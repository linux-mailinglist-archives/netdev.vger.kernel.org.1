Return-Path: <netdev+bounces-187648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2602AA8899
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8160318990AC
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471D51F12FA;
	Sun,  4 May 2025 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="syiaYLbC";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="VKRRSBm2"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41EB1EEA39;
	Sun,  4 May 2025 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379960; cv=pass; b=KsNuKMWwZLGpNClJf5PJw2zCx6JV4yBkrp6Zhmb0q8GXYjhubDqDofZs5qrPMDbFTfhGjDyTyTjs84PY0I+XzcBVMJ6BGf/rOQZqULdimnaSXs6xEvk0S6r2ozZN2H/KaRUvxWHLj+AsdRtmDBj35SfZgrc4HNKNjT2NwPDT97k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379960; c=relaxed/simple;
	bh=CGq95FFCitrDU4kSl80FyMm3qcIAzLYe4OPJEcok9ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLquSytpvxB0U95WtjO5aJHMntYSos+Lc/AdLCEuRJ4cEkOGq52MoMDzwtyJLZjVCkNgZJ098IjZcvVijJMkCIXa43XRi/enWelwIXN8W9ffABUURxZtHJ/YpOhSG1bGOlpJU1WBVMmjcrvqf4e3HTh8328phytUtGLbGnnlZDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=syiaYLbC; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=VKRRSBm2; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1746379774; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kPOmm7elWmM0zs9YKe0mxTNWb5w+qYBlPgdf+57ZjMBXhjMvzuMjrE3aI5KstUSwck
    rfNstgoe+pUJo/DSXYNmKgXW0PfBD1fXc4ZcKS8MYbj7oBYU3pGPBNYkH1rS+M6VSp5Y
    bgqOnv1yl8n4sJnM00sgapL/GL4kZwSRQi3nmwwsKqWh7g0c3dmu+iHj7SMiWd3MkriT
    ysIzosHXC00b5kza/TS1sGEPVRpLRMnjizy3BBXWPdgZexmiC5NmjG69TSSc9oRPfbxU
    YPhEtieqzDmQSn9z66Ojlfpocirsn6azSlDEfIhwt1fJE89fuPrq/8FwgzNWNJTAcZWF
    6tdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379774;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PaEoVQlznhi9pCpWZbxcLxQZGvCFQ3YD/uDLUZg5VWE=;
    b=dmKvPiIf+wayGcgJoG5MxAdWYWz4JwRZwcyQ7GR/VC/eQ678RzZEqyGMvEdSRcyTNL
    fqFSU4+tHKLLSw5N3gvheXJARjWKHEMNaVBfQrAl0qVRpicZJJBk7PJE2iO76XZrrS4n
    /O1tHk7crJrIWBocBlHl4bhEIPa/hFz84fGCp+vKDMxu/jSz4mPIWUeAhrRxJRXsHEKC
    zu3RvN7EMKH4UHrkz+D98sW2TtzkjOag7bSeCSg64yqjxBKQg+UbiABLQzo58Fyg0X8v
    opwu3S4TiThoNm0443lbFUachdpjVKadNABy8A572nokUGoKFpGxwxsA/jbH2h33i9FK
    TX6Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379774;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PaEoVQlznhi9pCpWZbxcLxQZGvCFQ3YD/uDLUZg5VWE=;
    b=syiaYLbC5mNqfNKfiGgrsRD5F1NY4edjPEXGQf2BadLt53QjWg1dCyKzd5bRmO2Nav
    +C8hJpNv82mWZIffqCUo0DVE4hKgbsUkCAYPY5YhUHpy3Mfkqbv78fmGnZunHTwkBK5y
    FkwUU4MQbK+qPowm06OVRO/QKMokoqyzJDEKa0KbIF9BivTd2bLxCB27XCVUC0vSi0BY
    HmAUv3GDWMgkpM89pG4MWHk7MX40l+3jV0Tr7nZqbi0skPFpJZHfXiImPvhmOFrfe6Rl
    pUrY8HlZkjEWiWX3k918Ss7Np9Bk3FdbxYxv4ZbIqR9EGCpwXa07MT46jUy+lMUWCu77
    5qRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746379774;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PaEoVQlznhi9pCpWZbxcLxQZGvCFQ3YD/uDLUZg5VWE=;
    b=VKRRSBm2kG0JkyaLwjUnEtyYGj1Mw/pTclG703uQTenmfp21fwFBoWpajBvswRGgX7
    slKdibBluGkEnZFjZ1Cg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35144HTYz9L
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 4 May 2025 19:29:34 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1uBd9g-0004Or-2w;
	Sun, 04 May 2025 19:29:32 +0200
