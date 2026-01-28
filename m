Return-Path: <netdev+bounces-254089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCUgGLqCeWmexQEAu9opvQ
	(envelope-from <netdev+bounces-254089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:30:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C49719CB0B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE94430143CB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC4932E12E;
	Wed, 28 Jan 2026 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aUSi8+EW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA7F2BB13;
	Wed, 28 Jan 2026 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570997; cv=none; b=S8YDtwiCZsk9x+eei9VKIbf7xwSHxSP5G+G199XY3w9LHbrxzPWbnoxYgAZyndmCMdwCrI8dVdBC3m6FLJ2/4Rf0Q5+us2/obqNtBmsTHIKdC6opDtIbRd72okamEFMUSX7QGYCuOELYAko2DT13oZFVGGfTAs444XNZkPaCGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570997; c=relaxed/simple;
	bh=HmJTNnpp1FaHLOxYS9/NxKP1NS+6IaLzfbXUJ/tZEas=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AajE8oR7cfKHiWu0xB1AOJ2tdSKZdBPPb/4eBuV/3lHI5RiYM4FCDP00MHMx49ZhDljNNDJo15jFzc3+txz/wZJpu6vZn7imrqveTgDIs6Kt04+04rOWuJ/M8nk/KDRF9S3O2s5nQeoJrfFAc4zIQhTmre7asENQXsUf84iyUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aUSi8+EW; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RGPxbR1390280;
	Tue, 27 Jan 2026 19:29:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=+TOOuq0U6h51gxfqoPJbKDlHR
	lb2Oyeqk3p6/RTB3gY=; b=aUSi8+EWKn6mnV5lfkagX1M7TwRhiO1VYi7+lRaBI
	KSX2zp4rNZBapPR/u7rXpnf8EAh38nySVa+qP2JOpR22Zn7PnvlATUdtZHeR99JF
	YhGsAwEchbU9plRKhVC6BxD+s/IbLTJZbk2TpnEC3lKUTTJ6fEM3Imtf+tRdjDOU
	fnsOCQcrbMetBo+Ywi8tMxlIABHrJa+kEOjr/qC/U1L2eezoyBG6mqnjjvWr4V7b
	7cjVB2FTHB30I2zUXlqqPINVo9/Hs4c/8I968/3uogkpQZD1kuz078Wsk+b8x407
	uxrA2ZSmYRTfn7wsbwx3Ha4EOJjc0I8+kTohJ/JwRAg3Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bx0qswgwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 19:29:46 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 19:29:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 19:29:45 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 38E6B3F70AD;
	Tue, 27 Jan 2026 19:29:41 -0800 (PST)
Date: Wed, 28 Jan 2026 08:59:41 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <sbhatta@marvell.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <sumang@marvell.com>,
        <pabeni@redhat.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v5,05/13] octeontx2-af: npc: cn20k: Allocate default
 MCAM indexes
Message-ID: <aXmCpZWl9JHk2bpC@rkannoth-OptiPlex-7090>
References: <20260126123254.1000480-6-rkannoth@marvell.com>
 <20260128022921.4152787-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260128022921.4152787-1-kuba@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyNCBTYWx0ZWRfX8lf+QLpS7cdz
 MVwubMLldCy8jHh1AZ4Iqf8PrAoaQNdB405V3lloRBGRv6uS9+jZXME4Q6BTTEcNPc+W6zPgpGv
 LaseTb66MwthRz/5Th+K3oFPXKSJUkPr8l8/QuvJkbrOS47xfsnVzByIpnVpUVmWgQxAhvP1nxd
 y2FC1q/zSzlYgNIRiiri+WBVunuD7M2Mr9zQlvagML0IuOrYTyCyLle1NEO/fNl3IwlfAsQTTLY
 30pv41qYaW0x+9bddaPOq/g0H/4dJdJfvlOJirhxpaI+ChLT4Z+QlID1PxBXBdxQNHdVrpelCBG
 dvXOVipHONxH/LRj801YAwDRMWcceEMKuHck22llTWOZ6zJMz8GvIcA4UDdjGh8NqTEmu7m3+fn
 MmX4LZDg4tZjD96Th8bj8VH6jsrIu+vB/ppmJY4KMnQcvh84JhipcRA5uIogdrPJt1MgfocYe5A
 1EJdLn2A6nEXnM7bJIw==
X-Authority-Analysis: v=2.4 cv=P9E3RyAu c=1 sm=1 tr=0 ts=697982aa cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=qThpFUtN2p9B4LzkY_4A:9 a=CjuIK1q_8ugA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: dkQ7dxvheDib1vDPKUFdgAn5znrY4O0p
X-Proofpoint-GUID: dkQ7dxvheDib1vDPKUFdgAn5znrY4O0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254089-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: C49719CB0B
X-Rspamd-Action: no action

On 2026-01-28 at 07:59:21, Jakub Kicinski (kuba@kernel.org) wrote:
> > +chk_sanity:
> > +	dev_dbg(rvu->dev,
> > +		"%s: Default index for pcifunc=%#x, bcast=%u mcast=%u promise=%u ucast=%u cnt=%u\n",
>                                                                        ^^^^^^^
>
> Should "promise" be "promisc" here? This appears to be a typo in the debug
> message.
ACK.

>
>
> > +/**
> > + * enum npc_dft_rule_id - Default rule type
> > + *
> > + * Mcam default rule type.
> > + *
> > + * @NPC_DFT_RULE_START_ID:	Not used
> > + * @NPC_DFT_RULE_PROMISC_ID:	promiscuous rule
> > + * @NPC_DFT_RULE_MCAST_ID:	promiscuous rule
>                                 ^^^^^^^^^^^^^^^^

>
> Should this say "multicast rule" instead of "promiscuous rule"? It appears
>
ACK.

>
> > + * @NPC_DFT_RULE_BCAST_ID:	broadcast rule
> > + * @NPC_DFT_RULE_UCAST_ID:	unicast rule
> > + * @NPC_DFT_RULE_MAX_ID:	Maximum index.
> > + */
> --
> pw-bot: cr

