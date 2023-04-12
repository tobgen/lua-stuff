--*************************************
--name      : ceres_mech_labs_mission.lua
--ver       : 0.2
--author    : Tinyhorns
--date      : 15.11.2022
--lang      : eng
--desc      : Guiding Runners towards the Ceres biomechanic labs, and teaching them how to aquire WoC-disks
--npcs:
--NPCID: XXXX           Dr Fleming, Location: Biological Research Lab - Plaza 3
--       StartNPC       (NPC Starts first and 2nd mission)
--       Assistant Boskins (start 3rd and 4th mission)

--*************************************
--changelog:
--15.11.2022 0.1: Initial release
--02.01.2023 0.2: adding some more running
--31-01-2023 0.3: changing location of Boskins
--12-04-2023 0.4: rewrite to match new location, G_05

--- Missions
mission01 = 5001  -- Gather information about the wereabouts of BioMecanical Labs
mission02 = 5002  -- Gather additional information about lab locations
mission03 = 5003  -- Kill 10 Experimental Ceres Infantry Troopers in Ceres BioMechanical Labs G_05, H_05, I_10 or J_16. 
mission04 = 5004  -- Kill 10 Prototype Ceres Infantry Troopers in Ceres BioMechanical Labs G_05, H_05, I_10 or J_16. 



function DIALOG()
   local missionflag="ceres_mech_labs_mission"
   local killtarget01="Experimental Ceres Infantry Trooper"
   local killtarget02="Protoype Ceres Infantry Trooper"

-- missionflag=0 --> start misstion 1
-- missionflag=1 --> start misstion 2
-- missionflag=2 --> start misstion 3
-- missionflag=3 --> start misstion 4
-- missionflag=4 --> mission already completed

    NODE(0)
    if (state == node) then
        GETBASERANK()
            if (result >=55) then
                GETDATA(missionflag)
                    if (result == 0) then
                        state = 1   --mission 1
                    elseif (result == 1) then
                        state = 40   --mission 2
                    elseif (result == 2) then
                        state = 80   --mission 3
                    elseif (result == 3) then
                        state = 120   --mission 4
                    elseif (result == 4) then
                        SAY(" Sorry %PLAYER_NAME() , you have already completed this mission. ")
                        ENDDIALOG()
                    end
            else
                SAY(" Please come back and see mee after you have finished your Oatmeal. ")
                ENDDIALOG()
            end
    end

