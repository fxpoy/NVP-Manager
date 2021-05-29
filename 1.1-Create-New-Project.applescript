


On run {scriptPath}
	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE

	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script \n \n",logPath,true) -- anounce to the starting of the scrip


	set res to (display dialog "CA RUN BIEN LE SCRIPT" buttons {"Don't Continue", "Continue"} default button "Continue")

	if button returned of res = "Don't Continue" then
		set scriptNVPManagerPath to (scriptPath & "/NVP-Manager.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
		baseVariables's write_to_file(" \n \n call to run the script = " & scriptNVPManagerPath & "  \n \n",logPath,true) -- write in log file the calling script
		set res to (run script scriptNVPManagerPath with parameters false)
	end if

end run
