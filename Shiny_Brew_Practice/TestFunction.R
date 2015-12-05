# Test Function loaded pre server 

test <- function(text = "test"){
        data <- data.frame(A=1:1000000,B = 1:1000000)
        write.csv(x = data,file = "data.csv",row.names = F,col.names = F)
        cat(text)
}