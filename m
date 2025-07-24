Return-Path: <netdev+bounces-209871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1CAB11205
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A31AC1D0D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF2251791;
	Thu, 24 Jul 2025 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ICfBrqkt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823D23AE9B;
	Thu, 24 Jul 2025 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387933; cv=none; b=QHjHYpIiQ/yFJwKj/fIrMGQndTonau/vF/UEP8Xrsp9kx5drJvW8rMDfszEhD1hMRxfDo/1mLC+r9LHUriE2D9dNNNDqyMkOBZ6+c+2GWSL7C1hmY4FruTVBNTsTdt1zd6vsf9YRFeXcmaMn8paH7HJfEr6wk/fam8kKXbe1lNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387933; c=relaxed/simple;
	bh=GMIymy25u9kFoZzqYvxz36izeA7dOlt3OQSsOvguYHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAMx51v9PO2CPncCi/yR/z4dYI8+Vh9JPyeou46y1ogM8CtngZCulXTMMSlDn92BDLq4o+o8ThX8JhIQp125uL19J+9/zLCHbaQqaJIxh5vOrCaPlhw7QyMBwtUmZusl+AbFpQQBAusS81kFvc9Q+6uv8Y6YEe6Z3ZxVLJhxTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ICfBrqkt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753387931; x=1784923931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GMIymy25u9kFoZzqYvxz36izeA7dOlt3OQSsOvguYHk=;
  b=ICfBrqkt3eJWc1YBunJHlLgR774zL8dw2Zj6CCy6Skycx/zSf3ibWIot
   +vQWEIz+RifqRLoCCht9c+F3RB0n7hZ8h4zqB8u81n42DWDakW9E+/k1u
   HO/mZ8rBThoeorkomZfi4bszc9+/9vrNCxAO1MZmVlaiCrGrnSU9iJ+7C
   vLg9CGY4Z30b1vOoR71Krk2WB9lNY1Pof/272Y4iMDX7QrH3yt7NdwVlT
   S6DJ6cudrIiKRAkFR+blrvokPylr5ZxRX0h4mWthljfXavGiI4da2ojMl
   9FjhkpXS1DVcx5BCmjaqVS4a47VwdEYc004Ux5ndGUA0S1ZW875T7XNEJ
   g==;
X-CSE-ConnectionGUID: dPxjunYJTo2XkJR5vJWM1w==
X-CSE-MsgGUID: NSk2ggX+TqKYDzh38OBD+g==
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="44383322"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 13:12:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 13:11:35 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 24 Jul 2025 13:11:33 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 3/4] net: phy: micrel: Replace hardcoded pages with defines
Date: Thu, 24 Jul 2025 22:08:25 +0200
Message-ID: <20250724200826.2662658-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The functions lan_*_page_reg gets as a second parameter the page
where the register is. In all the functions the page was hardcoded.
Replace the hardcoded values with defines to make it more clear
what are those parameters.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 291 +++++++++++++++++++++++++--------------
 1 file changed, 185 insertions(+), 106 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index b04c471c11a4a..d20f028106b7d 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2788,6 +2788,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
 	return ret;
 }
 
+#define LAN_EXT_PAGE_0					0
+#define LAN_EXT_PAGE_1					1
+#define LAN_EXT_PAGE_2					2
+#define LAN_EXT_PAGE_4					4
+#define LAN_EXT_PAGE_5					5
+#define LAN_EXT_PAGE_31					31
+
 #define LAN_EXT_PAGE_ACCESS_CONTROL			0x16
 #define LAN_EXT_PAGE_ACCESS_ADDRESS_DATA		0x17
 #define LAN_EXT_PAGE_ACCESS_CTRL_EP_FUNC		0x4000
@@ -2866,35 +2873,46 @@ static int lan8814_config_ts_intr(struct phy_device *phydev, bool enable)
 		      PTP_TSU_INT_EN_PTP_RX_TS_EN_ |
 		      PTP_TSU_INT_EN_PTP_RX_TS_OVRFL_EN_;
 
