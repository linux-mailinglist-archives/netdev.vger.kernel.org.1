Return-Path: <netdev+bounces-113922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D84E94064A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E012283464
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0384516727B;
	Tue, 30 Jul 2024 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XPaENoqb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD018E1A;
	Tue, 30 Jul 2024 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312613; cv=none; b=fNuYU1+HAWHCk8CaX9TgOcofC6mHB9n7YmAi0spHQ3hK1iHVWCwAVM9PUvBSEet8pdPiMnUVZQEm5UWaVs5lfIH6+ctrg1tFeF8Mx00lKmV1DI2DZBFNkZJcfhrk/E+e9AAQKTKefyASigkZBTUYP2uxsIRs0C5TDibQ4s58dYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312613; c=relaxed/simple;
	bh=y4Gmu0+osrUXJKG6JYBX6EnYWRbGVMr2cbW5FtVqOAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHEn4wHJmZotpi6fC7t0Oh6cnor6WvHcwOM11CNznv+vObEuV4stboDZOXW5vSPB7obu7UbuT3BraW/jidEuqtZr7YsUquYd7y1Z0q3O940YM3S00fwKuXkpJYeUSzrm8H640SE9BdpfBUH4mKKRj0ZkDJZcQJXrTOh0QHXA+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XPaENoqb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722312612; x=1753848612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y4Gmu0+osrUXJKG6JYBX6EnYWRbGVMr2cbW5FtVqOAo=;
  b=XPaENoqbOd33mP745UBFQejpCHWsk79oEX5OPSkZzHUfXj+kE1uugY7U
   9AlI3Zy8HAo6SjNYLi3usNZFandyxJ7BkaoeHOR/j8SsF8++/j0nLtOLE
   BqgdHAlLuPZ290lYRi9MNDxxoAJdGsqrdyQDtNBbt7Cm/jm3NT4JGS9Ro
   +I7ElxYDGmHX5v3ouvzC+PMzAVsi8nNoLqWIDaRrz4MFG1Dwgbm/RVMiI
   F7mUjg99LYi0CeRC/J9jLjydgH9tj904fMEbWaKqKm8hutG0RyrEQC8Dv
   GRrXloNHf9BqBPItq74EmoYUZ9WOu+JZqHJgI6d7xktFulx5WkQq91a0O
   A==;
X-CSE-ConnectionGUID: qP/LMvA5SsS85cdahLETNw==
X-CSE-MsgGUID: BXu0f/8ASIijVTZeO/5RLg==
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="30501823"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 21:10:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 21:09:16 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 21:09:06 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v5 04/14] net: ethernet: oa_tc6: implement software reset
Date: Tue, 30 Jul 2024 09:38:56 +0530
Message-ID: <20240730040906.53779-5-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Reset complete bit is set when the MAC-PHY reset completes and ready for
configuration. Additionally reset complete bit in the STS0 register has
to be written by one upon reset complete to clear the interrupt.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 72bab9234436..f774ed397213 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -6,8 +6,18 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/iopoll.h>
 #include <linux/oa_tc6.h>
 
+/* OPEN Alliance TC6 registers */
+/* Reset Control and Status Register */
+#define OA_TC6_REG_RESET			0x0003
+#define RESET_SWRESET				BIT(0)	/* Software Reset */
+
+/* Status Register #0 */
+#define OA_TC6_REG_STATUS0			0x0008
+#define STATUS0_RESETC				BIT(6)	/* Reset Complete */
+
 /* Control command header */
 #define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
 #define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
@@ -24,6 +34,8 @@
 						(OA_TC6_CTRL_MAX_REGISTERS *\
 						OA_TC6_CTRL_REG_VALUE_SIZE) +\
 						OA_TC6_CTRL_IGNORED_SIZE)
+#define STATUS0_RESETC_POLL_DELAY		1000
+#define STATUS0_RESETC_POLL_TIMEOUT		1000000
 
 /* Internal structure for MAC-PHY drivers */
 struct oa_tc6 {
@@ -279,6 +291,42 @@ int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_write_register);
 
+static int oa_tc6_read_status0(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &regval);
+	if (ret) {
+		dev_err(&tc6->spi->dev, "STATUS0 register read failed: %d\n",
+			ret);
+		return 0;
+	}
+
+	return regval;
+}
+
+static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
+{
+	u32 regval = RESET_SWRESET;
+	int ret;
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_RESET, regval);
+	if (ret)
+		return ret;
+
+	/* Poll for soft reset complete for every 1ms until 1s timeout */
+	ret = readx_poll_timeout(oa_tc6_read_status0, tc6, regval,
+				 regval & STATUS0_RESETC,
+				 STATUS0_RESETC_POLL_DELAY,
+				 STATUS0_RESETC_POLL_TIMEOUT);
+	if (ret)
+		return -ENODEV;
+
+	/* Clear the reset complete status */
+	return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
+}
+
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
@@ -289,6 +337,7 @@ EXPORT_SYMBOL_GPL(oa_tc6_write_register);
 struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 {
 	struct oa_tc6 *tc6;
+	int ret;
 
 	tc6 = devm_kzalloc(&spi->dev, sizeof(*tc6), GFP_KERNEL);
 	if (!tc6)
@@ -313,6 +362,13 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 	if (!tc6->spi_ctrl_rx_buf)
 		return NULL;
 
+	ret = oa_tc6_sw_reset_macphy(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev,
+			"MAC-PHY software reset failed: %d\n", ret);
+		return NULL;
+	}
+
 	return tc6;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
-- 
2.34.1


