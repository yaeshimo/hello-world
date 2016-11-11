hoge = 10
print("hoge\t=", hoge)

fuga = 0.101
print("fuga\t=", fuga)

print(fuga==hoge)

hoge, fuga = 20, 0.202 --muxing
print(fuga, hoge)
print(string.format("fuga=%d, hoge=%d", fuga, hoge))

print "\n"
print("+", hoge + fuga)
print("-", hoge - fuga)
print("*", hoge * fuga)
print("/", hoge / fuga)
print("%", hoge % fuga)
print "\n"

print("value types" ..
[[
nil
boolean
number
string
function
userdata
thread
table
]])

print(type(hoge))

io.write("hello io.write!")

