--*************************************
--name      : test_mission.lua
--ver       : 0.1
--author    : Tinyhorns
--date      : 14.11.2022
--lang      : eng
--desc      : first attempt at a lua-mission
--npcs:
--NPCID: XXXX           Poor beggar outside Crahn HQ
--       StartNPC       (NPC Starts all missions)

--NPCID: YYYY           Gerald Forsyte outside PP HQ
--       NPC0           (NPC0 In mission 1)

--NPCID: ZZZZ           Mike Garninger inside Techical Workshop, P4
--       NPC1           (NPC0 In mission 1)

--*************************************
--changelog:
--14.11.2022 0.1: Initial try
--14.11.2022 0.2: Mission02 added, kill stuff



--- Missonitems
qitem01 = 1234
qitem02 = 4321

--- MissionRewards
money = 15000

    function DIALOG()
        local missionflag="test_mission"
        local qitemname01="Tofu sausages in poisonous plant puree"
        local qitemname02="Warbot Cola"
	local killtarget01="Protoype Ceres Hover Infantry Trooper" 
	
-- missionflag=0 --> start misstion 1
-- missionflag=1 --> start misstion 2
-- missionflag=2 --> mission already completed


    NODE(0)
        if (state == node) then
            GETBASERANK()
                if (result >=30) then
                    GETDATA(missionflag)
                        if (result == 0) then
                            state = 1   --mission 1
			elseif (result == 1) then
		       	    state = 2   --mission2
                        elseif (result == 2) then
                            SAY(" Sorry %PLAYER_NAME() , you have already completed this mission. ")
                            ENDDIALOG()
                        end
                else
                    SAY(" Please come back and see mee after you have finished your Oatmeal. ")
                    ENDDIALOG()
                end
        end
    end

-- StartNPC Poor Beggar

    NODE(1)
        SAY(" Dear Runner, I have not eaten in a very long time, can you spare me some food? ")
        ANSWER(" Sure, What can I get you? ", 3)
        ANSWER(" Shoo! Go away!", 2 )

    NODE(2)
        SAY(" I'm still starving! ")
        ENDDIALOG()

    NODE(3)
        SAY(" Can you bring me one "..qitemname01.." and a "..qitemname02.." to wash it down with? ")
        ANSWER(" Sure, comming right up", 10)
        ANSWER(" Get your own food!", 2)


--mission01
    NODE(10)
        STARTMISSION(mission01)
        SAY(" Please hurry, I'm dying here! ")
        SETNEXTDIALOGSTATE(15)
        ENDDIALOG()

    NODE(15)
        TAKEITEM(qitem01)
            if (result == 1) then
                SETNEXTDIALOGSTATE(16)
                SAY(" Give me "..qitemname01.." so I do not die of hunger please! ")
                ANSWER(" - Give the "..qitemname01.." - ", 16)
            else
                SAY(" You forgot to bring me the "..qitemname01.." , Do you think I can live on just air? " )
                SETNEXTDIALOGSTATE(15)
                ENDDIALOG()
            end

    NODE(16)
        TAKEITEM(qitem02)
            if (result == 1) then
                SETNEXTDIALOGSTATE(20)
                SAY(" HELP! The Tofu is stuck in my throat, Quick Runner, give me the "..qitemname02.." so I can wash it down! ")
                ANSWER(" - Give the "..qitemname02.." - ", 20)
            else
                SAY(" You forgot to bring the "..qitemname01.." , Good bye cruel life! " )
                SETNEXTDIALOGSTATE(15)
                ENDDIALOG()
                DIE()
            end


    NODE(20)
        SETDATA(missionflag,1)
        SAY(" Thank you Runner!, you have saved my life!\nI have something for you in return.\nTalk to me again when you are ready for another challenge.  ")
        ACTIVATEDIALOGTRIGGER(0)
        ENDDIALOG()



    NODE(32)
	STARTMISSION(mission02)
        SAY(" Please go and see Gerald Forsyte, he is waiting for you outside PP HQ." )
        SETNEXTDIALOGSTATE(75)
        ENDDIALOG()



-- Mission02
    NODE(75)
	SAY(" I'm busy, what do you want Runner? ")
	ANSWER(" A not to hungry man sent me. ", 76)
	ANSWER(" Nothing, wrong number, sorry",80 )


   NODE(76)
	SAY(" I want to you kill 10 "..killtarget01.." located in one of the Ceres Labs.\Do you think you are up for it? ")
	ANSWER(" - Hell yea, bring it baby!", 78)
	ANSWER(" - Hell NO!, I'm way to scared!", 90) 
	

   NODE(78)
	SAY(" Go now Runner, Hurry!)
	SETNEXTDIALOGSTATE(80)
	ENDDIALOG()

   NODE(80)
	IMISSIONTARGETACCOMPLISHED(0)
	    if (result==1) 
		SAY("Good Job runner, you removed some of those pesky "..killtarget01.."\nI hope you found something useful down there as well. ")
		SETNEXTDIALOGSTATE(82)
		ENDDIALOG()
	    else
		SAY("You have not killed enough "..killtarget01..", To hard for you?\Go now and don't comeback until you have killed some more! ")
		ENDDIALOG()
	    end
			 
    NODE(82)
	SETDATA(missionflag,2)
	SAY("Good job Runner!)
	GIVEMONEY(money)
	ACTIVATEDIALOGTRIGGER(0)
	ENDDIALOG()
	
    NODE(90)	
	SAY(" Have a nice day Runner. ")
	ENDDIALOG()
