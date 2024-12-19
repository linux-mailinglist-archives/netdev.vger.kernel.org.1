Return-Path: <netdev+bounces-153341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443EB9F7B5A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF7C16AB73
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD61A225A27;
	Thu, 19 Dec 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QiUX68CD"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6B223C75;
	Thu, 19 Dec 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611435; cv=none; b=BBp25IYPKvPnpVnax8AXEgYfBMGm7i7jtXMMgGABPQGFgcWtr7SpNzpptZ2jFuh8hd3+FK9VMNiXkyKhLWzrYSuq2Y5XtMobiwZL+aHfjBrENLHjjR6hAxmmR9xoPG24WHdEI/A+MORZBt4MWT3az+SOLxRD3zIL973A1hg6hnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611435; c=relaxed/simple;
	bh=emVFLeUK36XPU3M9V1J97G+XnPSJmt0puuRX/cqOKL8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0FasPm5/oM2iqNrwcuafFBMle0C7IFVgJpOvIskwdYgBvVqte1BHwW2GBZ22xFHI1rM0OzJFhh6Zwux1IwjIaOj4ftEQTGB2R93u23Y7WOshOZ//fjCNql+2nJR5iCptty+lA8Re38RJublJpjXhy8eIM8GCZxZSr5A25ztnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QiUX68CD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734611433; x=1766147433;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=emVFLeUK36XPU3M9V1J97G+XnPSJmt0puuRX/cqOKL8=;
  b=QiUX68CDA6VH3os48+cN7N+EiVl/JjIW3YB960zvX/ndwvqX+WJMgEvt
   Dc7vY/S8mwWBv0zfve0yXmj6kTyRh8z11lYshTMhD77oQfMGnIOl+3h7D
   6wJBrXEELWNWli56xenkGN+DD0QmLv8wKO0hoiGSrf0QJw7a5y+NvnpEN
   n3TLoXnhE/vo8P+rY4paC608+mF6XzjHlfO3EpqDrGS6UbJ+zh4qWyVoy
   TplyczfbWk7CcMLvZruWMpsXvbRTpxL4Y5/p/s3xOFYlA4jhUR1N9QxKi
   GaBhaE16fJR4bSXUrk9EID2XyPdAh0jaKMwx8WwDE95/J5X99sXJmVSar
   g==;
X-CSE-ConnectionGUID: fAJcK6EDT7m5zwyySMd1TA==
X-CSE-MsgGUID: iJOVa96RR3C8ofEvZuzciw==
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="36197113"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2024 05:30:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 19 Dec 2024 05:30:16 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 19 Dec 2024 05:30:11 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v8 1/5] net: phy: microchip_rds_ptp: Add header file for Microchip rds ptp library
Date: Thu, 19 Dec 2024 18:03:07 +0530
Message-ID: <20241219123311.30213-2-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241219123311.30213-1-divya.koppera@microchip.com>
References: <20241219123311.30213-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This rds ptp header file will cover ptp macros for future phys in
Microchip where addresses will be same but base offset and mmd address
may changes.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v7 -> v8
- Removed passing base address to macros, as that is been calculated in
  wrapper function of phy read and writes for ptp rdp library.

v6 -> v7
- No changes

v5 -> v6
- Renamed header file name, macros and function names to
  reflect ptp hardware code name.

v4 -> v5
- Reduced scope of config PTP Macro check to APIs

v3 -> v4
- Re-ordered mchp_ptp_clock structure.

v2 -> v3
- No changes

v1 -> v2
- Fixed sparse warnings and compilation errors/warnings reported by kernel
  test robot
---
 drivers/net/phy/microchip_rds_ptp.h | 223 ++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)
 create mode 100644 drivers/net/phy/microchip_rds_ptp.h

