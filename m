Return-Path: <netdev+bounces-172852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585FCA564B4
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFB3B174A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D120CCCD;
	Fri,  7 Mar 2025 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="Y3ihVJg+"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-34.ptr.blmpb.com (va-2-34.ptr.blmpb.com [209.127.231.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93520C481
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342263; cv=none; b=Na7P4WETKsEG73lWWLQpjcaVOAIe5q3kj3EPZ6f3ZWcf+FAXYCAmNWy8PpBazLEsOF+1+Dvqt+3c3SZoXdj3xNBmkYtnyxWoQYYzd7qM50SrBRLG+Pw0uev8fW99AUThOGSkgwWYcCq6XsHG07YScSvr8Id9z8nDRJQrlGzojRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342263; c=relaxed/simple;
	bh=5OiJzoMFAF3+pKZnfuDD9BaEv/IJSIBodOwqcR5XAk4=;
	h=From:In-Reply-To:References:To:Message-Id:Date:Mime-Version:Cc:
	 Subject:Content-Type; b=uZZut6GDp/Wf8hq0WTD1/OVHV1De7UmTysPNAztJWhWX3dIbdRADbvqvV1U/pIMtSo4cm1ymrtQEYqLp54Qm9UdGsalL1AR5pnaggO5UJjV9W9YYAia3pbAxzBGNb61ZVgQy+CBUoJYLxTUlp7s8ojoJ4afLOf4DUe4vsMGakAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=Y3ihVJg+; arc=none smtp.client-ip=209.127.231.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741342114; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=on/1JbSF5ieq6n881YJlKePeUsZtGcNqD331WtUqdVM=;
 b=Y3ihVJg+NtY5VqvYhkZJ0HNDbuRu0NvnAi7ynM0geL+E3EdfK50KvIw0qZbi+kPCSsPWri
 ozh/4wrh7xB1xqV4X9ENcPFcZhBEmAhx78iI+viDR5sm3Ni0C3Anf525lCBBRN13FAutph
 r/9ZtmRa+ScQS3qegv0FqnVwGbTHbwdYjnbvA/X2b7AMzNoanaOuIX8K2ar3LizPeqHN2f
 kpe5bWbJ4mkR6JChQ0IskOOy4jQo2tXqyDZ67rjkjhhIVJuoPEdLX3xfksQYSh1MhUDKeX
 OsrAQ8soVmi8pvXN9x32K2ZbHOBEjSuS9H7qJqxyS4BcgfSQIJVs6UT0l+2mVQ==
From: "Xin Tian" <tianx@yunsilicon.com>
In-Reply-To: <20250307100824.555320-1-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267cac5a0+6b8313+vger.kernel.org+tianx@yunsilicon.com>
References: <20250307100824.555320-1-tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
Message-Id: <20250307100830.555320-4-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 07 Mar 2025 18:08:31 +0800
Date: Fri, 07 Mar 2025 18:08:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
Subject: [PATCH net-next v8 03/14] xsc: Add hardware setup APIs
X-Mailer: git-send-email 2.25.1
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After CMDQ is initialized, the driver can retrieve hardware
information from the firmware. This patch provides APIs to
obtain the Hardware Component Adapter (HCA) capabilities,
the Globally Unique Identifier (GUID) of the board, activate
the hardware configuration, and reset function-specific
resources.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h | 158 ++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   2 +-
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  | 282 ++++++++++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h  |  18 ++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  27 ++
 5 files changed, 486 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index c6077b8b3..270e3d30a 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -29,6 +29,145 @@
 
 #define XSC_REG_ADDR(dev, offset)	(((dev)->bar) + ((offset) - 0xA0000000))
 
+enum {
+	XSC_MAX_PORTS	= 2,
+};
+
+enum {
+	XSC_MAX_FW_PORTS	= 1,
+};
+
+enum {
+	XSC_BF_REGS_PER_PAGE	= 4,
+	XSC_MAX_UAR_PAGES	= 1 << 8,
+	XSC_MAX_UUARS		= XSC_MAX_UAR_PAGES * XSC_BF_REGS_PER_PAGE,
+};
+
+/* hw */
+struct xsc_reg_addr {
+	u64	tx_db;
+	u64	rx_db;
+	u64	complete_db;
+	u64	complete_reg;
+	u64	event_db;
+	u64	cpm_get_lock;
+	u64	cpm_put_lock;
+	u64	cpm_lock_avail;
+	u64	cpm_data_mem;
+	u64	cpm_cmd;
+	u64	cpm_addr;
+	u64	cpm_busy;
+};
+
+struct xsc_board_info {
+	u32			board_id;
+	char			board_sn[XSC_BOARD_SN_LEN];
+	__be64			guid;
+	u8			guid_valid;
+	u8			hw_config_activated;
+};
+
+struct xsc_port_caps {
+	int		gid_table_len;
+	int		pkey_table_len;
+};
+
+struct xsc_caps {
+	u8		log_max_eq;
+	u8		log_max_cq;
+	u8		log_max_qp;
+	u8		log_max_mkey;
+	u8		log_max_pd;
+	u8		log_max_srq;
+	u8		log_max_msix;
+	u32		max_cqes;
+	u32		max_wqes;
+	u32		max_sq_desc_sz;
+	u32		max_rq_desc_sz;
+	u64		flags;
+	u16		stat_rate_support;
+	u32		log_max_msg;
+	u32		num_ports;
+	u32		max_ra_res_qp;
+	u32		max_ra_req_qp;
+	u32		max_srq_wqes;
+	u32		bf_reg_size;
+	u32		bf_regs_per_page;
+	struct xsc_port_caps	port[XSC_MAX_PORTS];
+	u8		ext_port_cap[XSC_MAX_PORTS];
+	u32		reserved_lkey;
+	u8		local_ca_ack_delay;
+	u8		log_max_mcg;
+	u16		max_qp_mcg;
+	u32		min_page_sz;
+	u32		send_ds_num;
+	u32		send_wqe_shift;
+	u32		recv_ds_num;
+	u32		recv_wqe_shift;
+	u32		rx_pkt_len_max;
+
+	u32		msix_enable:1;
+	u32		port_type:1;
+	u32		embedded_cpu:1;
+	u32		eswitch_manager:1;
+	u32		ecpf_vport_exists:1;
+	u32		vport_group_manager:1;
+	u32		sf:1;
+	u32		wqe_inline_mode:3;
+	u32		raweth_qp_id_base:15;
+	u32		rsvd0:7;
+
+	u16		max_vfs;
+	u8		log_max_qp_depth;
+	u8		log_max_current_uc_list;
+	u8		log_max_current_mc_list;
+	u16		log_max_vlan_list;
+	u8		fdb_multi_path_to_table;
+	u8		log_esw_max_sched_depth;
+
+	u8		max_num_sf_partitions;
+	u8		log_max_esw_sf;
+	u16		sf_base_id;
+
+	u32		max_tc:8;
+	u32		ets:1;
+	u32		dcbx:1;
+	u32		dscp:1;
+	u32		sbcam_reg:1;
+	u32		qos:1;
+	u32		port_buf:1;
+	u32		rsvd1:2;
+	u32		raw_tpe_qp_num:16;
+	u32		max_num_eqs:8;
+	u32		mac_port:8;
+	u32		raweth_rss_qp_id_base:16;
+	u16		msix_base;
+	u16		msix_num;
+	u8		log_max_mtt;
+	u8		log_max_tso;
+	u32		hca_core_clock;
+	u32		max_rwq_indirection_tables; /* rss_caps */
+	u32		max_rwq_indirection_table_size; /* rss_caps */
+	u16		raweth_qp_id_end;
+	u32		qp_rate_limit_min;
+	u32		qp_rate_limit_max;
+	u32		hw_feature_flag;
+	u16		pf0_vf_funcid_base;
+	u16		pf0_vf_funcid_top;
+	u16		pf1_vf_funcid_base;
+	u16		pf1_vf_funcid_top;
+	u16		pcie0_pf_funcid_base;
+	u16		pcie0_pf_funcid_top;
+	u16		pcie1_pf_funcid_base;
+	u16		pcie1_pf_funcid_top;
+	u8		nif_port_num;
+	u8		pcie_host;
+	u8		mac_bit;
+	u16		funcid_to_logic_port;
+	u8		lag_logic_port_ofst;
+};
+
+/* xsc_core */
 struct xsc_dev_resource {
 	/* protect buffer allocation according to numa node */
 	struct mutex		alloc_mutex;
@@ -43,8 +182,27 @@ struct xsc_core_device {
 	void __iomem		*bar;
 	int			bar_num;
 
+	u8			mac_port;
+	u16			glb_func_id;
+
 	struct xsc_cmd		cmd;
 	u16			cmdq_ver;
+
+	struct xsc_caps		caps;
+	struct xsc_board_info	*board_info;
+
+	struct xsc_reg_addr	regs;
+	u32			chip_ver_h;
+	u32			chip_ver_m;
+	u32			chip_ver_l;
+	u32			hotfix_num;
+	u32			feature_flag;
+
+	u8			fw_version_major;
+	u8			fw_version_minor;
+	u16			fw_version_patch;
+	u32			fw_version_tweak;
+	u8			fw_version_extra_flag;
 };
 
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index 5e0f0a205..fea625d54 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o
+xsc_pci-y := main.o cmdq.o hw.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c b/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
new file mode 100644
index 000000000..7d239ca17
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include "common/xsc_driver.h"
+#include "hw.h"
+
+#define MAX_BOARD_NUM	32
+
+static struct xsc_board_info *board_info[MAX_BOARD_NUM];
+
+static struct xsc_board_info *xsc_get_board_info(char *board_sn)
+{
+	int i;
+
+	for (i = 0; i < MAX_BOARD_NUM; i++) {
+		if (!board_info[i])
+			continue;
+		if (!strncmp(board_info[i]->board_sn, board_sn,
+			     XSC_BOARD_SN_LEN))
+			return board_info[i];
+	}
+
+	return NULL;
+}
+
+static struct xsc_board_info *xsc_alloc_board_info(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_BOARD_NUM; i++) {
+		if (!board_info[i])
+			break;
+	}
+	if (i == MAX_BOARD_NUM)
+		return NULL;
+	board_info[i] = vzalloc(sizeof(*board_info[i]));
+	if (!board_info[i])
+		return NULL;
+	board_info[i]->board_id = i;
+	return board_info[i];
+}
+
+void xsc_free_board_info(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_BOARD_NUM; i++)
+		vfree(board_info[i]);
+}
+
+int xsc_cmd_query_hca_cap(struct xsc_core_device *xdev,
+			  struct xsc_caps *caps)
+{
+	struct xsc_cmd_query_hca_cap_mbox_out *out;
+	struct xsc_cmd_query_hca_cap_mbox_in in;
+	struct xsc_board_info *board_info;
+	int err;
+	u16 t16;
+
+	out = kzalloc(sizeof(*out), GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	memset(&in, 0, sizeof(in));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_HCA_CAP);
+	in.cpu_num = cpu_to_be16(num_online_cpus());
+
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), out, sizeof(*out));
+	if (err)
+		goto err_free;
+
+	if (out->hdr.status) {
+		err = xsc_cmd_status_to_err(&out->hdr);
+		goto err_free;
+	}
+
+	xdev->glb_func_id = be32_to_cpu(out->hca_cap.glb_func_id);
+	caps->pcie0_pf_funcid_base =
+		be16_to_cpu(out->hca_cap.pcie0_pf_funcid_base);
+	caps->pcie0_pf_funcid_top =
+		be16_to_cpu(out->hca_cap.pcie0_pf_funcid_top);
+	caps->pcie1_pf_funcid_base =
+		be16_to_cpu(out->hca_cap.pcie1_pf_funcid_base);
+	caps->pcie1_pf_funcid_top =
+		be16_to_cpu(out->hca_cap.pcie1_pf_funcid_top);
+	caps->funcid_to_logic_port =
+		be16_to_cpu(out->hca_cap.funcid_to_logic_port);
+
+	caps->pcie_host = out->hca_cap.pcie_host;
+	caps->nif_port_num = out->hca_cap.nif_port_num;
+	caps->hw_feature_flag = be32_to_cpu(out->hca_cap.hw_feature_flag);
+
+	caps->raweth_qp_id_base = be16_to_cpu(out->hca_cap.raweth_qp_id_base);
+	caps->raweth_qp_id_end = be16_to_cpu(out->hca_cap.raweth_qp_id_end);
+	caps->raweth_rss_qp_id_base =
+		be16_to_cpu(out->hca_cap.raweth_rss_qp_id_base);
+	caps->raw_tpe_qp_num = be16_to_cpu(out->hca_cap.raw_tpe_qp_num);
+	caps->max_cqes = 1 << out->hca_cap.log_max_cq_sz;
+	caps->max_wqes = 1 << out->hca_cap.log_max_qp_sz;
+	caps->max_sq_desc_sz = be16_to_cpu(out->hca_cap.max_desc_sz_sq);
+	caps->max_rq_desc_sz = be16_to_cpu(out->hca_cap.max_desc_sz_rq);
+	caps->flags = be64_to_cpu(out->hca_cap.flags);
+	caps->stat_rate_support = be16_to_cpu(out->hca_cap.stat_rate_support);
+	caps->log_max_msg = out->hca_cap.log_max_msg & 0x1f;
+	caps->num_ports = out->hca_cap.num_ports & 0xf;
+	caps->log_max_cq = out->hca_cap.log_max_cq & 0x1f;
+	caps->log_max_eq = out->hca_cap.log_max_eq & 0xf;
+	caps->log_max_msix = out->hca_cap.log_max_msix & 0xf;
+	caps->mac_port = out->hca_cap.mac_port & 0xff;
+	xdev->mac_port = caps->mac_port;
+	if (caps->num_ports > XSC_MAX_FW_PORTS) {
+		pci_err(xdev->pdev, "device has %d ports while the driver supports max %d ports\n",
+			caps->num_ports, XSC_MAX_FW_PORTS);
+		err = -EINVAL;
+		goto err_free;
+	}
+	caps->send_ds_num = out->hca_cap.send_seg_num;
+	caps->send_wqe_shift = out->hca_cap.send_wqe_shift;
+	caps->recv_ds_num = out->hca_cap.recv_seg_num;
+	caps->recv_wqe_shift = out->hca_cap.recv_wqe_shift;
+
+	caps->embedded_cpu = 0;
+	caps->ecpf_vport_exists = 0;
+	caps->log_max_current_uc_list = 0;
+	caps->log_max_current_mc_list = 0;
+	caps->log_max_vlan_list = 8;
+	caps->log_max_qp = out->hca_cap.log_max_qp & 0x1f;
+	caps->log_max_mkey = out->hca_cap.log_max_mkey & 0x3f;
+	caps->log_max_pd = out->hca_cap.log_max_pd & 0x1f;
+	caps->log_max_srq = out->hca_cap.log_max_srqs & 0x1f;
+	caps->local_ca_ack_delay = out->hca_cap.local_ca_ack_delay & 0x1f;
+	caps->log_max_mcg = out->hca_cap.log_max_mcg;
+	caps->log_max_mtt = out->hca_cap.log_max_mtt;
+	caps->log_max_tso = out->hca_cap.log_max_tso;
+	caps->hca_core_clock = be32_to_cpu(out->hca_cap.hca_core_clock);
+	caps->max_rwq_indirection_tables =
+		be32_to_cpu(out->hca_cap.max_rwq_indirection_tables);
+	caps->max_rwq_indirection_table_size =
+		be32_to_cpu(out->hca_cap.max_rwq_indirection_table_size);
+	caps->max_qp_mcg = be16_to_cpu(out->hca_cap.max_qp_mcg);
+	caps->max_ra_res_qp = 1 << (out->hca_cap.log_max_ra_res_qp & 0x3f);
+	caps->max_ra_req_qp = 1 << (out->hca_cap.log_max_ra_req_qp & 0x3f);
+	caps->max_srq_wqes = 1 << out->hca_cap.log_max_srq_sz;
+	caps->rx_pkt_len_max = be32_to_cpu(out->hca_cap.rx_pkt_len_max);
+	caps->max_vfs = be16_to_cpu(out->hca_cap.max_vfs);
+	caps->qp_rate_limit_min = be32_to_cpu(out->hca_cap.qp_rate_limit_min);
+	caps->qp_rate_limit_max = be32_to_cpu(out->hca_cap.qp_rate_limit_max);
+
+	caps->msix_enable = 1;
+	caps->msix_base = be16_to_cpu(out->hca_cap.msix_base);
+	caps->msix_num = be16_to_cpu(out->hca_cap.msix_num);
+
+	t16 = be16_to_cpu(out->hca_cap.bf_log_bf_reg_size);
+	if (t16 & 0x8000) {
+		caps->bf_reg_size = 1 << (t16 & 0x1f);
+		caps->bf_regs_per_page = XSC_BF_REGS_PER_PAGE;
+	} else {
+		caps->bf_reg_size = 0;
+		caps->bf_regs_per_page = 0;
+	}
+	caps->min_page_sz = ~(u32)((1 << PAGE_SHIFT) - 1);
+
+	caps->dcbx = 1;
+	caps->qos = 1;
+	caps->ets = 1;
+	caps->dscp = 1;
+	caps->max_tc = out->hca_cap.max_tc;
+	caps->log_max_qp_depth = out->hca_cap.log_max_qp_depth & 0xff;
+	caps->mac_bit = out->hca_cap.mac_bit;
+	caps->lag_logic_port_ofst = out->hca_cap.lag_logic_port_ofst;
+
+	xdev->chip_ver_h = be32_to_cpu(out->hca_cap.chip_ver_h);
+	xdev->chip_ver_m = be32_to_cpu(out->hca_cap.chip_ver_m);
+	xdev->chip_ver_l = be32_to_cpu(out->hca_cap.chip_ver_l);
+	xdev->hotfix_num = be32_to_cpu(out->hca_cap.hotfix_num);
+	xdev->feature_flag = be32_to_cpu(out->hca_cap.feature_flag);
+
+	board_info = xsc_get_board_info(out->hca_cap.board_sn);
+	if (!board_info) {
+		board_info = xsc_alloc_board_info();
+		if (!board_info) {
+			err = -ENOMEM;
+			goto err_free;
+		}
+
+		memcpy(board_info->board_sn,
+		       out->hca_cap.board_sn,
+		       sizeof(out->hca_cap.board_sn));
+	}
+
+	xdev->board_info = board_info;
+
+	xdev->regs.tx_db = be64_to_cpu(out->hca_cap.tx_db);
+	xdev->regs.rx_db = be64_to_cpu(out->hca_cap.rx_db);
+	xdev->regs.complete_db = be64_to_cpu(out->hca_cap.complete_db);
+	xdev->regs.complete_reg = be64_to_cpu(out->hca_cap.complete_reg);
+	xdev->regs.event_db = be64_to_cpu(out->hca_cap.event_db);
+
+	xdev->fw_version_major = out->hca_cap.fw_ver.fw_version_major;
+	xdev->fw_version_minor = out->hca_cap.fw_ver.fw_version_minor;
+	xdev->fw_version_patch =
+		be16_to_cpu(out->hca_cap.fw_ver.fw_version_patch);
+	xdev->fw_version_tweak =
+		be32_to_cpu(out->hca_cap.fw_ver.fw_version_tweak);
+	xdev->fw_version_extra_flag = out->hca_cap.fw_ver.fw_version_extra_flag;
+
+	kfree(out);
+	return 0;
+err_free:
+	kfree(out);
+	return err;
+}
+
+static int xsc_cmd_query_guid(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd_query_guid_mbox_out out;
+	struct xsc_cmd_query_guid_mbox_in in;
+	int err;
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_GUID);
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err)
+		return err;
+
+	if (out.hdr.status)
+		return xsc_cmd_status_to_err(&out.hdr);
+	xdev->board_info->guid = out.guid;
+	xdev->board_info->guid_valid = 1;
+	return 0;
+}
+
+int xsc_query_guid(struct xsc_core_device *xdev)
+{
+	if (xdev->board_info->guid_valid)
+		return 0;
+
+	return xsc_cmd_query_guid(xdev);
+}
+
+static int xsc_cmd_activate_hw_config(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd_activate_hw_config_mbox_out out;
+	struct xsc_cmd_activate_hw_config_mbox_in in;
+	int err = 0;
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_ACTIVATE_HW_CONFIG);
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err)
+		return err;
+	if (out.hdr.status)
+		return xsc_cmd_status_to_err(&out.hdr);
+	xdev->board_info->hw_config_activated = 1;
+	return 0;
+}
+
+int xsc_activate_hw_config(struct xsc_core_device *xdev)
+{
+	if (xdev->board_info->hw_config_activated)
+		return 0;
+
+	return xsc_cmd_activate_hw_config(xdev);
+}
+
+int xsc_reset_function_resource(struct xsc_core_device *xdev)
+{
+	struct xsc_function_reset_mbox_out out;
+	struct xsc_function_reset_mbox_in in;
+	int err;
+
+	memset(&in, 0, sizeof(in));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_FUNCTION_RESET);
+	in.glb_func_id = cpu_to_be16(xdev->glb_func_id);
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err || out.hdr.status)
+		return -EINVAL;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/hw.h b/drivers/net/ethernet/yunsilicon/xsc/pci/hw.h
new file mode 100644
index 000000000..d1030bfde
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/hw.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __HW_H
+#define __HW_H
+
+#include "common/xsc_core.h"
+
+void xsc_free_board_info(void);
+int xsc_cmd_query_hca_cap(struct xsc_core_device *xdev,
+			  struct xsc_caps *caps);
+int xsc_query_guid(struct xsc_core_device *xdev);
+int xsc_activate_hw_config(struct xsc_core_device *xdev);
+int xsc_reset_function_resource(struct xsc_core_device *xdev);
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index 3c717acbb..099feb650 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -5,6 +5,7 @@
 
 #include "common/xsc_core.h"
 #include "common/xsc_driver.h"
