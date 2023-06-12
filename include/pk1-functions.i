#include this towards the top after begin sierra

begin function pk1_1_1_function
type is analytic
expression variable: sigma = element_sym_tensor cauchy_stress
expression variable: f = element_tensor deformation_gradient
evaluate expression = "((-f_yz*f_zy) + (f_yy*f_zz))*sigma_xx"
end function pk1_1_1_function

begin function pk1_1_2_function
type is analytic
expression variable: sigma = element_sym_tensor cauchy_stress
expression variable: f = element_tensor deformation_gradient
evaluate expression = "((f_yz*f_zx) - (f_yx*f_zz))*sigma_xy"
end function pk1_1_2_function


begin function pk1_1_3_function
type is analytic
expression variable: sigma = element_sym_tensor cauchy_stress
expression variable: f = element_tensor deformation_gradient
evaluate expression = "((-f_yy*f_zx) + (f_yx*f_zy))*sigma_zx"
end function pk1_1_3_function


begin function pk1_2_1_function
type is analytic
expression variable: sigma = element_sym_tensor cauchy_stress
expression variable: f = element_tensor deformation_gradient
evaluate expression = "((f_xz*f_zy) - (f_xy*f_zz))*sigma_xy"
end function pk1_2_1_function


begin function pk1_2_2_function
type is analytic
expression variable: sigma = element_sym_tensor cauchy_stress
expression variable: f = element_tensor deformation_gradient
evaluate expression = "((-f_xz*f_zx) + (f_xx*f_zz))*sigma_yy"
end function pk1_2_2_function


begin function pk1_2_3_function
type is analytic
expression variable: sigma = element_sym_tensor cauchy_stress
expression variable: f = element_tensor deformation_gradient
evaluate expression = "((f_xy*f_zx) - (f_xx*f_zy))*sigma_yz"
end function pk1_2_3_function


begin function pk1_3_1_function
type is analytic
expression variable: sigma = element_sym_tensor cauchy_stress
expression variable: f = element_tensor deformation_gradient
evaluate expression = "((-f_xz*f_yy) + (f_xy*f_yz))*sigma_zx"
end function pk1_3_1_function


begin function pk1_3_2_function
type is analytic
expression variable: sigma = element_sym_tensor cauchy_stress
expression variable: f = element_tensor deformation_gradient
evaluate expression = "((f_xz*f_yx) - (f_xx*f_yz))*sigma_yz"
end function pk1_3_2_function


begin function pk1_3_3_function
type is analytic
expression variable: sigma = element_sym_tensor cauchy_stress
expression variable: f = element_tensor deformation_gradient
evaluate expression = "((-f_xy*f_yx) + (f_xx*f_yy))*sigma_zz"
end function pk1_3_3_function