-	return lanphy_write_page_reg(phydev, 5, PTP_TSU_INT_EN, val);
+	return lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5, PTP_TSU_INT_EN,
+				     val);
 }
 
 static void lan8814_ptp_rx_ts_get(struct phy_device *phydev,
 				  u32 *seconds, u32 *nano_seconds, u16 *seq_id)
 {
-	*seconds = lanphy_read_page_reg(phydev, 5, PTP_RX_INGRESS_SEC_HI);
+	*seconds = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+					PTP_RX_INGRESS_SEC_HI);
 	*seconds = (*seconds << 16) |
-		   lanphy_read_page_reg(phydev, 5, PTP_RX_INGRESS_SEC_LO);
+		   lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+					PTP_RX_INGRESS_SEC_LO);
 
-	*nano_seconds = lanphy_read_page_reg(phydev, 5, PTP_RX_INGRESS_NS_HI);
+	*nano_seconds = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5
+					     , PTP_RX_INGRESS_NS_HI);
 	*nano_seconds = ((*nano_seconds & 0x3fff) << 16) |
-			lanphy_read_page_reg(phydev, 5, PTP_RX_INGRESS_NS_LO);
+			lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+					     PTP_RX_INGRESS_NS_LO);
 
-	*seq_id = lanphy_read_page_reg(phydev, 5, PTP_RX_MSG_HEADER2);
+	*seq_id = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+				       PTP_RX_MSG_HEADER2);
 }
 
 static void lan8814_ptp_tx_ts_get(struct phy_device *phydev,
 				  u32 *seconds, u32 *nano_seconds, u16 *seq_id)
 {
-	*seconds = lanphy_read_page_reg(phydev, 5, PTP_TX_EGRESS_SEC_HI);
+	*seconds = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+					PTP_TX_EGRESS_SEC_HI);
 	*seconds = *seconds << 16 |
-		   lanphy_read_page_reg(phydev, 5, PTP_TX_EGRESS_SEC_LO);
+		   lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+					PTP_TX_EGRESS_SEC_LO);
 
-	*nano_seconds = lanphy_read_page_reg(phydev, 5, PTP_TX_EGRESS_NS_HI);
+	*nano_seconds = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+					     PTP_TX_EGRESS_NS_HI);
 	*nano_seconds = ((*nano_seconds & 0x3fff) << 16) |
-			lanphy_read_page_reg(phydev, 5, PTP_TX_EGRESS_NS_LO);
+			lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+					     PTP_TX_EGRESS_NS_LO);
 
-	*seq_id = lanphy_read_page_reg(phydev, 5, PTP_TX_MSG_HEADER2);
+	*seq_id = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+				       PTP_TX_MSG_HEADER2);
 }
 
 static int lan8814_ts_info(struct mii_timestamper *mii_ts, struct kernel_ethtool_ts_info *info)
@@ -2928,11 +2946,11 @@ static void lan8814_flush_fifo(struct phy_device *phydev, bool egress)
 	int i;
 
 	for (i = 0; i < FIFO_SIZE; ++i)
-		lanphy_read_page_reg(phydev, 5,
+		lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
 				     egress ? PTP_TX_MSG_HEADER2 : PTP_RX_MSG_HEADER2);
 
 	/* Read to clear overflow status bit */
-	lanphy_read_page_reg(phydev, 5, PTP_TSU_INT_STS);
+	lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5, PTP_TSU_INT_STS);
 }
 
 static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
@@ -2982,20 +3000,26 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
 		rxcfg |= PTP_RX_PARSE_CONFIG_IPV4_EN_ | PTP_RX_PARSE_CONFIG_IPV6_EN_;
 		txcfg |= PTP_TX_PARSE_CONFIG_IPV4_EN_ | PTP_TX_PARSE_CONFIG_IPV6_EN_;
 	}
-	lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_RX_PARSE_CONFIG, rxcfg);
-	lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_PARSE_CONFIG, txcfg);
+	lanphy_write_page_reg(ptp_priv->phydev, LAN_EXT_PAGE_5,
+			      PTP_RX_PARSE_CONFIG, rxcfg);
+	lanphy_write_page_reg(ptp_priv->phydev, LAN_EXT_PAGE_5,
+			      PTP_TX_PARSE_CONFIG, txcfg);
 
 	pkt_ts_enable = PTP_TIMESTAMP_EN_SYNC_ | PTP_TIMESTAMP_EN_DREQ_ |
 			PTP_TIMESTAMP_EN_PDREQ_ | PTP_TIMESTAMP_EN_PDRES_;
