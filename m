Return-Path: <netdev+bounces-256035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKVPC5c+gWk8FAMAu9opvQ
	(envelope-from <netdev+bounces-256035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:17:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5AD2E01
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2F53300DDF9
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263D5125D0;
	Tue,  3 Feb 2026 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VHco1eed"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C6286A7
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077844; cv=none; b=CPNU9u17gslY10xFgCaceg/ETZXVFxx4aReVYnQ+mYvmJX5h11YQrVAxQtu9zxbQPm05y9q7NGzRQfKujbvZ7Ao7KhDSXntDDmvknS1loLmvAKhDC8mx5kUkkX1EK1tlHW9cKDSGymq0Zz6f51jyMr81QJq5S1LmDQW4gn1Ao8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077844; c=relaxed/simple;
	bh=Ng135SnaS703nDA7esgIsFfXee++TNvFidYovRMyJnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALFrnZDkWXPAu64XOKY31PMk41PP57EZTVgvc423ixoXv04B/WVVBO/YNUmu0aPSS44tkhRsNapuN8LLAK6eo99jpAqw9I1v3Rs0nKM8hq74j/abjR9B6V/UjMt1BEzCIZZ2jmkKgSZsDeuOLdz+Ac1buetsLRfnlwJUMJ43X8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VHco1eed; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cnbZIEEYc7qpXnHl4ZHTwHEJ9GmdouAAJMZTX/GpBdE=; b=VHco1eedf+GGw5ftuQkpadN50P
	7/H8FTN1MGUAxFL0qaQpqSUGBucDqIYDt2U6LLBoiqx7tvKS6VoTTBhrOYlT1RxPCi6HFdsETvIQp
	sXTZAAPd5royUP8fucUiITv0PgZWrzYozcBefdUuZQOxe2GyOcd6r+F67dWJJ3SFiTt1LB02rYw7V
	Pfll0qmBlvzg+6CwkRVObhvX8/S3fYitEX1qZyg0Dq3jn83YD/SjpS9v5OJyj6Us0yPmzm9hhgY8a
	pVqBbhlOEvLVREJxuvD4A86L1kSexJyTYxCFgGMK+cpZoLagFf11xaAlc550PdCWJ+aDfbmBgHihf
	j7NM+9ZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52622)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vn46R-000000004UO-08eh;
	Tue, 03 Feb 2026 00:17:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vn46M-000000003qY-46I1;
	Tue, 03 Feb 2026 00:17:07 +0000
Date: Tue, 3 Feb 2026 00:17:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	"David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Wei Fang <wei.fang@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH RFC net-next] net: stmmac: provide flag to disable EEE
Message-ID: <aYE-gvuZdv7ezm7X@shell.armlinux.org.uk>
References: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
 <f95f73b9-d024-4697-bca1-02fb8bc044af@gmail.com>
 <aYEj8VM5AfvcDHrl@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYEj8VM5AfvcDHrl@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256035-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,nxp.com,ideasonboard.com,davemloft.net,gmail.com,google.com,lists.linux.dev,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,pengutronix.de,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ED5AD2E01
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 10:23:45PM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 02, 2026 at 08:54:52PM +0200, Ovidiu Panait wrote:
> > If not, maybe this patch could be merged to add the flag that disables
> > EEE and I will just send a patch to disable EEE on our platforms as well.
> 
> We still need the flag to disable EEE for platforms where lpi_intr_o is
> logically OR'd with the other interrupts, so there's no way to ignore
> its persistent assertion.

I'll also state that we need both patches, but there's no point pushing
my original patch (to allow EEE to be disabled) unless Laurent is going
to also submit a patch to make use of the flag - the EEE disable and
Laurent's patch needs to be part of a series. We don't merge stuff that
adds facilities that have no users, because that's been proven time and
time again to be a recipe for accumulating cruft.

So, at the moment, "net: stmmac: provide flag to disable EEE" ain't
going anywhere until there's a patch that makes use of the new flag.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

