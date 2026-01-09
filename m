Return-Path: <netdev+bounces-248315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C027D06D6A
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 03:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A75301739A
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 02:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C3B305968;
	Fri,  9 Jan 2026 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WE01PEFJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF82FB09A;
	Fri,  9 Jan 2026 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767925107; cv=none; b=SAIk360nEPPP+2cEWvMMjc3/+nsMUVh4eCAG0YUofAp3FraLnsG8gKG5w0HScn/1VdRh1sQzni+JzMBgd8RSVHlOqWPj9Q+SlC9s96uTTSvaWSBWuqsiW8HBD1uJUmR5caqy8OSSPHrq5zMSymyC0YJw1ndf6Y/Lyf/obdtQwm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767925107; c=relaxed/simple;
	bh=oKH0rjJzzA5b7gQfjTlKL/y27PPHmQmN76D0rmom27o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMCEgIjOA8Enx4yms3zyeRcsZBOA5o6ACs5mW0Ha6yPRqlSE6euFfpA1sY2hCbpYx0t0nN+S7duqhUGbMaX/p5H0lCnrb9fgYDIC5RlrcQ6/0RV7b1wZ7KdsvVdu5Hdewn52bURU8WdfHVGDgN6GoNQWjMVE3Y68RtQkS8pGP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WE01PEFJ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608Etkb92094216;
	Thu, 8 Jan 2026 18:18:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=oKH0rjJzzA5b7gQfjTlKL/y27
	PPHmQmN76D0rmom27o=; b=WE01PEFJ65b+XC1VC6ukhIgwWbugii74Xor6sccgF
	1FKqjZTihM2NAxLvM9R/eOo8XCw4qatHoqoG0Vzxz7hpo6bRoXZewFwoABPdtIjW
	wx1SW22ZpuIdQFMBdd18N4b8FXgrE48zOWdmBg76RBRDEAuZWVgfNJyubM7x/Koe
	VnfnSzLo2jJ0qcC94d2dpVmoSrVlVfbujqZhTFSbnRLGMinxGO6Jhlmi4dfdbXPW
	KvSIL/abq7QggvMkYz3Y2a1rmVIuR9eBh7yXv9icwVvDyJjLGRKmBs5YcMWEjP7U
	TPqC7PgZI1HvqCpqAIySpKZiSJvsPQfjXJXmEQrZws6og==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bj181b51e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 18:18:03 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 18:18:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 18:18:16 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 883C13F70FB;
	Thu,  8 Jan 2026 18:17:59 -0800 (PST)
Date: Fri, 9 Jan 2026 07:47:59 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        Suman Ghosh
	<sumang@marvell.com>
Subject: Re: [PATCH net-next v2 03/13] octeontx2-af: npc: cn20k: Add default
 profile
Message-ID: <aWBlVxeOnAfCxfkc@rkannoth-OptiPlex-7090>
References: <20260107033844.437026-1-rkannoth@marvell.com>
 <20260107033844.437026-4-rkannoth@marvell.com>
 <20260108175950.GK345651@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260108175950.GK345651@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAxNCBTYWx0ZWRfX1Y2vT2PCb0ym
 spmXHvMzR1g6G8O05Nydu1P+QdIT9Q4iPLtyaqegisbocA5U+mXLUEC/XfdoqLxFV+3Meq7R3gb
 2xmmOrsKNKz3f/d6qzwYrDa8sfrfM7YmH2pa1CKFk98qW4msMww2PRJo1oEdGU3QyLrlgM06BNY
 ddnYzLwcWHCDebCDwEjT3fumt64MyzvodoE9wGp+6YDjv3l5LcscFldQObJZmtwRB1K2h1ew8Xq
 +faBicam3S1N6jlK8hnhKVglYSzJkCOjGgX2uSP0nbMRt10q1pqxyob+d27DilSINysQ66Jb56J
 5oQ/8tnp14RGmgK0WtGFxzkDDCvkSnt3j8AfWDzOdTyU76WyCdICBjO/HQrxKvMxgh5CCEKTfwL
 5TUPB5BvMc3jXEz5g+Te+ZfmOvuTholBeWywUVvxIfZZpMK09SqSdKjY7jgWsk/gJYyZSjaUf3Y
 yeYo/Q0oEBdLtxA+HhA==
X-Authority-Analysis: v=2.4 cv=Vdf6/Vp9 c=1 sm=1 tr=0 ts=6960655b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=d0FI7k7IQsfs4wOnv_sA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: QIW5ZEjrjRqtOwREBehkJQM0ltDpX-z4
X-Proofpoint-ORIG-GUID: QIW5ZEjrjRqtOwREBehkJQM0ltDpX-z4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01

On 2026-01-08 at 23:29:50, Simon Horman (horms@kernel.org) wrote:
> On Wed, Jan 07, 2026 at 09:08:34AM +0530, Ratheesh Kannoth wrote:
> > From: Suman Ghosh <sumang@marvell.com>
>
> Hi Suman and Ratheesh,
>
> NPC_CN20K_PARSE_NIBBLE_ERRCODE isn't defined until the following patch,
> so this results in a build failure.
>
> ...
Thanks. will fix in V3.

