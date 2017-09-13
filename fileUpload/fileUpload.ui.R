upload.box <- fluidPage(
  tags$head(tags$style(HTML("div.box-header {text-align: center;}"))),
  box(width=7,height=40,title="Select .CSV file to upload - this will act as your static dataframe for each subsequent analysis.",
              background="green"),
          mainPanel(width=12,
            dataTableOutput("inputfile")
          )
         )