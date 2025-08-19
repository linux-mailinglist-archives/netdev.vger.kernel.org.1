Return-Path: <netdev+bounces-214891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED61B2BA43
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 09:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86ABC1882EB3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 07:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729EB3101BB;
	Tue, 19 Aug 2025 07:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF1284892
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587604; cv=none; b=MLRk7h7+4QZDmjS/FPL8T0eOt+eHrV8lGj5/mKXiF9YAHmhMkKIkIgM0kydtLkx3+lGmM7uxPzfBzQ4dHYa9OESD6hBnc4ciTGRd94JOFbCBIIM2RKvqiHy/SKqFn2oFQR3JU9kD6ox5mKH2mXhKk79/zooKezJdPOu5Y5sZH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587604; c=relaxed/simple;
	bh=llwU2Haob+VB2ivA8PzF5K2LGi4vmKnFoaGS4VTW+J4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWCyTUfxsTtdi+IZEu0Sjoz4owvVOecLZFQ88A3yeiX4EXrFF3CvaMNkJG0O8Qdlfh2raFo5/b9uxDpbroFchLVwBTbr2KFftiMpp6QjMNE+u0ZKZuIKBp9glkUU7xEtvFS6CyYklmYqcwZSdfBO1Z1GAccPTXLAupazPEnwTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uoGWj-0004jM-QK; Tue, 19 Aug 2025 09:13:01 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uoGWf-00121b-0t;
	Tue, 19 Aug 2025 09:12:57 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uoGWf-00EEbQ-0V;
	Tue, 19 Aug 2025 09:12:57 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>,
	Roan van Dijk <roan@protonic.nl>
Subject: [PATCH net-next v3 4/5] net: phy: micrel: add MSE interface support for KSZ9477 family
Date: Tue, 19 Aug 2025 09:12:55 +0200
Message-Id: <20250819071256.3392659-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819071256.3392659-1-o.rempel@pengutronix.de>
References: <20250819071256.3392659-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Implement the get_mse_config() and get_mse_snapshot() PHY driver ops
for KSZ9477-series integrated PHYs to demonstrate the new PHY MSE
UAPI.

These PHYs do not expose a documented direct MSE register, but the
Signal Quality Indicator (SQI) registers are derived from the
internal MSE computation. This hook maps SQI readings into the MSE
interface so that tooling can retrieve the raw value together with
metadata for correct interpretation in userspace.

Behaviour:
  - For 1000BASE-T, report per-channel (A–D) values and support a
    WORST channel selector.
  - For 100BASE-TX, only LINK-wide measurements are available.
  - Report average MSE only, with a max scale based on
    KSZ9477_MMD_SQI_MASK and a fixed refresh rate of 2 µs.

This mapping differs from the OPEN Alliance SQI definition, which
assigns thresholds such as pre-fail indices; the MSE interface
instead provides the raw measurement, leaving interpretation to
userspace.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/micrel.c | 76 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 605b0315b4cb..6a49722890bb 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2305,6 +2305,80 @@ static int kszphy_get_sqi_max(struct phy_device *phydev)
 	return KSZ9477_SQI_MAX;
 }
 
+static int kszphy_get_mse_config(struct phy_device *phydev,
+				 struct phy_mse_config *config)
+{
+	if (phydev->speed == SPEED_1000)
+		config->supported_caps |= PHY_MSE_CAP_CHANNEL_A |
+					  PHY_MSE_CAP_CHANNEL_B |
+					  PHY_MSE_CAP_CHANNEL_C |
+					  PHY_MSE_CAP_CHANNEL_D |
+					  PHY_MSE_CAP_WORST_CHANNEL;
+	else if (phydev->speed == SPEED_100)
+		config->supported_caps |= PHY_MSE_CAP_LINK;
+	else
+		return -EOPNOTSUPP;
+
+	config->max_average_mse = FIELD_MAX(KSZ9477_MMD_SQI_MASK);
+	config->refresh_rate_ps = 2000000; /* 2 us */
+	/* Estimated from link modulation (125 MBd per channel) and documented
+	 * refresh rate of 2 µs
+	 */
+	config->num_symbols = 250;
+
+	config->supported_caps |= PHY_MSE_CAP_AVG;
+
+	return 0;
+}
+
+static int kszphy_get_mse_snapshot(struct phy_device *phydev, u32 channel,
+				   struct phy_mse_snapshot *snapshot)
+{
+	u8 num_channels;
+	int ret;
+
+	if (phydev->speed == SPEED_1000)
+		num_channels = 4;
+	else if (phydev->speed == SPEED_100)
+		num_channels = 1;
+	else
+		return -EOPNOTSUPP;
+
+	if (channel == PHY_MSE_CHANNEL_WORST) {
+		u32 worst_val = 0;
+		int i;
+
+		for (i = 0; i < num_channels; i++) {
+			ret = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+					KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A + i);
+			if (ret < 0)
+				return ret;
+
+			ret = FIELD_GET(KSZ9477_MMD_SQI_MASK, ret);
+			if (ret > worst_val)
+				worst_val = ret;
+		}
+		snapshot->average_mse = worst_val;
+	} else if (channel == PHY_MSE_CHANNEL_LINK && num_channels == 1) {
+		ret = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+				   KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A);
+		if (ret < 0)
+			return ret;
+		snapshot->average_mse = FIELD_GET(KSZ9477_MMD_SQI_MASK, ret);
+	} else if (channel >= PHY_MSE_CHANNEL_A &&
+		   channel <= PHY_MSE_CHANNEL_D) {
+		ret = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+				   KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A + channel);
+		if (ret < 0)
+			return ret;
+		snapshot->average_mse = FIELD_GET(KSZ9477_MMD_SQI_MASK, ret);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void kszphy_enable_clk(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
@@ -5943,6 +6017,8 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 	.get_sqi	= kszphy_get_sqi,
 	.get_sqi_max	= kszphy_get_sqi_max,
+	.get_mse_config = kszphy_get_mse_config,
+	.get_mse_snapshot = kszphy_get_mse_snapshot,
 } };
 
 module_phy_driver(ksphy_driver);
-- 
2.39.5


