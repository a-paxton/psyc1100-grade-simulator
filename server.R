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
        min(input$exam_1_score_first,exam_01_max) / exam_01_max
      } else { 0 }
    })
    values$exam_1_percent_second = isolate({
      if (input$exam_1_second_attempt == FALSE){
        min(input$exam_1_score_second,exam_01_max) / exam_01_max
      } else { NA }
    })
    values$exam_1_percent_third = isolate({
      if (input$exam_1_third_attempt == FALSE) {
        min(input$exam_1_score_third,exam_01_max) / exam_01_max
      } else { NA }
    })
    values$exam_1_average = isolate({
      mean(c(values$exam_1_percent_first, 
             values$exam_1_percent_second,
             values$exam_1_percent_third),
           na.rm = TRUE)
    })
    
    # report out what the Exam 1 average is
    output$exam_1_average = renderText(paste0(round(values$exam_1_average*100,1), "%"))
    
    # get Exam 1 S/U number
    values$exam_1_attempt = isolate({
      if (input$exam_1_score_first >= exam_01_satisfactory) {
        1
      } else if (input$exam_1_score_second >= exam_01_satisfactory) {
        2
      } else {
        0
      }
    })
    
    # figure out if they earned over 65 on any attempt
    values$exam_1_over65 = isolate({
      if (values$exam_1_percent_first >= 65 | 
          (input$exam_1_second_attempt == TRUE & values$exam_1_percent_second >= 65) | 
          (input$exam_1_third_attempt == TRUE & values$exam_1_percent_second >= 65)){
        1
      } else {
        0
      }
    })
    
    ####### 1b. Exam 2 #######
    
    # get Exam 2 attempts
    values$exam_2_percent_first = isolate({
      if (input$exam_2_first_attempt == FALSE){
        min(input$exam_2_score_first,exam_02_max) / exam_02_max
      } else { 0 }
    })
    values$exam_2_percent_second = isolate({
      if (input$exam_2_second_attempt == FALSE){
        min(input$exam_2_score_second,exam_02_max) / exam_02_max
      } else { NA }
    })
    values$exam_2_percent_third = isolate({
      if (input$exam_2_third_attempt == FALSE) {
        min(input$exam_2_score_third,exam_02_max) / exam_02_max
      } else { NA }
    })
    values$exam_2_average = isolate({
      mean(c(values$exam_2_percent_first, 
             values$exam_2_percent_second,
             values$exam_2_percent_third),
           na.rm = TRUE)
    })
    
    # report out what the Exam 2 average is
    output$exam_2_average = renderText(paste0(round(values$exam_2_average*100,1), "%"))
    
    # get Exam 2 S/U number
    values$exam_2_attempt = isolate({
      if (input$exam_2_score_first >= exam_02_satisfactory) {
        1
      } else if (input$exam_2_score_second >= exam_02_satisfactory) {
        2
      } else {
        0
      }
    })
    
    # figure out if they earned over 65 on any attempt
    values$exam_2_over65 = isolate({
      if (values$exam_2_percent_first >= 65 | 
          (input$exam_2_second_attempt == TRUE & values$exam_2_percent_second >= 65) | 
          (input$exam_2_third_attempt == TRUE & values$exam_2_percent_second >= 65)){
        1
      } else {
        0
      }
    })
    
    ####### 1c. Exam 3 #######
    
    # get Exam 3 attempts
    values$exam_3_percent_first = isolate({
      if (input$exam_3_first_attempt == FALSE){
        min(input$exam_3_score_first,exam_03_max) / exam_03_max
      } else { 0 }
    })
    values$exam_3_percent_second = isolate({
      if (input$exam_3_second_attempt == FALSE){
        min(input$exam_3_score_second,exam_03_max) / exam_03_max
      } else { NA }
    })
    values$exam_3_percent_third = isolate({
      if (input$exam_3_third_attempt == FALSE) {
        min(input$exam_3_score_third,exam_03_max) / exam_03_max
      } else { NA }
    })
    values$exam_3_average = isolate({
      mean(c(values$exam_3_percent_first, 
             values$exam_3_percent_second,
             values$exam_3_percent_third),
           na.rm = TRUE)
    })
    
    # report out what the Exam 3 average is
    output$exam_3_average = renderText(paste0(round(values$exam_3_average*100,1), "%"))
    
    # get Exam 3 S/U number
    values$exam_3_attempt = isolate({
      if (input$exam_3_score_first >= exam_03_satisfactory) {
        1
      } else if (input$exam_3_score_second >= exam_03_satisfactory) {
        2
      } else {
        0
      }
    })
    
    # figure out if they earned over 65 on any attempt
    values$exam_3_over65 = isolate({
      if (values$exam_3_percent_first >= 65 | 
          (input$exam_3_second_attempt == TRUE & values$exam_3_percent_second >= 65) | 
          (input$exam_3_third_attempt == TRUE & values$exam_3_percent_second >= 65)){
        1
      } else {
        0
      }
    })
    
    ####### 1d. Cumulative Final #######
    
    # get Cumulative Final attempts
    values$sim_final_percent_first = isolate({
      if (input$final_exam_taking == FALSE) {
        min(input$final_exam_percent_first,cumulative_final_max) / cumulative_final_max
      } else { 0 }
    })
    values$sim_final_percent_second = isolate({
      if (input$final_exam_second_attempt == FALSE) {
        min(input$final_exam_percent_second,cumulative_final_max) / cumulative_final_max
      } else { NA }
    })
    values$sim_final_average = isolate({
      mean(c(values$sim_final_percent_first, 
             values$sim_final_percent_second),
           na.rm = TRUE)
    })
    
    # report out what the Cumulative Final average is
    output$sim_final_average = renderText(paste0(round(values$sim_final_average*100,1), "%"))
    
    # get Cumulative Final S/U number
    values$cumulative_final_attempt = isolate({
      if (length(input$sim_final_percent_first) > 1) {
        if (input$sim_final_percent_first >= cumulative_final_satisfactory) {
          1
        } else if (input$sim_final_percent_second >= cumulative_final_satisfactory) {
          2
        } else {
          0
        }
      } else {
        0
      }
    })
    
    # figure out if they earned over 65 on any attempt
    values$cumulative_final_over65 = isolate({
      if ((input$final_exam_taking == TRUE & values$sim_final_percent_first >= 65) | 
          (input$final_exam_second_attempt == TRUE & values$sim_final_percent_second >= 65)) {
        1
      } else {
        0
      }
    })
    
    ####### 1e. Averages #######
    
    # take only the top 3 exam scores
    values$exam_scores = isolate({
      round(mean(sort(c(values$exam_1_average,
                        values$exam_2_average,
                        values$exam_3_average,
                        values$sim_final_average)[2:4]),
                 na.rm = TRUE), 
            0)
    })
    
    # report out what the average of 3 best is
    output$simulated_exam_average = renderText({ paste0( values$exam_scores ) })
    
    ####### 1e. Overall performance #######
    
    # figure out satisfactory first vs. second 
    values$exams_satisfactory_first = isolate({
      (values$exam_1_attempt==1)*1 + (values$exam_2_attempt==1)*1 + 
        (values$exam_3_attempt==1)*1 + (values$cumulative_final_attempt==1)*1
    })
    
    # figure out satisfactory first vs. second 
    values$exams_satisfactory_first = isolate({
      (values$exam_1_attempt==1)*1 + (values$exam_2_attempt==1)*1 + 
        (values$exam_3_attempt==1)*1 + (values$cumulative_final_attempt==1)*1
    })
    values$exams_satisfactory_second = isolate({
      (values$exam_1_attempt==2)*1 + (values$exam_2_attempt==2)*1 + 
        (values$exam_3_attempt==2)*1 + (values$cumulative_final_attempt==2)*1
    })
    
    # report out the total Satisfactories on first and second attempts
    output$exams_satisfactory_first = renderText({ paste0(values$exams_satisfactory_first) })
    output$exams_satisfactory_second = renderText({paste0(values$exams_satisfactory_second)})
    
    # count the number of exams over 65
    values$final_exams_over_65 = isolate({
      values$exam_1_over65 + values$exam_2_over65 + values$exam_3_over65 + values$cumulative_final_over65
    })
    
    # figure out what the letter grade should be for the exam performance
    values$exam_grade = isolate({
      if ((values$final_exams_over_65 < 3) & (values$exam_scores < grade_bundles$exam_average[4])) { 
        "F"
      } else if (values$exams_satisfactory_first >= 3) {
        "A"
      } else if (values$exams_satisfactory_first >= 2 & values$exams_satisfactory_second >= 1) {
        "B"
      } else if ((values$exams_satisfactory_first >= 1 & values$exams_satisfactory_second >= 2) |
                 values$exam_scores >= grade_bundles$exam_average[3]) {
        "C"
      } else if ((values$final_exams_over_65 >= 3) |
                 values$exam_scores >= grade_bundles$exam_average[4]) {
        "D"
      } else {
        "Error -- check exam inputs"
      }
    })
    
    # report out to the student
    output$exam_letter = renderText({ paste0( values$exam_grade ) })
    
    ###### 2. Preps ######
    
    values$satisfactory_preps = isolate({
      sum(c(input$s_prep_01,
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
            input$s_prep_21),
          na.rm=TRUE
      )
    })
    
    # figure out what the letter grade should be for that value
    values$prep_grade = isolate({
      grade_bundles$letter_grade[which(values$satisfactory_preps >= grade_bundles$prep_satisfactory)[1]]
    })
    
    # report out to the student
    output$total_preps = renderText({ paste0( values$satisfactory_preps ) })
    output$prep_letter = renderText({ paste0( values$prep_grade ) })
    
    ###### 3. Actives ######
    
    # tally satisfactory actives
    values$satisfactory_actives = isolate({
      sum(c(input$s_active_02,
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
            input$s_active_21),
          na.rm=TRUE
      )
    })
    
    # figure out what the letter grade should be for that value
    values$active_grade = isolate({
      grade_bundles$letter_grade[which(values$satisfactory_actives >= grade_bundles$active_satisfactory)[1]]
    })
    
    # report out to the student
    output$total_actives = renderText({ paste0( values$satisfactory_actives ) })
    output$active_letter = renderText({ paste0( values$active_grade ) })
    
    ###### 4. CTSes ######
    
    # extract how many CTSes they earned
    values$cts_satisfactory = isolate({
      sum(c(input$s_cts_01,
            input$s_cts_02,
            input$s_cts_03,
            input$s_cts_04),
          na.rm=TRUE
      )
    })
    
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