library(shiny)


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
    
    # calculate and transform the lab score
    values$lab_score = isolate({
      min(input$lab_score, 110) * .7
    })
    
    #### Knowledge Checks ####
    
    # grab how many KC points they earned (total)
    values$raw_kc = isolate({
      sum(c(input$kc_1/20,
            input$kc_2/20,
            input$kc_3/20,
            input$kc_4/20,
            input$kc_5/20))
    })
    
    # calculate how much extra credit they got from KCs (up to 4)
    values$extra_credit_kc = isolate({
      ifelse(values$raw_kc >= 4,
             4,
             values$raw_kc)
    })
    
    #### ELCs ####
    
    # grab how many ELCs they earned (total)
    values$total_elcs = isolate({
      sum(c(input$elc_participant_pool_credits,
            input$elc_writing_credits,
            input$elc_question_credits))
    })
    
    # calculate the proportion of the required ELCs earned
    values$required_elcs = isolate({
      ifelse(values$total_elcs >= 5,
             20,
             values$total_elcs/5)
    })
    
    # calculate extra credit from ELCs 
    # (anything over the required 5 ELCs; up to 4 extra-credit ELCs)
    values$extra_credit_elcs = isolate({
      ifelse(values$total_elcs > 5,
             ifelse((values$total_elcs - 5) > 4,
                    4,
                    values$total_elcs - 5),
             0)
    })
    
    #### Totalling ####
    
    # calculate their total score for the class so far
    values$total_score_unrounded <- isolate({
      sum(c(values$exam_scores,
            values$quiz_score,
            values$lab_score,
            values$required_elcs,
            values$extra_credit_kc,
            values$extra_credit_elcs))
    })
    
    # round up if .5 or higher, down if not
    values$total_score_decimals <- isolate({ 
      values$total_score_unrounded - floor(values$total_score_unrounded)
    })
    values$total_score <- isolate({ 
      ifelse(values$total_score_decimals >= .5,
             floor(values$total_score_unrounded) + 1,
             floor(values$total_score_unrounded))
    })
    
    # calculate the scores before Optional Final
    values$up_to_final_unrounded <- isolate({
      sum(c(values$exam_1_score,
            values$exam_2_score,
            values$exam_3_score,
            values$quiz_score,
            values$lab_score,
            values$required_elcs,
            values$extra_credit_kc,
            values$extra_credit_elcs))
    })
    
    # round up if .5 or higher, down if not
    values$up_to_final_decimals <- isolate({ 
      values$up_to_final_unrounded - floor(values$up_to_final_unrounded)
    })
    values$up_to_final <- isolate({ 
      ifelse(values$up_to_final_decimals >= .5,
             floor(values$up_to_final_unrounded) + 1,
             floor(values$up_to_final_unrounded))
    })
    
  })
  
  # output the number of points earned
  output$text_grade<-renderText({
    if(input$action_total==0) ""
    else
      paste0(values$total_score, " points")
  })
  
  # # output the percentage earned
  # #values$total_percent = reactiveVal()
  # output$text_percent<-renderText({
  #   if(input$action_total==0) ""
  #   else
  #     paste0(values$total_score/400 * 100, "%")
  # })
  
  # create letter grade text
  output$text_comment<-renderText({
    if(input$action_total==0) ""
    else({
      if(values$total_score>=372)
        paste("A")
      else if(values$total_score>=360)
        paste("A-")
      else if(values$total_score>=348)
        paste("B+")
      else if(values$total_score>=332)
        paste("B")
      else if(values$total_score>=320)
        paste("B-")
      else if(values$total_score>=308)
        paste("C+")
      else if(values$total_score>=292)
        paste("C")
      else if(values$total_score>=280)
        paste("C-")
      else if(values$total_score>=268)
        paste("D+")
      else if(values$total_score>=252)
        paste("D")
      else if(values$total_score>=220)
        paste("D-")
      else
        paste("F")
    })
  })
  
  # create text with grade needed pass
  output$text_passing_grade<-renderText({
    if(input$action_total==0) ""
    else if (values$up_to_final >= 220)
      paste("Simulated grade already at or above a D- (without taking the Optional Final)")
    else
      paste(220 - (values$up_to_final + min(values$exam_1_score,
                                            values$exam_2_score,
                                            values$exam_3_score)))
  })
  
  # create text with grade needed to make a C
  output$text_cgrade<-renderText({
    if(input$action_total==0) ""
    else if (values$up_to_final >= 292)
      paste("Simulated grade already at or above a C (without taking the Optional Final)")
    else
      paste(292 - (values$up_to_final + min(values$exam_1_score,
                                            values$exam_2_score,
                                            values$exam_3_score)))
  })
  
  # set up our Preps
  prep_checkboxes = list()
  for (i in 1:21){
    prep_label = paste0("Prep ", i)
    prep_checkboxes[[i]] <- checkboxInput(prep_label, prep_label)
  }
  output$satisfactory_prep <- renderUI(prep_checkboxes)
  
  # set up our Actives
  kc_checkboxes = list()
  lr_checkboxes = list()
  active_checkboxes = list()

  for (i in 2:21){
    kc_label = paste0("KC ", i)
    kc_checkboxes[[i]] <- checkboxInput(kc_label, kc_label)
    
    lr_label = paste0("L&R ", i)
    lr_checkboxes[[i]] <- checkboxInput(lr_label, lr_label)
    
    active_label = paste0("Active ", i)
    active_checkboxes[[i]] <- checkboxInput(active_label, active_label)

  }
  output$satisfactory_kc <- renderUI(kc_checkboxes)
  output$satisfactory_lr <- renderUI(lr_checkboxes)
  output$satisfactory_active <- renderUI(active_checkboxes)
  
  # set up our CTSes
  cts_checkboxes = list()
  for (i in 1:4){
    cts_label = paste0("CTS ", i)
    cts_checkboxes[[i]] <- checkboxInput(cts_label, cts_label)
  }
  output$satisfactory_cts <- renderUI(cts_checkboxes)
  
  
})
# })