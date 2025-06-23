Return-Path: <netdev+bounces-200371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFF5AE4B37
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944903A40F4
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F9299AA3;
	Mon, 23 Jun 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="GBSIHhn2"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367B13B284;
	Mon, 23 Jun 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697004; cv=none; b=cs5S1QXWReWQljWGR9C03vrN8n0Xu2s1oSRcvm6S4BzuiJbgcXwqsHxIGf1WD/yEz277U99cFLRj/LZGyWILq1f8jF8rx8c55jO2Nd1tza5aBieFypSJjZUX6g4cYJhH7DyloYOgAtyZ8mqe0FtHlyzUffUHMOCsKWe6KvmpDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697004; c=relaxed/simple;
	bh=hvBd75szp3cEcIfoI0YpIbwE1Q0R7dHL3FEVWFQOFRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r++QU9gPs0YsxOPSWFpWaFEJmmQiqD+7chDXps7Qc9+jBi6r19/pezkfIyVXUvufq5VNtiEsiHf4MJLm0ig/eNzhPTJuQP6B53CFv4xtSTVnF/CyC8O9fKKa9LmfsAWLwYsrDE2joF2waCRMKWNSUCG1Wh1XvasFevXaZq3WSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=GBSIHhn2; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6j0zsLCew1EIpjzKmjvRgL1VK6EgqLBK+XZNRmCDjCw=; b=GBSIHhn2t7EzuaGORHYc4ufhUi
	ypdd2VLzPH0xRdh1aTudF/Drz3zEnOiZSqDx8TFx0NZ3XKOhFq+vL78375kpHOIj2Jl/MS06Zkt/E
	NaZlXuM0ABFOK6I4pPEgnSbqGB9fjaou61FLcUozTGO5pmDVttVOYu9Qrths+pDQ/u2z8kC/L0Vs3
	aPviTGnXrh7MRcuTm7oZ8OGY+w74NLr45Xdy0Z1B7FJRR7xw6RBJ/jaBeAPmSr5dHn4Hk6CNByp+5
	tD08yISqFGVUqR5MNvNl0OkGykfKR0ThQEBEF6V9xKMrVbkmHH2gEd68zewwTyaJP/XSIE1F2KIGU
	kBdvKPbw==;
Received: from [122.175.9.182] (port=13719 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uTkGK-00000006VGn-20Ga;
	Mon, 23 Jun 2025 12:43:16 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ssantosh@kernel.org,
	richardcochran@gmail.com,
	s.hauer@pengutronix.de,
	m-karicheri2@ti.com,
	glaroque@baylibre.com,
	afd@ti.com,
	saikrishnag@marvell.com,
	m-malladi@ti.com,
	jacob.e.keller@intel.com,
	diogo.ivo@siemens.com,
	javier.carrasco.cruz@gmail.com,
	horms@kernel.org,
	s-anna@ti.com,
	basharath@couthit.com,
	parvathi@couthit.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	pmohan@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v9 08/11] net: ti: prueth: Adds support for RX interrupt coalescing/pacing
Date: Mon, 23 Jun 2025 22:12:33 +0530
Message-Id: <20250623164236.255083-9-parvathi@couthit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623135949.254674-1-parvathi@couthit.com>
References: <20250623135949.254674-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Murali Karicheri <m-karicheri2@ti.com>

Changes for supporting RX interrupt pacing feature using eCAP peripheral
available in PRU-ICSS.

Instead of interrupting the CPU for every packet received, the firmware
running on the PRU-ICSS will interrupt the CPU based on the configured
time period, if interrupt pacing is enabled.

The time period can be configured using ethtool.

RX pacing/coalescing is implemented Using eCAP timer events to give CPU
breathing space from ISR to perform other critical tasks.

The changes include new eCAP driver module which will initialization and
configures the ICSS eCAP HW.

