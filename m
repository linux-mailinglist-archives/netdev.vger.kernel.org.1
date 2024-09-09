Return-Path: <netdev+bounces-126498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9697187B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197C9284241
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE971B5820;
	Mon,  9 Sep 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kN2CPShX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A26E13BAF1;
	Mon,  9 Sep 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882237; cv=none; b=vEo0HA0eVc+dowwj7td0ROJn3Rmimp8GkHA9Des8EXzQFzDITwKmda5XcEsAKQXj1tb3At0jD6/xm19QhDF9Jxq0ni91yxytZOfoTyHHkoEcpwKNb295/NLtQgyKhwgR56Do9h3nY/+ZVreNptu7XxiQIKVxKNGGKVFJoqGE1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882237; c=relaxed/simple;
	bh=HF2wRwR9G0wHmxi5gUDV/S/0x07++l0QRjOXhmn7PW4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u2BTgomAZ3n7M49i/e0CJuqjyIGOaKkIfvcfEfy5mqu0jh+Qwii9C4ikLSBxVjQ2szO8GgpDhKIRRki9zV8zy6wieI7Ona5eqR/tbt9rO0SaGFquLOFKcFehVnWlyR8ZbGJfaiHUk8oXxOpj4zJWrZ2XxhYeoKaqz19PTvP2sDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kN2CPShX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725882235; x=1757418235;
  h=from:to:subject:date:message-id:mime-version;
  bh=HF2wRwR9G0wHmxi5gUDV/S/0x07++l0QRjOXhmn7PW4=;
  b=kN2CPShXfj02BF5JSKxah4GbUrrbTePyPMWDLYmwSIgAQ8pQhWB7gY7z
   akKYk1Mxl0y+gLF/6eFsvfhLxlekbbUlveQDzdwAbZL/3gExwDvYZBQfD
   Dc92ReijDAEQnUjmQYIdw3O3LC8eRK4SoFz8/mbWDamI6m/CSpfMyQiaQ
   MReooz2+H0RN9BK8DGWwjWqQA+eLCgvNbMiY4iVM4Thwm01yG3XGtQb+P
   sJM3/7ZMIgNNmSl1Hph8UuJziu5uivbaUfIX0SbDPEHbpBAWK1LfVy4CR
   J5nxpu2jYqfurfw1AQT8g/MNBNjZbcXvOSULip9qAJRrMdf4ACQUw2hpw
   A==;
X-CSE-ConnectionGUID: VHxj1MfJQ2WeGZXl49WY7Q==
X-CSE-MsgGUID: m5sZQa0fQ7GafiLPx8y3aA==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="31501037"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 04:43:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 04:43:49 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 04:43:46 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: phy: microchip_t1: Cable Diagnostics for lan887x
Date: Mon, 9 Sep 2024 17:13:39 +0530
Message-ID: <20240909114339.3446-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add support for cable diagnostics in lan887x PHY.
Using this we can diagnose connected/open/short wires and
also length where cable fault is occurred.

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/microchip_t1.c | 413 +++++++++++++++++++++++++++++++++
 1 file changed, 413 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 5732ad65e7f9..a5ef8fe50704 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -175,6 +175,9 @@
 #define LAN887X_LED_LINK_ACT_ANY_SPEED		0x0
 
 /* MX chip top registers */
+#define LAN887X_CHIP_HARD_RST			0xf03e
+#define LAN887X_CHIP_HARD_RST_RESET		BIT(0)
+
 #define LAN887X_CHIP_SOFT_RST			0xf03f
 #define LAN887X_CHIP_SOFT_RST_RESET		BIT(0)
 
@@ -188,9 +191,60 @@
 #define LAN887X_EFUSE_READ_DAT9_SGMII_DIS	BIT(9)
 #define LAN887X_EFUSE_READ_DAT9_MAC_MODE	GENMASK(1, 0)
 