-- StartNPC Dr Fleming

    NODE(1)
        SAY(" Careful Runner, you don't want to catch any nasty viruses down here, no lurking around. ")
        ANSWER(" What excaclty are you doing down here? ", 3)
        ANSWER(" I'll better go back upstairs and leave you to it", 2 )

    NODE(2)
        SAY(" Run away little girl, run away! ")
        ENDDIALOG()

    NODE(3)
        SAY(" I can tell you it involves the study of the long lost Ceres Disks.\nWe do biological experiments found on those disks. ")
        ANSWER(" Ceres Disks, what are those?", 4)

    NODE(4)
        SAY(" They contain knowledge from Ceres Project.\nSome say it contains secrets to even more power. ")
        ANSWER(" More Power, please tell me more. ", 5)   

    NODE(5)
        SAY(" I've heard rumors of a secret facility hidden in the wastelands. It's supposed to be heavily guarded and well-hidden.\nI have sent my assistant Boskins to search for clues about the labs.\nBut I have not heared from him in a very long time. ")
        ANSWER(" Do you know where he went? ", 6)
        ANSWER(" Sounds like he was scared of your viruses and just left, I'm out as well! ",2)

    NODE(6)
        SAY(" He said he would start by asking my old friend Hacking Pete. \nLast time I did hear from Pete, he was hiding in a factory.\nSomewhere in the eastern part of the watelands.\nHe's always poking around in places he shouldn't be and he might have some information about the lab.")
        ANSWER("Consider it done.", 10)
        ANSWER("I don't have time to chase rumors around, bye! ",2)

    NODE(10)
	    STARTMISSION(mission01)
	    SAY(" Go quickly now. ")
        SETNEXTDIALOGSTATE(20)
        ENDDIALOG()

    NODE(20) -- Hacking Pete
        SAY(" What do you want, can't you see I'm busy?" )
        ANSWER(" Hey Hacking Pete, Dr Fleming sent me.\nDo you know where I can find Assistant Boskins? ", 22)
        ANSWER("Sorry to bother you, I will be on my way.", 21)

    NODE(21)
        SAY(" Run away little girl, run away! ")
        ENDDIALOG()

    NODE(22)
        SAY(" Oh, Assistant Boskins. Yeah, I might know where he is. But it's gonna cost you.\nI don't give out information for free, you know.")
        ANSWER("How much are you asking for?", 23)

    NODE(23)
        SAY("25,000 credits. That's a pretty good deal if you ask me.")
        ANSWER(" Alright, I'll pay you the 25,000 credits. But you better give me some good information.", 24)
        ANSWER(" I don't have that kind of money", 21)

    NODE(24)
        SAY("You got it.\nAssistant Boskins was last seen in the mountains north of Regants \nHe's probably still there, but who knows. He's a slippery one. \nI heard he's been looking for a secret biomechanical lab. Maybe that's where he's headed. \nReport back to Dr Fleming.")
	SETDATA(missionflag,1)
	ACTIVATEDIALOGTRIGGER(0)
	ENDDIALOG()


    NODE(40)  -- Dr Fleming
        SAY(" Did Hacking Pete tell you anything useful?")
        ANSWER("He said something about Regants, north of Regans, mountains", 42)
        ANSWER("I do not have time for this right now....", 41)
    
    NODE(41)
        SAY("Run away little girl, run away! ")
        ENDDIALOG()
    
    NODE(42) -- TODO: check location, and write a better dialog
        SAY("I remember when I was a little kid, my father used to take me camping near Greycore Outpost, But I did never see any lab there, maybe it's more up, and towards the coast?.\nAll I remember is that we was not allowed to go that way.\nThe mountains is full of Hoverbots.")
        ANSWER("Time to grab the big guns, I'm going over there right now.", 43)
        ANSWER("Hoverbots? I'm out.", 41)

    NODE(43)
	    STARTMISSION(mission02)
	    SAY(" Go quickly now. ")
	    SETNEXTDIALOGSTATE(80)
	    ENDDIALOG()



    NODE(80)  -- Boskins 
        SAY("Careful runner, keep your voice down. There are everywhere.")
        ANSWER("I was sent by Dr Fleming, did you find the lab?", 82)
        ANSWER("I do not have time for you", 81)

    NODE(81)
        SAY("Then go, very quite!")
        ENDDIALOG()

    NODE(82) -- TODO: update directions when location has been scouted
        SAY("I found it! Its a bit to the north from here, down the hill.\nBut the outside is guarded by Hoverbots and even if you make it inside, there will be trouble waiting.")
    	SETDATA(missionflag,1)
	    ACTIVATEDIALOGTRIGGER(0)
	    ENDDIALOG()    
        
        
    NODE(83)    
        SAY("It's said to be guarded by Ceres Infantry Troops, some of the most advanced and formidable soldiers in the wasteland. \nIf you do decide to go, be prepared for a tough fight. ")
        ANSWER("...", 84)
         
    NODE(84)
        SAY("The Ceres Troops don't take kindly to outsiders poking around in their affairs.\nThey'll do whatever it takes to protect that lab and its secrets...\nBut the Ceres Disks are in there, of that I'm sure.")
        ANSWER("I did not come this far to turn around and run, time to dive in!", 85)
        ANSWER("I'm out, not going near crazy Hoverbots or Ceres Troops", 81)

    NODE(85)
        SAY("Kill 10 "..killtarget01.." and report back to me.")
	    STARTMISSION(mission03)
	    SETNEXTDIALOGSTATE(90)
	    ENDDIALOG()

    NODE(90)
            if (result==1)
                SAY("Good Job runner, you removed some of those pesky "..killtarget01.."\nI hope you found something useful down there as well. ")
                SETNEXTDIALOGSTATE(100)
                ENDDIALOG()
            else
                SAY("You have not killed enough "..killtarget01..", To hard for you?\nGo now and don't comeback until you have killed some more! ")
        SETNEXTDIALOGSTATE(90)
                ENDDIALOG()
            end



    NODE(130)
        SAY("Kill 10 "..killtarget02.." and report back to me.")
	    STARTMISSION(mission04)
	    SETNEXTDIALOGSTATE(150)
	    ENDDIALOG()

    NODE(150) 
        IMISSIONTARGETACCOMPLISHED(0)
            if (result==1)
                SAY("Good Job runner, you removed some of those pesky "..killtarget02.."!\nI hope you found something useful down there as well. ")
                SETNEXTDIALOGSTATE(180)
                ENDDIALOG()
            else
                SAY("You have not killed enough "..killtarget02..", To hard for you?\nGo now and don't comeback until you have killed some more! ")
        SETNEXTDIALOGSTATE(150)
                ENDDIALOG()
            end

    NODE(180)
        SETDATA(missionflag,4)
        SAY("Good job Runner!)
        GIVEMONEY(reward)
        GIVEITEM(--ADDDISK)
        ACTIVATEDIALOGTRIGGER(1)
        ENDDIALOG()