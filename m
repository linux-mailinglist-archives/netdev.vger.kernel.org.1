Return-Path: <netdev+bounces-168481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1E6A3F20F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393C73BDDF8
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECC7205E28;
	Fri, 21 Feb 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9oQKAM/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C0204F90;
	Fri, 21 Feb 2025 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133712; cv=none; b=n1pwXECGRAfImqJCvbypPRuGHPErZfPRLWq+/pvRkFxUk07yYFRgb41PzS7M+yzsoGvamLoFslDZy7u/b60QE/RDZqGHBSJIOuTrMTp2rha3TV7gf+fj1jeyJ9/IeQKwe4LRfdB/gtFWjF0FDoyMiV23ekRBKNqZmIXsMmYSU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133712; c=relaxed/simple;
	bh=AG4jf7U7RiixvNy/Wq2aS66C8zHWh8H0synk3h9IdPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwxfMiycFj8mcmiYcpGHm10k9tcdD69V35LzCW+sBmiFVb7NA32ncB2Q14ss2bqsA1O3Y/Wk6dl27iMkGWn1ywxylP3dSGtWaGrnYjxmoTCmipywGb7JopPniKyqvXNb7bbCPoTHe0aNis/LQYh6mFC2AB6QnzIK0zqhTAh1PY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9oQKAM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CE7C4CED6;
	Fri, 21 Feb 2025 10:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740133711;
	bh=AG4jf7U7RiixvNy/Wq2aS66C8zHWh8H0synk3h9IdPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V9oQKAM/J86vTV1n7RWED+/rEX9IezLolfEBCPINOGBtazYOTGXmO+LvuXL6ZcG5C
	 K8IiXLFN0lQLXwdKt05gQvHnynXE8/2J5pMqXDOD2nrIfrSki56PzKSTgpdYwYnGmH
	 cKDm8TUzV5Rw2yrGeWWf1w+WHUQ97RwZXK+z0dt3JpRENEZ3K9TACSlmFQmQuvjcPj
	 WfucumJfw6Y7I/EToYjO4GiRiw+fthv2ClM+fhUYnLyVRZybpAkbgtMbHHKVVf4k88
	 Fht409Mw8jvzKlQ6/fPT99hU92XXADo1Tws8J7CwOBXsxy0JMbEHiBN7u4YoSHucDq
	 VFS489oAxXBhQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 21 Feb 2025 11:28:03 +0100
Subject: [PATCH net-next v6 02/15] net: airoha: Move definitions in
 airoha_eth.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-airoha-en7581-flowtable-offload-v6-2-d593af0e9487@kernel.org>
References: <20250221-airoha-en7581-flowtable-offload-v6-0-d593af0e9487@kernel.org>
In-Reply-To: <20250221-airoha-en7581-flowtable-offload-v6-0-d593af0e9487@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

Move common airoha_eth definitions in airoha_eth.h in order to reuse
them for Packet Processor Engine (PPE) codebase.
PPE module is used to enable support for flowtable hw offloading in
airoha_eth driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 240 +----------------------------
 drivers/net/ethernet/airoha/airoha_eth.h | 251 +++++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+), 239 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index aa5f220ddbcf9ca5bee1173114294cb3aec701c9..0048a5665576afaf532778f0bd96be8b07d29703 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3,14 +3,9 @@
  * Copyright (c) 2024 AIROHA Inc
  * Author: Lorenzo Bianconi <lorenzo@kernel.org>
  */
-#include <linux/etherdevice.h>
-#include <linux/iopoll.h>
-#include <linux/kernel.h>
-#include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/platform_device.h>
-#include <linux/reset.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
 #include <net/dsa.h>
@@ -18,35 +13,7 @@
 #include <net/pkt_cls.h>
 #include <uapi/linux/ppp_defs.h>
 
