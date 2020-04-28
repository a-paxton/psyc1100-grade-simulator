library(shiny)

# start the server
shinyServer(function(input, output){
  values<-reactiveValues()
  
  observe({
    
    input$action_total
    
    #### Exams ####
    
    # get Exam 1 Score
    values$exam_1_score = isolate({
      min(input$exam_1_score, 115)
    })
    
    # get Exam 2 Score
    values$exam_2_score = isolate({
      min(input$exam_2_score, 115)
    })
    
    # get Exam 3 Score
    values$exam_3_score = isolate({
      min(input$exam_3_score, 115)
    })
    
    # get Optional Final Score
    values$sim_final_score = isolate({
      min(input$final_exam_score, 115)
    })
    
    # take only the top 3 exam scores
    values$exam_scores = isolate({
      sum(sort(c(values$exam_1_score,
                 values$exam_2_score,
                 values$exam_3_score,
                 values$sim_final_score))[2:4])
    })
    
    #### Quizzes ####
    
    # get the total quiz points earned
    values$quiz_total = isolate({
      sum(c((input$quiz_warm_up * 15),
            input$quiz_syllabus,
            (input$quiz_post_exam1 * 15),
            (input$quiz_post_exam2 * 15)))
    })
    
    # figure out which to drop
    values$quiz_drop = isolate({
      min((input$quiz_warm_up * 15), 
          input$quiz_syllabus, 
          (input$quiz_post_exam1 * 15), 
          (input$quiz_post_exam2 * 15))
    })
    
    # drop lowest
    values$quiz_score = isolate({
      ((values$quiz_total - values$quiz_drop) / 45) * 10
    })
    
    #### Lab ####
    
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
  
})
# })