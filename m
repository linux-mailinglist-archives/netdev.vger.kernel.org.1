Return-Path: <netdev+bounces-300670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rLr5IdcPNWoWmgYAu9opvQ
	(envelope-from <netdev+bounces-300670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:45:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D848F6A5071
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:45:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=AxPMmZwk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300670-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300670-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA2C93032778
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDCA367B85;
	Fri, 19 Jun 2026 09:45:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2019A357A3E;
	Fri, 19 Jun 2026 09:45:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862356; cv=none; b=M+RWwpi1UIIthJvD2tZQF9hxYaQacH56TSR/Y5tBszrh9nyWN9N6DgzW9lR73KX+WkEGBhoD4tFTpZ5gaOMl2DMWLmuzn1vBPC+7IgRPTalnumbFvLkILE8befgQc2Qukb1drsTtjlixWYyoJqe7GopfSxpyTkyXTeGqRY1gglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862356; c=relaxed/simple;
	bh=bLySxgl/bdsnBUBifgDYVTYzJv6fFMLMrWtGBQuLbaM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJUZ9c/aRXW+DurkEf3OZbo/eY5u7qcxQwS7fwhnJZ+bUn9IaNFX7eUCDc86an1gmamteRC6FoAwCY8xjnPrOW5Z11vj3Er1XVULgA6oByVaYpyGjI1bfHpF96Otqa0c+SkFXogXLPFM6xQO/M/aQIBgPg0YrZOTUg3Og/kAh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AxPMmZwk; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7QvWI1746527;
	Fri, 19 Jun 2026 02:45:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=UQa/vuRTQ6NZvTvYIHCQxmx5+
	rjPCt9Hg8V8E7/9rYs=; b=AxPMmZwkTHE00OzSiao23l7/ssI6rUjYbaVJza7T7
	+wI9LJks3DpDHmBRj5g0lAaj6K9/ZKIfsg8S3245IkOhXeGPUo8ItcNGUbSYLlV9
	DjNW7KS1e/1GHTKDbzNaNuS7gZEbBBYSgXSj10S1y66qVjF4c0clk1uCWEl61dMS
	R9dgD4wjZvrsMkAwrTX02S2TtGD9dGSKgDrJdyczp7T52Zo2NwYfOBfjTu6cQVhj
	cXdZGCK+ELngTUM9RTyE/3Lv6Q9bJlIZ+aeBsC8NkY38Wg97ENbwIpKysnjkNmPs
	CjiaFJGWG7UbWuaPPoidGzieQV71ZpQ/SPs+fUaFwZC2w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ev59ddh0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 02:45:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 19 Jun 2026 02:45:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 19 Jun 2026 02:45:38 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 487D05B692E;
	Fri, 19 Jun 2026 02:45:36 -0700 (PDT)
Date: Fri, 19 Jun 2026 15:15:35 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <sgoutham@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: npc: cn20k: Fix subbank free list
 indexing for search order
Message-ID: <ajUPv7eg670c2W9v@rkannoth-OptiPlex-7090>
References: <20260618035926.1490794-1-rkannoth@marvell.com>
 <20260619091341.918165-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260619091341.918165-1-horms@kernel.org>
X-Proofpoint-GUID: JWYPfhyCsJV1OYRzMIpwe1E9CxvIdl3G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA5MCBTYWx0ZWRfX/UimB/+VNtCE
 DPWvIQWV/LV9cwpuFKro0v4WQwSrzd/QdaeBQwdm0hm+z6iTodxUNf0hrVrNNbTRYqkem1mmAZ0
 Bv+E2NUQYk1LApikI+aNNLxuWPnLAtuUJMSt2XTEhwwCdSWaw3CZ0jw299bPmvbZBjSQdwL1X/L
 HXddNxOkHUbDU7tT54to/8FIXtZZCXAWLJxMRCl/9Jbcdp7nZoMfuDT26yhgnZHT71NVs6KyxNS
 xjVbDRX+d3fg4nUTp7WjNsO2DRmBUmFQYzLM33yQUvpeXflSnyUowIq3ud4hVKZXb+KZiMNRnaJ
 W7yMqyjRqrqiKLypB/nwJgwafU/WrU1GfPmftei/ilvOwcKdCe0WONxI3dp9H2fozQrAy8n0WyA
 Y+B9txafVkfXgu772Z52sjwo3Igmzck1xjZAfJlE6KbxxqE6lIY5gctRJHr/bNqzxAAhdMVOrd6
 a6RLPAYI+79So87e80w==
X-Authority-Analysis: v=2.4 cv=c4Cbhx9l c=1 sm=1 tr=0 ts=6a350fc4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=VwQbUJbxAAAA:8 a=NZriviDRHQyHBaRo1GIA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: JWYPfhyCsJV1OYRzMIpwe1E9CxvIdl3G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA5MCBTYWx0ZWRfX/Oj0r7skMd6G
 TiTLXuF0FgRG16NVIReTU/7hRMDrlH6J8BaHrZd3MB/kGOpoy3FriL4K/CmapjGqiWK2enWcqOd
 JiwLqhp1790A6fGL3LYBXS9W7BW/Sx4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300670-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:dkim,marvell.com:from_mime];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D848F6A5071

