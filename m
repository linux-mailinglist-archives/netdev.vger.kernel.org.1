Return-Path: <netdev+bounces-182661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1567CA898E8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C73174058
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5382918D0;
	Tue, 15 Apr 2025 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fuWdPx6G"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120528B4EF
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710899; cv=none; b=b2QUFFp+Swb0d+Jibh9bfpDWiRoM3NY0AI/O9JLA2Uk2GGpWOogGqAkazpFVsLlqEVlrIChkLeElbHKrH/nT9Gwl8uqHKZbH4SNcc6nia652/k0qC5M/+QOCAOcj9aKLNp9jrsR0gPIWK82nuhCdbaQxVEPtvCNm203YAxchBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710899; c=relaxed/simple;
	bh=PWfkR1IMEWyh+66SdLABy34quqLCyIaPRMm/I2wKjIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnWDyqyRQmginyGtpHILbe8HgYpVQoeRPNYAxhDPNR91iTBnZ3UJYPnW5AxxzPEbgvmpIj5i3QRzRnRSwalF1EKGjGm0Z1VuEsrS2FyGM/D36ddceZWYbasn/cmUu0RLtLjUKIufsgpZ2v4TKdS0xAbkzvPladzTRTCnBP2OfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fuWdPx6G; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IFDH9vhWaq+ALllkPSDHzLJE41HD2vsjtjk4qA/e2mQ=; b=fuWdPx6GZN1eNf0cArwoAmpK7d
	AayMLXQzTkfKlcEaqCqvLpA3jxERKs/fV8rnhvBlzf5Hex5N2M46GK4CNyS9N6URjHzNh5jFkkjJf
	0k4DVFyPXYIvBHzf7mdbkfDqQXO0MY2Ejn/tYnh+JVgpnjeTxjl14JjYRkKDF4vB3kbt7mUPWmxd7
	Dt1s5UC+j+n/vxB/mAjRGu2mBfX4TEf3LRlpvtmR5rVFiRXO0iOQO2/6Z7Kyn88ayyoK9Oxgag4xf
	potupcaQeCqqy/np+DQiz3sOqB7O82bFLup289XuWs9fZo/Fl6aNC4pqTYG+mpkKvgw+49DQ29ReN
	0Ao8BGPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58114)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4d0B-0007sy-2L;
	Tue, 15 Apr 2025 10:54:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4d08-0000GI-1a;
	Tue, 15 Apr 2025 10:54:44 +0100
Date: Tue, 15 Apr 2025 10:54:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: call phylink_start() and
 phylink_stop() in XDP functions
Message-ID: <Z_4s5DmCPKB8SUJv@shell.armlinux.org.uk>
References: <Z/ozvMMoWGH9o6on@shell.armlinux.org.uk>
 <E1u3XG6-000EJg-V8@rmk-PC.armlinux.org.uk>
 <20250414174342.67fe4b1d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414174342.67fe4b1d@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 14, 2025 at 05:43:42PM -0700, Jakub Kicinski wrote:
> On Sat, 12 Apr 2025 10:34:42 +0100 Russell King (Oracle) wrote:
> > Phylink does not permit drivers to mess with the netif carrier, as
> > this will de-synchronise phylink with the MAC driver. Moreover,
> > setting and clearing the TE and RE bits via stmmac_mac_set() in this
> > path is also wrong as the link may not be up.
> > 
> > Replace the netif_carrier_on(), netif_carrier_off() and
> > stmmac_mac_set() calls with the appropriate phylink_start() and
> > phylink_stop() calls, thereby allowing phylink to manage the netif
> > carrier and TE/RE bits through the .mac_link_up() and .mac_link_down()
> > methods.
> > 
> > Note that RE should only be set after the DMA is ready to avoid the
> > receive FIFO between the MAC and DMA blocks overflowing, so
> > phylink_start() needs to be placed after DMA has been started.
> 
> IIUC this will case a link loss when XDP is installed, if not disregard
> the reset of the email.

It will, because the author who added XDP support to stmmac decided it
was easier to tear everything down and rebuild, which meant (presumably)
that it was necessary to use netif_carrier_off() to stop the net layer
queueing packets to the driver. I'm just guessing - I know nothing
about XDP, and never knowingly used it.

> Any idea why it's necessary to mess with the link for XDP changes?

Depends what you mean by "link". If you're asking why it messes with
netif_carrier_foo(), my best guess is as above. However, phylink
drivers are not allowed to mess with the netif_carrier state (as the
commit message states.) This is not a new requirement, it's always
been this way with phylink, and this pre-dates the addition of XDP
to this driver.

As long as the code requires the netif_carrier to be turned off, the
only way to guarantee that in a phylink using driver is as per this
patch.

I'm guessing that the reason it does this is because it completely
takes down the MAC and tx/rx rings to reprogram everything from
scratch, and thus any interference from a packet coming in to be
transmitted is going to cause problems.

> I think we should mention in the commit message that the side effect is
> link loss on XDP on / off. I don't know of any other driver which would
> need this, stmmac is a real gift..

I'll add that. However, it would be nice to find a different solution
for XDP on this driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