-	lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_RX_TIMESTAMP_EN, pkt_ts_enable);
-	lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_TIMESTAMP_EN, pkt_ts_enable);
+	lanphy_write_page_reg(ptp_priv->phydev, LAN_EXT_PAGE_5,
+			      PTP_RX_TIMESTAMP_EN, pkt_ts_enable);
+	lanphy_write_page_reg(ptp_priv->phydev, LAN_EXT_PAGE_5,
+			      PTP_TX_TIMESTAMP_EN, pkt_ts_enable);
 
 	if (ptp_priv->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC) {
-		lanphy_modify_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD,
+		lanphy_modify_page_reg(ptp_priv->phydev, LAN_EXT_PAGE_5,
+				       PTP_TX_MOD,
 				       PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_,
 				       PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_);
 	} else if (ptp_priv->hwts_tx_type == HWTSTAMP_TX_ON) {
-		lanphy_modify_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD,
+		lanphy_modify_page_reg(ptp_priv->phydev, LAN_EXT_PAGE_5,
+				       PTP_TX_MOD,
 				       PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_,
 				       0);
 	}
@@ -3119,29 +3143,41 @@ static bool lan8814_rxtstamp(struct mii_timestamper *mii_ts, struct sk_buff *skb
 static void lan8814_ptp_clock_set(struct phy_device *phydev,
 				  time64_t sec, u32 nsec)
 {
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_LO, lower_16_bits(sec));
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_MID, upper_16_bits(sec));
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_HI, upper_32_bits(sec));
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_LO, lower_16_bits(nsec));
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_HI, upper_16_bits(nsec));
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CLOCK_SET_SEC_LO,
+			      lower_16_bits(sec));
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CLOCK_SET_SEC_MID,
+			      upper_16_bits(sec));
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CLOCK_SET_SEC_HI,
+			      upper_32_bits(sec));
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CLOCK_SET_NS_LO,
+			      lower_16_bits(nsec));
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CLOCK_SET_NS_HI,
+			      upper_16_bits(nsec));
 
-	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_CLOCK_LOAD_);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CMD_CTL,
+			      PTP_CMD_CTL_PTP_CLOCK_LOAD_);
 }
 
 static void lan8814_ptp_clock_get(struct phy_device *phydev,
 				  time64_t *sec, u32 *nsec)
 {
-	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_CLOCK_READ_);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CMD_CTL,
+			      PTP_CMD_CTL_PTP_CLOCK_READ_);
 
-	*sec = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_HI);
+	*sec = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+				    PTP_CLOCK_READ_SEC_HI);
 	*sec <<= 16;
-	*sec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_MID);
+	*sec |= lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+				     PTP_CLOCK_READ_SEC_MID);
 	*sec <<= 16;
-	*sec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_LO);
+	*sec |= lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+				     PTP_CLOCK_READ_SEC_LO);
 
-	*nsec = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_HI);
+	*nsec = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+				     PTP_CLOCK_READ_NS_HI);
 	*nsec <<= 16;
-	*nsec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_LO);
+	*nsec |= lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+				      PTP_CLOCK_READ_NS_LO);
 }
 
 static int lan8814_ptpci_gettime64(struct ptp_clock_info *ptpci,
@@ -3180,14 +3216,18 @@ static void lan8814_ptp_set_target(struct phy_device *phydev, int event,
 				   s64 start_sec, u32 start_nsec)
 {
 	/* Set the start time */
-	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_CLOCK_TARGET_SEC_LO(event),
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+			      LAN8814_PTP_CLOCK_TARGET_SEC_LO(event),
 			      lower_16_bits(start_sec));
-	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_CLOCK_TARGET_SEC_HI(event),
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+			      LAN8814_PTP_CLOCK_TARGET_SEC_HI(event),
 			      upper_16_bits(start_sec));
 
-	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_CLOCK_TARGET_NS_LO(event),
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+			      LAN8814_PTP_CLOCK_TARGET_NS_LO(event),
 			      lower_16_bits(start_nsec));
-	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_CLOCK_TARGET_NS_HI(event),
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+			      LAN8814_PTP_CLOCK_TARGET_NS_HI(event),
 			      upper_16_bits(start_nsec) & 0x3fff);
 }
 
