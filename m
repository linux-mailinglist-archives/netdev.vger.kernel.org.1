Return-Path: <netdev+bounces-212837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D5B22394
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3723ADFFD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE12E9ED4;
	Tue, 12 Aug 2025 09:41:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C432E9EC0;
	Tue, 12 Aug 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991685; cv=none; b=taTXqbh09bvXurN641DQsfted2fZ0DuhQdIVqKCRMeUzGyKCUyBb2LOiE8Mj8r80gbwy0Zb6Uo9xhvG/NP89Jea0ItikcTc7EPE2/nLUfWzhiEMIC/0M17u2TZG+f41vT4x40NST05CBcAaS5HVshqSiXykBQEmjCxCGZaE3QF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991685; c=relaxed/simple;
	bh=Im9Vkd0s9hPxgA1luKgJ7AYpdtfWsxg+ljIHrptYs1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jn0JXApSeWyhbmb8TmwUZaw4UvXxQxYQXPR7wF6og73PR21TBXjAacC6WmDmdrfxvMUa7CzITl23ehAUMceMFOePnMkxyuanEt5oVIASU5MrqTC8Sy7++OrsLS+8WEExoo2oXnNEuK7mwW1wPE+JxOCgDU3Xm1tc2ORaL6bVP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1754991618tb7d4409b
X-QQ-Originating-IP: l0XasemLQVoKQ6eVzROs1xb4lcbZA7Ma8Y4RDF+7idw=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 17:40:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3401973990743582225
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
Subject: [PATCH v3 5/5] net: rnpgbe: Add register_netdev
Date: Tue, 12 Aug 2025 17:39:37 +0800
Message-Id: <20250812093937.882045-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250812093937.882045-1-dong100@mucse.com>
References: <20250812093937.882045-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NBi/QPTU2d7kYLspUzam+mJKmugjcn1Ol3C4iEkusRZY5zHv+sRAtT8U
	Pg8PygxLG/AMKGudYcwEjN6zgiRkD5Ji+/R4vhP5sjyhf2A26HbaRzfcNx5lj41tcx21EL0
	tFH3D5NwVvQO3WR4DVK2vAn2fZq+3ccbpZ1KL9lU6Va7O8kdJ4LhoydnDovHXlZ8YWZS+f/
	ltta7lIoNjSHu2j6eVrujoW1ZhG5AJZDqzQWSzg475v5dljciaplL6/yCoFQyN6DS5h/rER
	DcpTsDughUgil2fmJLzFYQKmfYvxn4uqA1BuClyRlkbNUZdBfQFy5+/ehhpjorH9xA/zJ63
	b2+mF75KjJil/74Vj46nXU8g2GapjBfiFVhDlaKqXRh2eLcNJTX/Q0qoCTfwW0YaTiu+mak
	XbE1cnNGw3lJOx1T8fqubHZ9XGfu1m9GZsixcu33/Yrmft16WLmbxWzwebMpBKKQ5Xn2keK
	pMrop44TpgpJR0Qoa1cVAHQ5vuNtvlALxI4TIw1wbosuocBWTClZLhzZiTMBN+ws2ulxtgj
	PQ5aYaeoLKfczFu15wA7OYzp34cSS869kNAcRk+8TNOECxoHf2t/xWeK+zlGoxKvOiPcHUR
	pscr9DxcVIbtkH//cAupbcmwNAx3gEup34W1181A2K8YyWA2HIuoJVJeXdZywuu6EawzY+J
	3vSiWdNyiijRiq7k/UpOwzJMwt/vO45lMEUIh6g5coIPbpNhkg7cJqvgdlAEopcWaLOy2TP
	8cDlK/8nFpg49lXdLBhobzL/gxHfN8aLnLoa5of3wBYVzmXJrz0C8RltAwcylP3fSATh0VO
	eqbkSK/xV47hfZyfZr5L5zLx9j7j8ygH4MHXHP1p/piashlBj4EOL7rd8qcS+kXH+ArZ2cq
	QsUgJv4pG+mJ0T6sTvuVDa2anPRT9H5non0ucLIEKDEdYKBB0O8LOOK85cHbj0GUDv02QBR
	vT942BX3pTyzqfeDD0AWO223JOlJaVfACoUNJpmOdHZKxTEpjcYnls0nIWST2I6L/+4BuF5
	+3wR+MvFtuR+jJPzPphQsN7jbWTdsSZehvJJD3l3wxX9snGKni6GvTFImsQsumBqFQilnZQ
	qMsL+XvaeBHUxHO8N/aXUTBqwI1fP5yKQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Initialize get mac from hw, register the netdev.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 22 ++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 76 +++++++++++++++++++
 4 files changed, 172 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 6cb14b79cbfe..644b8c85c29d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -86,6 +87,18 @@ struct mucse_mbx_info {
 	u32 fw2pf_mbox_vec;
 };
 
+struct mucse_hw_operations {
+	int (*init_hw)(struct mucse_hw *hw);
+	int (*reset_hw)(struct mucse_hw *hw);
+	void (*start_hw)(struct mucse_hw *hw);
+	void (*init_rx_addrs)(struct mucse_hw *hw);
+	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
+};
+
+enum {
+	mucse_driver_insmod,
+};
+
 struct mucse_hw {
 	void *back;
 	u8 pfvfnum;
@@ -96,12 +109,18 @@ struct mucse_hw {
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
+	u8 addr[ETH_ALEN];
+	u8 perm_addr[ETH_ALEN];
 };
 
 struct mucse {
@@ -123,4 +142,7 @@ struct rnpgbe_info {
 #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
+
+#define dma_wr32(dma, reg, val) writel((val), (dma)->dma_base_addr + (reg))
+#define dma_rd32(dma, reg) readl((dma)->dma_base_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 16d0a76114b5..3eaa0257f3bb 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -2,10 +2,82 @@
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
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
+	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->lane)) {
+		eth_random_addr(mac_addr);
+	} else {
+		if (!is_valid_ether_addr(mac_addr))
+			eth_random_addr(mac_addr);
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
+	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS)) {
+		rnpgbe_get_permanent_mac(hw, hw->perm_addr);
+		memcpy(hw->addr, hw->perm_addr, ETH_ALEN);
+	}
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
@@ -28,6 +100,7 @@ static void rnpgbe_init_common(struct mucse_hw *hw)
 	mac->back = hw;
 
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
index c151995309f8..e0a08fa5b297 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -8,6 +8,7 @@
 #include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
@@ -34,6 +35,54 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
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
@@ -106,6 +155,29 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
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
+	memcpy(netdev->perm_addr, hw->perm_addr, netdev->addr_len);
+	ether_addr_copy(hw->addr, hw->perm_addr);
+	err = register_netdev(netdev);
+	if (err)
+		goto err_free_net;
 	return 0;
 
 err_free_net:
@@ -170,12 +242,16 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