Makefile and Kernel config has been updated to compile the eCAP driver
and to insert the module.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/Kconfig               |  12 +
 drivers/net/ethernet/ti/Makefile              |   2 +
 drivers/net/ethernet/ti/icssm/icssm_ethtool.c |  38 +++
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  |  25 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   3 +
 .../net/ethernet/ti/icssm/icssm_prueth_ecap.c | 312 ++++++++++++++++++
 .../net/ethernet/ti/icssm/icssm_prueth_ecap.h |  47 +++
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  23 ++
 8 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_ecap.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_ecap.h

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index ab20f22524cb..94383712d48a 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -229,6 +229,18 @@ config TI_ICSS_IEP
 	  To compile this driver as a module, choose M here. The module
 	  will be called icss_iep.
 
+config TI_PRUETH_ECAP
+	tristate "TI PRUETH ECAP driver"
+	depends on TI_PRUSS
+	default TI_PRUSS
+	help
+	  This enables support for the PRU-ICSS Enhanced Capture (eCAP) driver
+	  used for rx interrupt pacing support in PRU Driver/firmwares
+	  (Dual EMAC, HSR, PRP).
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called prueth_ecap.
+
 config TI_PRUETH
 	tristate "TI PRU Ethernet EMAC driver"
 	depends on PRU_REMOTEPROC
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 852640ce2b15..dce14a30d4ac 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -49,3 +49,5 @@ icssg-y := icssg/icssg_common.o \
 	   icssg/icssg_ethtool.o
 
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
+
+obj-$(CONFIG_TI_PRUETH_ECAP) += icssm/icssm_prueth_ecap.o
diff --git a/drivers/net/ethernet/ti/icssm/icssm_ethtool.c b/drivers/net/ethernet/ti/icssm/icssm_ethtool.c
index 4d51f2013f86..97bcc3fbc854 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_ethtool.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_ethtool.c
@@ -8,6 +8,7 @@
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
 #include "icssm_prueth.h"
+#include "icssm_prueth_ecap.h"
 #include "icssm_vlan_mcast_filter_mmap.h"
 #include "../icssg/icss_iep.h"
 
@@ -281,6 +282,40 @@ static int icssm_emac_get_ts_info(struct net_device *ndev,
 	return 0;
 }
 
