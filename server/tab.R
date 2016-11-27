lvl<-reactive(unlist(input$check))
output$value <- renderTable({
  inFile<-input$file
  arrayName=input$arrayName
  if (!is.null(inFile) && !is.null(arrayName) && arrayName!=''){
    x=read.csv(inFile$datapath,header = TRUE, sep = ',')
      y<-as.scidb(x,name=arrayName)
      arrayI=scidb(arrayName)
      d=iqdf(arrayI,n = 1)
      array_data=scidb(arrayName)
      attrs=scidb_attributes(array_data)
      #usernames=c("Purva","Manasi","Matthew")
      #passwords=c("pwd1","pwd2","pwd3")
      #arrays=c("stockmarket","weather","crime")
      #userdata<-data.frame(usernames,passwords,arrays)
      #res1 <- as.scidb(userdata,name = "users")
      x=scidb("users")
      fd=iqdf(x)
      username=input$userlabel
      st=fd$arrays[fd$usernames==username]
      st=paste(st,arrayName,sep=';')
      fd$arrays[fd$usernames==username]<-st
      iquery("remove(users)")
      usernames=fd$usernames
      passwords=fd$passwords
      arrays=fd$arrays
      temp<-data.frame(usernames,passwords,arrays)
      x<-as.scidb(temp,name="users")
      
      updateCheckboxGroupInput(session, "check",choices = c(attrs))
      print(iqdf(arrayI,n = 100,prob = 1))
      
  }
  })

#observe({ 
#  inFile<-input$file
#  arrayName=input$arrayName
#  if (!is.null(inFile) && !is.null(arrayName) && arrayName!=''){
#    array_data=scidb(arrayName)
#   attrs=scidb_attributes(array_data)
#    updateCheckboxGroupInput(session, "check",choices = c(attrs))
#    }

#}
#)

output$value1 <- renderPrint(
  {
    dims=input$check
    dims
  }
)

observeEvent(input$redimensionArray,
  {
    dims=input$check
    inFile<-input$file
    arrayName=input$arrayName
    if(!is.null(inFile) && !is.null(dims) && dims!='' && !is.null(arrayName) && arrayName!='')
    {
      x=scidb(arrayName)
      attrs=scidb_attributes(x)
      types1=scidb_types(x)
      df=data.frame(attrs,types1)
      s=""
      count1=nrow(df)-length(dims)
      for(i in 1:nrow(df))
      {
        rw <- df[i,]
        if(match(rw$attrs,dims,nomatch = 0)==0)
        {
          
          s=paste(s,rw$attrs,":",rw$types1)
          if(count1>1)
          {
            s=paste(s,",")
          }
          count1=count1-1
        }
        
        
        }
      
      s1=""
      count2=0
      for(dim1 in dims)
      {
        count2=count2+1
        s1=paste(s1,dim1," = 0:*, 5, 0")
        if(count2<length(dims))
          s1=paste(s1,",")
      }
      s2=""
      s2=paste("<",s,">","[",s1,"]")
      s3=""
      s3=paste("store(redimension(",arrayName,", ",s2,"),temp)")
      iquery(s3)
      s4=paste("remove(",arrayName,")")
      iquery(s4)
      s5=paste("rename(temp,",arrayName,")")
      iquery(s5)
          }
  }
)
  
  