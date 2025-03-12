Return-Path: <netdev+bounces-174322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6684EA5E49C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5ED7A69E9
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F5D2571A5;
	Wed, 12 Mar 2025 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="GPMEC+OE";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="zu2lOdpT"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9F2571A4;
	Wed, 12 Mar 2025 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808385; cv=pass; b=aZTF5cuHDbzyPor/tPcQdfxpfTRTm7K4EdVfCgUZuuRQgje8Tlg+xvcqF2EfUJ5NXYVtihmweVtkgWbw9JGDiqDZb+JD+/P3yNw2+G4OEz8BZZgpb8zdperjCVLA3BAQQcUP7XiyR/N6/z2kkRkzFqDGeJAP6HFdJIbnufOpFfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808385; c=relaxed/simple;
	bh=9LHZqETUxUNt66FmBa/3tY6eBPTCTvDIOse2AO2Y0p0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IyQRBuQxKzD+MLRIdBaKEROKIADskXlWFEy7xeo4O/O3/j+Wz6RDnbwpFbr6hIDhcu6MU497R1IFgh+78Vl7c1uAgwZo4w1m1LPcph9C+emdzOzMEBAio/RgfT9H59MgL5aytlOKKSWvAQ4c2nGIKG83pGlfLE8gIc7ciBVYAiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=GPMEC+OE; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=zu2lOdpT; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1741808195; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hkm5zCCyZ1rYRVi/To1srG9U5kTicMGyX7X78zkhfwBB3ISUjPA50rJ1+QnEfvHSR7
    6hNpX0KFRDZJjCnB/4ZA9vDYy+fuLlYoS5+FZ2c2t8Lb7x0kBzfRXXsByasSjuaqHMhb
    bSbs1NeA5+Baasvp1zMoUzkyqziOc73og2VsOCJ8b71nZtuok0T3qPaxzLZT6jnAsu3n
    zZgbc8mPOKgxLaXt+QpECS8Jasr7fXv5NIZ1MNbDt+bHRU1cO4a5nVXMKwhc1DedjnkB
    /o6GGKfWS+Sq29v9qKc2bLrPqzv4glGrjBjUo3eQtLwjX0zLdYcrCiO5acVi4bcw32p+
    xtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741808195;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rJ18HIBPB0es5ZImxh5nwXUc5nhaYpMnoN95dARg6r8=;
    b=GcKD6HMxV2CAVmC24bdjbsQ72lG5so9a1UyZrrmpcRRfqThI3UPaLZbuMcjP+OS2jy
    yU4dkpsTMvkBUnuIvOjxf+IF3agndRGQ+QLoyUOqgv0xOcWp2zH79szFD2DAva0jASOZ
    s9QvxBlx80uQ72iYxgDnVDnXkzzuCPUACUJOq61ujZG+KnopqxMaUpGo676RmIDln/yj
    XKMIwN8D4Yx962holo5mFXpFrjJ9uryX+FZrgmpwbRxSCTFuyaq9JHntxiT3u8fppOay
    0lFr2FF8JAq2Ustt8nv62GyOEksANK+KLw56XcDcQfylJ3Z0ED48OONhZzRrWzYjZlq8
    xq4A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741808195;
    s=strato-dkim-0002; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rJ18HIBPB0es5ZImxh5nwXUc5nhaYpMnoN95dARg6r8=;
    b=GPMEC+OEgh7iByF/dwcd0+gdvsAM1kr67+NRNkfgah7WcSV5LAK/rjT4y/ErWBoSSc
    y3MX1btmZEbtg+3sd3c04vDgwlP1Z5+QL2YLPepAIqNq+yxhs4iWDwTWiolk91RLFHDk
    /+QMHjvQ2lxm9Cl3oMfj5gWQe+NIt1OrpfyUzZkqhYha/v3vkxXAoH4DWeBU5G9HRryM
    8nlwiJpU1EvFxlMlxKEh9YedSmaWvv33oN8bIllkGOd9WXt7ZRYsD2R88uUEB2hPUZjy
    k9SSxjFPveUUvEYldn1fcGZuRS9wiuTBjZVvFR+qJFFuybBsSTcqRNb1rhrfGEaHVt1H
    gQLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741808195;
    s=strato-dkim-0003; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rJ18HIBPB0es5ZImxh5nwXUc5nhaYpMnoN95dARg6r8=;
    b=zu2lOdpTMwUVluCguSNe9Ifi9MkEMR6a11Xxf76Uzr/nyd9BswQEso+Yw484gQfWil
    tHQfE/CBYYXm8v0SRpDQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512CJaZkg4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 12 Mar 2025 20:36:35 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1tsRsY-00057w-00;
	Wed, 12 Mar 2025 20:36:34 +0100
Received: (nullmailer pid 85443 invoked by uid 502);
	Wed, 12 Mar 2025 19:36:33 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: phy: realtek: Add support for PHY LEDs on RTL8211E
