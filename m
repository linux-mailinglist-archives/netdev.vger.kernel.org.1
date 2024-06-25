Return-Path: <netdev+bounces-106661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA491729D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8493DB222A4
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666AC17D88C;
	Tue, 25 Jun 2024 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ahSB2cYR"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FCE4C6E;
	Tue, 25 Jun 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348157; cv=none; b=i6u8Xlm05GkFn0CWf40nhWW8eC8pnbOXyP7iVkaTjfJs+FMO8FwOI2TqwadwjhfIzMPnR5/rvAu5zofdlb7c12wvBGQojyWknI7Y9Y5MSY0WNdrEydiX9smWuujZGohF3000BQkbRSUSmdRP5oQBfEjgYLKt0F6NHWmhO5NuJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348157; c=relaxed/simple;
	bh=nbmDxXCmHJWxzZH16oetoXnbF9xzOgD2H4J5TNZZbAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnWXfC6L81wd5VeaA7hpwVX8N4pSZkduU3uw7ccuTcRy9wltQqDWdsWqNutTeFz+A8LJp4Bbj6J8DT81zOSt4UkwuMnVzBmYaOwXM6tbUTho4M7nme0MlwcKJIgOQINzblQuNThuF6nmr0q4xI9zDEmtRSZZUXxStzFqKocGe/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ahSB2cYR; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6A093882D4;
	Tue, 25 Jun 2024 22:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719348153;
	bh=PR2JDse5jSJnbA6wzTy/BoqZj5vMlQhcTVfVV4sVfbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ahSB2cYRS3BKGeIr7v7tKXim/c7OT/2AOCE+GHANqPcJoPowlUBnoqQkUJhXcfEfI
	 EMVPwmjYMl4p9stydhZXINjSiFwYb7YI56SQKFHI9OYiQAVYCdYM+hcSrcJzHoEjCz
	 ri8E1aXgNUbSehgdB3VqqZbYz6yOqIuICkQoRDKMJcvgekdmOhs9ugVaRjAaSLq6EE
	 t+mwWHNh7SSY/zNx37plJJzNh8iJ+fhxgryNtuiLzYuHIwg6ZBvm73OFAa4+11SrMt
	 oQwIFwI8JjPUvaF9ly3C7CdI2FqxyT7jCDdZ3OlO5KbQWXmz1TEkxnDzFUoYcvmOqg
	 EctgMD1pquAgw==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [net-next,PATCH v2] net: phy: realtek: Add support for PHY LEDs on RTL8211F
Date: Tue, 25 Jun 2024 22:42:17 +0200
Message-ID: <20240625204221.265139-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Realtek RTL8211F Ethernet PHY supports 3 LED pins which are used to
indicate link status and activity. Add minimal LED controller driver
supporting the most common uses with the 'netdev' trigger.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: - RX and TX are not differentiated, either both are set or not set,
      filter this in rtl8211f_led_hw_is_supported()
---
 drivers/net/phy/realtek.c | 106 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 2174893c974f3..bed839237fb55 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -32,6 +32,15 @@
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_INSR				0x1d
 
+#define RTL8211F_LEDCR				0x10
+#define RTL8211F_LEDCR_MODE			BIT(15)
+#define RTL8211F_LEDCR_ACT_TXRX			BIT(4)
+#define RTL8211F_LEDCR_LINK_1000		BIT(3)
+#define RTL8211F_LEDCR_LINK_100			BIT(1)
+#define RTL8211F_LEDCR_LINK_10			BIT(0)
+#define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
+#define RTL8211F_LEDCR_SHIFT			5
+
 #define RTL8211F_TX_DELAY			BIT(8)
 #define RTL8211F_RX_DELAY			BIT(3)
 
@@ -87,6 +96,8 @@
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 
+#define RTL8211F_LED_COUNT			3
+
 MODULE_DESCRIPTION("Realtek PHY driver");
 MODULE_AUTHOR("Johnson Leung");
 MODULE_LICENSE("GPL");
