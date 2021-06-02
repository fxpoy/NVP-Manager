on run {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}


	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script \n \n",logPath,true) -- anounce to the starting of the scrip



	-- CALL TO ADD WORKFLOW MENU



	set addWorkflowMenuChoiceList to {"add DaVinci Resolve workflow", "add Premiere Pro workflow", "add After Effect workflow"} -- list of all the choice for New Project Menu

	set addWorkflowMenuRes to (choose from list addWorkflowMenuChoiceList with title "FILE MANAGER" with prompt "Choose your Workflow\n" OK button name {"OK"} cancel button name {"Cancel"})-- create the variable of the choice for the menu
	baseVariables's write_to_file("\n \n  Result of the  Menu add workflow = " & addWorkflowMenuRes & " \n \n",logPath,true) -- write the result of the choice of the ADD WORKFLOW MENU



	-- RUN SCRIPT 2.1.3.1-add-DaVinci-Resolve-Workflow.applescript 


	if addWorkflowMenuRes is {"add DaVinci Resolve workflow"} then
		baseVariables's write_to_file("\n \n  Call to run the script = 2.1.3.1-add-DaVinci-Resolve-Workflow.applescript \n \n",logPath,true) -- write the result of the choice of the ADD MEDIA FROM SET MENU
		set scriptAddDavinciResolveWorkflowPath to (scriptPath & "2.1.3.1-add-DaVinci-Resolve-Workflow.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
		run script scriptAddDavinciResolveWorkflowPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}
	end if



	-- RUN THE SCRIPT FILES MANAGER



	set scriptFilesManagerPath to (scriptPath & "2.1-Files-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"

	baseVariables's write_to_file(" \n \n call to run the script = " & scriptFilesManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
	run script scriptFilesManagerPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}



end run