Return-Path: <netdev+bounces-105960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F2B913F41
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DBA1C20AD7
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D398184126;
	Sun, 23 Jun 2024 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="NMFRlbMs"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FDD450E2;
	Sun, 23 Jun 2024 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719186151; cv=none; b=EuBu1WOq5bPJKvk0mhi9OcORd/ORrqFtglR9mY3e6qPDE3a6+MuFZqWEdmfCYlu6bQ3/+Lspc6Uz35Vp7X60uJFK71lycXkYWmodUPAenmrFGze7XbcxdOmR5wAEBUQgNDTAtqHk9r7sIvZlMdVyfoOcQCi/89bgY8f+wi7i6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719186151; c=relaxed/simple;
	bh=kM1qsG9JfRBW27V9dQaVXHE5rzjrbrS7nfzT41caXCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAZmqgldS5p85N1yttNRP/pM+OV4rSpK7JZSHdYzkVBMxLtHAoOmjWMH1l3I+mQBwAQ7Dj2c3QX691S3xTON8SB2mP686pqRT66sVIrmGvsLpX0bYnIAoLuNkxMLSjSlZsYu0Kbx9UY8XR09xvAHx9yf/E058qMTh+MIJfGF12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=NMFRlbMs; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9262388137;
	Mon, 24 Jun 2024 01:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719186146;
	bh=JE5Lh7V2QCbWxdKoLrPPqvI+lXldIaIwahYSjFrYagY=;
	h=From:To:Cc:Subject:Date:From;
	b=NMFRlbMsR9PJrerDVy5sTMVVdo7ZquGMziV0zsCAn4HqIFCPGuhAZL50jYwt7k4ar
	 y/FxAD44qzByzBp7/vxtlfQwbb092ximnu8Z5RwBkHXcsS5dNDuhq9JRw7oUSE86fu
	 dmmIvxgKZatE5XY52Cge9RC39vX6vieSCAST01Ui8eqnvRDveXrb76FpZUO3o0ay66
	 l42oMDjcSsNWHIYAV7Vz549Kpi3RBatl/J0d08tmMDETvgF+bfuEK7P/ED3yXa69rX
	 3Twcb/ehb7Gwsfj1QeZzyjT1BIMV/1MXAQYgeUHlJ/64wpZ97V8wEGdC22V+n7k7gb
	 7vF2+q/6bmpPA==
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
Subject: [net-next,PATCH] net: phy: realtek: Add support for PHY LEDs on RTL8211F
Date: Mon, 24 Jun 2024 01:40:33 +0200
Message-ID: <20240623234211.122475-1-marex@denx.de>
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
 drivers/net/phy/realtek.c | 102 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 2174893c974f3..cb7860571adcb 100644
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
@@ -476,6 +487,94 @@ static int rtl821x_resume(struct phy_device *phydev)
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
@@ -1192,6 +1291,9 @@ static struct phy_driver realtek_drvs[] = {
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


