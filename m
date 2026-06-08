Return-Path: <netdev+bounces-296350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sRDXKEYpJmqzSwIAu9opvQ
	(envelope-from <netdev+bounces-296350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:30:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2A6523DF
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=R2+1icgd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296350-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296350-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF15D30038EC
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4634A3128BE;
	Mon,  8 Jun 2026 02:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD430C157;
	Mon,  8 Jun 2026 02:29:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885770; cv=none; b=HR8+OwfT2N2IA6Bq987C69QjY2DGT5JM+LUKvqprz4DWbqY6MyUWRmfBydZTVFrwqQkZKsO7kSz/BtxGJrIKvvEmphUJkaZcryAqbzdrWgRmcOdecmumiu6jSLYXvQHjYJI5AdNmfbK4TEjrNz6dzzhxJowOKbdeZwrFxmMqOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885770; c=relaxed/simple;
	bh=vTgrKg5ZEQDkgfMdNi1zK2bCgSQuOIZNlD03/RqtjmY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDEsjMPSUv8nu4J+GB663TYx4865jsKNIgLKRBuPS5iHiY/A87hfvY9UcV3yfRp/rfU8gXlGGf7HkFB/jY9bkCFesP+AavhjF1YcBFRZwKJxjGaScQmdNRczPlPI7VHDjJblZxSXImMUhzhSuBdfxM/q3BsfFtzJ4SNoFPtqtmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=R2+1icgd; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580ElR1936625;
	Sun, 7 Jun 2026 19:29:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=y3skfZfKdnjbXsdUeRP9kMWTL
	Ft3raArqsUhnGjMYAg=; b=R2+1icgdJXPWIv3QYqSZbqv1yXTZ1zlQAlG3EI2vX
	EXIc/h/BIqW5OsmNFVEs5WgpTr3fymTeo/ggP3c0wUPFOcghsr07GdTMivz6iGEY
	8ILT+U5MpSmAA3JAvBTjBlM/GMX5KPqRyfTlxUTifWkVYZGNS1lbC3qczKrHHhw1
	WNGYOrViE/As2F5kj3Kr+3RcWQo9b+ijbLWl9Y0HnMU+yD5o5aTSag7CNqba4JcO
	6R/H2/3B1pZ+am1vBymi/u9Hhrf09tG/Wvz0G2wpOaO4VnZ7LQjZRev4hY8gR0tj
	fRDSELm7cJJHIdn2BMkgr1TuzI7wCtyJCI0nWHgNUAp4g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4emk2ems4d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:29:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:29:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:29:20 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id AE9275B6960;
	Sun,  7 Jun 2026 19:29:16 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:59:15 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 6/9] octeontx2: cn20k: Coordinate default
 rules with NIX LF lifecycle
Message-ID: <aiYo-wl9FrsRq9N_@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605063245.3553861-7-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfXy2vzUgE9hH6q
 pS/xP7gbN58pdCEgU+hs1p2ROiFqpyZ9vSQ6IDkJRvDx4tNj9NToUliQAQRsgIu29+DKAlBxR24
 fqPNJ6hdbS6v9KtU6L0NMra34fDPf0vmc/tKS3LS3YkfjUR/0kZ3o1AhkGCI0LRPHC7A/Pu/MNa
 12JapQdY2Ag44AZzGB/ACzhQlNCdERc2iDdlmghmZTTWBom2k3GO1wms4PitrcgqzkWyUQwmm1z
 OYqElayjJEpxxRtg48TpES7XQsm5Cc/MjQ7hKgNSlH9V8NhVyM0prmQR7ZqMI9opBjKLfpxfFC8
 4CCmGNsdxhAgskscapFHY6HFN8nImODPRZYYBzHZyr5yfv7lP6n1vjU79RUpWsCFC03VVsxoHie
 hfa4MIWSqcvvR7JyLV2qn8g75NLM+Ou32TLvT3jcAegBZc4LCm++nFxyzdVVDJvkpklo1JFgQPE
 xLZjKkk2+i2tWI9Pyhw==
