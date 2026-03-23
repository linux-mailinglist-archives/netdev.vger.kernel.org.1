Return-Path: <netdev+bounces-270448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O1lFxAOwWngQAQAu9opvQ
	(envelope-from <netdev+bounces-270448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:55:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD32EF72F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6A59302F431
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587AF3876C4;
	Mon, 23 Mar 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cxjo/Yn0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61202F6918
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259642; cv=none; b=tO4g0cFEBWSebjtmK66z/T/fdZ8rQSl0Xrnjib4nOdziCnJtIw74bb5aoEQ7NU/98QHH2/O0QU+MaQQizv4pNBMCeCk4WKRAqfFOLimkPvkIwiD+Y4zRmejq4+cuS1a0YBMIJ9+2dDDXd3GlZkszbj/vLhmsfAO45gCJPtYXR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259642; c=relaxed/simple;
	bh=3HsKF4yCiA2gxjgM2E7yixnedzbJaMrRcQsR5RsO0j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9j66z4TgVaM/+0vIkIRqXE59KH5ZVvmLj62mE/Ct7prkEuBIQBZIDH5/vcRS0xUq+tMHRCYxoyXPYMy7prTVfauNvU8ScfXcQ0jZCLvqBSthlL2HyIrlzMDphk1l6JByhyIrmXs+87Kh1Ny0+Min1wxrRr0G83/1xehdFEChxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Cxjo/Yn0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c1JtUgAJo9zz29RauK3FUJzPu0iLBjOxgL8d3JFQYgo=; b=Cxjo/Yn0PNrXJyYp78jYI1Lr3m
	ju8Kh2IvRY5ar5bE5Pw+4HTNk0GKuL4aEgKkhhVFh2kN/jnHBjSX4/N0WIIugMxhZnKVB4lInlcMG
	HtAA+hyqdOCA2kruIi0C35/bz3L//QZtb2JepV0Rai8uJZdTNMfgjdxXFh2Dg9IZw1sw91RnaP8Io
	fgQpwDXpxqpd/ThjJY80fbLgeHm29H4xXzRlziw37OvjpNrM1HCzCUap2NNVuTxrrNHILg8Fc1mnr
	DXWbtjrtjP1t+jNFZQAC38vH6rYaktnzIfwCcGtI77IgYt7JlonIIYcwy3LWm5V0BKnsFUrIpo3wL
	c3Z0XMKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54524)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4byv-000000000Fk-2JZx;
	Mon, 23 Mar 2026 09:53:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4byt-000000003w1-0vsp;
	Mon, 23 Mar 2026 09:53:55 +0000
Date: Mon, 23 Mar 2026 09:53:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: netdev@vger.kernel.org, imx@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
	Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] net: stmmac: imx: Disable EEE
Message-ID: <acENs-IoUZwz-Wdl@shell.armlinux.org.uk>
References: <20260323093933.1785583-1-laurent.pinchart@ideasonboard.com>
 <20260323093933.1785583-3-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323093933.1785583-3-laurent.pinchart@ideasonboard.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270448-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lunn.ch,davemloft.net,google.com,gmail.com,toradex.com,nxp.com,kernel.org,ideasonboard.com,pengutronix.de,redhat.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.930];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,armlinux.org.uk:email,armlinux.org.uk:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ideasonboard.com:email]
X-Rspamd-Queue-Id: D4AD32EF72F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:39:33AM +0200, Laurent Pinchart wrote:
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

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

