library(shiny)
library(MASS)
library(caret)

data("Melanoma")

Melanoma$status <- as.factor(Melanoma$status)
levels(Melanoma$status) <- c("Died_Melanoma", "Alive", "Died_Other_Causes")

Melanoma$sex <- as.factor(Melanoma$sex)
levels(Melanoma$sex) <- c("Female","Male")

Melanoma$year <- as.factor(Melanoma$year)

Melanoma$ulcer <- as.factor(Melanoma$ulcer)
levels(Melanoma$ulcer) <- c("Absence", "Presence")

shinyServer(function(input, output) {
    ##  Fit a linear model to the Melanoma survival dataset from the MASS package

    ##  Create Dummy Variables and remove colinearity
    dummies <- dummyVars(~ ., data = Melanoma, fullRank = TRUE)
    MelanTrans <- data.frame(predict(dummies, newdata = Melanoma))
    MelanTrans$time <- Melanoma$time
    MelanTrans$age <- Melanoma$age
    MelanTrans$thickness <- Melanoma$thickness

    ##  Remove Near Zero Variance Columns
    nzv_cols <- nearZeroVar(MelanTrans)
    if(length(nzv_cols) > 0) MelanTrans <- MelanTrans[, -nzv_cols]
    
    ##  Split the data into Training and Test sets
    inTrain <- createDataPartition(y = MelanTrans$time, p = 0.7, list = FALSE)
    training <- MelanTrans[inTrain,] 
    testing <- MelanTrans[-inTrain,]

    ##  Train linear model
    set.seed(123)
    melanModFit<- train(time ~ ., data = training, method = "lm", 
                        trControl = trainControl(method = "cv", number = 10), 
                        preProcess = c("center", "scale"))
    summary(melanModFit)
        
    model1pred <- reactive({

##  The following values need to be set to input into the predict function
        # status.Alive
        # status.Died_Other_Causes
        # sex.Male
        # age
        # year.1965
        # year.1967
        # year.1968
        # year.1969
        # year.1970
        # year.1971
        # year.1972
        # year.1973
        # thickness
        # ulcer.Presence

        ##  Get status from Radio Button
        
        statusSelect <- switch(input$status,
                       Alive = matrix(c(1,0), 1, 2),
                       Other = matrix(c(0,1), 1, 2),
                       Melanoma = matrix(c(0,0), 1, 2))
        
        genderSelect <- switch(input$gender,
                               Female = 0,
                               Male = 1)
        
        ageInput <- input$sliderAge
        
        yearSelect <- switch(input$year,
                        six_five = matrix(c(1, 0, 0, 0, 0, 0, 0, 0, 0), 1, 9),
                        six_six = matrix(c(0, 1, 0, 0, 0, 0, 0, 0, 0), 1, 9),
                        six_seven = matrix(c(0, 0, 1, 0, 0, 0, 0, 0, 0), 1, 9),
                        six_eight = matrix(c(0, 0, 0, 1, 0, 0, 0, 0, 0), 1, 9),
                        six_nine = matrix(c(0, 0, 0, 0, 1, 0, 0, 0, 0), 1, 9),
                        seven_zero = matrix(c(0, 0, 0, 0, 0, 1, 0, 0, 0), 1, 9),
                        seven_one = matrix(c(0, 0, 0, 0, 0, 0, 1, 0, 0), 1, 9),
                        seven_two = matrix(c(0, 0, 0, 0, 0, 0, 0, 1, 0), 1, 9),
                        seven_three = matrix(c(0, 0, 0, 0, 0, 0, 0, 0, 1), 1, 9))
        
        thickInput <- input$sliderTumorThick
        
        ulcerSelect <- switch(input$ulcer,
                              Presence = 1,
                              Absence = 0)
        
        newDataCombine <- cbind(statusSelect, genderSelect, ageInput, yearSelect, 
                                thickInput, ulcerSelect)
        newDataDF <- data.frame(newDataCombine)
        colnames(newDataDF) <- c("status.Alive", "status.Died_Other_Causes", 
                                 "sex.Male", "age", "year.1965", "year.1966",
                                 "year.1967", "year.1968", "year.1969", "year.1970",
                                 "year.1971", "year.1972", "year.1973", "thickness", "ulcer.Presence")
        round(predict(melanModFit, newdata = newDataDF), digits = 0)
    })

    ##  Display the prediction from Model 1 as numeric text
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$modelSummary <- renderPrint({
        summary(melanModFit)
    })
    
})