Return-Path: <netdev+bounces-258075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MNJLTwki2lyQQAAu9opvQ
	(envelope-from <netdev+bounces-258075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:27:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC511AC9F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2005304BCD3
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65258328B58;
	Tue, 10 Feb 2026 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wR0EDoHK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6C329368
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726390; cv=none; b=H92G0x50kWKHZO/pTuI01mEobE5+sROYit0EDbNuhqOlcl9ig1RzPk97WhgLh2+DQ9Th1UZbnzPOuNTvblu9VPj5l9ZUx4V0Ja363ss4hQOP7pGoDrYbF2GJYTsyUdHpEIreXFTE6dhSm+gynzPbYWreMDuu/IoTrhLdywGigSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726390; c=relaxed/simple;
	bh=+qM7MdOe2Y5+jA2loXINHPjzHRtXdwX5qkJFdvu6Zxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbUY8+7hA1uUnIYMPyLKQeD3XAmPFyOjDe1ZlXotNA8VdWcJKmwV0P/3yRgjqtaYdiialv8aqeKSRYN8y7wS+HtCBKI9GjR80bYTHpTwcHpINyV16FlSxthjIuBX5YstKnMYPriLjAtzDJQqmaIrApy9i1Ri6vd9KhmJKRRkP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wR0EDoHK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uCvUw7/lCEGBlYKLIRMIa5KgRRKn+Acso8mw+XapQ0g=; b=wR0EDoHK8mRIH8uMaABT5/zC3s
	HO8R1f7x+9M/R36KD14yKssCKQQtSEP1wKrrajvtnRxorwaUWTbWf5/mk4qRZW0SoCcz3dZqNa7sM
	LGkvMLebYcdEDRiCSlnomHQvHqu3jbBPMNua/6kZOBa24d9kMwL8oeT3NZVdVYkZd6sLoSu4ysUhp
	vOT1sZL8XH6rQMBiji06An2fs5pTRhtCpSU+S3VDblGJrbECGY61XczTAhpV7i+FBf4WIVZloCG6C
	3xc+s1ehMzwFChtKgm5k91c1WegbnvuE72YAhjZBo+KuwrNQGfI7LpKGxYQb0mHkXDqBopZK2yN8U
	JBUBCU6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vpmoq-000000002XV-22Ce;
	Tue, 10 Feb 2026 12:26:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vpmom-000000002m2-25N6;
	Tue, 10 Feb 2026 12:26:12 +0000
Date: Tue, 10 Feb 2026 12:26:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: netdev@vger.kernel.org, imx@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@denx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Heiko Schocher <hs@denx.de>,
	Jakub Kicinski <kuba@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Martyn Welch <martyn.welch@collabora.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Richard Hu <richard.hu@technexion.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Wei Fang <wei.fang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] net: stmmac: imx: Disable EEE
Message-ID: <aYsj5IayQd3NRflL@shell.armlinux.org.uk>
References: <20260209202155.2388099-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209202155.2388099-1-laurent.pinchart@ideasonboard.com>
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
	TAGGED_FROM(0.00)[bounces-258075-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lunn.ch,nxp.com,davemloft.net,google.com,denx.de,gmail.com,toradex.com,kernel.org,ideasonboard.com,pengutronix.de,collabora.com,gnu.org,redhat.com,technexion.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[29];
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
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toradex.com:email]
X-Rspamd-Queue-Id: ECCC511AC9F
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 10:21:55PM +0200, Laurent Pinchart wrote:
> The i.MX8MP suffers from an interrupt storm related to the stmmac and
> EEE. A long and tedious analysis ([1]) concluded that the SoC wires the
> stmmac lpi_intr_o signal to an OR gate along with the main dwmac
> interrupts, which causes an interrupt storm for two reasons.
> 
> First, there's a race condition due to the interrupt deassertion being
> synchronous to the RX clock domain:
> 
> - When the PHY exits LPI mode, it restarts generating the RX clock
>   (clk_rx_i input signal to the GMAC).
> - The MAC detects exit from LPI, and asserts lpi_intr_o. This triggers
>   the ENET_EQOS interrupt.
> - Before the CPU has time to process the interrupt, the PHY enters LPI
>   mode again, and stops generating the RX clock.
> - The CPU processes the interrupt and reads the GMAC4_LPI_CTRL_STATUS
>   registers. This does not clear lpi_intr_o as there's no clk_rx_i.
> 
> An attempt was made to fixing the issue by not stopping RX_CLK in Rx LPI
> state ([2]). This alleviates the symptoms but doesn't fix the issue.
> Since lpi_intr_o takes four RX_CLK cycles to clear, an interrupt storm
> can still occur during that window. In 1000T mode this is harder to
> notice, but slower receive clocks cause hundreds to thousands of
> spurious interrupts.
> 
> Fix the issue by disabling EEE completely on i.MX8MP.
> 
> [1] https://lore.kernel.org/all/20251026122905.29028-1-laurent.pinchart@ideasonboard.com/
> [2] https://lore.kernel.org/all/20251123053518.8478-1-laurent.pinchart@ideasonboard.com/
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> This patch depends on https://lore.kernel.org/all/E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk/

... and a few other patches as well. There is also a conflicting change
in net-next:

commit dc6597fab3e3d291da9e0b4c6f7da01a5a863e80
Author: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Date:   Tue Jan 20 21:30:04 2026 +0100

    net: stmmac: dwmac-imx: keep preamble before sfd on i.MX8MP

> base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b

This is v6.19

> prerequisite-patch-id: 9229185bf29c206923075a0450e763664af050bb
> prerequisite-patch-id: e17c3f8a7cb2b18fc0c3c6250773a9680bdabdba
> prerequisite-patch-id: a3c3f8b08fd66ee3ccce632aad3f4a3c21c92718

I have no idea what these are. These don't exist in Linus', net, nor
net-next trees. I'm not sure what generates these, but they are useless
unless they also indicate the summary line for the commit in question,
so that one can have some clue what change they're referring to.

While this is a fix, I think you previously suggested that this isn't
a regression, which suggests it should be merged in net-next (currently
closed due to the merge window) rather than net.

Also, referring to another patch doesn't get it applied - netdev
workflow uses patchwork, and patches to be applied need to be there.
If patches depend on each other, they need to be submitted as a
series. So either I need to pick up your patch and send it along
with mine, or you need to pick up my patch and send it with yours.
We need to come to agreement on who is submitting it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

