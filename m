Return-Path: <netdev+bounces-294935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jv/4HECmIGos6QAAu9opvQ
	(envelope-from <netdev+bounces-294935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:10:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E6D63B81E
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:10:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="AkQr5a/x";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294935-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294935-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1325303C632
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CAC43E4A6;
	Wed,  3 Jun 2026 22:08:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F44438FEF
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:08:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524522; cv=none; b=Sac9BOrEASnZIvPzf/ucB8SWtpEPTmdFHsAlbo7V/bBL3LLWW2NYneQXt0bPrzUuy1iaRlHDX5FksakXI2Li6zQKpa2VacG9yESo0GjJNN11R76/64bfuG0aL1x0q4gj1cv76AZuhrW7pHczbVc0Rd9o6NFDaq8briRLpDOLb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524522; c=relaxed/simple;
	bh=4dA+0nT4dKFGfaBY4usDuWC2tft/XemqhxIIomJ4fus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ja01SFFtRnVRqaip0GeqFILMshcdBdzY/0N67znfp7E1FH2KNum1WJUewStcdvsW80adE+0xVf9BC7jvPDL22+DpKDNv1Z7eAdmU6QM9cSV5Z0nvgNigdcZUC9mffMEzWM0lsapdSitHVCKkT6fYKHv2oqzSxAkpNYzSr/H1Iv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkQr5a/x; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780524519; x=1812060519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4dA+0nT4dKFGfaBY4usDuWC2tft/XemqhxIIomJ4fus=;
  b=AkQr5a/xgUPskEqkYz5dnd3IEHWxO1KWlwZZwo5SawcMYHjQObS6HzN/
   E872gomZzp0twsnWcV68vkPI/0ygI9tSte7n9xbMGwMivbAO8nY7j585H
   MSJ3BdW4xQTz/rFcWS5k3XL3aNU/TWuejG21jyLtNMwBHBbt6Wad7iJgW
   2Il3ue/G+0yM6L0cBwxLAPj+sFT7rtJW57h0/Kv20NHFSRbxmXGioykE6
   gXzer87OTnO8kAfYNwYPoKRHHZvvDYp/jxqVTc1FRs2nOH60oGDs2rq10
   MZoKzkiCQQIih7d6sSWmLmdoC0Wqcd0uxdGkqqpxFBt96mjSEo5Equt98
   A==;
X-CSE-ConnectionGUID: aMwuEG2WQYanMAq1iH0png==
X-CSE-MsgGUID: a7qTPUgRSfilNQmlN6HY4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98920912"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98920912"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:08:36 -0700
X-CSE-ConnectionGUID: NtUzWxDdRt+0TGQ7JlWY7Q==
X-CSE-MsgGUID: z0szPTPnSiW//1DBII/34w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282458889"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Jun 2026 15:08:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Real Valiquette <anthony.l.nguyen@intel.com>,
	marcin.szycik@linux.intel.com,
	aleksandr.loktionov@intel.com,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Chinh Cao <chinh.t.cao@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 04/10] ice: create flow profile
Date: Wed,  3 Jun 2026 15:08:20 -0700
Message-ID: <20260603220828.829969-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
References: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294935-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:marcin.szycik@linux.intel.com,m:aleksandr.loktionov@intel.com,m:sandeep.penigalapati@intel.com,m:ananth.s@intel.com,m:alexander.duyck@gmail.com,m:chinh.t.cao@intel.com,m:alexander.nowlin@intel.com,m:andrew@lunn.ch,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98E6D63B81E

From: Real Valiquette <real.valiquette@intel.com>

Implement the initial steps for creating an ACL filter to support ntuple
masks. Create a flow profile based on a given mask rule and program it to
the hardware. Though the profile is written to hardware, no actions are
associated with the profile yet.

Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
Signed-off-by: Real Valiquette <real.valiquette@intel.com>
Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   6 +
 drivers/net/ethernet/intel/ice/ice_acl_main.c | 228 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_acl_main.h |   9 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  39 +++
 .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 299 +++++++++++++-----
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   6 +
 drivers/net/ethernet/intel/ice/ice_flow.c     | 173 ++++++++++
 drivers/net/ethernet/intel/ice/ice_flow.h     |  17 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  36 ++-
 10 files changed, 733 insertions(+), 81 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 6afe7be056ba..7f06d9bafe4a 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -25,6 +25,7 @@ ice-y := ice_main.o	\
 	 ice_vsi_vlan_lib.o \
 	 ice_fdir.o	\
 	 ice_ethtool_ntuple.o \
+	 ice_acl_main.o	\
 	 ice_acl.o	\
 	 ice_acl_ctrl.o	\
 	 ice_vlan_mode.o \
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 31d69977a947..aa07c300da90 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1025,6 +1025,11 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
 int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
 int ice_get_ethtool_fdir_entry(struct ice_hw *hw, struct ethtool_rxnfc *cmd);
 u32 ice_ntuple_get_max_fltr_cnt(struct ice_hw *hw);
+int ice_ntuple_l4_proto_to_port(enum ice_flow_seg_hdr l4_proto,
+				enum ice_flow_field *src_port,
+				enum ice_flow_field *dst_port);
+int ice_ntuple_check_ip4_seg(struct ethtool_tcpip4_spec *tcp_ip4_spec);
+int ice_ntuple_check_ip4_usr_seg(struct ethtool_usrip4_spec *usr_ip4_spec);
 int
 ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
 		      u32 *rule_locs);
@@ -1033,6 +1038,7 @@ void ice_fdir_release_flows(struct ice_hw *hw);
 void ice_fdir_replay_flows(struct ice_hw *hw);
 void ice_fdir_replay_fltrs(struct ice_pf *pf);
 int ice_fdir_create_dflt_rules(struct ice_pf *pf);
