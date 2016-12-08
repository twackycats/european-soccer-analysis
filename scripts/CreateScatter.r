library(dplyr)
library(ggplot2)
CreateScatter <- function(df, input) {
    return(
    renderPlot({
      x_value <- df[, input$X_Value]
      y_value <- df[, input$Y_Value]
      ggplot(df,aes(x=x_value,y=y_value)) + geom_point(alpha = 0.1)    }
    )
  )
}