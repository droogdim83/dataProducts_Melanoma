#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

##  This app predicts the survival time for patients with malignant melanoma 
##      based on data from 205 patients in Denmark 


shinyUI(fluidPage(
    titlePanel("Predict Survival Time for Melanoma Patients"),
    sidebarLayout(
        sidebarPanel(
            
            ##  Create a Radio Input for Status (Alive, Dead from Melanoma, 
            ##      Dead from Other Causes)
            radioButtons("status", "Expected Health Outcome:", 
                         c("Alive" = "Alive",
                           "Dead - Other Causes" = "Other",
                           "Dead - Melanoma" = "Melanoma")),
            
            ##  Create a Radio Input for Gender (Male, Female)
            radioButtons("gender", "Gender:", 
                         c("Male" = "Male",
                           "Female" = "Female")),
            
            ##  Create a Slider for age (4-95)
            sliderInput("sliderAge", "What is the patients age?", 4, 95, value = 50),
            
            ##  Create a Slider for year of Surgery (1965 - 1973)
            ##sliderInput("sliderYearSurg", "Year of tumor surgery:", 1965, 1973, value = 1969),
            radioButtons("year", "Year of tumor surgery:", 
                         c("1965" = "six_five",
                           "1966" = "six_six",
                           "1967" = "six_seven",
                           "1968" = "six_eight",
                           "1969" = "six_nine",
                           "1970" = "seven_zero",
                           "1971" = "seven_one",
                           "1972" = "seven_two",
                           "1973" = "seven_three")),
            
            ##  Create a Slider for tumor thickness
            sliderInput("sliderTumorThick", "What is the thickness of the tumor?", 0.1, 17.5, value = 3.0),
            
            ##  Create a Radio Input for presence of ulcer
            radioButtons("ulcer", "Ulcer Presence:", 
                         c("Presence" = "Presence",
                           "Absence" = "Absence")),
            
            ##  Add a Submit button so that the calculations aren't rerun until 
            ##      the user first clicks the button
            submitButton("Submit") # New!
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Documentation", 
                         h2("This app allows you to predict survival time 
                            (in days) for patients diagnosed with malignant 
                            melanoma"),
                         h4("Note - The model is based on a sample of 205 patients 
                            in Denmark from 1962 - 1977. Be very cautious in 
                            applying the model's predictions to other time periods 
                            and populations."), 
                         tags$ol(tags$li("Choose the patient's anticipated health outcome after 15 years"), 
                                 tags$li("Select the patient's gender"), 
                                 tags$li("Select the patient's age at diagnosis"),
                                 tags$li("Choose the calendar year when the patient had surgery to remove the tumor"), 
                                 tags$li("Select the tumor thickness (in mm)"), 
                                 tags$li("Is the melanoma ulcerated?"))),
                tabPanel("Prediction", 
                         h2("Predicted number of survival days for patient"),
                         textOutput("pred1")),
                tabPanel("Regression Model",
                         h2("Regression Model Summary"),
                         verbatimTextOutput("modelSummary"))
            )
        )
)))