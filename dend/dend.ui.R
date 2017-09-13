dend.box <- fluidPage(
  box(width=12,
            plotOutput("dend")),#,height = 600, width = 1300),
      fluidRow(
        box(width=4, title = "Dendrogram Label Size",
            status = "success", solidHeader = TRUE,
               sliderInput(
                 "labelsize", NULL, 
                 min = 0, max = 4, value = 1, step= 0.25)
        ),
        box(width=4,title = "Dendrogram Leaf Node Size", 
            status = "success", solidHeader = TRUE,
               sliderInput(
                 "leafsize", NULL, 
                 min = 0, max = 4, value = 2, step= 0.25)
        ),
        box(width=4,title = "Dendrogram Branches Width",
            status = "success", solidHeader = TRUE,
               sliderInput(
                 "brancheswidth", NULL, 
                 min = 0, max = 5, value = 2, step= 0.25)
        )
      )
      
      # div(style="display: inline-block;vertical-align:top;height: 60px;",sliderInput(
      #   "labelsize", "Dendrogram Label Size", 
      #   min = 0, max = 4, value = 1, step= 0.25)
      # ),
      # div(style="display: inline-block;vertical-align:top;height: 60px;",sliderInput(
      #   "leafsize", "Dendrogram Leaf Node Size", 
      #   min = 0, max = 4, value = 2, step= 0.25)
      # ),
      # div(style="display: inline-block;vertical-align:top;height: 60px;",sliderInput(
      #   "brancheswidth", "Dendrogram Branches Width", 
      #   min = 0, max = 5, value = 2, step= 0.25)
      # )
            # verbatimTextOutput("lv"),
            #Save function
            # "At the moment, it is not possible to apply k-means cluster colors to centroid or median dendrograms",
            # selectInput("format", "File type", choices=c(".png",".tiff",".jpeg",".pdf",".eps"), selected = "png", multiple = FALSE, selectize = TRUE),
            # downloadButton(outputId="downdend", label = "Save Plot"),
            # selectInput("legpos", "Legend Position", choices=c("Top Right","Top Left","Bottom Right","Bottom Left"), selected = "Top Right", multiple = FALSE, selectize = TRUE)
          )
        