Return-Path: <netdev+bounces-127469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F4E97580B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E61282F04
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5061B29D8;
	Wed, 11 Sep 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SHSXdk7i"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA91AC454;
	Wed, 11 Sep 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071326; cv=none; b=dv+Az93aePueoV+hoIdJ/zpKLKpwh2EzKyl+kV8T02+4250k8M9vPncqPJhSAI/YNl33yRxOzNVJSxRYB/eD8rRPTrmHaBcGEKdqOf9PJuScGGaoa0XypinbyY7r1wncJIs2wQ//6BTvW7Lh4bQ16Mj0VmD42WilM2rbKKZBUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071326; c=relaxed/simple;
	bh=sIvyob1olP4zFEKTbhbc5N7sm72ACzP8pnPALstswF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmB1Zi4jP0Q+l4WM4TiQAw+e4pFh5KmSXhUMYAQoIQp6eif8RuwxGFuTxgud1VkNblMWHPffEh4f8HMYY1lcddsgOoe+cz/pVT1wJCUhC4GyYwcg28sZXexPNmEsOq470gh0XSuY3nXAwVLUxt1a5U+pE00HljcwvGwS3Q5IpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SHSXdk7i; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726071325; x=1757607325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sIvyob1olP4zFEKTbhbc5N7sm72ACzP8pnPALstswF4=;
  b=SHSXdk7irajcF5s41M3Zs+Kt5sKCsOq6uiCwSgCvbcBV3QlZrF80kNXY
   /KvNhm5MOSEvJiY4rhJjQSOwiTaKgS+sZoX2kMdnf0QK66EJfCuPAPndk
   Tnh7Dd+ZZLZb6NJdMhK+TsDYEpQ68YesZDh4ldQCNz5hlXL+6iTSmUMmp
   A1i+deAhMXZQcDQMbD4E4mwzzhIqiWmjYS7O4QUC0wWz5v0HSSVkk+sCK
   6YyvJh00Q0Q5YLjvsdp6fElxhOREse1cSYlxUE656zfFtpiCdQpvLbPUV
   QHWHKt7bPWx4fxqz4XVezt7KnIK/kjwqyuAE6SFiRONz5Sm8BZwCNWN2K
   g==;
X-CSE-ConnectionGUID: 2nHLmdpiRE6ZQX98BGaY/g==
X-CSE-MsgGUID: Q0BdccpkScySrlrlOaP5kQ==
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="262640538"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 09:15:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 09:14:55 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 09:14:50 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>, <andrew@lunn.ch>,
	<Steen.Hegelund@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Date: Wed, 11 Sep 2024 21:40:50 +0530
Message-ID: <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Support for SFP in the PCI11x1x devices is indicated by the "is_sfp_support_en"
flag in the STRAP register. This register is loaded at power up from the
PCI11x1x EEPROM contents (which specify the board configuration).

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
============
V1 -> V2:
  - Change variable name from "chip_rev" to "fpga_rev" 
V0 -> V1:
  - No changes

 drivers/net/ethernet/microchip/lan743x_main.c | 34 +++++++++++++++----
 drivers/net/ethernet/microchip/lan743x_main.h |  3 ++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 4dc5adcda6a3..20a42a2c7b0e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -28,9 +28,9 @@
 
 #define RFE_RD_FIFO_TH_3_DWORDS	0x3
 
-static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
+static int pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 {
-	u32 chip_rev;
+	u32 fpga_rev;
 	u32 cfg_load;
 	u32 hw_cfg;
 	u32 strap;
@@ -41,7 +41,7 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 	if (ret < 0) {
 		netif_err(adapter, drv, adapter->netdev,
 			  "Sys Lock acquire failed ret:%d\n", ret);
-		return;
+		return ret;
 	}
 
 	cfg_load = lan743x_csr_read(adapter, ETH_SYS_CONFIG_LOAD_STARTED_REG);
@@ -55,10 +55,15 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_sgmii_en = true;
 		else
 			adapter->is_sgmii_en = false;
+
+		if ((strap & STRAP_SFP_USE_EN_) && (strap & STRAP_SFP_EN_))
+			adapter->is_sfp_support_en = true;
+		else
+			adapter->is_sfp_support_en = false;
 	} else {
-		chip_rev = lan743x_csr_read(adapter, FPGA_REV);
-		if (chip_rev) {
-			if (chip_rev & FPGA_SGMII_OP)
+		fpga_rev = lan743x_csr_read(adapter, FPGA_REV);
+		if (fpga_rev) {
+			if (fpga_rev & FPGA_SGMII_OP)
 				adapter->is_sgmii_en = true;
 			else
 				adapter->is_sgmii_en = false;
@@ -66,8 +71,21 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_sgmii_en = false;
 		}
 	}
+
+	if (adapter->is_pci11x1x && !adapter->is_sgmii_en &&
+	    adapter->is_sfp_support_en) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "Invalid eeprom cfg: sfp enabled with sgmii disabled");
+		return -EINVAL;
+	}
+
 	netif_dbg(adapter, drv, adapter->netdev,
 		  "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "SFP support %sable\n", adapter->is_sfp_support_en ?
+		  "En" : "Dis");
+
+	return 0;
 }
 
 static bool is_pci11x1x_chip(struct lan743x_adapter *adapter)
@@ -3470,7 +3488,9 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 		adapter->max_tx_channels = PCI11X1X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = PCI11X1X_USED_TX_CHANNELS;
 		adapter->max_vector_count = PCI11X1X_MAX_VECTOR_COUNT;
-		pci11x1x_strap_get_status(adapter);
+		ret = pci11x1x_strap_get_status(adapter);
+		if (ret < 0)
+			return ret;
 		spin_lock_init(&adapter->eth_syslock_spinlock);
 		mutex_init(&adapter->sgmii_rw_lock);
 		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 8ef897c114d3..f7e96496600b 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -36,6 +36,8 @@
 
 #define STRAP_READ			(0x0C)
 #define STRAP_READ_USE_SGMII_EN_	BIT(22)
+#define STRAP_SFP_USE_EN_		BIT(31)
+#define STRAP_SFP_EN_			BIT(15)
 #define STRAP_READ_SGMII_EN_		BIT(6)
 #define STRAP_READ_SGMII_REFCLK_	BIT(5)
 #define STRAP_READ_SGMII_2_5G_		BIT(4)
@@ -1079,6 +1081,7 @@ struct lan743x_adapter {
 	u8			max_tx_channels;
 	u8			used_tx_channels;
 	u8			max_vector_count;
+	bool			is_sfp_support_en;
 
 #define LAN743X_ADAPTER_FLAG_OTP		BIT(0)
 	u32			flags;
-- 
2.34.1


