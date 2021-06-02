on run {scriptPath, NewProjectFolderPath, NewProjectFolder}


	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script \n \n",logPath,true) -- anounce to the starting of the scrip



	-- IMPORT RAW PHOTOS



	set RAWPhotosSourceFiles to (choose file with prompt "Please select the original RAW Photos to import in the project folder :" of type {"public.image"} with multiple selections allowed) -- ask for a selection a files of type : Image
	baseVariables's write_to_file("var RAWPhotosSourceFiles = " & RAWPhotosSourceFiles & " \n \n",logPath,true) -- write in log file the value of RAWPhotosSourceFiles

	Set RAWPhotosDestinationFolderPpath to (NewProjectFolderPath & "/02_MEDIAS FROM SET/_RAW PHOTOS")
	baseVariables's write_to_file("var RAWPhotosDestinationFolderPpath = " & RAWPhotosDestinationFolderPpath & " \n \n",logPath,true) -- write in log file the value of RAWPhotosDestinationFolderPpath


	-- CREATE THE DIRECTORY FOR THE RAW PHOTOS FOLDER


	set MediaFromSetDestinationFolderPath to (NewProjectFolder & "02_MEDIAS FROM SET") as text -- call to the path of the destination for the files selected  from RAWPhotosSourceFiles
	baseVariables's write_to_file("var MediaFromSetDestinationFolderPath = " & MediaFromSetDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of MediaFromSetDestinationFolderPath


	set RAWPhotosDestinationFolderPath to (NewProjectFolder & "02_MEDIAS FROM SET:_RAW PHOTOS") as text -- call to the path of the destination for the files selected  from RAWPhotosSourceFiles
	baseVariables's write_to_file("var RAWPhotosDestinationFolderPath = " & RAWPhotosDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of RAWPhotosDestinationFolderPath

	set manipulationRAWPhotosfiles to (display dialog "Choose your manipulating finder files for the RAW Photos importing :" buttons {"Move files", "Duplicate files"} default button 2 with icon (iconSoundFolderPpath of baseVariables)) -- ask for Moving or Duplicating action for the files from RAWPhotosSourceFiles

	if button returned of manipulationRAWPhotosfiles = "Duplicate files" then

		-- VERIFY THE EXISTING PATH FOR THE DESTINATION FOLDER
		
		tell application "Finder"
			if (exists (folder MediaFromSetDestinationFolderPath)) then
				if (exists (folder RAWPhotosDestinationFolderPath)) then
				
					tell application "Finder"
					    repeat with f in (get items of RAWPhotosSourceFiles)
					        if not (exists file (name of f) of folder RAWPhotosDestinationFolderPath) then
					            duplicate f to folder RAWPhotosDestinationFolderPath without replacing
					        end if
					    end repeat
					end tell

				else
					set RAWPhotosTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:_RAW PHOTOS") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var RAWPhotosTemplateFolderSourcesPpath = " & RAWPhotosTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of RAWPhotosTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate RAWPhotosTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
					end tell

					tell application "Finder"
						duplicate RAWPhotosSourceFiles to RAWPhotosDestinationFolderPath without replacing-- duplicate the files from RAWPhotosSourceFiles in the folder RAWPhotosDestinationFolderPath
					end tell

					tell application "Finder"
					    repeat with f in (get items of RAWPhotosSourceFiles)
					        if not (exists file (name of f) of folder RAWPhotosDestinationFolderPath) then
					            duplicate f to folder RAWPhotosDestinationFolderPath without replacing
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

				set RAWPhotosTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:_RAW PHOTOS") as text -- call to the path of the "/ZZ_EXPORTS" folder
				baseVariables's write_to_file("var RAWPhotosTemplateFolderSourcesPpath = " & RAWPhotosTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of RAWPhotosTemplateFolderSourcesPpath

				tell application "Finder"
					duplicate RAWPhotosTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
				end tell

				tell application "Finder"
					duplicate RAWPhotosSourceFiles to RAWPhotosDestinationFolderPath without replacing-- duplicate the files from RAWPhotosSourceFiles in the folder RAWPhotosDestinationFolderPath
				end tell

			end if
		end tell
	end if

	if button returned of manipulationRAWPhotosfiles = "Move files" then
		set confirmationRAWPhotosMoving to (display dialog "Confirmation to removing files from " & RAWPhotosSourceFiles & "to moving them to the project folder " buttons {"No, duplicate them", "Confirm removing"} default button 2 with icon 2)

		if button returned of confirmationRAWPhotosMoving = "Confirm removing" then
			
			-- VERIFY THE EXISTING PATH FOR THE DESTINATION FOLDER
		
			tell application "Finder"
				if (exists (folder MediaFromSetDestinationFolderPath)) then
					if (exists (folder RAWPhotosDestinationFolderPath)) then
					
						tell application "Finder"
						    repeat with f in (get items of RAWPhotosSourceFiles)
						        if not (exists file (name of f) of folder RAWPhotosDestinationFolderPath) then
						            move f to folder RAWPhotosDestinationFolderPath without replacing
						        end if
						    end repeat
						end tell

					else
						set RAWPhotosTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:_RAW PHOTOS") as text -- call to the path of the "/ZZ_EXPORTS" folder
						baseVariables's write_to_file("var RAWPhotosTemplateFolderSourcesPpath = " & RAWPhotosTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of RAWPhotosTemplateFolderSourcesPpath

						tell application "Finder"
							duplicate RAWPhotosTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
						end tell

						tell application "Finder"
							duplicate RAWPhotosSourceFiles to RAWPhotosDestinationFolderPath without replacing-- duplicate the files from RAWPhotosSourceFiles in the folder RAWPhotosDestinationFolderPath
						end tell

						tell application "Finder"
						    repeat with f in (get items of RAWPhotosSourceFiles)
						        if not (exists file (name of f) of folder RAWPhotosDestinationFolderPath) then
						            move f to folder RAWPhotosDestinationFolderPath without replacing
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

					set RAWPhotosTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:_RAW PHOTOS") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var RAWPhotosTemplateFolderSourcesPpath = " & RAWPhotosTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of RAWPhotosTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate RAWPhotosTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
					end tell

					tell application "Finder"
						move RAWPhotosSourceFiles to RAWPhotosDestinationFolderPath without replacing-- duplicate the files from RAWPhotosSourceFiles in the folder RAWPhotosDestinationFolderPath
					end tell

				end if
			end tell
		end if

		if button returned of confirmationRAWPhotosMoving = "No, duplicate them" then
			
			-- VERIFY THE EXISTING PATH FOR THE DESTINATION FOLDER
		
			tell application "Finder"
				if (exists (folder MediaFromSetDestinationFolderPath)) then
					if (exists (folder RAWPhotosDestinationFolderPath)) then
					
						tell application "Finder"
						    repeat with f in (get items of RAWPhotosSourceFiles)
						        if not (exists file (name of f) of folder RAWPhotosDestinationFolderPath) then
						            duplicate f to folder RAWPhotosDestinationFolderPath without replacing
						        end if
						    end repeat
						end tell

					else
						set RAWPhotosTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:_RAW PHOTOS") as text -- call to the path of the "/ZZ_EXPORTS" folder
						baseVariables's write_to_file("var RAWPhotosTemplateFolderSourcesPpath = " & RAWPhotosTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of RAWPhotosTemplateFolderSourcesPpath

						tell application "Finder"
							duplicate RAWPhotosTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
						end tell

						tell application "Finder"
							duplicate RAWPhotosSourceFiles to RAWPhotosDestinationFolderPath without replacing-- duplicate the files from RAWPhotosSourceFiles in the folder RAWPhotosDestinationFolderPath
						end tell

						tell application "Finder"
						    repeat with f in (get items of RAWPhotosSourceFiles)
						        if not (exists file (name of f) of folder RAWPhotosDestinationFolderPath) then
						            duplicate f to folder RAWPhotosDestinationFolderPath without replacing
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

					set RAWPhotosTemplateFolderSourcesPpath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:_RAW PHOTOS") as text -- call to the path of the "/ZZ_EXPORTS" folder
					baseVariables's write_to_file("var RAWPhotosTemplateFolderSourcesPpath = " & RAWPhotosTemplateFolderSourcesPpath & " \n \n",logPath,true) -- write in log file the value of RAWPhotosTemplateFolderSourcesPpath

					tell application "Finder"
						duplicate RAWPhotosTemplateFolderSourcesPpath to MediaFromSetDestinationFolderPath
					end tell

					tell application "Finder"
						duplicate RAWPhotosSourceFiles to RAWPhotosDestinationFolderPath without replacing-- duplicate the files from RAWPhotosSourceFiles in the folder RAWPhotosDestinationFolderPath
					end tell

				end if
			end tell
		end if
		
	end if



	-- RUN SCRIPT 2.1.1-add-medias-from-set.applescript 



	set scriptAddMediasFromSetPath to (scriptPath & "2.1.1-add-medias-from-set.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	run script scriptAddMediasFromSetPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder}


end run