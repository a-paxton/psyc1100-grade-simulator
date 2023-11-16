library(shiny)
library(shinythemes)

# create the user interface
shinyUI(fluidPage(
  theme = shinytheme("cerulean"),
  
  # create title
  titlePanel("PSYC 1100 Grade Simulator (Fall 2023)"),
  
  ##### 1. Instructions #####
  
  sidebarLayout(
    sidebarPanel(
      p(h5(strong("Instructions"))),
      tags$ul(
        tags$li("This grade simulator is provided to help you simulate what your
                grade may be in the class. Please note that this is provided for your
                informational purposes only. Using this improperly may result in
                inaccurate simulations."),
        tags$li(strong("Please read and follow all instructions carefully.")),
        tags$ul(
          tags$li("For exam scores, please enter the points that you earned (not the percentage). 
                  If there was a curve for the grade, remember to input your curved score, not the original score.
                  Check the boxes for ALL attempts that you did not take."),
          tags$li("For each Prep, Active, and CTS, check the box if you earned a Satisfactory. 
                  (Do not check it if you earned an Unsatisfactory.)"),
          tags$li("For ELCs, please enter the number of credits that you earned 
                    in the Participant Pool and Alternative Assignments"),
          tags$li("For the lab grade, please enter the percentage that you earned (out of 100)."),
          tags$li("After you have entered all grades, press 'Simulate!' to simulate your 
                  course grade so far.")
        ),
        tags$li("Be sure to", strong("check, double-check, and", em("triple-check")), 
                "the values that you entered to avoid making any mistakes when using 
                this grade simulator."),
        tags$li("To simulate your final course grade with the Cumulative Final Exam, simply 
                  type in a grade (between 0-100) and hit 'Simulate!' again."),
        tags$li("To simulate your final course grade without taking the Cumulative Final
                  Exam, check the box below the Optional Final Exam box.")),
      hr(),
      
      ##### 2. Simulated Results #####
      
      # create total button
      actionButton("action_total", label = "Simulate!"),        
      
      br(),
      hr(),
      
      p(h5(strong("Simulated Results"))),
      tags$ul(
        tags$li(strong("Exams"),
                tags$ul(
                  tags$li("Grade Bundle: ", textOutput("exam_letter", inline = TRUE), 
                          tags$ul(
                            tags$li(strong("Remember: Your performance on the exam category sets the",
                                    em("maximum"), "letter grade that you can earn in the class."), "This gradebook item
                                    has the largest impact on your overall grade."))
                          ),
                  tags$li("Satisfactory exams on first attempt: ", textOutput("exams_satisfactory_first", inline = TRUE)
                  ),
                  tags$li("Satisfactory exams on second attempt: ", textOutput("exams_satisfactory_second", inline = TRUE)
                  ),
                  tags$li("Exam average (best of three exams): ", textOutput("simulated_exam_average", inline = TRUE),
                          tags$ul(
                            tags$li("Exam 1 average (all attempts): ", textOutput("exam_1_average", inline = TRUE)
                            ),
                            tags$li("Exam 2 average (all attempts): ", textOutput("exam_2_average", inline = TRUE)
                            ),
                            tags$li("Exam 3 average (all attempts): ", textOutput("exam_3_average", inline = TRUE)
                            ),
                            tags$li("Cumulative Final average (all attempts): ", textOutput("sim_final_average", inline = TRUE)
                            )
                          )
                  ),
                ),
        ),
        tags$li(strong("Preps"),
                tags$ul(
                  tags$li("Grade Bundle:", textOutput("prep_letter", inline = TRUE)),
                  tags$li("Total Satisfactory:", textOutput("total_preps", inline = TRUE)),
                ),
        ),
        tags$li(strong("Actives"),
                tags$ul(
                  tags$li("Grade Bundle:", textOutput("active_letter", inline = TRUE)),
                  tags$li("Total Satisfactory:", textOutput("total_actives", inline = TRUE)),
                ),
        ),
        tags$li(strong("CTSes"),
                tags$ul(
                  tags$li("Grade Bundle:", textOutput("cts_letter", inline = TRUE)),
                  tags$li("Total Satisfactory:", textOutput("total_ctses", inline = TRUE)),
                ),
        ),
        tags$li(strong("ELCs"),
                tags$ul(
                  tags$li("Grade Bundle:", textOutput("elc_letter", inline = TRUE)),
                  tags$li("Total Credits:", textOutput("total_elcs", inline = TRUE)),
                ),
        ),
        tags$li(strong("Lab"),
                tags$ul(
                  tags$li("Grade Bundle:", textOutput("lab_letter", inline = TRUE)),
                  tags$li("Lab Percentage:", textOutput("lab_score", inline = TRUE)),
                ),
        ),
      ),
      hr(),
      
    ),
    
    # create main panel
    mainPanel(
      tabPanel("Grade",
               
               # Exam 1 section
               hr(),
               h3("Exam 1"),
               
               fluidRow(
                 column(width = 4,
                        
                        ##### 1. Exams #####
                        
                        # numeric: input Exam 1 score
                        numericInput("exam_1_score_first",
                                     label = h4(strong("Exam 1: First Attempt Score"),
                                                br(),"(out of 82)"),
                                     min = 0, max = 85, value = 0)
                 ),
                 column(width = 4,
                        
                        # numeric: input second attempt Exam 1 score
                        numericInput("exam_1_score_second",
                                     label = h4(strong("Exam 1: Second Attempt Score"),
                                                br(),"(out of 82)"),
                                     min = 0, max = 85, value = 0),
                        checkboxInput("exam_1_second_attempt",
                                      label = h5(strong("Check here if you did not take a second attempt")),
                                      FALSE),
                 ),
                 column(width = 4,
                        
                        # numeric: input third attempt Exam 1 score
                        numericInput("exam_1_score_third",
                                     label = h4(strong("Third Attempt Exam 1 Score"),
                                                br(),"(out of 82)"),
                                     min = 0, max = 85, value = 0),
                        checkboxInput("exam_1_third_attempt",
                                      label = h5(strong("Check here if you did not take a third attempt")),
                                      FALSE),
                 )),
               
               # Exam 2 section
               hr(),
               h3("Exam 2"),
               
               fluidRow(
                 column(width = 4,
                        
                        # numeric: input first attempt Exam 2 score
                        numericInput("exam_2_score_first",
                                     label = h4(strong("Exam 2: First Attempt Score"),
                                                br(),"(out of 83)"),
                                     min = 0, max = 85, value = 0),
                 ),
                 column(width = 4,
                        
                        # numeric: input second attempt Exam 2 score
                        numericInput("exam_2_score_second",
                                     label = h4(strong("Exam 2: Second Attempt Score"),
                                                br(),"(out of 83)"),
                                     min = 0, max = 85, value = 0),
                        checkboxInput("exam_2_second_attempt",
                                      label = h5(strong("Check here if you did not take a second attempt")),
                                      FALSE),
                 ),
                 column(width = 4,
                        
                        # numeric: input third attempt Exam 2 score
                        numericInput("exam_2_score_third",
                                     label = h4(strong("Exam 2: Third Attempt Score"),
                                                br(),"(out of 83)"),
                                     min = 0, max = 85, value = 0),
                        checkboxInput("exam_2_third_attempt",
                                      label = h5(strong("Check here if you did not take a third attempt")),
                                      FALSE),
                 )),
               
               # Exam 3 section
               hr(),
               h3("Exam 3"),
               fluidRow(
                 column(width = 4,
                        
                        # numeric: input first attempt Exam 3 score
                        numericInput("exam_3_score_first",
                                     label = h4(strong("Exam 3: First Attempt Score"),
                                                br(),"(out of 78)"),
                                     min = 0, max = 85, value = 0),
                        
                 ),
                 column(width = 4,
                        
                        # numeric: input second attempt Exam 3 score
                        numericInput("exam_3_score_second",
                                     label = h4(strong("Exam 3: Second Attempt Score"),
                                                br(),"(out of 78)"),
                                     min = 0, max = 85, value = 0),
                        checkboxInput("exam_3_second_attempt",
                                      label = h5(strong("Check here if you did not take a second attempt")),
                                      FALSE),
                 ),
                 column(width = 4,
                        
                        # numeric: input third attempt Exam 3 score
                        numericInput("exam_3_score_third",
                                     label = h4(strong("Exam 3: Third Attempt Score"),
                                                br(),"(out of 78)"),
                                     min = 0, max = 85, value = 0),
                        checkboxInput("exam_3_third_attempt",
                                      label = h5(strong("Check here if you did not take a third attempt")),
                                      FALSE),
                 )),
               
               # Optional Final section
               hr(),
               h3("Cumulative Final"),
               fluidRow(
                 column(width = 4,
                        
                        # numeric: input first Cumulative Final Exam percent
                        numericInput("final_exam_percent_first",
                                     label = h4(strong("Cumulative Final: Estimated First Attempt Percentage"),
                                                br(),"(out of 100%)"),
                                     min = 0, max = 110, value = 0),
                        checkboxInput("final_exam_taking",
                                      label = h5(strong("Check here if you will not take the Cumulative Final")),
                                      FALSE),
                 ),
                 column(width = 4,
                        
                        # numeric: input Optional Final Exam score
                        numericInput("final_exam_percent_second",
                                     label = h4(strong("Cumulative Final: Estimated Second Attempt Percentage"),
                                                br(),"(out of 100%)"),
                                     min = 0, max = 110, value = 0),
                        checkboxInput("final_exam_second_attempt",
                                      label = h5(strong("Check here if you will not take a second attempt")),
                                      FALSE),
                 )),
               
               ##### 2. Preps #####
               
               hr(),
               h3("Preparations for Class Meeting (Preps)"),
               h5("Check the box for if you earned a Satisfactory for the item."),
               
               # checkboxes: check each Satisfactory Prep
               uiOutput("satisfactory_prep"),
               
               ##### 3. Actives #####
               
               hr(),
               h3("Active Learning (Actives)"),
               h5("Check the box for if you earned a Satisfactory for each KC and each L&R."),
               h5("Remember: To earn Satisfactory on an Active, you must earn a Satisfactory on both the KC and L&R."),
               fluidRow(
                 column(2, 
                        h4("KCs"),
                        # checkboxes: check each Satisfactory KC
                        uiOutput("satisfactory_kc")
                 ),
                 column(2, 
                        h4("L&Rs"),
                        # checkboxes: check each Satisfactory L&R
                        uiOutput("satisfactory_lr")
                 )),
               
               ##### 4. CTSes #####
               
               hr(),
               h3("Critical Thinking & Synthesis (CTSes)"),
               h5("Check the box for if you earned a Satisfactory for the overall CTS."),
               
               # checkboxes: check each Satisfactory KC
               uiOutput("satisfactory_cts"),
               
               ##### 5. ELCs #####
               
               hr(),
               h3("ELCs"),
               
               fluidRow(
                 column(3,
                        # numeric: input total participant pool ELCs
                        numericInput("elc_participant_pool_credits",
                                     label = h5("Total credits earned from Participant Pool"),
                                     min = 0, value = 0)
                 ),
                 column(3,
                        
                        # numeric: input total alternate assignment
                        numericInput("elc_alt_assignment_credits",
                                     label = h5("Total credits earned from Alternate Assignments"),
                                     min = 0, value = 0, max = 30),
                 )
               ),   
               
               ##### 6. Lab #####
               
               hr(),
               h3("Lab"),
               
               # numeric: input lab percentage
               numericInput("lab_score",
                            label = h5("Total percentage in lab (out of 100)"),
                            min = 0, max = 110, value = 0),
               br(),    
               
               
      )
    )
  ),
))
