--ＴＧ ワーウルフ BW-03
function c513000181.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(513000181,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c513000181.spcon)
	e1:SetTarget(c513000181.sptg)
	e1:SetOperation(c513000181.spop)
	c:RegisterEffect(e1)
	--Type Machine
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_ADD_RACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(RACE_MACHINE)
	c:RegisterEffect(e2)
	--Half stats
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95100034,4))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c513000181.discon)
	e3:SetOperation(c513000181.disop)
	c:RegisterEffect(e3)
	--Add to hand
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(c513000181.scon)
	e4:SetTarget(c513000181.stg)
	e4:SetOperation(c513000181.sop)
	c:RegisterEffect(e4)
end
function c513000181.cfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLevelBelow(2)
end
function c513000181.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c513000181.cfilter,1,nil,tp)
end
function c513000181.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c513000181.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c513000181.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsContains(c) and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and c:IsRace(RACE_MACHINE) and (re:GetHandler():IsCode(63995093) 
	or re:GetHandler():IsCode(12503902) or re:GetHandler():IsCode(63851864) or re:GetHandler():IsCode(42237854) or re:GetHandler():IsCode(63995093)
	or re:GetHandler():IsCode(7030340) or re:GetHandler():IsCode(35220244) or re:GetHandler():IsCode(511600009) or re:GetHandler():IsCode(511002887)
	or re:GetHandler():IsCode(511002568) or re:GetHandler():IsCode(511001883) or re:GetHandler():IsCode(511002308) or re:GetHandler():IsCode(511001762))
	--This list must continue to be updated
end
function c513000181.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c:GetBaseAttack()/2)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(c:GetBaseDefense()/2)
		c:RegisterEffect(e2)
	end
end
function c513000181.scon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c513000181.sfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x27) and c:IsAbleToHand()
end
function c513000181.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000181.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c513000181.sop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c513000181.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		local e1 = Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_FORBIDDEN)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		g:GetFirst():RegisterEffect(e1)
	end
end