@@ -476,6 +487,98 @@ static int rtl821x_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					unsigned long rules)
+{
+	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK_10) |
+				   BIT(TRIGGER_NETDEV_LINK_100) |
+				   BIT(TRIGGER_NETDEV_LINK_1000) |
+				   BIT(TRIGGER_NETDEV_RX) |
+				   BIT(TRIGGER_NETDEV_TX);
+
+	/* The RTL8211F PHY supports these LED settings on up to three LEDs:
+	 * - Link: Configurable subset of 10/100/1000 link rates
+	 * - Active: Blink on activity, RX or TX is not differentiated
+	 * The Active option has two modes, A and B:
+	 * - A: Link and Active indication at configurable, but matching,
+	 *      subset of 10/100/1000 link rates
+	 * - B: Link indication at configurable subset of 10/100/1000 link
+	 *      rates and Active indication always at all three 10+100+1000
+	 *      link rates.
+	 * This code currently uses mode B only.
+	 */
+
+	if (index >= RTL8211F_LED_COUNT)
+		return -EINVAL;
+
+	/* Filter out any other unsupported triggers. */
+	if (rules & ~mask)
+		return -EOPNOTSUPP;
+
+	/* RX and TX are not differentiated, either both are set or not set. */
+	if (!(rules & BIT(TRIGGER_NETDEV_RX)) ^ !(rules & BIT(TRIGGER_NETDEV_TX)))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
+				       unsigned long *rules)
+{
+	int val;
+
+	val = phy_read_paged(phydev, 0xd04, RTL8211F_LEDCR);
+	if (val < 0)
+		return val;
+
+	val >>= RTL8211F_LEDCR_SHIFT * index;
+	val &= RTL8211F_LEDCR_MASK;
+
+	if (val & RTL8211F_LEDCR_LINK_10)
+		set_bit(TRIGGER_NETDEV_LINK_10, rules);
+
+	if (val & RTL8211F_LEDCR_LINK_100)
+		set_bit(TRIGGER_NETDEV_LINK_100, rules);
+
+	if (val & RTL8211F_LEDCR_LINK_1000)
+		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+
+	if (val & RTL8211F_LEDCR_ACT_TXRX) {
+		set_bit(TRIGGER_NETDEV_RX, rules);
+		set_bit(TRIGGER_NETDEV_TX, rules);
+	}
+
+	return 0;
+}
+
+static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	const u16 mask = RTL8211F_LEDCR_MASK << (RTL8211F_LEDCR_SHIFT * index);
+	u16 reg = RTL8211F_LEDCR_MODE;	/* Mode B */
+
+	if (index >= RTL8211F_LED_COUNT)
+		return -EINVAL;
+
+	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+		reg |= RTL8211F_LEDCR_LINK_10;
+
+	if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+		reg |= RTL8211F_LEDCR_LINK_100;
+
+	if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+		reg |= RTL8211F_LEDCR_LINK_1000;
+
+	if (test_bit(TRIGGER_NETDEV_RX, &rules) ||
+	    test_bit(TRIGGER_NETDEV_TX, &rules)) {
+		reg |= RTL8211F_LEDCR_ACT_TXRX;
+	}
+
+	reg <<= RTL8211F_LEDCR_SHIFT * index;
+
+	return phy_modify_paged(phydev, 0xd04, RTL8211F_LEDCR, mask, reg);
+}
+
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
 	int ret = 0, oldpage;
@@ -1192,6 +1295,9 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
 		.flags		= PHY_ALWAYS_CALL_SUSPEND,
+		.led_hw_is_supported = rtl8211f_led_hw_is_supported,
+		.led_hw_control_get = rtl8211f_led_hw_control_get,
+		.led_hw_control_set = rtl8211f_led_hw_control_set,
 	}, {
 		PHY_ID_MATCH_EXACT(RTL_8211FVD_PHYID),
 		.name		= "RTL8211F-VD Gigabit Ethernet",
-- 
2.43.0


