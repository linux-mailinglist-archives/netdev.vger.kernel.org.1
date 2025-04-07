Return-Path: <netdev+bounces-179847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA9CA7EBC1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F32FC7A2562
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589F25B66C;
	Mon,  7 Apr 2025 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="tYtTduCg";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="s3+ojI8q"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A325B660;
	Mon,  7 Apr 2025 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050336; cv=pass; b=A+VaqsQkVjLTz7NcQ064wQxuhz8/oLWm/wwxG5DTq40OBjV5mSos69A0XzKjRLi8fo93q/cqoCPJO92lbM/oCthbG2pYtPNeFpZpeVqgBkDCzrE1b9n6CY/EImWSjJ4temYwNsDq2BH9E2aqVDqDy0a+PsGj/MmXmIoTjGagUjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050336; c=relaxed/simple;
	bh=JsBPV+BoVZZ8mHe+BMDN7NZXxxagZRvpszOxyvlpkrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0BuiKULXCYFDNeHgw4prewgiyQ8CE6E9xXiPtLZMs+n6PfxIFV3NMH5HB8R8Mk+yRv6oba46cHxcIxEkg2J/dKm2G9quLRKIpuHLNmgt4b+xngVqBq98i3lmCxzLNyhIZ1Cu/F4ctTrcZF0isRCwBlBqxSSN1esbcRdS4HYP5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=tYtTduCg; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=s3+ojI8q; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744050147; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ksILdzYkuBYyyK5uaanNXg4ZuD7VubwPsg2Q28Xz078fM3Jzqz9x2jf0e5tKesR9rb
    j9bBGo+XgiqLSxchFPDaHjii72ivzVV8sCBzsKfpbGgBuGV3OICNmRvPgaoZL5re0V05
    0B3CWLIZhyuCRKk4N0g/ju+8tp0VBOkatdywT0TnBri9RzQ3YWIktv4+d0i3oZC3q2Rl
    sptmaVEnG5dEtvp7V0/Le+J+djkMXOY6ioXnsPRPUUANyh+KlEMqet9Q85a5hpbeCC6x
    B9qxRUxS1NVGVr11vz8rB5W6mkGwOvLvAEY8pOHKPYPjvasD8TWHtNeRzmIUpBbCxO18
    a+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744050147;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=P/McivwteINBEBUe5y6izhPA6joYrRsVsjumRXRwJUU=;
    b=XsLE62MAzeBRaX5yvcLnH1dD3MmhpNEyHbxZYUCjic91Jhu75XV1rnbR8Ann6AYYz5
    EbAJa3GAwkPLg2ERDpg03ZrJMBcCTDTD60nvKzn8gDf4wEF6w3XBw+GRZeqnc7H6LsvM
    isapTmod7zXqNsqWWaJht1w1bQvmnwAsKPALiL1Fg2pk+6X8XKI1qF8kK3MwAEeVN2KS
    Slj8fcON7MwlUQY0VX6dP/1rBhmHGWkZuF3TKK1d4ChsnX7QmJ71HMqvX9/CFdwpOthL
    zMJ2ST/wGJTcxYr3mLZY8nROGWHlSotdi1Jg52G4/vidgy726kaXdqlJYBL5l53ii+PS
    cFhw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744050147;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=P/McivwteINBEBUe5y6izhPA6joYrRsVsjumRXRwJUU=;
    b=tYtTduCgENLp/+Vn1oHa+4A8NrhB96mOJzK8zmI4O3dZ47lVFnp8Mh5h3c2Okhe8S5
    0g2yLurypFB8BUqVWfZVjFZSMKL0xmfMVJmztw1jPhm8QGlCTgwwOTfgpaPJp3qzzIEg
    +gw5qI6JJ5XFIy/CuwTfn0tZgPSyOSi8plTTUwq+kF2yn5MAsyyOsjgNrWC+psnXUExw
    IJg6MUn+TKjtGFvWz0u0vZaLtWDXUUU8TSN2x0Mthy+XqjHWiSLDGkt6guq1XLdEF7Mo
    6uJ6jCyZm+eBPuqZ5LSBt7ls74LnVXlzIB37G18BzJ9kImNAfm9q2qzIRbkCGVfuwy2u
    ICNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744050147;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=P/McivwteINBEBUe5y6izhPA6joYrRsVsjumRXRwJUU=;
    b=s3+ojI8qL3F8XxiJ+mjT0V2jYX8ZPiSdeLsB4BR0zAlILqx5lbj90LecD0TMg3DJ0s
    WBKdWABfSFuEJnEIxBBA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35137IMRyOs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Apr 2025 20:22:27 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1u1r74-0003yk-1g;
	Mon, 07 Apr 2025 20:22:26 +0200
