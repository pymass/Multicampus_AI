with open("test2.txt","a")  as  test  :  # 자동 close 됩니다.
    test.write("테스트1 입니다. \n")
    test.write("테스트2 입니다. \n")