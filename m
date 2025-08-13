Return-Path: <netdev+bounces-213290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602D9B246B5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7783C3B2C4D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BB3212552;
	Wed, 13 Aug 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e8CONxhY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF85212566
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079541; cv=none; b=H6JeXyCTGRHi5fK9eOEi0ulCE6puaYw+yKNePAke9sFyIXyjG4ZdiMmFpUKhysaPjcga8DGkSK5I4hXd/+Ba3R2k+btsqgSKDN7qzkpwQ31My3kU5ohy7yvx26mvJMcDoq/zz3sMvPIJzfFULXpoZ5L69SdDFKeWIY+SeN4XsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079541; c=relaxed/simple;
	bh=X9Q91pOooOt3P56vAU6/R76qgu9ct5BPQli1mIDzIlg=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=ewqg0TQkl2LfsVEpgq+r8j2XpmZfgs3BveicVeahO5RlqcvDS+gaU9gX7x8WwX4L6aO3okMANex5XReIMvUqShiEKYcf5dGc0d0XlkiML/V3R1NKysWbbavMk9Lkx2F5PwOD1fmFDHaze3572FD3p63zsD317oXbArcQCGy0Ryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e8CONxhY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wLCV6CbMAyOZGB59vaH1Hthx6Ywzr9+se6LuLyGVmy0=; b=e8CONxhYX0TqRdsQRc9E+8KSG/
	THAgbm6dzx7Me7ItdXALItN2RvfCKSF0PYDHgbB+s95YIKqBlfT6w7bes/jjkHBHG343eOPBzTIPC
	qKbzkMNgdZzbqXd/wjJN248Cw52vfc34naO2D9VroUsb3ABdjwrABd3yV6gIxptQgWQoB0ZDvYfAg
	cZU+0QOHDY9Y0/dkuG83l+VPQFicDslJHKh5zgw57ecJGjNpBALwox06bRl53W292MGdA4yIxw+/h
	0ClLhkNyTHwtE5B8ELfEWZI3Y6lrjJGlPbfPF73ImYra1ZXnIObg0VCTwhqJ5exgPY7RdLqZj7udQ
	s0yfC89A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35384 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1um8MM-0006O1-1f;
	Wed, 13 Aug 2025 11:05:30 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1um8Ld-008jxD-Mc; Wed, 13 Aug 2025 11:04:45 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next] net: phy: realtek: fix RTL8211F wake-on-lan support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 13 Aug 2025 11:04:45 +0100

Implement Wake-on-Lan for RTL8211F correctly. The existing
implementation has multiple issues:

1. It assumes that Wake-on-Lan can always be used, whether or not the
   interrupt is wired, and whether or not the interrupt is capable of
   waking the system. This breaks the ability for MAC drivers to detect
   whether the PHY WoL is functional.
2. switching the interrupt pin in the .set_wol() method to PMEB mode
   immediately silences link-state interrupts, which breaks phylib
   when interrupts are being used rather than polling mode.
3. the code claiming to "reset WOL status" was doing nothing of the
   sort. Bit 15 in page 0xd8a register 17 controls WoL reset, and
   needs to be pulsed low to reset the WoL state. This bit was always
   written as '1', resulting in no reset.
4. not resetting WoL state results in the PMEB pin remaining asserted,
   which in turn leads to an interrupt storm. Only resetting the WoL
   state in .set_wol() is not sufficient.
5. PMEB mode does not allow software detection of the wake-up event as
   there is no status bit to indicate we received the WoL packet.
6. across reboots of at least the Jetson Xavier NX system, the WoL
   configuration is preserved.

Fix all of these issues by essentially rewriting the support. We:
1. clear the WoL event enable register at probe time.
2. detect whether we can support wake-up by having a valid interrupt,
   and the "wakeup-source" property in DT. If we can, then we mark
   the MDIO device as wakeup capable, and associate the interrupt
   with the wakeup source.
3. arrange for the get_wol() and set_wol() implementations to handle
   the case where the MDIO device has not been marked as wakeup
   capable (thereby returning no WoL support, and refusing to enable
   WoL support.)
4. avoid switching to PMEB mode, instead using INTB mode with the
   interrupt enable, reconfiguring the interrupt enables at suspend
   time, and restoring their original state at resume time (we track
   the state of the interrupt enable register in .config_intr()
   register.)
5. move WoL reset from .set_wol() to the suspend function to ensure
   that WoL state is cleared prior to suspend. This is necessary
   after the PME interrupt has been enabled as a second WoL packet
   will not re-raise a previously cleared PME interrupt.
6. when a PME interrupt (for wakeup) is asserted, pass this to the
   PM wakeup so it knows which device woke the system.

