Return-Path: <netdev+bounces-210801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9F1B14DD7
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2ECB3B6FDF
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E5A6FC5;
	Tue, 29 Jul 2025 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ygyXLptN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6910E9
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793168; cv=none; b=mj6dmHsqpxwlm/uUxlxanHe4VWTgs5EBv1bcYJWEtaj2RVvuSA46gRTNOcwkjDJwqORmPPFgYzGNn8iFB5pakcixdDZv/QRvc7d09b5mAdtgbAUptZBBU6hCESzYw0ZzWaIQoZnvMbdqY9xMsAcTmBcjBqpj7A+G3XYnEJEzv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793168; c=relaxed/simple;
	bh=N8uU2QwVCVM4Jw8lltZWOoL6xJ3fD0xi+pSMLmG4PNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUPZF9Vfuit6KpgQc9ZOpD7aJN3cIvcJVHP236qkd5++HZ2jAO3kZrUBGZFcJnSXXCvYLOEDmh6yz057eWExAKAIOMCJH3Rt6rwV6/hBRK7wSHvIW3JIdWt7iXHA6g6xDJrC4Txc2RUdeqaqi5Gq46sVeJTdQsKHjMCJ5KbDSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ygyXLptN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PswxPYOya6KsdVbaImLuw/Evrnb6EANrQ2lNtu2xVIg=; b=ygyXLptN2aFVGpvg6kjvjbvzqD
	FM+shJgq+ptaEHpRfSrYtTFZE/i1SmzZYr/DKU598BNVlACFu61+w6Yplm9Rkqppep2WJutR9pIbN
	QRuuxJOwhvmKOO7CVv9IJFJeDGCtHS1AzfOCnuUa6rAUDM4Zx90P7vT+Eo0F5UMIYu1lYZcFphBs+
	q62b9/aCwb37wfMBX4xbCb8Z8jh2uFQM9Z2yRylJ+yhuGJzPjvpYqR5788Im1TQbAM/mVMDbvKyiE
	CLWaM1HovKtRT+POahZ7E0Zo3RKx7e1sXxUpsye83EOyt4w9T9DDRQzYKkjI0Ey7axZP9I0OOepfY
	yoxzl7Tw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33078)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ugjiR-0001vE-1K;
	Tue, 29 Jul 2025 13:45:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ugjiN-0007QL-2W;
	Tue, 29 Jul 2025 13:45:55 +0100
Date: Tue, 29 Jul 2025 13:45:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Linux-stm32] [PATCH RFC net-next 6/7] net: stmmac: add helpers
 to indicate WoL enable status
Message-ID: <aIjCg_sjTOge9vd4@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
 <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
 <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
 <77229e46-6466-4cd4-9b3b-d76aadbe167c@foss.st.com>
 <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 29, 2025 at 10:03:22AM +0100, Russell King (Oracle) wrote:
> With Thierry's .dts patch, PHY interrupts completely stop working, so
> we don't get link change notifications anymore - and we still don't
> seem to be capable of waking the system up with the PHY interrupt
> being asserted.
> 
> Without Thierry's .dts patch, as I predicted, enabling WoL at the
> PHY results in Bad Stuff happening - the code in the realtek driver
> for WoL is quite simply broken and wrong.
> 
> Switching the pin from INTB mode to PMEB mode results in:
> - No link change interrupts once WoL is enabled
> - The interrupt output being stuck at active level, causing an
>   interrupt storm and the interrupt is eventually disabled.
>   The PHY can be configured to pulse the PMEB or hold at an active
>   level until the WoL is cleared - and by default it's the latter.
> 
> So, switching the interrupt pin to PMEB mode is simply wrong and
> breaks phylib. I guess the original WoL support was only tested on
> a system which didn't use the PHY interrupt, only using the interrupt
> pin for wake-up purposes.
> 
> I was working on the realtek driver to fix this, but it's pointless
> spending time on this until the rest of the system can wake up -
> and thus the changes can be tested. This is where I got to (and
> includes work from both Thierry and myself, so please don't pick
> this up as-is, because I can guarantee that you'll get the sign-offs
> wrong! It's a work-in-progress, and should be a series for submission.)

Okay, with this patch, wake-up now works on the PHY interrupt line, but
because normal interrupts aren't processed, the interrupt output from
the PHY is stuck at active level, so the system immediately wakes up
from suspend.

Without the normal interrupt problem solved, there's nothing further
I can do on this.

Some of the open questions are:
- whether we should configure the WoL interrupt in the suspend/resume
  function
- the interaction between the WoL interrupt configuration and the
  config_intr method (whether on resume, the WoL interrupt enable
  could get cleared, effectively disabling future WoL, despite it
  being reported as enabled to userspace)
- if we don't mark the PHY as wake-up capable, should we indicate
  that the PHY does not support WoL in .get_wol() and return
  -EOPNOTSUPP for .set_wol() given that we've had broken WoL support
  merged in the recent v6.16 release.

I'm pretty sure that we want all PHYs that support WoL to mark
themselves as a wakeup capable device, so the core wakeup code knows
that the PHY has capabilities, and control the device wakeup enable.
Thus, I think we want to have some of this wakeup handling in the
core phylib code.

However, as normal PHY interrupts don't work, this isn't something I
can pursue further.

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi
index a410fc335fa3..8ceba83614ed 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi
@@ -39,9 +39,10 @@ mdio {
 				phy: ethernet-phy@0 {
 					compatible = "ethernet-phy-ieee802.3-c22";
 					reg = <0x0>;
-					interrupt-parent = <&gpio>;
-					interrupts = <TEGRA194_MAIN_GPIO(G, 4) IRQ_TYPE_LEVEL_LOW>;
+					interrupt-parent = <&pmc>;
+					interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
 					#phy-cells = <0>;
+					wakeup-source;
 				};
 			};
 		};
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 09ae16e026eb..bcaa37e08345 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -261,7 +261,8 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
 	plat_dat->bsp_priv = eqos;
 	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE |
