# Move to app1 location (the app to use renv.)
cd /srv/shiny-server/app1
# Initialize a renv and install a specific version of ggplot2
Rscript -e "renv::init()"
Rscript -e "renv::install('ggplot2@3.4.4')"
# Update the renv lockfile.
Rscript -e "renv::snapshot()"
# Isolate the renv from the cache.
Rscript -e "renv::isolate()"
