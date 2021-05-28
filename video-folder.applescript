on run {NewProjectFolderPath,NewProjectFolder}
	

	
	set scriptPath to POSIX path of ((path to me as text) & "::")  -- create a variable for the parents folder path  of the actual script
	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	--ZONE IMPORT MEDIAS


	set importMediaFromSet to (display dialog "Import MEDIAS FROM SET in the Project folder ?" buttons {"Cancel", "Yes", "Skip"} default button 2 with icon (iconMediaFromSetPpath of baseVariables))


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

	
	return "le scritp video folder est terminé "
end run