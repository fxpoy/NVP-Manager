on run {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}


	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script \n \n",logPath,true) -- anounce to the starting of the scrip



	-- CALL TO FILE MANAGER  MENU



	set FileManageMenuChoiceList to {"add Medias from set", "add Ressources medias", "add Workflow"} -- list of all the choice for New Project Menu

	set FileManageMenuRes to (choose from list FileManageMenuChoiceList with title "FILE MANAGER" with prompt "Choose your Finder actions\n" OK button name {"OK"} cancel button name {"Cancel"})-- create the variable of the choice for the menu
	baseVariables's write_to_file("\n \n  Result of the New Project Menu = " & FileManageMenuRes & " \n \n",logPath,true) -- write the result of the choice of the File Manager menu



	-- RUN SCRIPT 2.1.1-add-medias-from-set.applescript 



	if FileManageMenuRes is {"add Medias from set"} then
		set scriptAddMediasFromSetPath to (scriptPath & "2.1.1-add-medias-from-set.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
		run script scriptAddMediasFromSetPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder}
	end if


	
	-- RUN SCRIPT 2.1.2-add-ressources-media.applescript



	if FileManageMenuRes is {"add Ressources medias"} then
		set scriptAddRessourcesMediasPath to (scriptPath & "2.1.2-add-ressources-medias.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
		run script scriptAddRessourcesMediasPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder}
	end if

	
	-- RUN SCRIPT 2.1.3-add-workflow.applescript



	if FileManageMenuRes is {"add Workflow"} then
		set scriptAddWorkflowPath to (scriptPath & "2.1.3-add-workflow.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
		run script scriptAddWorkflowPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}
	end if



	-- RETURN TO THE MAIN MENU



	set scriptNVPManagerPath to (scriptPath & "/Video-Folder-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	baseVariables's write_to_file(" \n \n call to run the script = " & scriptNVPManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
	run script scriptNVPManagerPath with parameters false


end run
