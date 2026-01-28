Return-Path: <netdev+bounces-254092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL7sBEGEeWnGxQEAu9opvQ
	(envelope-from <netdev+bounces-254092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:36:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66A9CC2A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 655DF301D07A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F7732695A;
	Wed, 28 Jan 2026 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BCiWl+lw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E130B52E;
	Wed, 28 Jan 2026 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571364; cv=none; b=eA+SLUCTsMXEOW6sT0CBdrK+rXQWxFwVxEmJm1TdEJGkIcbUdIOvzwjSlQcLHbaD1uSNfIiy1UrAfoJ/ZpFtahU87Qqs0C+dCQFPCC6l3SPN41Be59/aWGcJmTPteRbB9UaAWcgBoHUyv516yJSRh9K80RkG1neJt8tf03OLrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571364; c=relaxed/simple;
	bh=XaZm0xy3k5EBSreK2p6rpxDnagbw57SepK7uE92J6Mc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh/aWUM0vYqIm6bXklmYQlcDx0f+qlZCh+egAz7cysgC7X6albk4q4V0zEK9ylhz2Yvol8ARzeNvpKjzdqHXlKsywXYmvQDFpQjjVzk1lax+a6dt6P21wko5XHBEn+0XkQ45YoRIPkTz/qcV+H78JS1VgEtViaK0EUMTym4BIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BCiWl+lw; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S1MwCC3583354;
	Tue, 27 Jan 2026 19:35:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=aQWNyUSW2LeyAUU4Y5ILG4V7/
	zUJJ11wNy4okBYufqQ=; b=BCiWl+lw424PhvvxJBrYnTntjvU5S/4Jw80WZNyIC
	lXl+Cr/uhWk+Jdx1HWNDK6T4/lQfYvVmYoM6+T22dcuLE6ES60b7GAZc5GiuSaQR
	NINARW3KlckFLbMNltFOCW5n6zoW6TAltJZ3RoTcSarSHNBJbqKKveuZjpkPO7f3
	oyQ2v9VqmjIjn0xhmoxiYJxEYvAG+pg/VPUtGK2BIF3SacVXo6qsm0+gi6eQaR5U
	N9j3pJcLhfBhBV5G5ScvJq/E7n5jM8A88c8XmL5KQyc3NyxL2b7Dal2CuIdkGhTV
	aySoFYPewJV/pkrf6jLb9XVrNExuAK+4pB3+CLtZO2ttw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4by8r68778-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 19:35:54 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 19:36:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 19:36:08 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 2EC953F70AD;
	Tue, 27 Jan 2026 19:35:49 -0800 (PST)
Date: Wed, 28 Jan 2026 09:05:49 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <sbhatta@marvell.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <sumang@marvell.com>,
        <pabeni@redhat.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v5,09/13] octeontx2-af: npc: cn20k: virtual index
 support
Message-ID: <aXmEFX1HUKa448Ih@rkannoth-OptiPlex-7090>
References: <20260126123254.1000480-10-rkannoth@marvell.com>
 <20260128022928.4153136-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260128022928.4153136-1-kuba@kernel.org>
X-Authority-Analysis: v=2.4 cv=Ka/fcAYD c=1 sm=1 tr=0 ts=6979841a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=iUMg8g7UlDxS8Tr-YeUA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyNSBTYWx0ZWRfX2lL+UcWVrPRS
 A8ny5e6L5NoWYte9jhcCDtptzGzl1LBHNdwnhwd0WgxAyUF0peIF5HRQfMpertMT7NGVXFwKcDK
 t9xB8MFhO9pxHEiRLc2VC5Kv83ELACfKWjq3hKsJS5joMbw3XT0PAAb1bIqjc+DzIJrYkiziVC3
 GNOuhiNJ4g+Gyo2yhdwnNPZMP02xSAFnL24L8P0d04aFXJ0HgWx8CLl7nVYHddj3M4K3SSBdw3R
 WA9Ehbw6An7g8/bMvIPBzIQq5tEa8aU6RkM7BN6Hkg7dteS60LFxiDyU26UTCZTeyI5Nmf94LG6
 q3/gqBkKubAZ1TDrn8YH2AE+DhjiCKzWRKe4o+jTq610KA8WD4xbua8+GP8fLW2YkmUSVyVw3Jy
 byCILWqh8cILg2huiX7pIHn1bBqoK3UsyteQePrhsmm87KG/R9ZlE6kSeuSDLDM9ZQjmmTMiO1o
 LFiTky9PzBHqKGD7MdQ==
