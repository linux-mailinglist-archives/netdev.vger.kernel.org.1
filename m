Return-Path: <netdev+bounces-280969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPvAFhwz62mkJwAAu9opvQ
	(envelope-from <netdev+bounces-280969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:08:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BC45BE5F
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EFAB301E59F
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0D8361DCB;
	Fri, 24 Apr 2026 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="C/gy7yh8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52234EF07;
	Fri, 24 Apr 2026 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021608; cv=none; b=n3E7txcQqBzFKuPgqcQDFvjaG59PeLNRBLHI2v0yEwnY/0/xExbC5ptPXHYEWnOZq/M6v52VciEeEJ9Ebz2HcOpxjsU9T5LGEK3Cjtrnx/VBi9/RoM8/EsWPWHdQvuaTnasI1EciUYyfNsHANSmid+mNIm0525LMDmxUfJJPerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021608; c=relaxed/simple;
	bh=CzCPtO1Ndge8nUyAlyoVss7t6xN8OtNHPotIYSvU12Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ech52fL5BETPORyGHlKXfQTUz8/vuELB04UuPjP7R1O8a/VjjFK8WX7xS6lkJa0obay4cjG7qSQCLrpez/XuCcfK1e2YD1TuhjQBceKqRh2OrYLLEltmPPQhSInlxeieQ/KSsJJf1Wm1yVHVO928YGIey1rvxGxgtNO0ixm9SSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=C/gy7yh8; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O38lpB3067901;
	Fri, 24 Apr 2026 02:06:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=KCZHvoOEUx2CEV3QPmZYIIaLA
	KVk7QH+ch5iJGm8IT8=; b=C/gy7yh83ZRjSpJa7kukGV2wPjsP4ll+pCvnE7do4
	T7pHtigDZ17Jb9nYq4E5GjMlv/KPTpb/VO7aooGINbo0rHIuJ3E3McPc8jdGA/Oo
	vY0o8etpF2IAkhkjHaBio/a5ZN07dLwm0Jmlurme5pOGsali1VotD6Q0kEsYZIoi
	MgWGOgcTqU5Ymd/ZxaMI4nUHvSql/VyLe3Z8ySVEF+97joy7wUXpEh9hCJ8fVbA+
	EBzzHNpxcbvujSvI2HtoMTZ5GnBW9MnUE4dnpUUSgU6+7OLu1+LH05102vXniMi7
	fdnhHxsNx0bgZ0sqKtkVPghSw16YIa+vvoQrbPmJtFWDQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dpeph09vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 02:06:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Apr 2026 02:06:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Apr 2026 02:06:37 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id A27B53F7081;
	Fri, 24 Apr 2026 02:06:34 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:36:33 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v3 net 05/11] octeontx2-af: npc: cn20k: Align MCAM X2/X4
 use with KEX profile
Message-ID: <aesymQEJIaGwkufh@rkannoth-OptiPlex-7090>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
 <20260423104317.2707923-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423104317.2707923-6-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: 5NmxHj7QSlSUeurAg4qVkDbECG7OBFbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA4NCBTYWx0ZWRfX/398SfMmcNb8
 QtxbDjDN6LbadcvFC89Mkdvxx97RTen0jmTn2znblFhGNfxtdqE1m3OE/mq2zpqhAung4i0yCMC
 HXv4PCgO2w1mtUnKVzUwlqjyRFAiconH0BucP0MFxDWM92aDHJkhA4D2vUSXUWcALq5MuLl5CxA
 W6cHhAKRebV+BRCzjfruI1Q1jjqE38lqkGSyZofZCv308lZ4Jr3vyoCDQN21/6garnS+l0qGndu
 CLva/GfFYbmwGsHwP4vo6KGGiByAn8zZEdIOAljJEd3rPJ36xEVf8KP0XBatMbNePQ1BbQO4rgD
 bgbBjvsLNKtOVrSu51b/CbydB3c02s4vmh+lCRWeEos681JzVXl8VNZf4eaO33xlTVU2DJhY3Zx
 a0G6GI8YE+/KkM0u9XmTid0IhpO3C0D0DCMWYnasTihR8cMiv6KmPPVbKTSwariUV/8lrrTfOn3
 n/Fo5q/2L3TUslvJE1g==
X-Proofpoint-GUID: 5NmxHj7QSlSUeurAg4qVkDbECG7OBFbY
X-Authority-Analysis: v=2.4 cv=SJBykuvH c=1 sm=1 tr=0 ts=69eb329e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=irE2w_USGBwkW_TQbVoA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: EF1BC45BE5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280969-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email,npc_priv.kw:url,linux.dev:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-23 at 16:13:11, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Flow install derives whether an NPC MCAM line must be X2 or X4 from the
> effective key width (>256 bits needs X4).  That is only valid when the
> global KEX profile allows X4 keys; if the profile is X2-only, fail the
> install with -EOPNOTSUPP instead of allocating a mismatched entry.
> Default L2 rules allocation always requested X2 keys.  When npc_priv.kw
> is X4, request X4 MCAM entries and wrap the reference index to the MCAM
> bank depth so default rules match the active key mode.
>
> Fixes: 9000cada7aa9 ("octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation")
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

This patch has some dependency on patch number #4, Since we plan to post patch #4 in net-next(simon asked to do so),
dropping this patch as well from this series.

