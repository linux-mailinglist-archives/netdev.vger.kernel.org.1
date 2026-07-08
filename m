Return-Path: <netdev+bounces-305976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x/DwG1GvTmqJSQIAu9opvQ
	(envelope-from <netdev+bounces-305976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:13:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA1D72A206
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:13:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=l17znRXq;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305976-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305976-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38F8A301A7C5
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC23E00BD;
	Wed,  8 Jul 2026 20:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D23AF656
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:12:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541581; cv=none; b=A4s39dyci+/YulYhuQtStsnD+zzpmcvAnVBbeChXNI6Tt53oEp4mMUjAJKPbqaU/Etbur1IQ3UbI9MrtiE68rSIZOWByJRpqrQAvJf31UCErnyTR7LVBw0utBKfAugk3VqQCgQv7Cf4Jw07GgiAVz7c3M+olWBktScYqNKH6+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541581; c=relaxed/simple;
	bh=8gR3mAJVr5wruz3+lrN1CWfP2dHht+Y18OTFdDiNBdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=RfiJkWWpxu9ayZEGlANzDGFgq0X0zCoars7jh16oa4RIrySm+woovXfdjoDxB4HoJ3oC9cciB9ukvKdKPKoDy3Mb/G7OjFWqAZfKjC+UHtxus1O8pYZQSY536fYEeQEKVh3gROfjNK4AEClT1fbMrgoRhSAV4YBDjKOVQpEiLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l17znRXq; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260708201251euoutp01dc6ae081b48589783c0a6ad6a92303a5~AaZv9yDYZ1331413314euoutp012
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:12:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260708201251euoutp01dc6ae081b48589783c0a6ad6a92303a5~AaZv9yDYZ1331413314euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783541571;
	bh=sWv5LKxiCTQpIMVM+IVYcM4I7ORaawMDktpdHx4zPLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l17znRXqJBIpPf6cjjGr1Q32ku3S781rc6bjt782uZXTBbEmU3c53fkGu8k+TsCC9
	 P0h7MIxa8mP4QLutbd8hUVPvLNwK0yT2/EGv74rIq74fB/xOOYYgflbJ8IHmvBF5wc
	 5Be2k21DK3b0BSfIzh/CqTNx+4hrbPsGswNll2Zs=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260708201249eucas1p1cabc72998ab7481e285fda2a90c938dd~AaZuwfJNL2208522085eucas1p1G;
	Wed,  8 Jul 2026 20:12:49 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260708201249eusmtip220a824c2b3b58cd1a50f3f593e7a9924~AaZuEZM9B2195521955eusmtip2B;
	Wed,  8 Jul 2026 20:12:49 +0000 (GMT)
Date: Wed, 8 Jul 2026 22:12:45 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net/stmmac: Check for STMMAC_DOWN flag in
 all XDP paths
Message-ID: <ak6vPffCx2OYqWYW@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260707174551.1264558-2-j.raczynski@samsung.com>
X-CMS-MailID: 20260708201249eucas1p1cabc72998ab7481e285fda2a90c938dd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad52_"
X-RootMTR: 20260707174556eucas1p141142a61e5669032194f9eedf6393895
X-EPHeader: CA
X-CMS-RootMailID: 20260707174556eucas1p141142a61e5669032194f9eedf6393895
References: <20260707174551.1264558-1-j.raczynski@samsung.com>
	<CGME20260707174556eucas1p141142a61e5669032194f9eedf6393895@eucas1p1.samsung.com>
	<20260707174551.1264558-2-j.raczynski@samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305976-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[samsung.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,samsung.com:from_mime,samsung.com:email,samsung.com:dkim,AMDC4622.eu.corp.samsungelectronics.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAA1D72A206

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad52_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jul 07, 2026 at 07:45:50PM +0200, Jakub Raczynski wrote:
> Currently STMMAC_DOWN flag is only set/cleared by stmmac_reset_subtask(),
> to notify driver to stop processing of TX/RX frames. One of these processing
> paths is for XDP, but it is only ever checked in stmmac_xdp_xmit(), which
> leaves all other XDP paths vulnerable to processing data while interface is
> restarting.
> 
> Make verification of STMMAC_DOWN flag consistent by applying check to
> all XDP paths.
> 
> Fixes: 8b278a5b69a22 ("net: stmmac: Add support for XDP_REDIRECT action")
> Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
> Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---

Sashiko AI gave review that has valid points, patch needs changes.
Please drop it

--
pw-bot: cr

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad52_
Content-Type: text/plain; charset="utf-8"


------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad52_--

