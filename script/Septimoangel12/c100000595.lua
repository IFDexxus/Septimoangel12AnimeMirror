--無限
function c100000595.initial_effect(c)
	--Activate1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000595,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000595.cost)
	e1:SetTarget(c100000595.target1)
	e1:SetOperation(c100000595.operation1)
	c:RegisterEffect(e1)
	--Activate2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000595,1))
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c100000595.cost)
	e2:SetTarget(c100000595.target2)
	e2:SetOperation(c100000595.operation2)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(511001283)
	c:RegisterEffect(e3)
end
function c100000595.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.RegisterFlagEffect(tp,100000595,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
end
function c100000595.allfilter(c)
	return c:IsFaceup() and c:IsCode(100000594)
end
function c100000595.dfilter(c)
	return c:IsFaceup() and c:IsCode(100000590)
end
function c100000595.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	local dg=Duel.GetMatchingGroup(c100000595.allfilter,tp,LOCATION_SZONE,0,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_SZONE,0,1,e:GetHandler()) 
	 and Duel.IsExistingMatchingCard(c100000595.dfilter,tp,LOCATION_SZONE,0,1,nil) and dg:GetCount()==0 
	 and e:GetHandler():GetFlagEffect(1000005952)==0 and Duel.GetFlagEffect(tp,100000594)==0 end
	 e:GetHandler():RegisterFlagEffect(1000005951,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c100000595.operation1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local dg=Duel.GetMatchingGroup(c100000595.allfilter,tp,LOCATION_SZONE,0,nil)
	if dg:GetCount()==0 then
		local rg=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_SZONE,0,c)
		local tc=rg:Select(tp,1,1,nil):GetFirst()
		if tc then
			Duel.ChangePosition(tc,POS_FACEUP)
			local tpe=tc:GetType()
			local te=tc:GetActivateEffect()
			local co=te:GetCost()
			local cd=te:GetCondition()
			local tg=te:GetTarget()
			local op=te:GetOperation()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			Duel.ClearTargetCard()
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if Duel.IsDuelType(DUEL_OBSOLETE_RULING) then
					if fc then Duel.Destroy(fc,REASON_RULE) end
					fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
				else
					fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
						if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
				end
			end
			Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
			tc:CreateEffectRelation(te)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 and not tc:IsHasEffect(EFFECT_REMAIN_FIELD) then
				tc:CancelToGrave(false)
			end
			if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
			if cd then cd(te,tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
			Duel.BreakEffect()
			local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
			if g then
				local etc=g:GetFirst()
				while etc do
					etc:CreateEffectRelation(te)
					etc=g:GetNext()
				end
			end
			if op then op(te,tp,eg,ep,ev,re,r,rp) end
			tc:ReleaseEffectRelation(te)
			if etc then	
				etc=g:GetFirst()
				while etc do
					etc:ReleaseEffectRelation(te)
					etc=g:GetNext()
				end
			end	
		end	
	end	
end
function c100000595.cfilter(c)
	return not c:IsHasEffect(511001283) and c100000595.filter(c)
end
function c100000595.filter(c,minseq,maxseq)
	local seq=c:GetSequence()
	return c:IsFacedown() and c:CheckActivateEffect(true,true,false)~=nil and c:GetSequence()<5 
		and (not minseq or (seq>minseq and seq<maxseq))
end
function c100000595.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	local dg=Duel.GetMatchingGroup(c100000595.allfilter,tp,LOCATION_SZONE,0,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000595.cfilter,tp,LOCATION_SZONE,0,1,e:GetHandler()) 
	and Duel.IsExistingMatchingCard(c100000595.dfilter,tp,LOCATION_SZONE,0,1,nil) and dg:GetCount()>0 end
	e:GetHandler():RegisterFlagEffect(1000005951,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c100000595.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.RegisterFlagEffect(tp,100000590,RESET_CHAIN,0,1)
	if not Duel.IsExistingMatchingCard(c100000595.cfilter,tp,LOCATION_SZONE,0,1,c) then return end
	local dg=Duel.GetMatchingGroup(c100000595.allfilter,tp,LOCATION_SZONE,0,nil)
	if dg:GetCount()>0 then
		local minseq=c:GetSequence()
		local maxseq
		dg:ForEach(function(tc1)
			local seq=tc1:GetSequence()
			if not maxseq then
				maxseq=seq
				if minseq>maxseq then
					minseq,maxseq=maxseq,minseq
				end
			end
			if seq<minseq then
				minseq=seq
			end
			if seq>maxseq then
				maxseq=seq
			end
		end)
		sg=Duel.GetMatchingGroup(c100000595.filter,tp,LOCATION_SZONE,0,c,minseq,maxseq)
	end	
		if sg:GetCount()==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
		local ag1=sg:RandomSelect(tp,1,1,nil)
		local tc1=ag1:GetFirst()
		if sg:GetCount()==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
		local ag2=sg:RandomSelect(tp,1,1,tc1)
		local tc2=ag2:GetFirst()
		if sg:GetCount()==0 then return end
		local cg1=Group.FromCards(tc1,tc2)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
		local ag3=sg:Select(tp,1,1,cg1)
		local tc3=ag3:GetFirst()
		local cg2=Group.FromCards(tc1,tc2,tc3)
		Duel.ChangePosition(cg2,POS_FACEUP)
		if tc1 then
			tc1:RegisterFlagEffect(100000594,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
			local tpe=tc1:GetType()
			local te=tc1:GetActivateEffect()
			local co=te:GetCost()
			local cd=te:GetCondition()
			local tg=te:GetTarget()
			local op=te:GetOperation()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			Duel.ClearTargetCard()
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if Duel.IsDuelType(DUEL_OBSOLETE_RULING) then
					if fc then Duel.Destroy(fc,REASON_RULE) end
					fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc1,REASON_RULE) end
				else
					fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc1,REASON_RULE) end
				end
			end
			Duel.Hint(HINT_CARD,0,tc1:GetOriginalCode())
			tc1:CreateEffectRelation(te)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 and not tc1:IsHasEffect(EFFECT_REMAIN_FIELD) then
				tc1:CancelToGrave(false)
			end
			if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
			if cd then cd(te,tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
			Duel.BreakEffect()
			local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
			if g then
				local etc=g:GetFirst()
				while etc do
					etc:CreateEffectRelation(te)
					etc=g:GetNext()
				end
			end
			if op then op(te,tp,eg,ep,ev,re,r,rp) end
			tc1:ReleaseEffectRelation(te)
			if etc then	
				etc=g:GetFirst()
				while etc do
					etc:ReleaseEffectRelation(te)
					etc=g:GetNext()
			end
		end
	local dg=Duel.GetMatchingGroup(c100000595.allfilter,tp,LOCATION_SZONE,0,nil)
	if dg:GetCount()>0 then
		local minseq=c:GetSequence()
		local maxseq
		dg:ForEach(function(tc2)
			local seq=tc2:GetSequence()
			if not maxseq then
				maxseq=seq
				if minseq>maxseq then
					minseq,maxseq=maxseq,minseq
				end
			end
			if seq<minseq then
				minseq=seq
			end
			if seq>maxseq then
				maxseq=seq
			end
		end)
		sg=Duel.GetMatchingGroup(c100000595.filter,tp,LOCATION_SZONE,0,c,minseq,maxseq)
	end	
		if sg:GetCount()==0 then return end
		if tc2 then
			tc2:RegisterFlagEffect(100000594,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
			local tpe=tc2:GetType()
			local te=tc2:GetActivateEffect()
			local co=te:GetCost()
			local cd=te:GetCondition()
			local tg=te:GetTarget()
			local op=te:GetOperation()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			Duel.ClearTargetCard()
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if Duel.IsDuelType(DUEL_OBSOLETE_RULING) then
					if fc then Duel.Destroy(fc,REASON_RULE) end
					fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc2,REASON_RULE) end
				else
					fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc2,REASON_RULE) end
				end
			end
			Duel.Hint(HINT_CARD,0,tc2:GetOriginalCode())
			tc2:CreateEffectRelation(te)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 and not tc2:IsHasEffect(EFFECT_REMAIN_FIELD) then
				tc2:CancelToGrave(false)
			end
			if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
			if cd then cd(te,tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
			Duel.BreakEffect()
			local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
			if g then
				local etc=g:GetFirst()
				while etc do
					etc:CreateEffectRelation(te)
					etc=g:GetNext()
				end
			end
			if op then op(te,tp,eg,ep,ev,re,r,rp) end
			tc2:ReleaseEffectRelation(te)
			if etc then	
				etc=g:GetFirst()
				while etc do
					etc:ReleaseEffectRelation(te)
					etc=g:GetNext()
			end
		end	
	local dg=Duel.GetMatchingGroup(c100000595.allfilter,tp,LOCATION_SZONE,0,nil)
	if dg:GetCount()>0 then
		local minseq=c:GetSequence()
		local maxseq
		dg:ForEach(function(tc3)
			local seq=tc3:GetSequence()
			if not maxseq then
				maxseq=seq
				if minseq>maxseq then
					minseq,maxseq=maxseq,minseq
				end
			end
			if seq<minseq then
				minseq=seq
			end
			if seq>maxseq then
				maxseq=seq
			end
		end)
		sg=Duel.GetMatchingGroup(c100000595.filter,tp,LOCATION_SZONE,0,c,minseq,maxseq)
	end	
		if sg:GetCount()==0 then return end
		if tc3 then
			tc3:RegisterFlagEffect(100000594,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
			local tpe=tc3:GetType()
			local te=tc3:GetActivateEffect()
			local co=te:GetCost()
			local cd=te:GetCondition()
			local tg=te:GetTarget()
			local op=te:GetOperation()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			Duel.ClearTargetCard()
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if Duel.IsDuelType(DUEL_OBSOLETE_RULING) then
					if fc then Duel.Destroy(fc,REASON_RULE) end
					fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc3,REASON_RULE) end
				else
					fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc3,REASON_RULE) end
				end
			end
			Duel.Hint(HINT_CARD,0,tc3:GetOriginalCode())
			tc3:CreateEffectRelation(te)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 and not tc3:IsHasEffect(EFFECT_REMAIN_FIELD) then
				tc3:CancelToGrave(false)
			end
			if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
			if cd then cd(te,tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
			Duel.BreakEffect()
			local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
			if g then
				local etc=g:GetFirst()
				while etc do
					etc:CreateEffectRelation(te)
					etc=g:GetNext()
				end
			end
			if op then op(te,tp,eg,ep,ev,re,r,rp) end
			tc3:ReleaseEffectRelation(te)
			if etc then	
				etc=g:GetFirst()
				while etc do
					etc:ReleaseEffectRelation(te)
					etc=g:GetNext()
					end
				end
			end
		end	
	end
end