diff --git a/drivers/net/phy/microchip_rds_ptp.h b/drivers/net/phy/microchip_rds_ptp.h
new file mode 100644
index 000000000000..e95c065728b5
--- /dev/null
+++ b/drivers/net/phy/microchip_rds_ptp.h
@@ -0,0 +1,223 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2024 Microchip Technology
+ */
+
+#ifndef _MICROCHIP_RDS_PTP_H
+#define _MICROCHIP_RDS_PTP_H
+
+#include <linux/ptp_clock_kernel.h>
+#include <linux/ptp_clock.h>
+#include <linux/ptp_classify.h>
+#include <linux/net_tstamp.h>
+#include <linux/mii.h>
+#include <linux/phy.h>
+
+#define MCHP_RDS_PTP_CMD_CTL			0x0
+#define MCHP_RDS_PTP_CMD_CTL_LTC_STEP_NSEC	BIT(6)
+#define MCHP_RDS_PTP_CMD_CTL_LTC_STEP_SEC	BIT(5)
+#define MCHP_RDS_PTP_CMD_CTL_CLOCK_LOAD		BIT(4)
+#define MCHP_RDS_PTP_CMD_CTL_CLOCK_READ		BIT(3)
+#define MCHP_RDS_PTP_CMD_CTL_EN			BIT(1)
+#define MCHP_RDS_PTP_CMD_CTL_DIS		BIT(0)
+
+#define MCHP_RDS_PTP_REF_CLK_CFG		0x2
+#define MCHP_RDS_PTP_REF_CLK_SRC_250MHZ		0x0
+#define MCHP_RDS_PTP_REF_CLK_PERIOD_OVERRIDE	BIT(9)
+#define MCHP_RDS_PTP_REF_CLK_PERIOD		4
+#define MCHP_RDS_PTP_REF_CLK_CFG_SET	(MCHP_RDS_PTP_REF_CLK_SRC_250MHZ |\
+					 MCHP_RDS_PTP_REF_CLK_PERIOD_OVERRIDE |\
+					 MCHP_RDS_PTP_REF_CLK_PERIOD)
+
+#define MCHP_RDS_PTP_LTC_SEC_HI			0x5
+#define MCHP_RDS_PTP_LTC_SEC_MID		0x6
+#define MCHP_RDS_PTP_LTC_SEC_LO			0x7
+#define MCHP_RDS_PTP_LTC_NS_HI			0x8
+#define MCHP_RDS_PTP_LTC_NS_LO			0x9
+#define MCHP_RDS_PTP_LTC_RATE_ADJ_HI		0xc
+#define MCHP_RDS_PTP_LTC_RATE_ADJ_HI_DIR	BIT(15)
+#define MCHP_RDS_PTP_LTC_RATE_ADJ_LO		0xd
+#define MCHP_RDS_PTP_STEP_ADJ_HI		0x12
+#define MCHP_RDS_PTP_STEP_ADJ_HI_DIR		BIT(15)
+#define MCHP_RDS_PTP_STEP_ADJ_LO		0x13
+#define MCHP_RDS_PTP_LTC_READ_SEC_HI		0x29
+#define MCHP_RDS_PTP_LTC_READ_SEC_MID		0x2a
+#define MCHP_RDS_PTP_LTC_READ_SEC_LO		0x2b
+#define MCHP_RDS_PTP_LTC_READ_NS_HI		0x2c
+#define MCHP_RDS_PTP_LTC_READ_NS_LO		0x2d
+#define MCHP_RDS_PTP_OP_MODE			0x41
+#define MCHP_RDS_PTP_OP_MODE_DIS		0
+#define MCHP_RDS_PTP_OP_MODE_STANDALONE		1
+#define MCHP_RDS_PTP_LATENCY_CORRECTION_CTL	0x44
+#define MCHP_RDS_PTP_PREDICTOR_EN		BIT(6)
+#define MCHP_RDS_PTP_TX_PRED_DIS		BIT(1)
+#define MCHP_RDS_PTP_RX_PRED_DIS		BIT(0)
+#define MCHP_RDS_PTP_LATENCY_SETTING		(MCHP_RDS_PTP_PREDICTOR_EN | \
+						 MCHP_RDS_PTP_TX_PRED_DIS | \
+						 MCHP_RDS_PTP_RX_PRED_DIS)
+
+#define MCHP_RDS_PTP_INT_EN			0x0
+#define MCHP_RDS_PTP_INT_STS			0x01
+#define MCHP_RDS_PTP_INT_TX_TS_OVRFL_EN		BIT(3)
+#define MCHP_RDS_PTP_INT_TX_TS_EN		BIT(2)
+#define MCHP_RDS_PTP_INT_RX_TS_OVRFL_EN		BIT(1)
+#define MCHP_RDS_PTP_INT_RX_TS_EN		BIT(0)
+#define MCHP_RDS_PTP_INT_ALL_MSK	(MCHP_RDS_PTP_INT_TX_TS_OVRFL_EN | \
+					 MCHP_RDS_PTP_INT_TX_TS_EN | \
+					 MCHP_RDS_PTP_INT_RX_TS_OVRFL_EN |\
+					 MCHP_RDS_PTP_INT_RX_TS_EN)
+
+#define MCHP_RDS_PTP_CAP_INFO			0x2e
+#define MCHP_RDS_PTP_TX_TS_CNT(v)		(((v) & GENMASK(11, 8)) >> 8)
+#define MCHP_RDS_PTP_RX_TS_CNT(v)		((v) & GENMASK(3, 0))
+
+#define MCHP_RDS_PTP_RX_PARSE_CONFIG		0x42
+#define MCHP_RDS_PTP_RX_PARSE_L2_ADDR_EN	0x44
+#define MCHP_RDS_PTP_RX_PARSE_IPV4_ADDR_EN	0x45
+
+#define MCHP_RDS_PTP_RX_TIMESTAMP_CONFIG	0x4e
+#define MCHP_RDS_PTP_RX_TIMESTAMP_CONFIG_PTP_FCS_DIS BIT(0)
+
+#define MCHP_RDS_PTP_RX_VERSION			0x48
+#define MCHP_RDS_PTP_RX_TIMESTAMP_EN		0x4d
+
+#define MCHP_RDS_PTP_RX_INGRESS_NS_HI		0x54
+#define MCHP_RDS_PTP_RX_INGRESS_NS_HI_TS_VALID	BIT(15)
+
+#define MCHP_RDS_PTP_RX_INGRESS_NS_LO		0x55
+#define MCHP_RDS_PTP_RX_INGRESS_SEC_HI		0x56
+#define MCHP_RDS_PTP_RX_INGRESS_SEC_LO		0x57
+#define MCHP_RDS_PTP_RX_MSG_HDR2		0x59
+
+#define MCHP_RDS_PTP_TX_PARSE_CONFIG		0x82
+#define MCHP_RDS_PTP_PARSE_CONFIG_LAYER2_EN	BIT(0)
+#define MCHP_RDS_PTP_PARSE_CONFIG_IPV4_EN	BIT(1)
+#define MCHP_RDS_PTP_PARSE_CONFIG_IPV6_EN	BIT(2)
+
+#define MCHP_RDS_PTP_TX_PARSE_L2_ADDR_EN	0x84
+#define MCHP_RDS_PTP_TX_PARSE_IPV4_ADDR_EN	0x85
+
+#define MCHP_RDS_PTP_TX_VERSION			0x88
+#define MCHP_RDS_PTP_MAX_VERSION(x)		(((x) & GENMASK(7, 0)) << 8)
+#define MCHP_RDS_PTP_MIN_VERSION(x)		((x) & GENMASK(7, 0))
+
+#define MCHP_RDS_PTP_TX_TIMESTAMP_EN		0x8d
+#define MCHP_RDS_PTP_TIMESTAMP_EN_SYNC		BIT(0)
+#define MCHP_RDS_PTP_TIMESTAMP_EN_DREQ		BIT(1)
+#define MCHP_RDS_PTP_TIMESTAMP_EN_PDREQ		BIT(2)
+#define MCHP_RDS_PTP_TIMESTAMP_EN_PDRES		BIT(3)
+#define MCHP_RDS_PTP_TIMESTAMP_EN_ALL	(MCHP_RDS_PTP_TIMESTAMP_EN_SYNC |\
+					 MCHP_RDS_PTP_TIMESTAMP_EN_DREQ |\
+					 MCHP_RDS_PTP_TIMESTAMP_EN_PDREQ |\
+					 MCHP_RDS_PTP_TIMESTAMP_EN_PDRES)
+
+#define MCHP_RDS_PTP_TX_TIMESTAMP_CONFIG	0x8e
+#define MCHP_RDS_PTP_TX_TIMESTAMP_CONFIG_PTP_FCS_DIS BIT(0)
+
+#define MCHP_RDS_PTP_TX_MOD			0x8f
+#define MCHP_RDS_TX_MOD_PTP_SYNC_TS_INSERT	BIT(12)
+
+#define MCHP_RDS_PTP_TX_EGRESS_NS_HI		0x94
+#define MCHP_RDS_PTP_TX_EGRESS_NS_HI_TS_VALID	BIT(15)
+
+#define MCHP_RDS_PTP_TX_EGRESS_NS_LO		0x95
+#define MCHP_RDS_PTP_TX_EGRESS_SEC_HI		0x96
+#define MCHP_RDS_PTP_TX_EGRESS_SEC_LO		0x97
+#define MCHP_RDS_PTP_TX_MSG_HDR2		0x99
+
+#define MCHP_RDS_PTP_TSU_GEN_CONFIG		0xc0
+#define MCHP_RDS_PTP_TSU_GEN_CFG_TSU_EN		BIT(0)
+
+#define MCHP_RDS_PTP_TSU_HARD_RESET		0xc1
+#define MCHP_RDS_PTP_TSU_HARDRESET		BIT(0)
+
+/* Represents 1ppm adjustment in 2^32 format with
+ * each nsec contains 4 clock cycles in 250MHz.
+ * The value is calculated as following: (1/1000000)/((2^-32)/4)
+ */
+#define MCHP_RDS_PTP_1PPM_FORMAT		17179
+#define MCHP_RDS_PTP_FIFO_SIZE			8
+#define MCHP_RDS_PTP_MAX_ADJ			31249999
+
+#define BASE_CLK(p)				((p)->clk_base_addr)
+#define BASE_PORT(p)				((p)->port_base_addr)
+#define PTP_MMD(p)				((p)->mmd)
+
+enum mchp_rds_ptp_base {
+	MCHP_RDS_PTP_PORT,
+	MCHP_RDS_PTP_CLOCK
+};
+
+enum mchp_rds_ptp_fifo_dir {
+	MCHP_RDS_PTP_INGRESS_FIFO,
+	MCHP_RDS_PTP_EGRESS_FIFO
+};
+
+struct mchp_rds_ptp_clock {
+	struct mii_timestamper mii_ts;
+	struct phy_device *phydev;
+	struct ptp_clock *ptp_clock;
+
+	struct sk_buff_head tx_queue;
+	struct sk_buff_head rx_queue;
+	struct list_head rx_ts_list;
+
+	struct ptp_clock_info caps;
+
+	/* Lock for Rx ts fifo */
+	spinlock_t rx_ts_lock;
+	int hwts_tx_type;
+
+	enum hwtstamp_rx_filters rx_filter;
+	int layer;
+	int version;
+	u16 port_base_addr;
+	u16 clk_base_addr;
+
+	/* Lock for phc */
+	struct mutex ptp_lock;
+	u8 mmd;
+};
+
+struct mchp_rds_ptp_rx_ts {
+	struct list_head list;
+	u32 seconds;
+	u32 nsec;
+	u16 seq_id;
+};
+
+#if IS_ENABLED(CONFIG_MICROCHIP_PHY_RDS_PTP)
+
+struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
+					      u16 clk_base, u16 port_base);
+
+int mchp_rds_ptp_top_config_intr(struct mchp_rds_ptp_clock *clock,
+				 u16 reg, u16 val, bool enable);
+
+irqreturn_t mchp_rds_ptp_handle_interrupt(struct mchp_rds_ptp_clock *clock);
+
+#else
+
+static inline struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device
+							    *phydev, u8 mmd,
+							    u16 clk_base,
+							    u16 port_base)
+{
+	return NULL;
+}
+
+static inline int mchp_rds_ptp_top_config_intr(struct mchp_rds_ptp_clock *clock,
+					       u16 reg, u16 val, bool enable)
+{
+	return 0;
+}
+
+static inline irqreturn_t mchp_rds_ptp_handle_interrupt(struct
+							mchp_rds_ptp_clock
+							* clock)
+{
+	return IRQ_NONE;
+}
+
+#endif //CONFIG_MICROCHIP_PHY_RDS_PTP
+
+#endif //_MICROCHIP_RDS_PTP_H
-- 
2.17.1


