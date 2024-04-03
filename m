Return-Path: <netdev+bounces-84342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B1896A7F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B794A1F25E69
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E273164;
	Wed,  3 Apr 2024 09:27:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C3130A64
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136477; cv=none; b=f6Qg/jY4D0h20EsDnM8oNh8tcQwBGzdysRVOlL7sY7v/kOpSnya+5Rz1UwKfPfevciIc+HURdzKVBpxjjJfGsCNylp+vfHwNpat0MCQHRlYyP71ZQVJDQ7jUa9hH/vV0j6BC+4eA5efWLDTrAo2s2cAXzOeyuoB0++ZxS9DVkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136477; c=relaxed/simple;
	bh=GFabwEuGbhFq8OTJ+pTL/7SFJFJKvR1KIOlB+CruWr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZ7XCfLM4FssEiN1MbBIpIQGcW1JcOx64ZhU7mGEQjvzoILippIWT0uQDffQtZqrM/pr8GRTWPUPjdkeb/XoZWuoof/bAHQde1J5wG2VvDPVlRtER2Vn98/BJZwxIQfcjm0o/H/dsz2duKkrCFHJbqsHNlC/K9WIsW5hktYPPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz9t1712136459tgn98kx
X-QQ-Originating-IP: VqGxPBgda6uCnbn0CThXlnYRYxkw4YsQgsU6Sa0MDQo=
Received: from localhost.localdomain ( [36.24.97.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 17:27:37 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: W+onFc5Tw4MZ0na36bUABnLBbtmsQyXrKeFMMLBKcxXRQIljwKjXbj8749lGJ
	bTnFJ6bFF1SVLtdSU2eMtH7++wStMFj15iKdOVVkqsI7dv6haGyUYtks/i1xtSUBurM6tk4
	wfyWsJGmoLj5fOzrXXoBbxXdi/gsq1TcWh35oNKsYvEmXM0lbdBZ6ZmL6oh/24UfKTtd0qK
	oHm+/Ox0ozyxbw0ybssd2upUAbMYksNY3cyaF01LTmYwdgHvCeAcQLOzwo3V8lsCkq0eOZU
	aRn8yjgO7vvlGdukPueV3umZzTVhqifuM5b1ve+vGAMgxjn3c9HDbWreSXKB2A1u01bGD6u
	x/2HRsL/PqZWQ4wQuEGM5Xp/Rvye4s5mzCjS7PxUY2WSBXCiJZLzeY9afY5hKHDc5w2mR/X
	r1RTtR/4id++DdobSFB7WA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4149854345897228095
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 2/7] net: libwx: Add sriov api for wangxun nics
Date: Wed,  3 Apr 2024 17:09:59 +0800
Message-ID: <249562B2DA26BA00+20240403092714.3027-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403092714.3027-1-mengyuanlou@net-swift.com>
References: <20240403092714.3027-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1

Implement sriov_configure interface for wangxun nics in libwx.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 221 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  10 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  38 +++
 5 files changed, 274 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index 913a978c9032..5b996d973d29 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o wx_sriov.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
index 1579096fb6ad..3c70654a8b14 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
@@ -23,6 +23,10 @@
 
 #define WX_VT_MSGINFO_MASK    GENMASK(23, 16)
 
+enum wxvf_xcast_modes {
+	WXVF_XCAST_MODE_NONE = 0,
+};
+
 int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
 int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
 int wx_check_for_rst_pf(struct wx *wx, u16 mbx_id);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
new file mode 100644
index 000000000000..032b75f23460
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2023 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/etherdevice.h>
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_mbx.h"
+#include "wx_sriov.h"
+
+static void wx_vf_configuration(struct pci_dev *pdev, int event_mask)
+{
+	unsigned int vfn = (event_mask & GENMASK(5, 0));
+	struct wx *wx = pci_get_drvdata(pdev);
+
+	bool enable = ((event_mask & BIT(31)) != 0);
+
+	if (enable)
+		eth_zero_addr(wx->vfinfo[vfn].vf_mac_addr);
+}
+
+static void wx_alloc_vf_macvlans(struct wx *wx, u8 num_vfs)
+{
+	struct vf_macvlans *mv_list;
+	int num_vf_macvlans, i;
+
+	/* Initialize list of VF macvlans */
+	INIT_LIST_HEAD(&wx->vf_mvs.l);
+
+	num_vf_macvlans = wx->mac.num_rar_entries -
+			  (WX_MAX_PF_MACVLANS + 1 + num_vfs);
+	if (!num_vf_macvlans)
+		return;
+
+	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
+			  GFP_KERNEL);
+	if (mv_list) {
+		for (i = 0; i < num_vf_macvlans; i++) {
+			mv_list[i].vf = -1;
+			mv_list[i].free = true;
+			list_add(&mv_list[i].l, &wx->vf_mvs.l);
+		}
+		wx->mv_list = mv_list;
+	}
+}
+
+static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
+{
+	u32 value = 0;
+	int i;
+
+	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
+	wx_err(wx, "SR-IOV enabled with %d VFs\n", num_vfs);
+
+	/* Enable VMDq flag so device will be set in VM mode */
+	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
+	if (!wx->ring_feature[RING_F_VMDQ].limit)
+		wx->ring_feature[RING_F_VMDQ].limit = 1;
+	wx->ring_feature[RING_F_VMDQ].offset = num_vfs;
+
+	wx_alloc_vf_macvlans(wx, num_vfs);
+	/* Initialize default switching mode VEB */
+	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_SW_EN, WX_PSR_CTL_SW_EN);
+
+	/* If call to enable VFs succeeded then allocate memory
+	 * for per VF control structures.
+	 */
+	wx->vfinfo = kcalloc(num_vfs, sizeof(struct vf_data_storage), GFP_KERNEL);
+	if (!wx->vfinfo)
+		return -ENOMEM;
+
+	/* enable spoof checking for all VFs */
+	for (i = 0; i < num_vfs; i++) {
+		/* enable spoof checking for all VFs */
+		wx->vfinfo[i].spoofchk_enabled = true;
+		wx->vfinfo[i].link_enable = true;
+		/* Untrust all VFs */
+		wx->vfinfo[i].trusted = false;
+		/* set the default xcast mode */
+		wx->vfinfo[i].xcast_mode = WXVF_XCAST_MODE_NONE;
+	}
+
+	if (wx->mac.type == wx_mac_sp) {
+		if (num_vfs < 32)
+			value = WX_CFG_PORT_CTL_NUM_VT_32;
+		else
+			value = WX_CFG_PORT_CTL_NUM_VT_64;
+	} else {
+		value = WX_CFG_PORT_CTL_NUM_VT_8;
+	}
+	wr32m(wx, WX_CFG_PORT_CTL,
+	      WX_CFG_PORT_CTL_NUM_VT_MASK,
+	      value);
+
+	return 0;
+}
+
+static void wx_sriov_reinit(struct wx *wx)
+{
+	rtnl_lock();
+	wx->setup_tc(wx->netdev, netdev_get_num_tc(wx->netdev));
+	rtnl_unlock();
+}
+
+int wx_disable_sriov(struct wx *wx)
+{
+	/* If our VFs are assigned we cannot shut down SR-IOV
+	 * without causing issues, so just leave the hardware
+	 * available but disabled
+	 */
+	if (pci_vfs_assigned(wx->pdev)) {
+		wx_err(wx, "Unloading driver while VFs are assigned.\n");
+		return -EPERM;
+	}
+	/* disable iov and allow time for transactions to clear */
+	pci_disable_sriov(wx->pdev);
+
+	/* set num VFs to 0 to prevent access to vfinfo */
+	wx->num_vfs = 0;
+
+	/* free VF control structures */
+	kfree(wx->vfinfo);
+	wx->vfinfo = NULL;
+
+	/* free macvlan list */
+	kfree(wx->mv_list);
+	wx->mv_list = NULL;
+
+	/* set default pool back to 0 */
+	wr32m(wx, WX_PSR_VM_CTL, WX_PSR_VM_CTL_POOL_MASK, 0);
+	wx->ring_feature[RING_F_VMDQ].offset = 0;
+
+	clear_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
+	/* Disable VMDq flag so device will be set in VM mode */
+	if (wx->ring_feature[RING_F_VMDQ].limit == 1)
+		clear_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_disable_sriov);
+
+static int wx_pci_sriov_enable(struct pci_dev *dev,
+			       int num_vfs)
+{
+	struct wx *wx = pci_get_drvdata(dev);
+	int err = 0, i;
+
+	err = __wx_enable_sriov(wx, num_vfs);
+	if (err)
+		goto err_out;
+
+	wx->num_vfs = num_vfs;
+	for (i = 0; i < wx->num_vfs; i++)
+		wx_vf_configuration(dev, (i | BIT(31)));
+
+	/* reset before enabling SRIOV to avoid mailbox issues */
+	wx_sriov_reinit(wx);
+
+	err = pci_enable_sriov(dev, num_vfs);
+	if (err) {
+		wx_err(wx, "Failed to enable PCI sriov: %d\n", err);
+		goto err_out;
+	}
+
+	return num_vfs;
+err_out:
+	return err;
+}
+
+static int wx_pci_sriov_disable(struct pci_dev *dev)
+{
+	struct wx *wx = pci_get_drvdata(dev);
+	int err;
+
+	err = wx_disable_sriov(wx);
+
+	/* reset before enabling SRIOV to avoid mailbox issues */
+	if (!err)
+		wx_sriov_reinit(wx);
+
+	return err;
+}
+
+static int wx_check_sriov_allowed(struct wx *wx, int num_vfs)
+{
+	u16 max_vfs;
+
+	max_vfs = (wx->mac.type == wx_mac_sp) ? 63 : 7;
+
+	if (num_vfs > max_vfs)
+		return -EPERM;
+
+	return 0;
+}
+
+int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	int err;
+
+	err = wx_check_sriov_allowed(wx, num_vfs);
+	if (err)
+		return err;
+
+	if (!num_vfs) {
+		if (!pci_vfs_assigned(pdev)) {
+			wx_pci_sriov_disable(pdev);
+			return 0;
+		}
+
+		wx_err(wx, "can't free VFs because some are assigned to VMs.\n");
+		return -EBUSY;
+	}
+
+	err = wx_pci_sriov_enable(pdev, num_vfs);
+	if (err)
+		return err;
+
+	return num_vfs;
+}
+EXPORT_SYMBOL(wx_pci_sriov_configure);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
new file mode 100644
index 000000000000..17b547ae8862
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _WX_SRIOV_H_
+#define _WX_SRIOV_H_
+
+int wx_disable_sriov(struct wx *wx);
+int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
+
+#endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index f29ac955dc83..c1bf8653b900 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -18,6 +18,7 @@
 /* MSI-X capability fields masks */
 #define WX_PCIE_MSIX_TBL_SZ_MASK                0x7FF
 #define WX_PCI_LINK_STATUS                      0xB2
