################################################################################
#                                                                              #
# fed_rates_xml_transform.R                                                    #  
#                                                                              #  
#   transforms an xml file of historical federal interest rates                #  
#                                                                              #
################################################################################

### !!! ### !!! currently this isn't working as intended, but I'm preserving it#
### !!! ### !!! because the functions may be useful to adapt

################################################################################
#                                                                              #
# library() calls                                                              #  
#                                                                              #
################################################################################

library(XML) # interacting with XML files

################################################################################
#                                                                              #
# function definitions                                                         #  
#                                                                              #
################################################################################

save_dataframe <- function(dataframe_to_save,
                           directory_save = "default",
                           name_save){
  # process whether directory is supplied
  if(!(directory_save == "default")){ # directory has been supplied
    # nothing to see here
  }else{                              # use the current working directory
    directory_save <- getwd()
  }
  
  # assemble the complete filepath to save to
  filepath_save <- paste(directory_save,
                         "/",
                         name_save,
                         sep = "")
  
  # save the dataframe
  save(dataframe_to_save,
       file = filepath_save)
}

transform_xml <- function(filepath_xml,
                          flag_save = FALSE,
                          directory_save = "default",
                          name_save = "fed_rates.DATASAVE"){
  # parse the xml source
  data_xml <- xmlParse(filepath_xml)
  
  # transform the parsed data into a list
  data_list <- xmlToList(data_xml)
  
  dataframe_loaded <- xmlToDataFrame(filepath_xml) 
  
  # check save logic
  if(flag_save){    # save the dataframe with the supplied filename
    save_dataframe(dataframe_to_save = dataframe_loaded,
                   directory_save = directory_save,
                   name_save = name_save)
  }
}