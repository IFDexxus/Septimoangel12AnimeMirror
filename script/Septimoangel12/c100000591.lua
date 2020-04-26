--ダークネス １
function c100000591.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000591.descost)
	e1:SetCondition(c100000591.descon)
	e1:SetTarget(c100000591.destg)
	e1:SetOperation(c100000591.desop)
	c:RegisterEffect(e1)
end	
function c100000591.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.RegisterFlagEffect(tp,100000591,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
end
function c100000591.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.CheckChainUniqueness() and (Duel.GetFlagEffect(tp,100000592)==0 or Duel.GetFlagEffect(tp,100000593)==0)
end
function c100000591.cfilter(c)
	return c:IsFaceup() and (c:IsCode(100000591) or c:IsCode(100000592) or c:IsCode(100000593))
end
function c100000591.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.GetFlagEffect(tp,100000592)==0 or Duel.GetFlagEffect(tp,100000593)==0 
	 or e:GetHandler():GetFlagEffect(100000594)~=0 and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) end
	local cc=Duel.GetMatchingGroupCount(c100000591.cfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,cc,0,0)
	Duel.RegisterFlagEffect(tp,100000591,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
end
function c100000591.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,100000592)~=0 or Duel.GetFlagEffect(tp,100000593)~=0 or e:GetHandler():GetFlagEffect(100000594)==0 then return end 
	if Duel.GetMatchingGroupCount(Card.IsDestructable,tp,0,LOCATION_ONFIELD,nil)==0 and e:GetHandler():GetFlagEffect(100000594)==0 then return end
		g1=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,1,nil)
		if Duel.Destroy(g1,REASON_EFFECT)>0 then	
		local cc=Duel.GetMatchingGroupCount(c100000591.cfilter,tp,LOCATION_ONFIELD,0,e:GetHandler())
		if Duel.GetMatchingGroupCount(Card.IsDestructable,tp,0,LOCATION_ONFIELD,nil)>=cc then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local g2=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,cc,cc,nil)
			Duel.Destroy(g2,REASON_EFFECT)
		end	
	end
end
