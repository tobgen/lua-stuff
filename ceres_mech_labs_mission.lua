--*************************************
--name      : ceres_mech_labs_mission.lua
--ver       : 0.1
--author    : Tinyhorns
--date      : 15.11.2022
--lang      : eng
--desc      : Guiding Runners towards the Ceres biomechanic labs, and teaching them how to aquire WoC-disks
--npcs:
--NPCID: XXXX           Dr Fleming, Location: Biological Research Lab - Plaza 3
--       StartNPC       (NPC Starts all missions)

--*************************************
--changelog:
--15.11.2022 0.1: Initial release



--- Missions
mission01 = 5001  -- Gather information about the wereabouts of BioMecanical Labs
mission02 = 5002  -- Gather additional information about lab locations
mission03 = 5003  -- Kill 10 Experimental Ceres Infantry Troopers in Ceres BioMechanical Labs G_05, H_05, I_10 or J_16. 
mission04 = 5004  -- Kill 10 Prototype Ceres Infantry Troopers in Ceres BioMechanical Labs G_05, H_05, I_10 or J_16. 



    function DIALOG()
        local missionflag="ceres_labs_mission"


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
                        state = 20   --mission 2
                    elseif (result == 2) then
                        state = 40   --mission 3
                    elseif (result == 3) then
                        state = 60   --mission 4
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
        SAY("I've heard rumors of a secret facility hidden in the wastelands. It's supposed to be heavily guarded and well-hidden.\nI have sent my assistant Boskins to search for clues about the labs.\nBut I have not heared from him in a very long time. ")
        ANSWER(" Do you know where he went? ", 6)
        ANSWER(" Sounds like he was scared of your viruses and just left, I'm out as well! ",2)

    NODE(6)
        SAY(" He said he would start by asking my old friend Hacking Pete. \nLast time I did hear from Pete, he was hiding in a factory.\nSomewhere in the eastern part of the watelands.\nRunning, talk to Hacking Pete and report back to me.")
        ANSWER("Consider it done, I will go right away.", 7)
        ANSWER("I don't have time to chase rumors around, bye! ",2)

    NODE(10)
		STARTMISSION(mission01)
		SAY(" Hurry runnier, I'm worried about Assistant Boskins! ")
		SETNEXTDIALOGSTATE(15)
		ENDDIALOG()

