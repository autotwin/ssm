#include this towards the top after begin sierra

begin function j_2_e_function
type is analytic
expression variable: e = element_sym_tensor green_lagrange_strain
evaluate expression = "((pow((e_xx - e_yy),2)              +                 \#
                       pow((e_yy - e_zz),2)                +                 \#
                       pow((e_zz - e_xx),2))/6)            +                 \#
                       pow((e_xy),2)                       +                 \#
                       pow((e_yz),2)                       +                 \#
                       pow((e_zx),2)"
end function j_2_e_function

begin function e_vm_function
type is analytic
expression variable: j_2_e = element j_2_e
evaluate expression = "sqrt((4/3)*j_2_e)"
end function e_vm_function
