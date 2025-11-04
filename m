Return-Path: <netdev+bounces-235438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24105C3082F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 11:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E5C189B925
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 10:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F005731690E;
	Tue,  4 Nov 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CLIbGPyy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102311DFF0;
	Tue,  4 Nov 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252169; cv=none; b=D42vAJWehHBpOx3hGNnN82C0jzecMWm9lvKDfJBP6OrxhZ0t1Qn7GEKMSTGHIFU/usjd0ukX9zDBWbYdW4tCulEuGIWhtRlf+YcCa5FXmaQFS56nNZDX/wNiXcf8AYqUKE0h3UaRvJiKSs0bf1qrWPLt6TGLhFrCLf/7AHS5qO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252169; c=relaxed/simple;
	bh=A59m6WsH87WemzrxvkLBiH3gUMQmSkWhT9XCVMqntdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHo3majG9ffm68uFX58FlgusRCOHCt8FyYnYDb/89mg2ixhTyRRZATCSSY0pFBYR43zY/FiVBD4t6EAMovemXnyOlo9/x2CVac/bpk9fasMLNKyBF2TIf5m8Hkgyyw0PvQZi0gqEsASfRwXhW0il1MmG13rVjWdpOCJ81zJFVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CLIbGPyy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762252167; x=1793788167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A59m6WsH87WemzrxvkLBiH3gUMQmSkWhT9XCVMqntdE=;
  b=CLIbGPyyW/Cs9RebMyn4KOMBE21NvZizNPTsFCCUikdyJoLVkTXHfhk5
   MbPD++AtPvcJRD2MMfAcc3LnauN0HMtVWooaZUQk4L5zUhUxiYhlXqvEN
   FlXKzDQ7PGkOj+TLY19m65M14p4Rc+pIpw5RXa/IEetwUggO4eOyYysXU
   tWqD8DYLiAOq1Rz/7Lit+ifUZUO4rwqfubgxAZ8hTuSd0BjvgcPKCwgPv
   lVz6FtwDgLRpaHso9/y74/F1ha0kq2mEN371g0QqkvN6lJA0w01rIyUAg
   C9S0uC3HUvU1Cg2RNE/ssbCSwDDhDlDKby/F9khKr3p+BIhpOWZ+ocbpZ
   Q==;
X-CSE-ConnectionGUID: 54f3n6OUQHWzRkAOn9QkBA==
X-CSE-MsgGUID: xdbrd9nfR1C75Rip8evwKA==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="49163544"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2025 03:29:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Nov 2025 03:28:59 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Nov 2025 03:28:55 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2 1/2] net: phy: phy-c45: add OATC14 10BASE-T1S PHY cable diagnostic support
Date: Tue, 4 Nov 2025 15:58:41 +0530
Message-ID: <20251104102842.64519-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104102842.64519-1-parthiban.veerasooran@microchip.com>
References: <20251104102842.64519-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Add support for Open Alliance TC14 (OATC14) 10BASE-T1S PHYs cable
diagnostic feature.

This patch implements:
- genphy_c45_oatc14_cable_test_start() to initiate a cable test
- genphy_c45_oatc14_cable_test_get_status() to retrieve test results
- Helper function to map PHY cable test status to ethtool result codes
- Function declarations and exports for use by PHY drivers

This enables ethtool to report ok, open, short, and undetectable cable
conditions on OATC14 10Base-T1S PHYs.

Open Alliance TC14 10BASE-T1S Advanced Diagnostic PHY Features
Specification ref:
https://opensig.org/wp-content/uploads/2025/06/OPEN_Alliance_10BASE-T1S_Advanced_PHY_features_for-automotive_Ethernet_V2.1b.pdf

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/mdio-open-alliance.h |  36 ++++++++
 drivers/net/phy/phy-c45.c            | 122 +++++++++++++++++++++++++++
 include/linux/phy.h                  |   3 +
 3 files changed, 161 insertions(+)

diff --git a/drivers/net/phy/mdio-open-alliance.h b/drivers/net/phy/mdio-open-alliance.h
index 931e14660d75..db302ff1f39a 100644
--- a/drivers/net/phy/mdio-open-alliance.h
+++ b/drivers/net/phy/mdio-open-alliance.h
@@ -43,4 +43,40 @@
 /* Version Identifiers */
 #define OATC14_IDM		0x0a00
 
+/*
+ * Open Alliance TC14 (10BASE-T1S) - Advanced Diagnostic Features Registers
+ *
+ * Refer to the OPEN Alliance documentation:
+ *   https://opensig.org/automotive-ethernet-specifications/
+ *
+ * Specification:
+ *   "10BASE-T1S Advanced Diagnostic PHY Features"
+ *   https://opensig.org/wp-content/uploads/2025/06/OPEN_Alliance_10BASE-T1S_Advanced_PHY_features_for-automotive_Ethernet_V2.1b.pdf
+ */
+/* Advanced Diagnostic Features Capability Register*/
+#define MDIO_OATC14_ADFCAP		0xcc00
+#define OATC14_ADFCAP_HDD_CAPABILITY	GENMASK(10, 8)
+
+/* Harness Defect Detection Register */
+#define MDIO_OATC14_HDD			0xcc01
+#define OATC14_HDD_CONTROL		BIT(15)
+#define OATC14_HDD_READY		BIT(14)
+#define OATC14_HDD_START_CONTROL	BIT(13)
+#define OATC14_HDD_VALID		BIT(2)
+#define OATC14_HDD_SHORT_OPEN_STATUS	GENMASK(1, 0)
+
+/* Bus Short/Open Status:
+ * 0 0 - no fault; everything is ok. (Default)
+ * 0 1 - detected as an open or missing termination(s)
+ * 1 0 - detected as a short or extra termination(s)
+ * 1 1 - fault but fault type not detectable. More details can be available by
+ *       vender specific register if supported.
+ */
+enum oatc14_hdd_status {
+	OATC14_HDD_STATUS_CABLE_OK,
+	OATC14_HDD_STATUS_OPEN,
+	OATC14_HDD_STATUS_SHORT,
+	OATC14_HDD_STATUS_NOT_DETECTABLE,
+};
+
 #endif /* __MDIO_OPEN_ALLIANCE__ */
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 61670be0f095..6030023bf840 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -7,6 +7,7 @@
 #include <linux/mdio.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
