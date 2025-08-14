Return-Path: <netdev+bounces-213611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9D8B25DC2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2821B68BF6
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7A3274B3A;
	Thu, 14 Aug 2025 07:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8982727FD;
	Thu, 14 Aug 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157230; cv=none; b=DA0u9Jl1BoF6p/crHEJOZE1cdYd4x9W/0hrrHVQuZF8gyy755XWOPcp1anHCxQ/ze2Q2kwhn4xjjMqG5arPp39CJ1ulWik7goJwIZZE/xpaF1ddxfk32RyyaqKsBdJzns+CCuwlsjLzgw7Ctm8edAc/XAThKv/AHNWSJhfu7TMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157230; c=relaxed/simple;
	bh=GgmqEEjCNZl+eabtCioQrGGXhiYUjzW5ScXOmOavcuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxOrty3x42L1vUfVkQvtFU2meFzpNWCs7yPXGP8J6I3UX7RD5gHJ9eyI2W8AdGhZ5Sartj0pVhwY2Y44aXdjwQm7ch/F5AAuoL1hZDMP3L72fao9sA095RDqyYULTBqnzwC6nUog8ZHtyQ2E4WYj3ycfgJDcLQehjMj/xBLzl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1755157166tf08bb8b2
X-QQ-Originating-IP: +D2qxNTh+8Cz6sOnHiw5AFylcq/yLqmgo7h6OB4j6ks=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 15:39:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16184359842408352212
EX-QQ-RecipientCnt: 23
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v4 5/5] net: rnpgbe: Add register_netdev
Date: Thu, 14 Aug 2025 15:38:55 +0800
Message-Id: <20250814073855.1060601-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250814073855.1060601-1-dong100@mucse.com>
References: <20250814073855.1060601-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N7uWGur8ZHHzv76pEjOZ9YEKQFs/vKByqn7Fm9XYtTsEtH1o2xkDGAMC
	aOr4SfXXjD6zP5RzvkJPU5lTOlpZLFNQnEPwngIiAr1r+yUJkHoL6J+xBgw5p+RhwY4DV5Z
	G3aR2KvF+xTxuHNET0TOLWPX4bMxz0pHaKoXCbFaJ+9/Ek2HJ4TaMrINMjwogFhWMDLied9
	1L9u9M92TOK18X/0BBTKC76yFW36NF6JFLefbydloaoFyEFzwYfUdipiJT6H90IiX5toPsD
	bxWtkfbgyGRMQSp3prIujOP6HblbrrdkUSzbgl0tF00EAuNWISIPF8q3OFboq2cw0KeHkEP
	61n0K2XHHJa3H6FXP4erQ5Lw65zVZlzar/i661vjFASd/NUn4hFTu9qwRp+WulXCPa95/RM
	C0oRpmzd+xrhD6tHMvMvWUPstWfK4HKO+kaJ4Rk5sJlbD0dcrRIRaRZQKazOMACSJ06NmXx
	DV+0BneLwhw6H3kvjrdosn+haeagI3ELGWJoyCJTUEQxHHQMrPx0W8DnXfip9cQXq/G9g6J
	c9PkOZHXlSzo7trJbkk51XNJXoVTH4Q+sU04W0klgqoVBN/6p86ke27O0q2SotWnzguE8LP
	A2UuJDcKfk9p2wc62OiBkDnnD1+CCV3ir/fCA2YAtKyP3lyk/gzhopH8Ce6FpF0hNLRl4bf
	uwlRIhJBm/G9Qb1wDors2OroK4sl4LrdFCL2BfQajF/GtCvT9ZX1SLDyXtN7Jl6UceK7gdf
	ym6TEtEwQL8dEvvtNmAbBFXCXkVgFmCIkHFX8Ww036GfOhTTEGe7xmK3EZQT507Kb+XacS7
	BLPJagbscFelL3BnSQtA8KIn9LfzAZw7HCp79le9n5127ku+skisQzPEGYOvSdz/TXfp96E
	t4THsP+L2mR6acuibCZzRpEh2cxf20w1slEjL1zEFx8nowG8W47pN+8avPHhiAkE3PoKGiB
	aY5gpje2iSdGSk5KywlWtO2C8P1STAT1nrK9uy1RQbdjPrtfVjSSSgP/BBokAGrR3QdQIWb
	s2IC+mMu9rpFVNE5f3hJR1/FoI7IlTOODOTmKlq5lXxdUA5Opc
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Initialize get mac from hw, register the netdev.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 18 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 75 +++++++++++++++++++
 4 files changed, 167 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 7ab1cbb432f6..7e51a8871b71 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -82,6 +83,15 @@ struct mucse_mbx_info {
 	u32 fw2pf_mbox_vec;
 };
 