+#define WX_MAX_PF_MACVLANS                      15
 
 /**************** Global Registers ****************************/
 /* chip control Registers */
@@ -88,6 +89,9 @@
 #define WX_CFG_TAG_TPID(_i)          (0x14430 + ((_i) * 4))
 #define WX_CFG_PORT_CTL_NUM_VT_MASK  GENMASK(13, 12) /* number of TVs */
 
+#define WX_CFG_PORT_CTL_NUM_VT_8     FIELD_PREP(GENMASK(13, 12), 1)
+#define WX_CFG_PORT_CTL_NUM_VT_32    FIELD_PREP(GENMASK(13, 12), 2)
+#define WX_CFG_PORT_CTL_NUM_VT_64    FIELD_PREP(GENMASK(13, 12), 3)
 
 /* GPIO Registers */
 #define WX_GPIO_DR                   0x14800
@@ -161,6 +165,7 @@
 /******************************* PSR Registers *******************************/
 /* psr control */
 #define WX_PSR_CTL                   0x15000
+#define WX_PSR_VM_CTL                0x151B0
 /* Header split receive */
 #define WX_PSR_CTL_SW_EN             BIT(18)
 #define WX_PSR_CTL_RSC_ACK           BIT(17)
@@ -181,6 +186,7 @@
 /* mcasst/ucast overflow tbl */
 #define WX_PSR_MC_TBL(_i)            (0x15200  + ((_i) * 4))
 #define WX_PSR_UC_TBL(_i)            (0x15400 + ((_i) * 4))