+#include <linux/ethtool_netlink.h>
 
 #include "mdio-open-alliance.h"
 #include "phylib-internal.h"
@@ -1573,3 +1574,124 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 	return ret;
 }
 EXPORT_SYMBOL(genphy_c45_ethtool_set_eee);
+
+/**
+ * oatc14_cable_test_get_result_code - Convert hardware cable test status to
+ *                                     ethtool result code.
+ * @status: The hardware-reported cable test status
+ *
+ * This helper function maps the OATC14 HDD cable test status to the
+ * corresponding ethtool cable test result code. It provides a translation
+ * between the device-specific status values and the standardized ethtool
+ * result codes.
+ *
+ * Return:
+ * * ETHTOOL_A_CABLE_RESULT_CODE_OK          - Cable is OK
+ * * ETHTOOL_A_CABLE_RESULT_CODE_OPEN        - Open circuit detected
+ * * ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT  - Short circuit detected
+ * * ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC      - Status not detectable or invalid
+ */
+static int oatc14_cable_test_get_result_code(enum oatc14_hdd_status status)
+{
+	switch (status) {
+	case OATC14_HDD_STATUS_CABLE_OK:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
+	case OATC14_HDD_STATUS_OPEN:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+	case OATC14_HDD_STATUS_SHORT:
+		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+	case OATC14_HDD_STATUS_NOT_DETECTABLE:
+	default:
+		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+	}
+}
+
+/**
+ * genphy_c45_oatc14_cable_test_get_status - Get status of OATC14 10Base-T1S
+ *                                           PHY cable test.
+ * @phydev:   pointer to the PHY device structure
+ * @finished: pointer to a boolean set true if the test is complete
+ *
+ * Retrieves the current status of the OATC14 10Base-T1S PHY cable test.
+ * This function reads the OATC14 HDD register to determine whether the test
+ * results are valid and whether the test has finished.
+ *
+ * If the test is complete, the function reports the cable test result via
+ * the ethtool cable test interface using ethnl_cable_test_result(), and then
+ * clears the test control bit in the PHY register to reset the test state.
+ *
+ * Return: 0 on success, or a negative error code on failure (e.g. register
+ *         read/write error).
+ */
+int genphy_c45_oatc14_cable_test_get_status(struct phy_device *phydev,
+					    bool *finished)
+{
+	int ret;
+	u8 sts;
+
+	*finished = false;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_HDD);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & OATC14_HDD_VALID))
+		return 0;
+
+	*finished = true;
+
+	sts = FIELD_GET(OATC14_HDD_SHORT_OPEN_STATUS, ret);
+
+	ret = ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+				      oatc14_cable_test_get_result_code(sts));
+	if (ret)
+		return ret;
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
+				  MDIO_OATC14_HDD, OATC14_HDD_CONTROL);
+}
+EXPORT_SYMBOL(genphy_c45_oatc14_cable_test_get_status);
+
+/**
+ * genphy_c45_oatc14_cable_test_start - Start a cable test on an OATC14
+ *                                      10Base-T1S PHY.
+ * @phydev: Pointer to the PHY device structure
+ *
+ * This function initiates a cable diagnostic test on a Clause 45 OATC14
+ * 10Base-T1S capable PHY device. It first reads the PHY’s advanced diagnostic
+ * capability register to check if High Definition Diagnostics (HDD) mode is
+ * supported. If the PHY does not report HDD capability, cable testing is not
+ * supported and the function returns -EOPNOTSUPP.
+ *
+ * For PHYs that support HDD, the function sets the appropriate control bits in
+ * the OATC14_HDD register to enable and start the cable diagnostic test.
+ *
+ * Return:
+ * * 0 on success
+ * * -EOPNOTSUPP if the PHY does not support HDD capability
+ * * A negative error code on I/O or register access failures
+ */
+int genphy_c45_oatc14_cable_test_start(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_ADFCAP);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & OATC14_ADFCAP_HDD_CAPABILITY))
+		return -EOPNOTSUPP;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_HDD,
+			       OATC14_HDD_CONTROL);
+	if (ret)
+		return ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_HDD);
+	if (ret < 0)
+		return ret;
+
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_HDD,
+				OATC14_HDD_START_CONTROL);
+}
+EXPORT_SYMBOL(genphy_c45_oatc14_cable_test_start);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e3474f03cbc1..36457879c677 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2251,6 +2251,9 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data);
 int genphy_c45_an_config_eee_aneg(struct phy_device *phydev);
+int genphy_c45_oatc14_cable_test_start(struct phy_device *phydev);
+int genphy_c45_oatc14_cable_test_get_status(struct phy_device *phydev,
+					    bool *finished);
 
 /* The gen10g_* functions are the old Clause 45 stub */
 int gen10g_config_aneg(struct phy_device *phydev);
-- 
2.34.1