+enum ice_fltr_ptype ice_ethtool_flow_to_fltr(int eth);
 
 enum ice_aq_task_state {
 	ICE_AQ_TASK_NOT_PREPARED,
diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
new file mode 100644
index 000000000000..5eda2a6b8245
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2026, Intel Corporation. */
+
+#include "ice.h"
+#include "ice_lib.h"
+#include "ice_acl_main.h"
+
+/* Number of action */
+#define ICE_ACL_NUM_ACT		1
+
+/**
+ * ice_acl_set_ip4_addr_seg - set flow segment IPv4 addresses masks
+ * @seg: flow segment for programming
+ */
+static void ice_acl_set_ip4_addr_seg(struct ice_flow_seg_info *seg)
+{
+	u16 val_loc, mask_loc;
+
+	/* IP source address */
+	val_loc = offsetof(struct ice_ntuple_fltr, ip.v4.src_ip);
+	mask_loc = offsetof(struct ice_ntuple_fltr, mask.v4.src_ip);
+
+	ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV4_SA, val_loc,
+			 mask_loc, ICE_FLOW_FLD_OFF_INVAL, false);
+
+	/* IP destination address */
+	val_loc = offsetof(struct ice_ntuple_fltr, ip.v4.dst_ip);
+	mask_loc = offsetof(struct ice_ntuple_fltr, mask.v4.dst_ip);
+
+	ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV4_DA, val_loc,
+			 mask_loc, ICE_FLOW_FLD_OFF_INVAL, false);
+}
+
+/**
+ * ice_acl_set_ip4_port_seg - set flow segment port masks based on L4 port
+ * @seg: flow segment for programming
+ * @l4_proto: Layer 4 protocol to program
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_acl_set_ip4_port_seg(struct ice_flow_seg_info *seg,
+				    enum ice_flow_seg_hdr l4_proto)
+{
+	enum ice_flow_field src_port, dst_port;
+	u16 val_loc, mask_loc;
+	int err;
+
+	err = ice_ntuple_l4_proto_to_port(l4_proto, &src_port, &dst_port);
+	if (err)
+		return err;
+
+	/* Layer 4 source port */
+	val_loc = offsetof(struct ice_ntuple_fltr, ip.v4.src_port);
+	mask_loc = offsetof(struct ice_ntuple_fltr, mask.v4.src_port);
+
+	ice_flow_set_fld(seg, src_port, val_loc, mask_loc,
+			 ICE_FLOW_FLD_OFF_INVAL, false);
+
+	/* Layer 4 destination port */
+	val_loc = offsetof(struct ice_ntuple_fltr, ip.v4.dst_port);
+	mask_loc = offsetof(struct ice_ntuple_fltr, mask.v4.dst_port);
+
+	ice_flow_set_fld(seg, dst_port, val_loc, mask_loc,
+			 ICE_FLOW_FLD_OFF_INVAL, false);
+
+	return 0;
+}
+
+/**
+ * ice_acl_set_ip4_seg - set flow segment IPv4 and L4 masks
+ * @seg: flow segment for programming
+ * @tcp_ip4_spec: mask data from ethtool
+ * @l4_proto: Layer 4 protocol to program
+ *
+ * Set the mask data into the flow segment to be used to program HW
+ * table based on provided L4 protocol for IPv4
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_acl_set_ip4_seg(struct ice_flow_seg_info *seg,
+			       struct ethtool_tcpip4_spec *tcp_ip4_spec,
+			       enum ice_flow_seg_hdr l4_proto)
+{
+	int err;
+
+	err = ice_ntuple_check_ip4_seg(tcp_ip4_spec);
+	if (err)
+		return err;
+
+	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV4 | l4_proto);
+	ice_acl_set_ip4_addr_seg(seg);
+
+	return ice_acl_set_ip4_port_seg(seg, l4_proto);
+}
+
+/**
+ * ice_acl_set_ip4_usr_seg - set flow segment IPv4 masks
+ * @seg: flow segment for programming
+ * @usr_ip4_spec: ethtool userdef packet offset
+ *
+ * Set the offset data into the flow segment to be used to program HW
+ * table for IPv4
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_acl_set_ip4_usr_seg(struct ice_flow_seg_info *seg,
+				   struct ethtool_usrip4_spec *usr_ip4_spec)
+{
+	int err;
+
+	err = ice_ntuple_check_ip4_usr_seg(usr_ip4_spec);
+	if (err)
+		return err;
+
+	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV4);
+	ice_acl_set_ip4_addr_seg(seg);
+
+	return 0;
+}
+
+/**
+ * ice_acl_prof_add_ethtool - Check ethtool input set and add ACL profile
+ * @pf: ice PF structure
+ * @fsp: pointer to ethtool Rx flow specification
+ *
+ * Return: 0 on success and negative values for failure
+ */
+static int ice_acl_prof_add_ethtool(struct ice_pf *pf,
+				    struct ethtool_rx_flow_spec *fsp)
+{
+	struct ice_flow_prof *prof = NULL;
+	struct ice_acl_hw_prof *hw_prof;
+	struct ice_flow_seg_info *seg;
+	enum ice_fltr_ptype fltr_type;
+	struct ice_hw *hw = &pf->hw;
+	int err;
+
+	seg = kzalloc_obj(*seg);
+	if (!seg)
+		return -ENOMEM;
+
+	switch (fsp->flow_type & ~FLOW_EXT) {
+	case TCP_V4_FLOW:
+		err = ice_acl_set_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					  ICE_FLOW_SEG_HDR_TCP);
+		break;
+	case UDP_V4_FLOW:
+		err = ice_acl_set_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					  ICE_FLOW_SEG_HDR_UDP);
+		break;
+	case SCTP_V4_FLOW:
+		err = ice_acl_set_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					  ICE_FLOW_SEG_HDR_SCTP);
+		break;
+	case IPV4_USER_FLOW:
+		err = ice_acl_set_ip4_usr_seg(seg, &fsp->m_u.usr_ip4_spec);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+	if (err)
+		goto free_seg;
+
+	fltr_type = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
+
+	hw_prof = hw->acl_prof[fltr_type];
+	if (!hw_prof) {
+		hw_prof = kzalloc_obj(**hw->acl_prof);
+		if (!hw_prof) {
+			err = -ENOMEM;
+			goto free_seg;
+		}
+	}
+
+	if (hw_prof->seg) {
+		/* This flow_type already has an input set.
+		 * If it matches the requested input set then we are
+		 * done. If it's different then it's an error.
+		 */
+		if (!memcmp(hw_prof->seg, seg, sizeof(*seg))) {
+			kfree(seg);
+			return 0;
+		}
+
+		err = -EINVAL;
+		goto free_acl_prof;
+	}
+
+	/* Adding a profile for the given flow specification with no
+	 * actions (NULL) and zero actions 0.
+	 */
+	err = ice_flow_add_prof(hw, ICE_BLK_ACL, ICE_FLOW_RX, seg, 1, false,
+				&prof);
+	if (err)
+		goto free_acl_prof;
+
+	hw_prof->seg = seg;
+	hw_prof->prof_id = prof->id;
+	hw->acl_prof[fltr_type] = hw_prof;
+	return 0;
+
+free_acl_prof:
+	kfree(hw_prof);
+	hw->acl_prof[fltr_type] = NULL;
+free_seg:
+	kfree(seg);
+
+	return err;
+}
+
+/**
+ * ice_acl_add_rule_ethtool - add an ACL rule
+ * @vsi: pointer to target VSI
+ * @cmd: command to add or delete ACL rule
+ *
+ * Return: 0 on success and negative values for failure
+ */
+int ice_acl_add_rule_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp;
+	struct ice_pf *pf;
+
+	pf = vsi->back;
+
+	fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
+
+	return ice_acl_prof_add_ethtool(pf, fsp);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.h b/drivers/net/ethernet/intel/ice/ice_acl_main.h
new file mode 100644
index 000000000000..6665af2e7053
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_acl_main.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026, Intel Corporation. */
+
+#ifndef _ICE_ACL_MAIN_H_
+#define _ICE_ACL_MAIN_H_
+#include "ice.h"
+#include <linux/ethtool.h>
+int ice_acl_add_rule_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
+#endif /* _ICE_ACL_MAIN_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index e6519e88b980..3d566112ef8d 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -172,6 +172,8 @@ struct ice_aqc_set_port_params {
 #define ICE_AQC_RES_TYPE_FDIR_COUNTER_BLOCK		0x21
 #define ICE_AQC_RES_TYPE_FDIR_GUARANTEED_ENTRIES	0x22
 #define ICE_AQC_RES_TYPE_FDIR_SHARED_ENTRIES		0x23