@@ -3285,9 +3325,11 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 			adjustment_value_lo = adjustment_value & 0xffff;
 			adjustment_value_hi = (adjustment_value >> 16) & 0x3fff;
 
-			lanphy_write_page_reg(phydev, 4, PTP_LTC_STEP_ADJ_LO,
+			lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+					      PTP_LTC_STEP_ADJ_LO,
 					      adjustment_value_lo);
-			lanphy_write_page_reg(phydev, 4, PTP_LTC_STEP_ADJ_HI,
+			lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+					      PTP_LTC_STEP_ADJ_HI,
 					      PTP_LTC_STEP_ADJ_DIR_ |
 					      adjustment_value_hi);
 			seconds -= ((s32)adjustment_value);
@@ -3305,9 +3347,11 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 			adjustment_value_lo = adjustment_value & 0xffff;
 			adjustment_value_hi = (adjustment_value >> 16) & 0x3fff;
 
-			lanphy_write_page_reg(phydev, 4, PTP_LTC_STEP_ADJ_LO,
+			lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+					      PTP_LTC_STEP_ADJ_LO,
 					      adjustment_value_lo);
-			lanphy_write_page_reg(phydev, 4, PTP_LTC_STEP_ADJ_HI,
+			lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+					      PTP_LTC_STEP_ADJ_HI,
 					      adjustment_value_hi);
 			seconds += ((s32)adjustment_value);
 
@@ -3315,7 +3359,7 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 			set_seconds += adjustment_value;
 			lan8814_ptp_update_target(phydev, set_seconds);
 		}
-		lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL,
+		lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CMD_CTL,
 				      PTP_CMD_CTL_PTP_LTC_STEP_SEC_);
 	}
 	if (nano_seconds) {
@@ -3325,12 +3369,14 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 		nano_seconds_lo = nano_seconds & 0xffff;
 		nano_seconds_hi = (nano_seconds >> 16) & 0x3fff;
 
-		lanphy_write_page_reg(phydev, 4, PTP_LTC_STEP_ADJ_LO,
+		lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+				      PTP_LTC_STEP_ADJ_LO,
 				      nano_seconds_lo);
-		lanphy_write_page_reg(phydev, 4, PTP_LTC_STEP_ADJ_HI,
+		lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+				      PTP_LTC_STEP_ADJ_HI,
 				      PTP_LTC_STEP_ADJ_DIR_ |
 				      nano_seconds_hi);
-		lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL,
+		lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CMD_CTL,
 				      PTP_CMD_CTL_PTP_LTC_STEP_NSEC_);
 	}
 }
@@ -3372,8 +3418,10 @@ static int lan8814_ptpci_adjfine(struct ptp_clock_info *ptpci, long scaled_ppm)
 		kszphy_rate_adj_hi |= PTP_CLOCK_RATE_ADJ_DIR_;
 
 	mutex_lock(&shared->shared_lock);
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_RATE_ADJ_HI, kszphy_rate_adj_hi);
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_RATE_ADJ_LO, kszphy_rate_adj_lo);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CLOCK_RATE_ADJ_HI,
+			      kszphy_rate_adj_hi);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CLOCK_RATE_ADJ_LO,
+			      kszphy_rate_adj_lo);
 	mutex_unlock(&shared->shared_lock);
 
 	return 0;
@@ -3382,17 +3430,17 @@ static int lan8814_ptpci_adjfine(struct ptp_clock_info *ptpci, long scaled_ppm)
 static void lan8814_ptp_set_reload(struct phy_device *phydev, int event,
 				   s64 period_sec, u32 period_nsec)
 {
-	lanphy_write_page_reg(phydev, 4,
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
 			      LAN8814_PTP_CLOCK_TARGET_RELOAD_SEC_LO(event),
 			      lower_16_bits(period_sec));
-	lanphy_write_page_reg(phydev, 4,
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
 			      LAN8814_PTP_CLOCK_TARGET_RELOAD_SEC_HI(event),
 			      upper_16_bits(period_sec));
 
-	lanphy_write_page_reg(phydev, 4,
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
 			      LAN8814_PTP_CLOCK_TARGET_RELOAD_NS_LO(event),
 			      lower_16_bits(period_nsec));
-	lanphy_write_page_reg(phydev, 4,
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
 			      LAN8814_PTP_CLOCK_TARGET_RELOAD_NS_HI(event),
 			      upper_16_bits(period_nsec) & 0x3fff);
 }
