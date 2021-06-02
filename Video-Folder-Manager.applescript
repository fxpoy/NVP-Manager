on run {firstRun}
	
	-- TO MAKE IT COMPATIBLE WITH SUBLIME TEXT (CONVERT STRING IN BOOLEAN)

	if firstRun is "true" then
		set firstRun to true
	end if


	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)
	-- ceci est un test


	set scriptPath to POSIX path of ((path to me as text) & "::")  -- create a variable for the parents folder path  of the actual script
	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script \n \n",logPath,not firstRun) -- anounce to the starting of the scrip






	-- CALL TO MAIN MENU

	set mainMenuChoiceList to {"CREATE NEW PROJECT", "MANAGE EXISTING PROJECT"} -- list of all the choice for Main Menu

	set mainMenuRes to (choose from list mainMenuChoiceList with title "NVP Manager" with prompt "Would you like to CREATE a New Project folder or MANAGE an Existing Project\n" OK button name {"OK"} cancel button name {"Cancel"})-- create the variable of the choice for the Main menu
	baseVariables's write_to_file("\n \n -- CALL TO MAIN MENU \n \n Result of Main Menu = " & mainMenuRes & " \n \n",logPath,true) -- write the result of the choice of the main menu



	-- CALL TO RUN THE SCRIPT "1.1-Create-New-Project.applescript"



	if mainMenuRes is {"CREATE NEW PROJECT"} then
		

		set scriptCreateNewProjectPath to (scriptPath & "1.1-Create-New-Project.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
		
		baseVariables's write_to_file(" \n \n call to run the script = " & scriptCreateNewProjectPath & "  \n \n",logPath,true) -- write in log file the calling script
		run script scriptCreateNewProjectPath with parameters {scriptPath}

		return

	end if



	-- CHOOSE BETWIN UPDATE OR CLONE EXISTING PROJECT



	if mainMenuRes is {"MANAGE EXISTING PROJECT"} then
		set resMenuExistingProject to (display dialog "Would you like to UPDATE an existing project or CLONE an existing project?"buttons {"Return", "CLONE Project", "UPDATE Project"} default button 3 with icon (iconNVPManagerFolderPpath of baseVariables))
		baseVariables's write_to_file("\n \n  Result of Menu 'EXISTING MENU' = " & resMenuExistingProject & " \n \n",logPath,true) -- write the result of the choice of the Menu Existing Project


		if button returned of resMenuExistingProject = "UPDATE Project" then


			return
		end if

		if button returned of resMenuExistingProject = "CLONE Project" then
			
			return
		end if

		
	end if

	return


end run