Received: (nullmailer pid 15079 invoked by uid 502);
	Mon, 07 Apr 2025 18:22:26 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND net-next v5 4/4] net: phy: realtek: Add support for PHY LEDs on RTL8211E
Date: Mon,  7 Apr 2025 20:21:43 +0200
Message-Id: <20250407182155.14925-5-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407182155.14925-1-michael@fossekall.de>
References: <20250407182155.14925-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Like the RTL8211F, the RTL8211E PHY supports up to three LEDs.
Add netdev trigger support for them, too.

Signed-off-by: Michael Klein <michael@fossekall.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/realtek/realtek_main.c | 125 +++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 0fcc57ad777f..9c3727a646f2 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -46,6 +46,20 @@
 #define RTL8211E_TX_DELAY			BIT(12)
 #define RTL8211E_RX_DELAY			BIT(11)
 
+#define RTL8211E_LEDCR_EXT_PAGE			0x2c
+
+#define RTL8211E_LEDCR1				0x1a
+#define RTL8211E_LEDCR1_ACT_TXRX		BIT(4)
+#define RTL8211E_LEDCR1_MASK			BIT(4)
+#define RTL8211E_LEDCR1_SHIFT			1
+
+#define RTL8211E_LEDCR2				0x1c
+#define RTL8211E_LEDCR2_LINK_1000		BIT(2)
+#define RTL8211E_LEDCR2_LINK_100		BIT(1)
+#define RTL8211E_LEDCR2_LINK_10			BIT(0)
+#define RTL8211E_LEDCR2_MASK			GENMASK(2, 0)
+#define RTL8211E_LEDCR2_SHIFT			4
+
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
@@ -62,7 +76,8 @@
 #define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
 #define RTL8211F_LEDCR_SHIFT			5
 
-#define RTL8211F_LED_COUNT			3
+/* RTL8211E and RTL8211F support up to three LEDs */
+#define RTL8211x_LED_COUNT			3
 
 #define RTL8211F_TX_DELAY			BIT(8)
 #define RTL8211F_RX_DELAY			BIT(3)
@@ -137,6 +152,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
 }
 
+static int rtl8211e_read_ext_page(struct phy_device *phydev, u16 ext_page,
+				  u32 regnum)
+{
+	int oldpage, ret = 0;
+
+	oldpage = phy_select_page(phydev, RTL8211E_SET_EXT_PAGE);
+	if (oldpage >= 0) {
+		ret = __phy_write(phydev, RTL8211E_EXT_PAGE_SELECT, ext_page);
+		if (ret == 0)
+			ret = __phy_read(phydev, regnum);
+	}
+
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
 static int rtl8211e_modify_ext_page(struct phy_device *phydev, u16 ext_page,
 				    u32 regnum, u16 mask, u16 set)
 {
@@ -526,7 +556,7 @@ static int rtl821x_resume(struct phy_device *phydev)
 	return 0;
 }
 
-static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
+static int rtl8211x_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					unsigned long rules)
 {
 	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK_10) |
@@ -545,9 +575,11 @@ static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
 	 *      rates and Active indication always at all three 10+100+1000
 	 *      link rates.
 	 * This code currently uses mode B only.
