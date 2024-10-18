SomeOperation <- function(v) {
    if (sum(v) > 0) {  # `sum(v)` is a single value
        return (v * 100)  # if the sum of v is greater than 0, multiplies all values in v by 100 and return them
    } else {
        return (v)
    }
}

M <- matrix(rnorm(100), 10, 10)
print(apply(M, 1, SomeOperation))
