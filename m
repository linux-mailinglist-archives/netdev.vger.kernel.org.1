Return-Path: <netdev+bounces-238323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E03C5745D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74BFF4E40CD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4934D3A9;
	Thu, 13 Nov 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YhQ7uBWK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43AC21C17D;
	Thu, 13 Nov 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034753; cv=none; b=uWsiOuIoeIqQNPXw/G4wghBsGm8Vks/XIXK/XwD4/9tbr+p49k594CftiJhkMz4dDlhyTFPwixVKX2lJ4lhhLY0CGqF0DP5uW8MqHYzfKTg1ZOw1JEMJ+KXIhwMRRcDZMtNj7KDXSNZz4Y45CnaCzg1JZZ93N8pErztmFJ3w5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034753; c=relaxed/simple;
	bh=7gMwnRjHvMqqGMiXjOIzyFT+cQgAtSmq6wtrIQx7ckU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUsAKEn+BCbihpahqFaVFsF5Xnz0v+oCaX9W2hoxTet6sOsypGQJyXRlQwPa7vwblhAxbNqsMPqntJ1bIl2Qv2KFZKK0eag6lBNHGgvStgigjh17X59bLOFN49Vpryx4/LtA/liOe08Gj1IqIchabed2/D4nlq++QLAdRlwkk+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YhQ7uBWK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763034751; x=1794570751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7gMwnRjHvMqqGMiXjOIzyFT+cQgAtSmq6wtrIQx7ckU=;
  b=YhQ7uBWKB0rwoVlrI9jZj4Za9gn8o1zneKXzTW1ziMJ/kWDXKpYtMLQT
   ai2qr0AzSp97twTlefqH+HHtws07jfh+AYKba1r+rB29kXpBz46tuHHiN
   Hf1eLX7oQgacWAJmdIeDiLyG8008zYcAnlR47qlEKj6Ap49VB/5jc6KNm
   7gO2n0XSRMTXQMtxf/cIRqqlHUJOBfIVWRdiAQjTkjqM9xJxtxNhn3dWq
   hz2/o+hcJsJN71rFQroizguFm68dEk5m67XvWZkI7eRSIF2leGiVS+w8u
   J09q7u6PZTYUlRSCF+e0PPnWk+NL37E6mvywiilo2WDJPh1QUqL6JuLTX
   w==;
X-CSE-ConnectionGUID: 3YIJu1weQma93cjyGpczEw==
X-CSE-MsgGUID: 8W5QFcX3TI6eCaUS7Y9ocg==
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="55526997"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 04:52:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 13 Nov 2025 04:52:20 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 13 Nov 2025 04:52:15 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 1/2] net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
Date: Thu, 13 Nov 2025 17:22:05 +0530
Message-ID: <20251113115206.140339-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
References: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
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
basic SQI (0-7 levels).

These changes allow higher-layer drivers and diagnostic tools to assess
link quality more accurately for OATC14 PHYs.

Open Alliance TC14 10BASE-T1S Advanced Diagnostic PHY Features
Specification ref:
https://opensig.org/wp-content/uploads/2025/06/OPEN_Alliance_10BASE-T1S_Advanced_PHY_features_for-automotive_Ethernet_V2.1b.pdf

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/mdio-open-alliance.h | 14 +++++
 drivers/net/phy/phy-c45.c            | 94 ++++++++++++++++++++++++++++
 include/linux/phy.h                  |  2 +
 3 files changed, 110 insertions(+)

diff --git a/drivers/net/phy/mdio-open-alliance.h b/drivers/net/phy/mdio-open-alliance.h
index 6850a3f0b31e..dcf7b685da5c 100644
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
@@ -65,6 +67,18 @@
 #define OATC14_HDD_VALID		BIT(2)
 #define OATC14_HDD_SHORT_OPEN_STATUS	GENMASK(1, 0)
 