Date: Wed, 12 Mar 2025 20:36:27 +0100
Message-Id: <20250312193629.85417-1-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
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
---
 drivers/net/phy/realtek.c | 120 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 166f6a728373..906640d6dca5 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -52,6 +52,18 @@
 #define RTL8211E_TX_DELAY			BIT(12)
 #define RTL8211E_RX_DELAY			BIT(11)
 
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
 #define RTL8211F_CLKOUT_EN			BIT(0)
 
 #define RTL8201F_ISR				0x1e
@@ -96,7 +108,8 @@
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 
-#define RTL8211F_LED_COUNT			3
+/* RTL8211E and RTL8211F support up to three LEDs */
+#define RTL8211x_LED_COUNT			3
 
 MODULE_DESCRIPTION("Realtek PHY driver");
 MODULE_AUTHOR("Johnson Leung");
@@ -487,7 +500,7 @@ static int rtl821x_resume(struct phy_device *phydev)
 	return 0;
 }
 
-static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
+static int rtl8211x_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					unsigned long rules)
 {
 	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK_10) |
@@ -506,9 +519,11 @@ static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
 	 *      rates and Active indication always at all three 10+100+1000
 	 *      link rates.
 	 * This code currently uses mode B only.
+	 *
+	 * RTL8211E PHY LED has one mode, which works like RTL8211F * mode B.
 	 */
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	/* Filter out any other unsupported triggers. */
@@ -527,7 +542,7 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 {
 	int val;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	val = phy_read_paged(phydev, 0xd04, RTL8211F_LEDCR);
@@ -560,7 +575,7 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	const u16 mask = RTL8211F_LEDCR_MASK << (RTL8211F_LEDCR_SHIFT * index);
 	u16 reg = 0;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
@@ -583,6 +598,96 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	return phy_modify_paged(phydev, 0xd04, RTL8211F_LEDCR, mask, reg);
 }
 
+static int rtl8211e_led_hw_control_get(struct phy_device *phydev, u8 index,
+				       unsigned long *rules)
+{
+	int oldpage, ret;
+	u16 cr1, cr2;
+
+	if (index >= RTL8211x_LED_COUNT)
+		return -EINVAL;
+
+	oldpage = phy_select_page(phydev, 0x7);
+	if (oldpage < 0)
+		goto err_restore_page;
+
+	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0x2c);
+	if (ret)
+		goto err_restore_page;
+
+	cr1 = ret = __phy_read(phydev, RTL8211E_LEDCR1);
+	if (ret < 0)
+		goto err_restore_page;
+
+	cr1 >>= RTL8211E_LEDCR1_SHIFT * index;
+	if (cr1 & RTL8211E_LEDCR1_ACT_TXRX) {
+		set_bit(TRIGGER_NETDEV_RX, rules);
+		set_bit(TRIGGER_NETDEV_TX, rules);
+	}
+
+	cr2 = ret = __phy_read(phydev, RTL8211E_LEDCR2);
+	if (ret < 0)
+		goto err_restore_page;
+
+	cr2 >>= RTL8211E_LEDCR2_SHIFT * index;
+	if (cr2 & RTL8211E_LEDCR2_LINK_10)
+		set_bit(TRIGGER_NETDEV_LINK_10, rules);
+
+	if (cr2 & RTL8211E_LEDCR2_LINK_100)
+		set_bit(TRIGGER_NETDEV_LINK_100, rules);
+
+	if (cr2 & RTL8211E_LEDCR2_LINK_1000)
+		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+
+err_restore_page:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
+static int rtl8211e_led_hw_control_set(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	const u16 cr1mask = RTL8211E_LEDCR1_MASK << (RTL8211E_LEDCR1_SHIFT * index);
+	const u16 cr2mask = RTL8211E_LEDCR2_MASK << (RTL8211E_LEDCR2_SHIFT * index);
+	u16 cr1 = 0, cr2 = 0;
+	int oldpage, ret;
+
+	if (index >= RTL8211x_LED_COUNT)
+		return -EINVAL;
+
+	oldpage = phy_select_page(phydev, 0x7);
+	if (oldpage < 0)
+		goto err_restore_page;
+
+	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0x2c);
+	if (ret)
+		goto err_restore_page;
+
+	if (test_bit(TRIGGER_NETDEV_RX, &rules) ||
+	    test_bit(TRIGGER_NETDEV_TX, &rules)) {
+		cr1 |= RTL8211E_LEDCR1_ACT_TXRX;
+	}
+
+	cr1 <<= RTL8211E_LEDCR1_SHIFT * index;
+	ret = __phy_modify(phydev, RTL8211E_LEDCR1, cr1mask, cr1);
+	if (ret < 0)
+		goto err_restore_page;
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
+	ret = __phy_modify(phydev, RTL8211E_LEDCR2, cr2mask, cr2);
+
+err_restore_page:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
 	int ret = 0, oldpage;
@@ -1296,6 +1401,9 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
+		.led_hw_control_get = rtl8211e_led_hw_control_get,
+		.led_hw_control_set = rtl8211e_led_hw_control_set,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc916),
 		.name		= "RTL8211F Gigabit Ethernet",
@@ -1309,7 +1417,7 @@ static struct phy_driver realtek_drvs[] = {
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


