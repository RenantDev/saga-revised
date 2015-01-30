-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 39;
local ReqClv = 8;
local ReqJlv = 0;
local NextQuest = 338;
local RewZeny = 165;
local RewCxp = 408;
local RewJxp = 160;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 3;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 3901);
	Saga.AddStep(cid, QuestID, 3902);
	Saga.AddStep(cid, QuestID, 3903);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1);
		Saga.GiveItem(cid, RewItem2, RewItemCount2);
		return 0;
	else
		return -1;
	end
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	--Talk with Misha Berardini
	Saga.AddWaypoint(cid, QuestID, 3901, 1, 1000);
	
	--check for completion
	local ret = Saga.GetNPCIndex(cid);
		if ret == 1000 then
			Saga.GeneralDialog(cid, 3936);
			Saga.SubstepComplete(cid, QuestID, 3901, 1);
		end
	end
	--check if all substeps are complete
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, 3901, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 3901);
	return 0;
end
function QUEST_STEP_2(cid)
	--Eliminate Hodemimes Blue Shark;Search Shark Coast floor for a Stone
	Saga.Eliminate(cid, QuestID, 3902, 10054, 7, 1);
	Saga.Eliminate(cid, QuestID, 3902, 10055, 7, 1);
	Saga.FindQuestItem(cid, QuestID, 3902, 16, 2844, 8000, 1, 2);
	
	if Saga.IsSubStepCompleted(cid, QuestID, 3902, 2) == false then
		Saga.UserUpdateActionObjectType(cid, QuestID, 3902, 16, 0);
	else
		Saga.UserUpdateActionObjectType(cid, QuestID, 3902, 16, 1);
	end
	
	--check if all substeps are complete
	for i = 1, 2 do
		if Saga.IsSubStepCompleted(cid, QuestID, 3902, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, 3902);
	return 0;
end

function QUEST_STEP_3(cid)
	--Report to Misha Berardini
	Saga.AddWaypoint(cid, QuestID, 3903, 1, 1000);
	
	--check for completion
	local ret = Saga.GetNPCIndex(cid);
	local ItemCount = Saga.CheckUserInventory(cid, 2844);
	if ret == 1000 then
		Saga.GeneralDialog(cid, 3936);
		if ItemCount > 0 then
			Saga.NpcTakeItem(cid, 2844, 1);
			Saga.SubstepComplete(cid, QuestID, 3903, 1);
		end
	end
	
	--check if all substeps are complete
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, 3903, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 3903);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;

	if CurStepID == 3901 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 3902 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 3903 then
		ret = QUEST_STEP_3(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return ret;
end
