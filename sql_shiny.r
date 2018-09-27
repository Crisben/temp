busq_1 <- reactive(paste("'",unlist(strsplit(gsub(" ", "",input$ruc), ",")),"'", sep="",collapse = ","))

resultado_1 <- eventReactive(input$goButton,{
        query <- paste0("select DISTINCT * from f_generarAccionistas(array[",busq_1(),"])")
        db <- dbConnect(PostgreSQL(), dbname = "jodfxi", host = "172.111.111.111",
                port = 5432, user = "ppppppp",
                password = "jpppppppp")
        
        script<-sqlInterpolate(db, query)
        resultado <- tryCatch({
                dbGetQuery(db, script)
                },
                error=function(e) {
                        NULL
                        },
                warning=function(w) {
                        NULL
                })
dbDisconnect(db)
resultado <- resultado %>% filter(nchar(ruc)>0)
resultado
})
