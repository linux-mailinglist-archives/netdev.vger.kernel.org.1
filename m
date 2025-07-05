Return-Path: <netdev+bounces-204350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE37AFA1FD
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E831BC5976
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6118D244685;
	Sat,  5 Jul 2025 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZrlP/7P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F823D28F;
	Sat,  5 Jul 2025 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751749824; cv=none; b=HAMvP69f+xYfJwJqkQCzNGiW5009bBNzhTdDEUNUWxOZoa9SGYt8Dztu3TuIHoLyRlmNLDGIJ66j99/B3Y1togrdVn0JqaM7fWdkuD5uxDAIl3fyxnptn8RlprKRgPG+HfZAxvMk88Gb/PZR7uzbTOK1xkbUwEsgRDqS1b5ETr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751749824; c=relaxed/simple;
	bh=Aq0ubc5CVbjO1p9cP3nqCMpxpHCDw0nT4LaWAKDNlrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgODeYPm97M7e0rjncWnAeCuxzKc9BvR8dFwdkE0ckYGx80nQRuyqFEjlQ/nPU++5CfeCaAgsv5no38hCGtdWC+hICr1IV8L3j0OpN9YrySag629+4ejtcPe28+D6uK+CgfLjG0eLiU5bfGQbQTIsvI0gFREJyDOrjs5HLZ7U7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZrlP/7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6E1C4CEE7;
	Sat,  5 Jul 2025 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751749824;
	bh=Aq0ubc5CVbjO1p9cP3nqCMpxpHCDw0nT4LaWAKDNlrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FZrlP/7PGNpgzqzIlIO2w40QidC29MibfsICwbDWe++6nrDWsiImotZrNVpPvJThi
	 mNq/eswwB6TwJkyDywkuqV/KSNn5xEqUeqgzLUUEsBuoAw/+UDAyBHD9uTh71dJ8QV
	 Gyg0vXHHxmHM8tFmchcXB9aval9ayT3xAnB/vO+jlt4M8PVhxpC4kypMnvD04fAAQU
	 1uTE3b+1+3Jjka9i1f92ZUrL5aYcMhxmOmg4oRtiCdsOJb6eJRGzlw/HwikeeYCBz+
	 RJt/rohwYgbe1W8sfZP1pPPvIz0No22Fa0Hz7CwiEa91btdEhBtugRxzFrNtgdQPR0
	 tl8PuGMALj87g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 05 Jul 2025 23:09:51 +0200
Subject: [PATCH net-next v2 7/7] net: airoha: Add airoha_offload.h header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250705-airoha-en7581-wlan-offlaod-v2-7-3cf32785e381@kernel.org>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
In-Reply-To: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Move NPU definitions to airoha_offload.h in include/linux/soc/airoha/ in
order to allow the MT76 driver to access the callback definitions.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c  |   2 +-
 drivers/net/ethernet/airoha/airoha_npu.h  | 102 ------------
 drivers/net/ethernet/airoha/airoha_ppe.c  |   2 +-
 include/linux/soc/airoha/airoha_offload.h | 256 ++++++++++++++++++++++++++++++
 4 files changed, 258 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index cbd81394cfb6d512d131f1c805f5c15d95d08634..c3782de5dcdab158076fc1c2c8fb155f13b26fb2 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -11,9 +11,9 @@
 #include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/regmap.h>
+#include <linux/soc/airoha/airoha_offload.h>
 
 #include "airoha_eth.h"
-#include "airoha_npu.h"
 
 #define NPU_EN7581_FIRMWARE_DATA		"airoha/en7581_npu_data.bin"
 #define NPU_EN7581_FIRMWARE_RV32		"airoha/en7581_npu_rv32.bin"
