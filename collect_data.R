library(Rtinder)

configAccount('MY_FB_REGISTERED_MAIL', 'MY_FB_PASSWORD')
invisible(login())

convert_df_func <- function(ls_0, init_df = data.frame(), label = 'tin')
{
	for (i in ls_0)
	{
		temp = data.frame(tinder_id = i$user[['_id']],username = i$user$name, bio = i$user$bio, birthdate = i$user$birth_date, flag = label, time = as.character(Sys.time()))
		temp$gender = ifelse(is.null(i$user$gender), NA, i$user$gender)
		init_df = rbind(init_df,temp)
	}
	init_df = init_df[!duplicated(init_df$tinder_id),]
	return(init_df)
}

collect_data <- function(df, timer = 90){
	for (i in c(1:60)){
		ls = getSwipes()
		df = convert_df_func(ls, df)
		Sys.sleep(90)
	}
	return(df)
}