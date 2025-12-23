Return-Path: <netdev+bounces-245791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC29CD7FF9
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC2E30456F5
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC4E2DA771;
	Tue, 23 Dec 2025 03:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-33.us.a.mail.aliyun.com (out198-33.us.a.mail.aliyun.com [47.90.198.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA31940A1;
	Tue, 23 Dec 2025 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461908; cv=none; b=kVq5vMt6gJ8PU7/fk7PK3Cz4ma2RKaOQTp5zN0RUjwum4A3/7rP2GId9YZf/gumn4vbsqYxBE3ppP27qdBiKu27NrKUwy+nTgc44m0g+en/pS+1jstU9FcvraJogRpwFg5j3/lWiUv76Qb3hEOo69XFALCLpw7nGynAYH2Tpua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461908; c=relaxed/simple;
	bh=JPUYGaMWOLoJDJXrI81xeMVhPblt+V/8/+8x6XW4kMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk+Y1M7c0OUu/MBhCRSGZ/cGPFCIxeIjVsrhlnXgI/kibRHuMjRaVl+xvRnbSYU24jT270wMlycdVwlMS6zYwc1qh4MTlEPwf6Q4TJogrVf8EgpgGfyNZtxFUpNtDFCXSSGcCWXIjiRTEtqQakCQ9Zbm+020eRseI3+QcrMJuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.fqrxWVg_1766461884 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 11:51:26 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 net-next 03/15] net/nebula-matrix: add HW layer definitions and implementation
Date: Tue, 23 Dec 2025 11:50:26 +0800
Message-ID: <20251223035113.31122-4-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

add HW layer related definitions and product ops

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
Change-Id: I18e1b62b94b4348abc3cbbe936fc5e4590c27a93
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    3 +-
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   11 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw.h         |  184 ++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  168 ++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  | 1842 +++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |  187 ++
 .../nbl/nbl_include/nbl_def_hw.h              |   26 +
 .../nbl/nbl_include/nbl_include.h             |   64 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   14 +-
 9 files changed, 2496 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 7717efab0b01..723ac077aef3 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -4,7 +4,8 @@
 
 obj-$(CONFIG_NBL_CORE) := nbl_core.o
 
-nbl_core-objs +=      nbl_main.o
+nbl_core-objs +=      nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_main.o
 
 # Do not modify include path, unless you are adding a new file which needs some headers in its
 # direct upper directory (see the exception part in below).
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index f28fe8058c75..0a76b6f66d5e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -7,12 +7,16 @@
 #ifndef _NBL_CORE_H_
 #define _NBL_CORE_H_
 #include "nbl_product_base.h"
+#include "nbl_def_hw.h"
 #include "nbl_def_common.h"
 
 #define NBL_ADAPTER_TO_PDEV(adapter)		((adapter)->pdev)
 #define NBL_ADAPTER_TO_DEV(adapter)		(&((adapter)->pdev->dev))
 #define NBL_ADAPTER_TO_COMMON(adapter)		(&((adapter)->common))
 #define NBL_ADAPTER_TO_RPDUCT_BASE_OPS(adapter)	((adapter)->product_base_ops)
+
+#define NBL_ADAPTER_TO_HW_MGT(adapter)		((adapter)->core.hw_mgt)
+#define NBL_ADAPTER_TO_HW_OPS_TBL(adapter)	((adapter)->intf.hw_ops_tbl)
 #define NBL_CAP_SET_BIT(loc)			(1 << (loc))
 #define NBL_CAP_TEST_BIT(val, loc)		(((val) >> (loc)) & 0x1)
 
@@ -48,9 +52,16 @@ enum nbl_adapter_state {
 };
 
 struct nbl_interface {
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
 };
 
 struct nbl_core {
+	void *hw_mgt;
+	void *res_mgt;
+	void *disp_mgt;
+	void *serv_mgt;
+	void *dev_mgt;
+	void *chan_mgt;
 };
 
 struct nbl_adapter {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
new file mode 100644
index 000000000000..52a14f1dbf12
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_HW_H_
+#define _NBL_HW_H_
+
+#include "nbl_include.h"
+
+#define NBL_MAX_ETHERNET				(4)
+
+#define NBL_PT_PP0					0
+#define NBL_PT_LEN					3
+#define NBL_TCAM_TABLE_LEN				(64)
+#define NBL_MCC_ID_INVALID				U16_MAX
+#define NBL_KT_BYTE_LEN					40
+#define NBL_KT_BYTE_HALF_LEN				20
+
+#define NBL_EM0_PT_HW_UP_TUNNEL_L2			0
+#define NBL_EM0_PT_HW_UP_L2				1
+#define NBL_EM0_PT_HW_DOWN_L2				2
+#define NBL_EM0_PT_HW_UP_LLDP_LACP			3
+#define NBL_EM0_PT_PMD_ND_UPCALL			4
+#define NBL_EM0_PT_HW_L2_UP_MULTI_MCAST		5
+#define NBL_EM0_PT_HW_L3_UP_MULTI_MCAST		6
+#define NBL_EM0_PT_HW_L2_DOWN_MULTI_MCAST		7
+#define NBL_EM0_PT_HW_L3_DOWN_MULTI_MCAST		8
+#define NBL_EM0_PT_HW_DPRBAC_IPV4			9
+#define NBL_EM0_PT_HW_DPRBAC_IPV6			10
+#define NBL_EM0_PT_HW_UL4S_IPV4			11
+#define NBL_EM0_PT_HW_UL4S_IPV6			12
+
+#define NBL_PP0_PROFILE_ID_MIN				(0)
+#define NBL_PP0_PROFILE_ID_MAX				(15)
+#define NBL_PP1_PROFILE_ID_MIN				(16)
+#define NBL_PP1_PROFILE_ID_MAX				(31)
+#define NBL_PP2_PROFILE_ID_MIN				(32)
+#define NBL_PP2_PROFILE_ID_MAX				(47)
+#define NBL_PP_PROFILE_NUM				(16)
+
+#define NBL_QID_MAP_TABLE_ENTRIES			(4096)
+#define NBL_EPRO_PF_RSS_RET_TBL_DEPTH			(4096)
+#define NBL_EPRO_RSS_RET_TBL_DEPTH			(8192 * 2)
+#define NBL_EPRO_RSS_ENTRY_SIZE_UNIT			(16)
+
+#define NBL_EPRO_PF_RSS_RET_TBL_COUNT			(512)
+#define NBL_EPRO_PF_RSS_ENTRY_SIZE			(5)
+
+#define NBL_EPRO_RSS_ENTRY_MAX_COUNT			(512)
+#define NBL_EPRO_RSS_ENTRY_MAX_SIZE			(4)
+
+#define NBL_EPRO_RSS_SK_SIZE 40
+#define NBL_EPRO_RSS_PER_KEY_SIZE 8
+#define NBL_EPRO_RSS_KEY_NUM (NBL_EPRO_RSS_SK_SIZE / NBL_EPRO_RSS_PER_KEY_SIZE)
+
+enum {
+	NBL_HT0,
+	NBL_HT1,
+	NBL_HT_MAX,
+};
+
+enum {
+	NBL_KT_HALF_MODE,
+	NBL_KT_FULL_MODE,
+};
+
+#pragma pack(1)
+union nbl_action_data {
+	union dport_act {
+		struct {
+			/* port_type = SET_DPORT_TYPE_ETH_LAG, set the eth and lag field. */
+			u16 dport_info:10;
+			u16 dport_type:2;
+		#define FWD_DPORT_TYPE_ETH		(0)
+		#define FWD_DPORT_TYPE_LAG		(1)
+		#define FWD_DPORT_TYPE_VSI		(2)
+			u16 dport_id:4;
+		#define FWD_DPORT_ID_HOST_TLS		(0)
+		#define FWD_DPORT_ID_ECPU_TLS		(1)
+		#define FWD_DPORT_ID_HOST_RDMA		(2)
+		#define FWD_DPORT_ID_ECPU_RDMA		(3)
+		#define FWD_DPORT_ID_EMP		(4)
+		#define FWD_DPORT_ID_BMC		(5)
+		#define FWD_DPORT_ID_LOOP_BACK		(7)
+		#define FWD_DPORT_ID_ETH0		(8)
+		#define FWD_DPORT_ID_ETH1		(9)
+		#define FWD_DPORT_ID_ETH2		(10)
+		#define FWD_DPORT_ID_ETH3		(11)
+		} fwd_dport;
+
+		struct {
+			/* port_type = SET_DPORT_TYPE_ETH_LAG, set the eth and lag field. */
+			u16 eth_id:2;
+			u16 lag_id:2;
+			u16 eth_vld:1;
+			u16 lag_vld:1;
+			u16 rsv:4;
+			u16 port_type:2;
+			u16 next_stg_sel:2;
+			u16 upcall_flag:2;
+		} down;
+
+		struct {
+			/* port_type = SET_DPORT_TYPE_VSI_HOST and SET_DPORT_TYPE_VSI_ECPU,
+			 * set the port_id field as the vsi_id.
+			 * port_type = SET_DPORT_TYPE_SP_PORT, set the port_id as the defined
+			 * PORT_TYPE_SP_*.
+			 */
+			u16 port_id:10;
+		#define PORT_TYPE_SP_DROP		(0x3FF)
+		#define PORT_TYPE_SP_GLB_LB		(0x3FE)
+		#define PORT_TYPE_SP_BMC		(0x3FD)
+		#define PORT_TYPE_SP_EMP		(0x3FC)
+			u16 port_type:2;
+		#define SET_DPORT_TYPE_VSI_HOST		(0)
+		#define SET_DPORT_TYPE_VSI_ECPU		(1)
+		#define SET_DPORT_TYPE_ETH_LAG		(2)
+		#define SET_DPORT_TYPE_SP_PORT		(3)
+			u16 next_stg_sel:2;
+		#define NEXT_STG_SEL_NONE		(0)
+		#define NEXT_STG_SEL_ACL_S0		(1)
+		#define NEXT_STG_SEL_EPRO		(2)
+		#define NEXT_STG_SEL_BYPASS		(3)
+			u16 upcall_flag:2;
+		#define AUX_KEEP_FWD_TYPE		(0)
+		#define AUX_FWD_TYPE_NML_FWD		(1)
+		#define AUX_FWD_TYPE_UPCALL		(2)
+		} up;
+	} dport;
+
+	struct dqueue_act {
+		u16 que_id:11;
+		u16 rsv:5;
+	} dqueue;
+
+	struct mcc_id_act {
+		u16 mcc_id:13;
+		u16 pri:1;
+	#define NBL_MCC_PRI_HIGH		(0)
+	#define NBL_MCC_PRI_LOW			(1)
+		uint32_t rsv:2;
+	} mcc_idx;
+
+	struct set_aux_act {
+		u16 nstg_val:4;
+		u16 nstg_vld:1;
+		u16 ftype_val:3;
+		u16 ftype_vld:1;
+		u16 pkt_cos_val:3;
+		u16 pcos_vld:1;
+		u16 rsv:1;
+	#define NBL_SET_AUX_CLR_FLG			(0)
+	#define NBL_SET_AUX_SET_FLG			(1)
+	#define NBL_SET_AUX_SET_AUX			(2)
+		u16 sub_id:2;
+	} set_aux;
+
+	u16 data;
+};
+
+#pragma pack()
+
+#define SFF8636_TRANSMIT_FIBER_850nm_VCSEL	(0x0)
+#define SFF8636_TRANSMIT_FIBER_1310nm_VCSEL	(0x1)
+#define SFF8636_TRANSMIT_FIBER_1550nm_VCSEL	(0x2)
+#define SFF8636_TRANSMIT_FIBER_1310nm_FP	(0x3)
+#define SFF8636_TRANSMIT_FIBER_1310nm_DFB	(0x4)
+#define SFF8636_TRANSMIT_FIBER_1550nm_DFB	(0x5)
+#define SFF8636_TRANSMIT_FIBER_1310nm_EML	(0x6)
+#define SFF8636_TRANSMIT_FIBER_1550nm_EML	(0x7)
+#define SFF8636_TRANSMIT_FIBER_OTHER		(0x8)
+#define SFF8636_TRANSMIT_FIBER_1490nm_DFB	(0x9)
+#define SFF8636_TRANSMIT_COPPER_UNEQUA		(0xa)
+#define SFF8636_TRANSMIT_COPPER_PASSIVE_EQUALIZED	(0xb)
+#define SFF8636_TRANSMIT_COPPER_NEAR_FAR_END		(0xc)
+#define SFF8636_TRANSMIT_COPPER_FAR_END			(0xd)
+#define SFF8636_TRANSMIT_COPPER_NEAR_END		(0xe)
+#define SFF8636_TRANSMIT_COPPER_LINEAR_ACTIVE		(0xf)
+
+#define NBL_SPORT_ETH_OFFSET				8
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
new file mode 100644
index 000000000000..5c33d4ead957
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_hw_leonis.h"
+
+static struct nbl_hw_ops hw_ops = {
+};
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_hw_setup_hw_mgt(struct nbl_common_info *common,
+			       struct nbl_hw_mgt_leonis **hw_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*hw_mgt_leonis = devm_kzalloc(dev, sizeof(struct nbl_hw_mgt_leonis), GFP_KERNEL);
+	if (!*hw_mgt_leonis)
+		return -ENOMEM;
+
+	NBL_HW_MGT_TO_COMMON(&(*hw_mgt_leonis)->hw_mgt) = common;
+
+	return 0;
+}
+
+static void nbl_hw_remove_hw_mgt(struct nbl_common_info *common,
+				 struct nbl_hw_mgt_leonis **hw_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	devm_kfree(dev, *hw_mgt_leonis);
+	*hw_mgt_leonis = NULL;
+}
+
+static int nbl_hw_setup_ops(struct nbl_common_info *common, struct nbl_hw_ops_tbl **hw_ops_tbl,
+			    struct nbl_hw_mgt_leonis *hw_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*hw_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_hw_ops_tbl), GFP_KERNEL);
+	if (!*hw_ops_tbl)
+		return -ENOMEM;
+
+	NBL_HW_OPS_TBL_TO_OPS(*hw_ops_tbl) = &hw_ops;
+	NBL_HW_OPS_TBL_TO_PRIV(*hw_ops_tbl) = hw_mgt_leonis;
+
+	return 0;
+}
+
+static void nbl_hw_remove_ops(struct nbl_common_info *common, struct nbl_hw_ops_tbl **hw_ops_tbl)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	devm_kfree(dev, *hw_ops_tbl);
+	*hw_ops_tbl = NULL;
+}
+
+int nbl_hw_init_leonis(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_common_info *common;
+	struct pci_dev *pdev;
+	struct nbl_hw_mgt_leonis **hw_mgt_leonis;
+	struct nbl_hw_mgt *hw_mgt;
+	struct nbl_hw_ops_tbl **hw_ops_tbl;
+	int bar_mask;
+	int ret = 0;
+
+	common = NBL_ADAPTER_TO_COMMON(adapter);
+	hw_mgt_leonis = (struct nbl_hw_mgt_leonis **)&NBL_ADAPTER_TO_HW_MGT(adapter);
+	hw_ops_tbl = &NBL_ADAPTER_TO_HW_OPS_TBL(adapter);
+	pdev = NBL_COMMON_TO_PDEV(common);
+
+	ret = nbl_hw_setup_hw_mgt(common, hw_mgt_leonis);
+	if (ret)
+		goto setup_mgt_fail;
+
+	hw_mgt = &(*hw_mgt_leonis)->hw_mgt;
+	bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
+	ret = pci_request_selected_regions(pdev, bar_mask, NBL_DRIVER_NAME);
+	if (ret) {
+		dev_err(&pdev->dev, "Request memory bar and mailbox bar failed, err = %d\n", ret);
+		goto request_bar_region_fail;
+	}
+
+	if (param->caps.has_ctrl) {
+		hw_mgt->hw_addr = ioremap(pci_resource_start(pdev, NBL_MEMORY_BAR),
+					  pci_resource_len(pdev, NBL_MEMORY_BAR) -
+					  NBL_RDMA_NOTIFY_OFF);
+		if (!hw_mgt->hw_addr) {
+			dev_err(&pdev->dev, "Memory bar ioremap failed\n");
+			ret = -EIO;
+			goto ioremap_err;
+		}
+		hw_mgt->hw_size = pci_resource_len(pdev, NBL_MEMORY_BAR) - NBL_RDMA_NOTIFY_OFF;
+	} else {
+		hw_mgt->hw_addr = ioremap(pci_resource_start(pdev, NBL_MEMORY_BAR),
+					  NBL_RDMA_NOTIFY_OFF);
+		if (!hw_mgt->hw_addr) {
+			dev_err(&pdev->dev, "Memory bar ioremap failed\n");
+			ret = -EIO;
+			goto ioremap_err;
+		}
+		hw_mgt->hw_size = NBL_RDMA_NOTIFY_OFF;
+	}
+
+	hw_mgt->notify_offset = 0;
+	hw_mgt->mailbox_bar_hw_addr = pci_ioremap_bar(pdev, NBL_MAILBOX_BAR);
+	if (!hw_mgt->mailbox_bar_hw_addr) {
+		dev_err(&pdev->dev, "Mailbox bar ioremap failed\n");
+		ret = -EIO;
+		goto mailbox_ioremap_err;
+	}
+
+	spin_lock_init(&hw_mgt->reg_lock);
+	hw_mgt->should_lock = true;
+
+	ret = nbl_hw_setup_ops(common, hw_ops_tbl, *hw_mgt_leonis);
+	if (ret)
+		goto setup_ops_fail;
+
+	(*hw_mgt_leonis)->ro_enable = pcie_relaxed_ordering_enabled(pdev);
+
+	return 0;
+
+setup_ops_fail:
+	iounmap(hw_mgt->mailbox_bar_hw_addr);
+mailbox_ioremap_err:
+	iounmap(hw_mgt->hw_addr);
+ioremap_err:
+	pci_release_selected_regions(pdev, bar_mask);
+request_bar_region_fail:
+	nbl_hw_remove_hw_mgt(common, hw_mgt_leonis);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_hw_remove_leonis(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_common_info *common;
+	struct nbl_hw_mgt_leonis **hw_mgt_leonis;
+	struct nbl_hw_ops_tbl **hw_ops_tbl;
+	struct pci_dev *pdev;
+	u8 __iomem *hw_addr;
+	u8 __iomem *mailbox_bar_hw_addr;
+	int bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
+
+	common = NBL_ADAPTER_TO_COMMON(adapter);
+	hw_mgt_leonis = (struct nbl_hw_mgt_leonis **)&NBL_ADAPTER_TO_HW_MGT(adapter);
+	hw_ops_tbl = &NBL_ADAPTER_TO_HW_OPS_TBL(adapter);
+	pdev = NBL_COMMON_TO_PDEV(common);
+
+	hw_addr = (*hw_mgt_leonis)->hw_mgt.hw_addr;
+	mailbox_bar_hw_addr = (*hw_mgt_leonis)->hw_mgt.mailbox_bar_hw_addr;
+
+	iounmap(mailbox_bar_hw_addr);
+	iounmap(hw_addr);
+	pci_release_selected_regions(pdev, bar_mask);
+	nbl_hw_remove_hw_mgt(common, hw_mgt_leonis);
+
+	nbl_hw_remove_ops(common, hw_ops_tbl);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
new file mode 100644
index 000000000000..905b197e6633
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -0,0 +1,1842 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_HW_LEONIS_H_
+#define _NBL_HW_EONIS_H_
+
+#include "nbl_core.h"
+#include "nbl_hw.h"
+#include "nbl_hw_reg.h"
+
+#define NBL_NOTIFY_DELAY_MAX_TIME_FOR_REGS	300 /* 300us for palladium,5us for s2c */
+
+#define NBL_DRAIN_WAIT_TIMES			(30000)
+
+/*  ----------  FEM  ----------  */
+#define NBL_FEM_INT_STATUS			(NBL_PPE_FEM_BASE + 0x00000000)
+#define NBL_FEM_INT_MASK			(NBL_PPE_FEM_BASE + 0x00000004)
+#define NBL_FEM_INIT_START			(NBL_PPE_FEM_BASE + 0x00000180)
+#define NBL_FEM_KT_ACC_DATA			(NBL_PPE_FEM_BASE + 0x00000348)
+#define NBL_FEM_INSERT_SEARCH0_CTRL		(NBL_PPE_FEM_BASE + 0x00000500)
+#define NBL_FEM_INSERT_SEARCH0_ACK		(NBL_PPE_FEM_BASE + 0x00000504)
+#define NBL_FEM_INSERT_SEARCH0_DATA		(NBL_PPE_FEM_BASE + 0x00000508)
+#define KT_MASK_LEN32_ACTION_INFO		(0x0)
+#define KT_MASK_LEN12_ACTION_INFO		(0xFFFFF000)
+#define NBL_FEM_SEARCH_KEY_LEN			44
+#define NBL_HW_DUMMY_REG			(0x1300904)
+
+#define HT_PORT0_BANK_SEL             (0b01100000)
+#define HT_PORT1_BANK_SEL             (0b00011000)
+#define HT_PORT2_BANK_SEL             (0b00000111)
+#define KT_PORT0_BANK_SEL             (0b11100000)
+#define KT_PORT1_BANK_SEL             (0b00011000)
+#define KT_PORT2_BANK_SEL             (0b00000111)
+#define AT_PORT0_BANK_SEL             (0b000000000000)
+#define AT_PORT1_BANK_SEL             (0b111110000000)
+#define AT_PORT2_BANK_SEL             (0b000001111111)
+#define HT_PORT0_BTM                  2
+#define HT_PORT1_BTM                  6
+#define HT_PORT2_BTM                  16
+#define NBL_1BIT                        1
+#define NBL_8BIT                        8
+#define NBL_16BIT                       16
+
+#define NBL_FEM_HT_BANK_SEL_BITMAP		(NBL_PPE_FEM_BASE + 0x00000200)
+#define NBL_FEM_KT_BANK_SEL_BITMAP		(NBL_PPE_FEM_BASE + 0x00000204)
+#define NBL_FEM_AT_BANK_SEL_BITMAP		(NBL_PPE_FEM_BASE + 0x00000208)
+#define NBL_FEM_AT_BANK_SEL_BITMAP2		(NBL_PPE_FEM_BASE + 0x0000020C)
+
+#define NBL_EM_PT_MASK_LEN_0     (0xFFFFFFFF)
+#define NBL_EM_PT_MASK_LEN_64    (0x0000FFFF)
+#define NBL_EM_PT_MASK_LEN_96    (0x000000FF)
+#define NBL_EM_PT_MASK1_LEN_0    (0xFFFFFFFF)
+#define NBL_EM_PT_MASK1_LEN_4    (0x7FFFFFFF)
+#define NBL_EM_PT_MASK1_LEN_12   (0x1FFFFFFF)
+#define NBL_EM_PT_MASK1_LEN_20   (0x07FFFFFF)
+#define NBL_EM_PT_MASK1_LEN_28   (0x01FFFFFF)
+#define NBL_EM_PT_MASK1_LEN_32   (0x00FFFFFF)
+#define NBL_EM_PT_MASK1_LEN_76   (0x00001FFF)
+#define NBL_EM_PT_MASK1_LEN_112  (0x0000000F)
+#define NBL_EM_PT_MASK1_LEN_116  (0x00000007)
+#define NBL_EM_PT_MASK1_LEN_124  (0x00000001)
+#define NBL_EM_PT_MASK1_LEN_128  (0x0)
+#define NBL_EM_PT_MASK2_LEN_28   (0x000007FF)
+#define NBL_EM_PT_MASK2_LEN_36   (0x000001FF)
+#define NBL_EM_PT_MASK2_LEN_44   (0x0000007F)
+#define NBL_EM_PT_MASK2_LEN_52   (0x0000001F)
+#define NBL_EM_PT_MASK2_LEN_60   (0x00000007)
+#define NBL_EM_PT_MASK2_LEN_68   (0x00000001)
+#define NBL_EM_PT_MASK2_LEN_72   (0x00000010)
+#define NBL_EM_PT_MASK2_SEC_72   (0x00000000)
+
+#define NBL_KT_HW_L2_DW_LEN				40
+
+#define NBL_ACL_VSI_PF_UPCALL			9
+#define NBL_ACL_ETH_PF_UPCALL			8
+#define NBL_ACL_INDIRECT_ACCESS_WRITE		(0)
+#define NBL_ACL_INDIRECT_ACCESS_READ		(1)
+#define NBL_ETH_BASE_IDX 8
+#define NBL_VSI_BASE_IDX 0
+#define NBL_PF_MAX_NUM 4
+#define NBL_ACL_TCAM_UPCALL_IDX 15
+
+#define NBL_GET_PF_ETH_ID(idx) ((idx) + NBL_ETH_BASE_IDX)
+#define NBL_GET_PF_VSI_ID(idx) ((idx) * 256)
+#define NBL_ACL_GET_ACTION_DATA(act_buf, act_data) (act_data = (act_buf) & 0x3fffff)
+#define NBL_ACL_FLUSH_FLOW_BTM 0x7fff
+#define NBL_ACL_FLUSH_UPCALL_BTM 0x8000
+
+#define NBL_ACL_TCAM_DATA_X(t)		(NBL_PPE_ACL_BASE + 0x00000904 + ((t) * 8))
+#define NBL_ACL_TCAM_DATA_Y(t)		(NBL_PPE_ACL_BASE + 0x00000990 + ((t) * 8))
+
+struct nbl_acl_tcam_common_data_u {
+	u8 data[5];
+	u8 rsv[3];
+};
+
+/*  ----------  MCC  ----------  */
+#define NBL_MCC_MODULE	(0x00B44000)
+#define NBL_MCC_LEAF_NODE_TABLE(i) \
+	(NBL_MCC_MODULE + 0x00010000 + (i) * sizeof(struct nbl_mcc_tbl))
+#pragma pack(1)
+
+struct nbl_fem_int_mask {
+	u32 rsv0:2;
+	u32 fifo_ovf_err:1;
+	u32 fifo_udf_err:1;
+	u32 cif_err:1;
+	u32 rsv1:1;
+	u32 cfg_err:1;
+	u32 data_ucor_err:1;
+	u32 bank_cflt_err:1;
+	u32 rsv2:23;
+};
+
+union nbl_fem_ht_acc_ctrl_u {
+	struct nbl_fem_ht_acc_ctrl {
+		u32 bucket_id:2; /* used for choose entry's hash-bucket */
+		u32 entry_id:14; /* used for choose hash-bucket's entry */
+		u32 ht_id:1; /* 0:HT0, 1:HT1 */
+#define NBL_ACC_HT0				(0)
+#define NBL_ACC_HT1				(1)
+		u32 port:2; /* 0:pp0 1:pp1 2:pp2 */
+		u32 rsv:10;
+		u32 access_size:1; /* 0:32bit 1:128bit,read support 128 */
+#define NBL_ACC_SIZE_32B			(0)
+#define NBL_ACC_SIZE_128B			(1)
+		u32 rw:1; /* 1:read 0:write */
+#define NBL_ACC_MODE_READ			(1)
+#define NBL_ACC_MODE_WRITE			(0)
+		u32 start:1; /* enable indirect access */
+	} info;
+#define NBL_FEM_HT_ACC_CTRL_TBL_WIDTH (sizeof(struct nbl_fem_ht_acc_ctrl))
+	u8 data[NBL_FEM_HT_ACC_CTRL_TBL_WIDTH];
+};
+
+#define NBL_FEM_HT_ACC_CTRL			(NBL_PPE_FEM_BASE + 0x00000300)
+
+union nbl_fem_ht_acc_data_u {
+	struct nbl_fem_ht_acc_data {
+		u32 kt_index:17;
+		u32 hash:14;
+		u32 vld:1;
+	} info;
+#define NBL_FEM_HT_ACC_DATA_TBL_WIDTH (sizeof(struct nbl_fem_ht_acc_data))
+	u8 data[NBL_FEM_HT_ACC_DATA_TBL_WIDTH];
+};
+
+#define NBL_FEM_HT_ACC_DATA			(NBL_PPE_FEM_BASE + 0x00000308)
+
+union nbl_fem_ht_acc_ack_u {
+	struct nbl_fem_ht_acc_ack {
+		u32 done:1; /* indirect access is finished */
+		u32 status:1; /* indirect access is error */
+		u32 rsv:30;
+	} info;
+#define NBL_FEM_HT_ACC_ACK_TBL_WIDTH (sizeof(struct nbl_fem_ht_acc_ack))
+	u8 data[NBL_FEM_HT_ACC_ACK_TBL_WIDTH];
+};
+
+#define NBL_FEM_HT_ACC_ACK			(NBL_PPE_FEM_BASE + 0x00000304)
+
+union nbl_fem_kt_acc_ctrl_u {
+	struct nbl_fem_kt_acc_ctrl {
+		u32 addr:17; /* kt-index */
+		u32 rsv:12;
+		u32 access_size:1;
+#define NBL_ACC_SIZE_160B			(0)
+#define NBL_ACC_SIZE_320B			(1)
+		u32 rw:1; /* 1:read 0:write */
+		u32 start:1; /* enable ，indirect access */
+	} info;
+#define NBL_FEM_KT_ACC_CTRL_TBL_WIDTH (sizeof(struct nbl_fem_kt_acc_ctrl))
+	u8 data[NBL_FEM_KT_ACC_CTRL_TBL_WIDTH];
+};
+
+#define NBL_FEM_KT_ACC_CTRL			(NBL_PPE_FEM_BASE + 0x00000340)
+
+union nbl_fem_kt_acc_ack_u {
+	struct nbl_fem_kt_acc_ack {
+		u32 done:1; /* indirect access is finished */
+		u32 status:1; /* indirect access is error */
+		u32 rsv:30;
+	} info;
+#define NBL_FEM_KT_ACC_ACK_TBL_WIDTH (sizeof(struct nbl_fem_kt_acc_ack))
+	u8 data[NBL_FEM_KT_ACC_ACK_TBL_WIDTH];
+};
+
+#define NBL_FEM_KT_ACC_ACK			(NBL_PPE_FEM_BASE + 0x00000344)
+
+union nbl_search_ctrl_u {
+	struct nbl_search_ctrl {
+		u32 rsv:31;
+		u32 start:1;
+	} info;
+#define NBL_SEARCH_CTRL_WIDTH (sizeof(struct nbl_search_ctrl))
+	u8 data[NBL_SEARCH_CTRL_WIDTH];
+};
+
+union nbl_search_ack_u {
+	struct nbl_search_ack {
+		u32 done:1;
+		u32 status:1;
+		u32 rsv:30;
+	} info;
+#define NBL_SEARCH_ACK_WIDTH (sizeof(struct nbl_search_ack))
+	u8 data[NBL_SEARCH_ACK_WIDTH];
+};
+
+#define NBL_FEM_EM0_TCAM_TABLE_ADDR (0xa0b000)
+#define NBL_FEM_EM_TCAM_TABLE_DEPTH (64)
+#define NBL_FEM_EM_TCAM_TABLE_WIDTH (256)
+
+union fem_em_tcam_table_u {
+	struct fem_em_tcam_table {
+		u32 key[5];              /* [159:0] Default:0x0 RW */
+		u32 key_vld:1;           /* [160] Default:0x0 RW */
+		u32 key_size:1;          /* [161] Default:0x0 RW */
+		u32 rsv:30;              /* [191:162] Default:0x0 RO */
+		u32 rsv1[2];              /* [255:192] Default:0x0 RO */
+	} info;
+	u32 data[NBL_FEM_EM_TCAM_TABLE_WIDTH / 32];
+	u8 hash_key[sizeof(struct fem_em_tcam_table)];
+};
+
+#define NBL_FEM_EM_TCAM_TABLE_REG(r, t) (NBL_FEM_EM0_TCAM_TABLE_ADDR + 0x1000 * (r) + \
+		(NBL_FEM_EM_TCAM_TABLE_WIDTH / 8) * (t))
+
+#define NBL_FEM_EM0_AD_TABLE_ADDR (0xa08000)
+#define NBL_FEM_EM_AD_TABLE_DEPTH (64)
+#define NBL_FEM_EM_AD_TABLE_WIDTH (512)
+
+union fem_em_ad_table_u {
+	struct fem_em_ad_table {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 action4:22;          /* [109:88] Default:0x0 RW */
+		u32 action5:22;          /* [131:110] Default:0x0 RW */
+		u32 action6:22;          /* [153:132] Default:0x0 RW */
+		u32 action7:22;          /* [175:154] Default:0x0 RW */
+		u32 action8:22;          /* [197:176] Default:0x0 RW */
+		u32 action9:22;          /* [219:198] Default:0x0 RW */
+		u32 action10:22;         /* [241:220] Default:0x0 RW */
+		u32 action11:22;         /* [263:242] Default:0x0 RW */
+		u32 action12:22;         /* [285:264] Default:0x0 RW */
+		u32 action13:22;         /* [307:286] Default:0x0 RW */
+		u32 action14:22;         /* [329:308] Default:0x0 RW */
+		u32 action15:22;         /* [351:330] Default:0x0 RW */
+		u32 rsv[5];          /* [511:352] Default:0x0 RO */
+	} info;
+	u32 data[NBL_FEM_EM_AD_TABLE_WIDTH / 32];
+	u8 hash_key[sizeof(struct fem_em_ad_table)];
+};
+
+#define NBL_FEM_EM_AD_TABLE_REG(r, t) (NBL_FEM_EM0_AD_TABLE_ADDR + 0x1000 * (r) + \
+		(NBL_FEM_EM_AD_TABLE_WIDTH / 8) * (t))
+
+#define NBL_FLOW_TCAM_TOTAL_LEN			32
+#define NBL_FLOW_AD_TOTAL_LEN			64
+
+struct nbl_mcc_tbl {
+	u32 dport_act:16;
+	u32 dqueue_act:11;
+	u32 dqueue_en:1;
+	u32 dqueue_rsv:4;
+	u32 stateid_act:11;
+	u32 stateid_filter:1;
+	u32 flowid_filter:1;
+	u32 stateid_rsv:3;
+	u32 next_pntr:13;
+	u32 tail:1;
+	u32 vld:1;
+	u32 rsv:1;
+};
+
+union nbl_fem_ht_size_table_u {
+	struct nbl_fem_ht_size_table {
+		u32 pp0_size:5;
+		u32 rsv0:3;
+		u32 pp1_size:5;
+		u32 rsv1:3;
+		u32 pp2_size:5;
+		u32 rsv2:11;
+	} info;
+#define NBL_FEM_HT_SIZE_TBL_WIDTH (sizeof(struct nbl_fem_ht_size_table))
+	u8 data[NBL_FEM_HT_SIZE_TBL_WIDTH];
+};
+
+#define NBL_FEM_HT_SIZE_REG		(NBL_PPE_FEM_BASE + 0x0000011c)
+
+#define NBL_FEM0_PROFILE_TABLE(t) (NBL_PPE_FEM_BASE + 0x00001000 +		\
+				   (NBL_FEM_PROFILE_TBL_WIDTH) * (t))
+
+/*  ----------  REG BASE ADDR  ----------  */
+#define NBL_LB_PCIEX16_TOP_BASE			(0x01500000)
+/* PPE modules base addr */
+#define NBL_PPE_FEM_BASE			(0x00a04000)
+#define NBL_PPE_IPRO_BASE			(0x00b04000)
+#define NBL_PPE_PP0_BASE			(0x00b14000)
+#define NBL_PPE_PP1_BASE			(0x00b24000)
+#define NBL_PPE_PP2_BASE			(0x00b34000)
+#define NBL_PPE_MCC_BASE			(0x00b44000)
+#define NBL_PPE_ACL_BASE			(0x00b64000)
+#define NBL_PPE_CAP_BASE			(0x00e64000)
+#define NBL_PPE_EPRO_BASE			(0x00e74000)
+#define NBL_PPE_DPRBAC_BASE			(0x00904000)
+#define NBL_PPE_UPRBAC_BASE			(0x0000C000)
+/* Interface modules base addr */
+#define NBL_INTF_HOST_PCOMPLETER_BASE		(0x00f08000)
+#define NBL_INTF_HOST_PADPT_BASE		(0x00f4c000)
+#define NBL_INTF_HOST_CTRLQ_BASE		(0x00f8c000)
+#define NBL_INTF_HOST_VDPA_NET_BASE		(0x00f98000)
+#define NBL_INTF_HOST_CMDQ_BASE			(0x00fa0000)
+#define NBL_INTF_HOST_MAILBOX_BASE		(0x00fb0000)
+#define NBL_INTF_HOST_PCIE_BASE			(0X01504000)
+#define NBL_INTF_HOST_PCAP_BASE			(0X015a4000)
+/* DP modules base addr */
+#define NBL_DP_URMUX_BASE			(0x00008000)
+#define NBL_DP_UPRBAC_BASE			(0x0000C000)
+#define NBL_DP_UPA_BASE				(0x0008C000)
+#define NBL_DP_USTORE_BASE			(0x00104000)
+#define NBL_DP_UPMEM_BASE			(0x00108000)
+#define NBL_DP_UBM_BASE				(0x0010c000)
+#define NBL_DP_UQM_BASE				(0x00114000)
+#define NBL_DP_USTAT_BASE			(0x0011c000)
+#define NBL_DP_UPED_BASE			(0x0015c000)
+#define NBL_DP_UCAR_BASE			(0x00e84000)
+#define NBL_DP_UL4S_BASE			(0x00204000)
+#define NBL_DP_UVN_BASE				(0x00244000)
+#define NBL_DP_DSCH_BASE			(0x00404000)
+#define NBL_DP_SHAPING_BASE			(0x00504000)
+#define NBL_DP_DVN_BASE				(0x00514000)
+#define NBL_DP_DL4S_BASE			(0x00614000)
+#define NBL_DP_DRMUX_BASE			(0x00654000)
+#define NBL_DP_DSTORE_BASE			(0x00704000)
+#define NBL_DP_DPMEM_BASE			(0x00708000)
+#define NBL_DP_DBM_BASE				(0x0070c000)
+#define NBL_DP_DQM_BASE				(0x00714000)
+#define NBL_DP_DSTAT_BASE			(0x0071c000)
+#define NBL_DP_DPED_BASE			(0x0075c000)
+#define NBL_DP_DPA_BASE				(0x0085c000)
+#define NBL_DP_DPRBAC_BASE			(0x00904000)
+#define NBL_DP_DDMUX_BASE			(0x00984000)
+#define NBL_DP_LB_DDP_BUF_BASE			(0x00000000)
+#define NBL_DP_LB_DDP_OUT_BASE			(0x00000000)
+#define NBL_DP_LB_DDP_DIST_BASE			(0x00000000)
+#define NBL_DP_LB_DDP_IN_BASE			(0x00000000)
+#define NBL_DP_LB_UDP_BUF_BASE			(0x00000000)
+#define NBL_DP_LB_UDP_OUT_BASE			(0x00000000)
+#define NBL_DP_LB_UDP_DIST_BASE			(0x00000000)
+#define NBL_DP_LB_UDP_IN_BASE			(0x00000000)
+#define NBL_DP_DL4S_BASE			(0x00614000)
+#define NBL_DP_UL4S_BASE			(0x00204000)
+
+/*  --------  LB  --------  */
+#define NBL_LB_PF_CONFIGSPACE_SELECT_OFFSET	(0x81100000)
+#define NBL_LB_PF_CONFIGSPACE_SELECT_STRIDE	(0x00100000)
+#define NBL_LB_PF_CONFIGSPACE_BASE_ADDR		(NBL_LB_PCIEX16_TOP_BASE + 0x00024000)
+#define NBL_LB_PCIEX16_TOP_AHB			(NBL_LB_PCIEX16_TOP_BASE + 0x00000020)
+
+#define NBL_SRIOV_CAPS_OFFSET			(0x140)
+
+/*  --------  MAILBOX BAR2 -----  */
+#define NBL_MAILBOX_NOTIFY_ADDR			(0x00000000)
+#define NBL_MAILBOX_BAR_REG			(0x00000000)
+#define NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR	(0x10)
+#define NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR	(0x20)
+#define NBL_MAILBOX_QINFO_CFG_DBG_TABLE_ADDR	(0x30)
+
+/*  --------  ADMINQ BAR2 -----  */
+#define NBL_ADMINQ_NOTIFY_ADDR			(0x40)
+#define NBL_ADMINQ_QINFO_CFG_RX_TABLE_ADDR	(0x50)
+#define NBL_ADMINQ_QINFO_CFG_TX_TABLE_ADDR	(0x60)
+#define NBL_ADMINQ_QINFO_CFG_DBG_TABLE_ADDR	(0x78)
+#define NBL_ADMINQ_MSIX_MAP_TABLE_ADDR		(0x80)
+
+/*  --------  MAILBOX  --------  */
+
+/* mailbox BAR qinfo_cfg_dbg_table */
+struct nbl_mailbox_qinfo_cfg_dbg_tbl {
+	u16 rx_drop;
+	u16 rx_get;
+	u16 tx_drop;
+	u16 tx_out;
+	u16 rx_hd_ptr;
+	u16 tx_hd_ptr;
+	u16 rx_tail_ptr;
+	u16 tx_tail_ptr;
+};
+
+/* mailbox BAR qinfo_cfg_table */
+struct nbl_mailbox_qinfo_cfg_table {
+	u32 queue_base_addr_l;
+	u32 queue_base_addr_h;
+	u32 queue_size_bwind:4;
+	u32 rsv1:28;
+	u32 queue_rst:1;
+	u32 queue_en:1;
+	u32 dif_err:1;
+	u32 ptr_err:1;
+	u32 rsv2:28;
+};
+
+/*  --------  ADMINQ  --------  */
+
+struct nbl_adminq_qinfo_map_table {
+	u32 function:3;
+	u32 devid:5;
+	u32 bus:8;
+	u32 msix_idx:13;
+	u32 msix_idx_valid:1;
+	u32 rsv:2;
+};
+
+/* adminq BAR qinfo_cfg_dbg_table */
+struct nbl_adminq_qinfo_cfg_dbg_tbl {
+	u16 rx_hd_ptr;
+	u16 tx_hd_ptr;
+	u16 rx_tail_ptr;
+	u16 tx_tail_ptr;
+};
+
+/*  --------  MAILBOX BAR0 -----  */
+/* mailbox qinfo_map_table */
+#define NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id) \
+	(NBL_INTF_HOST_MAILBOX_BASE + 0x00001000 + \
+	(func_id) * sizeof(struct nbl_mailbox_qinfo_map_table))
+
+/* MAILBOX qinfo_map_table */
+struct nbl_mailbox_qinfo_map_table {
+	u32 function:3;
+	u32 devid:5;
+	u32 bus:8;
+	u32 msix_idx:13;
+	u32 msix_idx_valid:1;
+	u32 rsv:2;
+};
+
+/*  --------  HOST_PCIE  --------  */
+#define NBL_PCIE_HOST_K_PF_MASK_REG		(NBL_INTF_HOST_PCIE_BASE + 0x00001004)
+#define NBL_PCIE_HOST_K_PF_FID(pf_id) \
+	(NBL_INTF_HOST_PCIE_BASE + 0x0000106C + 4 * (pf_id))
+#define NBL_PCIE_HOST_TL_CFG_BUSDEV		(NBL_INTF_HOST_PCIE_BASE + 0x11040)
+
+/*  --------  HOST_PADPT  --------  */
+#define NBL_HOST_PADPT_HOST_CFG_FC_PD_DN	(NBL_INTF_HOST_PADPT_BASE + 0x00000160)
+#define NBL_HOST_PADPT_HOST_CFG_FC_PH_DN	(NBL_INTF_HOST_PADPT_BASE + 0x00000164)
+#define NBL_HOST_PADPT_HOST_CFG_FC_NPH_DN	(NBL_INTF_HOST_PADPT_BASE + 0x0000016C)
+#define NBL_HOST_PADPT_HOST_CFG_FC_CPLH_UP	(NBL_INTF_HOST_PADPT_BASE + 0x00000170)
+/* host_padpt host_msix_info */
+#define NBL_PADPT_ABNORMAL_MSIX_VEC		(NBL_INTF_HOST_PADPT_BASE + 0x00000200)
+#define NBL_PADPT_ABNORMAL_TIMEOUT		(NBL_INTF_HOST_PADPT_BASE + 0x00000204)
+#define NBL_PADPT_HOST_MSIX_INFO_REG_ARR(vector_id) \
+	(NBL_INTF_HOST_PADPT_BASE + 0x00010000 + (vector_id) * sizeof(struct nbl_host_msix_info))
+/* host_padpt host_vnet_qinfo */
+#define NBL_PADPT_HOST_VNET_QINFO_REG_ARR(queue_id) \
+	(NBL_INTF_HOST_PADPT_BASE + 0x00008000 + (queue_id) * sizeof(struct nbl_host_vnet_qinfo))
+
+struct nbl_host_msix_info {
+	u32 intrl_pnum:16;
+	u32 intrl_rate:16;
+	u32 function:3;
+	u32 devid:5;
+	u32 bus:8;
+	u32 valid:1;
+	u32 msix_mask_en:1;
+	u32 rsv:14;
+};
+
+struct nbl_abnormal_msix_vector {
+	u32 idx:16;
+	u32 vld:1;
+	u32 rsv:15;
+};
+
+/* host_padpt host_vnet_qinfo */
+struct nbl_host_vnet_qinfo {
+	u32 function_id:3;
+	u32 device_id:5;
+	u32 bus_id:8;
+	u32 msix_idx:13;
+	u32 msix_idx_valid:1;
+	u32 log_en:1;
+	u32 valid:1;
+	u32 tph_en:1;
+	u32 ido_en:1;
+	u32 rlo_en:1;
+	u32 rsv0:29;
+};
+
+struct nbl_msix_notify {
+	u32 glb_msix_idx:13;
+	u32 rsv1:3;
+	u32 mask:1;
+	u32 rsv2:15;
+};
+
+/*  --------  HOST_PCOMPLETER  --------  */
+/* pcompleter_host pcompleter_host_virtio_qid_map_table */
+#define NBL_PCOMPLETER_QID_MAP_REG_ARR(select, i) \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x00010000 + \
+	 (select) * NBL_QID_MAP_TABLE_ENTRIES * sizeof(struct nbl_virtio_qid_map_table) + \
+	 (i) * sizeof(struct nbl_virtio_qid_map_table))
+#define NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(i) \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x00004000 + (i) * sizeof(struct nbl_function_msix_map))
+#define NBL_PCOMPLETER_HOST_MSIX_FID_TABLE(i) \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x0003a000 + \
+	(i) * sizeof(struct nbl_pcompleter_host_msix_fid_table))
+#define NBL_PCOMPLETER_INT_STATUS (NBL_INTF_HOST_PCOMPLETER_BASE + 0x00000000)
+#define NBL_PCOMPLETER_TLP_OUT_DROP_CNT (NBL_INTF_HOST_PCOMPLETER_BASE + 0x00002430)
+
+/* pcompleter_host pcompleter_host_virtio_table_ready */
+#define NBL_PCOMPLETER_QUEUE_TABLE_READY_REG \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x0000110C)
+/* pcompleter_host pcompleter_host_virtio_table_select */
+#define NBL_PCOMPLETER_QUEUE_TABLE_SELECT_REG \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x00001110)
+
+#define NBL_PCOMPLETER_MSIX_NOTIRY_OFFSET (0x1020)
+
+#define NBL_REG_WRITE_MAX_TRY_TIMES 2
+
+/* pcompleter_host virtio_qid_map_table */
+struct nbl_virtio_qid_map_table {
+	u32 local_qid:9;
+	u32 notify_addr_l:23;
+	u32 notify_addr_h;
+	u32 global_qid:12;
+	u32 ctrlq_flag:1;
+	u32 rsv1:19;
+	u32 rsv2;
+};
+
+struct nbl_pcompleter_host_msix_fid_table {
+	u32 fid:10;
+	u32 vld:1;
+	u32 rsv:21;
+};
+
+struct nbl_function_msix_map {
+	u64 msix_map_base_addr;
+	u32 function:3;
+	u32 devid:5;
+	u32 bus:8;
+	u32 valid:1;
+	u32 rsv0:15;
+	u32 rsv1;
+};
+
+struct nbl_queue_table_select {
+	u32 select:1;
+	u32 rsv:31;
+};
+
+struct nbl_queue_table_ready {
+	u32 ready:1;
+	u32 rsv:31;
+};
+
+/* IPRO ipro_queue_tbl */
+struct nbl_ipro_queue_tbl {
+	u32 vsi_id:10;
+	u32 vsi_en:1;
+	u32 rsv:21;
+};
+
+/*  --------  HOST_PCAP  --------  */
+#define NBL_HOST_PCAP_TX_CAP_EN			(NBL_INTF_HOST_PCAP_BASE + 0x00000200)
+#define NBL_HOST_PCAP_TX_CAP_STORE		(NBL_INTF_HOST_PCAP_BASE + 0x00000204)
+#define NBL_HOST_PCAP_TX_CAP_STALL		(NBL_INTF_HOST_PCAP_BASE + 0x00000208)
+#define NBL_HOST_PCAP_RX_CAP_EN			(NBL_INTF_HOST_PCAP_BASE + 0x00000800)
+#define NBL_HOST_PCAP_RX_CAP_STORE		(NBL_INTF_HOST_PCAP_BASE + 0x00000804)
+#define NBL_HOST_PCAP_RX_CAP_STALL		(NBL_INTF_HOST_PCAP_BASE + 0x00000808)
+
+/*  ----------  DPED  ----------  */
+#define NBL_DPED_VLAN_OFFSET		(NBL_DP_DPED_BASE + 0x000003F4)
+#define NBL_DPED_DSCP_OFFSET_0		(NBL_DP_DPED_BASE + 0x000003F8)
+#define NBL_DPED_DSCP_OFFSET_1		(NBL_DP_DPED_BASE + 0x000003FC)
+
+/* DPED dped_hw_edt_prof */
+#define NBL_DPED_HW_EDT_PROF_TABLE(i) \
+	(NBL_DP_DPED_BASE + 0x00001000 + (i) * sizeof(struct ped_hw_edit_profile))
+/* DPED dped_l4_ck_cmd_40 */
+
+/* DPED hw_edt_prof/ UPED hw_edt_prof */
+struct ped_hw_edit_profile {
+	u32 l4_len:2;
+#define NBL_PED_L4_LEN_MDY_CMD_0		(0)
+#define NBL_PED_L4_LEN_MDY_CMD_1		(1)
+#define NBL_PED_L4_LEN_MDY_DISABLE		(2)
+	u32 l3_len:2;
+#define NBL_PED_L3_LEN_MDY_CMD_0		(0)
+#define NBL_PED_L3_LEN_MDY_CMD_1		(1)
+#define NBL_PED_L3_LEN_MDY_DISABLE		(2)
+	u32 l4_ck:3;
+#define NBL_PED_L4_CKSUM_CMD_0			(0)
+#define NBL_PED_L4_CKSUM_CMD_1			(1)
+#define NBL_PED_L4_CKSUM_CMD_2			(2)
+#define NBL_PED_L4_CKSUM_CMD_3			(3)
+#define NBL_PED_L4_CKSUM_CMD_4			(4)
+#define NBL_PED_L4_CKSUM_CMD_5			(5)
+#define NBL_PED_L4_CKSUM_CMD_6			(6)
+#define NBL_PED_L4_CKSUM_DISABLE		(7)
+	u32 l3_ck:1;
+#define NBL_PED_L3_CKSUM_ENABLE			(1)
+#define NBL_PED_L3_CKSUM_DISABLE		(0)
+	u32 l4_ck_zero_free:1;
+#define NBL_PED_L4_CKSUM_ZERO_FREE_ENABLE	(1)
+#define NBL_PED_L4_CKSUM_ZERO_FREE_DISABLE	(0)
+	u32 rsv:23;
+};
+
+struct nbl_ped_hw_edit_profile_cfg {
+	u32 table_id;
+	struct ped_hw_edit_profile edit_prf;
+};
+
+/*  ----------  UPED  ----------  */
+/* UPED uped_hw_edt_prof */
+#define NBL_UPED_HW_EDT_PROF_TABLE(i) \
+	(NBL_DP_UPED_BASE + 0x00001000 + (i) * sizeof(struct ped_hw_edit_profile))
+
+/*  ---------  SHAPING  ---------  */
+#define NBL_SHAPING_NET_TIMMING_ADD_ADDR	(NBL_DP_SHAPING_BASE + 0x00000300)
+#define NBL_SHAPING_NET(i) \
+	(NBL_DP_SHAPING_BASE + 0x00001800 + (i) * sizeof(struct nbl_shaping_net))
+
+/* cir 1, bandwidth 1kB/s in protol environment */
+/* cir 1, bandwidth 1Mb/s */
+#define NBL_LR_LEONIS_SYS_CLK			15000.0   /* 0105tag  Khz */
+#define NBL_LR_LEONIS_NET_SHAPING_CYCLE_MAX	25
+#define NBL_LR_LEONIS_NET_SHAPING_DPETH		600
+#define NBL_LR_LEONIS_NET_BUCKET_DEPTH		9600
+
+#define NBL_SHAPING_DPORT_25G_RATE		0x61A8
+#define NBL_SHAPING_DPORT_HALF_25G_RATE		0x30D4
+
+#define NBL_SHAPING_DPORT_100G_RATE		0x1A400
+#define NBL_SHAPING_DPORT_HALF_100G_RATE	0xD200
+
+#define NBL_UCAR_MAX_BUCKET_DEPTH		524287
+
+#define NBL_DSTORE_DROP_XOFF_TH			0xC8
+#define NBL_DSTORE_DROP_XON_TH			0x64
+
+#define NBL_DSTORE_DROP_XOFF_TH_100G		0x1F4
+#define NBL_DSTORE_DROP_XON_TH_100G		0x12C
+
+#define NBL_DSTORE_DROP_XOFF_TH_BOND_MAIN	0x180
+#define NBL_DSTORE_DROP_XON_TH_BOND_MAIN	0x180
+
+#define NBL_DSTORE_DROP_XOFF_TH_BOND_OTHER	0x64
+#define NBL_DSTORE_DROP_XON_TH_BOND_OTHER	0x64
+
+#define NBL_DSTORE_DROP_XOFF_TH_100G_BOND_MAIN	0x2D5
+#define NBL_DSTORE_DROP_XON_TH_100G_BOND_MAIN	0x2BC
+
+#define NBL_DSTORE_DROP_XOFF_TH_100G_BOND_OTHER	0x145
+#define NBL_DSTORE_DROP_XON_TH_100G_BOND_OTHER	0x12C
+
+#define NBL_DSTORE_DISC_BP_TH			(NBL_DP_DSTORE_BASE + 0x00000630)
+
+struct dstore_disc_bp_th {
+	u32 xoff_th:10;
+	u32 rsv1:6;
+	u32 xon_th:10;
+	u32 rsv:5;
+	u32 en:1;
+};
+
+struct nbl_shaping_net_timming_add {
+	u32 cycle_max:12;        /* [11:0] Default:0x8 RW */
+	u32 rsv1:4;              /* [15:12] Default:0x0 RO */
+	u32 depth:12;            /* [27:16] Default:0x258 RW */
+	u32 rsv:4;               /* [31:28] Default:0x0 RO */
+};
+
+/* DSCH dsch_vn_sha2net_map_tbl */
+struct dsch_vn_sha2net_map_tbl {
+	u32 vld:1;
+	u32 reserve:31;
+};
+
+/* DSCH dsch_vn_net2sha_map_tbl */
+struct dsch_vn_net2sha_map_tbl {
+	u32 vld:1;
+	u32 reserve:31;
+};
+
+#define NBL_NET_SHAPING_RDMA_BASE_ID (448)
+
+struct dsch_psha_en {
+	u32 en:4;
+	u32 rsv:28;
+};
+
+/* SHAPING shaping_net */
+struct nbl_shaping_net {
+	u32 valid:1;
+	u32 depth:19;
+	u32 cir:19;
+	u32 pir:19;
+	u32 cbs:21;
+	u32 pbs:21;
+	u32 rsv:28;
+};
+
+struct nbl_shaping_dport {
+	u32 valid:1;
+	u32 depth:19;
+	u32 cir:19;
+	u32 pir:19;
+	u32 cbs:21;
+	u32 pbs:21;
+	u32 rsv:28;
+};
+
+struct nbl_shaping_dvn_dport {
+	u32 valid:1;
+	u32 depth:19;
+	u32 cir:19;
+	u32 pir:19;
+	u32 cbs:21;
+	u32 pbs:21;
+	u32 rsv:28;
+};
+
+/*  ----------  DSCH  ----------  */
+/* DSCH vn_host_qid_max */
+#define NBL_DSCH_NOTIFY_BITMAP_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00003000 + (i) * BYTES_PER_DWORD)
+#define NBL_DSCH_FLY_BITMAP_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00004000 + (i) * BYTES_PER_DWORD)
+#define NBL_DSCH_PORT_MAP_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00005000 + (i) * sizeof(struct nbl_port_map))
+/* DSCH dsch_vn_q2tc_cfg_tbl */
+#define NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00010000 + (i) * sizeof(struct dsch_vn_q2tc_cfg_tbl))
+/* DSCH dsch_vn_n2g_cfg_tbl */
+#define NBL_DSCH_VN_N2G_CFG_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00060000 + (i) * sizeof(struct dsch_vn_n2g_cfg_tbl))
+/* DSCH dsch_vn_g2p_cfg_tbl */
+#define NBL_DSCH_VN_G2P_CFG_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00064000 + (i) * sizeof(struct dsch_vn_g2p_cfg_tbl))
+/* DSCH dsch_vn_tc_wgt_cfg_tbl */
+#define NBL_DSCH_VN_TC_WGT_CFG_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00068000 + (i) * sizeof(union dsch_vn_tc_wgt_cfg_tbl_u))
+/* DSCH dsch_vn_sha2net_map_tbl */
+#define NBL_DSCH_VN_SHA2NET_MAP_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00070000 + (i) * sizeof(struct dsch_vn_sha2net_map_tbl))
+/* DSCH dsch_vn_net2sha_map_tbl */
+#define NBL_DSCH_VN_NET2SHA_MAP_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00074000 + (i) * sizeof(struct dsch_vn_net2sha_map_tbl))
+/* DSCH dsch_vn_tc_q_list_tbl */
+#define NBL_DSCH_VN_TC_Q_LIST_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00040000 + (i) * sizeof(struct dsch_vn_tc_q_list_tbl))
+/* DSCH dsch maxqid */
+#define NBL_DSCH_HOST_QID_MAX (NBL_DP_DSCH_BASE + 0x00000118)
+#define NBL_DSCH_VN_QUANTA_ADDR  (NBL_DP_DSCH_BASE + 0x00000134)
+#define NBL_DSCH_INT_STATUS		(NBL_DP_DSCH_BASE + 0x00000000)
+#define NBL_DSCH_RDMA_OTHER_ABN		(NBL_DP_DSCH_BASE + 0x00000080)
+#define NBL_DSCH_RDMA_OTHER_ABN_BIT	(0x4000)
+#define NBL_DSCH_RDMA_DPQM_DB_LOST	(2)
+
+#define NBL_MAX_QUEUE_ID	(0x7ff)
+#define NBL_HOST_QUANTA		(0x8000)
+#define NBL_ECPU_QUANTA		(0x1000)
+
+/* DSCH dsch_vn_q2tc_cfg_tbl */
+struct dsch_vn_q2tc_cfg_tbl {
+	u32 tcid:13;
+	u32 rsv:18;
+	u32 vld:1;
+};
+
+/* DSCH dsch_vn_n2g_cfg_tbl */
+struct dsch_vn_n2g_cfg_tbl {
+	u32 grpid:8;
+	u32 rsv:23;
+	u32 vld:1;
+};
+
+/* DSCH dsch_vn_tc_qlist_tbl */
+struct dsch_vn_tc_q_list_tbl {
+	u32 nxt:11;
+	u32 reserve:18;
+	u32 regi:1;
+	u32 fly:1;
+	u32 vld:1;
+};
+
+/* DSCH dsch_vn_g2p_cfg_tbl */
+struct dsch_vn_g2p_cfg_tbl {
+	u32 port:3;
+	u32 rsv:28;
+	u32 vld:1;
+};
+
+/* DSCH dsch_vn_tc_wgt_cfg_tbl */
+union dsch_vn_tc_wgt_cfg_tbl_u {
+	struct dsch_vn_tc_wgt_cfg_tbl {
+		u8 tc0_wgt;
+		u8 tc1_wgt;
+		u8 tc2_wgt;
+		u8 tc3_wgt;
+		u8 tc4_wgt;
+		u8 tc5_wgt;
+		u8 tc6_wgt;
+		u8 tc7_wgt;
+	} info;
+#define NBL_DSCH_VN_TC_WGT_CFG_TBL_WIDTH (sizeof(struct dsch_vn_tc_wgt_cfg_tbl))
+	u8 data[NBL_DSCH_VN_TC_WGT_CFG_TBL_WIDTH];
+};
+
+struct dsch_vn_quanta {
+	u32 h_qua:16;
+	u32 e_qua:16;
+};
+
+/*  ----------  DVN  ----------  */
+
+struct nbl_dvn_stat_cnt {
+	u32 dvn_desc_fwd_cnt:16;
+	u32 rsv0:16;
+	u32 dvn_desc_drop_cnt:16;
+	u32 rsv1:16;
+	u32 dvn_pkt_fwd_cnt:16;
+	u32 rsv2:16;
+	u32 dvn_pkt_drop_cnt:16;
+	u32 rsv3:16;
+	u32 rsv4[4];
+};
+
+/* DVN dvn_queue_table */
+#define NBL_DVN_QUEUE_TABLE_ARR(i) \
+	(NBL_DP_DVN_BASE + 0x00020000 + (i) * sizeof(struct dvn_queue_table))
+#define NBL_DVN_QUEUE_CXT_TABLE_ARR(i) \
+	(NBL_DP_DVN_BASE + 0x00030000 + (i) * sizeof(struct dvn_queue_context))
+#define NBL_DVN_STAT_CNT(i) (NBL_DP_DVN_BASE + 0x00040000 + (i) * sizeof(struct nbl_dvn_stat_cnt))
+/* DVN dvn_queue_reset */
+#define NBL_DVN_QUEUE_RESET_REG (NBL_DP_DVN_BASE + 0x00000400)
+/* DVN dvn_queue_reset_done */
+#define NBL_DVN_QUEUE_RESET_DONE_REG (NBL_DP_DVN_BASE + 0x00000404)
+#define NBL_DVN_ECPU_QUEUE_NUM			(NBL_DP_DVN_BASE + 0x0000041C)
+#define NBL_DVN_DESCREQ_NUM_CFG			(NBL_DP_DVN_BASE + 0x00000430)
+#define NBL_DVN_DESC_WR_MERGE_TIMEOUT		(NBL_DP_DVN_BASE + 0x00000480)
+#define NBL_DVN_DIF_REQ_RD_RO_FLAG		(NBL_DP_DVN_BASE + 0x0000045C)
+#define NBL_DVN_INT_STATUS			(NBL_DP_DVN_BASE + 0x00000000)
+#define NBL_DVN_DESC_DIF_ERR_CNT		(NBL_DP_DVN_BASE + 0x0000003C)
+#define NBL_DVN_DESC_DIF_ERR_INFO		(NBL_DP_DVN_BASE + 0x00000038)
+#define NBL_DVN_PKT_DIF_ERR_INFO		(NBL_DP_DVN_BASE + 0x00000030)
+#define NBL_DVN_PKT_DIF_ERR_CNT			(NBL_DP_DVN_BASE + 0x00000034)
+#define NBL_DVN_ERR_QUEUE_ID_GET		(NBL_DP_DVN_BASE + 0x0000040C)
+#define NBL_DVN_BACK_PRESSURE_MASK		(NBL_DP_DVN_BASE + 0x00000464)
+#define NBL_DVN_DESCRD_L2_UNAVAIL_CNT		(NBL_DP_DVN_BASE + 0x00000A1C)
+#define NBL_DVN_DESCRD_L2_NOAVAIL_CNT		(NBL_DP_DVN_BASE + 0x00000A20)
+
+#define DEFAULT_DVN_DESCREQ_NUMCFG		(0x00080014)
+#define DEFAULT_DVN_100G_DESCREQ_NUMCFG		(0x00080020)
+
+#define NBL_DVN_INT_PKT_DIF_ERR			(4)
+#define DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX	(0x3FF)
+
+#define NBL_DVN_INT_DESC_DIF_ERR		(5)
+
+struct nbl_dvn_descreq_num_cfg {
+	u32 avring_cfg_num:1; /* spilit ring descreq_num 0:8,1:16 */
+	u32 rsv0:3;
+	u32 packed_l1_num:3; /* packet ring descreq_num 0:8,1:12,2:16;3:20,4:24,5:26;6:32,7:32 */
+	u32 rsv1:25;
+};
+
+struct nbl_dvn_desc_wr_merge_timeout {
+	u32 cfg_cycle:10;
+	u32 rsv:22;
+};
+
+struct nbl_dvn_dif_req_rd_ro_flag {
+	u32 rd_desc_ro_en:1;
+	u32 rd_data_ro_en:1;
+	u32 rd_avring_ro_en:1;
+	u32 rsv:29;
+};
+
+/* DVN dvn_queue_table */
+struct dvn_queue_table {
+	u64 dvn_used_baddr;
+	u64 dvn_avail_baddr;
+	u64 dvn_queue_baddr;
+	u32 dvn_queue_size:4;
+	u32 dvn_queue_type:1;
+	u32 dvn_queue_en:1;
+	u32 dvn_extend_header_en:1;
+	u32 dvn_interleave_seg_disable:1;
+	u32 dvn_seg_disable:1;
+	u32 rsv0:23;
+	u32 rsv1:32;
+};
+
+/* DVN dvn_queue_context */
+struct dvn_queue_context {
+	u32 dvn_descrd_num:3;
+	u32 dvn_firstdescid:16;
+	u32 dvn_firstdesc:16;
+	u32 dvn_indirect_len:6;
+	u64 dvn_indirect_addr:64;
+	u32 dvn_indirect_next:5;
+	u32 dvn_l1_ring_read:16;
+	u32 dvn_avail_ring_read:16;
+	u32 dvn_ring_wrap_counter:1;
+	u32 dvn_lso_id:10;
+	u32 dvn_avail_ring_idx:16;
+	u32 dvn_used_ring_idx:16;
+	u32 dvn_indirect_left:1;
+	u32 dvn_desc_left:1;
+	u32 dvn_lso_flag:1;
+	u32 dvn_descrd_disable:1;
+	u32 dvn_queue_err:1;
+	u32 dvn_lso_drop:1;
+	u32 dvn_protected_bit:1;
+	u64 reserve;
+};
+
+/* DVN dvn_queue_reset */
+struct nbl_dvn_queue_reset {
+	u32 dvn_queue_index:11;
+	u32 vld:1;
+	u32 rsv:20;
+};
+
+/* DVN dvn_queue_reset_done */
+struct nbl_dvn_queue_reset_done {
+	u32 flag:1;
+	u32 rsv:31;
+};
+
+/* DVN dvn_desc_dif_err_info */
+struct dvn_desc_dif_err_info {
+	u32 queue_id:11;
+	u32 rsv:21;
+};
+
+struct dvn_pkt_dif_err_info {
+	u32 queue_id:11;
+	u32 rsv:21;
+};
+
+struct dvn_err_queue_id_get {
+	u32 pkt_flag:1;
+	u32 desc_flag:1;
+	u32 rsv:30;
+};
+
+struct dvn_back_pressure_mask {
+	u32 l4s_flag:1;
+	u32 dsch_flag:1;
+	u32 dstore_port0_flag:1;
+	u32 dstore_port1_flag:1;
+	u32 dstore_port2_flag:1;
+	u32 dstore_port3_flag:1;
+	u32 rsv:26;
+};
+
+/*  ----------  UVN  ----------  */
+/* UVN uvn_queue_table */
+#define NBL_UVN_QUEUE_TABLE_ARR(i) \
+	(NBL_DP_UVN_BASE + 0x00010000 + (i) * sizeof(struct uvn_queue_table))
+/* UVN uvn_queue_cxt */
+#define NBL_UVN_QUEUE_CXT_TABLE_ARR(i) \
+	(NBL_DP_UVN_BASE + 0x00020000 + (i) * sizeof(struct uvn_queue_cxt))
+/* UVN uvn_desc_cxt */
+#define NBL_UVN_DESC_CXT_TABLE_ARR(i) \
+	(NBL_DP_UVN_BASE + 0x00028000 + (i) * sizeof(struct uvn_desc_cxt))
+/* UVN uvn_queue_reset */
+#define NBL_UVN_QUEUE_RESET_REG (NBL_DP_UVN_BASE + 0x00000200)
+/* UVN uvn_queue_reset_done */
+#define NBL_UVN_QUEUE_RESET_DONE_REG (NBL_DP_UVN_BASE + 0x00000408)
+#define NBL_UVN_STATIS_PKT_DROP(i) (NBL_DP_UVN_BASE + 0x00038000 + (i) * sizeof(u32))
+#define NBL_UVN_INT_STATUS			(NBL_DP_UVN_BASE + 0x00000000)
+#define NBL_UVN_QUEUE_ERR_INFO			(NBL_DP_UVN_BASE + 0x00000034)
+#define NBL_UVN_QUEUE_ERR_CNT			(NBL_DP_UVN_BASE + 0x00000038)
+#define NBL_UVN_DESC_RD_WAIT			(NBL_DP_UVN_BASE + 0x0000020C)
+#define NBL_UVN_QUEUE_ERR_MASK			(NBL_DP_UVN_BASE + 0x00000224)
+#define NBL_UVN_ECPU_QUEUE_NUM			(NBL_DP_UVN_BASE + 0x0000023C)
+#define NBL_UVN_DESC_WR_TIMEOUT			(NBL_DP_UVN_BASE + 0x00000214)
+#define NBL_UVN_DIF_DELAY_REQ			(NBL_DP_UVN_BASE + 0x000010D0)
+#define NBL_UVN_DIF_DELAY_TIME			(NBL_DP_UVN_BASE + 0x000010D4)
+#define NBL_UVN_DIF_DELAY_MAX			(NBL_DP_UVN_BASE + 0x000010D8)
+#define NBL_UVN_DESC_PRE_DESC_REQ_NULL		(NBL_DP_UVN_BASE + 0x000012C8)
+#define NBL_UVN_DESC_PRE_DESC_REQ_LACK		(NBL_DP_UVN_BASE + 0x000012CC)
+#define NBL_UVN_DESC_RD_ENTRY			(NBL_DP_UVN_BASE + 0x000012D0)
+#define NBL_UVN_DESC_RD_DROP_DESC_LACK		(NBL_DP_UVN_BASE + 0x000012E0)
+#define NBL_UVN_DIF_REQ_RO_FLAG			(NBL_DP_UVN_BASE + 0x00000250)
+#define NBL_UVN_DESC_PREFETCH_INIT		(NBL_DP_UVN_BASE + 0x00000204)
+#define NBL_UVN_DESC_WR_TIMEOUT_4US		(0x960)
+#define NBL_UVN_DESC_PREFETCH_NUM		(4)
+
+#define NBL_UVN_INT_QUEUE_ERR			(5)
+
+struct uvn_dif_req_ro_flag {
+	u32 avail_rd:1;
+	u32 desc_rd:1;
+	u32 pkt_wr:1;
+	u32 desc_wr:1;
+	u32 rsv:28;
+};
+
+/* UVN uvn_queue_table */
+struct uvn_queue_table {
+	u64 used_baddr;
+	u64 avail_baddr;
+	u64 queue_baddr;
+	u32 queue_size_mask_pow:4;
+	u32 queue_type:1;
+	u32 queue_enable:1;
+	u32 extend_header_en:1;
+	u32 guest_csum_en:1;
+	u32 half_offload_en:1;
+	u32 rsv0:23;
+	u32 rsv1:32;
+};
+
+/* uvn uvn_queue_cxt */
+struct uvn_queue_cxt {
+	u32 queue_head:16;
+	u32 wrap_count:1;
+	u32 queue_err:1;
+	u32 prefetch_null_cnt:2;
+	u32 ntf_finish:1;
+	u32 spnd_flag:1;
+	u32 reserve0:10;
+	u32 avail_idx:16;
+	u32 avail_idx_spnd_flag:1;
+	u32 reserve1:15;
+	u32 reserve2[2];
+};
+
+/* uvn uvn_queue_reset */
+struct nbl_uvn_queue_reset {
+	u32 index:11;
+	u32 rsv0:5;
+	u32 vld:1;
+	u32 rsv1:15;
+};
+
+/* uvn uvn_queue_reset_done */
+struct nbl_uvn_queue_reset_done {
+	u32 flag:1;
+	u32 rsv:31;
+};
+
+/* uvn uvn_desc_cxt */
+struct uvn_desc_cxt {
+	u32 cache_head:9;
+	u32 reserve0:7;
+	u32 cache_tail:9;
+	u32 reserve1:7;
+	u32 cache_pref_num_prev:9;
+	u32 reserve2:7;
+	u32 cache_pref_num_post:9;
+	u32 reserve3:7;
+	u32 cache_head_byte:30;
+	u32 reserve4:2;
+	u32 cache_tail_byte:30;
+	u32 reserve5:2;
+};
+
+struct uvn_desc_wr_timeout {
+	u32 num:15;
+	u32 mask:1;
+	u32 rsv:16;
+};
+
+struct uvn_queue_err_info {
+	u32 queue_id:11;
+	u32 type:5;
+	u32 rsv:16;
+};
+
+struct uvn_queue_err_mask {
+	u32 rsv0:1;
+	u32 buffer_len_err:1;
+	u32 next_err:1;
+	u32 indirect_err:1;
+	u32 split_err:1;
+	u32 dif_err:1;
+	u32 rsv1:26;
+};
+
+struct uvn_desc_prefetch_init {
+	u32 num:8;
+	u32 rsv1:8;
+	u32 sel:1;
+	u32 rsv:15;
+};
+
+/*  --------  USTORE  --------  */
+#define NBL_USTORE_PKT_LEN_ADDR			(NBL_DP_USTORE_BASE + 0x00000108)
+#define NBL_USTORE_PORT_FC_TH_REG_ARR(port_id) \
+	(NBL_DP_USTORE_BASE + 0x00000134 + (port_id) * sizeof(struct nbl_ustore_port_fc_th))
+#define NBL_USTORE_COS_FC_TH_REG_ARR(cos_id) \
+	(NBL_DP_USTORE_BASE + 0x00000200 + (cos_id) * sizeof(struct nbl_ustore_cos_fc_th))
+#define NBL_USTORE_PORT_DROP_TH_REG_ARR(port_id) \
+	(NBL_DP_USTORE_BASE + 0x00000150 + (port_id) * sizeof(struct nbl_ustore_port_drop_th))
+#define NBL_USTORE_BUF_TOTAL_DROP_PKT		(NBL_DP_USTORE_BASE + 0x000010A8)
+#define NBL_USTORE_BUF_TOTAL_TRUN_PKT		(NBL_DP_USTORE_BASE + 0x000010AC)
+#define NBL_USTORE_BUF_PORT_DROP_PKT(eth_id) \
+	(NBL_DP_USTORE_BASE + 0x00002500 + (eth_id) * sizeof(u32))
+#define NBL_USTORE_BUF_PORT_TRUN_PKT(eth_id) \
+	(NBL_DP_USTORE_BASE + 0x00002540 + (eth_id) * sizeof(u32))
+
+#define NBL_USTORE_SIGNLE_ETH_DROP_TH		0xC80
+#define NBL_USTORE_DUAL_ETH_DROP_TH		0x640
+#define NBL_USTORE_QUAD_ETH_DROP_TH		0x320
+
+/* USTORE pkt_len */
+struct ustore_pkt_len {
+	u32 min:7;
+	u32 rsv:8;
+	u32 min_chk_en:1;
+	u32 max:14;
+	u32 rsv2:1;
+	u32 max_chk_len:1;
+};
+
+/* USTORE port_fc_th */
+struct nbl_ustore_port_fc_th {
+	u32 xoff_th:12;
+	u32 rsv1:4;
+	u32 xon_th:12;
+	u32 rsv2:2;
+	u32 fc_set:1;
+	u32 fc_en:1;
+};
+
+/* USTORE cos_fc_th */
+struct nbl_ustore_cos_fc_th {
+	u32 xoff_th:12;
+	u32 rsv1:4;
+	u32 xon_th:12;
+	u32 rsv2:2;
+	u32 fc_set:1;
+	u32 fc_en:1;
+};
+
+#define NBL_MAX_USTORE_COS_FC_TH (4080)
+
+/* USTORE port_drop_th */
+struct nbl_ustore_port_drop_th {
+	u32 disc_th:12;
+	u32 rsv:19;
+	u32 en:1;
+};
+
+/*  ----------  UL4S  ----------  */
+#define NBL_UL4S_SCH_PAD_ADDR			(NBL_DP_UL4S_BASE + 0x000006c4)
+
+/* UL4S ul4s_sch_pad */
+struct ul4s_sch_pad {
+	u32 en:1;
+	u32 clr:1;
+	u32 rsv:30;
+};
+
+/*  ---------  DSTAT  ---------  */
+#define NBL_DSTAT_VSI_STAT(vsi_id)	\
+	(NBL_DP_DSTAT_BASE + 0x00008000 + (vsi_id) * sizeof(struct nbl_dstat_vsi_stat))
+
+struct nbl_dstat_vsi_stat {
+	u32 fwd_byte_cnt_low;
+	u32 fwd_byte_cnt_high;
+	u32 fwd_pkt_cnt_low;
+	u32 fwd_pkt_cnt_high;
+};
+
+/*  ---------  USTAT  ---------  */
+#define NBL_USTAT_VSI_STAT(vsi_id)	\
+	(NBL_DP_USTAT_BASE + 0x00008000 + (vsi_id) * sizeof(struct nbl_ustat_vsi_stat))
+
+struct nbl_ustat_vsi_stat {
+	u32 fwd_byte_cnt_low;
+	u32 fwd_byte_cnt_high;
+	u32 fwd_pkt_cnt_low;
+	u32 fwd_pkt_cnt_high;
+};
+
+/*  ----------  IPRO  ----------  */
+/* ipro module related macros */
+#define NBL_IPRO_MODULE (0xB04000)
+/* ipro queue tbl */
+#define NBL_IPRO_QUEUE_TBL(i) \
+	(NBL_IPRO_MODULE + 0x00004000 + (i) * sizeof(struct nbl_ipro_queue_tbl))
+#define NBL_IPRO_UP_SPORT_TABLE(i) \
+	(NBL_IPRO_MODULE + 0x00007000 + (i) * sizeof(struct nbl_ipro_upsport_tbl))
+#define NBL_IPRO_DN_SRC_PORT_TABLE(i) \
+	(NBL_PPE_IPRO_BASE + 0x00008000 + (i) * sizeof(struct nbl_ipro_dn_src_port_tbl))
+
+enum nbl_fwd_type_e {
+	NBL_FWD_TYPE_NORMAL		= 0,
+	NBL_FWD_TYPE_CPU_ASSIGNED	= 1,
+	NBL_FWD_TYPE_UPCALL		= 2,
+	NBL_FWD_TYPE_SRC_MIRROR		= 3,
+	NBL_FWD_TYPE_OTHER_MIRROR	= 4,
+	NBL_FWD_TYPE_MNG		= 5,
+	NBL_FWD_TYPE_GLB_LB		= 6,
+	NBL_FWD_TYPE_DROP		= 7,
+	NBL_FWD_TYPE_MAX		= 8,
+};
+
+/* IPRO dn_src_port_tbl */
+struct nbl_ipro_dn_src_port_tbl {
+	u32 entry_vld:1;
+	u32 mirror_en:1;
+	u32 mirror_pr:2;
+	u32 mirror_id:4;
+	u32 vlan_layer_num_1:2;
+	u32 hw_flow:1;
+	u32 mtu_sel:4;
+	u32 addr_check_en:1;
+	u32 smac_low:16;
+	u32 smac_high;
+	u32 dqueue:11;
+	u32 dqueue_en:1;
+	u32 dqueue_pri:2;
+	u32 set_dport_pri:2;
+	union nbl_action_data set_dport;
+	u32 set_dport_en:1;
+	u32 proc_done:1;
+	u32 not_used_1:6;
+	u32 rsv:24;
+};
+
+/* IPRO up sport tab */
+struct nbl_ipro_upsport_tbl {
+	u32 entry_vld:1;
+	u32 vlan_layer_num_0:2;
+	u32 vlan_layer_num_1:2;
+	u32 lag_vld:1;
+	u32 lag_id:2;
+	u32 hw_flow:1;
+	u32 mirror_en:1;
+	u32 mirror_pr:2;
+	u32 mirror_id:4;
+	u32 dqueue_pri:2;
+	u32 set_dport_pri:2;
+	u32 dqueue:11;
+	u32 dqueue_en:1;
+	union nbl_action_data set_dport;
+	u32 set_dport_en:1;
+	u32 proc_done:1;
+	u32 car_en:1;
+	u32 car_pr:2;
+	u32 car_id:10;
+	u32 rsv:1;
+};
+
+struct nbl_ipro_mtu_sel {
+	u32 mtu_1:16;            /* [15:0] Default:0x0 RW */
+	u32 mtu_0:16;            /* [31:16] Default:0x0 RW */
+};
+
+/*  ----------  EPRO  ----------  */
+#define NBL_EPRO_INT_STATUS			(NBL_PPE_EPRO_BASE + 0x00000000)
+#define NBL_EPRO_INT_MASK			(NBL_PPE_EPRO_BASE + 0x00000004)
+#define NBL_EPRO_RSS_KEY_REG			(NBL_PPE_EPRO_BASE + 0x00000400)
+#define NBL_EPRO_MIRROR_ACT_PRI_REG		(NBL_PPE_EPRO_BASE + 0x00000234)
+#define NBL_EPRO_ACTION_FILTER_TABLE(i)		(NBL_PPE_EPRO_BASE + 0x00001900 + \
+						sizeof(struct nbl_epro_action_filter_tbl) * (i))
+/* epro epro_ept table */
+#define NBL_EPRO_EPT_TABLE(i) \
+	(NBL_PPE_EPRO_BASE + 0x00001800 + (i) * sizeof(struct nbl_epro_ept_tbl))
+/* epro epro_vpt table */
+#define NBL_EPRO_VPT_TABLE(i) \
+	(NBL_PPE_EPRO_BASE + 0x00004000 + (i) * sizeof(struct nbl_epro_vpt_tbl))
+/* epro epro_rss_pt table */
+#define NBL_EPRO_RSS_PT_TABLE(i) \
+	(NBL_PPE_EPRO_BASE + 0x00002000 + (i) * sizeof(struct nbl_epro_rss_pt_tbl))
+/* epro epro_rss_ret table */
+#define NBL_EPRO_RSS_RET_TABLE(i) \
+	(NBL_PPE_EPRO_BASE + 0x00008000 + (i) * sizeof(struct nbl_epro_rss_ret_tbl))
+/* epro epro_sch_cos_map table */
+#define NBL_EPRO_SCH_COS_MAP_TABLE(i, j) \
+	(NBL_PPE_EPRO_BASE + 0x00000640 + ((i) * 0x20) + (j) * sizeof(struct nbl_epro_cos_map))
+/* epro epro_port_pri_mdf_en */
+#define NBL_EPRO_PORT_PRI_MDF_EN	(NBL_PPE_EPRO_BASE + 0x000006E0)
+/* epro epro_act_sel_en */
+#define NBL_EPRO_ACT_SEL_EN_REG \
+	(NBL_PPE_EPRO_BASE + 0x00000214)
+/* epro epro_kgen_ft table */
+#define NBL_EPRO_KGEN_FT_TABLE(i) \
+	(NBL_PPE_EPRO_BASE + 0x00001980 + (i) * sizeof(struct nbl_epro_kgen_ft_tbl))
+
+struct nbl_epro_int_mask {
+	u32 fatal_err:1;
+	u32 fifo_uflw_err:1;
+	u32 fifo_dflw_err:1;
+	u32 cif_err:1;
+	u32 input_err:1;
+	u32 cfg_err:1;
+	u32 data_ucor_err:1;
+	u32 bank_cor_err:1;
+	u32 rsv2:24;
+};
+
+struct nbl_epro_rss_key {
+	u64 key0;
+	u64 key1;
+	u64 key2;
+	u64 key3;
+	u64 key4;
+};
+
+struct nbl_epro_mirror_act_pri {
+	u32 car_idx_pri:2;
+	u32 dqueue_pri:2;
+	u32 dport_pri:2;
+	u32 rsv:26;
+};
+
+/* EPRO epro_rss_ret table */
+struct nbl_epro_rss_ret_tbl {
+	u32 dqueue0:11;
+	u32 vld0:1;
+	u32 rsv0:4;
+	u32 dqueue1:11;
+	u32 vld1:1;
+	u32 rsv1:4;
+};
+
+/* EPRO epro_rss_pt table */
+struct nbl_epro_rss_pt_tbl {
+	u32 entry_size:3;
+#define NBL_EPRO_RSS_ENTRY_SIZE_16		(0)
+#define NBL_EPRO_RSS_ENTRY_SIZE_32		(1)
+#define NBL_EPRO_RSS_ENTRY_SIZE_64		(2)
+#define NBL_EPRO_RSS_ENTRY_SIZE_128		(3)
+#define NBL_EPRO_RSS_ENTRY_SIZE_256		(4)
+	u32 offset1:14;
+	u32 offset1_vld:1;
+	u32 offset0:14;
+	u32 offset0_vld:1;
+	u32 vld:1;
+	u32 rsv:30;
+};
+
+/*EPRO sch cos map*/
+struct nbl_epro_cos_map {
+	u32 pkt_cos:3;
+	u32 dscp:6;
+	u32 rsv:23;
+};
+
+/* EPRO epro_port_pri_mdf_en */
+struct nbl_epro_port_pri_mdf_en_cfg {
+	u32 eth0:1;
+	u32 eth1:1;
+	u32 eth2:1;
+	u32 eth3:1;
+	u32 loop:1;
+	u32 rsv:27;
+};
+
+enum nbl_md_action_id_e {
+	NBL_MD_ACTION_NONE		= 0,
+	NBL_MD_ACTION_CLEAR_FLAG	= 1,
+	NBL_MD_ACTION_SET_FLAG		= NBL_MD_ACTION_CLEAR_FLAG,
+	NBL_MD_ACTION_SET_FWD		= NBL_MD_ACTION_CLEAR_FLAG,
+	NBL_MD_ACTION_FLOWID0		= 2,
+	NBL_MD_ACTION_FLOWID1		= 3,
+	NBL_MD_ACTION_RSSIDX		= 4,
+	NBL_MD_ACTION_PORT_CARIDX	= 5,
+	NBL_MD_ACTION_FLOW_CARIDX	= 6,
+	NBL_MD_ACTION_TABLE_INDEX	= 7,
+	NBL_MD_ACTION_MIRRIDX		= 8,
+	NBL_MD_ACTION_DPORT		= 9,
+	NBL_MD_ACTION_SET_DPORT		= NBL_MD_ACTION_DPORT,
+	NBL_MD_ACTION_DQUEUE		= 10,
+	NBL_MD_ACTION_MCIDX		= 13,
+	NBL_MD_ACTION_VNI0		= 14,
+	NBL_MD_ACTION_VNI1		= 15,
+	NBL_MD_ACTION_STAT_IDX		= 16,
+	NBL_MD_ACTION_PRBAC_IDX		= 17,
+	NBL_MD_ACTION_L4S_IDX		= NBL_MD_ACTION_PRBAC_IDX,
+	NBL_MD_ACTION_DP_HASH0		= 19,
+	NBL_MD_ACTION_DP_HASH1		= 20,
+	NBL_MD_ACTION_MDF_PRI		= 21,
+
+	NBL_MD_ACTION_MDF_V4_SIP	= 32,
+	NBL_MD_ACTION_MDF_V4_DIP	= 33,
+	NBL_MD_ACTION_MDF_V6_SIP	= 34,
+	NBL_MD_ACTION_MDF_V6_DIP	= 35,
+	NBL_MD_ACTION_MDF_DPORT		= 36,
+	NBL_MD_ACTION_MDF_SPORT		= 37,
+	NBL_MD_ACTION_MDF_DMAC		= 38,
+	NBL_MD_ACTION_MDF_SMAC		= 39,
+	NBL_MD_ACTION_MDF_V4_DSCP_ECN	= 40,
+	NBL_MD_ACTION_MDF_V6_DSCP_ECN	= 41,
+	NBL_MD_ACTION_MDF_V4_TTL	= 42,
+	NBL_MD_ACTION_MDF_V6_HOPLIMIT	= 43,
+	NBL_MD_ACTION_DEL_O_VLAN	= 44,
+	NBL_MD_ACTION_DEL_I_VLAN	= 45,
+	NBL_MD_ACTION_MDF_O_VLAN	= 46,
+	NBL_MD_ACTION_MDF_I_VLAN	= 47,
+	NBL_MD_ACTION_ADD_O_VLAN	= 48,
+	NBL_MD_ACTION_ADD_I_VLAN	= 49,
+	NBL_MD_ACTION_ENCAP_TNL		= 50,
+	NBL_MD_ACTION_DECAP_TNL		= 51,
+	NBL_MD_ACTION_MDF_TNL_SPORT	= 52,
+};
+
+/* EPRO action filter table */
+struct nbl_epro_action_filter_tbl {
+	u64 filter_mask;
+};
+
+#define NBL_EPRO_LAG_MAX			(4)
+#define NBL_EPRO_EPT_LAG_OFFSET			(4)
+
+/* EPRO epr_ept table */
+struct nbl_epro_ept_tbl {
+	u32 cvlan:16;
+	u32 svlan:16;
+	u32 fwd:1;
+#define NBL_EPRO_FWD_TYPE_DROP		(0)
+#define NBL_EPRO_FWD_TYPE_NORMAL	(1)
+	u32 mirror_en:1;
+	u32 mirror_id:4;
+	u32 pop_i_vlan:1;
+	u32 pop_o_vlan:1;
+	u32 push_i_vlan:1;
+	u32 push_o_vlan:1;
+	u32 replace_i_vlan:1;
+	u32 replace_o_vlan:1;
+	u32 lag_alg_sel:2;
+#define NBL_EPRO_LAG_ALG_L2_HASH		(0)
+#define NBL_EPRO_LAG_ALG_L23_HASH		(1)
+#define NBL_EPRO_LAG_ALG_LINUX_L34_HASH		(2)
+#define NBL_EPRO_LAG_ALG_DPDK_L34_HASH		(3)
+	u32 lag_port_btm:4;
+	u32 lag_l2_protect_en:1;
+	u32 pfc_sch_cos_default:3;
+	u32 pfc_mode:1;
+	u32 vld:1;
+	u32 rsv:8;
+};
+
+/* EPRO epro_vpt table */
+struct nbl_epro_vpt_tbl {
+	u32 cvlan:16;
+	u32 svlan:16;
+	u32 fwd:1;
+#define NBL_EPRO_FWD_TYPE_DROP		(0)
+#define NBL_EPRO_FWD_TYPE_NORMAL	(1)
+	u32 mirror_en:1;
+	u32 mirror_id:4;
+	u32 car_en:1;
+	u32 car_id:10;
+	u32 pop_i_vlan:1;
+	u32 pop_o_vlan:1;
+	u32 push_i_vlan:1;
+	u32 push_o_vlan:1;
+	u32 replace_i_vlan:1;
+	u32 replace_o_vlan:1;
+	u32 rss_alg_sel:1;
+#define NBL_EPRO_RSS_ALG_TOEPLITZ_HASH		(0)
+#define NBL_EPRO_RSS_ALG_CRC32			(1)
+	u32 rss_key_type_ipv4:1;
+#define NBL_EPRO_RSS_KEY_TYPE_IPV4_L3		(0)
+#define NBL_EPRO_RSS_KEY_TYPE_IPV4_L4		(1)
+	u32 rss_key_type_ipv6:1;
+#define NBL_EPRO_RSS_KEY_TYPE_IPV6_L3		(0)
+#define NBL_EPRO_RSS_KEY_TYPE_IPV6_L4		(1)
+	u32 vld:1;
+	u32 rsv:5;
+};
+
+/* UPA upa_pri_sel_conf */
+#define NBL_UPA_PRI_SEL_CONF_TABLE(id)	(NBL_DP_UPA_BASE + 0x00000230 + \
+					((id) * sizeof(struct nbl_upa_pri_sel_conf)))
+#define NBL_UPA_PRI_CONF_TABLE(id)	(NBL_DP_UPA_BASE + 0x00002000 + \
+					((id) * sizeof(struct nbl_upa_pri_conf)))
+
+/* UPA pri_sel_conf */
+struct nbl_upa_pri_sel_conf {
+	u32 pri_sel:5;
+	u32 pri_default:3;
+	u32 pri_disen:1;
+	u32 rsv:23;
+};
+
+/* UPA pri_conf_table */
+struct nbl_upa_pri_conf {
+	u32 pri0:4;
+	u32 pri1:4;
+	u32 pri2:4;
+	u32 pri3:4;
+	u32 pri4:4;
+	u32 pri5:4;
+	u32 pri6:4;
+	u32 pri7:4;
+};
+
+#define NBL_DQM_RXMAC_TX_PORT_BP_EN	(NBL_DP_DQM_BASE + 0x00000660)
+#define NBL_DQM_RXMAC_TX_COS_BP_EN	(NBL_DP_DQM_BASE + 0x00000664)
+#define NBL_DQM_RXMAC_RX_PORT_BP_EN	(NBL_DP_DQM_BASE + 0x00000670)
+#define NBL_DQM_RX_PORT_BP_EN		(NBL_DP_DQM_BASE + 0x00000610)
+#define NBL_DQM_RX_COS_BP_EN		(NBL_DP_DQM_BASE + 0x00000614)
+
+/* DQM rxmac_tx_port_bp_en */
+struct nbl_dqm_rxmac_tx_port_bp_en_cfg {
+	u32 eth0:1;
+	u32 eth1:1;
+	u32 eth2:1;
+	u32 eth3:1;
+	u32 rsv:28;
+};
+
+/* DQM rxmac_tx_cos_bp_en */
+struct nbl_dqm_rxmac_tx_cos_bp_en_cfg {
+	u32 eth0:8;
+	u32 eth1:8;
+	u32 eth2:8;
+	u32 eth3:8;
+};
+
+#define NBL_UQM_QUE_TYPE			(NBL_DP_UQM_BASE + 0x0000013c)
+#define NBL_UQM_RX_COS_BP_EN			(NBL_DP_UQM_BASE + 0x00000614)
+#define NBL_UQM_TX_COS_BP_EN			(NBL_DP_UQM_BASE + 0x00000604)
+
+#define NBL_UQM_DROP_PKT_CNT			(NBL_DP_UQM_BASE + 0x000009C0)
+#define NBL_UQM_DROP_PKT_SLICE_CNT		(NBL_DP_UQM_BASE + 0x000009C4)
+#define NBL_UQM_DROP_PKT_LEN_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009C8)
+#define NBL_UQM_DROP_HEAD_PNTR_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009CC)
+#define NBL_UQM_DROP_WEIGHT_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009D0)
+#define NBL_UQM_PORT_DROP_PKT_CNT		(NBL_DP_UQM_BASE + 0x000009D4)
+#define NBL_UQM_PORT_DROP_PKT_SLICE_CNT		(NBL_DP_UQM_BASE + 0x000009F4)
+#define NBL_UQM_PORT_DROP_PKT_LEN_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A14)
+#define NBL_UQM_PORT_DROP_HEAD_PNTR_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A34)
+#define NBL_UQM_PORT_DROP_WEIGHT_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A54)
+#define NBL_UQM_FWD_DROP_CNT			(NBL_DP_UQM_BASE + 0x00000A80)
+#define NBL_UQM_DPORT_DROP_CNT			(NBL_DP_UQM_BASE + 0x00000B74)
+
+#define NBL_UQM_PORT_DROP_DEPTH			6
+#define NBL_UQM_DPORT_DROP_DEPTH		16
+
+struct nbl_uqm_que_type {
+	u32 bp_drop:1;
+	u32 rsv:31;
+};
+
+/* UQM rx_cos_bp_en */
+struct nbl_uqm_rx_cos_bp_en_cfg {
+	u32 vld_l;
+	u32 vld_h:16;
+};
+
+/* UQM rx_port_bp_en */
+struct nbl_uqm_rx_port_bp_en_cfg {
+	u32 l4s_h:1;
+	u32 l4s_e:1;
+	u32 rdma_h:1;
+	u32 rdma_e:1;
+	u32 emp:1;
+	u32 loopback:1;
+	u32 rsv:26;
+};
+
+/* UQM tx_cos_bp_en */
+struct nbl_uqm_tx_cos_bp_en_cfg {
+	u32 vld_l;
+	u32 vld_h:8;
+};
+
+#pragma pack()
+
+/*  ----------  TOP  ----------  */
+/* lb_top_ctrl_crg_cfg crg_cfg */
+#define NBL_TOP_CTRL_MODULE		(0x01300000)
+#define NBL_TOP_CTRL_INT_STATUS		(NBL_TOP_CTRL_MODULE + 0X0000)
+#define NBL_TOP_CTRL_INT_MASK		(NBL_TOP_CTRL_MODULE + 0X0004)
+#define NBL_TOP_CTRL_LB_CLK		(NBL_TOP_CTRL_MODULE + 0X0100)
+#define NBL_TOP_CTRL_LB_RST		(NBL_TOP_CTRL_MODULE + 0X0104)
+#define NBL_TOP_CTRL_TVSENSOR0		(NBL_TOP_CTRL_MODULE + 0X0254)
+#define NBL_TOP_CTRL_SOFT_DEF0		(NBL_TOP_CTRL_MODULE + 0x0430)
+#define NBL_TOP_CTRL_SOFT_DEF1		(NBL_TOP_CTRL_MODULE + 0x0434)
+#define NBL_TOP_CTRL_SOFT_DEF2		(NBL_TOP_CTRL_MODULE + 0x0438)
+#define NBL_TOP_CTRL_SOFT_DEF3		(NBL_TOP_CTRL_MODULE + 0x043c)
+#define NBL_TOP_CTRL_SOFT_DEF4		(NBL_TOP_CTRL_MODULE + 0x0440)
+#define NBL_TOP_CTRL_SOFT_DEF5		(NBL_TOP_CTRL_MODULE + 0x0444)
+#define NBL_TOP_CTRL_VERSION_INFO	(NBL_TOP_CTRL_MODULE + 0X0900)
+#define NBL_TOP_CTRL_VERSION_DATE	(NBL_TOP_CTRL_MODULE + 0X0904)
+
+#define NBL_FW_HEARTBEAT_PONG		NBL_TOP_CTRL_SOFT_DEF1
+
+#define NBL_TOP_CTRL_RDMA_LB_RST	BIT(10)
+#define NBL_TOP_CTRL_RDMA_LB_CLK	BIT(10)
+
+/* temperature threshold1 */
+#define NBL_LEONIS_TEMP_MAX			(105)
+/* temperature threshold2 */
+#define NBL_LEONIS_TEMP_CRIT			(115)
+
+#define NBL_ACT_DATA_BITS			(16)
+
+#define NBL_CMDQ_DIF_MODE_VALUE			(2)
+#define NBL_CMDQ_DELAY_200US			(200)
+#define NBL_CMDQ_DELAY_300US			(300)
+#define NBL_CMDQ_RESET_MAX_WAIT			(30)
+#define NBL_CMD_NOTIFY_ADDR			(0x00001000)
+#define NBL_ACL_RD_RETRY			(50000)
+#define NBL_ACL_RD_WAIT_100US			(100)
+#define NBL_ACL_RD_WAIT_200US			(200)
+#define NBL_ACL_CPU_WRITE			(0)
+#define NBL_ACL_CPU_READ			(1)
+
+/* the capacity of storing acl-items in all tcams */
+#define NBL_ACL_ITEM_CAP			(1536)
+#define NBL_ACL_KEY_WIDTH			(120)
+#define NBL_ACL_ITEM6_CAP			(512)
+#define NBL_ACL_KEY6_WIDTH			(240)
+#define NBL_ACL_TCAM_DEPTH			(512)
+#define NBL_ACL_S1_PROFILE_ID			(0)
+#define NBL_ACL_S2_PROFILE_ID			(1)
+#define NBL_ACL_TCAM_CNT			(16)
+#define NBL_ACL_TCAM_HALF			(8)
+#define NBL_ACL_TCAM_DEPTH			(512)
+#define NBL_ACL_TCAM_BITS			(40)
+#define NBL_ACL_HALF_TCAMS_BITS			(320)
+#define NBL_ACL_HALF_TCAMS_BYTES		(40)
+#define NBL_ACL_ALL_TCAMS_BITS			(640)
+#define NBL_ACL_ALL_TCAMS_BYTES			(80)
+#define NBL_ACL_ACT_RAM_CNT			(4)
+
+#define NBL_FEM_TCAM_MAX_NUM			(64)
+
+#define RTE_ETHER_TYPE_VLAN			0x8100
+#define RTE_ETHER_TYPE_QINQ			0x88A8
+#define RTE_ETHER_TYPE_QINQ1			0x9100
+#define RTE_ETHER_TYPE_QINQ2			0x9200
+#define NBL_BYTES_IN_REG			(4)
+#define NBL_CMDQ_HI_DWORD(x)				((u32)(((x) >> 32) & 0xFFFFFFFF))
+#define NBL_CMDQ_LO_DWORD(x)				((u32)(x) & 0xFFFFFFFF)
+#define NBL_FEM_INIT_START_KERN			(0xFE)
+#define NBL_FEM_INIT_START_VALUE		(0x3E)
+#define NBL_PED_VSI_TYPE_ETH_BASE		(1027)
+#define NBL_DPED_VLAN_TYPE_PORT_NUM		(1031)
+#define NBL_CHAN_REG_MAX_LEN			(32)
+#define NBL_EPRO_RSS_KEY_32			(0x6d5a6d5a)
+
+#define NBL_SHAPING_GRP_TIMMING_ADD_ADDR  (0x504400)
+#define NBL_SHAPING_GRP_ADDR  (0x504800)
+#define NBL_SHAPING_GRP_DWLEN (4)
+#define NBL_SHAPING_GRP_REG(r) (NBL_SHAPING_GRP_ADDR + \
+		(NBL_SHAPING_GRP_DWLEN * 4) * (r))
+#define NBL_DSCH_VN_SHA2GRP_MAP_TBL_ADDR  (0x47c000)
+#define NBL_DSCH_VN_SHA2GRP_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_VN_SHA2GRP_MAP_TBL_REG(r) (NBL_DSCH_VN_SHA2GRP_MAP_TBL_ADDR + \
+		(NBL_DSCH_VN_SHA2GRP_MAP_TBL_DWLEN * 4) * (r))
+#define NBL_DSCH_VN_GRP2SHA_MAP_TBL_ADDR  (0x480000)
+#define NBL_DSCH_VN_GRP2SHA_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_VN_GRP2SHA_MAP_TBL_REG(r) (NBL_DSCH_VN_GRP2SHA_MAP_TBL_ADDR + \
+		(NBL_DSCH_VN_GRP2SHA_MAP_TBL_DWLEN * 4) * (r))
+#define NBL_SHAPING_DPORT_TIMMING_ADD_ADDR  (0x504504)
+#define NBL_SHAPING_DPORT_ADDR  (0x504700)
+#define NBL_SHAPING_DPORT_DWLEN (4)
+#define NBL_SHAPING_DPORT_REG(r) (NBL_SHAPING_DPORT_ADDR + \
+		(NBL_SHAPING_DPORT_DWLEN * 4) * (r))
+#define NBL_SHAPING_DVN_DPORT_ADDR  (0x504750)
+#define NBL_SHAPING_DVN_DPORT_DWLEN (4)
+#define NBL_SHAPING_DVN_DPORT_REG(r) (NBL_SHAPING_DVN_DPORT_ADDR + \
+		(NBL_SHAPING_DVN_DPORT_DWLEN * 4) * (r))
+#define NBL_SHAPING_RDMA_DPORT_ADDR  (0x5047a0)
+#define NBL_SHAPING_RDMA_DPORT_DWLEN (4)
+#define NBL_SHAPING_RDMA_DPORT_REG(r) (NBL_SHAPING_RDMA_DPORT_ADDR + \
+		(NBL_SHAPING_RDMA_DPORT_DWLEN * 4) * (r))
+#define NBL_DSCH_PSHA_EN_ADDR  (0x404314)
+#define NBL_SHAPING_NET_ADDR  (0x505800)
+#define NBL_SHAPING_NET_DWLEN (4)
+#define NBL_SHAPING_NET_REG(r) (NBL_SHAPING_NET_ADDR + \
+		(NBL_SHAPING_NET_DWLEN * 4) * (r))
+#define NBL_DSCH_VN_SHA2NET_MAP_TBL_ADDR  (0x474000)
+#define NBL_DSCH_VN_SHA2NET_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_VN_SHA2NET_MAP_TBL_REG(r) (NBL_DSCH_VN_SHA2NET_MAP_TBL_ADDR + \
+		(NBL_DSCH_VN_SHA2NET_MAP_TBL_DWLEN * 4) * (r))
+#define NBL_DSCH_VN_NET2SHA_MAP_TBL_ADDR  (0x478000)
+#define NBL_DSCH_VN_NET2SHA_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_VN_NET2SHA_MAP_TBL_REG(r) (NBL_DSCH_VN_NET2SHA_MAP_TBL_ADDR + \
+		(NBL_DSCH_VN_NET2SHA_MAP_TBL_DWLEN * 4) * (r))
+
+#define NBL_DSCH_RDMA_SHA2NET_MAP_TBL_ADDR (0x49c000)
+#define NBL_DSCH_RDMA_SHA2NET_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_RDMA_SHA2NET_MAP_TBL_REG(r) (NBL_DSCH_RDMA_SHA2NET_MAP_TBL_ADDR + \
+		(NBL_DSCH_RDMA_SHA2NET_MAP_TBL_DWLEN * 4) * (r))
+#define NBL_DSCH_RDMA_NET2SHA_MAP_TBL_ADDR (0x494000)
+#define NBL_DSCH_RDMA_NET2SHA_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_RDMA_NET2SHA_MAP_TBL_REG(r) (NBL_DSCH_RDMA_NET2SHA_MAP_TBL_ADDR + \
+		(NBL_DSCH_RDMA_NET2SHA_MAP_TBL_DWLEN * 4) * (r))
+
+/* Mailbox bar hw register offset begin */
+#define NBL_FW_HEARTBEAT_PING			0x84
+#define NBL_FW_BOARD_CONFIG			0x200
+#define NBL_FW_BOARD_DW3_OFFSET			(NBL_FW_BOARD_CONFIG + 12)
+#define NBL_FW_BOARD_DW6_OFFSET			(NBL_FW_BOARD_CONFIG + 24)
+#define NBL_ETH_REP_INFO_BASE			(1024)
+
+/* Mailbox bar hw register offset end */
+
+enum nbl_ethdev_repr_flag {
+	NBL_ETHDEV_VIRTIO_REP = 0,
+	NBL_ETHDEV_ETH_REP,
+	NBL_ETHDEV_PF_REP,
+	NBL_ETHDEV_INVALID_REP,
+};
+
+enum nbl_ped_vlan_type_e {
+	INNER_VLAN_TYPE,
+	OUTER_VLAN_TYPE,
+};
+
+enum nbl_ped_vlan_tpid_e {
+	PED_VLAN_TYPE_8100 = 0,
+	PED_VLAN_TYPE_88A8 = 1,
+	PED_VLAN_TYPE_9100 = 2,
+	PED_VLAN_TYPE_9200 = 3,
+	PED_VLAN_TYPE_NUM = 4,
+};
+
+enum nbl_error_code_e {
+	NBL_ERROR_CODE_NONE		= 0,
+	NBL_ERROR_CODE_VLAN		= 1,
+	NBL_ERROR_CODE_L3_HEAD_LEN	= 2,
+	NBL_ERROR_CODE_L3_PLD_LEN	= 3,
+	NBL_ERROR_CODE_L3_CHKSUM	= 4,
+	NBL_ERROR_CODE_L4_CHKSUM	= 5,
+	NBL_ERROR_CODE_TTL_HOPLIMT	= 6,
+	NBL_ERROR_CODE_ESP_AUTH_FAIL	= 7,
+	NBL_ERROR_CODE_ESP_BAD_FAIL	= 8,
+	NBL_ERROR_CODE_PA_RECG_FAIL	= 9,
+	NBL_ERROR_CODE_DN_SMAC		= 10,
+	NBL_ERROR_CODE_TOTAL_NUM	= 16,
+};
+
+enum nbl_epro_act_pri_e {
+	EPRO_ACT_MIRRORIDX_PRI		= 3,
+	EPRO_ACT_CARIDX_PRI		= 3,
+	EPRO_ACT_DQUEUE_PRI		= 3,
+	EPRO_ACT_DPORT_PRI		= 3,
+	EPRO_ACT_POP_IVLAN_PRI		= 3,
+	EPRO_ACT_POP_OVLAN_PRI		= 3,
+	EPRO_ACT_REPLACE_IVLAN_PRI	= 3,
+	EPRO_ACT_REPLACE_OVLAN_PRI	= 3,
+	EPRO_ACT_PUSH_IVLAN_PRI		= 3,
+	EPRO_ACT_PUSH_OVLAN_PRI		= 3,
+	EPRO_ACT_OUTER_SPORT_MDF_PRI	= 3,
+	EPRO_ACT_PRI_MDF_PRI		= 3,
+	EPRO_ACT_DP_HASH0_PRI		= 3,
+	EPRO_ACT_DP_HASH1_PRI		= 3,
+};
+
+enum nbl_epro_mirror_act_pri_e {
+	EPRO_MIRROR_ACT_CARIDX_PRI	= 3,
+	EPRO_MIRROR_ACT_DQUEUE_PRI	= 3,
+	EPRO_MIRROR_ACT_DPORT_PRI	= 3,
+};
+
+union nbl_ped_port_vlan_type_u {
+	struct ped_port_vlan_type {
+		u32 o_vlan_sel:2;
+		u32 i_vlan_sel:2;
+		u32 rsv:28;
+	} __packed info;
+#define NBL_PED_PORT_VLAN_TYPE_TABLE_WIDTH (sizeof(struct ped_port_vlan_type) \
+		/ sizeof(u32))
+	u32 data[NBL_PED_PORT_VLAN_TYPE_TABLE_WIDTH];
+};
+
+#define NBL_ACL_ACTION_RAM_TBL(r, i)	(NBL_ACL_BASE + 0x00002000 + 0x2000 * (r) + \
+		(NBL_ACL_ACTION_RAM0_DWLEN * 4 * (i)))
+#define NBL_DPED_MIR_CMD_0_TABLE(t)		(NBL_DPED_MIR_CMD_00_ADDR + \
+		(NBL_DPED_MIR_CMD_00_DWLEN * 2 * (t)))
+#define NBL_SET_DPORT(upcall_flag, nxtstg_sel, port_type, port_id) \
+	((upcall_flag) << 14 | (nxtstg_sel) << 12 | (port_type) << 10 | (port_id))
+
+#define MAX_RSS_LEN (100)
+#define  NBL_RSS_FUNC_TYPE       "rss_func_type="
+enum rss_func_type {
+	NBL_SYM_TOEPLITZ_INT = 0,
+	NBL_XOR_INT,
+	NBL_INVALID_FUNC_TYPE
+};
+
+#define  NBL_XOR                 "xor"
+#define  NBL_SYM_TOEPLITZ        "sym_toeplitz"
+#define  NBL_RSS_KEY_TYPE        "rss_key_type"
+
+enum rss_field_type {
+	NBL_KEY_IPV4_L3_INT = 0,
+	NBL_KEY_IPV4_L4_INT,
+	NBL_KEY_IPV6_L3_INT,
+	NBL_KEY_IPV6_L4_INT,
+	NBL_KEY_AUTO,
+};
+
+#define  NBL_KEY_IPV4_L3	"ipv4"
+#define  NBL_KEY_IPV4_L4	"ipv4_l4"
+#define  NBL_KEY_IPV6_L3	"ipv6"
+#define  NBL_KEY_IPV6_L4	"ipv6_l4"
+
+#define RSS_SPLIT_STR_NUM 2
+#define NBL_KEY_IP4_L4_RSS_BIT 1
+#define NBL_KEY_IP6_L4_RSS_BIT 2
+
+union nbl_fw_board_cfg_dw3 {
+	struct board_cfg_dw3 {
+		u32 port_type:1;
+		u32 port_num:7;
+		u32 port_speed:2;
+		u32 gpio_type:3;
+		u32 p4_version:1; /* 0: low version; 1: high version */
+		u32 rsv:18;
+	} __packed info;
+	u32 data;
+};
+
+union nbl_fw_board_cfg_dw6 {
+	struct board_cfg_dw6 {
+		u8 lane_bitmap;
+		u8 eth_bitmap;
+		u16 rsv;
+	} __packed info;
+	u32 data;
+};
+
+#define NBL_LEONIS_QUIRKS_OFFSET	(0x00000140)
+
+#define NBL_LEONIS_ILLEGAL_REG_VALUE	(0xDEADBEEF)
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
new file mode 100644
index 000000000000..3f11f60643fa
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_HW_REG_H_
+#define _NBL_HW_REG_H_
+
+#include "nbl_core.h"
+
+#define NBL_HW_MGT_TO_COMMON(hw_mgt)		((hw_mgt)->common)
+#define NBL_HW_MGT_TO_DEV(hw_mgt)		NBL_COMMON_TO_DEV(NBL_HW_MGT_TO_COMMON(hw_mgt))
+#define NBL_MEMORY_BAR				(0)
+#define NBL_MAILBOX_BAR				(2)
+#define NBL_RDMA_NOTIFY_OFF			(8192)
+
+struct nbl_hw_mgt {
+	struct nbl_common_info *common;
+	u8 __iomem *hw_addr;
+	u8 __iomem *mailbox_bar_hw_addr;
+	u64 notify_offset;
+	u32 version;
+	u32 hw_size;
+	spinlock_t reg_lock;  /* Protect reg access */
+	bool should_lock;
+	u8 resv[3];
+	enum nbl_hw_status hw_status;
+};
+
+#define NBL_DELAY_MIN_TIME_FOR_REGS		400 /* 200us for palladium,3us for s2c */
+#define NBL_DELAY_MAX_TIME_FOR_REGS		500 /* 300us for palladium,5us for s2c */
+
+static inline __maybe_unused u32 rd32(u8 __iomem *addr, u64 reg)
+{
+	return readl(addr + (reg));
+}
+
+static inline __maybe_unused void wr32_barrier(u8 __iomem *addr, u64 reg, u32 value)
+{
+	writel((value), (addr + (reg)));
+}
+
+static inline __maybe_unused void nbl_hw_read_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+						   u8 *data, u32 len)
+{
+	u32 size = len / 4;
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	if (hw_mgt->hw_status) {
+		for (i = 0; i < size; i++)
+			*(u32 *)(data + i * sizeof(u32)) = U32_MAX;
+	}
+
+	if (size > 1 && hw_mgt->should_lock)
+		spin_lock(&hw_mgt->reg_lock);
+
+	for (i = 0; i < size; i++)
+		*(u32 *)(data + i * sizeof(u32)) = rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
+
+	if (size > 1 && hw_mgt->should_lock)
+		spin_unlock(&hw_mgt->reg_lock);
+}
+
+static inline __maybe_unused void nbl_hw_write_regs(struct nbl_hw_mgt *hw_mgt,
+						    u64 reg, const u8 *data, u32 len)
+{
+	u32 size = len / 4;
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	if (hw_mgt->hw_status)
+		return;
+
+	if (size > 1 && hw_mgt->should_lock)
+		spin_lock(&hw_mgt->reg_lock);
+
+	for (i = 0; i < size; i++)
+		/* Used for emu, make sure that we won't write too frequently */
+		wr32_barrier(hw_mgt->hw_addr, reg + i * sizeof(u32),
+			     *(u32 *)(data + i * sizeof(u32)));
+
+	if (size > 1 && hw_mgt->should_lock)
+		spin_unlock(&hw_mgt->reg_lock);
+}
+
+static inline __maybe_unused void nbl_hw_write_be_regs(struct nbl_hw_mgt *hw_mgt,
+						       u64 reg, const u8 *data, u32 len)
+{
+	u32 size = len / 4;
+	u32 i = 0;
+	u32 data_le;
+
+	if (len % 4)
+		return;
+
+	if (size > 1 && hw_mgt->should_lock)
+		spin_lock(&hw_mgt->reg_lock);
+
+	for (i = 0; i < size; i++) {
+		data_le = swab32(*(u32 *)(data + i * sizeof(u32)));
+		/* Used for emu, make sure that we won't write too frequently */
+		wr32_barrier(hw_mgt->hw_addr, reg + i * sizeof(u32), data_le);
+	}
+
+	data_le = rd32(hw_mgt->hw_addr, 0x0);
+	if (size > 1 && hw_mgt->should_lock)
+		spin_unlock(&hw_mgt->reg_lock);
+}
+
+static __maybe_unused void nbl_hw_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
+{
+	if (hw_mgt->hw_status)
+		return;
+
+	/* Used for emu, make sure that we won't write too frequently */
+	wr32_barrier(hw_mgt->hw_addr, reg, value);
+}
+
+static __maybe_unused u32 nbl_hw_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	if (hw_mgt->hw_status)
+		return U32_MAX;
+
+	return rd32(hw_mgt->hw_addr, reg);
+}
+
+static __maybe_unused void nbl_mbx_wr32(void *priv, u64 reg, u32 value)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	if (hw_mgt->hw_status)
+		return;
+
+	writel((value), ((hw_mgt)->mailbox_bar_hw_addr + (reg)));
+}
+
+static __maybe_unused u32 nbl_mbx_rd32(void *priv, u64 reg)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	if (hw_mgt->hw_status)
+		return U32_MAX;
+
+	return readl((hw_mgt)->mailbox_bar_hw_addr + (reg));
+}
+
+static __maybe_unused void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt,
+						u64 reg, u8 *data, u32 len)
+{
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		*(u32 *)(data + i * sizeof(u32)) = nbl_mbx_rd32(hw_mgt, reg + i * sizeof(u32));
+}
+
+static __maybe_unused void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt,
+						 u64 reg, const u8 *data, u32 len)
+{
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		/* Used for emu, make sure that we won't write too frequently */
+		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32),
+			     *(u32 *)(data + i * sizeof(u32)));
+}
+
+/* Mgt structure for each product.
+ * Every indivisual mgt must have the common mgt as its first member, and contains its unique
+ * data structure in the reset of it.
+ */
+struct nbl_hw_mgt_leonis {
+	struct nbl_hw_mgt hw_mgt;
+	bool ro_enable;
+};
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
new file mode 100644
index 000000000000..f3ec609e2ffa
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_HW_H_
+#define _NBL_DEF_HW_H_
+
+#include "nbl_include.h"
+
+#define NBL_HW_OPS_TBL_TO_OPS(hw_ops_tbl)		((hw_ops_tbl)->ops)
+#define NBL_HW_OPS_TBL_TO_PRIV(hw_ops_tbl)		((hw_ops_tbl)->priv)
+
+struct nbl_hw_ops {
+};
+
+struct nbl_hw_ops_tbl {
+	struct nbl_hw_ops *ops;
+	void *priv;
+};
+
+int nbl_hw_init_leonis(void *p, struct nbl_init_param *param);
+void nbl_hw_remove_leonis(void *p);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 0bceb682b824..f9430d894b04 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -53,6 +53,12 @@ enum nbl_product_type {
 	NBL_PRODUCT_MAX,
 };
 
