##### 1. Grade bundles #####

grade_table = data.frame(
  letter_grade = c("A",
                   "A-",
                   "B+",
                   "B",
                   "B-",
                   "C+",
                   "C",
                   "C-",
                   "D+",
                   "D",
                   "D-",
                   "F"),
  percent_cutoff = c(93.50000,
                     89.50000,
                     86.50000,
                     83.50000,
                     79.50000,
                     76.50000,
                     73.50000,
                     69.50000,
                     66.50000,
                     63.50000,
                     59.50000,
                     0)
)

##### 2. Exams #####

# total possible points
exam_01_max = 86
exam_02_max = 91
exam_03_max = 92

##### 3. Weights #####
exam_weight = .35
active_weight = .3
prep_weight = .2
lab_weight = .1
rc_weight = .05

##### 4. Dropped #####
total_actives_original = 23
total_actives_makeup = 2
total_actives = total_actives_original + total_actives_makeup
total_preps_original = 23
total_preps_makeup = 0
total_preps = total_preps_original + total_preps_makeup
dropped_n_actives = 2 + total_actives_makeup
dropped_n_preps = 3 + total_preps_makeup
top_n_actives = total_actives - dropped_n_actives
top_n_preps = total_preps - dropped_n_preps