@@ -3405,7 +3453,7 @@ static void lan8814_ptp_enable_event(struct phy_device *phydev, int event,
 	 * local time reaches or pass it
 	 * Set the polarity high
 	 */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4, LAN8814_PTP_GENERAL_CONFIG,
 			       LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_MASK(event) |
 			       LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_SET(event, pulse_width) |
 			       LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event) |
@@ -3420,7 +3468,7 @@ static void lan8814_ptp_disable_event(struct phy_device *phydev, int event)
 	lan8814_ptp_set_target(phydev, event, 0xFFFFFFFF, 0);
 
 	/* And then reload once it recheas the target */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4, LAN8814_PTP_GENERAL_CONFIG,
 			       LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event),
 			       LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event));
 }
@@ -3431,15 +3479,18 @@ static void lan8814_ptp_perout_off(struct phy_device *phydev, int pin)
 	 * 1: select as gpio,
 	 * 0: select alt func
 	 */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin),
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_GPIO_EN_ADDR(pin),
 			       LAN8814_GPIO_EN_BIT(pin),
 			       LAN8814_GPIO_EN_BIT(pin));
 
-	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin),
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_GPIO_DIR_ADDR(pin),
 			       LAN8814_GPIO_DIR_BIT(pin),
 			       0);
 
-	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin),
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_GPIO_BUF_ADDR(pin),
 			       LAN8814_GPIO_BUF_BIT(pin),
 			       0);
 }
@@ -3447,17 +3498,20 @@ static void lan8814_ptp_perout_off(struct phy_device *phydev, int pin)
 static void lan8814_ptp_perout_on(struct phy_device *phydev, int pin)
 {
 	/* Set as gpio output */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin),
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_GPIO_DIR_ADDR(pin),
 			       LAN8814_GPIO_DIR_BIT(pin),
 			       LAN8814_GPIO_DIR_BIT(pin));
 
 	/* Enable gpio 0:for alternate function, 1:gpio */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin),
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_GPIO_EN_ADDR(pin),
 			       LAN8814_GPIO_EN_BIT(pin),
 			       0);
 
 	/* Set buffer type to push pull */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin),
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_GPIO_BUF_ADDR(pin),
 			       LAN8814_GPIO_BUF_BIT(pin),
 			       LAN8814_GPIO_BUF_BIT(pin));
 }
@@ -3575,27 +3629,28 @@ static int lan8814_ptp_perout(struct ptp_clock_info *ptpci,
 static void lan8814_ptp_extts_on(struct phy_device *phydev, int pin, u32 flags)
 {
 	/* Set as gpio input */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin),
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_GPIO_DIR_ADDR(pin),
 			       LAN8814_GPIO_DIR_BIT(pin),
 			       0);
 
 	/* Map the pin to ltc pin 0 of the capture map registers */
-	lanphy_modify_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4, PTP_GPIO_CAP_MAP_LO,
 			       pin,
 			       pin);
 
 	/* Enable capture on the edges of the ltc pin */
 	if (flags & PTP_RISING_EDGE)
-		lanphy_modify_page_reg(phydev, 4, PTP_GPIO_CAP_EN,
+		lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4, PTP_GPIO_CAP_EN,
 				       PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(0),
 				       PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(0));
 	if (flags & PTP_FALLING_EDGE)
-		lanphy_modify_page_reg(phydev, 4, PTP_GPIO_CAP_EN,
+		lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4, PTP_GPIO_CAP_EN,
 				       PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(0),
 				       PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(0));
 
 	/* Enable interrupt top interrupt */
-	lanphy_modify_page_reg(phydev, 4, PTP_COMMON_INT_ENA,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4, PTP_COMMON_INT_ENA,
 			       PTP_COMMON_INT_ENA_GPIO_CAP_EN,
 			       PTP_COMMON_INT_ENA_GPIO_CAP_EN);
 }