+#define WX_PSR_VM_CTL_POOL_MASK      GENMASK(12, 7)
 
 /* VM L2 contorl */
 #define WX_PSR_VM_L2CTL(_i)          (0x15600 + ((_i) * 4))
@@ -943,6 +949,7 @@ struct wx_ring_feature {
 enum wx_ring_f_enum {
 	RING_F_NONE = 0,
 	RING_F_RSS,
+	RING_F_VMDQ,
 	RING_F_ARRAY_SIZE  /* must be last in enum set */
 };
 
@@ -986,9 +993,33 @@ struct wx_hw_stats {
 	u64 qmprc;
 };
 
+struct vf_data_storage {
+	struct pci_dev *vfdev;
+	unsigned char vf_mac_addr[ETH_ALEN];
+	bool spoofchk_enabled;
+	bool link_enable;
+	bool trusted;
+	int xcast_mode;
+};
+
+struct vf_macvlans {
+	struct list_head l;
+	int vf;
+	bool free;
+	bool is_macvlan;
+	u8 vf_macvlan[ETH_ALEN];
+};
+
+enum wx_pf_flags {
+	WX_FLAG_VMDQ_ENABLED,
+	WX_FLAG_SRIOV_ENABLED,
+	WX_PF_FLAGS_NBITS		/* must be last */
+};
+
 struct wx {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 
+	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
 	void *priv;
 	u8 __iomem *hw_addr;
 	struct pci_dev *pdev;
@@ -1076,6 +1107,13 @@ struct wx {
 	u64 hw_csum_rx_good;
 	u64 hw_csum_rx_error;
 	u64 alloc_rx_buff_failed;
+
+	unsigned int num_vfs;
+	struct vf_data_storage *vfinfo;
+	struct vf_macvlans vf_mvs;
+	struct vf_macvlans *mv_list;
+
+	int (*setup_tc)(struct net_device *netdev, u8 tc);
 };
 
 #define WX_INTR_ALL (~0ULL)
-- 
2.43.2


