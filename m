Return-Path: <netdev+bounces-248020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A1BD02B43
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 13:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1F2033F2CDC
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D5242A110;
	Thu,  8 Jan 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ygda1Zl3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CE73EEFD0;
	Thu,  8 Jan 2026 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864953; cv=none; b=O54cRBbIDySgDEVs/ba4Yk4tjlyIIgtSmEWBcB9MADOOi9iFlo0MGkbR34lQQ3+FtWWVqhLOGfoaXRs6kGcaweCWduxrlm3cqXwnVSS8SARbh/yJFAL2nGMtx//adMhxsg41wc1fi0ZNdFbv+VC5dYiUNAistMUjuUTCfGplrmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864953; c=relaxed/simple;
	bh=u4VNoQ4LhdNMfgJfjaPrZHW/RqtvVeuzsobcsLRKZ6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2tBsCIoGl/btuf5ojSFDhwX8FBVRbHIX2SV2J8etd7sQ895dpKAPloECs9T+a0RAoP2ubR4o4mwcr1F7BsSi+LataP0/gUlQb+X5btH4GKbQA5TqXp2/Tr09oBpi02HwZEfhd8fJeUkqHKqFFKwgNBf0bH6PGXvBiO8czoEcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ygda1Zl3; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607NW88a2095193;
	Thu, 8 Jan 2026 01:35:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=R9m/7bu28KfSpruc1SVA0v9xT
	u6mKd3dyd3y4F5hcGo=; b=Ygda1Zl3zD8t5iZhIbaZYyr762Brj+MVaF9aO7ke3
	vVxYrC7A9fDN/7ictd/cQj/VUD7VeeWkQf++BjHUq5mWTo32C0lXDxvzGTtkCx+2
	145Qd56LVN/DHiBL47lz1vOHclMg6p2fn9NT78CrTj+gA8JoX/8qTDJyoY3ovHxK
	rjZikIx2Y+iwAowZ9Wy1D8CjIbyvHJDzhec1gfBwDqo+z/xBaV9KrNWofRmfvpal
	+ZTU6IgBqCNcZBdrQmlJo4R4GZLLBjUEZlwon1KnqmtIFnpBZ0Ok+NyGwly+y7OS
	ju3BqPDPJVDyt5WJmOp8K7HT+sQok9B7tqITk9j6e03Zw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bj18193t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 01:35:17 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 01:35:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 01:35:30 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id C8CAB3F70AC;
	Thu,  8 Jan 2026 01:35:13 -0800 (PST)
Date: Thu, 8 Jan 2026 15:05:12 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 07/10] octeontx2: switch: L2 offload support
Message-ID: <aV96UNXRN9tzuWxI@rkannoth-OptiPlex-7090>
References: <20260107132408.3904352-1-rkannoth@marvell.com>
 <20260107132408.3904352-8-rkannoth@marvell.com>
 <99647efb-537c-462e-bbef-a3c01ef1bd8c@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <99647efb-537c-462e-bbef-a3c01ef1bd8c@oracle.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MyBTYWx0ZWRfX6sqMdsaALcgG
 5RiGO+VRxKvP48y0Gks261d8p6/Rbde6lDs/VBEzgbikiqr1IgUDTkqSaEOB7oAhuV7K4/DicwU
 upgosAugncX34WGZNDpnnkiBxoXPg1ZX5VDuLquufq06L8XTB3ktFYWLrmNmwmaFBgN44VTc1ji
 Y9N8rgAglCJdIcSR+CGeEG+nVUV4xchZ5IpxnCfPjCrXhiGzO8dbfdjhKPcIfNmhHNUdMCmQ7Na
 W2L8mSAHq5dFy19fiRQztYzjk8Xp9yUdFx1psJZ85kgZY+HjJnHLQaXE1+T4g5gYYhcMNTXlULY
 X6EIETbyhhOGq5roZ/Xpb3vOpriEqrLHpZ5ijVFjzOclsD4ssDM/b2t5OxCWB/76x2yC/VosXHN
 svENQxeqCQo39Xfq+AX7f7MvEUjydvgm9Zox1T0Gi1ACldSRK1+i0crIETWDFe4MSmeRUe40WYL
 A305a2dc31zCVEA46zw==
X-Authority-Analysis: v=2.4 cv=Vdf6/Vp9 c=1 sm=1 tr=0 ts=695f7a55 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=fx7Rj7giRjSIOVbTE-wA:9 a=CjuIK1q_8ugA:10
 a=8_z660xuARpGUQqPBE_n:22
X-Proofpoint-GUID: fHjv5R4HGN7EkCuiYfnHLqQf03CfdFbx
X-Proofpoint-ORIG-GUID: fHjv5R4HGN7EkCuiYfnHLqQf03CfdFbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01

On 2026-01-08 at 14:37:38, ALOK TIWARI (alok.a.tiwari@oracle.com) wrote:
>
>
> On 1/7/2026 6:54 PM, Ratheesh Kannoth wrote:
> > +		fdb_refresh_wq = alloc_workqueue("swdev_fdb_refresg_wq", 0, 0);
>
> consider, "swdev_fdb_refresg_wq" -> "swdev_fdb_refresh_wq"
ACK.
>
> > +		if (!rvu_sw_l2_offl_wq) {
>
> Checks rvu_sw_l2_offl_wq instead of fdb_refresh_wq
>
> > +			dev_err(rvu->dev, "L2 offl workqueue allocation failed\n");
>
> offl -> fbd
ACK.
>
> > +			return -ENOMEM;
> > +		}
> > +
> > +		return 0;
> > +	}
> > +
> > +	rswitch->flags &= ~RVU_SWITCH_FLAG_FW_READY;
> > +	rswitch->pcifunc = -1;
> > +	flush_work(&l2_offl_work.work);
> > +	return 0;
> > +}
>
>
> Thanks,
> Alok

