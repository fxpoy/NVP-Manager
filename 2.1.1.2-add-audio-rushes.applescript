on run {scriptPath, NewProjectFolderPath, NewProjectFolder}


	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script \n \n",logPath,true) -- anounce to the starting of the scrip



	-- IMPORT AUDIO RUSHES



	set AudioRushesSourceFiles to (choose file with prompt "Please select the original Audio rushes to import in the project folder :" of type {"public.audio"} with multiple selections allowed) -- ask for a selection a files of type : Audio
	baseVariables's write_to_file("var AudioRushesSourceFiles = " & AudioRushesSourceFiles & " \n \n",logPath,true) -- write in log file the value of AudioRushesSourceFiles

	Set AudioRushesDestinationFolderPpath to (NewProjectFolderPath & "/02_MEDIAS FROM SET/AUDIO RUSHES")
	baseVariables's write_to_file("var AudioRushesDestinationFolderPpath = " & AudioRushesDestinationFolderPpath & " \n \n",logPath,true) -- write in log file the value of AudioRushesDestinationFolderPpath

	-- CREATE THE DIRECTORY FOR THE AUDIO RUSHES FOLDER

	do shell script "mkdir -p " & (quoted form of AudioRushesDestinationFolderPpath)


	set AudioRushesDestinationFolderPath to (NewProjectFolder & "02_MEDIAS FROM SET:AUDIO RUSHES") as text -- call to the path of the destination for the files selected  from AudioRushesSourceFiles
	baseVariables's write_to_file("var AudioRushesDestinationFolderPath = " & AudioRushesDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of AudioRushesDestinationFolderPath

	set manipulationAudiofiles to (display dialog "Choose your manipulating finder files for the Audio Rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconSoundFolderPpath of baseVariables)) -- ask for Moving or Duplicating action for the files from AudioRushesSourceFiles

	if button returned of manipulationAudiofiles = "Duplicate files" then
		tell application "Finder"
			duplicate AudioRushesSourceFiles to AudioRushesDestinationFolderPath -- duplicate the files from AudioRushesSourceFiles in the folder AudioRushesDestinationFolderPath
		end tell
	end if

	if button returned of manipulationAudiofiles = "Move files" then
		set confirmationAudioMoving to (display dialog "Confirmation to removing files from " & AudioRushesSourceFiles & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)

		if button returned of confirmationAudioMoving = "Confirm removing" then
			tell application "Finder"
				move AudioRushesSourceFiles to AudioRushesDestinationFolderPath -- moving the files from AudioRushesSourceFiles in the folder AudioRushesDestinationFolderPath
			end tell
		end if

		if button returned of confirmationAudioMoving = "No, duplicate them" then
			tell application "Finder"
				duplicate AudioRushesSourceFiles to AudioRushesDestinationFolderPath -- duplicate the files from AudioRushesSourceFiles in the folder AudioRushesDestinationFolderPath
			end tell
		end if
		
	end if



	-- RUN SCRIPT 2.1.1-add-medias-from-set.applescript 



	set scriptAddMediasFromSetPath to (scriptPath & "2.1.1-add-medias-from-set.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	run script scriptAddMediasFromSetPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder}


end run