-			   STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
+			   STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP |
+			   STMMAC_FLAG_USE_PHY_WOL;
 
 	return 0;
 
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index dd0d675149ad..ef10e2c32318 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/of.h>
 #include <linux/phy.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/netdevice.h>
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -31,6 +32,7 @@
 #define RTL821x_INER				0x12
 #define RTL8211B_INER_INIT			0x6400
 #define RTL8211E_INER_LINK_STATUS		BIT(10)
+#define RTL8211F_INER_WOL			BIT(7)
 #define RTL8211F_INER_LINK_STATUS		BIT(4)
 
 #define RTL821x_INSR				0x13
@@ -255,6 +257,28 @@ static int rtl821x_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8211f_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	ret = rtl821x_probe(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Mark this PHY as wakeup capable and register the interrupt as a
+	 * wakeup IRQ if the PHY is marked as a wakeup source in firmware,
+	 * and the interrupt is valid.
+	 */
+	if (device_property_read_bool(dev, "wakeup-source") &&
+	    phy_interrupt_is_valid(phydev)) {
+		device_set_wakeup_capable(dev, true);
+		devm_pm_set_wake_irq(dev, phydev->irq);
+	}
+
+	return ret;
+}
+
 static int rtl8201_ack_interrupt(struct phy_device *phydev)
 {
 	int err;
@@ -426,12 +450,17 @@ static irqreturn_t rtl8211f_handle_interrupt(struct phy_device *phydev)
 		return IRQ_NONE;
 	}
 
-	if (!(irq_status & RTL8211F_INER_LINK_STATUS))
-		return IRQ_NONE;
+	if (irq_status & RTL8211F_INER_LINK_STATUS) {
+		phy_trigger_machine(phydev);
+		return IRQ_HANDLED;
+	}
 
-	phy_trigger_machine(phydev);
+	if (irq_status & RTL8211F_INER_WOL) {
+		pm_wakeup_event(&phydev->mdio.dev, 0);
+		return IRQ_HANDLED;
+	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static void rtl8211f_get_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
@@ -470,12 +499,16 @@ static int rtl8211f_set_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
 		__phy_write(dev, RTL8211F_WOL_SETTINGS_STATUS, RTL8211F_WOL_STATUS_RESET);
 
 		/* Enable the WOL interrupt */
-		rtl821x_write_page(dev, RTL8211F_INTBCR_PAGE);
-		__phy_set_bits(dev, RTL8211F_INTBCR, RTL8211F_INTBCR_INTB_PMEB);
+		//rtl821x_write_page(dev, RTL8211F_INTBCR_PAGE);
+		//__phy_set_bits(dev, RTL8211F_INTBCR, RTL8211F_INTBCR_INTB_PMEB);
+		rtl821x_write_page(dev, 0xa42);
+		__phy_set_bits(dev, RTL821x_INER, RTL8211F_INER_WOL);
 	} else {
 		/* Disable the WOL interrupt */
-		rtl821x_write_page(dev, RTL8211F_INTBCR_PAGE);
-		__phy_clear_bits(dev, RTL8211F_INTBCR, RTL8211F_INTBCR_INTB_PMEB);
+		//rtl821x_write_page(dev, RTL8211F_INTBCR_PAGE);
+		//__phy_clear_bits(dev, RTL8211F_INTBCR, RTL8211F_INTBCR_INTB_PMEB);
+		rtl821x_write_page(dev, 0xa42);
+		__phy_clear_bits(dev, RTL821x_INER, RTL8211F_INER_WOL);
 
 		/* Disable magic packet matching and reset WOL status */
 		rtl821x_write_page(dev, RTL8211F_WOL_SETTINGS_PAGE);
@@ -483,10 +516,30 @@ static int rtl8211f_set_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
 		__phy_write(dev, RTL8211F_WOL_SETTINGS_STATUS, RTL8211F_WOL_STATUS_RESET);
 	}
 
+	device_set_wakeup_enable(&dev->mdio.dev, !!(wol->wolopts & WAKE_MAGIC));
+
 err:
 	return phy_restore_page(dev, oldpage, 0);
 }
 
+static int rtl821x_suspend(struct phy_device *phydev);
+static int rtl8211f_suspend(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	int ret = rtl821x_suspend(phydev);
+
+	return ret;
+}
+
+static int rtl821x_resume(struct phy_device *phydev);
+static int rtl8211f_resume(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	int ret = rtl821x_resume(phydev);
+
+	return ret;
+}
+
 static int rtl8211_config_aneg(struct phy_device *phydev)
 {
 	int ret;
@@ -1612,15 +1665,15 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc916),
 		.name		= "RTL8211F Gigabit Ethernet",
-		.probe		= rtl821x_probe,
+		.probe		= rtl8211f_probe,
 		.config_init	= &rtl8211f_config_init,
 		.read_status	= rtlgen_read_status,
 		.config_intr	= &rtl8211f_config_intr,
 		.handle_interrupt = rtl8211f_handle_interrupt,
 		.set_wol	= rtl8211f_set_wol,
 		.get_wol	= rtl8211f_get_wol,
-		.suspend	= rtl821x_suspend,
-		.resume		= rtl821x_resume,
+		.suspend	= rtl8211f_suspend,
+		.resume		= rtl8211f_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
 		.flags		= PHY_ALWAYS_CALL_SUSPEND,

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