X-Proofpoint-GUID: Lf5TLRKg7iuEjXczw43V1QuEzV24AUXe
X-Authority-Analysis: v=2.4 cv=bJUm5v+Z c=1 sm=1 tr=0 ts=6a262901 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=v1ExrNIky-3ZwFm6Zd8A:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Lf5TLRKg7iuEjXczw43V1QuEzV24AUXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-296350-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rkannoth-OptiPlex-7090:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,linux.dev:url];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDC2A6523DF

On 2026-06-05 at 12:02:42, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add NIX_LF_DONT_FREE_DFT_IDXS so the PF can send NIX LF free during hw
> reinit or teardown without the AF freeing CN20K default NPC rule indexes
> while the driver still owns that state (otx2_init_hw_resources and
> otx2_free_hw_resources).
>
> On CN20K, allocate default NPC rules from NIX LF alloc before
> nix_interface_init, roll back with npc_cn20k_dft_rules_free on failure,
> and free from NIX LF free when the new flag is not set. Tighten
> rvu_mbox_handler_nix_lf_alloc error handling: use a single rc, propagate
> qmem_alloc and other errors, and set -ENOMEM only when kcalloc fails
> (remove the blanket -ENOMEM at the free_mem path).
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

>>  		intf = NIX_INTF_TYPE_SDP;
>>
>> -	err = nix_interface_init(rvu, pcifunc, intf, nixlf, rsp,
>> -				 !!(req->flags & NIX_LF_LBK_BLK_SEL));
>> -	if (err)
>> -		goto free_mem;
>> +	if (is_cn20k(rvu->pdev)) {
>> +		rc = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &bcast, &mcast,
>> +						 &promisc, &ucast);
>> +		if (rc) {
>> +			rc = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
>> +			if (rc)
>> +				goto free_mem;
>> +
>> +			rules_created = true;
>> +		}
>> +	}
>Does the rules_created flag faithfully reflect whether allocation
>actually happened?
>npc_cn20k_dft_rules_alloc() returns 0 without doing any work when the
>pcifunc is not CGX or LBK mapped (for example SDP):
>	if (!npc_is_cgx_or_lbk(rvu, pcifunc)) {
>		dev_dbg(rvu->dev,
>			"%s: dft rule allocation is only for cgx mapped device, pcifunc=%#x\n",
>			__func__, pcifunc);
>		return 0;
>	}
>For such a pcifunc, npc_cn20k_dft_rules_idx_get() returns -ESRCH, the
>if branch is taken, dft_rules_alloc() is a no-op returning 0, and
>rules_created becomes true even though no rule was created.
>The free_dft path then calls npc_cn20k_dft_rules_free(), which itself
>early-returns on the same !npc_is_cgx_or_lbk predicate, so the safety
>relies on that hidden coupling rather than an explicit signal.
>Would it be clearer to have npc_cn20k_dft_rules_alloc() return a
>distinct created/not-created indication, or to gate rules_created on
>npc_is_cgx_or_lbk(rvu, pcifunc) at the call site?
>> +
dft rules are only for cgx/lbk interfaces. So for sdp, eventhough npc_cn20k_dft_rules_alloc() returns 0
and rules_created is set to true, failure case, it will call dft_rules_free(), but there is nothing
to free. So this will work.

>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>> @@ -4085,12 +4095,10 @@ void rvu_npc_clear_ucast_entry(struct rvu *rvu, int pcifunc, int nixlf)
>>
>>  	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
>>  					     nixlf, NIXLF_UCAST_ENTRY);
>> -	if (ucast_idx < 0) {
>> -		dev_err(rvu->dev,
>> -			"%s: Error to get ucast entry for pcifunc=%#x\n",
>> -			__func__, pcifunc);
>> +
>> +	/* In cn20k, default rules are freed before detach rsrc */
>> +	if (ucast_idx < 0)
>>  		return;
>> -	}
>The comment says this silent return is for the CN20K case where default
>rules are freed before detach rsrc, but the change drops the dev_err
>unconditionally for every silicon that reaches rvu_npc_clear_ucast_entry()
>via the generic rvu_detach_block() path, including CN10K and OcteonTX2.
>On legacy silicon a negative ucast_idx was previously treated as
>exceptional and worth logging; should this silent return be gated on
>is_cn20k(rvu->pdev) so the dev_err is preserved for the other variants?
No. In cn10k, ucast entry is not dynamic, so it is treated as error. This is
a teardown path, so want to keep same code for cn10k and cn20k.

