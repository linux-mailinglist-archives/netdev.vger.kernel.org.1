Return-Path: <netdev+bounces-258077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN6hBFgli2mYQQAAu9opvQ
	(envelope-from <netdev+bounces-258077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:32:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAB511AE08
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 269A630297A6
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0804117ADE0;
	Tue, 10 Feb 2026 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G0IXE74W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867B191F94;
	Tue, 10 Feb 2026 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726641; cv=none; b=EZX6QufWkv6+GWpp7JR3cnfR1HrFSi5H2hrhn2RwpoleCh6tNbi2qhe3kLO8Y2mR+KJR6u4uRPFCiJe5VijFxduKlfKSZ30VWtqHeExx4wuc6GmrNS+rkV0Ik7PX3a9DsE3hn5asJdpNOca3bYwa7eqHJO3k1fyUweeNB4pyM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726641; c=relaxed/simple;
	bh=LQL5jEUHIKC/3GAjIqIlLOjpt2gP6Bu5EgPo+EPy8o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7DTtH3RS0OCDe1/9ZT/ySyMFgPkyV0brZfcBbDAcy8na+Q2z8MOubksEA77IQ3lRsNj6ELPkutNOxQRJkvk7fqX7KkEzDyo6+LK7rJaJV5oOC4x+6Sly+oUt52PV5OklDmPcjrA9iniTnw9cTg2qPrNyHhZy265yW/tHmclA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G0IXE74W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jQMAkiZGrqwSgr5mZ517weGZSWnKuFxc8IpWTd0MF0M=; b=G0IXE74WnLyWWegVxKpGZ9+KWe
	5EyQBMB4xTnAyP8jXnvWO7G/S1j2pDUelSQrb4jhmR0b0tk+xHy9vKXWKzP7SpFOM2EYJN65QDqTS
	CEV/UsrU1wA4L0Go1kVbZR/i8WeuAb1PzYg+vwI9hZPrdfDux0Jzza/T0zhVp6BXttvR6cvorAvH5
	2iIPbkIzZUYIii9jb6FBQD+JZtKTIcz1Uu6d7BFKgxMxc5M1mFcOX3GaApNV+cWf5oX6iwB0txSKI
	RVTa24Vm7/YEuppdiupb8HaEyKl/KD7gN1e8JQ4uP4X5KoznLNk3USPLSMM13fMpFbruKO2FO7ZjF
	HhMONwBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39224)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vpmsz-000000002YE-3X4B;
	Tue, 10 Feb 2026 12:30:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vpmsw-000000002mM-2Z9r;
	Tue, 10 Feb 2026 12:30:30 +0000
Date: Tue, 10 Feb 2026 12:30:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH v2 0/2] net: stmmac: eic7700: fix EIC7700 eth1 RX
 sampling timing
Message-ID: <aYsk5pnzVswdl_tf@shell.armlinux.org.uk>
References: <20260209094628.886-1-lizhi2@eswincomputing.com>
 <64bf6b40-b947-4ffa-8d48-4d6341931327@lunn.ch>
 <aYnvwAK3gpxBs-EF@shell.armlinux.org.uk>
 <5dea8ce0.4435.19c471231f5.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dea8ce0.4435.19c471231f5.Coremail.lizhi2@eswincomputing.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258077-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFAB511AE08
X-Rspamd-Action: no action

Hi,

On Tue, Feb 10, 2026 at 06:21:40PM +0800, 李志 wrote:
> > -----原始邮件-----
> > 发件人: "Russell King (Oracle)" <linux@armlinux.org.uk>
> > 发送时间:2026-02-09 22:31:28 (星期一)
> > 收件人: lizhi2@eswincomputing.com, "Andrew Lunn" <andrew@lunn.ch>
> > 抄送: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
> > 主题: Re: [PATCH v2 0/2] net: stmmac: eic7700: fix EIC7700 eth1 RX sampling timing
> > 
> > On Mon, Feb 09, 2026 at 02:36:11PM +0100, Andrew Lunn wrote:
> > > On Mon, Feb 09, 2026 at 05:46:28PM +0800, lizhi2@eswincomputing.com wrote:
> > > > From: Zhi Li <lizhi2@eswincomputing.com>
> > > > 
> > > > v1 -> v2:
> > > 
> > > For version 3, please include a patch to the SoC .dtsi file adding the
> > > Ethernet nodes. We like to see users of code being added.
> > 
> > In addition to Andrew's comments, before posting another series, please
> > review https://docs.kernel.org/process/maintainer-netdev.html,
> > particularly sections 1.4 and 1.6.1.
> > 
> Thanks for the comments.
> 
> The v3 patch will target the net git tree.

While it may be a fix, given that:

> We will add the ethernet nodes and the corresponding clock node to
> eic7700.dtsi and eic7700-hifive-premier-p550.dts in v3 patch. 
> 
> Please note that the EIC7700 clock controller binding and driver are not
> yet merged upstream, so the clock nodes will not be functional until the
> clock driver is available. As a result, dtbs_check will currently report
> schema warnings/errors related to the clock nodes. This is a known and
> temporary limitation until the clock binding and driver are available
> upstream.

I don't see much point to putting it in the net tree - you're addressing
problems with a driver that is currently not in a usable state in
mainline, so there's no need to rush to have this change in mainline.
I think the net-next tree will do once it re-opens after v7.0-rc1 has
been released.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

