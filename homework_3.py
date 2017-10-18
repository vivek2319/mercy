def convert_to_celsius(fahrenheit, num):
    a = float((fahrenheit - 32.0) * 5.0 / 9.0)
    b='{number:.{digits}f}'.format(number=a, digits=num)
    return print("The value of Temperature in celsius is",b)



