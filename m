Return-Path: <netdev+bounces-248710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF53D0D8E2
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 16:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA9A3012261
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306F7348898;
	Sat, 10 Jan 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A0iYr7pr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66639348466;
	Sat, 10 Jan 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768060071; cv=none; b=mjlVWEa7yimbK+EysPHdYz9pOo5UTLm3bMNlTigiKwYZgulLFqZa5K+e6ufORYrH+FymgTBLmA2wNQ6UZSCksntMIJ/bUsZN0EvJ5hsBlWd0lDg2ctoG7KZpQwFrrvD8hfyukxYpSpcpYtjGgT6JiA7u/oWrS4MBMB+7eUvyOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768060071; c=relaxed/simple;
	bh=bSDYgxW83k3pPLWt9O3y4zO+XoLVRH3WyrTLNZpoO3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5pZGxFBAr8Fbqz72ELZwk0q/bwbLtKeq27tKkE8lZnRcswEWDdL7kz4JSjz+UGIWQBm07k8Zpl9dd5gMPSdZtvcZqmZKlMbTchnnvsLCyMvZiGaB4chAHkkJ+qQU+7MkHDzZyqZDck899LTqVYsmaiqvWZoAPKoGeFzQTmpnPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A0iYr7pr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nUHVAoAREYLF1TzcvPdgfaRGlq1lrNPziR3WwRPXhq4=; b=A0iYr7prmMiASSL1AOz8/XgGnp
	ovZha2vbY0r/bjN1U7KLi7QQ95Ls88EQ7rWpiXyuL4qd5r5L5sAxP6f18XrMYnZfdbPpXk+CATM+k
	7hyz++Y0TvK6+c6JaSPTlVYElOR7Ov9sUzc4dGjAtrF6+Mc8Ev73r4UOwQBLJdlJaVVlaOk9Yz91e
	0EFZdcfLSQC9+VcyGqk7RdkISvlDd9/jUERKYAM1CLejmpG+vYtP50qQE3HqPSiGJ4gsrh0MS5trN
	Pk1sI854m9fkkLK88dF6pD/ZIrKSKrM6I04zOdgPRGmSAfZgxygS1zea+BnrP0mGVUT8dwzXKd7Bt
	lbHi5hXQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53048)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vebBV-000000004qn-3BkF;
	Sat, 10 Jan 2026 15:47:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vebBR-000000004Mx-2YK5;
	Sat, 10 Jan 2026 15:47:21 +0000
Date: Sat, 10 Jan 2026 15:47:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	robh@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH RESEND net-next v2] net: stmmac: dwmac: Add a fixup for
 the Micrel KSZ9131 PHY
Message-ID: <aWJ0iV6-_4XqpeHD@shell.armlinux.org.uk>
References: <20260105100245.19317-1-eichest@gmail.com>
 <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>
 <aVuxv3Pox-y5Dzln@eichest-laptop>
 <a597b9d6-2b32-461f-ac90-2db5bb20cdb2@lunn.ch>
 <aVvp70S2Lr3o_jyB@eichest-laptop>
 <aVvwOYce1CFOLiBk@shell.armlinux.org.uk>
 <aVv7wD2JFikGkt3F@eichest-laptop>
 <aWC_ZDu0HipuVhQS@eichest-laptop>
 <8f70bd9d-747f-4ffa-b0f2-1020071b5adc@bootlin.com>
 <aWJXNSiDLHLFGV8F@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWJXNSiDLHLFGV8F@eichest-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 10, 2026 at 02:42:13PM +0100, Stefan Eichenberger wrote:
> Hi Maxime,
> 
> Not problem, thanks a lot for the feedback and the discussion. I will
> then proceed with the current approach and send a new version with an
> updated commit message.

We could add a flag to:

/* Generic phy_device::dev_flags */
#define PHY_F_NO_IRQ            0x80000000
#define PHY_F_RXC_ALWAYS_ON     0x40000000

indicating that the MAC requires the full preamble, which the PHY can
then test for and configure appropiately.

The question is, whether the requirement for the full preamble applies
to many MACs, and whether there are PHYs that default to producing
short preambles.

Looking at Marvell 88e151x, the only control it has is to pad odd
nibbles of preambles on copper (page 2, register 16, bit 6.)

AR8035 seems to make no mention of preamble for the MII interfaces, so
I guess it has no control over it.

I've not looked further than that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

