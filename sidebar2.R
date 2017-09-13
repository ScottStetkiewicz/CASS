sidebar <- dashboardSidebar(
  sidebarMenu(id="sidebarmenu",
    menuItem("Homepage", 
             tabName = "start", 
             icon = icon("dashboard")
    ),
    menuItem("File Upload", 
             tabName = "upload", 
             icon = icon("upload")
    ),
    conditionalPanel("input.sidebarmenu === 'upload'",
                     div(style="height: 85px;",fileInput('file1', 'Choose CSV File',accept=c('text/csv','text/comma-separated-values,text/plain','.csv'))),
                     div(style="height: 35px;",checkboxInput('header', 'Header', TRUE)),
                     div(style="height: 110px;",radioButtons('sep', 'Separator:',c(Comma=',',Semicolon=';',Tab='\t'),','))
      
    ),
    menuItem("Modified Dataframe", 
             tabName = "selDat", 
             icon = icon("table")
             
    ),
    conditionalPanel("input.sidebarmenu === 'selDat'",
                     div(style="height: 35px;width:115;",checkboxInput(inputId = "rem2",
                                   label = "Exclude Columns",
                                   value = TRUE)),
                     uiOutput("condPanel2"),
                     div(style="height: 35px;width:115",checkboxInput(inputId = "rem",
                                   label = "Exclude Rows",
                                   value = TRUE)),
                     uiOutput("condPanel1"),
                     HTML("<br>")
    ),
    menuItem("Heirarchical Cluster Analysis", 
             tabName = "dend", 
             icon = icon("sitemap")
    ),
    conditionalPanel("input.sidebarmenu === 'dend'",
                     div(style="height: 55px;",selectInput(
                       "dendlabels", 
                       label = h5("Dendrogram Label Variable"),
                       ""
                     )),
                     HTML("<br>"),
                     div(style="height: 55px;",selectInput(
                       "dendcolor", 
                       label = h5("Dendrogram Coloring Variable"),
                       ""
                     )),
                     HTML("<br>"),
                     div(style="height: 65px;",selectInput(
                       "dendshape", 
                       label = h5("Dendrogram Leaf Shape"),
                       ""
                     )),
                     HTML("<br>"),
                     div(style="height: 55px;",selectInput(
                       'distMethod', 'Distance Method',
                                 c("euclidean", "maximum", "manhattan", "canberra",
                                   "binary", "minkowski"), 
                       selected="euclidean")
                       ),
                     HTML("<br>"),
                     div(style="height: 55px;",selectInput(
                       'clustMethod', 'Agglomeration Method',
                                 c("complete", "ward", "single", "average",
                                   "mcquitty", "median", "centroid"), 
                       selected="centroid")
                       ),
                     HTML("<br>"),
                     div(style="display: inline-block;vertical-align:top;height: 45px;width:107px;",checkboxInput(
                       "kbox", tagList(tags$em("k"),"- Means"), FALSE)
                     ),
                     div(style="display: inline-block;vertical-align:top;height: 45px;width:107px;",checkboxInput(
                       "horiz", "Horizontal", FALSE)
                     ),
                     div(style="height: 55px;",numericInput(
                       "kcount", "Number of Clusters (K)", 0)
                       ),
                     HTML("<br>")
    ),
    menuItem("Principal Component Analysis", 
             tabName = "pca", 
             icon = icon("arrows-alt")
    ),
    conditionalPanel("input.sidebarmenu === 'pca'",
                                   div(style="display: inline-block;vertical-align:top;width: 115px;height: 65px;",selectInput("axis1", "Axis 1","")),
                                   div(style="display: inline-block;vertical-align:top;width: 115px;height: 65px;",selectInput("axis2", "Axis 2","")),
                                   div(style="height: 65px;",selectInput("colVar", "Color","")),
                                   div(style="height: 65px;",selectInput("shapeVar", "Shape","")),
                                   div(style="height: 65px;",selectInput("labNames", "Select Label Names","")),
                                   div(style="height: 25px;",checkboxInput("ellipse", tagList(strong("Toggle Ellipses")))),
                                   div(style="height: 25px;",checkboxInput("do", tagList(strong(tags$em("k"),"- Means Cluster Analysis")))),
                                   HTML("<br>"),
                                   div(style="height: 55px;",sliderInput("clusters", strong("Clusters :"), 2,10,3,step = 1)),
                                   HTML("<br>"),
                                   div(style="height: 30px;",checkboxInput("fixed", tagList(strong("Fix Aspect Ratio at 1:1")))),
                                   HTML("<br>"),
                                   div(style="height: 55px;",actionButton("reset_input", "Clear Selected Points"),
                                   div(style="height: 55px;",tags$style(type='text/css', "button#reset_input { margin-left: 9px; }"))
                       )
    )
  )
)