On 2026-06-19 at 14:43:41, Simon Horman (horms@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> octeontx2-af: npc: cn20k: Fix subbank free list indexing for search order
>
> This change re-keys the xa_sb_free free list using each subbank's slot
> in subbank_srch_order[] rather than using subbank_srch_order[sb->idx],
> moving the population into a new helper called from npc_priv_init().
> A few comments inline.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > index 354c4e881c6a..d38e848add93 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > @@ -3423,6 +3423,36 @@ static int npc_create_srch_order(int cnt)
> >  	return 0;
> >  }
> >
> > +static int npc_subbanks_srch_oder_init(struct rvu *rvu)
>                                 ^^^^
>
> [Low]
> Is "oder" intended here? The neighbouring identifiers
> npc_create_srch_order() and subbank_srch_order use "order", so this
> appears to be a typo that would be easier to fix before the symbol
> lands.
>
> > +{
> > +	struct npc_subbank *sb;
> > +	int sb_idx;
> > +	int i, j;
> > +	int rc;
> > +
> > +	for (i = 0; i < npc_priv->num_subbanks; i++) {
> > +		sb_idx = subbank_srch_order[i];
> > +		sb = &npc_priv->sb[sb_idx];
> > +		sb->arr_idx = i;
> > +
> > +		dev_dbg(rvu->dev, "%s: sb->idx=%u sb->arr_idx=%u\n",
> > +			__func__, sb->idx, sb->arr_idx);
> > +
> > +		rc = xa_err(xa_store(&npc_priv->xa_sb_free, sb->arr_idx,
> > +				     xa_mk_value(sb->idx), GFP_KERNEL));
> > +		if (rc) {
> > +			dev_err(rvu->dev,
> > +				"%s: xa_store(xa_sb_free) failed at slot %d (sb=%d): %d\n",
> > +				__func__, i, sb_idx, rc);
> > +			for (j = 0; j < i; j++)
> > +				xa_erase(&npc_priv->xa_sb_free, j);
> > +			return rc;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
>
> [ ... ]
>
> > @@ -4727,6 +4748,10 @@ static int npc_priv_init(struct rvu *rvu)
> >  	for (i = 0, sb = npc_priv->sb; i < num_subbanks; i++, sb++)
> >  		npc_subbank_init(rvu, sb, i);
> >
> > +	ret = npc_subbanks_srch_oder_init(rvu);
> > +	if (ret)
> > +		goto fail2;
> > +
>
> [Medium]
> Can this leak subbank_srch_order on the new failure path?
>
> npc_create_srch_order() allocates subbank_srch_order via kcalloc().
> Before this patch, the only way to reach fail2 was when
> npc_create_srch_order() itself failed and left subbank_srch_order
> NULL, so fail2 not freeing it was safe.
>
> With this new goto fail2, subbank_srch_order has already been
> allocated, but the fail2 label only frees npc_priv->sb and npc_priv:
>
> fail2:
> 	xa_destroy(&npc_priv->xa_sb_used);
> 	[...]
> 	kfree(npc_priv->sb);
> 	npc_priv->sb = NULL;
> fail1:
> 	kfree(npc_priv);
> 	npc_priv = NULL;
> 	return ret;
>
> A subsequent re-init would unconditionally reassign
> subbank_srch_order = kcalloc(...) in npc_create_srch_order(),
> permanently leaking the previous buffer.
>
> Should this path go to a new label that also kfree()s
> subbank_srch_order, or should fail2 free it?
>
> >  	/* Get number of pcifuncs in the system */
> >  	npc_priv->pf_cnt = npc_pcifunc_map_create(rvu);
> >  	npc_priv->xa_pf2idx_map = kcalloc(npc_priv->pf_cnt,
>
> [High]
> Can npc_priv_init() return 0 on a real failure here?
>
> After npc_subbanks_srch_oder_init() returns successfully, ret is 0.
> If the kcalloc() for npc_priv->xa_pf2idx_map fails right after, the
> code does goto fail3 which falls through fail2 and fail1 to
> return ret, propagating 0 to the caller:
>
> fail3:
> 	kfree(subbank_srch_order);
> 	subbank_srch_order = NULL;
>
> fail2:
> 	[...]
> fail1:
> 	kfree(npc_priv);
> 	npc_priv = NULL;
> 	return ret;
>
> The caller npc_cn20k_init() then sees err == 0 and continues into
> npc_setup_mcam_section(), which dereferences npc_priv (now NULL).
>
> Pre-patch the function ended in return -ENOMEM, so the fail3 path
> returned -ENOMEM unconditionally. Should ret be reset to -ENOMEM
> before goto fail3, or should a separate variable be used for the
> new helper's return value?
>
> > @@ -4760,7 +4785,7 @@ static int npc_priv_init(struct rvu *rvu)
> >  fail1:
> >  	kfree(npc_priv);
> >  	npc_priv = NULL;
> > -	return -ENOMEM;
> > +	return ret;
> >  }

ACK for all.

pw-bot: changes-requested