@@ -3603,28 +3658,31 @@ static void lan8814_ptp_extts_on(struct phy_device *phydev, int pin, u32 flags)
 static void lan8814_ptp_extts_off(struct phy_device *phydev, int pin)
 {
 	/* Set as gpio out */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin),
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_GPIO_DIR_ADDR(pin),
 			       LAN8814_GPIO_DIR_BIT(pin),
 			       LAN8814_GPIO_DIR_BIT(pin));
 
 	/* Enable alternate, 0:for alternate function, 1:gpio */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin),
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_GPIO_EN_ADDR(pin),
 			       LAN8814_GPIO_EN_BIT(pin),
 			       0);
 
 	/* Clear the mapping of pin to registers 0 of the capture registers */
-	lanphy_modify_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       PTP_GPIO_CAP_MAP_LO,
 			       GENMASK(3, 0),
 			       0);
 
 	/* Disable capture on both of the edges */
-	lanphy_modify_page_reg(phydev, 4, PTP_GPIO_CAP_EN,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4, PTP_GPIO_CAP_EN,
 			       PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(pin) |
 			       PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(pin),
 			       0);
 
 	/* Disable interrupt top interrupt */
-	lanphy_modify_page_reg(phydev, 4, PTP_COMMON_INT_ENA,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4, PTP_COMMON_INT_ENA,
 			       PTP_COMMON_INT_ENA_GPIO_CAP_EN,
 			       0);
 }
@@ -3756,7 +3814,8 @@ static void lan8814_get_tx_ts(struct kszphy_ptp_priv *ptp_priv)
 		/* If other timestamps are available in the FIFO,
 		 * process them.
 		 */
-		reg = lanphy_read_page_reg(phydev, 5, PTP_CAP_INFO);
+		reg = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+					   PTP_CAP_INFO);
 	} while (PTP_CAP_INFO_TX_TS_CNT_GET_(reg) > 0);
 }
 
@@ -3829,7 +3888,8 @@ static void lan8814_get_rx_ts(struct kszphy_ptp_priv *ptp_priv)
 		/* If other timestamps are available in the FIFO,
 		 * process them.
 		 */
-		reg = lanphy_read_page_reg(phydev, 5, PTP_CAP_INFO);
+		reg = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+					   PTP_CAP_INFO);
 	} while (PTP_CAP_INFO_RX_TS_CNT_GET_(reg) > 0);
 }
 
@@ -3866,31 +3926,39 @@ static int lan8814_gpio_process_cap(struct lan8814_shared_priv *shared)
 	/* This is 0 because whatever was the input pin it was mapped it to
 	 * ltc gpio pin 0
 	 */
-	lanphy_modify_page_reg(phydev, 4, PTP_GPIO_SEL,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4, PTP_GPIO_SEL,
 			       PTP_GPIO_SEL_GPIO_SEL(0),
 			       PTP_GPIO_SEL_GPIO_SEL(0));
 
-	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_STS);
+	tmp = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4, PTP_GPIO_CAP_STS);
 	if (!(tmp & PTP_GPIO_CAP_STS_PTP_GPIO_RE_STS(0)) &&
 	    !(tmp & PTP_GPIO_CAP_STS_PTP_GPIO_FE_STS(0)))
 		return -1;
 
 	if (tmp & BIT(0)) {
-		sec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_SEC_HI_CAP);
+		sec = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+					   PTP_GPIO_RE_LTC_SEC_HI_CAP);
 		sec <<= 16;
-		sec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_SEC_LO_CAP);
+		sec |= lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+					    PTP_GPIO_RE_LTC_SEC_LO_CAP);
 
-		nsec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_NS_HI_CAP) & 0x3fff;
+		nsec = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+					    PTP_GPIO_RE_LTC_NS_HI_CAP) & 0x3fff;
 		nsec <<= 16;
-		nsec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_NS_LO_CAP);
+		nsec |= lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+					     PTP_GPIO_RE_LTC_NS_LO_CAP);
 	} else {
-		sec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_FE_LTC_SEC_HI_CAP);
+		sec = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+					   PTP_GPIO_FE_LTC_SEC_HI_CAP);
 		sec <<= 16;
-		sec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_FE_LTC_SEC_LO_CAP);
+		sec |= lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+					    PTP_GPIO_FE_LTC_SEC_LO_CAP);
 
-		nsec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_FE_LTC_NS_HI_CAP) & 0x3fff;
+		nsec = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+					    PTP_GPIO_FE_LTC_NS_HI_CAP) & 0x3fff;
 		nsec <<= 16;
