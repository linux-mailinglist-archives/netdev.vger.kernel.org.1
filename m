Return-Path: <netdev+bounces-242883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A431EC95A50
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 04:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2402F3A1FA2
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 03:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5E1FA15E;
	Mon,  1 Dec 2025 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U4AHexdY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD41E2858;
	Mon,  1 Dec 2025 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764559462; cv=none; b=BFzl5Y3wmUL91SRs1tNrWJIHB5Ig7id7JJaNpC+cXASb+ShdrjgtV9aQeno6N3Xx08oIjpxlzwfxcQTDOm2E19yRb7spgoOfK3sglOIfBNZnimNH5+468TsWkhe6QKDz2weoHYZTTaxFMh+jQkgB/nHPhdMd0xUb3eG5vMO0TUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764559462; c=relaxed/simple;
	bh=lpC8e9e5Vu5989bnb6Xqk8L5N0ezOEc1i+zzZ2AEqm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laMh2sByuCfBlrWQw8d2z2sLiicspgTtjN4F4xwkCk8vCNSiZ2wCXKEx0NQexwiZsHnOB7r9NMfAJAtfEiPdpumeOditUux2sYI9lhRseebwVTqgYjZP5Mb13YH3AtBkf2SYTY09fNyqohnerv/NIpmAQU1i7/TrzZ8GavSnRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=U4AHexdY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764559460; x=1796095460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lpC8e9e5Vu5989bnb6Xqk8L5N0ezOEc1i+zzZ2AEqm8=;
  b=U4AHexdYnuMc3Ery36lC7Ti/xZX4suLfhPd7+zI9DhPiFpocQh8jA/3z
   +k6pfzaqoixvqXWqU39DJdTYLJzEstr1QASKc6GmXn1Lvi0f7WKK9ImTT
   cIjZ29umGzhL1SchaBbAlbu98FFO/1RFWOUY+ehlrU7QQw5lkogn1f+31
   dUNVO3zrIlsQWr9kVwPZbXnuz21QNmn691megEO2TA75NoxQe1GfC5JEZ
   lG+aZuqQNnXdpue9FDa7VSYKU8Y7ddEPZE8K/D8xjmIXikx1NKQnu5TNX
   YlLYo74sfIH7Hi/XZNHaeiWhceOSkqyG+A8JQnEhXVLlFvNo2tWHA5zh8
   Q==;
X-CSE-ConnectionGUID: Rp+FM40qQ/yigmL/eX55kQ==
X-CSE-MsgGUID: mZ02YIBpQ4SLLTRVwIb5Og==
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="217188648"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2025 20:24:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 30 Nov 2025 20:23:57 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 30 Nov 2025 20:23:53 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v4 1/2] net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
Date: Mon, 1 Dec 2025 08:53:45 +0530
Message-ID: <20251201032346.6699-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
References: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
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
 drivers/net/phy/mdio-open-alliance.h |  13 +++
 drivers/net/phy/phy-c45.c            | 137 +++++++++++++++++++++++++++
 include/linux/phy.h                  |  29 ++++++
 3 files changed, 179 insertions(+)

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
index f5e23b53994f..d48aa7231b37 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1695,3 +1695,140 @@ int genphy_c45_oatc14_cable_test_start(struct phy_device *phydev)
 				OATC14_HDD_START_CONTROL);
 }
 EXPORT_SYMBOL(genphy_c45_oatc14_cable_test_start);
