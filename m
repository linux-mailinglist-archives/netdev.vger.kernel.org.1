Return-Path: <netdev+bounces-264792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDZ4Ng7Vqmn3XQEAu9opvQ
	(envelope-from <netdev+bounces-264792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:22:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4474822182B
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 880BC304DF36
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92296395DBD;
	Fri,  6 Mar 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps3EKqWC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDEC3921F7;
	Fri,  6 Mar 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803307; cv=none; b=u/upxDAHmsMufo1LUkHQH/7jFMgVYThwyE8Ia4SGTphodBf0Lj/VvQQSO0cd5p+Xmq796y3+Z0Ebaln3uvztLKDXA2L7DkmhCMM5VpO77+j2xyq7KcUlJZhsXnot7YChP/SI9bBMzPTjYjey7cKj7WnO5V2ePLXFiT5rnKmFq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803307; c=relaxed/simple;
	bh=sRHh/goBaDgsO7ewiIRPSxblhZxCN3oupcr+eYv2xM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUmSDrYZCsa7A/97yTAMO6jiXBPnUtisOxPLxuKBGly5+w/Vj5Ur7o6T6kgdeTqRpvH2STjEtNfLIOsVOHgkgAGCGqG7czHXfUFzZHvedlPUVMhriXMlMlM0Os9Me+f23GYDpmFTGMBJexCZc8guG5vyP750VkQdV1KCbTMhE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps3EKqWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DECDC2BC87;
	Fri,  6 Mar 2026 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772803307;
	bh=sRHh/goBaDgsO7ewiIRPSxblhZxCN3oupcr+eYv2xM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ps3EKqWCzvbTz+QHoz/rFkHZY73w6I9pAkJ3XEOABo4ucZaScJnTa2QLCuB90jVHp
	 ot6BO9gvADoPuzhEW2/Vy8zKr6pPT1GhVbSpPZV3tWKzHaKa5sbKmQz1PeqDajrzm2
	 5NoR+Z56ZQiYAo/mWLjf9VmHOlfTGPyjCVGPuSq7G/R42cXELtGe2HAosYkqUbwt9+
	 430nujgGe9CSUXcnSbcUR/q2fGsBpRaOuRfnstQUnHi+H3LsS8PhA0jeS4o4y4hvFQ
	 SawBosBQFeB2ZnBZKYQnirfyFY1IRPUD7w7nlSuQ709VStcn07RGiqzSh8vmc+98Hn
	 VVBCa6bCWxyxg==
Date: Fri, 6 Mar 2026 13:21:41 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
	jiri@resnulli.us, chuck.lever@oracle.com, matttbe@kernel.org,
	cjubran@nvidia.com, shshitrit@nvidia.com
Subject: Re: [PATCH net-next 4/5] cteontx2-af: npc: cn20k: dynamically
 allocate and free default MCAM entries
Message-ID: <20260306132141.GC461701@kernel.org>
References: <20260302085803.2449828-1-rkannoth@marvell.com>
 <20260302085803.2449828-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302085803.2449828-5-rkannoth@marvell.com>
X-Rspamd-Queue-Id: 4474822182B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264792-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 02:28:02PM +0530, Ratheesh Kannoth wrote:

...

> @@ -4220,21 +4242,46 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
>  		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
>  		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
>  		if (!map)
> -			dev_dbg(rvu->dev,
> +			dev_err(rvu->dev,
>  				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
>  				__func__, npc_dft_rule_name[i],
>  				pcifunc);
>  	}
>  
>  free_rules:
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +	if (blkaddr < 0)
> +		return;
>  
> -	free_req.hdr.pcifunc = pcifunc;
> -	free_req.all = 1;
> -	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
> -	if (rc)
> -		dev_err(rvu->dev,
> -			"%s: Error deleting default entries (pcifunc=%#x\n",
> -			__func__, pcifunc);
> +	for (int i = 0; i < 4; i++) {
> +		if (ptr[i] == USHRT_MAX)
> +			continue;
> +
> +		mutex_lock(&mcam->lock);
> +		npc_mcam_clear_bit(mcam, ptr[i]);
> +		mcam->entry2pfvf_map[ptr[i]] = NPC_MCAM_INVALID_MAP;
> +		npc_cn20k_enable_mcam_entry(rvu, blkaddr, ptr[i], false);
> +		mcam->entry2target_pffunc[ptr[i]] = 0x0;
> +		mutex_unlock(&mcam->lock);
> +
> +		rc = npc_cn20k_idx_free(rvu, &ptr[i], 1);
> +		if (rc)
> +			dev_err(rvu->dev,
> +				"%s:%d Error deleting default entries (pcifunc=%#x) mcam_idx=%u\n",
> +				__func__, __LINE__, pcifunc, ptr[i]);
> +	}
> +
> +	mutex_lock(&mcam->lock);
> +	list_for_each_entry_safe(rule, tmp, &mcam->mcam_rules, list) {
> +		for (int i = 0; i < 4; i++) {
> +			if (ptr[i] != rule->entry)
> +				continue;

Hi Ratheesh,

I assume that the condition above should match exactly once
for each iteration of the for loop. But if not rule may
either not be freed or freed twice.

Would it make sense to move freeing rule to outside the for loop?
I think this would address both problems. But perhaps it leads
to rule being freed when it should not be.

Alternatively, should there be a break after the call to kfree()?
I think that would address only the (theoretical possibility of) a double
free.

Flagged by Smatch.

> +
> +			list_del(&rule->list);
> +			kfree(rule);
> +		}
> +	}
> +	mutex_unlock(&mcam->lock);
>  }

...

