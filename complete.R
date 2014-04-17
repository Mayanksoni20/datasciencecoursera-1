complete=function(directory, id=1:332){
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:complete("specdata", 30:25)
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    setwd(paste0('/Users/jenniferli/Desktop/R/datasciencecoursera/',directory))
    
    complete_cases=data.frame()
    for(x in id){ ### which files to go through
        data=read.csv(dir()[x])
        how_many_complete=0
        for (each_row in 1:nrow(data)){
            if(sum(!is.na(data[each_row,]))==4){
                how_many_complete=how_many_complete+1
            }
        }
        
        
        complete_cases=rbind(complete_cases,c(x,how_many_complete))
    }
    
    
    setwd('../')
    colnames(complete_cases)=c('id','nobs')
    complete_cases
}
