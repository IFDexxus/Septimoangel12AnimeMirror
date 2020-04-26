--ダークネス・ネオスフィア
function c120000100.initial_effect(c)
	c:EnableUnsummonable()
	--Gains effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c120000100.codeop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--Set 1 Spell/Trap card
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(120000100,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_ONFIELD)
	e4:SetCountLimit(1)
	e4:SetTarget(c120000100.actg)
	e4:SetOperation(c120000100.acop)
	c:RegisterEffect(e4)
	--Set Spell/Trap cards
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(120000100,1))
	e5:SetCategory(CATEGORY_POSITION)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_ONFIELD)
	e5:SetCountLimit(1)
	e5:SetCondition(c120000100.setcon)
	e5:SetOperation(c120000100.setop)
	c:RegisterEffect(e5)
	--lp4000
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetCountLimit(1)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTarget(c120000100.lptg)
	e6:SetOperation(c120000100.lpop)
end
function c120000100.codeop(e,tp,eg,ep,ev,re,r,rp)	
	e:GetHandler():CopyEffect(100000701,RESET_EVENT+0x1fe0000)
end
function c120000100.filter(c)
	return c:IsFaceup() and (c:IsType(TYPE_SPELL+TYPE_TRAP) or c:IsType(TYPE_FIELD))
end
function c120000100.actg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and c120000100.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c120000100.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c120000100.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
end
function c120000100.acop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEDOWN)
	end
end
function c120000100.setfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:GetSequence()~=5 and not c:IsStatus(STATUS_CHAINING) 
end
function c120000100.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c120000100.setfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
end
function c120000100.setop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c120000100.setfilter,tp,LOCATION_ONFIELD,0,nil)	
	local g2=Duel.GetMatchingGroup(c120000100.setfilter,tp,0,LOCATION_ONFIELD,nil)
	local opt=0
	if g1:GetCount()>0 and g2:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(120000100,2),aux.Stringid(120000100,3))
	elseif g1:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(120000100,2))	
	elseif g2:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(120000100,3))+1	
	else return end
	if opt==0 then
		local tc=g1:GetFirst()
		while tc do
			Duel.ChangePosition(tc,POS_FACEDOWN)
			Duel.RaiseEvent(tc,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
			tc=g1:GetNext()
		end	
			local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_SZONE,0,nil)
			Duel.ShuffleSetCard(g)
	else
		local tc=g2:GetFirst()
		while tc do
			Duel.ChangePosition(tc,POS_FACEDOWN)
			Duel.RaiseEvent(tc,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
			tc=g2:GetNext()
		end
		local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_SZONE,nil)
		Duel.ShuffleSetCard(g)
	end
end
function c120000100.lptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLP(tp)<4000 end
	Duel.SetTargetPlayer(tp)
end
function c120000100.lpop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.SetLP(p,4000)
end