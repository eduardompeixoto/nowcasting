esus<-function(){

devtools::install_github("https://github.com/covid19br/nowcaster")
install.packages("sn")
require(sn)
require(readr)  
srag <- read.csv2("http://sistemas.saude.rj.gov.br/tabnetbd/dash/now_casting_sivep.csv",header = F)
colnames<-c("classi_fin", "dt_digita", "dt_notific", "dt_sin_pri","dt_intern","municipio_res")
colnames(srag)<-colnames

require(nowcaster)

a<-srag



a$reference_date=as.Date(a$dt_intern,"%Y/%m/%d")

a$report_date=as.Date(a$dt_digita, "%Y/%m/%d")

a<-subset(a,is.na(a$dt_digita)==F)
a<-subset(a,is.na(a$dt_sin_pri)==F)

srag_geral<-a
srag_influzenza<-subset(a,a$classi_fin==1)
srag_covid<-subset(a,a$classi_fin==5)
srag_outro_virus<-subset(a,a$classi_fin==2)



nowcasting1 <-
  nowcasting_inla(
    dataset = srag_geral,
    date_onset = "reference_date",
    date_report = "report_date",
    data.by.week = T  )

nowcasting2<-
  nowcasting_inla(
    dataset = srag_covid,
    date_onset = "reference_date",
    date_report = "report_date",
    data.by.week = T  )
nowcasting3 <-
  nowcasting_inla(
    dataset = srag_influzenza,
    date_onset = "reference_date",
    date_report = "report_date",
    data.by.week = T  )

nowcasting4 <-
  nowcasting_inla(
    dataset = srag_outro_virus,
    date_onset = "reference_date",
    date_report = "report_date",
    data.by.week = T  )


###



#####

chik <- read.csv2("http://sistemas.saude.rj.gov.br/tabnetbd/dash/chik.csv",header = F)
colnames<-c( 'dt_digita', 'dt_sin_pri', 'dt_notifica','mun_res' , 'class_fin', 'evolucao')
colnames(chik)<-colnames



chik<-subset(chik,chik$class_fin==13)

a<-chik

a$dt_sin_pri<- paste(substr(a$dt_sin_pri, 1, 4),
                      
                      substr(a$dt_sin_pri, 5, 6) ,
                      
                      substr(a$dt_sin_pri, 7, 8),sep="-" )

a$dt_digita<- paste(substr(a$dt_digita, 1, 4),
                    
                    substr(a$dt_digita, 5, 6) ,
                    
                    substr(a$dt_digita, 7, 8),sep="-" )

a$reference_date=as.Date(a$dt_sin_pri)
a$report_date=as.Date(a$dt_digita)


chik <-
  nowcasting_inla(
    dataset = a,
    date_onset = "reference_date",
    date_report = "report_date",
    data.by.week = T  )


###




dengue <- read.csv2("http://sistemas.saude.rj.gov.br/tabnetbd/dash/dengue.csv",header = F)
colnames<-c( 'dt_digita', 'dt_sin_pri', 'dt_notifica','muni_res', 'class_fin', 'evolucao')
colnames(dengue)<-colnames


dengue<-subset(dengue,dengue$class_fin!=5)


a<-dengue

a$dt_sin_pri<- paste(substr(a$dt_sin_pri, 1, 4),
                     
                     substr(a$dt_sin_pri, 5, 6) ,
                     
                     substr(a$dt_sin_pri, 7, 8),sep="-" )



a$reference_date=as.Date(a$dt_sin_pri)
a$report_date=as.Date(a$dt_digita)


dengue <-
  nowcasting_inla(
    dataset = a,
    date_onset = "reference_date",
    date_report = "report_date",
    data.by.week = T  )



  nowcasting1
  nowcasting2
  nowcasting3
  nowcasting4
  chik
  dengue



}
  
