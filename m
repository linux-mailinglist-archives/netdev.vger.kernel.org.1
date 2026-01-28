Return-Path: <netdev+bounces-254091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLTrKT2DeWmexQEAu9opvQ
	(envelope-from <netdev+bounces-254091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:32:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBAC9CB56
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AA5330182AD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C932EC541;
	Wed, 28 Jan 2026 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="C2hktf4U"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506851F4181;
	Wed, 28 Jan 2026 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571120; cv=none; b=n4qKVf0QWDFNvw2zk+jDofZWmUzS7dUYGk8lkddyz/QwEEk+JdA71MsfbufyVxKxGmWNprHs7n3E597PQiG5f1EGcdQembU1suf0NX/169sfQiqwDh9wg9rYavrTg8Cy4co2bCoPCpt0unl2wJYCN4nbUp20UCLkKn6PwQkHMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571120; c=relaxed/simple;
	bh=bixJH1bUAHPWD1oZXAscYYeFXZq03450SDQm9T0jmqs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQkI/yUx3f79Ow7+aAqfd+/6HdwSI6n+ftzrM+MLDRFKw/3k4oE3obxqmAe+YduYNC7wkH9M6V31kj0GDHKh+BswttojPZPnSQM4/CYP++95HKo7z14ogiPYwxskO8fA8jAgy9OEUml8+k+ayilNwJ+n+2ObenrTUFMLbIw/psI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=C2hktf4U; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RNTYlG379905;
	Tue, 27 Jan 2026 19:31:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=rEuOLqVeJknwWliEk0KMfvU/J
	BVF6K0PloxhTDHHEVc=; b=C2hktf4UkJ3EAsdq0buXffTaJ1QF0vuxfAcjYjxKk
	2sZlMENkZ9PQCkGG0kV9XKqJEdqcdUq91lPAkvfVK0lRQmyALCYXV90TJuo5XJ2K
	5bztNl24HSUwpww7JU0umnDEWGDOOJoRr3B98qmwIrC+zkcPkMcds1+ae3eK9mX4
	9F5ii6Rss23MpsUm8t/hD0MdmaTrA/AQI//4QwGUdOsEdX/oAGXLjDqxowrhKo5w
	Ym/0sCfIocFfgXBM+EtYMCDxYh8jTfersUGcuA8yJ1rJkZdPQFfKHGcApUHgNxPr
	qMC7IWkyy+vcdFtK862JX+lRMLnMaFF+0TdykN5OelOfg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bvxfjqhaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 19:31:51 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 19:32:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 19:32:05 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id B9B313F70DF;
	Tue, 27 Jan 2026 19:31:46 -0800 (PST)
Date: Wed, 28 Jan 2026 09:01:45 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <sbhatta@marvell.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <sumang@marvell.com>,
        <pabeni@redhat.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v5,08/13] octeontx2-af: npc: cn20k: Add new mailboxes
 for CN20K silicon
Message-ID: <aXmDIZx5P-7k90yI@rkannoth-OptiPlex-7090>
References: <20260126123254.1000480-9-rkannoth@marvell.com>
 <20260128022926.4153023-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260128022926.4153023-1-kuba@kernel.org>
X-Proofpoint-GUID: BjHboQG-FeREp5Naud8_UiMb4N1yPutA
X-Proofpoint-ORIG-GUID: BjHboQG-FeREp5Naud8_UiMb4N1yPutA
X-Authority-Analysis: v=2.4 cv=S9LUAYsP c=1 sm=1 tr=0 ts=69798327 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=OM17Ie04NdUCIjpt_V8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyNSBTYWx0ZWRfXzfTeVDo9pBPg
 f7K0WEqlCsi7owXDwwpQIt1kpaJVpdGSJggDSnzhP1peJVSK7Mvv8Px8KQbbCgxaLMvXuQbCLLz
 DCvRblf1KLNNfQA3Dp1UTKOc5EU3X+z4xcDE2RjawmbSDEpMJEE35OGKjszGp4iDwvbNCX9Scce
 Mz1k+eXRCOZ4xs4agniHddsDDhwzmBIxd/JMSwgOaxqgsW33m4zL91gQWqIL3zQcFp2iFx5L1lI
 EElS+hUwVIkQUp7/a38oZx5Ihu8Ti3He5kYyirudar8oqG8RW+uYS8/5JQ3f2+MWHqkEXI3d/T7
 asg7P9sVqGur6GTpOvnqWC2FaFalDKQ8ZH88Qn8ah/k/2YSRW02QigVcnWR693FWIIY5f79tR+O
 46YZed3zbb1EdLoPLk/E2Pm1LPQXcUKT5IBH3zR4v5aeBn7FPw2ecrMrY572ST0iYL2Ii+cLWhR
 dA2oM5bZnUewL2R9bXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254091-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2FBAC9CB56
X-Rspamd-Action: no action

On 2026-01-28 at 07:59:26, Jakub Kicinski (kuba@kernel.org) wrote:
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> > index cb05ec69e0b3..cefc5d70f3e4 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> > @@ -644,6 +644,7 @@ struct rvu_npc_mcam_rule {
> >  	u16 chan;
> >  	u16 chan_mask;
> >  	u8 lxmb;
> > +	u8 hw_prio;
> >  };
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> > index 425d3a43c0b8..620724dad093 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
>
> [ ... ]
>
> > @@ -3554,6 +3555,15 @@ static int rvu_dbg_npc_mcam_show_rules(struct seq_file *s, void *unused)
> >
> >  		enabled = is_mcam_entry_enabled(rvu, mcam, blkaddr, iter->entry);
> >  		seq_printf(s, "\tenabled: %s\n", enabled ? "yes" : "no");
> > +		if (is_cn20k(rvu->pdev)) {
> > +			seq_printf(s, "\tpriority: %u\n", iter->hw_prio);
>
> The hw_prio field is added to struct rvu_npc_mcam_rule and read here in
> debugfs, but I could not find where rule->hw_prio gets assigned in
> npc_install_flow(). Looking at the diff, cn20k_wreq.hw_prio is set from
> req->hw_prio, but rule->hw_prio appears to be left uninitialized.
>
> Since rules are allocated with kzalloc(), hw_prio will be zero, causing
> debugfs to always show "priority: 0" for CN20K rules regardless of the
> actual hardware priority configured.
>
> I see commit 62770f15276b "octeontx2-af: npc: cn20k: add debugfs support"
> later in the series adds "rule->hw_prio = req->hw_prio;" which appears to
> fix this. Should that assignment be part of this patch instead?
ACK.

>
> [ ... ]

