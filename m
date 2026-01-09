Return-Path: <netdev+bounces-248435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8372D0871B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 865CE303AC13
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87635338918;
	Fri,  9 Jan 2026 10:03:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-27.us.a.mail.aliyun.com (out198-27.us.a.mail.aliyun.com [47.90.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AD338586;
	Fri,  9 Jan 2026 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953002; cv=none; b=IvcC7/Mdq9K685THURb6Mr9yCXlveJn5rz1u83X7yqmd1QdrnSNyFh91siMvC1ymsJFa1jfcXTiqyNo29Ey2hWz0MGsjq72N9sL+A3a7z/qHYHKjJ460237wCOjlS/OLPogbAcdp4wogiWlsQ/nlfs+d2UkSfPWOe39mp+SWj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953002; c=relaxed/simple;
	bh=Mv3HB9OQNLNBiiWIFEZZ0jbsaiJ1sZp6y9W3h98zO30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUFpLTOyAcTmPVweDXsiUiXJwAEGDQoAS4ndj+GXnPOmmyGQXXTswCQUzILrP6o2CF4IukiRZEwgksUvxHsOAEryC9/VrDVbjuMPC7vphEkURWD+sJwpTr01zkO66vGwXfcxHkqrBqQJyezt84j0avZvZSdKsNWjUDCKnHKks8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQAbP_1767952949 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:30 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 net-next 04/15] net/nebula-matrix: add machine-generated headers and chip definitions
Date: Fri,  9 Jan 2026 18:01:22 +0800
Message-ID: <20260109100146.63569-5-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

1. nbl_hw_leonis/base/* are machine generated headers
2. nbl_hw.h/nbl_hw_leonis.h
	chip-related reg definitions
3. nbl_hw_leonis_regs.c
	P4 configuration that will be invoked during chip initialization

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw.h         |  172 +
 .../nbl_hw/nbl_hw_leonis/base/nbl_datapath.h  |   11 +
 .../nbl_hw_leonis/base/nbl_datapath_dped.h    | 2152 +++++++++
 .../nbl_hw_leonis/base/nbl_datapath_dstore.h  |  929 ++++
 .../nbl_hw_leonis/base/nbl_datapath_ucar.h    |  414 ++
 .../nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h   |   10 +
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h  |  665 +++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h  | 1397 ++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  | 1701 ++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c | 3863 +++++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h |   12 +
 12 files changed, 11327 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index d5cadc289366..f5c1f8030beb 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_NBL_CORE) := nbl_core.o
 
 nbl_core-objs +=      nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_main.o
 
 # Provide include files
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
new file mode 100644
index 000000000000..b88bc1db6162
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
@@ -0,0 +1,172 @@
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
+			/* port_type = SET_DPORT_TYPE_ETH_LAG, set the eth and
+			 * lag field.
+			 */
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
+			/* port_type = SET_DPORT_TYPE_ETH_LAG,
+			 * set the eth and lag field.
+			 */
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
+			/* port_type = SET_DPORT_TYPE_VSI_HOST and
+			 * SET_DPORT_TYPE_VSI_ECPU,
+			 * set the port_id field as the vsi_id.
+			 * port_type = SET_DPORT_TYPE_SP_PORT, set the port_id
+			 * as the defined PORT_TYPE_SP_*.
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
+#define NBL_SPORT_ETH_OFFSET				8
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath.h
new file mode 100644
index 000000000000..87a0f432cbd5
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#include "nbl_datapath_ucar.h"
+#include "nbl_datapath_dped.h"
+#include "nbl_datapath_dstore.h"
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h
new file mode 100644
index 000000000000..2715ce4ae32a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h
@@ -0,0 +1,2152 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+ // Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_DPED_H
+#define NBL_DPED_H 1
+
+#include <linux/types.h>
+
+#define NBL_DPED_BASE (0x0075C000)
+
+#define NBL_DPED_INT_STATUS_ADDR  (0x75c000)
+#define NBL_DPED_INT_STATUS_DEPTH (1)
+#define NBL_DPED_INT_STATUS_WIDTH (32)
+#define NBL_DPED_INT_STATUS_DWLEN (1)
+union dped_int_status_u {
+	struct dped_int_status {
+		u32 pkt_length_err:1;    /* [0] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 fsm_err:1;           /* [3] Default:0x0 RWC */
+		u32 cif_err:1;           /* [4] Default:0x0 RWC */
+		u32 input_err:1;         /* [5] Default:0x0 RWC */
+		u32 cfg_err:1;           /* [6] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [7] Default:0x0 RWC */
+		u32 inmeta_ucor_err:1;   /* [8] Default:0x0 RWC */
+		u32 meta_ucor_err:1;     /* [9] Default:0x0 RWC */
+		u32 meta_cor_ecc_err:1;  /* [10] Default:0x0 RWC */
+		u32 fwd_atid_nomat_err:1; /* [11] Default:0x0 RWC */
+		u32 meta_value_err:1;    /* [12] Default:0x0 RWC */
+		u32 edit_atnum_err:1;    /* [13] Default:0x0 RWC */
+		u32 header_oft_ovf:1;    /* [14] Default:0x0 RWC */
+		u32 edit_pos_err:1;      /* [15] Default:0x0 RWC */
+		u32 da_oft_len_ovf:1;    /* [16] Default:0x0 RWC */
+		u32 lxoffset_ovf:1;      /* [17] Default:0x0 RWC */
+		u32 add_head_ovf:1;      /* [18] Default:0x0 RWC */
+		u32 rsv:13;              /* [31:19] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_DPED_INT_MASK_ADDR  (0x75c004)
+#define NBL_DPED_INT_MASK_DEPTH (1)
+#define NBL_DPED_INT_MASK_WIDTH (32)
+#define NBL_DPED_INT_MASK_DWLEN (1)
+union dped_int_mask_u {
+	struct dped_int_mask {
+		u32 pkt_length_err:1;    /* [0] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RW */
+		u32 fsm_err:1;           /* [3] Default:0x0 RW */
+		u32 cif_err:1;           /* [4] Default:0x0 RW */
+		u32 input_err:1;         /* [5] Default:0x0 RW */
+		u32 cfg_err:1;           /* [6] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [7] Default:0x0 RW */
+		u32 inmeta_ucor_err:1;   /* [8] Default:0x0 RW */
+		u32 meta_ucor_err:1;     /* [9] Default:0x0 RW */
+		u32 meta_cor_ecc_err:1;  /* [10] Default:0x0 RW */
+		u32 fwd_atid_nomat_err:1; /* [11] Default:0x1 RW */
+		u32 meta_value_err:1;    /* [12] Default:0x0 RW */
+		u32 edit_atnum_err:1;    /* [13] Default:0x0 RW */
+		u32 header_oft_ovf:1;    /* [14] Default:0x0 RW */
+		u32 edit_pos_err:1;      /* [15] Default:0x0 RW */
+		u32 da_oft_len_ovf:1;    /* [16] Default:0x0 RW */
+		u32 lxoffset_ovf:1;      /* [17] Default:0x0 RW */
+		u32 add_head_ovf:1;      /* [18] Default:0x0 RW */
+		u32 rsv:13;              /* [31:19] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_DPED_INT_SET_ADDR  (0x75c008)
+#define NBL_DPED_INT_SET_DEPTH (1)
+#define NBL_DPED_INT_SET_WIDTH (32)
+#define NBL_DPED_INT_SET_DWLEN (1)
+union dped_int_set_u {
+	struct dped_int_set {
+		u32 pkt_length_err:1;    /* [0] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 WO */
+		u32 fsm_err:1;           /* [3] Default:0x0 WO */
+		u32 cif_err:1;           /* [4] Default:0x0 WO */
+		u32 input_err:1;         /* [5] Default:0x0 WO */
+		u32 cfg_err:1;           /* [6] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [7] Default:0x0 WO */
+		u32 inmeta_ucor_err:1;   /* [8] Default:0x0 WO */
+		u32 meta_ucor_err:1;     /* [9] Default:0x0 WO */
+		u32 meta_cor_ecc_err:1;  /* [10] Default:0x0 WO */
+		u32 fwd_atid_nomat_err:1; /* [11] Default:0x0 WO */
+		u32 meta_value_err:1;    /* [12] Default:0x0 WO */
+		u32 edit_atnum_err:1;    /* [13] Default:0x0 WO */
+		u32 header_oft_ovf:1;    /* [14] Default:0x0 WO */
+		u32 edit_pos_err:1;      /* [15] Default:0x0 WO */
+		u32 da_oft_len_ovf:1;    /* [16] Default:0x0 WO */
+		u32 lxoffset_ovf:1;      /* [17] Default:0x0 WO */
+		u32 add_head_ovf:1;      /* [18] Default:0x0 WO */
+		u32 rsv:13;              /* [31:19] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_DPED_INIT_DONE_ADDR  (0x75c00c)
+#define NBL_DPED_INIT_DONE_DEPTH (1)
+#define NBL_DPED_INIT_DONE_WIDTH (32)
+#define NBL_DPED_INIT_DONE_DWLEN (1)
+union dped_init_done_u {
+	struct dped_init_done {
+		u32 done:1;              /* [00:00] Default:0x0 RO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_DPED_PKT_LENGTH_ERR_INFO_ADDR  (0x75c020)
+#define NBL_DPED_PKT_LENGTH_ERR_INFO_DEPTH (1)
+#define NBL_DPED_PKT_LENGTH_ERR_INFO_WIDTH (32)
+#define NBL_DPED_PKT_LENGTH_ERR_INFO_DWLEN (1)
+union dped_pkt_length_err_info_u {
+	struct dped_pkt_length_err_info {
+		u32 ptr_eop:1;           /* [0] Default:0x0 RC */
+		u32 pkt_eop:1;           /* [1] Default:0x0 RC */
+		u32 pkt_mod:1;           /* [2] Default:0x0 RC */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_PKT_LENGTH_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_CIF_ERR_INFO_ADDR  (0x75c040)
+#define NBL_DPED_CIF_ERR_INFO_DEPTH (1)
+#define NBL_DPED_CIF_ERR_INFO_WIDTH (32)
+#define NBL_DPED_CIF_ERR_INFO_DWLEN (1)
+union dped_cif_err_info_u {
+	struct dped_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_INPUT_ERR_INFO_ADDR  (0x75c048)
+#define NBL_DPED_INPUT_ERR_INFO_DEPTH (1)
+#define NBL_DPED_INPUT_ERR_INFO_WIDTH (32)
+#define NBL_DPED_INPUT_ERR_INFO_DWLEN (1)
+union dped_input_err_info_u {
+	struct dped_input_err_info {
+		u32 eoc_miss:1;          /* [0] Default:0x0 RC */
+		u32 soc_miss:1;          /* [1] Default:0x0 RC */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INPUT_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_CFG_ERR_INFO_ADDR  (0x75c050)
+#define NBL_DPED_CFG_ERR_INFO_DEPTH (1)
+#define NBL_DPED_CFG_ERR_INFO_WIDTH (32)
+#define NBL_DPED_CFG_ERR_INFO_DWLEN (1)
+union dped_cfg_err_info_u {
+	struct dped_cfg_err_info {
+		u32 length:1;            /* [0] Default:0x0 RC */
+		u32 rd_conflict:1;       /* [1] Default:0x0 RC */
+		u32 rd_addr:8;           /* [9:2] Default:0x0 RC */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_ATID_NOMAT_ERR_INFO_ADDR  (0x75c06c)
+#define NBL_DPED_FWD_ATID_NOMAT_ERR_INFO_DEPTH (1)
+#define NBL_DPED_FWD_ATID_NOMAT_ERR_INFO_WIDTH (32)
+#define NBL_DPED_FWD_ATID_NOMAT_ERR_INFO_DWLEN (1)
+union dped_fwd_atid_nomat_err_info_u {
+	struct dped_fwd_atid_nomat_err_info {
+		u32 dport:1;             /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_ATID_NOMAT_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_META_VALUE_ERR_INFO_ADDR  (0x75c070)
+#define NBL_DPED_META_VALUE_ERR_INFO_DEPTH (1)
+#define NBL_DPED_META_VALUE_ERR_INFO_WIDTH (32)
+#define NBL_DPED_META_VALUE_ERR_INFO_DWLEN (1)
+union dped_meta_value_err_info_u {
+	struct dped_meta_value_err_info {
+		u32 sport:1;             /* [0] Default:0x0 RC */
+		u32 dport:1;             /* [1] Default:0x0 RC */
+		u32 dscp_ecn:1;          /* [2] Default:0x0 RC */
+		u32 tnl:1;               /* [3] Default:0x0 RC */
+		u32 vni:1;               /* [4] Default:0x0 RC */
+		u32 vni_one:1;           /* [5] Default:0x0 RC */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_META_VALUE_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_EDIT_ATNUM_ERR_INFO_ADDR  (0x75c078)
+#define NBL_DPED_EDIT_ATNUM_ERR_INFO_DEPTH (1)
+#define NBL_DPED_EDIT_ATNUM_ERR_INFO_WIDTH (32)
+#define NBL_DPED_EDIT_ATNUM_ERR_INFO_DWLEN (1)
+union dped_edit_atnum_err_info_u {
+	struct dped_edit_atnum_err_info {
+		u32 replace:1;           /* [0] Default:0x0 RC */
+		u32 del_add:1;           /* [1] Default:0x0 RC */
+		u32 ttl:1;               /* [2] Default:0x0 RC */
+		u32 dscp:1;              /* [3] Default:0x0 RC */
+		u32 tnl:1;               /* [4] Default:0x0 RC */
+		u32 sport:1;             /* [5] Default:0x0 RC */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_EDIT_ATNUM_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_HEADER_OFT_OVF_ADDR  (0x75c080)
+#define NBL_DPED_HEADER_OFT_OVF_DEPTH (1)
+#define NBL_DPED_HEADER_OFT_OVF_WIDTH (32)
+#define NBL_DPED_HEADER_OFT_OVF_DWLEN (1)
+union dped_header_oft_ovf_u {
+	struct dped_header_oft_ovf {
+		u32 replace:1;           /* [0] Default:0x0 RC */
+		u32 rsv2:7;              /* [7:1] Default:0x0 RO */
+		u32 add_del:6;           /* [13:8] Default:0x0 RC */
+		u32 dscp_ecn:1;          /* [14] Default:0x0 RC */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 ttl:1;               /* [16] Default:0x0 RC */
+		u32 sctp:1;              /* [17] Default:0x0 RC */
+		u32 dscp:1;              /* [18] Default:0x0 RC */
+		u32 pri:1;               /* [19] Default:0x0 RC */
+		u32 len0:1;              /* [20] Default:0x0 RC */
+		u32 len1:1;              /* [21] Default:0x0 RC */
+		u32 ck0:1;               /* [22] Default:0x0 RC */
+		u32 ck1:1;               /* [23] Default:0x0 RC */
+		u32 ck_start0_0:1;       /* [24] Default:0x0 RC */
+		u32 ck_start0_1:1;       /* [25] Default:0x0 RC */
+		u32 ck_start1_0:1;       /* [26] Default:0x0 RC */
+		u32 ck_start1_1:1;       /* [27] Default:0x0 RC */
+		u32 head:1;              /* [28] Default:0x0 RC */
+		u32 ck_len0:1;           /* [29] Default:0x0 RC */
+		u32 ck_len1:1;           /* [30] Default:0x0 RC */
+		u32 rsv:1;               /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HEADER_OFT_OVF_DWLEN];
+} __packed;
+
+#define NBL_DPED_EDIT_POS_ERR_ADDR  (0x75c088)
+#define NBL_DPED_EDIT_POS_ERR_DEPTH (1)
+#define NBL_DPED_EDIT_POS_ERR_WIDTH (32)
+#define NBL_DPED_EDIT_POS_ERR_DWLEN (1)
+union dped_edit_pos_err_u {
+	struct dped_edit_pos_err {
+		u32 replace:1;           /* [0] Default:0x0 RC */
+		u32 cross_level:6;       /* [6:1] Default:0x0 RC */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 add_del:6;           /* [13:8] Default:0x0 RC */
+		u32 dscp_ecn:1;          /* [14] Default:0x0 RC */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 ttl:1;               /* [16] Default:0x0 RC */
+		u32 sctp:1;              /* [17] Default:0x0 RC */
+		u32 dscp:1;              /* [18] Default:0x0 RC */
+		u32 pri:1;               /* [19] Default:0x0 RC */
+		u32 len0:1;              /* [20] Default:0x0 RC */
+		u32 len1:1;              /* [21] Default:0x0 RC */
+		u32 ck0:1;               /* [22] Default:0x0 RC */
+		u32 ck1:1;               /* [23] Default:0x0 RC */
+		u32 ck_start0_0:1;       /* [24] Default:0x0 RC */
+		u32 ck_start0_1:1;       /* [25] Default:0x0 RC */
+		u32 ck_start1_0:1;       /* [26] Default:0x0 RC */
+		u32 ck_start1_1:1;       /* [27] Default:0x0 RC */
+		u32 ck_len0:1;           /* [28] Default:0x0 RC */
+		u32 ck_len1:1;           /* [29] Default:0x0 RC */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_EDIT_POS_ERR_DWLEN];
+} __packed;
+
+#define NBL_DPED_DA_OFT_LEN_OVF_ADDR  (0x75c090)
+#define NBL_DPED_DA_OFT_LEN_OVF_DEPTH (1)
+#define NBL_DPED_DA_OFT_LEN_OVF_WIDTH (32)
+#define NBL_DPED_DA_OFT_LEN_OVF_DWLEN (1)
+union dped_da_oft_len_ovf_u {
+	struct dped_da_oft_len_ovf {
+		u32 at0:5;               /* [4:0] Default:0x0 RC */
+		u32 at1:5;               /* [9:5] Default:0x0 RC */
+		u32 at2:5;               /* [14:10] Default:0x0 RC */
+		u32 at3:5;               /* [19:15] Default:0x0 RC */
+		u32 at4:5;               /* [24:20] Default:0x0 RC */
+		u32 at5:5;               /* [29:25] Default:0x0 RC */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_DA_OFT_LEN_OVF_DWLEN];
+} __packed;
+
+#define NBL_DPED_LXOFFSET_OVF_ADDR  (0x75c098)
+#define NBL_DPED_LXOFFSET_OVF_DEPTH (1)
+#define NBL_DPED_LXOFFSET_OVF_WIDTH (32)
+#define NBL_DPED_LXOFFSET_OVF_DWLEN (1)
+union dped_lxoffset_ovf_u {
+	struct dped_lxoffset_ovf {
+		u32 l2:1;                /* [0] Default:0x0 RC */
+		u32 l3:1;                /* [1] Default:0x0 RC */
+		u32 l4:1;                /* [2] Default:0x0 RC */
+		u32 pld:1;               /* [3] Default:0x0 RC */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_LXOFFSET_OVF_DWLEN];
+} __packed;
+
+#define NBL_DPED_ADD_HEAD_OVF_ADDR  (0x75c0a0)
+#define NBL_DPED_ADD_HEAD_OVF_DEPTH (1)
+#define NBL_DPED_ADD_HEAD_OVF_WIDTH (32)
+#define NBL_DPED_ADD_HEAD_OVF_DWLEN (1)
+union dped_add_head_ovf_u {
+	struct dped_add_head_ovf {
+		u32 tnl_l2:1;            /* [0] Default:0x0 RC */
+		u32 tnl_pkt:1;           /* [1] Default:0x0 RC */
+		u32 rsv1:14;             /* [15:2] Default:0x0 RO */
+		u32 mir_l2:1;            /* [16] Default:0x0 RC */
+		u32 mir_pkt:1;           /* [17] Default:0x0 RC */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_ADD_HEAD_OVF_DWLEN];
+} __packed;
+
+#define NBL_DPED_CAR_CTRL_ADDR  (0x75c100)
+#define NBL_DPED_CAR_CTRL_DEPTH (1)
+#define NBL_DPED_CAR_CTRL_WIDTH (32)
+#define NBL_DPED_CAR_CTRL_DWLEN (1)
+union dped_car_ctrl_u {
+	struct dped_car_ctrl {
+		u32 sctr_car:1;          /* [00:00] Default:0x1 RW */
+		u32 rctr_car:1;          /* [01:01] Default:0x1 RW */
+		u32 rc_car:1;            /* [02:02] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [03:03] Default:0x1 RW */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_DPED_INIT_START_ADDR  (0x75c10c)
+#define NBL_DPED_INIT_START_DEPTH (1)
+#define NBL_DPED_INIT_START_WIDTH (32)
+#define NBL_DPED_INIT_START_DWLEN (1)
+union dped_init_start_u {
+	struct dped_init_start {
+		u32 start:1;             /* [00:00] Default:0x0 WO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_DPED_TIMEOUT_CFG_ADDR  (0x75c110)
+#define NBL_DPED_TIMEOUT_CFG_DEPTH (1)
+#define NBL_DPED_TIMEOUT_CFG_WIDTH (32)
+#define NBL_DPED_TIMEOUT_CFG_DWLEN (1)
+union dped_timeout_cfg_u {
+	struct dped_timeout_cfg {
+		u32 fsm_max_num:16;      /* [15:00] Default:0xfff RW */
+		u32 tab:8;               /* [23:16] Default:0x40 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TIMEOUT_CFG_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_MAX_LENGTH_ADDR  (0x75c154)
+#define NBL_DPED_TNL_MAX_LENGTH_DEPTH (1)
+#define NBL_DPED_TNL_MAX_LENGTH_WIDTH (32)
+#define NBL_DPED_TNL_MAX_LENGTH_DWLEN (1)
+union dped_tnl_max_length_u {
+	struct dped_tnl_max_length {
+		u32 th:7;                /* [6:0] Default:0x5A RW */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_MAX_LENGTH_DWLEN];
+} __packed;
+
+#define NBL_DPED_PKT_DROP_EN_ADDR  (0x75c170)
+#define NBL_DPED_PKT_DROP_EN_DEPTH (1)
+#define NBL_DPED_PKT_DROP_EN_WIDTH (32)
+#define NBL_DPED_PKT_DROP_EN_DWLEN (1)
+union dped_pkt_drop_en_u {
+	struct dped_pkt_drop_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_PKT_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_PKT_HERR_DROP_EN_ADDR  (0x75c174)
+#define NBL_DPED_PKT_HERR_DROP_EN_DEPTH (1)
+#define NBL_DPED_PKT_HERR_DROP_EN_WIDTH (32)
+#define NBL_DPED_PKT_HERR_DROP_EN_DWLEN (1)
+union dped_pkt_herr_drop_en_u {
+	struct dped_pkt_herr_drop_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_PKT_HERR_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_PKT_PARITY_DROP_EN_ADDR  (0x75c178)
+#define NBL_DPED_PKT_PARITY_DROP_EN_DEPTH (1)
+#define NBL_DPED_PKT_PARITY_DROP_EN_WIDTH (32)
+#define NBL_DPED_PKT_PARITY_DROP_EN_DWLEN (1)
+union dped_pkt_parity_drop_en_u {
+	struct dped_pkt_parity_drop_en {
+		u32 en0:1;               /* [0] Default:0x1 RW */
+		u32 en1:1;               /* [1] Default:0x1 RW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_PKT_PARITY_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_TTL_DROP_EN_ADDR  (0x75c17c)
+#define NBL_DPED_TTL_DROP_EN_DEPTH (1)
+#define NBL_DPED_TTL_DROP_EN_WIDTH (32)
+#define NBL_DPED_TTL_DROP_EN_DWLEN (1)
+union dped_ttl_drop_en_u {
+	struct dped_ttl_drop_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TTL_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_TTL_ERROR_CODE_ADDR  (0x75c188)
+#define NBL_DPED_TTL_ERROR_CODE_DEPTH (1)
+#define NBL_DPED_TTL_ERROR_CODE_WIDTH (32)
+#define NBL_DPED_TTL_ERROR_CODE_DWLEN (1)
+union dped_ttl_error_code_u {
+	struct dped_ttl_error_code {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv1:7;              /* [7:1] Default:0x0 RO */
+		u32 id:4;                /* [11:8] Default:0x6 RW */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TTL_ERROR_CODE_DWLEN];
+} __packed;
+
+#define NBL_DPED_HIGH_PRI_PKT_EN_ADDR  (0x75c190)
+#define NBL_DPED_HIGH_PRI_PKT_EN_DEPTH (1)
+#define NBL_DPED_HIGH_PRI_PKT_EN_WIDTH (32)
+#define NBL_DPED_HIGH_PRI_PKT_EN_DWLEN (1)
+union dped_high_pri_pkt_en_u {
+	struct dped_high_pri_pkt_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HIGH_PRI_PKT_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_PADDING_CFG_ADDR  (0x75c194)
+#define NBL_DPED_PADDING_CFG_DEPTH (1)
+#define NBL_DPED_PADDING_CFG_WIDTH (32)
+#define NBL_DPED_PADDING_CFG_DWLEN (1)
+union dped_padding_cfg_u {
+	struct dped_padding_cfg {
+		u32 th:6;                /* [5:0] Default:0x3B RW */
+		u32 rsv1:2;              /* [7:6] Default:0x0 RO */
+		u32 mode:2;              /* [9:8] Default:0x0 RW */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_PADDING_CFG_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDIT_FLAG_SEL0_ADDR  (0x75c204)
+#define NBL_DPED_HW_EDIT_FLAG_SEL0_DEPTH (1)
+#define NBL_DPED_HW_EDIT_FLAG_SEL0_WIDTH (32)
+#define NBL_DPED_HW_EDIT_FLAG_SEL0_DWLEN (1)
+union dped_hw_edit_flag_sel0_u {
+	struct dped_hw_edit_flag_sel0 {
+		u32 oft:5;               /* [4:0] Default:0x1 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDIT_FLAG_SEL0_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDIT_FLAG_SEL1_ADDR  (0x75c208)
+#define NBL_DPED_HW_EDIT_FLAG_SEL1_DEPTH (1)
+#define NBL_DPED_HW_EDIT_FLAG_SEL1_WIDTH (32)
+#define NBL_DPED_HW_EDIT_FLAG_SEL1_DWLEN (1)
+union dped_hw_edit_flag_sel1_u {
+	struct dped_hw_edit_flag_sel1 {
+		u32 oft:5;               /* [4:0] Default:0x2 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDIT_FLAG_SEL1_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDIT_FLAG_SEL2_ADDR  (0x75c20c)
+#define NBL_DPED_HW_EDIT_FLAG_SEL2_DEPTH (1)
+#define NBL_DPED_HW_EDIT_FLAG_SEL2_WIDTH (32)
+#define NBL_DPED_HW_EDIT_FLAG_SEL2_DWLEN (1)
+union dped_hw_edit_flag_sel2_u {
+	struct dped_hw_edit_flag_sel2 {
+		u32 oft:5;               /* [4:0] Default:0x3 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDIT_FLAG_SEL2_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDIT_FLAG_SEL3_ADDR  (0x75c210)
+#define NBL_DPED_HW_EDIT_FLAG_SEL3_DEPTH (1)
+#define NBL_DPED_HW_EDIT_FLAG_SEL3_WIDTH (32)
+#define NBL_DPED_HW_EDIT_FLAG_SEL3_DWLEN (1)
+union dped_hw_edit_flag_sel3_u {
+	struct dped_hw_edit_flag_sel3 {
+		u32 oft:5;               /* [4:0] Default:0x4 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDIT_FLAG_SEL3_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDIT_FLAG_SEL4_ADDR  (0x75c214)
+#define NBL_DPED_HW_EDIT_FLAG_SEL4_DEPTH (1)
+#define NBL_DPED_HW_EDIT_FLAG_SEL4_WIDTH (32)
+#define NBL_DPED_HW_EDIT_FLAG_SEL4_DWLEN (1)
+union dped_hw_edit_flag_sel4_u {
+	struct dped_hw_edit_flag_sel4 {
+		u32 oft:5;               /* [4:0] Default:0xe RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDIT_FLAG_SEL4_DWLEN];
+} __packed;
+
+#define NBL_DPED_RDMA_FLAG_ADDR  (0x75c22c)
+#define NBL_DPED_RDMA_FLAG_DEPTH (1)
+#define NBL_DPED_RDMA_FLAG_WIDTH (32)
+#define NBL_DPED_RDMA_FLAG_DWLEN (1)
+union dped_rdma_flag_u {
+	struct dped_rdma_flag {
+		u32 oft:5;               /* [4:0] Default:0xa RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_RDMA_FLAG_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_DPORT_ADDR  (0x75c230)
+#define NBL_DPED_FWD_DPORT_DEPTH (1)
+#define NBL_DPED_FWD_DPORT_WIDTH (32)
+#define NBL_DPED_FWD_DPORT_DWLEN (1)
+union dped_fwd_dport_u {
+	struct dped_fwd_dport {
+		u32 id:6;                /* [5:0] Default:0x9 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_DPORT_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_MIRID_ADDR  (0x75c238)
+#define NBL_DPED_FWD_MIRID_DEPTH (1)
+#define NBL_DPED_FWD_MIRID_WIDTH (32)
+#define NBL_DPED_FWD_MIRID_DWLEN (1)
+union dped_fwd_mirid_u {
+	struct dped_fwd_mirid {
+		u32 id:6;                /* [5:0] Default:0x8 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_MIRID_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_VNI0_ADDR  (0x75c244)
+#define NBL_DPED_FWD_VNI0_DEPTH (1)
+#define NBL_DPED_FWD_VNI0_WIDTH (32)
+#define NBL_DPED_FWD_VNI0_DWLEN (1)
+union dped_fwd_vni0_u {
+	struct dped_fwd_vni0 {
+		u32 id:6;                /* [5:0] Default:0xe RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_VNI0_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_VNI1_ADDR  (0x75c248)
+#define NBL_DPED_FWD_VNI1_DEPTH (1)
+#define NBL_DPED_FWD_VNI1_WIDTH (32)
+#define NBL_DPED_FWD_VNI1_DWLEN (1)
+union dped_fwd_vni1_u {
+	struct dped_fwd_vni1 {
+		u32 id:6;                /* [5:0] Default:0xf RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_VNI1_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_PRI_MDF_ADDR  (0x75c250)
+#define NBL_DPED_FWD_PRI_MDF_DEPTH (1)
+#define NBL_DPED_FWD_PRI_MDF_WIDTH (32)
+#define NBL_DPED_FWD_PRI_MDF_DWLEN (1)
+union dped_fwd_pri_mdf_u {
+	struct dped_fwd_pri_mdf {
+		u32 id:6;                /* [5:0] Default:0x15 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_PRI_MDF_DWLEN];
+} __packed;
+
+#define NBL_DPED_VLAN_TYPE0_ADDR  (0x75c260)
+#define NBL_DPED_VLAN_TYPE0_DEPTH (1)
+#define NBL_DPED_VLAN_TYPE0_WIDTH (32)
+#define NBL_DPED_VLAN_TYPE0_DWLEN (1)
+union dped_vlan_type0_u {
+	struct dped_vlan_type0 {
+		u32 vau:16;              /* [15:0] Default:0x8100 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_VLAN_TYPE0_DWLEN];
+} __packed;
+
+#define NBL_DPED_VLAN_TYPE1_ADDR  (0x75c264)
+#define NBL_DPED_VLAN_TYPE1_DEPTH (1)
+#define NBL_DPED_VLAN_TYPE1_WIDTH (32)
+#define NBL_DPED_VLAN_TYPE1_DWLEN (1)
+union dped_vlan_type1_u {
+	struct dped_vlan_type1 {
+		u32 vau:16;              /* [15:0] Default:0x88A8 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_VLAN_TYPE1_DWLEN];
+} __packed;
+
+#define NBL_DPED_VLAN_TYPE2_ADDR  (0x75c268)
+#define NBL_DPED_VLAN_TYPE2_DEPTH (1)
+#define NBL_DPED_VLAN_TYPE2_WIDTH (32)
+#define NBL_DPED_VLAN_TYPE2_DWLEN (1)
+union dped_vlan_type2_u {
+	struct dped_vlan_type2 {
+		u32 vau:16;              /* [15:0] Default:0x9100 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_VLAN_TYPE2_DWLEN];
+} __packed;
+
+#define NBL_DPED_VLAN_TYPE3_ADDR  (0x75c26c)
+#define NBL_DPED_VLAN_TYPE3_DEPTH (1)
+#define NBL_DPED_VLAN_TYPE3_WIDTH (32)
+#define NBL_DPED_VLAN_TYPE3_DWLEN (1)
+union dped_vlan_type3_u {
+	struct dped_vlan_type3 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_VLAN_TYPE3_DWLEN];
+} __packed;
+
+#define NBL_DPED_L3_LEN_MDY_CMD_0_ADDR  (0x75c300)
+#define NBL_DPED_L3_LEN_MDY_CMD_0_DEPTH (1)
+#define NBL_DPED_L3_LEN_MDY_CMD_0_WIDTH (32)
+#define NBL_DPED_L3_LEN_MDY_CMD_0_DWLEN (1)
+union dped_l3_len_mdy_cmd_0_u {
+	struct dped_l3_len_mdy_cmd_0 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 in_oft:7;            /* [14:8] Default:0x2 RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x2 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x2 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x0 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L3_LEN_MDY_CMD_0_DWLEN];
+} __packed;
+
+#define NBL_DPED_L3_LEN_MDY_CMD_1_ADDR  (0x75c304)
+#define NBL_DPED_L3_LEN_MDY_CMD_1_DEPTH (1)
+#define NBL_DPED_L3_LEN_MDY_CMD_1_WIDTH (32)
+#define NBL_DPED_L3_LEN_MDY_CMD_1_DWLEN (1)
+union dped_l3_len_mdy_cmd_1_u {
+	struct dped_l3_len_mdy_cmd_1 {
+		u32 value:8;             /* [7:0] Default:0x28 RW */
+		u32 in_oft:7;            /* [14:8] Default:0x4 RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x2 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x1 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x0 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L3_LEN_MDY_CMD_1_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_LEN_MDY_CMD_0_ADDR  (0x75c308)
+#define NBL_DPED_L4_LEN_MDY_CMD_0_DEPTH (1)
+#define NBL_DPED_L4_LEN_MDY_CMD_0_WIDTH (32)
+#define NBL_DPED_L4_LEN_MDY_CMD_0_DWLEN (1)
+union dped_l4_len_mdy_cmd_0_u {
+	struct dped_l4_len_mdy_cmd_0 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 in_oft:7;            /* [14:8] Default:0xc RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x3 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x0 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x1 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_LEN_MDY_CMD_0_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_LEN_MDY_CMD_1_ADDR  (0x75c30c)
+#define NBL_DPED_L4_LEN_MDY_CMD_1_DEPTH (1)
+#define NBL_DPED_L4_LEN_MDY_CMD_1_WIDTH (32)
+#define NBL_DPED_L4_LEN_MDY_CMD_1_DWLEN (1)
+union dped_l4_len_mdy_cmd_1_u {
+	struct dped_l4_len_mdy_cmd_1 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 in_oft:7;            /* [14:8] Default:0x4 RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x3 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x0 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x1 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_LEN_MDY_CMD_1_DWLEN];
+} __packed;
+
+#define NBL_DPED_L3_CK_CMD_00_ADDR  (0x75c310)
+#define NBL_DPED_L3_CK_CMD_00_DEPTH (1)
+#define NBL_DPED_L3_CK_CMD_00_WIDTH (32)
+#define NBL_DPED_L3_CK_CMD_00_DWLEN (1)
+union dped_l3_ck_cmd_00_u {
+	struct dped_l3_ck_cmd_00 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0xa RW */
+		u32 phid:2;              /* [27:26] Default:0x2 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L3_CK_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_DPED_L3_CK_CMD_01_ADDR  (0x75c314)
+#define NBL_DPED_L3_CK_CMD_01_DEPTH (1)
+#define NBL_DPED_L3_CK_CMD_01_WIDTH (32)
+#define NBL_DPED_L3_CK_CMD_01_DWLEN (1)
+union dped_l3_ck_cmd_01_u {
+	struct dped_l3_ck_cmd_01 {
+		u32 ck_start0:6;         /* [5:0] Default:0x0 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x0 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x0 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L3_CK_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_00_ADDR  (0x75c318)
+#define NBL_DPED_L4_CK_CMD_00_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_00_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_00_DWLEN (1)
+union dped_l4_ck_cmd_00_u {
+	struct dped_l4_ck_cmd_00 {
+		u32 value:8;             /* [7:0] Default:0x6 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x10 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_01_ADDR  (0x75c31c)
+#define NBL_DPED_L4_CK_CMD_01_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_01_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_01_DWLEN (1)
+union dped_l4_ck_cmd_01_u {
+	struct dped_l4_ck_cmd_01 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_10_ADDR  (0x75c320)
+#define NBL_DPED_L4_CK_CMD_10_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_10_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_10_DWLEN (1)
+union dped_l4_ck_cmd_10_u {
+	struct dped_l4_ck_cmd_10 {
+		u32 value:8;             /* [7:0] Default:0x11 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x6 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x1 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_10_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_11_ADDR  (0x75c324)
+#define NBL_DPED_L4_CK_CMD_11_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_11_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_11_DWLEN (1)
+union dped_l4_ck_cmd_11_u {
+	struct dped_l4_ck_cmd_11 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_11_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_20_ADDR  (0x75c328)
+#define NBL_DPED_L4_CK_CMD_20_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_20_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_20_DWLEN (1)
+union dped_l4_ck_cmd_20_u {
+	struct dped_l4_ck_cmd_20 {
+		u32 value:8;             /* [7:0] Default:0x2e RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x10 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_20_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_21_ADDR  (0x75c32c)
+#define NBL_DPED_L4_CK_CMD_21_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_21_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_21_DWLEN (1)
+union dped_l4_ck_cmd_21_u {
+	struct dped_l4_ck_cmd_21 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_21_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_30_ADDR  (0x75c330)
+#define NBL_DPED_L4_CK_CMD_30_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_30_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_30_DWLEN (1)
+union dped_l4_ck_cmd_30_u {
+	struct dped_l4_ck_cmd_30 {
+		u32 value:8;             /* [7:0] Default:0x39 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x6 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x1 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_30_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_31_ADDR  (0x75c334)
+#define NBL_DPED_L4_CK_CMD_31_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_31_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_31_DWLEN (1)
+union dped_l4_ck_cmd_31_u {
+	struct dped_l4_ck_cmd_31 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_31_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_40_ADDR  (0x75c338)
+#define NBL_DPED_L4_CK_CMD_40_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_40_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_40_DWLEN (1)
+union dped_l4_ck_cmd_40_u {
+	struct dped_l4_ck_cmd_40 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x8 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x1 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_40_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_41_ADDR  (0x75c33c)
+#define NBL_DPED_L4_CK_CMD_41_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_41_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_41_DWLEN (1)
+union dped_l4_ck_cmd_41_u {
+	struct dped_l4_ck_cmd_41 {
+		u32 ck_start0:6;         /* [5:0] Default:0x0 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x0 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x0 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x0 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x0 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_41_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_50_ADDR  (0x75c340)
+#define NBL_DPED_L4_CK_CMD_50_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_50_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_50_DWLEN (1)
+union dped_l4_ck_cmd_50_u {
+	struct dped_l4_ck_cmd_50 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x2 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_50_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_51_ADDR  (0x75c344)
+#define NBL_DPED_L4_CK_CMD_51_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_51_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_51_DWLEN (1)
+union dped_l4_ck_cmd_51_u {
+	struct dped_l4_ck_cmd_51 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x0 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_51_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_60_ADDR  (0x75c348)
+#define NBL_DPED_L4_CK_CMD_60_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_60_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_60_DWLEN (1)
+union dped_l4_ck_cmd_60_u {
+	struct dped_l4_ck_cmd_60 {
+		u32 value:8;             /* [7:0] Default:0x62 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x2 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_60_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_61_ADDR  (0x75c34c)
+#define NBL_DPED_L4_CK_CMD_61_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_61_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_61_DWLEN (1)
+union dped_l4_ck_cmd_61_u {
+	struct dped_l4_ck_cmd_61 {
+		u32 ck_start0:6;         /* [5:0] Default:0x0 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x0 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x0 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x0 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x0 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_61_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L3_CK_CMD_00_ADDR  (0x75c350)
+#define NBL_DPED_TNL_L3_CK_CMD_00_DEPTH (1)
+#define NBL_DPED_TNL_L3_CK_CMD_00_WIDTH (32)
+#define NBL_DPED_TNL_L3_CK_CMD_00_DWLEN (1)
+union dped_tnl_l3_ck_cmd_00_u {
+	struct dped_tnl_l3_ck_cmd_00 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0xa RW */
+		u32 phid:2;              /* [27:26] Default:0x2 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L3_CK_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L3_CK_CMD_01_ADDR  (0x75c354)
+#define NBL_DPED_TNL_L3_CK_CMD_01_DEPTH (1)
+#define NBL_DPED_TNL_L3_CK_CMD_01_WIDTH (32)
+#define NBL_DPED_TNL_L3_CK_CMD_01_DWLEN (1)
+union dped_tnl_l3_ck_cmd_01_u {
+	struct dped_tnl_l3_ck_cmd_01 {
+		u32 ck_start0:6;         /* [5:0] Default:0x0 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x0 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x0 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L3_CK_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_00_ADDR  (0x75c360)
+#define NBL_DPED_TNL_L4_CK_CMD_00_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_00_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_00_DWLEN (1)
+union dped_tnl_l4_ck_cmd_00_u {
+	struct dped_tnl_l4_ck_cmd_00 {
+		u32 value:8;             /* [7:0] Default:0x11 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x6 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x1 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_01_ADDR  (0x75c364)
+#define NBL_DPED_TNL_L4_CK_CMD_01_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_01_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_01_DWLEN (1)
+union dped_tnl_l4_ck_cmd_01_u {
+	struct dped_tnl_l4_ck_cmd_01 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_10_ADDR  (0x75c368)
+#define NBL_DPED_TNL_L4_CK_CMD_10_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_10_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_10_DWLEN (1)
+union dped_tnl_l4_ck_cmd_10_u {
+	struct dped_tnl_l4_ck_cmd_10 {
+		u32 value:8;             /* [7:0] Default:0x39 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x6 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x1 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_10_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_11_ADDR  (0x75c36c)
+#define NBL_DPED_TNL_L4_CK_CMD_11_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_11_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_11_DWLEN (1)
+union dped_tnl_l4_ck_cmd_11_u {
+	struct dped_tnl_l4_ck_cmd_11 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_11_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_20_ADDR  (0x75c370)
+#define NBL_DPED_TNL_L4_CK_CMD_20_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_20_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_20_DWLEN (1)
+union dped_tnl_l4_ck_cmd_20_u {
+	struct dped_tnl_l4_ck_cmd_20 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x0 RW */
+		u32 phid:2;              /* [27:26] Default:0x0 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_20_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_21_ADDR  (0x75c374)
+#define NBL_DPED_TNL_L4_CK_CMD_21_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_21_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_21_DWLEN (1)
+union dped_tnl_l4_ck_cmd_21_u {
+	struct dped_tnl_l4_ck_cmd_21 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x14 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_21_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_30_ADDR  (0x75c378)
+#define NBL_DPED_TNL_L4_CK_CMD_30_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_30_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_30_DWLEN (1)
+union dped_tnl_l4_ck_cmd_30_u {
+	struct dped_tnl_l4_ck_cmd_30 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x0 RW */
+		u32 phid:2;              /* [27:26] Default:0x0 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_30_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_31_ADDR  (0x75c37c)
+#define NBL_DPED_TNL_L4_CK_CMD_31_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_31_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_31_DWLEN (1)
+union dped_tnl_l4_ck_cmd_31_u {
+	struct dped_tnl_l4_ck_cmd_31 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x8 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_31_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_40_ADDR  (0x75c380)
+#define NBL_DPED_TNL_L4_CK_CMD_40_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_40_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_40_DWLEN (1)
+union dped_tnl_l4_ck_cmd_40_u {
+	struct dped_tnl_l4_ck_cmd_40 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x0 RW */
+		u32 phid:2;              /* [27:26] Default:0x0 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_40_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_41_ADDR  (0x75c384)
+#define NBL_DPED_TNL_L4_CK_CMD_41_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_41_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_41_DWLEN (1)
+union dped_tnl_l4_ck_cmd_41_u {
+	struct dped_tnl_l4_ck_cmd_41 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x8 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_41_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_50_ADDR  (0x75c388)
+#define NBL_DPED_TNL_L4_CK_CMD_50_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_50_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_50_DWLEN (1)
+union dped_tnl_l4_ck_cmd_50_u {
+	struct dped_tnl_l4_ck_cmd_50 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x0 RW */
+		u32 phid:2;              /* [27:26] Default:0x0 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_50_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_51_ADDR  (0x75c38c)
+#define NBL_DPED_TNL_L4_CK_CMD_51_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_51_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_51_DWLEN (1)
+union dped_tnl_l4_ck_cmd_51_u {
+	struct dped_tnl_l4_ck_cmd_51 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x8 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_51_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_60_ADDR  (0x75c390)
+#define NBL_DPED_TNL_L4_CK_CMD_60_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_60_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_60_DWLEN (1)
+union dped_tnl_l4_ck_cmd_60_u {
+	struct dped_tnl_l4_ck_cmd_60 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x0 RW */
+		u32 phid:2;              /* [27:26] Default:0x0 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_60_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_61_ADDR  (0x75c394)
+#define NBL_DPED_TNL_L4_CK_CMD_61_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_61_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_61_DWLEN (1)
+union dped_tnl_l4_ck_cmd_61_u {
+	struct dped_tnl_l4_ck_cmd_61 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x8 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_61_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_00_ADDR  (0x75c3a0)
+#define NBL_DPED_MIR_CMD_00_DEPTH (1)
+#define NBL_DPED_MIR_CMD_00_WIDTH (32)
+#define NBL_DPED_MIR_CMD_00_DWLEN (1)
+union dped_mir_cmd_00_u {
+	struct dped_mir_cmd_00 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_01_ADDR  (0x75c3a4)
+#define NBL_DPED_MIR_CMD_01_DEPTH (1)
+#define NBL_DPED_MIR_CMD_01_WIDTH (32)
+#define NBL_DPED_MIR_CMD_01_DWLEN (1)
+union dped_mir_cmd_01_u {
+	struct dped_mir_cmd_01 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_10_ADDR  (0x75c3a8)
+#define NBL_DPED_MIR_CMD_10_DEPTH (1)
+#define NBL_DPED_MIR_CMD_10_WIDTH (32)
+#define NBL_DPED_MIR_CMD_10_DWLEN (1)
+union dped_mir_cmd_10_u {
+	struct dped_mir_cmd_10 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_10_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_11_ADDR  (0x75c3ac)
+#define NBL_DPED_MIR_CMD_11_DEPTH (1)
+#define NBL_DPED_MIR_CMD_11_WIDTH (32)
+#define NBL_DPED_MIR_CMD_11_DWLEN (1)
+union dped_mir_cmd_11_u {
+	struct dped_mir_cmd_11 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_11_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_20_ADDR  (0x75c3b0)
+#define NBL_DPED_MIR_CMD_20_DEPTH (1)
+#define NBL_DPED_MIR_CMD_20_WIDTH (32)
+#define NBL_DPED_MIR_CMD_20_DWLEN (1)
+union dped_mir_cmd_20_u {
+	struct dped_mir_cmd_20 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_20_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_21_ADDR  (0x75c3b4)
+#define NBL_DPED_MIR_CMD_21_DEPTH (1)
+#define NBL_DPED_MIR_CMD_21_WIDTH (32)
+#define NBL_DPED_MIR_CMD_21_DWLEN (1)
+union dped_mir_cmd_21_u {
+	struct dped_mir_cmd_21 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_21_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_30_ADDR  (0x75c3b8)
+#define NBL_DPED_MIR_CMD_30_DEPTH (1)
+#define NBL_DPED_MIR_CMD_30_WIDTH (32)
+#define NBL_DPED_MIR_CMD_30_DWLEN (1)
+union dped_mir_cmd_30_u {
+	struct dped_mir_cmd_30 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_30_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_31_ADDR  (0x75c3bc)
+#define NBL_DPED_MIR_CMD_31_DEPTH (1)
+#define NBL_DPED_MIR_CMD_31_WIDTH (32)
+#define NBL_DPED_MIR_CMD_31_DWLEN (1)
+union dped_mir_cmd_31_u {
+	struct dped_mir_cmd_31 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_31_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_40_ADDR  (0x75c3c0)
+#define NBL_DPED_MIR_CMD_40_DEPTH (1)
+#define NBL_DPED_MIR_CMD_40_WIDTH (32)
+#define NBL_DPED_MIR_CMD_40_DWLEN (1)
+union dped_mir_cmd_40_u {
+	struct dped_mir_cmd_40 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_40_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_41_ADDR  (0x75c3c4)
+#define NBL_DPED_MIR_CMD_41_DEPTH (1)
+#define NBL_DPED_MIR_CMD_41_WIDTH (32)
+#define NBL_DPED_MIR_CMD_41_DWLEN (1)
+union dped_mir_cmd_41_u {
+	struct dped_mir_cmd_41 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_41_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_50_ADDR  (0x75c3c8)
+#define NBL_DPED_MIR_CMD_50_DEPTH (1)
+#define NBL_DPED_MIR_CMD_50_WIDTH (32)
+#define NBL_DPED_MIR_CMD_50_DWLEN (1)
+union dped_mir_cmd_50_u {
+	struct dped_mir_cmd_50 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_50_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_51_ADDR  (0x75c3cc)
+#define NBL_DPED_MIR_CMD_51_DEPTH (1)
+#define NBL_DPED_MIR_CMD_51_WIDTH (32)
+#define NBL_DPED_MIR_CMD_51_DWLEN (1)
+union dped_mir_cmd_51_u {
+	struct dped_mir_cmd_51 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_51_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_60_ADDR  (0x75c3d0)
+#define NBL_DPED_MIR_CMD_60_DEPTH (1)
+#define NBL_DPED_MIR_CMD_60_WIDTH (32)
+#define NBL_DPED_MIR_CMD_60_DWLEN (1)
+union dped_mir_cmd_60_u {
+	struct dped_mir_cmd_60 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_60_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_61_ADDR  (0x75c3d4)
+#define NBL_DPED_MIR_CMD_61_DEPTH (1)
+#define NBL_DPED_MIR_CMD_61_WIDTH (32)
+#define NBL_DPED_MIR_CMD_61_DWLEN (1)
+union dped_mir_cmd_61_u {
+	struct dped_mir_cmd_61 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_61_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_70_ADDR  (0x75c3d8)
+#define NBL_DPED_MIR_CMD_70_DEPTH (1)
+#define NBL_DPED_MIR_CMD_70_WIDTH (32)
+#define NBL_DPED_MIR_CMD_70_DWLEN (1)
+union dped_mir_cmd_70_u {
+	struct dped_mir_cmd_70 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_70_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_71_ADDR  (0x75c3dc)
+#define NBL_DPED_MIR_CMD_71_DEPTH (1)
+#define NBL_DPED_MIR_CMD_71_WIDTH (32)
+#define NBL_DPED_MIR_CMD_71_DWLEN (1)
+union dped_mir_cmd_71_u {
+	struct dped_mir_cmd_71 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_71_DWLEN];
+} __packed;
+
+#define NBL_DPED_DSCP_CK_EN_ADDR  (0x75c3e8)
+#define NBL_DPED_DSCP_CK_EN_DEPTH (1)
+#define NBL_DPED_DSCP_CK_EN_WIDTH (32)
+#define NBL_DPED_DSCP_CK_EN_DWLEN (1)
+union dped_dscp_ck_en_u {
+	struct dped_dscp_ck_en {
+		u32 l4_en:1;             /* [0] Default:0x0 RW */
+		u32 l3_en:1;             /* [1] Default:0x1 RW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_DSCP_CK_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_RDMA_ECN_REMARK_ADDR  (0x75c3f0)
+#define NBL_DPED_RDMA_ECN_REMARK_DEPTH (1)
+#define NBL_DPED_RDMA_ECN_REMARK_WIDTH (32)
+#define NBL_DPED_RDMA_ECN_REMARK_DWLEN (1)
+union dped_rdma_ecn_remark_u {
+	struct dped_rdma_ecn_remark {
+		u32 vau:2;               /* [1:0] Default:0x1 RW */
+		u32 rsv1:2;              /* [3:2] Default:0x0 RO */
+		u32 en:1;                /* [4] Default:0x0 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_RDMA_ECN_REMARK_DWLEN];
+} __packed;
+
+#define NBL_DPED_VLAN_OFFSET_ADDR  (0x75c3f4)
+#define NBL_DPED_VLAN_OFFSET_DEPTH (1)
+#define NBL_DPED_VLAN_OFFSET_WIDTH (32)
+#define NBL_DPED_VLAN_OFFSET_DWLEN (1)
+union dped_vlan_offset_u {
+	struct dped_vlan_offset {
+		u32 oft:8;               /* [7:0] Default:0xC RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_VLAN_OFFSET_DWLEN];
+} __packed;
+
+#define NBL_DPED_DSCP_OFFSET_0_ADDR  (0x75c3f8)
+#define NBL_DPED_DSCP_OFFSET_0_DEPTH (1)
+#define NBL_DPED_DSCP_OFFSET_0_WIDTH (32)
+#define NBL_DPED_DSCP_OFFSET_0_DWLEN (1)
+union dped_dscp_offset_0_u {
+	struct dped_dscp_offset_0 {
+		u32 oft:8;               /* [7:0] Default:0x8 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_DSCP_OFFSET_0_DWLEN];
+} __packed;
+
+#define NBL_DPED_DSCP_OFFSET_1_ADDR  (0x75c3fc)
+#define NBL_DPED_DSCP_OFFSET_1_DEPTH (1)
+#define NBL_DPED_DSCP_OFFSET_1_WIDTH (32)
+#define NBL_DPED_DSCP_OFFSET_1_DWLEN (1)
+union dped_dscp_offset_1_u {
+	struct dped_dscp_offset_1 {
+		u32 oft:8;               /* [7:0] Default:0x4 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_DSCP_OFFSET_1_DWLEN];
+} __packed;
+
+#define NBL_DPED_CFG_TEST_ADDR  (0x75c600)
+#define NBL_DPED_CFG_TEST_DEPTH (1)
+#define NBL_DPED_CFG_TEST_WIDTH (32)
+#define NBL_DPED_CFG_TEST_DWLEN (1)
+union dped_cfg_test_u {
+	struct dped_cfg_test {
+		u32 test:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_DPED_BP_STATE_ADDR  (0x75c608)
+#define NBL_DPED_BP_STATE_DEPTH (1)
+#define NBL_DPED_BP_STATE_WIDTH (32)
+#define NBL_DPED_BP_STATE_DWLEN (1)
+union dped_bp_state_u {
+	struct dped_bp_state {
+		u32 bm_rtn_tout:1;       /* [0] Default:0x0 RO */
+		u32 bm_not_rdy:1;        /* [1] Default:0x0 RO */
+		u32 dprbac_fc:1;         /* [2] Default:0x0 RO */
+		u32 qm_fc:1;             /* [3] Default:0x0 RO */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_DPED_BP_HISTORY_ADDR  (0x75c60c)
+#define NBL_DPED_BP_HISTORY_DEPTH (1)
+#define NBL_DPED_BP_HISTORY_WIDTH (32)
+#define NBL_DPED_BP_HISTORY_DWLEN (1)
+union dped_bp_history_u {
+	struct dped_bp_history {
+		u32 bm_rtn_tout:1;       /* [0] Default:0x0 RC */
+		u32 bm_not_rdy:1;        /* [1] Default:0x0 RC */
+		u32 dprbac_fc:1;         /* [2] Default:0x0 RC */
+		u32 qm_fc:1;             /* [3] Default:0x0 RC */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIRID_IND_ADDR  (0x75c900)
+#define NBL_DPED_MIRID_IND_DEPTH (1)
+#define NBL_DPED_MIRID_IND_WIDTH (32)
+#define NBL_DPED_MIRID_IND_DWLEN (1)
+union dped_mirid_ind_u {
+	struct dped_mirid_ind {
+		u32 nomat:1;             /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIRID_IND_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_AUX_OFT_ADDR  (0x75c904)
+#define NBL_DPED_MD_AUX_OFT_DEPTH (1)
+#define NBL_DPED_MD_AUX_OFT_WIDTH (32)
+#define NBL_DPED_MD_AUX_OFT_DWLEN (1)
+union dped_md_aux_oft_u {
+	struct dped_md_aux_oft {
+		u32 l2_oft:8;            /* [7:0] Default:0x0 RO */
+		u32 l3_oft:8;            /* [15:8] Default:0x0 RO */
+		u32 l4_oft:8;            /* [23:16] Default:0x0 RO */
+		u32 pld_oft:8;           /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_AUX_OFT_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_AUX_PKT_LEN_ADDR  (0x75c908)
+#define NBL_DPED_MD_AUX_PKT_LEN_DEPTH (1)
+#define NBL_DPED_MD_AUX_PKT_LEN_WIDTH (32)
+#define NBL_DPED_MD_AUX_PKT_LEN_DWLEN (1)
+union dped_md_aux_pkt_len_u {
+	struct dped_md_aux_pkt_len {
+		u32 len:14;              /* [13:0] Default:0x0 RO */
+		u32 rsv:18;              /* [31:14] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_AUX_PKT_LEN_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_FWD_MIR_ADDR  (0x75c90c)
+#define NBL_DPED_MD_FWD_MIR_DEPTH (1)
+#define NBL_DPED_MD_FWD_MIR_WIDTH (32)
+#define NBL_DPED_MD_FWD_MIR_DWLEN (1)
+union dped_md_fwd_mir_u {
+	struct dped_md_fwd_mir {
+		u32 id:4;                /* [3:0] Default:0x0 RO */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_FWD_MIR_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_FWD_DPORT_ADDR  (0x75c910)
+#define NBL_DPED_MD_FWD_DPORT_DEPTH (1)
+#define NBL_DPED_MD_FWD_DPORT_WIDTH (32)
+#define NBL_DPED_MD_FWD_DPORT_DWLEN (1)
+union dped_md_fwd_dport_u {
+	struct dped_md_fwd_dport {
+		u32 id:16;               /* [15:0] Default:0x0 RO */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_FWD_DPORT_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_AUX_PLD_CKSUM_ADDR  (0x75c914)
+#define NBL_DPED_MD_AUX_PLD_CKSUM_DEPTH (1)
+#define NBL_DPED_MD_AUX_PLD_CKSUM_WIDTH (32)
+#define NBL_DPED_MD_AUX_PLD_CKSUM_DWLEN (1)
+union dped_md_aux_pld_cksum_u {
+	struct dped_md_aux_pld_cksum {
+		u32 ck:32;               /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_AUX_PLD_CKSUM_DWLEN];
+} __packed;
+
+#define NBL_DPED_INNER_PKT_CKSUM_ADDR  (0x75c918)
+#define NBL_DPED_INNER_PKT_CKSUM_DEPTH (1)
+#define NBL_DPED_INNER_PKT_CKSUM_WIDTH (32)
+#define NBL_DPED_INNER_PKT_CKSUM_DWLEN (1)
+union dped_inner_pkt_cksum_u {
+	struct dped_inner_pkt_cksum {
+		u32 ck:16;               /* [15:0] Default:0x0 RO */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INNER_PKT_CKSUM_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_0_ADDR  (0x75c920)
+#define NBL_DPED_MD_EDIT_0_DEPTH (1)
+#define NBL_DPED_MD_EDIT_0_WIDTH (32)
+#define NBL_DPED_MD_EDIT_0_DWLEN (1)
+union dped_md_edit_0_u {
+	struct dped_md_edit_0 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_0_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_1_ADDR  (0x75c924)
+#define NBL_DPED_MD_EDIT_1_DEPTH (1)
+#define NBL_DPED_MD_EDIT_1_WIDTH (32)
+#define NBL_DPED_MD_EDIT_1_DWLEN (1)
+union dped_md_edit_1_u {
+	struct dped_md_edit_1 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_1_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_2_ADDR  (0x75c928)
+#define NBL_DPED_MD_EDIT_2_DEPTH (1)
+#define NBL_DPED_MD_EDIT_2_WIDTH (32)
+#define NBL_DPED_MD_EDIT_2_DWLEN (1)
+union dped_md_edit_2_u {
+	struct dped_md_edit_2 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_2_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_3_ADDR  (0x75c92c)
+#define NBL_DPED_MD_EDIT_3_DEPTH (1)
+#define NBL_DPED_MD_EDIT_3_WIDTH (32)
+#define NBL_DPED_MD_EDIT_3_DWLEN (1)
+union dped_md_edit_3_u {
+	struct dped_md_edit_3 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_3_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_4_ADDR  (0x75c930)
+#define NBL_DPED_MD_EDIT_4_DEPTH (1)
+#define NBL_DPED_MD_EDIT_4_WIDTH (32)
+#define NBL_DPED_MD_EDIT_4_DWLEN (1)
+union dped_md_edit_4_u {
+	struct dped_md_edit_4 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_4_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_5_ADDR  (0x75c934)
+#define NBL_DPED_MD_EDIT_5_DEPTH (1)
+#define NBL_DPED_MD_EDIT_5_WIDTH (32)
+#define NBL_DPED_MD_EDIT_5_DWLEN (1)
+union dped_md_edit_5_u {
+	struct dped_md_edit_5 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_5_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_6_ADDR  (0x75c938)
+#define NBL_DPED_MD_EDIT_6_DEPTH (1)
+#define NBL_DPED_MD_EDIT_6_WIDTH (32)
+#define NBL_DPED_MD_EDIT_6_DWLEN (1)
+union dped_md_edit_6_u {
+	struct dped_md_edit_6 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_6_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_7_ADDR  (0x75c93c)
+#define NBL_DPED_MD_EDIT_7_DEPTH (1)
+#define NBL_DPED_MD_EDIT_7_WIDTH (32)
+#define NBL_DPED_MD_EDIT_7_DWLEN (1)
+union dped_md_edit_7_u {
+	struct dped_md_edit_7 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_7_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_8_ADDR  (0x75c940)
+#define NBL_DPED_MD_EDIT_8_DEPTH (1)
+#define NBL_DPED_MD_EDIT_8_WIDTH (32)
+#define NBL_DPED_MD_EDIT_8_DWLEN (1)
+union dped_md_edit_8_u {
+	struct dped_md_edit_8 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_8_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_9_ADDR  (0x75c944)
+#define NBL_DPED_MD_EDIT_9_DEPTH (1)
+#define NBL_DPED_MD_EDIT_9_WIDTH (32)
+#define NBL_DPED_MD_EDIT_9_DWLEN (1)
+union dped_md_edit_9_u {
+	struct dped_md_edit_9 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_9_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_10_ADDR  (0x75c948)
+#define NBL_DPED_MD_EDIT_10_DEPTH (1)
+#define NBL_DPED_MD_EDIT_10_WIDTH (32)
+#define NBL_DPED_MD_EDIT_10_DWLEN (1)
+union dped_md_edit_10_u {
+	struct dped_md_edit_10 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_10_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_11_ADDR  (0x75c94c)
+#define NBL_DPED_MD_EDIT_11_DEPTH (1)
+#define NBL_DPED_MD_EDIT_11_WIDTH (32)
+#define NBL_DPED_MD_EDIT_11_DWLEN (1)
+union dped_md_edit_11_u {
+	struct dped_md_edit_11 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_11_DWLEN];
+} __packed;
+
+#define NBL_DPED_ADD_DEL_LEN_ADDR  (0x75c950)
+#define NBL_DPED_ADD_DEL_LEN_DEPTH (1)
+#define NBL_DPED_ADD_DEL_LEN_WIDTH (32)
+#define NBL_DPED_ADD_DEL_LEN_DWLEN (1)
+union dped_add_del_len_u {
+	struct dped_add_del_len {
+		u32 len:9;               /* [8:0] Default:0x0 RO */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_ADD_DEL_LEN_DWLEN];
+} __packed;
+
+#define NBL_DPED_TTL_INFO_ADDR  (0x75c970)
+#define NBL_DPED_TTL_INFO_DEPTH (1)
+#define NBL_DPED_TTL_INFO_WIDTH (32)
+#define NBL_DPED_TTL_INFO_DWLEN (1)
+union dped_ttl_info_u {
+	struct dped_ttl_info {
+		u32 old_ttl:8;           /* [7:0] Default:0x0 RO */
+		u32 new_ttl:8;           /* [15:8] Default:0x0 RO */
+		u32 ttl_val:1;           /* [16] Default:0x0 RC */
+		u32 rsv:15;              /* [31:17] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TTL_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_LEN_INFO_VLD_ADDR  (0x75c974)
+#define NBL_DPED_LEN_INFO_VLD_DEPTH (1)
+#define NBL_DPED_LEN_INFO_VLD_WIDTH (32)
+#define NBL_DPED_LEN_INFO_VLD_DWLEN (1)
+union dped_len_info_vld_u {
+	struct dped_len_info_vld {
+		u32 length0:1;           /* [0] Default:0x0 RC */
+		u32 length1:1;           /* [1] Default:0x0 RC */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_LEN_INFO_VLD_DWLEN];
+} __packed;
+
+#define NBL_DPED_LEN0_INFO_ADDR  (0x75c978)
+#define NBL_DPED_LEN0_INFO_DEPTH (1)
+#define NBL_DPED_LEN0_INFO_WIDTH (32)
+#define NBL_DPED_LEN0_INFO_DWLEN (1)
+union dped_len0_info_u {
+	struct dped_len0_info {
+		u32 old_len:16;          /* [15:0] Default:0x0 RO */
+		u32 new_len:16;          /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_LEN0_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_LEN1_INFO_ADDR  (0x75c97c)
+#define NBL_DPED_LEN1_INFO_DEPTH (1)
+#define NBL_DPED_LEN1_INFO_WIDTH (32)
+#define NBL_DPED_LEN1_INFO_DWLEN (1)
+union dped_len1_info_u {
+	struct dped_len1_info {
+		u32 old_len:16;          /* [15:0] Default:0x0 RO */
+		u32 new_len:16;          /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_LEN1_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_EDIT_ATNUM_INFO_ADDR  (0x75c980)
+#define NBL_DPED_EDIT_ATNUM_INFO_DEPTH (1)
+#define NBL_DPED_EDIT_ATNUM_INFO_WIDTH (32)
+#define NBL_DPED_EDIT_ATNUM_INFO_DWLEN (1)
+union dped_edit_atnum_info_u {
+	struct dped_edit_atnum_info {
+		u32 replace:4;           /* [3:0] Default:0x0 RO */
+		u32 del:4;               /* [7:4] Default:0x0 RO */
+		u32 add:4;               /* [11:8] Default:0x0 RO */
+		u32 ttl:4;               /* [15:12] Default:0x0 RO */
+		u32 dscp:4;              /* [19:16] Default:0x0 RO */
+		u32 tnl:4;               /* [23:20] Default:0x0 RO */
+		u32 sport:4;             /* [27:24] Default:0x0 RO */
+		u32 rsv:4;               /* [31:28] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_EDIT_ATNUM_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_EDIT_NO_AT_INFO_ADDR  (0x75c984)
+#define NBL_DPED_EDIT_NO_AT_INFO_DEPTH (1)
+#define NBL_DPED_EDIT_NO_AT_INFO_WIDTH (32)
+#define NBL_DPED_EDIT_NO_AT_INFO_DWLEN (1)
+union dped_edit_no_at_info_u {
+	struct dped_edit_no_at_info {
+		u32 l3_len:1;            /* [0] Default:0x0 RC */
+		u32 l4_len:1;            /* [1] Default:0x0 RC */
+		u32 l3_ck:1;             /* [2] Default:0x0 RC */
+		u32 l4_ck:1;             /* [3] Default:0x0 RC */
+		u32 sctp_ck:1;           /* [4] Default:0x0 RC */
+		u32 padding:1;           /* [5] Default:0x0 RC */
+		u32 rsv:26;              /* [31:06] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_EDIT_NO_AT_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDT_PROF_ADDR  (0x75d000)
+#define NBL_DPED_HW_EDT_PROF_DEPTH (32)
+#define NBL_DPED_HW_EDT_PROF_WIDTH (32)
+#define NBL_DPED_HW_EDT_PROF_DWLEN (1)
+union dped_hw_edt_prof_u {
+	struct dped_hw_edt_prof {
+		u32 l4_len:2;            /* [1:0] Default:0x2 RW */
+		u32 l3_len:2;            /* [3:2] Default:0x2 RW */
+		u32 l4_ck:3;             /* [6:4] Default:0x7 RW */
+		u32 l3_ck:1;             /* [7:7] Default:0x0 RW */
+		u32 l4_ck_zero_free:1;   /* [8:8] Default:0x1 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDT_PROF_DWLEN];
+} __packed;
+#define NBL_DPED_HW_EDT_PROF_REG(r) (NBL_DPED_HW_EDT_PROF_ADDR + \
+		(NBL_DPED_HW_EDT_PROF_DWLEN * 4) * (r))
+
+#define NBL_DPED_OUT_MASK_ADDR  (0x75e000)
+#define NBL_DPED_OUT_MASK_DEPTH (24)
+#define NBL_DPED_OUT_MASK_WIDTH (64)
+#define NBL_DPED_OUT_MASK_DWLEN (2)
+union dped_out_mask_u {
+	struct dped_out_mask {
+		u32 flag:32;             /* [31:0] Default:0x0 RW */
+		u32 fwd:30;              /* [61:32] Default:0x0 RW */
+		u32 rsv:2;               /* [63:62] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_OUT_MASK_DWLEN];
+} __packed;
+#define NBL_DPED_OUT_MASK_REG(r) (NBL_DPED_OUT_MASK_ADDR + \
+		(NBL_DPED_OUT_MASK_DWLEN * 4) * (r))
+
+#define NBL_DPED_TAB_EDIT_CMD_ADDR  (0x75f000)
+#define NBL_DPED_TAB_EDIT_CMD_DEPTH (32)
+#define NBL_DPED_TAB_EDIT_CMD_WIDTH (32)
+#define NBL_DPED_TAB_EDIT_CMD_DWLEN (1)
+union dped_tab_edit_cmd_u {
+	struct dped_tab_edit_cmd {
+		u32 in_offset:8;         /* [7:0] Default:0x0 RW */
+		u32 phid:2;              /* [9:8] Default:0x0 RW */
+		u32 len:7;               /* [16:10] Default:0x0 RW */
+		u32 mode:4;              /* [20:17] Default:0xf RW */
+		u32 l4_ck_ofld_upt:1;    /* [21] Default:0x1 RW */
+		u32 l3_ck_ofld_upt:1;    /* [22] Default:0x1 RW */
+		u32 rsv:9;               /* [31:23] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TAB_EDIT_CMD_DWLEN];
+} __packed;
+#define NBL_DPED_TAB_EDIT_CMD_REG(r) (NBL_DPED_TAB_EDIT_CMD_ADDR + \
+		(NBL_DPED_TAB_EDIT_CMD_DWLEN * 4) * (r))
+
+#define NBL_DPED_TAB_MIR_ADDR  (0x760000)
+#define NBL_DPED_TAB_MIR_DEPTH (8)
+#define NBL_DPED_TAB_MIR_WIDTH (1024)
+#define NBL_DPED_TAB_MIR_DWLEN (32)
+union dped_tab_mir_u {
+	struct dped_tab_mir {
+		u32 cfg_mir_data:16;     /* [719:0] Default:0x0 RW */
+		u32 cfg_mir_data_arr[22]; /* [719:0] Default:0x0 RW */
+		u32 cfg_mir_info_l:32;   /* [755:720] Default:0x0 RW */
+		u32 cfg_mir_info_h:4;    /* [755:720] Default:0x0 RW */
+		u32 rsv:12;              /* [1023:756] Default:0x0 RO */
+		u32 rsv_arr[8];          /* [1023:756] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TAB_MIR_DWLEN];
+} __packed;
+#define NBL_DPED_TAB_MIR_REG(r) (NBL_DPED_TAB_MIR_ADDR + \
+		(NBL_DPED_TAB_MIR_DWLEN * 4) * (r))
+
+#define NBL_DPED_TAB_VSI_TYPE_ADDR  (0x761000)
+#define NBL_DPED_TAB_VSI_TYPE_DEPTH (1031)
+#define NBL_DPED_TAB_VSI_TYPE_WIDTH (32)
+#define NBL_DPED_TAB_VSI_TYPE_DWLEN (1)
+union dped_tab_vsi_type_u {
+	struct dped_tab_vsi_type {
+		u32 sel:4;               /* [3:0] Default:0x0 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TAB_VSI_TYPE_DWLEN];
+} __packed;
+#define NBL_DPED_TAB_VSI_TYPE_REG(r) (NBL_DPED_TAB_VSI_TYPE_ADDR + \
+		(NBL_DPED_TAB_VSI_TYPE_DWLEN * 4) * (r))
+
+#define NBL_DPED_TAB_REPLACE_ADDR  (0x763000)
+#define NBL_DPED_TAB_REPLACE_DEPTH (2048)
+#define NBL_DPED_TAB_REPLACE_WIDTH (64)
+#define NBL_DPED_TAB_REPLACE_DWLEN (2)
+union dped_tab_replace_u {
+	struct dped_tab_replace {
+		u32 vau_arr[2];          /* [63:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TAB_REPLACE_DWLEN];
+} __packed;
+#define NBL_DPED_TAB_REPLACE_REG(r) (NBL_DPED_TAB_REPLACE_ADDR + \
+		(NBL_DPED_TAB_REPLACE_DWLEN * 4) * (r))
+
+#define NBL_DPED_TAB_TNL_ADDR  (0x7dc000)
+#define NBL_DPED_TAB_TNL_DEPTH (4096)
+#define NBL_DPED_TAB_TNL_WIDTH (1024)
+#define NBL_DPED_TAB_TNL_DWLEN (32)
+union dped_tab_tnl_u {
+	struct dped_tab_tnl {
+		u32 cfg_tnl_data:16;     /* [719:0] Default:0x0 RW */
+		u32 cfg_tnl_data_arr[22]; /* [719:0] Default:0x0 RW */
+		u32 cfg_tnl_info:8;      /* [791:720] Default:0x0 RW */
+		u32 cfg_tnl_info_arr[2]; /* [791:720] Default:0x0 RW */
+		u32 rsv_l:32;            /* [1023:792] Default:0x0 RO */
+		u32 rsv_h:8;             /* [1023:792] Default:0x0 RO */
+		u32 rsv_arr[6];          /* [1023:792] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TAB_TNL_DWLEN];
+} __packed;
+#define NBL_DPED_TAB_TNL_REG(r) (NBL_DPED_TAB_TNL_ADDR + \
+		(NBL_DPED_TAB_TNL_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h
new file mode 100644
index 000000000000..554ef4592189
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h
@@ -0,0 +1,929 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_DSTORE_H
+#define NBL_DSTORE_H 1
+
+#include <linux/types.h>
+
+#define NBL_DSTORE_BASE (0x00704000)
+
+#define NBL_DSTORE_INT_STATUS_ADDR  (0x704000)
+#define NBL_DSTORE_INT_STATUS_DEPTH (1)
+#define NBL_DSTORE_INT_STATUS_WIDTH (32)
+#define NBL_DSTORE_INT_STATUS_DWLEN (1)
+union dstore_int_status_u {
+	struct dstore_int_status {
+		u32 ucor_err:1;          /* [0] Default:0x0 RWC */
+		u32 cor_err:1;           /* [1] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [3] Default:0x0 RWC */
+		u32 cif_err:1;           /* [4] Default:0x0 RWC */
+		u32 parity_err:1;        /* [5] Default:0x0 RWC */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_INT_MASK_ADDR  (0x704004)
+#define NBL_DSTORE_INT_MASK_DEPTH (1)
+#define NBL_DSTORE_INT_MASK_WIDTH (32)
+#define NBL_DSTORE_INT_MASK_DWLEN (1)
+union dstore_int_mask_u {
+	struct dstore_int_mask {
+		u32 ucor_err:1;          /* [0] Default:0x0 RW */
+		u32 cor_err:1;           /* [1] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [3] Default:0x0 RW */
+		u32 cif_err:1;           /* [4] Default:0x0 RW */
+		u32 parity_err:1;        /* [5] Default:0x0 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_INT_SET_ADDR  (0x704008)
+#define NBL_DSTORE_INT_SET_DEPTH (0)
+#define NBL_DSTORE_INT_SET_WIDTH (32)
+#define NBL_DSTORE_INT_SET_DWLEN (1)
+union dstore_int_set_u {
+	struct dstore_int_set {
+		u32 ucor_err:1;          /* [0] Default:0x0 WO */
+		u32 cor_err:1;           /* [1] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [3] Default:0x0 WO */
+		u32 cif_err:1;           /* [4] Default:0x0 WO */
+		u32 parity_err:1;        /* [5] Default:0x0 WO */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_COR_ERR_INFO_ADDR  (0x70400c)
+#define NBL_DSTORE_COR_ERR_INFO_DEPTH (1)
+#define NBL_DSTORE_COR_ERR_INFO_WIDTH (32)
+#define NBL_DSTORE_COR_ERR_INFO_DWLEN (1)
+union dstore_cor_err_info_u {
+	struct dstore_cor_err_info {
+		u32 ram_addr:10;         /* [9:0] Default:0x0 RO */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 ram_id:4;            /* [19:16] Default:0x0 RO */
+		u32 rsv:12;              /* [31:20] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_COR_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PARITY_ERR_INFO_ADDR  (0x704014)
+#define NBL_DSTORE_PARITY_ERR_INFO_DEPTH (1)
+#define NBL_DSTORE_PARITY_ERR_INFO_WIDTH (32)
+#define NBL_DSTORE_PARITY_ERR_INFO_DWLEN (1)
+union dstore_parity_err_info_u {
+	struct dstore_parity_err_info {
+		u32 ram_addr:10;         /* [9:0] Default:0x0 RO */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 ram_id:4;            /* [19:16] Default:0x0 RO */
+		u32 rsv:12;              /* [31:20] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_PARITY_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_CIF_ERR_INFO_ADDR  (0x70401c)
+#define NBL_DSTORE_CIF_ERR_INFO_DEPTH (1)
+#define NBL_DSTORE_CIF_ERR_INFO_WIDTH (32)
+#define NBL_DSTORE_CIF_ERR_INFO_DWLEN (1)
+union dstore_cif_err_info_u {
+	struct dstore_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_CAR_CTRL_ADDR  (0x704100)
+#define NBL_DSTORE_CAR_CTRL_DEPTH (1)
+#define NBL_DSTORE_CAR_CTRL_WIDTH (32)
+#define NBL_DSTORE_CAR_CTRL_DWLEN (1)
+union dstore_car_ctrl_u {
+	struct dstore_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_INIT_START_ADDR  (0x704104)
+#define NBL_DSTORE_INIT_START_DEPTH (1)
+#define NBL_DSTORE_INIT_START_WIDTH (32)
+#define NBL_DSTORE_INIT_START_DWLEN (1)
+union dstore_init_start_u {
+	struct dstore_init_start {
+		u32 init_start:1;        /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PKT_LEN_ADDR  (0x704108)
+#define NBL_DSTORE_PKT_LEN_DEPTH (1)
+#define NBL_DSTORE_PKT_LEN_WIDTH (32)
+#define NBL_DSTORE_PKT_LEN_DWLEN (1)
+union dstore_pkt_len_u {
+	struct dstore_pkt_len {
+		u32 min:7;               /* [6:0] Default:60 RW */
+		u32 rsv1:8;              /* [14:7] Default:0x0 RO */
+		u32 min_chk_en:1;        /* [15] Default:0x0 RW */
+		u32 max:14;              /* [29:16] Default:9600 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 max_chk_en:1;        /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_PKT_LEN_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_SCH_PD_BUFFER_TH_ADDR  (0x704128)
+#define NBL_DSTORE_SCH_PD_BUFFER_TH_DEPTH (1)
+#define NBL_DSTORE_SCH_PD_BUFFER_TH_WIDTH (32)
+#define NBL_DSTORE_SCH_PD_BUFFER_TH_DWLEN (1)
+union dstore_sch_pd_buffer_th_u {
+	struct dstore_sch_pd_buffer_th {
+		u32 aful_th:9;           /* [8:0] Default:500 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_SCH_PD_BUFFER_TH_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_GLB_FC_TH_ADDR  (0x70412c)
+#define NBL_DSTORE_GLB_FC_TH_DEPTH (1)
+#define NBL_DSTORE_GLB_FC_TH_WIDTH (32)
+#define NBL_DSTORE_GLB_FC_TH_DWLEN (1)
+union dstore_glb_fc_th_u {
+	struct dstore_glb_fc_th {
+		u32 xoff_th:10;          /* [9:0] Default:900 RW */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 xon_th:10;           /* [25:16] Default:850 RW */
+		u32 rsv:5;               /* [30:26] Default:0x0 RO */
+		u32 fc_en:1;             /* [31:31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_GLB_FC_TH_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_GLB_DROP_TH_ADDR  (0x704130)
+#define NBL_DSTORE_GLB_DROP_TH_DEPTH (1)
+#define NBL_DSTORE_GLB_DROP_TH_WIDTH (32)
+#define NBL_DSTORE_GLB_DROP_TH_DWLEN (1)
+union dstore_glb_drop_th_u {
+	struct dstore_glb_drop_th {
+		u32 disc_th:10;          /* [9:0] Default:985 RW */
+		u32 rsv:21;              /* [30:10] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_GLB_DROP_TH_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PORT_FC_TH_ADDR  (0x704134)
+#define NBL_DSTORE_PORT_FC_TH_DEPTH (6)
+#define NBL_DSTORE_PORT_FC_TH_WIDTH (32)
+#define NBL_DSTORE_PORT_FC_TH_DWLEN (1)
+union dstore_port_fc_th_u {
+	struct dstore_port_fc_th {
+		u32 xoff_th:10;          /* [9:0] Default:400 RW */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 xon_th:10;           /* [25:16] Default:400 RW */
+		u32 rsv:4;               /* [29:26] Default:0x0 RO */
+		u32 fc_set:1;            /* [30:30] Default:0x0 RW */
+		u32 fc_en:1;             /* [31:31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_PORT_FC_TH_DWLEN];
+} __packed;
+#define NBL_DSTORE_PORT_FC_TH_REG(r) (NBL_DSTORE_PORT_FC_TH_ADDR + \
+		(NBL_DSTORE_PORT_FC_TH_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_PORT_DROP_TH_ADDR  (0x704150)
+#define NBL_DSTORE_PORT_DROP_TH_DEPTH (6)
+#define NBL_DSTORE_PORT_DROP_TH_WIDTH (32)
+#define NBL_DSTORE_PORT_DROP_TH_DWLEN (1)
+union dstore_port_drop_th_u {
+	struct dstore_port_drop_th {
+		u32 disc_th:10;          /* [9:0] Default:800 RW */
+		u32 rsv:21;              /* [30:10] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_PORT_DROP_TH_DWLEN];
+} __packed;
+#define NBL_DSTORE_PORT_DROP_TH_REG(r) (NBL_DSTORE_PORT_DROP_TH_ADDR + \
+		(NBL_DSTORE_PORT_DROP_TH_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_CFG_TEST_ADDR  (0x704170)
+#define NBL_DSTORE_CFG_TEST_DEPTH (1)
+#define NBL_DSTORE_CFG_TEST_WIDTH (32)
+#define NBL_DSTORE_CFG_TEST_DWLEN (1)
+union dstore_cfg_test_u {
+	struct dstore_cfg_test {
+		u32 test:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_HIGH_PRI_PKT_ADDR  (0x70417c)
+#define NBL_DSTORE_HIGH_PRI_PKT_DEPTH (1)
+#define NBL_DSTORE_HIGH_PRI_PKT_WIDTH (32)
+#define NBL_DSTORE_HIGH_PRI_PKT_DWLEN (1)
+union dstore_high_pri_pkt_u {
+	struct dstore_high_pri_pkt {
+		u32 en:1;                /* [0:0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_HIGH_PRI_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_COS_FC_TH_ADDR  (0x704200)
+#define NBL_DSTORE_COS_FC_TH_DEPTH (48)
+#define NBL_DSTORE_COS_FC_TH_WIDTH (32)
+#define NBL_DSTORE_COS_FC_TH_DWLEN (1)
+union dstore_cos_fc_th_u {
+	struct dstore_cos_fc_th {
+		u32 xoff_th:10;          /* [9:0] Default:100 RW */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 xon_th:10;           /* [25:16] Default:100 RW */
+		u32 rsv:4;               /* [29:26] Default:0x0 RO */
+		u32 fc_set:1;            /* [30:30] Default:0x0 RW */
+		u32 fc_en:1;             /* [31:31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_COS_FC_TH_DWLEN];
+} __packed;
+#define NBL_DSTORE_COS_FC_TH_REG(r) (NBL_DSTORE_COS_FC_TH_ADDR + \
+		(NBL_DSTORE_COS_FC_TH_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_COS_DROP_TH_ADDR  (0x704300)
+#define NBL_DSTORE_COS_DROP_TH_DEPTH (48)
+#define NBL_DSTORE_COS_DROP_TH_WIDTH (32)
+#define NBL_DSTORE_COS_DROP_TH_DWLEN (1)
+union dstore_cos_drop_th_u {
+	struct dstore_cos_drop_th {
+		u32 disc_th:10;          /* [9:0] Default:120 RW */
+		u32 rsv:21;              /* [30:10] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_COS_DROP_TH_DWLEN];
+} __packed;
+#define NBL_DSTORE_COS_DROP_TH_REG(r) (NBL_DSTORE_COS_DROP_TH_ADDR + \
+		(NBL_DSTORE_COS_DROP_TH_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_SCH_PD_WRR_WGT_ADDR  (0x704400)
+#define NBL_DSTORE_SCH_PD_WRR_WGT_DEPTH (36)
+#define NBL_DSTORE_SCH_PD_WRR_WGT_WIDTH (32)
+#define NBL_DSTORE_SCH_PD_WRR_WGT_DWLEN (1)
+union dstore_sch_pd_wrr_wgt_u {
+	struct dstore_sch_pd_wrr_wgt {
+		u32 wgt_cos:4;           /* [3:0] Default:0x0 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_SCH_PD_WRR_WGT_DWLEN];
+} __packed;
+#define NBL_DSTORE_SCH_PD_WRR_WGT_REG(r) (NBL_DSTORE_SCH_PD_WRR_WGT_ADDR + \
+		(NBL_DSTORE_SCH_PD_WRR_WGT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_COS7_FORCE_ADDR  (0x704504)
+#define NBL_DSTORE_COS7_FORCE_DEPTH (1)
+#define NBL_DSTORE_COS7_FORCE_WIDTH (32)
+#define NBL_DSTORE_COS7_FORCE_DWLEN (1)
+union dstore_cos7_force_u {
+	struct dstore_cos7_force {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_COS7_FORCE_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_D_DPORT_FC_TH_ADDR  (0x704600)
+#define NBL_DSTORE_D_DPORT_FC_TH_DEPTH (5)
+#define NBL_DSTORE_D_DPORT_FC_TH_WIDTH (32)
+#define NBL_DSTORE_D_DPORT_FC_TH_DWLEN (1)
+union dstore_d_dport_fc_th_u {
+	struct dstore_d_dport_fc_th {
+		u32 xoff_th:11;          /* [10:0] Default:200 RW */
+		u32 rsv1:5;              /* [15:11] Default:0x0 RO */
+		u32 xon_th:11;           /* [26:16] Default:100 RW */
+		u32 rsv:3;               /* [29:27] Default:0x0 RO */
+		u32 fc_set:1;            /* [30:30] Default:0x0 RW */
+		u32 fc_en:1;             /* [31:31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_D_DPORT_FC_TH_DWLEN];
+} __packed;
+#define NBL_DSTORE_D_DPORT_FC_TH_REG(r) (NBL_DSTORE_D_DPORT_FC_TH_ADDR + \
+		(NBL_DSTORE_D_DPORT_FC_TH_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_INIT_DONE_ADDR  (0x704800)
+#define NBL_DSTORE_INIT_DONE_DEPTH (1)
+#define NBL_DSTORE_INIT_DONE_WIDTH (32)
+#define NBL_DSTORE_INIT_DONE_DWLEN (1)
+union dstore_init_done_u {
+	struct dstore_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_SCH_IDLE_LIST_STATUS_CURR_ADDR  (0x70481c)
+#define NBL_DSTORE_SCH_IDLE_LIST_STATUS_CURR_DEPTH (1)
+#define NBL_DSTORE_SCH_IDLE_LIST_STATUS_CURR_WIDTH (32)
+#define NBL_DSTORE_SCH_IDLE_LIST_STATUS_CURR_DWLEN (1)
+union dstore_sch_idle_list_status_curr_u {
+	struct dstore_sch_idle_list_status_curr {
+		u32 empt:1;              /* [0] Default:0x0 RO */
+		u32 full:1;              /* [1] Default:0x1 RO */
+		u32 cnt:10;              /* [11:2] Default:0x200 RO */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_SCH_IDLE_LIST_STATUS_CURR_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_SCH_QUE_LIST_STATUS_ADDR  (0x704820)
+#define NBL_DSTORE_SCH_QUE_LIST_STATUS_DEPTH (48)
+#define NBL_DSTORE_SCH_QUE_LIST_STATUS_WIDTH (32)
+#define NBL_DSTORE_SCH_QUE_LIST_STATUS_DWLEN (1)
+union dstore_sch_que_list_status_u {
+	struct dstore_sch_que_list_status {
+		u32 curr_empt:1;         /* [0] Default:0x1 RO */
+		u32 curr_cnt:10;         /* [10:1] Default:0x0 RO */
+		u32 history_udf:1;       /* [11] Default:0x0 RC */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_SCH_QUE_LIST_STATUS_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_PKT_ADDR  (0x705050)
+#define NBL_DSTORE_RCV_TOTAL_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_PKT_DWLEN (1)
+union dstore_rcv_total_pkt_u {
+	struct dstore_rcv_total_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_BYTE_ADDR  (0x705054)
+#define NBL_DSTORE_RCV_TOTAL_BYTE_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_BYTE_WIDTH (48)
+#define NBL_DSTORE_RCV_TOTAL_BYTE_DWLEN (2)
+union dstore_rcv_total_byte_u {
+	struct dstore_rcv_total_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_BYTE_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_RIGHT_PKT_ADDR  (0x70505c)
+#define NBL_DSTORE_RCV_TOTAL_RIGHT_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_total_right_pkt_u {
+	struct dstore_rcv_total_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_WRONG_PKT_ADDR  (0x705060)
+#define NBL_DSTORE_RCV_TOTAL_WRONG_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_WRONG_PKT_DWLEN (1)
+union dstore_rcv_total_wrong_pkt_u {
+	struct dstore_rcv_total_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_FWD_RIGHT_PKT_ADDR  (0x705064)
+#define NBL_DSTORE_RCV_FWD_RIGHT_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_FWD_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_FWD_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_fwd_right_pkt_u {
+	struct dstore_rcv_fwd_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_FWD_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_FWD_WRONG_PKT_ADDR  (0x705068)
+#define NBL_DSTORE_RCV_FWD_WRONG_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_FWD_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_FWD_WRONG_PKT_DWLEN (1)
+union dstore_rcv_fwd_wrong_pkt_u {
+	struct dstore_rcv_fwd_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_FWD_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_HERR_RIGHT_PKT_ADDR  (0x70506c)
+#define NBL_DSTORE_RCV_HERR_RIGHT_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_HERR_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_HERR_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_herr_right_pkt_u {
+	struct dstore_rcv_herr_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_HERR_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_HERR_WRONG_PKT_ADDR  (0x705070)
+#define NBL_DSTORE_RCV_HERR_WRONG_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_HERR_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_HERR_WRONG_PKT_DWLEN (1)
+union dstore_rcv_herr_wrong_pkt_u {
+	struct dstore_rcv_herr_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_HERR_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_TOTAL_PKT_ADDR  (0x705074)
+#define NBL_DSTORE_IPRO_TOTAL_PKT_DEPTH (1)
+#define NBL_DSTORE_IPRO_TOTAL_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_TOTAL_PKT_DWLEN (1)
+union dstore_ipro_total_pkt_u {
+	struct dstore_ipro_total_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_TOTAL_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_TOTAL_BYTE_ADDR  (0x705078)
+#define NBL_DSTORE_IPRO_TOTAL_BYTE_DEPTH (1)
+#define NBL_DSTORE_IPRO_TOTAL_BYTE_WIDTH (48)
+#define NBL_DSTORE_IPRO_TOTAL_BYTE_DWLEN (2)
+union dstore_ipro_total_byte_u {
+	struct dstore_ipro_total_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_TOTAL_BYTE_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_FWD_RIGHT_PKT_ADDR  (0x705080)
+#define NBL_DSTORE_IPRO_FWD_RIGHT_PKT_DEPTH (1)
+#define NBL_DSTORE_IPRO_FWD_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_FWD_RIGHT_PKT_DWLEN (1)
+union dstore_ipro_fwd_right_pkt_u {
+	struct dstore_ipro_fwd_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_FWD_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_FWD_WRONG_PKT_ADDR  (0x705084)
+#define NBL_DSTORE_IPRO_FWD_WRONG_PKT_DEPTH (1)
+#define NBL_DSTORE_IPRO_FWD_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_FWD_WRONG_PKT_DWLEN (1)
+union dstore_ipro_fwd_wrong_pkt_u {
+	struct dstore_ipro_fwd_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_FWD_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_HERR_RIGHT_PKT_ADDR  (0x705088)
+#define NBL_DSTORE_IPRO_HERR_RIGHT_PKT_DEPTH (1)
+#define NBL_DSTORE_IPRO_HERR_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_HERR_RIGHT_PKT_DWLEN (1)
+union dstore_ipro_herr_right_pkt_u {
+	struct dstore_ipro_herr_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_HERR_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_HERR_WRONG_PKT_ADDR  (0x70508c)
+#define NBL_DSTORE_IPRO_HERR_WRONG_PKT_DEPTH (1)
+#define NBL_DSTORE_IPRO_HERR_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_HERR_WRONG_PKT_DWLEN (1)
+union dstore_ipro_herr_wrong_pkt_u {
+	struct dstore_ipro_herr_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_HERR_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PMEM_TOTAL_PKT_ADDR  (0x705090)
+#define NBL_DSTORE_PMEM_TOTAL_PKT_DEPTH (1)
+#define NBL_DSTORE_PMEM_TOTAL_PKT_WIDTH (32)
+#define NBL_DSTORE_PMEM_TOTAL_PKT_DWLEN (1)
+union dstore_pmem_total_pkt_u {
+	struct dstore_pmem_total_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_PMEM_TOTAL_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PMEM_TOTAL_BYTE_ADDR  (0x705094)
+#define NBL_DSTORE_PMEM_TOTAL_BYTE_DEPTH (1)
+#define NBL_DSTORE_PMEM_TOTAL_BYTE_WIDTH (48)
+#define NBL_DSTORE_PMEM_TOTAL_BYTE_DWLEN (2)
+union dstore_pmem_total_byte_u {
+	struct dstore_pmem_total_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_PMEM_TOTAL_BYTE_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_ERR_DROP_PKT_ADDR  (0x70509c)
+#define NBL_DSTORE_RCV_TOTAL_ERR_DROP_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_ERR_DROP_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_ERR_DROP_PKT_DWLEN (1)
+union dstore_rcv_total_err_drop_pkt_u {
+	struct dstore_rcv_total_err_drop_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_ERR_DROP_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_SHORT_PKT_ADDR  (0x7050a0)
+#define NBL_DSTORE_RCV_TOTAL_SHORT_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_SHORT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_SHORT_PKT_DWLEN (1)
+union dstore_rcv_total_short_pkt_u {
+	struct dstore_rcv_total_short_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_SHORT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_LONG_PKT_ADDR  (0x7050a4)
+#define NBL_DSTORE_RCV_TOTAL_LONG_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_LONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_LONG_PKT_DWLEN (1)
+union dstore_rcv_total_long_pkt_u {
+	struct dstore_rcv_total_long_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_LONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BUF_TOTAL_DROP_PKT_ADDR  (0x7050a8)
+#define NBL_DSTORE_BUF_TOTAL_DROP_PKT_DEPTH (1)
+#define NBL_DSTORE_BUF_TOTAL_DROP_PKT_WIDTH (32)
+#define NBL_DSTORE_BUF_TOTAL_DROP_PKT_DWLEN (1)
+union dstore_buf_total_drop_pkt_u {
+	struct dstore_buf_total_drop_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_BUF_TOTAL_DROP_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BUF_TOTAL_TRUN_PKT_ADDR  (0x7050ac)
+#define NBL_DSTORE_BUF_TOTAL_TRUN_PKT_DEPTH (1)
+#define NBL_DSTORE_BUF_TOTAL_TRUN_PKT_WIDTH (32)
+#define NBL_DSTORE_BUF_TOTAL_TRUN_PKT_DWLEN (1)
+union dstore_buf_total_trun_pkt_u {
+	struct dstore_buf_total_trun_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_BUF_TOTAL_TRUN_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_PORT_PKT_ADDR  (0x706000)
+#define NBL_DSTORE_RCV_PORT_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_PKT_DWLEN (1)
+union dstore_rcv_port_pkt_u {
+	struct dstore_rcv_port_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_PKT_REG(r) (NBL_DSTORE_RCV_PORT_PKT_ADDR + \
+		(NBL_DSTORE_RCV_PORT_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_BYTE_ADDR  (0x706040)
+#define NBL_DSTORE_RCV_PORT_BYTE_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_BYTE_WIDTH (48)
+#define NBL_DSTORE_RCV_PORT_BYTE_DWLEN (2)
+union dstore_rcv_port_byte_u {
+	struct dstore_rcv_port_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_BYTE_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_BYTE_REG(r) (NBL_DSTORE_RCV_PORT_BYTE_ADDR + \
+		(NBL_DSTORE_RCV_PORT_BYTE_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_ADDR  (0x7060c0)
+#define NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_port_total_right_pkt_u {
+	struct dstore_rcv_port_total_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_ADDR  (0x706100)
+#define NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_DWLEN (1)
+union dstore_rcv_port_total_wrong_pkt_u {
+	struct dstore_rcv_port_total_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_ADDR  (0x706140)
+#define NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_port_fwd_right_pkt_u {
+	struct dstore_rcv_port_fwd_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_ADDR  (0x706180)
+#define NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_DWLEN (1)
+union dstore_rcv_port_fwd_wrong_pkt_u {
+	struct dstore_rcv_port_fwd_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_ADDR  (0x7061c0)
+#define NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_port_herr_right_pkt_u {
+	struct dstore_rcv_port_herr_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_ADDR  (0x706200)
+#define NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_DWLEN (1)
+union dstore_rcv_port_herr_wrong_pkt_u {
+	struct dstore_rcv_port_herr_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_PORT_PKT_ADDR  (0x706240)
+#define NBL_DSTORE_IPRO_PORT_PKT_DEPTH (12)
+#define NBL_DSTORE_IPRO_PORT_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_PORT_PKT_DWLEN (1)
+union dstore_ipro_port_pkt_u {
+	struct dstore_ipro_port_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_PORT_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_IPRO_PORT_PKT_REG(r) (NBL_DSTORE_IPRO_PORT_PKT_ADDR + \
+		(NBL_DSTORE_IPRO_PORT_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_IPRO_PORT_BYTE_ADDR  (0x706280)
+#define NBL_DSTORE_IPRO_PORT_BYTE_DEPTH (12)
+#define NBL_DSTORE_IPRO_PORT_BYTE_WIDTH (48)
+#define NBL_DSTORE_IPRO_PORT_BYTE_DWLEN (2)
+union dstore_ipro_port_byte_u {
+	struct dstore_ipro_port_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_PORT_BYTE_DWLEN];
+} __packed;
+#define NBL_DSTORE_IPRO_PORT_BYTE_REG(r) (NBL_DSTORE_IPRO_PORT_BYTE_ADDR + \
+		(NBL_DSTORE_IPRO_PORT_BYTE_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_ADDR  (0x706300)
+#define NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_DEPTH (12)
+#define NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_DWLEN (1)
+union dstore_ipro_port_fwd_right_pkt_u {
+	struct dstore_ipro_port_fwd_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_ADDR  (0x706340)
+#define NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_DEPTH (12)
+#define NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_DWLEN (1)
+union dstore_ipro_port_fwd_wrong_pkt_u {
+	struct dstore_ipro_port_fwd_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PMEM_PORT_PKT_ADDR  (0x706380)
+#define NBL_DSTORE_PMEM_PORT_PKT_DEPTH (12)
+#define NBL_DSTORE_PMEM_PORT_PKT_WIDTH (32)
+#define NBL_DSTORE_PMEM_PORT_PKT_DWLEN (1)
+union dstore_pmem_port_pkt_u {
+	struct dstore_pmem_port_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_PMEM_PORT_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_PMEM_PORT_PKT_REG(r) (NBL_DSTORE_PMEM_PORT_PKT_ADDR + \
+		(NBL_DSTORE_PMEM_PORT_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_PMEM_PORT_BYTE_ADDR  (0x7063c0)
+#define NBL_DSTORE_PMEM_PORT_BYTE_DEPTH (12)
+#define NBL_DSTORE_PMEM_PORT_BYTE_WIDTH (48)
+#define NBL_DSTORE_PMEM_PORT_BYTE_DWLEN (2)
+union dstore_pmem_port_byte_u {
+	struct dstore_pmem_port_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_PMEM_PORT_BYTE_DWLEN];
+} __packed;
+#define NBL_DSTORE_PMEM_PORT_BYTE_REG(r) (NBL_DSTORE_PMEM_PORT_BYTE_ADDR + \
+		(NBL_DSTORE_PMEM_PORT_BYTE_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_ADDR  (0x706440)
+#define NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_DWLEN (1)
+union dstore_rcv_err_port_drop_pkt_u {
+	struct dstore_rcv_err_port_drop_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_ADDR  (0x706480)
+#define NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_DWLEN (1)
+union dstore_rcv_port_short_drop_pkt_u {
+	struct dstore_rcv_port_short_drop_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_PORT_LONG_PKT_ADDR  (0x7064c0)
+#define NBL_DSTORE_RCV_PORT_LONG_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_LONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_LONG_PKT_DWLEN (1)
+union dstore_rcv_port_long_pkt_u {
+	struct dstore_rcv_port_long_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_LONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BUF_PORT_DROP_PKT_ADDR  (0x706500)
+#define NBL_DSTORE_BUF_PORT_DROP_PKT_DEPTH (12)
+#define NBL_DSTORE_BUF_PORT_DROP_PKT_WIDTH (32)
+#define NBL_DSTORE_BUF_PORT_DROP_PKT_DWLEN (1)
+union dstore_buf_port_drop_pkt_u {
+	struct dstore_buf_port_drop_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_BUF_PORT_DROP_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BUF_PORT_TRUN_PKT_ADDR  (0x706540)
+#define NBL_DSTORE_BUF_PORT_TRUN_PKT_DEPTH (12)
+#define NBL_DSTORE_BUF_PORT_TRUN_PKT_WIDTH (32)
+#define NBL_DSTORE_BUF_PORT_TRUN_PKT_DWLEN (1)
+union dstore_buf_port_trun_pkt_u {
+	struct dstore_buf_port_trun_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_BUF_PORT_TRUN_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BP_CUR_1ST_ADDR  (0x706580)
+#define NBL_DSTORE_BP_CUR_1ST_DEPTH (1)
+#define NBL_DSTORE_BP_CUR_1ST_WIDTH (32)
+#define NBL_DSTORE_BP_CUR_1ST_DWLEN (1)
+union dstore_bp_cur_1st_u {
+	struct dstore_bp_cur_1st {
+		u32 link_fc:6;           /* [5:0] Default:0x0 RO */
+		u32 rsv:2;               /* [7:6] Default:0x0 RO */
+		u32 pfc:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_BP_CUR_1ST_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BP_CUR_2ND_ADDR  (0x706584)
+#define NBL_DSTORE_BP_CUR_2ND_DEPTH (1)
+#define NBL_DSTORE_BP_CUR_2ND_WIDTH (32)
+#define NBL_DSTORE_BP_CUR_2ND_DWLEN (1)
+union dstore_bp_cur_2nd_u {
+	struct dstore_bp_cur_2nd {
+		u32 pfc:24;              /* [23:0] Default:0x0 RO */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_BP_CUR_2ND_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BP_HISTORY_LINK_ADDR  (0x706590)
+#define NBL_DSTORE_BP_HISTORY_LINK_DEPTH (6)
+#define NBL_DSTORE_BP_HISTORY_LINK_WIDTH (32)
+#define NBL_DSTORE_BP_HISTORY_LINK_DWLEN (1)
+union dstore_bp_history_link_u {
+	struct dstore_bp_history_link {
+		u32 fc:1;                /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_BP_HISTORY_LINK_DWLEN];
+} __packed;
+#define NBL_DSTORE_BP_HISTORY_LINK_REG(r) (NBL_DSTORE_BP_HISTORY_LINK_ADDR + \
+		(NBL_DSTORE_BP_HISTORY_LINK_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_BP_HISTORY_ADDR  (0x7065b0)
+#define NBL_DSTORE_BP_HISTORY_DEPTH (48)
+#define NBL_DSTORE_BP_HISTORY_WIDTH (32)
+#define NBL_DSTORE_BP_HISTORY_DWLEN (1)
+union dstore_bp_history_u {
+	struct dstore_bp_history {
+		u32 pfc:1;               /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_BP_HISTORY_DWLEN];
+} __packed;
+#define NBL_DSTORE_BP_HISTORY_REG(r) (NBL_DSTORE_BP_HISTORY_ADDR + \
+		(NBL_DSTORE_BP_HISTORY_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_WRR_CUR_ADDR  (0x706800)
+#define NBL_DSTORE_WRR_CUR_DEPTH (36)
+#define NBL_DSTORE_WRR_CUR_WIDTH (32)
+#define NBL_DSTORE_WRR_CUR_DWLEN (1)
+union dstore_wrr_cur_u {
+	struct dstore_wrr_cur {
+		u32 wgt_cos:5;           /* [4:0] Default:0x0 RO */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_WRR_CUR_DWLEN];
+} __packed;
+#define NBL_DSTORE_WRR_CUR_REG(r) (NBL_DSTORE_WRR_CUR_ADDR + \
+		(NBL_DSTORE_WRR_CUR_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_DDPORT_CUR_ADDR  (0x707018)
+#define NBL_DSTORE_DDPORT_CUR_DEPTH (1)
+#define NBL_DSTORE_DDPORT_CUR_WIDTH (32)
+#define NBL_DSTORE_DDPORT_CUR_DWLEN (1)
+union dstore_ddport_cur_u {
+	struct dstore_ddport_cur {
+		u32 link_fc:5;           /* [4:0] Default:0x0 RO */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_DDPORT_CUR_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_DDPORT_HISTORY_ADDR  (0x70701c)
+#define NBL_DSTORE_DDPORT_HISTORY_DEPTH (5)
+#define NBL_DSTORE_DDPORT_HISTORY_WIDTH (32)
+#define NBL_DSTORE_DDPORT_HISTORY_DWLEN (1)
+union dstore_ddport_history_u {
+	struct dstore_ddport_history {
+		u32 link_fc:1;           /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_DDPORT_HISTORY_DWLEN];
+} __packed;
+#define NBL_DSTORE_DDPORT_HISTORY_REG(r) (NBL_DSTORE_DDPORT_HISTORY_ADDR + \
+		(NBL_DSTORE_DDPORT_HISTORY_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_DDPORT_RSC_ADD_ADDR  (0x707050)
+#define NBL_DSTORE_DDPORT_RSC_ADD_DEPTH (5)
+#define NBL_DSTORE_DDPORT_RSC_ADD_WIDTH (32)
+#define NBL_DSTORE_DDPORT_RSC_ADD_DWLEN (1)
+union dstore_ddport_rsc_add_u {
+	struct dstore_ddport_rsc_add {
+		u32 cnt:12;              /* [11:0] Default:0x0 RO */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_DDPORT_RSC_ADD_DWLEN];
+} __packed;
+#define NBL_DSTORE_DDPORT_RSC_ADD_REG(r) (NBL_DSTORE_DDPORT_RSC_ADD_ADDR + \
+		(NBL_DSTORE_DDPORT_RSC_ADD_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h
new file mode 100644
index 000000000000..3504c272c4d4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h
@@ -0,0 +1,414 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_UCAR_H
+#define NBL_UCAR_H 1
+
+#include <linux/types.h>
+
+#define NBL_UCAR_BASE (0x00E84000)
+
+#define NBL_UCAR_INT_STATUS_ADDR  (0xe84000)
+#define NBL_UCAR_INT_STATUS_DEPTH (1)
+#define NBL_UCAR_INT_STATUS_WIDTH (32)
+#define NBL_UCAR_INT_STATUS_DWLEN (1)
+union ucar_int_status_u {
+	struct ucar_int_status {
+		u32 color_err:1;         /* [0] Default:0x0 RWC */
+		u32 parity_err:1;        /* [1] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 cif_err:1;           /* [3] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [4] Default:0x0 RWC */
+		u32 atid_nomat_err:1;    /* [5] Default:0x0 RWC */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_UCAR_INT_MASK_ADDR  (0xe84004)
+#define NBL_UCAR_INT_MASK_DEPTH (1)
+#define NBL_UCAR_INT_MASK_WIDTH (32)
+#define NBL_UCAR_INT_MASK_DWLEN (1)
+union ucar_int_mask_u {
+	struct ucar_int_mask {
+		u32 color_err:1;         /* [0] Default:0x1 RW */
+		u32 parity_err:1;        /* [1] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 RW */
+		u32 cif_err:1;           /* [3] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [4] Default:0x0 RW */
+		u32 atid_nomat_err:1;    /* [5] Default:0x1 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_UCAR_INT_SET_ADDR  (0xe84008)
+#define NBL_UCAR_INT_SET_DEPTH (1)
+#define NBL_UCAR_INT_SET_WIDTH (32)
+#define NBL_UCAR_INT_SET_DWLEN (1)
+union ucar_int_set_u {
+	struct ucar_int_set {
+		u32 color_err:1;         /* [0] Default:0x0 WO */
+		u32 parity_err:1;        /* [1] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 WO */
+		u32 cif_err:1;           /* [3] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [4] Default:0x0 WO */
+		u32 atid_nomat_err:1;    /* [5] Default:0x0 WO */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_UCAR_PARITY_ERR_INFO_ADDR  (0xe84104)
+#define NBL_UCAR_PARITY_ERR_INFO_DEPTH (1)
+#define NBL_UCAR_PARITY_ERR_INFO_WIDTH (32)
+#define NBL_UCAR_PARITY_ERR_INFO_DWLEN (1)
+union ucar_parity_err_info_u {
+	struct ucar_parity_err_info {
+		u32 ram_addr:12;         /* [11:0] Default:0x0 RO */
+		u32 ram_id:3;            /* [14:12] Default:0x0 RO */
+		u32 rsv:17;              /* [31:15] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_PARITY_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UCAR_CIF_ERR_INFO_ADDR  (0xe8411c)
+#define NBL_UCAR_CIF_ERR_INFO_DEPTH (1)
+#define NBL_UCAR_CIF_ERR_INFO_WIDTH (32)
+#define NBL_UCAR_CIF_ERR_INFO_DWLEN (1)
+union ucar_cif_err_info_u {
+	struct ucar_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UCAR_ATID_NOMAT_ERR_INFO_ADDR  (0xe84134)
+#define NBL_UCAR_ATID_NOMAT_ERR_INFO_DEPTH (1)
+#define NBL_UCAR_ATID_NOMAT_ERR_INFO_WIDTH (32)
+#define NBL_UCAR_ATID_NOMAT_ERR_INFO_DWLEN (1)
+union ucar_atid_nomat_err_info_u {
+	struct ucar_atid_nomat_err_info {
+		u32 id:2;                /* [1:0] Default:0x0 RO */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_ATID_NOMAT_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UCAR_CAR_CTRL_ADDR  (0xe84200)
+#define NBL_UCAR_CAR_CTRL_DEPTH (1)
+#define NBL_UCAR_CAR_CTRL_WIDTH (32)
+#define NBL_UCAR_CAR_CTRL_DWLEN (1)
+union ucar_car_ctrl_u {
+	struct ucar_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_INIT_START_ADDR  (0xe84204)
+#define NBL_UCAR_INIT_START_DEPTH (1)
+#define NBL_UCAR_INIT_START_WIDTH (32)
+#define NBL_UCAR_INIT_START_DWLEN (1)
+union ucar_init_start_u {
+	struct ucar_init_start {
+		u32 start:1;             /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FWD_CARID_ADDR  (0xe84210)
+#define NBL_UCAR_FWD_CARID_DEPTH (1)
+#define NBL_UCAR_FWD_CARID_WIDTH (32)
+#define NBL_UCAR_FWD_CARID_DWLEN (1)
+union ucar_fwd_carid_u {
+	struct ucar_fwd_carid {
+		u32 act_id:6;            /* [5:0] Default:0x5 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FWD_CARID_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FWD_FLOW_CAR_ADDR  (0xe84214)
+#define NBL_UCAR_FWD_FLOW_CAR_DEPTH (1)
+#define NBL_UCAR_FWD_FLOW_CAR_WIDTH (32)
+#define NBL_UCAR_FWD_FLOW_CAR_DWLEN (1)
+union ucar_fwd_flow_car_u {
+	struct ucar_fwd_flow_car {
+		u32 act_id:6;            /* [5:0] Default:0x6 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FWD_FLOW_CAR_DWLEN];
+} __packed;
+
+#define NBL_UCAR_PBS_SUB_ADDR  (0xe84224)
+#define NBL_UCAR_PBS_SUB_DEPTH (1)
+#define NBL_UCAR_PBS_SUB_WIDTH (32)
+#define NBL_UCAR_PBS_SUB_DWLEN (1)
+union ucar_pbs_sub_u {
+	struct ucar_pbs_sub {
+		u32 sel:1;               /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_PBS_SUB_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FLOW_TIMMING_ADD_ADDR  (0xe84400)
+#define NBL_UCAR_FLOW_TIMMING_ADD_DEPTH (1)
+#define NBL_UCAR_FLOW_TIMMING_ADD_WIDTH (32)
+#define NBL_UCAR_FLOW_TIMMING_ADD_DWLEN (1)
+union ucar_flow_timming_add_u {
+	struct ucar_flow_timming_add {
+		u32 cycle_max:12;        /* [11:0] Default:0x4 RW */
+		u32 rsv1:4;              /* [15:12] Default:0x0 RO */
+		u32 depth:14;            /* [29:16] Default:0x4B0 RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FLOW_TIMMING_ADD_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FLOW_4K_TIMMING_ADD_ADDR  (0xe84404)
+#define NBL_UCAR_FLOW_4K_TIMMING_ADD_DEPTH (1)
+#define NBL_UCAR_FLOW_4K_TIMMING_ADD_WIDTH (32)
+#define NBL_UCAR_FLOW_4K_TIMMING_ADD_DWLEN (1)
+union ucar_flow_4k_timming_add_u {
+	struct ucar_flow_4k_timming_add {
+		u32 cycle_max:12;        /* [11:0] Default:0x4 RW */
+		u32 depth:18;            /* [29:12] Default:0x12C0 RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FLOW_4K_TIMMING_ADD_DWLEN];
+} __packed;
+
+#define NBL_UCAR_INIT_DONE_ADDR  (0xe84408)
+#define NBL_UCAR_INIT_DONE_DEPTH (1)
+#define NBL_UCAR_INIT_DONE_WIDTH (32)
+#define NBL_UCAR_INIT_DONE_DWLEN (1)
+union ucar_init_done_u {
+	struct ucar_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_UCAR_INPUT_CELL_ADDR  (0xe8441c)
+#define NBL_UCAR_INPUT_CELL_DEPTH (1)
+#define NBL_UCAR_INPUT_CELL_WIDTH (32)
+#define NBL_UCAR_INPUT_CELL_DWLEN (1)
+union ucar_input_cell_u {
+	struct ucar_input_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_INPUT_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_RD_CELL_ADDR  (0xe84420)
+#define NBL_UCAR_RD_CELL_DEPTH (1)
+#define NBL_UCAR_RD_CELL_WIDTH (32)
+#define NBL_UCAR_RD_CELL_DWLEN (1)
+union ucar_rd_cell_u {
+	struct ucar_rd_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_RD_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_CAR_CELL_ADDR  (0xe84424)
+#define NBL_UCAR_CAR_CELL_DEPTH (1)
+#define NBL_UCAR_CAR_CELL_WIDTH (32)
+#define NBL_UCAR_CAR_CELL_DWLEN (1)
+union ucar_car_cell_u {
+	struct ucar_car_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_CAR_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_CAR_FLOW_CELL_ADDR  (0xe84428)
+#define NBL_UCAR_CAR_FLOW_CELL_DEPTH (1)
+#define NBL_UCAR_CAR_FLOW_CELL_WIDTH (32)
+#define NBL_UCAR_CAR_FLOW_CELL_DWLEN (1)
+union ucar_car_flow_cell_u {
+	struct ucar_car_flow_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_CAR_FLOW_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_CAR_FLOW_4K_CELL_ADDR  (0xe8442c)
+#define NBL_UCAR_CAR_FLOW_4K_CELL_DEPTH (1)
+#define NBL_UCAR_CAR_FLOW_4K_CELL_WIDTH (32)
+#define NBL_UCAR_CAR_FLOW_4K_CELL_DWLEN (1)
+union ucar_car_flow_4k_cell_u {
+	struct ucar_car_flow_4k_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_CAR_FLOW_4K_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_NOCAR_CELL_ADDR  (0xe84430)
+#define NBL_UCAR_NOCAR_CELL_DEPTH (1)
+#define NBL_UCAR_NOCAR_CELL_WIDTH (32)
+#define NBL_UCAR_NOCAR_CELL_DWLEN (1)
+union ucar_nocar_cell_u {
+	struct ucar_nocar_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_NOCAR_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_NOCAR_ERR_ADDR  (0xe84434)
+#define NBL_UCAR_NOCAR_ERR_DEPTH (1)
+#define NBL_UCAR_NOCAR_ERR_WIDTH (32)
+#define NBL_UCAR_NOCAR_ERR_DWLEN (1)
+union ucar_nocar_err_u {
+	struct ucar_nocar_err {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_NOCAR_ERR_DWLEN];
+} __packed;
+
+#define NBL_UCAR_GREEN_CELL_ADDR  (0xe84438)
+#define NBL_UCAR_GREEN_CELL_DEPTH (1)
+#define NBL_UCAR_GREEN_CELL_WIDTH (32)
+#define NBL_UCAR_GREEN_CELL_DWLEN (1)
+union ucar_green_cell_u {
+	struct ucar_green_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_GREEN_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_YELLOW_CELL_ADDR  (0xe8443c)
+#define NBL_UCAR_YELLOW_CELL_DEPTH (1)
+#define NBL_UCAR_YELLOW_CELL_WIDTH (32)
+#define NBL_UCAR_YELLOW_CELL_DWLEN (1)
+union ucar_yellow_cell_u {
+	struct ucar_yellow_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_YELLOW_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_RED_CELL_ADDR  (0xe84440)
+#define NBL_UCAR_RED_CELL_DEPTH (1)
+#define NBL_UCAR_RED_CELL_WIDTH (32)
+#define NBL_UCAR_RED_CELL_DWLEN (1)
+union ucar_red_cell_u {
+	struct ucar_red_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_RED_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_NOCAR_PKT_ADDR  (0xe84444)
+#define NBL_UCAR_NOCAR_PKT_DEPTH (1)
+#define NBL_UCAR_NOCAR_PKT_WIDTH (48)
+#define NBL_UCAR_NOCAR_PKT_DWLEN (2)
+union ucar_nocar_pkt_u {
+	struct ucar_nocar_pkt {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_NOCAR_PKT_DWLEN];
+} __packed;
+
+#define NBL_UCAR_GREEN_PKT_ADDR  (0xe8444c)
+#define NBL_UCAR_GREEN_PKT_DEPTH (1)
+#define NBL_UCAR_GREEN_PKT_WIDTH (48)
+#define NBL_UCAR_GREEN_PKT_DWLEN (2)
+union ucar_green_pkt_u {
+	struct ucar_green_pkt {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_GREEN_PKT_DWLEN];
+} __packed;
+
+#define NBL_UCAR_YELLOW_PKT_ADDR  (0xe84454)
+#define NBL_UCAR_YELLOW_PKT_DEPTH (1)
+#define NBL_UCAR_YELLOW_PKT_WIDTH (48)
+#define NBL_UCAR_YELLOW_PKT_DWLEN (2)
+union ucar_yellow_pkt_u {
+	struct ucar_yellow_pkt {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_YELLOW_PKT_DWLEN];
+} __packed;
+
+#define NBL_UCAR_RED_PKT_ADDR  (0xe8445c)
+#define NBL_UCAR_RED_PKT_DEPTH (1)
+#define NBL_UCAR_RED_PKT_WIDTH (48)
+#define NBL_UCAR_RED_PKT_DWLEN (2)
+union ucar_red_pkt_u {
+	struct ucar_red_pkt {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_RED_PKT_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FWD_TYPE_WRONG_CELL_ADDR  (0xe84464)
+#define NBL_UCAR_FWD_TYPE_WRONG_CELL_DEPTH (1)
+#define NBL_UCAR_FWD_TYPE_WRONG_CELL_WIDTH (32)
+#define NBL_UCAR_FWD_TYPE_WRONG_CELL_DWLEN (1)
+union ucar_fwd_type_wrong_cell_u {
+	struct ucar_fwd_type_wrong_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_FWD_TYPE_WRONG_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FLOW_ADDR  (0xe88000)
+#define NBL_UCAR_FLOW_DEPTH (1024)
+#define NBL_UCAR_FLOW_WIDTH (128)
+#define NBL_UCAR_FLOW_DWLEN (4)
+union ucar_flow_u {
+	struct ucar_flow {
+		u32 valid:1;             /* [0] Default:0x0 RW */
+		u32 depth:19;            /* [19:1] Default:0x0 RW */
+		u32 cir:19;              /* [38:20] Default:0x0 RW */
+		u32 pir:19;              /* [57:39] Default:0x0 RW */
+		u32 cbs:21;              /* [78:58] Default:0x0 RW */
+		u32 pbs:21;              /* [99:79] Default:0x0 RW */
+		u32 rsv:28;              /* [127:100] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FLOW_DWLEN];
+} __packed;
+#define NBL_UCAR_FLOW_REG(r) (NBL_UCAR_FLOW_ADDR + \
+		(NBL_UCAR_FLOW_DWLEN * 4) * (r))
+
+#define NBL_UCAR_FLOW_4K_ADDR  (0xe94000)
+#define NBL_UCAR_FLOW_4K_DEPTH (4096)
+#define NBL_UCAR_FLOW_4K_WIDTH (128)
+#define NBL_UCAR_FLOW_4K_DWLEN (4)
+union ucar_flow_4k_u {
+	struct ucar_flow_4k {
+		u32 valid:1;             /* [0] Default:0x0 RW */
+		u32 depth:21;            /* [21:1] Default:0x0 RW */
+		u32 cir:21;              /* [42:22] Default:0x0 RW */
+		u32 pir:21;              /* [63:43] Default:0x0 RW */
+		u32 cbs:23;              /* [86:64] Default:0x0 RW */
+		u32 pbs:23;              /* [109:87] Default:0x0 RW */
+		u32 rsv:18;              /* [127:110] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FLOW_4K_DWLEN];
+} __packed;
+#define NBL_UCAR_FLOW_4K_REG(r) (NBL_UCAR_FLOW_4K_ADDR + \
+		(NBL_UCAR_FLOW_4K_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h
new file mode 100644
index 000000000000..47bda61dbf97
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#include "nbl_ppe_ipro.h"
+#include "nbl_ppe_epro.h"
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h
new file mode 100644
index 000000000000..7c36f4ad11b4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h
@@ -0,0 +1,665 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_EPRO_H
+#define NBL_EPRO_H 1
+
+#include <linux/types.h>
+
+#define NBL_EPRO_BASE (0x00E74000)
+
+#define NBL_EPRO_INT_STATUS_ADDR  (0xe74000)
+#define NBL_EPRO_INT_STATUS_DEPTH (1)
+#define NBL_EPRO_INT_STATUS_WIDTH (32)
+#define NBL_EPRO_INT_STATUS_DWLEN (1)
+union epro_int_status_u {
+	struct epro_int_status {
+		u32 fatal_err:1;         /* [0] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 cif_err:1;           /* [3] Default:0x0 RWC */
+		u32 input_err:1;         /* [4] Default:0x0 RWC */
+		u32 cfg_err:1;           /* [5] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 RWC */
+		u32 data_cor_err:1;      /* [7] Default:0x0 RWC */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_EPRO_INT_MASK_ADDR  (0xe74004)
+#define NBL_EPRO_INT_MASK_DEPTH (1)
+#define NBL_EPRO_INT_MASK_WIDTH (32)
+#define NBL_EPRO_INT_MASK_DWLEN (1)
+union epro_int_mask_u {
+	struct epro_int_mask {
+		u32 fatal_err:1;         /* [0] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RW */
+		u32 cif_err:1;           /* [3] Default:0x0 RW */
+		u32 input_err:1;         /* [4] Default:0x0 RW */
+		u32 cfg_err:1;           /* [5] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 RW */
+		u32 data_cor_err:1;      /* [7] Default:0x0 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_EPRO_INT_SET_ADDR  (0xe74008)
+#define NBL_EPRO_INT_SET_DEPTH (1)
+#define NBL_EPRO_INT_SET_WIDTH (32)
+#define NBL_EPRO_INT_SET_DWLEN (1)
+union epro_int_set_u {
+	struct epro_int_set {
+		u32 fatal_err:1;         /* [0] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 WO */
+		u32 cif_err:1;           /* [3] Default:0x0 WO */
+		u32 input_err:1;         /* [4] Default:0x0 WO */
+		u32 cfg_err:1;           /* [5] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 WO */
+		u32 data_cor_err:1;      /* [7] Default:0x0 WO */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_EPRO_INIT_DONE_ADDR  (0xe7400c)
+#define NBL_EPRO_INIT_DONE_DEPTH (1)
+#define NBL_EPRO_INIT_DONE_WIDTH (32)
+#define NBL_EPRO_INIT_DONE_DWLEN (1)
+union epro_init_done_u {
+	struct epro_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_EPRO_CIF_ERR_INFO_ADDR  (0xe74040)
+#define NBL_EPRO_CIF_ERR_INFO_DEPTH (1)
+#define NBL_EPRO_CIF_ERR_INFO_WIDTH (32)
+#define NBL_EPRO_CIF_ERR_INFO_DWLEN (1)
+union epro_cif_err_info_u {
+	struct epro_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_EPRO_CFG_ERR_INFO_ADDR  (0xe74050)
+#define NBL_EPRO_CFG_ERR_INFO_DEPTH (1)
+#define NBL_EPRO_CFG_ERR_INFO_WIDTH (32)
+#define NBL_EPRO_CFG_ERR_INFO_DWLEN (1)
+union epro_cfg_err_info_u {
+	struct epro_cfg_err_info {
+		u32 addr:10;             /* [9:0] Default:0x0 RO */
+		u32 id:3;                /* [12:10] Default:0x0 RO */
+		u32 rsv:19;              /* [31:13] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_EPRO_CAR_CTRL_ADDR  (0xe74100)
+#define NBL_EPRO_CAR_CTRL_DEPTH (1)
+#define NBL_EPRO_CAR_CTRL_WIDTH (32)
+#define NBL_EPRO_CAR_CTRL_DWLEN (1)
+union epro_car_ctrl_u {
+	struct epro_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_EPRO_INIT_START_ADDR  (0xe74180)
+#define NBL_EPRO_INIT_START_DEPTH (1)
+#define NBL_EPRO_INIT_START_WIDTH (32)
+#define NBL_EPRO_INIT_START_DWLEN (1)
+union epro_init_start_u {
+	struct epro_init_start {
+		u32 start:1;             /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_EPRO_FLAG_SEL_ADDR  (0xe74200)
+#define NBL_EPRO_FLAG_SEL_DEPTH (1)
+#define NBL_EPRO_FLAG_SEL_WIDTH (32)
+#define NBL_EPRO_FLAG_SEL_DWLEN (1)
+union epro_flag_sel_u {
+	struct epro_flag_sel {
+		u32 dir_offset_en:1;     /* [0] Default:0x1 RW */
+		u32 dir_offset:5;        /* [5:1] Default:0x0 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_FLAG_SEL_DWLEN];
+} __packed;
+
+#define NBL_EPRO_ACT_SEL_EN_ADDR  (0xe74214)
+#define NBL_EPRO_ACT_SEL_EN_DEPTH (1)
+#define NBL_EPRO_ACT_SEL_EN_WIDTH (32)
+#define NBL_EPRO_ACT_SEL_EN_DWLEN (1)
+union epro_act_sel_en_u {
+	struct epro_act_sel_en {
+		u32 rssidx_en:1;         /* [0] Default:0x1 RW */
+		u32 dport_en:1;          /* [1] Default:0x1 RW */
+		u32 mirroridx_en:1;      /* [2] Default:0x1 RW */
+		u32 dqueue_en:1;         /* [3] Default:0x1 RW */
+		u32 encap_en:1;          /* [4] Default:0x1 RW */
+		u32 pop_8021q_en:1;      /* [5] Default:0x1 RW */
+		u32 pop_qinq_en:1;       /* [6] Default:0x1 RW */
+		u32 push_cvlan_en:1;     /* [7] Default:0x1 RW */
+		u32 push_svlan_en:1;     /* [8] Default:0x1 RW */
+		u32 replace_cvlan_en:1;  /* [9] Default:0x1 RW */
+		u32 replace_svlan_en:1;  /* [10] Default:0x1 RW */
+		u32 rsv:21;              /* [31:11] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_ACT_SEL_EN_DWLEN];
+} __packed;
+
+#define NBL_EPRO_AM_ACT_ID0_ADDR  (0xe74218)
+#define NBL_EPRO_AM_ACT_ID0_DEPTH (1)
+#define NBL_EPRO_AM_ACT_ID0_WIDTH (32)
+#define NBL_EPRO_AM_ACT_ID0_DWLEN (1)
+union epro_am_act_id0_u {
+	struct epro_am_act_id0 {
+		u32 replace_cvlan:6;     /* [5:0] Default:0x2b RW */
+		u32 rsv3:2;              /* [7:6] Default:0x0 RO */
+		u32 replace_svlan:6;     /* [13:8] Default:0x2a RW */
+		u32 rsv2:2;              /* [15:14] Default:0x0 RO */
+		u32 push_cvlan:6;        /* [21:16] Default:0x2d RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 push_svlan:6;        /* [29:24] Default:0x2c RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_AM_ACT_ID0_DWLEN];
+} __packed;
+
+#define NBL_EPRO_AM_ACT_ID1_ADDR  (0xe7421c)
+#define NBL_EPRO_AM_ACT_ID1_DEPTH (1)
+#define NBL_EPRO_AM_ACT_ID1_WIDTH (32)
+#define NBL_EPRO_AM_ACT_ID1_DWLEN (1)
+union epro_am_act_id1_u {
+	struct epro_am_act_id1 {
+		u32 pop_qinq:6;          /* [5:0] Default:0x29 RW */
+		u32 rsv3:2;              /* [7:6] Default:0x0 RO */
+		u32 pop_8021q:6;         /* [13:08] Default:0x28 RW */
+		u32 rsv2:2;              /* [15:14] Default:0x0 RO */
+		u32 dport:6;             /* [21:16] Default:0x9 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 dqueue:6;            /* [29:24] Default:0xa RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_AM_ACT_ID1_DWLEN];
+} __packed;
+
+#define NBL_EPRO_AM_ACT_ID2_ADDR  (0xe74220)
+#define NBL_EPRO_AM_ACT_ID2_DEPTH (1)
+#define NBL_EPRO_AM_ACT_ID2_WIDTH (32)
+#define NBL_EPRO_AM_ACT_ID2_DWLEN (1)
+union epro_am_act_id2_u {
+	struct epro_am_act_id2 {
+		u32 rssidx:6;            /* [5:0] Default:0x4 RW */
+		u32 rsv3:2;              /* [7:6] Default:0x0 RO */
+		u32 mirroridx:6;         /* [13:8] Default:0x8 RW */
+		u32 rsv2:2;              /* [15:14] Default:0x0 RO */
+		u32 car:6;               /* [21:16] Default:0x5 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 encap:6;             /* [29:24] Default:0x2e RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_AM_ACT_ID2_DWLEN];
+} __packed;
+
+#define NBL_EPRO_AM_ACT_ID3_ADDR  (0xe74224)
+#define NBL_EPRO_AM_ACT_ID3_DEPTH (1)
+#define NBL_EPRO_AM_ACT_ID3_WIDTH (32)
+#define NBL_EPRO_AM_ACT_ID3_DWLEN (1)
+union epro_am_act_id3_u {
+	struct epro_am_act_id3 {
+		u32 outer_sport_mdf:6;   /* [5:0] Default:0x30 RW */
+		u32 rsv3:2;              /* [7:6] Default:0x0 RO */
+		u32 pri_mdf:6;           /* [13:8] Default:0x15 RW */
+		u32 rsv2:2;              /* [15:14] Default:0x0 RO */
+		u32 dp_hash0:6;          /* [21:16] Default:0x13 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 dp_hash1:6;          /* [29:24] Default:0x14 RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_AM_ACT_ID3_DWLEN];
+} __packed;
+
+#define NBL_EPRO_ACTION_PRIORITY_ADDR  (0xe74230)
+#define NBL_EPRO_ACTION_PRIORITY_DEPTH (1)
+#define NBL_EPRO_ACTION_PRIORITY_WIDTH (32)
+#define NBL_EPRO_ACTION_PRIORITY_DWLEN (1)
+union epro_action_priority_u {
+	struct epro_action_priority {
+		u32 mirroridx:2;         /* [1:0] Default:0x0 RW */
+		u32 car:2;               /* [3:2] Default:0x0 RW */
+		u32 dqueue:2;            /* [5:4] Default:0x0 RW */
+		u32 dport:2;             /* [7:6] Default:0x0 RW */
+		u32 pop_8021q:2;         /* [9:8] Default:0x0 RW */
+		u32 pop_qinq:2;          /* [11:10] Default:0x0 RW */
+		u32 replace_inner_vlan:2; /* [13:12] Default:0x0 RW */
+		u32 replace_outer_vlan:2; /* [15:14] Default:0x0 RW */
+		u32 push_inner_vlan:2;   /* [17:16] Default:0x0 RW */
+		u32 push_outer_vlan:2;   /* [19:18] Default:0x0 RW */
+		u32 outer_sport_mdf:2;   /* [21:20] Default:0x0 RW */
+		u32 pri_mdf:2;           /* [23:22] Default:0x0 RW */
+		u32 dp_hash0:2;          /* [25:24] Default:0x0 RW */
+		u32 dp_hash1:2;          /* [27:26] Default:0x0 RW */
+		u32 rsv:4;               /* [31:28] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_ACTION_PRIORITY_DWLEN];
+} __packed;
+
+#define NBL_EPRO_MIRROR_ACTION_PRIORITY_ADDR  (0xe74234)
+#define NBL_EPRO_MIRROR_ACTION_PRIORITY_DEPTH (1)
+#define NBL_EPRO_MIRROR_ACTION_PRIORITY_WIDTH (32)
+#define NBL_EPRO_MIRROR_ACTION_PRIORITY_DWLEN (1)
+union epro_mirror_action_priority_u {
+	struct epro_mirror_action_priority {
+		u32 car:2;               /* [1:0] Default:0x0 RW */
+		u32 dqueue:2;            /* [3:2] Default:0x0 RW */
+		u32 dport:2;             /* [5:4] Default:0x0 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_MIRROR_ACTION_PRIORITY_DWLEN];
+} __packed;
+
+#define NBL_EPRO_SET_FLAGS_ADDR  (0xe74238)
+#define NBL_EPRO_SET_FLAGS_DEPTH (1)
+#define NBL_EPRO_SET_FLAGS_WIDTH (32)
+#define NBL_EPRO_SET_FLAGS_DWLEN (1)
+union epro_set_flags_u {
+	struct epro_set_flags {
+		u32 set_flags:32;        /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_SET_FLAGS_DWLEN];
+} __packed;
+
+#define NBL_EPRO_CLEAR_FLAGS_ADDR  (0xe7423c)
+#define NBL_EPRO_CLEAR_FLAGS_DEPTH (1)
+#define NBL_EPRO_CLEAR_FLAGS_WIDTH (32)
+#define NBL_EPRO_CLEAR_FLAGS_DWLEN (1)
+union epro_clear_flags_u {
+	struct epro_clear_flags {
+		u32 clear_flags:32;      /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_CLEAR_FLAGS_DWLEN];
+} __packed;
+
+#define NBL_EPRO_RSS_SK_ADDR  (0xe74400)
+#define NBL_EPRO_RSS_SK_DEPTH (1)
+#define NBL_EPRO_RSS_SK_WIDTH (320)
+#define NBL_EPRO_RSS_SK_DWLEN (10)
+union epro_rss_sk_u {
+	struct epro_rss_sk {
+		u32 sk_arr[10];          /* [319:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_RSS_SK_DWLEN];
+} __packed;
+
+#define NBL_EPRO_VXLAN_SP_ADDR  (0xe74500)
+#define NBL_EPRO_VXLAN_SP_DEPTH (1)
+#define NBL_EPRO_VXLAN_SP_WIDTH (32)
+#define NBL_EPRO_VXLAN_SP_DWLEN (1)
+union epro_vxlan_sp_u {
+	struct epro_vxlan_sp {
+		u32 vxlan_tnl_sp_min:16; /* [15:0] Default:0x8000 RW */
+		u32 vxlan_tnl_sp_max:16; /* [31:16] Default:0xee48 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_VXLAN_SP_DWLEN];
+} __packed;
+
+#define NBL_EPRO_LOOP_SCH_COS_DEFAULT_ADDR  (0xe74600)
+#define NBL_EPRO_LOOP_SCH_COS_DEFAULT_DEPTH (1)
+#define NBL_EPRO_LOOP_SCH_COS_DEFAULT_WIDTH (32)
+#define NBL_EPRO_LOOP_SCH_COS_DEFAULT_DWLEN (1)
+union epro_loop_sch_cos_default_u {
+	struct epro_loop_sch_cos_default {
+		u32 sch_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 pfc_mode:1;          /* [3] Default:0x0 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_LOOP_SCH_COS_DEFAULT_DWLEN];
+} __packed;
+
+#define NBL_EPRO_MIRROR_PKT_COS_DEFAULT_ADDR  (0xe74604)
+#define NBL_EPRO_MIRROR_PKT_COS_DEFAULT_DEPTH (1)
+#define NBL_EPRO_MIRROR_PKT_COS_DEFAULT_WIDTH (32)
+#define NBL_EPRO_MIRROR_PKT_COS_DEFAULT_DWLEN (1)
+union epro_mirror_pkt_cos_default_u {
+	struct epro_mirror_pkt_cos_default {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_MIRROR_PKT_COS_DEFAULT_DWLEN];
+} __packed;
+
+#define NBL_EPRO_NO_DPORT_REDIRECT_ADDR  (0xe7463c)
+#define NBL_EPRO_NO_DPORT_REDIRECT_DEPTH (1)
+#define NBL_EPRO_NO_DPORT_REDIRECT_WIDTH (32)
+#define NBL_EPRO_NO_DPORT_REDIRECT_DWLEN (1)
+union epro_no_dport_redirect_u {
+	struct epro_no_dport_redirect {
+		u32 dport:16;            /* [15:0] Default:0x0 RW */
+		u32 dqueue:11;           /* [26:16] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [27] Default:0x0 RW */
+		u32 rsv:4;               /* [31:28] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_NO_DPORT_REDIRECT_DWLEN];
+} __packed;
+
+#define NBL_EPRO_SCH_COS_MAP_ETH0_ADDR  (0xe74640)
+#define NBL_EPRO_SCH_COS_MAP_ETH0_DEPTH (8)
+#define NBL_EPRO_SCH_COS_MAP_ETH0_WIDTH (32)
+#define NBL_EPRO_SCH_COS_MAP_ETH0_DWLEN (1)
+union epro_sch_cos_map_eth0_u {
+	struct epro_sch_cos_map_eth0 {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 dscp:6;              /* [8:3] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_SCH_COS_MAP_ETH0_DWLEN];
+} __packed;
+#define NBL_EPRO_SCH_COS_MAP_ETH0_REG(r) (NBL_EPRO_SCH_COS_MAP_ETH0_ADDR + \
+		(NBL_EPRO_SCH_COS_MAP_ETH0_DWLEN * 4) * (r))
+
+#define NBL_EPRO_SCH_COS_MAP_ETH1_ADDR  (0xe74660)
+#define NBL_EPRO_SCH_COS_MAP_ETH1_DEPTH (8)
+#define NBL_EPRO_SCH_COS_MAP_ETH1_WIDTH (32)
+#define NBL_EPRO_SCH_COS_MAP_ETH1_DWLEN (1)
+union epro_sch_cos_map_eth1_u {
+	struct epro_sch_cos_map_eth1 {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 dscp:6;              /* [8:3] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_SCH_COS_MAP_ETH1_DWLEN];
+} __packed;
+#define NBL_EPRO_SCH_COS_MAP_ETH1_REG(r) (NBL_EPRO_SCH_COS_MAP_ETH1_ADDR + \
+		(NBL_EPRO_SCH_COS_MAP_ETH1_DWLEN * 4) * (r))
+
+#define NBL_EPRO_SCH_COS_MAP_ETH2_ADDR  (0xe74680)
+#define NBL_EPRO_SCH_COS_MAP_ETH2_DEPTH (8)
+#define NBL_EPRO_SCH_COS_MAP_ETH2_WIDTH (32)
+#define NBL_EPRO_SCH_COS_MAP_ETH2_DWLEN (1)
+union epro_sch_cos_map_eth2_u {
+	struct epro_sch_cos_map_eth2 {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 dscp:6;              /* [8:3] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_SCH_COS_MAP_ETH2_DWLEN];
+} __packed;
+#define NBL_EPRO_SCH_COS_MAP_ETH2_REG(r) (NBL_EPRO_SCH_COS_MAP_ETH2_ADDR + \
+		(NBL_EPRO_SCH_COS_MAP_ETH2_DWLEN * 4) * (r))
+
+#define NBL_EPRO_SCH_COS_MAP_ETH3_ADDR  (0xe746a0)
+#define NBL_EPRO_SCH_COS_MAP_ETH3_DEPTH (8)
+#define NBL_EPRO_SCH_COS_MAP_ETH3_WIDTH (32)
+#define NBL_EPRO_SCH_COS_MAP_ETH3_DWLEN (1)
+union epro_sch_cos_map_eth3_u {
+	struct epro_sch_cos_map_eth3 {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 dscp:6;              /* [8:3] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_SCH_COS_MAP_ETH3_DWLEN];
+} __packed;
+#define NBL_EPRO_SCH_COS_MAP_ETH3_REG(r) (NBL_EPRO_SCH_COS_MAP_ETH3_ADDR + \
+		(NBL_EPRO_SCH_COS_MAP_ETH3_DWLEN * 4) * (r))
+
+#define NBL_EPRO_SCH_COS_MAP_LOOP_ADDR  (0xe746c0)
+#define NBL_EPRO_SCH_COS_MAP_LOOP_DEPTH (8)
+#define NBL_EPRO_SCH_COS_MAP_LOOP_WIDTH (32)
+#define NBL_EPRO_SCH_COS_MAP_LOOP_DWLEN (1)
+union epro_sch_cos_map_loop_u {
+	struct epro_sch_cos_map_loop {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 dscp:6;              /* [8:3] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_SCH_COS_MAP_LOOP_DWLEN];
+} __packed;
+#define NBL_EPRO_SCH_COS_MAP_LOOP_REG(r) (NBL_EPRO_SCH_COS_MAP_LOOP_ADDR + \
+		(NBL_EPRO_SCH_COS_MAP_LOOP_DWLEN * 4) * (r))
+
+#define NBL_EPRO_PORT_PRI_MDF_EN_ADDR  (0xe746e0)
+#define NBL_EPRO_PORT_PRI_MDF_EN_DEPTH (1)
+#define NBL_EPRO_PORT_PRI_MDF_EN_WIDTH (32)
+#define NBL_EPRO_PORT_PRI_MDF_EN_DWLEN (1)
+union epro_port_pri_mdf_en_u {
+	struct epro_port_pri_mdf_en {
+		u32 eth0:1;              /* [0] Default:0x0 RW */
+		u32 eth1:1;              /* [1] Default:0x0 RW */
+		u32 eth2:1;              /* [2] Default:0x0 RW */
+		u32 eth3:1;              /* [3] Default:0x0 RW */
+		u32 loop:1;              /* [4] Default:0x0 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_PORT_PRI_MDF_EN_DWLEN];
+} __packed;
+
+#define NBL_EPRO_CFG_TEST_ADDR  (0xe7480c)
+#define NBL_EPRO_CFG_TEST_DEPTH (1)
+#define NBL_EPRO_CFG_TEST_WIDTH (32)
+#define NBL_EPRO_CFG_TEST_DWLEN (1)
+union epro_cfg_test_u {
+	struct epro_cfg_test {
+		u32 test:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_EPRO_BP_STATE_ADDR  (0xe74b00)
+#define NBL_EPRO_BP_STATE_DEPTH (1)
+#define NBL_EPRO_BP_STATE_WIDTH (32)
+#define NBL_EPRO_BP_STATE_DWLEN (1)
+union epro_bp_state_u {
+	struct epro_bp_state {
+		u32 in_bp:1;             /* [0] Default:0x0 RO */
+		u32 out_bp:1;            /* [1] Default:0x0 RO */
+		u32 inter_bp:1;          /* [2] Default:0x0 RO */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_EPRO_BP_HISTORY_ADDR  (0xe74b04)
+#define NBL_EPRO_BP_HISTORY_DEPTH (1)
+#define NBL_EPRO_BP_HISTORY_WIDTH (32)
+#define NBL_EPRO_BP_HISTORY_DWLEN (1)
+union epro_bp_history_u {
+	struct epro_bp_history {
+		u32 in_bp:1;             /* [0] Default:0x0 RC */
+		u32 out_bp:1;            /* [1] Default:0x0 RC */
+		u32 inter_bp:1;          /* [2] Default:0x0 RC */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_EPRO_MT_ADDR  (0xe75400)
+#define NBL_EPRO_MT_DEPTH (16)
+#define NBL_EPRO_MT_WIDTH (64)
+#define NBL_EPRO_MT_DWLEN (2)
+#define NBL_EPRO_MT_MAX   (8)
+union epro_mt_u {
+	struct epro_mt {
+		u32 dport:16;            /* [15:0] Default:0x0 RW */
+		u32 dqueue:11;           /* [26:16] Default:0x0 RW */
+		u32 car_en:1;            /* [27] Default:0x0 RW */
+		u32 car_id:10;           /* [37:28] Default:0x0 RW */
+		u32 vld:1;               /* [38] Default:0x0 RW */
+		u32 rsv:25;              /* [63:39] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_MT_DWLEN];
+} __packed;
+#define NBL_EPRO_MT_REG(r) (NBL_EPRO_MT_ADDR + \
+		(NBL_EPRO_MT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_KG_TCAM_ADDR  (0xe75480)
+#define NBL_EPRO_KG_TCAM_DEPTH (16)
+#define NBL_EPRO_KG_TCAM_WIDTH (64)
+#define NBL_EPRO_KG_TCAM_DWLEN (2)
+union epro_kg_tcam_u {
+	struct epro_kg_tcam {
+		u32 mask:16;             /* [15:0] Default:0x0 RW */
+		u32 data:16;             /* [31:16] Default:0x0 RW */
+		u32 valid_bit:1;         /* [32] Default:0x0 RW */
+		u32 rsv:31;              /* [63:33] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_KG_TCAM_DWLEN];
+} __packed;
+#define NBL_EPRO_KG_TCAM_REG(r) (NBL_EPRO_KG_TCAM_ADDR + \
+		(NBL_EPRO_KG_TCAM_DWLEN * 4) * (r))
+
+#define NBL_EPRO_VPT_ADDR  (0xe78000)
+#define NBL_EPRO_VPT_DEPTH (1024)
+#define NBL_EPRO_VPT_WIDTH (64)
+#define NBL_EPRO_VPT_DWLEN (2)
+union epro_vpt_u {
+	struct epro_vpt {
+		u32 cvlan:16;            /* [15:0] Default:0x0 RW */
+		u32 svlan:16;            /* [31:16] Default:0x0 RW */
+		u32 fwd:1;               /* [32] Default:0x0 RW */
+		u32 mirror_en:1;         /* [33] Default:0x0 RW */
+		u32 mirror_id:4;         /* [37:34] Default:0x0 RW */
+		u32 car_en:1;            /* [38] Default:0x0 RW */
+		u32 car_id:10;           /* [48:39] Default:0x0 RW */
+		u32 pop_vlan:2;          /* [50:49] Default:0x0 RW */
+		u32 push_vlan:2;         /* [52:51] Default:0x0 RW */
+		u32 replace_vlan:2;      /* [54:53] Default:0x0 RW */
+		u32 rss_alg_sel:1;       /* [55] Default:0x0 RW */
+		u32 rss_key_type_btm:2;  /* [57:56] Default:0x0 RW */
+		u32 vld:1;               /* [58] Default:0x0 RW */
+		u32 rsv:5;               /* [63:59] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_VPT_DWLEN];
+} __packed;
+#define NBL_EPRO_VPT_REG(r) (NBL_EPRO_VPT_ADDR + \
+		(NBL_EPRO_VPT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_EPT_ADDR  (0xe75800)
+#define NBL_EPRO_EPT_DEPTH (8)
+#define NBL_EPRO_EPT_WIDTH (64)
+#define NBL_EPRO_EPT_DWLEN (2)
+union epro_ept_u {
+	struct epro_ept {
+		u32 cvlan:16;            /* [15:0] Default:0x0 RW */
+		u32 svlan:16;            /* [31:16] Default:0x0 RW */
+		u32 fwd:1;               /* [32] Default:0x0 RW */
+		u32 mirror_en:1;         /* [33] Default:0x0 RW */
+		u32 mirror_id:4;         /* [37:34] Default:0x0 RW */
+		u32 pop_vlan:2;          /* [39:38] Default:0x0 RW */
+		u32 push_vlan:2;         /* [41:40] Default:0x0 RW */
+		u32 replace_vlan:2;      /* [43:42] Default:0x0 RW */
+		u32 lag_alg_sel:2;       /* [45:44] Default:0x0 RW */
+		u32 lag_port_btm:4;      /* [49:46] Default:0x0 RW */
+		u32 lag_l2_protect_en:1; /* [50] Default:0x0 RW */
+		u32 pfc_sch_cos_default:3; /* [53:51] Default:0x0 RW */
+		u32 pfc_mode:1;          /* [54] Default:0x0 RW */
+		u32 vld:1;               /* [55] Default:0x0 RW */
+		u32 rsv:8;               /* [63:56] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_EPT_DWLEN];
+} __packed;
+#define NBL_EPRO_EPT_REG(r) (NBL_EPRO_EPT_ADDR + \
+		(NBL_EPRO_EPT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_AFT_ADDR  (0xe75900)
+#define NBL_EPRO_AFT_DEPTH (16)
+#define NBL_EPRO_AFT_WIDTH (64)
+#define NBL_EPRO_AFT_DWLEN (2)
+union epro_aft_u {
+	struct epro_aft {
+		u32 action_filter_btm_arr[2]; /* [63:0] Default:0x0 RW */
+	} __packed info;
+	u64 data;
+} __packed;
+#define NBL_EPRO_AFT_REG(r) (NBL_EPRO_AFT_ADDR + \
+		(NBL_EPRO_AFT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_RSS_PT_ADDR  (0xe76000)
+#define NBL_EPRO_RSS_PT_DEPTH (1024)
+#define NBL_EPRO_RSS_PT_WIDTH (64)
+#define NBL_EPRO_RSS_PT_DWLEN (2)
+union epro_rss_pt_u {
+	struct epro_rss_pt {
+		u32 entry_size:3;        /* [2:0] Default:0x0 RW */
+		u32 offset1:14;          /* [16:3] Default:0x0 RW */
+		u32 offset1_vld:1;       /* [17:17] Default:0x0 RW */
+		u32 offset0:14;          /* [31:18] Default:0x0 RW */
+		u32 offset0_vld:1;       /* [32] Default:0x0 RW */
+		u32 vld:1;               /* [33] Default:0x0 RW */
+		u32 rsv:30;              /* [63:34] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_RSS_PT_DWLEN];
+} __packed;
+#define NBL_EPRO_RSS_PT_REG(r) (NBL_EPRO_RSS_PT_ADDR + \
+		(NBL_EPRO_RSS_PT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_ECPVPT_ADDR  (0xe7a000)
+#define NBL_EPRO_ECPVPT_DEPTH (256)
+#define NBL_EPRO_ECPVPT_WIDTH (32)
+#define NBL_EPRO_ECPVPT_DWLEN (1)
+union epro_ecpvpt_u {
+	struct epro_ecpvpt {
+		u32 encap_cvlan_vld0:1;  /* [0] Default:0x0 RW */
+		u32 encap_svlan_vld0:1;  /* [1] Default:0x0 RW */
+		u32 encap_vlan_vld1_15:30; /* [31:2] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_ECPVPT_DWLEN];
+} __packed;
+#define NBL_EPRO_ECPVPT_REG(r) (NBL_EPRO_ECPVPT_ADDR + \
+		(NBL_EPRO_ECPVPT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_ECPIPT_ADDR  (0xe7b000)
+#define NBL_EPRO_ECPIPT_DEPTH (128)
+#define NBL_EPRO_ECPIPT_WIDTH (32)
+#define NBL_EPRO_ECPIPT_DWLEN (1)
+union epro_ecpipt_u {
+	struct epro_ecpipt {
+		u32 encap_ip_type0:1;    /* [0] Default:0x0 RW */
+		u32 encap_ip_type1_31:31; /* [31:1] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_ECPIPT_DWLEN];
+} __packed;
+#define NBL_EPRO_ECPIPT_REG(r) (NBL_EPRO_ECPIPT_ADDR + \
+		(NBL_EPRO_ECPIPT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_RSS_RET_ADDR  (0xe7c000)
+#define NBL_EPRO_RSS_RET_DEPTH (8192)
+#define NBL_EPRO_RSS_RET_WIDTH (32)
+#define NBL_EPRO_RSS_RET_DWLEN (1)
+union epro_rss_ret_u {
+	struct epro_rss_ret {
+		u32 dqueue0:11;          /* [10:0] Default:0x0 RW */
+		u32 vld0:1;              /* [11] Default:0x0 RW */
+		u32 rsv1:4;              /* [15:12] Default:0x0 RO */
+		u32 dqueue1:11;          /* [26:16] Default:0x0 RW */
+		u32 vld1:1;              /* [27] Default:0x0 RW */
+		u32 rsv:4;               /* [31:28] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_RSS_RET_DWLEN];
+} __packed;
+#define NBL_EPRO_RSS_RET_REG(r) (NBL_EPRO_RSS_RET_ADDR + \
+		(NBL_EPRO_RSS_RET_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h
new file mode 100644
index 000000000000..5f74a458a09a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h
@@ -0,0 +1,1397 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_IPRO_H
+#define NBL_IPRO_H 1
+
+#include <linux/types.h>
+
+#define NBL_IPRO_BASE (0x00B04000)
+
+#define NBL_IPRO_INT_STATUS_ADDR  (0xb04000)
+#define NBL_IPRO_INT_STATUS_DEPTH (1)
+#define NBL_IPRO_INT_STATUS_WIDTH (32)
+#define NBL_IPRO_INT_STATUS_DWLEN (1)
+union ipro_int_status_u {
+	struct ipro_int_status {
+		u32 fatal_err:1;         /* [0] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 cif_err:1;           /* [3] Default:0x0 RWC */
+		u32 input_err:1;         /* [4] Default:0x0 RWC */
+		u32 cfg_err:1;           /* [5] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 RWC */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_IPRO_INT_MASK_ADDR  (0xb04004)
+#define NBL_IPRO_INT_MASK_DEPTH (1)
+#define NBL_IPRO_INT_MASK_WIDTH (32)
+#define NBL_IPRO_INT_MASK_DWLEN (1)
+union ipro_int_mask_u {
+	struct ipro_int_mask {
+		u32 fatal_err:1;         /* [0] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RW */
+		u32 cif_err:1;           /* [3] Default:0x0 RW */
+		u32 input_err:1;         /* [4] Default:0x0 RW */
+		u32 cfg_err:1;           /* [5] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 RW */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_IPRO_INT_SET_ADDR  (0xb04008)
+#define NBL_IPRO_INT_SET_DEPTH (1)
+#define NBL_IPRO_INT_SET_WIDTH (32)
+#define NBL_IPRO_INT_SET_DWLEN (1)
+union ipro_int_set_u {
+	struct ipro_int_set {
+		u32 fatal_err:1;         /* [0] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 WO */
+		u32 cif_err:1;           /* [3] Default:0x0 WO */
+		u32 input_err:1;         /* [4] Default:0x0 WO */
+		u32 cfg_err:1;           /* [5] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 WO */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_IPRO_INIT_DONE_ADDR  (0xb0400c)
+#define NBL_IPRO_INIT_DONE_DEPTH (1)
+#define NBL_IPRO_INIT_DONE_WIDTH (32)
+#define NBL_IPRO_INIT_DONE_DWLEN (1)
+union ipro_init_done_u {
+	struct ipro_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_CIF_ERR_INFO_ADDR  (0xb04040)
+#define NBL_IPRO_CIF_ERR_INFO_DEPTH (1)
+#define NBL_IPRO_CIF_ERR_INFO_WIDTH (32)
+#define NBL_IPRO_CIF_ERR_INFO_DWLEN (1)
+union ipro_cif_err_info_u {
+	struct ipro_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_IPRO_INPUT_ERR_INFO_ADDR  (0xb04048)
+#define NBL_IPRO_INPUT_ERR_INFO_DEPTH (1)
+#define NBL_IPRO_INPUT_ERR_INFO_WIDTH (32)
+#define NBL_IPRO_INPUT_ERR_INFO_DWLEN (1)
+union ipro_input_err_info_u {
+	struct ipro_input_err_info {
+		u32 id:2;                /* [1:0] Default:0x0 RO */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INPUT_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_IPRO_CFG_ERR_INFO_ADDR  (0xb04050)
+#define NBL_IPRO_CFG_ERR_INFO_DEPTH (1)
+#define NBL_IPRO_CFG_ERR_INFO_WIDTH (32)
+#define NBL_IPRO_CFG_ERR_INFO_DWLEN (1)
+union ipro_cfg_err_info_u {
+	struct ipro_cfg_err_info {
+		u32 id:2;                /* [1:0] Default:0x0 RO */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_IPRO_CAR_CTRL_ADDR  (0xb04100)
+#define NBL_IPRO_CAR_CTRL_DEPTH (1)
+#define NBL_IPRO_CAR_CTRL_WIDTH (32)
+#define NBL_IPRO_CAR_CTRL_DWLEN (1)
+union ipro_car_ctrl_u {
+	struct ipro_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_IPRO_INIT_START_ADDR  (0xb04180)
+#define NBL_IPRO_INIT_START_DEPTH (1)
+#define NBL_IPRO_INIT_START_WIDTH (32)
+#define NBL_IPRO_INIT_START_DWLEN (1)
+union ipro_init_start_u {
+	struct ipro_init_start {
+		u32 init_start:1;        /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_IPRO_CREDIT_TOKEN_ADDR  (0xb041c0)
+#define NBL_IPRO_CREDIT_TOKEN_DEPTH (1)
+#define NBL_IPRO_CREDIT_TOKEN_WIDTH (32)
+#define NBL_IPRO_CREDIT_TOKEN_DWLEN (1)
+union ipro_credit_token_u {
+	struct ipro_credit_token {
+		u32 up_token_num:8;      /* [7:0] Default:0x80 RW */
+		u32 down_token_num:8;    /* [15:8] Default:0x80 RW */
+		u32 up_init_vld:1;       /* [16] Default:0x0 WO */
+		u32 down_init_vld:1;     /* [17] Default:0x0 WO */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_CREDIT_TOKEN_DWLEN];
+} __packed;
+
+#define NBL_IPRO_AM_SET_FLAG_ADDR  (0xb041e0)
+#define NBL_IPRO_AM_SET_FLAG_DEPTH (1)
+#define NBL_IPRO_AM_SET_FLAG_WIDTH (32)
+#define NBL_IPRO_AM_SET_FLAG_DWLEN (1)
+union ipro_am_set_flag_u {
+	struct ipro_am_set_flag {
+		u32 set_flag:32;         /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_AM_SET_FLAG_DWLEN];
+} __packed;
+
+#define NBL_IPRO_AM_CLEAR_FLAG_ADDR  (0xb041e4)
+#define NBL_IPRO_AM_CLEAR_FLAG_DEPTH (1)
+#define NBL_IPRO_AM_CLEAR_FLAG_WIDTH (32)
+#define NBL_IPRO_AM_CLEAR_FLAG_DWLEN (1)
+union ipro_am_clear_flag_u {
+	struct ipro_am_clear_flag {
+		u32 clear_flag:32;       /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_AM_CLEAR_FLAG_DWLEN];
+} __packed;
+
+#define NBL_IPRO_FLAG_OFFSET_0_ADDR  (0xb04200)
+#define NBL_IPRO_FLAG_OFFSET_0_DEPTH (1)
+#define NBL_IPRO_FLAG_OFFSET_0_WIDTH (32)
+#define NBL_IPRO_FLAG_OFFSET_0_DWLEN (1)
+union ipro_flag_offset_0_u {
+	struct ipro_flag_offset_0 {
+		u32 dir_offset_en:1;     /* [0] Default:0x1 RW */
+		u32 dir_offset:5;        /* [5:1] Default:0x00 RW */
+		u32 rsv1:2;              /* [7:6] Default:0x0 RO */
+		u32 hw_flow_offset_en:1; /* [8] Default:0x1 RW */
+		u32 hw_flow_offset:5;   /* [13:9] Default:0xb RW */
+		u32 rsv:18;              /* [31:14] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_FLAG_OFFSET_0_DWLEN];
+} __packed;
+
+#define NBL_IPRO_DROP_NXT_STAGE_ADDR  (0xb04210)
+#define NBL_IPRO_DROP_NXT_STAGE_DEPTH (1)
+#define NBL_IPRO_DROP_NXT_STAGE_WIDTH (32)
+#define NBL_IPRO_DROP_NXT_STAGE_DWLEN (1)
+union ipro_drop_nxt_stage_u {
+	struct ipro_drop_nxt_stage {
+		u32 stage:4;             /* [3:0] Default:0xf RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_DROP_NXT_STAGE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_FWD_ACTION_PRI_ADDR  (0xb04220)
+#define NBL_IPRO_FWD_ACTION_PRI_DEPTH (1)
+#define NBL_IPRO_FWD_ACTION_PRI_WIDTH (32)
+#define NBL_IPRO_FWD_ACTION_PRI_DWLEN (1)
+union ipro_fwd_action_pri_u {
+	struct ipro_fwd_action_pri {
+		u32 dqueue:2;            /* [1:0] Default:0x0 RW */
+		u32 set_dport:2;         /* [3:2] Default:0x0 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_FWD_ACTION_PRI_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MTU_CHECK_CTRL_ADDR  (0xb0427c)
+#define NBL_IPRO_MTU_CHECK_CTRL_DEPTH (1)
+#define NBL_IPRO_MTU_CHECK_CTRL_WIDTH (32)
+#define NBL_IPRO_MTU_CHECK_CTRL_DWLEN (1)
+union ipro_mtu_check_ctrl_u {
+	struct ipro_mtu_check_ctrl {
+		u32 set_dport:16;        /* [15:0] Default:0xFFFF RW */
+		u32 set_dport_pri:2;     /* [17:16] Default:0x3 RW */
+		u32 proc_done:1;         /* [18] Default:0x1 RW */
+		u32 rsv:13;              /* [31:19] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MTU_CHECK_CTRL_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MTU_SEL_ADDR  (0xb04280)
+#define NBL_IPRO_MTU_SEL_DEPTH (8)
+#define NBL_IPRO_MTU_SEL_WIDTH (32)
+#define NBL_IPRO_MTU_SEL_DWLEN (1)
+union ipro_mtu_sel_u {
+	struct ipro_mtu_sel {
+		u32 mtu_1:16;            /* [15:0] Default:0x0 RW */
+		u32 mtu_0:16;            /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MTU_SEL_DWLEN];
+} __packed;
+#define NBL_IPRO_MTU_SEL_REG(r) (NBL_IPRO_MTU_SEL_ADDR + \
+		(NBL_IPRO_MTU_SEL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_UDL_PKT_FLT_DMAC_ADDR  (0xb04300)
+#define NBL_IPRO_UDL_PKT_FLT_DMAC_DEPTH (16)
+#define NBL_IPRO_UDL_PKT_FLT_DMAC_WIDTH (64)
+#define NBL_IPRO_UDL_PKT_FLT_DMAC_DWLEN (2)
+union ipro_udl_pkt_flt_dmac_u {
+	struct ipro_udl_pkt_flt_dmac {
+		u32 dmac_l:32;           /* [47:0] Default:0x0 RW */
+		u32 dmac_h:16;           /* [47:0] Default:0x0 RW */
+		u32 rsv:16;              /* [63:48] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_UDL_PKT_FLT_DMAC_DWLEN];
+} __packed;
+#define NBL_IPRO_UDL_PKT_FLT_DMAC_REG(r) (NBL_IPRO_UDL_PKT_FLT_DMAC_ADDR + \
+		(NBL_IPRO_UDL_PKT_FLT_DMAC_DWLEN * 4) * (r))
+
+#define NBL_IPRO_UDL_PKT_FLT_VLAN_ADDR  (0xb04380)
+#define NBL_IPRO_UDL_PKT_FLT_VLAN_DEPTH (16)
+#define NBL_IPRO_UDL_PKT_FLT_VLAN_WIDTH (32)
+#define NBL_IPRO_UDL_PKT_FLT_VLAN_DWLEN (1)
+union ipro_udl_pkt_flt_vlan_u {
+	struct ipro_udl_pkt_flt_vlan {
+		u32 vlan_0:12;           /* [11:0] Default:0x0 RW */
+		u32 vlan_1:12;           /* [23:12] Default:0x0 RW */
+		u32 vlan_layer:2;        /* [25:24] Default:0x0 RW */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_UDL_PKT_FLT_VLAN_DWLEN];
+} __packed;
+#define NBL_IPRO_UDL_PKT_FLT_VLAN_REG(r) (NBL_IPRO_UDL_PKT_FLT_VLAN_ADDR + \
+		(NBL_IPRO_UDL_PKT_FLT_VLAN_DWLEN * 4) * (r))
+
+#define NBL_IPRO_UDL_PKT_FLT_CTRL_ADDR  (0xb043c0)
+#define NBL_IPRO_UDL_PKT_FLT_CTRL_DEPTH (1)
+#define NBL_IPRO_UDL_PKT_FLT_CTRL_WIDTH (32)
+#define NBL_IPRO_UDL_PKT_FLT_CTRL_DWLEN (1)
+union ipro_udl_pkt_flt_ctrl_u {
+	struct ipro_udl_pkt_flt_ctrl {
+		u32 vld:16;              /* [15:0] Default:0x0 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_UDL_PKT_FLT_CTRL_DWLEN];
+} __packed;
+
+#define NBL_IPRO_UDL_PKT_FLT_ACTION_ADDR  (0xb043c4)
+#define NBL_IPRO_UDL_PKT_FLT_ACTION_DEPTH (1)
+#define NBL_IPRO_UDL_PKT_FLT_ACTION_WIDTH (32)
+#define NBL_IPRO_UDL_PKT_FLT_ACTION_DWLEN (1)
+union ipro_udl_pkt_flt_action_u {
+	struct ipro_udl_pkt_flt_action {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 rsv:2;               /* [13:12] Default:0x0 RO */
+		u32 proc_done:1;         /* [14] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [15] Default:0x0 RW */
+		u32 set_dport:16;        /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_UDL_PKT_FLT_ACTION_DWLEN];
+} __packed;
+
+#define NBL_IPRO_ANTI_FAKE_ADDR_ERRCODE_ADDR  (0xb043e0)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ERRCODE_DEPTH (1)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ERRCODE_WIDTH (32)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ERRCODE_DWLEN (1)
+union ipro_anti_fake_addr_errcode_u {
+	struct ipro_anti_fake_addr_errcode {
+		u32 num:4;               /* [3:0] Default:0xA RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_ANTI_FAKE_ADDR_ERRCODE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_ANTI_FAKE_ADDR_ACTION_ADDR  (0xb043e4)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ACTION_DEPTH (1)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ACTION_WIDTH (32)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ACTION_DWLEN (1)
+union ipro_anti_fake_addr_action_u {
+	struct ipro_anti_fake_addr_action {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 rsv:2;               /* [13:12] Default:0x0 RO */
+		u32 proc_done:1;         /* [14] Default:0x1 RW */
+		u32 set_dport_en:1;      /* [15] Default:0x1 RW */
+		u32 set_dport:16;        /* [31:16] Default:0xFFFF RW */
+	} __packed info;
+	u32 data[NBL_IPRO_ANTI_FAKE_ADDR_ACTION_DWLEN];
+} __packed;
+
+#define NBL_IPRO_VLAN_NUM_CHK_ERRCODE_ADDR  (0xb043f0)
+#define NBL_IPRO_VLAN_NUM_CHK_ERRCODE_DEPTH (1)
+#define NBL_IPRO_VLAN_NUM_CHK_ERRCODE_WIDTH (32)
+#define NBL_IPRO_VLAN_NUM_CHK_ERRCODE_DWLEN (1)
+union ipro_vlan_num_chk_errcode_u {
+	struct ipro_vlan_num_chk_errcode {
+		u32 num:4;               /* [3:0] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_VLAN_NUM_CHK_ERRCODE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_VLAN_NUM_CHK_ACTION_ADDR  (0xb043f4)
+#define NBL_IPRO_VLAN_NUM_CHK_ACTION_DEPTH (1)
+#define NBL_IPRO_VLAN_NUM_CHK_ACTION_WIDTH (32)
+#define NBL_IPRO_VLAN_NUM_CHK_ACTION_DWLEN (1)
+union ipro_vlan_num_chk_action_u {
+	struct ipro_vlan_num_chk_action {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 rsv:2;               /* [13:12] Default:0x0 RO */
+		u32 proc_done:1;         /* [14] Default:0x1 RW */
+		u32 set_dport_en:1;      /* [15] Default:0x1 RW */
+		u32 set_dport:16;        /* [31:16] Default:0xFFFF RW */
+	} __packed info;
+	u32 data[NBL_IPRO_VLAN_NUM_CHK_ACTION_DWLEN];
+} __packed;
+
+#define NBL_IPRO_TCP_STATE_PROBE_ADDR  (0xb04400)
+#define NBL_IPRO_TCP_STATE_PROBE_DEPTH (1)
+#define NBL_IPRO_TCP_STATE_PROBE_WIDTH (32)
+#define NBL_IPRO_TCP_STATE_PROBE_DWLEN (1)
+union ipro_tcp_state_probe_u {
+	struct ipro_tcp_state_probe {
+		u32 up_chk_en:1;         /* [0] Default:0x0 RW */
+		u32 dn_chk_en:1;         /* [1] Default:0x0 RW */
+		u32 rsv:14;              /* [15:2] Default:0x0 RO */
+		u32 up_bitmap:8;         /* [23:16] Default:0x0 RW */
+		u32 dn_bitmap:8;         /* [31:24] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_TCP_STATE_PROBE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_TCP_STATE_UP_ACTION_ADDR  (0xb04404)
+#define NBL_IPRO_TCP_STATE_UP_ACTION_DEPTH (1)
+#define NBL_IPRO_TCP_STATE_UP_ACTION_WIDTH (32)
+#define NBL_IPRO_TCP_STATE_UP_ACTION_DWLEN (1)
+union ipro_tcp_state_up_action_u {
+	struct ipro_tcp_state_up_action {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 rsv:2;               /* [13:12] Default:0x0 RO */
+		u32 proc_done:1;         /* [14] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [15] Default:0x0 RW */
+		u32 set_dport:16;        /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_TCP_STATE_UP_ACTION_DWLEN];
+} __packed;
+
+#define NBL_IPRO_TCP_STATE_DN_ACTION_ADDR  (0xb04408)
+#define NBL_IPRO_TCP_STATE_DN_ACTION_DEPTH (1)
+#define NBL_IPRO_TCP_STATE_DN_ACTION_WIDTH (32)
+#define NBL_IPRO_TCP_STATE_DN_ACTION_DWLEN (1)
+union ipro_tcp_state_dn_action_u {
+	struct ipro_tcp_state_dn_action {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 rsv:2;               /* [13:12] Default:0x0 RO */
+		u32 proc_done:1;         /* [14] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [15] Default:0x0 RW */
+		u32 set_dport:16;        /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_TCP_STATE_DN_ACTION_DWLEN];
+} __packed;
+
+#define NBL_IPRO_FWD_ACTION_ID_ADDR  (0xb04440)
+#define NBL_IPRO_FWD_ACTION_ID_DEPTH (1)
+#define NBL_IPRO_FWD_ACTION_ID_WIDTH (32)
+#define NBL_IPRO_FWD_ACTION_ID_DWLEN (1)
+union ipro_fwd_action_id_u {
+	struct ipro_fwd_action_id {
+		u32 mirror_index:6;      /* [5:0] Default:0x8 RW */
+		u32 dport:6;             /* [11:6] Default:0x9 RW */
+		u32 dqueue:6;            /* [17:12] Default:0xA RW */
+		u32 car:6;               /* [23:18] Default:0x5 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_FWD_ACTION_ID_DWLEN];
+} __packed;
+
+#define NBL_IPRO_PED_ACTION_ID_ADDR  (0xb04448)
+#define NBL_IPRO_PED_ACTION_ID_DEPTH (1)
+#define NBL_IPRO_PED_ACTION_ID_WIDTH (32)
+#define NBL_IPRO_PED_ACTION_ID_DWLEN (1)
+union ipro_ped_action_id_u {
+	struct ipro_ped_action_id {
+		u32 encap:6;             /* [5:0] Default:0x2E RW */
+		u32 decap:6;             /* [11:6] Default:0x2F RW */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_PED_ACTION_ID_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_HIT_ACTION_ADDR  (0xb04510)
+#define NBL_IPRO_MNG_HIT_ACTION_DEPTH (8)
+#define NBL_IPRO_MNG_HIT_ACTION_WIDTH (32)
+#define NBL_IPRO_MNG_HIT_ACTION_DWLEN (1)
+union ipro_mng_hit_action_u {
+	struct ipro_mng_hit_action {
+		u32 data:24;             /* [23:0] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_HIT_ACTION_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_HIT_ACTION_REG(r) (NBL_IPRO_MNG_HIT_ACTION_ADDR + \
+		(NBL_IPRO_MNG_HIT_ACTION_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_DECISION_FLT_0_ADDR  (0xb04530)
+#define NBL_IPRO_MNG_DECISION_FLT_0_DEPTH (4)
+#define NBL_IPRO_MNG_DECISION_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_DECISION_FLT_0_DWLEN (1)
+union ipro_mng_decision_flt_0_u {
+	struct ipro_mng_decision_flt_0 {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 pkt_len_and:1;       /* [1] Default:0x0 RW */
+		u32 flow_ctrl_and:1;     /* [2] Default:0x0 RW */
+		u32 ncsi_and:1;          /* [3] Default:0x0 RW */
+		u32 eth_id:2;            /* [5:4] Default:0x0 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DECISION_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_DECISION_FLT_0_REG(r) (NBL_IPRO_MNG_DECISION_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_DECISION_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_DECISION_FLT_1_ADDR  (0xb04540)
+#define NBL_IPRO_MNG_DECISION_FLT_1_DEPTH (4)
+#define NBL_IPRO_MNG_DECISION_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_DECISION_FLT_1_DWLEN (1)
+union ipro_mng_decision_flt_1_u {
+	struct ipro_mng_decision_flt_1 {
+		u32 dmac_and:4;          /* [3:0] Default:0x0 RW */
+		u32 brcast_and:1;        /* [4] Default:0x0 RW */
+		u32 mulcast_and:1;       /* [5] Default:0x0 RW */
+		u32 vlan_and:8;          /* [13:6] Default:0x0 RW */
+		u32 ipv4_dip_and:4;      /* [17:14] Default:0x0 RW */
+		u32 ipv6_dip_and:4;      /* [21:18] Default:0x0 RW */
+		u32 ethertype_and:4;     /* [25:22] Default:0x0 RW */
+		u32 brcast_or:1;         /* [26] Default:0x0 RW */
+		u32 icmpv4_or:1;         /* [27] Default:0x0 RW */
+		u32 mld_or:4;            /* [31:28] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DECISION_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_DECISION_FLT_1_REG(r) (NBL_IPRO_MNG_DECISION_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_DECISION_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_DECISION_FLT_2_ADDR  (0xb04550)
+#define NBL_IPRO_MNG_DECISION_FLT_2_DEPTH (4)
+#define NBL_IPRO_MNG_DECISION_FLT_2_WIDTH (32)
+#define NBL_IPRO_MNG_DECISION_FLT_2_DWLEN (1)
+union ipro_mng_decision_flt_2_u {
+	struct ipro_mng_decision_flt_2 {
+		u32 neighbor_or:4;       /* [3:0] Default:0x0 RW */
+		u32 port_or:16;          /* [19:4] Default:0x0 RW */
+		u32 ethertype_or:4;      /* [23:20] Default:0x0 RW */
+		u32 arp_rsp_or:2;        /* [25:24] Default:0x0 RW */
+		u32 arp_req_or:2;        /* [27:26] Default:0x0 RW */
+		u32 dmac_or:4;           /* [31:28] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DECISION_FLT_2_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_DECISION_FLT_2_REG(r) (NBL_IPRO_MNG_DECISION_FLT_2_ADDR + \
+		(NBL_IPRO_MNG_DECISION_FLT_2_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_DMAC_FLT_0_ADDR  (0xb04560)
+#define NBL_IPRO_MNG_DMAC_FLT_0_DEPTH (4)
+#define NBL_IPRO_MNG_DMAC_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_DMAC_FLT_0_DWLEN (1)
+union ipro_mng_dmac_flt_0_u {
+	struct ipro_mng_dmac_flt_0 {
+		u32 data:16;             /* [15:0] Default:0x0 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 rsv:15;              /* [31:17] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DMAC_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_DMAC_FLT_0_REG(r) (NBL_IPRO_MNG_DMAC_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_DMAC_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_DMAC_FLT_1_ADDR  (0xb04570)
+#define NBL_IPRO_MNG_DMAC_FLT_1_DEPTH (4)
+#define NBL_IPRO_MNG_DMAC_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_DMAC_FLT_1_DWLEN (1)
+union ipro_mng_dmac_flt_1_u {
+	struct ipro_mng_dmac_flt_1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DMAC_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_DMAC_FLT_1_REG(r) (NBL_IPRO_MNG_DMAC_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_DMAC_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_VLAN_FLT_ADDR  (0xb04580)
+#define NBL_IPRO_MNG_VLAN_FLT_DEPTH (8)
+#define NBL_IPRO_MNG_VLAN_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_VLAN_FLT_DWLEN (1)
+union ipro_mng_vlan_flt_u {
+	struct ipro_mng_vlan_flt {
+		u32 data:12;             /* [11:0] Default:0x0 RW */
+		u32 sel:1;               /* [12] Default:0x0 RW */
+		u32 nontag:1;            /* [13] Default:0x0 RW */
+		u32 en:1;                /* [14] Default:0x0 RW */
+		u32 rsv:17;              /* [31:15] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_VLAN_FLT_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_VLAN_FLT_REG(r) (NBL_IPRO_MNG_VLAN_FLT_ADDR + \
+		(NBL_IPRO_MNG_VLAN_FLT_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_ETHERTYPE_FLT_ADDR  (0xb045a0)
+#define NBL_IPRO_MNG_ETHERTYPE_FLT_DEPTH (4)
+#define NBL_IPRO_MNG_ETHERTYPE_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_ETHERTYPE_FLT_DWLEN (1)
+union ipro_mng_ethertype_flt_u {
+	struct ipro_mng_ethertype_flt {
+		u32 data:16;             /* [15:0] Default:0x0 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 rsv:15;              /* [31:17] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ETHERTYPE_FLT_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_ETHERTYPE_FLT_REG(r) (NBL_IPRO_MNG_ETHERTYPE_FLT_ADDR + \
+		(NBL_IPRO_MNG_ETHERTYPE_FLT_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV4_FLT_0_ADDR  (0xb045b0)
+#define NBL_IPRO_MNG_IPV4_FLT_0_DEPTH (4)
+#define NBL_IPRO_MNG_IPV4_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_IPV4_FLT_0_DWLEN (1)
+union ipro_mng_ipv4_flt_0_u {
+	struct ipro_mng_ipv4_flt_0 {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV4_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV4_FLT_0_REG(r) (NBL_IPRO_MNG_IPV4_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_IPV4_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV4_FLT_1_ADDR  (0xb045c0)
+#define NBL_IPRO_MNG_IPV4_FLT_1_DEPTH (4)
+#define NBL_IPRO_MNG_IPV4_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_IPV4_FLT_1_DWLEN (1)
+union ipro_mng_ipv4_flt_1_u {
+	struct ipro_mng_ipv4_flt_1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV4_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV4_FLT_1_REG(r) (NBL_IPRO_MNG_IPV4_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_IPV4_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV6_FLT_0_ADDR  (0xb04600)
+#define NBL_IPRO_MNG_IPV6_FLT_0_DEPTH (4)
+#define NBL_IPRO_MNG_IPV6_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_IPV6_FLT_0_DWLEN (1)
+union ipro_mng_ipv6_flt_0_u {
+	struct ipro_mng_ipv6_flt_0 {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:15;              /* [15:1] Default:0x0 RO */
+		u32 mask:16;             /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV6_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV6_FLT_0_REG(r) (NBL_IPRO_MNG_IPV6_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_IPV6_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV6_FLT_1_ADDR  (0xb04610)
+#define NBL_IPRO_MNG_IPV6_FLT_1_DEPTH (4)
+#define NBL_IPRO_MNG_IPV6_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_IPV6_FLT_1_DWLEN (1)
+union ipro_mng_ipv6_flt_1_u {
+	struct ipro_mng_ipv6_flt_1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV6_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV6_FLT_1_REG(r) (NBL_IPRO_MNG_IPV6_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_IPV6_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV6_FLT_2_ADDR  (0xb04620)
+#define NBL_IPRO_MNG_IPV6_FLT_2_DEPTH (4)
+#define NBL_IPRO_MNG_IPV6_FLT_2_WIDTH (32)
+#define NBL_IPRO_MNG_IPV6_FLT_2_DWLEN (1)
+union ipro_mng_ipv6_flt_2_u {
+	struct ipro_mng_ipv6_flt_2 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV6_FLT_2_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV6_FLT_2_REG(r) (NBL_IPRO_MNG_IPV6_FLT_2_ADDR + \
+		(NBL_IPRO_MNG_IPV6_FLT_2_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV6_FLT_3_ADDR  (0xb04630)
+#define NBL_IPRO_MNG_IPV6_FLT_3_DEPTH (4)
+#define NBL_IPRO_MNG_IPV6_FLT_3_WIDTH (32)
+#define NBL_IPRO_MNG_IPV6_FLT_3_DWLEN (1)
+union ipro_mng_ipv6_flt_3_u {
+	struct ipro_mng_ipv6_flt_3 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV6_FLT_3_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV6_FLT_3_REG(r) (NBL_IPRO_MNG_IPV6_FLT_3_ADDR + \
+		(NBL_IPRO_MNG_IPV6_FLT_3_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV6_FLT_4_ADDR  (0xb04640)
+#define NBL_IPRO_MNG_IPV6_FLT_4_DEPTH (4)
+#define NBL_IPRO_MNG_IPV6_FLT_4_WIDTH (32)
+#define NBL_IPRO_MNG_IPV6_FLT_4_DWLEN (1)
+union ipro_mng_ipv6_flt_4_u {
+	struct ipro_mng_ipv6_flt_4 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV6_FLT_4_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV6_FLT_4_REG(r) (NBL_IPRO_MNG_IPV6_FLT_4_ADDR + \
+		(NBL_IPRO_MNG_IPV6_FLT_4_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_PORT_FLT_ADDR  (0xb04650)
+#define NBL_IPRO_MNG_PORT_FLT_DEPTH (16)
+#define NBL_IPRO_MNG_PORT_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_PORT_FLT_DWLEN (1)
+union ipro_mng_port_flt_u {
+	struct ipro_mng_port_flt {
+		u32 data:16;             /* [15:0] Default:0x0 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 mode:1;              /* [17] Default:0x0 RW */
+		u32 tcp:1;               /* [18] Default:0x0 RW */
+		u32 udp:1;               /* [19] Default:0x0 RW */
+		u32 rsv:12;              /* [31:20] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_PORT_FLT_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_PORT_FLT_REG(r) (NBL_IPRO_MNG_PORT_FLT_ADDR + \
+		(NBL_IPRO_MNG_PORT_FLT_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_ARP_REQ_FLT_0_ADDR  (0xb04690)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_0_DEPTH (2)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_0_DWLEN (1)
+union ipro_mng_arp_req_flt_0_u {
+	struct ipro_mng_arp_req_flt_0 {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:15;              /* [15:1] Default:0x0 RO */
+		u32 op:16;               /* [31:16] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ARP_REQ_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_ARP_REQ_FLT_0_REG(r) (NBL_IPRO_MNG_ARP_REQ_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_ARP_REQ_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_ARP_REQ_FLT_1_ADDR  (0xb046a0)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_1_DEPTH (2)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_1_DWLEN (1)
+union ipro_mng_arp_req_flt_1_u {
+	struct ipro_mng_arp_req_flt_1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ARP_REQ_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_ARP_REQ_FLT_1_REG(r) (NBL_IPRO_MNG_ARP_REQ_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_ARP_REQ_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_ARP_RSP_FLT_0_ADDR  (0xb046b0)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_0_DEPTH (2)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_0_DWLEN (1)
+union ipro_mng_arp_rsp_flt_0_u {
+	struct ipro_mng_arp_rsp_flt_0 {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:15;              /* [15:1] Default:0x0 RO */
+		u32 op:16;               /* [31:16] Default:0x2 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ARP_RSP_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_ARP_RSP_FLT_0_REG(r) (NBL_IPRO_MNG_ARP_RSP_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_ARP_RSP_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_ARP_RSP_FLT_1_ADDR  (0xb046c0)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_1_DEPTH (2)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_1_DWLEN (1)
+union ipro_mng_arp_rsp_flt_1_u {
+	struct ipro_mng_arp_rsp_flt_1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ARP_RSP_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_ARP_RSP_FLT_1_REG(r) (NBL_IPRO_MNG_ARP_RSP_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_ARP_RSP_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_86_ADDR  (0xb046d0)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_86_DEPTH (1)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_86_WIDTH (32)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_86_DWLEN (1)
+union ipro_mng_neighbor_flt_86_u {
+	struct ipro_mng_neighbor_flt_86 {
+		u32 data:8;              /* [7:0] Default:0x86 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_NEIGHBOR_FLT_86_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_87_ADDR  (0xb046d4)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_87_DEPTH (1)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_87_WIDTH (32)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_87_DWLEN (1)
+union ipro_mng_neighbor_flt_87_u {
+	struct ipro_mng_neighbor_flt_87 {
+		u32 data:8;              /* [7:0] Default:0x87 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_NEIGHBOR_FLT_87_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_88_ADDR  (0xb046d8)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_88_DEPTH (1)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_88_WIDTH (32)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_88_DWLEN (1)
+union ipro_mng_neighbor_flt_88_u {
+	struct ipro_mng_neighbor_flt_88 {
+		u32 data:8;              /* [7:0] Default:0x88 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_NEIGHBOR_FLT_88_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_89_ADDR  (0xb046dc)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_89_DEPTH (1)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_89_WIDTH (32)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_89_DWLEN (1)
+union ipro_mng_neighbor_flt_89_u {
+	struct ipro_mng_neighbor_flt_89 {
+		u32 data:8;              /* [7:0] Default:0x89 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_NEIGHBOR_FLT_89_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_MLD_FLT_82_ADDR  (0xb046e0)
+#define NBL_IPRO_MNG_MLD_FLT_82_DEPTH (1)
+#define NBL_IPRO_MNG_MLD_FLT_82_WIDTH (32)
+#define NBL_IPRO_MNG_MLD_FLT_82_DWLEN (1)
+union ipro_mng_mld_flt_82_u {
+	struct ipro_mng_mld_flt_82 {
+		u32 data:8;              /* [7:0] Default:0x82 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_MLD_FLT_82_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_MLD_FLT_83_ADDR  (0xb046e4)
+#define NBL_IPRO_MNG_MLD_FLT_83_DEPTH (1)
+#define NBL_IPRO_MNG_MLD_FLT_83_WIDTH (32)
+#define NBL_IPRO_MNG_MLD_FLT_83_DWLEN (1)
+union ipro_mng_mld_flt_83_u {
+	struct ipro_mng_mld_flt_83 {
+		u32 data:8;              /* [7:0] Default:0x83 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_MLD_FLT_83_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_MLD_FLT_84_ADDR  (0xb046e8)
+#define NBL_IPRO_MNG_MLD_FLT_84_DEPTH (1)
+#define NBL_IPRO_MNG_MLD_FLT_84_WIDTH (32)
+#define NBL_IPRO_MNG_MLD_FLT_84_DWLEN (1)
+union ipro_mng_mld_flt_84_u {
+	struct ipro_mng_mld_flt_84 {
+		u32 data:8;              /* [7:0] Default:0x84 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_MLD_FLT_84_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_MLD_FLT_8F_ADDR  (0xb046ec)
+#define NBL_IPRO_MNG_MLD_FLT_8F_DEPTH (1)
+#define NBL_IPRO_MNG_MLD_FLT_8F_WIDTH (32)
+#define NBL_IPRO_MNG_MLD_FLT_8F_DWLEN (1)
+union ipro_mng_mld_flt_8f_u {
+	struct ipro_mng_mld_flt_8f {
+		u32 data:8;              /* [7:0] Default:0x8f RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_MLD_FLT_8F_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_ICMPV4_FLT_ADDR  (0xb046f0)
+#define NBL_IPRO_MNG_ICMPV4_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_ICMPV4_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_ICMPV4_FLT_DWLEN (1)
+union ipro_mng_icmpv4_flt_u {
+	struct ipro_mng_icmpv4_flt {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ICMPV4_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_BRCAST_FLT_ADDR  (0xb04700)
+#define NBL_IPRO_MNG_BRCAST_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_BRCAST_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_BRCAST_FLT_DWLEN (1)
+union ipro_mng_brcast_flt_u {
+	struct ipro_mng_brcast_flt {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_BRCAST_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_MULCAST_FLT_ADDR  (0xb04704)
+#define NBL_IPRO_MNG_MULCAST_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_MULCAST_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_MULCAST_FLT_DWLEN (1)
+union ipro_mng_mulcast_flt_u {
+	struct ipro_mng_mulcast_flt {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_MULCAST_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_FLOW_CTRL_FLT_ADDR  (0xb04710)
+#define NBL_IPRO_MNG_FLOW_CTRL_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_FLOW_CTRL_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_FLOW_CTRL_FLT_DWLEN (1)
+union ipro_mng_flow_ctrl_flt_u {
+	struct ipro_mng_flow_ctrl_flt {
+		u32 data:16;             /* [15:0] Default:0x8808 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 bow:1;               /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_FLOW_CTRL_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_NCSI_FLT_ADDR  (0xb04714)
+#define NBL_IPRO_MNG_NCSI_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_NCSI_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_NCSI_FLT_DWLEN (1)
+union ipro_mng_ncsi_flt_u {
+	struct ipro_mng_ncsi_flt {
+		u32 data:16;             /* [15:0] Default:0x88F8 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 bow:1;               /* [17] Default:0x1 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_NCSI_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_PKT_LEN_FLT_ADDR  (0xb04720)
+#define NBL_IPRO_MNG_PKT_LEN_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_PKT_LEN_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_PKT_LEN_FLT_DWLEN (1)
+union ipro_mng_pkt_len_flt_u {
+	struct ipro_mng_pkt_len_flt {
+		u32 max:16;              /* [15:0] Default:0x800 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 rsv:15;              /* [31:17] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_PKT_LEN_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_FLOW_STOP_ADDR  (0xb04810)
+#define NBL_IPRO_FLOW_STOP_DEPTH (1)
+#define NBL_IPRO_FLOW_STOP_WIDTH (32)
+#define NBL_IPRO_FLOW_STOP_DWLEN (1)
+union ipro_flow_stop_u {
+	struct ipro_flow_stop {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_FLOW_STOP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_TOKEN_NUM_ADDR  (0xb04814)
+#define NBL_IPRO_TOKEN_NUM_DEPTH (1)
+#define NBL_IPRO_TOKEN_NUM_WIDTH (32)
+#define NBL_IPRO_TOKEN_NUM_DWLEN (1)
+union ipro_token_num_u {
+	struct ipro_token_num {
+		u32 dn_cnt:8;            /* [7:0] Default:0x80 RO */
+		u32 up_cnt:8;            /* [15:8] Default:0x80 RO */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_TOKEN_NUM_DWLEN];
+} __packed;
+
+#define NBL_IPRO_BYPASS_ADDR  (0xb04818)
+#define NBL_IPRO_BYPASS_DEPTH (1)
+#define NBL_IPRO_BYPASS_WIDTH (32)
+#define NBL_IPRO_BYPASS_DWLEN (1)
+union ipro_bypass_u {
+	struct ipro_bypass {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_BYPASS_DWLEN];
+} __packed;
+
+#define NBL_IPRO_RR_REQ_MASK_ADDR  (0xb0481c)
+#define NBL_IPRO_RR_REQ_MASK_DEPTH (1)
+#define NBL_IPRO_RR_REQ_MASK_WIDTH (32)
+#define NBL_IPRO_RR_REQ_MASK_DWLEN (1)
+union ipro_rr_req_mask_u {
+	struct ipro_rr_req_mask {
+		u32 dn:1;                /* [0] Default:0x0 RW */
+		u32 up:1;                /* [1] Default:0x0 RW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_RR_REQ_MASK_DWLEN];
+} __packed;
+
+#define NBL_IPRO_BP_STATE_ADDR  (0xb04828)
+#define NBL_IPRO_BP_STATE_DEPTH (1)
+#define NBL_IPRO_BP_STATE_WIDTH (32)
+#define NBL_IPRO_BP_STATE_DWLEN (1)
+union ipro_bp_state_u {
+	struct ipro_bp_state {
+		u32 pp_up_link_fc:1;     /* [0] Default:0x0 RO */
+		u32 pp_dn_link_fc:1;     /* [1] Default:0x0 RO */
+		u32 pp_up_creadit:1;     /* [2] Default:0x0 RO */
+		u32 pp_dn_creadit:1;     /* [3] Default:0x0 RO */
+		u32 mcc_up_creadit:1;    /* [4] Default:0x0 RO */
+		u32 mcc_dn_creadit:1;    /* [5] Default:0x0 RO */
+		u32 pp_rdy:1;            /* [6] Default:0x1 RO */
+		u32 dn_rdy:1;            /* [7] Default:0x1 RO */
+		u32 up_rdy:1;            /* [8] Default:0x1 RO */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_BP_HISTORY_ADDR  (0xb0482c)
+#define NBL_IPRO_BP_HISTORY_DEPTH (1)
+#define NBL_IPRO_BP_HISTORY_WIDTH (32)
+#define NBL_IPRO_BP_HISTORY_DWLEN (1)
+union ipro_bp_history_u {
+	struct ipro_bp_history {
+		u32 pp_rdy:1;            /* [0] Default:0x0 RC */
+		u32 dn_rdy:1;            /* [1] Default:0x0 RC */
+		u32 up_rdy:1;            /* [2] Default:0x0 RC */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_IPRO_ERRCODE_TBL_DROP_ADDR  (0xb0486c)
+#define NBL_IPRO_ERRCODE_TBL_DROP_DEPTH (1)
+#define NBL_IPRO_ERRCODE_TBL_DROP_WIDTH (32)
+#define NBL_IPRO_ERRCODE_TBL_DROP_DWLEN (1)
+union ipro_errcode_tbl_drop_u {
+	struct ipro_errcode_tbl_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_ERRCODE_TBL_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_SPORT_TBL_DROP_ADDR  (0xb04870)
+#define NBL_IPRO_SPORT_TBL_DROP_DEPTH (1)
+#define NBL_IPRO_SPORT_TBL_DROP_WIDTH (32)
+#define NBL_IPRO_SPORT_TBL_DROP_DWLEN (1)
+union ipro_sport_tbl_drop_u {
+	struct ipro_sport_tbl_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_SPORT_TBL_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_PTYPE_TBL_DROP_ADDR  (0xb04874)
+#define NBL_IPRO_PTYPE_TBL_DROP_DEPTH (1)
+#define NBL_IPRO_PTYPE_TBL_DROP_WIDTH (32)
+#define NBL_IPRO_PTYPE_TBL_DROP_DWLEN (1)
+union ipro_ptype_tbl_drop_u {
+	struct ipro_ptype_tbl_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_PTYPE_TBL_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_UDL_DROP_ADDR  (0xb04878)
+#define NBL_IPRO_UDL_DROP_DEPTH (1)
+#define NBL_IPRO_UDL_DROP_WIDTH (32)
+#define NBL_IPRO_UDL_DROP_DWLEN (1)
+union ipro_udl_drop_u {
+	struct ipro_udl_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_UDL_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_ANTIFAKE_DROP_ADDR  (0xb0487c)
+#define NBL_IPRO_ANTIFAKE_DROP_DEPTH (1)
+#define NBL_IPRO_ANTIFAKE_DROP_WIDTH (32)
+#define NBL_IPRO_ANTIFAKE_DROP_DWLEN (1)
+union ipro_antifake_drop_u {
+	struct ipro_antifake_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_ANTIFAKE_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_VLAN_NUM_DROP_ADDR  (0xb04880)
+#define NBL_IPRO_VLAN_NUM_DROP_DEPTH (1)
+#define NBL_IPRO_VLAN_NUM_DROP_WIDTH (32)
+#define NBL_IPRO_VLAN_NUM_DROP_DWLEN (1)
+union ipro_vlan_num_drop_u {
+	struct ipro_vlan_num_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_VLAN_NUM_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_TCP_STATE_DROP_ADDR  (0xb04884)
+#define NBL_IPRO_TCP_STATE_DROP_DEPTH (1)
+#define NBL_IPRO_TCP_STATE_DROP_WIDTH (32)
+#define NBL_IPRO_TCP_STATE_DROP_DWLEN (1)
+union ipro_tcp_state_drop_u {
+	struct ipro_tcp_state_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_TCP_STATE_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_RAM_ERR_DROP_ADDR  (0xb04888)
+#define NBL_IPRO_RAM_ERR_DROP_DEPTH (1)
+#define NBL_IPRO_RAM_ERR_DROP_WIDTH (32)
+#define NBL_IPRO_RAM_ERR_DROP_DWLEN (1)
+union ipro_ram_err_drop_u {
+	struct ipro_ram_err_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_RAM_ERR_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_KG_MISS_ADDR  (0xb0488c)
+#define NBL_IPRO_KG_MISS_DEPTH (1)
+#define NBL_IPRO_KG_MISS_WIDTH (32)
+#define NBL_IPRO_KG_MISS_DWLEN (1)
+union ipro_kg_miss_u {
+	struct ipro_kg_miss {
+		u32 drop_cnt:16;         /* [15:0] Default:0x0 SCTR */
+		u32 cnt:16;              /* [31:16] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_IPRO_KG_MISS_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_DROP_ADDR  (0xb04890)
+#define NBL_IPRO_MNG_DROP_DEPTH (1)
+#define NBL_IPRO_MNG_DROP_WIDTH (32)
+#define NBL_IPRO_MNG_DROP_DWLEN (1)
+union ipro_mng_drop_u {
+	struct ipro_mng_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MTU_CHECK_DROP_ADDR  (0xb04900)
+#define NBL_IPRO_MTU_CHECK_DROP_DEPTH (256)
+#define NBL_IPRO_MTU_CHECK_DROP_WIDTH (32)
+#define NBL_IPRO_MTU_CHECK_DROP_DWLEN (1)
+union ipro_mtu_check_drop_u {
+	struct ipro_mtu_check_drop {
+		u32 vsi_3:8;             /* [7:0] Default:0x0 SCTR */
+		u32 vsi_2:8;             /* [15:8] Default:0x0 SCTR */
+		u32 vsi_1:8;             /* [23:16] Default:0x0 SCTR */
+		u32 vsi_0:8;             /* [31:24] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_IPRO_MTU_CHECK_DROP_DWLEN];
+} __packed;
+#define NBL_IPRO_MTU_CHECK_DROP_REG(r) (NBL_IPRO_MTU_CHECK_DROP_ADDR + \
+		(NBL_IPRO_MTU_CHECK_DROP_DWLEN * 4) * (r))
+
+#define NBL_IPRO_LAST_QUEUE_RAM_ERR_ADDR  (0xb04d08)
+#define NBL_IPRO_LAST_QUEUE_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_QUEUE_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_QUEUE_RAM_ERR_DWLEN (1)
+union ipro_last_queue_ram_err_u {
+	struct ipro_last_queue_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_QUEUE_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_DN_SRC_PORT_RAM_ERR_ADDR  (0xb04d0c)
+#define NBL_IPRO_LAST_DN_SRC_PORT_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_DN_SRC_PORT_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_DN_SRC_PORT_RAM_ERR_DWLEN (1)
+union ipro_last_dn_src_port_ram_err_u {
+	struct ipro_last_dn_src_port_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_DN_SRC_PORT_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_UP_SRC_PORT_RAM_ERR_ADDR  (0xb04d10)
+#define NBL_IPRO_LAST_UP_SRC_PORT_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_UP_SRC_PORT_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_UP_SRC_PORT_RAM_ERR_DWLEN (1)
+union ipro_last_up_src_port_ram_err_u {
+	struct ipro_last_up_src_port_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_UP_SRC_PORT_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_DN_PTYPE_RAM_ERR_ADDR  (0xb04d14)
+#define NBL_IPRO_LAST_DN_PTYPE_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_DN_PTYPE_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_DN_PTYPE_RAM_ERR_DWLEN (1)
+union ipro_last_dn_ptype_ram_err_u {
+	struct ipro_last_dn_ptype_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_DN_PTYPE_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_UP_PTYPE_RAM_ERR_ADDR  (0xb04d18)
+#define NBL_IPRO_LAST_UP_PTYPE_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_UP_PTYPE_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_UP_PTYPE_RAM_ERR_DWLEN (1)
+union ipro_last_up_ptype_ram_err_u {
+	struct ipro_last_up_ptype_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_UP_PTYPE_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_KG_PROF_RAM_ERR_ADDR  (0xb04d20)
+#define NBL_IPRO_LAST_KG_PROF_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_KG_PROF_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_KG_PROF_RAM_ERR_DWLEN (1)
+union ipro_last_kg_prof_ram_err_u {
+	struct ipro_last_kg_prof_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_KG_PROF_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_ERRCODE_RAM_ERR_ADDR  (0xb04d28)
+#define NBL_IPRO_LAST_ERRCODE_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_ERRCODE_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_ERRCODE_RAM_ERR_DWLEN (1)
+union ipro_last_errcode_ram_err_u {
+	struct ipro_last_errcode_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_ERRCODE_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_IN_PKT_CAP_EN_ADDR  (0xb04dfc)
+#define NBL_IPRO_IN_PKT_CAP_EN_DEPTH (1)
+#define NBL_IPRO_IN_PKT_CAP_EN_WIDTH (32)
+#define NBL_IPRO_IN_PKT_CAP_EN_DWLEN (1)
+union ipro_in_pkt_cap_en_u {
+	struct ipro_in_pkt_cap_en {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_IN_PKT_CAP_EN_DWLEN];
+} __packed;
+
+#define NBL_IPRO_IN_PKT_CAP_ADDR  (0xb04e00)
+#define NBL_IPRO_IN_PKT_CAP_DEPTH (64)
+#define NBL_IPRO_IN_PKT_CAP_WIDTH (32)
+#define NBL_IPRO_IN_PKT_CAP_DWLEN (1)
+union ipro_in_pkt_cap_u {
+	struct ipro_in_pkt_cap {
+		u32 data:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_IN_PKT_CAP_DWLEN];
+} __packed;
+#define NBL_IPRO_IN_PKT_CAP_REG(r) (NBL_IPRO_IN_PKT_CAP_ADDR + \
+		(NBL_IPRO_IN_PKT_CAP_DWLEN * 4) * (r))
+
+#define NBL_IPRO_ERRCODE_TBL_ADDR  (0xb05000)
+#define NBL_IPRO_ERRCODE_TBL_DEPTH (16)
+#define NBL_IPRO_ERRCODE_TBL_WIDTH (64)
+#define NBL_IPRO_ERRCODE_TBL_DWLEN (2)
+union ipro_errcode_tbl_u {
+	struct ipro_errcode_tbl {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 dqueue_pri:2;        /* [13:12] Default:0x0 RW */
+		u32 set_dport_pri:2;     /* [15:14] Default:0x0 RW */
+		u32 set_dport:16;        /* [31:16] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [32] Default:0x0 RW */
+		u32 proc_done:1;         /* [33] Default:0x0 RW */
+		u32 vld:1;               /* [34] Default:0x0 RW */
+		u32 rsv:29;              /* [63:35] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_ERRCODE_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_ERRCODE_TBL_REG(r) (NBL_IPRO_ERRCODE_TBL_ADDR + \
+		(NBL_IPRO_ERRCODE_TBL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_DN_PTYPE_TBL_ADDR  (0xb06000)
+#define NBL_IPRO_DN_PTYPE_TBL_DEPTH (256)
+#define NBL_IPRO_DN_PTYPE_TBL_WIDTH (64)
+#define NBL_IPRO_DN_PTYPE_TBL_DWLEN (2)
+union ipro_dn_ptype_tbl_u {
+	struct ipro_dn_ptype_tbl {
+		u32 dn_entry_vld:1;      /* [0] Default:0x0 RW */
+		u32 dn_mirror_en:1;      /* [1] Default:0x0 RW */
+		u32 dn_mirror_pri:2;     /* [3:2] Default:0x0 RW */
+		u32 dn_mirror_id:4;      /* [7:4] Default:0x0 RW */
+		u32 dn_encap_en:1;       /* [8] Default:0x0 RW */
+		u32 dn_encap_pri:2;      /* [10:9] Default:0x0 RW */
+		u32 dn_encap_index:13;   /* [23:11] Default:0x0 RW */
+		u32 not_used_0:6;        /* [29:24] Default:0x0 RW */
+		u32 proc_done:1;         /* [30] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [31] Default:0x0 RW */
+		u32 set_dport:16;        /* [47:32] Default:0x0 RW */
+		u32 set_dport_pri:2;     /* [49:48] Default:0x0 RW */
+		u32 dqueue_pri:2;        /* [51:50] Default:0x0 RW */
+		u32 dqueue:11;           /* [62:52] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [63] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_DN_PTYPE_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_DN_PTYPE_TBL_REG(r) (NBL_IPRO_DN_PTYPE_TBL_ADDR + \
+		(NBL_IPRO_DN_PTYPE_TBL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_UP_PTYPE_TBL_ADDR  (0xb06800)
+#define NBL_IPRO_UP_PTYPE_TBL_DEPTH (256)
+#define NBL_IPRO_UP_PTYPE_TBL_WIDTH (64)
+#define NBL_IPRO_UP_PTYPE_TBL_DWLEN (2)
+union ipro_up_ptype_tbl_u {
+	struct ipro_up_ptype_tbl {
+		u32 up_entry_vld:1;      /* [0] Default:0x0 RW */
+		u32 up_mirror_en:1;      /* [1] Default:0x0 RW */
+		u32 up_mirror_pri:2;     /* [3:2] Default:0x0 RW */
+		u32 up_mirror_id:4;      /* [7:4] Default:0x0 RW */
+		u32 up_decap_en:1;       /* [8] Default:0x0 RW */
+		u32 up_decap_pri:2;      /* [10:9] Default:0x0 RW */
+		u32 not_used_1:19;       /* [29:11] Default:0x0 RW */
+		u32 proc_done:1;         /* [30] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [31] Default:0x0 RW */
+		u32 set_dport:16;        /* [47:32] Default:0x0 RW */
+		u32 set_dport_pri:2;     /* [49:48] Default:0x0 RW */
+		u32 dqueue_pri:2;        /* [51:50] Default:0x0 RW */
+		u32 dqueue:11;           /* [62:52] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [63] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_UP_PTYPE_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_UP_PTYPE_TBL_REG(r) (NBL_IPRO_UP_PTYPE_TBL_ADDR + \
+		(NBL_IPRO_UP_PTYPE_TBL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_QUEUE_TBL_ADDR  (0xb08000)
+#define NBL_IPRO_QUEUE_TBL_DEPTH (2048)
+#define NBL_IPRO_QUEUE_TBL_WIDTH (32)
+#define NBL_IPRO_QUEUE_TBL_DWLEN (1)
+union ipro_queue_tbl_u {
+	struct ipro_queue_tbl {
+		u32 vsi:10;              /* [9:0] Default:0x0 RW */
+		u32 vsi_en:1;            /* [10] Default:0x0 RW */
+		u32 rsv:21;              /* [31:11] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_QUEUE_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_QUEUE_TBL_REG(r) (NBL_IPRO_QUEUE_TBL_ADDR + \
+		(NBL_IPRO_QUEUE_TBL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_UP_SRC_PORT_TBL_ADDR  (0xb0b000)
+#define NBL_IPRO_UP_SRC_PORT_TBL_DEPTH (4)
+#define NBL_IPRO_UP_SRC_PORT_TBL_WIDTH (64)
+#define NBL_IPRO_UP_SRC_PORT_TBL_DWLEN (2)
+union ipro_up_src_port_tbl_u {
+	struct ipro_up_src_port_tbl {
+		u32 entry_vld:1;         /* [0] Default:0x0 RW */
+		u32 vlan_layer_num_0:2;  /* [2:1] Default:0x0 RW */
+		u32 vlan_layer_num_1:2;  /* [4:3] Default:0x0 RW */
+		u32 lag_vld:1;           /* [5] Default:0x0 RW */
+		u32 lag_id:2;            /* [7:6] Default:0x0 RW */
+		u32 hw_flow:1;          /* [8] Default:0x0 RW */
+		u32 mirror_en:1;         /* [9] Default:0x0 RW */
+		u32 mirror_pr:2;         /* [11:10] Default:0x0 RW */
+		u32 mirror_id:4;         /* [15:12] Default:0x0 RW */
+		u32 dqueue_pri:2;        /* [17:16] Default:0x0 RW */
+		u32 set_dport_pri:2;     /* [19:18] Default:0x0 RW */
+		u32 dqueue:11;           /* [30:20] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [31] Default:0x0 RW */
+		u32 set_dport:16;        /* [47:32] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [48] Default:0x0 RW */
+		u32 proc_done:1;         /* [49] Default:0x0 RW */
+		u32 car_en:1;            /* [50] Default:0x0 RW */
+		u32 car_pr:2;            /* [52:51] Default:0x0 RW */
+		u32 car_id:10;           /* [62:53] Default:0x0 RW */
+		u32 rsv:1;               /* [63] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_UP_SRC_PORT_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_UP_SRC_PORT_TBL_REG(r) (NBL_IPRO_UP_SRC_PORT_TBL_ADDR + \
+		(NBL_IPRO_UP_SRC_PORT_TBL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_DN_SRC_PORT_TBL_ADDR  (0xb0c000)
+#define NBL_IPRO_DN_SRC_PORT_TBL_DEPTH (1024)
+#define NBL_IPRO_DN_SRC_PORT_TBL_WIDTH (128)
+#define NBL_IPRO_DN_SRC_PORT_TBL_DWLEN (4)
+union ipro_dn_src_port_tbl_u {
+	struct ipro_dn_src_port_tbl {
+		u32 entry_vld:1;         /* [0] Default:0x0 RW */
+		u32 mirror_en:1;         /* [1] Default:0x0 RW */
+		u32 mirror_pr:2;         /* [3:2] Default:0x0 RW */
+		u32 mirror_id:4;         /* [7:4] Default:0x0 RW */
+		u32 vlan_layer_num_1:2;  /* [9:8] Default:0x0 RW */
+		u32 hw_flow:1;          /* [10] Default:0x0 RW */
+		u32 mtu_sel:4;           /* [14:11] Default:0x0 RW */
+		u32 addr_check_en:1;     /* [15] Default:0x0 RW */
+		u32 smac_l:32;           /* [63:16] Default:0x0 RW */
+		u32 smac_h:16;           /* [63:16] Default:0x0 RW */
+		u32 dqueue:11;           /* [74:64] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [75] Default:0x0 RW */
+		u32 dqueue_pri:2;        /* [77:76] Default:0x0 RW */
+		u32 set_dport_pri:2;     /* [79:78] Default:0x0 RW */
+		u32 set_dport:16;        /* [95:80] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [96] Default:0x0 RW */
+		u32 proc_done:1;         /* [97] Default:0x0 RW */
+		u32 not_used_1:2;        /* [99:98] Default:0x0 RW */
+		u32 rsv:28;              /* [127:100] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_DN_SRC_PORT_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_DN_SRC_PORT_TBL_REG(r) (NBL_IPRO_DN_SRC_PORT_TBL_ADDR + \
+		(NBL_IPRO_DN_SRC_PORT_TBL_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index b078b765f772..b562b2426a5a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -8,6 +8,1707 @@
 #define _NBL_HW_LEONIS_H_
 
 #include "nbl_core.h"
+#include "nbl_hw.h"
 #include "nbl_hw_reg.h"
 
+#define NBL_NOTIFY_DELAY_MAX_TIME_FOR_REGS \
+	300 /* 300us for palladium,5us for s2c */
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
+#define NBL_DRIVER_STATUS_REG			(0x1300444)
+#define NBL_DRIVER_STATUS_BIT			(16)
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
+#define NBL_ACL_GET_ACTION_DATA(act_buf, act_data) \
+	(act_data = (act_buf) & 0x3fffff)
+#define NBL_ACL_FLUSH_FLOW_BTM 0x7fff
+#define NBL_ACL_FLUSH_UPCALL_BTM 0x8000
+
+#define NBL_ACL_TCAM_DATA_X(t) (NBL_PPE_ACL_BASE + 0x00000904 + ((t) * 8))
+#define NBL_ACL_TCAM_DATA_Y(t) (NBL_PPE_ACL_BASE + 0x00000990 + ((t) * 8))
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
+#define NBL_FEM_EM_TCAM_TABLE_REG(r, t)               \
+	(NBL_FEM_EM0_TCAM_TABLE_ADDR + 0x1000 * (r) + \
+	 (NBL_FEM_EM_TCAM_TABLE_WIDTH / 8) * (t))
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
+#define NBL_FEM_EM_AD_TABLE_REG(r, t)               \
+	(NBL_FEM_EM0_AD_TABLE_ADDR + 0x1000 * (r) + \
+	 (NBL_FEM_EM_AD_TABLE_WIDTH / 8) * (t))
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
+#define NBL_FEM0_PROFILE_TABLE(t) \
+	(NBL_PPE_FEM_BASE + 0x00001000 + (NBL_FEM_PROFILE_TBL_WIDTH) * (t))
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
+#define NBL_LB_PF_CONFIGSPACE_SELECT_OFFSET (0x81100000)
+#define NBL_LB_PF_CONFIGSPACE_SELECT_STRIDE (0x00100000)
+#define NBL_LB_PF_CONFIGSPACE_BASE_ADDR (NBL_LB_PCIEX16_TOP_BASE + 0x00024000)
+#define NBL_LB_PCIEX16_TOP_AHB (NBL_LB_PCIEX16_TOP_BASE + 0x00000020)
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
+struct nbl_adminq_qinfo_map_table {
+	u32 function:3;
+	u32 devid:5;
+	u32 bus:8;
+	u32 msix_idx:13;
+	u32 msix_idx_valid:1;
+	u32 rsv:2;
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
+#define NBL_PCIE_HOST_K_PF_MASK_REG (NBL_INTF_HOST_PCIE_BASE + 0x00001004)
+#define NBL_PCIE_HOST_K_PF_FID(pf_id) \
+	(NBL_INTF_HOST_PCIE_BASE + 0x0000106C + 4 * (pf_id))
+#define NBL_PCIE_HOST_TL_CFG_BUSDEV (NBL_INTF_HOST_PCIE_BASE + 0x11040)
+
+/*  --------  HOST_PADPT  --------  */
+#define NBL_HOST_PADPT_HOST_CFG_FC_PD_DN (NBL_INTF_HOST_PADPT_BASE + 0x00000160)
+#define NBL_HOST_PADPT_HOST_CFG_FC_PH_DN (NBL_INTF_HOST_PADPT_BASE + 0x00000164)
+#define NBL_HOST_PADPT_HOST_CFG_FC_NPH_DN \
+	(NBL_INTF_HOST_PADPT_BASE + 0x0000016C)
+#define NBL_HOST_PADPT_HOST_CFG_FC_CPLH_UP \
+	(NBL_INTF_HOST_PADPT_BASE + 0x00000170)
+/* host_padpt host_msix_info */
+#define NBL_PADPT_ABNORMAL_MSIX_VEC (NBL_INTF_HOST_PADPT_BASE + 0x00000200)
+#define NBL_PADPT_ABNORMAL_TIMEOUT (NBL_INTF_HOST_PADPT_BASE + 0x00000204)
+#define NBL_PADPT_HOST_MSIX_INFO_REG_ARR(vector_id) \
+	(NBL_INTF_HOST_PADPT_BASE + 0x00010000 +    \
+	 (vector_id) * sizeof(struct nbl_host_msix_info))
+/* host_padpt host_vnet_qinfo */
+#define NBL_PADPT_HOST_VNET_QINFO_REG_ARR(queue_id) \
+	(NBL_INTF_HOST_PADPT_BASE + 0x00008000 +    \
+	 (queue_id) * sizeof(struct nbl_host_vnet_qinfo))
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
+#define NBL_PCOMPLETER_QID_MAP_REG_ARR(select, i)          \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x00010000 +      \
+	 (select) * NBL_QID_MAP_TABLE_ENTRIES *            \
+		 sizeof(struct nbl_virtio_qid_map_table) + \
+	 (i) * sizeof(struct nbl_virtio_qid_map_table))
+#define NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(i)   \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x00004000 + \
+	 (i) * sizeof(struct nbl_function_msix_map))
+#define NBL_PCOMPLETER_HOST_MSIX_FID_TABLE(i)         \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x0003a000 + \
+	 (i) * sizeof(struct nbl_pcompleter_host_msix_fid_table))
+#define NBL_PCOMPLETER_INT_STATUS (NBL_INTF_HOST_PCOMPLETER_BASE + 0x00000000)
+#define NBL_PCOMPLETER_TLP_OUT_DROP_CNT \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x00002430)
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
+#define NBL_HOST_PCAP_TX_CAP_EN (NBL_INTF_HOST_PCAP_BASE + 0x00000200)
+#define NBL_HOST_PCAP_TX_CAP_STORE (NBL_INTF_HOST_PCAP_BASE + 0x00000204)
+#define NBL_HOST_PCAP_TX_CAP_STALL (NBL_INTF_HOST_PCAP_BASE + 0x00000208)
+#define NBL_HOST_PCAP_RX_CAP_EN (NBL_INTF_HOST_PCAP_BASE + 0x00000800)
+#define NBL_HOST_PCAP_RX_CAP_STORE (NBL_INTF_HOST_PCAP_BASE + 0x00000804)
+#define NBL_HOST_PCAP_RX_CAP_STALL (NBL_INTF_HOST_PCAP_BASE + 0x00000808)
+
+/*  ----------  DPED  ----------  */
+#define NBL_DPED_VLAN_OFFSET		(NBL_DP_DPED_BASE + 0x000003F4)
+#define NBL_DPED_DSCP_OFFSET_0		(NBL_DP_DPED_BASE + 0x000003F8)
+#define NBL_DPED_DSCP_OFFSET_1		(NBL_DP_DPED_BASE + 0x000003FC)
+
+/* DPED dped_hw_edt_prof */
+#define NBL_DPED_HW_EDT_PROF_TABLE(i)    \
+	(NBL_DP_DPED_BASE + 0x00001000 + \
+	 (i) * sizeof(struct ped_hw_edit_profile))
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
+#define NBL_UPED_HW_EDT_PROF_TABLE(i)    \
+	(NBL_DP_UPED_BASE + 0x00001000 + \
+	 (i) * sizeof(struct ped_hw_edit_profile))
+
+/*  ---------  SHAPING  ---------  */
+#define NBL_SHAPING_NET_TIMMING_ADD_ADDR (NBL_DP_SHAPING_BASE + 0x00000300)
+#define NBL_SHAPING_NET(i)                  \
+	(NBL_DP_SHAPING_BASE + 0x00001800 + \
+	 (i) * sizeof(struct nbl_shaping_net))
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
+#define NBL_DSTORE_DISC_BP_TH (NBL_DP_DSTORE_BASE + 0x00000630)
+
+struct dstore_disc_bp_th {
+	u32 xoff_th:10;
+	u32 rsv1:6;
+	u32 xon_th:10;
+	u32 rsv:5;
+	u32 en:1;
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
+	(NBL_DP_DSCH_BASE + 0x00010000 +      \
+	 (i) * sizeof(struct dsch_vn_q2tc_cfg_tbl))
+/* DSCH dsch_vn_n2g_cfg_tbl */
+#define NBL_DSCH_VN_N2G_CFG_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00060000 +     \
+	 (i) * sizeof(struct dsch_vn_n2g_cfg_tbl))
+/* DSCH dsch_vn_g2p_cfg_tbl */
+#define NBL_DSCH_VN_G2P_CFG_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00064000 +     \
+	 (i) * sizeof(struct dsch_vn_g2p_cfg_tbl))
+/* DSCH dsch_vn_sha2net_map_tbl */
+#define NBL_DSCH_VN_SHA2NET_MAP_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00070000 +         \
+	 (i) * sizeof(struct dsch_vn_sha2net_map_tbl))
+/* DSCH dsch_vn_net2sha_map_tbl */
+#define NBL_DSCH_VN_NET2SHA_MAP_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00074000 +         \
+	 (i) * sizeof(struct dsch_vn_net2sha_map_tbl))
+/* DSCH dsch_vn_tc_q_list_tbl */
+#define NBL_DSCH_VN_TC_Q_LIST_TABLE_REG_ARR(i) \
+	(NBL_DP_DSCH_BASE + 0x00040000 +       \
+	 (i) * sizeof(struct dsch_vn_tc_q_list_tbl))
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
+struct dsch_vn_quanta {
+	u32 h_qua:16;
+	u32 e_qua:16;
+};
+
+/*  ----------  DVN  ----------  */
+/* DVN dvn_queue_table */
+#define NBL_DVN_QUEUE_TABLE_ARR(i) \
+	(NBL_DP_DVN_BASE + 0x00020000 + (i) * sizeof(struct dvn_queue_table))
+#define NBL_DVN_QUEUE_CXT_TABLE_ARR(i) \
+	(NBL_DP_DVN_BASE + 0x00030000 + (i) * sizeof(struct dvn_queue_context))
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
+	/* packet ring descreq_num 0:8,1:12,2:16;3:20,4:24,5:26;6:32,7:32 */
+	u32 packed_l1_num:3;
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
+#define NBL_UVN_STATIS_PKT_DROP(i) \
+	(NBL_DP_UVN_BASE + 0x00038000 + (i) * sizeof(u32))
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
+#define NBL_USTORE_PKT_LEN_ADDR (NBL_DP_USTORE_BASE + 0x00000108)
+#define NBL_USTORE_PORT_FC_TH_REG_ARR(port_id) \
+	(NBL_DP_USTORE_BASE + 0x00000134 +     \
+	 (port_id) * sizeof(struct nbl_ustore_port_fc_th))
+#define NBL_USTORE_COS_FC_TH_REG_ARR(cos_id) \
+	(NBL_DP_USTORE_BASE + 0x00000200 +   \
+	 (cos_id) * sizeof(struct nbl_ustore_cos_fc_th))
+#define NBL_USTORE_PORT_DROP_TH_REG_ARR(port_id) \
+	(NBL_DP_USTORE_BASE + 0x00000150 +       \
+	 (port_id) * sizeof(struct nbl_ustore_port_drop_th))
+#define NBL_USTORE_BUF_TOTAL_DROP_PKT (NBL_DP_USTORE_BASE + 0x000010A8)
+#define NBL_USTORE_BUF_TOTAL_TRUN_PKT (NBL_DP_USTORE_BASE + 0x000010AC)
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
+#define NBL_DSTAT_VSI_STAT(vsi_id)        \
+	(NBL_DP_DSTAT_BASE + 0x00008000 + \
+	 (vsi_id) * sizeof(struct nbl_dstat_vsi_stat))
+
+struct nbl_dstat_vsi_stat {
+	u32 fwd_byte_cnt_low;
+	u32 fwd_byte_cnt_high;
+	u32 fwd_pkt_cnt_low;
+	u32 fwd_pkt_cnt_high;
+};
+
+/*  ---------  USTAT  ---------  */
+#define NBL_USTAT_VSI_STAT(vsi_id)        \
+	(NBL_DP_USTAT_BASE + 0x00008000 + \
+	 (vsi_id) * sizeof(struct nbl_ustat_vsi_stat))
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
+#define NBL_IPRO_UP_SPORT_TABLE(i)      \
+	(NBL_IPRO_MODULE + 0x00007000 + \
+	 (i) * sizeof(struct nbl_ipro_upsport_tbl))
+#define NBL_IPRO_DN_SRC_PORT_TABLE(i)     \
+	(NBL_PPE_IPRO_BASE + 0x00008000 + \
+	 (i) * sizeof(struct nbl_ipro_dn_src_port_tbl))
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
+#define NBL_EPRO_ACTION_FILTER_TABLE(i)   \
+	(NBL_PPE_EPRO_BASE + 0x00001900 + \
+	 sizeof(struct nbl_epro_action_filter_tbl) * (i))
+/* epro epro_ept table */
+#define NBL_EPRO_EPT_TABLE(i) \
+	(NBL_PPE_EPRO_BASE + 0x00001800 + (i) * sizeof(struct nbl_epro_ept_tbl))
+/* epro epro_vpt table */
+#define NBL_EPRO_VPT_TABLE(i) \
+	(NBL_PPE_EPRO_BASE + 0x00004000 + (i) * sizeof(struct nbl_epro_vpt_tbl))
+/* epro epro_rss_pt table */
+#define NBL_EPRO_RSS_PT_TABLE(i)          \
+	(NBL_PPE_EPRO_BASE + 0x00002000 + \
+	 (i) * sizeof(struct nbl_epro_rss_pt_tbl))
+/* epro epro_rss_ret table */
+#define NBL_EPRO_RSS_RET_TABLE(i)         \
+	(NBL_PPE_EPRO_BASE + 0x00008000 + \
+	 (i) * sizeof(struct nbl_epro_rss_ret_tbl))
+/* epro epro_sch_cos_map table */
+#define NBL_EPRO_SCH_COS_MAP_TABLE(i, j)                 \
+	(NBL_PPE_EPRO_BASE + 0x00000640 + ((i) * 0x20) + \
+	 (j) * sizeof(struct nbl_epro_cos_map))
+/* epro epro_port_pri_mdf_en */
+#define NBL_EPRO_PORT_PRI_MDF_EN	(NBL_PPE_EPRO_BASE + 0x000006E0)
+/* epro epro_act_sel_en */
+#define NBL_EPRO_ACT_SEL_EN_REG (NBL_PPE_EPRO_BASE + 0x00000214)
+/* epro epro_kgen_ft table */
+#define NBL_EPRO_KGEN_FT_TABLE(i)         \
+	(NBL_PPE_EPRO_BASE + 0x00001980 + \
+	 (i) * sizeof(struct nbl_epro_kgen_ft_tbl))
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
+#define NBL_UPA_PRI_SEL_CONF_TABLE(id)  \
+	(NBL_DP_UPA_BASE + 0x00000230 + \
+	 ((id) * sizeof(struct nbl_upa_pri_sel_conf)))
+#define NBL_UPA_PRI_CONF_TABLE(id)      \
+	(NBL_DP_UPA_BASE + 0x00002000 + \
+	 ((id) * sizeof(struct nbl_upa_pri_conf)))
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
+#define NBL_BYTES_IN_REG			(4)
+
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
+#define NBL_SHAPING_GRP_REG(r) \
+	(NBL_SHAPING_GRP_ADDR + (NBL_SHAPING_GRP_DWLEN * 4) * (r))
+#define NBL_DSCH_VN_SHA2GRP_MAP_TBL_ADDR (0x47c000)
+#define NBL_DSCH_VN_SHA2GRP_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_VN_SHA2GRP_MAP_TBL_REG(r)  \
+	(NBL_DSCH_VN_SHA2GRP_MAP_TBL_ADDR + \
+	 (NBL_DSCH_VN_SHA2GRP_MAP_TBL_DWLEN * 4) * (r))
+#define NBL_DSCH_VN_GRP2SHA_MAP_TBL_ADDR (0x480000)
+#define NBL_DSCH_VN_GRP2SHA_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_VN_GRP2SHA_MAP_TBL_REG(r)  \
+	(NBL_DSCH_VN_GRP2SHA_MAP_TBL_ADDR + \
+	 (NBL_DSCH_VN_GRP2SHA_MAP_TBL_DWLEN * 4) * (r))
+#define NBL_SHAPING_DPORT_TIMMING_ADD_ADDR (0x504504)
+#define NBL_SHAPING_DPORT_ADDR (0x504700)
+#define NBL_SHAPING_DPORT_DWLEN (4)
+#define NBL_SHAPING_DPORT_REG(r) \
+	(NBL_SHAPING_DPORT_ADDR + (NBL_SHAPING_DPORT_DWLEN * 4) * (r))
+#define NBL_SHAPING_DVN_DPORT_ADDR (0x504750)
+#define NBL_SHAPING_DVN_DPORT_DWLEN (4)
+#define NBL_SHAPING_DVN_DPORT_REG(r) \
+	(NBL_SHAPING_DVN_DPORT_ADDR + (NBL_SHAPING_DVN_DPORT_DWLEN * 4) * (r))
+#define NBL_SHAPING_RDMA_DPORT_ADDR (0x5047a0)
+#define NBL_SHAPING_RDMA_DPORT_DWLEN (4)
+#define NBL_SHAPING_RDMA_DPORT_REG(r) \
+	(NBL_SHAPING_RDMA_DPORT_ADDR + (NBL_SHAPING_RDMA_DPORT_DWLEN * 4) * (r))
+#define NBL_DSCH_PSHA_EN_ADDR (0x404314)
+#define NBL_SHAPING_NET_ADDR (0x505800)
+#define NBL_SHAPING_NET_DWLEN (4)
+#define NBL_SHAPING_NET_REG(r) \
+	(NBL_SHAPING_NET_ADDR + (NBL_SHAPING_NET_DWLEN * 4) * (r))
+#define NBL_DSCH_VN_SHA2NET_MAP_TBL_ADDR (0x474000)
+#define NBL_DSCH_VN_SHA2NET_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_VN_SHA2NET_MAP_TBL_REG(r)  \
+	(NBL_DSCH_VN_SHA2NET_MAP_TBL_ADDR + \
+	 (NBL_DSCH_VN_SHA2NET_MAP_TBL_DWLEN * 4) * (r))
+#define NBL_DSCH_VN_NET2SHA_MAP_TBL_ADDR (0x478000)
+#define NBL_DSCH_VN_NET2SHA_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_VN_NET2SHA_MAP_TBL_REG(r)  \
+	(NBL_DSCH_VN_NET2SHA_MAP_TBL_ADDR + \
+	 (NBL_DSCH_VN_NET2SHA_MAP_TBL_DWLEN * 4) * (r))
+
+#define NBL_DSCH_RDMA_SHA2NET_MAP_TBL_ADDR (0x49c000)
+#define NBL_DSCH_RDMA_SHA2NET_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_RDMA_SHA2NET_MAP_TBL_REG(r)  \
+	(NBL_DSCH_RDMA_SHA2NET_MAP_TBL_ADDR + \
+	 (NBL_DSCH_RDMA_SHA2NET_MAP_TBL_DWLEN * 4) * (r))
+#define NBL_DSCH_RDMA_NET2SHA_MAP_TBL_ADDR (0x494000)
+#define NBL_DSCH_RDMA_NET2SHA_MAP_TBL_DWLEN (1)
+#define NBL_DSCH_RDMA_NET2SHA_MAP_TBL_REG(r)  \
+	(NBL_DSCH_RDMA_NET2SHA_MAP_TBL_ADDR + \
+	 (NBL_DSCH_RDMA_NET2SHA_MAP_TBL_DWLEN * 4) * (r))
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
+#define NBL_ACL_ACTION_RAM_TBL(r, i)                \
+	(NBL_ACL_BASE + 0x00002000 + 0x2000 * (r) + \
+	 (NBL_ACL_ACTION_RAM0_DWLEN * 4 * (i)))
+#define NBL_DPED_MIR_CMD_0_TABLE(t) \
+	(NBL_DPED_MIR_CMD_00_ADDR + (NBL_DPED_MIR_CMD_00_DWLEN * 2 * (t)))
+#define NBL_SET_DPORT(upcall_flag, nxtstg_sel, port_type, port_id)      \
+	((upcall_flag) << 14 | (nxtstg_sel) << 12 | (port_type) << 10 | \
+	 (port_id))
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
+#define NBL_LEONIS_ILLEGAL_REG_VALUE	(0xDEADBEEF)
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
new file mode 100644
index 000000000000..6486fc74ab31
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
@@ -0,0 +1,3863 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_hw_reg.h"
+#include "nbl_hw_leonis.h"
+#include "nbl_hw_leonis_regs.h"
+
+#define NBL_SEC_BLOCK_SIZE		(0x100)
+#define NBL_SEC000_SIZE			(1)
+#define NBL_SEC000_ADDR			(0x114150)
+#define NBL_SEC001_SIZE			(1)
+#define NBL_SEC001_ADDR			(0x15c190)
+#define NBL_SEC002_SIZE			(1)
+#define NBL_SEC002_ADDR			(0x10417c)
+#define NBL_SEC003_SIZE			(1)
+#define NBL_SEC003_ADDR			(0x714154)
+#define NBL_SEC004_SIZE			(1)
+#define NBL_SEC004_ADDR			(0x75c190)
+#define NBL_SEC005_SIZE			(1)
+#define NBL_SEC005_ADDR			(0x70417c)
+#define NBL_SEC006_SIZE			(512)
+#define NBL_SEC006_ADDR			(0x8f000)
+#define NBL_SEC006_REGI(i)		(0x8f000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC007_SIZE			(256)
+#define NBL_SEC007_ADDR			(0x8f800)
+#define NBL_SEC007_REGI(i)		(0x8f800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC008_SIZE			(1024)
+#define NBL_SEC008_ADDR			(0x90000)
+#define NBL_SEC008_REGI(i)		(0x90000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC009_SIZE			(2048)
+#define NBL_SEC009_ADDR			(0x94000)
+#define NBL_SEC009_REGI(i)		(0x94000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC010_SIZE			(256)
+#define NBL_SEC010_ADDR			(0x96000)
+#define NBL_SEC010_REGI(i)		(0x96000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC011_SIZE			(1024)
+#define NBL_SEC011_ADDR			(0x91000)
+#define NBL_SEC011_REGI(i)		(0x91000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC012_SIZE			(128)
+#define NBL_SEC012_ADDR			(0x92000)
+#define NBL_SEC012_REGI(i)		(0x92000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC013_SIZE			(64)
+#define NBL_SEC013_ADDR			(0x92200)
+#define NBL_SEC013_REGI(i)		(0x92200 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC014_SIZE			(64)
+#define NBL_SEC014_ADDR			(0x92300)
+#define NBL_SEC014_REGI(i)		(0x92300 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC015_SIZE			(1)
+#define NBL_SEC015_ADDR			(0x8c214)
+#define NBL_SEC016_SIZE			(1)
+#define NBL_SEC016_ADDR			(0x8c220)
+#define NBL_SEC017_SIZE			(1)
+#define NBL_SEC017_ADDR			(0x8c224)
+#define NBL_SEC018_SIZE			(1)
+#define NBL_SEC018_ADDR			(0x8c228)
+#define NBL_SEC019_SIZE			(1)
+#define NBL_SEC019_ADDR			(0x8c22c)
+#define NBL_SEC020_SIZE			(1)
+#define NBL_SEC020_ADDR			(0x8c1f0)
+#define NBL_SEC021_SIZE			(1)
+#define NBL_SEC021_ADDR			(0x8c1f8)
+#define NBL_SEC022_SIZE			(256)
+#define NBL_SEC022_ADDR			(0x85f000)
+#define NBL_SEC022_REGI(i)		(0x85f000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC023_SIZE			(128)
+#define NBL_SEC023_ADDR			(0x85f800)
+#define NBL_SEC023_REGI(i)		(0x85f800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC024_SIZE			(512)
+#define NBL_SEC024_ADDR			(0x860000)
+#define NBL_SEC024_REGI(i)		(0x860000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC025_SIZE			(1024)
+#define NBL_SEC025_ADDR			(0x864000)
+#define NBL_SEC025_REGI(i)		(0x864000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC026_SIZE			(256)
+#define NBL_SEC026_ADDR			(0x866000)
+#define NBL_SEC026_REGI(i)		(0x866000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC027_SIZE			(512)
+#define NBL_SEC027_ADDR			(0x861000)
+#define NBL_SEC027_REGI(i)		(0x861000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC028_SIZE			(64)
+#define NBL_SEC028_ADDR			(0x862000)
+#define NBL_SEC028_REGI(i)		(0x862000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC029_SIZE			(32)
+#define NBL_SEC029_ADDR			(0x862200)
+#define NBL_SEC029_REGI(i)		(0x862200 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC030_SIZE			(32)
+#define NBL_SEC030_ADDR			(0x862300)
+#define NBL_SEC030_REGI(i)		(0x862300 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC031_SIZE			(1)
+#define NBL_SEC031_ADDR			(0x85c214)
+#define NBL_SEC032_SIZE			(1)
+#define NBL_SEC032_ADDR			(0x85c220)
+#define NBL_SEC033_SIZE			(1)
+#define NBL_SEC033_ADDR			(0x85c224)
+#define NBL_SEC034_SIZE			(1)
+#define NBL_SEC034_ADDR			(0x85c228)
+#define NBL_SEC035_SIZE			(1)
+#define NBL_SEC035_ADDR			(0x85c22c)
+#define NBL_SEC036_SIZE			(1)
+#define NBL_SEC036_ADDR			(0xb04200)
+#define NBL_SEC037_SIZE			(1)
+#define NBL_SEC037_ADDR			(0xb04230)
+#define NBL_SEC038_SIZE			(1)
+#define NBL_SEC038_ADDR			(0xb04234)
+#define NBL_SEC039_SIZE			(64)
+#define NBL_SEC039_ADDR			(0xb05800)
+#define NBL_SEC039_REGI(i)		(0xb05800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC040_SIZE			(32)
+#define NBL_SEC040_ADDR			(0xb05400)
+#define NBL_SEC040_REGI(i)		(0xb05400 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC041_SIZE			(16)
+#define NBL_SEC041_ADDR			(0xb05500)
+#define NBL_SEC041_REGI(i)		(0xb05500 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC042_SIZE			(1)
+#define NBL_SEC042_ADDR			(0xb14148)
+#define NBL_SEC043_SIZE			(1)
+#define NBL_SEC043_ADDR			(0xb14104)
+#define NBL_SEC044_SIZE			(1)
+#define NBL_SEC044_ADDR			(0xb1414c)
+#define NBL_SEC045_SIZE			(1)
+#define NBL_SEC045_ADDR			(0xb14150)
+#define NBL_SEC046_SIZE			(256)
+#define NBL_SEC046_ADDR			(0xb15000)
+#define NBL_SEC046_REGI(i)		(0xb15000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC047_SIZE			(32)
+#define NBL_SEC047_ADDR			(0xb15800)
+#define NBL_SEC047_REGI(i)		(0xb15800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC048_SIZE			(1)
+#define NBL_SEC048_ADDR			(0xb24148)
+#define NBL_SEC049_SIZE			(1)
+#define NBL_SEC049_ADDR			(0xb24104)
+#define NBL_SEC050_SIZE			(1)
+#define NBL_SEC050_ADDR			(0xb2414c)
+#define NBL_SEC051_SIZE			(1)
+#define NBL_SEC051_ADDR			(0xb24150)
+#define NBL_SEC052_SIZE			(256)
+#define NBL_SEC052_ADDR			(0xb25000)
+#define NBL_SEC052_REGI(i)		(0xb25000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC053_SIZE			(32)
+#define NBL_SEC053_ADDR			(0xb25800)
+#define NBL_SEC053_REGI(i)		(0xb25800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC054_SIZE			(1)
+#define NBL_SEC054_ADDR			(0xb34148)
+#define NBL_SEC055_SIZE			(1)
+#define NBL_SEC055_ADDR			(0xb34104)
+#define NBL_SEC056_SIZE			(1)
+#define NBL_SEC056_ADDR			(0xb3414c)
+#define NBL_SEC057_SIZE			(1)
+#define NBL_SEC057_ADDR			(0xb34150)
+#define NBL_SEC058_SIZE			(256)
+#define NBL_SEC058_ADDR			(0xb35000)
+#define NBL_SEC058_REGI(i)		(0xb35000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC059_SIZE			(32)
+#define NBL_SEC059_ADDR			(0xb35800)
+#define NBL_SEC059_REGI(i)		(0xb35800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC060_SIZE			(1)
+#define NBL_SEC060_ADDR			(0xe74630)
+#define NBL_SEC061_SIZE			(1)
+#define NBL_SEC061_ADDR			(0xe74634)
+#define NBL_SEC062_SIZE			(64)
+#define NBL_SEC062_ADDR			(0xe75000)
+#define NBL_SEC062_REGI(i)		(0xe75000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC063_SIZE			(32)
+#define NBL_SEC063_ADDR			(0xe75480)
+#define NBL_SEC063_REGI(i)		(0xe75480 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC064_SIZE			(16)
+#define NBL_SEC064_ADDR			(0xe75980)
+#define NBL_SEC064_REGI(i)		(0xe75980 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC065_SIZE			(32)
+#define NBL_SEC065_ADDR			(0x15f000)
+#define NBL_SEC065_REGI(i)		(0x15f000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC066_SIZE			(32)
+#define NBL_SEC066_ADDR			(0x75f000)
+#define NBL_SEC066_REGI(i)		(0x75f000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC067_SIZE			(1)
+#define NBL_SEC067_ADDR			(0xb64108)
+#define NBL_SEC068_SIZE			(1)
+#define NBL_SEC068_ADDR			(0xb6410c)
+#define NBL_SEC069_SIZE			(1)
+#define NBL_SEC069_ADDR			(0xb64140)
+#define NBL_SEC070_SIZE			(1)
+#define NBL_SEC070_ADDR			(0xb64144)
+#define NBL_SEC071_SIZE			(512)
+#define NBL_SEC071_ADDR			(0xb65000)
+#define NBL_SEC071_REGI(i)		(0xb65000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC072_SIZE			(32)
+#define NBL_SEC072_ADDR			(0xb65800)
+#define NBL_SEC072_REGI(i)		(0xb65800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC073_SIZE			(1)
+#define NBL_SEC073_ADDR			(0x8c210)
+#define NBL_SEC074_SIZE			(1)
+#define NBL_SEC074_ADDR			(0x85c210)
+#define NBL_SEC075_SIZE			(4)
+#define NBL_SEC075_ADDR			(0x8c1b0)
+#define NBL_SEC075_REGI(i)		(0x8c1b0 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC076_SIZE			(4)
+#define NBL_SEC076_ADDR			(0x8c1c0)
+#define NBL_SEC076_REGI(i)		(0x8c1c0 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC077_SIZE			(4)
+#define NBL_SEC077_ADDR			(0x85c1b0)
+#define NBL_SEC077_REGI(i)		(0x85c1b0 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC078_SIZE			(1)
+#define NBL_SEC078_ADDR			(0x85c1ec)
+#define NBL_SEC079_SIZE			(1)
+#define NBL_SEC079_ADDR			(0x8c1ec)
+#define NBL_SEC080_SIZE			(1)
+#define NBL_SEC080_ADDR			(0xb04440)
+#define NBL_SEC081_SIZE			(1)
+#define NBL_SEC081_ADDR			(0xb04448)
+#define NBL_SEC082_SIZE			(1)
+#define NBL_SEC082_ADDR			(0xb14450)
+#define NBL_SEC083_SIZE			(1)
+#define NBL_SEC083_ADDR			(0xb24450)
+#define NBL_SEC084_SIZE			(1)
+#define NBL_SEC084_ADDR			(0xb34450)
+#define NBL_SEC085_SIZE			(1)
+#define NBL_SEC085_ADDR			(0xa04188)
+#define NBL_SEC086_SIZE			(1)
+#define NBL_SEC086_ADDR			(0xe74218)
+#define NBL_SEC087_SIZE			(1)
+#define NBL_SEC087_ADDR			(0xe7421c)
+#define NBL_SEC088_SIZE			(1)
+#define NBL_SEC088_ADDR			(0xe74220)
+#define NBL_SEC089_SIZE			(1)
+#define NBL_SEC089_ADDR			(0xe74224)
+#define NBL_SEC090_SIZE			(1)
+#define NBL_SEC090_ADDR			(0x75c22c)
+#define NBL_SEC091_SIZE			(1)
+#define NBL_SEC091_ADDR			(0x75c230)
+#define NBL_SEC092_SIZE			(1)
+#define NBL_SEC092_ADDR			(0x75c238)
+#define NBL_SEC093_SIZE			(1)
+#define NBL_SEC093_ADDR			(0x75c244)
+#define NBL_SEC094_SIZE			(1)
+#define NBL_SEC094_ADDR			(0x75c248)
+#define NBL_SEC095_SIZE			(1)
+#define NBL_SEC095_ADDR			(0x75c250)
+#define NBL_SEC096_SIZE			(1)
+#define NBL_SEC096_ADDR			(0x15c230)
+#define NBL_SEC097_SIZE			(1)
+#define NBL_SEC097_ADDR			(0x15c234)
+#define NBL_SEC098_SIZE			(1)
+#define NBL_SEC098_ADDR			(0x15c238)
+#define NBL_SEC099_SIZE			(1)
+#define NBL_SEC099_ADDR			(0x15c23c)
+#define NBL_SEC100_SIZE			(1)
+#define NBL_SEC100_ADDR			(0x15c244)
+#define NBL_SEC101_SIZE			(1)
+#define NBL_SEC101_ADDR			(0x15c248)
+#define NBL_SEC102_SIZE			(1)
+#define NBL_SEC102_ADDR			(0xb6432c)
+#define NBL_SEC103_SIZE			(1)
+#define NBL_SEC103_ADDR			(0xb64220)
+#define NBL_SEC104_SIZE			(1)
+#define NBL_SEC104_ADDR			(0xb44804)
+#define NBL_SEC105_SIZE			(1)
+#define NBL_SEC105_ADDR			(0xb44a00)
+#define NBL_SEC106_SIZE			(1)
+#define NBL_SEC106_ADDR			(0xe84210)
+#define NBL_SEC107_SIZE			(1)
+#define NBL_SEC107_ADDR			(0xe84214)
+#define NBL_SEC108_SIZE			(1)
+#define NBL_SEC108_ADDR			(0xe64228)
+#define NBL_SEC109_SIZE			(1)
+#define NBL_SEC109_ADDR			(0x65413c)
+#define NBL_SEC110_SIZE			(1)
+#define NBL_SEC110_ADDR			(0x984144)
+#define NBL_SEC111_SIZE			(1)
+#define NBL_SEC111_ADDR			(0x114130)
+#define NBL_SEC112_SIZE			(1)
+#define NBL_SEC112_ADDR			(0x714138)
+#define NBL_SEC113_SIZE			(1)
+#define NBL_SEC113_ADDR			(0x114134)
+#define NBL_SEC114_SIZE			(1)
+#define NBL_SEC114_ADDR			(0x71413c)
+#define NBL_SEC115_SIZE			(1)
+#define NBL_SEC115_ADDR			(0x90437c)
+#define NBL_SEC116_SIZE			(32)
+#define NBL_SEC116_ADDR			(0xb05000)
+#define NBL_SEC116_REGI(i)		(0xb05000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC117_SIZE			(1)
+#define NBL_SEC117_ADDR			(0xb043e0)
+#define NBL_SEC118_SIZE			(1)
+#define NBL_SEC118_ADDR			(0xb043f0)
+#define NBL_SEC119_SIZE			(5)
+#define NBL_SEC119_ADDR			(0x8c230)
+#define NBL_SEC119_REGI(i)		(0x8c230 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC120_SIZE			(1)
+#define NBL_SEC120_ADDR			(0x8c1f4)
+#define NBL_SEC121_SIZE			(1)
+#define NBL_SEC121_ADDR			(0x2046c4)
+#define NBL_SEC122_SIZE			(1)
+#define NBL_SEC122_ADDR			(0x85c1f4)
+#define NBL_SEC123_SIZE			(1)
+#define NBL_SEC123_ADDR			(0x75c194)
+#define NBL_SEC124_SIZE			(256)
+#define NBL_SEC124_ADDR			(0xa05000)
+#define NBL_SEC124_REGI(i)		(0xa05000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC125_SIZE			(256)
+#define NBL_SEC125_ADDR			(0xa06000)
+#define NBL_SEC125_REGI(i)		(0xa06000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC126_SIZE			(256)
+#define NBL_SEC126_ADDR			(0xa07000)
+#define NBL_SEC126_REGI(i)		(0xa07000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC127_SIZE			(1)
+#define NBL_SEC127_ADDR			(0x75c204)
+#define NBL_SEC128_SIZE			(1)
+#define NBL_SEC128_ADDR			(0x15c204)
+#define NBL_SEC129_SIZE			(1)
+#define NBL_SEC129_ADDR			(0x75c208)
+#define NBL_SEC130_SIZE			(1)
+#define NBL_SEC130_ADDR			(0x15c208)
+#define NBL_SEC131_SIZE			(1)
+#define NBL_SEC131_ADDR			(0x75c20c)
+#define NBL_SEC132_SIZE			(1)
+#define NBL_SEC132_ADDR			(0x15c20c)
+#define NBL_SEC133_SIZE			(1)
+#define NBL_SEC133_ADDR			(0x75c210)
+#define NBL_SEC134_SIZE			(1)
+#define NBL_SEC134_ADDR			(0x15c210)
+#define NBL_SEC135_SIZE			(1)
+#define NBL_SEC135_ADDR			(0x75c214)
+#define NBL_SEC136_SIZE			(1)
+#define NBL_SEC136_ADDR			(0x15c214)
+#define NBL_SEC137_SIZE			(32)
+#define NBL_SEC137_ADDR			(0x15d000)
+#define NBL_SEC137_REGI(i)		(0x15d000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC138_SIZE			(32)
+#define NBL_SEC138_ADDR			(0x75d000)
+#define NBL_SEC138_REGI(i)		(0x75d000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC139_SIZE			(1)
+#define NBL_SEC139_ADDR			(0x75c310)
+#define NBL_SEC140_SIZE			(1)
+#define NBL_SEC140_ADDR			(0x75c314)
+#define NBL_SEC141_SIZE			(1)
+#define NBL_SEC141_ADDR			(0x75c340)
+#define NBL_SEC142_SIZE			(1)
+#define NBL_SEC142_ADDR			(0x75c344)
+#define NBL_SEC143_SIZE			(1)
+#define NBL_SEC143_ADDR			(0x75c348)
+#define NBL_SEC144_SIZE			(1)
+#define NBL_SEC144_ADDR			(0x75c34c)
+#define NBL_SEC145_SIZE			(32)
+#define NBL_SEC145_ADDR			(0xb15800)
+#define NBL_SEC145_REGI(i)		(0xb15800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC146_SIZE			(32)
+#define NBL_SEC146_ADDR			(0xb25800)
+#define NBL_SEC146_REGI(i)		(0xb25800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC147_SIZE			(32)
+#define NBL_SEC147_ADDR			(0xb35800)
+#define NBL_SEC147_REGI(i)		(0xb35800 + NBL_BYTES_IN_REG * (i))
+
+static u32 nbl_sec046_1p_data[] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00077c2b, 0x005c0000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x70000000, 0x00000020, 0x24140000, 0x00000020,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00002100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x20140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x20140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x38430000,
+	0x70000006, 0x00000020, 0x24140000, 0x00000020,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x98cb1180, 0x6e36d469,
+	0x9d8eb91c, 0x87e3ef47, 0xa2931288, 0x08405c5a,
+	0x73865086, 0x00000080, 0x30140000, 0x00000080,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x000b3849, 0x38430000,
+	0x00000006, 0x0000c100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x08400000,
+	0x03865086, 0x4c016100, 0x00000014, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec071_1p_data[] = {
+	0x00000000, 0x00000000, 0x00113d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7029b00, 0x00000000,
+	0x00000000, 0x43000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x51e00000, 0x00000c9c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00293d00, 0x00000000,
+	0x00000000, 0x00000000, 0x67089b00, 0x00000002,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x80000000, 0x00000000, 0xb1e00000, 0x0000189c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x014b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x015b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d29a00, 0x000149c4,
+	0x00000000, 0x4b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d2c000, 0x000149c4,
+	0x00000000, 0x5b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x64d49200, 0x5e556945,
+	0xc666d89a, 0x4b0001a9, 0x00004c84, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x6ed4ba00, 0x5ef56bc5,
+	0xc666d8c0, 0x5b0001a9, 0x00004dc4, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00700000, 0x00000000, 0x08028000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec046_2p_data[] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00077c2b, 0x005c0000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x70000000, 0x00000020, 0x04140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00002100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x00140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x00140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x38430000,
+	0x70000006, 0x00000020, 0x04140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x98cb1180, 0x6e36d469,
+	0x9d8eb91c, 0x87e3ef47, 0xa2931288, 0x08405c5a,
+	0x73865086, 0x00000080, 0x10140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x000b3849, 0x38430000,
+	0x00000006, 0x0000c100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x08400000,
+	0x03865086, 0x4c016100, 0x00000014, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec071_2p_data[] = {
+	0x00000000, 0x00000000, 0x00113d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7029b00, 0x00000000,
+	0x00000000, 0x43000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x51e00000, 0x00000c9c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00293d00, 0x00000000,
+	0x00000000, 0x00000000, 0x67089b00, 0x00000002,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x80000000, 0x00000000, 0xb1e00000, 0x0000189c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x014b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x015b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d29a00, 0x000149c4,
+	0x00000000, 0x4b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d2c000, 0x000149c4,
+	0x00000000, 0x5b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x64d49200, 0x5e556945,
+	0xc666d89a, 0x4b0001a9, 0x00004c84, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x6ed4ba00, 0x5ef56bc5,
+	0xc666d8c0, 0x5b0001a9, 0x00004dc4, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00700000, 0x00000000, 0x00028000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec006_data[] = {
+	0x81008100, 0x00000001, 0x88a88100, 0x00000001,
+	0x810088a8, 0x00000001, 0x88a888a8, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08004000, 0x00000001, 0x86dd6000, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x08060000, 0x00000001, 0x80350000, 0x00000001,
+	0x88080000, 0x00000001, 0x88f70000, 0x00000001,
+	0x88cc0000, 0x00000001, 0x88090000, 0x00000001,
+	0x89150000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x11006000, 0x00000001, 0x06006000, 0x00000001,
+	0x02006000, 0x00000001, 0x3a006000, 0x00000001,
+	0x2f006000, 0x00000001, 0x84006000, 0x00000001,
+	0x32006000, 0x00000001, 0x2c006000, 0x00000001,
+	0x3c006000, 0x00000001, 0x2b006000, 0x00000001,
+	0x00006000, 0x00000001, 0x00004000, 0x00000001,
+	0x00004000, 0x00000001, 0x20004000, 0x00000001,
+	0x40004000, 0x00000001, 0x00000000, 0x00000001,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x2c000000, 0x00000001,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x00000000, 0x00000000,
+	0x2c000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x06001072, 0x00000001, 0x06000000, 0x00000001,
+	0x110017c1, 0x00000001, 0x110012b7, 0x00000001,
+	0x110012b5, 0x00000001, 0x01000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x11000043, 0x00000001, 0x11000044, 0x00000001,
+	0x11000222, 0x00000001, 0x11000000, 0x00000001,
+	0x2f006558, 0x00000001, 0x32000000, 0x00000001,
+	0x84000000, 0x00000001, 0x00000000, 0x00000001,
+	0x65582000, 0x00000001, 0x65583000, 0x00000001,
+	0x6558a000, 0x00000001, 0x6558b000, 0x00000001,
+	0x65580000, 0x00000001, 0x12b50000, 0x00000001,
+	0x02000102, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x65580000, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x81008100, 0x00000001, 0x88a88100, 0x00000001,
+	0x810088a8, 0x00000001, 0x88a888a8, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08004000, 0x00000001, 0x86dd6000, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x08060000, 0x00000001, 0x80350000, 0x00000001,
+	0x88080000, 0x00000001, 0x88f70000, 0x00000001,
+	0x88cc0000, 0x00000001, 0x88090000, 0x00000001,
+	0x89150000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x11006000, 0x00000001, 0x06006000, 0x00000001,
+	0x02006000, 0x00000001, 0x3a006000, 0x00000001,
+	0x2f006000, 0x00000001, 0x84006000, 0x00000001,
+	0x32006000, 0x00000001, 0x2c006000, 0x00000001,
+	0x3c006000, 0x00000001, 0x2b006000, 0x00000001,
+	0x00006000, 0x00000001, 0x00004000, 0x00000001,
+	0x00004000, 0x00000001, 0x20004000, 0x00000001,
+	0x40004000, 0x00000001, 0x00000000, 0x00000001,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x2c000000, 0x00000001,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x00000000, 0x00000000,
+	0x2c000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x06001072, 0x00000001, 0x06000000, 0x00000001,
+	0x110012b7, 0x00000001, 0x01000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x32000000, 0x00000001, 0x84000000, 0x00000001,
+	0x11000043, 0x00000001, 0x11000044, 0x00000001,
+	0x11000222, 0x00000001, 0x11000000, 0x00000001,
+	0x2f006558, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec007_data[] = {
+	0x10001000, 0x00001000, 0x10000000, 0x00000000,
+	0x1000ffff, 0x0000ffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00000fff, 0x00000fff, 0x1000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x10ff0fff, 0xffff0fff, 0x00000fff,
+	0x1fff0fff, 0x1fff0fff, 0x1fff0fff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ff0000, 0x00ffffff, 0x00ff0000, 0x00ff0000,
+	0x00ff0000, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ff0000, 0x00ff0000, 0x00ff0001, 0x00ffffff,
+	0x00ff0000, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00000fff, 0x00000fff, 0x00000fff, 0x00000fff,
+	0x00000fff, 0x0000ffff, 0xc0ff0000, 0xc0ffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x0000ffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x10001000, 0x00001000, 0x10000000, 0x00000000,
+	0x1000ffff, 0x0000ffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00000fff, 0x00000fff, 0x1000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x10ff0fff, 0xffff0fff, 0x00000fff,
+	0x1fff0fff, 0x1fff0fff, 0x1fff0fff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ff0000, 0x00ffffff, 0x00ff0000, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ff0000, 0x00ff0000, 0x00ff0001, 0x00ffffff,
+	0x00ff0000, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+};
+
+static u32 nbl_sec008_data[] = {
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00800090, 0x12009092, 0x00000100, 0x00000000,
+	0x00800090, 0x12009092, 0x00000100, 0x00000000,
+	0x00800000, 0x0e008c8e, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08909581, 0x00008680, 0x00000200, 0x00000000,
+	0x10900082, 0x28008680, 0x00000200, 0x00000000,
+	0x809b0093, 0x00000000, 0x00000100, 0x00000000,
+	0x809b0093, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b0000, 0x00000000, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x009b0000, 0x00000000, 0x00000100, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000200, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000200, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000200, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000300, 0x00000000,
+	0x00000000, 0x00a089c2, 0x000005f0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x000002f0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x000002f0, 0x00000000,
+	0x00000000, 0x00a089c2, 0x000005f0, 0x00000000,
+	0x000b0000, 0x00000000, 0x00000200, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000400, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000400, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x0000050f, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x0000050f, 0x00000000,
+	0x02a00084, 0x08008890, 0x00000600, 0x00000000,
+	0x02ab848a, 0x08000000, 0x00000500, 0x00000000,
+	0x02a00084, 0x10008200, 0x00000600, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000500, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab0084, 0x08000000, 0x00000500, 0x00000000,
+	0x00a00000, 0x04008280, 0x00000600, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x04ab8e84, 0x0c000000, 0x00000500, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x00000000, 0x0400ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0800ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0800ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0c00ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0000ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0000ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x10008200, 0x00000700, 0x00000000,
+	0x00000000, 0x08008200, 0x00000700, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x0000ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0000ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00808786, 0x16009496, 0x00000900, 0x00000000,
+	0x00808786, 0x16009496, 0x00000900, 0x00000000,
+	0x00808786, 0x16009496, 0x00000900, 0x00000000,
+	0x00808786, 0x16009496, 0x00000900, 0x00000000,
+	0x00800086, 0x12009092, 0x00000900, 0x00000000,
+	0x00800086, 0x12009092, 0x00000900, 0x00000000,
+	0x00800000, 0x0e008c8e, 0x00000900, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08908192, 0x00008680, 0x00000a00, 0x00000000,
+	0x10908292, 0x28008680, 0x00000a00, 0x00000000,
+	0x809b9392, 0x00000000, 0x00000900, 0x00000000,
+	0x809b9392, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b0092, 0x00000000, 0x00000900, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x009b0092, 0x00000000, 0x00000900, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000a00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000a00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000a00, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000b00, 0x00000000,
+	0x00000000, 0x00a089c2, 0x00000df0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x00000af0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x00000af0, 0x00000000,
+	0x00000000, 0x00a089c2, 0x00000df0, 0x00000000,
+	0x000b0000, 0x00000000, 0x00000a00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000b00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000b00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000b00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000b00, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000c00, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000c00, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000c00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000c00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000c00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000c00, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x00000d0f, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x00000d0f, 0x00000000,
+	0x02ab8a84, 0x08000000, 0x00000d00, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000d00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000d00, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000d00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000d00, 0x00000000,
+	0x04ab8e84, 0x0c000000, 0x00000d00, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000d00, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000d00, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000d00, 0x00000000,
+	0x02ab0084, 0x08000000, 0x00000d00, 0x00000000,
+	0x00ab0000, 0x04000000, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec009_data[] = {
+	0x00000000, 0x00000060, 0x00000000, 0x00000090,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000050, 0x00000000, 0x000000a0,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000000a0, 0x00000000, 0x00000050,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000800, 0x00000000, 0x00000700,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000900, 0x00000000, 0x00000600,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00008000, 0x00000000, 0x00007000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00009000, 0x00000000, 0x00006000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x0000a000, 0x00000000, 0x00005000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000c0000, 0x00000000, 0x00030000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000d0000, 0x00000000, 0x00020000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000e0000, 0x00000000, 0x00010000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000040, 0x00000000, 0x000000b0,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000070, 0x00000000, 0x00000080,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000090, 0x00000000, 0x00000060,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000080, 0x00000000, 0x00000070,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000700, 0x00000000, 0x00000800,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00007000, 0x00000000, 0x00008000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00080000, 0x00000000, 0x00070000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000c00, 0x00000000, 0x00000300,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000d00, 0x00000000, 0x00000200,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00600000, 0x00000000, 0x00900000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00d00000, 0x00000000, 0x00200000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00500000, 0x00000000, 0x00a00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00700000, 0x00000000, 0x00800000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00e00000, 0x00000000, 0x00100000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00f00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00f00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00100000, 0x00000000, 0x00e00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00300000, 0x00000000, 0x00c00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00800000, 0x00000000, 0x00700000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00900000, 0x00000000, 0x00600000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00a00000, 0x00000000, 0x00500000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00b00000, 0x00000000, 0x00400000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000060, 0x00400000, 0x00000090, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000050, 0x00400000, 0x000000a0, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000000a0, 0x00400000, 0x00000050, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000800, 0x00400000, 0x00000700, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000900, 0x00400000, 0x00000600, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00008000, 0x00400000, 0x00007000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00009000, 0x00400000, 0x00006000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x0000a000, 0x00400000, 0x00005000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000c0000, 0x00400000, 0x00030000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000d0000, 0x00400000, 0x00020000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000e0000, 0x00400000, 0x00010000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000070, 0x00400000, 0x00000080, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000700, 0x00400000, 0x00000800, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00007000, 0x00400000, 0x00008000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00080000, 0x00400000, 0x00070000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000c00, 0x00400000, 0x00000300, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000d00, 0x00400000, 0x00000200, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x00400000, 0x000000b0, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000090, 0x00400000, 0x00000060, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000080, 0x00400000, 0x00000070, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000060, 0x06000000, 0x00000090, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000060, 0x07000000, 0x00000090, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000050, 0x06000000, 0x000000a0, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000050, 0x07000000, 0x000000a0, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000000a0, 0x06000000, 0x00000050, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000000a0, 0x07000000, 0x00000050, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000800, 0x06000000, 0x00000700, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000900, 0x06000000, 0x00000600, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00008000, 0x06000000, 0x00007000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00009000, 0x06000000, 0x00006000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x0000a000, 0x06000000, 0x00005000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000c0000, 0x06000000, 0x00030000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000d0000, 0x06000000, 0x00020000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000e0000, 0x06000000, 0x00010000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000800, 0x07000000, 0x00000700, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000900, 0x07000000, 0x00000600, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00008000, 0x07000000, 0x00007000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00009000, 0x07000000, 0x00006000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x0000a000, 0x07000000, 0x00005000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000c0000, 0x07000000, 0x00030000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000d0000, 0x07000000, 0x00020000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000e0000, 0x07000000, 0x00010000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000070, 0x06000000, 0x00000080, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000070, 0x07000000, 0x00000080, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000700, 0x06000000, 0x00000800, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00007000, 0x06000000, 0x00008000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00080000, 0x06000000, 0x00070000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000c00, 0x06000000, 0x00000300, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000d00, 0x06000000, 0x00000200, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000700, 0x07000000, 0x00000800, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00007000, 0x07000000, 0x00008000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00080000, 0x07000000, 0x00070000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000c00, 0x07000000, 0x00000300, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000d00, 0x07000000, 0x00000200, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x06000000, 0x000000b0, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x07000000, 0x000000b0, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000090, 0x06000000, 0x00000060, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000090, 0x07000000, 0x00000060, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000080, 0x06000000, 0x00000070, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000080, 0x07000000, 0x00000070, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000060, 0x00c00000, 0x00000090, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000050, 0x00c00000, 0x000000a0, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000000a0, 0x00c00000, 0x00000050, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000800, 0x00c00000, 0x00000700, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000900, 0x00c00000, 0x00000600, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00008000, 0x00c00000, 0x00007000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00009000, 0x00c00000, 0x00006000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x0000a000, 0x00c00000, 0x00005000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000c0000, 0x00c00000, 0x00030000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000d0000, 0x00c00000, 0x00020000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000e0000, 0x00c00000, 0x00010000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000070, 0x00c00000, 0x00000080, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000700, 0x00c00000, 0x00000800, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00007000, 0x00c00000, 0x00008000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00080000, 0x00c00000, 0x00070000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000c00, 0x00c00000, 0x00000300, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000d00, 0x00c00000, 0x00000200, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x00c00000, 0x000000b0, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000090, 0x00c00000, 0x00000060, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000080, 0x00c00000, 0x00000070, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00400000, 0x00400000, 0x00b00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00600000, 0x00400000, 0x00900000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00300000, 0x00400000, 0x00c00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x00400000, 0x00a00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00700000, 0x00400000, 0x00800000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x00400000, 0x00d00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00800000, 0x00400000, 0x00700000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00900000, 0x00400000, 0x00600000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00a00000, 0x00400000, 0x00500000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00b00000, 0x00400000, 0x00400000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00400000, 0x00f00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00400000, 0x00f00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00100000, 0x00400000, 0x00e00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00400000, 0x06000000, 0x00b00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00400000, 0x07000000, 0x00b00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00600000, 0x06000000, 0x00900000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00600000, 0x07000000, 0x00900000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00300000, 0x06000000, 0x00c00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00300000, 0x07000000, 0x00c00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x06000000, 0x00a00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x07000000, 0x00a00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00700000, 0x06000000, 0x00800000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00700000, 0x07000000, 0x00800000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x06000000, 0x00d00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x07000000, 0x00d00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00800000, 0x06000000, 0x00700000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00900000, 0x06000000, 0x00600000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00a00000, 0x06000000, 0x00500000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00b00000, 0x06000000, 0x00400000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00800000, 0x07000000, 0x00700000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00900000, 0x07000000, 0x00600000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00a00000, 0x07000000, 0x00500000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00b00000, 0x07000000, 0x00400000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x06000000, 0x00f00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x07000000, 0x00f00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x06000000, 0x00f00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00100000, 0x06000000, 0x00e00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x07000000, 0x00f00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00100000, 0x07000000, 0x00e00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00400000, 0x00c00000, 0x00b00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00600000, 0x00c00000, 0x00900000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00300000, 0x00c00000, 0x00c00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x00c00000, 0x00a00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00700000, 0x00c00000, 0x00800000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x00c00000, 0x00d00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00800000, 0x00c00000, 0x00700000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00900000, 0x00c00000, 0x00600000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00a00000, 0x00c00000, 0x00500000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00b00000, 0x00c00000, 0x00400000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00c00000, 0x00f00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00c00000, 0x00f00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00100000, 0x00c00000, 0x00e00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000f0000, 0x00400000, 0x00000000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00f00000, 0x00400000, 0x00000000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000f0000, 0x06000000, 0x00000000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00f00000, 0x06000000, 0x00000000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000f0000, 0x07000000, 0x00000000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00f00000, 0x07000000, 0x00000000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000f0000, 0x00c00000, 0x00000000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00f00000, 0x00c00000, 0x00000000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000f0000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00f00000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec010_data[] = {
+	0x0000000a, 0x0000000a, 0x0000000a, 0x0000000a,
+	0x0000000a, 0x0000000a, 0x0000000a, 0x0000000a,
+	0x0000000a, 0x0000000a, 0x0000000a, 0x00000000,
+	0x0000000b, 0x00000008, 0x00000009, 0x0000000f,
+	0x0000000f, 0x0000000f, 0x0000000f, 0x0000000f,
+	0x0000000c, 0x0000000d, 0x00000001, 0x00000001,
+	0x0000000e, 0x00000005, 0x00000002, 0x00000002,
+	0x00000004, 0x00000003, 0x00000003, 0x00000003,
+	0x00000003, 0x00000040, 0x00000040, 0x00000040,
+	0x00000040, 0x00000040, 0x00000040, 0x00000040,
+	0x00000040, 0x00000040, 0x00000040, 0x00000040,
+	0x00000045, 0x00000044, 0x00000044, 0x00000044,
+	0x00000044, 0x00000044, 0x00000041, 0x00000042,
+	0x00000043, 0x00000046, 0x00000046, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x0000004b,
+	0x0000004b, 0x0000004a, 0x0000004a, 0x0000004a,
+	0x0000004a, 0x0000004a, 0x0000004a, 0x0000004a,
+	0x0000004a, 0x0000004a, 0x0000004a, 0x00000047,
+	0x00000047, 0x00000048, 0x00000048, 0x00000049,
+	0x00000049, 0x0000004c, 0x0000004c, 0x0000004c,
+	0x0000004c, 0x0000004c, 0x0000004c, 0x0000004c,
+	0x0000004c, 0x0000004c, 0x0000004c, 0x0000004c,
+	0x00000051, 0x00000050, 0x00000050, 0x00000050,
+	0x00000050, 0x00000050, 0x0000004d, 0x0000004e,
+	0x0000004f, 0x00000052, 0x00000053, 0x00000054,
+	0x00000054, 0x00000055, 0x00000056, 0x00000057,
+	0x00000057, 0x00000057, 0x00000057, 0x00000058,
+	0x00000059, 0x00000059, 0x0000005a, 0x0000005a,
+	0x0000005b, 0x0000005b, 0x0000005c, 0x0000005c,
+	0x0000005c, 0x0000005c, 0x0000005d, 0x0000005d,
+	0x0000005e, 0x0000005e, 0x0000005f, 0x0000005f,
+	0x0000005f, 0x0000005f, 0x0000005f, 0x0000005f,
+	0x0000005f, 0x0000005f, 0x00000060, 0x00000060,
+	0x00000061, 0x00000061, 0x00000061, 0x00000061,
+	0x00000062, 0x00000063, 0x00000064, 0x00000064,
+	0x00000065, 0x00000066, 0x00000067, 0x00000067,
+	0x00000067, 0x00000067, 0x00000068, 0x00000069,
+	0x00000069, 0x00000040, 0x00000040, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x0000004c,
+	0x0000004c, 0x0000000a, 0x0000000a, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec011_data[] = {
+	0x0008002c, 0x00080234, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080230,
+	0x00080332, 0x0008063c, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0008002c, 0x00080234, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080230,
+	0x00080332, 0x00080738, 0x0008083c, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0008002c, 0x00080234, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080230,
+	0x00080332, 0x00080738, 0x0008093a, 0x00080a3c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080634, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080834, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080932, 0x00080a34,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00090200, 0x00090304, 0x00090408, 0x0009050c,
+	0x00090610, 0x00090714, 0x00090818, 0x0009121c,
+	0x0009131e, 0x00000000, 0x00000000, 0x00000000,
+	0x00090644, 0x00000000, 0x000d8045, 0x000d4145,
+	0x0009030c, 0x0009041c, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00090145, 0x00090944, 0x00000000, 0x00000000,
+	0x0009061c, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x0009033a,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00090200, 0x00090304, 0x00090408, 0x0009050c,
+	0x00090610, 0x00090714, 0x00090818, 0x0009121c,
+	0x0009131e, 0x00000000, 0x00000000, 0x00000000,
+	0x0009063d, 0x00090740, 0x000d803f, 0x000d413f,
+	0x0009030c, 0x0009041c, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0009013f, 0x00090840, 0x000dc93d, 0x000d093d,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0324, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a003e,
+	0x000a0140, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0324, 0x000a0520, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a003e,
+	0x000a0140, 0x000a0842, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0124, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0224, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a003c, 0x000a0037, 0x000ec139, 0x000e0139,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x000a0742, 0x00000000, 0x00000000,
+	0x000a0d41, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0d3e, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0037, 0x000a0139, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080634, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080834, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080932, 0x00080a34,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0009061c, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x0009033a,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00090200, 0x00090304, 0x00090408, 0x0009050c,
+	0x00090610, 0x00090714, 0x00090818, 0x0009121c,
+	0x0009131e, 0x00000000, 0x00000000, 0x00000000,
+	0x0009063d, 0x00090740, 0x000d803f, 0x000d413f,
+	0x0009030c, 0x0009041c, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0009013f, 0x00090840, 0x000dc93d, 0x000d093d,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a003c, 0x000a0037, 0x000ec139, 0x000e0139,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x000a0742, 0x00000000, 0x00000000,
+	0x000a0d41, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0d3e, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0037, 0x000a0139, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec012_data[] = {
+	0x00000006, 0x00000001, 0x00000004, 0x00000001,
+	0x00000006, 0x00000001, 0x00000000, 0x00000001,
+	0x00000004, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000010, 0x00000001, 0x00000000, 0x00000001,
+	0x00000040, 0x00000001, 0x00000010, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x06200000, 0x00000001, 0x00c00000, 0x00000001,
+	0x02c00000, 0x00000001, 0x00200000, 0x00000001,
+	0x00400000, 0x00000001, 0x00700000, 0x00000001,
+	0x00300000, 0x00000001, 0x00000000, 0x00000001,
+	0x00a00000, 0x00000001, 0x00b00000, 0x00000001,
+	0x00e00000, 0x00000001, 0x00500000, 0x00000001,
+	0x00800000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000004, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x00000001, 0x00000010, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x00000001, 0x00700000, 0x00000001,
+	0x00a00000, 0x00000001, 0x00b00000, 0x00000001,
+	0x00200000, 0x00000001, 0x00000000, 0x00000001,
+	0x00300000, 0x00000001, 0x00800000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec013_data[] = {
+	0xf7fffff0, 0xf7fffff1, 0xfffffff0, 0xf7fffff3,
+	0xfffffff1, 0xfffffff3, 0xffffffff, 0xffffffff,
+	0xf7ffff0f, 0xf7ffff0f, 0xffffff0f, 0xffffff0f,
+	0xffffff0f, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x100fffff, 0xf10fffff, 0xf10fffff, 0xf70fffff,
+	0xf70fffff, 0xff0fffff, 0xff0fffff, 0xff1fffff,
+	0xff0fffff, 0xff0fffff, 0xff0fffff, 0xff0fffff,
+	0xff1fffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xfffffff1, 0xfffffff3, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffff0f, 0xffffff0f, 0xffffff0f, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xff0fffff, 0xff0fffff, 0xff0fffff, 0xff0fffff,
+	0xff0fffff, 0xff1fffff, 0xff0fffff, 0xff1fffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+};
+
+static u32 nbl_sec014_data[] = {
+	0x00000000, 0x00000001, 0x00000003, 0x00000002,
+	0x00000004, 0x00000005, 0x00000000, 0x00000000,
+	0x00000000, 0x00000001, 0x00000002, 0x00000003,
+	0x00000004, 0x00000000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000002, 0x00000003, 0x00000000,
+	0x00000000, 0x00000004, 0x00000005, 0x00000006,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000002, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000001, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000001, 0x00000001, 0x00000001,
+	0x00000002, 0x00000003, 0x00000004, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec022_data[] = {
+	0x81008100, 0x00000001, 0x88a88100, 0x00000001,
+	0x810088a8, 0x00000001, 0x88a888a8, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08004000, 0x00000001, 0x86dd6000, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x08060000, 0x00000001, 0x80350000, 0x00000001,
+	0x88080000, 0x00000001, 0x88f70000, 0x00000001,
+	0x88cc0000, 0x00000001, 0x88090000, 0x00000001,
+	0x89150000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x11006000, 0x00000001, 0x06006000, 0x00000001,
+	0x02006000, 0x00000001, 0x3a006000, 0x00000001,
+	0x2f006000, 0x00000001, 0x84006000, 0x00000001,
+	0x32006000, 0x00000001, 0x2c006000, 0x00000001,
+	0x3c006000, 0x00000001, 0x2b006000, 0x00000001,
+	0x00006000, 0x00000001, 0x00004000, 0x00000001,
+	0x00004000, 0x00000001, 0x20004000, 0x00000001,
+	0x40004000, 0x00000001, 0x00000000, 0x00000001,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x2c000000, 0x00000001,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x00000000, 0x00000000,
+	0x2c000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x06001072, 0x00000001, 0x06000000, 0x00000001,
+	0x110012b7, 0x00000001, 0x01000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x32000000, 0x00000001, 0x84000000, 0x00000001,
+	0x11000043, 0x00000001, 0x11000044, 0x00000001,
+	0x11000222, 0x00000001, 0x11000000, 0x00000001,
+	0x2f006558, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec023_data[] = {
+	0x10001000, 0x00001000, 0x10000000, 0x00000000,
+	0x1000ffff, 0x0000ffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00000fff, 0x00000fff, 0x1000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x10ff0fff, 0xffff0fff, 0x00000fff,
+	0x1fff0fff, 0x1fff0fff, 0x1fff0fff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ff0000, 0x00ffffff, 0x00ff0000, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ff0000, 0x00ff0000, 0x00ff0001, 0x00ffffff,
+	0x00ff0000, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+};
+
+static u32 nbl_sec024_data[] = {
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00800090, 0x12009092, 0x00000100, 0x00000000,
+	0x00800090, 0x12009092, 0x00000100, 0x00000000,
+	0x00800000, 0x0e008c8e, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08900081, 0x00008680, 0x00000200, 0x00000000,
+	0x10900082, 0x28008680, 0x00000200, 0x00000000,
+	0x809b0093, 0x00000000, 0x00000100, 0x00000000,
+	0x809b0093, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b0000, 0x00000000, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x009b0000, 0x00000000, 0x00000100, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000200, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000200, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000200, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000300, 0x00000000,
+	0x00000000, 0x00a089c2, 0x000005f0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x000002f0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x000002f0, 0x00000000,
+	0x00000000, 0x00a089c2, 0x000005f0, 0x00000000,
+	0x000b0000, 0x00000000, 0x00000200, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000400, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000400, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x0000050f, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x0000050f, 0x00000000,
+	0x02ab848a, 0x08000000, 0x00000500, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000500, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000500, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x04ab8e84, 0x0c000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab0084, 0x08000000, 0x00000500, 0x00000000,
+	0x00ab0000, 0x04000000, 0x00000500, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec025_data[] = {
+	0x00000060, 0x00000090, 0x00000001, 0x00000000,
+	0x00000050, 0x000000a0, 0x00000001, 0x00000000,
+	0x000000a0, 0x00000050, 0x00000001, 0x00000000,
+	0x00000800, 0x00000700, 0x00000001, 0x00000000,
+	0x00000900, 0x00000600, 0x00000001, 0x00000000,
+	0x00008000, 0x00007000, 0x00000001, 0x00000000,
+	0x00009000, 0x00006000, 0x00000001, 0x00000000,
+	0x0000a000, 0x00005000, 0x00000001, 0x00000000,
+	0x000c0000, 0x00030000, 0x00000001, 0x00000000,
+	0x000d0000, 0x00020000, 0x00000001, 0x00000000,
+	0x000e0000, 0x00010000, 0x00000001, 0x00000000,
+	0x00000040, 0x000000b0, 0x00000001, 0x00000000,
+	0x00000070, 0x00000080, 0x00000001, 0x00000000,
+	0x00000090, 0x00000060, 0x00000001, 0x00000000,
+	0x00000080, 0x00000070, 0x00000001, 0x00000000,
+	0x00000700, 0x00000800, 0x00000001, 0x00000000,
+	0x00007000, 0x00008000, 0x00000001, 0x00000000,
+	0x00080000, 0x00070000, 0x00000001, 0x00000000,
+	0x00000c00, 0x00000300, 0x00000001, 0x00000000,
+	0x00000d00, 0x00000200, 0x00000001, 0x00000000,
+	0x00400000, 0x00b00000, 0x00000001, 0x00000000,
+	0x00600000, 0x00900000, 0x00000001, 0x00000000,
+	0x00300000, 0x00c00000, 0x00000001, 0x00000000,
+	0x00500000, 0x00a00000, 0x00000001, 0x00000000,
+	0x00700000, 0x00800000, 0x00000001, 0x00000000,
+	0x00000000, 0x00f00000, 0x00000001, 0x00000000,
+	0x00000000, 0x00f00000, 0x00000001, 0x00000000,
+	0x00100000, 0x00e00000, 0x00000001, 0x00000000,
+	0x00200000, 0x00d00000, 0x00000001, 0x00000000,
+	0x00800000, 0x00700000, 0x00000001, 0x00000000,
+	0x00900000, 0x00600000, 0x00000001, 0x00000000,
+	0x00a00000, 0x00500000, 0x00000001, 0x00000000,
+	0x00b00000, 0x00400000, 0x00000001, 0x00000000,
+	0x000f0000, 0x00000000, 0x00000001, 0x00000000,
+	0x00f00000, 0x00000000, 0x00000001, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec026_data[] = {
+	0x0000000a, 0x0000000a, 0x0000000a, 0x0000000a,
+	0x0000000a, 0x0000000a, 0x0000000a, 0x0000000a,
+	0x0000000a, 0x0000000a, 0x0000000a, 0x00000000,
+	0x0000000b, 0x00000008, 0x00000009, 0x0000000f,
+	0x0000000f, 0x0000000f, 0x0000000f, 0x0000000f,
+	0x0000000c, 0x0000000d, 0x00000001, 0x00000001,
+	0x0000000e, 0x00000005, 0x00000002, 0x00000002,
+	0x00000004, 0x00000003, 0x00000003, 0x00000003,
+	0x00000003, 0x0000000a, 0x0000000a, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec027_data[] = {
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080634, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080834, 0x0008082e,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080932, 0x00080a34,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0009061c, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x0009033a,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00090200, 0x00090304, 0x00090408, 0x0009050c,
+	0x00090610, 0x00090714, 0x00090818, 0x0009121c,
+	0x0009131e, 0x00000000, 0x00000000, 0x00000000,
+	0x0009063d, 0x00090740, 0x000d803f, 0x000d413f,
+	0x0009030c, 0x0009041c, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0009013f, 0x00090840, 0x000dc93d, 0x000d093d,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a003c, 0x000a0037, 0x000ec139, 0x000e0139,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x000a0742, 0x00000000, 0x00000000,
+	0x000a0d41, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0d3e, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0037, 0x000a0139, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec028_data[] = {
+	0x00000006, 0x00000001, 0x00000004, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x00000001, 0x00000010, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x00000001, 0x00700000, 0x00000001,
+	0x00a00000, 0x00000001, 0x00b00000, 0x00000001,
+	0x00200000, 0x00000001, 0x00000000, 0x00000001,
+	0x00300000, 0x00000001, 0x00800000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec029_data[] = {
+	0xfffffff0, 0xfffffff1, 0xfffffff3, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffff0f, 0xffffff0f, 0xffffff0f, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xff0fffff, 0xff0fffff, 0xff0fffff, 0xff0fffff,
+	0xff0fffff, 0xff1fffff, 0xff0fffff, 0xff1fffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+};
+
+static u32 nbl_sec030_data[] = {
+	0x00000000, 0x00000001, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000001, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000001, 0x00000001, 0x00000001,
+	0x00000002, 0x00000003, 0x00000004, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec039_data[] = {
+	0xfef80000, 0x00000002, 0x000002e0, 0x00000000,
+	0xfef8013e, 0x00000002, 0x000002e0, 0x00000000,
+	0x6660013e, 0x726e6802, 0x02224e42, 0x00000000,
+	0x6660013e, 0x726e6802, 0x02224e42, 0x00000000,
+	0x66600000, 0x726e6802, 0x02224e42, 0x00000000,
+	0x66600000, 0x726e6802, 0x02224e42, 0x00000000,
+	0x66600000, 0x00026802, 0x02224e40, 0x00000000,
+	0x66627800, 0x00026802, 0x02224e40, 0x00000000,
+	0x66600000, 0x00026a76, 0x02224e40, 0x00000000,
+	0x66600000, 0x00026802, 0x00024e40, 0x00000000,
+	0x66600000, 0x00026802, 0x00024e40, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec040_data[] = {
+	0x0040fb3f, 0x00000001, 0x0440fb3f, 0x00000001,
+	0x0502fa00, 0x00000001, 0x0602f900, 0x00000001,
+	0x0903e600, 0x00000001, 0x0a03e500, 0x00000001,
+	0x1101e600, 0x00000001, 0x1201e500, 0x00000001,
+	0x0000ff00, 0x00000001, 0x0008ff07, 0x00000001,
+	0x00ffff00, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec046_4p_data[] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00077c2b, 0x005c0000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x70000000, 0x00000020, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00002100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x38430000,
+	0x70000006, 0x00000020, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x98cb1180, 0x6e36d469,
+	0x9d8eb91c, 0x87e3ef47, 0xa2931288, 0x08405c5a,
+	0x73865086, 0x00000080, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x000b3849, 0x38430000,
+	0x00000006, 0x0000c100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x08400000,
+	0x03865086, 0x4c016100, 0x00000014, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec047_data[] = {
+	0x2040dc3f, 0x00000001, 0x2000dcff, 0x00000001,
+	0x2200dcff, 0x00000001, 0x0008dc01, 0x00000001,
+	0x0001de00, 0x00000001, 0x2900c4ff, 0x00000001,
+	0x3100c4ff, 0x00000001, 0x2b00c4ff, 0x00000001,
+	0x3300c4ff, 0x00000001, 0x2700d8ff, 0x00000001,
+	0x2300d8ff, 0x00000001, 0x2502d800, 0x00000001,
+	0x2102d800, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec052_data[] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x30000000, 0x000b844c, 0xc8580000,
+	0x00000006, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0xb0d3668b, 0xb0555e12,
+	0x03b055c6, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0xa64b3449, 0x405a3cc1,
+	0x00000006, 0x3d2d3300, 0x00000010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x26473429, 0x00482cc1,
+	0x00000000, 0x00ccd300, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec053_data[] = {
+	0x0840f03f, 0x00000001, 0x0040f03f, 0x00000001,
+	0x0140fa3f, 0x00000001, 0x0100fa0f, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec058_data[] = {
+	0x00000000, 0x00000000, 0x59f89400, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00470000,
+	0x00000000, 0x3c000000, 0xa2e40006, 0x00000017,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x19fa1400, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x28440000,
+	0x038e5186, 0x3c000000, 0xa8e40012, 0x00000047,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x0001f3d0, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x38c30000,
+	0x0000000a, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x0001f3d0, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x38c30000,
+	0x0000000a, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x000113d0, 0x00000000,
+	0x00000000, 0xb0000000, 0x00073829, 0x00430000,
+	0x00000000, 0x3c000000, 0x0000000a, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x000293d0, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x08400000,
+	0x03865086, 0x3c000000, 0x00000016, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec059_data[] = {
+	0x0200e4ff, 0x00000001, 0x0400e2ff, 0x00000001,
+	0x1300ecff, 0x00000001, 0x1500eaff, 0x00000001,
+	0x0300e4ff, 0x00000001, 0x0500e2ff, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec062_data[] = {
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec063_data[] = {
+	0x0500e2ff, 0x00000001, 0x0900e2ff, 0x00000001,
+	0x1900e2ff, 0x00000001, 0x1100e2ff, 0x00000001,
+	0x0100e2ff, 0x00000001, 0x0600e1ff, 0x00000001,
+	0x0a00e1ff, 0x00000001, 0x1a00e1ff, 0x00000001,
+	0x1200e1ff, 0x00000001, 0x0200e1ff, 0x00000001,
+	0x0000fcff, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec065_data[] = {
+	0x006e120c, 0x006e1210, 0x006e4208, 0x006e4218,
+	0x00200b02, 0x00200b00, 0x000e1900, 0x000e1906,
+	0x00580208, 0x00580204, 0x004c0208, 0x004c0207,
+	0x0002110c, 0x0002110c, 0x0012010c, 0x00100110,
+	0x0010010c, 0x000a010c, 0x0008010c, 0x00060000,
+	0x00160000, 0x00140000, 0x001e0000, 0x001e0000,
+	0x001e0000, 0x001e0000, 0x001e0000, 0x001e0000,
+	0x001e0000, 0x001e0000, 0x001e0000, 0x001e0000,
+};
+
+static u32 nbl_sec066_data[] = {
+	0x006e120c, 0x006e1210, 0x006e4208, 0x006e4218,
+	0x00200b02, 0x00200b00, 0x000e1900, 0x000e1906,
+	0x00580208, 0x00580204, 0x004c0208, 0x004c0207,
+	0x0002110c, 0x0002110c, 0x0012010c, 0x00100110,
+	0x0010010c, 0x000a010c, 0x0008010c, 0x00060000,
+	0x00160000, 0x00140000, 0x001e0000, 0x001e0000,
+	0x001e0000, 0x001e0000, 0x001e0000, 0x001e0000,
+	0x001e0000, 0x001e0000, 0x001e0000, 0x001e0000,
+};
+
+static u32 nbl_sec071_4p_data[] = {
+	0x00000000, 0x00000000, 0x00113d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7029b00, 0x00000000,
+	0x00000000, 0x43000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x51e00000, 0x00000c9c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00293d00, 0x00000000,
+	0x00000000, 0x00000000, 0x67089b00, 0x00000002,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x80000000, 0x00000000, 0xb1e00000, 0x0000189c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x014b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x015b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d29a00, 0x000149c4,
+	0x00000000, 0x4b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d2c000, 0x000149c4,
+	0x00000000, 0x5b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x64d49200, 0x5e556945,
+	0xc666d89a, 0x4b0001a9, 0x00004c84, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x6ed4ba00, 0x5ef56bc5,
+	0xc666d8c0, 0x5b0001a9, 0x00004dc4, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00700000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec072_data[] = {
+	0x84006aff, 0x00000001, 0x880066ff, 0x00000001,
+	0x140040ff, 0x00000001, 0x70000cff, 0x00000001,
+	0x180040ff, 0x00000001, 0x30000cff, 0x00000001,
+	0x10004cff, 0x00000001, 0x30004cff, 0x00000001,
+	0x0100ecff, 0x00000001, 0x0300ecff, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec116_data[] = {
+	0x00000000, 0x00000000, 0x3fff8000, 0x00000007,
+	0x3fff8000, 0x00000007, 0x3fff8000, 0x00000007,
+	0x3fff8000, 0x00000003, 0x3fff8000, 0x00000003,
+	0x3fff8000, 0x00000007, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec124_data[] = {
+	0xfffffffc, 0xffffffff, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000500, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x00300010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000500, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x00300010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000500, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x00300fff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x00301fff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x0030ffff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x0030ffff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x0030ffff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x0030ffff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000500, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0000fffe, 0x00000000, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000480, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0x00ffffff, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000480, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffe, 0x0000000f, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec125_data[] = {
+	0xfffffffc, 0x01ffffff, 0x00300000, 0x70000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000480, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffe, 0x00000001, 0x00300000, 0x70000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000540, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffe, 0x011003ff, 0x00300000, 0x70000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000005c0, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0x103fffff, 0x00300001, 0x70000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000480, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec126_data[] = {
+	0xfffffffc, 0xffffffff, 0x00300001, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000500, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffe, 0x000001ff, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000005c0, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00002013, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000400, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00002013, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000400, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0x01ffffff, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000480, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffe, 0x00000001, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000540, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec137_data[] = {
+	0x0000017a, 0x000000f2, 0x00000076, 0x0000017a,
+	0x0000017a, 0x00000080, 0x00000024, 0x0000017a,
+	0x0000017a, 0x00000191, 0x00000035, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+	0x0000017a, 0x000000d2, 0x00000066, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+	0x0000017a, 0x000000f2, 0x00000076, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+};
+
+static u32 nbl_sec138_data[] = {
+	0x0000017a, 0x000000f2, 0x00000076, 0x0000017a,
+	0x0000017a, 0x00000080, 0x00000024, 0x0000017a,
+	0x0000017a, 0x00000191, 0x00000035, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+	0x0000017a, 0x000000d2, 0x00000066, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+	0x0000017a, 0x000000f2, 0x00000076, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+};
+
+void nbl_write_all_regs(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	u32 *nbl_sec046_data;
+	u32 *nbl_sec071_data;
+	u8 eth_mode = NBL_COMMON_TO_ETH_MODE(common);
+	u32 i = 0;
+
+	switch (eth_mode) {
+	case 1:
+		nbl_sec046_data = nbl_sec046_1p_data;
+		nbl_sec071_data = nbl_sec071_1p_data;
+		break;
+	case 2:
+		nbl_sec046_data = nbl_sec046_2p_data;
+		nbl_sec071_data = nbl_sec071_2p_data;
+		break;
+	case 4:
+		nbl_sec046_data = nbl_sec046_4p_data;
+		nbl_sec071_data = nbl_sec071_4p_data;
+		break;
+	default:
+		nbl_sec046_data = nbl_sec046_2p_data;
+		nbl_sec071_data = nbl_sec071_2p_data;
+	}
+
+	for (i = 0; i < NBL_SEC006_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC006_REGI(i), nbl_sec006_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC007_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC007_REGI(i), nbl_sec007_data[i]);
+
+	for (i = 0; i < NBL_SEC008_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC008_REGI(i), nbl_sec008_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC009_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC009_REGI(i), nbl_sec009_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC010_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC010_REGI(i), nbl_sec010_data[i]);
+
+	for (i = 0; i < NBL_SEC011_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC011_REGI(i), nbl_sec011_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC012_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC012_REGI(i), nbl_sec012_data[i]);
+
+	for (i = 0; i < NBL_SEC013_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC013_REGI(i), nbl_sec013_data[i]);
+
+	for (i = 0; i < NBL_SEC014_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC014_REGI(i), nbl_sec014_data[i]);
+
+	for (i = 0; i < NBL_SEC022_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC022_REGI(i), nbl_sec022_data[i]);
+
+	for (i = 0; i < NBL_SEC023_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC023_REGI(i), nbl_sec023_data[i]);
+
+	for (i = 0; i < NBL_SEC024_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC024_REGI(i), nbl_sec024_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC025_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC025_REGI(i), nbl_sec025_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC026_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC026_REGI(i), nbl_sec026_data[i]);
+
+	for (i = 0; i < NBL_SEC027_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC027_REGI(i), nbl_sec027_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC028_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC028_REGI(i), nbl_sec028_data[i]);
+
+	for (i = 0; i < NBL_SEC029_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC029_REGI(i), nbl_sec029_data[i]);
+
+	for (i = 0; i < NBL_SEC030_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC030_REGI(i), nbl_sec030_data[i]);
+
+	for (i = 0; i < NBL_SEC039_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC039_REGI(i), nbl_sec039_data[i]);
+
+	for (i = 0; i < NBL_SEC040_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC040_REGI(i), nbl_sec040_data[i]);
+
+	for (i = 0; i < NBL_SEC046_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC046_REGI(i), nbl_sec046_data[i]);
+
+	for (i = 0; i < NBL_SEC047_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC047_REGI(i), nbl_sec047_data[i]);
+
+	for (i = 0; i < NBL_SEC052_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC052_REGI(i), nbl_sec052_data[i]);
+
+	for (i = 0; i < NBL_SEC053_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC053_REGI(i), nbl_sec053_data[i]);
+
+	for (i = 0; i < NBL_SEC058_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC058_REGI(i), nbl_sec058_data[i]);
+
+	for (i = 0; i < NBL_SEC059_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC059_REGI(i), nbl_sec059_data[i]);
+
+	for (i = 0; i < NBL_SEC062_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC062_REGI(i), nbl_sec062_data[i]);
+
+	for (i = 0; i < NBL_SEC063_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC063_REGI(i), nbl_sec063_data[i]);
+
+	for (i = 0; i < NBL_SEC065_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC065_REGI(i), nbl_sec065_data[i]);
+
+	for (i = 0; i < NBL_SEC066_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC066_REGI(i), nbl_sec066_data[i]);
+
+	for (i = 0; i < NBL_SEC071_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC071_REGI(i), nbl_sec071_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC072_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC072_REGI(i), nbl_sec072_data[i]);
+
+	for (i = 0; i < NBL_SEC116_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC116_REGI(i), nbl_sec116_data[i]);
+
+	for (i = 0; i < NBL_SEC124_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC124_REGI(i), nbl_sec124_data[i]);
+
+	for (i = 0; i < NBL_SEC125_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC125_REGI(i), nbl_sec125_data[i]);
+
+	for (i = 0; i < NBL_SEC126_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC126_REGI(i), nbl_sec126_data[i]);
+
+	for (i = 0; i < NBL_SEC137_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC137_REGI(i), nbl_sec137_data[i]);
+
+	for (i = 0; i < NBL_SEC138_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC138_REGI(i), nbl_sec138_data[i]);
+
+	nbl_hw_wr32(hw_mgt, NBL_SEC000_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC001_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC002_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC003_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC004_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC005_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC015_ADDR, 0x000f0908);
+	nbl_hw_wr32(hw_mgt, NBL_SEC016_ADDR, 0x10110607);
+	nbl_hw_wr32(hw_mgt, NBL_SEC017_ADDR, 0x383a3032);
+	nbl_hw_wr32(hw_mgt, NBL_SEC018_ADDR, 0x0201453f);
+	nbl_hw_wr32(hw_mgt, NBL_SEC019_ADDR, 0x00000a41);
+	nbl_hw_wr32(hw_mgt, NBL_SEC020_ADDR, 0x000000c8);
+	nbl_hw_wr32(hw_mgt, NBL_SEC021_ADDR, 0x00000400);
+	nbl_hw_wr32(hw_mgt, NBL_SEC031_ADDR, 0x000f0908);
+	nbl_hw_wr32(hw_mgt, NBL_SEC032_ADDR, 0x00001011);
+	nbl_hw_wr32(hw_mgt, NBL_SEC033_ADDR, 0x00003032);
+	nbl_hw_wr32(hw_mgt, NBL_SEC034_ADDR, 0x0201003f);
+	nbl_hw_wr32(hw_mgt, NBL_SEC035_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC036_ADDR, 0x00001701);
+	nbl_hw_wr32(hw_mgt, NBL_SEC037_ADDR, 0x009238a1);
+	nbl_hw_wr32(hw_mgt, NBL_SEC038_ADDR, 0x0000002e);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(0), 0x00000200);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(1), 0x00000300);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(2), 0x00000105);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(3), 0x00000106);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(4), 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(5), 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(6), 0x00000041);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(7), 0x00000082);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(8), 0x00000020);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(9), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(10), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(11), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(12), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(13), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(14), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(15), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC042_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC043_ADDR, 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC044_ADDR, 0x28212000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC045_ADDR, 0x00002b29);
+	nbl_hw_wr32(hw_mgt, NBL_SEC048_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC049_ADDR, 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC050_ADDR, 0x352b2000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC051_ADDR, 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC054_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC055_ADDR, 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC056_ADDR, 0x2b222100);
+	nbl_hw_wr32(hw_mgt, NBL_SEC057_ADDR, 0x00000038);
+	nbl_hw_wr32(hw_mgt, NBL_SEC060_ADDR, 0x24232221);
+	nbl_hw_wr32(hw_mgt, NBL_SEC061_ADDR, 0x0000002e);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(0), 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(1), 0x00000005);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(2), 0x00000011);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(3), 0x00000005);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(4), 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(5), 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(6), 0x00000006);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(7), 0x00000012);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(8), 0x00000006);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(9), 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(10), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(11), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(12), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(13), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(14), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(15), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC067_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC068_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC069_ADDR, 0x22212000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC070_ADDR, 0x3835322b);
+	nbl_hw_wr32(hw_mgt, NBL_SEC073_ADDR, 0x0316a5ff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC074_ADDR, 0x0316a5ff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC075_REGI(0), 0x08802080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC075_REGI(1), 0x12a05080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC075_REGI(2), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC075_REGI(3), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC076_REGI(0), 0x08802080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC076_REGI(1), 0x12a05080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC076_REGI(2), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC076_REGI(3), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC077_REGI(0), 0x08802080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC077_REGI(1), 0x12a05080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC077_REGI(2), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC077_REGI(3), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC078_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC079_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC080_ADDR, 0x0014a248);
+	nbl_hw_wr32(hw_mgt, NBL_SEC081_ADDR, 0x00000d33);
+	nbl_hw_wr32(hw_mgt, NBL_SEC082_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC083_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC084_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC085_ADDR, 0x000144d2);
+	nbl_hw_wr32(hw_mgt, NBL_SEC086_ADDR, 0x31322e2f);
+	nbl_hw_wr32(hw_mgt, NBL_SEC087_ADDR, 0x0a092d2c);
+	nbl_hw_wr32(hw_mgt, NBL_SEC088_ADDR, 0x33050804);
+	nbl_hw_wr32(hw_mgt, NBL_SEC089_ADDR, 0x14131535);
+	nbl_hw_wr32(hw_mgt, NBL_SEC090_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC091_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC092_ADDR, 0x00000008);
+	nbl_hw_wr32(hw_mgt, NBL_SEC093_ADDR, 0x0000000e);
+	nbl_hw_wr32(hw_mgt, NBL_SEC094_ADDR, 0x0000000f);
+	nbl_hw_wr32(hw_mgt, NBL_SEC095_ADDR, 0x00000015);
+	nbl_hw_wr32(hw_mgt, NBL_SEC096_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC097_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC098_ADDR, 0x00000008);
+	nbl_hw_wr32(hw_mgt, NBL_SEC099_ADDR, 0x00000011);
+	nbl_hw_wr32(hw_mgt, NBL_SEC100_ADDR, 0x00000013);
+	nbl_hw_wr32(hw_mgt, NBL_SEC101_ADDR, 0x00000014);
+	nbl_hw_wr32(hw_mgt, NBL_SEC102_ADDR, 0x00000010);
+	nbl_hw_wr32(hw_mgt, NBL_SEC103_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC104_ADDR, 0x0000004d);
+	nbl_hw_wr32(hw_mgt, NBL_SEC105_ADDR, 0x08020a09);
+	nbl_hw_wr32(hw_mgt, NBL_SEC106_ADDR, 0x00000005);
+	nbl_hw_wr32(hw_mgt, NBL_SEC107_ADDR, 0x00000006);
+	nbl_hw_wr32(hw_mgt, NBL_SEC108_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC109_ADDR, 0x00110a09);
+	nbl_hw_wr32(hw_mgt, NBL_SEC110_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC111_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC112_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC113_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC114_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC115_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC117_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC118_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC119_REGI(0), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC119_REGI(1), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC119_REGI(2), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC119_REGI(3), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC119_REGI(4), 0x00000100);
+	nbl_hw_wr32(hw_mgt, NBL_SEC120_ADDR, 0x0000003c);
+	nbl_hw_wr32(hw_mgt, NBL_SEC121_ADDR, 0x00000003);
+	nbl_hw_wr32(hw_mgt, NBL_SEC122_ADDR, 0x000000bc);
+	nbl_hw_wr32(hw_mgt, NBL_SEC123_ADDR, 0x0000023b);
+	nbl_hw_wr32(hw_mgt, NBL_SEC127_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC128_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC129_ADDR, 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC130_ADDR, 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC131_ADDR, 0x00000003);
+	nbl_hw_wr32(hw_mgt, NBL_SEC132_ADDR, 0x00000003);
+	nbl_hw_wr32(hw_mgt, NBL_SEC133_ADDR, 0x00000004);
+	nbl_hw_wr32(hw_mgt, NBL_SEC134_ADDR, 0x00000004);
+	nbl_hw_wr32(hw_mgt, NBL_SEC135_ADDR, 0x0000000e);
+	nbl_hw_wr32(hw_mgt, NBL_SEC136_ADDR, 0x0000000e);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
new file mode 100644
index 000000000000..187f7557cc9e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_HW_LEONIS_REGS_H_
+#define _NBL_HW_LEONIS_REGS_H_
+
+void nbl_write_all_regs(void *priv);
+
+#endif
-- 
2.47.3


