on run {scriptPath, NewProjectFolderPath, NewProjectFolder}


	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script add video rushes \n \n",logPath,true) -- anounce to the starting of the scrip


	-- IMPORT VIDEO RUSHES

	set VideoRushesSourceFiles to (choose file with prompt "Please select the original Video rushes to import in the project folder :" of type {"public.movie"} with multiple selections allowed) -- ask for a selection a files of type : video
	baseVariables's write_to_file("var VideoRushesSourceFiles = " & VideoRushesSourceFiles & " \n \n",logPath,true) -- write in log file the value of VideoRushesSourceFiles

	Set VideoRushesDestinationFolderPpath to (NewProjectFolderPath & "/02_MEDIAS FROM SET/VIDEO RUSHES")
	baseVariables's write_to_file("var VideoRushesDestinationFolderPpath = " & VideoRushesDestinationFolderPpath & " \n \n",logPath,true) -- write in log file the value of VideoRushesDestinationFolderPpath

	-- CREATE THE DIRECTORY FOR THE VIDEO RUSHES FOLDER

	-- do shell script "mkdir -p " & (quoted form of VideoRushesDestinationFolderPpath)

	set MediaFromSetDestinationFolderPath to (NewProjectFolder & "02_MEDIAS FROM SET") as text -- call to the path of the destination for the files selected  from VideoRushesSourceFiles
	baseVariables's write_to_file("var MediaFromSetDestinationFolderPath = " & MediaFromSetDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of MediaFromSetDestinationFolderPath

	set VideoRushesDestinationFolderPath to (NewProjectFolder & "02_MEDIAS FROM SET:VIDEO RUSHES") as text -- call to the path of the destination for the files selected  from VideoRushesSourceFiles
	baseVariables's write_to_file("var VideoRushesDestinationFolderPath = " & VideoRushesDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of VideoRushesDestinationFolderPath

	set manipulationVideofiles to (display dialog "Choose your manipulating finder files for the Video rushes importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconVideoFolderPpath of baseVariables)) -- ask for Moving or Duplicating action for the files from VideoRushesSourceFiles

	if button returned of manipulationVideofiles = "Duplicate files" then
		
		-- VERIFY THE EXISTING PATH FOR THE DESTINATION FOLDER
		tell application "Finder"
			if (exists (folder MediaFromSetDestinationFolderPath)) then
				if (exists (folder MediaFromSetDestinationFolderPath)) then
				
					tell application "Finder"
					    repeat with f in (get items of VideoRushesSourceFiles)
					        if not (exists file (name of f) of folder VideoRushesDestinationFolderPath) then
					            duplicate f to folder VideoRushesDestinationFolderPath without replacing
					        end if
					    end repeat
					end tell

				else
					set VideoRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:VIDEO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var VideoRushesTemplateFolderSourcesPpath = " & VideoRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of VideoRushesTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate VideoRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
					end tell

					tell application "Finder"
						duplicate VideoRushesSourceFiles to VideoRushesDestinationFolderPath without replacing-- duplicate the files from VideoRushesSourceFiles in the folder VideoRushesDestinationFolderPath
					end tell

					tell application "Finder"
					    repeat with f in (get items of VideoRushesSourceFiles)
					        if not (exists file (name of f) of folder VideoRushesDestinationFolderPath) then
					            duplicate f to folder VideoRushesDestinationFolderPath without replacing
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

				set VideoRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:VIDEO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
				baseVariables's write_to_file("var VideoRushesTemplateFolderSourcesPpath = " & VideoRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of VideoRushesTemplateFolderSourcesPpath

				tell application "Finder"
					duplicate VideoRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
				end tell

				tell application "Finder"
					duplicate VideoRushesSourceFiles to VideoRushesDestinationFolderPath without replacing-- duplicate the files from VideoRushesSourceFiles in the folder VideoRushesDestinationFolderPath
				end tell

			end if
		end tell

	end if

	if button returned of manipulationVideofiles = "Move files" then
		set confirmationVideomoving to (display dialog "Confirmation to removing files from " & VideoRushesSourceFiles & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)

		if button returned of confirmationVideomoving = "Confirm removing" then

			-- VERIFY THE EXISTING PATH FOR THE DESTINATION FOLDER
			
			tell application "Finder"
				if (exists (folder MediaFromSetDestinationFolderPath)) then
					if (exists (folder MediaFromSetDestinationFolderPath)) then
					
						tell application "Finder"
						    repeat with f in (get items of VideoRushesSourceFiles)
						        if not (exists file (name of f) of folder VideoRushesDestinationFolderPath) then
						            move f to folder VideoRushesDestinationFolderPath without replacing
						        end if
						    end repeat
						end tell

					else
						set VideoRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:VIDEO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
						baseVariables's write_to_file("var VideoRushesTemplateFolderSourcesPpath = " & VideoRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of VideoRushesTemplateFolderSourcesPpath

						tell application "Finder"
							duplicate VideoRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
						end tell

						tell application "Finder"
							duplicate VideoRushesSourceFiles to VideoRushesDestinationFolderPath without replacing-- duplicate the files from VideoRushesSourceFiles in the folder VideoRushesDestinationFolderPath
						end tell

						tell application "Finder"
						    repeat with f in (get items of VideoRushesSourceFiles)
						        if not (exists file (name of f) of folder VideoRushesDestinationFolderPath) then
						            move f to folder VideoRushesDestinationFolderPath without replacing
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

					set VideoRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:VIDEO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var VideoRushesTemplateFolderSourcesPpath = " & VideoRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of VideoRushesTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate VideoRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
					end tell

					tell application "Finder"
						move VideoRushesSourceFiles to VideoRushesDestinationFolderPath without replacing-- duplicate the files from VideoRushesSourceFiles in the folder VideoRushesDestinationFolderPath
					end tell

				end if
			end tell
		end if

		if button returned of confirmationVideomoving = "No, duplicate them" then

			-- VERIFY THE EXISTING PATH FOR THE DESTINATION FOLDER
			
			tell application "Finder"
				if (exists (folder MediaFromSetDestinationFolderPath)) then
					if (exists (folder MediaFromSetDestinationFolderPath)) then
					
						tell application "Finder"
						    repeat with f in (get items of VideoRushesSourceFiles)
						        if not (exists file (name of f) of folder VideoRushesDestinationFolderPath) then
						            duplicate f to folder VideoRushesDestinationFolderPath without replacing
						        end if
						    end repeat
						end tell

					else
						set VideoRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:VIDEO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
						baseVariables's write_to_file("var VideoRushesTemplateFolderSourcesPpath = " & VideoRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of VideoRushesTemplateFolderSourcesPpath

						tell application "Finder"
							duplicate VideoRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
						end tell

						tell application "Finder"
							duplicate VideoRushesSourceFiles to VideoRushesDestinationFolderPath without replacing-- duplicate the files from VideoRushesSourceFiles in the folder VideoRushesDestinationFolderPath
						end tell

						tell application "Finder"
						    repeat with f in (get items of VideoRushesSourceFiles)
						        if not (exists file (name of f) of folder VideoRushesDestinationFolderPath) then
						            duplicate f to folder VideoRushesDestinationFolderPath without replacing
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

					set VideoRushesTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:VIDEO RUSHES") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var VideoRushesTemplateFolderSourcesPpath = " & VideoRushesTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of VideoRushesTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate VideoRushesTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
					end tell

					tell application "Finder"
						duplicate VideoRushesSourceFiles to VideoRushesDestinationFolderPath without replacing-- duplicate the files from VideoRushesSourceFiles in the folder VideoRushesDestinationFolderPath
					end tell

				end if
			end tell
		end if
		
	end if


	-- RUN SCRIPT 2.1.1-add-medias-from-set.applescript 


	set scriptAddMediasFromSetPath to (scriptPath & "2.1.1-add-medias-from-set.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	run script scriptAddMediasFromSetPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder}


end run