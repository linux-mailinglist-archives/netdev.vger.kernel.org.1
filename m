Return-Path: <netdev+bounces-254093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBpWE1iEeWnGxQEAu9opvQ
	(envelope-from <netdev+bounces-254093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:36:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD739CC4A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6E3B300C9BE
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A4F32695A;
	Wed, 28 Jan 2026 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KObCyvTP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D762EC541;
	Wed, 28 Jan 2026 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571413; cv=none; b=DeN5YeyFfTTRsH5zk9M6L1jFOokL40YbGHmf+xbi9A+rjY724U//ZJCQFgtP6WpDeLSX7T1gswGtd6RPb0UvZcOHuLiPzeCbHD6WQ/ULSzbXkBhl7EYNBLZ6x8qpAWLyi/T+eOOnzqy/ucy/7K5+sAWsfBBT/TG6itM1OVihHJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571413; c=relaxed/simple;
	bh=ubWCOAW/3Af3X54QpHOJptLeWLmRZnC7Ouhmtqvu9yU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfFIrnaR+yONnAEvsyImuuXM7iIqn+CFQIf6dm5n1NBwkqzezyDTYNIS74M07VgdeScb9UGDofPWh92zE0PFUqOY5iwpcX1pMPsa7ngpbLhs083qYiwssSkIUXPhZAb3RvltMsuqBpQdgdiantA/MUBxEVyU3qGB7U8MbiMteH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KObCyvTP; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RG2EwK1389849;
	Tue, 27 Jan 2026 19:36:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=60SxqvJal81ZGycRP4KJMMrHL
	wVZgeHHXtcFbIHEUBk=; b=KObCyvTPSSStU8Atcl05FSr+KBbXu4ZSyTxBYmaAc
	HRh1F/qHHCix5ebCNE6SnnlVzp8gwdPy9ttZzgcdUo73ceT7398pBvTnNBe0yhb6
	sr+icVe+M1JcdVVDmI359xXxv+9nB+xAqqAAhfb6yCAnKaXbPOQJESfAcwQrQ81L
	pJ7Z+6/aG55f/ZWyfL52vysE3rKyhwNWF0VszTJe7mYR7NviQ7w1VNG3RRfG4dbP
	T66lKiYA7ToNFCeMnV1HnH4Rjdu97QfDJOcxMcJxOhdEgpzgmGTz5KWVIU3tM3d0
	qqq7VKi7xPWzmOxG1l6BdJ5M5QgUj5bV6QgO1/vi7E52g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bx0qswhc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 19:36:40 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 19:36:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 19:36:39 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id C7D903F70AD;
	Tue, 27 Jan 2026 19:36:36 -0800 (PST)
Date: Wed, 28 Jan 2026 09:06:35 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <sbhatta@marvell.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <sumang@marvell.com>,
        <pabeni@redhat.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v5,10/13] octeontx2-af: npc: cn20k: Allocate MCAM
 entry for flow installation
Message-ID: <aXmEQ00dZU_psD-0@rkannoth-OptiPlex-7090>
References: <20260126123254.1000480-11-rkannoth@marvell.com>
 <20260128022930.4153164-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260128022930.4153164-1-kuba@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyNSBTYWx0ZWRfX/g8uoNkpQS8y
 4qXpJgqk6BiehraHPAqGt8MhrO6QTwK5/3IMU63x9DaMnixC8aNBqL4krTIAxhDNmh3HKlENAT/
 a2G9zwdChE1eCR7AmYa0TBiXMuyjfsAX0bC147x+2sLGHFHMY8YNNIS5X3QouOJ8ZhXpyvaSvRw
 Ycu0GML1IabfwHFoHggF0TVh+UXoAmFfhwHZXf88vC8cA6L26woMTScE7dX4sVU7g3TIM1wMZE8
 1IgMxpdjbhay3SRH2NfyomBcK/oMuZ00nainI2lRm+5OUdUGemI/4oHHOzuCw8dyKtOSnCTcZCx
 XHnu6od8hUogo9JsO81QlhHULOBfv8ZUh+JxUgESQCbB51YGq7wzvvittFpf1toZkG/pitYggjr
 NPU+7YPp+KMaOl/JKKUzXZEXJ3KVBmO+8roB1eQnCRJdecgFimgPF6NNLa5wdDLwd6yByBRMA6h
 sm6XgkxX4wUl8VS+amw==
