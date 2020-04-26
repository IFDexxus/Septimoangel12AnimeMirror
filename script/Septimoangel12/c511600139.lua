--一撃必殺！居合いドロー
function c511600139.initial_effect(c)
	--discard deck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511600139.condition)
	e1:SetCost(c511600139.cost)
	e1:SetTarget(c511600139.target)
	e1:SetOperation(c511600139.operation)
	c:RegisterEffect(e1)
end
function c511600139.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)>0
end
function c511600139.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroupCount(c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>g and Duel.IsPlayerCanDiscardDeckAsCost(tp,g) end
	Duel.DiscardDeck(tp,g,REASON_COST)
end
function c511600139.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511600139.dfilter(c)
	return c:IsDestructable()
end
function c511600139.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local ct=Duel.GetDecktopGroup(tp,1)
	local tc=ct:GetFirst()
	if Duel.Draw(p,d,REASON_EFFECT) then
		local tc=Duel.GetOperatedGroup():GetFirst()
		Duel.ConfirmCards(1-tp,tc)
		if tc:IsCode(71344451) then
			Duel.BreakEffect()
			if Duel.SendtoGrave(tc,REASON_COST)>0 and tc:IsLocation(LOCATION_GRAVE) then
				local dg=Duel.GetMatchingGroup(c511600139.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
				cd=Duel.Destroy(dg,REASON_EFFECT)
				if cd>0 then
					Duel.Damage(1-tp,cd*1000,REASON_EFFECT)
				end		
			end
	else	
		Duel.ShuffleHand(tp)	
		end			
	end
end