--*************************************
--name      : ceres_labs_mission.lua
--ver       : 0.1
--author    : Tinyhorns
--date      : 15.11.2022
--lang      : eng
--desc      : Guiding Runners towards the Ceres labs, and learning them how to aquire WoC-disks
--npcs:
--NPCID: XXXX           Dr Fleming or Prof DR Whitley (Undecidede), Location: Biological Research Lab - Plaza 3
--       StartNPC       (NPC Starts all missions)

--*************************************
--changelog:
--15.11.2022 0.1: Initial release



--- Missions
mission01 = 5001  -- Kill 10 Experimental Ceres Infantry Troopers in Ceres Biomechanical Labs G_05, H_05, I_10 or J_16. 
mission02 = 5002  -- Kill 10 Prototype Ceres Infantry Troopers in Ceres Biomechanical Labs G_05, H_05, I_10 or J_16. 
mission03 = 5003  -- Kill 10 Experimental Ceres Hover Infantry Trooper in Ceres BioGenetics Labs F_10, E_05, C_10 or B_06. 
mission04 = 5004  -- Kill 10 Prototype Ceres Hover Infantry Trooper in Ceres BioGenetics Labs F_10, E_05, C_10 or B_06. 


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
                        state = 2   --mission 2
                    elseif (result == 2) then
                        state = 3   --mission 3
                    elseif (result == 3) then
                        state = 4   --mission 4
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
        SAY(" Careful Runner, you don't want to catch a nasty virus down here, no lurking around. ")
        ANSWER(" What excaclty are you doing down here? ", 3)
        ANSWER(" I'll better go back upstairs and leave you to it", 2 )

    NODE(2)
        SAY(" Run away little girl, run away! ")
        ENDDIALOG()

    NODE(3)
        SAY(" I can tell you it involves the study of the long lost Ceres Disks.\nWe do biological experiments found on those disks. ")
        ANSWER(" Ceres Disks, what are those?", 4)

    NODE(4)
        SAY(" They contain knowledge from Ceres Project.\nSome say it contains secrets to even more power.\nI have sent my assistant to search for more disks.\nBut I have not heared from him in a very long time. ")
        ANSWER(" Where did you send him?", 5)
        ANSWER(" Sounds like he was scared of your viruses and just left, Im out as well! ")

    NODE(5)
        SAY(" He was tasked to go to the Ceres Biomechanical Labs in the wastelands.\nI wonder if the rumors are true...")
        ANSWER(" What rumors? ", 6)

    NODE(6)
        SAY(" Rumors about the labs not being empty.\n I wonder what has happened to him.\nPlease Runner, Investigate the Ceres Biomechanical Labs")