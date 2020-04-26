--ダークネス ２
function c100000592.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000592.atkcost)
	e1:SetCondition(c100000592.atkcon)
	e1:SetTarget(c100000592.atktg)
	e1:SetOperation(c100000592.atkop)
	c:RegisterEffect(e1)
end
function c100000592.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.RegisterFlagEffect(tp,100000592,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
end
function c100000592.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.CheckChainUniqueness() and (Duel.GetFlagEffect(tp,100000591)==0 or Duel.GetFlagEffect(tp,100000593)==0)
end
function c100000592.cfilter(c)
	return c:IsFaceup() and (c:IsCode(100000591) or c:IsCode(100000592) or c:IsCode(100000593))
end
function c100000592.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c100000592.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.GetFlagEffect(tp,100000591)==0 or Duel.GetFlagEffect(tp,100000593)==0 or e:GetHandler():GetFlagEffect(100000594)~=0 
	 and Duel.IsExistingMatchingCard(c100000592.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	 Duel.RegisterFlagEffect(tp,100000592,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
end
function c100000592.atkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,100000591)~=0 or Duel.GetFlagEffect(tp,100000593)~=0 or e:GetHandler():GetFlagEffect(100000594)==0 then return end 
	local cc=Duel.GetMatchingGroupCount(c100000592.cfilter,tp,LOCATION_ONFIELD,0,nil)
	if e:GetHandler():GetFlagEffect(100000594)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectMatchingCard(tp,c100000592.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	local tg1=g1:GetFirst()
	if tg1 and tg1:IsFaceup() and e:GetHandler():GetFlagEffect(100000594)~=0 and not tg1:IsImmuneToEffect(e) then	
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tg1:RegisterEffect(e1)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g2=Duel.SelectMatchingCard(tp,c100000592.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
		local tg2=g2:GetFirst()
		if tg2 and cc>0 then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetValue(cc*1000)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tg2:RegisterEffect(e2)
		end
	end
end		