Return-Path: <netdev+bounces-29257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE61782543
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 10:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F17D1C20924
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3684C9E;
	Mon, 21 Aug 2023 08:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019E64C6A
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 08:15:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BA893
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692605721; x=1724141721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HiDt/wvreu3x8uTzPuM04eMcmACrU0e2kwIusCNTnO0=;
  b=HvbabVlf2O6Osi+xsXeYP2QwQa+45EJEoANzSBwSJjlJ5Q3z8t5XsRDt
   rgE5srlv94KSW0llPg2r13j/GmY6I99LhdO1vT6bHAS3maOy4h3yyftiO
   STMO/4nPq4mPFG+ccF79KKhxKs9z7y3vR3X9Slj0rHfdvv5Q1NW0xRAVq
   11rFDDjhJ7qbFGSbGLqfpbZMgUc98RSLG9AIQXQbRL1P9grkNwCF1lkIS
   60mZbE023aEnFAjxDXEoO74Jyuv2W7FBbuBBOB/D/T5mj552cJK8Fp/op
   EAmr+lNppvqcXxI5wXHeC2dpCHL04635kLSC5sBxeuMPAY4pMRXOtPl29
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="376280498"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="376280498"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="685577587"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="685577587"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2023 01:15:17 -0700
From: Junfeng Guo <junfeng.guo@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	qi.z.zhang@intel.com,
	ivecera@redhat.com,
	sridhar.samudrala@intel.com,
	horms@kernel.org,
	Junfeng Guo <junfeng.guo@intel.com>
Subject: [PATCH iwl-next v6 10/15] ice: add parser runtime skeleton
Date: Mon, 21 Aug 2023 16:14:33 +0800
Message-Id: <20230821081438.2937934-11-junfeng.guo@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821081438.2937934-1-junfeng.guo@intel.com>
References: <20230821023833.2700902-1-junfeng.guo@intel.com>
 <20230821081438.2937934-1-junfeng.guo@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add parser runtime data struct ice_parser_rt.

Add below APIs for parser runtime preparation:
- ice_parser_rt_reset
- ice_parser_rt_pkt_buf_set

Add below API skeleton for parser runtime execution:
- ice_parser_rt_execute

Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.c   | 40 ++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h   | 28 ++++++
 .../net/ethernet/intel/ice/ice_parser_rt.c    | 92 +++++++++++++++++++
 .../net/ethernet/intel/ice/ice_parser_rt.h    | 39 ++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser_rt.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser_rt.h

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index 6499bb774667..1bd1417e32c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -156,6 +156,7 @@ int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr)
 		return -ENOMEM;
 
 	p->hw = hw;
+	p->rt.psr = p;
 
 	p->imem_table = ice_imem_table_get(hw);
 	if (!p->imem_table) {
@@ -285,3 +286,42 @@ void ice_parser_destroy(struct ice_parser *psr)
 
 	devm_kfree(ice_hw_to_dev(psr->hw), psr);
 }