This fixes WoL support in the Realtek RTL8211F driver when used on the
nVidia Jetson Xavier NX platform, and needs to be applied before stmmac
patches which allow these platforms to forward the ethtool WoL commands
to the Realtek PHY.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/realtek/realtek_main.c | 172 ++++++++++++++++++++-----
 1 file changed, 140 insertions(+), 32 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index dd0d675149ad..4361529e68fb 100644
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
+#define RTL8211F_INER_PME			BIT(7)
 #define RTL8211F_INER_LINK_STATUS		BIT(4)
 
 #define RTL821x_INSR				0x13
@@ -96,17 +98,13 @@
 #define RTL8211F_RXCR				0x15
 #define RTL8211F_RX_DELAY			BIT(3)
 
-/* RTL8211F WOL interrupt configuration */
-#define RTL8211F_INTBCR_PAGE			0xd40
-#define RTL8211F_INTBCR				0x16
-#define RTL8211F_INTBCR_INTB_PMEB		BIT(5)
-
 /* RTL8211F WOL settings */
-#define RTL8211F_WOL_SETTINGS_PAGE		0xd8a
+#define RTL8211F_WOL_PAGE		0xd8a
 #define RTL8211F_WOL_SETTINGS_EVENTS		16
 #define RTL8211F_WOL_EVENT_MAGIC		BIT(12)
-#define RTL8211F_WOL_SETTINGS_STATUS		17
-#define RTL8211F_WOL_STATUS_RESET		(BIT(15) | 0x1fff)
+#define RTL8211F_WOL_RST_RMSQ		17
+#define RTL8211F_WOL_RG_RSTB			BIT(15)
+#define RTL8211F_WOL_RMSQ			0x1fff
 
 /* RTL8211F Unique phyiscal and multicast address (WOL) */
 #define RTL8211F_PHYSICAL_ADDR_PAGE		0xd8c
@@ -172,7 +170,8 @@ struct rtl821x_priv {
 	u16 phycr2;
 	bool has_phycr2;
 	struct clk *clk;
-	u32 saved_wolopts;
+	/* rtl8211f */
+	u16 iner;
 };
 
 static int rtl821x_read_page(struct phy_device *phydev)
@@ -255,6 +254,34 @@ static int rtl821x_probe(struct phy_device *phydev)
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
+	/* Disable all PME events */
+	ret = phy_write_paged(phydev, RTL8211F_WOL_PAGE,
+			      RTL8211F_WOL_SETTINGS_EVENTS, 0);
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
@@ -352,6 +379,7 @@ static int rtl8211e_config_intr(struct phy_device *phydev)
 
 static int rtl8211f_config_intr(struct phy_device *phydev)
 {
+	struct rtl821x_priv *priv = phydev->priv;
 	u16 val;
 	int err;
 
@@ -362,8 +390,10 @@ static int rtl8211f_config_intr(struct phy_device *phydev)
 
 		val = RTL8211F_INER_LINK_STATUS;
 		err = phy_write_paged(phydev, 0xa42, RTL821x_INER, val);
+		if (err == 0)
+			priv->iner = val;
 	} else {
-		val = 0;
+		priv->iner = val = 0;
 		err = phy_write_paged(phydev, 0xa42, RTL821x_INER, val);
 		if (err)
 			return err;
@@ -426,21 +456,34 @@ static irqreturn_t rtl8211f_handle_interrupt(struct phy_device *phydev)
 		return IRQ_NONE;
 	}
 
-	if (!(irq_status & RTL8211F_INER_LINK_STATUS))
-		return IRQ_NONE;
+	if (irq_status & RTL8211F_INER_LINK_STATUS) {
+		phy_trigger_machine(phydev);
+		return IRQ_HANDLED;
+	}
 
