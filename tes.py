def faktorial(n: int) -> int:
    if n == 0:
        return 1
    else:
        
        return n * faktorial(n-1)
n = int(input())
#   (f"Langkah {n}: {n}! = {n} * {n-1}! = {memo} (hasil dari langkah {n-1} = {n-1})\n")
print(faktorial(n))