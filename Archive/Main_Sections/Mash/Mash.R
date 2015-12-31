#-----------------------------------------------------------#
#--------------------------- Mash --------------------------#
#-----------------------------------------------------------#

mash <- function(mashType = "SingleStep"){

if(mashType == "SingleStep"){
        
        # Single Step Mash
        source("~/Github/BK_Brew/Main_Sections/Mash/mashSingleStep.R") 
         mashSchedule <- mashSingleStep()

}else if(mashType == "SingleStep"){
        
        # Two Step Mash
        source("~/Github/BK_Brew/Main_Sections/Mash/mashTwoStep.R")
        mashSchedule <- mashTwoStep()

}else if(mashType == "SingleStep"){

        # Decoction Mash
        source("~/Github/BK_Brew/Main_Sections/Mash/mashDecoction.R")
        mashSchedule <- mashDecoction()

}
        
return(mashSchedule)
}