local  RUI = select(2, ...):unpack()

local E, L, V, P, G = unpack(ElvUI)

--This is the data we pass on to the ElvUI Plugin Installer.
--The Plugin Installer is responsible for displaying the install guide for this layout.
RUI.InstallerData = {
	Title = "|cff87f542Redtuzk|r|cffffffffUI TBC Anniversary|r",
	Name = RUI.PluginName,
	tutorialImage = "Interface\\AddOns\\ElvUI_Redtuzk\\Media\\logo.tga", --If you have a logo you want to use, otherwise it uses the one from ElvUI
	Pages = {
		[1] = function() --Welcome
			if E.private[RUI.PluginName].install_version == nil and E["global"][RUI.PluginName].profile_name then
				PluginInstallFrame.SubTitle:SetFormattedText("Welcome to the installation for %s.", RUI.PluginName)
				PluginInstallFrame.Desc1:SetText("It looks like you already have a RedtuzkUI profile installed called |cffc41f3b"..E["global"][RUI.PluginName].profile_name.."|r. Click \"Use Original\" to use the same profile on this character")
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript("OnClick", RUI.LoadRUIProfile)
				PluginInstallFrame.Option1:SetText("Use Original")
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript("OnClick", RUI.InstallComplete)
				PluginInstallFrame.Option2:SetText("Skip Process")
			elseif E.private[RUI.PluginName].install_version == RUI.Version or E.private[RUI.PluginName].install_version == nil then
				PluginInstallFrame.Desc1:SetText("This installation process will guide you through a few steps and apply settings to your current ElvUI profile. If you want to be able to go back to your original settings then create a new profile before going through this installation process.")
				PluginInstallFrame.Desc2:SetText("Please press the continue button if you wish to go through the installation process, otherwise click the 'Skip Process' button.")
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript("OnClick", RUI.InstallComplete)
				PluginInstallFrame.Option1:SetText("Skip Process")
			else
				PluginInstallFrame.SubTitle:SetFormattedText("|cff00ff00Looks like you've downloaded an update for|r |cffc41f3b%s|r!", RUI.PluginName)
				PluginInstallFrame.Desc1:SetText("Please go through the installer again to update parts of the UI you'd like updated.\n\n\nAny changes that you've made from the default RedtuzkUI profile will be removed.")
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript("OnClick", RUI.InstallComplete)
				PluginInstallFrame.Option1:SetText("Skip Update")
			end
		end,
		[2] = function() --Profile Setup
			if E.private[RUI.PluginName].install_version == nil or E.private[RUI.PluginName].install_version == RUI.Version then
				PluginInstallFrame.SubTitle:SetText("Profiles")
				PluginInstallFrame.Desc1:SetText("You can either create a new profile to install RedtuzkUI onto or you can apply RedtuzkUI settings to your current profile")
				PluginInstallFrame.Desc3:SetText("Your currently active ElvUI profile is: |cff87f542"..ElvUI[1].data:GetCurrentProfile().."|r")
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:NewProfile(false) end)
				PluginInstallFrame.Option1:SetText("Use Current")
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript("OnClick", function() RUI:NewProfile(true, "RedtuzkUI") end)
				PluginInstallFrame.Option2:SetText("Create New")
			else
				PluginInstallFrame.SubTitle:SetText("Profiles")
				PluginInstallFrame.Desc1:SetText("Press \"Update Current\" to update your current profile with the new RedtuzkUI changes.")
				PluginInstallFrame.Desc2:SetText("If you'd like to check out what the changes are, without overwriting your current settings, you can press \"Create New\"")
				PluginInstallFrame.Desc3:SetText("Your currently active ElvUI profile is: |cff87f542"..ElvUI[1].data:GetCurrentProfile().."|r")
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:NewProfile(false) end)
				PluginInstallFrame.Option1:SetText("Update Current")
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript("OnClick", function() RUI:NewProfile(true, "RedtuzkUI-Update") end)
				PluginInstallFrame.Option2:SetText("Create New")
			end
		end,
		[3] = function() --Inject profile
			if E.private[RUI.PluginName].install_version == nil or E.private[RUI.PluginName].install_version == RUI.Version then
				PluginInstallFrame.SubTitle:SetText("Load RedtuzkUI")
				PluginInstallFrame.Desc1:SetText("Loads the RUI TBC Anniversary profile")
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:SetupLayout("Redtuzk") end)
				PluginInstallFrame.Option1:SetText("Load Profile")
			else
			end
		end,
		[4] = function() --UI Scale
			if E.private[RUI.PluginName].install_version == nil or E.private[RUI.PluginName].install_version == RUI.Version or not E.private[RUI.PluginName].RaidFrameStyle then
				PluginInstallFrame.SubTitle:SetText("Set UI Scale")
				PluginInstallFrame.Desc1:SetText("RedtuzkUI is made for 1440p.\n If you want pixel-perfect alignment and sizing on a different resolution, you will have to manually reposition the movers and resize certain elements.")
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:UIScale("1440p"); end)
				PluginInstallFrame.Option1:SetText("1440p")
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript("OnClick", function() RUI:UIScale("1080p"); end)
				PluginInstallFrame.Option2:SetText("1080p & Other")
			end
		end,
		[5] = function() --Raidframes
			if E.private[RUI.PluginName].install_version == nil or E.private[RUI.PluginName].install_version == RUI.Version or not E.private[RUI.PluginName].RaidFrameStyle then
				PluginInstallFrame.SubTitle:SetText("Raid Frame Options")
				PluginInstallFrame.Desc1:SetText("Here you can select some options for Raid Frame styles. \n\nThe Vertical style is the standard RUI raid frame style with all players displaed in a single colum with no groupings.\n\nThe Traditional style is the traditional WoW raid frame style with groups layed out in a grid.")
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:RaidFrameStyle("vertical"); E.private[RUI.PluginName].RaidFrameStyle = "vertical" end)
				PluginInstallFrame.Option1:SetText("Vertical")
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript("OnClick", function() RUI:RaidFrameStyle("grid"); E.private[RUI.PluginName].RaidFrameStyle = "grid" end)
				PluginInstallFrame.Option2:SetText("Traditional")
			else
				PluginInstallFrame.SubTitle:SetText("Raid Frame Options")
				PluginInstallFrame.Desc1:SetText("Press \"Update Raid Frames\" to update your raid frame settings.")
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:RaidFrameStyle(E.private[RUI.PluginName].RaidFrameStyle) end)
				PluginInstallFrame.Option1:SetText("Update Raid Frames")
			end
		end,
		[6] = function() --NamePlates
			if C_AddOns.IsAddOnLoaded("Plater") then
		    PluginInstallFrame.SubTitle:SetText("NamePlates")
				PluginInstallFrame.Desc1:SetText("We highly recommend using Plater nameplates. \n When you click \"Setup Plater\" a new Plater profile called RedtuzkUI will be created.")
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:NamePlateSettings() end)
				PluginInstallFrame.Option1:SetText("Plater")
			else
				PluginInstallFrame.SubTitle:SetText("NamePlates")
				PluginInstallFrame.Desc1:SetText("We highly recommend using Plater nameplates. \n When you click \"Setup Plater\" a new Plater profile called RedtuzkUI will be created.")
				PluginInstallFrame.Desc2:SetText("|cffB33A3AOops! Looks like you haven't opted to use either of our avaiable layouts OR you don't have Plater. We don't have any nameplates settings to offer you.|r")
				--User doesn't have Plater so assume they want ElvUI plates
				E.private[RUI.PluginName]["plater"] = false
			end
		end,
		--[[[6] = function() --Boss Mod
			if C_AddOns.IsAddOnLoaded("BigWigs") and (E.private[RUI.PluginName].layout == "Redtuzk" or E.private[RUI.PluginName].layout == "Aldarana") then --Make sure the User has BigWigs installed.
				PluginInstallFrame.SubTitle:SetText("BigWigs")
				if E.private[RUI.PluginName].install_version == nil or E.private[RUI.PluginName].install_version == RUI.Version then
					PluginInstallFrame.Desc1:SetText("Import Redtuzk's BigWigs profile. A new profile called RedtuzkUI will be created. If you already have the Redtuzk profile it will be updated.")
					PluginInstallFrame.Desc2:SetText("Requires a UI reload for profile switch to take effect")
					PluginInstallFrame.Option1:Show()
					PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:SetupBigWigs() end)
					PluginInstallFrame.Option1:SetText("Setup BigWigs")
				else
					PluginInstallFrame.Desc1:SetText("Click \"Update BigWigs\" to update the RedtuzkUI BigWigs profile.\n\nCustom Settings for bosses will |cff07D400NOT|r be altered.")
					PluginInstallFrame.Desc2:SetText("Requires a UI reload for profile changes to take effect")
					PluginInstallFrame.Option1:Show()
					PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:SetupBigWigs() end)
					PluginInstallFrame.Option1:SetText("Update BigWigs")
				end
			else
				PluginInstallFrame.SubTitle:SetText("Boss Mod")
				PluginInstallFrame.Desc1:SetText("|cffB33A3AOops, it looks like you don't have BigWigs installed OR haven't selected a layout!|r")
				PluginInstallFrame.Desc2:SetText("BigWigs is recommended for use with RedtuzkUI")
			end
		end,]]
		[7] = function() --Details
			PluginInstallFrame.SubTitle:SetText("Details")
			if C_AddOns.IsAddOnLoaded("Details") then --Make sure the User has Details installed.
				if E.private[RUI.PluginName].install_version == nil or E.private[RUI.PluginName].install_version == RUI.Version then
					PluginInstallFrame.Desc1:SetText("Import Redtuzk's Details profile. A new profile called RedtuzkUI will be created. If you already have the Redtuzk profile it will be updated.")
					PluginInstallFrame.Option1:Show()
					PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:SetupDetails("Redtuzk") end)
					PluginInstallFrame.Option1:SetText("Setup Details")
				else
					PluginInstallFrame.Desc1:SetText("Click \"Update Details\" to update the RedtuzkUI Details profile.")
					PluginInstallFrame.Option1:Show()
					PluginInstallFrame.Option1:SetScript("OnClick", function() RUI:SetupDetails() end)
					PluginInstallFrame.Option1:SetText("Update Details")
				end
			else
				PluginInstallFrame.Desc1:SetText("|cffB33A3AOops, it looks like you don't have Details installed!|r")
				PluginInstallFrame.Desc2:SetText("Details is recommended for use with RedtuzkUI")
			end
		end,
		[8] = function() -- Install Complete
			if E.private[RUI.PluginName].install_version == nil or E.private[RUI.PluginName].install_version == RUI.Version then
				PluginInstallFrame.SubTitle:SetText("Installation Complete")
				PluginInstallFrame.Desc1:SetText("You have completed the installation process.")
				PluginInstallFrame.Desc2:SetText("Please click the button below in order to finalize the process and automatically reload your UI.")
			else
				PluginInstallFrame.SubTitle:SetText("Update Complete")
				PluginInstallFrame.Desc1:SetText("You have completed the update process.")
				PluginInstallFrame.Desc2:SetText("Please click the button below in order to finalize the process and automatically reload your UI.")
			end
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", RUI.InstallComplete)
			PluginInstallFrame.Option1:SetText("Finished")
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript("OnClick", createLink)
			PluginInstallFrame.Option2:SetText("Join Discord")
		end,
	},
	StepTitles = {
		[1] = "Welcome",
		[2] = "Profile Setup",
		[3] = "Load RedtuzkUI",
		[4] = "Set UI Scale",
		[5] = "Raid Frame Options",
		[6] = "NamePlates",
		--[6] = "Boss Mod Setup",
		[7] = "Details Setup",
		[8] = "Installation Complete",
	},
	StepTitlesColor = {1, 1, 1},
	StepTitlesColorSelected = {135/255, 245/255, 66/255},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = "RIGHT",
}
