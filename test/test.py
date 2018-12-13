with open("test","r") as test:
    line=test.readline()
    while line:
        while line.strip() and line[-2]=="\\":
            line=line[:-2]+test.readline()
        print(line)
        line=test.readline()