+
+/**
+ * ice_parser_run - parse on a packet in binary and return the result
+ * @psr: pointer to a parser instance
+ * @pkt_buf: packet data
+ * @pkt_len: packet length
+ * @rslt: input/output parameter to save parser result.
+ */
+int ice_parser_run(struct ice_parser *psr, const u8 *pkt_buf,
+		   int pkt_len, struct ice_parser_result *rslt)
+{
+	ice_parser_rt_reset(&psr->rt);
+	ice_parser_rt_pktbuf_set(&psr->rt, pkt_buf, pkt_len);
+
+	return ice_parser_rt_execute(&psr->rt, rslt);
+}
+
+/**
+ * ice_parser_result_dump - dump a parser result info
+ * @hw: pointer to the hardware structure
+ * @rslt: parser result info to dump
+ */
+void ice_parser_result_dump(struct ice_hw *hw, struct ice_parser_result *rslt)
+{
+	int i;
+
+	dev_info(ice_hw_to_dev(hw), "ptype = %d\n", rslt->ptype);
+	for (i = 0; i < rslt->po_num; i++)
+		dev_info(ice_hw_to_dev(hw), "proto = %d, offset = %d\n",
+			 rslt->po[i].proto_id, rslt->po[i].offset);
+
+	dev_info(ice_hw_to_dev(hw), "flags_psr = 0x%016llx\n",
+		 (unsigned long long)rslt->flags_psr);
+	dev_info(ice_hw_to_dev(hw), "flags_pkt = 0x%016llx\n",
+		 (unsigned long long)rslt->flags_pkt);
+	dev_info(ice_hw_to_dev(hw), "flags_sw = 0x%04x\n", rslt->flags_sw);
+	dev_info(ice_hw_to_dev(hw), "flags_fd = 0x%04x\n", rslt->flags_fd);
+	dev_info(ice_hw_to_dev(hw), "flags_rss = 0x%04x\n", rslt->flags_rss);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index ca71ef4f50f5..5f98f3031294 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -13,6 +13,7 @@
 #include "ice_proto_grp.h"
 #include "ice_flg_rd.h"
 #include "ice_xlt_kb.h"
+#include "ice_parser_rt.h"
 
 #define ICE_SEC_DATA_OFFSET				4
 #define ICE_SID_RXPARSER_IMEM_ENTRY_SIZE		48
@@ -30,6 +31,8 @@
 #define ICE_SEC_LBL_DATA_OFFSET				2
 #define ICE_SID_LBL_ENTRY_SIZE				66
 
+#define ICE_PARSER_PROTO_OFF_PAIR_SIZE			16
+
 struct ice_parser {
 	struct ice_hw *hw; /* pointer to the hardware structure */
 
@@ -65,8 +68,33 @@ struct ice_parser {
 	struct ice_xlt_kb *xlt_kb_fd;
 	/* load data from section ICE_SID_XLT_KEY_BUILDER_RSS */
 	struct ice_xlt_kb *xlt_kb_rss;
+	struct ice_parser_rt rt; /* parser runtime */
 };
 
 int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr);
 void ice_parser_destroy(struct ice_parser *psr);
+
+struct ice_parser_proto_off {
+	u8 proto_id;	/* hardware protocol ID */
+	u16 offset;	/* offset from the start of the protocol header */
+};
+
+#define ICE_PARSER_FLAG_PSR_SIZE	8
+
+struct ice_parser_result {
+	u16 ptype;	/* 16 bits hardware PTYPE */
+	/* array of protocol and header offset pairs */
+	struct ice_parser_proto_off po[ICE_PARSER_PROTO_OFF_PAIR_SIZE];
+	int po_num;	/* # of protocol-offset pairs must <= 16 */
+	u64 flags_psr;	/* 64 bits parser flags */
+	u64 flags_pkt;	/* 64 bits packet flags */
+	u16 flags_sw;	/* 16 bits key builder flag for SW */
+	u16 flags_acl;	/* 16 bits key builder flag for ACL */
+	u16 flags_fd;	/* 16 bits key builder flag for FD */
+	u16 flags_rss;	/* 16 bits key builder flag for RSS */
+};
+
+int ice_parser_run(struct ice_parser *psr, const u8 *pkt_buf,
+		   int pkt_len, struct ice_parser_result *rslt);
+void ice_parser_result_dump(struct ice_hw *hw, struct ice_parser_result *rslt);
 #endif /* _ICE_PARSER_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
new file mode 100644
index 000000000000..a6644f4b3324
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Intel Corporation */
+
+#include "ice_common.h"
+
+static void _ice_rt_tsr_set(struct ice_parser_rt *rt, u16 tsr)
+{
+	rt->gpr[ICE_GPR_TSR_IDX] = tsr;
+}
+
+static void _ice_rt_ho_set(struct ice_parser_rt *rt, u16 ho)
+{
+	rt->gpr[ICE_GPR_HO_IDX] = ho;
+	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
+}
+
+static void _ice_rt_np_set(struct ice_parser_rt *rt, u16 pc)
+{
+	rt->gpr[ICE_GPR_NP_IDX] = pc;
+}
+
+static void _ice_rt_nn_set(struct ice_parser_rt *rt, u16 node)
+{
+	rt->gpr[ICE_GPR_NN_IDX] = node;
+}
+
+static void _ice_rt_flag_set(struct ice_parser_rt *rt, int idx, bool val)
+{
+	int y = idx / ICE_GPR_FLG_SIZE;
+	int x = idx % ICE_GPR_FLG_SIZE;
+
+	if (val)
+		rt->gpr[ICE_GPR_FLG_IDX + y] |= (u16)BIT(x);
+}
+
+/**
+ * ice_parser_rt_reset - reset the parser runtime
+ * @rt: pointer to the parser runtime
+ */
+void ice_parser_rt_reset(struct ice_parser_rt *rt)
+{
+	struct ice_parser *psr = rt->psr;
+	struct ice_metainit_item *mi = &psr->mi_table[0];
+	int i;
+
+	memset(rt, 0, sizeof(*rt));
+
+	/* TSR: TCAM Search Register */
+	_ice_rt_tsr_set(rt, mi->tsr);
+	/* HO: Next Parsing Cycle Header Offset */
+	_ice_rt_ho_set(rt, mi->ho);
+	/* NP: Next Parsing Cycle */
+	_ice_rt_np_set(rt, mi->pc);
+	/* NN: Next Parsing Cycle Node ID */
+	_ice_rt_nn_set(rt, mi->pg_rn);
+
+	rt->psr = psr;
+
+	for (i = 0; i < ICE_PARSER_FLG_NUM; i++) {
+		if ((mi->flags & BIT(i)) != 0ul)
+			_ice_rt_flag_set(rt, i, true);
+	}
+}
+
+/**
+ * ice_parser_rt_pktbuf_set - set a packet into parser runtime
+ * @rt: pointer to the parser runtime
+ * @pkt_buf: buffer with packet data
+ * @pkt_len: packet buffer length
+ */
+void ice_parser_rt_pktbuf_set(struct ice_parser_rt *rt, const u8 *pkt_buf,
+			      int pkt_len)
+{
+	int len = min(ICE_PARSER_MAX_PKT_LEN, pkt_len);
+	u16 ho = rt->gpr[ICE_GPR_HO_IDX];
+
+	memcpy(rt->pkt_buf, pkt_buf, len);
+	rt->pkt_len = pkt_len;
+
+	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
+}
+
+/**
+ * ice_parser_rt_execute - parser execution routine
+ * @rt: pointer to the parser runtime
+ * @rslt: input/output parameter to save parser result
+ */
+int ice_parser_rt_execute(struct ice_parser_rt *rt,
+			  struct ice_parser_result *rslt)
+{
+	return ICE_ERR_NOT_IMPL;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.h b/drivers/net/ethernet/intel/ice/ice_parser_rt.h
new file mode 100644
index 000000000000..dadcb8791430
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _ICE_PARSER_RT_H_
+#define _ICE_PARSER_RT_H_
+
+#define ICE_GPR_HV_IDX		64
+#define ICE_GPR_HV_SIZE		32
+#define ICE_GPR_ERR_IDX		84
+#define ICE_GPR_FLG_IDX		104
+#define ICE_GPR_FLG_SIZE	16
+
+#define ICE_GPR_TSR_IDX		108
+#define ICE_GPR_NN_IDX		109
+#define ICE_GPR_HO_IDX		110
+#define ICE_GPR_NP_IDX		111
+
+struct ice_parser_ctx;
+
+#define ICE_PARSER_MAX_PKT_LEN	504
+#define ICE_PARSER_PKT_REV	32
+#define ICE_PARSER_GPR_NUM	128
+
+struct ice_parser_rt {
+	struct ice_parser *psr;
+	u16 gpr[ICE_PARSER_GPR_NUM];
+	u8 pkt_buf[ICE_PARSER_MAX_PKT_LEN + ICE_PARSER_PKT_REV];
+	u16 pkt_len;
+	u16 po;
+};
+
+void ice_parser_rt_reset(struct ice_parser_rt *rt);
+void ice_parser_rt_pktbuf_set(struct ice_parser_rt *rt, const u8 *pkt_buf,
+			      int pkt_len);
+
+struct ice_parser_result;
+int ice_parser_rt_execute(struct ice_parser_rt *rt,
+			  struct ice_parser_result *rslt);
+#endif /* _ICE_PARSER_RT_H_ */
-- 
2.25.1