+
+/**
+ * oatc14_update_sqi_capability - Read and update OATC14 10Base-T1S PHY SQI/SQI+
+ *                                capability
+ * @phydev: Pointer to the PHY device structure
+ *
+ * This helper reads the OATC14 ADFCAP capability register to determine whether
+ * the PHY supports SQI or SQI+ reporting.
+ *
+ * SQI+ capability is detected first. The SQI+ field indicates the number of
+ * valid MSBs (3–8), corresponding to 8–256 SQI+ levels. When present, the
+ * function stores the number of SQI+ bits and computes the maximum SQI+ value
+ * as (2^bits - 1).
+ *
+ * If SQI+ is not supported, the function checks for basic SQI capability,
+ * which provides 0–7 SQI levels.
+ *
+ * On success, the capability information is stored in
+ * @phydev->oatc14_sqi_capability and marked as updated.
+ *
+ * Return:
+ * * 0        - capability successfully read and stored
+ * * -EOPNOTSUPP - SQI/SQI+ not supported by this PHY
+ * * Negative errno on read failure
+ */
+static int oatc14_update_sqi_capability(struct phy_device *phydev)
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
+		phydev->oatc14_sqi_capability.sqiplus_bits = bits;
+		/* Max sqi+ level supported: (2 ^ bits) - 1 */
+		phydev->oatc14_sqi_capability.sqi_max = BIT(bits) - 1;
+		goto update_done;
+	}
+
+	/* Check for SQI capability
+	 * 0 - SQI is not supported
+	 * 1 - SQI is supported (0-7 levels)
+	 */
+	if (ret & OATC14_ADFCAP_SQI_CAPABILITY) {
+		phydev->oatc14_sqi_capability.sqi_max = OATC14_SQI_MAX_LEVEL;
+		goto update_done;
+	}
+
+	return -EOPNOTSUPP;
+
+update_done:
+	phydev->oatc14_sqi_capability.updated = true;
+	return 0;
+}
+
+/**
+ * genphy_c45_oatc14_get_sqi_max - Get maximum supported SQI or SQI+ level of
+ *				   OATC14 10Base-T1S PHY
+ * @phydev: pointer to the PHY device structure
+ *
+ * This function returns the maximum supported Signal Quality Indicator (SQI) or
+ * SQI+ level. The SQI capability is updated on first invocation if it has not
+ * already been updated.
+ *
+ * Return:
+ * * Maximum SQI/SQI+ level supported
+ * * Negative errno on capability read failure
+ */
+int genphy_c45_oatc14_get_sqi_max(struct phy_device *phydev)
+{
+	int ret;
+
+	if (!phydev->oatc14_sqi_capability.updated) {
+		ret = oatc14_update_sqi_capability(phydev);
+		if (ret)
+			return ret;
+	}
+
+	return phydev->oatc14_sqi_capability.sqi_max;
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
+ * extended SQI+ value; otherwise, it returns the basic SQI value. The SQI
+ * capability is updated on first invocation if it has not already been updated.
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
+	if (!phydev->oatc14_sqi_capability.updated) {
+		ret = oatc14_update_sqi_capability(phydev);
+		if (ret)
+			return ret;
+	}
+
+	/* Calculate and return SQI+ value if supported */
+	if (phydev->oatc14_sqi_capability.sqiplus_bits) {
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+				   MDIO_OATC14_DCQ_SQIPLUS);
+		if (ret < 0)
+			return ret;
+
+		/* SQI+ uses N MSBs out of 8 bits, left-aligned with padding 1's
+		 * Calculate the right-shift needed to isolate the N bits.
+		 */
+		shift = 8 - phydev->oatc14_sqi_capability.sqiplus_bits;
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
index 059a104223c4..fbbe028cc4b7 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -530,6 +530,30 @@ struct phy_c45_device_ids {
 struct macsec_context;
 struct macsec_ops;
 
+/**
+ * struct phy_oatc14_sqi_capability - SQI capability information for OATC14
+ *                                    10Base-T1S PHY
+ * @updated: Indicates whether the SQI capability fields have been updated.
+ * @sqi_max: Maximum supported Signal Quality Indicator (SQI) level reported by
+ *           the PHY.
+ * @sqiplus_bits: Bits for SQI+ levels supported by the PHY.
+ *                0 - SQI+ is not supported
+ *                3 - SQI+ is supported, using 3 bits (8 levels)
+ *                4 - SQI+ is supported, using 4 bits (16 levels)
+ *                5 - SQI+ is supported, using 5 bits (32 levels)
+ *                6 - SQI+ is supported, using 6 bits (64 levels)
+ *                7 - SQI+ is supported, using 7 bits (128 levels)
+ *                8 - SQI+ is supported, using 8 bits (256 levels)
+ *
+ * This structure is used by the OATC14 10Base-T1S PHY driver to store the SQI
+ * and SQI+ capability information retrieved from the PHY.
+ */
+struct phy_oatc14_sqi_capability {
+	bool updated;
+	int sqi_max;
+	u8 sqiplus_bits;
+};
+
 /**
  * struct phy_device - An instance of a PHY
  *
@@ -626,6 +650,7 @@ struct macsec_ops;
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
  * @priv: Pointer to driver private data
+ * @oatc14_sqi_capability: SQI capability information for OATC14 10Base-T1S PHY
  *
  * interrupts currently only supports enabled or disabled,
  * but could be changed in the future to support enabling
@@ -772,6 +797,8 @@ struct phy_device {
 	/* MACsec management functions */
 	const struct macsec_ops *macsec_ops;
 #endif
+
+	struct phy_oatc14_sqi_capability oatc14_sqi_capability;
 };
 
 /* Generic phy_device::dev_flags */
@@ -2257,6 +2284,8 @@ int genphy_c45_an_config_eee_aneg(struct phy_device *phydev);
 int genphy_c45_oatc14_cable_test_start(struct phy_device *phydev);
 int genphy_c45_oatc14_cable_test_get_status(struct phy_device *phydev,
 					    bool *finished);
+int genphy_c45_oatc14_get_sqi_max(struct phy_device *phydev);
+int genphy_c45_oatc14_get_sqi(struct phy_device *phydev);
 
 /* The gen10g_* functions are the old Clause 45 stub */
 int gen10g_config_aneg(struct phy_device *phydev);
-- 
2.34.1


