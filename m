Return-Path: <netdev+bounces-305243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id omxUFv46TGoAiAEAu9opvQ
	(envelope-from <netdev+bounces-305243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:32:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD981716518
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:32:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="lQO+/6XF";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305243-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305243-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E407B303280A
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 23:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B9B39A046;
	Mon,  6 Jul 2026 23:32:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A53242D4
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 23:32:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783380728; cv=none; b=DTkTTp/HxLTrJX4Q4K/ZDx+zy3mk7Vw/EiQVbNkJ1UGCMgvQGMU2KD1o/KO9XqJf0eBXcS12NFvgvFyY4sebS5Uj9yyaF8+p0I7ZLLjAOjbRvrTndiz5Tq4BmVXZnFSW/4whkL9zN6VNmBklqnYKgOehSiN8/A+V1kPoauiD1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783380728; c=relaxed/simple;
	bh=/bh8lpYnml96QzvIHIyqPoi635IHHu05+b27moIaExE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f0YLpnF6bMWyeGqGLEEoVzDT+dTyGOI8iv/flvcBryFQkkkBdqJKfsyGk7k+7ZRlXK10XXAPiKQIM7A7nq0n22LT4+bYtJqcjGKZcVXM/mnUEA6QmlgQu7sKlwp/ACupbvu3EsKdovA5BOqtGqdJu1n/qsPahmwdVMWsRaDkbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQO+/6XF; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783380726; x=1814916726;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=/bh8lpYnml96QzvIHIyqPoi635IHHu05+b27moIaExE=;
  b=lQO+/6XFfNXcrELb3ZRnvYKUF3omIz130VWYkoENWQQNVZ3lBKf3IAOs
   LPPC2ptLzvYWp9GctwgK/gFRB92LeZYBzUXwOkH6InU7pDXCrNq7/cXT3
   s3h+Q+5Jc/1+0wnSCBpVZpIHC7lDCbq+FEATb3u+oTXcMVosPhtASH+a+
   9Reo5+6JYBOT/apJ854M6veFFc9uho9pHu+eZ6ECiXPFFwuBRW4qu9kFj
   eOSDp9VHddqo2WZz/y9Ru6f53ImlPLPrNhbnKj0U6FUUwdUC9mZtfZj21
   EJJox+Jxnp1GdqEHgiYFXZc9T/GVtyc59aXgs5WPAokYJdaNbb75t97cG
   A==;
X-CSE-ConnectionGUID: 3LS7HwgWR1eLBLdUAHostQ==
X-CSE-MsgGUID: AHXEMF8KTm+0OEhTlrMoYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83131475"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83131475"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 16:32:06 -0700
X-CSE-ConnectionGUID: +hC8/FiFSDuJn8kAbwqaTw==
X-CSE-MsgGUID: vGYFV6DHRZK5V+bIq1p46g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="257417221"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 16:32:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 06 Jul 2026 16:31:17 -0700
Subject: [PATCH iwl-net v2] ice: add missing xa_destroy for sched_node_ids
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-jk-fix-missing-xa-destroy-v2-1-b83b0f02beef@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OSw6CMBCGr0Jm7RjagkRX3sOw4DHAILSmrQgh3
 N2CF3D55X+u4MgyObhFK1ia2LHRAeQpgqordEvIdWCQsbzEqUiwf2LDM47sHOsW5wJrct6aBWv
 VXONGZUKUBCH/shScR/cD+DOgJg/5T3DvsqfK7827tWPnjV2OF5M4An8MTgJFgERlZZNKlWR31
 p6Gc2VGyLdt+wKYFCdf3QAAAA==
X-Change-ID: 20260514-jk-fix-missing-xa-destroy-d3f90f3711be
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-b9e00
X-Developer-Signature: v=1; a=openpgp-sha256; l=5381;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=/bh8lpYnml96QzvIHIyqPoi635IHHu05+b27moIaExE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhiwfq3cbZU3e1ta4bq1v1O9dsV5t1cWVl8U/KFY+9Fm0S
 EJOStO1o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlc+MLIMP/+hInno7cc7f4/
 cd+y9ODDMRpz69YJRiyZMVmDr/hVWhAjw/eGa7Z3uSPiQxPl78879vR0ufcnGTs9w8n5c9pKeGU
 YOAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:jacob.e.keller@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305243-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD981716518

Commit 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
added a sched_node_ids xarray to the port info structure, but never called
xa_destroy on it.

Since xarrays can allocate internal memory, this can result in a memory
leak even if every element in the xarray has been removed.

The xarray is currently embedded in the port_info structure. This appears
to have been done because its use is within functions that take the
port_info as a primary argument.

However, this complicates managing the lifecycle of the field. The
port_info structure is allocated in ice_init_hw() using devm, and it is
not released until the devm cleanup when the driver is unloaded.

The ice_init_hw() function is called in many places, including devlink
reload, and possibly during DDP load after updating the Tx scheduler
layout.

Adding a call of xa_destroy to the ice_deinit_hw() causes Sashiko to raise
multiple concerns due to potential ordering issues and possible ways that
port_info could be a dangling reference.

To handle this, move the sched_node_ids out of port_info and into the hw
structure. All users of the array already have a pointer to hw anyways, and
there is only one sched_node_ids per adapter. While here, remove the overly
verbose comment explaining the nature of the sched_node_ids xarray.

Add the missing xa_destroy to the cleanup path and to ice_deinit_hw(),
ensuring that we properly release the xarray memory.

This was caught by Sashiko during development of unrelated code.

Fixes: 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Move sched_node_ids out of port_into into hw.
- Link to v1: https://patch.msgid.link/20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com
---
 drivers/net/ethernet/intel/ice/ice_type.h   | 2 +-
 drivers/net/ethernet/intel/ice/ice_common.c | 9 ++++++---
 drivers/net/ethernet/intel/ice/ice_sched.c  | 4 ++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index d9a5c1aae7c2..cf147a212707 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -765,7 +765,6 @@ struct ice_port_info {
 	/* List contain profile ID(s) and other params per layer */
 	struct list_head rl_prof_list[ICE_AQC_TOPO_MAX_LEVEL_NUM];
 	struct ice_qos_cfg qos_cfg;
-	struct xarray sched_node_ids;
 	u8 is_vf:1;
 	u8 is_custom_tx_enabled:1;
 };
@@ -930,6 +929,7 @@ struct ice_hw {
 	u8 sw_entry_point_layer;
 	u16 max_children[ICE_AQC_TOPO_MAX_LEVEL_NUM];
 	struct list_head agg_list;	/* lists all aggregator */
+	struct xarray sched_node_ids;
 
 	struct ice_vsi_ctx *vsi_ctx[ICE_MAX_VSI];
 	u8 evb_veb;		/* true for VEB, false for VEPA */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ef1ce106f81b..04633103e3e6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1051,14 +1051,13 @@ int ice_init_hw(struct ice_hw *hw)
 
 	hw->evb_veb = true;
 
-	/* init xarray for identifying scheduling nodes uniquely */
-	xa_init_flags(&hw->port_info->sched_node_ids, XA_FLAGS_ALLOC);
+	xa_init_flags(&hw->sched_node_ids, XA_FLAGS_ALLOC);
 
 	/* Query the allocated resources for Tx scheduler */
 	status = ice_sched_query_res_alloc(hw);
 	if (status) {
 		ice_debug(hw, ICE_DBG_SCHED, "Failed to get scheduler allocated resources\n");
-		goto err_unroll_alloc;
+		goto err_unroll_xarray;
 	}
 	ice_sched_get_psm_clk_freq(hw);
 
@@ -1146,6 +1145,8 @@ int ice_init_hw(struct ice_hw *hw)
 	ice_cleanup_fltr_mgmt_struct(hw);
 err_unroll_sched:
 	ice_sched_cleanup_all(hw);
+err_unroll_xarray:
+	xa_destroy(&hw->sched_node_ids);
 err_unroll_alloc:
 	devm_kfree(ice_hw_to_dev(hw), hw->port_info);
 err_unroll_cqinit:
@@ -1186,6 +1187,8 @@ void ice_deinit_hw(struct ice_hw *hw)
 
 	/* Clear VSI contexts if not already cleared */
 	ice_clear_all_vsi_ctx(hw);
+
+	xa_destroy(&hw->sched_node_ids);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index fff0c1afdb41..ffa18d86729a 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -371,7 +371,7 @@ void ice_free_sched_node(struct ice_port_info *pi, struct ice_sched_node *node)
 
 	devm_kfree(ice_hw_to_dev(hw), node->children);
 	kfree(node->name);
-	xa_erase(&pi->sched_node_ids, node->id);
+	xa_erase(&hw->sched_node_ids, node->id);
 	devm_kfree(ice_hw_to_dev(hw), node);
 }
 
@@ -977,7 +977,7 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 		if (!new_node->name)
 			return -ENOMEM;
 
-		status = xa_alloc(&pi->sched_node_ids, &new_node->id, NULL, XA_LIMIT(0, UINT_MAX),
+		status = xa_alloc(&hw->sched_node_ids, &new_node->id, NULL, XA_LIMIT(0, UINT_MAX),
 				  GFP_KERNEL);
 		if (status) {
 			ice_debug(hw, ICE_DBG_SCHED, "xa_alloc failed for sched node status =%d\n",

---
base-commit: 9e05e91a9a847ed57926414bd7c2c5e54d6c56c6
change-id: 20260514-jk-fix-missing-xa-destroy-d3f90f3711be

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


