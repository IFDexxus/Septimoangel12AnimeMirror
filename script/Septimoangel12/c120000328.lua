--SRタケトンボーグ
function c120000328.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(120000328,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c120000328.spcon)
	c:RegisterEffect(e1)
end
function c120000328.spfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND)
end
function c120000328.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c120000328.spfilter,tp,LOCATION_ONFIELD,0,1,nil)
end