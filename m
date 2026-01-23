Return-Path: <netdev+bounces-252871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAiQGvmWc2lgxQAAu9opvQ
	(envelope-from <netdev+bounces-252871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:42:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C132877E7B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9444309D605
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A993B2DC763;
	Fri, 23 Jan 2026 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gNo/HBbT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2B2F9C32;
	Fri, 23 Jan 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182781; cv=none; b=ePFyagtoM58gsSw6qTlv09t0lZVephNf6Qw96WftfXKwCvKm5afIAltqRROwHnmbm5BymU9lUyaDzuUePSvMHQ/ylo0MT5bFSbpSMijmmhF0VGOqNq3+MQ9aUfyi2U4L5Ux/RYhwLs+0vf5DZN+/FlF5eYK52b1P999FMLGWaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182781; c=relaxed/simple;
	bh=p+glKWECymdVUz2WmPx5TXkicq+Z2OkxSvs3k3xWfNQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF9oBpVgLaOcX+5fWIY4s6vLNfOVSgVJtvbvDhGQYPjTE4NLNB/H8lG0t+CdH7Hj44CWdxHP8KNNJd8BmjDa1Pd7Frjv3aHcZlMVyWr37RaJzgQ1UZBg+AjDMMIrVNg0GdQu0D7nr5v7EfWtmik2uMd5KqOiBu0Pw9XHKVFxbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gNo/HBbT; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MNRxes2725587;
	Fri, 23 Jan 2026 07:39:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=8m68JymYCfsOXGcb+YWiY+I2t
	4KCStHyQUKPKm1eBKE=; b=gNo/HBbTiBV03FiqVUx0Klda/OXq2moQOCPYBDIqe
	0gSr5IgJmdNiygvZ2IYTt1XIrvgLfZWjUj+jsJtTYHR1V757G9IChTuLur3C2mhw
	hUG6P1f6raSKO5bQ7erzPaiVS6v/kBhTQf1C/VlY67PyUsfmGQVxgBjcZk7b+bFh
	oOVCYfpruP1pllD1zyluuBJeIy4haG2yLWkyxyXFDbBoXMg20lgWNj/yV+OJhWsF
	04VokCn0ZKwVIArNMkvFHJS4V1Go5+DVjCT4QcYddKsMVG/tWC3GLE7yFaskK45l
	qtIEUv+pcNcnIx0SLBEPWla8wGcstSA3EzCJksvZOSCPA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4buwkdsnru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 07:39:28 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 Jan 2026 07:39:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 23 Jan 2026 07:39:27 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 9B5385C68E1;
	Fri, 23 Jan 2026 07:39:24 -0800 (PST)
Date: Fri, 23 Jan 2026 21:09:23 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v4 07/13] octeontx2-af: npc: cn20k: Prepare for
 new SoC
Message-ID: <aXOWK2IkFikFQxnb@rkannoth-OptiPlex-7090>
References: <20260113101658.4144610-1-rkannoth@marvell.com>
 <20260113101658.4144610-8-rkannoth@marvell.com>
 <aXHhekHJSpTZzHXy@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXHhekHJSpTZzHXy@horms.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDExOSBTYWx0ZWRfX9DdbrUFgSTFA
 hcrCeW5NBGiAsnLFStt9AQKoWah2SBoFPasuA3iOsH1tKFB0ZHwQNRy6mZRRMd+ZAMmPoZx7iqN
 JnfjKTScAqLp3IaKtx0v1jJXCPXDt4TLlW2KjxQEqT5COoc7BbX6hgJPPfLR0XwE7MMQo+pbqSS
 WRBaN46K0u/w5lQJQTV0w8rvTy/4G7a8ZLvMFauAvbj2LdquhoFZveM03KXxiTIr2hRRZ3TnrjB
 f9ExJ6DA81POuDCeN83PGm0jaSeJO+tuhjBduBZYhlG3+xWaLprXoK57fpnlPbsUrG5GQvgluZ9
 LJ7MFwt2sJgIj6ZcNAQZICS2s7eWwhn0RdbJbYlMEeL7/VL7Ups8hJ7Iq5pO1RVLAvHaPQrZlqC
 ZDaHDuQLcX4szWK87Y1tdhel7Vm1/8OJMu+5miVT0/sPvU1l4tq7PscHb4TlGDsWk8X5PFDxakH
 4wvZnh1GBov6Z6QOExg==
X-Proofpoint-GUID: tD6rkHlhX1cU2Rt9xihWqoqXdHSquCSS
X-Proofpoint-ORIG-GUID: tD6rkHlhX1cU2Rt9xihWqoqXdHSquCSS
X-Authority-Analysis: v=2.4 cv=bJob4f+Z c=1 sm=1 tr=0 ts=69739630 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pbxx0CnoOJxI3RIAxZAA:9 a=CjuIK1q_8ugA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-252871-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C132877E7B
X-Rspamd-Action: no action

On 2026-01-22 at 14:06:10, Simon Horman (horms@kernel.org) wrote:
> On Tue, Jan 13, 2026 at 03:46:52PM +0530, Ratheesh Kannoth wrote:
> > @@ -945,12 +945,12 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
> >  			kw2 = shift ? val_lo >> (64 - shift) : 0;
> >  			kw2 |= (val_hi << shift);
> >  			kw2 &= field->kw_mask[i + 1];
> > -			dummy.kw[i + 1] = kw2;
> > +			kw[i + 1] = kw2;
>
> Hi Ratheesh,
>
> It's not a problem introduced by this patch.
> But it seems that this could overrun kw if i is max_kw - 1.
> Likewise elsewhere in this loop.
>
> Flagged by Smatch.
ACK.

>
> >  			/* update entry mask */
> >  			kw2 = shift ? mask_lo >> (64 - shift) : 0;
> >  			kw2 |= (mask_hi << shift);
> >  			kw2 &= field->kw_mask[i + 1];
> > -			dummy.kw_mask[i + 1] = kw2;
> > +			kw_mask[i + 1] = kw2;
> >  			break;
> >  		}
> >  		/* place remaining bits of key value in kw[x + 1], kw[x + 2] */
> > @@ -961,34 +961,40 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
> >  			kw2 &= field->kw_mask[i + 1];
> >  			kw3 = shift ? val_hi >> (64 - shift) : 0;
> >  			kw3 &= field->kw_mask[i + 2];
> > -			dummy.kw[i + 1] = kw2;
> > -			dummy.kw[i + 2] = kw3;
> > +			kw[i + 1] = kw2;
> > +			kw[i + 2] = kw3;
> >  			/* update entry mask */
> >  			kw2 = shift ? mask_lo >> (64 - shift) : 0;
> >  			kw2 |= (mask_hi << shift);
> >  			kw2 &= field->kw_mask[i + 1];
> >  			kw3 = shift ? mask_hi >> (64 - shift) : 0;
> >  			kw3 &= field->kw_mask[i + 2];
> > -			dummy.kw_mask[i + 1] = kw2;
> > -			dummy.kw_mask[i + 2] = kw3;
> > +			kw_mask[i + 1] = kw2;
> > +			kw_mask[i + 2] = kw3;
> >  			break;
> >  		}
> >  	}
>
> ...

