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



--- Missonitems
qitem01 = 1234
qitem02 = 4321

    function DIALOG()
        local missionflag="test_mission"
        local qitemname01="Tofu sausages in poisonous plant puree"
        local qitemname02="Warbot Cola"

-- missionflag=0 --> start misstion 1
-- missionflag=1 --> mission already completed


    NODE(0)
        if (state == node) then
            GETBASERANK()
                if (result >=30) then
                    GETDATA(missionflag)
                        if (result == 0) then
                            state = 1   --mission 1
                        elseif (result == 1) then
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

    NODE(10)
        STARTMISSION(mission01)
        SAY(" Please hurry, I'm dying here! ")
        SETNEXTDIALOGSTATE(15)
        ENDDIALOG()

    NODE(15)
        TAKEITEMCNT(qitem01,1)
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
        TAKEITEMCNT(qitem02,1)
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
        SAY(" Thank you Runner!, you have saved my life! ")
        ACTIVATEDIALOGTRIGGER(0)
        ENDDIALOG()
