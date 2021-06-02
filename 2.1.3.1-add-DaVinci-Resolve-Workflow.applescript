on run {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}


	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script add video rushes \n \n",logPath,true) -- anounce to the starting of the scrip




	set ProjectFolder to (NewProjectFolderPath & "/01_PROJECT")

	set DaVinciWorkflow to (display dialog "Will you work on DaVinci Resolve workflow" buttons {"No", "Yes"} default button 2 with icon (iconAppDavinciResolvePpath of baseVariables))
	set DaVinciRessourceFolder to (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO/DaVinci Resolve")
	set DaVinciFolder to (ProjectFolder & "/DaVinci Resolve")
	set DaVinci4Kfile to (DaVinciFolder & "/_00_RESSOURCES_ALGO/Template_4K_UHD_v1.drp")
	set DaVinci1080pfile to (DaVinciFolder & "/_00_RESSOURCES_ALGO/Template_1080p_v1.drp")
	
	-- CREATE THE DIRECTORY FOR THE VIDEO RUSHES FOLDER


	set ProjectDestinationFolderPath to (NewProjectFolder & "01_PROJECT") as text -- call to the path of the destination for the files selected  from VideoRushesSourceFiles
	baseVariables's write_to_file("var ProjectDestinationFolderPath = " & ProjectDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of ProjectDestinationFolderPath

	set DaVinciResolveDestinationFolderPath to (NewProjectFolder & "01_PROJECT:DaVinci Resolve") as text -- call to the path of the destination for the files selected  from VideoRushesSourceFiles
	baseVariables's write_to_file("var DaVinciResolveDestinationFolderPath = " & DaVinciResolveDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of DaVinciResolveDestinationFolderPath
	
	-- DAVINCI = YES
	
	if button returned of DaVinciWorkflow = "Yes" then

		tell application "Finder"
			if (exists (folder ProjectDestinationFolderPath)) then
				if (exists (folder DaVinciResolveDestinationFolderPath)) then
				
					display dialog "A DaVinci Resolve PROJECT already exit!" buttons {"OK"} default button 1 with icon (iconAppDavinciResolvePpath of baseVariables)

				else
					do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/._00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO"))


					do shell script "mv " & (quoted form of DaVinciRessourceFolder) & " " & (quoted form of ProjectFolder)

					set DaVinciDefworkflow to (display dialog "Choose your timeline resolution for DaVinci Resolve  :" buttons {"1080p", "4K UHD"} default button 2 with icon (iconAppDavinciResolvePpath of baseVariables))

					if button returned of DaVinciDefworkflow = "4K UHD" then
						do shell script "mv " & (quoted form of DaVinci4Kfile) & " " & (quoted form of DaVinciFolder)

						-- RENAME 4K TEMPLATE FILE

						tell application "Finder"
							set fileAlias to (NewProjectFolder & "01_PROJECT:DaVinci Resolve:Template_4K_UHD_v1.drp") as text
							set fileAliasPath to (NewProjectFolder & "01_PROJECT:DaVinci Resolve") as text
							set theFile to "Template_4K_UHD_v1.drp"
							set AppleScript's text item delimiters to "."
							set fileName to name of file fileAlias 
							set fileExtension to last text item of fileName
							set nameWithoutExtension to first text item of fileName 
							set newName to (globalProjectName & "_4K_UHD_v1." & fileExtension)
							set name of file theFile of folder fileAliasPath to newName --> rename the file
						end tell
					end if

					if button returned of DaVinciDefworkflow = "1080p" then
						do shell script "mv " & (quoted form of DaVinci1080pfile) & " " & (quoted form of DaVinciFolder)

						-- RENAME 4K TEMPLATE FILE

						tell application "Finder"
							set fileAlias to (NewProjectFolder & "01_PROJECT:DaVinci Resolve:Template_1080p_v1.drp") as text
							set fileAliasPath to (NewProjectFolder & "01_PROJECT:DaVinci Resolve") as text
							set theFile to "Template_1080p_v1.drp"
							set AppleScript's text item delimiters to "."
							set fileName to name of file fileAlias 
							set fileExtension to last text item of fileName
							set nameWithoutExtension to first text item of fileName 
							set newName to (globalProjectName & "_1080p_v1." & fileExtension)
							set name of file theFile of folder fileAliasPath to newName --> rename the file
						end tell
					end if

					do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/DaVinci Resolve/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/DaVinci Resolve/._00_RESSOURCES_ALGO"))
					do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/._00_RESSOURCES_ALGO"))



				end if
			else
				set ProjectTemplateFolderSourcesPath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:01_PROJECT") as text -- import le dossier ressource pour 01_PROJECT

				tell application "Finder"
					duplicate ProjectTemplateFolderSourcesPath to NewProjectFolder -- ajoute le dossier Projet qui n'existant pas dans le dossier de projet
				end tell

				do shell script "mv " & (quoted form of DaVinciRessourceFolder) & " " & (quoted form of ProjectFolder)

				set DaVinciDefworkflow to (display dialog "Choose your timeline resolution for DaVinci Resolve  :" buttons {"1080p", "4K UHD"} default button 2 with icon (iconAppDavinciResolvePpath of baseVariables))

				if button returned of DaVinciDefworkflow = "4K UHD" then
					do shell script "mv " & (quoted form of DaVinci4Kfile) & " " & (quoted form of DaVinciFolder)

					-- RENAME 4K TEMPLATE FILE

					tell application "Finder"
						set fileAlias to (NewProjectFolder & "01_PROJECT:DaVinci Resolve:Template_4K_UHD_v1.drp") as text
						set fileAliasPath to (NewProjectFolder & "01_PROJECT:DaVinci Resolve") as text
						set theFile to "Template_4K_UHD_v1.drp"
						set AppleScript's text item delimiters to "."
						set fileName to name of file fileAlias 
						set fileExtension to last text item of fileName
						set nameWithoutExtension to first text item of fileName 
						set newName to (globalProjectName & "_4K_UHD_v1." & fileExtension)
						set name of file theFile of folder fileAliasPath to newName --> rename the file
					end tell
				end if

				if button returned of DaVinciDefworkflow = "1080p" then
					do shell script "mv " & (quoted form of DaVinci1080pfile) & " " & (quoted form of DaVinciFolder)

					-- RENAME 4K TEMPLATE FILE

					tell application "Finder"
						set fileAlias to (NewProjectFolder & "01_PROJECT:DaVinci Resolve:Template_1080p_v1.drp") as text
						set fileAliasPath to (NewProjectFolder & "01_PROJECT:DaVinci Resolve") as text
						set theFile to "Template_1080p_v1.drp"
						set AppleScript's text item delimiters to "."
						set fileName to name of file fileAlias 
						set fileExtension to last text item of fileName
						set nameWithoutExtension to first text item of fileName 
						set newName to (globalProjectName & "_1080p_v1." & fileExtension)
						set name of file theFile of folder fileAliasPath to newName --> rename the file
					end tell
				end if

				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/DaVinci Resolve/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/DaVinci Resolve/._00_RESSOURCES_ALGO"))
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/._00_RESSOURCES_ALGO"))


			end if
		end tell

	end if

	
	


	-- RUN SCRIPT 2.1.3-add-workflow.applescript 


	set scriptAddWorkflowPath to (scriptPath & "2.1.3-add-workflow.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	run script scriptAddWorkflowPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}

	return


end run