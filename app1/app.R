# app1/app.R

# A basic shiny app which prints the version of ggplot2 being used by the app.
# ============================================================================ #
# Imports.
library(shiny)
library(ggplot2)

# ============================================================================ #
# User interface specification.
ui <- fluidPage(
  verbatimTextOutput("gg_v")
)

# ============================================================================ #
# Server specification.
server <- function(input, output, session) {
  output$gg_v <- renderText({
    as.character(packageVersion("ggplot2"))
  })
}

# ============================================================================ #
# Run the app.
shinyApp(ui, server)

# ============================================================================ #
