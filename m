Return-Path: <netdev+bounces-297429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Guw0IGXoKGqaNAMAu9opvQ
	(envelope-from <netdev+bounces-297429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:30:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3553665BFB
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:30:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=NxviLJkI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297429-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297429-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9536730B8F25
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA153655D8;
	Wed, 10 Jun 2026 04:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294F36493C;
	Wed, 10 Jun 2026 04:30:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065827; cv=none; b=k9FhRB4VyOwaSURZQTWsUoYC4LyR6uOng6JtijaVG7oWLjAz/QO6iGQ5+dizU3MDfVoh0MOcjrtYKFBCru8mrcVhZ6hsQNx6XGOHb/FUcZOxAXyfkTeaPHH7BkkQyxUjUFUPHoyiXbcChbmjMp0ITvoO8VLRvRlgnf8YODnfM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065827; c=relaxed/simple;
	bh=N4HXRqyQUmsUFWSCprb44oKWAbPFtXp6ppERf4nZcMc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVbG2CG4yW7mNj4j4R7m6f2lT6o8i8smxIG0ijU4FE/EZCHxqG/S3NAWkPwELe+6CRrWZsxDBS/dwILKB3OWsCF9+fghUo02eNMSKV/QPN7Lbg3o1RNZ/S/xx10aRcPEKpd1Yd8TEt+dGfySt2TKB6wuZgxZEpUe/rMIiV4JNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NxviLJkI; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A3TaXj2550742;
	Tue, 9 Jun 2026 21:30:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wdcwEmkhix0X1vneBn/2YUdje
	tzUCPKRrIKLvoBygMc=; b=NxviLJkIWhwUj1FXDYKBE0RaQ3RpNR7gpeupReWBc
	VbGLI7zMdgLdqn7WMaw1mLa9T//sR1xUORGa+sKQvt+XvgA65FfNGY7+kfz1cO7Z
	3b1rFZRsiGljU8dW5aeN2rfyxs4B84O4+WpRro+eKMKQm3wXb2j3xpDi5z63Wm4J
	0Z9jE1a8hsJEtmki4Uv6l0pCGW1HL4RuTgc6cmHw8ZuzhYZYw1NRMtS0lw+35UNh
	RhyHbKplizfkIpuv1mXi84/SDh+ikTm3n5XWm1TEq33JpIT4MuJ5dT48Uk8W9vI1
	CfNOrNPgDbGmuBaH46bpAxT1izYkIP+dDJXLE65fEYElQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eq02mr548-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 21:30:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 21:30:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 21:30:16 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id B78E15B693E;
	Tue,  9 Jun 2026 21:30:12 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:00:11 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 6/9] octeontx2: cn20k: Coordinate default
 rules with NIX LF lifecycle
Message-ID: <aijoU869xdZHM36E@rkannoth-OptiPlex-7090>
References: <20260609040453.711932-1-rkannoth@marvell.com>
 <20260609040453.711932-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609040453.711932-7-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=cuGrVV4i c=1 sm=1 tr=0 ts=6a28e859 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=5IvDXcuzzZJvPDbM8RkA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: LaOco9Vs9lcS7pWqqW73yGqoTWidW6b3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDAzOCBTYWx0ZWRfX7/u0w+ucZLhJ
 1T6M/ZqUPY85/zIdErQu/7+HDJTNTjCLrQ/WOjHnPahNt3xnySXFv30e2E/7NHBoA2eE07kmzTw
 E3YuLo6GhGZKTOa0DrgmGoZIm0pUuPbPz6DEoKGodcJyvDEsaP7xxPlx41ycA6l3goBLNmROD2J
 DlttP8aA4TRNeS/HsKAtsF0PJD81oHGj8l5gSB1qAFF62Rhr49OcYCoJYlrwPGyDH+70+8M9GFM
 6qjm4ysIbFVuQpbttPt1Si2Pjw6KZLz/D6Ksh7OS+pNvDcBRZEXNpsBsBKPy1zCOt+aRFaFOQiM
 Ayeor3SNqt+B9fRX+Pp3SFTBuQ+5Ez04VSeJISgF2qkpnCRVNYl1UNtx+HhAmjzNdb78Qu3C9bv
 5Ucos0mu6OBG14mqG9ea6YetpTijte+BFZC8eSWOr4eIsyBdDJiqWlTT6GmEuUSaOrJUK+ecPNc
 ye4+x2ZKaHqcmcyd0vA==
X-Proofpoint-ORIG-GUID: LaOco9Vs9lcS7pWqqW73yGqoTWidW6b3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-297429-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:from_mime,rkannoth-OptiPlex-7090:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: C3553665BFB

On 2026-06-09 at 09:34:50, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

https://sashiko.dev/#/patchset/20260609040453.711932-1-rkannoth%40marvell.com says

>> -	if (err)
>> +	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
>> +	if (rc)
>>  		goto free_mem;
>>
>>  	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
>> -	if (!pfvf->rq_bmap)
>> +	if (!pfvf->rq_bmap) {
>> +		rc = -ENOMEM;
>>  		goto free_mem;
>> +	}
>This is a pre-existing issue, but does this code allow a memory leak if a VF
>sends consecutive allocation requests?
>Looking at rvu_mbox_handler_nix_lf_alloc(), the AF driver handles the NIX LF
>allocation by allocating DMA memory via qmem_alloc() and heap memory via
>kcalloc(). It appears to directly overwrite the context pointers (such as
>pfvf->rq_ctx and pfvf->rq_bmap) without checking if they are already
>allocated.
>If a misbehaving VF sends this allocation message multiple times sequentially
>without an intervening NIX_LF_FREE message, could the previously allocated
>memory be silently overwritten and leaked?
>It looks like a similar pattern might also exist for NPA LF allocations in
>rvu_mbox_handler_npa_lf_alloc() where pfvf->aura_ctx and pfvf->pool_ctx are
>allocated in a similar manner.

This is a pre-existing issue.

A hardening series to "net-next" post merge of this series would address
this issue.

