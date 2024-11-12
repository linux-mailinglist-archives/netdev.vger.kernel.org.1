Return-Path: <netdev+bounces-144094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A829C593C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D411F24D38
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49591155308;
	Tue, 12 Nov 2024 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f6zh6C5p"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E03A143736;
	Tue, 12 Nov 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418646; cv=none; b=M5LmXT6l4+QILOcGIzoGi8fxFeKe98GqHtl3Nz+8v0SOFB1QeRQcIgecbedcBPqnoWiUKPn1+6IRZ7e8DHmIcg5ZnVVrVu1ytajDXAS8zwP6CRowFy/FkQqCoBJI2eNC8Qk2sIN3aKHwuY8S0yjS689MU1c0jbSKrMyX/DBIU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418646; c=relaxed/simple;
	bh=CtYGJIfDr4DcfL0+zaY6Fh7NGxcukLqigCh9w2foFF0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkQWHblIm3v8zLVoi2Ztc20cnwoHTPs+a4erizp/XD548avYQ/IlPsuc8Hh2++4VICjx3ytJN4DJ1Y5T7qv3nMpYq0iu037aY/8dKMe099Ls1D/g7SgJDm+/FjDzl7OMQFPpXnP7JICWGAOOtWyxBSiTJPuLOor2YcjA64bcw74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f6zh6C5p; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731418644; x=1762954644;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=CtYGJIfDr4DcfL0+zaY6Fh7NGxcukLqigCh9w2foFF0=;
  b=f6zh6C5pG4pLpy2b/RbYSDWwhiASfqbP7HCs+AwuaiKai16Uy+S1QqX2
   BWEHdsk32cqd0dZ7MXW/XOcmvo/Imp6Hg2y3RTj8fDWnlr790lI4pvGba
   LW/2EtZHVFz83BKmR/8K6v/uYqdmiSm+Mr/ta7KztHDthm8FN7DIU708m
   gI1QMPSM95jWCAQfaxF3CifIeYihhtZQc08JKp3D2ZGiq/+ysCMm9lE58
   6PmO2JjTqa0o0wXRlTK0FTQpl9yW+6SHt6WJ3emwj3xb0Oh6mCb9c6HLS
   /kkwH3JnQdHO274IaxMhPOHVSjVOOgI1EJzWxOq8s507ogTZEJl3UcO+j
   g==;
X-CSE-ConnectionGUID: MrNChj17QCGoNOgRM4DkTw==
X-CSE-MsgGUID: auL9Eg/3RmmIrzFr/RoC3g==
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="201634988"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Nov 2024 06:37:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Nov 2024 06:37:11 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 12 Nov 2024 06:37:06 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v3 1/5] net: phy: microchip_ptp : Add header file for Microchip ptp library
Date: Tue, 12 Nov 2024 19:07:20 +0530
Message-ID: <20241112133724.16057-2-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112133724.16057-1-divya.koppera@microchip.com>
References: <20241112133724.16057-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This ptp header file library will cover ptp macros for future phys in
Microchip where addresses will be same but base offset and mmd address
may changes.

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v2 -> v3
- No changes

v1 -> v2
- Fixed sparse warnings and compilation errors/warnings reported by kernel
  test robot
---
 drivers/net/phy/microchip_ptp.h | 217 ++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)
 create mode 100644 drivers/net/phy/microchip_ptp.h