-#define AIROHA_MAX_NUM_GDM_PORTS	1
-#define AIROHA_MAX_NUM_QDMA		2
-#define AIROHA_MAX_NUM_RSTS		3
-#define AIROHA_MAX_NUM_XSI_RSTS		5
-#define AIROHA_MAX_MTU			2000
-#define AIROHA_MAX_PACKET_SIZE		2048
-#define AIROHA_NUM_QOS_CHANNELS		4
-#define AIROHA_NUM_QOS_QUEUES		8
-#define AIROHA_NUM_TX_RING		32
-#define AIROHA_NUM_RX_RING		32
-#define AIROHA_NUM_NETDEV_TX_RINGS	(AIROHA_NUM_TX_RING + \
-					 AIROHA_NUM_QOS_CHANNELS)
-#define AIROHA_FE_MC_MAX_VLAN_TABLE	64
-#define AIROHA_FE_MC_MAX_VLAN_PORT	16
-#define AIROHA_NUM_TX_IRQ		2
-#define HW_DSCP_NUM			2048
-#define IRQ_QUEUE_LEN(_n)		((_n) ? 1024 : 2048)
-#define TX_DSCP_NUM			1024
-#define RX_DSCP_NUM(_n)			\
-	((_n) ==  2 ? 128 :		\
-	 (_n) == 11 ? 128 :		\
-	 (_n) == 15 ? 128 :		\
-	 (_n) ==  0 ? 1024 : 16)
-
-#define PSE_RSV_PAGES			128
-#define PSE_QUEUE_RSV_PAGES		64
-
-#define QDMA_METER_IDX(_n)		((_n) & 0xff)
-#define QDMA_METER_GROUP(_n)		(((_n) >> 8) & 0x3)
+#include "airoha_eth.h"
 
 /* FE */
 #define PSE_BASE			0x0100
@@ -706,211 +673,6 @@ struct airoha_qdma_fwd_desc {
 	__le32 rsv1;
 };
 
