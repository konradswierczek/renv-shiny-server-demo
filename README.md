# How Am I Supposed To Use Renv With Shiny Server???

This is a simple demonstration of how to orchestrate multiple shiny apps, each using their own Renv. In this case, I'll just demonstrate how one of these apps uses one R lib, and another uses a different lib.

You'll need to have docker installed, and not much else (although running the run code will need to download the rocker/shiny-verse image).

Start by creating a docker container. Note that I'm not customizing an image: alot of the work we do here would typically happen in a dockerfile, but let's keep this simple and not add another custom image.
```
docker run -d \
    --name shiny-tests \
    -p 3838:3838 \
    -v ./:/srv/shiny-server \
    rocker/shiny-verse:4.5.0
```

For whatever reason, rocker/shiny-verse does not include Renv. Maybe that's a good sign we shouldn't be doing this. Who's to know. Either way, let's install it in our container.
```
docker exec \
    shiny-tests \
    Rscript -e "install.packages('renv')"
```

Next, let's set up the 
```
docker exec \
    shiny-tests \
    bash /srv/shiny-server/setup.sh
```

Finaly, you'll need to restart the container in order for shiny to be aware of the Renv.
```
docker restart shiny-tests
```

That's it! Both apps will simply print the version of ggplot2 the app is using. If you navigate to localhost:3838/app1, you should see "3.4.4": the version installed in the Renv. However, localhost:3838/app2 should say "3.5.2": the version installed in the container. Using this as a model you should be able to mix and match packages and versions for each shiny app hosted in a shiny-server.
