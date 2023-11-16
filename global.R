##### 1. Grade bundles #####

grade_bundles = data.frame(letter_grade = c("A", "B", "C", "D", "F"),
                           exam_first_attempt = c(3, 2, 1, 0, 0),
                           exam_second_attempt = c(0, 1, 2, 0, 0),
                           exam_65 = c(0, 0, 0, 3, 0),
                           exam_average = c(0, 0, 70, 55, 0),
                           prep_satisfactory = c(17, 15, 13, 11, 0),
                           active_satisfactory = c(15, 13, 11, 9, 0),
                           cts_satisfactory = c(3, 2, 1, 0, 0),
                           elcs = c(5, 3, 1, 0, 0),
                           lab = c(85, 80, 70, 55, 0))

##### 2. Exams #####

# total possible points
exam_01_max = 80
exam_02_max = 85
exam_03_max = 80
cumulative_final_max = 100

# passing for each
exam_01_satisfactory = exam_01_max * .75
exam_02_satisfactory = exam_02_max * .75
exam_03_satisfactory = exam_03_max * .75
cumulative_final_satisfactory = 75