diff --git a/drivers/net/ethernet/airoha/airoha_npu.h b/drivers/net/ethernet/airoha/airoha_npu.h
deleted file mode 100644
index 72b1d41d99e798ed32e8abdaa443e4775c6defd1..0000000000000000000000000000000000000000
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ /dev/null
@@ -1,102 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2025 AIROHA Inc
- * Author: Lorenzo Bianconi <lorenzo@kernel.org>
- */
-
-#define NPU_NUM_CORES		8
-#define NPU_NUM_IRQ		6
-
-enum airoha_npu_wlan_set_cmd {
-	WLAN_FUNC_SET_WAIT_PCIE_ADDR,
-	WLAN_FUNC_SET_WAIT_DESC,
-	WLAN_FUNC_SET_WAIT_NPU_INIT_DONE,
-	WLAN_FUNC_SET_WAIT_TRAN_TO_CPU,
-	WLAN_FUNC_SET_WAIT_BA_WIN_SIZE,
-	WLAN_FUNC_SET_WAIT_DRIVER_MODEL,
-	WLAN_FUNC_SET_WAIT_DEL_STA,
-	WLAN_FUNC_SET_WAIT_DRAM_BA_NODE_ADDR,
-	WLAN_FUNC_SET_WAIT_PKT_BUF_ADDR,
-	WLAN_FUNC_SET_WAIT_IS_TEST_NOBA,
-	WLAN_FUNC_SET_WAIT_FLUSHONE_TIMEOUT,
-	WLAN_FUNC_SET_WAIT_FLUSHALL_TIMEOUT,
-	WLAN_FUNC_SET_WAIT_IS_FORCE_TO_CPU,
-	WLAN_FUNC_SET_WAIT_PCIE_STATE,
-	WLAN_FUNC_SET_WAIT_PCIE_PORT_TYPE,
-	WLAN_FUNC_SET_WAIT_ERROR_RETRY_TIMES,
-	WLAN_FUNC_SET_WAIT_BAR_INFO,
-	WLAN_FUNC_SET_WAIT_FAST_FLAG,
-	WLAN_FUNC_SET_WAIT_NPU_BAND0_ONCPU,
-	WLAN_FUNC_SET_WAIT_TX_RING_PCIE_ADDR,
-	WLAN_FUNC_SET_WAIT_TX_DESC_HW_BASE,
-	WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
-	WLAN_FUNC_SET_WAIT_RX_RING_FOR_TXDONE_HW_BASE,
-	WLAN_FUNC_SET_WAIT_TX_PKT_BUF_ADDR,
-	WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
-	WLAN_FUNC_SET_WAIT_INODE_DEBUG_FLAG,
-	WLAN_FUNC_SET_WAIT_INODE_HW_CFG_INFO,
-	WLAN_FUNC_SET_WAIT_INODE_STOP_ACTION,
-	WLAN_FUNC_SET_WAIT_INODE_PCIE_SWAP,
-	WLAN_FUNC_SET_WAIT_RATELIMIT_CTRL,
-	WLAN_FUNC_SET_WAIT_HWNAT_INIT,
-	WLAN_FUNC_SET_WAIT_ARHT_CHIP_INFO,
-	WLAN_FUNC_SET_WAIT_TX_BUF_CHECK_ADDR,
-	WLAN_FUNC_SET_WAIT_DEBUG_ARRAY_ADDR,
-};
-
-enum airoha_npu_wlan_get_cmd {
-	WLAN_FUNC_GET_WAIT_NPU_INFO,
-	WLAN_FUNC_GET_WAIT_LAST_RATE,
-	WLAN_FUNC_GET_WAIT_COUNTER,
-	WLAN_FUNC_GET_WAIT_DBG_COUNTER,
-	WLAN_FUNC_GET_WAIT_RXDESC_BASE,
-	WLAN_FUNC_GET_WAIT_WCID_DBG_COUNTER,
-	WLAN_FUNC_GET_WAIT_DMA_ADDR,
-	WLAN_FUNC_GET_WAIT_RING_SIZE,
-	WLAN_FUNC_GET_WAIT_NPU_SUPPORT_MAP,
-	WLAN_FUNC_GET_WAIT_MDC_LOCK_ADDRESS,
-};
-
-struct airoha_npu {
-	struct device *dev;
-	struct regmap *regmap;
-
-	struct airoha_npu_core {
-		struct airoha_npu *npu;
-		/* protect concurrent npu memory accesses */
-		spinlock_t lock;
-		struct work_struct wdt_work;
-	} cores[NPU_NUM_CORES];
-
-	int irqs[NPU_NUM_IRQ];
-
-	struct airoha_foe_stats __iomem *stats;
-
-	struct {
-		int (*ppe_init)(struct airoha_npu *npu);
-		int (*ppe_deinit)(struct airoha_npu *npu);
-		int (*ppe_flush_sram_entries)(struct airoha_npu *npu,
-					      dma_addr_t foe_addr,
-					      int sram_num_entries);
-		int (*ppe_foe_commit_entry)(struct airoha_npu *npu,
-					    dma_addr_t foe_addr,
-					    u32 entry_size, u32 hash,
-					    bool ppe2);
-		int (*wlan_init_reserved_memory)(struct airoha_npu *npu);
-		int (*wlan_send_msg)(struct airoha_npu *npu, int ifindex,
-				     enum airoha_npu_wlan_set_cmd func_id,
-				     u32 data, gfp_t gfp);
-		int (*wlan_get_msg)(struct airoha_npu *npu, int ifindex,
-				    enum airoha_npu_wlan_get_cmd func_id,
-				    u32 *data);
-		u32 (*wlan_get_queue_addr)(struct airoha_npu *npu, int qid,
-					   bool xmit);
-		void (*wlan_set_irq_status)(struct airoha_npu *npu, u32 val);
-		u32 (*wlan_get_irq_status)(struct airoha_npu *npu, int q);
-		void (*wlan_enable_irq)(struct airoha_npu *npu, int q);
-		void (*wlan_disable_irq)(struct airoha_npu *npu, int q);
-	} ops;
-};
-
-struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr);
-void airoha_npu_put(struct airoha_npu *npu);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index c354d536bc66e97ab853792e4ab4273283d2fb91..5d12bde6b20a89b3037ae4405b383d75307e8239 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -7,10 +7,10 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/rhashtable.h>
+#include <linux/soc/airoha/airoha_offload.h>
 #include <net/ipv6.h>
 #include <net/pkt_cls.h>
 
