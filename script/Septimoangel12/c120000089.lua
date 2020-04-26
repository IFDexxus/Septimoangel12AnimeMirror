--ヒロイック・チャンス
function c120000089.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(120000089,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c120000089.condition)
	e1:SetTarget(c120000089.target)
	e1:SetOperation(c120000089.activate)
	c:RegisterEffect(e1)
end
function c120000089.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=500
end
function c120000089.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6f)
end
function c120000089.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c120000089.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c120000089.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c120000089.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c120000089.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
