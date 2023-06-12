#include this towards the top after begin sierra

begin function min_principal_green_lagrange_strain_function
type is analytic
expression variable: min_eig = element_real min_principal_log_strain
evaluate expression = "0.5*(pow(exp(min_eig),2) - 1.0)" 
end function min_principal_green_lagrange_strain_function

begin function intermediate_principal_green_lagrange_strain_function
type is analytic
expression variable: intermediate_eig = element_real intermediate_principal_log_strain
evaluate expression = "0.5*(pow(exp(intermediate_eig),2) - 1.0)" 
end function intermediate_principal_green_lagrange_strain_function

begin function max_principal_green_lagrange_strain_function
type is analytic
expression variable: max_eig = element_real max_principal_log_strain
evaluate expression = "0.5*(pow(exp(max_eig),2) - 1.0)" 
end function max_principal_green_lagrange_strain_function

