Return-Path: <netdev+bounces-181507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAB6A85417
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216687B29E5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7D427CCCF;
	Fri, 11 Apr 2025 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="tTyJVGz7";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="5RXs4eJG"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEDC27CB36;
	Fri, 11 Apr 2025 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352690; cv=pass; b=W9butUd13xPFndbWF6OQrORhP4KheVa0mpDktArYUz/DAxaGE72utlPPDFeLkgpcqv841/kyPbsw46vk8rpk0QtrK2dw/o2NlvOikuYf0cMY1KTaZhrNaKnAfA161QxlnfIf7xxlP82E88QNkzYrPHWmU8aEeW4ixAAfgfj5Lyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352690; c=relaxed/simple;
	bh=l+I6yaZDQZFzU/0lOna1bxv1XefK864QEYTNwA/sEjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7JDKJfFs0Jvk6HXBitiAPa6vFY5dG82U7ZStwVJaOTDjnMNTGAZp4Adi0twvM5TtqHmuIvPsOoyZHU607QE6uhj0ElMATdlienD4i0qUp8bNTCOPUBj9rW8VvvPhrXH8nUECQzcdYJeMuELfFq2r3iIY3UuvIgGl17fE2PmbNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=tTyJVGz7; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=5RXs4eJG; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744352677; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kk0uNfbOtzMQ8ForAz8b6Lt/k7bXB2s+CHd+GpQDCe/NYJj/UwpebXwIf7+SDf1Sln
    rKXllh6RCHYpgQ9GCO8W3NOvdFImzdNhcO5siWFpYo5AVXhRbIIJbH2nlVpEG4iOBzQo
    1zL7P0UlJxacWXWM/ZponojxCyMy9Q6Ws9mESn3SDVou74RTaq7//Gx3opZPRej2+D2z
    d0mXCHHxcDoFXrsy4NhsnSczLMVPcquw2ZkIaUOlcRil43UyCTQxUeIUOCn9DYRxd9mj
    krTf8fwLKJX09Bc+Wl2UCN9pbdA/b2dJ7416kAUGZMhwnxAqC6hRqJa9UXdUqNXZ6eAj
    ajBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744352677;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GOW7EgaK4eTMqPSWF+IPv4cYDIseNc2HtpiUiSUFm3M=;
    b=Bwf0n1nwuy9C2bPDdtFB7XDkyD7Y2l8tr5jxEyngd1RHklsQvVeuQLLv/dyXEGQUrX
    4/o0L9fz72wpvGbt9SCyn1+6lQ/MUS5FX//rte+HXbwZjwc8MB+aoXT5VD3djt6UeWu2
    vFAn7agjASgCj5bRWVOVNl2i5qtfDTVmRL6gSDwFQniqeyWDfdKRol4baHjZPfM8Ssau
    iik9fux553Ec7Wbtdmz74qHHI0KL0tNIqNeiOl33CXnT29cz8Jeg2npgJE+JlvXVhTVx
    2YQ7NXz+zhLn2mN5X2SlBfXjEBDDA8hWoY9JafGxSYGwV/TMdMqq+HKvvIeFQM2x/D1v
    loqA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744352677;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GOW7EgaK4eTMqPSWF+IPv4cYDIseNc2HtpiUiSUFm3M=;
    b=tTyJVGz7GWMYjq9wJD/2fFLB6QiD1iKe11NQGviPtWNAN7Nxf3xe5FEjGlnzwIcdt4
    ogUPqsDhymWtwjgchgmXuy5U390bqd5cbhg3AWmmPmYUrRR91I+O8YDwh2wEtHsGdUiM
    2Y0DyJZho4xicql8ZYuogPAkO2g4aT4nywdahux1G6L+BE577GH+pWxYAUUzLK8XHaEk
    uRv145FqR4eLGNGnI8ynrnQWj1KxLzdwrwlJ1uocPEKxSoKRYrG16WxfipLqMQXslheC
    xSDOZy3gWC6fzj2B+i4J5YTMHludKCEJh0jft5xkY9ek04bbHVq/f0UUozVpPekCVLJB
    7vVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744352677;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GOW7EgaK4eTMqPSWF+IPv4cYDIseNc2HtpiUiSUFm3M=;
    b=5RXs4eJGxZJMKw39+mgUX5pGHyDtJPTiHknySH+W7L4dA8eseQrQ1Fgi5oA0Xk8swu
    ZpcW2eZVhQsTm7A7DIAw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3513B6ObHae
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 11 Apr 2025 08:24:37 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1u37oa-0000Nm-2r;
	Fri, 11 Apr 2025 08:24:36 +0200
Received: (nullmailer pid 8911 invoked by uid 502);
	Fri, 11 Apr 2025 06:24:36 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v6 4/4] net: phy: realtek: Add support for PHY LEDs on RTL8211E
Date: Fri, 11 Apr 2025 08:24:26 +0200
Message-Id: <20250411062426.8820-5-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411062426.8820-1-michael@fossekall.de>
References: <20250411062426.8820-1-michael@fossekall.de>
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
index cf310cc90b97..a37be6b4e9f4 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -50,6 +50,20 @@
 #define RTL8211E_RX_DELAY			BIT(11)
 #define RTL8211E_DELAY_MASK			GENMASK(13, 11)
 
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
@@ -66,7 +80,8 @@
 #define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
 #define RTL8211F_LEDCR_SHIFT			5
 
-#define RTL8211F_LED_COUNT			3
+/* RTL8211E and RTL8211F support up to three LEDs */
+#define RTL8211x_LED_COUNT			3
 
 #define RTL8211F_TX_DELAY			BIT(8)
 #define RTL8211F_RX_DELAY			BIT(3)
@@ -141,6 +156,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
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
@@ -530,7 +560,7 @@ static int rtl821x_resume(struct phy_device *phydev)
 	return 0;
 }
 
-static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
+static int rtl8211x_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					unsigned long rules)
 {
 	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK_10) |
@@ -549,9 +579,11 @@ static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
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
@@ -570,7 +602,7 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 {
 	int val;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	val = phy_read_paged(phydev, 0xd04, RTL8211F_LEDCR);
@@ -603,7 +635,7 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	const u16 mask = RTL8211F_LEDCR_MASK << (RTL8211F_LEDCR_SHIFT * index);
 	u16 reg = 0;
 
-	if (index >= RTL8211F_LED_COUNT)
+	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
 	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
@@ -626,6 +658,84 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
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
 	u16 val;
@@ -1401,6 +1511,9 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
+		.led_hw_control_get = rtl8211e_led_hw_control_get,
+		.led_hw_control_set = rtl8211e_led_hw_control_set,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc916),
 		.name		= "RTL8211F Gigabit Ethernet",
@@ -1414,7 +1527,7 @@ static struct phy_driver realtek_drvs[] = {
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