+#define LAN887X_CALIB_CONFIG_100		0x437
+#define LAN887X_CALIB_CONFIG_100_CBL_DIAG_USE_LOCAL_SMPL	BIT(5)
+#define LAN887X_CALIB_CONFIG_100_CBL_DIAG_STB_SYNC_MODE		BIT(4)
+#define LAN887X_CALIB_CONFIG_100_CBL_DIAG_CLK_ALGN_MODE		BIT(3)
+#define LAN887X_CALIB_CONFIG_100_VAL \
+	(LAN887X_CALIB_CONFIG_100_CBL_DIAG_CLK_ALGN_MODE |\
+	LAN887X_CALIB_CONFIG_100_CBL_DIAG_STB_SYNC_MODE |\
+	LAN887X_CALIB_CONFIG_100_CBL_DIAG_USE_LOCAL_SMPL)
+
+#define LAN887X_MAX_PGA_GAIN_100		0x44f
+#define LAN887X_MIN_PGA_GAIN_100		0x450
+#define LAN887X_START_CBL_DIAG_100		0x45a
+#define LAN887X_CBL_DIAG_DONE			BIT(1)
+#define LAN887X_CBL_DIAG_START			BIT(0)
+#define LAN887X_CBL_DIAG_STOP			0x0
+
+#define LAN887X_CBL_DIAG_TDR_THRESH_100		0x45b
+#define LAN887X_CBL_DIAG_AGC_THRESH_100		0x45c
+#define LAN887X_CBL_DIAG_MIN_WAIT_CONFIG_100	0x45d
+#define LAN887X_CBL_DIAG_MAX_WAIT_CONFIG_100	0x45e
+#define LAN887X_CBL_DIAG_CYC_CONFIG_100		0x45f
+#define LAN887X_CBL_DIAG_TX_PULSE_CONFIG_100	0x460
+#define LAN887X_CBL_DIAG_MIN_PGA_GAIN_100	0x462
+#define LAN887X_CBL_DIAG_AGC_GAIN_100		0x497
+#define LAN887X_CBL_DIAG_POS_PEAK_VALUE_100	0x499
+#define LAN887X_CBL_DIAG_NEG_PEAK_VALUE_100	0x49a
+#define LAN887X_CBL_DIAG_POS_PEAK_TIME_100	0x49c
+#define LAN887X_CBL_DIAG_NEG_PEAK_TIME_100	0x49d
+
+#define MICROCHIP_CABLE_NOISE_MARGIN		20
+#define MICROCHIP_CABLE_TIME_MARGIN		89
+#define MICROCHIP_CABLE_MIN_TIME_DIFF		96
+#define MICROCHIP_CABLE_MAX_TIME_DIFF	\
+	(MICROCHIP_CABLE_MIN_TIME_DIFF + MICROCHIP_CABLE_TIME_MARGIN)
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
 
+/* TEST_MODE_NORMAL: Non-hybrid results to calculate cable status(open/short/ok)
+ * TEST_MODE_HYBRID: Hybrid results to calculate distance to fault
+ */
+enum cable_diag_mode {
+	TEST_MODE_NORMAL,
+	TEST_MODE_HYBRID
+};
+
+/* CD_TEST_INIT: Cable test is initated
+ * CD_TEST_DONE: Cable test is done
+ */
+enum cable_diag_state {
+	CD_TEST_INIT,
+	CD_TEST_DONE
+};
+
 struct access_ereg_val {
 	u8  mode;
 	u8  bank;
@@ -1420,6 +1474,362 @@ static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
 		ethtool_puts(&data, lan887x_hw_stats[i].string);
 }
 
