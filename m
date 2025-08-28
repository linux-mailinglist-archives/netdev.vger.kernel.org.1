Return-Path: <netdev+bounces-217590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAAFB391FC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C7E4657B0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4773270552;
	Thu, 28 Aug 2025 02:57:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4992690ED;
	Thu, 28 Aug 2025 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349826; cv=none; b=uBEBcfVWYn4vHLnjnMqa79Setp8h1vFT6oL7jsv0cChNBsMYq8+CgtXOPYFWC//sF3TDBXlbbLfcrYWMvQdB7IvXxigudm28QfVyLJjTAks+Zc7DCb6z30JG+13sD9fXUYg5xc87fa+8WgCezg3HQAcTw2pTJNf4YcNPEEuXhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349826; c=relaxed/simple;
	bh=yB0y89VplFZv/A11CEuC67ZfzNQOKSezzEPlm8RCA1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QI9yug81HARsUKLzqRRuK1xTLc12yFwjwFgL2ymDX7sM8ALdqNZIkToYSxE342KX01FAjrQ860gI4T17quPvSHMfP1SgZuTfPHg1wqQ5WhTHIb74kprlhP7eNcWbykIjqVKxEqfSgOhPbbE1I20aNqnVEuEEJ7KFGRT+tPs7oCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1756349780tcf2c1d49
X-QQ-Originating-IP: nfhrw2Ng3mJUfzYjX0xHUBR7MLw0/dc2bAddmMfRS9A=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 Aug 2025 10:56:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16946421492491032157
EX-QQ-RecipientCnt: 28
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
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	rdunlap@infradead.org,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v9 5/5] net: rnpgbe: Add register_netdev
Date: Thu, 28 Aug 2025 10:55:47 +0800
Message-Id: <20250828025547.568563-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828025547.568563-1-dong100@mucse.com>
References: <20250828025547.568563-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NH2c3QqomeNiGVd8imAOrAHGN7iCmm7Jtr3idjA+qu7exqsEJFthBWvg
	FICc3epq4sgPAijMHAy/sSOGOGBYPu8GRutb2edXhUOZH6JJjb2zd6iB5sZkE314CgDc9Mv
	/holhohMp7rK0GRvIeBIQFNt/0kEIg2EODs/BYTPs9hrHSHkrwGFSBUQyqgqeyupOG8kECS
	8XMI5ErpWd8LnmCIWOWa15RlN92M7yPvkiRTiLeBhMkZYR+qAV7eTtomrCxPGeFwX7kXVcV
	3rWE5cm0WOMaG/3I+0O2EBs8PZemkj78U20kaQKuB9akAzML6SpmYFOpqe7cB6oUAdBMcUI
	MRCJOgG8gg4gxnhWDXW8gWl8IztJJLRF22jM69DpC/cdjSLEHaNfz4hiYztFsBSCCZ8SVzU
	VPtH9+Vi/U4dx82aWHrw+WF9Rlc2oitJBPi45Sn3VnbwWcA24wKm7JmyxiYKTgYkjYa5+YH
	KbrS5GeiCEgfsO6eA4LA1sAgb1VgDdcbGmFDXHN4+1pJ/BkzijT4kMMvCbsbxZSjBzCx+NF
	dlo6dzv9BW4sbkKRn5adp+z0Bj1OzzLiPIbbtoSdX8xIb58f5QBndeYtZGFUd0g8ILbqL01
	BlrW5QAPaRVeJHMnI3cZw6eyye1cg3QPuI0+Fro5zrQnazrmFGn6X1a72yrz7i0odb9p11p
	Hxye7yydmJfCSlbnKvtpJI5fBIAZauAEzv2UkWLcxNGFFgrZla3vu4RBlKVamgPKIGWVi81
	YAUuMCBqfk194c457FiNvnC6GejTgdFaomfxKFzkCf7wZ96oFnt8aDX9rj8ex1F3pXGpKCc
	3C7NhmH+vKbeX4Ln0HQSpstTk7dYDFJgNmgdqj4fxNZqPmhOGQR7eytv18w74ve8bt9FxWx
	ylvL0U/8oFuAC4cWHWUNw1GVEoqXkSeUGDtzra90xC9qXmTwji5zybxc5dqPE36LMIZbus5
	jwqEUezZ0CDsXuEoRY8/um4s0wAJkzcI7rH2dyBN7a4JNsyNIU2RI47EuGeEC0nnaD2yT+f
	FK4/nl9TrXTbITIk/fMZOCOw02AdX0xkwyacmq6Ggf47dpgMq+
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Initialize get mac from hw, register the netdev.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 23 ++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 82 +++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 75 +++++++++++++++++
 4 files changed, 182 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 4d2cca59fb23..33ee6f05e9b8 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -24,6 +25,10 @@ enum rnpgbe_hw_type {
 	rnpgbe_hw_unknown
 };
 
