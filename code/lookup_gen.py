# Used to generate the hex look-up table

# Format:
# db 'XX' ; X
# db 0x00

for i in range(0, 256):
    print("\tdb " + "\'x" + f"{i:02x}" + "\'" + "\t; " + str(i))
    print("\tdb 0x00\n")
