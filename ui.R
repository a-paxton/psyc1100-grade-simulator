library(shiny)
library(shinythemes)
library(shinyWidgets)
library(tidyverse)

# create the user interface
shinyUI(fluidPage(
  theme = shinytheme("cerulean"),
  
  # create title
  titlePanel("PSYC 1100 Grade Simulator (Fall 2026)"),
  
  ##### 1. Instructions #####
  
  sidebarLayout(
    sidebarPanel(
      p(h5(strong("Instructions"))),
      strong("Please read and follow all instructions carefully."),
      p("Be sure to", strong("check, double-check, and", em("triple-check")), 
        "the values that you entered to avoid making any mistakes when using this simulator."),
      p("This grade simulator is provided to help you simulate what your
                grade may be in the class. Using this improperly may result in
                inaccurate simulations.", strong("Remember that this is provided only as
                a guide;"), "it isn't a guarantee of what you will earn in the class."),
      tags$ul(
        tags$li("Enter all exams in percentage (out of 100). If you earned extra credit
                  and/or if there was a curve, input the percentage after those points.
                  Check the boxes for ALL attempts that you did not take."),
        tags$li("Enter all Actives in points (out of 16)."),
        tags$li("Enter all Preps in percentage (out of 100)."),
        tags$li("For Research Credits, please enter the number of credits that you earned 
                    in the Participant Pool and Alternative Assignments"),
        tags$li("Enter your lab grade in percentage (out of 100)."),
        tags$li("After you have entered all grades, press 'Simulate!' to simulate your 
                  course grade so far."),
        tags$li("To simulate your final course grade after retaking an exam during
                  the last week of classes, simply in a grade (between 0-100) and hit 'Simulate!' again."),
        tags$li("To simulate your final course grade without retaking or making up
                  exams during the last week of class, simply check the boxes
                  for attempts.")
      ),
      hr(),
      
      ##### 2. Simulated Results #####
      
      # create total button
      actionButton("action_total", label = "Simulate!"),        
      
      br(),
      hr(),
      
      p(h5(strong("Simulated Results"))),
      p(strong("Simulated course percent: ", textOutput("simulated_weighted_average", inline = TRUE))),
      p(strong("Simulated course letter grade: ", textOutput("simulated_letter", inline = TRUE))),
      tags$ul(
        tags$li(strong("Exams: ", textOutput("simulated_exam_average", inline = TRUE)),
                tags$ul(
                  tags$li("Exam 1 average (all attempts): ", textOutput("exam_1_average", inline = TRUE)
                  ),
                  tags$li("Exam 2 average (all attempts): ", textOutput("exam_2_average", inline = TRUE)
                  ),
                  tags$li("Exam 3 average (all attempts): ", textOutput("exam_3_average", inline = TRUE)
                  )
                ),
        ),
        tags$li(strong("Preparations Checks (Preps): ", textOutput("average_preps", inline = TRUE))),
        tags$li(strong("Active Learnings (Actives): ", textOutput("average_actives", inline = TRUE))),
        tags$li(strong("Research Credits (RCs): ", textOutput("total_rcs", inline = TRUE))),
        tags$li(strong("Lab: ", textOutput("lab_score", inline = TRUE))),
      ),
      hr(),
      
    ),
    
    # create main panel
    mainPanel(
      tabPanel("Grade",
               
               ##### 3. Exams #####
               
               # Exam 1 section
               hr(),
               h2("Exams"),
               
               fluidRow(
                 column(width = 4,
                        
                        # numeric: input Exam 1 score
                        numericInputIcon("exam_1_score_first",
                                         label = h5(strong("Exam 1: First Attempt")),
                                         min = 0, value = 0,
                                         icon = list(NULL, icon("percent"))),
                        checkboxInput("exam_1_first_attempt",
                                      label = h5(strong("Check here if you did not take a first attempt")),
                                      FALSE),
                 ),
                 column(width = 4,
                        
                        # numeric: input second attempt Exam 1 score
                        numericInputIcon("exam_1_score_second",
                                         label = h5(strong("Exam 1: Second Attempt")),
                                         min = 0, value = 0,
                                         icon = list(NULL, icon("percent"))),
                        checkboxInput("exam_1_second_attempt",
                                      label = h5(strong("Check here if you did not take a second attempt")),
                                      FALSE),
                 )),
               
               # Exam 2 section
               hr(),
               # h3("Exam 2"),
               
               fluidRow(
                 column(width = 4,
                        
                        # numeric: input first attempt Exam 2 score
                        numericInputIcon("exam_2_score_first",
                                         label = h5(strong("Exam 2: First Attempt")),
                                         min = 0, value = 0,
                                         icon = list(NULL, icon("percent"))),
                        checkboxInput("exam_2_first_attempt",
                                      label = h5(strong("Check here if you did not take a first attempt")),
                                      FALSE),
                 ),
                 column(width = 4,
                        
                        # numeric: input second attempt Exam 2 score
                        numericInputIcon("exam_2_score_second",
                                         label = h5(strong("Exam 2: Second Attempt")),
                                         min = 0, value = 0,
                                         icon = list(NULL, icon("percent"))),
                        checkboxInput("exam_2_second_attempt",
                                      label = h5(strong("Check here if you did not take a second attempt")),
                                      FALSE),
                 )),
               
               # Exam 3 section
               hr(),
               # h3("Exam 3"),
               fluidRow(
                 column(width = 4,
                        
                        # numeric: input first attempt Exam 3 score
                        numericInputIcon("exam_3_score_first",
                                         label = h5(strong("Exam 3: First Attempt")),
                                         min = 0, value = 0,
                                         icon = list(NULL, icon("percent"))),
                        checkboxInput("exam_3_first_attempt",
                                      label = h5(strong("Check here if you did not take a first attempt")),
                                      FALSE),
                 ),
                 column(width = 4,
                        
                        # numeric: input second attempt Exam 3 score
                        numericInputIcon("exam_3_score_second",
                                         label = h5(strong("Exam 3: Second Attempt")),
                                         min = 0, value = 0,
                                         icon = list(NULL, icon("percent"))),
                        checkboxInput("exam_3_second_attempt",
                                      label = h5(strong("Check here if you did not take a second attempt")),
                                      FALSE),
                 )),
               
               ##### 4. Preps #####
               
               hr(),
               h2("Preparations for Class Meeting (Preps)"),
               h5("For each Prep, include the percentage that you earned."),
               h5("If you do not have a score for one in your Gradebook on HuskyCT, it means you have a 0 for it."),
               
               h4("Preps from Module 01"),
               
               # Week 01
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_01",
                                         label = h5(strong("Prep 01")),
                                         min = 0, max = 100, value = 0,
                                         icon = list(NULL, icon("percent")))),
                 column(width = 4,
                        numericInputIcon("s_prep_02",
                                         label = h5(strong("Prep 02")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               # Week 02
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_03",
                                         label = h5(strong("Prep 03")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))),
                 column(width = 4,
                        numericInputIcon("s_prep_04",
                                         label = h5(strong("Prep 04")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               # Week 03
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_05",
                                         label = h5(strong("Prep 05")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))),
                 column(width = 4,
                        numericInputIcon("s_prep_06",
                                         label = h5(strong("Prep 06")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               # Week 04
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_07",
                                         label = h5(strong("Prep 07")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               h4("Preps from Module 02"),
               
               # Week 05
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_08",
                                         label = h5(strong("Prep 08")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))),
                 column(width = 4,
                        numericInputIcon("s_prep_09",
                                         label = h5(strong("Prep 09")),
                                         min = 0, max = 100, value = 0, icon = list(NULL, icon("percent")))
                 )),
               
               # Week 06
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_10",
                                         label = h5(strong("Prep 10")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))),
                 column(width = 4,
                        numericInputIcon("s_prep_11",
                                         label = h5(strong("Prep 11")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               # Week 07
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_12",
                                         label = h5(strong("Prep 12")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))),
                 column(width = 4,
                        numericInputIcon("s_prep_13",
                                         label = h5(strong("Prep 13")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               # Week 08
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_14",
                                         label = h5(strong("Prep 14")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               h4("Preps from Module 03"),
               
               # Week 09
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_15",
                                         label = h5(strong("Prep 15")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))),
                 column(width = 4,
                        numericInputIcon("s_prep_16",
                                         label = h5(strong("Prep 16")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               # Week 10
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_17",
                                         label = h5(strong("Prep 17")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))),
                 column(width = 4,
                        numericInputIcon("s_prep_18",
                                         label = h5(strong("Prep 18")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               # Week 11
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_19",
                                         label = h5(strong("Prep 19")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))),
                 column(width = 4,
                        numericInputIcon("s_prep_20",
                                         label = h5(strong("Prep 20")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               # Week 12
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_21",
                                         label = h5(strong("Prep 21")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               h4("Preps from Module 04"),
               
               # Week 13
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_prep_22",
                                         label = h5(strong("Prep 22")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))),
                 column(width = 4,
                        numericInputIcon("s_prep_23",
                                         label = h5(strong("Prep 23")),
                                         min = 0, max = 100, value = 0, 
                                         icon = list(NULL, icon("percent")))
                 )),
               
               ##### 5. Actives #####
               
               hr(),
               h2("Active Learning (Actives)"),
               h5("For each Active, include the points that you earned (out of 16)."),
               h5("If you do not have a score for one in your Gradebook on HuskyCT, it means you have a 0 for it."),
               
               h4("Actives from Module 01"),
               
               # Week 01
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_01",
                                         label = h5(strong("Active 01")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_active_02",
                                         label = h5(strong("Active 02")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               # Week 02
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_03",
                                         label = h5(strong("Active 03")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_active_04",
                                         label = h5(strong("Active 04")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16"))))
               ),
               
               # Week 03
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_05",
                                         label = h5(strong("Active 05")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_active_06",
                                         label = h5(strong("Active 06")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               # Week 04
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_07",
                                         label = h5(strong("Active 07")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               h4("Actives from Module 02"),
               
               # Week 05
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_08",
                                         label = h5(strong("Active 08")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_active_09",
                                         label = h5(strong("Active 09")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               # Week 06
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_10",
                                         label = h5(strong("Active 10")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_active_11",
                                         label = h5(strong("Active 11")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               # Week 07
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_12",
                                         label = h5(strong("Active 12")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_active_13",
                                         label = h5(strong("Active 13")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               # Week 08
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_14",
                                         label = h5(strong("Active 14")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               h4("Actives from Module 03"),
               
               # Week 09
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_15",
                                         label = h5(strong("Active 15")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_active_16",
                                         label = h5(strong("Active 16")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               # Week 10
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_17",
                                         label = h5(strong("Active 17")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_active_18",
                                         label = h5(strong("Active 18")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               # Week 11
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_19",
                                         label = h5(strong("Active 19")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_active_20",
                                         label = h5(strong("Active 20")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               # Week 12
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_21",
                                         label = h5(strong("Active 21")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               h4("Actives from Module 04"),
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_active_22",
                                         label = h5(strong("Active 22")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_active_23",
                                         label = h5(strong("Active 23")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               h4("Make-Up or Retake Actives"),
               fluidRow(
                 column(width = 4,
                        numericInputIcon("s_makeup_active_01",
                                         label = h5(strong("Make-Up or Retake Active 01")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 ),
                 column(width = 4,
                        numericInputIcon("s_makeup_active_02",
                                         label = h5(strong("Make-Up or Retake Active 02")),
                                         min = 0, max = 16, value = 0,
                                         icon = list(NULL, c("out of 16")))
                 )),
               
               ##### 7. ELCs #####
               
               hr(),
               h3("RCs"),
               
               fluidRow(
                 column(4,
                        # numeric: input total participant pool credits
                        numericInputIcon("rc_participant_pool_credits",
                                     label = h5("Total credits from Participant Pool"),
                                     min = 0, value = 0, max = 30,
                                     icon = list(NULL, icon("hashtag")))
                 ),
                 column(4,
                        
                        # numeric: input total alternate assignment
                        numericInputIcon("rc_alt_assignment_credits",
                                         label = h5("Total credits from Alternate Assignments"),
                                         min = 0, value = 0, max = 30,
                                         icon = list(NULL, icon("hashtag")))
                 )
               ),   
               
               ##### 8. Lab #####
               
               hr(),
               h3("Lab"),
               
               # numeric: input lab percentage
               fluidRow(
                 column(3,
                        numericInputIcon("lab_score",
                                         label = h5("Total percentage in lab (out of 100)"),
                                         min = 0, max = 100, value = 0, icon = list(NULL, icon("percent"))))),
               br(),    
      )
    )
  ),
))
