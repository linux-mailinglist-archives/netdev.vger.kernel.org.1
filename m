Return-Path: <netdev+bounces-214529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB1DB2A0A5
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00747561AF1
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9D931A060;
	Mon, 18 Aug 2025 11:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616B26F2A0;
	Mon, 18 Aug 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516625; cv=none; b=XnD4fzpXn1B/6D7L/SLEuZDP7lCuX8JBq7jQYg9n9gk1KRjWqWSzlsBl7StwAaoz7ShZVWZFRIK/TRVqBeYh5jBfuf1yzP03uCHke6yNMRavnt1D/PUtq/NjHlIyIdBZQj+0N9EQ0au+t/o7XhS2bCntVlbj8rWBluiCcGHXj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516625; c=relaxed/simple;
	bh=s5ddgFsGGGk1pcIW/Fr3GYZhq6M5E684EPn3M+VHnPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWJbrgfwC6KZJ/rgyGrdPySVC1CWiWDh35nXAf9qzXsKe8aD45+VNOKLEuSnC3IsfrkDHN0HpIe5iAYFXpSP5MOKD6kgDsdil+qWz50giKXkYTqTds7JlOlFSHmkjyPwmKZpoOJN2U+hjkQk34UqHhqowpSBRKQgAvj022B9uSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1755516572t4c883a33
X-QQ-Originating-IP: Z7rUYEvrlMkARr6Zw4Y/nJVtfly9OFveXrOrlfgQY6Y=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 19:29:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 382944158943631087
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
Subject: [PATCH v5 5/5] net: rnpgbe: Add register_netdev
Date: Mon, 18 Aug 2025 19:28:56 +0800
Message-Id: <20250818112856.1446278-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250818112856.1446278-1-dong100@mucse.com>
References: <20250818112856.1446278-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ODdlE4ipA1aGooQCdXCVbsyoPt8Nd3ofuLSR/uI7GOrmxFx/rz/3qOdW
	YJpWM0WmyHLnK99WiFJKpDqiG+1ia08SfrUExvWnlpMBtif7Hbmb8/unr53lqtGr5lJAn9Q
	YH4ye/pXZmiTGZvlDopDRF08oUsi7iX3C2DJye5H2fSsp3HgQTlgymhj/SgcjnrhTFYDfPn
	CAJsDv4jP7dGGV4Fu/EwGsLSCfQt5YiCvFZd1cR4SEwOAOSF4T/dleKBB3T2KOqeTwPwt2b
	FknUu+O8WmME6HqReGBWhneQeBqvU/UpgTrtevN/fBajI1eG8JsJacXmUPQnbY+mGKBN26l
	2TZ1cT9vSuHaVOBsVWBquRzaw+/xT4alU7q4Twuo5ikgni/ZHjjcTRKBxBVhrWAppNHI1y7
	F946tqWAI81vAUIXwcrg3vTU2vKnF/pWVaVZMfi+6QPE6+TRjhe8G/2dxBIPzeSA9jWY6NB
	+pwyb21WE+PYLA34s9bNUakSX+yBVf3xo020t9oNSXEKV0xTIUq6/pXHJVJc/HIIQHLcOGO
	8Vsx9pl9K2kUTeNs1xdEUSdzd0Vk11Zr+XmerHRf/Xy3eeVfeCukM2TRegAlCiAtTwrkhrh
	sEXLaiSHiDtTZSaXbSuM0PXmmIlm8YYQeIcETDAd900n0UUgEBkqG4eQxGvCKPYW/WYGNyJ
	sf2yacdOI7osqsT1giGZoKSAAyXkxFRODBiLXBOwAa6bXFxxXgqo2YdLpxGN1gE1CWY/jAJ
	0QRay1d5/7M/8iabENx45j6sIL+YJeSaO7m/QwP/pEm8VFjya4CZNvCVtZ6hoVbt0hdIrm0
	JRR9GjjwkURh9o2xHWlzejN2CR28W2X6Gh0mgDtM/a6BfuRaCIb3h9xGtUkJietWcGRAeKs
	M1qRLyuLN55dgUJX5zRo35JiRlhxsQAZkxLu0GYCHiiwxRpobrUn0oAquHBZ9kjl8zzWB2v
	Kp1/DKK9uL2sLj5icQbnYWph+k420CX8dpbxZYi/LXAS1g6hHpnY6DLV6AU2+ugKFP4lxvC
	N2tLhgnX9NT/OlIMbZU3MaGnf8V9iIU5RORMzvu062aGuzpKa1laohhGRrRT1T+wb+85hl5
	KDh3ydpRVco
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Initialize get mac from hw, register the netdev.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 18 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 72 ++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 75 +++++++++++++++++++
 4 files changed, 166 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 6a77fcfa0b09..1630885366cf 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -63,6 +64,17 @@ struct mucse_mbx_info {
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
 	void __iomem *ring_msix_base;
@@ -71,11 +83,15 @@ struct mucse_hw {
 	u32 bd_uid;
 	enum rnpgbe_hw_type hw_type;
 	u8 pfvfnum;
+	const struct mucse_hw_operations *ops;
 	struct mucse_dma_info dma;
 	struct mucse_eth_info eth;
 	struct mucse_mac_info mac;
 	struct mucse_mbx_info mbx;
+	u32 flags;
 	u32 usecstocount;
+	int port;
+	u8 perm_addr[ETH_ALEN];
 };
 
 struct mucse {
@@ -96,4 +112,6 @@ struct rnpgbe_info {
 #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
+
+#define rnpgbe_dma_wr32(dma, reg, val) writel((val), (dma)->dma_base_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 452541c9e1e9..d3da4ad760a4 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,11 +1,81 @@
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
+ * @return: 0 or -EINVAL
+ **/
+static int rnpgbe_get_permanent_mac(struct mucse_hw *hw,
+				    u8 *mac_addr)
+{
+	struct device *dev = &hw->pdev->dev;
+
+	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port) ||
+	    !is_valid_ether_addr(mac_addr)) {
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
+ * @return: 0 on success, negative on failure
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
@@ -27,6 +97,8 @@ static void rnpgbe_init_common(struct mucse_hw *hw)
 
 	mbx->pf2fw_mbox_ctrl = GBE_PF2FW_MBX_MASK_OFFSET;
 	mbx->fw_pf_mbox_mask = GBE_FWPF_MBX_MASK;
+
+	hw->ops = &rnpgbe_hw_ops;
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index cb3eb53b804d..42acc96e5b26 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -20,6 +20,7 @@
 #define N210_DEFAULT_USECSTOCOUNT 62
 /**************** DMA Registers ****************************/
 #define RNPGBE_DMA_DUMY 0x000c
+#define RNPGBE_DMA_AXI_EN 0x0010
 /**************** CHIP Resource ****************************/
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 89d8f78af146..4d75f73b012b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -8,6 +8,8 @@
 #include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
@@ -34,6 +36,55 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
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
@@ -82,6 +133,27 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	hw->hw_addr = hw_addr;
 	hw->dma.dma_version = dma_version;
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