-	phy_trigger_machine(phydev);
+	if (irq_status & RTL8211F_INER_PME) {
+		pm_wakeup_event(&phydev->mdio.dev, 0);
+		return IRQ_HANDLED;
+	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static void rtl8211f_get_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
 {
 	int wol_events;
 
+	/* If the PHY is not capable of waking the system, then WoL can not
+	 * be supported.
+	 */
+	if (!device_can_wakeup(&dev->mdio.dev)) {
+		wol->supported = 0;
+		return;
+	}
+
 	wol->supported = WAKE_MAGIC;
 
-	wol_events = phy_read_paged(dev, RTL8211F_WOL_SETTINGS_PAGE, RTL8211F_WOL_SETTINGS_EVENTS);
+	wol_events = phy_read_paged(dev, RTL8211F_WOL_PAGE, RTL8211F_WOL_SETTINGS_EVENTS);
 	if (wol_events < 0)
 		return;
 
@@ -453,6 +496,9 @@ static int rtl8211f_set_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
 	const u8 *mac_addr = dev->attached_dev->dev_addr;
 	int oldpage;
 
+	if (!device_can_wakeup(&dev->mdio.dev))
+		return -EOPNOTSUPP;
+
 	oldpage = phy_save_page(dev);
 	if (oldpage < 0)
 		goto err;
@@ -464,25 +510,23 @@ static int rtl8211f_set_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
 		__phy_write(dev, RTL8211F_PHYSICAL_ADDR_WORD1, mac_addr[3] << 8 | (mac_addr[2]));
 		__phy_write(dev, RTL8211F_PHYSICAL_ADDR_WORD2, mac_addr[5] << 8 | (mac_addr[4]));
 
-		/* Enable magic packet matching and reset WOL status */
-		rtl821x_write_page(dev, RTL8211F_WOL_SETTINGS_PAGE);
+		/* Enable magic packet matching */
+		rtl821x_write_page(dev, RTL8211F_WOL_PAGE);
 		__phy_write(dev, RTL8211F_WOL_SETTINGS_EVENTS, RTL8211F_WOL_EVENT_MAGIC);
-		__phy_write(dev, RTL8211F_WOL_SETTINGS_STATUS, RTL8211F_WOL_STATUS_RESET);
-
-		/* Enable the WOL interrupt */
-		rtl821x_write_page(dev, RTL8211F_INTBCR_PAGE);
-		__phy_set_bits(dev, RTL8211F_INTBCR, RTL8211F_INTBCR_INTB_PMEB);
+		/* Set the maximum packet size, and assert WoL reset */
+		__phy_write(dev, RTL8211F_WOL_RST_RMSQ, RTL8211F_WOL_RMSQ);
 	} else {
-		/* Disable the WOL interrupt */
-		rtl821x_write_page(dev, RTL8211F_INTBCR_PAGE);
-		__phy_clear_bits(dev, RTL8211F_INTBCR, RTL8211F_INTBCR_INTB_PMEB);
-
-		/* Disable magic packet matching and reset WOL status */
-		rtl821x_write_page(dev, RTL8211F_WOL_SETTINGS_PAGE);
+		/* Disable magic packet matching */
+		rtl821x_write_page(dev, RTL8211F_WOL_PAGE);
 		__phy_write(dev, RTL8211F_WOL_SETTINGS_EVENTS, 0);
-		__phy_write(dev, RTL8211F_WOL_SETTINGS_STATUS, RTL8211F_WOL_STATUS_RESET);
+
+		/* Place WoL in reset */
+		__phy_clear_bits(dev, RTL8211F_WOL_RST_RMSQ,
+				 RTL8211F_WOL_RG_RSTB);
 	}
 
+	device_set_wakeup_enable(&dev->mdio.dev, !!(wol->wolopts & WAKE_MAGIC));
+
 err:
 	return phy_restore_page(dev, oldpage, 0);
 }
@@ -628,6 +672,52 @@ static int rtl821x_suspend(struct phy_device *phydev)
 	return ret;
 }
 
+static int rtl8211f_suspend(struct phy_device *phydev)
+{
+	u16 wol_rst;
+	int ret;
+
+	ret = rtl821x_suspend(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* If a PME event is enabled, then configure the interrupt for
+	 * PME events only, disabling link interrupt. We avoid switching
+	 * to PMEB mode as we don't have a status bit for that.
+	 */
+	if (device_may_wakeup(&phydev->mdio.dev)) {
+		ret = phy_write_paged(phydev, 0xa42, RTL821x_INER,
+				      RTL8211F_INER_PME);
+		if (ret < 0)
+			goto err;
+
+		/* Read the INSR to clear any pending interrupt */
+		phy_read_paged(phydev, RTL8211F_INSR_PAGE, RTL8211F_INSR);
+
+		/* Reset the WoL to ensure that an event is picked up.
+		 * Unless we do this, even if we receive another packet,
+		 * we may not have a PME interrupt raised.
+		 */
+		ret = phy_read_paged(phydev, RTL8211F_WOL_PAGE,
+				     RTL8211F_WOL_RST_RMSQ);
+		if (ret < 0)
+			goto err;
+
+		wol_rst = ret & ~RTL8211F_WOL_RG_RSTB;
+		ret = phy_write_paged(phydev, RTL8211F_WOL_PAGE,
+				      RTL8211F_WOL_RST_RMSQ, wol_rst);
+		if (ret < 0)
+			goto err;
+
+		wol_rst |= RTL8211F_WOL_RG_RSTB;
+		ret = phy_write_paged(phydev, RTL8211F_WOL_PAGE,
+				      RTL8211F_WOL_RST_RMSQ, wol_rst);
+	}
+
+err:
+	return ret;
+}
+
 static int rtl821x_resume(struct phy_device *phydev)
 {
 	struct rtl821x_priv *priv = phydev->priv;
@@ -645,6 +735,24 @@ static int rtl821x_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8211f_resume(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	int ret;
+
+	ret = rtl821x_resume(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* If the device was programmed for a PME event, restore the interrupt
+	 * enable so phylib can receive link state interrupts.
+	 */
+	if (device_may_wakeup(&phydev->mdio.dev))
+		ret = phy_write_paged(phydev, 0xa42, RTL821x_INER, priv->iner);
+
+	return ret;
+}
+
 static int rtl8211x_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					unsigned long rules)
 {
@@ -1612,15 +1720,15 @@ static struct phy_driver realtek_drvs[] = {
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
2.30.2


