Return-Path: <netdev+bounces-302440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cRAYJu3WQWrVuwkAu9opvQ
	(envelope-from <netdev+bounces-302440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 04:22:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 316AE6D57DB
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 04:22:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=JGz3jHzc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302440-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302440-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F8053003D01
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 02:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D90245012;
	Mon, 29 Jun 2026 02:22:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C1175A73;
	Mon, 29 Jun 2026 02:22:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699753; cv=none; b=fT6bC8YSabCXfcryeeoolQ1Bz+O7QMIHy3y0ksQJExBNtPIPeAmv4ugpepL02DFyL4nxVGPwpNMVRnIcDniz9nAGD2vzKdqK2yCuInUVu3KlGwVD7qaWv3LBcSeOigxOb8ckMN7qLeVhVG+QzAV+rY7sggL1/A4ShJL9q8tnKj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699753; c=relaxed/simple;
	bh=hB8n72VjyYikQSv/ZroWA/b1rnLqq1WJzg0jWujA+mQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZvr548pzgifTN8lz3ukkpKeNEUrWoDb4dmbylx4d3zF5B+rXb18e19jsum5S9G22fjMZLfU6CA/Z0saqJebJetHOae1z+mxvAm+9Ih96MZr0Wc6j2OSPge4BhIjmw4gM3l0Gs0IR95m6f7vzb4yZDdEi9TCFu281oZFWiR/8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JGz3jHzc; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SM9tfQ394616;
	Sun, 28 Jun 2026 19:22:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=6KYNqxP9sCNG7g3Gt1KgjZ3qM
	i85Ms3ne1hlpHdAeq4=; b=JGz3jHzcfVsxiULomV+evDrcJZi2zLccWlVWCLPz+
	Fe1gp+vte/1YQNZ3xo+Z9Wy+TPH+d6CibwlOPD2n6Mh5Htgo5tb+Ffia+rs3YWeB
	2le+L9ZbPviAgmhFjs26tS1HS5GzlydKyS+QxNGJPDAMyg+RULwy45CXIwSzDFPt
	510ydDDJdfDJ+flqidj8cB1c4wQ6RWg64a4i12VFgU24lFtQce21k7SeLu0VRAwV
	xUY+lEZ1EP8oMfZ8d9mthXGTRgeSGoHe1DOblyTvFLui2gdGXYAct7U7DvME/+to
	1W9rmcSDCi8i+NlbofaYgG0C9pKJUoBWZ9RhlXjo2CL2w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f2bvh4183-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jun 2026 19:22:19 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 28 Jun 2026 19:22:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 28 Jun 2026 19:22:18 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 74B133F70A2;
	Sun, 28 Jun 2026 19:22:14 -0700 (PDT)
Date: Mon, 29 Jun 2026 07:52:13 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: David Ahern <dsahern@kernel.org>, <pablo@netfilter.org>
CC: <stephen@networkplumber.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH iproute2-next] devlink: support u32-array values in
 devlink param show/set
Message-ID: <akHW1ZiovKdwUq6s@rkannoth-OptiPlex-7090>
References: <20260615041042.549715-1-rkannoth@marvell.com>
 <e907ee3e-df70-4e32-a69f-29a9baaf1993@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e907ee3e-df70-4e32-a69f-29a9baaf1993@kernel.org>
X-Proofpoint-GUID: -eX8JH2T4y8r_lO_H1htSmoXinoX0VZE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAxOCBTYWx0ZWRfX71T2E0vU4pLZ
 ZZTOzaGLzlGzFXO88q2zjiRtEmanFXwBjcE3hyzx0OWkvmzgqEIkVQfGiyVdZyiTDiNtJBtwShM
 Ti4Mvbrpk6/42Wcpe0QbhvepH0Bwm9Y=
X-Authority-Analysis: v=2.4 cv=b+SCJNGx c=1 sm=1 tr=0 ts=6a41d6db cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=l_b__QYnox7BynmhaiIA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAxOCBTYWx0ZWRfX1SW9kg7dKplA
 XOMYIlIcBr9QoWUFIeVuUPm232AYdiY4UDneVx1ZLWJGfkcn4jLJ5kQ7u1IvtCxTOK+ezkKjIzr
 urXHM920cq93wKvA61MLnXTdeqm/y4hKfeZglTLim3oBczwFGzekl3ItSG0mC+5GWLCvGmS/LbG
 I3SsfxT4W9/tiXC54ocTVukKrhJqKB6dlDaGGGO/T+wZT2seYoZ/AylwPrHjQTsx1JWVtN7DwFT
 /VZKA1ZFn7c3YRvm+sQxO5p1cu6SCQjiXmEV3p9k6ZrZiwaEJ+vVYWMbspbDZiDAf3gRiF3/TVm
 ApTlBr88e1EOlfDIAyu7/j8SaOIYz0RYogdHodn3mZav2nvm64LKk0WIZdOvG1L8Zlud3bIV2eG
 isnCqT/mzUWHDFXMaVSVvVpA8hzMNteUPRTQeXn4it23R/Brvkst/djIx/XOXYv3nKTsXrd7Xn4
 vgGrXlDhui+d7kTs0xg==
X-Proofpoint-ORIG-GUID: -eX8JH2T4y8r_lO_H1htSmoXinoX0VZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302440-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,rkannoth-OptiPlex-7090:mid,marvell.com:dkim,marvell.com:from_mime];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:pablo@netfilter.org,m:stephen@networkplumber.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 316AE6D57DB

On 2026-06-28 at 22:49:48, David Ahern (dsahern@kernel.org) wrote:
> On 6/14/26 10:10 PM, Ratheesh Kannoth wrote:
> > @@ -3904,6 +3935,14 @@ static int cmd_dev_param_set(struct dl *dl)
> >  		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
> >  			return 0;
> >  		break;
> > +	case 129:
>
> no magic numbers. What does 129 represent? Is there a named macro for
> it? If not, why not if this is part of a UAPI?

The magic number 129 actually represents DEVLINK_PARAM_TYPE_U64_ARRAY from the kernel UAPI (include/uapi/linux/devlink.h).

The other cases in this switch block utilize MNL_TYPE_* constants from libmnl. I previously tried to
patch libmnl to add a matching MNL_TYPE_UARR = 129 macro, but the netfilter maintainers declined it,
noting that the enum is internal to libmnl (thread: https://lore.kernel.org/netfilter-devel/20260623043755.2435685-1-rkannoth@marvell.com/).

To resolve this without magic numbers, I can use the existing kernel macro directly in
the case statement with an explanatory comment, like so:

	/* DEVLINK_PARAM_TYPE_U64_ARRAY maps to 129 */
	case DEVLINK_PARAM_TYPE_U64_ARRAY:

Please let me know if this approach works for you, or if you prefer a different handling.

>