Received: (nullmailer pid 243306 invoked by uid 502);
	Sun, 04 May 2025 17:29:32 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v7 6/6] net: phy: realtek: Add support for PHY LEDs on RTL8211E
Date: Sun,  4 May 2025 19:29:16 +0200
Message-Id: <20250504172916.243185-7-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250504172916.243185-1-michael@fossekall.de>
References: <20250504172916.243185-1-michael@fossekall.de>
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
index e26098a2ff27..301fbe141b9b 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -40,6 +40,20 @@
 #define RTL821x_PAGE_SELECT			0x1f
 #define RTL821x_SET_EXT_PAGE			0x07
 
+/* RTL8211E extension page 44/0x2c */
+#define RTL8211E_LEDCR_EXT_PAGE			0x2c
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
 /* RTL8211E extension page 164/0xa4 */
 #define RTL8211E_RGMII_EXT_PAGE			0xa4
 #define RTL8211E_RGMII_DELAY			0x1c
@@ -145,7 +159,8 @@
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 
-#define RTL8211F_LED_COUNT			3
+/* RTL8211E and RTL8211F support up to three LEDs */
+#define RTL8211x_LED_COUNT			3
 
 MODULE_DESCRIPTION("Realtek PHY driver");
 MODULE_AUTHOR("Johnson Leung");
@@ -169,6 +184,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
 }
 
+static int rtl821x_read_ext_page(struct phy_device *phydev, u16 ext_page,
+				 u32 regnum)
+{
+	int oldpage, ret = 0;
+
+	oldpage = phy_select_page(phydev, RTL821x_SET_EXT_PAGE);
+	if (oldpage >= 0) {
+		ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, ext_page);
+		if (ret == 0)
+			ret = __phy_read(phydev, regnum);
+	}
+
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
 static int rtl821x_modify_ext_page(struct phy_device *phydev, u16 ext_page,
 				   u32 regnum, u16 mask, u16 set)
 {
@@ -608,7 +638,7 @@ static int rtl821x_resume(struct phy_device *phydev)
 	return 0;
 }
 
-static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
+static int rtl8211x_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					unsigned long rules)
 {
 	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK_10) |
@@ -627,9 +657,11 @@ static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
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
@@ -648,7 +680,7 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 {
 	int val;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	val = phy_read_paged(phydev, 0xd04, RTL8211F_LEDCR);
@@ -681,7 +713,7 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	const u16 mask = RTL8211F_LEDCR_MASK << (RTL8211F_LEDCR_SHIFT * index);
 	u16 reg = 0;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
@@ -704,6 +736,84 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
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
+	ret = rtl821x_read_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
+				    RTL8211E_LEDCR1);
+	if (ret < 0)
+		return ret;
+
+	cr1 = ret >> RTL8211E_LEDCR1_SHIFT * index;
+	if (cr1 & RTL8211E_LEDCR1_ACT_TXRX) {
+		__set_bit(TRIGGER_NETDEV_RX, rules);
+		__set_bit(TRIGGER_NETDEV_TX, rules);
+	}
+
+	ret = rtl821x_read_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
+				    RTL8211E_LEDCR2);
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
+	ret = rtl821x_modify_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
+				      RTL8211E_LEDCR1, cr1mask, cr1);
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
+	ret = rtl821x_modify_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
+				      RTL8211E_LEDCR2, cr2mask, cr2);
+
+	return ret;
+}
+
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
 	u16 val;
@@ -1479,6 +1589,9 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
+		.led_hw_control_get = rtl8211e_led_hw_control_get,
+		.led_hw_control_set = rtl8211e_led_hw_control_set,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc916),
 		.name		= "RTL8211F Gigabit Ethernet",
@@ -1494,7 +1607,7 @@ static struct phy_driver realtek_drvs[] = {
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


