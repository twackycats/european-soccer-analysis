library(plotly)

CreateScatter <- function(df, input) {
  return(
    renderPlotly({
      plot_ly(df, x = input$X_Value, y = input$Y_Value, 
              marker = list(size = 10, 
                            color = 'rgba(255, 182, 193, .9)',
                            line = list(color = 'rgba(152, 0, 0, .8)', 
                                        width = 2)))
    }
      
    )
  )
}