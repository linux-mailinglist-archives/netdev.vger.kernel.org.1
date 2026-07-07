Return-Path: <netdev+bounces-305596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OZXNHopzTWoc0QEAu9opvQ
	(envelope-from <netdev+bounces-305596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 23:45:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C76DC71FD51
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 23:45:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=J5Ql4lP1;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305596-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305596-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98AA0300D31E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 21:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAC047F2F0;
	Tue,  7 Jul 2026 21:45:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741047F2FB
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 21:45:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460743; cv=none; b=n3XjQtAEH/q+nTiWP3mIU+glgBkcqVfr91nNmO0fN8owbYRRG8kIYQf3ZL4c//muEwS3yf8AalF4QJMyavv/oKcixpWyqcN75q3HB2srAW7wloJ358AgeMzKltTgVPQkSkRnNgSQJCGXYdns8GsgEJwTkTOeyLJymopjsbJhzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460743; c=relaxed/simple;
	bh=uxlarWoZJRMoaFl5LzOGETwdh8dbdjkRxQ56mGu427k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=fOH+ClRGQcHo4iQ8gjPwSxuKt3QcgY+nsMlOO9NO5TZyO5oW1+EpW22lCPiNBOSdphv5Wy5Vx/luS5g9tdslwMq6PCr5W7ikssGueUy0IUFY626xmzMAa/4PIhZRBU4wyRKZnwSsm/4wVoOBbxZxPjh8MBsplgQpelCEcH1/LEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J5Ql4lP1; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707214540euoutp013a73bd6e533971feef0140281426ec80~AIBgXrGhz0751007510euoutp01C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 21:45:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707214540euoutp013a73bd6e533971feef0140281426ec80~AIBgXrGhz0751007510euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783460740;
	bh=64yZTokUOKWEi1l5XEMnLoTKVKqtdorCaDPLUUg5R/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J5Ql4lP1oiFXtQYiTzFXBmfxUjrzpzyZIpRJNeQHBONwrncCno0MOBr6cc0EmYxlu
	 qF5E54SFmmGhCpalWIiWVKmoAGz/OtSGDc+SJJDY3j4GJwLNwxWljxwjafpp1QFsxE
	 4Fs1fvxkC4wf13bezU9LBhFtgTzqgDUb5ayosdMk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260707214538eucas1p2b46a6831dbed600dab30756a0078711f~AIBeoMkm10868008680eucas1p29;
	Tue,  7 Jul 2026 21:45:38 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260707214537eusmtip272eee7641a70a5f1694e39ef6326faf4~AIBd7L2FY0322003220eusmtip2Y;
	Tue,  7 Jul 2026 21:45:37 +0000 (GMT)
Date: Tue, 7 Jul 2026 23:45:34 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Stefan Agner <stefan@agner.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Ovidiu Panait
	<ovidiu.panait.rb@renesas.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net v2] net: stmmac: resume PHY before hardware setup
 when opening the interface
Message-ID: <ak1zfkNN4akdKrRQ@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ak1rseUKTWFKzBib@AMDC4622.eu.corp.samsungelectronics.net>
X-CMS-MailID: 20260707214538eucas1p2b46a6831dbed600dab30756a0078711f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----086pkQbFtnoS7HLFmBecfPu9Cf9WQCmSNse4hrMKP7AYRkCa=_12ee25_"
X-RootMTR: 20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1
X-EPHeader: CA
X-CMS-RootMailID: 20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1
References: <message-id-of-your-v1-mail>
	<20260707195425.405989-1-stefan@agner.ch>
	<CGME20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1@eucas1p2.samsung.com>
	<ak1rseUKTWFKzBib@AMDC4622.eu.corp.samsungelectronics.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305596-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stefan@agner.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:ovidiu.panait.rb@renesas.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:regressions@lists.linux.dev,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,armlinux.org.uk,bootlin.com,renesas.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,samsung.com:from_mime,samsung.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C76DC71FD51

------086pkQbFtnoS7HLFmBecfPu9Cf9WQCmSNse4hrMKP7AYRkCa=_12ee25_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jul 07, 2026 at 11:13:46PM +0200, Jakub Raczynski wrote:
> - This change is actually broken - in previous patch rtnl_lock() was asserted
>   by dev_ioctl(), but in this version it is not asserted anywhere and will
>   trigger WARN_ONCE().

Ok, as I looked again, I am wrong again, ndo_open() does hold rtnl_lock
already. So from this point it is good. Relocking would create deadlock,
so I take that part of comment back.

BR
Jakub Raczynski

------086pkQbFtnoS7HLFmBecfPu9Cf9WQCmSNse4hrMKP7AYRkCa=_12ee25_
Content-Type: text/plain; charset="utf-8"


------086pkQbFtnoS7HLFmBecfPu9Cf9WQCmSNse4hrMKP7AYRkCa=_12ee25_--

