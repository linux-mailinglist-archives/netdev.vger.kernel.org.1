Return-Path: <netdev+bounces-254793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFkvDvNce2nXEAIAu9opvQ
	(envelope-from <netdev+bounces-254793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:13:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 987BFB04A9
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9932E302FAA4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74598388875;
	Thu, 29 Jan 2026 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="panKYiyF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6265388866;
	Thu, 29 Jan 2026 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692375; cv=none; b=ojE6HI8D85Z99JhgrS+LLIy0eG0Tl8I+2JbDNnw/VTcZp4L43+nZ3vctStt+auGKfrvEZ2TExWEadQ0sHFx262McjZ7wMxJulJSV2SfOfxoDbcDIhWFTO7Ux3hGQkQmDjzkaHgTe/ZXIc1kNkQw2Br0OWLMGEl6DedqUjQywMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692375; c=relaxed/simple;
	bh=1dOx9+jLhDVGcSqsXOiDo4uOTThVRzHqpIE7pWewHFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/XrVsxBW6jb9Jw/7W5tVLSP5eCLz2uUOH6CT67DQXXxs1soLaMlUkrHNXQDxXJpYJUX3TnwcpQKZIPQhlp3Z1Sm66W5V69JxkA4iJUWUpMhJ+u9mtecPORulvTNS9xDV2xAC0NpEgTLpL+mrtvqmVWG9fJO+Xz9SDt20G9DhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=panKYiyF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ohKyf4TmGx8r7L6ANC4iUvAA5KyUbb3nqfmngkQM1WU=; b=panKYiyFMhOJ17u10FQs2i8yyT
	bF6MELsnpH9hYtuWjZQhw4tswj2ZQmMrYueYotonVO6gLx5YB1bYPUuaZS7iwsSx2QFb7erRx1Ekb
	oP0a0TCTyG8DPPvV16sS/skrjv6cekXunsBvPsn0aL12qo3M63tC4oLUzr6L0LonDLpr/u5YgwNvt
	QEfLqxlDxK0+ywKESi3QBq63S9TRUXCkfBCyoowCY947bcf5+spGZjY2pDEwyNBq7fW6fvVUEIZcg
	owsq3payyQvn4rf3PXTdazxXlXYaqvqusnxX0nSEbwKtEDtYmQoerX5w8uBkWyNKMaP2G9+sKyanb
	bsyek4sQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46246)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlRpE-0000000005y-1Zxv;
	Thu, 29 Jan 2026 13:12:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlRpB-0000000080R-1D5t;
	Thu, 29 Jan 2026 13:12:41 +0000
Date: Thu, 29 Jan 2026 13:12:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into
 phy_init_hw
Message-ID: <aXtcydbhclLAxDWZ@shell.armlinux.org.uk>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
 <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
 <aXqJ_TtdBnkvEZ_i@shell.armlinux.org.uk>
 <20260129104123.zir4rtgeiu5qv3i7@pengutronix.de>
 <aXs8m8UodO4griTY@shell.armlinux.org.uk>
 <20260129111726.jjkcq46dpghuorco@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129111726.jjkcq46dpghuorco@pengutronix.de>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254793-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amarulasolutions.com,lunn.ch,nxp.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 987BFB04A9
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 12:17:26PM +0100, Marco Felsch wrote:
> IMHO this flag should be removed completely because it makes the
> phy-driver mac-driver dependent. Since the FEC is the only driver
> checking this flag.

From what I can see, the _only_ caller of phy_reset_after_clk_enable()
is the FEC driver. However, we seem to have DP83848C, DP83848C,
DP83620, TLK10X, LAN8710, LAN8720, LAN8740, and LAN8742 all needing
this flag. As also pointed out, other PHYs also require their XTAL
based clock to be running before reset is released.

This reconfirms my statements that this is *not* a PHY issue, but an
issue that afflicts FEC based systems because, on these systems, there
seems to be a tendency for hardware designers to omit the PHY's crystal
and source the PHY clock from the SoC.

My guess is that this doesn't happen anywhere else (since no workaround
is necessary.)

So, this backs up my stance that "this PHY requires a special reset
sequence" is incorrect.

Hence, I think PHY_RST_AFTER_CLK_EN + phy_reset_after_clk_enable()
should be entirely removed.

Another possible solution beyond those I've already stated, given that
this only afflicts the FEC driver, ould be for the FEC MDIO driver to
walk the child nodes, checking to see whether they require any clocks,
and ensuring that those are properly initialised before registering the
MDIO bus.

Since the MDIO bus layer can release the PHY reset just before probing
the driver, this seems to me to be the only way to guarantee that,
where boot firmware does not deal with this, the PHY manufacturers
specification for the initial release of reset can be met while keeping
this FEC specific behaviour out of the core MDIO/phylib layers.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

