Return-Path: <netdev+bounces-176989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488F6A6D2E7
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 03:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD3716DFE2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 02:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2C615E96;
	Mon, 24 Mar 2025 02:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA815D1
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742781682; cv=none; b=oLjO0P7FoXwdXTcYvmYCb3rlsOKNwGxlJoAABKSlHOv0mC+FFmA3roEc+YaZt+lOY7ObYx0fwgAHHPUwtE/o73CAMiukRBmmv2NrfHpkiU24jzR/WQJlsl/ioPtaMDjdgynzJdoFjWBFKByTS/0XKG+lH1O07MpGZpDf7D3lXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742781682; c=relaxed/simple;
	bh=O1upGiAxhD1MzWJnBxTt9VxJXUSspq6DD+1rlIHjc7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQ+UOnfGYD6N4lbjxlcla9gfPSKRospF/CNG+MrctYFqiQRDHMxAz1R/vTmweOy+xZGq5s8/SyihAN6Stib3f2Lt+zJhwuuuaZyA+CtVQu2B323c6xBe6PlwbABmz5uzBDkNUpDhMi7mbW8MHrHdVJYkqsaicLYGsGJ4ZwLsC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz6t1742781651t29idea
X-QQ-Originating-IP: lIhHroMvTKfuU2sIHxSxOBwz99q3P8iuP+nuv5ROsqo=
Received: from localhost.localdomain ( [60.186.241.229])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Mar 2025 10:00:49 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13351892728711411881
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RESEND,PATCH net-next v9 2/6] net: libwx: Add sriov api for wangxun nics
Date: Mon, 24 Mar 2025 10:00:29 +0800
Message-ID: <BB5F8D8A58D935D7+20250324020033.36225-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324020033.36225-1-mengyuanlou@net-swift.com>
References: <20250324020033.36225-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nr5N425iK0yraAWDZ2hE8TRJvRnMXkkHKr/tJWCZMKV6xPX0VrjTySn2
	1ruNDpsTO15Zspasd9yszIi0bsTHiWoOSt1euQ2/K4lglJfC+aR5O3pOprycC/R4tqsQdYX
	x+08nqi/VOXWNYmS8OqBEbX2Xx4YvAzGWpZrMqd66Evzq7zosnX+DaqhjOMRDvnR0JFTZB1
	gsXcZ0sQ+Hn1Or7tJDmFXQJ++exARo6fS+UgbFgvlrohDyv0a9gZnJakq14ZsA/+w5CJOk9
	cefAYWR+4hUGnlf8gPO4nagnZfYg6HNfmTBqXhppWV5LQHGgToc42svTC6LfOB6nf24/Adw
	8G9lXqXYg/r/dK3W6t5AlDrkNHiutGE3hVt2H7wG0PVeV/LjA7q18MqARNR22cC2obbeSnM
	D4oX5Bs6+wSKgUzi1yumiDs/sX4bQy83CasDOIr4OKIync9f3B4CmW4FogtMO5QxjNoeDh/
	7M4lJfDzi7VOe4IYGHcvLFA4BSbRzehnL4HoNcmzMm2u+14G6bt/NJufgPbY6/iiWICp/fL
	EZRGMOg2rHUjdWF/t/grfP7VdCy3cImwcmpqReGP5NVo5njLq7V/9/SxS3831Rio0iGm52o
	oHiKnXpn+FKPzKSS7AWc72d5I1juGwpQ6AVwFO9seFxjxBpjiZrnb1FteLIV5KJH0Zhrn6j
	1TBYmwxB55awxgi7dxXOF4EL0HBnLGXasesgGYfcrmRNQi0k3Q5dhlb0umbUX9/iHTbptRR
	E3ArETbyYkwvw6u7E0V5pOUvqNolDn1ngLGQXHI6vQghlRVyiyz8XcTbCGcSBrRhVO87AFR
	UeyCzC768weB0/BhJia0575wKa0+0Txpth0OLZm/1WcsqWTeido4dGuBCw7u/VqU1vH/rBi
	GGL+a3Z4gWrrq6ij+bbfgXOwKSynDNmlxSVUkY2NjrHIW0miJhdiAcrNiNMDySHNLrYiufq
	VYpS4kDp2Runajt1nV/c+TCT7L92lqbLtKO/GtKgyJEhqbHhgGLBG1pYQ2VLSzZGoXDRlYl
	7vpiMXADdoYsFS8xqoWSfQzW7e+HTbGnjvhJ9QLA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Implement sriov_configure interface for wangxun nics in libwx.
