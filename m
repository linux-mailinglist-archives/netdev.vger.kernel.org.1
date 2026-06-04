Return-Path: <netdev+bounces-295040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rMBWJTnvIGrL9gAAu9opvQ
	(envelope-from <netdev+bounces-295040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 05:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E663CAFE
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 05:21:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=ESl0gcHf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295040-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295040-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B97630391C7
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 03:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD33AFCE0;
	Thu,  4 Jun 2026 03:21:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37573AFAE1;
	Thu,  4 Jun 2026 03:21:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780543279; cv=none; b=mbg3a2QuR5N9NA87XQwXorWByqan0OqEa8hNQX2zuGxxFgnkAcaGhX8poK/MloHyYAZnuhT1v+RktNXDhanszLNb4bdW0d4t7AtxWkUIzLPM8SYK7puoQdJfmQNdb9nD4HCwtjeUTUTcdxoR9F5Q7vvLeznONgGMpYFiiw6JkQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780543279; c=relaxed/simple;
	bh=1oDiJB74RxXKNtE6veGROB69s5IkmtYfeS6XlJ+7O5w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbN2OAtENJK6xeGZazW3pbvfG9Qfm4t4/t452FBVTck2qpagaaibQcVBBFwBGjqffNQEOwNA0dBaM4PrUdenOaiOtTudD2x1rWrSEmus1naIsb69ZhdJq9XrVfvyq3C22xemr3f4bWTmB2heEBcIwbLeQJ7rcvhZ0coIH8PxxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ESl0gcHf; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653J7Sgj2884705;
	Wed, 3 Jun 2026 20:21:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=NNyy1jq/HXaiMvrK9Ng7rk+va
	I3HU3arH8QIARQY2Fg=; b=ESl0gcHfS2JTSdUB1OuP0ZdRCxex1pQApHZztzRJz
	HI6GjqyK7FNXI2Gr2YdnNG8DTdnTKg4THtygOR0wmUxYAJJrP2ASIp/8ZEPNR3zg
	PEfOt0rh08Y/RKrcEwBOcQh8u4zYyj/t/PsEdQAz4wfR8zVZT6N9xMR9ZAHkTBLa
	Bwk5JdNK3TxI033wWfZuQ2ByIh9Qn14k4+3Fu2r/TUjQhh5neSxbpaUhZMXL7KR9
	5ZYSZy0rdpCy6G7YLRn5EWiL1/O9ZT8Zr9PKshtXee1Edb7gxTHFoDs9sVdCZaMa
	kQ9n0B64zPYLBlqn/VoG8iHFyxhyoeqoUVzJ0HRw7mCKg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ej8vfcynk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 20:21:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 3 Jun 2026 20:21:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 3 Jun 2026 20:21:06 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id B00B93F7066;
	Wed,  3 Jun 2026 20:21:03 -0700 (PDT)
Date: Thu, 4 Jun 2026 08:51:02 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 8/8] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
Message-ID: <aiDvHu_f0nPpXC81@rkannoth-OptiPlex-7090>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
 <20260602060359.1894952-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260602060359.1894952-9-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: 0RO2QFmIJRf_GY1WwiChFZtBIzKg2FrQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDAyOSBTYWx0ZWRfX7idvCb//hzcg
 IGXdgvWS0zHx8FF01Qcfpzaq9N14Ib1isO3nMu9768PE+ZD4EB7qQjp87nlDU01qPPaZbUY7tSx
 Ftfy12G4OJsQiJado0d+qGZdPXcd/p1z8LdvEqwyz8MDU6kNNcpC8hHXEu6Z2i5rzi7nXoJ2d0q
 H4EvGDmCdLTHs2LAgqOrcIzT4k1y7S4xBjSkqhqX6MbMr1xknI62W32sj6H4VJalfR2Rik6yJiE
 Ts0Gp78Nk8hH8VH+vPzps/zKmZtl5meM8eiVM505uFKrkoybeemOuL3ECfvoNT3h0mvO0eZX6Ql
 wyzNT8+piH9xavRDYx8tKTm9dPa4Awlelu+zOZSBKIwMtJ71teMXgXjvc31RX8CSHQjokuL14LP
 bB4qHNpj6pGcumI+u1xXD9NiY6bVBroDG7+xfh7mseOG+nB08gAcYaaxX06LHFjgRioYOw6btJi
 v5UQ8GSkL0Us8Buk6TA==
