Return-Path: <netdev+bounces-161334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846E8A20B71
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A67A45AB
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2741A9B40;
	Tue, 28 Jan 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="z64FuhbQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE381A725A;
	Tue, 28 Jan 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738071609; cv=none; b=XBT0lgUqfS6ooTNeJLUX8Zhb/eSnisHy0hGtTLRvMho/EGQTtwdqcbmM3zhxgKG1H55lFrzpg+kjgtdRGV41WP2PJSWv2Th8IddOSMw0PBj1cKpw3FgdR/QYZeX08M7Yy+EnpgOMg1sjd4Cap0GY1WV5y3dBO1AO7CzhVRqwz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738071609; c=relaxed/simple;
	bh=0iNfeZHcQX/hyxiA0F3IDJeQsZwcYvtZ89NrvRszhew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swO368XpICJYietg+jZCo6WEU9YrbMUGE6pja+rMCgG4LUQynd/SFZw0bdzEB75hfyRHb3FpIIlf5/exU42cQ2IIZ/upxqGFJQlhq7hYlF6PMBIgQuJX/BxENo3zo/AVV9tjL+Bshp9paR5OhXmA8aZ2qBqJ7fwj5ynenr8dO5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=z64FuhbQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mCtfPLXq4GNmCA1Ax/oTvwmuawp3GE7H6PmnBY/CzT4=; b=z64FuhbQbE6lBuAM9arRIgTNTR
	bEdR+EnIIjwTeaOVzNTBHI6rRG1NUd/XSbtVHFGtNbVplaW1dW2WlQib779MLzskOMZ6EMU0JvTPS
	66w0H8lLcq1/Cyk6LJfP+f0kdQecbhpnPgmme58UsuPOtRAiBhf/EDd3kjvaaqaLSDdfWPjhYcIob
	9qAZ9w5wfekNNL7kbNKjL8b0XplBNCTN/78Epg+i8y+zhE0ejvxE5otQCP7Ybd/fClziFexawIukk
	bcV72ntH+fshl5oF8jKL83EmfpFBaJAbYUaJ73HuEcDYQhlKKXyS1QjKeMTDAOYpMoKUGhbdts+Q0
	QZfZEyqQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37626)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tclop-0007Fm-0b;
	Tue, 28 Jan 2025 13:39:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tclol-0002gs-1t;
	Tue, 28 Jan 2025 13:39:51 +0000
Date: Tue, 28 Jan 2025 13:39:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z5jeJ_p22fF1AqDZ@shell.armlinux.org.uk>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <69e2c86e-b463-4c4a-8f2c-0613b29be916@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e2c86e-b463-4c4a-8f2c-0613b29be916@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 28, 2025 at 02:16:28PM +0100, Andrew Lunn wrote:
> > For 1000BaseX mode setting neg_mode to false works, but that does not
> > work for SGMII mode.  Setting 0x18 value in register 0x1f8001 allows
> > 1000BaseX mode to work with auto-negotiation enabled.
> 
> Unless you have the datasheet, writing 0x18 to 0x1f8001 is pretty
> meaningless. You need to explain what these two bits mean in this
> register.

Well, this is the reason I searched for the datasheet to find out
what it was, and discovered further information which suggests
other stuff is wrong in the current driver.

bit 4: SGMII link status. This is used to populate the SGMII tx_config
register bit 15 when XPCS is operating in PHY mode. KSZ9477
documentation states that this bit must be set in "SerDes" mode, aka
1000base-X. If that requirement comes from Synopsys, then the current
XPCS driver is buggy...

bit 3: Transmit configuration. In SGMII mode, selects between PHY mode
(=1) or MAC mode (=0). KSZ9477 documentation states that this bit must
be set when operating in "SerDes" mode. (Same concern as for bit 4.)

I will also note here that bits 2:1 are documented as 00=SerDes mode,
10=SGMII mode.

Cross-referencing with the SJA1105 documentation, Digital Control
Register 1 bit 0 = 0 gives a tx_config format of:

	tx_config[15] = comes from SGMII link status above
	tx_config[12] = MII_ADVERTISE.bit5 (which, even though operating
			in SGMII mode, MII_ADVERTISE is 802.3z format.)
	tx_config[11:10] = MII_BMCR speed bits

As stated elsewhere, changes to the AN control register in KSZ9477
are documented as only taking effect when the MII_ADVERTISE register
is subsequently written (which the driver doesn't do, nor does this
patch!)

The lack of access to Synopsys Designware XPCS documentation makes
working out how to properly drive this hardware problematical. We're
subject to the randomness of the register set documentation that can
be found in various chip manufacturers who publish it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

