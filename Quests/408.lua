-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 408;
local ReqClv = 6;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 83;
local RewCxp = 224;
local RewJxp = 91;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 51500003;
local RewItemCount1 = 2;
local RewItemCount2 = 7;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 40801);
	Saga.AddStep(cid, QuestID, 40802);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1);
		Saga.GiveItem(cid, RewItem2, RewItemCount2);
		return 0;
	else
		Saga.EmptyInventory(cid);
		return -1;
	end
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	-- Capture a Marine Sphere Imago (5)
	Saga.FindQuestItem(cid, QuestID, StepID, 10042, 4217, 8000, 5, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10043, 4217, 8000, 5, 1);
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return -1;
end

function QUEST_STEP_2(cid)
	-- Hand in to Kafra Board Mailbox
	local ret = Saga.GetActionObjectIndex(cid);
	if ret == 1123 then
		local ItemCountA = Saga.CheckUserInventory(cid, 4217);
		if ItemCountA > 4 then
			Saga.NpcTakeItem(cid, 4217, 5);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		else
			Saga.ItemNotFound(cid);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	Saga.ClearWaypoints(cid, QuestID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 40801 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 40802 then
		ret = QUEST_STEP_2(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
