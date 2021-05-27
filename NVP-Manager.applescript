


--CREATE FONCTION TU USE LOG



on write_to_file(this_data, target_file, append_data)
	try
		set the target_file to the target_file as string
		set the open_target_file to open for access POSIX file target_file with write permission
		if append_data is false then set eof of the open_target_file to 0
		write this_data to the open_target_file starting at eof
	 	close access the open_target_file
 		return true
 	on error
 		try
 			close access file target_file
 		end try
 		return false
	 end try
end write_to_file



-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)



set scriptPath to POSIX path of ((path to me as text) & "::")  -- create a variable for the parents folder path  of the actual script
set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



-- CALL TO WRITE ON THE LOG FILE



set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")

my write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script \n \n",logPath,false) -- anounce to the starting of the scrip



-- RUN TO CREATE THE NEW PROJECT FOLDER



set createNewProjectFolder to (display dialog "Hello there! Do you want to create a New Video Project folder ?" buttons {"No","Yes"} default button 2 with icon (iconNVPManagerFolderPpath of baseVariables))
if button returned of createNewProjectFolder = "No" then

	my write_to_file("\n \n -- RUN TO CREATE THE NEW PROJECT FOLDER \n \n exiting app on the display dialog 'Hello there! Do you want to create a New Video Project folder ?' \n \n",logPath,true) -- write in log file the exit of the app "NVP Manager"

	return 
end if



--CHOOSE THE CLIENT NAME OF THE VIDEO PROJECT



set AllClientList to do shell script "find /Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/01_CLIENT_NAME -mindepth 1  -maxdepth 1 -type d -exec basename {} \\; | grep -v 00_ | grep -v Corbeille | sort"
set AppleScript's text item delimiters to {return & linefeed, return, linefeed, character id 8233, character id 8232}
set allClientName to (every text item in AllClientList) as list
my write_to_file("\n \n --CHOOSE THE CLIENT NAME OF THE VIDEO PROJECT \n \n var allClientName =\n{" & allClientName & "} \n \n",logPath,true) -- write in log file the value of allClientName

set clientName to (choose from list allClientName with title "Video project name" with prompt "Select the Client name of the video project :") as text
my write_to_file("var clientName = " & clientName & " \n \n",logPath,true) -- write in log file the value of clientName



--ASK FOR THE PROJECT NAME



set projectName to text returned of (display dialog "name of the project :" buttons {"Cancel", "OK"} default button 2 default answer "" with icon (iconRessourcesFolderPpath of baseVariables)) as text
my write_to_file("\n \n --ASK FOR THE PROJECT NAME \n \n var projectName = " & projectName & " \n \n",logPath,true) -- write in log file the value of projectName



--NAME OF THE GLOBAL PROJECT FOLDER 



set globalProjectName to clientName & "_" & projectName as text -- concatenation of the two variables : "clientName" and "projectName"
my write_to_file("\n \n --NAME OF THE GLOBAL PROJECT FOLDER \n \n var globalProjectName = " & globalProjectName & " \n \n",logPath,true) -- write in log file the value of globalProjectName



--ASK FOR THE DIRECTORY OF THE GLOBAL PROJECT FOLDER



set New_Project_RootFolderDirectory to (choose folder with prompt "Please select the directory of the project folder :") -- user tell the directory of the future new project folder 
my write_to_file("\n \n --ASK FOR THE DIRECTORY OF THE GLOBAL PROJECT FOLDER \n \n var New_Project_RootFolderDirectory = " & New_Project_RootFolderDirectory & " \n \n",logPath,true) -- write in log file the value of New_Project_RootFolderDirectory



--CREATE THE NEW PROJECT FOLDER



tell application "Finder"
	make new folder at New_Project_RootFolderDirectory with properties {name:globalProjectName} -- create a new folder at the directory of New_Project_RootFolderDirectory
end tell