+	 *
+	 * RTL8211E PHY LED has one mode, which works like RTL8211F mode B.
 	 */
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	/* Filter out any other unsupported triggers. */
@@ -566,7 +598,7 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 {
 	int val;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	val = phy_read_paged(phydev, 0xd04, RTL8211F_LEDCR);
@@ -599,7 +631,7 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	const u16 mask = RTL8211F_LEDCR_MASK << (RTL8211F_LEDCR_SHIFT * index);
 	u16 reg = 0;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
@@ -622,6 +654,84 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	return phy_modify_paged(phydev, 0xd04, RTL8211F_LEDCR, mask, reg);
 }
 
+static int rtl8211e_led_hw_control_get(struct phy_device *phydev, u8 index,
+				       unsigned long *rules)
+{
+	int ret;
+	u16 cr1, cr2;
+
+	if (index >= RTL8211x_LED_COUNT)
+		return -EINVAL;
+
+	ret = rtl8211e_read_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
+				     RTL8211E_LEDCR1);
+	if (ret < 0)
+		return ret;
+
+	cr1 = ret >> RTL8211E_LEDCR1_SHIFT * index;
+	if (cr1 & RTL8211E_LEDCR1_ACT_TXRX) {
+		__set_bit(TRIGGER_NETDEV_RX, rules);
+		__set_bit(TRIGGER_NETDEV_TX, rules);
+	}
+
+	ret = rtl8211e_read_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
+				     RTL8211E_LEDCR2);
+	if (ret < 0)
+		return ret;
+
+	cr2 = ret >> RTL8211E_LEDCR2_SHIFT * index;
+	if (cr2 & RTL8211E_LEDCR2_LINK_10)
+		__set_bit(TRIGGER_NETDEV_LINK_10, rules);
+
+	if (cr2 & RTL8211E_LEDCR2_LINK_100)
+		__set_bit(TRIGGER_NETDEV_LINK_100, rules);
+
+	if (cr2 & RTL8211E_LEDCR2_LINK_1000)
+		__set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+
+	return ret;
+}
+
+static int rtl8211e_led_hw_control_set(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	const u16 cr1mask =
+		RTL8211E_LEDCR1_MASK << (RTL8211E_LEDCR1_SHIFT * index);
+	const u16 cr2mask =
+		RTL8211E_LEDCR2_MASK << (RTL8211E_LEDCR2_SHIFT * index);
+	u16 cr1 = 0, cr2 = 0;
+	int ret;
+
+	if (index >= RTL8211x_LED_COUNT)
+		return -EINVAL;
+
+	if (test_bit(TRIGGER_NETDEV_RX, &rules) ||
+	    test_bit(TRIGGER_NETDEV_TX, &rules)) {
+		cr1 |= RTL8211E_LEDCR1_ACT_TXRX;
+	}
+
+	cr1 <<= RTL8211E_LEDCR1_SHIFT * index;
+	ret = rtl8211e_modify_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
+				       RTL8211E_LEDCR1, cr1mask, cr1);
+	if (ret < 0)
+		return ret;
+
+	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+		cr2 |= RTL8211E_LEDCR2_LINK_10;
+
+	if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+		cr2 |= RTL8211E_LEDCR2_LINK_100;
+
+	if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+		cr2 |= RTL8211E_LEDCR2_LINK_1000;
+
+	cr2 <<= RTL8211E_LEDCR2_SHIFT * index;
+	ret = rtl8211e_modify_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
+				       RTL8211E_LEDCR2, cr2mask, cr2);
+
+	return ret;
+}
+
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
 	const u16 delay_mask = RTL8211E_CTRL_DELAY |
@@ -1398,6 +1508,9 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
+		.led_hw_control_get = rtl8211e_led_hw_control_get,
+		.led_hw_control_set = rtl8211e_led_hw_control_set,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc916),
 		.name		= "RTL8211F Gigabit Ethernet",
@@ -1411,7 +1524,7 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
 		.flags		= PHY_ALWAYS_CALL_SUSPEND,
-		.led_hw_is_supported = rtl8211f_led_hw_is_supported,
+		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
 		.led_hw_control_get = rtl8211f_led_hw_control_get,
 		.led_hw_control_set = rtl8211f_led_hw_control_set,
 	}, {
-- 
2.39.5


