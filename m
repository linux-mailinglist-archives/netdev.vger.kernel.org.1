Return-Path: <netdev+bounces-211263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D991B1769B
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 21:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE87F16F996
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE372459D0;
	Thu, 31 Jul 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S66/5oXI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B95C15E5D4;
	Thu, 31 Jul 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990018; cv=none; b=M/ZG9kG4WQA5rfcKhJ9aFKB6NsvajkejRyEkauvBf2RAY4/XvUiRSau1vo1EFWTsf3kQI1bZzxjeFgccRUmc+NahYdjJ/P4XMMsZsvK53GVWu1mWdLWzvhWBOUY834tHhvjRef9jQWuqO41RLkAE/drW2w6v1FOblyMt9qu8nDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990018; c=relaxed/simple;
	bh=31UY6IyD3cvrHRGfuoivh8kCJIkz87ifJetdfZxruzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdSUwAamUrCdYqCIgcoRKZSrJ3oc3qHfGTa0RH4QK0yrsUR8pT02yHTHMuhv1beIQ2rUQzftrHrL36LLkIeoY4ktW0Hl6muYsmYnXbq4FVcdpSlc5XEk1X2CH2E9kPkCeBoWuOL9GI9Dmde0JVMtLn1JKSJyHqzIDrAVs84Ng2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S66/5oXI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1nlI48xArvrBHfTnhzWDv3TSWgsTV0z4LPDzuqofLI8=; b=S66/5oXIArRIKC40/BLF3QmVbo
	NvCDH27oT6EiixwYM4WBy5LZQOlUCMCEQJPToPSKf53170Bw8xj6li6f4P3UxkhwqlBNJmisogvWQ
	I+wKf44RYWil8IokSm/+QMN/lMTD4c82h2q+SUV2Fb/txyWdfvsvYRUkL5qCzZNhlFsrAkGg+VATd
	0xBgLNGwLH4NKuvKX+GMVhhye8iVqzDcOBUnJfsq/buMVxg0fRG7wLxszwC424AnKoGRCtt1BSB8e
	3Nmp8/8Td2f4z7xnYbCXE52AtOdSnwdDqZhRKye2JZLKcSzZntHt5PyvcEtdZxurKErnB03R6oDzc
	hy5O0Qyg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55192)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhYvP-0005Qh-0y;
	Thu, 31 Jul 2025 20:26:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhYvL-0001HL-3B;
	Thu, 31 Jul 2025 20:26:44 +0100
Date: Thu, 31 Jul 2025 20:26:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731171642.2jxmhvrlb554mejz@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 31, 2025 at 08:16:42PM +0300, Vladimir Oltean wrote:
> Hi Alexander,
> 
> On Thu, Jul 31, 2025 at 04:59:09PM +0200, Alexander Wilhelm wrote:
> > Hello devs,
> > 
> > I'm fairly new to Ethernet PHY drivers and would appreciate your help. I'm
> > working with the Aquantia AQR115 PHY. The existing driver already supports the
> > AQR115C, so I reused that code for the AQR115, assuming minimal differences. My
> > goal is to enable 2.5G link speed. The PHY supports OCSGMII mode, which seems to
> > be non-standard.
> > 
> > * Is it possible to use this mode with the current driver?
> > * If yes, what would be the correct DTS entry?
> > * If not, I’d be willing to implement support. Could you suggest a good starting point?
> > 
> > Any hints or guidance would be greatly appreciated.
> > 
> > 
> > Best regards
> > Alexander Wilhelm
> > 
> 
> In addition to what Andrew and Russell said:
> 
> The Aquantia PHY driver is a bit unlike other PHY drivers, in that it
> prefers not to change the hardware configuration, and work with the
> provisioning of the firmware.

I'll state here that this is a design decision of the PHY driver.
It is possible to reconfigure the PHY (I have code in the PHY
driver to do it, so I can test the module on the Armada 388 based
Clearfog patform.

Essentially, in aqr107_fill_interface_modes() I do this:

+       phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1, MDIO_CTRL1_LPOWER);
+       mdelay(10);
+       phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x31a, 2);
+       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_10M,
+                     VEND1_GLOBAL_CFG_SGMII_AN |
+                     VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
+       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_100M,
+                     VEND1_GLOBAL_CFG_SGMII_AN |
+                     VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
+       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_1G,
+                     VEND1_GLOBAL_CFG_SGMII_AN |
+                     VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
+       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_2_5G,
+                     VEND1_GLOBAL_CFG_SGMII_AN |
+                     VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII);
+       phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1,
+                          MDIO_CTRL1_LPOWER);

with:

 #define VEND1_GLOBAL_CFG_SERDES_MODE_XFI       0
 #define VEND1_GLOBAL_CFG_SERDES_MODE_SGMII     3
 #define VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII   4
+#define VEND1_GLOBAL_CFG_SERDES_MODE_LOW_POWER 5
 #define VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G     6
+#define VEND1_GLOBAL_CFG_SERDES_MODE_XFI20G    7
+#define VEND1_GLOBAL_CFG_SGMII_AN              BIT(3)
+#define VEND1_GLOBAL_CFG_SERDES_SILENT         BIT(6)

and this works. So... we could actually reconfigure the PHY independent
of what was programmed into the firmware.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

