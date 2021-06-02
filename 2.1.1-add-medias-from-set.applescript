on run {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}


	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script \n \n",logPath,true) -- anounce to the starting of the scrip



	-- CALL TO ADD MEDIA FROM SET MENU



	set addMediaFromSetMenuChoiceList to {"add Video Rushes", "add Audio Rushes", "add RAW Photos"} -- list of all the choice for New Project Menu

	set addMediaFromSetMenuRes to (choose from list addMediaFromSetMenuChoiceList with title "FILE MANAGER" with prompt "Choose your Finder actions\n" OK button name {"OK"} cancel button name {"Cancel"})-- create the variable of the choice for the menu
	baseVariables's write_to_file("\n \n  Result of the  Menu add media from set = " & addMediaFromSetMenuRes & " \n \n",logPath,true) -- write the result of the choice of the ADD MEDIA FROM SET MENU



	-- RUN SCRIPT 2.1.1-add-medias-from-set.applescript 


	if addMediaFromSetMenuRes is {"add Video Rushes"} then
		baseVariables's write_to_file("\n \n  Call to run the script = 2.1.1.1-add-video-rushes.applescript \n \n",logPath,true) -- write the result of the choice of the ADD MEDIA FROM SET MENU
		set scriptAddVideoRushesPath to (scriptPath & "2.1.1.1-add-video-rushes.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
		run script scriptAddVideoRushesPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}
		return
	end if



	-- RUN SCRIPT 2.1.1.2-add-audio-rushes.applescript 



	if addMediaFromSetMenuRes is {"add Audio Rushes"} then
		baseVariables's write_to_file("\n \n  Call to run the script = 2.1.1.2-add-audio-rushes.applescript \n \n",logPath,true) -- write the result of the choice of the ADD MEDIA FROM SET MENU
		set scriptAddAudioRushesPath to (scriptPath & "2.1.1.2-add-audio-rushes.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
		run script scriptAddAudioRushesPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}
		return
	end if



	-- RUN SCRIPT 2.1.1.3-add-raw-photos.applescript 



	if addMediaFromSetMenuRes is {"add RAW Photos"} then
		baseVariables's write_to_file("\n \n  Call to run the script = 2.1.1.3-add-raw-photos.applescript \n \n",logPath,true) -- write the result of the choice of the ADD MEDIA FROM SET MENU
		set scriptAddRawPhotosPath to (scriptPath & "2.1.1.3-add-raw-photos.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
		run script scriptAddRawPhotosPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}
		return
	end if



	-- RUN THE SCRIPT FILES MANAGER



	set scriptFilesManagerPath to (scriptPath & "2.1-Files-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"

	baseVariables's write_to_file(" \n \n call to run the script = " & scriptFilesManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
	run script scriptFilesManagerPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}

	return

end run