Return-Path: <netdev+bounces-256340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAUOHEwZgmmZPAMAu9opvQ
	(envelope-from <netdev+bounces-256340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:50:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B12DB848
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BC8B3059F24
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E83AE707;
	Tue,  3 Feb 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jt0kIIiv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDB86341
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133419; cv=none; b=lm1r4+Qz/rn2lM/NGV7t+mn85RUviKVbUvK1xNHs5nRrFpxsEbaIdzCsC6tNqaBI1/X2stCjl8fdC/cwOMYGrAWn6RySqeL2uAcaLIb7xKQpXF3/zqlRD6CcxQpLi87bbvtTKDkNKj9tiNIkev6E4qTG6w3fuUkPmfFxS0T0sTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133419; c=relaxed/simple;
	bh=o3x6/g/1y67NEu99YmPMUek/Tb68no2EGtXXsL3PEPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTNeykP2QvqwwioVRRKyR8Vbsybftdf0EtiwA8PU0zh4hai2lR7p0vSvmmJZxXRfINQ81vH8imbe1Yzcu3wvmVN0ACH8emxwKgXbR/rhM3d20BlzaHJLypL211CxrXGHwEhkZmUgdplkt1C4BhJvG+kd8yWUJxzE+fvMgQ+OB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Jt0kIIiv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RzeM8oaESwR5f6Qc18NJENPAHewlAD17RZTiqrl1jUw=; b=Jt0kIIivMsAafQg+iXRknxBUz6
	F/yuYSd/CfJA/N0eRjBsL+4fi2Q3FsHCPR9M5rdXzRrQWKlPH7WnXlgXUnZ+b4s2MD5nHekUB2MCL
	ThA/6rkEuHK2KZyrXiR1bGbRYvoH8F+Oebt9U7lOWk9KSAjVk46UxW/ZQuv7wsyT8ttlaJj4xHac/
	NmW/h1b2jqJpPk1aEiB6Wq7N8sfvM6q6uH7JYE8wL++vKpFL9JkfmtzbAzrUz0ywT0dJ9TeABywca
	mJDKj6Oi3LUbfI1dsueqDjZK8SMsaRR6Ao9flVloipD9KuSGLQisEH6eWPU5dTZGh1qA4rE7OrvcP
	7nUacWuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42522)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vnIYn-000000005EC-41oW;
	Tue, 03 Feb 2026 15:43:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vnIYk-000000004UW-1y5v;
	Tue, 03 Feb 2026 15:43:22 +0000
Date: Tue, 3 Feb 2026 15:43:22 +0000
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
Message-ID: <aYIXmsIG_ZJO-cg4@shell.armlinux.org.uk>
References: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
 <f95f73b9-d024-4697-bca1-02fb8bc044af@gmail.com>
 <aYEj8VM5AfvcDHrl@shell.armlinux.org.uk>
 <ea2434e6-d1db-4ea2-90f4-0a77961b7918@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2434e6-d1db-4ea2-90f4-0a77961b7918@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-256340-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,renesas.com:email,armlinux.org.uk:url,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7B12DB848
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 05:42:07PM +0200, Ovidiu Panait wrote:
> 
> Hi Russell,
> 
> On 2/3/26 12:23 AM, Russell King (Oracle) wrote:
> > On Mon, Feb 02, 2026 at 08:54:52PM +0200, Ovidiu Panait wrote:
> >>
> >> Hi Russell,
> >>
> >> On 11/24/25 1:27 PM, Russell King (Oracle) wrote:
> >>> Some platforms have problems when EEE is enabled, and thus need a way
> >>> to disable stmmac EEE support. Add a flag before the other LPI related
> >>> flags which tells stmmac to avoid populating the phylink LPI
> >>> capabilities, which causes phylink to call phy_disable_eee() for any
> >>> PHY that is attached to the affected phylink instance.
> >>>
> >>> iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
> >>> along with the main dwmac interrupts. Since lpi_intr_o is synchronous
> >>> to the receive clock domain, and takes four clock cycles to clear, this
> >>> leads to interrupt storms as the interrupt remains asserted for some
> >>> time after the LPI control and status register is read.
> >>>
> >>> This problem becomes worse when the receive clock from the PHY stops
> >>> when the receive path enters LPI state - which means that lpi_intr_o
> >>> can not deassert until the clock restarts. Since the LPI state of the
> >>> receive path depends on the link partner, this is out of our control.
> >>> We could disable RX clock stop at the PHY, but that doesn't get around
> >>> the slow-to-deassert lpi_intr_o mentioned in the above paragraph.
> >>>
> >>> Previously, iMX8MP worked around this by disabling gigabit EEE, but
> >>> this is insufficient - the problem is also visible at 100M speeds,
> >>> where the receive clock is slower.
> >>>
> >>> There is extensive discussion and investigation in the thread linked
> >>> below, the result of which is summarised in this commit message.
> >>>
> >>
> >> We are seeing the same lpi_intr_o interrupt storm on the Renesas RZ/V2H
> >> EVK (dwmac-renesas-gbeth.c). On this platform, lpi_intr_o is routed as a
> >> separate, dedicated interrupt line to the CPU rather than being OR'd
> >> with the main DWMAC interrupt as on iMX8MP. This corresponds to the
> >> "eth_lpi" interrupt in the stmmac bindings:
> >> """
> >> - description: The interrupt that occurs when Rx exits the LPI state
> >> const: eth_lpi
> >> """
> >>
> >> Looking through the other glue drivers/device-trees, it looks to me that
> >> every platform that defines a separate "eth_lpi" irq might have the
> >> interrupt storm problem.
> > 
> > That is highly likely.
> > 
> >> To fix this issue on these platforms, rather than disabling EEE
> >> altogether, would it be possible to just not request the eth_lpi
> >> interrupt and let EEE continue to work? Perhaps a new flag could let
> >> each platform decide.
> > 
> > Yes, because lpi_intr_o serves no purpose from a software point of
> > view - see the commit message below for the details. I do like
> > removing code from stmmac :)
> > 
> >> If not, maybe this patch could be merged to add the flag that disables
> >> EEE and I will just send a patch to disable EEE on our platforms as well.
> > 
> > We still need the flag to disable EEE for platforms where lpi_intr_o is
> > logically OR'd with the other interrupts, so there's no way to ignore
> > its persistent assertion.
> > 
> > 8<===
> > From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> > Subject: [PATCH net-next] net: stmmac: remove support for lpi_intr_o
> > 
> > The dwmac databook for v3.74a states that lpi_intr_o is a sideband
> > signal which should be used to ungate the application clock, and this
> > signal is synchronous to the receive clock. The receive clock can run
> > at 2.5, 25 or 125MHz depending on the media speed, and can stop under
> > the control of the link partner. This means that the time it takes to
> > clear is dependent on the negotiated media speed, and thus can be 8,
> > 40, or 400ns after reading the LPI control and status register.
> > 
> > It has been observed with some aggressive link partners, this clock
> > can stop while lpi_intr_o is still asserted, meaning that the signal
> > remains asserted for an indefinite period that the local system has
> > no direct control over.
> > 
> > The LPI interrupts will still be signalled through the main interrupt
> > path in any case, and this path is not dependent on the receive clock.
> > 
> > This, since we do not gate the application clock, and the chances of
> > adding clock gating in the future are slim due to the clocks being
> > ill-defined, lpi_intr_o serves no useful purpose. Remove the code which
> > requests the interrupt, and all associated code.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks for fixing this. I did some testing on the Renesas RZ/V2H board
> with this patch and didn't see any issues:
> 
> Tested-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Would you say this is a regression or a new problem?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