Enable VT mode and initialize vf control structure, when sriov
is enabled. Do not be allowed to disable sriov when vfs are
assigned.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 200 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  14 ++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  31 +++
 5 files changed, 250 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index cd1675ef3253..9b78b604a94e 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
index c09b25f3e43d..172b46b9c14d 100644
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
index 000000000000..ce7469e1cf3e
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
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
+	bool enable = !!WX_VF_ENABLE_CHECK(event_mask);
+	struct wx *wx = pci_get_drvdata(pdev);
+	u32 vfn = WX_VF_NUM_GET(event_mask);
+
+	if (enable)
+		eth_zero_addr(wx->vfinfo[vfn].vf_mac_addr);
+}
+
+static int wx_alloc_vf_macvlans(struct wx *wx, u8 num_vfs)
+{
+	struct vf_macvlans *mv_list;
+	int num_vf_macvlans, i;
+
+	/* Initialize list of VF macvlans */
+	INIT_LIST_HEAD(&wx->vf_mvs.mvlist);
+
+	num_vf_macvlans = wx->mac.num_rar_entries -
+			  (WX_MAX_PF_MACVLANS + 1 + num_vfs);
+	if (!num_vf_macvlans)
+		return -EINVAL;
+
+	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
+			  GFP_KERNEL);
+	if (!mv_list)
+		return -ENOMEM;
+
+	for (i = 0; i < num_vf_macvlans; i++) {
+		mv_list[i].vf = -1;
+		mv_list[i].free = true;
+		list_add(&mv_list[i].mvlist, &wx->vf_mvs.mvlist);
+	}
+	wx->mv_list = mv_list;
+
+	return 0;
+}
+
+static void wx_sriov_clear_data(struct wx *wx)
+{
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
+	/* Disable VMDq flag so device will be set in NM mode */
+	if (wx->ring_feature[RING_F_VMDQ].limit == 1)
+		clear_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
+}
+
+static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
+{
+	int i, ret = 0;
+	u32 value = 0;
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
+	wx->vfinfo = kcalloc(num_vfs, sizeof(struct vf_data_storage),
+			     GFP_KERNEL);
+	if (!wx->vfinfo)
+		return -ENOMEM;
+
+	ret = wx_alloc_vf_macvlans(wx, num_vfs);
+	if (ret)
+		return ret;
+
+	/* Initialize default switching mode VEB */
+	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_SW_EN, WX_PSR_CTL_SW_EN);
+
+	for (i = 0; i < num_vfs; i++) {
+		/* enable spoof checking for all VFs */
+		wx->vfinfo[i].spoofchk_enabled = true;
+		wx->vfinfo[i].link_enable = true;
+		/* untrust all VFs */
+		wx->vfinfo[i].trusted = false;
+		/* set the default xcast mode */
+		wx->vfinfo[i].xcast_mode = WXVF_XCAST_MODE_NONE;
+	}
+
+	if (wx->mac.type == wx_mac_em) {
+		value = WX_CFG_PORT_CTL_NUM_VT_8;
+	} else {
+		if (num_vfs < 32)
+			value = WX_CFG_PORT_CTL_NUM_VT_32;
+		else
+			value = WX_CFG_PORT_CTL_NUM_VT_64;
+	}
+	wr32m(wx, WX_CFG_PORT_CTL,
+	      WX_CFG_PORT_CTL_NUM_VT_MASK,
+	      value);
+
+	return ret;
+}
+
+static void wx_sriov_reinit(struct wx *wx)
+{
+	rtnl_lock();
+	wx->setup_tc(wx->netdev, netdev_get_num_tc(wx->netdev));
+	rtnl_unlock();
+}
+
+void wx_disable_sriov(struct wx *wx)
+{
+	if (!pci_vfs_assigned(wx->pdev))
+		pci_disable_sriov(wx->pdev);
+	else
+		wx_err(wx, "Unloading driver while VFs are assigned.\n");
+
+	/* clear flags and free allloced data */
+	wx_sriov_clear_data(wx);
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
+		return err;
+
+	wx->num_vfs = num_vfs;
+	for (i = 0; i < wx->num_vfs; i++)
+		wx_vf_configuration(dev, (i | WX_VF_ENABLE));
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
+	wx_sriov_clear_data(wx);
+	return err;
+}
+
+static void wx_pci_sriov_disable(struct pci_dev *dev)
+{
+	struct wx *wx = pci_get_drvdata(dev);
+
+	wx_disable_sriov(wx);
+	wx_sriov_reinit(wx);
+}
+
+int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	int err;
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
index 000000000000..e5fd96b7c598
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _WX_SRIOV_H_
+#define _WX_SRIOV_H_
+
+#define WX_VF_ENABLE_CHECK(_m)          FIELD_GET(BIT(31), (_m))
+#define WX_VF_NUM_GET(_m)               FIELD_GET(GENMASK(5, 0), (_m))
+#define WX_VF_ENABLE                    BIT(31)
+
+void wx_disable_sriov(struct wx *wx);
+int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
+
+#endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 18287b0ee040..26776dee6490 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -20,6 +20,7 @@
 /* MSI-X capability fields masks */
 #define WX_PCIE_MSIX_TBL_SZ_MASK                0x7FF
 #define WX_PCI_LINK_STATUS                      0xB2
