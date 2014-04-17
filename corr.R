corr=function(directory, threshold=0){
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
        
    setwd(paste0('/Users/jenniferli/Desktop/R/datasciencecoursera/',directory))
    
    correlations=vector()
    index=1
    for(x in dir()){ ### go through all files
        data=read.csv(x)
        complete_cases=which(!is.na(data$sulfate)&!is.na(data$nitrate))
        
        if(length(complete_cases)>threshold){
            correlations=c(correlations,cor(data$sulfate[complete_cases],data$nitrate[complete_cases]))}
    
        index=index+1
    }
    setwd('../')
    correlations 
    
}
