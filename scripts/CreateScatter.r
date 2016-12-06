library(dplyr)
library(plotly)
CreateScatter <- function(df, input) {
    return(
    renderPlotly({
      xval <- df[, input$X_Value]
      yval <- df[, input$Y_Value]
      plot_ly(data = df, x = xval, y = yval, type = 'scatter')
    }
    )
  )
}