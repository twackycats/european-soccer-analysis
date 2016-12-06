library(plotly)
library(dplyr)

CreateScatter <- function(df, input) {
  xval = reactive(as.vector(as.matrix(select(df, ~input$X_Value))))
  yval = reactive(as.vector(as.matrix(select(df, ~input$Y_Value))))
  return(
    renderPlotly({
      plot_ly(df, x = xval, y = yval)
    }
    )
  )
}