Return-Path: <netdev+bounces-241853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9378C8964E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E963B58E5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52831ED87;
	Wed, 26 Nov 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s1X1CRQO"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8C31D36B;
	Wed, 26 Nov 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154238; cv=none; b=RzPf0W+GFj0Wi953/llx4w0d7gTMjNZCymNjt0GRRl1+60H8anKj/Hx1BTdbhp2O5z8ZO7prIoUadHCu8mzoBvPkucjMiaCuFr1YQECMFFR1rCJLQSu/tic6e7o0SY+9X4iwvtLwyEZ693cXSCo7QZ1tsB4RiAjGESBrTS8F5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154238; c=relaxed/simple;
	bh=QxCGD4pKjByIIfmJwEvbaaZVShRxQoVC2zIHaFUBsT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHo0ygf9Itwk9vYTLaaQ+LhUnq00z164L4lxPgsCEBed8zYTNoGAR9q5UB5WkKl5ABbmeRALrLf49MlrlYj9kw8/GEt60XWFYI9/5mop3trkumNLadY8LZA7Ws/NkS9y+yXm/QvgBoEoK3fyl39tFmj1W1LO3ep2+sD/nPABN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s1X1CRQO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764154236; x=1795690236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QxCGD4pKjByIIfmJwEvbaaZVShRxQoVC2zIHaFUBsT8=;
  b=s1X1CRQO4ASVLAvkUwNUXzMMTFrU67jpjpITFqgcTQgHFe3/STH1iQmz
   QUDdhmPnwdAY2ir44Pb6f0RABzKtWF7ldTeyd7Y5Y/dqCaedFtlLQmiCU
   HJD4tqUFCFc+jaDOczxAwscdSDrlbBmjDTLtdazqNL7hP6ecz+gjACR/x
   h3Rm/Re4B8gJPMkhmq9aIn8utOTgKoloiFv+l4xu5SRkHMKkhDf3VvDiq
   LOijMMjxr2LJqgUmpQqQsWX/tjhOtQ/32+cqFTj6PnrGXmjpzkMcWAVK3
   pLKtRwur1s5ek935Nv/8ukY9CDmLRMI/Jktz1cjIpGFBaQEAm4giL0cf9
   A==;
X-CSE-ConnectionGUID: tMjMCUkbTjK0Gq0hYCWfYA==
X-CSE-MsgGUID: aEjO81fpTciBg8wWTMeZ1w==
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="50191394"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Nov 2025 03:50:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 26 Nov 2025 03:50:08 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 26 Nov 2025 03:50:04 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v3 1/2] net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
Date: Wed, 26 Nov 2025 16:19:54 +0530
Message-ID: <20251126104955.61215-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126104955.61215-1-parthiban.veerasooran@microchip.com>
References: <20251126104955.61215-1-parthiban.veerasooran@microchip.com>
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
 include/linux/phy.h                  |  28 ++++++
 3 files changed, 178 insertions(+)

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
index e8e5be4684ab..52090ee2e997 100644
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
index 65b0c3ca6a2b..6e99c152b794 100644
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
@@ -772,6 +796,8 @@ struct phy_device {
 	/* MACsec management functions */
 	const struct macsec_ops *macsec_ops;
 #endif
+
+	struct phy_oatc14_sqi_capability oatc14_sqi_capability;
 };
 
 /* Generic phy_device::dev_flags */
@@ -2257,6 +2283,8 @@ int genphy_c45_an_config_eee_aneg(struct phy_device *phydev);
 int genphy_c45_oatc14_cable_test_start(struct phy_device *phydev);
 int genphy_c45_oatc14_cable_test_get_status(struct phy_device *phydev,
 					    bool *finished);
+int genphy_c45_oatc14_get_sqi_max(struct phy_device *phydev);
+int genphy_c45_oatc14_get_sqi(struct phy_device *phydev);
 
 /* The gen10g_* functions are the old Clause 45 stub */
 int gen10g_config_aneg(struct phy_device *phydev);
-- 
2.34.1


