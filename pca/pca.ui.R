pca.box <- fluidRow(
              tabsetPanel(type = "tabs",
                     tabPanel(strong(h3("Plot Output")),
                             box(width=10,
                                 scatterD3Output("scatterPlot")
                             ),
                             box(title = "Selected Points :", width=2, solidHeader = TRUE, status = "primary",
                                 h4(tagAppendAttributes(textOutput("points_selected"), style="white-space:pre-wrap;"))
                             )
                    ),
                    tabPanel(strong(h3("Scree Plot and PC Variances")),
                             box(title = "Scree Plot",width=6, solidHeader = TRUE, status = "primary",
                                 plotOutput("scree")
                             ),
                             box(title = "PC Variances",width=6, solidHeader = TRUE, status = "primary",
                                 dataTableOutput("printout")
                             )
                    )
                    # tabPanel(strong(h3("dickshit")),
                    #   box(title = "dickshit",width=12, solidHeader = TRUE, status = "primary",
                    #     verbatimTextOutput("text")
                    #   )
                    # )
            )
          )
