Return-Path: <netdev+bounces-186021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4085A9CBE5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C2F7A7210
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CDC2580EA;
	Fri, 25 Apr 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AYDw7rIy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A32472A6;
	Fri, 25 Apr 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592246; cv=none; b=ttmX7ZEFp1x/fkpR4LOqsdCSIz03yR9hcTHVCv0EhPeLzuoheibrU5zhescxZAqSgjWC26Rc4Lui/acg5L3Qh1ha59PZ45Q/uuWpdXwJdE5xyNChlFB23TidoBlhdUWZGWrG6/li4yTVFvO++ItWpX9MfMHarSFNTOdBOWOsFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592246; c=relaxed/simple;
	bh=jVJBf/R/dc6ahgsECfA9a4xV6tsV8GYocrn8WOFAkRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojK6qOwcB8r1G5iKV9+ZksKaI/iAOROnuCK6ZlD2D4Di7XemL5yeC/73MnQEZIvJ9bLkzUouDzHS6ObhGTBR+VsugrSVtCb78HgE/qovqoeAxhdZ3B4YNrxGGK0OUncT/ZijeselAIDc+1sc7AWJ9fvWtt4UfUS5Tj9oNUqqQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AYDw7rIy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1ssB4Rfy0T4ksx0Lnlz+elFfLJ0yGIeQrZznCe7Aq24=; b=AYDw7rIyOl/D9Wy4/pJKLOcuGO
	mIcV+bNNNkyfM6ri86MKGLJeaBtwsJI94WTwBVzt8Gr0a5UFwNSErB6GS1x/T2KVv6UOktWihA9sE
	cUsoq1/71O2tGVMMaZWQkBpcGzcNk+4tVB2p1GcLPy+NWuQEefWS7RwCOkikK/tSJMZKC7ITJDj7W
	o1Tzip8br8GRK9FuQHs46K2PEkgZbxgWOazM7GJbGq3taU9GIP7l3tu747vWijHtTAw/hEQAOc3Vd
	g6ZOJu0oWh81kbq3D4Wf9egAK3TqJlv6KAjExbCInofNxDb/icxvrlC+tJZe9t0VS5MwNcnUX374/
	NuooLP3A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47354)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u8KHR-0000Xy-2w;
	Fri, 25 Apr 2025 15:43:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u8KHP-0002Cr-0T;
	Fri, 25 Apr 2025 15:43:51 +0100
Date: Fri, 25 Apr 2025 15:43:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: Remove ineffective
 checks from ksz_set_mac_eee()
Message-ID: <aAufpsLhs8GLMm_b@shell.armlinux.org.uk>
References: <20250425110845.482652-1-o.rempel@pengutronix.de>
 <aAuRAadDStfwfS1U@shell.armlinux.org.uk>
 <aAubnUSDpwtfuCrm@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAubnUSDpwtfuCrm@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 25, 2025 at 04:26:37PM +0200, Oleksij Rempel wrote:
> On Fri, Apr 25, 2025 at 02:41:21PM +0100, Russell King (Oracle) wrote:
> > On Fri, Apr 25, 2025 at 01:08:45PM +0200, Oleksij Rempel wrote:
> > > KSZ switches handle EEE internally via PHY advertisement and do not
> > > support MAC-level configuration. The ksz_set_mac_eee() handler previously
> > > rejected Tx LPI disable and timer changes, but provided no real control.
> > 
> > Err what?
> > 
> > ksz does not set phylink_config->eee_enabled_default, so the default
> > state in phylink is eee_enabled = false, tx_lpi_enabled = false. It
> > doesn't set the default LPI timer, so tx_lpi_timer = 0.
> > 
> > As the driver does not implement the ability to change the LPI timer
> > enable nor the timer value, this seemed reasonable as the values are
> > not reported (being reported as zeros) and thus prevents modification
> > thereof.
> > 
> > Why do you want to allow people to change parameters that have no
> > effect?
> 
> The original ksz_get_mac_eee() used to report tx_lpi_enabled = true,
> which correctly reflected the internal EEE/LPI activity of the hardware.

Are you sure it did _actually_ did return that?

Yes, ksz_get_mac_eee() set e->tx_lpi_enabled = true, but if you read the
commit 0945a7b44220 message, you will see that DSA calls
phylink_ethtool_get_eee() after this function, which then calls into
phy_ethtool_get_eee(), and phy_ethtool_get_eee() overwrites *all*
members of struct ethtool_keee.

Thus, userspace doesn't see tx_lpi_enabled set.

Please wind back to before commit 0945a7b44220 to confirm this - I
think you'll find that this bug was introduced in commit
fe0d4fd9285e "net: phy: Keep track of EEE configuration".

> After commit [0945a7b44220 ("net: dsa: ksz: remove setting of tx_lpi
> parameters")], ksz_get_mac_eee() was removed, and now tx_lpi_enabled defaults
> to false via the phylink fallback.

As stated above, I think this driver has had a problem for over a year
now, caused ultimately by the incomplete submission of Andrew's patch
set. I think you'll find that if you try the comparing the ksz behaviour
of commit fe0d4fd9285e^ with commit fe0d4fd9285e, you'll find that's
where this behaviour changed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

