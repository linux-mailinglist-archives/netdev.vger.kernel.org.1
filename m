Return-Path: <netdev+bounces-175436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38EFA65EB4
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BFD174359
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B391E833B;
	Mon, 17 Mar 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="EQHBC3db";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="iXfLs/m6"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D721F583E;
	Mon, 17 Mar 2025 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241951; cv=pass; b=laOZ4HCB9soEVf4tSsF6Xwm1k/E1Ou87Wj5ATUgl3ALGifPKaaTPWxsAQ4NbD2RnwOJZhBRhUl/6hxYC5Pvnv4mKOEAEBCgIBM214AmCCRG81vtbkugCrlkj/XLABAb6nGZ5RJruVaFKSNM/9z/EfOW6fhoxY1yjK8K/2s/58Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241951; c=relaxed/simple;
	bh=j7KP1PHA4NUdJk5rdZIR8Mmf4Wtmm5IuG6EQoFm9cQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGeX/biNIc0V7xRc78vfVZfK5aZKouDUSY7lt/Pt4TFJOFXuP+3cS8NQF9Z6ENOtlxIbW3E0A68SwF1o9e3cTm3M8L3oLPicYGuLs76gOoqyV48LeJqMJbWkLk198UydojuiEN3/hZ3h6chupOi4hyP/zXamwdhGTD57qkUZKXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=EQHBC3db; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=iXfLs/m6; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1742241940; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Jtc6m1y8W/RdTLYTgDqN5SkmTijOAe9ZyevzL8tnDvQOMUwLjqEa8ehNu6BSzkFQNN
    YqbCLU8VCwSS0vzYv/94ebUUAki8pI0nZDULRdQxwgOcizQQjagPltAktdmUgC7n7EhM
    qmWsxvrCQlpbqK5wh0IivHCgXRu8r2chTn4UF6art/Pe52g9BjUinmrrzd5cUPvMzhKO
    qdQQquHbta/YoEr09eUOK9N0q6V6t81naciZh+l+20bl2Q654i5KyVHR2o/sHlruOky4
    gKrxqqvylFp0/QYD3iN9EQI3wDxnh4JEHIidvLaqBsCgBeyPKQtn7s8KF+iKGdrvLzg2
    Qtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742241940;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hWqgTBaP+ZomcWG8WO+zlFwfylXLSfH6hkDPg0uRmuw=;
    b=DmxO8Xx7jj1fCsg9SC2kqcs/Rxvc6Z+jPwXTdj4LbAikkHPu6leWMiWKj3WepgFZEe
    pwi7hja30kv4FPHVx6OZGtAWYRHijRUDuYF2IKLnImK5oOnF9cCPPRVyqHpIxyyBvHp9
    7keAHRb9RF4SGImwUbb/o75hBzdZs+CYcgyBqmSGAmIAEudyEJ3n5aDxDFPC1E/l5BWD
    bWVdiicqWDIO52ho2g34/Vk7MRl9tJAGcy7vh3g/dNYhbb1RvjRWadCAAxUr0JooxVD3
    rPqBA1efqhCxLNiMYFB0pSgJpMMJPTLEha3NSPi1slx5XzQWFgAm42J2zUteQVGTilY6
    gIhA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742241940;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hWqgTBaP+ZomcWG8WO+zlFwfylXLSfH6hkDPg0uRmuw=;
    b=EQHBC3dbz9IaVGQmwRMAVuN1Z08GBcei9t4nxUyVlQ8Pq9SPEg9i6JLcO/KrW4ZZz/
    ZdEvG6jnrWIstIXgKJHnjKOjRkbp6GRlmrO8XuEbqr4GdXb2jV4jIMc4ONRrPt3lLhhk
    2FGa+bZkra6yJkmmY5Etn66jDYHe2ltuXF91E+rQ2sdtOKJPhLvEAfZqQXb20LQZA0Jk
    6jlGHs2cfDN27koET6ttXQGM3S8Dla0fkCjS/QhsLqCTDd9j/lOSEXd+IGSAql8wwahf
    Dr4NkGn9dOqvQT7skJ5TdC46YYTgfqeljV/NvGst/U/apyE6sdxZUlUSLqx4Mkuq82Yp
    wlmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742241940;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hWqgTBaP+ZomcWG8WO+zlFwfylXLSfH6hkDPg0uRmuw=;
    b=iXfLs/m6PXHvkqXO6p2dG1WmYkcj/HLc4XQXneVPAEh3x1P2NB55xSVf3lc82ttTTp
    mHthIOqgivTWgdwYEYBw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512HK5eG01
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Mar 2025 21:05:40 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1tuGiP-000862-32;
	Mon, 17 Mar 2025 21:05:37 +0100
Received: (nullmailer pid 93694 invoked by uid 502);
	Mon, 17 Mar 2025 20:05:37 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v4 3/3] net: phy: realtek: Add support for PHY LEDs on RTL8211E
Date: Mon, 17 Mar 2025 21:05:32 +0100
Message-Id: <20250317200532.93620-4-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317200532.93620-1-michael@fossekall.de>
References: <20250317200532.93620-1-michael@fossekall.de>
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
 drivers/net/phy/realtek/realtek_main.c | 125 +++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index ccef7c01ccc4..86dd3e17317b 100644
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
@@ -136,6 +151,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
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
@@ -519,7 +549,7 @@ static int rtl821x_resume(struct phy_device *phydev)
 	return 0;
 }
 
-static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
+static int rtl8211x_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					unsigned long rules)
 {
 	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK_10) |
@@ -538,9 +568,11 @@ static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
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
@@ -559,7 +591,7 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 {
 	int val;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	val = phy_read_paged(phydev, 0xd04, RTL8211F_LEDCR);
@@ -592,7 +624,7 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	const u16 mask = RTL8211F_LEDCR_MASK << (RTL8211F_LEDCR_SHIFT * index);
 	u16 reg = 0;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
@@ -615,6 +647,84 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
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
@@ -1390,6 +1500,9 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
+		.led_hw_control_get = rtl8211e_led_hw_control_get,
+		.led_hw_control_set = rtl8211e_led_hw_control_set,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc916),
 		.name		= "RTL8211F Gigabit Ethernet",
@@ -1403,7 +1516,7 @@ static struct phy_driver realtek_drvs[] = {
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


