--ダークネス ３
function c100000593.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000593.damcost)
	e1:SetCondition(c100000593.damcon)
	e1:SetTarget(c100000593.damtg)
	e1:SetOperation(c100000593.damop)
	c:RegisterEffect(e1)
end
function c100000593.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.RegisterFlagEffect(tp,100000593,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
end
function c100000593.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.CheckChainUniqueness() and (Duel.GetFlagEffect(tp,100000591)==0 or Duel.GetFlagEffect(tp,100000592)==0)
end
function c100000593.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,100000591)==0 or e:GetHandler():GetFlagEffect(100000594)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
	Duel.RegisterFlagEffect(tp,100000593,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
end
function c100000593.damop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,100000591)~=0 or Duel.GetFlagEffect(tp,100000592)~=0 or e:GetHandler():GetFlagEffect(100000594)==0 then return end 
	if e:GetHandler():GetFlagEffect(100000594)==0 then return end
		if Duel.Damage(1-tp,1000,REASON_EFFECT) then 
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_CHAIN_SOLVING)
			e1:SetRange(LOCATION_SZONE)
			e1:SetOperation(c100000593.dmop)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
	end
end
function c100000593.dmop(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and (re:GetCode(100000591) or re:GetCode(100000592) or re:GetCode(100000593)) and e:GetHandler():GetFlagEffect(1)>0 then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end