+#define WX_MAX_PF_MACVLANS                      15
 
 /**************** Global Registers ****************************/
 #define WX_VF_REG_OFFSET(_v)         FIELD_GET(GENMASK(15, 5), (_v))
@@ -93,6 +94,9 @@
 #define WX_CFG_TAG_TPID(_i)          (0x14430 + ((_i) * 4))
 #define WX_CFG_PORT_CTL_NUM_VT_MASK  GENMASK(13, 12) /* number of TVs */
 
+#define WX_CFG_PORT_CTL_NUM_VT_8     FIELD_PREP(GENMASK(13, 12), 1)
+#define WX_CFG_PORT_CTL_NUM_VT_32    FIELD_PREP(GENMASK(13, 12), 2)
+#define WX_CFG_PORT_CTL_NUM_VT_64    FIELD_PREP(GENMASK(13, 12), 3)
 
 /* GPIO Registers */
 #define WX_GPIO_DR                   0x14800
@@ -168,6 +172,7 @@
 /******************************* PSR Registers *******************************/
 /* psr control */
 #define WX_PSR_CTL                   0x15000
+#define WX_PSR_VM_CTL                0x151B0
 /* Header split receive */
 #define WX_PSR_CTL_SW_EN             BIT(18)
 #define WX_PSR_CTL_RSC_ACK           BIT(17)
@@ -205,6 +210,7 @@
 /* mcasst/ucast overflow tbl */
 #define WX_PSR_MC_TBL(_i)            (0x15200  + ((_i) * 4))
 #define WX_PSR_UC_TBL(_i)            (0x15400 + ((_i) * 4))
+#define WX_PSR_VM_CTL_POOL_MASK      GENMASK(12, 7)
 
 /* VM L2 contorl */
 #define WX_PSR_VM_L2CTL(_i)          (0x15600 + ((_i) * 4))
@@ -1059,6 +1065,7 @@ struct wx_ring_feature {
 
 enum wx_ring_f_enum {
 	RING_F_NONE = 0,
+	RING_F_VMDQ,
 	RING_F_RSS,
 	RING_F_FDIR,
 	RING_F_ARRAY_SIZE  /* must be last in enum set */
@@ -1114,8 +1121,27 @@ enum wx_state {
 	WX_STATE_NBITS		/* must be last */
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
+	struct list_head mvlist;
+	int vf;
+	bool free;
+	bool is_macvlan;
+	u8 vf_macvlan[ETH_ALEN];
+};
+
 enum wx_pf_flags {
 	WX_FLAG_SWFW_RING,
+	WX_FLAG_VMDQ_ENABLED,
+	WX_FLAG_SRIOV_ENABLED,
 	WX_FLAG_FDIR_CAPABLE,
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
@@ -1220,10 +1246,15 @@ struct wx {
 	u64 hw_csum_rx_good;
 	u64 hw_csum_rx_error;
 	u64 alloc_rx_buff_failed;
+	unsigned int num_vfs;
+	struct vf_data_storage *vfinfo;
+	struct vf_macvlans vf_mvs;
+	struct vf_macvlans *mv_list;
 
 	u32 atr_sample_rate;
 	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
 	void (*configure_fdir)(struct wx *wx);
+	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev);
 	int (*ptp_setup_sdp)(struct wx *wx);
 
-- 
2.48.1