set New_Project_RootFolderDirectoryText to New_Project_RootFolderDirectory as text -- convert New_Project_RootFolderDirectory to text
my write_to_file("\n \n --CREATE THE NEW PROJECT FOLDER \n \n var New_Project_RootFolderDirectoryText = " & New_Project_RootFolderDirectoryText & " \n \n",logPath,true) -- write in log file the value of New_Project_RootFolderDirectoryText

set New_Project_RootFolder to New_Project_RootFolderDirectoryText & globalProjectName --concatenation of the two variables "New_Project_RootFolderDirectoryText" and "globalProjectName"
my write_to_file("var New_Project_RootFolder = " & New_Project_RootFolder & " \n \n",logPath,true) -- write in log file the value of New_Project_RootFolder

set NewProjectFolder to New_Project_RootFolder as text -- convert New_Project_RootFolder to text
my write_to_file("var NewProjectFolder = " & NewProjectFolder & " \n \n",logPath,true) -- write in log file the value of NewProjectFolder


set NewProjectFolderPath to POSIX path of New_Project_RootFolder -- give the POSIX path of New_Project_RootFolder
my write_to_file("var NewProjectFolderPath = " & NewProjectFolderPath & " \n \n",logPath,true) -- write in log file the value of NewProjectFolderPath




--IMPORT THE TEMPLATE FOLDERS FROM NAS



set templateFolderSources to "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/02_TREEFOLDER_VIDEO_PROJECT" -- give the path of templateFolderSources
my write_to_file("\n \n --IMPORT THE TEMPLATE FOLDERS FROM NAS \n \n var templateFolderSources = " & templateFolderSources & " \n \n",logPath,true) -- write in log file the value of templateFolderSources

