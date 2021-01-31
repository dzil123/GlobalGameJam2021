class_name Passwords

extends Object

const TEXT = """
foobar
password1
stupid
gamejam
password
m
Password!
asdfgh
lolololol
12345
dog
qwerty
corrupted
Type tHis
pzpzpzp
h
"""

static func get_arr():
	return TEXT.split("\n", false)