X-Proofpoint-GUID: SGeXBOGQENsHhRXBbJoEgewrp8GuPnin
X-Proofpoint-ORIG-GUID: SGeXBOGQENsHhRXBbJoEgewrp8GuPnin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254092-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 4E66A9CC2A
X-Rspamd-Action: no action

On 2026-01-28 at 07:59:28, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-af: npc: cn20k: virtual index support
>
> This patch adds support for virtual MCAM index allocation and improves
> CN20K MCAM defragmentation handling.  Virtual indexes allow the hardware
> to move mapped MCAM entries internally, enabling defragmentation.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > index 8b77ac053d8d..d1a927f3d5db 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
> [ ... ]
>
> > +static int npc_vidx_maps_modify(struct rvu *rvu, u16 vidx, u16 new_midx)
> > +{
> > +	u16 old_midx;
> > +	void *map;
> > +	int rc;
> > +
> > +	if (!npc_is_vidx(vidx)) {
> > +		dev_err(rvu->dev,
> > +			"%s: vidx(%u) does not map to proper mcam idx\n",
> > +			__func__, vidx);
> > +		return -ESRCH;
> > +	}
> > +
> > +	map = xa_erase(&npc_priv.xa_vidx2idx_map, vidx);
> > +	if (!map) {
> > +		dev_err(rvu->dev,
> > +			"%s: vidx(%u) could not be deleted from vidx2idx map\n",
> > +			__func__, vidx);
> > +		return -ESRCH;
> > +	}
> > +
> > +	old_midx = xa_to_value(map);
> > +
> > +	rc = xa_insert(&npc_priv.xa_vidx2idx_map, vidx,
> > +		       xa_mk_value(new_midx), GFP_KERNEL);
> > +	if (rc) {
> > +		dev_err(rvu->dev,
> > +			"%s: vidx(%u) cannot be added to vidx2idx map\n",
> > +			__func__, vidx);
> > +		return rc;
> > +	}
> > +
> > +	map = xa_erase(&npc_priv.xa_idx2vidx_map, old_midx);
> > +	if (!map) {
> > +		dev_err(rvu->dev,
> > +			"%s: old_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
> > +			__func__, old_midx, vidx);
> > +		return -ESRCH;
>
> If this error path is taken, xa_vidx2idx_map now has vidx pointing to
> new_midx, but xa_idx2vidx_map still has old_midx pointing back to vidx.
> The bidirectional mapping becomes inconsistent.  Can this leave the maps
> in a corrupted state?
ACK.

>
> > +	}
> > +
> > +	rc = xa_insert(&npc_priv.xa_idx2vidx_map, new_midx,
> > +		       xa_mk_value(vidx), GFP_KERNEL);
> > +	if (rc) {
> > +		dev_err(rvu->dev,
> > +			"%s: new_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
> > +			__func__, new_midx, vidx);
> > +		return rc;
>
> Similarly here, if xa_insert fails (e.g., memory pressure), the maps are
> left inconsistent: xa_vidx2idx_map has vidx -> new_midx but xa_idx2vidx_map
> has neither old_midx nor new_midx pointing to vidx.  Subsequent lookups
> via npc_idx2vidx() for new_midx would fail to find the correct vidx.
> Should these error paths restore the previous map state?
ACK.

>
> > +	}
> > +
> > +	return 0;
> > +}
>
> [ ... ]
>
> > +static int npc_defrag_process(struct rvu *rvu, struct list_head *lh)
> > +{
>
> [ ... ]
>
> > +err:
> > +	/* TODO: how to go back to old state ? */
> > +	return rc;
> > +}
>
> The TODO comment here suggests awareness that error recovery is incomplete.
> Given that npc_defrag_move_vdx_to_free() calls npc_vidx_maps_modify() which
> can fail mid-operation, should the defragmentation be made atomic or have
> proper rollback?
Whole defragmentation process is done under lock. We cannot roll back as roll back
can also fail.

The defragmentation process failure indicate a bug in index management code.

I removed the "TODO" comment and added an explantion.

