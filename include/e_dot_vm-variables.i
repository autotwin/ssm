begin user variable e_dot_1_1
initial value = 0.0
type = element real length = 1
end

begin user variable e_dot_2_2
initial value = 0.0
type = element real length = 1
end

begin user variable e_dot_3_3
initial value = 0.0
type = element real length = 1
end

begin user variable e_dot_1_2
initial value = 0.0
type = element real length = 1
end

begin user variable e_dot_1_3
initial value = 0.0
type = element real length = 1
end

begin user variable e_dot_2_3
initial value = 0.0
type = element real length = 1
end

begin user variable j_2_e_dot
initial value = 0.0
type = element real length = 1
end

begin user variable e_dot_vm
initial value = 0.0
type = element real length = 1
end

begin user output
compute element e_dot_1_1 as function e_dot_1_1_function
compute element e_dot_2_2 as function e_dot_2_2_function
compute element e_dot_3_3 as function e_dot_3_3_function
compute element e_dot_1_2 as function e_dot_1_2_function
compute element e_dot_1_3 as function e_dot_1_3_function
compute element e_dot_2_3 as function e_dot_2_3_function
compute element j_2_e_dot as function j_2_e_dot_function
compute element e_dot_vm  as function e_dot_vm_function
compute at every step
end user output