+#include "hw.h"
 
 static const struct pci_device_id xsc_pci_id_table[] = {
 	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
@@ -153,6 +154,31 @@ static int xsc_hw_setup(struct xsc_core_device *xdev)
 		goto err_cmd_cleanup;
 	}
 
+	err = xsc_cmd_query_hca_cap(xdev, &xdev->caps);
+	if (err) {
+		pci_err(xdev->pdev, "Failed to query hca, err=%d\n", err);
+		goto err_cmd_cleanup;
+	}
+
+	err = xsc_query_guid(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "failed to query guid, err=%d\n", err);
+		goto err_cmd_cleanup;
+	}
+
+	err = xsc_activate_hw_config(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "failed to activate hw config, err=%d\n",
+			err);
+		goto err_cmd_cleanup;
+	}
+
+	err = xsc_reset_function_resource(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "Failed to reset function resource\n");
+		goto err_cmd_cleanup;
+	}
+
 	return 0;
 err_cmd_cleanup:
 	xsc_cmd_cleanup(xdev);
@@ -261,6 +287,7 @@ static int __init xsc_init(void)
 static void __exit xsc_fini(void)
 {
 	pci_unregister_driver(&xsc_pci_driver);
+	xsc_free_board_info();
 }
 
 module_init(xsc_init);
-- 
2.43.0

