Return-Path: <netdev+bounces-239383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB525C674E5
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 06:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A3E122A151
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD2F2848B2;
	Tue, 18 Nov 2025 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eckAFy4p"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5D1B87EB;
	Tue, 18 Nov 2025 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442020; cv=none; b=gpnPb4QmgSV5UrvVe5abiFtc2ykailmnu/Y4tCywLOOwlibm5crx+OcKSnJJHqlTmE1F6l8mX4DK+aIPHiLnLKB4qJRvFBPtOn6lJIXT/dfsSf5vJVkdDZpTPGQXYxuAKw/Spl9Ksq18ip5RUR7WTiPyUttQwaqonzsSfr7E8og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442020; c=relaxed/simple;
	bh=y0Amnlqv8nmif58hSmu/YOwW7mpcorfMVs5m07aVPe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjWKXWhRxjRG+Qany9UplxUNThD4ZkGgwcXJUPqu/8dJ+p/VJ5j6BKy8ioSQOoTI/+5QQMz9KahT2tpGZOGfOxqmNjOUqnCfk5W3YlAUhX7iz6xHjZGkLIqfxmcV1NSgBng3EgE+TEpuvpzBle4q8eHd10/Dcj9cRaRXV7Uu9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eckAFy4p; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763442020; x=1794978020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0Amnlqv8nmif58hSmu/YOwW7mpcorfMVs5m07aVPe0=;
  b=eckAFy4pCjOEtQIIlrwsA6tUfcnyTUOpFTiO6g67alz53/UpWS+lkP08
   8vi1/nNPg5DQjk2QVC7Xg+1oRnJT3MiSRH5ogGyqj+JrTJzDeSfL6OvPi
   joGll8hCGCFAh+GXH9qJZuIdgBBoDCtVtnDK4FbhACDD07EsT4rUhAoKx
   2V5eVwyV28yIeWzr6AjnvaOAY0udvlCEdGK22XD2Ehb2cKabvxA4VbK1D
   piLPFI033RY0TcgI4bKzSTwtVPGuhHqOKThVXYgEkXyJN9wfGg8gkZVxu
   bUrdW2drGzeIBOVZeLWk5pVzUclWx58Gl6sHqVhYPSQinG90ulysnBByi
   g==;
X-CSE-ConnectionGUID: Uo7hmtmwRE2lxom0deaYtA==
X-CSE-MsgGUID: e5QtIojNTPO/sMiRoHctyw==
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="49294698"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 22:00:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 17 Nov 2025 21:59:57 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Nov 2025 21:59:53 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2 1/2] net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
Date: Tue, 18 Nov 2025 10:29:45 +0530
Message-ID: <20251118045946.31825-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118045946.31825-1-parthiban.veerasooran@microchip.com>
References: <20251118045946.31825-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Add support for reading Signal Quality Indicator (SQI) and enhanced SQI+
from OATC14 10Base-T1S PHYs.

- Introduce MDIO register definitions for DCQ_SQI and DCQ_SQIPLUS.
- Add `genphy_c45_oatc14_get_sqi_max()` to return the maximum supported
  SQI/SQI+ level.
- Add `genphy_c45_oatc14_get_sqi()` to return the current SQI or SQI+
  value.
- Update `include/linux/phy.h` to expose the new APIs.

SQI+ capability is read from the Advanced Diagnostic Features Capability
register (ADFCAP). If SQI+ is supported, the driver calculates the value
from the MSBs of the DCQ_SQIPLUS register; otherwise, it falls back to
basic SQI (0-7 levels). This enables ethtool to report the SQI value for
OATC14 10Base-T1S PHYs.

Open Alliance TC14 10BASE-T1S Advanced Diagnostic PHY Features
Specification ref:
https://opensig.org/wp-content/uploads/2025/06/OPEN_Alliance_10BASE-T1S_Advanced_PHY_features_for-automotive_Ethernet_V2.1b.pdf

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/mdio-open-alliance.h | 13 +++++
 drivers/net/phy/phy-c45.c            | 86 ++++++++++++++++++++++++++++
 include/linux/phy.h                  | 12 ++++
 3 files changed, 111 insertions(+)

diff --git a/drivers/net/phy/mdio-open-alliance.h b/drivers/net/phy/mdio-open-alliance.h
index 6850a3f0b31e..449d0fb67093 100644
--- a/drivers/net/phy/mdio-open-alliance.h
+++ b/drivers/net/phy/mdio-open-alliance.h
@@ -56,6 +56,8 @@
 /* Advanced Diagnostic Features Capability Register*/
 #define MDIO_OATC14_ADFCAP		0xcc00
 #define OATC14_ADFCAP_HDD_CAPABILITY	GENMASK(10, 8)
+#define OATC14_ADFCAP_SQIPLUS_CAPABILITY	GENMASK(4, 1)
+#define OATC14_ADFCAP_SQI_CAPABILITY	BIT(0)
 
 /* Harness Defect Detection Register */
 #define MDIO_OATC14_HDD			0xcc01
@@ -65,6 +67,17 @@
 #define OATC14_HDD_VALID		BIT(2)
 #define OATC14_HDD_SHORT_OPEN_STATUS	GENMASK(1, 0)
 