+static int icssm_emac_get_coalesce(struct net_device *ndev,
+				   struct ethtool_coalesce *coal,
+				   struct kernel_ethtool_coalesce *kernel_coal,
+				   struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	struct prueth_ecap *ecap;
+
+	ecap = prueth->ecap;
+	if (IS_ERR(ecap))
+		return -EOPNOTSUPP;
+
+	return ecap->get_coalesce(emac, &coal->use_adaptive_rx_coalesce,
+				  &coal->rx_coalesce_usecs);
+}
+
+static int icssm_emac_set_coalesce(struct net_device *ndev,
+				   struct ethtool_coalesce *coal,
+				   struct kernel_ethtool_coalesce *kernel_coal,
+				   struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	struct prueth_ecap *ecap;
+
+	ecap = prueth->ecap;
+	if (IS_ERR(ecap))
+		return -EOPNOTSUPP;
+
+	return ecap->set_coalesce(emac, coal->use_adaptive_rx_coalesce,
+				  coal->rx_coalesce_usecs);
+}
+
 /* Ethtool support for EMAC adapter */
 const struct ethtool_ops emac_ethtool_ops = {
 	.get_drvinfo = icssm_emac_get_drvinfo,
@@ -295,5 +330,8 @@ const struct ethtool_ops emac_ethtool_ops = {
 	.get_rmon_stats = icssm_emac_get_rmon_stats,
 	.get_eth_mac_stats = icssm_emac_get_eth_mac_stats,
 	.get_ts_info = icssm_emac_get_ts_info,
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS,
+	.get_coalesce = icssm_emac_get_coalesce,
+	.set_coalesce = icssm_emac_set_coalesce,
 };
 EXPORT_SYMBOL_GPL(emac_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 95e10bc57642..3b90c9f7b76d 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -30,6 +30,7 @@
 
 #include "icssm_prueth.h"
 #include "icssm_vlan_mcast_filter_mmap.h"
+#include "icssm_prueth_ecap.h"
 #include "../icssg/icssg_mii_rt.h"
 #include "../icssg/icss_iep.h"
 
@@ -1222,8 +1223,10 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 	struct prueth *prueth = emac->prueth;
+	struct prueth_ecap *ecap;
 	int ret;
 
+	ecap = prueth->ecap;
 	/* set h/w MAC as user might have re-configured */
 	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
 
@@ -1233,6 +1236,9 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 	icssm_prueth_emac_config(emac);
 
 	icssm_emac_set_stats(emac, &emac->stats);
+	/* initialize ecap for interrupt pacing */
+	if (!IS_ERR(ecap))
+		ecap->init(emac);
 
 	if (!prueth->emac_configured) {
 		icssm_iptp_dram_init(emac);
@@ -2179,12 +2185,25 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 		goto netdev_exit;
 	}
 
+	/* Make rx interrupt pacing optional so that users can use ECAP for
+	 * other use cases if needed
+	 */
+	prueth->ecap = icssm_prueth_ecap_get(np);
+	if (IS_ERR(prueth->ecap)) {
+		ret = PTR_ERR(prueth->ecap);
+		if (ret != -EPROBE_DEFER)
+			dev_info(dev,
+				 "No ECAP. Rx interrupt pacing disabled\n");
+		else
+			goto iep_put;
+	}
+
 	/* register the network devices */
 	if (eth0_node) {
 		ret = register_netdev(prueth->emac[PRUETH_MAC0]->ndev);
 		if (ret) {
 			dev_err(dev, "can't register netdev for port MII0");
-			goto iep_put;
+			goto ecap_put;
 		}
 
 		prueth->registered_netdevs[PRUETH_MAC0] =
@@ -2220,6 +2239,10 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 		unregister_netdev(prueth->registered_netdevs[i]);
 	}
 
+ecap_put:
+	if (!IS_ERR(prueth->ecap))
+		icssm_prueth_ecap_put(prueth->ecap);
+
 iep_put:
 	icss_iep_put(prueth->iep);
 
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index 61f37909aa71..07c29c560cb9 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/pruss_driver.h>
 #include <linux/remoteproc/pruss.h>
+#include <linux/netdevice.h>
 
 #include "icssm_switch.h"
 #include "icssm_prueth_ptp.h"
@@ -403,6 +404,7 @@ struct prueth {
 	struct regmap *mii_rt;
 	struct icss_iep *iep;
 
+	struct prueth_ecap *ecap;
 	const struct prueth_private_data *fw_data;
 	struct prueth_fw_offsets *fw_offsets;
 
@@ -412,6 +414,7 @@ struct prueth {
 
 	unsigned int eth_type;
 	size_t ocmc_ram_size;
+	struct mutex mlock; /* serialize access */
 	u8 emac_configured;
 	u8 base_mac[ETH_ALEN];
 };
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_ecap.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_ecap.c
new file mode 100644
index 000000000000..7603188103c3
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_ecap.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* PRUETH Ecap driver for Interrupt pacing support. eCAP is used by
+ * firmware to implement Rx Interrupt pacing for PRUETH driver using
+ * ECAP1 and ECAP2.  Firmware uses ECAP as a timer to implement
+ * interrupt pacing logic. For HSR/PRP, the interrupt pacing can
+ * be enabled/disabled for both ports together as there is a common
+ * control for both ports, where as for Dual EMAC, interrupt pacing
+ * can be enabled or disabled independently for both Ethernet ports.
+ * SRAM memory location stores the configuration for interrupt pacing
+ * such as enable/disable flag and timeout values.
+ *
+ * TODO: This is marked as a HACK driver since the correct solution
+ * is to move the initialization of the ECAP registers to firmware.
+ * Driver has nothing to do ECAP as it is used by firmware and it
+ * is expected that firmware does the initialization.
+ *
+ * Copyright (C) 2018-2020 Texas Instruments Incorporated - https://www.ti.com
+ *	Murali Karicheri <m-karicheri2@ti.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "icssm_switch.h"
+#include "icssm_prueth_ecap.h"
+
+/* ECAP registers */
+#define ECAP_CAP1			8
+#define ECAP_CAP2			0xC
+#define ECAP_ECCTL2			0x2A
+
+#define ECAP_ECCTL2_TSCTRSTOP_MASK	BIT(4)
+#define ECAP_ECCTL2_CAP_APWM_MASK	BIT(9)
+
+#define ECAP_ECCTL2_INIT_VAL		(ECAP_ECCTL2_TSCTRSTOP_MASK | \
+					 ECAP_ECCTL2_CAP_APWM_MASK)
+#define ECAP_CAP2_MAX_COUNT		0xFFFFFFFF
+
+/* TODO: Driver assumes that ECAP runs at 200Mhz clock. But on some
+ * platforms, PRU ICSS clock rate may be changed by user in which case
+ * the pacing logic will not work as expected. Update the driver and
+ * firmware if ECAP/PRUSS clock rate is ever changed. Based on this
+ * assumption each tick is 5 nsec. i.e 1000/200
+ */
+#define ECAP_TICK_NSEC			5
+
+/* in usec */
+/* Duration of 3 frames of 1528 bytes each. If we go beyond this,
+ * receive buffer overflow may happen assuming 4 MTU buffer. So
+ * set this as the limit
+ */
+#define MAX_RX_TIMEOUT_USEC		(123 * 3)
+
+/* Dual EMAC defaults */
+static struct rx_int_pacing_offsets pacing_offsets_defaults[PRUETH_NUM_MACS] = {
+	{ INTR_PAC_STATUS_OFFSET_PRU0, INTR_PAC_TMR_EXP_OFFSET_PRU0,
+	  INTR_PAC_PREV_TS_OFFSET_PRU0 },
+	{ INTR_PAC_STATUS_OFFSET_PRU1, INTR_PAC_TMR_EXP_OFFSET_PRU1,
+	  INTR_PAC_PREV_TS_OFFSET_PRU1 },
+};
+
+static int icssm_prueth_ecap_config_pacing(struct prueth_emac *emac,
+					   u32 use_adaptive,
+					   u32 new_timeout_val)
+{
+	struct rx_int_pacing_offsets *offsets;
+	struct prueth *prueth = emac->prueth;
+	u8 val = INTR_PAC_DIS_ADP_LGC_DIS;
+	struct prueth_ecap *ecap;
+	void __iomem *sram;
+	u32 pacing_ctrl;
+	int port;
+
+	ecap = prueth->ecap;
+	sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+	port = (emac->port_id == PRUETH_PORT_MII0) ?
+				PRUETH_MAC0 : PRUETH_MAC1;
+	offsets = &ecap->int_pacing_offsets[port];
+	pacing_ctrl = offsets->rx_int_pacing_ctrl;
+
+	if (!new_timeout_val) {
+		/* disable pacing */
+		writeb_relaxed(val, sram + pacing_ctrl);
+		/* Timeout separate */
+		ecap->timeout[port] = new_timeout_val;
+		return 0;
+	}
+
+	if (use_adaptive)
+		val = INTR_PAC_ENA_ADP_LGC_ENA;
+	else
+		val = INTR_PAC_ENA_ADP_LGC_DIS;
+
+	if (!ecap->timeout[port]) {
+		/* disable to enable transition */
+		writeb_relaxed(INTR_PAC_DIS_ADP_LGC_DIS, sram + pacing_ctrl);
+		/* For EMAC set timeout for specific port and for
+		 * LRE for both ports
+		 */
+		if (PRUETH_IS_EMAC(prueth)) {
+			if (!port) {
+				offsets =
+					&ecap->int_pacing_offsets[PRUETH_MAC0];
+				writel_relaxed(new_timeout_val *
+						NSEC_PER_USEC / ECAP_TICK_NSEC,
+						sram +
+						offsets->rx_int_pacing_exp);
+				writel_relaxed(INTR_PAC_PREV_TS_RESET_VAL,
+					       sram +
+					       offsets->rx_int_pacing_prev);
+				ecap->timeout[PRUETH_MAC0] = new_timeout_val;
+			} else {
+				offsets =
+					&ecap->int_pacing_offsets[PRUETH_MAC1];
+				writel_relaxed(new_timeout_val *
+						NSEC_PER_USEC / ECAP_TICK_NSEC,
+						sram +
+						offsets->rx_int_pacing_exp);
+				writel_relaxed(INTR_PAC_PREV_TS_RESET_VAL,
+					       sram +
+					       offsets->rx_int_pacing_prev);
+				ecap->timeout[PRUETH_MAC1] = new_timeout_val;
+			}
+		}
+	} else {
+		/* update */
+		if (PRUETH_IS_EMAC(prueth)) {
+			if (!port) {
+				offsets =
+					&ecap->int_pacing_offsets[PRUETH_MAC0];
+				writel_relaxed(new_timeout_val *
+						NSEC_PER_USEC / ECAP_TICK_NSEC,
+						sram +
+						offsets->rx_int_pacing_exp);
+				ecap->timeout[PRUETH_MAC0] = new_timeout_val;
+			} else {
+				offsets =
+					&ecap->int_pacing_offsets[PRUETH_MAC1];
+				writel_relaxed(new_timeout_val *
+						NSEC_PER_USEC / ECAP_TICK_NSEC,
+						sram +
+						offsets->rx_int_pacing_exp);
+				ecap->timeout[PRUETH_MAC1] = new_timeout_val;
+			}
+		}
+	}
+
+	writeb_relaxed(val, sram + pacing_ctrl);
+
+	return 0;
+}
+
+/**
+ * icssm_prueth_ecap_init - ecap driver init
+ *
+ * @emac: EMAC data structure
+ *
+ */
+static void icssm_prueth_ecap_init(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+
+	if (!prueth->emac_configured || PRUETH_IS_EMAC(prueth))
+		icssm_prueth_ecap_config_pacing(emac, 0, 0);
+}
+
+static int icssm_prueth_ecap_get_coalesce(struct prueth_emac *emac,
+					  u32 *use_adaptive_rx_coalesce,
+					  u32 *rx_coalesce_usecs)
+{
+	struct rx_int_pacing_offsets *pacing_offsets;
+	struct prueth *prueth = emac->prueth;
+	struct prueth_ecap *ecap;
+	void __iomem *sram;
+	int port;
+	u32 val;
+
+	ecap = prueth->ecap;
+	sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+	port = (emac->port_id == PRUETH_PORT_MII0) ?
+			PRUETH_MAC0 : PRUETH_MAC1;
+	pacing_offsets = &ecap->int_pacing_offsets[port];
+	val = readb_relaxed(sram + pacing_offsets->rx_int_pacing_ctrl);
+	*use_adaptive_rx_coalesce = (val == INTR_PAC_ENA_ADP_LGC_ENA);
+	*rx_coalesce_usecs = ecap->timeout[port];
+
+	return 0;
+}
+
+static int icssm_prueth_ecap_set_coalesce(struct prueth_emac *emac,
+					  u32 use_adaptive_rx_coalesce,
+					  u32 rx_coalesce_usecs)
+{
+	struct prueth *prueth = emac->prueth;
+	int ret;
+
+	if (rx_coalesce_usecs  > MAX_RX_TIMEOUT_USEC)
+		return -EINVAL;
+
+	mutex_lock(&prueth->mlock);
+	/* Start or restart the pacing timer. */
+	ret = icssm_prueth_ecap_config_pacing(emac, use_adaptive_rx_coalesce,
+					      rx_coalesce_usecs);
+	mutex_unlock(&prueth->mlock);
+
+	return ret;
+}
+
+void icssm_prueth_ecap_put(struct prueth_ecap *ecap)
+{
+	device_lock(ecap->dev);
+	ecap->client_np = NULL;
+	device_unlock(ecap->dev);
+	put_device(ecap->dev);
+}
+EXPORT_SYMBOL_GPL(icssm_prueth_ecap_put);
+
+struct prueth_ecap *icssm_prueth_ecap_get(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct device_node *ecap_np;
+	struct prueth_ecap *ecap;
+
+	ecap_np = of_parse_phandle(np, "ti,ecap", 0);
+	if (!ecap_np || !of_device_is_available(ecap_np))
+		return ERR_PTR(-ENODEV);
+
+	pdev = of_find_device_by_node(ecap_np);
+	of_node_put(ecap_np);
+
+	if (!pdev)
+		/* probably IEP not yet probed */
+		return ERR_PTR(-EPROBE_DEFER);
+
+	ecap = platform_get_drvdata(pdev);
+	if (!ecap)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	device_lock(ecap->dev);
+	if (ecap->client_np) {
+		device_unlock(ecap->dev);
+		dev_err(ecap->dev, "ECAP is already acquired by %s",
+			ecap->client_np->name);
+		return ERR_PTR(-EBUSY);
+	}
+	ecap->client_np = np;
+	device_unlock(ecap->dev);
+	get_device(ecap->dev);
+
+	return ecap;
+}
+EXPORT_SYMBOL_GPL(icssm_prueth_ecap_get);
+
+static int icssm_prueth_ecap_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct prueth_ecap *ecap;
+	struct resource *res;
+	int i;
+
+	ecap = devm_kzalloc(dev, sizeof(*ecap), GFP_KERNEL);
+	if (!ecap)
+		return -ENOMEM;
+
+	ecap->dev = dev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ecap->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ecap->base))
+		return -ENODEV;
+
+	/* Initialize the ECAP timer. It is a common timer used
+	 * by firmware for rx interrupt pacing.
+	 */
+	writew_relaxed(ECAP_ECCTL2_INIT_VAL, ecap->base + ECAP_ECCTL2);
+	writel_relaxed(ECAP_CAP2_MAX_COUNT, ecap->base + ECAP_CAP1);
+	writel_relaxed(ECAP_CAP2_MAX_COUNT, ecap->base + ECAP_CAP2);
+
+	/* initialize SRAM memory offsets for rx pace time control */
+	for (i = 0; i < PRUETH_NUM_MACS; i++)
+		ecap->int_pacing_offsets[i] = pacing_offsets_defaults[i];
+	ecap->get_coalesce = icssm_prueth_ecap_get_coalesce;
+	ecap->set_coalesce = icssm_prueth_ecap_set_coalesce;
+	ecap->init = icssm_prueth_ecap_init;
+
+	dev_set_drvdata(dev, ecap);
+
+	return 0;
+}
+
+static const struct of_device_id prueth_ecap_of_match[] = {
+	{ .compatible = "ti,pruss-ecap", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, prueth_ecap_of_match);
+
+static struct platform_driver prueth_ecap_driver = {
+	.driver = {
+		.name = "prueth-ecap",
+		.of_match_table = prueth_ecap_of_match,
+	},
+	.probe = icssm_prueth_ecap_probe,
+};
+module_platform_driver(prueth_ecap_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TI PRUETH ECAP driver for Rx Interrupt pacing");
+MODULE_AUTHOR("Murali Karicheri <m-karicheri2@ti.com>");
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_ecap.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_ecap.h
new file mode 100644
index 000000000000..d422756bc27f
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_ecap.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Texas Instruments ICSS Enhanced Capture (eCAP) Driver
+ *
+ * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ */
+#ifndef __NET_TI_PRUETH_ECAP_H
+#define __NET_TI_PRUETH_ECAP_H
+
+#include "icssm_prueth.h"
+
+/* SRAM offsets for firmware pacing timer configuration */
+struct rx_int_pacing_offsets {
+	u32 rx_int_pacing_ctrl;
+	u32 rx_int_pacing_exp;
+	u32 rx_int_pacing_prev;
+};
+
+struct prueth_ecap {
+	struct device *dev;
+	void __iomem *base;
+	struct device_node *client_np;
+	struct rx_int_pacing_offsets int_pacing_offsets[PRUETH_NUM_MACS];
+	u32 timeout[PRUETH_NUM_MACS];
+	void (*init)(struct prueth_emac *emac);
+	int (*get_coalesce)(struct prueth_emac *emac,
+			    u32 *use_adaptive_rx_coalesce,
+			    u32 *rx_coalesce_usecs);
+	int (*set_coalesce)(struct prueth_emac *emac,
+			    u32 use_adaptive_rx_coalesce,
+			    u32 rx_coalesce_usecs);
+};
+
+#if IS_ENABLED(CONFIG_TI_PRUETH_ECAP)
+struct prueth_ecap *icssm_prueth_ecap_get(struct device_node *np);
+void icssm_prueth_ecap_put(struct prueth_ecap *ecap);
+#else
+static inline struct prueth_ecap *icssm_prueth_ecap_get(struct device_node *np)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void icssm_prueth_ecap_put(struct prueth_ecap *ecap)
+{};
+#endif
+
+#endif /* __NET_TI_PRUETH_ECAP_H */
diff --git a/drivers/net/ethernet/ti/icssm/icssm_switch.h b/drivers/net/ethernet/ti/icssm/icssm_switch.h
index 0053191380b7..cb5ddd536747 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_switch.h
@@ -259,4 +259,27 @@
 #define P0_COL_BUFFER_OFFSET	0xEE00
 #define P0_Q1_BUFFER_OFFSET	0x0000
 
+/* Below Rx Interrupt pacing defines. */
+/* shared RAM */
+/* 1 byte for pace control */
+#define INTR_PAC_STATUS_OFFSET                       0x1FAF
+#define INTR_PAC_STATUS_OFFSET_PRU1                  0x1FAE
+#define INTR_PAC_STATUS_OFFSET_PRU0                  0x1FAF
+/* Interrupt Pacing disabled, Adaptive logic disabled */
+#define INTR_PAC_DIS_ADP_LGC_DIS                     0x0
+/* Interrupt Pacing enabled, Adaptive logic disabled */
+#define INTR_PAC_ENA_ADP_LGC_DIS                     0x1
+/* Interrupt Pacing enabled, Adaptive logic enabled */
+#define INTR_PAC_ENA_ADP_LGC_ENA                     0x2
+
+/* 4 bytes | previous TS from eCAP TSCNT for PRU 0 */
+#define INTR_PAC_PREV_TS_OFFSET_PRU0                 0x1FB0
+/* 4 bytes | timer expiration value for PRU 0 */
+#define INTR_PAC_TMR_EXP_OFFSET_PRU0                 0x1FB4
+/* 4 bytes | previous TS from eCAP TSCNT for PRU 1 */
+#define INTR_PAC_PREV_TS_OFFSET_PRU1                 0x1FB8
+/* 4 bytes | timer expiration value for PRU 1 */
+#define INTR_PAC_TMR_EXP_OFFSET_PRU1                 0x1FBC
+#define INTR_PAC_PREV_TS_RESET_VAL                   0x0
+
 #endif /* __ICSS_SWITCH_H */
-- 
2.34.1