set templateFolderSourcesPpath to POSIX file templateFolderSources -- convert in POSIX path templateFolderSources
my write_to_file("var templateFolderSourcesPpath = " & templateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of templateFolderSourcesPpath

tell application "Finder" to set contentTemplateFolderSourcesPpath to get the entire contents of folder templateFolderSourcesPpath -- give the contents of the folder in the path templateFolderSourcesPpath

tell application "Finder"
	duplicate contentTemplateFolderSourcesPpath to NewProjectFolder -- duplicate the contents of contentTemplateFolderSourcesPpath in NewProjectFolder 
	my write_to_file("Contents of the templateFolderSources duplicate in " & NewProjectFolderPath & " \n \n",logPath,true) -- write in log file the value of templateFolderSources
end tell






--set NewProjectFolder to input as text
--set NewProjectFolderPath to (POSIX path of input)



--ZONE IMPORT MEDIAS


set importMediaFromSet to (display dialog "Import MEDIAS FROM SET in the Project folder ?" buttons {"Cancel", "Yes", "Skip"} default button 2 with icon (iconRessourcesFolderPpath of baseVariables))


--IMPORT MEDIAS = YES


if button returned of importMediaFromSet = "Yes" then
	
	
	--ZONE IMPORT VIDEO RUSHES
	
	
	set importVideoRushesStep to (display dialog "Import Video rushes from set in the Project folder ?" buttons {"Yes", "No"} default button 1 with icon (iconVideoFolderPpath of baseVariables))
	
	
	-- IMPORT VIDEO RUSHES = YES
	
	
	if button returned of importVideoRushesStep = "Yes" then
		set VideoRushesSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
		set VideoRushesDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:VIDEO RUSHES") as alias
		set manipulationVideofiles to (display dialog "Choose your manipulating finder files for the Video rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconVideoFolderPpath of baseVariables))
		if button returned of manipulationVideofiles = "Duplicate files" then
			tell application "Finder"
				duplicate VideoRushesSourceFolder to VideoRushesDestinationFolder
			end tell
		end if
		if button returned of manipulationVideofiles = "Move files" then
			set confirmationVideomoving to (display dialog "Confirmation to removing files from " & VideoRushesSourceFolder & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)
			if button returned of confirmationVideomoving = "Confirm removing" then
				tell application "Finder"
					move VideoRushesSourceFolder to VideoRushesDestinationFolder
				end tell
			end if
			if button returned of confirmationVideomoving = "No, duplicate them" then
				tell application "Finder"
					duplicate VideoRushesSourceFolder to VideoRushesDestinationFolder
				end tell
			end if
		end if
		
		
		--ZONE IMPORT VIDEO RUSHES =YES //> ZONE IMPORT AUDIO RUSHES
		
		
		set importAudioRushesStep to (display dialog "Import External Audio rushes from set in the Project folder ?" buttons {"Skip Audio and RAW", "Yes", "No"} default button 3 with icon (iconSoundFolderPpath of baseVariables))
		
		
		-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = YES
		
		
		
		if button returned of importAudioRushesStep = "Yes" then
			set AudioRushesSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
			set AudioRushesDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:AUDIO RUSHES") as alias
			set manipulationAudiofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconSoundFolderPpath of baseVariables))
			if button returned of manipulationAudiofiles = "Duplicate files" then
				tell application "Finder"
					duplicate AudioRushesSourceFolder to AudioRushesDestinationFolder
				end tell
			end if
			if button returned of manipulationAudiofiles = "Move files" then
				set confirmationAudiomoving to (display dialog "Confirmation to removing files from " & AudioRushesSourceFolder & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)
				if button returned of confirmationAudiomoving = "Confirm removing" then
					tell application "Finder"
						move AudioRushesSourceFolder to AudioRushesDestinationFolder
					end tell
				end if
				if button returned of confirmationAudiomoving = "No, duplicate them" then
					tell application "Finder"
						duplicate AudioRushesSourceFolder to AudioRushesDestinationFolder
					end tell
				end if
			end if
			
			
			-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = YES //> ZONE IMPORT RAW
			
			
			set importPhotosStep to (display dialog "Import RAW Photos from set in the Project folder ?" buttons {"Yes", "No"} default button 2 with icon (iconRAWFolderPpath of baseVariables))
			
			
			-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = YES //> IMPORT RAW = YES
			
			
			
			if button returned of importPhotosStep = "Yes" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
				set PhotoSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
				set PhotoDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:_RAW PHOTOS") as alias
				set manipulationPhotofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconRAWFolderPpath of baseVariables))
				if button returned of manipulationPhotofiles = "Duplicate files" then
					tell application "Finder"
						duplicate PhotoSourceFolder to PhotoDestinationFolder
					end tell
				end if
				if button returned of manipulationPhotofiles = "Move files" then
					set confirmationPhotomoving to (display dialog "Confirmation to removing files from " & PhotoSourceFolder & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)
					if button returned of confirmationPhotomoving = "Confirm removing" then
						tell application "Finder"
							move AudioRushesSourceFolder to AudioRushesDestinationFolder
						end tell
					end if
					if button returned of confirmationPhotomoving = "No, duplicate them" then
						tell application "Finder"
							duplicate AudioRushesSourceFolder to AudioRushesDestinationFolder
						end tell
					end if
				end if
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/._00_RESSOURCES_ALGO"))
			end if
			
			
			-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = YES //> IMPORT RAW = NO
			
			
			if button returned of importPhotosStep = "No" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_RAW PHOTOS")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO"))
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/._00_RESSOURCES_ALGO"))
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
			end if
		end if
		
		
		-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = NO
		
		
		if button returned of importAudioRushesStep = "No" then
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/AUDIO RUSHES")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO"))
			
			
			-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = NO //> ZONE IMPORT RAW
			
			
			set importPhotosStep to (display dialog "Import RAW Photos from set in the Project folder ?" buttons {"Yes", "No"} default button 1 with icon (iconRAWFolderPpath of baseVariables))
			
			
			-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = NO //> IMPORT RAW = YES
			
			
			if button returned of importPhotosStep = "Yes" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
				set PhotoSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
				set PhotoDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:_RAW PHOTOS") as alias
				set manipulationPhotofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconRAWFolderPpath of baseVariables))
				if button returned of manipulationPhotofiles = "Duplicate files" then
					tell application "Finder"
						duplicate PhotoSourceFolder to PhotoDestinationFolder
					end tell
				end if
				if button returned of manipulationPhotofiles = "Move files" then
					set confirmationPhotomoving to (display dialog "Confirmation to removing files from " & PhotoSourceFolder & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)
					if button returned of confirmationPhotomoving = "Confirm removing" then
						tell application "Finder"
							move PhotoSourceFolder to PhotoDestinationFolder
						end tell
					end if
					if button returned of confirmationPhotomoving = "No, duplicate them" then
						tell application "Finder"
							duplicate PhotoSourceFolder to PhotoDestinationFolder
						end tell
					end if
				end if
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/._00_RESSOURCES_ALGO"))
			end if
			
			
			-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = NO //> IMPORT RAW = NO
			
			
			if button returned of importPhotosStep = "No" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_RAW PHOTOS")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO"))
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/._00_RESSOURCES_ALGO"))
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
			end if
		end if
		
		
		-- IMPORT VIDEO RUSHES = YES //> SKIP AUDIO AND RAW
		
		
		if button returned of importAudioRushesStep = "Skip Audio and RAW" then
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/AUDIO RUSHES")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO"))
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_RAW PHOTOS")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO"))
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/._00_RESSOURCES_ALGO"))
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
		end if
	end if
	
	
	-- IMPORT VIDEO RUSHES = NO
	
	
	if button returned of importVideoRushesStep = "No" then
		do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/VIDEO RUSHES")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO"))
		
		
		--ZONE IMPORT VIDEO RUSHES = NO //> ZONE IMPORT AUDIO RUSHES
		
		
		set importAudioRushesStep to (display dialog "Import External Audio rushes from set in the Project folder ?" buttons {"Skip Audio and RAW", "Yes", "No"} default button 3 with icon (iconSoundFolderPpath of baseVariables))
		
		
		--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = YES
		
		
		if button returned of importAudioRushesStep = "Yes" then
			set AudioRushesSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
			set AudioRushesDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:AUDIO RUSHES") as alias
			set manipulationAudiofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconSoundFolderPpath of baseVariables))
			if button returned of manipulationAudiofiles = "Duplicate files" then
				tell application "Finder"
					duplicate AudioRushesSourceFolder to AudioRushesDestinationFolder
				end tell
			end if
			if button returned of manipulationAudiofiles = "Move files" then
				set confirmationAudiomoving to (display dialog "Confirmation to removing files from " & AudioRushesSourceFolder & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)
				if button returned of confirmationAudiomoving = "Confirm removing" then
					tell application "Finder"
						move AudioRushesSourceFolder to AudioRushesDestinationFolder
					end tell
				end if
				if button returned of confirmationAudiomoving = "No, duplicate them" then
					tell application "Finder"
						duplicate AudioRushesSourceFolder to AudioRushesDestinationFolder
					end tell
				end if
			end if
			
			
			--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = YES //> ZONE IMPORT RAW
			
			
			set importPhotosStep to (display dialog "Import RAW Photos from set in the Project folder ?" buttons {"Yes", "No"} default button 1 with icon (iconRAWFolderPpath of baseVariables))
			
			
			--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = YES //> IMPORT RAW = YES
			
			
			if button returned of importPhotosStep = "Yes" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
				set PhotoSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
				set PhotoDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:_RAW PHOTOS") as alias
				set manipulationPhotofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconRAWFolderPpath of baseVariables))
				if button returned of manipulationPhotofiles = "Duplicate files" then
					tell application "Finder"
						duplicate PhotoSourceFolder to PhotoDestinationFolder
					end tell
				end if
				if button returned of manipulationPhotofiles = "Move files" then
					set confirmationPhotomoving to (display dialog "Confirmation to removing files from " & PhotoSourceFolder & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)
					if button returned of confirmationPhotomoving = "Confirm removing" then
						tell application "Finder"
							move PhotoSourceFolder to PhotoDestinationFolder
						end tell
					end if
					if button returned of confirmationPhotomoving = "No, duplicate them" then
						tell application "Finder"
							duplicate PhotoSourceFolder to PhotoDestinationFolder
						end tell
					end if
				end if
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/._00_RESSOURCES_ALGO"))
			end if
			
			
			--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = YES //> IMPORT RAW = NO
			
			
			if button returned of importPhotosStep = "No" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/._00_RESSOURCES_ALGO"))
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
			end if
		end if
		
		
		--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = NO
		
		
		if button returned of importAudioRushesStep = "No" then
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/AUDIO RUSHES")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO"))
			
			
			--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = NO //> ZONE IMPORT RAW
			
			
			set importPhotosStep to (display dialog "Import RAW Photos rushes from set in the Project folder ?" buttons {"Yes", "No"} default button 1 with icon (iconRAWFolderPpath of baseVariables))
			
			
			--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = NO //> IMPORT RAW = YES
			
			
			if button returned of importPhotosStep = "Yes" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
				set PhotoSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
				set PhotoDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:_RAW PHOTOS") as alias
				set manipulationPhotofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconRAWFolderPpath of baseVariables))
				if button returned of manipulationPhotofiles = "Duplicate files" then
					tell application "Finder"
						duplicate PhotoSourceFolder to PhotoDestinationFolder
					end tell
				end if
				if button returned of manipulationPhotofiles = "Move files" then
					set confirmationPhotomoving to (display dialog "Confirmation to removing files from " & PhotoSourceFolder & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)
					if button returned of confirmationPhotomoving = "Confirm removing" then
						tell application "Finder"
							move PhotoSourceFolder to PhotoDestinationFolder
						end tell
					end if
					if button returned of confirmationPhotomoving = "No, duplicate them" then
						tell application "Finder"
							duplicate PhotoSourceFolder to PhotoDestinationFolder
						end tell
					end if
				end if
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/._00_RESSOURCES_ALGO"))
			end if
			
			
			--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = NO //> IMPORT RAW = NO
			
			
			if button returned of importPhotosStep = "No" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET")) & " " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO"))
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
				--doit normalement passé à la Cancel
				
			end if
		end if
		
		
		-- IMPORT VIDEO RUSHES = NO //> SKIP AUDIO AND RAW
		
		
		if button returned of importAudioRushesStep = "Skip Audio and RAW" then
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/AUDIO RUSHES")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO"))
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_RAW PHOTOS")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO"))
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET/._00_RESSOURCES_ALGO"))
			do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
		end if
	end if
