Return-Path: <netdev+bounces-174844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB3A60FAE
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A67178DA7
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352D1E8338;
	Fri, 14 Mar 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="OaIYWObV";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="PwRuUiXy"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F092AF1D;
	Fri, 14 Mar 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951008; cv=pass; b=tAuWu3aPKOnOhG3dhWG8lJZ+CIoeGGj3A+YOmy3W5JjYkZtyUckCVF3e73EwBMi6b5/CWtdDKTkFEgHV5VTRevQok4qP7/SC2+AqjHmx8JpBTbt6glsKaNplg+e4Uq8ytcP8eC3JWBCLhn56Hv9RYNQqfVfY+b/GyxjpRU8cv+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951008; c=relaxed/simple;
	bh=Y+P/W072JJIsNKDvE9Rhk/SEbvtNpoIYndiNevJ94Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAPeUb+Sp12MO0Ne+M0R8J33a7HZhk4iOXawWmM/M4iuDDyfWkQ12GrASc1vfU+tcqAo48C/HtJWf7XWbB/XWLilM0kcMuZ6E27ozvG8JegC/SRjzSJSFfCgI40DXL3T0tppGCZVayT666d3+OtqUbXjJEg6IX5CAta9gDope/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=OaIYWObV; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=PwRuUiXy; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1741951001; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ool5veCsj6mh0euAIzzgodN/aWwCxcIzqXcFgGxgFR583Z1bSLHR+W57I0e4FobRp/
    WapLPaUXR7m6j8oT2vNq50j2WSSS4OXeq/qP2rjVDJaUdOhRpafjxcnPnhcellDdLfdT
    k3oYeNUh9Q/9cuVT1Jg8epo1+4gbpffxK3pv6gfX/Oprre8Ro2tXrQcJ2aZbMbFUh4BH
    rMZLt4aAorZDEXBhFXKGyRr/T0oju7OUZoY1LMQrYfnLPoHQNxMq6f0kXjyK++Hc+c5C
    tbEhsayrDv5v4b7RkURlTZr59B/K0L1ULYTy7Tp/g1Mpc5pst1Ouzb62QhQXduJiS+gk
    RE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741951001;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DB6vKemOe/bk+9eGpBMhPX4GaOKT7vUnTvDqhO8T5mY=;
    b=X46gtomKaW3hW+DOHc2npBb6d1p+EBwkanRwg/vRC0ZoSroD1pU/kzZYJpE28dl0IX
    ckjsM/OgH/SKUbNDHAYupP+2WV+9FikXeChHOE8KRX+H5BcRTf4YYWsDcln6MZsYgXle
    ekxdfj3SGJGjF+bY2biVWpJaXhCrFCJYP02Qo5TUiE8jHoP/VbaxHCuBWVWw8MGeOjPD
    XWuN4plX8JT2Ae60wHpb21kBqLm/MXhktcyIyRfHO6rlZRMTaj9uV1JY29Iz0TrBYGso
    7Gy+DVlHi4aSes6Eg2xyWYOICwaykE4XQb3I5W/bY7oCC/CBFK3Hnl3UVn2mtlBg1ggb
    mfDQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741951001;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DB6vKemOe/bk+9eGpBMhPX4GaOKT7vUnTvDqhO8T5mY=;
    b=OaIYWObV6v8G6JABuOlye+QKOmMO1j6eZafJE2QAdTNVnL2/EPnvbBI0NWKgA9RLAC
    vIJJNH0Ip4nHfJ1Jou0QEG4vnyy/shqnmqZLwGn2bCl/v8S5aWetuO8vHFOhsL0hX+54
    jMtsmP7tet6m0OPtdMsiFtJ1VV7A2SYSvihME/iEMKSkFoYgsr5lcXmXini/rymHUonA
    wzxN/7JvyjOzJ5zbXSoGpWmDsjI+7oKqN/Q1Pg+oVjePZMSKBFl9LJNyMvpi9lt0aBgl
    aqgBO4tGs7Nc+BoaLUnXPWq6FlF6LNggbaswRSAC4ck7N2ousdbwio1atxdmP0xIEM1p
    Jwqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741951001;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DB6vKemOe/bk+9eGpBMhPX4GaOKT7vUnTvDqhO8T5mY=;
    b=PwRuUiXytdzmvE09G/4EVbbpK4bxuBld7/iDgKoXhvuaOu2cjNzfN6WVp8wrTujtOH
    Z0gM8qkhFAI0yAyofuDQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512EBGfts6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 14 Mar 2025 12:16:41 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1tt31s-0000Ix-1D;
	Fri, 14 Mar 2025 12:16:40 +0100
