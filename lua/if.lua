print("compare")

io.write("num1>")
num1 = io.read()

io.write("num2>")
num2 = io.read()

if num1 == num2 then
  print("equal", num1, num2)
elseif num1 > num2 then
  print("num1", num1)
else
  print("num2", num2)
end
-- don't maind case of type differently

