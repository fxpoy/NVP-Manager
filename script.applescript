
--now the script is on github TEST 3
-- ceci est un test

-- utiliser chemin relatif pour apperler script (chemin original = chemin ou se trouve le fichier script.applescript)

--RESSOURCES ICON (.icns) ACCES FROM NAS
do shell script "echo coucou"

set iconAppFolder to "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier Application.icns"
set iconAppFolderPpath to POSIX file iconAppFolder as alias

set iconRessourcesFolder to "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier ressources.icns"
set iconRessourcesFolderPpath to POSIX file iconRessourcesFolder as alias

set iconVideoFolder to "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier video.icns"
set iconVideoFolderPpath to POSIX file iconVideoFolder as alias

set iconSoundFolder to "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier Son.icns"
set iconSoundFolderPpath to POSIX file iconSoundFolder as alias

set iconRAWFolder to "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier photo.icns"
set iconRAWFolderPpath to POSIX file iconRAWFolder as alias


--CHOOSE THE CLIENT NAME FOR THE VIDEO PROJECT


set AllClientList to do shell script "find /Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/01_CLIENT_NAME -mindepth 1  -maxdepth 1 -type d -exec basename {} \\; | grep -v 00_ | grep -v Corbeille | sort"
set AppleScript's text item delimiters to {return & linefeed, return, linefeed, character id 8233, character id 8232}
set allClientName to (every text item in AllClientList) as list
set clientName to (choose from list allClientName with title "Video project name" with prompt "Select the Client name of the video project :") as text



--ASK FOR THE PROJECT NAME


set projectName to text returned of (display dialog "name of the project :" buttons {"Cancel", "OK"} default button 2 default answer "" with icon iconRessourcesFolderPpath) as text


--NAME OF THE GLOBAL PROJECT FOLDER 


set globalProjectName to clientName & "_" & projectName as text


-- __MODIF en applescript__


--ASK FOR THE DIRECTORY OF THE GLOBAL PROJECT FOLDER


set New_Project_RootFolderDirectory to (choose folder with prompt "Please select the directory of the project folder :")


--CREATE THE NEW PROJECT FOLDER


tell application "Finder"
	make new folder at New_Project_RootFolderDirectory with properties {name:globalProjectName}
end tell
set New_Project_RootFolderDirectoryText to New_Project_RootFolderDirectory as text
set New_Project_RootFolder to New_Project_RootFolderDirectoryText & globalProjectName
set NewProjectFolder to New_Project_RootFolder as text
set NewProjectFolderPath to POSIX path of New_Project_RootFolder


--IMPORT THE TEMPLATE FOLDERS FROM NAS

set templateFolderSources to "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/02_TREEFOLDER_VIDEO_PROJECT"
set templateFolderSourcesPpath to POSIX file templateFolderSources
tell application "Finder" to set contentTemplateFolderSourcesPpath to get the entire contents of folder templateFolderSourcesPpath
tell application "Finder"
	duplicate contentTemplateFolderSourcesPpath to NewProjectFolder
end tell






--set NewProjectFolder to input as text
--set NewProjectFolderPath to (POSIX path of input)



--ZONE IMPORT MEDIAS


set importMediaFromSet to (display dialog "Import MEDIAS FROM SET in the Project folder ?" buttons {"Cancel", "Yes", "Skip"} default button 2 with icon iconRessourcesFolderPpath)


--IMPORT MEDIAS = YES


