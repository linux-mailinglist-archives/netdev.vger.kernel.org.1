Return-Path: <netdev+bounces-280964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PhSFDop62mPJQAAu9opvQ
	(envelope-from <netdev+bounces-280964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:26:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B75BB45B740
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93EF530120C9
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781832A3FD;
	Fri, 24 Apr 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Wwn7wEhn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9C244687;
	Fri, 24 Apr 2026 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019191; cv=none; b=dvdPO7K9CFE5XEfoSiyTbkySIf/opRY8haxkAB5Zp2Oy1Y6aYn+DAgtHleMOqY1thjnB+sIpMq7+QDZPlxiEoBzdhTOUGCr+Sr1ja+KRAHodQ3KmVgHZb650pMwUEWhYMXvS2TEGZ0oQOOhsGOwIAXdDO7Y5XX8nvYrN3RBjBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019191; c=relaxed/simple;
	bh=r6UwaujmmA34X05ARd2oY0WcRCAWhL4Vghc8FhMyeTo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3UC4f+HjPAxs1nzLqgkeJDxMiZKe1eWmrqSf8xXLnyDggWJWT86U/sg+3DByLVnQVMUW9LAyFutSXAl4CWu2Rga9n6zz0xShT8GD1fxwotwY5iu4pWFpM3d1QbWNukTEjIhtjGcIFovdNcSCKuweJ8QUGLPzuuDdcEMMd39QAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Wwn7wEhn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O771V11922659;
	Fri, 24 Apr 2026 01:26:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=TLDmDwIinwnU1WuZsd+E6cxzH
	IjQG9Et0UwIndVSXNY=; b=Wwn7wEhnDlay2+8HnPNZfHcF1Y8YWftLgxQBGqRTg
	VxCkvBlkQnYmBd+gxz3+N9HEBKER9AP+NDhKbx3YmI4BkFsLCtqQMTEli0jYjqhJ
	83i7bivBMPimPkI3T6+jb1KtoV7+mW/3Bgl1sBriTR3EeS5m0r3EqMujy5FA2Y7U
	93w13OH8qZb3ZtJ80IqdP77QyeSuKumf69RKhlWQmad0uLenlfWQvFjcsSfpZieK
	XNH1AIiS85l76PePlRN6HXXfaC2BQLCt6LSl19Mkw3kPCKzW4hmZ9Ps9GO/FvBDk
	yh8Y5W0IhiFIQVpEeT8Jw+ndCAmfSK82cjxL5I0dpj/QQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dqc06ur7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 01:26:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Apr 2026 01:26:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Apr 2026 01:26:19 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 5EAB83F7082;
	Fri, 24 Apr 2026 01:26:16 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:56:15 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v3 net 04/11] octeontx2-af: npc: cn20k: Make default
 entries as x4.
Message-ID: <aespJ5nvW-pfeMFo@rkannoth-OptiPlex-7090>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
 <20260423104317.2707923-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423104317.2707923-5-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NyBTYWx0ZWRfX2aYmJPhjouVE
 SkLf0/gW5BU2FlU30I3L/vrajzvsoRHr3O49mGXa2Wlu7l2O1EXdbR8RgKcmQeoa7QKCwnoUxS0
 80u7ycVCT49cnCFjEyhgHUDoDydjkE+Red3ol6ZYnIudMGDoOzzmpqh368qaSjnBIzhS884sE79
 9uSYxiAMZHhacfGANiHHFEsD1o1bSD6sp5HTQDbIHun48j6HcrOsfkaoJ1/IbfnxcKrPo7or/KF
 M0AWpv/i+clNTRsgvXcCajx3JhkxtBgLTfrRjxkyEy3gV10+cvUhjymiUD0zRk6bxHvYzK000x9
 sAmmBflwQYmNGs6ZKSa6aMHDDfV3ecSxwC7pLpLTR5uzcjTu/SQoqPfHW0R4q00TGtEOHDHWlEP
 /QGlF2YBoWB9bHBUC/qAQq/hrabWbPiqPo6ZRfI10ktEl1ub3dzdxRo3oXVxHE+7wVAHGTavv4b
 vQR32BoX07zFbr9IhEQ==
X-Proofpoint-GUID: f6Pi8vNwbC-4amU_j6ypsEqC815eY_3z
X-Authority-Analysis: v=2.4 cv=N84Z0W9B c=1 sm=1 tr=0 ts=69eb292c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=tFNJmSkQzRgE3DcoZz0A:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: f6Pi8vNwbC-4amU_j6ypsEqC815eY_3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: B75BB45B740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280964-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-23 at 16:13:10, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> X4 profile users won't alloc x2 entries. Allocating x2 entries
> would cause under utilized subbanks(X2). Avoid this in X4 kex
> profile, all allocations will be from x4 subbank.
>
> Fixes: 09d3b7a1403f ("octeontx2-af: npc: cn20k: Allocate default MCAM indexes")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> index 8630a6a73387..97acba77ff88 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
>[ ... ]
>
>> @@ -4274,10 +4289,16 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
>>  	pfvf = rvu_get_pfvf(rvu, pcifunc);
>>  	pfvf->hw_prio = NPC_DFT_RULE_PRIO;
>>
>> +	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
>> +		req.kw_type = NPC_MCAM_KEY_X4;
>> +		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
>> +	} else {
>> +		req.kw_type = NPC_MCAM_KEY_X2;
>> +		req.ref_entry = eidx;
>> +	}
>> +
>>  	req.contig = false;
>>  	req.ref_prio = NPC_MCAM_HIGHER_PRIO;
>> -	req.ref_entry = eidx;
>> -	req.kw_type = NPC_MCAM_KEY_X2;
>>  	req.count = cnt;
>>  	req.hdr.pcifunc = pcifunc;
>>
>> @@ -4299,8 +4320,9 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
>>
>>  		req = otx2_mbox_alloc_msg_npc_mcam_alloc_entry(&pf->mbox);
>>  		req->contig = false;
>> -		req->ref_entry = eidx + 1;
>>  		req->kw_type = NPC_MCAM_KEY_X2;
>> +		req->ref_entry = eidx + 1;
>
>The VF fallback path still hardcodes req.kw_type = NPC_MCAM_KEY_X2. Does this
>violate the commit message's claim that "X4 profile users won't alloc x2
>entries"? When the first allocation attempt fails for a VF on an X4 system,
>wouldn't this retry path still allocate from X2 subbanks?
>
>Also, should the ref_entry here be masked with (npc_priv.bank_depth - 1)
>similar to the primary allocation path for X4 profiles?

AI review report: https://netdev-ai.bots.linux.dev/ai-review.html?id=9923f145-31df-46b0-84e8-b15f1e307ad2#patch-10
pw-bot: changes-requested

Simon suggested to remove this from net, and post it as enhancement when net-next opens. So Dropping it for now.
Will post it in net-next after fixing this comment.