end if


--IMPORT MEDIAS = SKIP


if button returned of importMediaFromSet = "Skip" then
	do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET")) & " " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO"))
	do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
end if


--CANCEL SCRIPT


if button returned of importMediaFromSet = "Cancel" then
	do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT")) & " " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO"))
	do shell script "mv " & (quoted form of (NewProjectFolderPath & "/02_MEDIAS FROM SET")) & " " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO"))
	do shell script "mv " & (quoted form of (NewProjectFolderPath & "/03_RESSOURCES MEDIAS")) & " " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO"))
	do shell script "mv " & (quoted form of (NewProjectFolderPath & "/ZZ_EXPORTS")) & " " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO"))
	do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
	tell application "New Video Project" to quit
end if


--ZONE CHOOSE WORKFLOW


set ChooseWorkflow to (display dialog "Choose Workflow(s) for the Project ? " buttons {"Cancel", "Yes", "Skip"} default button 2 with icon (iconAppFolderPpath of baseVariables))

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
		set DaVinciDefworkflow to (display dialog "Choose your timeline resolution for DaVinci Resolve  :" buttons {"1080p", "4K UHD"} default button 2 with icon ":Applications:DaVinci Resolve:DaVinci Resolve.app:Contents:Resources:Resolve.icns" as alias)
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