diff --git a/drivers/net/phy/microchip_ptp.h b/drivers/net/phy/microchip_ptp.h
new file mode 100644
index 000000000000..26a9a65c1810
--- /dev/null
+++ b/drivers/net/phy/microchip_ptp.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2024 Microchip Technology
+ */
+
+#ifndef _MICROCHIP_PTP_H
+#define _MICROCHIP_PTP_H
+
+#if IS_ENABLED(CONFIG_MICROCHIP_PHYPTP)
+
+#include <linux/ptp_clock_kernel.h>
+#include <linux/ptp_clock.h>
+#include <linux/ptp_classify.h>
+#include <linux/net_tstamp.h>
+#include <linux/mii.h>
+#include <linux/phy.h>
+
+#define MCHP_PTP_CMD_CTL(b)			((b) + 0x0)
+#define MCHP_PTP_CMD_CTL_LTC_STEP_NSEC		BIT(6)
+#define MCHP_PTP_CMD_CTL_LTC_STEP_SEC		BIT(5)
+#define MCHP_PTP_CMD_CTL_CLOCK_LOAD		BIT(4)
+#define MCHP_PTP_CMD_CTL_CLOCK_READ		BIT(3)
+#define MCHP_PTP_CMD_CTL_EN			BIT(1)
+#define MCHP_PTP_CMD_CTL_DIS			BIT(0)
+
+#define MCHP_PTP_REF_CLK_CFG(b)			((b) + 0x2)
+#define MCHP_PTP_REF_CLK_SRC_250MHZ		0x0
+#define MCHP_PTP_REF_CLK_PERIOD_OVERRIDE	BIT(9)
+#define MCHP_PTP_REF_CLK_PERIOD			4
+#define MCHP_PTP_REF_CLK_CFG_SET	(MCHP_PTP_REF_CLK_SRC_250MHZ |\
+					 MCHP_PTP_REF_CLK_PERIOD_OVERRIDE |\
+					 MCHP_PTP_REF_CLK_PERIOD)
+
+#define MCHP_PTP_LTC_SEC_HI(b)			((b) + 0x5)
+#define MCHP_PTP_LTC_SEC_MID(b)			((b) + 0x6)
+#define MCHP_PTP_LTC_SEC_LO(b)			((b) + 0x7)
+#define MCHP_PTP_LTC_NS_HI(b)			((b) + 0x8)
+#define MCHP_PTP_LTC_NS_LO(b)			((b) + 0x9)
+#define MCHP_PTP_LTC_RATE_ADJ_HI(b)		((b) + 0xc)
+#define MCHP_PTP_LTC_RATE_ADJ_HI_DIR		BIT(15)
+#define MCHP_PTP_LTC_RATE_ADJ_LO(b)		((b) + 0xd)
+#define MCHP_PTP_LTC_STEP_ADJ_HI(b)		((b) + 0x12)
+#define MCHP_PTP_LTC_STEP_ADJ_HI_DIR		BIT(15)
+#define MCHP_PTP_LTC_STEP_ADJ_LO(b)		((b) + 0x13)
+#define MCHP_PTP_LTC_READ_SEC_HI(b)		((b) + 0x29)
+#define MCHP_PTP_LTC_READ_SEC_MID(b)		((b) + 0x2a)
+#define MCHP_PTP_LTC_READ_SEC_LO(b)		((b) + 0x2b)
+#define MCHP_PTP_LTC_READ_NS_HI(b)		((b) + 0x2c)
+#define MCHP_PTP_LTC_READ_NS_LO(b)		((b) + 0x2d)
+#define MCHP_PTP_OP_MODE(b)			((b) + 0x41)
+#define MCHP_PTP_OP_MODE_DIS			0
+#define MCHP_PTP_OP_MODE_STANDALONE		1
+#define MCHP_PTP_LATENCY_CORRECTION_CTL(b)	((b) + 0x44)
+#define MCHP_PTP_PREDICTOR_EN			BIT(6)
+#define MCHP_PTP_TX_PRED_DIS			BIT(1)
+#define MCHP_PTP_RX_PRED_DIS			BIT(0)
+#define MCHP_PTP_LATENCY_SETTING		(MCHP_PTP_PREDICTOR_EN | \
+						 MCHP_PTP_TX_PRED_DIS | \
+						 MCHP_PTP_RX_PRED_DIS)
+
+#define MCHP_PTP_INT_EN(b)			((b) + 0x0)
+#define MCHP_PTP_INT_STS(b)			((b) + 0x01)
+#define MCHP_PTP_INT_TX_TS_OVRFL_EN		BIT(3)
+#define MCHP_PTP_INT_TX_TS_EN			BIT(2)
+#define MCHP_PTP_INT_RX_TS_OVRFL_EN		BIT(1)
+#define MCHP_PTP_INT_RX_TS_EN			BIT(0)
+#define MCHP_PTP_INT_ALL_MSK		(MCHP_PTP_INT_TX_TS_OVRFL_EN | \
+					 MCHP_PTP_INT_TX_TS_EN | \
+					 MCHP_PTP_INT_RX_TS_OVRFL_EN |\
+					 MCHP_PTP_INT_RX_TS_EN)
+
+#define MCHP_PTP_CAP_INFO(b)			((b) + 0x2e)
+#define MCHP_PTP_TX_TS_CNT(v)			(((v) & GENMASK(11, 8)) >> 8)
+#define MCHP_PTP_RX_TS_CNT(v)			((v) & GENMASK(3, 0))
+
+#define MCHP_PTP_RX_PARSE_CONFIG(b)		((b) + 0x42)
+#define MCHP_PTP_RX_PARSE_L2_ADDR_EN(b)		((b) + 0x44)
+#define MCHP_PTP_RX_PARSE_IPV4_ADDR_EN(b)	((b) + 0x45)
+
+#define MCHP_PTP_RX_TIMESTAMP_CONFIG(b)		((b) + 0x4e)
+#define MCHP_PTP_RX_TIMESTAMP_CONFIG_PTP_FCS_DIS BIT(0)
+
+#define MCHP_PTP_RX_VERSION(b)			((b) + 0x48)
+#define MCHP_PTP_RX_TIMESTAMP_EN(b)		((b) + 0x4d)
+
+#define MCHP_PTP_RX_INGRESS_NS_HI(b)		((b) + 0x54)
+#define MCHP_PTP_RX_INGRESS_NS_HI_TS_VALID	BIT(15)
+
+#define MCHP_PTP_RX_INGRESS_NS_LO(b)		((b) + 0x55)
+#define MCHP_PTP_RX_INGRESS_SEC_HI(b)		((b) + 0x56)
+#define MCHP_PTP_RX_INGRESS_SEC_LO(b)		((b) + 0x57)
+#define MCHP_PTP_RX_MSG_HEADER2(b)		((b) + 0x59)
+
+#define MCHP_PTP_TX_PARSE_CONFIG(b)		((b) + 0x82)
+#define MCHP_PTP_PARSE_CONFIG_LAYER2_EN		BIT(0)
+#define MCHP_PTP_PARSE_CONFIG_IPV4_EN		BIT(1)
+#define MCHP_PTP_PARSE_CONFIG_IPV6_EN		BIT(2)
+
+#define MCHP_PTP_TX_PARSE_L2_ADDR_EN(b)		((b) + 0x84)
+#define MCHP_PTP_TX_PARSE_IPV4_ADDR_EN(b)	((b) + 0x85)
+
+#define MCHP_PTP_TX_VERSION(b)			((b) + 0x88)
+#define MCHP_PTP_MAX_VERSION(x)			(((x) & GENMASK(7, 0)) << 8)
+#define MCHP_PTP_MIN_VERSION(x)			((x) & GENMASK(7, 0))
+
+#define MCHP_PTP_TX_TIMESTAMP_EN(b)		((b) + 0x8d)
+#define MCHP_PTP_TIMESTAMP_EN_SYNC		BIT(0)
+#define MCHP_PTP_TIMESTAMP_EN_DREQ		BIT(1)
+#define MCHP_PTP_TIMESTAMP_EN_PDREQ		BIT(2)
+#define MCHP_PTP_TIMESTAMP_EN_PDRES		BIT(3)
+#define MCHP_PTP_TIMESTAMP_EN_ALL		(MCHP_PTP_TIMESTAMP_EN_SYNC |\
+						 MCHP_PTP_TIMESTAMP_EN_DREQ |\
+						 MCHP_PTP_TIMESTAMP_EN_PDREQ |\
+						 MCHP_PTP_TIMESTAMP_EN_PDRES)
+
+#define MCHP_PTP_TX_TIMESTAMP_CONFIG(b)		((b) + 0x8e)
+#define MCHP_PTP_TX_TIMESTAMP_CONFIG_PTP_FCS_DIS BIT(0)
+
+#define MCHP_PTP_TX_MOD(b)			((b) + 0x8f)
+#define MCHP_PTP_TX_MOD_PTP_SYNC_TS_INSERT	BIT(12)
+#define MCHP_PTP_TX_MOD_PTP_FU_TS_INSERT	BIT(11)
+
+#define MCHP_PTP_TX_EGRESS_NS_HI(b)		((b) + 0x94)
+#define MCHP_PTP_TX_EGRESS_NS_HI_TS_VALID	BIT(15)
+
+#define MCHP_PTP_TX_EGRESS_NS_LO(b)		((b) + 0x95)
+#define MCHP_PTP_TX_EGRESS_SEC_HI(b)		((b) + 0x96)
+#define MCHP_PTP_TX_EGRESS_SEC_LO(b)		((b) + 0x97)
+#define MCHP_PTP_TX_MSG_HEADER2(b)		((b) + 0x99)
+
+#define MCHP_PTP_TSU_GEN_CONFIG(b)		((b) + 0xc0)
+#define MCHP_PTP_TSU_GEN_CFG_TSU_EN		BIT(0)
+
+#define MCHP_PTP_TSU_HARD_RESET(b)		((b) + 0xc1)
+#define MCHP_PTP_TSU_HARDRESET			BIT(0)
+
+/* Represents 1ppm adjustment in 2^32 format with
+ * each nsec contains 4 clock cycles in 250MHz.
+ * The value is calculated as following: (1/1000000)/((2^-32)/4)
+ */
+#define MCHP_PTP_1PPM_FORMAT			17179
+#define MCHP_PTP_FIFO_SIZE			8
+#define MCHP_PTP_MAX_ADJ				31249999
+
+#define BASE_CLK(p)		((p)->clk_base_addr)
+#define BASE_PORT(p)		((p)->port_base_addr)
+#define PTP_MMD(p)		((p)->mmd)
+
+enum ptp_fifo_dir {
+	PTP_INGRESS_FIFO,
+	PTP_EGRESS_FIFO
+};
+
+struct mchp_ptp_clock {
+	struct mii_timestamper mii_ts;
+	struct phy_device *phydev;
+
+	struct sk_buff_head tx_queue;
+	struct sk_buff_head rx_queue;
+
+	struct list_head rx_ts_list;
+	/* Lock for Rx ts fifo */
+	spinlock_t rx_ts_lock;
+
+	int hwts_tx_type;
+	enum hwtstamp_rx_filters rx_filter;
+	int layer;
+	int version;
+
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info caps;
+
+	/* Lock for phc */
+	struct mutex ptp_lock;
+
+	u16 port_base_addr;
+	u16 clk_base_addr;
+	u8 mmd;
+};
+
+struct mchp_ptp_rx_ts {
+	struct list_head list;
+	u32 seconds;
+	u32 nsec;
+	u16 seq_id;
+};
+
+struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev, u8 mmd,
+				      u16 clk_base, u16 port_base);
+
+int mchp_config_ptp_intr(struct mchp_ptp_clock *ptp_clock,
+			 u16 reg, u16 val, bool enable);
+
+irqreturn_t mchp_ptp_handle_interrupt(struct mchp_ptp_clock *ptp_clock);
+
+#else
+
+static inline struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev,
+						    u8 mmd, u16 clk_base,
+						    u16 port_base)
+{
+	return NULL;
+}
+
+static inline int mchp_config_ptp_intr(struct mchp_ptp_clock *ptp_clock,
+				       u16 reg, u16 val, bool enable)
+{
+	return 0;
+}
+
+static inline irqreturn_t mchp_ptp_handle_interrupt(struct mchp_ptp_clock *ptp_clock)
+{
+	return IRQ_NONE;
+}
+
+#endif //CONFIG_MICROCHIP_PHYPTP
+
+#endif //_MICROCHIP_PTP_H
-- 
2.17.1


