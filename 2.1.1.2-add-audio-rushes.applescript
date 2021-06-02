on run {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}


	
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


	set MediaFromSetDestinationFolderPath to (NewProjectFolder & "02_MEDIAS FROM SET") as text -- call to the path of the destination for the files selected  from AudioRushesSourceFiles
	baseVariables's write_to_file("var MediaFromSetDestinationFolderPath = " & MediaFromSetDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of MediaFromSetDestinationFolderPath


	set AudioRushesDestinationFolderPath to (NewProjectFolder & "02_MEDIAS FROM SET:AUDIO RUSHES") as text -- call to the path of the destination for the files selected  from AudioRushesSourceFiles
	baseVariables's write_to_file("var AudioRushesDestinationFolderPath = " & AudioRushesDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of AudioRushesDestinationFolderPath

	set manipulationAudiofiles to (display dialog "Choose your manipulating finder files for the Audio Rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconSoundFolderPpath of baseVariables)) -- ask for Moving or Duplicating action for the files from AudioRushesSourceFiles

	if button returned of manipulationAudiofiles = "Duplicate files" then

		-- VERIFY THE EXISTING PATH FOR THE DESTINATION FOLDER
		
		tell application "Finder"
			if (exists (folder MediaFromSetDestinationFolderPath)) then
				if (exists (folder AudioRushesDestinationFolderPath)) then
				
					tell application "Finder"
					    repeat with f in (get items of AudioRushesSourceFiles)
					        if not (exists file (name of f) of folder AudioRushesDestinationFolderPath) then
					            duplicate f to folder AudioRushesDestinationFolderPath without replacing
					        end if
					    end repeat
					end tell

				else
					set AudioRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:AUDIO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var AudioRushesTemplateFolderSourcesPpath = " & AudioRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of AudioRushesTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate AudioRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
					end tell

					tell application "Finder"
						duplicate AudioRushesSourceFiles to AudioRushesDestinationFolderPath without replacing-- duplicate the files from AudioRushesSourceFiles in the folder AudioRushesDestinationFolderPath
					end tell

					tell application "Finder"
					    repeat with f in (get items of AudioRushesSourceFiles)
					        if not (exists file (name of f) of folder AudioRushesDestinationFolderPath) then
					            duplicate f to folder AudioRushesDestinationFolderPath without replacing
					        end if
					    end repeat
					end tell

				end if
			else
				set MediaFromSetTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:02_MEDIAS FROM SET") as text -- call to the path of the "/ZZ_EXPORTS" folder
				baseVariables's write_to_file("var MediaFromSetTemplateFolderSourcesPpath = " & MediaFromSetTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of MediaFromSetTemplateFolderSourcesPpath

				tell application "Finder"
					duplicate MediaFromSetTemplateFolderSourcesPpath to NewProjectFolder
				end tell

				set AudioRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:AUDIO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
				baseVariables's write_to_file("var AudioRushesTemplateFolderSourcesPpath = " & AudioRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of AudioRushesTemplateFolderSourcesPpath

				tell application "Finder"
					duplicate AudioRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
				end tell

				tell application "Finder"
					duplicate AudioRushesSourceFiles to AudioRushesDestinationFolderPath without replacing-- duplicate the files from AudioRushesSourceFiles in the folder AudioRushesDestinationFolderPath
				end tell

			end if
		end tell
	end if

	if button returned of manipulationAudiofiles = "Move files" then
		set confirmationAudioMoving to (display dialog "Confirmation to removing files from " & AudioRushesSourceFiles & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)

		if button returned of confirmationAudioMoving = "Confirm removing" then
			
			-- VERIFY THE EXISTING PATH FOR THE DESTINATION FOLDER
		
			tell application "Finder"
				if (exists (folder MediaFromSetDestinationFolderPath)) then
					if (exists (folder AudioRushesDestinationFolderPath)) then
					
						tell application "Finder"
						    repeat with f in (get items of AudioRushesSourceFiles)
						        if not (exists file (name of f) of folder AudioRushesDestinationFolderPath) then
						            move f to folder AudioRushesDestinationFolderPath without replacing
						        end if
						    end repeat
						end tell

					else
						set AudioRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:AUDIO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
						baseVariables's write_to_file("var AudioRushesTemplateFolderSourcesPpath = " & AudioRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of AudioRushesTemplateFolderSourcesPpath

						tell application "Finder"
							duplicate AudioRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
						end tell

						tell application "Finder"
							duplicate AudioRushesSourceFiles to AudioRushesDestinationFolderPath without replacing-- duplicate the files from AudioRushesSourceFiles in the folder AudioRushesDestinationFolderPath
						end tell

						tell application "Finder"
						    repeat with f in (get items of AudioRushesSourceFiles)
						        if not (exists file (name of f) of folder AudioRushesDestinationFolderPath) then
						            move f to folder AudioRushesDestinationFolderPath without replacing
						        end if
						    end repeat
						end tell

					end if
				else
					set MediaFromSetTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:02_MEDIAS FROM SET") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var MediaFromSetTemplateFolderSourcesPpath = " & MediaFromSetTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of MediaFromSetTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate MediaFromSetTemplateFolderSourcesPpath to NewProjectFolder
					end tell

					set AudioRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:AUDIO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var AudioRushesTemplateFolderSourcesPpath = " & AudioRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of AudioRushesTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate AudioRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
					end tell

					tell application "Finder"
						move AudioRushesSourceFiles to AudioRushesDestinationFolderPath without replacing-- duplicate the files from AudioRushesSourceFiles in the folder AudioRushesDestinationFolderPath
					end tell

				end if
			end tell
		end if

		if button returned of confirmationAudioMoving = "No, duplicate them" then
			
			-- VERIFY THE EXISTING PATH FOR THE DESTINATION FOLDER
		
			tell application "Finder"
				if (exists (folder MediaFromSetDestinationFolderPath)) then
					if (exists (folder AudioRushesDestinationFolderPath)) then
					
						tell application "Finder"
						    repeat with f in (get items of AudioRushesSourceFiles)
						        if not (exists file (name of f) of folder AudioRushesDestinationFolderPath) then
						            duplicate f to folder AudioRushesDestinationFolderPath without replacing
						        end if
						    end repeat
						end tell

					else
						set AudioRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:AUDIO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
						baseVariables's write_to_file("var AudioRushesTemplateFolderSourcesPpath = " & AudioRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of AudioRushesTemplateFolderSourcesPpath

						tell application "Finder"
							duplicate AudioRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
						end tell

						tell application "Finder"
							duplicate AudioRushesSourceFiles to AudioRushesDestinationFolderPath without replacing-- duplicate the files from AudioRushesSourceFiles in the folder AudioRushesDestinationFolderPath
						end tell

						tell application "Finder"
						    repeat with f in (get items of AudioRushesSourceFiles)
						        if not (exists file (name of f) of folder AudioRushesDestinationFolderPath) then
						            duplicate f to folder AudioRushesDestinationFolderPath without replacing
						        end if
						    end repeat
						end tell

					end if
				else
					set MediaFromSetTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:02_MEDIAS FROM SET") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var MediaFromSetTemplateFolderSourcesPpath = " & MediaFromSetTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of MediaFromSetTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate MediaFromSetTemplateFolderSourcesPpath to NewProjectFolder
					end tell

					set AudioRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:AUDIO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var AudioRushesTemplateFolderSourcesPpath = " & AudioRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of AudioRushesTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate AudioRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
					end tell

					tell application "Finder"
						duplicate AudioRushesSourceFiles to AudioRushesDestinationFolderPath without replacing-- duplicate the files from AudioRushesSourceFiles in the folder AudioRushesDestinationFolderPath
					end tell

				end if
			end tell
		end if
		
	end if



	-- RUN SCRIPT 2.1.1-add-medias-from-set.applescript 



	set scriptAddMediasFromSetPath to (scriptPath & "2.1.1-add-medias-from-set.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	run script scriptAddMediasFromSetPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}

	return


end run