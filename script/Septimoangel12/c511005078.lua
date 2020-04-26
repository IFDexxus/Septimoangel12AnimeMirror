--奇跡の銀河
function c511005078.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23118924,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511005078.condition1)
	e1:SetTarget(c511005078.target1)
	e1:SetOperation(c511005078.operation1)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6430659,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c511005078.condition2)
	e2:SetTarget(c511005078.target2)
	e2:SetOperation(c511005078.operation2)
	c:RegisterEffect(e2)
	if not c511005078.global_check then
		c511005078.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DAMAGE)
		ge1:SetOperation(c511005078.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511005078.checkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(ep,511005078,RESET_PHASE+PHASE_END,0,1)
end
function c511005078.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,511005078)==0 and Duel.GetCurrentPhase()==PHASE_MAIN2 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c511005078.filter1(c)
	return c:IsFaceup() and c:IsPosition(POS_FACEUP_ATTACK) and c:IsAttackable() and not (c:IsHasEffect(EFFECT_CANNOT_ATTACK) 
		or c:IsHasEffect(EFFECT_CANNOT_ATTACK_ANNOUNCE))
end
function c511005078.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511005078.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c511005078.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	local g2=Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
	g1:Merge(g2)
end
function c511005078.operation1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()==2 then
		Duel.CalculateDamage(g:GetFirst(),g:GetNext())
	end
end
function c511005078.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,511005078)==0 and Duel.GetCurrentPhase()==PHASE_MAIN2 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)==0
end
function c511005078.filter2(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and not (c:IsHasEffect(EFFECT_CANNOT_ATTACK) or c:IsHasEffect(EFFECT_CANNOT_DIRECT_ATTACK)
	or c:IsHasEffect(EFFECT_CANNOT_ATTACK_ANNOUNCE)) 
end
function c511005078.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511005078.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511005078.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetFirst():GetAttack())
end
function c511005078.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetAttack()>0 then
		Duel.Damage(1-tp,tc:GetAttack(),REASON_BATTLE)
		Duel.RaiseSingleEvent(tc,EVENT_BATTLE_DAMAGE,e,REASON_BATTLE,0,1-tp,tc:GetAttack())
	end
end