-		nsec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_NS_LO_CAP);
+		nsec |= lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4,
+					     PTP_GPIO_RE_LTC_NS_LO_CAP);
 	}
 
 	ptp_event.index = 0;
@@ -3916,15 +3984,16 @@ static int lan8814_handle_gpio_interrupt(struct phy_device *phydev, u16 status)
 static int lan8804_config_init(struct phy_device *phydev)
 {
 	/* MDI-X setting for swap A,B transmit */
-	lanphy_modify_page_reg(phydev, 2, LAN8804_ALIGN_SWAP,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_2, LAN8804_ALIGN_SWAP,
 			       LAN8804_ALIGN_TX_A_B_SWAP_MASK,
 			       LAN8804_ALIGN_TX_A_B_SWAP);
 
 	/* Make sure that the PHY will not stop generating the clock when the
 	 * link partner goes down
 	 */
-	lanphy_write_page_reg(phydev, 31, LAN8814_CLOCK_MANAGEMENT, 0x27e);
-	lanphy_read_page_reg(phydev, 1, LAN8814_LINK_QUALITY);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_31,
+			      LAN8814_CLOCK_MANAGEMENT, 0x27e);
+	lanphy_read_page_reg(phydev, LAN_EXT_PAGE_1, LAN8814_LINK_QUALITY);
 
 	return 0;
 }
@@ -4006,7 +4075,8 @@ static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
 	}
 
 	while (true) {
-		irq_status = lanphy_read_page_reg(phydev, 5, PTP_TSU_INT_STS);
+		irq_status = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5,
+						  PTP_TSU_INT_STS);
 		if (!irq_status)
 			break;
 
@@ -4034,7 +4104,7 @@ static int lan8814_config_intr(struct phy_device *phydev)
 {
 	int err;
 
-	lanphy_write_page_reg(phydev, 4, LAN8814_INTR_CTRL_REG,
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, LAN8814_INTR_CTRL_REG,
 			      LAN8814_INTR_CTRL_REG_POLARITY |
 			      LAN8814_INTR_CTRL_REG_INTR_ENABLE);
 
@@ -4065,29 +4135,34 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	    !IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING))
 		return;
 
-	lanphy_write_page_reg(phydev, 5, TSU_HARD_RESET, TSU_HARD_RESET_);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5,
+			      TSU_HARD_RESET, TSU_HARD_RESET_);
 
-	lanphy_modify_page_reg(phydev, 5, PTP_TX_MOD,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_5, PTP_TX_MOD,
 			       PTP_TX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_,
 			       PTP_TX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_);
 
-	lanphy_modify_page_reg(phydev, 5, PTP_RX_MOD,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_5, PTP_RX_MOD,
 			       PTP_RX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_,
 			       PTP_RX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_);
 
-	lanphy_write_page_reg(phydev, 5, PTP_RX_PARSE_CONFIG, 0);
-	lanphy_write_page_reg(phydev, 5, PTP_TX_PARSE_CONFIG, 0);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5, PTP_RX_PARSE_CONFIG, 0);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5, PTP_TX_PARSE_CONFIG, 0);
 
 	/* Removing default registers configs related to L2 and IP */
-	lanphy_write_page_reg(phydev, 5, PTP_TX_PARSE_L2_ADDR_EN, 0);
-	lanphy_write_page_reg(phydev, 5, PTP_RX_PARSE_L2_ADDR_EN, 0);
-	lanphy_write_page_reg(phydev, 5, PTP_TX_PARSE_IP_ADDR_EN, 0);
-	lanphy_write_page_reg(phydev, 5, PTP_RX_PARSE_IP_ADDR_EN, 0);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5,
+			      PTP_TX_PARSE_L2_ADDR_EN, 0);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5,
+			      PTP_RX_PARSE_L2_ADDR_EN, 0);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5,
+			      PTP_TX_PARSE_IP_ADDR_EN, 0);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5,
+			      PTP_RX_PARSE_IP_ADDR_EN, 0);
 
 	/* Disable checking for minorVersionPTP field */
-	lanphy_write_page_reg(phydev, 5, PTP_RX_VERSION,
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5, PTP_RX_VERSION,
 			      PTP_MAX_VERSION(0xff) | PTP_MIN_VERSION(0x0));
