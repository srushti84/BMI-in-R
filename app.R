# Load necessary libraries
library(shiny)

# Define the UI
ui <- fluidPage(
  
  # App title
  titlePanel("BMI Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      # Input fields for weight and height
      numericInput("weight", "Weight (kg)", value = 70, min = 1),
      numericInput("height", "Height (cm)", value = 170, min = 1),
      
      # Calculate button
      actionButton("calculate", "Calculate BMI")
    ),
    
    # Display BMI result and category
    mainPanel(
      textOutput("bmi_result"),
      textOutput("bmi_category")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  
  # Observe the Calculate button event
  observeEvent(input$calculate, {
    
    # Calculate BMI
    height_m <- input$height / 100  # Convert height from cm to meters
    bmi <- input$weight / (height_m^2)
    
    # Determine BMI category
    category <- ifelse(bmi < 18.5, "Underweight",
                       ifelse(bmi < 24.9, "Normal weight",
                              ifelse(bmi < 29.9, "Overweight", "Obese")))
    
    # Display BMI result
    output$bmi_result <- renderText({
      paste("Your BMI is:", round(bmi, 2))
    })
    
    # Display BMI category
    output$bmi_category <- renderText({
      paste("You are:", category)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
