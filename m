Return-Path: <netdev+bounces-273453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPfUE71Fy2nSFAYAu9opvQ
	(envelope-from <netdev+bounces-273453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:55:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 900F2363C57
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06D163036EEC
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851BD292B54;
	Tue, 31 Mar 2026 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G/PW045v"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9E1A3154;
	Tue, 31 Mar 2026 03:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774929274; cv=none; b=s4Imwjohc/d3qCVtuA4YL8VgqPg4rhs7/v7vSeVlmP5eAU+tUZ6JjKnO5nttSrt9pubOlvyLyASMWccW2x21CDdmhuwVpyYDbqNquaRk1Ny9Bk6mH1hv2ocQfBG/ltzMi6QVp3QdZtqmIJU1d65Tn9CGuycxamPBCQ0uiZZLeqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774929274; c=relaxed/simple;
	bh=ATZV6iycX6yHF6Pq4Es1cRfIe5pU2PFBMmBvdNhgBdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPrnCbouX2dnKL6Fx8INFJMFwypuT7jciBUxK8Zymi0DEW56lkr/8QhgPONN7deWh5lGLcwFvZu3EOraMpe6ukJS9sUmZCyWRH6F+YNMG9wkPWVymD1wl+8HU85JSmDCDzJQF/pnyjEopgvEYGN969Hr0jXdBisLoZ2uhnEDh2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G/PW045v; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UGNWDo3053916;
	Mon, 30 Mar 2026 20:43:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=2AdKfCKm/uHWeLRWf9vQNwB7K
	mqObbWnQF+GtyT5gmA=; b=G/PW045vhMBacMs3iMIHo7DpP7JTzxBetvKp8Y5pS
	yEuIobpg9q2ipxbeZ5K0BCX587VIWrm6Cc8SLwGLJtUIMsHyPXk/N7ESYAt3/Ks0
	ZwNVZSoD48SVpeSbnvikybTo5cpAnAY+atkDO5qRV5qCxS1wE5E0Pe8mIJg0JjDB
	37uu/RccwZScKuwv8vrqoJjoCLV9J7zvpbGcdsINn+4H/+MMywf+2GMgKp4aH9hk
	D0AZF5TAkjGsrTpuvVHW5gHnqnUPoWw82kgx6nvF0taVajvGUf7rAJvA2eUeScfC
	mOS6GoVI6i8MEbC0K6KVg4l4rYqppbGTZR266IdMdWxsA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d6yr73xrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 20:43:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Mar 2026 20:43:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 30 Mar 2026 20:43:12 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 454C03F705A;
	Mon, 30 Mar 2026 20:43:07 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:13:06 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <donald.hunter@gmail.com>,
        <jiri@resnulli.us>, <chuck.lever@oracle.com>, <matttbe@kernel.org>,
        <cjubran@nvidia.com>, <shshitrit@nvidia.com>, <dtatulea@nvidia.com>,
        <tariqt@nvidia.com>
Subject: Re: [PATCH v8 net-next 6/6] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <actCysjPKrnzExJx@rkannoth-OptiPlex-7090>
References: <20260325072159.1126964-1-rkannoth@marvell.com>
 <20260325072159.1126964-7-rkannoth@marvell.com>
 <20260327133036.GE567789@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327133036.GE567789@horms.kernel.org>
X-Proofpoint-GUID: SnWgw0JvzTdgsB2ff63YnKQoHaGpZadF
X-Proofpoint-ORIG-GUID: SnWgw0JvzTdgsB2ff63YnKQoHaGpZadF
X-Authority-Analysis: v=2.4 cv=a949NESF c=1 sm=1 tr=0 ts=69cb42d1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=9R54UkLUAAAA:8
 a=VwQbUJbxAAAA:8 a=JAhMjkpjCbTQvw1v-iEA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAzMiBTYWx0ZWRfX00mx2mbcYNZb
 JuC2i4tyirho9LvXi/rtpIzbNlbe0Ygh0VdpqzeQxw3zICdrlv3E0zWxld9RDZTpEuD6wmKgvPK
 MXYsB6Fs+IZdzyMPaRNxRt9F+RxVLe6Hu3p2q0Ewq7j4Yg5W1s7IOMmlPRllMAsTHxrsQkJtPov
 v4/vckIQoBnWNPi3X8aRlC6AWADxk/hEM0BIa8+2sSqOPYKoxvBX9vDK3sroqxoJ2xmn6Lxt5Wz
 JiQd9AiQKusgnpW9WugPeEYipkBfXVphFsg+Q+5gnSQHgHJv+9oIlfGGRPzHH2Dq9BhQkyYnAhT
 oI64X+/M+/ey79Hk2YIhWN6NxhhplOxevKT6sBjjlXa4EfQ6uRXxuDue9akzqIQ7H2/S/+7GVDE
 6kMQHjpeYEIGJDBHOv9IOTu3bXwt+AtiNLDQjDrPYW7Hl3uX7hgf6ygDpXc71dq7N8Jhgc7cN/W
 Tt2rZRfywg2nBx9aWug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273453-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 900F2363C57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-27 at 19:00:36, Simon Horman (horms@kernel.org) wrote:
> AI review flags that:
>
> npc_load_kpu_profile_from_fs() calls npc_apply_custom_kpu(),
> which returns early if the following condition is met.
>
> 	if (fw->kpus > profile->kpus)
>
> Does npc_prepare_default_kpu() need to be called before
> npc_load_kpu_profile_from_fs() to initialise profile->kpus,
> which is 0 by default due to profile being allocated using devm_kzalloc()?
simon,

Thank you very much for your time.

The v9 AI review has raised the following concern again:
https://netdev-ai.bots.linux.dev/ai-review.html?id=f29b81fe-bb3f-4902-85de-8271effbb41c

"In the filesystem loading path, does profile->kpus need to be initialized
before calling npc_load_kpu_profile_from_fs()?

Simon Horman raised this concern in v8 review on lore:
https://lore.kernel.org/netdev/20260327133036.GE567789@horms.kernel.org/"

would like to clarify that npc_prepare_default_kpu(rvu, profile) is invoked
very early in the flow, and therefore applies to all execution paths
(default, filesystem loading, and firmware loading). Additionally,
if the filesystem loading fails, npc_prepare_default_kpu() is invoked again to
ensure that all values are reset to their defaults before attempting to load from firmware.

Could you please advise on the best way to address the AI review comment?
Specifically, would you recommend:

1. Adding a clarifying comment in the code, or
2. Invoking npc_prepare_default_kpu() again just before npc_load_kpu_profile_from_fs()

to make this behavior clearer?

Thank you once again !

