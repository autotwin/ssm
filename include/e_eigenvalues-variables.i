begin user variable min_principal_green_lagrange_strain
initial value = 0.0
type = element real length = 1
end

begin user variable intermediate_principal_green_lagrange_strain
initial value = 0.0
type = element real length = 1
end

begin user variable max_principal_green_lagrange_strain
initial value = 0.0
type = element real length = 1
end




begin user output
compute element min_principal_green_lagrange_strain as function min_principal_green_lagrange_strain_function
compute element intermediate_principal_green_lagrange_strain as function intermediate_principal_green_lagrange_strain_function
compute element max_principal_green_lagrange_strain as function max_principal_green_lagrange_strain_function
compute at every step
end user output
