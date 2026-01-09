Return-Path: <netdev+bounces-248316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F247ED06DEC
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 03:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A0093014A3B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 02:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D223164C7;
	Fri,  9 Jan 2026 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Qxfl75n0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5E2BB13;
	Fri,  9 Jan 2026 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767926522; cv=none; b=ZbAVsgw/KVu2DqpDbtCTKb9A2s5YCAEi24POf43RQ97rY/N/trZ+8pFVRghrWw2TBtfG+bDcSSTylenYKV4GUZ4PJvyLhDQYCOEaie+VrOSl+V92/AAWN+vT5tEwTy+6WMnXOZTHFY7/my8fiwMaxZN7ERvKnDE4ORm8h9rc7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767926522; c=relaxed/simple;
	bh=8gIJc307wYswg9bvGm4UixvDJfrgQK+eXf+YReey38M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lmj3GJv4JyJ5ME1Gs09rkM/4la9rqbOZ4gaT6mE6bfPKlqVWgQPHawQPbaBOLz51FeRRUIf3ZnJnt/exT1aVTOOOJka5L8lx3gbxIzGH4dE/F9/jB7wfT0iZHTF3w77S7EpHMnm934cZHQM7UYUlmdkPbTXsTSQ0TOlqUgWke4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Qxfl75n0; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608F7nKj2095868;
	Thu, 8 Jan 2026 18:40:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=FytM9jyUt8R9AbPyqihzzt205
	z8R7kzPVjV2qgzlwRI=; b=Qxfl75n0OUBNKtbl7u2yQx5AydI8YSOwcDkMTrUcg
	xhg+Jqq9WCH0UT06FJrk9nRrQwo+zMk82P8g4BwJf3DEQ+UdWgZAyJ1dXCxlCikb
	Z2PFk/2D9GHGrLeqhdx80jUFGx4ui2dyPTZd1niSCvi5In3EvmsAZcgYQccX6AT7
	nX05OV++zLYZ26Zrp5pfd8eLMw2WvBPB05D2P7WfFw5SoCPzd8eePELiGyfkpzn/
	RABmSTgv2qwBIBouV+6/dAW/o99ARThf6IMxRfKJcTa4OUjqXrX64RsxxopIr9Zc
	/lgQ4lLdYncGigJIaNxH8FhXGaFSGuCyqDkzaj1rxiJxA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bj181b60q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 18:40:48 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 18:41:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 18:41:01 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id C6D895B6921;
	Thu,  8 Jan 2026 18:40:44 -0800 (PST)
Date: Fri, 9 Jan 2026 08:10:43 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <sumang@marvell.com>
Subject: Re: [PATCH net-next 01/13] octeontx2-af: npc: cn20k: Index management
Message-ID: <aWBqq9UKWD5ewKpA@rkannoth-OptiPlex-7090>
References: <20260105023254.1426488-1-rkannoth@marvell.com>
 <20260105023254.1426488-2-rkannoth@marvell.com>
 <20260108175357.GJ345651@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260108175357.GJ345651@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAxNyBTYWx0ZWRfX5iPEkhe/smQx
 HwUQ6L6U9YT+EPkbI9Rj5bVBz6Qdl1hu4DyYujdRCUY5ZQKWqJXfFbSBNUXXS+RJDk0Xk7cBRT5
 CGf5FvAkRloTGRunl92g3U3g1IgU28i8bclcJ394P4gLbItwNzW3+Z+3hnp1pveaktwZn8FypH2
 xtBORx/0GUVSocMCdXABpqKsX0ThASrABKcJaCyKqGdv7x/CoYOzo94L5GcJL0vOA4+TmbOF6OP
 Aanya1uLrgJuWC5wAIFAEgZlV4ylgiRUQQk5S5Qfy8TThS5SZJxxxeEB45g26Bj5eR5Rr1soDW0
 Y9q/4ehhWcWxm8FvteILvv8ChgqqtFFQNsRAA/IyZXej9heXG6NpfM+KBibu1ZA9ioekcOba+Op
 pVi8gULj2oenttxFje8qD81qFfFRlBHCbLP/GJQ5n30aMIBWuN6CCki6by58A3kqHk1yYcQqQrd
 90IqgLkSMGxIOXEOymg==
X-Authority-Analysis: v=2.4 cv=Vdf6/Vp9 c=1 sm=1 tr=0 ts=69606ab0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=GYswm18s28uouDx7PEEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: S625oUeu11u7wQbNaaY0sikQ25odYZr1
X-Proofpoint-ORIG-GUID: S625oUeu11u7wQbNaaY0sikQ25odYZr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01

On 2026-01-08 at 23:23:57, Simon Horman (horms@kernel.org) wrote:
> On Mon, Jan 05, 2026 at 08:02:42AM +0530, Ratheesh Kannoth wrote:
>
> > +		if (strlen(t1) < 3) {
> > +			pr_err("%s:%d Bad Token %s=%s\n",
> > +			       __func__, __LINE__, t1, t2);
> > +			goto err;
> > +		}
> > +
> > +		if (t1[0] != '[' || t1[strlen(t1) - 1] != ']') {
> > +			pr_err("%s:%d Bad Token %s=%s\n",
> > +			       __func__, __LINE__, t1, t2);
>
> Hi Ratheesh,
>
> FWIIW, I would advocate slightly more descriptive and thus unique
> error messages
ACK.

>and dropping __func__ and __LINE__ from logs,
> here and elsewhere.
ACK.

>
> The __func__, and in particular __LINE__ information will only
> tend to change as the file is up dated, and so any debugging will
> need to know the source that the kernel was compiled from.
ACK.

>
> And I'd say that given the state of debugging functionality in the kernel -
> e..g dynamic tracepoints - this is not as useful as it may seem at first.
Since these represent valid error cases, they should be logged by default.
Relying on dynamic trace points would require the customer to recompile the
kernel and retest, which could lead to significant debugging delays and
multiple rounds of communication.

> ...
>
> > +			if (contig) {
> > +				cnt = 0;
> > +				rc = npc_idx_free(rvu, mcam_idx, cnt, false);
> > +				if (rc)
> > +					return rc;
>
> Claude Code with Review Prompts [1] flags that the call to npc_idx_free()
> is a noop because count is reset to 0 before (rather than after) it is
> called.
THanks, i noticed that patchwork AI code review tool also detected this.

>
> > +	if (!fslots)
> > +		return -ENOMEM;
> > +
> > +	uslots = kcalloc(cnt, sizeof(*uslots), GFP_KERNEL);
> > +	if (!uslots)
> > +		return -ENOMEM;
> > +
> > +	for (int i = 0; i < cnt; i++, arr++) {
> > +		idx = (*arr)[0];
> > +		val = (*arr)[1];
>
> FWIIW, I think this would be slightly more clearly expressed as:
>
> 		idx = arr[i][0];
> 		val = arr[i][0];
>
> Likewise for uslots and fslots below.
ACK.
>
> > +
> > +#define MAX_SUBBANK_DEPTH 256
> > +
> > +enum npc_subbank_flag {
> > +	NPC_SUBBANK_FLAG_UNINIT,	// npc_subbank is not initialized yet.
> > +	NPC_SUBBANK_FLAG_FREE = BIT(0),	// No slot allocated
> > +	NPC_SUBBANK_FLAG_USED = BIT(1), // At least one slot allocated
> > +};
>
> I would suggest using Kernel doc formatting for the documentation
> the enum above and two structs below.
>
ACK.

> > +
>
> ...

