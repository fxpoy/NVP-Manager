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









	-- TEST -- TO CHOOSE FROM LIST



	-- set projectManagerList to {"add Video rushes", "add Audio rushes", "add RAW photos","add workflow", "add Video ressources", "add Image ressources", "add Audio ressources"}
	-- set actionProjectManager to (choose from list projectManagerList with title "Project Manager" with prompt "Select what do you want to do :" OK button name {"OK"} cancel button name {"Return"}) as text

	-- set res to (display dialog actionProjectManager buttons {"Don't Continue", "Continue"} default button "Continue" cancel button "Don't Continue")







	-- RUN TO CREATE THE NEW PROJECT FOLDER



	set createNewProjectFolder to (display dialog "Hello there! Do you want to create a New Video Project folder ?" buttons {"No","Yes"} default button 2 with icon (iconNVPManagerFolderPpath of baseVariables))
	if button returned of createNewProjectFolder = "No" then

		baseVariables's write_to_file("\n \n -- RUN TO CREATE THE NEW PROJECT FOLDER \n \n exiting app on the display dialog 'Hello there! Do you want to create a New Video Project folder ?' \n \n",logPath,true) -- write in log file the exit of the app "NVP Manager"

		return 
	end if



	--CHOOSE THE CLIENT NAME OF THE VIDEO PROJECT



	set AllClientList to do shell script "find /Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/01_CLIENT_NAME -mindepth 1  -maxdepth 1 -type d -exec basename {} \\; | grep -v 00_ | grep -v Corbeille | sort"
	set AppleScript's text item delimiters to {return & linefeed, return, linefeed, character id 8233, character id 8232}
	set allClientName to (every text item in AllClientList) as list
	baseVariables's write_to_file("\n \n --CHOOSE THE CLIENT NAME OF THE VIDEO PROJECT \n \n var allClientName =\n{" & allClientName & "} \n \n",logPath,true) -- write in log file the value of allClientName

	set clientName to (choose from list allClientName with title "Video project name" with prompt "Select the Client name of the video project :") as text
	baseVariables's write_to_file("var clientName = " & clientName & " \n \n",logPath,true) -- write in log file the value of clientName



	--ASK FOR THE PROJECT NAME



	set projectName to text returned of (display dialog "name of the project :" buttons {"Cancel", "OK"} default button 2 default answer "" with icon (iconRessourcesFolderPpath of baseVariables)) as text
	baseVariables's write_to_file("\n \n --ASK FOR THE PROJECT NAME \n \n var projectName = " & projectName & " \n \n",logPath,true) -- write in log file the value of projectName



	--NAME OF THE GLOBAL PROJECT FOLDER 



	set globalProjectName to clientName & "_" & projectName as text -- concatenation of the two variables : "clientName" and "projectName"
	baseVariables's write_to_file("\n \n --NAME OF THE GLOBAL PROJECT FOLDER \n \n var globalProjectName = " & globalProjectName & " \n \n",logPath,true) -- write in log file the value of globalProjectName



	--ASK FOR THE DIRECTORY OF THE GLOBAL PROJECT FOLDER



	set New_Project_RootFolderDirectory to (choose folder with prompt "Please select the directory of the project folder :") -- user tell the directory of the future new project folder 
	baseVariables's write_to_file("\n \n --ASK FOR THE DIRECTORY OF THE GLOBAL PROJECT FOLDER \n \n var New_Project_RootFolderDirectory = " & New_Project_RootFolderDirectory & " \n \n",logPath,true) -- write in log file the value of New_Project_RootFolderDirectory



	--CREATE THE NEW PROJECT FOLDER



	tell application "Finder"
		make new folder at New_Project_RootFolderDirectory with properties {name:globalProjectName} -- create a new folder at the directory of New_Project_RootFolderDirectory
	end tell

	set New_Project_RootFolderDirectoryText to New_Project_RootFolderDirectory as text -- convert New_Project_RootFolderDirectory to text
	baseVariables's write_to_file("\n \n --CREATE THE NEW PROJECT FOLDER \n \n var New_Project_RootFolderDirectoryText = " & New_Project_RootFolderDirectoryText & " \n \n",logPath,true) -- write in log file the value of New_Project_RootFolderDirectoryText

	set New_Project_RootFolder to New_Project_RootFolderDirectoryText & globalProjectName --concatenation of the two variables "New_Project_RootFolderDirectoryText" and "globalProjectName"
	baseVariables's write_to_file("var New_Project_RootFolder = " & New_Project_RootFolder & " \n \n",logPath,true) -- write in log file the value of New_Project_RootFolder

	set NewProjectFolder to New_Project_RootFolder as text -- convert New_Project_RootFolder to text
	baseVariables's write_to_file("var NewProjectFolder = " & NewProjectFolder & " \n \n",logPath,true) -- write in log file the value of NewProjectFolder


	set NewProjectFolderPath to POSIX path of New_Project_RootFolder -- give the POSIX path of New_Project_RootFolder
	baseVariables's write_to_file("var NewProjectFolderPath = " & NewProjectFolderPath & " \n \n",logPath,true) -- write in log file the value of NewProjectFolderPath



	--IMPORT THE TEMPLATE FOLDERS FROM NAS



	set templateFolderSources to "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/02_TREEFOLDER_VIDEO_PROJECT" -- give the path of templateFolderSources
	baseVariables's write_to_file("\n \n --IMPORT THE TEMPLATE FOLDERS FROM NAS \n \n var templateFolderSources = " & templateFolderSources & " \n \n",logPath,true) -- write in log file the value of templateFolderSources

	set templateFolderSourcesPpath to POSIX file templateFolderSources -- convert in POSIX path templateFolderSources
	baseVariables's write_to_file("var templateFolderSourcesPpath = " & templateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of templateFolderSourcesPpath

	tell application "Finder" to set contentTemplateFolderSourcesPpath to get the entire contents of folder templateFolderSourcesPpath -- give the contents of the folder in the path templateFolderSourcesPpath

	tell application "Finder"
		duplicate contentTemplateFolderSourcesPpath to NewProjectFolder -- duplicate the contents of contentTemplateFolderSourcesPpath in NewProjectFolder 
		baseVariables's write_to_file("Contents of the templateFolderSources duplicate in " & NewProjectFolderPath & " \n \n",logPath,true) -- write in log file the value of templateFolderSources
	end tell



	-- LOAD SCRIPT FOR VIDEO FOLDER



	set videoFolderPath to (scriptPath & "/video-folder.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"

	set importMediaFromSet to (run script videoFolderPath with parameters {NewProjectFolderPath,NewProjectFolder})
	baseVariables's write_to_file("TEST TES tEST  = " & importMediaFromSet & " \n \n",logPath,true) -- write in log file the value of NewProjectFolderPath













	--ZONE CHOOSE WORKFLOW


	set ChooseWorkflow to (display dialog "Choose Workflow(s) for the Project ? " buttons {"Cancel", "Yes", "Skip"} default button 2 with icon (iconAppPpath of baseVariables))

	set ProjectFolder to (NewProjectFolderPath & "/01_PROJECT")


	-- CHOOSE WORKFLOW = YES


	if button returned of ChooseWorkflow = "Yes" then
		
		
		-- ZONE DAVINCI

		
		set DaVinciWorkflow to (display dialog "Will you work on DaVinci Resolve workflow" buttons {"No", "Yes"} default button 2 with icon (iconAppDavinciResolvePpath of baseVariables))
		set DaVinciRessourceFolder to (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO/DaVinci Resolve")
		set DaVinciFolder to (ProjectFolder & "/DaVinci Resolve")
		set DaVinci4Kfile to (DaVinciFolder & "/_00_RESSOURCES_ALGO/Template_4K_UHD_v1.drp")
		set DaVinci1080pfile to (DaVinciFolder & "/_00_RESSOURCES_ALGO/Template_1080p_v1.drp")
		
		
		-- DAVINCI = YES
		
		
		if button returned of DaVinciWorkflow = "Yes" then
			do shell script "mv " & (quoted form of DaVinciRessourceFolder) & " " & (quoted form of ProjectFolder)
			set DaVinciDefworkflow to (display dialog "Choose your timeline resolution for DaVinci Resolve  :" buttons {"1080p", "4K UHD"} default button 2 with icon (iconAppDavinciResolvePpath of baseVariables))
			if button returned of DaVinciDefworkflow = "4K UHD" then
				do shell script "mv " & (quoted form of DaVinci4Kfile) & " " & (quoted form of DaVinciFolder)
			end if
			if button returned of DaVinciDefworkflow = "1080p" then
				do shell script "mv " & (quoted form of DaVinci1080pfile) & " " & (quoted form of DaVinciFolder)
			end if
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/DaVinci Resolve/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/DaVinci Resolve/._00_RESSOURCES_ALGO"))
		end if
		
		
		-- ZONE PREMIERE PRO
		
		
		set PremiereProWorkflow to (display dialog "Will you work on Premiere Pro workflow" buttons {"No", "Yes"} default button 2 with icon (iconAppPremiereProPpath of baseVariables))
		set PremiereProRessourceFolder to (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO/Premiere Pro")
		set PremiereProFolder to (ProjectFolder & "/Premiere Pro")
		set PremiereProfile to (PremiereProFolder & "/_00_RESSOURCES_ALGO/Template_v1.prproj")
		
		
		-- PREMIERE PRO = YES
		
		
		if button returned of PremiereProWorkflow = "Yes" then
			do shell script "mv " & (quoted form of PremiereProRessourceFolder) & " " & (quoted form of ProjectFolder)
			do shell script "mv " & (quoted form of PremiereProfile) & " " & (quoted form of PremiereProFolder)
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/Premiere Pro/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/Premiere Pro/._00_RESSOURCES_ALGO"))
		end if
		
		
		-- ZONE AFTER EFFECT
		
		
		set AfterEffectWorkflow to (display dialog "Will you work on After Effect workflow" buttons {"No", "Yes"} default button 2 with icon (iconAppAfterEffectPpath of baseVariables))
		set AfterEffectRessourceFolder to (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO/After Effect")
		set AfterEffectFolder to (ProjectFolder & "/After Effect")
		set AfterEffectFile to (AfterEffectFolder & "/_00_RESSOURCES_ALGO/Template_v1.aep")
		
		
		-- AFTER EFFECT = YES
		
		
		if button returned of AfterEffectWorkflow = "Yes" then
			do shell script "mv " & (quoted form of AfterEffectRessourceFolder) & " " & (quoted form of ProjectFolder)
			do shell script "mv " & (quoted form of AfterEffectFile) & " " & (quoted form of AfterEffectFolder)
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/After Effect/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/After Effect/._00_RESSOURCES_ALGO"))
		end if
		do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/._00_RESSOURCES_ALGO"))
	end if


	-- CHOOSE WORKFLOW = SKIP


	if button returned of ChooseWorkflow = "Skip" then
		
	end if


	-- CHOOSE WORKFLOW = CANCEL


	if button returned of ChooseWorkflow = "Cancel" then
		
	end if
end run