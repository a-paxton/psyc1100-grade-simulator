library(shiny)
library(tidyverse)

# start the server
shinyServer(function(input, output){
  values<-reactiveValues()
  
  observe({
    
    input$action_total
    
    ###### 1. Exams ######
    
    ####### 1a. Exam 1 #######
    
    # get Exam 1 attempts
    values$exam_1_percent_first = isolate({
      if (input$exam_1_first_attempt == FALSE){
        input$exam_1_score_first
      } else { NA }
    })
    values$exam_1_percent_second = isolate({
      if (input$exam_1_second_attempt == FALSE){
        input$exam_1_score_second
      } else { NA }
    })
    values$exam_1_average = isolate({
      mean(c(values$exam_1_percent_first, 
             values$exam_1_percent_second),
           na.rm = TRUE)
    })
    
    # report out what the Exam 1 average is
    values$exam_1_average = ifelse(is.na(values$exam_1_percent_first) & 
                                     is.na(values$exam_1_percent_second),
                                   0,
                                   values$exam_1_average)
    output$exam_1_average = renderText(paste0(values$exam_1_average,
                                              "%"))
    
    ####### 1b. Exam 2 #######
    
    # get Exam 2 attempts
    values$exam_2_percent_first = isolate({
      if (input$exam_2_first_attempt == FALSE){
        input$exam_2_score_first
      } else { NA }
    })
    values$exam_2_percent_second = isolate({
      if (input$exam_2_second_attempt == FALSE){
        input$exam_2_score_second
      } else { NA }
    })
    
    values$exam_2_average = isolate({
      mean(c(values$exam_2_percent_first, 
             values$exam_2_percent_second),
           na.rm = TRUE)
    })
    
    # report out what the Exam 2 average is
    values$exam_2_average = ifelse(is.na(values$exam_2_percent_first) & 
                                     is.na(values$exam_2_percent_second),
                                   0,
                                   values$exam_2_average)
    output$exam_2_average = renderText(paste0(values$exam_2_average,
                                              "%"))
    ####### 1c. Exam 3 #######
    
    # get Exam 3 attempts
    values$exam_3_percent_first = isolate({
      if (input$exam_3_first_attempt == FALSE){
        input$exam_3_score_first
      } else { NA }
    })
    values$exam_3_percent_second = isolate({
      if (input$exam_3_second_attempt == FALSE){
        input$exam_3_score_second
      } else { NA }
    })
    values$exam_3_average = isolate({
      mean(c(values$exam_3_percent_first, 
             values$exam_3_percent_second),
           na.rm = TRUE)
    })
    
    # report out what the Exam 3 average is
    values$exam_3_average = ifelse(is.na(values$exam_3_percent_first) & 
                                     is.na(values$exam_3_percent_second),
                                   0,
                                   values$exam_3_average)
    output$exam_3_average = renderText(paste0(values$exam_3_average,
                                              "%"))
    
    ####### 1e. Averages #######
    
    # get full average of all exam attempts
    values$exam_scores = isolate({
      round(mean(c(values$exam_1_average,
                   values$exam_2_average,
                   values$exam_3_average),
                 na.rm = TRUE))
    })
    
    # report out what the average is
    output$simulated_exam_average = renderText({ paste0( values$exam_scores , "%") })
    
    ###### 2. Preps ######
    
    values$average_preps = isolate({
      round(mean(sort(c(input$s_prep_01,
                        input$s_prep_02,
                        input$s_prep_03,
                        input$s_prep_04,
                        input$s_prep_05,
                        input$s_prep_06,
                        input$s_prep_07,
                        input$s_prep_08,
                        input$s_prep_09,
                        input$s_prep_10,
                        input$s_prep_11,
                        input$s_prep_12,
                        input$s_prep_13,
                        input$s_prep_14,
                        input$s_prep_15,
                        input$s_prep_16,
                        input$s_prep_17,
                        input$s_prep_18,
                        input$s_prep_19,
                        input$s_prep_20,
                        input$s_prep_21,
                        input$s_prep_22,
                        input$s_prep_23),
                      decreasing = TRUE)[1:top_n_preps],
                 na.rm=TRUE
      ), 2)
    })
    
    # report out to the student
    output$average_preps = renderText({ paste0( (values$average_preps), "%" ) })
    
    ###### 3. Actives ######
    
    # average Active scores
    values$average_actives = isolate({
      round(mean(sort(c(input$s_active_01,
                        input$s_active_02,
                        input$s_active_03,
                        input$s_active_04,
                        input$s_active_05,
                        input$s_active_06,
                        input$s_active_07,
                        input$s_active_08,
                        input$s_active_09,
                        input$s_active_10,
                        input$s_active_11,
                        input$s_active_12,
                        input$s_active_13,
                        input$s_active_14,
                        input$s_active_15,
                        input$s_active_16,
                        input$s_active_17,
                        input$s_active_18,
                        input$s_active_19,
                        input$s_active_20,
                        input$s_active_21,
                        input$s_active_22,
                        input$s_active_23,
                        input$s_makeup_active_01,
                        input$s_makeup_active_02)[5:25]),
                 na.rm=TRUE
      ), 2)
    })
    
    # report out to the student
    output$average_actives = renderText({ paste0( (values$average_actives)/16, "%" ) })
    
    # figure out what the letter grade should be for that value
    values$cts_grade = isolate({
      grade_bundles$letter_grade[which(values$cts_satisfactory >= grade_bundles$cts_satisfactory)[1]]
    })
    
    # report out to the student
    output$total_ctses = renderText({ paste0( values$cts_satisfactory ) })
    output$cts_letter = renderText({ paste0( values$cts_grade ) })
    
    ###### 5. ELCs ######
    
    # grab how many ELCs they earned (total)
    values$elcs = isolate({
      sum(c(input$elc_participant_pool_credits,
            input$elc_alt_assignment_credits))
    })
    
    # figure out what the letter grade should be for that value
    values$elc_grade = isolate({
      grade_bundles$letter_grade[which(values$elcs >= grade_bundles$elcs)[1]]
    })
    
    # report out to the student
    output$total_elcs = renderText({ paste0( values$elcs ) })
    output$elc_letter = renderText({ paste0( values$elc_grade ) })
    
    ###### 6. Lab ######
    
    # calculate lab percentage
    values$lab_score = isolate({
      min(input$lab_score, 110)
    })
    
    # figure out what the letter grade should be for that value
    values$lab_grade = isolate({
      grade_bundles$letter_grade[which(values$lab_score >= grade_bundles$lab)[1]]
    })
    
    # report out to the student
    output$lab_letter = renderText({ paste0( values$lab_grade ) })
    output$lab_score = renderText({ paste0( values$lab_score ) })
    
  })
})