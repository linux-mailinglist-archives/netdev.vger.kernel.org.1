Return-Path: <netdev+bounces-294604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qFucCSfTH2rrqQAAu9opvQ
	(envelope-from <netdev+bounces-294604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:09:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F5635047
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:09:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=dhRuHCqs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294604-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294604-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72D2A3041C5E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066223F0A9B;
	Wed,  3 Jun 2026 07:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB63F8EC3;
	Wed,  3 Jun 2026 07:03:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470206; cv=none; b=pY8t9dR4c7AAMrsWqAKPF/x2mY33NifD10gHwYj6jCpRmuilMebzuhfVasYbWR10gBiI5K0zGf6qzJ5Pf/GzV38i4biuv84LvjCjBvLsT4wBlV1Dafzg1qhRayTWtlHkSlRJHf3+98AOUWf1nr7eC6fBTX7vC9XX1REqhQX6yjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470206; c=relaxed/simple;
	bh=SbapfZPKFwbW1/TUMqfSlObqXwF6GDRQ6CGNYkaVaz8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9EkYvN32RLASuasWobX+1bMrJ9tkC5lVPTly1Q1IxlzUj0Mit6gwoiKwPs40qQFu3mHp8d+5mu1e1AB39VA1ivINWvzDdSy1LKDI6kDjb/o4C+XSV34LqYnG3or930cLfJsxdzSmFrv8hMPDXxatqJb0u2Khu5ZPdwveWPj5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dhRuHCqs; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652NTeMq2885820;
	Wed, 3 Jun 2026 00:03:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=aaQhmC+yLhb3C7eAsw456lePu
	8T4RcxRF6axckIMr5U=; b=dhRuHCqsPxXwN/5IixqzFSaGohZPfrQqHacU9eAGe
	6SNQDgLYwQ1Jy2p9LdkZMWbb6QZGzfAXDEZPVpny0frKqzvcCs9yqrwf+jyU1QFb
	R51oC9Un1yEfW+NGVw3DPI4WL7rSz0ryEzuSkO7oR6LsIFDD9Aoyo0hMCzzJqP5E
	9mJf93zx6kYjqUlc5RG7VNVyOCCShrUnTTcX9B7ocgCZz4aTEKDPD2+B9BhR3Wk8
	IxqNUijslw5WHXyglj/IKrTBAlTN2WLK0jRy9b2oPw2pSn0e4A+71/fg49LRfrs/
	djHzzbj/3sk1P1U4tMXH3b66PnFa9X5vG0Rs8jlxroErg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ej8vf998s-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 00:03:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 3 Jun 2026 00:03:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 3 Jun 2026 00:03:13 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7800B3F708D;
	Wed,  3 Jun 2026 00:03:10 -0700 (PDT)
Date: Wed, 3 Jun 2026 12:33:09 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 8/8] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
Message-ID: <ah_RrQD0rtL4oJiF@rkannoth-OptiPlex-7090>
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
X-Proofpoint-ORIG-GUID: qBsCTulOurRBTxCnx_6KY_PJCr4I1pNh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NiBTYWx0ZWRfXyio2gn/larQm
 b8BAawAQ8lqGipgxKSqkqAtpVuKI5cMdIZvWUurnxhxeCMXNV4pvO9IqU+PO3jfygo+uFQMmZk1
 1h6F7ymy8CtGzjVeJMhc+Y8pK4WxkGEz+2rw3LEpgYuFWFtkAJwtF+PGvbC2vHYmFTLJjdTkIzZ
 UzyYNtgs4iQT5oazYlckN8G7g/isxE5mlOUaCZc9mblGx+0/yi5wISWwW1m+jMdlLMEhVLls5vg
 70Pc7eJk4x12d8lnQhX9OnzME2vLpBEV4XmEWeHnbjTa14MlwjVdHO7MNGnO4KoXT9f2XWCVTHO
 8b7hbciLoqtUGzRF2IIv1WTGqYN+RKwHqmOe0OjKRN2VuN3x9X8lWNa/6vA4KRaJJG7IFgDgl+f
 ku4IffNcuM3IxWfIzqtPYNLKqn1UV+z0vM/qR21xC+eRY+OdyTawTN8p0Mc/ATkNXeQg7Ml6I1t
 myVy3BXGSlo81nBY/wg==
X-Authority-Analysis: v=2.4 cv=EtviaycA c=1 sm=1 tr=0 ts=6a1fd1b2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=jXztlOBXjf_iSrI2OZQA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: qBsCTulOurRBTxCnx_6KY_PJCr4I1pNh
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-294604-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:from_mime,marvell.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rkannoth-OptiPlex-7090:mid];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: DF2F5635047

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

https://sashiko.dev/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com says

>>
>> +	dstats = devm_kzalloc(rvu->dev, sizeof(*dstats), GFP_KERNEL);
>> +	if (!dstats)
>> +		return -ENOMEM;
>> +
>Since dstats remains a global static pointer, won't multiple RVU devices
>probing cause this to be unconditionally overwritten, leaking the previously
>allocated memory?
>
There is only one admin-function PCI device per system. Will post a patch to net-next (after this series is merged)to  reject any additional AF probe
with -EBUSY so the driver model matches hardware and automated reviewers can rely on a single bound instance.

>Additionally, because this uses devm_kzalloc, if a device is unbound, won't
>devres free the memory while leaving the global pointer dangling? Could this
>lead to a use-after-free for other active devices that attempt to read from
>the debugfs file?

There is only one AF device per system, there is no support unbind AF device, so it is already attached.

>> -	bw = bitmap_weight(bmap, npc_priv.subbank_depth);
>> -	bfree = npc_priv.subbank_depth - bw;
>> +	bw = bitmap_weight(bmap, npc_priv->subbank_depth);
>> +	bfree = npc_priv->subbank_depth - bw;
>>
>>  	if (!bfree) {
>>  		dev_dbg(rvu->dev, "%s: subbank is full\n", __func__);
>This is a pre-existing issue, but does __npc_subbank_alloc() properly verify
>the bounds of the mcam_idx buffer before writing to it?
Pre-existing issue, will add bound check as part of hardening series, after the patch series merged.

> -	npc_priv.subbank_depth = subbank_depth;
>> +	npc_priv = kcalloc(1, sizeof(*npc_priv), GFP_KERNEL);
>> +	if (!npc_priv)
>> +		return -ENOMEM;
>> +
>Since npc_priv remains a file-scope global pointer, if multiple PCI physical
>functions probe, won't the second device initialization overwrite this pointer
>and permanently leak the memory allocated by the first device? Should this
>state be encapsulated within the per-device private data structure (such as
>struct rvu) instead?

THere is only one AF device, so only one npc_priv_t instance.

> +	kfree(npc_priv->sb);
>>  	kfree(subbank_srch_order);
>> -	bitmap_clear(npc_priv.en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
>> +	bitmap_clear(npc_priv->en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
>>  		     MAX_SUBBANK_DEPTH);
>> +	npc_defrag_list_clear();
>> +	kfree(npc_priv);
>> +	npc_priv = NULL;
>>  }
>If one device is torn down and calls npc_cn20k_deinit(), it explicitly frees
>the global npc_priv pointer and sets it to NULL. Won't this immediately break
>any other active RVU devices that are concurrently using this shared global
>pointer, leading to use-after-free or NULL pointer crashes?
>
THere is only one AF device, so only one npc_priv_t instance.