Received: (nullmailer pid 84477 invoked by uid 502);
	Fri, 14 Mar 2025 11:16:40 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next,v2,2/2] net: phy: realtek: Add support for PHY LEDs on RTL8211E
Date: Fri, 14 Mar 2025 12:15:45 +0100
Message-Id: <20250314111545.84350-3-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314111545.84350-1-michael@fossekall.de>
References: <20250314111545.84350-1-michael@fossekall.de>
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
 drivers/net/phy/realtek/realtek_main.c | 106 +++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index abea2291b0f4..ade265cc13f3 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -37,6 +37,20 @@
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
 #define RTL8211F_INSR				0x1d
@@ -113,7 +127,8 @@
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 
-#define RTL8211F_LED_COUNT			3
+/* RTL8211E and RTL8211F support up to three LEDs */
+#define RTL8211x_LED_COUNT			3
 
 MODULE_DESCRIPTION("Realtek PHY driver");
 MODULE_AUTHOR("Johnson Leung");
@@ -534,7 +549,7 @@ static int rtl821x_resume(struct phy_device *phydev)
 	return 0;
 }
 
-static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
+static int rtl8211x_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					unsigned long rules)
 {
 	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK_10) |
@@ -553,9 +568,11 @@ static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
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
@@ -574,7 +591,7 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 {
 	int val;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	val = phy_read_paged(phydev, 0xd04, RTL8211F_LEDCR);
@@ -607,7 +624,7 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	const u16 mask = RTL8211F_LEDCR_MASK << (RTL8211F_LEDCR_SHIFT * index);
 	u16 reg = 0;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
@@ -630,6 +647,80 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
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
+	ret = rtl8211e_read_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE, RTL8211E_LEDCR1);
+	if (ret < 0)
+		return ret;
+
+	cr1 = ret >> RTL8211E_LEDCR1_SHIFT * index;
+	if (cr1 & RTL8211E_LEDCR1_ACT_TXRX) {
+		set_bit(TRIGGER_NETDEV_RX, rules);
+		set_bit(TRIGGER_NETDEV_TX, rules);
+	}
+
+	ret = rtl8211e_read_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE, RTL8211E_LEDCR2);
+	if (ret < 0)
+		return ret;
+
+	cr2 = ret >> RTL8211E_LEDCR2_SHIFT * index;
+	if (cr2 & RTL8211E_LEDCR2_LINK_10)
+		set_bit(TRIGGER_NETDEV_LINK_10, rules);
+
+	if (cr2 & RTL8211E_LEDCR2_LINK_100)
+		set_bit(TRIGGER_NETDEV_LINK_100, rules);
+
+	if (cr2 & RTL8211E_LEDCR2_LINK_1000)
+		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+
+	return ret;
+}
+
+static int rtl8211e_led_hw_control_set(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	const u16 cr1mask = RTL8211E_LEDCR1_MASK << (RTL8211E_LEDCR1_SHIFT * index);
+	const u16 cr2mask = RTL8211E_LEDCR2_MASK << (RTL8211E_LEDCR2_SHIFT * index);
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
@@ -1405,6 +1496,9 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
+		.led_hw_control_get = rtl8211e_led_hw_control_get,
+		.led_hw_control_set = rtl8211e_led_hw_control_set,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc916),
 		.name		= "RTL8211F Gigabit Ethernet",
@@ -1418,7 +1512,7 @@ static struct phy_driver realtek_drvs[] = {
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