-	lanphy_write_page_reg(phydev, 5, PTP_TX_VERSION,
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5, PTP_TX_VERSION,
 			      PTP_MAX_VERSION(0xff) | PTP_MIN_VERSION(0x0));
 
 	skb_queue_head_init(&ptp_priv->tx_queue);
@@ -4172,12 +4247,14 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	/* The EP.4 is shared between all the PHYs in the package and also it
 	 * can be accessed by any of the PHYs
 	 */
-	lanphy_write_page_reg(phydev, 4, LTC_HARD_RESET, LTC_HARD_RESET_);
-	lanphy_write_page_reg(phydev, 4, PTP_OPERATING_MODE,
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+			      LTC_HARD_RESET, LTC_HARD_RESET_);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_OPERATING_MODE,
 			      PTP_OPERATING_MODE_STANDALONE_);
 
 	/* Enable ptp to run LTC clock for ptp and gpio 1PPS operation */
-	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_ENABLE_);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4, PTP_CMD_CTL,
+			      PTP_CMD_CTL_PTP_ENABLE_);
 
 	return 0;
 }
@@ -4186,14 +4263,14 @@ static void lan8814_setup_led(struct phy_device *phydev, int val)
 {
 	int temp;
 
-	temp = lanphy_read_page_reg(phydev, 5, LAN8814_LED_CTRL_1);
+	temp = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_5, LAN8814_LED_CTRL_1);
 
 	if (val)
 		temp |= LAN8814_LED_CTRL_1_KSZ9031_LED_MODE_;
 	else
 		temp &= ~LAN8814_LED_CTRL_1_KSZ9031_LED_MODE_;
 
-	lanphy_write_page_reg(phydev, 5, LAN8814_LED_CTRL_1, temp);
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_5, LAN8814_LED_CTRL_1, temp);
 }
 
 static int lan8814_config_init(struct phy_device *phydev)
@@ -4201,17 +4278,19 @@ static int lan8814_config_init(struct phy_device *phydev)
 	struct kszphy_priv *lan8814 = phydev->priv;
 
 	/* Reset the PHY */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_QSGMII_SOFT_RESET,
 			       LAN8814_QSGMII_SOFT_RESET_BIT,
 			       LAN8814_QSGMII_SOFT_RESET_BIT);
 
 	/* Disable ANEG with QSGMII PCS Host side */
-	lanphy_modify_page_reg(phydev, 4, LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
 			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA,
 			       0);
 
 	/* MDI-X setting for swap A,B transmit */
-	lanphy_modify_page_reg(phydev, 2, LAN8814_ALIGN_SWAP,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_2, LAN8814_ALIGN_SWAP,
 			       LAN8814_ALIGN_TX_A_B_SWAP_MASK,
 			       LAN8814_ALIGN_TX_A_B_SWAP);
 
@@ -4248,7 +4327,7 @@ static void lan8814_clear_2psp_bit(struct phy_device *phydev)
 	 * cable is removed then the LED was still one even though there is no
 	 * link
 	 */
-	lanphy_modify_page_reg(phydev, 2, LAN8814_EEE_STATE,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_2, LAN8814_EEE_STATE,
 			       LAN8814_EEE_STATE_MASK2P5P,
 			       0);
 }
@@ -4259,7 +4338,7 @@ static void lan8814_update_meas_time(struct phy_device *phydev)
 	 * longer than 100m to be used. This configuration can be used
 	 * regardless of the mode of operation of the PHY
 	 */
-	lanphy_modify_page_reg(phydev, 1, LAN8814_PD_CONTROLS,
+	lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_1, LAN8814_PD_CONTROLS,
 			       LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK,
 			       LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL);
 }
@@ -4284,7 +4363,7 @@ static int lan8814_probe(struct phy_device *phydev)
 	/* Strap-in value for PHY address, below register read gives starting
 	 * phy address value
 	 */
-	addr = lanphy_read_page_reg(phydev, 4, 0) & 0x1F;
+	addr = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_4, 0) & 0x1F;
 	devm_phy_package_join(&phydev->mdio.dev, phydev,
 			      addr, sizeof(struct lan8814_shared_priv));
 
-- 
2.34.1


