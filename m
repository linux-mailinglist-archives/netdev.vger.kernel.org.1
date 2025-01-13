Return-Path: <netdev+bounces-157561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9605EA0ACC6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 01:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F0618866F1
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 00:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB7BA4B;
	Mon, 13 Jan 2025 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="YRC+CPJZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3846B5;
	Mon, 13 Jan 2025 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736727368; cv=none; b=OO2sy5Ty3cXzesqDcHUFUvr5slckM+ykaCzO+KrVC/MicWNLEpzH60qEammchtsmBuqofQRDFGclYDZ1lAxCwxBtZWFfuWZkc8gbWZJZyGWW5GAk2nUYfBcftpiaW5RNn3XUauAnv9PgyNFI28ouPT0dc/FUv7/NxOu+1GGllAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736727368; c=relaxed/simple;
	bh=3ssiZM8JV+NIxO+SQfkDid7Ncucx1gZRgYr4/uu0SUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGybpYNRRdMa24XVhKPfDC3tq8isQQG7SalU9WI4FQnvbu63xwv8b508NBrhtz+4+2Wim629WiVk3hJQcz530fUyn81CMPZmlLAgYqQQWh12OMNRxkyMQOJxOKyQq3h/SBQ/63ZbL4fScEuE2nQnrlPEtOF2IxEUTBqMDG77Wks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=YRC+CPJZ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBA8710A334D3;
	Mon, 13 Jan 2025 01:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1736727360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQjhPYFc/jf3F6SO4i0n9ie3+8Yag/Cz0g9fvVHNRAc=;
	b=YRC+CPJZxcyg89aLjqLMa61QhqPD8ZuPM46z9cqvuUjcey9K0L2NQG0+dBZSZUl4dQ2MKZ
	0hTUCqEQqOax2R29a5OMpLnm/AxX1nuPLa/lBvaXXqLUV1Kf/W04Q9fpXNKrx8gg3UBxMB
	babjf983OqDmn1fQAov3K1dKU9tLZruUV/e6S85fcQcBM3QMLtDyRZrdOS8Of6WIM+JURw
	SQtDI67vh/z+cOqGIVIeYnjN3+GW4M4qh/k7fm+S8GfxNwK1P1SiXdC6hjNtShSfGq8XfR
	k9q9lvk3ZMDALAI96ZkEjqsUx3U+6cNJ9+Ky7iYItimpXoxfXNSz3/5bD+Njfg==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Tristram Ha <tristram.ha@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [net-next,PATCH 2/2] net: phy: micrel: Add KSZ87XX Switch LED control
Date: Mon, 13 Jan 2025 01:15:36 +0100
Message-ID: <20250113001543.296510-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250113001543.296510-1-marex@denx.de>
References: <20250113001543.296510-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The KSZ87xx switch contains LED control registers. There is one shared
global control register bitfield which affects behavior of all LEDs on
all ports, the Register 11 (0x0B): Global Control 9 bitfield [5:4].
There is also one per-port Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3
Control 10 bit 7 which controls enablement of both LEDs on each port
separately.

Expose LED brightness control and HW offload support for both of the two
programmable LEDs on this KSZ87XX Switch. Note that on KSZ87xx there are
three or more instances of simple KSZ87XX Switch PHY, one for each port,
however, the registers which control the LED behavior are mostly shared.

Introduce LED brightness control using Register 29/45/61 (0x1D/0x2D/0x3D):
Port 1/2/3 Control 10 bit 7. This bit selects between LEDs disabled and
LEDs set to Function mode. In case LED brightness is set to 0, both LEDs
are turned off, otherwise both LEDs are configured to Function mode which
follows the global Register 11 (0x0B): Global Control 9 bitfield [5:4]
setting.

Note that while two LEDs are registered per port, and each expose a matching
sysfs directory which contains a brightness attribute, a write into either
brightness attribute does reconfigure the same bit 7 in Register 29/45/61
(0x1D/0x2D/0x3D): Port 1/2/3 Control 10 for that particular port . The two
brightness attributes can also be out of sync which is not great.

Introduce LED mode configuration using Register 11 (0x0B): Global Control
9 bitfield [5:4]. This bitfield can be set to 1 of 4 non-orthogonal mode
settings which affects both LEDs on the port. Use a look up table to find
out whether setting one LED on the port is compatible with current setting
of the other LED and if not, reject the configuration until both LEDs are
configured to one of the four valid modes.

