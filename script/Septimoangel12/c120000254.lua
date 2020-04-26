--ジェムナイトレディ・ラピスラズリ
function c120000254.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,false,false,81846636,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1047))
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c120000254.damtg)
	e1:SetOperation(c120000254.damop)
	c:RegisterEffect(e1)
end
function c120000254.filter(c,cod)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave() and c:IsCode(cod)
end
function c120000254.ctfilter(c)
	return c:GetSummonLocation()==LOCATION_EXTRA
end
function c120000254.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local atk=c:GetAttack()
	if chk==0 then return Duel.IsExistingMatchingCard(c120000254.filter,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler():GetCode())
		and Duel.IsExistingMatchingCard(c120000254.ctfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c120000254.ctfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local dam=(ct*100)+(atk/2)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c120000254.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local co=c:GetCode()
	local atk=c:GetAttack()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c120000254.filter,tp,LOCATION_EXTRA,0,1,1,nil,e:GetHandler():GetCode())
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		local ct=Duel.GetMatchingGroupCount(c120000254.ctfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		local dam=(ct*100)+(atk/2)
		Duel.SetTargetPlayer(1-tp)
		Duel.Damage(p,dam,REASON_EFFECT)
	end
end
