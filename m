Return-Path: <netdev+bounces-249382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5804D17D64
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4692B3001825
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C9343D84;
	Tue, 13 Jan 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="O4rRT5Ag"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93833F8C5;
	Tue, 13 Jan 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298575; cv=none; b=aOiqbjyViPa4Im5rF0420lP2qocXmBPpVawDeUl8qnA2A1nvKkAL00gF8oVgwYgy0pMcLxNfV7Sm3YwUCjogmuJUggd027KB59614gTBjUTAip7ryPFiopxPhwm3fBdNejrwN8GkxGLFj6NsbV+K7CphqNRgmvU6BHMkO8XjFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298575; c=relaxed/simple;
	bh=Hk5FuLQBlGYUXB8fZpgsLrSdmPEDFxsobo45wV+rXco=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGmgLlb85/tC0gdzR/muFTqs4c04Lb2m5lisMpgdz97vPt5w/IFDZK1CCVqkSTWJU7b01ocr16+MmVY+GT44QtFZrWA+Ikz5NrDlZdIKiYLkFU2Ji25OMLy4Y+2B5o9jiIpaAgOWGvGQVYBBuke49AlJvml/PPD2DAfO9L3JK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=O4rRT5Ag; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q6F93356391;
	Tue, 13 Jan 2026 02:02:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=1wfYsnindzhA7nEu3JrsaIIXG
	dfqodSsR/2kzV/ZtbI=; b=O4rRT5AgLkiIRHTuZekql4Q4UIOppyXOJmVhIeMov
	8MfjC0UpI/kRlJ2EZKRSlREnpk4iP9XZzOCuvCmPGntPVScrdaBJa5K5mF7dg/wV
	ZTJ9gKkkOrb5dsFB7osDoxCsEi1gzRkS5AJf+CukjTrug6yBMogAGv/qBMgRf2br
	/4xqSbq4e328xaESu3+1w5payV9ZC7qkmL97iZYIMzmS5dhOf83j7Tk0o44AdImr
	Ibpq8qPpAD22FsnPzIf5cAIr803POvvVBdfXaGl5IAiRjs+EnkOcWyzBM6CEdI63
	pVkkXU0kzRkKpVtqjC9nDmEPXyCWeXlyei5u/eM0nHcDg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bnd2g8sbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:02:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 02:02:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 02:02:50 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id B581E3F709C;
	Tue, 13 Jan 2026 02:02:48 -0800 (PST)
Date: Tue, 13 Jan 2026 15:32:47 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v3,04/13] ocetontx2-af: npc: cn20k: MKEX profile
 support
Message-ID: <aWYYR6eDcY-0ByTY@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-5-rkannoth@marvell.com>
 <20260110225932.3900827-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110225932.3900827-1-kuba@kernel.org>
X-Proofpoint-ORIG-GUID: AdkEtDa2pt5AAHuxpo56gdSxFkITA4V5
X-Authority-Analysis: v=2.4 cv=OvlCCi/t c=1 sm=1 tr=0 ts=6966184b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=qdG5cbYOcRVrSoTU22UA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: AdkEtDa2pt5AAHuxpo56gdSxFkITA4V5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4MyBTYWx0ZWRfX340RNGqAYL7I
 Bdfo7ic1L4LD6eQ5e5SKG1BRIDqmNMaiiRNVDEGfr1Zkua0QMM9utDDkmuzO3UwQB+i5tBTrrZn
 mtz0+O/K0wr5IYOfgRvLGIveSZOqUW+vH/0gKmXJp53f/aP7tBWaGx4E98zhGZ8IPQqVAWqW27u
 DodZyanp5VcNmwerntGst7MBOYosMTnBv9b00kPQIijJETokP28Q0dZeJwnOamkjxVwtJKH4R7f
 YtSvVqRVK52m9rGlSU8eXaAatRXZFLQZwYvCB9fLZCmTCvA9Gd1peQtlC882BRN3rvBGg/VNxfg
 i6pQ5pg4xh/mRB6hRZTg7v2mpGLrGuhtk7cHLfl/wZiU/rpkx0qj8o/Kqwbl++HEiIuYG395ZPo
 f1rKrXE3zLzTtTdZ/1r7EOvvmoBcdqOglCs45JPnT8MV/fXeygMKL8CIjUDvJFanvO0Z51wmN5W
 Fzc4CiJSs8tZ3SWPXLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

On 2026-01-11 at 04:29:32, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least pausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> ocetontx2-af: npc: cn20k: MKEX profile support
>
> This patch adds MKEX profile support for the cn20k silicon variant,
> introducing a new key extractor concept with up to 24 extractors per
> packet parsing profile.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > index 316e6cd1436a..88d7f65d246c 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
> [ ... ]
>
> > +void npc_cn20k_load_mkex_profile(struct rvu *rvu, int blkaddr,
> > +				 const char *mkex_profile)
> > +{
> > +	struct npc_mcam_kex_extr *mcam_kex_extr;
> > +	struct device *dev = &rvu->pdev->dev;
> > +	void __iomem *mkex_prfl_addr = NULL;
> > +	u64 prfl_sz;
> > +	int ret;
> > +
> > +	/* If user not selected mkex profile */
> > +	if (rvu->kpu_fwdata_sz ||
> > +	    !strncmp(mkex_profile, cn20k_def_pfl_name, MKEX_NAME_LEN))
> > +		goto program_mkex_extr;
> > +
> > +	/* Setting up the mapping for mkex profile image */
> > +	ret = npc_fwdb_prfl_img_map(rvu, &mkex_prfl_addr, &prfl_sz);
> > +	if (ret < 0)
> > +		goto program_mkex_extr;
> > +
> > +	mcam_kex_extr = (struct npc_mcam_kex_extr __force *)mkex_prfl_addr;
> > +
> > +	while (((s64)prfl_sz > 0) && (mcam_kex_extr->mkex_sign != MKEX_END_SIGN)) {
> > +		/* Compare with mkex mod_param name string */
> > +		if (mcam_kex_extr->mkex_sign == MKEX_CN20K_SIGN &&
> > +		    !strncmp(mcam_kex_extr->name, mkex_profile, MKEX_NAME_LEN)) {
> > +			rvu->kpu.mcam_kex_prfl.mkex_extr = mcam_kex_extr;
> > +			goto program_mkex_extr;
> > +		}
> > +
> > +		mcam_kex_extr++;
> > +		prfl_sz -= sizeof(struct npc_mcam_kex);
>                                  ^^^^^^^^^^^^^^^^^^^^^
>
> The loop iterates over struct npc_mcam_kex_extr entries (the pointer
> mcam_kex_extr is advanced by sizeof(struct npc_mcam_kex_extr) via
> mcam_kex_extr++), but the size decrement uses sizeof(struct npc_mcam_kex).
>
> These structures have different sizes:
> - struct npc_mcam_kex_extr contains intf_extr_lid[2][24] and
>   intf_extr_lt[2][24][16] arrays
> - struct npc_mcam_kex contains intf_lid_lt_ld[2][8][16][2] and
>   intf_ld_flags[2][2][16] arrays
>
> Should this be sizeof(struct npc_mcam_kex_extr) to match the pointer
> increment? Otherwise the loop termination condition will be incorrect
> and could read beyond the profile buffer boundaries.
ACK.
>
> > +	}
> > +	dev_warn(dev, "Failed to load requested profile: %s\n", mkex_profile);
>
> [ ... ]

