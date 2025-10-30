Return-Path: <netdev+bounces-234289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9EC1EDB0
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB173ACD07
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA612FD66B;
	Thu, 30 Oct 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RKRZ8ljE"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F98F5B;
	Thu, 30 Oct 2025 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810766; cv=none; b=cWpEK2Qz6oyQGYG6LSZBkzArRFSZWVummpgmqirteJ177niTbsIz29MaYvUy6eV7tbuXCjJ4M0ixt/yQFrZCi5f9xi3CyrzfER6wBq1y0zKpmQnaPh89rIybNNtBnzegKjymt956cTp1ED31zrM8gCJp0k2NVH8yDh3drMoHXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810766; c=relaxed/simple;
	bh=4brPCS6Z+GhMLQ+QXdncx2uLcqx1yYNpz/2tWj5/whk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r39gYlbhkuUfU1SMGlVmQ5hOIMceuzj55H1w8jw/y3Rm/HbpvbPBEvDlY5BFGOLrF3N8EopK5jzZMjO2fBMQi1DuT9f1xV8WQc4W9JdHZWoJ+Cuklp1bAUnOvq6TGbN8YlWnsEyCoyyXVSpubQ+oV2UO/JkFoVRIENQ5TEss50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RKRZ8ljE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761810765; x=1793346765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4brPCS6Z+GhMLQ+QXdncx2uLcqx1yYNpz/2tWj5/whk=;
  b=RKRZ8ljEKx7Bn4rZ4Vz0EPwiVwoIUnh5ZiNfHldMd5Si7mfX1rgBL201
   TBtvMhRZ0iV8oRIj69ZP5NZmWE6QGKsFqjQUsqlmv1fpjsSFVoJpvjP7C
   TFw+BeFxhXgm17EWL7nbS3OvUZlVOsEi5/w6SYM9y0dIC6fLVxQmZL0Y9
   eRnTqMUpICEr0B8mjQ1pb8VWI7jU8Bpwf42Df+kpHS5Xu3LZU+sqtZpnA
   qSLLrHxGVjhROSeaOzJVV0ZbniGKf2ZPmkvekrTEzYg4TIk6QRwSL9Vsz
   NeOKw5Lc5fFHWrbtTpQBS5JLxdIjPHDxIee0lY0F+1sBOdPFHGoYKZr0R
   A==;
X-CSE-ConnectionGUID: GIlKJHtsT5WfM3AzSiISvg==
X-CSE-MsgGUID: saPEV6GpTTSfiOHD5Sbi4A==
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="54760039"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:52:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 30 Oct 2025 00:52:30 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 30 Oct 2025 00:52:28 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v3 2/2] net: phy: micrel: lan8842 errata
Date: Thu, 30 Oct 2025 08:49:41 +0100
Message-ID: <20251030074941.611454-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030074941.611454-1-horatiu.vultur@microchip.com>
References: <20251030074941.611454-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add errata for lan8842. The errata document can be found here [1].
This is fixing the module 7 ("1000BASE-T PMA EEE TX wake PHY-side shorted
center taps")

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN8842-Errata-DS80001172.pdf

Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 504c715b7db90..b0f5941fddb0a 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2835,6 +2835,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
  */
 #define LAN8814_PAGE_PCS_DIGITAL 2
 
+/**
+ * LAN8814_PAGE_EEE - Selects Extended Page 3.
+ *
+ * This page contains EEE registers
+ */
+#define LAN8814_PAGE_EEE 3
+
 /**
  * LAN8814_PAGE_COMMON_REGS - Selects Extended Page 4.
  *
@@ -5952,6 +5959,9 @@ static int lan8842_probe(struct phy_device *phydev)
 
 #define LAN8814_POWER_MGMT_VAL5		LAN8814_POWER_MGMT_B_C_D
 
+#define LAN8814_EEE_WAKE_TX_TIMER			0x0e
+#define LAN8814_EEE_WAKE_TX_TIMER_MAX_VAL		0x1f
+
 static int lan8842_erratas(struct phy_device *phydev)
 {
 	int ret;
@@ -6023,9 +6033,16 @@ static int lan8842_erratas(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	return lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
-				     LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX,
-				     LAN8814_POWER_MGMT_VAL4);
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX,
+				    LAN8814_POWER_MGMT_VAL4);
+	if (ret < 0)
+		return ret;
+
+	/* Refresh time Waketx timer */
+	return lanphy_write_page_reg(phydev, LAN8814_PAGE_EEE,
+				     LAN8814_EEE_WAKE_TX_TIMER,
+				     LAN8814_EEE_WAKE_TX_TIMER_MAX_VAL);
 }
 
 static int lan8842_config_init(struct phy_device *phydev)
-- 
2.34.1