if button returned of importMediaFromSet = "Yes" then
	
	
	--ZONE IMPORT VIDEO RUSHES
	
	
	set importVideoRushesStep to (display dialog "Import Video rushes from set in the Project folder ?" buttons {"Yes", "No"} default button 1 with icon iconVideoFolderPpath)
	
	
	-- IMPORT VIDEO RUSHES = YES
	
	
	if button returned of importVideoRushesStep = "Yes" then
		set VideoRushesSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
		set VideoRushesDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:VIDEO RUSHES") as alias
		set manipulationVideofiles to (display dialog "Choose your manipulating finder files for the Video rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon iconVideoFolderPpath)
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
		
		
		set importAudioRushesStep to (display dialog "Import External Audio rushes from set in the Project folder ?" buttons {"Skip Audio and RAW", "Yes", "No"} default button 3 with icon iconSoundFolderPpath)
		
		
		-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = YES
		
		
		
		if button returned of importAudioRushesStep = "Yes" then
			set AudioRushesSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
			set AudioRushesDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:AUDIO RUSHES") as alias
			set manipulationAudiofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon iconSoundFolderPpath)
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
			
			
			set importPhotosStep to (display dialog "Import RAW Photos from set in the Project folder ?" buttons {"Yes", "No"} default button 2 with icon iconRAWFolderPpath)
			
			
			-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = YES //> IMPORT RAW = YES
			
			
			
			if button returned of importPhotosStep = "Yes" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
				set PhotoSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
				set PhotoDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:_RAW PHOTOS") as alias
				set manipulationPhotofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon iconRAWFolderPpath)
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
			
			
			set importPhotosStep to (display dialog "Import RAW Photos from set in the Project folder ?" buttons {"Yes", "No"} default button 1 with icon iconRAWFolderPpath)
			
			
			-- IMPORT VIDEO RUSHES = YES //> IMPORT AUDIO RUSHES = NO //> IMPORT RAW = YES
			
			
			if button returned of importPhotosStep = "Yes" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
				set PhotoSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
				set PhotoDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:_RAW PHOTOS") as alias
				set manipulationPhotofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon iconRAWFolderPpath)
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
		
		
		set importAudioRushesStep to (display dialog "Import External Audio rushes from set in the Project folder ?" buttons {"Skip Audio and RAW", "Yes", "No"} default button 3 with icon iconSoundFolderPpath)
		
		
		--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = YES
		
		
		if button returned of importAudioRushesStep = "Yes" then
			set AudioRushesSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
			set AudioRushesDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:AUDIO RUSHES") as alias
			set manipulationAudiofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon iconSoundFolderPpath)
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
			
			
			set importPhotosStep to (display dialog "Import RAW Photos from set in the Project folder ?" buttons {"Yes", "No"} default button 1 with icon iconRAWFolderPpath)
			
			
			--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = YES //> IMPORT RAW = YES
			
			
			if button returned of importPhotosStep = "Yes" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
				set PhotoSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
				set PhotoDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:_RAW PHOTOS") as alias
				set manipulationPhotofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon iconRAWFolderPpath)
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
			
			
			set importPhotosStep to (display dialog "Import RAW Photos rushes from set in the Project folder ?" buttons {"Yes", "No"} default button 1 with icon iconRAWFolderPpath)
			
			
			--ZONE IMPORT VIDEO RUSHES = NO //> IMPORT AUDIO RUSHES = NO //> IMPORT RAW = YES
			
			
			if button returned of importPhotosStep = "Yes" then
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/._00_RESSOURCES_ALGO"))
				set PhotoSourceFolder to (choose file with prompt "Please select the original Video rushes to import in the project folder :" with multiple selections allowed)
				set PhotoDestinationFolder to (NewProjectFolder & ":02_MEDIAS FROM SET:_RAW PHOTOS") as alias
				set manipulationPhotofiles to (display dialog "Choose your manipulating finder files for the Audio rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon iconRAWFolderPpath)
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


set ChooseWorkflow to (display dialog "Choose Workflow(s) for the Project ? " buttons {"Cancel", "Yes", "Skip"} default button 2 with icon iconAppFolderPpath)

set ProjectFolder to (NewProjectFolderPath & "/01_PROJECT")


-- CHOOSE WORKFLOW = YES


if button returned of ChooseWorkflow = "Yes" then
	
	
	-- ZONE DAVINCI
	
	
	set DaVinciWorkflow to (display dialog "Will you work on DaVinci Resolve workflow" buttons {"No", "Yes"} default button 2 with icon ":Applications:DaVinci Resolve:DaVinci Resolve.app:Contents:Resources:Resolve.icns" as alias)
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
	
	
	set PremiereProWorkflow to (display dialog "Will you work on Premiere Pro workflow" buttons {"No", "Yes"} default button 2 with icon ":Applications:Adobe Premiere Pro 2021:Adobe Premiere Pro 2021.app:Contents:Resources:pr_app_icons.icns" as alias)
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
	
	
	set AfterEffectWorkflow to (display dialog "Will you work on After Effect workflow" buttons {"No", "Yes"} default button 2 with icon ":Applications:Adobe After Effects 2021:Adobe After Effects 2021.app:Contents:Resources:ae_app_stable.icns" as alias)
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