-#include "airoha_npu.h"
 #include "airoha_regs.h"
 #include "airoha_eth.h"
 
diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
new file mode 100644
index 0000000000000000000000000000000000000000..5b15e4b3d53385c84ac5ac4fb33cb57f03c663fc
--- /dev/null
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -0,0 +1,256 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 AIROHA Inc
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+#ifndef AIROHA_OFFLOAD_H
+#define AIROHA_OFFLOAD_H
+
+#define NPU_NUM_CORES		8
+#define NPU_NUM_IRQ		6
+#define NPU_RX0_DESC_NUM	512
+#define NPU_RX1_DESC_NUM	512
+
+/* CTRL */
+#define NPU_RX_DMA_DESC_LAST_MASK	BIT(29)
+#define NPU_RX_DMA_DESC_LEN_MASK	GENMASK(28, 15)
+#define NPU_RX_DMA_DESC_CUR_LEN_MASK	GENMASK(14, 1)
+#define NPU_RX_DMA_DESC_DONE_MASK	BIT(0)
+/* INFO */
+#define NPU_RX_DMA_PKT_COUNT_MASK	GENMASK(31, 28)
+#define NPU_RX_DMA_PKT_ID_MASK		GENMASK(28, 26)
+#define NPU_RX_DMA_SRC_PORT_MASK	GENMASK(25, 21)
+#define NPU_RX_DMA_CRSN_MASK		GENMASK(20, 16)
+#define NPU_RX_DMA_FOE_ID_MASK		GENMASK(15, 0)
+/* DATA */
+#define NPU_RX_DMA_SID_MASK		GENMASK(31, 16)
+#define NPU_RX_DMA_FRAG_TYPE_MASK	GENMASK(15, 14)
+#define NPU_RX_DMA_PRIORITY_MASK	GENMASK(13, 10)
+#define NPU_RX_DMA_RADIO_ID_MASK	GENMASK(9, 6)
+#define NPU_RX_DMA_VAP_ID_MASK		GENMASK(5, 2)
+#define NPU_RX_DMA_FRAME_TYPE_MASK	GENMASK(1, 0)
+
+struct airoha_npu_rx_dma_desc {
+	u32 ctrl;
+	u32 info;
+	u32 data;
+	u32 addr;
+	u64 rsv;
+} __packed;
+
+/* CTRL */
+#define NPU_TX_DMA_DESC_SCHED_MASK	BIT(31)
+#define NPU_TX_DMA_DESC_LEN_MASK	GENMASK(30, 18)
+#define NPU_TX_DMA_DESC_VEND_LEN_MASK	GENMASK(17, 1)
+#define NPU_TX_DMA_DESC_DONE_MASK	BIT(0)
+
+#define NPU_TXWI_LEN	192
+
+struct airoha_npu_tx_dma_desc {
+	u32 ctrl;
+	u32 addr;
+	u64 rsv;
+	u8 txwi[NPU_TXWI_LEN];
+} __packed;
+
+enum airoha_npu_wlan_set_cmd {
+	WLAN_FUNC_SET_WAIT_PCIE_ADDR,
+	WLAN_FUNC_SET_WAIT_DESC,
+	WLAN_FUNC_SET_WAIT_NPU_INIT_DONE,
+	WLAN_FUNC_SET_WAIT_TRAN_TO_CPU,
+	WLAN_FUNC_SET_WAIT_BA_WIN_SIZE,
+	WLAN_FUNC_SET_WAIT_DRIVER_MODEL,
+	WLAN_FUNC_SET_WAIT_DEL_STA,
+	WLAN_FUNC_SET_WAIT_DRAM_BA_NODE_ADDR,
+	WLAN_FUNC_SET_WAIT_PKT_BUF_ADDR,
+	WLAN_FUNC_SET_WAIT_IS_TEST_NOBA,
+	WLAN_FUNC_SET_WAIT_FLUSHONE_TIMEOUT,
+	WLAN_FUNC_SET_WAIT_FLUSHALL_TIMEOUT,
+	WLAN_FUNC_SET_WAIT_IS_FORCE_TO_CPU,
+	WLAN_FUNC_SET_WAIT_PCIE_STATE,
+	WLAN_FUNC_SET_WAIT_PCIE_PORT_TYPE,
+	WLAN_FUNC_SET_WAIT_ERROR_RETRY_TIMES,
+	WLAN_FUNC_SET_WAIT_BAR_INFO,
+	WLAN_FUNC_SET_WAIT_FAST_FLAG,
+	WLAN_FUNC_SET_WAIT_NPU_BAND0_ONCPU,
+	WLAN_FUNC_SET_WAIT_TX_RING_PCIE_ADDR,
+	WLAN_FUNC_SET_WAIT_TX_DESC_HW_BASE,
+	WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
+	WLAN_FUNC_SET_WAIT_RX_RING_FOR_TXDONE_HW_BASE,
+	WLAN_FUNC_SET_WAIT_TX_PKT_BUF_ADDR,
+	WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
+	WLAN_FUNC_SET_WAIT_INODE_DEBUG_FLAG,
+	WLAN_FUNC_SET_WAIT_INODE_HW_CFG_INFO,
+	WLAN_FUNC_SET_WAIT_INODE_STOP_ACTION,
+	WLAN_FUNC_SET_WAIT_INODE_PCIE_SWAP,
+	WLAN_FUNC_SET_WAIT_RATELIMIT_CTRL,
+	WLAN_FUNC_SET_WAIT_HWNAT_INIT,
+	WLAN_FUNC_SET_WAIT_ARHT_CHIP_INFO,
+	WLAN_FUNC_SET_WAIT_TX_BUF_CHECK_ADDR,
+	WLAN_FUNC_SET_WAIT_DEBUG_ARRAY_ADDR,
+};
+
+enum airoha_npu_wlan_get_cmd {
+	WLAN_FUNC_GET_WAIT_NPU_INFO,
+	WLAN_FUNC_GET_WAIT_LAST_RATE,
+	WLAN_FUNC_GET_WAIT_COUNTER,
+	WLAN_FUNC_GET_WAIT_DBG_COUNTER,
+	WLAN_FUNC_GET_WAIT_RXDESC_BASE,
+	WLAN_FUNC_GET_WAIT_WCID_DBG_COUNTER,
+	WLAN_FUNC_GET_WAIT_DMA_ADDR,
+	WLAN_FUNC_GET_WAIT_RING_SIZE,
+	WLAN_FUNC_GET_WAIT_NPU_SUPPORT_MAP,
+	WLAN_FUNC_GET_WAIT_MDC_LOCK_ADDRESS,
+};
+
+struct airoha_npu {
+#if (IS_BUILTIN(CONFIG_NET_AIROHA_NPU) || IS_MODULE(CONFIG_NET_AIROHA_NPU))
+	struct device *dev;
+	struct regmap *regmap;
+
+	struct airoha_npu_core {
+		struct airoha_npu *npu;
+		/* protect concurrent npu memory accesses */
+		spinlock_t lock;
+		struct work_struct wdt_work;
+	} cores[NPU_NUM_CORES];
+
+	int irqs[NPU_NUM_IRQ];
+
+	struct airoha_foe_stats __iomem *stats;
+
+	struct {
+		int (*ppe_init)(struct airoha_npu *npu);
+		int (*ppe_deinit)(struct airoha_npu *npu);
+		int (*ppe_flush_sram_entries)(struct airoha_npu *npu,
+					      dma_addr_t foe_addr,
+					      int sram_num_entries);
+		int (*ppe_foe_commit_entry)(struct airoha_npu *npu,
+					    dma_addr_t foe_addr,
+					    u32 entry_size, u32 hash,
+					    bool ppe2);
+		int (*wlan_init_reserved_memory)(struct airoha_npu *npu);
+		int (*wlan_send_msg)(struct airoha_npu *npu, int ifindex,
+				     enum airoha_npu_wlan_set_cmd func_id,
+				     u32 data, gfp_t gfp);
+		int (*wlan_get_msg)(struct airoha_npu *npu, int ifindex,
+				    enum airoha_npu_wlan_get_cmd func_id,
+				    u32 *data);
+		u32 (*wlan_get_queue_addr)(struct airoha_npu *npu, int qid,
+					   bool xmit);
+		void (*wlan_set_irq_status)(struct airoha_npu *npu, u32 val);
+		u32 (*wlan_get_irq_status)(struct airoha_npu *npu, int q);
+		void (*wlan_enable_irq)(struct airoha_npu *npu, int q);
+		void (*wlan_disable_irq)(struct airoha_npu *npu, int q);
+	} ops;
+#endif
+};
+
+#if (IS_BUILTIN(CONFIG_NET_AIROHA_NPU) || IS_MODULE(CONFIG_NET_AIROHA_NPU))
+struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr);
+void airoha_npu_put(struct airoha_npu *npu);
+
+static inline int airoha_npu_wlan_init_reserved_memory(struct airoha_npu *npu)
+{
+	return npu->ops.wlan_init_reserved_memory(npu);
+}
+
+static inline int airoha_npu_wlan_send_msg(struct airoha_npu *npu,
+					   int ifindex,
+					   enum airoha_npu_wlan_set_cmd cmd,
+					   u32 data, gfp_t gfp)
+{
+	return npu->ops.wlan_send_msg(npu, ifindex, cmd, data, gfp);
+}
+
+static inline int airoha_npu_wlan_get_msg(struct airoha_npu *npu, int ifindex,
+					  enum airoha_npu_wlan_get_cmd cmd,
+					  u32 *data)
+{
+	return npu->ops.wlan_get_msg(npu, ifindex, cmd, data);
+}
+
+static inline u32 airoha_npu_wlan_get_queue_addr(struct airoha_npu *npu,
+						 int qid, bool xmit)
+{
+	return npu->ops.wlan_get_queue_addr(npu, qid, xmit);
+}
+
+static inline void airoha_npu_wlan_set_irq_status(struct airoha_npu *npu,
+						  u32 val)
+{
+	npu->ops.wlan_set_irq_status(npu, val);
+}
+
+static inline u32 airoha_npu_wlan_get_irq_status(struct airoha_npu *npu, int q)
+{
+	return npu->ops.wlan_get_irq_status(npu, q);
+}
+
+static inline void airoha_npu_wlan_enable_irq(struct airoha_npu *npu, int q)
+{
+	npu->ops.wlan_enable_irq(npu, q);
+}
+
+static inline void airoha_npu_wlan_disable_irq(struct airoha_npu *npu, int q)
+{
+	npu->ops.wlan_disable_irq(npu, q);
+}
+#else
+static inline struct airoha_npu *airoha_npu_get(struct device *dev,
+						dma_addr_t *foe_stats_addr)
+{
+	return NULL;
+}
+
+static inline void airoha_npu_put(struct airoha_npu *npu)
+{
+}
+
+static inline int airoha_npu_wlan_init_reserved_memory(struct airoha_npu *npu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int airoha_npu_wlan_send_msg(struct airoha_npu *npu,
+					   int ifindex,
+					   enum airoha_npu_wlan_set_cmd cmd,
+					   u32 data, gfp_t gfp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int airoha_npu_wlan_get_msg(struct airoha_npu *npu, int ifindex,
+					  enum airoha_npu_wlan_get_cmd cmd,
+					  u32 *data)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline u32 airoha_npu_wlan_get_queue_addr(struct airoha_npu *npu,
+						 int qid, bool xmit)
+{
+	return 0;
+}
+
+static inline void airoha_npu_wlan_set_irq_status(struct airoha_npu *npu,
+						  u32 val)
+{
+}
+
+static inline u32 airoha_npu_wlan_get_irq_status(struct airoha_npu *npu,
+						 int q)
+{
+	return 0;
+}
+
+static inline void airoha_npu_wlan_enable_irq(struct airoha_npu *npu, int q)
+{
+}
+
+static inline void airoha_npu_wlan_disable_irq(struct airoha_npu *npu, int q)
+{
+}
+#endif
+
+#endif /* AIROHA_OFFLOAD_H */

-- 
2.50.0


