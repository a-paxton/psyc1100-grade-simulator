library(shiny)
library(shinythemes)

# create the user interface
shinyUI(fluidPage(
  theme = shinytheme("spacelab"),
  
  # create title
  titlePanel("PSYC 1100 Grade Simulator"),
  
  # create sidebar
  sidebarLayout(
    sidebarPanel(
      p(h5(strong("Instructions"))),
      tags$ul(
        tags$li("For each item, please enter the", strong("actual grade"),"that you 
        earned (visible on HuskyCT). After you have entered all grades,
        press 'Total' to calculate your total grade so far."),
        tags$li("Each text box",strong("must"), "have a number in it, even if that 
        number is zero."),
        tags$li("Be sure to", strong("check and double-check"), "the values that you 
        entered to avoid making any mistakes when using this grade simulator."),
        tags$li("To estimate your final grade with the Optional Final Exam, simply 
        type in a grade (between 0-150) and hit 'Total' again."),
        tags$li("To estimate what your grade will be without taking the Optional Final
        Exam, enter '0' for the Optional Final Exam box.")),
      hr(),
      
      # specify the grade
      p(h5(strong("Grading scale")),
        ("For more, see syllabus.")),
      tags$ul(
        tags$li("372 points  =<	A"),
        tags$li("360 points  =<    A-    <   372 points"),
        tags$li("348 points  =<    B+   <   360 points"),
        tags$li("332 points  =<    B     <   348 points"),
        tags$li("320 points  =<    B-    <   332 points"),
        tags$li("308 points  =<    C+   <   320 points"),
        tags$li("292 points  =<    C     <   308 points"),
        tags$li("280 points  =<    C-    <   292 points"),
        tags$li("268 points  =<    D+   <   280 points"),
        tags$li("252 points  =<    D     <   268 points"),
        tags$li("220 points  =<    D-    <   252 points"),
        tags$li("F      <   220 points")),
      hr(),
      
      # spit out grades
      p(h5(strong("Simulated grade")),
        "Final grades will not be rounded up or down."),
      tags$ul(
        tags$li(strong("Simulated points: "), textOutput("text_grade")),
        tags$li(strong("Simulated percent: "), textOutput("text_percent")),
        tags$li(strong("Simulated letter: "), textOutput("text_comment")),
        tags$li(strong("Simulated grade needed on Optional Final to make a C in the class: "), 
                textOutput("text_cgrade"))),
      hr(),
      
      # create total button
      actionButton("action_total", label = "Total")        
    ),
    
    # create main panel
    mainPanel(
      tabPanel("Grade",
               
               # numeric: input Exam 1 score
               numericInput("exam_1_score",
                            label = h4(strong(em("Curved"), " Exam 1 Score"),
                                       br(),"(out of 150)"),
                            min = 0, max = 170, value = 0),
               br(),
               
               # numeric: input Exam 2 score
               numericInput("exam_2_score",
                            label = h4(strong(em("Curved"), "Exam 2 Score"),
                                       br(),"(out of 150)"),
                            min = 0, max = 170, value = 0),
               
               br(),
               
               # numeric: input Optional Final Exam score
               numericInput("final_exam_score",
                            label = h4(strong("Estimated Optional Final Exam Score"),
                                       br(),"(out of 150)"),
                            min = 0, max = 170, value = 0),
               
               br(),
               
               # numeric: input lab percentage
               numericInput("lab_score",
                            label = h4(strong("Lab percentage"),
                                       br(),"(out of 100)"),
                            min = 0, max = 110, value = 0),
               br(),       
               
               # numeric: input total participant pool ELCs
               numericInput("elc_participant_pool_credits",
                            label = h4(strong("ELC: ",
                                              "Total credits earned from Participant Pool")),
                            min = 0, value = 0),
               br(),
               
               # numeric: input total writing credit ELCs
               numericInput("elc_writing_credits",
                            label = h4(strong("ELC: ",
                                              "Total credits earned from writing assignments")),
                            min = 0, value = 0, max = 30),
               
               br(),            
               
               # numeric: input Knowledge Check 1 score
               numericInput("kc_1",
                            label = h4(strong("Knowledge Check 1 Score"),
                                       br(),"(out of 20)"),
                            min = 0, max = 20, value = 0),
               br(),            
               
               # numeric: input Knowledge Check 2 score
               numericInput("kc_2",
                            label = h4(strong("Knowledge Check 2 Score"),
                                       br(),"(out of 20)"),
                            min = 0, max = 20, value = 0),
               br(),            
               
               # numeric: input Knowledge Check 3 score
               numericInput("kc_3",
                            label = h4(strong("Knowledge Check 3 Score"),
                                       br(),"(out of 20)"),
                            min = 0, max = 20, value = 0),
               br(),            
               
               # numeric: input Knowledge Check 4 score
               numericInput("kc_4",
                            label = h4(strong("Knowledge Check 4 Score"),
                                       br(),"(out of 20)"),
                            min = 0, max = 20, value = 0),
               br(),            
               
               # numeric: input Knowledge Check 5 score
               numericInput("kc_5",
                            label = h4(strong("Knowledge Check 5 Score"),
                                       br(),"(out of 10)"),
                            min = 0, max = 10, value = 0),
               
               br(),            
               
               # numeric: input Knowledge Check 6 score
               numericInput("kc_6",
                            label = h4(strong("Knowledge Check 6 Score"),
                                       br(),"(out of 10)"),
                            min = 0, max = 10, value = 0)
               
      )
    )
  ),
))