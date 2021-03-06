--ＲＲ－リターン
function c120000249.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c120000249.condition)
	e1:SetTarget(c120000249.target)
	e1:SetOperation(c120000249.activate)
	c:RegisterEffect(e1)
end
function c120000249.filter(c,tp)
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE) and c:GetPreviousControler()==tp and c:IsControler(tp) 
	and c:IsSetCard(0xba) and c:IsAbleToHand()
end
function c120000249.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c120000249.filter,1,nil,tp)
end
function c120000249.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c120000249.filter(chkc,tp) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=eg:FilterSelect(tp,c120000249.filter,1,1,nil,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c120000249.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
