pkgload::load_all()

df_esus <- esus()

save(df_esus, file="inst/nowcast.RData")

commit_message <- paste0("", Sys.time())

writeLines(commit_message, "mensagem-comit.txt")
