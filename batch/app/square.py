import sys
def square(x):
    return x * x

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python square.py <number>")
        sys.exit(1)

    try:
        number = float(sys.argv[1])
        result = square(number)
        print(f"The square of {number} is {result}")
    except ValueError:
        print("Please provide a valid number.")
        sys.exit(1)
