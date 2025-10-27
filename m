Return-Path: <netdev+bounces-233073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51765C0BC1D
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 04:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CADC18A333B
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F812D0620;
	Mon, 27 Oct 2025 03:30:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D72D8797;
	Mon, 27 Oct 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535811; cv=none; b=qNr/oyf9T88lvb0A+Si8pIhRl5E56CVJlWiFFqv0SDBK8CTYyCMVqnWjaJr7Hniab/X5sL1b0/nveWTF9mqPQtHDhhnaNzSy3qXPlZc4ilMO+8SzBSQ4/YCyizWPHcYbcm08T9C04uuczQQNIrxgTuB7K0aqEba75Y2QOraXocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535811; c=relaxed/simple;
	bh=FP3scRSWmy6T/27Xx7Ci/dJ+/UlDf+/Oyo+7Yt0U7Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHfNP31A0xSGRnRJyI2OcCl/zdZAOapGLWtakTe7cGiR4Uo1wHV4YcJVu8PxSxhWtVgZ8fwZfCcbVsrNwyO+llmXb0dafGEbxI4bvWWwx09NPuXbgKf23TCBXzCkZ7NudWyIK9avjODmtIIGej3Fg9SLdy4njtHUDVIU2vETai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1761535775t275faa42
X-QQ-Originating-IP: kHde58sSBI0uA78RvYiv+PC6B4rynyVAad344SkmVsU=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 11:29:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4632171058279916096
EX-QQ-RecipientCnt: 17
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	geert+renesas@glider.be,
	mpe@ellerman.id.au,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v16 5/5] net: rnpgbe: Add register_netdev
Date: Mon, 27 Oct 2025 11:29:05 +0800
Message-Id: <20251027032905.94147-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251027032905.94147-1-dong100@mucse.com>
References: <20251027032905.94147-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MrTVJ9obs/HIPIT4cA4uftEEszYdsYs/lHlmYZHlV5udcA4vRACPNRmT
	Sk7NMfifIxOcJofAiPJYpfFNMvmaq4wP2KX4ae5KiOMuAX2hKbVN7QPqC3vQTHjcsK7oAb6
	M8VrF+hZ82JMzspC1iwSG0wdw7KCb1rUh6MSLW8P9yoZIPDYSIO85Qodclv490iU36SBsXc
	z3Y0j9h2tzYL5m4ETHaY7V41HWfjiSJbOi5+9WJkRsvSegsFzPRsPMlzCVBQq36I94pJyhM
	AyvaLeKo3HZUxEKVotxKPYR4oBeJbgYpx1qjgDIoXecdjZBBnamqeomDRrlNOu9nEdLPzZl
	J/Wq5U5k17tqpwUHaVd/xG8lmBRabb5mLv1iHdeikIyKN0WcTwDhQBMBTfST08pcUdcPyud
	wBHma0P0YNLGZXUrw8Qk10WrfSY9mezj3SFZz9wGgCZ5M6af1j7PLtWJpbVf7I9bsvyByjW
	24Ef412zDOEGEt2SXNFqM089XJe7IoQdUEFuuH0zcCnYaGfElK8XZ06irWLeXDbvcPh+d60
	vTgOiffSSRqCoidBaYA3E8x5UzoSaZN4aIedxlwKnQtmFrY32J41+9isQAh9q6D9oDoq3NS
	EGTaF2b5n2sa6IMVsMNzIv77UrkHktHwmenV1WWBZaoLptfeGlVHFDR3Wd6mvRjWKQkCa+X
	plobKt8Dpb7brRcJ35m9qonWymjzkjFwMbsReKq6BCnuxFL+Fwcc0apWBLKnDg2aARBnz16
	35TdPJG80g58l7A3yv79nh2bn60dSWW+n2hqK+mRuT9LfJaTSVrdlh3UDCBh1/buYhZZLW3
	BSpaoayx73mRKS/FZ3pWB/xu9HNcNb/c/sQ3y8i9FZlJ/6MawthJgky/MGvjopec2nfZzmO
	sOPjJx3QgMvdOU3H1OpNdamLA7yRLnnmviKd00wwe3DK0ZvxaAaYjLo75iOjJTUit8Pl3o+
	H/PFCAPetrxCI6OXjNqRP57rBBnkKvyF4k6+DO6CE4N/YQ+i2sSkRd9YW+iV+HOdztkjIff
	ejReb2/qYwLsPv4ePG0vMhjedRojxbMB2HaoIRfgq8jX9fY3x/
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Complete the network device (netdev) registration flow for Mucse Gbe
Ethernet chips, including:
1. Hardware state initialization:
   - Send powerup notification to firmware (via echo_fw_status)
   - Sync with firmware
   - Reset hardware
