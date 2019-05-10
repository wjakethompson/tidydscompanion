#' Simulated Admissions Data for a Graduate Program
#'
#' Data simulated to mimic common admission criteria into a graduate program.
#' The data includes test scores on the GRE, undergraduate GPA, and gender.
#' *Note:* This data is **simulated**, and therefore is not reflective of any
#' individual program's practices. It was specifically created to have
#' interesting findings.
#'
#' @format A tibble with 9416 rows and 6 variables: \describe{
#'   \item{admit}{Admission status. 1 = admitted, 0 = not admitted}
#'   \item{gre_v}{Applicant's score on the GRE Verbal Reasoning test}
#'   \item{gre_q}{Applicant's score on the GRE Quantitative Reasoning test}
#'   \item{gre_w}{Applicant's score on the GRE Analytical Writing test}
#'   \item{gpa}{Applicant's undergraduate GPA} \item{gender}{Applicant's gender}
#'   }
"admission"
