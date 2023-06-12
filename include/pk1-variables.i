begin user variable pk1_1_1
initial value = 0.0
type = element real length = 1
end

begin user variable pk1_1_2
initial value = 0.0
type = element real length = 1
end

begin user variable pk1_1_3
initial value = 0.0
type = element real length = 1
end

begin user variable pk1_2_1
initial value = 0.0
type = element real length = 1
end

begin user variable pk1_2_2
initial value = 0.0
type = element real length = 1
end

begin user variable pk1_2_3
initial value = 0.0
type = element real length = 1
end

begin user variable pk1_3_1
initial value = 0.0
type = element real length = 1
end

begin user variable pk1_3_2
initial value = 0.0
type = element real length = 1
end

begin user variable pk1_3_3
initial value = 0.0
type = element real length = 1
end


begin user output
compute element pk1_1_1 as function pk1_1_1_function
compute element pk1_1_2 as function pk1_1_2_function
compute element pk1_1_3 as function pk1_1_3_function
compute element pk1_2_1 as function pk1_2_1_function
compute element pk1_2_2 as function pk1_2_2_function
compute element pk1_2_3 as function pk1_2_3_function
compute element pk1_3_1 as function pk1_3_1_function
compute element pk1_3_2 as function pk1_3_2_function
compute element pk1_3_3 as function pk1_3_3_function
compute at every step
end user output
