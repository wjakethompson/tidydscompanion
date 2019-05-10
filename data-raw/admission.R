library(tidyverse)
library(mvtnorm)
library(here)

dim_cor <- matrix(data = c(1.00, 0.35, 0.68, 0.23,
                           0.35, 1.00, 0.16, 0.21,
                           0.68, 0.16, 1.00, 0.09,
                           0.23, 0.21, 0.09, 1.00),
                  nrow = 4, byrow = TRUE)

set.seed(9416)
admission <- rmvnorm(9416, mean = rep(0, nrow(dim_cor)), sigma = dim_cor) %>%
  as_tibble(.name_repair = ~ c("x1", "x2", "x3", "x4")) %>%
  rowid_to_column(var = "subject_id") %>%
  mutate(gre_v = (x1 * 8.75) + 150,
         gre_q = (x2 * 8.75) + 150,
         gre_w = (x3 * 1.00) + 3.5,
         gpa = (x4 * 0.3) + 3.0,
         gre_v = case_when(gre_v < 130 ~ 130,
                           gre_v > 170 ~ 170,
                           TRUE ~ gre_v),
         gre_q = case_when(gre_q < 130 ~ 130,
                           gre_q > 170 ~ 170,
                           TRUE ~ gre_q),
         gre_w = case_when(gre_w > 6 ~ 6,
                           gre_w < 0 ~ 0,
                           TRUE ~ gre_w),
         gpa = case_when(gpa > 4 ~ 4,
                         gpa < 0 ~ 0,
                         TRUE ~ gpa),
         gre_v = as.integer(round(gre_v, digits = 0)),
         gre_q = as.integer(round(gre_q, digits = 0)),
         gre_w = round(gre_w / 0.5) * 0.5,
         gpa = round(gpa / 0.01) * 0.01,
         gender = sample(factor(c("Male", "Female"),
                                levels = c("Male", "Female")),
                         n(), replace = TRUE, prob = c(0.6, 0.4))) %>%
  mutate(z = -0.8 + (0.2 * x1) + (0.4 * x2 ) + (1.4 * x1 * x2) +
           (0.6 * x3) + (2 * x4) + (-1 * as.numeric(gender)),
         prob = 1 / (1 + exp(-z)),
         admit = map_int(prob, ~ rbernoulli(1, p = .x))) %>%
  select(admit, gre_v:gender)

usethis::use_data(admission)