+/* Dynamic Channel Quality SQI Register */
+#define MDIO_OATC14_DCQ_SQI		0xcc03
+#define OATC14_DCQ_SQI_VALUE		GENMASK(2, 0)
+
+/* Dynamic Channel Quality SQI Plus Register */
+#define MDIO_OATC14_DCQ_SQIPLUS		0xcc04
+#define OATC14_DCQ_SQIPLUS_VALUE	GENMASK(7, 0)
+
+/* SQI is supported using 3 bits means 8 levels (0-7) */
+#define OATC14_SQI_MAX_LEVEL		7
+
 /* Bus Short/Open Status:
  * 0 0 - no fault; everything is ok. (Default)
  * 0 1 - detected as an open or missing termination(s)
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index e8e5be4684ab..eb496a900780 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1695,3 +1695,89 @@ int genphy_c45_oatc14_cable_test_start(struct phy_device *phydev)
 				OATC14_HDD_START_CONTROL);
 }
 EXPORT_SYMBOL(genphy_c45_oatc14_cable_test_start);
+
+/**
+ * genphy_c45_oatc14_get_sqi_max - Get maximum supported SQI or SQI+ level of
+ *				   OATC14 10Base-T1S PHY
+ * @phydev: pointer to the PHY device structure
+ *
+ * This function reads the advanced capability register to determine the maximum
+ * supported Signal Quality Indicator (SQI) or SQI+ level
+ *
+ * Return:
+ * * Maximum SQI/SQI+ level (≥0)
+ * * -EOPNOTSUPP if not supported
+ * * Negative errno on read failure
+ */
+int genphy_c45_oatc14_get_sqi_max(struct phy_device *phydev)
+{
+	u8 bits;
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_ADFCAP);
+	if (ret < 0)
+		return ret;
+
+	/* Check for SQI+ capability
+	 * 0 - SQI+ is not supported
+	 * (3-8) bits for (8-256) SQI+ levels supported
+	 */
+	bits = FIELD_GET(OATC14_ADFCAP_SQIPLUS_CAPABILITY, ret);
+	if (bits) {
+		phydev->oatc14_sqiplus_bits = bits;
+		/* Max sqi+ level supported: (2 ^ bits) - 1 */
+		return BIT(bits) - 1;
+	}
+
+	/* Check for SQI capability
+	 * 0 - SQI is not supported
+	 * 1 - SQI is supported (0-7 levels)
+	 */
+	if (ret & OATC14_ADFCAP_SQI_CAPABILITY)
+		return OATC14_SQI_MAX_LEVEL;
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(genphy_c45_oatc14_get_sqi_max);
+
+/**
+ * genphy_c45_oatc14_get_sqi - Get Signal Quality Indicator (SQI) from an OATC14
+ *			       10Base-T1S PHY
+ * @phydev: pointer to the PHY device structure
+ *
+ * This function reads the SQI+ or SQI value from an OATC14-compatible
+ * 10Base-T1S PHY. If SQI+ capability is supported, the function returns the
+ * extended SQI+ value; otherwise, it returns the basic SQI value.
+ *
+ * Return:
+ * * SQI/SQI+ value on success
+ * * Negative errno on read failure
+ */
+int genphy_c45_oatc14_get_sqi(struct phy_device *phydev)
+{
+	u8 shift;
+	int ret;
+
+	/* Calculate and return SQI+ value if supported */
+	if (phydev->oatc14_sqiplus_bits) {
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+				   MDIO_OATC14_DCQ_SQIPLUS);
+		if (ret < 0)
+			return ret;
+
+		/* SQI+ uses N MSBs out of 8 bits, left-aligned with padding 1's
+		 * Calculate the right-shift needed to isolate the N bits.
+		 */
+		shift = 8 - phydev->oatc14_sqiplus_bits;
+
+		return (ret & OATC14_DCQ_SQIPLUS_VALUE) >> shift;
+	}
+
+	/* Read and return SQI value if SQI+ capability is not supported */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_DCQ_SQI);
+	if (ret < 0)
+		return ret;
+
+	return ret & OATC14_DCQ_SQI_VALUE;
+}
+EXPORT_SYMBOL(genphy_c45_oatc14_get_sqi);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 65b0c3ca6a2b..841006fac16a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -626,6 +626,14 @@ struct macsec_ops;
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
  * @priv: Pointer to driver private data
+ * @oatc14_sqiplus_bits: Number of bits for sqi+ level supported
+ *        0 - SQI+ is not supported
+ *        3 - SQI+ is supported, using 3 bits (8 levels)
+ *        4 - SQI+ is supported, using 4 bits (16 levels)
+ *        5 - SQI+ is supported, using 5 bits (32 levels)
+ *        6 - SQI+ is supported, using 6 bits (64 levels)
+ *        7 - SQI+ is supported, using 7 bits (128 levels)
+ *        8 - SQI+ is supported, using 8 bits (256 levels)
  *
  * interrupts currently only supports enabled or disabled,
  * but could be changed in the future to support enabling
@@ -772,6 +780,8 @@ struct phy_device {
 	/* MACsec management functions */
 	const struct macsec_ops *macsec_ops;
 #endif
+
+	u8 oatc14_sqiplus_bits;
 };
 
 /* Generic phy_device::dev_flags */
@@ -2257,6 +2267,8 @@ int genphy_c45_an_config_eee_aneg(struct phy_device *phydev);
 int genphy_c45_oatc14_cable_test_start(struct phy_device *phydev);
 int genphy_c45_oatc14_cable_test_get_status(struct phy_device *phydev,
 					    bool *finished);
+int genphy_c45_oatc14_get_sqi_max(struct phy_device *phydev);
+int genphy_c45_oatc14_get_sqi(struct phy_device *phydev);
 
 /* The gen10g_* functions are the old Clause 45 stub */
 int gen10g_config_aneg(struct phy_device *phydev);
-- 
2.34.1