+#define ICE_AQC_RES_TYPE_ACL_PROF_BLDR_PROFID		0x50
+#define ICE_AQC_RES_TYPE_ACL_PROF_BLDR_TCAM		0x51
 #define ICE_AQC_RES_TYPE_FD_PROF_BLDR_PROFID		0x58
 #define ICE_AQC_RES_TYPE_FD_PROF_BLDR_TCAM		0x59
 #define ICE_AQC_RES_TYPE_HASH_PROF_BLDR_PROFID		0x60
@@ -2176,6 +2178,43 @@ struct ice_aqc_actpair {
 	struct ice_acl_act_entry act[ICE_ACL_NUM_ACT_PER_ACT_PAIR];
 };
 
+/* The first byte of the byte selection base is reserved to keep the
+ * first byte of the field vector where the packet direction info is
+ * available. Thus we should start at index 1 of the field vector to
+ * map its entries to the byte selection base.
+ */
+#define ICE_AQC_ACL_PROF_BYTE_SEL_START_IDX	1
+#define ICE_AQC_ACL_PROF_BYTE_SEL_ELEMS		30
+
+/* Input buffer format for program profile extraction admin command and
+ * response buffer format for query profile admin command is as defined
+ * in struct ice_aqc_acl_prof_generic_frmt
+ */
+
+/* Input buffer format for program profile ranges and query profile ranges
+ * admin commands. Same format is used for response buffer in case of query
+ * profile ranges command
+ */
+struct ice_acl_rng_data {
+	/* The range checker output shall be sent when the value
+	 * related to this range checker is lower than low boundary
+	 */
+	__be16 low_boundary;
+	/* The range checker output shall be sent when the value
+	 * related to this range checker is higher than high boundary
+	 */
+	__be16 high_boundary;
+	/* A value of '0' in bit shall clear the relevant bit input
+	 * to the range checker
+	 */
+	__be16 mask;
+};
+
+#define ICE_AQC_ACL_PROF_RANGES_NUM_CFG 8
+struct ice_aqc_acl_profile_ranges {
+	struct ice_acl_rng_data checker_cfg[ICE_AQC_ACL_PROF_RANGES_NUM_CFG];
+};
+
 /* Program ACL entry (indirect 0x0C20) */
 struct ice_aqc_acl_entry {
 	u8 tcam_index;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index d2612037b2e7..684c832b0c58 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -7,6 +7,7 @@
 #include "ice_lib.h"
 #include "ice_fdir.h"
 #include "ice_flow.h"
+#include "ice_acl_main.h"
 
 static struct in6_addr full_ipv6_addr_mask = {
 	.in6_u = {
@@ -26,6 +27,9 @@ static struct in6_addr zero_ipv6_addr_mask = {
 	}
 };
 
+#define ICE_FULL_IPV4_ADDR_MASK	0xFFFFFFFF
+#define ICE_FULL_PORT_MASK	0xFFFF
+
 /* calls to ice_flow_add_prof require the number of segments in the array
  * for segs_cnt. In this code that is one more than the index.
  */
@@ -71,7 +75,7 @@ static int ice_fltr_to_ethtool_flow(enum ice_fltr_ptype flow)
  *
  * Returns flow enum
  */
-static enum ice_fltr_ptype ice_ethtool_flow_to_fltr(int eth)
+enum ice_fltr_ptype ice_ethtool_flow_to_fltr(int eth)
 {
 	switch (eth) {
 	case ETHER_FLOW:
@@ -960,23 +964,13 @@ ice_create_init_fdir_rule(struct ice_pf *pf, enum ice_fltr_ptype flow)
 }
 
 /**
- * ice_set_fdir_ip4_seg
- * @seg: flow segment for programming
+ * ice_ntuple_check_ip4_seg - Check valid fields are provided for filter
  * @tcp_ip4_spec: mask data from ethtool
- * @l4_proto: Layer 4 protocol to program
- * @perfect_fltr: only valid on success; returns true if perfect filter,
- *		  false if not
  *
- * Set the mask data into the flow segment to be used to program HW
- * table based on provided L4 protocol for IPv4
+ * Return: 0 if fields valid, negative otherwise
  */
-static int
-ice_set_fdir_ip4_seg(struct ice_flow_seg_info *seg,
-		     struct ethtool_tcpip4_spec *tcp_ip4_spec,
-		     enum ice_flow_seg_hdr l4_proto, bool *perfect_fltr)
+int ice_ntuple_check_ip4_seg(struct ethtool_tcpip4_spec *tcp_ip4_spec)
 {
-	enum ice_flow_field src_port, dst_port;
-
 	/* make sure we don't have any empty rule */
 	if (!tcp_ip4_spec->psrc && !tcp_ip4_spec->ip4src &&
 	    !tcp_ip4_spec->pdst && !tcp_ip4_spec->ip4dst)
@@ -986,24 +980,71 @@ ice_set_fdir_ip4_seg(struct ice_flow_seg_info *seg,
 	if (tcp_ip4_spec->tos)
 		return -EOPNOTSUPP;
 
+	return 0;
+}
+
+/**
+ * ice_ntuple_l4_proto_to_port - set src and dst port for given L4 protocol
+ * @l4_proto: Layer 4 protocol to program
+ * @src_port: source flow field value for provided l4 protocol
+ * @dst_port: destination flow field value for provided l4 protocol
+ *
+ * Return: 0 on success, negative on error
+ */
+int ice_ntuple_l4_proto_to_port(enum ice_flow_seg_hdr l4_proto,
+				enum ice_flow_field *src_port,
+				enum ice_flow_field *dst_port)
+{
 	if (l4_proto == ICE_FLOW_SEG_HDR_TCP) {
-		src_port = ICE_FLOW_FIELD_IDX_TCP_SRC_PORT;
-		dst_port = ICE_FLOW_FIELD_IDX_TCP_DST_PORT;
+		*src_port = ICE_FLOW_FIELD_IDX_TCP_SRC_PORT;
+		*dst_port = ICE_FLOW_FIELD_IDX_TCP_DST_PORT;
 	} else if (l4_proto == ICE_FLOW_SEG_HDR_UDP) {
-		src_port = ICE_FLOW_FIELD_IDX_UDP_SRC_PORT;
-		dst_port = ICE_FLOW_FIELD_IDX_UDP_DST_PORT;
+		*src_port = ICE_FLOW_FIELD_IDX_UDP_SRC_PORT;
+		*dst_port = ICE_FLOW_FIELD_IDX_UDP_DST_PORT;
 	} else if (l4_proto == ICE_FLOW_SEG_HDR_SCTP) {
-		src_port = ICE_FLOW_FIELD_IDX_SCTP_SRC_PORT;
-		dst_port = ICE_FLOW_FIELD_IDX_SCTP_DST_PORT;
+		*src_port = ICE_FLOW_FIELD_IDX_SCTP_SRC_PORT;
+		*dst_port = ICE_FLOW_FIELD_IDX_SCTP_DST_PORT;
 	} else {
 		return -EOPNOTSUPP;
 	}
 
+	return 0;
+}
+
+/**
+ * ice_set_fdir_ip4_seg - setup flow segment based on IPv4 and L4 proto
+ * @seg: flow segment for programming
+ * @tcp_ip4_spec: mask data from ethtool
+ * @l4_proto: Layer 4 protocol to program
+ * @perfect_fltr: only valid on success; returns true if perfect filter,
+ *		  false if not
+ *
+ * Set the mask data into the flow segment to be used to program HW
+ * table based on provided L4 protocol for IPv4
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_set_fdir_ip4_seg(struct ice_flow_seg_info *seg,
+				struct ethtool_tcpip4_spec *tcp_ip4_spec,
+				enum ice_flow_seg_hdr l4_proto,
+				bool *perfect_fltr)
+{
+	enum ice_flow_field src_port, dst_port;
+	int err;
+
+	err = ice_ntuple_check_ip4_seg(tcp_ip4_spec);
+	if (err)
+		return err;
+
+	err = ice_ntuple_l4_proto_to_port(l4_proto, &src_port, &dst_port);
+	if (err)
+		return err;
+
 	*perfect_fltr = true;
 	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV4 | l4_proto);
 
 	/* IP source address */
-	if (tcp_ip4_spec->ip4src == htonl(0xFFFFFFFF))
+	if (tcp_ip4_spec->ip4src == htonl(ICE_FULL_IPV4_ADDR_MASK))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV4_SA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
@@ -1013,7 +1054,7 @@ ice_set_fdir_ip4_seg(struct ice_flow_seg_info *seg,
 		return -EOPNOTSUPP;
 
 	/* IP destination address */
-	if (tcp_ip4_spec->ip4dst == htonl(0xFFFFFFFF))
+	if (tcp_ip4_spec->ip4dst == htonl(ICE_FULL_IPV4_ADDR_MASK))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV4_DA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
@@ -1023,7 +1064,7 @@ ice_set_fdir_ip4_seg(struct ice_flow_seg_info *seg,
 		return -EOPNOTSUPP;
 
 	/* Layer 4 source port */
-	if (tcp_ip4_spec->psrc == htons(0xFFFF))
+	if (tcp_ip4_spec->psrc == htons(ICE_FULL_PORT_MASK))
 		ice_flow_set_fld(seg, src_port, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 false);
@@ -1033,7 +1074,7 @@ ice_set_fdir_ip4_seg(struct ice_flow_seg_info *seg,
 		return -EOPNOTSUPP;
 
 	/* Layer 4 destination port */
-	if (tcp_ip4_spec->pdst == htons(0xFFFF))
+	if (tcp_ip4_spec->pdst == htons(ICE_FULL_PORT_MASK))
 		ice_flow_set_fld(seg, dst_port, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 false);
@@ -1046,19 +1087,12 @@ ice_set_fdir_ip4_seg(struct ice_flow_seg_info *seg,
 }
 
 /**
- * ice_set_fdir_ip4_usr_seg
- * @seg: flow segment for programming
+ * ice_ntuple_check_ip4_usr_seg - Check valid fields are provided for filter
  * @usr_ip4_spec: ethtool userdef packet offset
- * @perfect_fltr: only valid on success; returns true if perfect filter,
- *		  false if not
  *
- * Set the offset data into the flow segment to be used to program HW
- * table for IPv4
+ * Return: 0 if fields valid, negative otherwise
  */
-static int
-ice_set_fdir_ip4_usr_seg(struct ice_flow_seg_info *seg,
-			 struct ethtool_usrip4_spec *usr_ip4_spec,
-			 bool *perfect_fltr)
+int ice_ntuple_check_ip4_usr_seg(struct ethtool_usrip4_spec *usr_ip4_spec)
 {
 	/* first 4 bytes of Layer 4 header */
 	if (usr_ip4_spec->l4_4_bytes)
@@ -1074,11 +1108,36 @@ ice_set_fdir_ip4_usr_seg(struct ice_flow_seg_info *seg,
 	if (!usr_ip4_spec->ip4src && !usr_ip4_spec->ip4dst)
 		return -EINVAL;
 
+	return 0;
+}
+
+/**
+ * ice_set_fdir_ip4_usr_seg - setup flow segment based on IPv4
+ * @seg: flow segment for programming
+ * @usr_ip4_spec: ethtool userdef packet offset
+ * @perfect_fltr: only set on success; returns true if perfect filter, false if
+ *		  not
+ *
+ * Set the offset data into the flow segment to be used to program HW
+ * table for IPv4
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_set_fdir_ip4_usr_seg(struct ice_flow_seg_info *seg,
+				    struct ethtool_usrip4_spec *usr_ip4_spec,
+				    bool *perfect_fltr)
+{
+	int err;
+
+	err = ice_ntuple_check_ip4_usr_seg(usr_ip4_spec);
+	if (err)
+		return err;
+
 	*perfect_fltr = true;
 	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV4);
 
 	/* IP source address */
-	if (usr_ip4_spec->ip4src == htonl(0xFFFFFFFF))
+	if (usr_ip4_spec->ip4src == htonl(ICE_FULL_IPV4_ADDR_MASK))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV4_SA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
@@ -1088,7 +1147,7 @@ ice_set_fdir_ip4_usr_seg(struct ice_flow_seg_info *seg,
 		return -EOPNOTSUPP;
 
 	/* IP destination address */
-	if (usr_ip4_spec->ip4dst == htonl(0xFFFFFFFF))
+	if (usr_ip4_spec->ip4dst == htonl(ICE_FULL_IPV4_ADDR_MASK))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV4_DA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
@@ -1101,23 +1160,13 @@ ice_set_fdir_ip4_usr_seg(struct ice_flow_seg_info *seg,
 }
 
 /**
- * ice_set_fdir_ip6_seg
- * @seg: flow segment for programming
+ * ice_ntuple_check_ip6_seg - Check valid fields are provided for filter
  * @tcp_ip6_spec: mask data from ethtool
- * @l4_proto: Layer 4 protocol to program
- * @perfect_fltr: only valid on success; returns true if perfect filter,
- *		  false if not
  *
- * Set the mask data into the flow segment to be used to program HW
- * table based on provided L4 protocol for IPv6
+ * Return: 0 if fields valid, negative otherwise
  */
-static int
-ice_set_fdir_ip6_seg(struct ice_flow_seg_info *seg,
-		     struct ethtool_tcpip6_spec *tcp_ip6_spec,
-		     enum ice_flow_seg_hdr l4_proto, bool *perfect_fltr)
+static int ice_ntuple_check_ip6_seg(struct ethtool_tcpip6_spec *tcp_ip6_spec)
 {
-	enum ice_flow_field src_port, dst_port;
-
 	/* make sure we don't have any empty rule */
 	if (!memcmp(tcp_ip6_spec->ip6src, &zero_ipv6_addr_mask,
 		    sizeof(struct in6_addr)) &&
@@ -1130,18 +1179,37 @@ ice_set_fdir_ip6_seg(struct ice_flow_seg_info *seg,
 	if (tcp_ip6_spec->tclass)
 		return -EOPNOTSUPP;
 
-	if (l4_proto == ICE_FLOW_SEG_HDR_TCP) {
-		src_port = ICE_FLOW_FIELD_IDX_TCP_SRC_PORT;
-		dst_port = ICE_FLOW_FIELD_IDX_TCP_DST_PORT;
-	} else if (l4_proto == ICE_FLOW_SEG_HDR_UDP) {
-		src_port = ICE_FLOW_FIELD_IDX_UDP_SRC_PORT;
-		dst_port = ICE_FLOW_FIELD_IDX_UDP_DST_PORT;
-	} else if (l4_proto == ICE_FLOW_SEG_HDR_SCTP) {
-		src_port = ICE_FLOW_FIELD_IDX_SCTP_SRC_PORT;
-		dst_port = ICE_FLOW_FIELD_IDX_SCTP_DST_PORT;
-	} else {
-		return -EINVAL;
-	}
+	return 0;
+}
+
+/**
+ * ice_set_fdir_ip6_seg - setup flow segment based on IPv6 and L4 proto
+ * @seg: flow segment for programming
+ * @tcp_ip6_spec: mask data from ethtool
+ * @l4_proto: Layer 4 protocol to program
+ * @perfect_fltr: only valid on success; returns true if perfect filter,
+ *		  false if not
+ *
+ * Set the mask data into the flow segment to be used to program HW
+ * table based on provided L4 protocol for IPv6
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_set_fdir_ip6_seg(struct ice_flow_seg_info *seg,
+				struct ethtool_tcpip6_spec *tcp_ip6_spec,
+				enum ice_flow_seg_hdr l4_proto,
+				bool *perfect_fltr)
+{
+	enum ice_flow_field src_port, dst_port;
+	int err;
+
+	err = ice_ntuple_check_ip6_seg(tcp_ip6_spec);
+	if (err)
+		return err;
+
+	err = ice_ntuple_l4_proto_to_port(l4_proto, &src_port, &dst_port);
+	if (err)
+		return err;
 
 	*perfect_fltr = true;
 	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV6 | l4_proto);
@@ -1169,7 +1237,7 @@ ice_set_fdir_ip6_seg(struct ice_flow_seg_info *seg,
 		return -EOPNOTSUPP;
 
 	/* Layer 4 source port */
-	if (tcp_ip6_spec->psrc == htons(0xFFFF))
+	if (tcp_ip6_spec->psrc == htons(ICE_FULL_PORT_MASK))
 		ice_flow_set_fld(seg, src_port, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 false);
@@ -1179,7 +1247,7 @@ ice_set_fdir_ip6_seg(struct ice_flow_seg_info *seg,
 		return -EOPNOTSUPP;
 
 	/* Layer 4 destination port */
-	if (tcp_ip6_spec->pdst == htons(0xFFFF))
+	if (tcp_ip6_spec->pdst == htons(ICE_FULL_PORT_MASK))
 		ice_flow_set_fld(seg, dst_port, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 false);
@@ -1192,19 +1260,13 @@ ice_set_fdir_ip6_seg(struct ice_flow_seg_info *seg,
 }
 
 /**
- * ice_set_fdir_ip6_usr_seg
- * @seg: flow segment for programming
+ * ice_ntuple_check_ip6_usr_seg - Check valid fields are provided for filter
  * @usr_ip6_spec: ethtool userdef packet offset
- * @perfect_fltr: only valid on success; returns true if perfect filter,
- *		  false if not
  *
- * Set the offset data into the flow segment to be used to program HW
- * table for IPv6
+ * Return: 0 if fields valid, negative otherwise
  */
 static int
-ice_set_fdir_ip6_usr_seg(struct ice_flow_seg_info *seg,
-			 struct ethtool_usrip6_spec *usr_ip6_spec,
-			 bool *perfect_fltr)
+ice_ntuple_check_ip6_usr_seg(struct ethtool_usrip6_spec *usr_ip6_spec)
 {
 	/* filtering on Layer 4 bytes not supported */
 	if (usr_ip6_spec->l4_4_bytes)
@@ -1222,6 +1284,31 @@ ice_set_fdir_ip6_usr_seg(struct ice_flow_seg_info *seg,
 		    sizeof(struct in6_addr)))
 		return -EINVAL;
 
+	return 0;
+}
+
+/**
+ * ice_set_fdir_ip6_usr_seg - setup flow segment based on IPv6
+ * @seg: flow segment for programming
+ * @usr_ip6_spec: ethtool userdef packet offset
+ * @perfect_fltr: only set on success; returns true if perfect filter, false if
+ *		  not
+ *
+ * Set the offset data into the flow segment to be used to program HW
+ * table for IPv6
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_set_fdir_ip6_usr_seg(struct ice_flow_seg_info *seg,
+				    struct ethtool_usrip6_spec *usr_ip6_spec,
+				    bool *perfect_fltr)
+{
+	int err;
+
+	err = ice_ntuple_check_ip6_usr_seg(usr_ip6_spec);
+	if (err)
+		return err;
+
 	*perfect_fltr = true;
 	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV6);
 
@@ -1836,6 +1923,60 @@ int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	return val;
 }
 
+/**
+ * ice_is_acl_filter - Check if it's a FD or ACL filter
+ * @fsp: pointer to ethtool Rx flow specification
+ *
+ * If any field of the provided filter is using a partial mask then this is
+ * an ACL filter.
+ *
+ * Return: true if ACL filter, false otherwise
+ */
+static bool ice_is_acl_filter(struct ethtool_rx_flow_spec *fsp)
+{
+	struct ethtool_tcpip4_spec *tcp_ip4_spec;
+	struct ethtool_usrip4_spec *usr_ip4_spec;
+
+	switch (fsp->flow_type & ~FLOW_EXT) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+		tcp_ip4_spec = &fsp->m_u.tcp_ip4_spec;
+
+		if (tcp_ip4_spec->ip4src &&
+		    tcp_ip4_spec->ip4src != htonl(ICE_FULL_IPV4_ADDR_MASK))
+			return true;
+
+		if (tcp_ip4_spec->ip4dst &&
+		    tcp_ip4_spec->ip4dst != htonl(ICE_FULL_IPV4_ADDR_MASK))
+			return true;
+
+		if (tcp_ip4_spec->psrc &&
+		    tcp_ip4_spec->psrc != htons(ICE_FULL_PORT_MASK))
+			return true;
+
+		if (tcp_ip4_spec->pdst &&
+		    tcp_ip4_spec->pdst != htons(ICE_FULL_PORT_MASK))
+			return true;
+
+		break;
+	case IPV4_USER_FLOW:
+		usr_ip4_spec = &fsp->m_u.usr_ip4_spec;
+
+		if (usr_ip4_spec->ip4src &&
+		    usr_ip4_spec->ip4src != htonl(ICE_FULL_IPV4_ADDR_MASK))
+			return true;
+
+		if (usr_ip4_spec->ip4dst &&
+		    usr_ip4_spec->ip4dst != htonl(ICE_FULL_IPV4_ADDR_MASK))
+			return true;
+
+		break;
+	}
+
+	return false;
+}
+
 /**
  * ice_update_ring_dest_vsi - update dest ring and dest VSI
  * @vsi: pointer to target VSI
@@ -2053,7 +2194,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 
 	/* Do not program filters during reset */
 	if (ice_is_reset_in_progress(pf->state)) {
-		dev_err(dev, "Device is resetting - adding Flow Director filters not supported during reset\n");
+		dev_err(dev, "Device is resetting - adding ntuple filters not supported during reset\n");
 		return -EBUSY;
 	}
 
@@ -2065,10 +2206,6 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	if (fsp->flow_type & FLOW_MAC_EXT)
 		return -EINVAL;
 
-	ret = ice_cfg_fdir_xtrct_seq(pf, fsp, &userdata);
-	if (ret)
-		return ret;
-
 	max_location = ice_ntuple_get_max_fltr_cnt(hw);
 	if (fsp->location >= max_location) {
 		dev_err(dev, "Failed to add filter. The number of ntuple filters or provided location exceed max %d.\n",
@@ -2076,6 +2213,14 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -ENOSPC;
 	}
 
+	/* ACL filter */
+	if (pf->hw.acl_tbl && ice_is_acl_filter(fsp))
+		return ice_acl_add_rule_ethtool(vsi, cmd);
+
+	ret = ice_cfg_fdir_xtrct_seq(pf, fsp, &userdata);
+	if (ret)
+		return ret;
+
 	/* return error if not an update and no available filters */
 	fltrs_needed = ice_get_open_tunnel_port(hw, &tunnel_port, TNL_ALL) ? 2 : 1;
 	if (!ice_fdir_find_fltr_by_idx(hw, fsp->location) &&
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index bb1d12f952cf..d255ffcd5c86 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1259,6 +1259,9 @@ ice_find_prof_id_with_mask(struct ice_hw *hw, enum ice_block blk,
 static bool ice_prof_id_rsrc_type(enum ice_block blk, u16 *rsrc_type)
 {
 	switch (blk) {
+	case ICE_BLK_ACL:
+		*rsrc_type = ICE_AQC_RES_TYPE_ACL_PROF_BLDR_PROFID;
+		break;
 	case ICE_BLK_FD:
 		*rsrc_type = ICE_AQC_RES_TYPE_FD_PROF_BLDR_PROFID;
 		break;
@@ -1279,6 +1282,9 @@ static bool ice_prof_id_rsrc_type(enum ice_block blk, u16 *rsrc_type)
 static bool ice_tcam_ent_rsrc_type(enum ice_block blk, u16 *rsrc_type)
 {
 	switch (blk) {
+	case ICE_BLK_ACL:
+		*rsrc_type = ICE_AQC_RES_TYPE_ACL_PROF_BLDR_TCAM;
+		break;
 	case ICE_BLK_FD:
 		*rsrc_type = ICE_AQC_RES_TYPE_FD_PROF_BLDR_TCAM;
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 121552c644cd..855d296aeed8 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -3,6 +3,7 @@
 
 #include "ice_common.h"
 #include "ice_flow.h"
+#include "ice_acl.h"
 #include <net/gre.h>
 
 /* Size of known protocol header fields */
@@ -989,6 +990,43 @@ static int ice_flow_proc_seg_hdrs(struct ice_flow_prof_params *params)
 	return 0;
 }
 
+/**
+ * ice_flow_xtract_pkt_flags - Create an extr sequence entry for packet flags
+ * @hw: pointer to the HW struct
+ * @params: information about the flow to be processed
+ * @flags: The value of pkt_flags[x:x] in Rx/Tx MDID metadata.
+ *
+ * Allocate an extraction sequence entries for a DWORD size chunk of the packet
+ * flags.
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_flow_xtract_pkt_flags(struct ice_hw *hw,
+				     struct ice_flow_prof_params *params,
+				     enum ice_flex_mdid_pkt_flags flags)
+{
+	u8 fv_words = hw->blk[params->blk].es.fvw;
+	u8 idx;
+
+	/* Make sure the number of extraction sequence entries required does not
+	 * exceed the block's capacity.
+	 */
+	if (params->es_cnt >= fv_words)
+		return -ENOSPC;
+
+	/* some blocks require a reversed field vector layout */
+	if (hw->blk[params->blk].es.reverse)
+		idx = fv_words - params->es_cnt - 1;
+	else
+		idx = params->es_cnt;
+
+	params->es[idx].prot_id = ICE_PROT_META_ID;
+	params->es[idx].off = flags;
+	params->es_cnt++;
+
+	return 0;
+}
+
 /**
  * ice_flow_xtract_fld - Create an extraction sequence entry for the given field
  * @hw: pointer to the HW struct
@@ -1287,6 +1325,16 @@ ice_flow_create_xtrct_seq(struct ice_hw *hw,
 	int status = 0;
 	u8 i;
 
+	/* For ACL, we also need to extract the direction bit (Rx,Tx) data from
+	 * packet flags
+	 */
+	if (params->blk == ICE_BLK_ACL) {
+		status = ice_flow_xtract_pkt_flags(hw, params,
+						   ICE_RX_MDID_PKT_FLAGS_15_0);
+		if (status)
+			return status;
+	}
+
 	for (i = 0; i < prof->segs_cnt; i++) {
 		u64 match = params->prof->segs[i].match;
 		enum ice_flow_field j;
@@ -1308,6 +1356,123 @@ ice_flow_create_xtrct_seq(struct ice_hw *hw,
 	return status;
 }
 
+/**
+ * ice_flow_sel_acl_scen - return specific scenario
+ * @hw: pointer to the hardware structure
+ * @params: information about the flow to be processed
+ *
+ * Return (through @params) the specific scenario based on params.
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_flow_sel_acl_scen(struct ice_hw *hw,
+				 struct ice_flow_prof_params *params)
+{
+	/* Find the best-fit scenario for the provided match width */
+	struct ice_acl_scen *cand_scen = NULL, *scen;
+
+	if (!hw->acl_tbl)
+		return -ENOENT;
+
+	/* Loop through each scenario and match against the scenario width
+	 * to select the specific scenario
+	 */
+	list_for_each_entry(scen, &hw->acl_tbl->scens, list_entry)
+		if (scen->eff_width >= params->entry_length &&
+		    (!cand_scen || cand_scen->eff_width > scen->eff_width))
+			cand_scen = scen;
+	if (!cand_scen)
+		return -ENOENT;
+
+	params->prof->cfg.scen = cand_scen;
+
+	return 0;
+}
+
+/**
+ * ice_flow_acl_def_entry_frmt - Determine the layout of flow entries
+ * @params: information about the flow to be processed
+ *
+ * Return: 0 on success, negative on error
+ */
+static int
+ice_flow_acl_def_entry_frmt(struct ice_flow_prof_params *params)
+{
+	u16 index, range_idx = 0;
+
+	index = ICE_AQC_ACL_PROF_BYTE_SEL_START_IDX;
+
+	for (int i = 0; i < params->prof->segs_cnt; i++) {
+		struct ice_flow_seg_info *seg = &params->prof->segs[i];
+		unsigned long match = seg->match;
+		int j;
+
+		for_each_set_bit(j, &match, ICE_FLOW_FIELD_IDX_MAX) {
+			struct ice_flow_fld_info *fld = &seg->fields[j];
+
+			fld->entry.mask = ICE_FLOW_FLD_OFF_INVAL;
+
+			if (fld->type == ICE_FLOW_FLD_TYPE_RANGE) {
+				fld->entry.last = ICE_FLOW_FLD_OFF_INVAL;
+
+				/* Range checking only supported for single
+				 * words
+				 */
+				if (DIV_ROUND_UP(ice_flds_info[j].size +
+						 fld->xtrct.disp,
+						 BITS_PER_BYTE * 2) > 1)
+					return -EINVAL;
+
+				/* Ranges must define low and high values */
+				if (fld->src.val == ICE_FLOW_FLD_OFF_INVAL ||
+				    fld->src.last == ICE_FLOW_FLD_OFF_INVAL)
+					return -EINVAL;
+
+				fld->entry.val = range_idx++;
+			} else {
+				/* Store adjusted byte-length of field for later
+				 * use, taking into account potential
+				 * non-byte-aligned displacement
+				 */
+				fld->entry.last =
+					DIV_ROUND_UP(ice_flds_info[j].size +
+						     (fld->xtrct.disp %
+						      BITS_PER_BYTE),
+						     BITS_PER_BYTE);
+				fld->entry.val = index;
+				index += fld->entry.last;
+			}
+		}
+
+		for (j = 0; j < seg->raws_cnt; j++) {
+			struct ice_flow_seg_fld_raw *raw = &seg->raws[j];
+
+			raw->info.entry.mask = ICE_FLOW_FLD_OFF_INVAL;
+			raw->info.entry.val = index;
+			raw->info.entry.last = raw->info.src.last;
+			index += raw->info.entry.last;
+		}
+	}
+
+	/* Currently only support using the byte selection base, which only
+	 * allows for an effective entry size of 30 bytes. Reject anything
+	 * larger.
+	 */
+	if (index > ICE_AQC_ACL_PROF_BYTE_SEL_ELEMS)
+		return -EINVAL;
+
+	/* Only 8 range checkers per profile, reject anything trying to use
+	 * more
+	 */
+	if (range_idx > ICE_AQC_ACL_PROF_RANGES_NUM_CFG)
+		return -EINVAL;
+
+	/* Store # bytes required for entry for later use */
+	params->entry_length = index - ICE_AQC_ACL_PROF_BYTE_SEL_START_IDX;
+
+	return 0;
+}
+
 /**
  * ice_flow_proc_segs - process all packet segments associated with a profile
  * @hw: pointer to the HW struct
@@ -1331,6 +1496,14 @@ ice_flow_proc_segs(struct ice_hw *hw, struct ice_flow_prof_params *params)
 	case ICE_BLK_RSS:
 		status = 0;
 		break;
+	case ICE_BLK_ACL:
+		status = ice_flow_acl_def_entry_frmt(params);
+		if (status)
+			return status;
+		status = ice_flow_sel_acl_scen(hw, params);
+		if (status)
+			return status;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index b9b42592b84a..7357088091bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -504,6 +504,23 @@ struct ice_rss_cfg {
 	struct ice_rss_hash_cfg hash;
 };
 
+enum ice_flow_action_type {
+	ICE_FLOW_ACT_NOP,
+	ICE_FLOW_ACT_DROP,
+	ICE_FLOW_ACT_CNTR_PKT,
+	ICE_FLOW_ACT_FWD_QUEUE,
+	ICE_FLOW_ACT_CNTR_BYTES,
+	ICE_FLOW_ACT_CNTR_PKT_BYTES,
+};
+
+struct ice_flow_action {
+	enum ice_flow_action_type type;
+	union {
+		struct ice_acl_act_entry acl_act;
+		u32 dummy;
+	} data;
+};
+
 int
 ice_flow_add_prof(struct ice_hw *hw, enum ice_block blk, enum ice_flow_dir dir,
 		  struct ice_flow_seg_info *segs, u8 segs_cnt,
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a957ac023e6c..39a184a81115 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4330,19 +4330,25 @@ static int ice_send_version(struct ice_pf *pf)
 }
 
 /**
- * ice_init_acl - Initializes the ACL block
+ * ice_init_acl - initialize the ACL block and allocate necessary structs
  * @pf: ptr to PF device
  *
  * Return: 0 on success, negative on error
  */
 static int ice_init_acl(struct ice_pf *pf)
 {
+	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_acl_tbl_params params = {};
 	struct ice_hw *hw = &pf->hw;
 	int divider;
 	u16 scen_id;
 	int err;
 
+	hw->acl_prof = devm_kcalloc(dev, ICE_FLTR_PTYPE_MAX,
+				    sizeof(*hw->acl_prof), GFP_KERNEL);
+	if (!hw->acl_prof)
+		return -ENOMEM;
+
 	/* Creates a single ACL table that consist of src_ip(4 byte),
 	 * dest_ip(4 byte), src_port(2 byte) and dst_port(2 byte) for a total
 	 * of 12 bytes (96 bits), hence 120 bit wide keys, i.e. 3 TCAM slices.
@@ -4362,7 +4368,7 @@ static int ice_init_acl(struct ice_pf *pf)
 
 	err = ice_acl_create_tbl(hw, &params);
 	if (err)
-		return err;
+		goto free_prof;
 
 	err = ice_acl_create_scen(hw, params.width, params.depth, &scen_id);
 	if (err)
@@ -4372,17 +4378,39 @@ static int ice_init_acl(struct ice_pf *pf)
 
 destroy_table:
 	ice_acl_destroy_tbl(hw);
+free_prof:
+	devm_kfree(dev, hw->acl_prof);
+	hw->acl_prof = NULL;
 
 	return err;
 }
 
 /**
- * ice_deinit_acl - Unroll the initialization of the ACL block
+ * ice_deinit_acl - unroll the initialization of the ACL block
  * @pf: ptr to PF device
  */
 static void ice_deinit_acl(struct ice_pf *pf)
 {
-	ice_acl_destroy_tbl(&pf->hw);
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
+
+	ice_acl_destroy_tbl(hw);
+
+	if (!hw->acl_prof)
+		return;
+
+	for (int i = 0; i < ICE_FLTR_PTYPE_MAX; i++) {
+		struct ice_acl_hw_prof *hw_prof = hw->acl_prof[i];
+
+		if (!hw_prof)
+			continue;
+
+		kfree(hw_prof->seg);
+		kfree(hw_prof);
+	}
+
+	devm_kfree(dev, hw->acl_prof);
+	hw->acl_prof = NULL;
 }
 
 /**
-- 
2.47.1


