begin user variable j_2_e
initial value = 0.0
type = element real length = 1
end

begin user variable e_vm
initial value = 0.0
type = element real length = 1
end

begin user output
compute element j_2_e as function j_2_e_function
compute element e_vm  as function e_vm_function
compute at every step
end user output

