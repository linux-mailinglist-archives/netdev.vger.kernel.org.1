Return-Path: <netdev+bounces-294582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H56SOfnMH2o1qAAAu9opvQ
	(envelope-from <netdev+bounces-294582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:43:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FC2634BD0
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:43:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=S9MeyWfr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294582-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294582-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C08A53007F73
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1C314A73;
	Wed,  3 Jun 2026 06:38:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED0286AC;
	Wed,  3 Jun 2026 06:38:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468682; cv=none; b=h8fUp2qa6Idk3eUZzI0AbC5NF2oa9t3MTWexka4RhVbrO9sf0oEEjsFeYWiLelJJJZ42i+2Xubs6g6ZKt9oc74CmZLaF5s/UNTJ+2PR669Hyr9fYEA01XZY7KrtNGvGwVJaFWAA7t7OxzsG+ZWzL6EBtqeI9VUXgQY9ThOUkRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468682; c=relaxed/simple;
	bh=TcS8ozdvqYwuaxXS6ik7ii1gXzcBaJYB1U1kLQmazOo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyeqbiss17eWOnlAYJVBtSZwqGH1dIXdHKD+bP0bwUVOwln0rmemYWh5IFs7AIeQ56JQz2Z/fDNMLMf0gklGRk0+KmOeSaTDz774exCJo1pTzLrzwesL8+UEZUWIJkfCNZDLgNOIMPnxoJGHFTL055znO7kZ1uKqxtsO6ItZq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=S9MeyWfr; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6532CFtq1194256;
	Tue, 2 Jun 2026 23:37:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=FGokJjgUyTvBTzBtrU9E3YF9B
	uoWdrBav7kix/H9XlE=; b=S9MeyWfr3eEYeTJclaWg0C9xTOXJKebPi1U37qNXK
	Mf03J7tcYVUz7m2H6Snb9HOT0A3Fz3eobtX/zopX/n+EpjBifooMDtEQ8UcO21Mn
	XEKoX2XUS1x5prPQ4MApHIxRF6BESBTjf7Z+CxvYOiDHQ+Vi/BAwF55Fr4wJXj3H
	pNblud8sC69tWT94Nfz0XsAR1RlDNwQXcesM9eow1mA2jk4hvkS1c4rp4nKTANlH
	lCsS3v17JQOv5pdWVdnRWDRzzZAG/N/U6LU8QhzvUouXFy/ZgCU6VNUqmDAT0CRD
	Bv3ljRkLDjx+r5Fe0j3/VOkLs/yIyLcNjIB947mv1GY6A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3bc5tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 23:37:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 2 Jun 2026 23:37:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 2 Jun 2026 23:37:39 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 35BF03F708D;
	Tue,  2 Jun 2026 23:37:35 -0700 (PDT)
Date: Wed, 3 Jun 2026 12:07:35 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 5/8] octeontx2: cn20k: Coordinate default
 rules with NIX LF lifecycle
Message-ID: <ah_Lrz0aP4jAd9eR@rkannoth-OptiPlex-7090>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2MSBTYWx0ZWRfX5YRr7pXVwnbZ
 hcP+Px6RnJGQQ4FwA2DnGaqYndiUxy8sLX8W8sppv14Ydz1Ea0IGlul4m3+MzHRArmhw9mlfFvY
 itLzZXbTsMAJNOVgiR3ZvNWyKV8a0JBfwc/90bnQ1X7oGO4PzklJBqtgNPm50scA3VyNcqxpTic
 FkrLwLc38eMBzZOYxLLIOjfxrn7+diZpy3I1ze4BojuKywNPByLqzDfZfWlUc71Tfqe5n7k0yp5
 x84l5LIe9Mmmf+0exQaQK84QnjU5lc+BA8D/6s5ua4G0NFDdiZTmT3SfRk3J/uCt0WTEecI1ZSz
 CUXGiMsGCqDmxi1G5dGKlod6Az+u2ectx2ZMIeJ49usxJsRYT58ZrOCuV6R/FLZqZ4mRyc051GO
 0W/Rr/lo32TXnlknny6AlA0mwVFUbjJFpD8G8eOfDx3Q2v0eLgj7uYbRFe+qaQi0x/q/bZGCvCB
 OREZD9qPVcrUFANHmXA==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1fcbb4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=_4monf2TZ0uLVZycb8gA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 5ABij7lqwmwIIBK5FfzOjZUjdlmOydo0
X-Proofpoint-GUID: 5ABij7lqwmwIIBK5FfzOjZUjdlmOydo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-294582-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rkannoth-OptiPlex-7090:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: 42FC2634BD0

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

https://sashiko.dev/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com says

>>  	/* Alloc NIX RQ HW context memory and config the base */
>>  	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
>> -	err = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
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
>This is a pre-existing issue, but can repeated mailbox messages cause a memory
>leak here?
>If an untrusted VF continuously sends MBOX_MSG_NIX_LF_ALLOC messages without
>sending a corresponding NIX_LF_FREE, it appears qmem_alloc() and kcalloc()
>will overwrite the pointers in the pfvf structure (like pfvf->rq_ctx and
>pfvf->rq_bmap) without freeing the previously allocated memory.
>Could this be used by a guest to cause host DMA or heap memory exhaustion?
Prexisting issue, not addressing as part of this. May be a hardening series post this series,
or patch to introduce some limit  can be planned.

>> +	rc = nix_interface_init(rvu, pcifunc, intf, nixlf, rsp,
>> +				!!(req->flags & NIX_LF_LBK_BLK_SEL));
>> +	if (rc)
>> +		goto free_dft;
>>
>>  	/* Disable NPC entries as NIXLF's contexts are not initialized yet */
>>  	rvu_npc_disable_default_entries(rvu, pcifunc, nixlf);
>> @@ -1699,9 +1712,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>>
>>  	goto exit;
>>
>> +free_dft:
>> +	if (is_cn20k(rvu->pdev))
>> +		npc_cn20k_dft_rules_free(rvu, pcifunc);
>Does this rollback path accidentally destroy pre-existing default rules?
>If the PF preserved the rules using NIX_LF_DONT_FREE_DFT_IDXS during teardown,
>npc_cn20k_dft_rules_alloc() returns 0 without allocating anything when they
>are already installed:
>npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
>{
>    ...
>    ret = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &b, &m, &p, &u);
>    if (!ret) {
>        dev_dbg(rvu->dev, "default rules are already installed...");
>        return 0;
>    }
>    ...
>}
>If nix_interface_init() subsequently fails, the error handler jumps to free_dft
>and unconditionally frees the rules.
Even if it is freed, next successful nix lf alloc, will setup these default rules.

We can modify npc_cn20k_dft_rules_alloc() to add one more paremeter (bool &) to indicate whether newly/already
allocated status. Based on the flag, invoke npc_cn20k_dft_rules_free(). Will take it up as
hardening series after the series is merged.