-enum {
-	QDMA_INT_REG_IDX0,
-	QDMA_INT_REG_IDX1,
-	QDMA_INT_REG_IDX2,
-	QDMA_INT_REG_IDX3,
-	QDMA_INT_REG_IDX4,
-	QDMA_INT_REG_MAX
-};
-
-enum {
-	XSI_PCIE0_PORT,
-	XSI_PCIE1_PORT,
-	XSI_USB_PORT,
-	XSI_AE_PORT,
-	XSI_ETH_PORT,
-};
-
-enum {
-	XSI_PCIE0_VIP_PORT_MASK	= BIT(22),
-	XSI_PCIE1_VIP_PORT_MASK	= BIT(23),
-	XSI_USB_VIP_PORT_MASK	= BIT(25),
-	XSI_ETH_VIP_PORT_MASK	= BIT(24),
-};
-
-enum {
-	DEV_STATE_INITIALIZED,
-};
-
-enum {
-	CDM_CRSN_QSEL_Q1 = 1,
-	CDM_CRSN_QSEL_Q5 = 5,
-	CDM_CRSN_QSEL_Q6 = 6,
-	CDM_CRSN_QSEL_Q15 = 15,
-};
-
-enum {
-	CRSN_08 = 0x8,
-	CRSN_21 = 0x15, /* KA */
-	CRSN_22 = 0x16, /* hit bind and force route to CPU */
-	CRSN_24 = 0x18,
-	CRSN_25 = 0x19,
-};
-
-enum {
-	FE_PSE_PORT_CDM1,
-	FE_PSE_PORT_GDM1,
-	FE_PSE_PORT_GDM2,
-	FE_PSE_PORT_GDM3,
-	FE_PSE_PORT_PPE1,
-	FE_PSE_PORT_CDM2,
-	FE_PSE_PORT_CDM3,
-	FE_PSE_PORT_CDM4,
-	FE_PSE_PORT_PPE2,
-	FE_PSE_PORT_GDM4,
-	FE_PSE_PORT_CDM5,
-	FE_PSE_PORT_DROP = 0xf,
-};
-
-enum tx_sched_mode {
-	TC_SCH_WRR8,
-	TC_SCH_SP,
-	TC_SCH_WRR7,
-	TC_SCH_WRR6,
-	TC_SCH_WRR5,
-	TC_SCH_WRR4,
-	TC_SCH_WRR3,
-	TC_SCH_WRR2,
-};
-
-enum trtcm_param_type {
-	TRTCM_MISC_MODE, /* meter_en, pps_mode, tick_sel */
-	TRTCM_TOKEN_RATE_MODE,
-	TRTCM_BUCKETSIZE_SHIFT_MODE,
-	TRTCM_BUCKET_COUNTER_MODE,
-};
-
-enum trtcm_mode_type {
-	TRTCM_COMMIT_MODE,
-	TRTCM_PEAK_MODE,
-};
-
-enum trtcm_param {
-	TRTCM_TICK_SEL = BIT(0),
-	TRTCM_PKT_MODE = BIT(1),
-	TRTCM_METER_MODE = BIT(2),
-};
-
-#define MIN_TOKEN_SIZE				4096
-#define MAX_TOKEN_SIZE_OFFSET			17
-#define TRTCM_TOKEN_RATE_MASK			GENMASK(23, 6)
-#define TRTCM_TOKEN_RATE_FRACTION_MASK		GENMASK(5, 0)
-
-struct airoha_queue_entry {
-	union {
-		void *buf;
-		struct sk_buff *skb;
-	};
-	dma_addr_t dma_addr;
-	u16 dma_len;
-};
-
-struct airoha_queue {
-	struct airoha_qdma *qdma;
-
-	/* protect concurrent queue accesses */
-	spinlock_t lock;
-	struct airoha_queue_entry *entry;
-	struct airoha_qdma_desc *desc;
-	u16 head;
-	u16 tail;
-
-	int queued;
-	int ndesc;
-	int free_thr;
-	int buf_size;
-
-	struct napi_struct napi;
-	struct page_pool *page_pool;
-};
-
-struct airoha_tx_irq_queue {
-	struct airoha_qdma *qdma;
-
-	struct napi_struct napi;
-
-	int size;
-	u32 *q;
-};
-
-struct airoha_hw_stats {
-	/* protect concurrent hw_stats accesses */
-	spinlock_t lock;
-	struct u64_stats_sync syncp;
-
-	/* get_stats64 */
-	u64 rx_ok_pkts;
-	u64 tx_ok_pkts;
-	u64 rx_ok_bytes;
-	u64 tx_ok_bytes;
-	u64 rx_multicast;
-	u64 rx_errors;
-	u64 rx_drops;
-	u64 tx_drops;
-	u64 rx_crc_error;
-	u64 rx_over_errors;
-	/* ethtool stats */
-	u64 tx_broadcast;
-	u64 tx_multicast;
-	u64 tx_len[7];
-	u64 rx_broadcast;
-	u64 rx_fragment;
-	u64 rx_jabber;
-	u64 rx_len[7];
-};
-
-struct airoha_qdma {
-	struct airoha_eth *eth;
-	void __iomem *regs;
-
-	/* protect concurrent irqmask accesses */
-	spinlock_t irq_lock;
-	u32 irqmask[QDMA_INT_REG_MAX];
-	int irq;
-
-	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
-
-	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
-	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
-
-	/* descriptor and packet buffers for qdma hw forward */
-	struct {
-		void *desc;
-		void *q;
-	} hfwd;
-};
-
-struct airoha_gdm_port {
-	struct airoha_qdma *qdma;
-	struct net_device *dev;
-	int id;
-
-	struct airoha_hw_stats stats;
-
-	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
-
-	/* qos stats counters */
-	u64 cpu_tx_packets;
-	u64 fwd_tx_packets;
-};
-
-struct airoha_eth {
-	struct device *dev;
-
-	unsigned long state;
-	void __iomem *fe_regs;
-
-	struct reset_control_bulk_data rsts[AIROHA_MAX_NUM_RSTS];
-	struct reset_control_bulk_data xsi_rsts[AIROHA_MAX_NUM_XSI_RSTS];
-
-	struct net_device *napi_dev;
-
-	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
-	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
-};
-
 static u32 airoha_rr(void __iomem *base, u32 offset)
 {
 	return readl(base + offset);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
new file mode 100644
index 0000000000000000000000000000000000000000..3310e0cf85f1d240e95404a0c15703e5f6be26bc
--- /dev/null
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -0,0 +1,251 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 AIROHA Inc
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#ifndef AIROHA_ETH_H
+#define AIROHA_ETH_H
+
+#include <linux/etherdevice.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/reset.h>
+
+#define AIROHA_MAX_NUM_GDM_PORTS	1
+#define AIROHA_MAX_NUM_QDMA		2
+#define AIROHA_MAX_NUM_RSTS		3
+#define AIROHA_MAX_NUM_XSI_RSTS		5
+#define AIROHA_MAX_MTU			2000
+#define AIROHA_MAX_PACKET_SIZE		2048
+#define AIROHA_NUM_QOS_CHANNELS		4
+#define AIROHA_NUM_QOS_QUEUES		8
+#define AIROHA_NUM_TX_RING		32
+#define AIROHA_NUM_RX_RING		32
+#define AIROHA_NUM_NETDEV_TX_RINGS	(AIROHA_NUM_TX_RING + \
+					 AIROHA_NUM_QOS_CHANNELS)
+#define AIROHA_FE_MC_MAX_VLAN_TABLE	64
+#define AIROHA_FE_MC_MAX_VLAN_PORT	16
+#define AIROHA_NUM_TX_IRQ		2
+#define HW_DSCP_NUM			2048
+#define IRQ_QUEUE_LEN(_n)		((_n) ? 1024 : 2048)
+#define TX_DSCP_NUM			1024
+#define RX_DSCP_NUM(_n)			\
+	((_n) ==  2 ? 128 :		\
+	 (_n) == 11 ? 128 :		\
+	 (_n) == 15 ? 128 :		\
+	 (_n) ==  0 ? 1024 : 16)
+
+#define PSE_RSV_PAGES			128
+#define PSE_QUEUE_RSV_PAGES		64
+
+#define QDMA_METER_IDX(_n)		((_n) & 0xff)
+#define QDMA_METER_GROUP(_n)		(((_n) >> 8) & 0x3)
+
+enum {
+	QDMA_INT_REG_IDX0,
+	QDMA_INT_REG_IDX1,
+	QDMA_INT_REG_IDX2,
+	QDMA_INT_REG_IDX3,
+	QDMA_INT_REG_IDX4,
+	QDMA_INT_REG_MAX
+};
+
+enum {
+	XSI_PCIE0_PORT,
+	XSI_PCIE1_PORT,
+	XSI_USB_PORT,
+	XSI_AE_PORT,
+	XSI_ETH_PORT,
+};
+
+enum {
+	XSI_PCIE0_VIP_PORT_MASK	= BIT(22),
+	XSI_PCIE1_VIP_PORT_MASK	= BIT(23),
+	XSI_USB_VIP_PORT_MASK	= BIT(25),
+	XSI_ETH_VIP_PORT_MASK	= BIT(24),
+};
+
+enum {
+	DEV_STATE_INITIALIZED,
+};
+
+enum {
+	CDM_CRSN_QSEL_Q1 = 1,
+	CDM_CRSN_QSEL_Q5 = 5,
+	CDM_CRSN_QSEL_Q6 = 6,
+	CDM_CRSN_QSEL_Q15 = 15,
+};
+
+enum {
+	CRSN_08 = 0x8,
+	CRSN_21 = 0x15, /* KA */
+	CRSN_22 = 0x16, /* hit bind and force route to CPU */
+	CRSN_24 = 0x18,
+	CRSN_25 = 0x19,
+};
+
+enum {
+	FE_PSE_PORT_CDM1,
+	FE_PSE_PORT_GDM1,
+	FE_PSE_PORT_GDM2,
+	FE_PSE_PORT_GDM3,
+	FE_PSE_PORT_PPE1,
+	FE_PSE_PORT_CDM2,
+	FE_PSE_PORT_CDM3,
+	FE_PSE_PORT_CDM4,
+	FE_PSE_PORT_PPE2,
+	FE_PSE_PORT_GDM4,
+	FE_PSE_PORT_CDM5,
+	FE_PSE_PORT_DROP = 0xf,
+};
+
+enum tx_sched_mode {
+	TC_SCH_WRR8,
+	TC_SCH_SP,
+	TC_SCH_WRR7,
+	TC_SCH_WRR6,
+	TC_SCH_WRR5,
+	TC_SCH_WRR4,
+	TC_SCH_WRR3,
+	TC_SCH_WRR2,
+};
+
+enum trtcm_param_type {
+	TRTCM_MISC_MODE, /* meter_en, pps_mode, tick_sel */
+	TRTCM_TOKEN_RATE_MODE,
+	TRTCM_BUCKETSIZE_SHIFT_MODE,
+	TRTCM_BUCKET_COUNTER_MODE,
+};
+
+enum trtcm_mode_type {
+	TRTCM_COMMIT_MODE,
+	TRTCM_PEAK_MODE,
+};
+
+enum trtcm_param {
+	TRTCM_TICK_SEL = BIT(0),
+	TRTCM_PKT_MODE = BIT(1),
+	TRTCM_METER_MODE = BIT(2),
+};
+
+#define MIN_TOKEN_SIZE				4096
+#define MAX_TOKEN_SIZE_OFFSET			17
+#define TRTCM_TOKEN_RATE_MASK			GENMASK(23, 6)
+#define TRTCM_TOKEN_RATE_FRACTION_MASK		GENMASK(5, 0)
+
+struct airoha_queue_entry {
+	union {
+		void *buf;
+		struct sk_buff *skb;
+	};
+	dma_addr_t dma_addr;
+	u16 dma_len;
+};
+
+struct airoha_queue {
+	struct airoha_qdma *qdma;
+
+	/* protect concurrent queue accesses */
+	spinlock_t lock;
+	struct airoha_queue_entry *entry;
+	struct airoha_qdma_desc *desc;
+	u16 head;
+	u16 tail;
+
+	int queued;
+	int ndesc;
+	int free_thr;
+	int buf_size;
+
+	struct napi_struct napi;
+	struct page_pool *page_pool;
+};
+
+struct airoha_tx_irq_queue {
+	struct airoha_qdma *qdma;
+
+	struct napi_struct napi;
+
+	int size;
+	u32 *q;
+};
+
+struct airoha_hw_stats {
+	/* protect concurrent hw_stats accesses */
+	spinlock_t lock;
+	struct u64_stats_sync syncp;
+
+	/* get_stats64 */
+	u64 rx_ok_pkts;
+	u64 tx_ok_pkts;
+	u64 rx_ok_bytes;
+	u64 tx_ok_bytes;
+	u64 rx_multicast;
+	u64 rx_errors;
+	u64 rx_drops;
+	u64 tx_drops;
+	u64 rx_crc_error;
+	u64 rx_over_errors;
+	/* ethtool stats */
+	u64 tx_broadcast;
+	u64 tx_multicast;
+	u64 tx_len[7];
+	u64 rx_broadcast;
+	u64 rx_fragment;
+	u64 rx_jabber;
+	u64 rx_len[7];
+};
+
+struct airoha_qdma {
+	struct airoha_eth *eth;
+	void __iomem *regs;
+
+	/* protect concurrent irqmask accesses */
+	spinlock_t irq_lock;
+	u32 irqmask[QDMA_INT_REG_MAX];
+	int irq;
+
+	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
+
+	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
+	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
+
+	/* descriptor and packet buffers for qdma hw forward */
+	struct {
+		void *desc;
+		void *q;
+	} hfwd;
+};
+
+struct airoha_gdm_port {
+	struct airoha_qdma *qdma;
+	struct net_device *dev;
+	int id;
+
+	struct airoha_hw_stats stats;
+
+	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
+
+	/* qos stats counters */
+	u64 cpu_tx_packets;
+	u64 fwd_tx_packets;
+};
+
+struct airoha_eth {
+	struct device *dev;
+
+	unsigned long state;
+	void __iomem *fe_regs;
+
+	struct reset_control_bulk_data rsts[AIROHA_MAX_NUM_RSTS];
+	struct reset_control_bulk_data xsi_rsts[AIROHA_MAX_NUM_XSI_RSTS];
+
+	struct net_device *napi_dev;
+
+	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
+	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
+};
+
+#endif /* AIROHA_ETH_H */

-- 
2.48.1