X-Authority-Analysis: v=2.4 cv=EtviaycA c=1 sm=1 tr=0 ts=6a20ef23 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=wLtUEu86mD6Azn7RXrwA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 0RO2QFmIJRf_GY1WwiChFZtBIzKg2FrQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_01,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-295040-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,rkannoth-OptiPlex-7090:mid,linux.dev:url,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 094E663CAFE

On 2026-06-02 at 11:33:59, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Replace the file-scope static npc_priv with a kcalloc'd struct filled
> from hardware bank/subbank geometry at init (num_banks is no longer a
> const compile-time constant; drop init_done and use a non-NULL
> npc_priv pointer for liveness). Thread npc_priv_get() / pointer access
> through the CN20K NPC code paths, extend teardown to kfree the root
> struct on failure and in npc_cn20k_deinit, and adjust MCAM section
> setup to use the discovered subbank count.
>
> Allocate MCAM debugfs dstats via devm_kzalloc instead of a static matrix,
> and use the allocated backing store consistently when computing deltas
> (including the counter rollover compare).
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com says

>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
>[ ... ]
>> @@ -397,6 +398,10 @@ int npc_cn20k_debugfs_init(struct rvu *rvu)
>>  	debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
>>  			    npc_priv, &npc_vidx2idx_map_fops);
>>
>> +	dstats = devm_kzalloc(rvu->dev, sizeof(*dstats), GFP_KERNEL);
>> +	if (!dstats)
>> +		return -ENOMEM;
>> +
>>  	debugfs_create_file("dstats", 0444, rvu->rvu_dbg.npc, rvu,
>>  			    &npc_mcam_dstats_fops);
>Should the dstats allocation move to the top of npc_cn20k_debugfs_init()?
>By the time the kzalloc fails, three debugfs files (mcam_layout,
>mcam_default, vidx2idx) have already been created, and on -ENOMEM the
>function returns without unwinding them. The sole caller in
>rvu_dbg_npc_init() is:
>    if (is_cn20k(rvu->pdev))
>        npc_cn20k_debugfs_init(rvu);
>rvu_dbg_npc_init() is static void and discards the return value, so under
>memory pressure during probe the device completes probe with a partially
>populated debugfs hierarchy and no error is logged. Pre-patch the function
>unconditionally returned 0, so this is a new failure mode introduced by
>this change.
I dont see any problem with this.

>> -	xa_destroy(&npc_priv.xa_sb_used);
>[ ... ]
>> +	if (!npc_priv)
>> +		return;
>[ ... ]
>> +	kfree(npc_priv->sb);
>>  	kfree(subbank_srch_order);
>> -	bitmap_clear(npc_priv.en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
>> +	bitmap_clear(npc_priv->en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
>>  		     MAX_SUBBANK_DEPTH);
>> +	npc_defrag_list_clear();
>> +	kfree(npc_priv);
>> +	npc_priv = NULL;
>>  }
>Should npc_cn20k_deinit() also NULL out subbank_srch_order after
>kfree()ing it, to match the cleanup symmetry of the fail3 path in
>npc_priv_init()?
I dont see a need as there is only one AF device per system

>> -	const int num_banks;
>> +	int num_banks;
>>  	int num_subbanks;
>>  	int subbank_depth;
>>  	DECLARE_BITMAP(en_map, MAX_NUM_BANKS *
>> @@ -214,7 +214,6 @@ struct npc_priv_t {
>>  	struct list_head defrag_lh;
>>  	struct mutex lock; /* protect defrag nodes */
>>  	int pf_cnt;
>> -	bool init_done;
>>  };
>The init_done field is removed from struct npc_priv_t, but the
>kernel-doc block above the struct still carries the corresponding
>description:
>    * @init_done:		Indicates MCAM initialization is done.
>Should this @init_done line in the kernel-doc be removed alongside the
>field? scripts/kernel-doc and make htmldocs will warn with "Excess
>struct member init_done description in npc_priv_t".
ACK. Should i post v19 to address this ?

