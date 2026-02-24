Return-Path: <netdev+bounces-260348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INcTO01DnWkMOAQAu9opvQ
	(envelope-from <netdev+bounces-260348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:21:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5BD182609
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35AC43047BDB
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E82DCF74;
	Tue, 24 Feb 2026 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ixb/drv7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4929AB05;
	Tue, 24 Feb 2026 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914057; cv=none; b=rDI7UrrfjAwmqIhi4f51QRG6OqoqdFS2VImJ+VNSzfSccT9J2rxKa2rMzc6OI0vOqdJINK04FXjxYO+XCTHk6Zu90L+74q2AWA26HIM4b11ik2VPNDgVWYpi3qb/VjybfyJL4prbIa4elfrFifviU7qhDfoQytlfp2a17sPaDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914057; c=relaxed/simple;
	bh=A50jC4LfoMxSa9lpx4VQPVxgpchl+m7KZrlwyFd5rhs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neA+JbhneXQI0mRyRzX2cSi6sSw+jU0grphV3pqPueon+oN+/LY7veeIHjzRi1MD81qm1Ln6wFEiYucNFKGvFDLlM3/h2UyQVbWGjcS+6uu2Wtyn8JdLSyik1icRlAA+RZOQTbl+2fJfr18HKwBIg6c98iqEEcC3D2u/jLjjtt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ixb/drv7; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NHSmGa3895504;
	Mon, 23 Feb 2026 22:20:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=lsIWV0lAbt0Fe4quo+bjdEVqY
	HmKpu+swmVQaofqSEw=; b=Ixb/drv70BmwE1YPbUgBEGHmohNBMTe56Ly17kQTY
	umWTKEJyw64yq9+kvpkRxs52YAbWW2ytAseRXmwPBH4kspQFzEDE3NWp5Z0pvjAh
	E9lRIOlU1OWv221BzfrBhXLjq6eiNgJUcyusLHptZPusa1Q/kY9bCw4+WM9QAT8P
	LIQCBx9qt/vln5i1PlPHao+DI01JCaSCJ3DupUJo24BYrJVlyLVTNQI7C8/5q/2E
	Hd/ekgkPHjRYhqAib8bhRiNG9D/GZIx2y0iXdYBblrAzEiCIkfeAX4NX860rCBxn
	Y61uRxSZTEEzLoAhp/qR6zQqDrL9zkXut1bdmKqrl7m+A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cfaxp5avh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 22:20:46 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Feb 2026 22:20:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 23 Feb 2026 22:20:44 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 8C8363F709A;
	Mon, 23 Feb 2026 22:20:42 -0800 (PST)
Date: Tue, 24 Feb 2026 11:50:41 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <edumazet@google.com>, <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sumang@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>
Subject: Re: [net-next,v8,09/13] octeontx2-af: npc: cn20k: virtual index
 support
Message-ID: <aZ1DOQOswkO6bgmP@rkannoth-OptiPlex-7090>
References: <20260202074607.2535569-10-rkannoth@marvell.com>
 <20260205022525.2271130-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260205022525.2271130-1-kuba@kernel.org>
X-Proofpoint-GUID: YFGQ8Z_2kim3fY0qVJX87yKDQnkSBWMu
X-Authority-Analysis: v=2.4 cv=IsQTsb/g c=1 sm=1 tr=0 ts=699d433e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=5OoKT6bNshcxhbm2wnAA:9 a=CjuIK1q_8ugA:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA1MyBTYWx0ZWRfX772Oq4RkySv6
 uiY6h51T5Ds1QyhLt3UmbT6u0ctbjEVDbHipfmBBu8jV+YQAir5oeUcKg+1gsAgOXYwbhssrWT2
 qbaqC78CuAQ918xY6SbODjc8sqfXWL1Bak5u0n/Hk2fHdqrLOpG6hOrjxFvSSf+ddbshqkPdWQj
 kkxLT66Y9aUrQapXlUTcQT95kbp6WlKQIyzqp1cbJYDhJMPxp/99xQGJRiifV0EjoDc9gzKfrrM
 ALHWAyqGtNJ6hYOXzfa/SAGF++a2vDNbbwYqLDY3a8dncIgawKz2RthpeP0hAjxROkG7KXoR09W
 h/V3pFOv9FM6JQWEsuBCdFPoWicipt2zv3J8h/Ulbq00XFp3DsnO9JsMv68TtgLkV1tilztNWf0
 6rNMHiyhMwXvaa4JFfvgCo/1GoQ0t6wWu3scurVlShBB6QDv6U1KQMqzi7geW1hDZGO/ZrqTPxh
 3/l6Bc+eVQGaZkFRcSQ==
X-Proofpoint-ORIG-GUID: YFGQ8Z_2kim3fY0qVJX87yKDQnkSBWMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260348-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6E5BD182609
X-Rspamd-Action: no action

On 2026-02-05 at 07:55:25, Jakub Kicinski (kuba@kernel.org) wrote:
> > +		dev_err(rvu->dev,
> > +			"%s: Failed to roll back vidx2idx vidx=%u\n",
> > +			__func__, vidx);
>
> At fail2, xa_erase() returns the erased entry on success (non-NULL) and NULL
> on failure. The error message is printed when xa_erase() succeeds, which
> appears inverted from the intended behavior.
>
> Should the condition check for NULL to detect failure instead?
>
> > +
> > +fail1:
> > +	if (xa_insert(&npc_priv.xa_vidx2idx_map, vidx,
> > +		      xa_mk_value(old_midx), GFP_KERNEL))
> > +		dev_err(rvu->dev,
> > +			"%s: Faled to roll back vidx2idx to old_midx=%u, vidx=%u\n",
> > +			__func__, old_midx, vidx);
>
> This isn't a bug, but there's a typo: "Faled" should be "Failed".
>
> Also, at fail1, the rollback attempts to insert into xa_vidx2idx_map to
> restore old_midx. However, looking at the control flow, fail1 is reached when
> xa_insert() to xa_vidx2idx_map fails. At that point, xa_vidx2idx_map has
> already been erased, so the rollback target is correct.
>
> But fail2 rolls back using xa_erase() on xa_vidx2idx_map, which was just
> inserted successfully. The rollback at fail1 should restore xa_idx2vidx_map
> instead, since that's the only map modified when fail1 is reached via direct
> return.
>
> Could the error path rollback logic be reviewed?
This is getting flagged every time. i dont see any issue in the logic. Am i missing
any thing here.