+/* Dynamic Channel Quality SQI Register */
+#define MDIO_OATC14_DCQ_SQI		0xcc03
+#define OATC14_DCQ_SQI_UPDATE		BIT(15)
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
index e8e5be4684ab..47854c8fb9da 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1695,3 +1695,97 @@ int genphy_c45_oatc14_cable_test_start(struct phy_device *phydev)
 				OATC14_HDD_START_CONTROL);
 }
 EXPORT_SYMBOL(genphy_c45_oatc14_cable_test_start);
+
+/**
+ * genphy_c45_oatc14_get_sqi_max - Get maximum supported SQI or SQI+ level of
+				   OATC14 10Base-T1S PHY
+ * @phydev: pointer to the PHY device structure
+ *
+ * Reads the Signal Quality Indicator (SQI) or enhanced SQI+ capability and
+ * returns the highest supported level.
+ *
+ * Return:
+ * * Maximum SQI/SQI+ level (≥0)
+ * * -EOPNOTSUPP if not supported
+ * * Negative errno on read failure
+ */
+int genphy_c45_oatc14_get_sqi_max(struct phy_device *phydev)
+{
+	int bits;
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_ADFCAP);
+	if (ret < 0)
+		return ret;
+
+	/* SQI+ capability
+	 * 0 - SQI+ is not supported
+	 * X - SQI+ is supported using X bits (0-255 levels)
+	 */
+	bits = FIELD_GET(OATC14_ADFCAP_SQIPLUS_CAPABILITY, ret);
+	if (bits)
+		/* Max sqi+ level supported: (2 ^ bits) - 1 */
+		return BIT(bits) - 1;
+
+	/* SQI capability
+	 * 0 – SQI is not supported
+	 * 1 – SQI is supported (0-7 levels)
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
+			       10Base-T1S PHY
+ * @phydev: pointer to the PHY device structure
+ *
+ * Reads the SQI or SQI+ value from an OATC14-compatible 10Base-T1S PHY. If SQI+
+ * capability is supported, the function returns the extended SQI+ value;
+ * otherwise, it returns the basic SQI value.
+ *
+ * Return:
+ * * Positive SQI/SQI+ value on success
+ * * 0 if SQI update is not available
+ * * Negative errno on failure
+ */
+int genphy_c45_oatc14_get_sqi(struct phy_device *phydev)
+{
+	u8 shift;
+	int ret;
+
+	/* Read SQI value */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_DCQ_SQI);
+	if (ret < 0)
+		return ret;
+
+	/* Check for SQI update */
+	if (!(ret & OATC14_DCQ_SQI_UPDATE))
+		return 0;
+
+	/* Read SQI capability */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_ADFCAP);
+	if (ret < 0)
+		return ret;
+
+	/* Calculate and return SQI+ value if supported */
+	if (ret & OATC14_ADFCAP_SQIPLUS_CAPABILITY) {
+		/* SQI+ uses N MSBs out of 8 bits, left-aligned with padding 1's
+		 * Calculate the right-shift needed to isolate the N bits.
+		 */
+		shift = 8 - FIELD_GET(OATC14_ADFCAP_SQIPLUS_CAPABILITY, ret);
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+				   MDIO_OATC14_DCQ_SQIPLUS);
+		if (ret < 0)
+			return ret;
+
+		return (ret & OATC14_DCQ_SQIPLUS_VALUE) >> shift;
+	}
+
+	/* Return SQI value if SQI+ capability is not supported */
+	return ret & OATC14_DCQ_SQI_VALUE;
+}
+EXPORT_SYMBOL(genphy_c45_oatc14_get_sqi);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index bf5457341ca8..a3a8ff099f94 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2254,6 +2254,8 @@ int genphy_c45_an_config_eee_aneg(struct phy_device *phydev);
 int genphy_c45_oatc14_cable_test_start(struct phy_device *phydev);
 int genphy_c45_oatc14_cable_test_get_status(struct phy_device *phydev,
 					    bool *finished);
+int genphy_c45_oatc14_get_sqi_max(struct phy_device *phydev);
+int genphy_c45_oatc14_get_sqi(struct phy_device *phydev);
 
 /* The gen10g_* functions are the old Clause 45 stub */
 int gen10g_config_aneg(struct phy_device *phydev);
-- 
2.34.1


