Return-Path: <netdev+bounces-255705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJGwHvspgGl73gIAu9opvQ
	(envelope-from <netdev+bounces-255705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 05:37:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6458C82E3
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 05:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25A6430075EB
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 04:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AEE2BE7BB;
	Mon,  2 Feb 2026 04:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YAY9zmia"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3022BD5A2;
	Mon,  2 Feb 2026 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007032; cv=none; b=MeJbF/8TNdgvdKGe6tsih+gZRylD00oHt7mqFQPys21C/Xt2RwLqRUMmLWCasNL65haaAuu6vpOAgDX492TsXWfRt8531MZ93fdSXBu9/9d7N1PnolOnS+Rr5Sm6VZ4/n6XPzXYX+xmiFJPCS9/HM95GVq6fLjUEWD1kDICofgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007032; c=relaxed/simple;
	bh=2M1FlUwZmy9rpiw3aEyqteFrrP++1HMD9u+KqGT+ipA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emcFMFuZvu+qWOrjvJMuruRE7ZFsKpLT7aGxMxSBpSrGGOxQwJQkK7BX/uMDgTL9/B8a8W3nEFNJu8yy9tyWulDmq9sMVX7iCl2HXKo4ZRgZQmJkxU3TS4NIBkA6t49qGSw3Q+qd9nXz0X+QRF25zW0fiyJ1frsUiRX2Q+CdiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YAY9zmia; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611NsDP93463246;
	Sun, 1 Feb 2026 20:11:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Mgp9VulRLNfMc5bfmTK+x0ifw
	Ky71HfYrFn4vr1yauc=; b=YAY9zmiaE2ZoCdnTNrvLohp4vlrVAWgnJfHbnhjb8
	qv34WQ3p1VGiVo7DtpgEID1de3ZqqPDoRBpqmzP/Yb54cJuvP69Sv81NQTTmK7ws
	YmlXGkBjZmh0i9JeLH1sdfKXvcghgTt7Cc3GM46YrmqUc1ENPP0fZT8TX+lIxt03
	Uond4BOuGlcAr3YeZ1Xf3MgjgXQN0xvZF6L1mykzieb94FEo7PSZzNPa9GLAWxeP
	Er1JfbmhTcIfAo0P8x1IkBqiopKZ1eMB9ceiPy6+50QA2U08wnGU+b6fWmnWcpQu
	Th5NwqcsGjjE+roCPH2j/i+1k53YMMQiJObQsJLgknVLg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c28mvrvgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 20:11:09 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 1 Feb 2026 20:11:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 1 Feb 2026 20:11:08 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 5E47A3F70E6;
	Sun,  1 Feb 2026 20:11:07 -0800 (PST)
Date: Mon, 2 Feb 2026 09:41:06 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v7,09/13] octeontx2-af: npc: cn20k: virtual index
 support
Message-ID: <aYAj2gIfrlNq2_zt@rkannoth-OptiPlex-7090>
References: <20260129083339.264386-10-rkannoth@marvell.com>
 <20260131033322.1013834-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260131033322.1013834-1-kuba@kernel.org>
X-Authority-Analysis: v=2.4 cv=MuhfKmae c=1 sm=1 tr=0 ts=698023dd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=7eULd4cwdJC3NnIBy84A:9 a=CjuIK1q_8ugA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: _Id3mGfy8m2JQyijmOMVQgvNX9wt6Jyc
X-Proofpoint-GUID: _Id3mGfy8m2JQyijmOMVQgvNX9wt6Jyc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDAzMyBTYWx0ZWRfX4xo81nCLnTTW
 lK+0kPOUrg4PjkqNy17im8AV0oEr6bzjfQ8xNfmGzEwrL/GEsHvEAwsLwVvoxl2PUxXEVWCXT86
 j0oV5d0gKE4WfawWoRKEXIo7ZEEvxROKh793ZPVtK7t70X6dbxUiUtpr/v0dgRoFCSCLKrERXN1
 OodRoM2rP7ZnGqpmCK/XXULKD4AF+A6Wb5bZzK6RsDUboHFs50GUQxO4ZqJCJ8Ig4OoyzbhqzPI
 32tTicAofyMQMWZs84UTHlcV1SWG7yVitjl5w9D2/w2vuc8HLK7wUBnNsGhigtAhZjytVTYnts/
 gdCjyPDaV5huMMOXEzMu8p5tw1ptMA5DujBMPnAsa0fuHpFOnvGm52Ugpl53wkPJK/ipLt+c482
 yrILSlkC1WjmeslmVapySdcTCaBcCeII0L3dc9Ni25FP5eRkC5z/IxGTBhjURA0MfBanjtaZhKp
 RQTPMXaN9gJbijUulGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_01,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E6458C82E3
X-Rspamd-Action: no action

On 2026-01-31 at 09:03:22, Jakub Kicinski (kuba@kernel.org) wrote:
>
> > +fail1:
> > +	if (xa_insert(&npc_priv.xa_idx2vidx_map, old_midx,
> > +		      xa_mk_value(vidx), GFP_KERNEL))
> > +		dev_err(rvu->dev,
> > +			"%s: Faled to roll back vidx2idx to old_midx=%u, vidx=%u\n",
> > +			__func__, old_midx, vidx);
> > +
> > +	return rc;
> > +}
>
> When we jump to fail1, it's because the xa_insert() into xa_vidx2idx_map
> failed (around line 352). At that point, xa_idx2vidx_map hasn't been touched
> yet - only xa_vidx2idx_map had the vidx erased. The rollback here tries to
> insert into xa_idx2vidx_map, but shouldn't this restore vidx -> old_midx
> in xa_vidx2idx_map instead? This appears to be operating on the wrong xarray
> and would leave the mapping inconsistent on error.
>
> This was also raised in lore review feedback:
> https://lore.kernel.org/all/20260129051307.376632-1-kuba@kernel.org/
Label fall1: is modifying vidx2idx_map in V7. Am i missing anything here ?