+static int lan887x_cd_reset(struct phy_device *phydev,
+			    enum cable_diag_state cd_done)
+{
+	u16 val;
+	int rc;
+
+	/* Chip hard-reset */
+	rc = phy_write_mmd(phydev, MDIO_MMD_VEND1, LAN887X_CHIP_HARD_RST,
+			   LAN887X_CHIP_HARD_RST_RESET);
+	if (rc < 0)
+		return rc;
+
+	/* Wait for reset to complete */
+	rc = phy_read_poll_timeout(phydev, MII_PHYSID2, val,
+				   ((val & GENMASK(15, 4)) ==
+				    (PHY_ID_LAN887X & GENMASK(15, 4))),
+				   5000, 50000, true);
+	if (rc < 0)
+		return rc;
+
+	if (cd_done == CD_TEST_DONE) {
+		/* Cable diagnostics complete. Restore PHY. */
+		rc = lan887x_phy_setup(phydev);
+		if (rc < 0)
+			return rc;
+
+		rc = lan887x_phy_init(phydev);
+		if (rc < 0)
+			return rc;
+
+		rc = lan887x_phy_reconfig(phydev);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int lan887x_cable_test_prep(struct phy_device *phydev,
+				   enum cable_diag_mode mode)
+{
+	static const struct lan887x_regwr_map values[] = {
+		{MDIO_MMD_VEND1, LAN887X_MAX_PGA_GAIN_100, 0x1f},
+		{MDIO_MMD_VEND1, LAN887X_MIN_PGA_GAIN_100, 0x0},
+		{MDIO_MMD_VEND1, LAN887X_CBL_DIAG_TDR_THRESH_100, 0x1},
+		{MDIO_MMD_VEND1, LAN887X_CBL_DIAG_AGC_THRESH_100, 0x3c},
+		{MDIO_MMD_VEND1, LAN887X_CBL_DIAG_MIN_WAIT_CONFIG_100, 0x0},
+		{MDIO_MMD_VEND1, LAN887X_CBL_DIAG_MAX_WAIT_CONFIG_100, 0x46},
+		{MDIO_MMD_VEND1, LAN887X_CBL_DIAG_CYC_CONFIG_100, 0x5a},
+		{MDIO_MMD_VEND1, LAN887X_CBL_DIAG_TX_PULSE_CONFIG_100, 0x44d5},
+		{MDIO_MMD_VEND1, LAN887X_CBL_DIAG_MIN_PGA_GAIN_100, 0x0},
+
+	};
+	int rc;
+
+	rc = lan887x_cd_reset(phydev, CD_TEST_INIT);
+	if (rc < 0)
+		return rc;
+
+	/* Forcing DUT to master mode, as we don't care about
+	 * mode during diagnostics
+	 */
+	rc = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1_CTRL,
+			   MDIO_PMA_PMD_BT1_CTRL_CFG_MST);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x80b0, 0x0038);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			    LAN887X_CALIB_CONFIG_100, 0,
+			    LAN887X_CALIB_CONFIG_100_VAL);
+	if (rc < 0)
+		return rc;
+
+	for (int i = 0; i < ARRAY_SIZE(values); i++) {
+		rc = phy_write_mmd(phydev, values[i].mmd, values[i].reg,
+				   values[i].val);
+		if (rc < 0)
+			return rc;
+
+		if (mode &&
+		    values[i].reg == LAN887X_CBL_DIAG_MAX_WAIT_CONFIG_100) {
+			rc = phy_write_mmd(phydev, values[i].mmd,
+					   values[i].reg, 0xa);
+			if (rc < 0)
+				return rc;
+		}
+	}
+
+	if (mode == TEST_MODE_HYBRID) {
+		rc = phy_modify_mmd(phydev, MDIO_MMD_PMAPMD,
+				    LAN887X_AFE_PORT_TESTBUS_CTRL4,
+				    BIT(0), BIT(0));
+		if (rc < 0)
+			return rc;
+	}
+
+	/* HW_INIT 100T1, Get DUT running in 100T1 mode */
+	rc = phy_modify_mmd(phydev, MDIO_MMD_VEND1, LAN887X_REG_REG26,
+			    LAN887X_REG_REG26_HW_INIT_SEQ_EN,
+			    LAN887X_REG_REG26_HW_INIT_SEQ_EN);
+	if (rc < 0)
+		return rc;
+
+	/* Cable diag requires hard reset and is sensitive regarding the delays.
+	 * Hard reset is expected into and out of cable diag.
+	 * Wait for 50ms
+	 */
+	msleep(50);
+
+	/* Start cable diag */
+	return phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			   LAN887X_START_CBL_DIAG_100,
+			   LAN887X_CBL_DIAG_START);
+}
+
+static int lan887x_cable_test_chk(struct phy_device *phydev,
+				  enum cable_diag_mode mode)
+{
+	int val;
+	int rc;
+
+	if (mode == TEST_MODE_HYBRID) {
+		/* Cable diag requires hard reset and is sensitive regarding the delays.
+		 * Hard reset is expected into and out of cable diag.
+		 * Wait for cable diag to complete.
+		 * Minimum wait time is 50ms if the condition is not a match.
+		 */
+		rc = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					       LAN887X_START_CBL_DIAG_100, val,
+					       ((val & LAN887X_CBL_DIAG_DONE) ==
+						LAN887X_CBL_DIAG_DONE),
+					       50000, 500000, false);
+		if (rc < 0)
+			return rc;
+	} else {
+		rc = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				  LAN887X_START_CBL_DIAG_100);
+		if (rc < 0)
+			return rc;
+
+		if ((rc & LAN887X_CBL_DIAG_DONE) != LAN887X_CBL_DIAG_DONE)
+			return -EAGAIN;
+	}
+
+	/* Stop cable diag */
+	return phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			     LAN887X_START_CBL_DIAG_100,
+			     LAN887X_CBL_DIAG_STOP);
+}
+
+static int lan887x_cable_test_start(struct phy_device *phydev)
+{
+	int rc, ret;
+
+	rc = lan887x_cable_test_prep(phydev, TEST_MODE_NORMAL);
+	if (rc < 0) {
+		ret = lan887x_cd_reset(phydev, CD_TEST_DONE);
+		if (ret < 0)
+			return ret;
+
+		return rc;
+	}
+
+	return 0;
+}
+
+static int lan887x_cable_test_report(struct phy_device *phydev)
+{
+	int pos_peak_cycle, pos_peak_cycle_hybrid, pos_peak_in_phases;
+	int pos_peak_time, pos_peak_time_hybrid, neg_peak_time;
+	int neg_peak_cycle, neg_peak_in_phases;
+	int pos_peak_in_phases_hybrid;
+	int gain_idx, gain_idx_hybrid;
+	int pos_peak_phase_hybrid;
+	int pos_peak, neg_peak;
+	int distance;
+	int detect;
+	int length;
+	int ret;
+	int rc;
+
+	/* Read non-hybrid results */
+	gain_idx = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				LAN887X_CBL_DIAG_AGC_GAIN_100);
+	if (gain_idx < 0) {
+		rc = gain_idx;
+		goto error;
+	}
+
+	pos_peak = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				LAN887X_CBL_DIAG_POS_PEAK_VALUE_100);
+	if (pos_peak < 0) {
+		rc = pos_peak;
+		goto error;
+	}
+
+	neg_peak = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				LAN887X_CBL_DIAG_NEG_PEAK_VALUE_100);
+	if (neg_peak < 0) {
+		rc = neg_peak;
+		goto error;
+	}
+
+	pos_peak_time = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     LAN887X_CBL_DIAG_POS_PEAK_TIME_100);
+	if (pos_peak_time < 0) {
+		rc = pos_peak_time;
+		goto error;
+	}
+
+	neg_peak_time = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     LAN887X_CBL_DIAG_NEG_PEAK_TIME_100);
+	if (neg_peak_time < 0) {
+		rc = neg_peak_time;
+		goto error;
+	}
+
+	/* Calculate non-hybrid values */
+	pos_peak_cycle = (pos_peak_time >> 7) & 0x7f;
+	pos_peak_in_phases = (pos_peak_cycle * 96) + (pos_peak_time & 0x7f);
+	neg_peak_cycle = (neg_peak_time >> 7) & 0x7f;
+	neg_peak_in_phases = (neg_peak_cycle * 96) + (neg_peak_time & 0x7f);
+
+	/* Deriving the status of cable */
+	if (pos_peak > MICROCHIP_CABLE_NOISE_MARGIN &&
+	    neg_peak > MICROCHIP_CABLE_NOISE_MARGIN && gain_idx >= 0) {
+		if (pos_peak_in_phases > neg_peak_in_phases &&
+		    ((pos_peak_in_phases - neg_peak_in_phases) >=
+		     MICROCHIP_CABLE_MIN_TIME_DIFF) &&
+		    ((pos_peak_in_phases - neg_peak_in_phases) <
+		     MICROCHIP_CABLE_MAX_TIME_DIFF) &&
+		    pos_peak_in_phases > 0) {
+			detect = LAN87XX_CABLE_TEST_SAME_SHORT;
+		} else if (neg_peak_in_phases > pos_peak_in_phases &&
+			   ((neg_peak_in_phases - pos_peak_in_phases) >=
+			    MICROCHIP_CABLE_MIN_TIME_DIFF) &&
+			   ((neg_peak_in_phases - pos_peak_in_phases) <
+			    MICROCHIP_CABLE_MAX_TIME_DIFF) &&
+			   neg_peak_in_phases > 0) {
+			detect = LAN87XX_CABLE_TEST_OPEN;
+		} else {
+			detect = LAN87XX_CABLE_TEST_OK;
+		}
+	} else {
+		detect = LAN87XX_CABLE_TEST_OK;
+	}
+
+	if (detect == LAN87XX_CABLE_TEST_OK) {
+		distance = 0;
+		goto get_len;
+	}
+
+	/* Re-initialize PHY and start cable diag test */
+	rc = lan887x_cable_test_prep(phydev, TEST_MODE_HYBRID);
+	if (rc < 0)
+		goto cd_stop;
+
+	/* Wait for cable diag test completion */
+	rc = lan887x_cable_test_chk(phydev, TEST_MODE_HYBRID);
+	if (rc < 0)
+		goto cd_stop;
+
+	/* Read hybrid results */
+	gain_idx_hybrid = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				       LAN887X_CBL_DIAG_AGC_GAIN_100);
+	if (gain_idx_hybrid < 0) {
+		rc = gain_idx_hybrid;
+		goto error;
+	}
+
+	pos_peak_time_hybrid = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+					    LAN887X_CBL_DIAG_POS_PEAK_TIME_100);
+	if (pos_peak_time_hybrid < 0) {
+		rc = pos_peak_time_hybrid;
+		goto error;
+	}
+
+	/* Calculate hybrid values to derive cable length to fault */
+	pos_peak_cycle_hybrid = (pos_peak_time_hybrid >> 7) & 0x7f;
+	pos_peak_phase_hybrid = pos_peak_time_hybrid & 0x7f;
+	pos_peak_in_phases_hybrid = pos_peak_cycle_hybrid * 96 +
+				    pos_peak_phase_hybrid;
+
+	/* Distance to fault calculation.
+	 * distance = (peak_in_phases - peak_in_phases_hybrid) *
+	 *             propagationconstant.
+	 * constant to convert number of phases to meters
+	 * propagationconstant = 0.015953
+	 *                       (0.6811 * 2.9979 * 156.2499 * 0.0001 * 0.5)
+	 * Applying constant 1.5953 as ethtool further devides by 100 to
+	 * convert to meters.
+	 */
+	if (detect == LAN87XX_CABLE_TEST_OPEN) {
+		distance = (((pos_peak_in_phases - pos_peak_in_phases_hybrid)
+			     * 15953) / 10000);
+	} else if (detect == LAN87XX_CABLE_TEST_SAME_SHORT) {
+		distance = (((neg_peak_in_phases - pos_peak_in_phases_hybrid)
+			     * 15953) / 10000);
+	} else {
+		distance = 0;
+	}
+
+get_len:
+	rc = lan887x_cd_reset(phydev, CD_TEST_DONE);
+	if (rc < 0)
+		return rc;
+
+	length = ((u32)distance & GENMASK(15, 0));
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+				lan87xx_cable_test_report_trans(detect));
+	ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A, length);
+
+	return 0;
+
+cd_stop:
+	/* Stop cable diag */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			    LAN887X_START_CBL_DIAG_100,
+			    LAN887X_CBL_DIAG_STOP);
+	if (ret < 0)
+		return ret;
+
+error:
+	/* Cable diag test failed */
+	ret = lan887x_cd_reset(phydev, CD_TEST_DONE);
+	if (ret < 0)
+		return ret;
+
+	/* Return error in failure case */
+	return rc;
+}
+
+static int lan887x_cable_test_get_status(struct phy_device *phydev,
+					 bool *finished)
+{
+	int rc;
+
+	rc = lan887x_cable_test_chk(phydev, TEST_MODE_NORMAL);
+	if (rc < 0) {
+		/* Let PHY statemachine poll again */
+		if (rc == -EAGAIN)
+			return 0;
+		return rc;
+	}
+
+	/* Cable diag test complete */
+	*finished = true;
+
+	/* Retrieve test status and cable length to fault */
+	return lan887x_cable_test_report(phydev);
+}
+
 static struct phy_driver microchip_t1_phy_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX),
@@ -1458,6 +1868,7 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_LAN887X),
 		.name		= "Microchip LAN887x T1 PHY",
+		.flags          = PHY_POLL_CABLE_TEST,
 		.probe		= lan887x_probe,
 		.get_features	= lan887x_get_features,
 		.config_init    = lan887x_phy_init,
@@ -1468,6 +1879,8 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_status	= genphy_c45_read_status,
+		.cable_test_start = lan887x_cable_test_start,
+		.cable_test_get_status = lan887x_cable_test_get_status,
 	}
 };
 
-- 
2.17.1


