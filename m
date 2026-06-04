Return-Path: <netdev+bounces-295036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kFLlHjvmIGq09AAAu9opvQ
	(envelope-from <netdev+bounces-295036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:43:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E500563C8E6
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:43:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=NZNiltO1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295036-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295036-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AEC130082A5
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564F3A718C;
	Thu,  4 Jun 2026 02:41:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F03A5436;
	Thu,  4 Jun 2026 02:41:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540913; cv=none; b=pCwftq+/s2L1V+BZQd38rJjZ82cQIAja6Yojtw+Nc8CDcFFLYZl5iWMDce1HcHlkPrNwUj8slpRflqCoqXJVeeaX/mBQeeb35TtOu9b+3c0k8OZv5lFTg88Qk9Z4bwwkrl2RNXRVA5rUjRfTW9mREkLmpLXBapCyp6ZXjUrXCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540913; c=relaxed/simple;
	bh=ViHP/CJORgZoH2K9fD3GjQmHwanz/PxShqUps8VfIwo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1FL6EPijGYxtTMOeFbjZ5NuLNh4udAWt9U1rOFCdsCprGKixXO2Eec5ElijqP2me8l8naRgZZnocEJPIdZMb7XqmUiyTDVzcV4YXV1BuQkwmwcxrdGz1D2Z3RqYPKQZuNL/fx4+vX5HE2LH0fHk9tcB5v9FWOCSFXemy0Pag84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NZNiltO1; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653J7SbE2884705;
	Wed, 3 Jun 2026 19:41:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=J/QdjPlu7o8SdysvLOv0ELOBd
	sIjqyxNq21w+RNqr6c=; b=NZNiltO1lCJuFWQV1aDoi7Bldjs2/E0m994Sop/rm
	rIxovJK9cZxgcRJrg4zCYnV0uJENiW8SFhP0y4mV6sD+pNo82i2shm8RFVZv8EaZ
	t9opClTp29xBfmo/O1f8r1FGE361+2OtYE39NaeINxQ8J1iZgyEf0tQALh0QUxOW
	6Zd+pEQQabGAWKtqybizVXXF8Y3uIA7APDsJY3VxgODXrCnM2nitUm1Zk3CqkTPW
	5/dqf1BuyGQIM5vFohMMK/mW1L5bUeoj1TZNdwmOtTmkNIWKj9P0X5v47FfStHAA
	W/PgoECW3NpPhgqfbeuSqCzI/wLu6YODD4HcgLn2vsYWQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ej8vfcuh0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 19:41:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 3 Jun 2026 19:41:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 3 Jun 2026 19:41:39 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 9FE7D3F70A3;
	Wed,  3 Jun 2026 19:41:35 -0700 (PDT)
Date: Thu, 4 Jun 2026 08:11:34 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 5/8] octeontx2: cn20k: Coordinate default
 rules with NIX LF lifecycle
Message-ID: <aiDl3p5SYTd9vnd9@rkannoth-OptiPlex-7090>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
 <20260602060359.1894952-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260602060359.1894952-6-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: _XNjHBngiwH8ugqWCC2LRoiqenj0OMlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDAyMyBTYWx0ZWRfX9TBNZIsmmZZx
 ulXVBvgjlHjbj9g/ufil+i2OanUt3oi9IwcVIISC4hhzR7giZWWPtUUCYytVhuUNec6wqagGrvR
 lQY2Cl1ic/e8g3o4v0s6pF0Z2xypL1bT6Fcetb6tehKtjYkBqJdbLOcJHT72akA2CNOpfAmMoHV
 zNydnyIV9i/9fFvol9mLCRB1TRaMjQ6heBwPVaWB8tE7nLl3Rc4eobbNVJi5brLhzstgmjJ+2Ha
 VULYN38Z0ABchbMMRgG1W3JTaexUsPNL2K2ryWaUp5h+JCDZEerJiFoAWqfMdCuFpse9XQ5sI3f
 pfyDxFWnxuWk1Vx6JdPqSar+7b0ajp6WVEc4/tL9OCvPYeQEMyUUqXW70yorLTK/BaE7V6FEQ8a
 Q5rEKs+NT5HvpOv4Bcb6cNuqVGWOobpTJ4eo4epPegSr/f0+7uro//kCpod3I66lmMtSPcNL3Zg
 5xujbC7FXUAdleEGtxQ==
X-Authority-Analysis: v=2.4 cv=EtviaycA c=1 sm=1 tr=0 ts=6a20e5e3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=c8inJCVlxSO3531r6KsA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: _XNjHBngiwH8ugqWCC2LRoiqenj0OMlK
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-295036-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url,rkannoth-OptiPlex-7090:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: E500563C8E6

On 2026-06-02 at 11:33:56, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com says:

>4. nix_interface_init() then calls
>   nix_update_mce_rule(NIXLF_BCAST_ENTRY, true), which can fail (for
>   example -EINVAL from npc_get_nixlf_mcam_index in the cn20k path,
>   or kzalloc failure in nix_update_mce_list).
>5. The new error path goto free_dft -> npc_cn20k_dft_rules_free()
>   walks mcam->mcam_rules and kfree()s every rule whose entry matches
>   one of the freed dft indexes, including the rule installed in
>   step 3.
>6. pfvf->def_ucast_rule is not cleared, so it now points at freed
>   memory.
>Subsequent mbox traffic for the same pcifunc dereferences that
>dangling pointer in places like:
If nix lf alloc fails, subsequent mbox traffic wont come for that Pcifunc.
Next nix_lf alloc, would alloc default mcam rules. Practically this is not possible.
I will add an hardening patchseries to remove the idempotency attribute of
npc_cn20k_dft_rules_alloc() after this series is merged.

