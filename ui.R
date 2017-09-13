source("header.R")
source("sidebar2.R")
source("body.R")

ui <- dashboardPage(
  skin = "blue",
  header, sidebar, body
)