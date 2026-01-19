Return-Path: <netdev+bounces-250959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC30BD39D4E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 05:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD923006A62
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 04:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E89825C6F9;
	Mon, 19 Jan 2026 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GNgm9b+2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC31E32A2;
	Mon, 19 Jan 2026 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768795486; cv=none; b=KGGXy0GSxEUSrp6D84fnMZhPkqclDw+ooyGbn23jisE4PYI2dH0TYIQ/6wDv2zOplF++rWOw3AwDAZmAfOorM08MM6wzw+4ym21Qbv4fBK6e0+zKMZXm1rqT5RO9md8B0ecEc0tuwR8uewt7GmoipnD+kBleE1HiM6y955QkkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768795486; c=relaxed/simple;
	bh=kDCuwHROHTcQ/JxEnEtQyMKS+aJ03khn2rNimU71amQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFdm3yfqw8Oo2rhnEhDNJ+5qJwgI2m2Ig9vakVrkS/GJr/ciwrg994VEOJEat27Ahm2XFngw71iZomZ1LbY1II7+D8Q/5Tp3v2GNNEYXuGMOcXXYOKOKqA2mSwUGyutLEpvfOoE4WSjP6DuEQmjRbuf0Rj+rSV2HHBm6OFJX5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GNgm9b+2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J2TY2t1312470;
	Sun, 18 Jan 2026 20:04:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=rqPA/tOf7fu0M8iGQeGktARMq
	Qmr+R7zGxebNlwoAUg=; b=GNgm9b+2LwIymQZ2TGr86ymfQqkqudmfEBx7lxaRy
	YSu/tVh9DPDZgr4aBj2YqVhIH0t7QBG3lXadXjNittr6gdfXGsPMgNZgUYQdaEUe
	OLxW5OqdTmeLbF4KWOnZIy5bUjTG2bJ91xbHcYwxMzCHkqExmjAKup3ZGkvHvGBs
	qr9bWJDxn6kgHPmXZgVJIMA4/xh6xzk9TmaKkWdQKIcWuSAzQ4h9iUOoKykiVeOo
	jyJiNz/U0cz6k5mtrCJNpCVgUnRY8F1z2jmGMQ5PvgH6T+32GsU96wchQ3lyTj3S
	yRAseb00+NKIE/2btIVGgNwgnox6WSgG26vtZU8Ji1Rhw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bsbvfr3kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 20:04:36 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 Jan 2026 20:04:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 18 Jan 2026 20:04:50 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id BF3863F707F;
	Sun, 18 Jan 2026 20:04:32 -0800 (PST)
Date: Mon, 19 Jan 2026 09:34:31 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v4 01/13] octeontx2-af: npc: cn20k: Index
 management
Message-ID: <aW2tT6pkI-bJ3394@rkannoth-OptiPlex-7090>
References: <20260113101658.4144610-1-rkannoth@marvell.com>
 <20260113101658.4144610-2-rkannoth@marvell.com>
 <20260117163959.5e949a25@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260117163959.5e949a25@kernel.org>
X-Proofpoint-ORIG-GUID: Ywa44XuTKfbxTmr5RbFrDyIr3nsK8djE
X-Proofpoint-GUID: Ywa44XuTKfbxTmr5RbFrDyIr3nsK8djE
X-Authority-Analysis: v=2.4 cv=ebgwvrEH c=1 sm=1 tr=0 ts=696dad54 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=fLNZezRRMFmasL0oagIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDAzMCBTYWx0ZWRfXxcivG1jE3xWX
 v7rwKP0OxX351c5GpviWoD4tOYXbbxC5654s8M6W9Fbmd2n7sH8MQXPKatDPwPs56HTQuCJLEIm
 1n+tI8Ezke5oQ528t8KCHcNnMjj6yEHpaUw++K3RND4LaS4CXD02hrLFYBweg/zfsonx58CPTKG
 7qHS/z5eWl8gC5AiagPCr4C256DpfVb6Q04LuTT0vqmCum9/z4TSAf12JroXw5fJ+n/Vghdqh3B
 2IyY8LNDVBXP+hfPcU7nfRGds/y7340nHrrrMvpx0jnwwNp6f4WNgVbvQWuCduMGM/YM4qdXcmK
 3CgnaoT0g6oiKWKrkvv9+wtyZh1rAnQhLRZ9vZ4C9riAPr+jA8hA/g3TWKC4SlDUocqhkfoKfnu
 QLe0lS4G76o6mEKbXh0msIo/lBpcuVdbvjSKUxiyFbfJHAjx15qquEI2dWsUv/4VDTOLJdR6G6w
 6tNFWyfKOS3K1PMv7BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01

On 2026-01-18 at 06:09:59, Jakub Kicinski (kuba@kernel.org) wrote:
> On Tue, 13 Jan 2026 15:46:46 +0530 Ratheesh Kannoth wrote:
> > +static void npc_subbank_srch_order_dbgfs_usage(struct rvu *rvu)
> > +{
> > +	dev_err(rvu->dev,
> > +		"Usage: echo \"[0]=[8],[1]=7,[2]=30,...[31]=0\" > <debugfs>/subbank_srch_order\n");
> > +}
>

> - please try to finish up the devlink array config thing instead.
> debugfs is for debug.
ACK.

> I'll release the AI code review results,
>but as mentioned on Wednesday

