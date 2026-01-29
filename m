Return-Path: <netdev+bounces-254573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CatOcruemnn/wEAu9opvQ
	(envelope-from <netdev+bounces-254573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:23:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 606C5ABE4D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 515F53019142
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84D62D77FE;
	Thu, 29 Jan 2026 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Wbnfu26x"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB24215F42;
	Thu, 29 Jan 2026 05:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664200; cv=none; b=JVQMd0653fLhDrWq/Je+vCxp/TwrBXCp11noAcKl1aP9r6K+rrB+igWYRc5nFwNDG7OypzszuzD8qXnJc54xaN0N8yCiA11rrnopVCNfBQ39+8wvtnIwkv7CW/PSbTNvuoeqZrMNOrcK1jAx1/jgp8WP7VvUB/vntrG8u4A5z98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664200; c=relaxed/simple;
	bh=8EtvXezDL8nN9hK+Dc+RZe77AUI6FGI4Xofxz/NF6Fw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeoC7OXK0+ARq0avX9K4gELjnYCnez1v4LU806pObHFxXVFxsG0+TqQRTHZPcKfqN/NEy+k/O4/gTpYemvLTcdJzqTnr++Q8OZY5zewWJwI8zpYZIBnZkMtSBkWfgXN1MVv6ChMnpu7n11pa1y1WmgMLBEZab+IHyr8Ckqa5RzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Wbnfu26x; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SMINpW2897781;
	Wed, 28 Jan 2026 21:23:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=bZKX6jWk5XCvLHe9aZFiQu2xD
	RKzfqh+0jt/H29EaBA=; b=Wbnfu26xZBjRCmybcY7NkVzYgOaXk3EaQ9P5J75Ii
	FczKcuyc0GNjKfZWh5ZOBLR4+R1bldbTUgOTiXSutYWFvaDQo21oXSWzj/Qab8Ac
	Om6QAQ8DL5dUF0J+Nz+Emxv6elEAaaXM+DtSWhtbxVbo/s1Pp4yIxTEkjREqgoEo
	JtegfXWPyQ2e9HRt3ldO7sDaEoUqTnNVm1imza5nGdr8FannI4eoWBx1WR26Jr1O
	Xmqd7J7V6aB+BHmcgjUeB598da+rzWWG1+9yBC1TKOcToxAfT7mbuVCEG2y1AOvW
	e1sQ2+l7e5Ms5QpAwtu84hTRBtDfUJkIQtmfVAZPzkX+A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4byu4s0tcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 21:23:06 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 Jan 2026 21:23:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 28 Jan 2026 21:23:21 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id ECDAB3F704B;
	Wed, 28 Jan 2026 21:23:01 -0800 (PST)
Date: Thu, 29 Jan 2026 10:53:00 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <edumazet@google.com>, <sumang@marvell.com>,
        <linux-kernel@vger.kernel.org>, <sbhatta@marvell.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>
Subject: Re: [net-next,v6,01/13] octeontx2-af: npc: cn20k: Index management
Message-ID: <aXrutHgsKEuJUlGK@rkannoth-OptiPlex-7090>
References: <20260128071235.3577206-2-rkannoth@marvell.com>
 <20260129051301.376533-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260129051301.376533-1-kuba@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzMiBTYWx0ZWRfX7gS2l9JlT2DA
 pTl7jzDuaYHLpuHzOvotrgb5UeanijQ6NXqJJDjMxOPaWcl4GsFMLZtuGpF9Mems7xRIkvkAaXf
 EzZvPRkriiQJYrNM825zijYSmEtUw11Rtd1bDtqvjZsNDexruDD2QgZpJWzZqMZODdhMOFrd2Rg
 AJGTanl4A/AhvTMp9DXSTBQVG84CylI81P80LM9d/A3zDzo8ARgokY9tcB4hwm4PyJfTfFsNuCn
 1UViHIe+vM1d0LyJtyymxGzPDUKXEym2J6YfKdCFlJlvWFhE8ESAJx+vneu0vniFWXMlFWDhBNJ
 4gPXS2OCKjMfwtIWEu/xDi8qa87Ql3h5uDToKFchICz3Lpilv6EuW8r+TNN6yA73+ekA8HkA//i
 LZq4xvwog//AZJucB+TFKqt3avCr2u1509HokuGk1A2BWrbwzxU/TCJR8bTH80HXGQegmgAAtJ2
 PUCpQqhJpUCDyfrgM/Q==
X-Proofpoint-ORIG-GUID: z_fAJUEA0GcCdZ0aZjoTS4tSw-CbziIo
X-Authority-Analysis: v=2.4 cv=XeOEDY55 c=1 sm=1 tr=0 ts=697aeeba cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=zNruMUKu9Wi_VSSbIxoA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: z_fAJUEA0GcCdZ0aZjoTS4tSw-CbziIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254573-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 606C5ABE4D
X-Rspamd-Action: no action

On 2026-01-29 at 10:43:01, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-af: npc: cn20k: Index management
>
> This patch adds MCAM index management for CN20K silicon, implementing
> contiguous and non-contiguous allocation schemes across the new subbank
> architecture with 32 subbanks of 256 entries each.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > new file mode 100644
> > index 000000000000..30cc05c64487
> > --- /dev/null
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
> [ ... ]
>
> > +static int npc_create_srch_order(int cnt)
> > +{
> > +	int val = 0;
> > +
> > +	subbank_srch_order = kcalloc(cnt, sizeof(int),
> > +				     GFP_KERNEL);
> > +	if (!subbank_srch_order)
> > +		return -ENOMEM;
> > +
> > +	for (int i = 0; i < cnt; i += 2) {
> > +		subbank_srch_order[i] = cnt / 2 - val - 1;
> > +		subbank_srch_order[i + 1] = cnt / 2 + 1 + val;
>                                    ^^^^^
>
> When cnt is odd, the final loop iteration has i = cnt - 1, which means
> subbank_srch_order[i + 1] writes to index cnt, which is out of bounds.
>
> For example with cnt = 5, the loop iterates with i = 0, 2, 4. At i = 4,
> the array access subbank_srch_order[5] overflows the allocated array of
> 5 elements.
>
> While CN20K hardware typically has 32 subbanks (even), the value is read
> from a hardware register at npc_priv_init() without validation beyond
> checking for zero. Could this lead to memory corruption if the hardware
> reports an odd subbank count?
subbank count is 16 or 8, depending on SoC variant. i will add a WARN check on
odd ?

>
> > +		val++;
> > +	}
> > +
> > +	subbank_srch_order[cnt - 1] = cnt / 2;
> > +	return 0;
> > +}
>
> [ ... ]
> --
> pw-bot: cr

