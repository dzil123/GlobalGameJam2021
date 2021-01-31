class_name Passwords

extends Object

const TEXT = """
foobar
password1
stupid
gamejam
password
m
Password
asdfgh
lolololol
12345
dog
qwerty
corrupted
pzpzpzp
h
monkey
letmein
qwertyuiop
computer
secret
whatever
4444
bruh
"""

static func get_arr():
	return TEXT.split("\n", false)
