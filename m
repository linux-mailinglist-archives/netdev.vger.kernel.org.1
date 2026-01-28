Return-Path: <netdev+bounces-254090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GPoKg2DeWmexQEAu9opvQ
	(envelope-from <netdev+bounces-254090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:31:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4ED9CB37
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D387300CC2C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9F72C15A2;
	Wed, 28 Jan 2026 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cBW6dWkH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6432BE7AC;
	Wed, 28 Jan 2026 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571079; cv=none; b=cdl3TQydTs0vBItnIv285a+l3MCEFLuOiXKbVixhIxLXqqMXoTu1wsaJtKDZf2XN7RtW4qvsv5UWCKjvwcJxRltE2Hbj86R6IkU3Vv6zV5WeJ1Bx/j7zHUbBhpniWluZzCwsDgxGRcG11uzvIa8qPw94v/X1qj4XcGjenmr7EGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571079; c=relaxed/simple;
	bh=jkeA/vZl8bF8L1CzCCl8WBHoYe+jZ4+Jy3CHSeOpNkA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYzLiARF1N5o01oAnvnJgQTixxvdMTza2MmN+A7y9zuJvgFJq1WlcjO+bbG7aK62GpPVTdbWw/gGwA4Don9TxaVx2vmZYXd+oM0dw+gBHVzMUD3EWproJcViZXeMWGAwqPOzmFwl/N7WyMQMkQYLLnkECpqCaKCTnmdXaaGWeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cBW6dWkH; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S1NKLF3583782;
	Tue, 27 Jan 2026 19:31:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=vi9rjZjlUmamfYOGRXVRWHRAi
	YWstxBuGh1cSvGE7CE=; b=cBW6dWkHkTsMbDzf5N/5J7RjBQlso4EpS34hoXWuA
	K70Bp0ToTEHSmQ9hfqNcHfUOaIqrIFeeWroQwO3HxD5BomXfewdsGsNO+DhwYwEo
	kktBPRMvo3zTbJerkz/lM1auACiEGkWN3cm9ZtwZQ00bu2bVbwSyAj5phbr3wPWI
	cjFE5Rr9b+ifBY2DjSxrCbWemaditnKWCyI+qVqNh4TKdw8rlu9zqBwKumip6Cbb
	CmAlUajE8dHdANdHl5s6zuPM8rj8Q1QjbWEs0XoNoTS8qx4DIC0PkzoFvHwTZzab
	LIs/TdWPRdX8NaTUZ9TyHF5Hx+lrUuHUx+GFsjLsOe5Wg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4by8r686ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 19:31:07 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 19:31:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 19:31:22 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 671953F70D8;
	Tue, 27 Jan 2026 19:31:03 -0800 (PST)
Date: Wed, 28 Jan 2026 09:01:02 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <sbhatta@marvell.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <sumang@marvell.com>,
        <pabeni@redhat.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v5,06/13] octeontx2-af: npc: cn20k: Use common APIs
Message-ID: <aXmC9p4duz0uzV7Q@rkannoth-OptiPlex-7090>
References: <20260126123254.1000480-7-rkannoth@marvell.com>
 <20260128022924.4152852-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260128022924.4152852-1-kuba@kernel.org>
X-Authority-Analysis: v=2.4 cv=Ka/fcAYD c=1 sm=1 tr=0 ts=697982fb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=F5DxMg4TZr2gjxwrdeMA:9 a=CjuIK1q_8ugA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyNSBTYWx0ZWRfX0JSxaZGUUuk2
 DYP0WTVp3pdKtuLETpebpdu/h1y9gekfbJ6LlvgwrDl4f8+nJ8KcjXa5bKPruNgaAflQ1EaVF16
 y/f74/UP468NET3LdouGK4VRt1rrC/ZJyvfyg4qM+CodNdUqXT7povpFnzbMcP1wsLgLO4xo94+
 cv7qcpBtNn+58K84uOjVVJwKX3EXfzsCQwuMwp81kEVJ7BLY2OA65N3AWqIcAR+0J5OxSigoQr1
 ANJdpHIhqtjCJRIY43wk+fl7uak6uD3uziqWIkkjMonFoh+P+cnIePKL09Uffbi4RiyjFMCb4tH
 ZgQ+jSjzRxg9HWVi8i/pjQXmS8lM/htia6qGZHBOIg2tZW2KXtmhx2U1AJ2zC4oQrAUFSCePTaU
 /FwEaBCDPNKemaKtje/hsSVkK8e0b7vme/TNMmkSbEvNt0fmkF2g2D5udmwycVZ0kriDTNW6/BK
 3tkZkUGHt7WNtVDYhMA==
X-Proofpoint-GUID: XugrqSZwA2oFwl2GttUuSVDzFiUqkOGn
X-Proofpoint-ORIG-GUID: XugrqSZwA2oFwl2GttUuSVDzFiUqkOGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254090-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 1C4ED9CB37
X-Rspamd-Action: no action

On 2026-01-28 at 07:59:24, Jakub Kicinski (kuba@kernel.org) wrote:
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>
> > +	else
> > +		keyx_cfg = mkex->keyx_cfg;
> >
> >  	/* Reserve last counter for MCAM RX miss action which is set to
> >  	 * drop packet. This way we will know how many pkts didn't match
> > @@ -2080,7 +2169,6 @@ static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
> >  	mcam->counters.max--;
> >  	mcam->rx_miss_act_cntr = mcam->counters.max;
>                    ^^^^^^^^^^
>
> Was the removal of "goto skip_miss_cntr" intentional for cn20k? Previously,
> cn20k would skip the counter reservation here. Now cn20k reserves a counter
> via mcam->counters.max-- but never programs NPC_AF_INTFX_MISS_STAT_ACT (due
> to the "continue" later in the RX interface loop). This appears to waste
> one counter on cn20k.
ACK. cn20k does not use counters. Anyway i moved this under SoC cn20k check.

>
> > -skip_miss_cntr:
> >  	rx_kex = keyx_cfg[NIX_INTF_RX];
> >  	tx_kex = keyx_cfg[NIX_INTF_TX];
> >

