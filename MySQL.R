hg19=dbConnect(MySQL(),user='genome',db='hg19',host='genome-mysql.cse.ucsc.edu')
allTables=dbListTables(hg19)  ## list of all tabless
dbListFields(hg19,"affyU133Plus2")  #### list of all fields
dbGetQuery(hg19,'select count(*) from affyU133Plus2')  #### gets total number of records
affyData=dbReadTable(hg19,'affyU133Plus2')  #### gets full table
query=dbSendQuery(hg19,'select* from affyU133Plus2 where misMatches between 1 and 3')  ### get subset of data
affyMis=fetch(query,n=10);  ### fetch top ten records
dbClearResult(query); ### clear query 

dbDisconnect(hg19)

#### HDF5
library(rhdf5)
created=h5createFile('example.h5')  ### creates a hdf5 file
h5createGroup('example.h5','foo')   ### creates groups
h5createGroup('example.h5','baa')
h5createGroup('example.h5','foo/foobaa')
h5ls('example.h5')   ### list of groups
A=matrix(1:10,nr=5,nc=2)
h5write(A,'example.h5','foo/A')  ### writing data to a given group
B=array(seq(0.1,2.0, by=0.1),dim=c(5,2,2))
attr(B,'scale')='liter'
h5write(B,'example.h5','foo/foobaa/B')
h5ls('example.h5')

### reading and writing chunks
h5write(c(12,13,14),'example.h5','foo/A',index=list(1:3,1))


### library(httr): main function is GET
url='http://httpbin.org/basic-auth/user/passwd'
html=htmlTreeParse(url,useInternalNodes=1)  ### doesn't work!  Need authentication
html2=GET(url,authenticate('user','passwd'))  ### can use httr methods
content2=content(html2,as='text')

## using handles
google=handle('http://google.com')
pg1=GET(handle=google,path='/')
pg2=GET(handle=google,path='search')

url=handle('http://httpbin.org/basic-auth/user/passwd')
pg1=GET(handle=url,authenticate('user','passwd'))

url=handle('http://httpbin.org/basic-auth/user/passwd',authenticate('user','passwd'))
pg1=GET(handle=url)


##### accessing data from Twitter
library(httr)
library(jsonlite)
### which site
myapp=oauth_app('twitter',key='BBfanePQr1cdmQPV7T2Kp0GoA',secret='GfjQOm43zIuQp82MgtoN5EITaZo0a092grrAzJI0Uy0vkRozni')
#### user name and password to access site
sig=sign_oauth1.0(myapp,token='2447994709-pMpMWo3ENSzRxhkcJJctolLd5vCqak0FnO1ZBzK',token_secret='RhTsjRHo645OMRPeSx9UjCy3myD240aLDxLayPpz8TR0G')
## "searching"
homeTL=GET('http://api.twitter.com/1.1/statuses/home_timeline.json',sig)
## converting json object
json1=content(homeTL) ### a bit hard to read
json2=jsonlite::fromJSON(toJSON(json1))  ### reformatting

### another search
searchTL=GET('https://api.twitter.com/1.1/search/tweets.json?q=coursera&since_id=12345',sig)
json1=content(searchTL) ### a bit hard to read
json2=jsonlite::fromJSON(toJSON(json1))  ### reformatting


###################
#### quiz questions
#######################
### Question 1
library(httr)
library(httpuv)
oauth_endpoints('github')
myapp = oauth_app("github", "694251767b60235b25be","39d123a8ae4d65486e268bf051969bc3ce4942e7")
### get OAuth credentials
github_token = oauth2.0_token(oauth_endpoints("github"), myapp)

### using API
req = GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
a=content(req)
json2=jsonlite::fromJSON(toJSON(a))
json2[json2$name=='datasharing',]['created_at']

###Question 2,3...don't actually need to run anything to see...just think about it
library(sqldf)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv','/Users/jenniferli/Desktop/R/datasciencecoursera/quiz2.csv',method='curl')
acs=read.csv('quiz2.csv')

### Question 4
con=url('http://biostat.jhsph.edu/~jleek/contact.html')  ### make a connection
htmlCode=readLines(con)
close(con)

### Question 5
file='getdata-wksst8110.for'
data=read.fwf(file,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4),skip=4)
sum(data[,4])

