


On run {scriptPath}
	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script \n \n",logPath,true) -- anounce to the starting of the scrip



	--CHOOSE THE CLIENT NAME OF THE VIDEO PROJECT



	set AllClientList to do shell script "find /Volumes/ECOMMERCE/VIDEO_PROJECT -mindepth 1  -maxdepth 1 -type d -exec basename {} \\; | grep -v .00_ | grep -v Corbeille | sort"
	set AppleScript's text item delimiters to {return & linefeed, return, linefeed, character id 8233, character id 8232}
	set allClientName to (every text item in AllClientList) as list
	baseVariables's write_to_file("\n \n --CHOOSE THE CLIENT NAME OF THE VIDEO PROJECT \n \n var allClientName =\n{" & allClientName & "} \n \n",logPath,true) -- write in log file the value of allClientName

	set clientName to (choose from list allClientName with title "Video project name" with prompt "Select the Client name of the video project : " OK button name {"OK"} cancel button name {"Create new Client Folder"}) as text -- call for the name of the new project
	baseVariables's write_to_file("var clientName = " & clientName & " \n \n",logPath,true) -- write in log file the value of clientName



	-- IF DOESN'T EXIST CLIENT FOLDER IN NAS ECOMMERCE CREATE NEW FOLDER ON IT



	if allClientName does not contain clientName
		set ClientNameMenu to (display dialog "name of the New Client Folder :" buttons {"Cancel", "OK"} default button 2 default answer "" with icon (iconRessourcesFolderPpath of baseVariables)) -- set a var to the menu Name of new client folder

		if button returned of ClientNameMenu = "Cancel"
			-- RETURN TO THE MAIN MENU
			set scriptNVPManagerPath to (scriptPath & "/Video-Folder-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
			baseVariables's write_to_file(" \n \n call to run the script = " & scriptNVPManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
			run script scriptNVPManagerPath with parameters false
			return
		end if

		set clientName to text returned of ClientNameMenu as text -- call for the name of the new client folder
	end if
	baseVariables's write_to_file("var clientName = " & clientName & " \n \n",logPath,true) -- write in log file the value of clientName


	--ASK FOR THE PROJECT NAME



	set projectNameMenu to (display dialog "name of the PROJECT :" buttons {"Cancel", "OK"} default button 2 default answer "" with icon (iconRessourcesFolderPpath of baseVariables)) -- set a var to the menu Name of the Project

	if button returned of projectNameMenu = "Cancel"
		-- RETURN TO THE MAIN MENU
		set scriptNVPManagerPath to (scriptPath & "/Video-Folder-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
		baseVariables's write_to_file(" \n \n call to run the script = " & scriptNVPManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
		run script scriptNVPManagerPath with parameters false
		return
	end if

	set projectName to text returned of projectNameMenu as text -- call for the name of the new project
	baseVariables's write_to_file("\n \n --ASK FOR THE PROJECT NAME \n \n var projectName = " & projectName & " \n \n",logPath,true) -- write in log file the value of projectName



	--NAME OF THE GLOBAL PROJECT FOLDER 



	set globalProjectName to clientName & "-" & projectName as text -- concatenation of the two variables : "clientName" and "projectName"
	baseVariables's write_to_file("\n \n --NAME OF THE GLOBAL PROJECT FOLDER \n \n var globalProjectName = " & globalProjectName & " \n \n",logPath,true) -- write in log file the value of globalProjectName



	-- CALL TO NEW PROJECT MENU



	set newPojectMenuChoiceList to {"Create on LOCAL", "Create on ECOMMERCE NAS", "Create on EXTERNAL VOLUME"} -- list of all the choice for New Project Menu

	set newPojectMenuRes to (choose from list newPojectMenuChoiceList with title "CREATE NEW PROJECT" with prompt "Where do you want to CREATE a New Project folder?\n" OK button name {"OK"} cancel button name {"Return"})-- create the variable of the choice for the Main menu
	baseVariables's write_to_file("\n \n  Result of the New Project Menu = " & newPojectMenuRes & " \n \n",logPath,true) -- write the result of the choice of the main menu



	-- CALL TO CREATE ON LOCAL



	if newPojectMenuRes is {"Create on LOCAL"} then

		-- CALL FOR THE DIRECTORY OF THE GLOBAL PROJECT FOLDER

		set rootNameUsers to POSIX path of (path to home folder) -- call the path of the Users Home folder
		set rootDirFolder to rootNameUsers & "Documents/ECOMMERCE/VIDEO_PROJECT" -- call to the Local directory of global video project folder

		set NewProjectFolderPath to (rootDirFolder & "/" & clientName & "/" & globalProjectName) -- call to the directory of the futur new project folder
		baseVariables's write_to_file("\n \n  path of the future New Project Folder = " & NewProjectFolderPath & " \n \n",logPath,true) -- write the result of the choice of the main menu


		set NewProjectFolder to POSIX file NewProjectFolderPath
		baseVariables's write_to_file("\n \n  var NewProjectFolder = " & NewProjectFolder & " \n \n",logPath,true) 

		-- VERIFY IF PROJECT FOLDER DOESN'T EXIST

		set NewProjectFolderPathAsText to NewProjectFolder as text

		tell application "System Events"
			if (exists (folder NewProjectFolderPathAsText)) then

				display dialog "the project " & globalProjectName & "already exist in this directory!"  buttons {"OK"} default button 1 with icon 2

				-- RETURN TO THE MAIN MENU

				set scriptNVPManagerPath to (scriptPath & "/Video-Folder-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
				baseVariables's write_to_file(" \n \n call to run the script = " & scriptNVPManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
				run script scriptNVPManagerPath with parameters false
				return
				
			else

				-- CREATE NEW PROJECT FOLDER TO THE DIRECTORY

				do shell script "mkdir -p " & (quoted form of NewProjectFolderPath) -- Create the New Porject Folder

			end if
		end tell

		--IMPORT EXPORT TEMPLATE FOLDERS FROM NAS

		set ExportTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:ZZ_EXPORTS") as text -- call to the path of the "/ZZ_EXPORTS" folder
		baseVariables's write_to_file("var ExportTemplateFolderSourcesPpath = " & ExportTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of ExportTemplateFolderSourcesPpath

		tell application "Finder"
			duplicate ExportTemplateFolderSourcesPpath to NewProjectFolder
		end tell 

		-- RUN THE SCRIPT FILES MANAGER

		set scriptFilesManagerPath to (scriptPath & "2.1-Files-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"

		baseVariables's write_to_file(" \n \n call to run the script = " & scriptFilesManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
		run script scriptFilesManagerPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}

		return

	end if



	-- CALL TO CREATE ON ECOMMERCE NAS



	if newPojectMenuRes is {"Create on ECOMMERCE NAS"} then
		
		-- CALL FOR THE DIRECTORY OF THE GLOBAL PROJECT FOLDER

		set rootDirFolder to "/Volumes/ECOMMERCE/VIDEO_PROJECT" -- call to the Local directory of global video project folder

		set NewProjectFolderPath to (rootDirFolder & "/" & clientName & "/" & globalProjectName) -- call to the directory of the futur new project folder
		baseVariables's write_to_file("\n \n  path of the future New Project Folder = " & NewProjectFolderPath & " \n \n",logPath,true) -- write the result of the choice of the main menu


		set NewProjectFolder to POSIX file NewProjectFolderPath
		baseVariables's write_to_file("\n \n  var NewProjectFolder = " & NewProjectFolder & " \n \n",logPath,true) 

		-- VERIFY IF PROJECT FOLDER DOESN'T EXIST

		set NewProjectFolderPathAsText to NewProjectFolder as text

		tell application "System Events"
			if (exists (folder NewProjectFolderPathAsText)) then

				display dialog "the project " & globalProjectName & "already exist in this directory!"  buttons {"OK"} default button 1 with icon 2

				-- RETURN TO THE MAIN MENU

				set scriptNVPManagerPath to (scriptPath & "/Video-Folder-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
				baseVariables's write_to_file(" \n \n call to run the script = " & scriptNVPManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
				run script scriptNVPManagerPath with parameters false
				return
				
			else

				-- CREATE NEW PROJECT FOLDER TO THE DIRECTORY

				do shell script "mkdir -p " & (quoted form of NewProjectFolderPath) -- Create the New Porject Folder

			end if
		end tell
		--IMPORT EXPORT TEMPLATE FOLDERS FROM NAS

		set ExportTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:ZZ_EXPORTS") as text -- call to the path of the "/ZZ_EXPORTS" folder
		baseVariables's write_to_file("var ExportTemplateFolderSourcesPpath = " & ExportTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of ExportTemplateFolderSourcesPpath

		tell application "Finder"
			duplicate ExportTemplateFolderSourcesPpath to NewProjectFolder
		end tell 

		-- RUN THE SCRIPT FILES MANAGER

		set scriptFilesManagerPath to (scriptPath & "2.1-Files-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"

		baseVariables's write_to_file(" \n \n call to run the script = " & scriptFilesManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
		run script scriptFilesManagerPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}
		return

	end if



	-- CALL TO CREATE ON EXTERNAL VOLUMES



	if newPojectMenuRes is {"Create on EXTERNAL VOLUME"} then

		set AllVolumesList to do shell script "find /Volumes -mindepth 1  -maxdepth 1 -type d -exec basename {} \\; | grep -v ECOMMERCE | grep -v Corbeille | sort"
		set AppleScript's text item delimiters to {return & linefeed, return, linefeed, character id 8233, character id 8232}
		set allvolumesName to (every text item in AllVolumesList) as list
		baseVariables's write_to_file("\n \n --CHOOSE THE VOLUMES NAME \n \n var allvolumesName =\n{" & allvolumesName & "} \n \n",logPath,true) -- write in log file the value of allvolumesName

		set volumesName to (choose from list allvolumesName with title "Video project name" with prompt "Select the Volumes fot where will be create the new video project : " OK button name {"OK"} cancel button name {"Cancel"}) as text -- call for the name of the new project
		baseVariables's write_to_file("var volumesName = " & volumesName & " \n \n",logPath,true) -- write in log file the value of volumesName

		set rootDirFolderPpath to (volumesName & ":ECOMMERCE:VIDEO_PROJECT")
		baseVariables's write_to_file("var rootDirFolderPpath = " & rootDirFolderPpath & " \n \n",logPath,true) -- write in log file the value of rootDirFolderPpath

		set rootDirFolder to POSIX path of rootDirFolderPpath  -- call to the Local directory of global video project folder
		baseVariables's write_to_file("var rootDirFolder = " & rootDirFolder & " \n \n",logPath,true) -- write in log file the value of rootDirFolder

		set NewProjectFolderPath to (rootDirFolder & "/" & clientName & "/" & globalProjectName) -- call to the directory of the futur new project folder
		baseVariables's write_to_file("\n \n  path of the future New Project Folder = " & NewProjectFolderPath & " \n \n",logPath,true) -- write the result of the choice of the main menu


		set NewProjectFolder to POSIX file NewProjectFolderPath
		baseVariables's write_to_file("\n \n  var NewProjectFolder = " & NewProjectFolder & " \n \n",logPath,true) 

		-- VERIFY IF PROJECT FOLDER DOESN'T EXIST

		set NewProjectFolderPathAsText to NewProjectFolder as text

		tell application "System Events"
			if (exists (folder NewProjectFolderPathAsText)) then

				display dialog "the project " & globalProjectName & "already exist in this directory!"  buttons {"OK"} default button 1 with icon 2

				-- RETURN TO THE MAIN MENU

				set scriptNVPManagerPath to (scriptPath & "/Video-Folder-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
				baseVariables's write_to_file(" \n \n call to run the script = " & scriptNVPManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
				run script scriptNVPManagerPath with parameters false
				return
				
			else

				-- CREATE NEW PROJECT FOLDER TO THE DIRECTORY

				do shell script "mkdir -p " & (quoted form of NewProjectFolderPath) -- Create the New Porject Folder

			end if
		end tell
		--IMPORT EXPORT TEMPLATE FOLDERS FROM NAS

		set ExportTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:ZZ_EXPORTS") as text -- call to the path of the "/ZZ_EXPORTS" folder
		baseVariables's write_to_file("var ExportTemplateFolderSourcesPpath = " & ExportTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of ExportTemplateFolderSourcesPpath

		tell application "Finder"
			duplicate ExportTemplateFolderSourcesPpath to NewProjectFolder
		end tell 

		-- RUN THE SCRIPT FILES MANAGER

		set scriptFilesManagerPath to (scriptPath & "2.1-Files-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"

		baseVariables's write_to_file(" \n \n call to run the script = " & scriptFilesManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
		run script scriptFilesManagerPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}
		return


	end if



	-- RETURN TO THE MAIN MENU



	set scriptNVPManagerPath to (scriptPath & "/Video-Folder-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	baseVariables's write_to_file(" \n \n call to run the script = " & scriptNVPManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
	run script scriptNVPManagerPath with parameters false

	return

end run
