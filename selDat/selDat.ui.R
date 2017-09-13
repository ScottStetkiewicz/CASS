selDat.box <- fluidPage(
  tags$head(tags$style(HTML("div.box-header {text-align: center;}"))),
  box(width=4,height=40,title="Remove all string vectors prior to HCA and PCA.",
              background="green"),
            mainPanel(width=12,
              dataTableOutput("selDat")
            )
           )