X-Authority-Analysis: v=2.4 cv=P9E3RyAu c=1 sm=1 tr=0 ts=69798448 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=301O3xPN7kGrk-tezfwA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: 8Yqq0y-63AKjpUbaVyGfAcsPvsE-dA4p
X-Proofpoint-GUID: 8Yqq0y-63AKjpUbaVyGfAcsPvsE-dA4p
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
	TAGGED_FROM(0.00)[bounces-254093-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:dkim];
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
X-Rspamd-Queue-Id: ECD739CC4A
X-Rspamd-Action: no action

On 2026-01-28 at 07:59:30, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation
>
> This patch extends the install_flow mailbox request message with additional
> fields that allow the AF driver to determine the required NPC MCAM entry
> type, allocate the MCAM entry, and complete the flow installation in a
> single step for CN20K.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> > index 052d989f2d9a..efd994c65b32 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
>
> [ ... ]
>
> > +static int otx2_get_kw_type(struct otx2_nic *pfvf,
> > +			    struct npc_install_flow_req *fl_req,
> > +			    u8 *kw_type)
> > +{
> > +	struct npc_get_num_kws_req *req;
> > +	struct npc_get_num_kws_rsp *rsp;
> > +	u8 *src, *dst;
> > +	int off, err;
> > +	int kw_bits;
> > +
> > +	off = offsetof(struct npc_install_flow_req, packet);
> > +
> > +	mutex_lock(&pfvf->mbox.lock);
> > +
> > +	req = otx2_mbox_alloc_msg_npc_get_num_kws(&pfvf->mbox);
> > +
> > +	dst = (u8 *)&req->fl + off;
>                   ^^^
ACK.

>
> Can this dereference a NULL pointer? otx2_mbox_alloc_msg_* functions can
> return NULL on allocation failure, and this line accesses req->fl without
> first checking if req is NULL.
>
> Other similar functions in this file (e.g., otx2_mcam_pfl_info_get(),
> otx2_get_dft_rl_idx()) properly check for NULL after the mailbox
> allocation before using the returned pointer.
>
> > +	src = (u8 *)fl_req + off;
> > +
> > +	memcpy(dst, src, sizeof(struct npc_install_flow_req) - off);
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> > index 963d12ecd328..5fe077935c97 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>
> [ ... ]
>
> > @@ -1759,8 +1857,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
> >  		enable = true;
> >
> >  	/* Do not allow requests from uninitialized VFs */
> > -	if (from_vf && !enable)
> > +	if (from_vf && !enable) {
> > +		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
> > +						    allocated, req->entry);
> >  		return NPC_FLOW_VF_NOT_INIT;
> > +	}
> >
> >  	/* PF sets VF mac & VF NIXLF is not attached, update the mac addr */
> >  	if (pf_set_vfs_mac && !enable) {
> >  		ether_addr_copy(pfvf->default_mac, req->packet.dmac);
> >  		ether_addr_copy(pfvf->mac_addr, req->packet.dmac);
> >  		set_bit(PF_SET_VF_MAC, &pfvf->flags);
> >  		return 0;
>                 ^^^^^^^^^^
>
> Does this path leak the allocated MCAM entry? When rvu_npc_alloc_entry_for_
> flow_install() allocates an entry (setting allocated=true), but then this
> early return path is taken, rvu_npc_free_entry_for_flow_install() is not
> called. All other early return paths in this function properly free the
> entry, but this one does not.
ACK.

>
> >  	}
> >
> >  	mutex_lock(&rswitch->switch_lock);