Note that while there are two LEDs per port, and there are multiple ports,
each with matching sysfs directory which contains netdev trigger attributes,
a write into either attribute does reconfigure the same shared Register 11
(0x0B): Global Control 9 bitfield [5:4] and the sysfs attributes can be out
of sync which is not great.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Tristram Ha <tristram.ha@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/phy/micrel.c | 112 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index eeb33eb181ac9..08eda25852048 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -434,6 +434,7 @@ struct kszphy_priv {
 	const struct kszphy_type *type;
 	struct clk *clk;
 	int led_mode;
+	unsigned long led_rules[2];
 	u16 vct_ctrl1000;
 	bool rmii_ref_clk_sel;
 	bool rmii_ref_clk_sel_val;
@@ -891,6 +892,112 @@ static int ksz8795_match_phy_device(struct phy_device *phydev)
 	return ksz8051_ksz8795_match_phy_device(phydev, false);
 }
 
+#define KSZ8795_LED_COUNT	2
+
+static const unsigned long ksz8795_led_rules_map[4][2] = {
+	{
+		/* Control Bits = 2'b00 => LEDx_0=Link/ACT LEDx_1=Speed */
+		BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX) |
+		BIT(TRIGGER_NETDEV_TX),
+		BIT(TRIGGER_NETDEV_LINK_100)
+	}, {
+		/* Control Bits = 2'b01 => LEDx_0=Link     LEDx_1=ACT */
+		BIT(TRIGGER_NETDEV_LINK),
+		BIT(TRIGGER_NETDEV_RX) | BIT(TRIGGER_NETDEV_TX)
+	}, {
+		/* Control Bits = 2'b10 => LEDx_0=Link/ACT LEDx_1=Duplex */
+		BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX) |
+		BIT(TRIGGER_NETDEV_TX),
+		BIT(TRIGGER_NETDEV_FULL_DUPLEX)
+	}, {
+		/* Control Bits = 2'b11 => LEDx_0=Link     LEDx_1=Duplex */
+		BIT(TRIGGER_NETDEV_LINK),
+		BIT(TRIGGER_NETDEV_FULL_DUPLEX)
+	}
+};
+
+static int ksz8795_led_brightness_set(struct phy_device *phydev, u8 index,
+				      enum led_brightness value)
+{
+	/* Turn all LEDs on this port on or off */
+	/* Emulated rmw of Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3 Control 10 */
+	return phy_modify(phydev, 0x0d00, BIT(7), (value == LED_OFF) ? BIT(7) : 0);
+}
+
+static int ksz8795_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	const unsigned long mask[2] = {
+		BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX) |
+		BIT(TRIGGER_NETDEV_TX),
+		BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_RX) |
+		BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_FULL_DUPLEX)
+	};
+
+	if (index >= KSZ8795_LED_COUNT)
+		return -EINVAL;
+
+	/* Filter out any other unsupported triggers. */
+	if (rules & ~mask[index])
+		return -EOPNOTSUPP;
+
+	/* RX and TX are not differentiated, either both are set or not set. */
+	if (!(rules & BIT(TRIGGER_NETDEV_RX)) ^ !(rules & BIT(TRIGGER_NETDEV_TX)))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int ksz8795_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	int val;
+
+	if (index >= KSZ8795_LED_COUNT)
+		return -EINVAL;
+
+	/* Emulated read of Register 11 (0x0B): Global Control 9 */
+	val = phy_read(phydev, 0x0b00);
+	if (val < 0)
+		return val;
+
+	/* Extract bits [5:4] and look up matching LED configuration */
+	*rules = ksz8795_led_rules_map[(val >> 4) & 0x3][index];
+
+	return 0;
+}
+
+static int ksz8795_led_hw_control_set(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	struct kszphy_priv *priv = phydev->priv;
+	unsigned long other_rules;
+	int i;
+
+	if (index >= KSZ8795_LED_COUNT)
+		return -EINVAL;
+
+	/*
+	 * Cache the rules for this LED for future use when setting up the
+	 * other LED and looking up compatible configuration of the global
+	 * control 9 register bitfield [5:4].
+	 */
+	priv->led_rules[index] = rules;
+
+	/* Use cached configuration of the other LED. */
+	other_rules = priv->led_rules[!index];
+
+	/* Update this LED configuration if compatible with the other LED */
+	for (i = 0; i < 4; i++) {
+		if (ksz8795_led_rules_map[i][index] == rules &&
+		    ksz8795_led_rules_map[i][!index] == other_rules) {
+			return phy_modify(phydev, 0x0b00, 0x30, i << 4);
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg,
@@ -5666,10 +5773,15 @@ static struct phy_driver ksphy_driver[] = {
 }, {
 	.name		= "Micrel KSZ87XX Switch",
 	/* PHY_BASIC_FEATURES */
+	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
 	.match_phy_device = ksz8795_match_phy_device,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	.led_brightness_set = ksz8795_led_brightness_set,
+	.led_hw_is_supported = ksz8795_led_hw_is_supported,
+	.led_hw_control_get = ksz8795_led_hw_control_get,
+	.led_hw_control_set = ksz8795_led_hw_control_set,
 }, {
 	.phy_id		= PHY_ID_KSZ9477,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
-- 
2.45.2