+struct mucse_hw_operations {
+	int (*reset_hw)(struct mucse_hw *hw);
+	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
+};
+
+enum {
+	mucse_driver_insmod,
+};
+
 struct mucse_hw {
 	u8 pfvfnum;
 	void __iomem *hw_addr;
@@ -91,12 +101,17 @@ struct mucse_hw {
 	u32 axi_mhz;
 	u32 bd_uid;
 	enum rnpgbe_hw_type hw_type;
+	const struct mucse_hw_operations *ops;
 	struct mucse_dma_info dma;
 	struct mucse_eth_info eth;
 	struct mucse_mac_info mac;
 	struct mucse_mbx_info mbx;
+	u32 flags;
+#define M_FLAGS_INIT_MAC_ADDRESS BIT(0)
 	u32 driver_version;
 	u16 usecstocount;
+	int lane;
+	u8 perm_addr[ETH_ALEN];
 };
 
 struct mucse {
@@ -117,4 +132,7 @@ struct rnpgbe_info {
 #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
+
+#define dma_wr32(dma, reg, val) writel((val), (dma)->dma_base_addr + (reg))
+#define dma_rd32(dma, reg) readl((dma)->dma_base_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index e0c6f47efd4c..aba44b31eae3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,11 +1,83 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
+#include <linux/pci.h>
 #include <linux/string.h>
+#include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
 #include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
+
+/**
+ * rnpgbe_get_permanent_mac - Get permanent mac
+ * @hw: hw information structure
+ * @mac_addr: pointer to store mac
+ *
+ * rnpgbe_get_permanent_mac tries to get mac from hw.
+ * It use eth_random_addr if failed.
+ **/
+static void rnpgbe_get_permanent_mac(struct mucse_hw *hw,
+				     u8 *mac_addr)
+{
+	struct device *dev = &hw->pdev->dev;
+
+	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->lane) ||
+	    !is_valid_ether_addr(mac_addr)) {
+		dev_warn(dev, "Failed to get valid MAC from FW, using random\n");
+		eth_random_addr(mac_addr);
+	}
+
+	hw->flags |= M_FLAGS_INIT_MAC_ADDRESS;
+}
+
+/**
+ * rnpgbe_reset_hw_ops - Do a hardware reset
+ * @hw: hw information structure
+ *
+ * rnpgbe_reset_hw_ops calls fw to do a hardware
+ * reset, and cleans some regs to default.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
+{
+	struct mucse_dma_info *dma = &hw->dma;
+	int err;
+
+	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
+	err = mucse_mbx_fw_reset_phy(hw);
+	if (err)
+		return err;
+	/* Store the permanent mac address */
+	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS))
+		rnpgbe_get_permanent_mac(hw, hw->perm_addr);
+
+	return 0;
+}
+
+/**
+ * rnpgbe_driver_status_hw_ops - Echo driver status to hw
+ * @hw: hw information structure
+ * @enable: true or false status
+ * @mode: status mode
+ **/
+static void rnpgbe_driver_status_hw_ops(struct mucse_hw *hw,
+					bool enable,
+					int mode)
+{
+	switch (mode) {
+	case mucse_driver_insmod:
+		mucse_mbx_ifinsmod(hw, enable);
+		break;
+	}
+}
+
+static const struct mucse_hw_operations rnpgbe_hw_ops = {
+	.reset_hw = &rnpgbe_reset_hw_ops,
+	.driver_status = &rnpgbe_driver_status_hw_ops,
+};
 
 /**
  * rnpgbe_init_common - Setup common attribute
@@ -25,6 +97,7 @@ static void rnpgbe_init_common(struct mucse_hw *hw)
 	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
 
 	hw->mbx.ops = &mucse_mbx_ops_generic;
+	hw->ops = &rnpgbe_hw_ops;
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index aee037e3219d..4e07328ccf82 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -9,6 +9,7 @@
 #define RNPGBE_ETH_BASE 0x10000
 /**************** DMA Registers ****************************/
 #define RNPGBE_DMA_DUMY 0x000c
+#define RNPGBE_DMA_AXI_EN 0x0010
 /**************** CHIP Resource ****************************/
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 1fef7fa30208..a377ecaa0da5 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -8,6 +8,7 @@
 #include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
@@ -34,6 +35,55 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).
+ *
+ * @return: 0 on success, negative value on failure
+ **/
+static int rnpgbe_open(struct net_device *netdev)
+{
+	return 0;
+}
+
+/**
+ * rnpgbe_close - Disables a network interface
+ * @netdev: network interface device structure
+ *
+ * The close entry point is called when an interface is de-activated
+ * by the OS.
+ *
+ * @return: 0, this is not allowed to fail
+ **/
+static int rnpgbe_close(struct net_device *netdev)
+{
+	return 0;
+}
+
+/**
+ * rnpgbe_xmit_frame - Send a skb to driver
+ * @skb: skb structure to be sent
+ * @netdev: network interface device structure
+ *
+ * @return: NETDEV_TX_OK or NETDEV_TX_BUSY
+ **/
+static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
+				     struct net_device *netdev)
+{
+		dev_kfree_skb_any(skb);
+		netdev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops rnpgbe_netdev_ops = {
+	.ndo_open = rnpgbe_open,
+	.ndo_stop = rnpgbe_close,
+	.ndo_start_xmit = rnpgbe_xmit_frame,
+};
+
 /**
  * rnpgbe_add_adapter - Add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -103,6 +153,27 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	hw->dma.dma_version = dma_version;
 	hw->driver_version = 0x0002040f;
 	info->init(hw);
+	hw->mbx.ops->init_params(hw);
+	/* echo fw driver insmod to control hw */
+	hw->ops->driver_status(hw, true, mucse_driver_insmod);
+	err = mucse_mbx_get_capability(hw);
+	if (err) {
+		dev_err(&pdev->dev,
+			"mucse_mbx_get_capability failed! %d\n",
+			err);
+		goto err_free_net;
+	}
+	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	netdev->watchdog_timeo = 5 * HZ;
+	err = hw->ops->reset_hw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
+		goto err_free_net;
+	}
+	eth_hw_addr_set(netdev, hw->perm_addr);
+	err = register_netdev(netdev);
+	if (err)
+		goto err_free_net;
 	return 0;
 
 err_free_net:
@@ -166,12 +237,16 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 {
 	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct mucse_hw *hw = &mucse->hw;
 	struct net_device *netdev;
 
 	if (!mucse)
 		return;
 	netdev = mucse->netdev;
+	if (netdev->reg_state == NETREG_REGISTERED)
+		unregister_netdev(netdev);
 	mucse->netdev = NULL;
+	hw->ops->driver_status(hw, false, mucse_driver_insmod);
 	free_netdev(netdev);
 }
 
-- 
2.25.1


