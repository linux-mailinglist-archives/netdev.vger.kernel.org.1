Return-Path: <netdev+bounces-303919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yZyJNWXSRWoTFwsAu9opvQ
	(envelope-from <netdev+bounces-303919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:52:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD26F31E7
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:52:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=hq3iHlAU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303919-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303919-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD1683022697
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 02:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB12E8E09;
	Thu,  2 Jul 2026 02:52:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F091A6835;
	Thu,  2 Jul 2026 02:52:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960738; cv=none; b=dh+exMnCEDZrnvQruRH4qJ54oSGcwj5UxaV/LusxCr9ECT88/c7l8EYx4qAPL67dgFWuZSfjOOuf0Kwtr/kFtw010y/Pc8Oe4uKBTfu0ermANkP+98WFaNqnRotHsWz2Sc+dxkgHFXzaVnc4GZrt8pRyh/PZu3QARpvqDS8WJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960738; c=relaxed/simple;
	bh=rtdDKsCtnntX6zqkSrHyzx8ijMDggLL0sRKioK6YNlI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHfie0nBW91JEDRYHCJsRqgXz4wADtPY1Pan6VkBqgdJXuB4Fac+xcLKsQKMSCONwQujoZUa/BHo9reX9ez11H1I7v1JiTxXfRtUQPM3PGiAN9LkTJMYpA+uJ/iAZPbb3wgw2lY3/JfLNcKpK0wIVNYVjcebuL1M4HCqhsk8MtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hq3iHlAU; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621MgG5601485;
	Wed, 1 Jul 2026 19:51:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Qjv2uhUJHNIFzj5cmnm3jFbAL
	IHwHrbAZqLrId8cNIo=; b=hq3iHlAUo4nIRs+o8BuKRzknk+fYI4MrvGq70jiOK
	3+brakM99OlSXaCZnv+IW9NXi8GPF75GS1mHvP+hYExPViLtRksG05zIRocpwmSQ
	yFz28Lbi/TKFVwmDmdlp50sW3TRq6o4gvcaImSXxYuyehMcpF/6sH5/lk87BwqnQ
	zfI4sB0IBTD9aF08IkyuE0P7WLesmWVkF4E+tb5vPpbQDVsd61DH2Z/bUbilKFuY
	mzwUAugf3h+mTYTJotStaLGtYycoAftB18G1AxSnL5AUd7fz0VQ/C7p2mYCtOAx6
	ve1Fl+n+eWGTDSHed5efJxUPKdfX4df82vDsqfR/DVwkA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f50g3kga3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 19:51:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 19:51:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 19:51:55 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id B90C23F7091;
	Wed,  1 Jul 2026 19:51:52 -0700 (PDT)
Date: Thu, 2 Jul 2026 08:21:51 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
        <jiri@resnulli.us>
Subject: Re: [PATCH iproute2-next v3 2/2] devlink: support u64-array values
 in devlink param show/set
Message-ID: <akXSRyqVN9jja5nc@rkannoth-OptiPlex-7090>
References: <20260701031359.839221-1-rkannoth@marvell.com>
 <20260701031359.839221-3-rkannoth@marvell.com>
 <6c59d8f0-9a70-46d1-bf70-1e69c1869fb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6c59d8f0-9a70-46d1-bf70-1e69c1869fb5@kernel.org>
X-Authority-Analysis: v=2.4 cv=Gf4nWwXL c=1 sm=1 tr=0 ts=6a45d24c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=XH6R7allbje8br_4yIEA:9 a=CjuIK1q_8ugA:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX2cZt97esrflU
 36YKFrK52ntB2krMa0zBelQEDwWrV1yjVKb2/nNZKsRwr3cezE5wfXK9xP4lYlqWY0R9ZClM0Do
 xIWQaKp5Ooxmt48FWw96qm/ab0kbVMNgya13KUwVQFDzE+ahNZRa754qgd/ssVEzezjFpzCW9li
 mzy/mziTqYc/76DdnXBI8QydXV49d2dfyFByK/k0cEyoBBZ9hq+c6VJnwdbczPMozT9aMmElWIn
 R2+bW4QCO1ds7jUXvdUkF/Jitgh7dLFuFWApOkSDeIU81V7hRANDdfjRoepytC5a20Fx1RU1QQL
 PB51i7ZHixv5LNcooz4OR/199DMUpVmyrdGH2xCb1B5Xjm3djAQKAGX/H5TQ8vbT0AhQj56l/BP
 0W77XJtdWhxq0n+PX2MBd9jCc+WFHn+Gqeujwr2HvQc6Qe+OJY3uxEK2NGwzHnayZ1xvoN1iW1F
 OMufcOv1zplpjYvqiQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX9iy46jruWhGF
 vwR7phASfaBxkMx7gDt+kXwaitwI0HWFXq5Zx6DHpdFpsy6/lVV294SWs9TuK6ErMXJTypj9xPO
 mX/bQMyUkDqnlIYLX3di/VAGJFO0w+E=
X-Proofpoint-GUID: jP5Lhglc6dyNRJ1y3zpg9oDw-aGyYTyA
X-Proofpoint-ORIG-GUID: jP5Lhglc6dyNRJ1y3zpg9oDw-aGyYTyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303919-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:from_mime,vger.kernel.org:from_smtp,rkannoth-OptiPlex-7090:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:stephen@networkplumber.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37CD26F31E7

On 2026-07-02 at 05:23:33, David Ahern (dsahern@kernel.org) wrote:
> On 6/30/26 9:13 PM, Ratheesh Kannoth wrote:
> > Add support for DEVLINK_VAR_ATTR_TYPE_U64_ARRAY parameters that carry
> > multiple DEVLINK_ATTR_PARAM_VALUE_DATA attributes. Parse and display
> > u64 array values in param show, and accept space- or comma-separated
> > u64 values in devlink and port param set commands.
> >
> >   - Show search order
> >
> >   devlink dev param show pci/0002:01:00.0 name npc_srch_order
> >   pci/0002:01:00.0:
> >     name npc_srch_order type driver-specific
> >       values:
> >         cmode runtime value  value  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
>
> "value value"? Is that correct or a typo in the commit message?
it is a typo.
>
> You are dumping it as a string which for json is wrong -- it should be
> an array.
ACK.