2. MAC address handling:
   - Retrieve permanent MAC from firmware (via mucse_mbx_get_macaddr)
   - Fallback to random valid MAC (eth_random_addr) if not valid mac
     from Fw

Signed-off-by: Dong Yibo <dong100@mucse.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  24 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  73 +++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 117 +++++++++++++++++-
 4 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 37bd9278beaa..27fb080c0e37 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 
 enum rnpgbe_boards {
 	board_n500,
@@ -26,18 +27,38 @@ struct mucse_mbx_info {
 	u32 fwpf_ctrl_base;
 };
 
+/* Enum for firmware notification modes,
+ * more modes (e.g., portup, link_report) will be added in future
+ **/
+enum {
+	mucse_fw_powerup,
+};
+
 struct mucse_hw {
 	void __iomem *hw_addr;
+	struct pci_dev *pdev;
 	struct mucse_mbx_info mbx;
+	int port;
+	u8 perm_addr[ETH_ALEN];
 	u8 pfvfnum;
 };
 
+struct mucse_stats {
+	u64 tx_dropped;
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	struct mucse_hw hw;
+	struct mucse_stats stats;
 };
 
+int rnpgbe_get_permanent_mac(struct mucse_hw *hw);
+int rnpgbe_reset_hw(struct mucse_hw *hw);
+int rnpgbe_send_notify(struct mucse_hw *hw,
+		       bool enable,
+		       int mode);
 int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 
 /* Device IDs */
@@ -46,4 +67,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 #define RNPGBE_DEVICE_ID_N500_DUAL_PORT   0x8318
 #define RNPGBE_DEVICE_ID_N210             0x8208
 #define RNPGBE_DEVICE_ID_N210L            0x820a
+
+#define mucse_hw_wr32(hw, reg, val) \
+	writel((val), (hw)->hw_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 5739db98f12a..2ec6e28d2c35 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,11 +1,82 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
+#include <linux/pci.h>
 #include <linux/errno.h>
+#include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
 #include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
+
+/**
+ * rnpgbe_get_permanent_mac - Get permanent mac
+ * @hw: hw information structure
+ *
+ * rnpgbe_get_permanent_mac tries to get mac from hw
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int rnpgbe_get_permanent_mac(struct mucse_hw *hw)
+{
+	struct device *dev = &hw->pdev->dev;
+	u8 *mac_addr = hw->perm_addr;
+	int err;
+
+	err = mucse_mbx_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port);
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
+ * rnpgbe_reset_hw - Do a hardware reset
+ * @hw: hw information structure
+ *
+ * rnpgbe_reset_hw calls fw to do a hardware
+ * reset, and cleans some regs to default.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int rnpgbe_reset_hw(struct mucse_hw *hw)
+{
+	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, 0);
+	return mucse_mbx_reset_hw(hw);
+}
+
+/**
+ * rnpgbe_send_notify - Echo fw status
+ * @hw: hw information structure
+ * @enable: true or false status
+ * @mode: status mode
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int rnpgbe_send_notify(struct mucse_hw *hw,
+		       bool enable,
+		       int mode)
+{
+	int err;
+	/* Keep switch struct to support more modes in the future */
+	switch (mode) {
+	case mucse_fw_powerup:
+		err = mucse_mbx_powerup(hw, enable);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
 
 /**
  * rnpgbe_init_n500 - Setup n500 hw info
@@ -50,6 +121,8 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
 {
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
+	hw->port = 0;
+
 	mbx->pf2fw_mbx_ctrl = MUCSE_GBE_PFFW_MBX_CTRL_OFFSET;
 	mbx->fwpf_mbx_mask = MUCSE_GBE_FWPF_MBX_MASK_OFFSET;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 268f572936aa..e77e6bc3d3e3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -11,5 +11,7 @@
 #define MUCSE_N210_FWPF_CTRL_BASE      0x29400
 #define MUCSE_N210_FWPF_SHM_BASE       0x2d900
 
+#define RNPGBE_DMA_AXI_EN              0x0010
+
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index d8aaac79ff4b..e4392ddfbce2 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -7,6 +7,7 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 
@@ -24,6 +25,58 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).
+ *
+ * Return: 0
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
+ * Return: NETDEV_TX_OK
+ **/
+static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
+				     struct net_device *netdev)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+
+	dev_kfree_skb_any(skb);
+	mucse->stats.tx_dropped++;
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops rnpgbe_netdev_ops = {
+	.ndo_open       = rnpgbe_open,
+	.ndo_stop       = rnpgbe_close,
+	.ndo_start_xmit = rnpgbe_xmit_frame,
+};
+
 /**
  * rnpgbe_add_adapter - Add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -42,7 +95,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	void __iomem *hw_addr;
 	struct mucse *mucse;
 	struct mucse_hw *hw;
-	int err;
+	int err, err_notify;
 
 	netdev = alloc_etherdev_mq(sizeof(struct mucse), RNPGBE_MAX_QUEUES);
 	if (!netdev)
@@ -64,14 +117,66 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	hw->hw_addr = hw_addr;
+	hw->pdev = pdev;
+
 	err = rnpgbe_init_hw(hw, board_type);
 	if (err) {
 		dev_err(&pdev->dev, "Init hw err %d\n", err);
 		goto err_free_net;
 	}
+	/* Step 1: Send power-up notification to firmware (no response expected)
+	 * This informs firmware to initialize hardware power state, but
+	 * firmware only acknowledges receipt without returning data. Must be
+	 * done before synchronization as firmware may be in low-power idle
+	 * state initially.
+	 */
+	err_notify = rnpgbe_send_notify(hw, true, mucse_fw_powerup);
+	if (err_notify) {
+		dev_warn(&pdev->dev, "Send powerup to hw failed %d\n",
+			 err_notify);
+		dev_warn(&pdev->dev, "Maybe low performance\n");
+	}
+	/* Step 2: Synchronize mailbox communication with firmware (requires
+	 * response) After power-up, confirm firmware is ready to process
+	 * requests with responses. This ensures subsequent request/response
+	 * interactions work reliably.
+	 */
+	err = mucse_mbx_sync_fw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Sync fw failed! %d\n", err);
+		goto err_powerdown;
+	}
 
-	return 0;
+	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	err = rnpgbe_reset_hw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
+		goto err_powerdown;
+	}
+
+	err = rnpgbe_get_permanent_mac(hw);
+	if (err == -EINVAL) {
+		dev_warn(&pdev->dev, "Using random MAC\n");
+		eth_random_addr(hw->perm_addr);
+	} else if (err) {
+		dev_err(&pdev->dev, "get perm_addr failed %d\n", err);
+		goto err_powerdown;
+	}
+
+	eth_hw_addr_set(netdev, hw->perm_addr);
+	err = register_netdev(netdev);
+	if (err)
+		goto err_powerdown;
 
+	return 0;
+err_powerdown:
+	/* notify powerdown only powerup ok */
+	if (!err_notify) {
+		err_notify = rnpgbe_send_notify(hw, false, mucse_fw_powerup);
+		if (err_notify)
+			dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n",
+				 err_notify);
+	}
 err_free_net:
 	free_netdev(netdev);
 	return err;
@@ -138,11 +243,17 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 {
 	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct mucse_hw *hw = &mucse->hw;
 	struct net_device *netdev;
+	int err;
 
 	if (!mucse)
 		return;
 	netdev = mucse->netdev;
+	unregister_netdev(netdev);
+	err = rnpgbe_send_notify(hw, false, mucse_fw_powerup);
+	if (err)
+		dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n", err);
 	free_netdev(netdev);
 }
 
@@ -173,6 +284,8 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
 
 	rtnl_lock();
 	netif_device_detach(netdev);
+	if (netif_running(netdev))
+		rnpgbe_close(netdev);
 	rtnl_unlock();
 	pci_disable_device(pdev);
 }
-- 
2.25.1