+struct mucse_dma_info {
+	void __iomem *dma_base_addr;
+};
+
 struct mucse_mbx_stats {
 	u32 msgs_tx;
 	u32 msgs_rx;
@@ -47,12 +52,27 @@ struct mucse_mbx_info {
 	u32 fw2pf_mbox_vec;
 };
 
+struct mucse_hw;
+
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
 	void __iomem *hw_addr;
 	struct pci_dev *pdev;
 	enum rnpgbe_hw_type hw_type;
 	u8 pfvfnum;
+	const struct mucse_hw_operations *ops;
+	struct mucse_dma_info dma;
 	struct mucse_mbx_info mbx;
+	int port;
+	u8 perm_addr[ETH_ALEN];
 };
 
 struct mucse {
@@ -72,4 +92,7 @@ struct rnpgbe_info {
 #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
+
+#define rnpgbe_dma_wr32(dma, reg, val) \
+	writel((val), (dma)->dma_base_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index f38daef752a3..f25dbc0dab5a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,11 +1,87 @@
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
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int rnpgbe_get_permanent_mac(struct mucse_hw *hw,
+				    u8 *mac_addr)
+{
+	struct device *dev = &hw->pdev->dev;
+	int err;
+
+	err = mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port);
+	if (err) {
+		dev_err(dev, "Failed to get MAC from FW %d\n", err);
+		return err;
+	}
+
+	if (!is_valid_ether_addr(mac_addr)) {
+		dev_err(dev, "Failed to get valid MAC from FW\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * rnpgbe_reset_hw_ops - Do a hardware reset
+ * @hw: hw information structure
+ *
+ * rnpgbe_reset_hw_ops calls fw to do a hardware
+ * reset, and cleans some regs to default.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
+{
+	struct mucse_dma_info *dma = &hw->dma;
+	int err;
+
+	rnpgbe_dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
+	err = mucse_mbx_fw_reset_phy(hw);
+	if (err)
+		return err;
+	return rnpgbe_get_permanent_mac(hw, hw->perm_addr);
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
@@ -13,10 +89,16 @@
  **/
 static void rnpgbe_init_common(struct mucse_hw *hw)
 {
+	struct mucse_dma_info *dma = &hw->dma;
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
+	dma->dma_base_addr = hw->hw_addr;
+
 	mbx->pf2fw_mbox_ctrl = GBE_PF2FW_MBX_MASK_OFFSET;
 	mbx->fw_pf_mbox_mask = GBE_FWPF_MBX_MASK;
+
+	hw->ops = &rnpgbe_hw_ops;
+	hw->port = 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 746dca78f1df..0ab2c328c9e9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -11,6 +11,8 @@
 #define GBE_FWPF_MBX_MASK 0x5700
 #define N210_FW2PF_MBX_VEC_OFFSET 0x29400
 #define N210_FWPF_SHM_BASE_OFFSET 0x2d900
+/**************** DMA Registers ****************************/
+#define RNPGBE_DMA_AXI_EN 0x0010
 /**************** CHIP Resource ****************************/
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 25b7119d6ecb..82805b61cd07 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -9,6 +9,8 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
@@ -35,6 +37,55 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).
+ *
+ * Return: 0 on success, negative value on failure
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
+ * Return: 0, this is not allowed to fail
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
+ * Return: NETDEV_TX_OK or NETDEV_TX_BUSY
+ **/
+static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
+				     struct net_device *netdev)
+{
+	dev_kfree_skb_any(skb);
+	netdev->stats.tx_dropped++;
+	return NETDEV_TX_OK;
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
@@ -78,6 +129,27 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 
 	hw->hw_addr = hw_addr;
 	info->init(hw);
+	mucse_init_mbx_params_pf(hw);
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
@@ -145,12 +217,15 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 {
 	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct mucse_hw *hw = &mucse->hw;
 	struct net_device *netdev;
 
 	if (!mucse)
 		return;
 	netdev = mucse->netdev;
+	unregister_netdev(netdev);
 	mucse->netdev = NULL;
+	hw->ops->driver_status(hw, false, mucse_driver_insmod);
 	free_netdev(netdev);
 }
 
-- 
2.25.1


