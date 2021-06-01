on run {scriptPath, NewProjectFolderPath, NewProjectFolder}


	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script \n \n",logPath,true) -- anounce to the starting of the scrip



	-- CALL HSF path for NewProjectFolderPath

	baseVariables's write_to_file("var NewProjectFolder = " & NewProjectFolder & " \n \n",logPath,true) -- write in log file the value of NewProjectFolder

	-- set NewProjectFolderPpath to NewProjectFolderPath as text
	-- baseVariables's write_to_file("var NewProjectFolderPpath = " & NewProjectFolderPpath & " \n \n",logPath,true) -- write in log file the value of NewProjectFolderPpath

	-- set NewProjectFolder to POSIX file NewProjectFolderPpath
	-- baseVariables's write_to_file("var NewProjectFolder = " & NewProjectFolder & " \n \n",logPath,true) -- write in log file the value of NewProjectFolder



	--IMPORT THE TEMPLATE FOLDERS FROM NAS

	set NewProjectFolderPpath to (quoted form of NewProjectFolderPath)

	set templateFolderSources to "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/02_TREEFOLDER_VIDEO_PROJECT" -- give the path of templateFolderSources
	baseVariables's write_to_file("\n \n --IMPORT THE TEMPLATE FOLDERS FROM NAS \n \n var templateFolderSources = " & templateFolderSources & " \n \n",logPath,true) -- write in log file the value of templateFolderSources

	set ProjectTemplateFolderSourcesPath to (quoted form of (templateFolderSources & "/01_PROJECT")) -- call to the path of the "/01_PROJECT" folder
	baseVariables's write_to_file("var ProjectTemplateFolderSourcesPath = " & ProjectTemplateFolderSourcesPath & " \n \n",logPath,true) -- write in log file the value of ProjectTemplateFolderSourcesPath

	set MediasTemplateFolderSourcesPath to (quoted form of (templateFolderSources & "/02_MEDIAS FROM SET"))  -- call to the path of the "/02_MEDIAS FROM SET" folder
	baseVariables's write_to_file("var MediasTemplateFolderSourcesPath = " & MediasTemplateFolderSourcesPath & " \n \n",logPath,true) -- write in log file the value of MediasTemplateFolderSourcesPath

	set RessourcesTemplateFolderSourcesPath to (quoted form of (templateFolderSources & "/03_RESSOURCES MEDIAS"))-- call to the path of the "/03_RESSOURCES MEDIAS" folder
	baseVariables's write_to_file("var RessourcesTemplateFolderSourcesPath = " & RessourcesTemplateFolderSourcesPath & " \n \n",logPath,true) -- write in log file the value of RessourcesTemplateFolderSourcesPath

	set ExportTemplateFolderSourcesPath to (quoted form of (templateFolderSources & "/ZZ_EXPORTS"))-- call to the path of the "/ZZ_EXPORTS" folder
	baseVariables's write_to_file("var ExportTemplateFolderSourcesPath = " & ExportTemplateFolderSourcesPath & " \n \n",logPath,true) -- write in log file the value of ExportTemplateFolderSourcesPath

	do shell script "rsync -r " & ProjectTemplateFolderSourcesPath & " " & NewProjectFolderPpath -- copy ProjectTemplateFolderSourcesPath in the New Project Folder
	do shell script "rsync -r " & MediasTemplateFolderSourcesPath & " " & NewProjectFolderPpath -- copy MediasTemplateFolderSourcesPath in the New Project Folder
	do shell script "rsync -r " & RessourcesTemplateFolderSourcesPath & " " & NewProjectFolderPpath -- copy RessourcesTemplateFolderSourcesPath in the New Project Folder
	do shell script "rsync -r " & ExportTemplateFolderSourcesPath & " " & NewProjectFolderPpath -- copy ExportTemplateFolderSourcesPath in the New Project Folder



	--ZONE IMPORT MEDIAS


	set importMediaFromSet to (display dialog "Import MEDIAS FROM SET in the Project folder ?" buttons {"Cancel", "Yes", "Skip"} default button 2 with icon (iconMediaFromSetPpath of baseVariables)) -- ask for importing media from set


	--IMPORT MEDIAS = YES


	if button returned of importMediaFromSet = "Yes" then
		
		
		--ZONE IMPORT VIDEO RUSHES
		
		
		set importVideoRushesStep to (display dialog "Import Video rushes from set in the Project folder ?" buttons {"Yes", "No"} default button 1 with icon (iconVideoFolderPpath of baseVariables)) -- ask for importing Video rushes from set 
		
		
		-- IMPORT VIDEO RUSHES = YES
		
		
		if button returned of importVideoRushesStep = "Yes" then


			set VideoRushesSourceFiles to (choose file with prompt "Please select the original Video rushes to import in the project folder :" of type {"public.movie"} with multiple selections allowed) -- ask for a selection a files of type : video
			baseVariables's write_to_file("var VideoRushesSourceFiles = " & VideoRushesSourceFiles & " \n \n",logPath,true) -- write in log file the value of VideoRushesSourceFiles


			set VideoRushesDestinationFolderPath to (NewProjectFolder & "02_MEDIAS FROM SET:VIDEO RUSHES") as text -- call to the path of the destination for the files selected  from VideoRushesSourceFiles
			baseVariables's write_to_file("var VideoRushesDestinationFolderPath = " & VideoRushesDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of VideoRushesDestinationFolderPath

			set manipulationVideofiles to (display dialog "Choose your manipulating finder files for the Video rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconVideoFolderPpath of baseVariables)) -- ask for Moving or Duplicating action for the files from VideoRushesSourceFiles

			if button returned of manipulationVideofiles = "Duplicate files" then
				tell application "Finder"
					duplicate VideoRushesSourceFiles to VideoRushesDestinationFolderPath -- duplicate the files from VideoRushesSourceFiles in the folder VideoRushesDestinationFolderPath
				end tell
			end if

			if button returned of manipulationVideofiles = "Move files" then
				set confirmationVideomoving to (display dialog "Confirmation to removing files from " & VideoRushesSourceFiles & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)

				if button returned of confirmationVideomoving = "Confirm removing" then
					tell application "Finder"
						move VideoRushesSourceFiles to VideoRushesDestinationFolderPath -- moving the files from VideoRushesSourceFiles in the folder VideoRushesDestinationFolderPath
					end tell
				end if

				if button returned of confirmationVideomoving = "No, duplicate them" then
					tell application "Finder"
						duplicate VideoRushesSourceFiles to VideoRushesDestinationFolderPath -- duplicate the files from VideoRushesSourceFiles in the folder VideoRushesDestinationFolderPath
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


end run
