library(shiny)

# start the server
shinyServer(function(input, output){
  values<-reactiveValues()
  
  observe({
    
    input$action_total
    
    # take only the top 2 exam scores
    values$exam_scores = isolate({
      sum(sort(c(min(input$exam_1_score, 170),
                 min(input$exam_2_score, 170),
                 min(input$final_exam_score, 170)))[2:3])
    })
    
    # calculate and transform the lab score
    values$lab_score = isolate({
      min(input$lab_score, 110) * .8
    })
    
    # grab how many KC points they earned (total)
    values$raw_kc = isolate({
      input$kc_1/20 + input$kc_2/20 + input$kc_3/20 + input$kc_4/20 + input$kc_5/10 + input$kc_6/10 
    })
    
    # calculate how much extra credit they got from KCs (up to 4)
    values$extra_credit_kc = isolate({
      ifelse(values$raw_kc >= 4,
             4,
             values$raw_kc)
    })
    
    # grab how many ELCs they earned (total)
    values$total_elcs = isolate({
      input$elc_participant_pool_credits + input$elc_writing_credits
    })
    
    # calculate the proportion of the required ELCs earned
    values$required_elcs = isolate({
      ifelse(values$total_elcs >= 5,
             20,
             values$total_elcs/5)
    })
    
    # calculate extra credit from ELCs 
    # (anything over the required 5 ELCs; up to 6 extra-credit ELCs)
    values$extra_credit_elcs = isolate({
      ifelse(values$total_elcs > 5,
             ifelse(values$total_elcs - 5 > 6,
                    6,
                    values$total_elcs - 5),
             0)
    })
    
    # calculate their total score for the class so far
    values$total_score<-isolate({
      values$exam_scores + values$lab_score + values$required_elcs + values$extra_credit_kc + values$extra_credit_elcs
    })
    
    # calculate the scores for Exams 1 and 2 and everything else
    values$up_to_final<-isolate({
      sum(c(min(input$exam_1_score, 170),
            min(input$exam_2_score, 170),
            values$lab_score,
            values$required_elcs,
            values$extra_credit_kc,
            values$extra_credit_elcs))
    })
    
  })
  
  # output the number of points earned
  output$text_grade<-renderText({
    if(input$action_total==0) ""
    else
      paste0(values$total_score, " points")
  })
  
  # output the percentage earned
  #values$total_percent = reactiveVal()
  output$text_percent<-renderText({
    if(input$action_total==0) ""
    else
      paste0(values$total_score/400 * 100, "%")
  })
  
  # create letter grade text
  output$text_comment<-renderText({
    if(input$action_total==0) ""
    else({
      if((values$total_score/400 * 100)>=93)
        paste("A")
      else if((values$total_score/400 * 100)>=90)
        paste("A-")
      else if((values$total_score/400 * 100)>=87)
        paste("B+")
      else if((values$total_score/400 * 100)>=83)
        paste("B")
      else if((values$total_score/400 * 100)>=80)
        paste("B-")
      else if((values$total_score/400 * 100)>=77)
        paste("C+")
      else if((values$total_score/400 * 100)>=73)
        paste("C")
      else if((values$total_score/400 * 100)>=70)
        paste("C-")
      else if((values$total_score/400 * 100)>=67)
        paste("D+")
      else if((values$total_score/400 * 100)>=63)
        paste("D")
      else if((values$total_score/400 * 100)>=55)
        paste("D-")
      else
        paste("F")
    })
  })
  
  # create text with grade needed to make a C
  output$text_cgrade<-renderText({
    if(input$action_total==0) ""
    else if (values$up_to_final > 292)
      paste("Simulated grade already at or above a C")
    else
      paste(292 - values$up_to_final)
  })
    
})
  # })