+enum nbl_hw_status {
+	NBL_HW_NOMAL,
+	NBL_HW_FATAL_ERR, /* Most hw module is not work nomal exclude pcie/emp */
+	NBL_HW_STATUS_MAX,
+};
+
 struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
@@ -69,4 +75,62 @@ struct nbl_init_param {
 	bool pci_using_dac;
 };
 
+struct nbl_vnet_queue_info_param {
+	u32 function_id;
+	u32 device_id;
+	u32 bus_id;
+	u32 msix_idx;
+	u32 msix_idx_valid;
+	u32 valid;
+};
+
+struct nbl_ustore_stats {
+	u64 rx_drop_packets;
+	u64 rx_trun_packets;
+};
+
+struct nbl_notify_param {
+	u16 notify_qid;
+	u16 tail_ptr;
+};
+
+enum nbl_port_mode {
+	NBL_PORT_NRZ_NORSFEC,
+	NBL_PORT_NRZ_544,
+	NBL_PORT_NRZ_528,
+	NBL_PORT_PAM4_544,
+	NBL_PORT_MODE_MAX,
+};
+
+#define NBL_ACL_TCAM_KEY_LEN				5
+#define NBL_ACL_TCAM_KEY_MAX				16
+
+struct nbl_acl_tcam_key_param {
+	u8 data[NBL_ACL_TCAM_KEY_LEN];
+} __packed;
+
+struct nbl_acl_tcam_param {
+	union nbl_acl_tcam_info {
+		struct nbl_acl_tcam_key_param key[NBL_ACL_TCAM_KEY_MAX];
+		u8 data[NBL_ACL_TCAM_KEY_LEN * NBL_ACL_TCAM_KEY_MAX];
+	} info;
+	u8 len;
+};
+
+enum nbl_abnormal_event_module {
+	NBL_ABNORMAL_EVENT_DVN = 0,
+	NBL_ABNORMAL_EVENT_UVN,
+	NBL_ABNORMAL_EVENT_MAX,
+};
+
+struct nbl_abnormal_details {
+	bool abnormal;
+	u16 qid;
+	u16 vsi_id;
+};
+
+struct nbl_abnormal_event_info {
+	struct nbl_abnormal_details details[NBL_ABNORMAL_EVENT_MAX];
+	u32 other_abnormal_info;
+};
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index b690bac3d306..f7669d361ef4 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -9,8 +9,8 @@
 
 static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
 	{
-		.hw_init	= NULL,
-		.hw_remove	= NULL,
+		.hw_init	= nbl_hw_init_leonis,
+		.hw_remove	= nbl_hw_remove_leonis,
 		.res_init	= NULL,
 		.res_remove	= NULL,
 		.chan_init	= NULL,
@@ -30,6 +30,7 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev, struct nbl_init_param *p
 	struct nbl_adapter *adapter;
 	struct nbl_common_info *common;
 	struct nbl_product_base_ops *product_base_ops;
+	int ret = 0;
 
 	if (!pdev)
 		return NULL;
@@ -57,7 +58,15 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev, struct nbl_init_param *p
 
 	nbl_core_setup_product_ops(adapter, param, &product_base_ops);
 
+	/* every product's hw/chan/res layer has a great difference, so call their own init ops */
+	ret = product_base_ops->hw_init(adapter, param);
+	if (ret)
+		goto hw_init_fail;
+
 	return adapter;
+hw_init_fail:
+	devm_kfree(&pdev->dev, adapter);
+	return NULL;
 }
 
 void nbl_core_remove(struct nbl_adapter *adapter)
@@ -71,6 +80,7 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 	dev = NBL_ADAPTER_TO_DEV(adapter);
 	product_base_ops = NBL_ADAPTER_TO_RPDUCT_BASE_OPS(adapter);
+	product_base_ops->hw_remove(adapter);
 	devm_kfree(dev, adapter);
 }
 
-- 
2.43.0


