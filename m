Return-Path: <netdev+bounces-230853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29493BF08A9
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D792F3E45FA
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F57472634;
	Mon, 20 Oct 2025 10:32:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750822E0B64
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956328; cv=none; b=Rpj+YYmUq8VYndSaUMd/K5EvOxqsDCC+V0URezw7uC/8C/Vv4NGj7bMdkznzAsM0wqz5OMB+HKXQWv4PxeeSea0mlc3scq8eNPJ19tBkU/sOtuqoMitkow42gzUYO5qX+ctAYHtshiZY6K7lTO/6po0+MaO4w0Zci8Bl+nh+AG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956328; c=relaxed/simple;
	bh=0TpaHIynp602WkTpStwrzEogLpfv0pv3ehaEOTf+Xh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYt/McrSBvwg9uACN97Q4eGvlPABdziil6qdTafeapSfU8Gm/Y21ftvy8J5dglLpyvXljdkoGeKH3jdNIRcqH59fkFAs1vMWyzaYa3J2k7mSJVnXgVFjCIW5pg/wn1FdJqMpXdroJcDZKYlvX5qlGaxS+0xSM8yri9dlPIcIiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vAnB8-0002zy-AU; Mon, 20 Oct 2025 12:31:50 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vAnB6-004WvV-0o;
	Mon, 20 Oct 2025 12:31:48 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vAnB6-0000000B1Kv-0XgA;
	Mon, 20 Oct 2025 12:31:48 +0200
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
Subject: [PATCH net-next v7 4/5] net: phy: micrel: add MSE interface support for KSZ9477 family
Date: Mon, 20 Oct 2025 12:31:46 +0200
Message-ID: <20251020103147.2626645-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020103147.2626645-1-o.rempel@pengutronix.de>
References: <20251020103147.2626645-1-o.rempel@pengutronix.de>
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

Implement the get_mse_capability() and get_mse_snapshot() PHY driver ops
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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
changes v7:
- add Reviewed-by
changes v6:
- update comments
- s/get_mse_config/get_mse_capability/
---
 drivers/net/phy/micrel.c | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 79ce3eb6752b..08c2dbc933a0 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2323,6 +2323,105 @@ static int kszphy_get_sqi_max(struct phy_device *phydev)
 	return KSZ9477_SQI_MAX;
 }
 
+static int kszphy_get_mse_capability(struct phy_device *phydev,
+				     struct phy_mse_capability *cap)
+{
+	/* Capabilities depend on link mode:
+	 * - 1000BASE-T: per-pair SQI registers exist => expose A..D
+	 *   and a WORST selector.
+	 * - 100BASE-TX: HW provides a single MSE/SQI reading in the "channel A"
+	 *   register, but with auto MDI-X there is no MDI-X resolution bit,
+	 *   so we cannot map that register to a specific wire pair reliably.
+	 *   To avoid misleading per-channel data, advertise only LINK.
+	 * Other speeds: no MSE exposure via this driver.
+	 *
+	 * Note: WORST is *not* a hardware selector on this family.
+	 * We expose it because the driver computes it in software
+	 * by scanning per-channel readouts (A..D) and picking the
+	 * maximum average MSE.
+	 */
+	if (phydev->speed == SPEED_1000)
+		cap->supported_caps = PHY_MSE_CAP_CHANNEL_A |
+				      PHY_MSE_CAP_CHANNEL_B |
+				      PHY_MSE_CAP_CHANNEL_C |
+				      PHY_MSE_CAP_CHANNEL_D |
+				      PHY_MSE_CAP_WORST_CHANNEL;
+	else if (phydev->speed == SPEED_100)
+		cap->supported_caps = PHY_MSE_CAP_LINK;
+	else
+		return -EOPNOTSUPP;
+
+	cap->max_average_mse = FIELD_MAX(KSZ9477_MMD_SQI_MASK);
+	cap->refresh_rate_ps = 2000000; /* 2 us */
+	/* Estimated from link modulation (125 MBd per channel) and documented
+	 * refresh rate of 2 us
+	 */
+	cap->num_symbols = 250;
+
+	cap->supported_caps |= PHY_MSE_CAP_AVG;
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
+		/* WORST is implemented in software: select the maximum
+		 * average MSE across the available per-channel registers.
+		 * Only defined when multiple channels exist (1000BASE-T).
+		 */
+		if (num_channels < 2)
+			return -EOPNOTSUPP;
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
+		/* Per-channel readouts are valid only for 1000BASE-T. */
+		if (phydev->speed != SPEED_1000)
+			return -EOPNOTSUPP;
+
+		ret = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+				   KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A + channel);
+		if (ret < 0)
+			return ret;
+		snapshot->average_mse = FIELD_GET(KSZ9477_MMD_SQI_MASK, ret);
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static void kszphy_enable_clk(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
@@ -6463,6 +6562,8 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 	.get_sqi	= kszphy_get_sqi,
 	.get_sqi_max	= kszphy_get_sqi_max,
+	.get_mse_capability = kszphy_get_mse_capability,
+	.get_mse_snapshot = kszphy_get_mse_snapshot,
 } };
 
 module_phy_driver(ksphy_driver);
-- 
2.47.3


