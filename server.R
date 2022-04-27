
function(input,output){
  mycon <-dbConnect(SQLite(), "primary_enrollment_sctypesex.db")
  #cropprod.data <- dbConnect(SQLite(),"Primary-School-Data/Data/cropproduction_db.db")
  cropconn <- dbConnect(SQLite(),"cropproduction_db.db")
  #dbListTables(cropprod.data)
  hf.crops <- dbGetQuery(conn=cropconn,statement = "select * from `hf.crop.combined`;")
  #dbListTables(cropprod.data)

  #dbWriteTable(mycon, "primary_enrollment_sctypesex", primary_long)
  #print(dbListTables(mycon))
#primarySchool.df <- dbGetQuery(mycon,statement = "select * from primary_enrollment_sctypesex")
#server <- function(input,output)
  output$primaryschoolplot <- renderPlot({
   primsummary <- primarySchool.df%>%
      group_by(year,gender)%>%
      summarise(total_enrol = sum(enrolment))
      ggplot(primsummary,aes(x = as.character(year),y=total_enrol,group=gender,color=gender))+
      geom_line()+
      ggtitle(label="Primary School Enrollment", subtitle = "For the Year 2017 - 19")+
      labs(x="Year",y= "Enrollment",fill="Gender")+
      theme(plot.title = element_text(hjust = 0.5))+
      theme(plot.subtitle = element_text(hjust = 0.5))
  })
output$primbar <- renderPlot({
  primsummary <- primarySchool.df%>%
    group_by(subcounty,gender,year)%>%
    filter(year==input$year)%>%
    summarise(total_enrol = sum(enrolment))
  ggplot(primsummary,aes(x = subcounty,y=total_enrol,group=gender,fill = gender))+
    geom_col(stat = "identity", position = position_dodge())+
    scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))+ theme_bw()+
    ggtitle(label="Primary School Distribution", subtitle = "Boys and Girls")+
    labs(x="subcounty",y= "Enrollment",fill="Gender")+
    theme(plot.title = element_text(hjust = 0.5))+
    theme(plot.subtitle = element_text(hjust = 0.5))
})
output$primadata <- renderPlotly({
  primsummary <- primarySchool.df%>%
    group_by(schooltype,gender)%>%
    summarise(total_enrol = sum(enrolment))
  
  plot_ly(data = primsummary,x = ~schooltype,y=~total_enrol,type = "bar", color = ~gender, barmode ="group")%>%
  layout(title="Distribution by Subcounty and schooltype",
           xaxis = list(title = "schooltype"),
           yaxis = list(title="Total Enrollment"))
})
# output$foodcropplot <- renderPlot({
#   ggplot(data = cropprod.data,aes(x=subcounty,y=tot.Quantity,fill=crop_type)) +
#     geom_col(position = position_dodge())
output$foodcropplot <- renderPlot({
  horticul <- hf.crops %>%
    group_by(subcounty,crop_type)%>%
    summarise(Total_qty = sum(quantity.MT))
  
  ggplot(horticul, aes(x=subcounty, y=Total_qty, fill=crop_type))+
    geom_col(stat = "identity", position = position_dodge())+
    ggtitle(label="Agriculture Dashboard", subtitle = "Food Production per Subcounty")+
    labs(x="subcounty",y= "quantity.MT ",fill="Gender")+
    theme(plot.title = element_text(hjust = 0.5))+
    theme(plot.subtitle = element_text(hjust = 0.5))
})
}