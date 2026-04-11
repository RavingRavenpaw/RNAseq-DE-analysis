# This is all from CHatGPT and hasn't been checked yet - fair warning!

config_file <- file.path("config", "local_paths.R")

if (!file.exists(config_file)) {
  dir.create("config", showWarnings = FALSE, recursive = TRUE)
  
  # Create the file first
  file.create(config_file)
  
  message("No local data-path config was found.")
  message("Please select or enter the folder where this machine's analysis data lives.")
  
  if (requireNamespace("rstudioapi", quietly = TRUE) &&
      rstudioapi::isAvailable()) {
    
    data_dir <- rstudioapi::selectDirectory(
      caption = "Select the RNA-seq data directory"
    )
    
  } else {
    
    data_dir <- readline("Enter full path to RNA-seq data directory: ")
    
  }
  
  if (!nzchar(data_dir)) {
    stop("No directory selected/entered. Setup cancelled.")
  }
  
  data_dir <- normalizePath(data_dir, winslash = "/", mustWork = FALSE)
  
  writeLines(
    sprintf('data_dir <- "%s"', data_dir),
    con = config_file
  )
  
  message("Created config/local_paths.R and saved data_dir.")
}

source(config_file)