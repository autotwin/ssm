#include this towards the top after begin sierra

begin function e_dot_1_1_function
type is analytic
expression variable: u = element_sym_tensor right_stretch
expression variable: d = element_tensor rate_of_deformation
evaluate expression = "(d_xx*u_xx*u_xx)   + (2*d_xy*u_xx*u_xy) +             \#
                       (d_yy*u_xy*u_xy)   + (2*d_xz*u_xx*u_zx) +             \#
                       (2*d_yz*u_xy*u_yz) + (d_zz*u_zx*u_zx)"
end function e_dot_1_1_function

begin function e_dot_2_2_function
type is analytic
expression variable: u = element_sym_tensor right_stretch
expression variable: d = element_tensor rate_of_deformation
evaluate expression = "(d_xx*u_xy*u_xy)   + (2*d_xy*u_xy*u_yy) +             \#
                       (d_yy*u_yy*u_yy)   + (2*d_xz*u_xy*u_yz) +             \#
                       (2*d_yz*u_yy*u_yz) + (d_zz*u_yz*u_yz)"
end function e_dot_2_2_function

begin function e_dot_3_3_function
type is analytic
expression variable: u = element_sym_tensor right_stretch
expression variable: d = element_tensor rate_of_deformation
evaluate expression = "(d_xx*u_zx*u_zx)   + (2*d_xy*u_zx*u_yz) +             \#
                       (d_yy*u_yz*u_yz)   + (2*d_xz*u_zx*u_zz) +             \#
                       (2*d_yz*u_yz*u_zz) + (d_zz*u_zz*u_zz)"
end function e_dot_3_3_function

begin function e_dot_1_2_function
type is analytic
expression variable: u = element_sym_tensor right_stretch
expression variable: d = element_tensor rate_of_deformation
evaluate expression = "(d_xy*u_xy*u_xy)   + (d_xx*u_xx*u_xy)   +             \#
                       (d_xy*u_yy*u_xx)   + (d_xz*u_yz*u_xx)   +             \#
                       (d_yy*u_yy*u_xy) +   (d_yz*u_yz*u_xy)   +             \#
                       (d_xz*u_xy*u_zx)   + (d_yz*u_yy*u_zx)   +             \#
                       (d_zz*u_yz*u_zx)"
end function e_dot_1_2_function  

begin function e_dot_1_3_function
type is analytic
expression variable: u = element_sym_tensor right_stretch
expression variable: d = element_tensor rate_of_deformation
evaluate expression = "(d_xz*u_zx*u_zx)   + (d_xx*u_zx*u_xx)   +             \#
                       (d_xy*u_yz*u_xx)   + (d_xz*u_zz*u_xx)   +             \#
                       (d_xy*u_xy*u_zx) +   (d_yy*u_yz*u_xy)   +             \#
                       (d_yz*u_zz*u_xy)   + (d_yz*u_yz*u_zx)   +             \#
                       (d_zz*u_zz*u_zx)"
end function e_dot_1_3_function  

begin function e_dot_2_3_function
type is analytic
expression variable: u = element_sym_tensor right_stretch
expression variable: d = element_tensor rate_of_deformation
evaluate expression = "(d_yz*u_yz*u_yz)   + (d_xx*u_zx*u_xy)   +             \#
                       (d_xy*u_yz*u_xy)   + (d_xz*u_zz*u_xy)   +             \#
                       (d_xy*u_zx*u_yy) +   (d_yy*u_yz*u_yy)   +             \#
                       (d_yz*u_zz*u_yy)   + (d_xz*u_zx*u_yz)   +             \#
                       (d_zz*u_zz*u_yz)"
end function e_dot_2_3_function  

begin function j_2_e_dot_function
type is analytic
expression variable: e_dot_1_1 = element e_dot_1_1
expression variable: e_dot_2_2 = element e_dot_2_2
expression variable: e_dot_3_3 = element e_dot_3_3
expression variable: e_dot_1_2 = element e_dot_1_2
expression variable: e_dot_1_3 = element e_dot_1_3
expression variable: e_dot_2_3 = element e_dot_2_3
evaluate expression = "((pow((e_dot_1_1 - e_dot_2_2),2)    +                 \#
                       pow((e_dot_2_2 - e_dot_3_3),2)      +                 \#
                       pow((e_dot_3_3 - e_dot_1_1),2))/6)  +                 \#
                       pow((e_dot_1_2),2)                  +                 \#
                       pow((e_dot_2_3),2)                  +                 \#
                       pow((e_dot_1_3),2)"
end function j_2_e_dot_function

begin function e_dot_vm_function
type is analytic
expression variable: j_2_e_dot = element j_2_e_dot
evaluate expression = "sqrt((4/3)*j_2_e_dot)"
end function e_dot_vm_function
