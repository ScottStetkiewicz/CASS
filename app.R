if(interactive()) {
  source("global.R")
  source("ui.R")
  source("server.R") ## function(input, out)
  shinyApp(ui, server)
}