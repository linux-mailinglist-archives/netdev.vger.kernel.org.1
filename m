Return-Path: <netdev+bounces-213867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49027B272C5
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A1B1BC8B1F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC82857F0;
	Thu, 14 Aug 2025 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMXU4Wau"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C42882A1
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212950; cv=none; b=F0kAOUqRF1QXKO2euY3Q+/E4/Dt7VnUd1NdNblHoaXrgSUIFoSbkHPTMoNpKnmQGTyhnbxhHiF3i3RoDo2dusKb6Ps244glYzfEBLS4Z0ukmG3aCThhseFFye6v+deKmYaoB3TJ1Qec0ClIONQ67ggFEcPSpa1S0ZMUaPXRw06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212950; c=relaxed/simple;
	bh=ksyfNLWv3cIMMHxd26+g8lm2njtrNuLd2dClA6OoKZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDSGgUe++CSRts/DnVEMvdGgGvBNXd4y2eE4l+rOwjDG0/XPGAsGy0cLUR//dT1t9OzkV0V/bwYatNTlcZVCGVEM8xbI0i9i3TkYpq+2+P4c7OSwVLGkRMX+ONfw5wQumuYF0DHM8WZ85yxWbcdBFr0nd/rjsZrQNbtp4nWWQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMXU4Wau; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755212948; x=1786748948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ksyfNLWv3cIMMHxd26+g8lm2njtrNuLd2dClA6OoKZU=;
  b=KMXU4Wauk0j+9jej1nFnUPeXGyPHmvv3+SYdNmsC4DiaseP8LgHzQ51V
   RievCB+ndviRdBqj15t2s8DnoNxSBQ0OAmrhHHHw6BbbYAXN6f+O3CC3q
   l5BOTTo0jkf4vzAX0xBCJypcoL9i+/9sEebOozFrpOu5br7EskfuazjBu
   +643L+QJzM/iSd8xJ/r/RGOmSoxMsFdNTIby/4HUi+OwEyG+k7E/ph3U5
   4mcg0pUb+Z1e4CzBCCV+ru0E4skdRg2jBCv4wt5uyZTx9m0Oax5XktnM8
   +NalCJRY2nuI4xjQto4BNEhg7zTB3rt/d66dba+WT9rBUluSr2WQKxrrW
   A==;
X-CSE-ConnectionGUID: 4PtuhSKuQPWl4dmsBDOPNg==
X-CSE-MsgGUID: 9PoSftDhTzu8IWcTkjv9pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="45117985"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="45117985"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:04 -0700
X-CSE-ConnectionGUID: RB6QOHFEQIibARfh2lT1LA==
X-CSE-MsgGUID: tK9vC6e2SiqEopN03aT6YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166848139"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2025 16:09:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 5/7] ice: Cleanup variable initialization in LAG code
Date: Thu, 14 Aug 2025 16:08:52 -0700
Message-ID: <20250814230855.128068-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
References: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

In preparation for implementing SRIOV Active-Active LAG support,
cleanup several unneeded variable initializations in declaration
blocks.

Also move a couple of variable initializations into declaration
block that should be there.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 54 ++++++++----------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 1f76536e6176..72284555b98a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -234,13 +234,12 @@ ice_lag_cfg_fltr(struct ice_lag *lag, u32 act, u16 recipe_id, u16 *rule_idx,
 		 u8 direction, bool add)
 {
 	struct ice_sw_rule_lkup_rx_tx *s_rule;
+	struct ice_hw *hw = &lag->pf->hw;
 	u16 s_rule_sz, vsi_num;
-	struct ice_hw *hw;
 	u8 *eth_hdr;
 	u32 opc;
 	int err;
 
-	hw = &lag->pf->hw;
 	vsi_num = ice_get_hw_vsi_num(hw, 0);
 
 	s_rule_sz = ICE_SW_RULE_RX_TX_ETH_HDR_SIZE(s_rule);
@@ -384,12 +383,10 @@ ice_lag_cfg_pf_fltrs(struct ice_lag *lag, void *ptr)
 static void
 ice_lag_cfg_cp_fltr(struct ice_lag *lag, bool add)
 {
-	struct ice_sw_rule_lkup_rx_tx *s_rule = NULL;
-	struct ice_vsi *vsi;
+	struct ice_sw_rule_lkup_rx_tx *s_rule;
+	struct ice_vsi *vsi = lag->pf->vsi[0];
 	u16 buf_len, opc;
 
-	vsi = lag->pf->vsi[0];
-
 	buf_len = ICE_SW_RULE_RX_TX_HDR_SIZE(s_rule, ICE_TRAIN_PKT_LEN);
 	s_rule = kzalloc(buf_len, GFP_KERNEL);
 	if (!s_rule) {
@@ -477,12 +474,11 @@ static u16
 ice_lag_qbuf_recfg(struct ice_hw *hw, struct ice_aqc_cfg_txqs_buf *qbuf,
 		   u16 vsi_num, u16 numq, u8 tc)
 {
+	struct ice_pf *pf = hw->back;
 	struct ice_q_ctx *q_ctx;
 	u16 qid, count = 0;
-	struct ice_pf *pf;
 	int i;
 
-	pf = hw->back;
 	for (i = 0; i < numq; i++) {
 		q_ctx = ice_get_lan_q_ctx(hw, vsi_num, tc, i);
 		if (!q_ctx) {
@@ -940,13 +936,12 @@ ice_lag_reclaim_vf_tc(struct ice_lag *lag, struct ice_hw *src_hw, u16 vsi_num,
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
 	struct ice_aqc_cfg_txqs_buf *qbuf;
+	struct ice_hw *hw = &lag->pf->hw;
 	struct ice_sched_node *n_prt;
 	__le32 teid, parent_teid;
 	struct ice_vsi_ctx *ctx;
-	struct ice_hw *hw;
 	u32 tmp_teid;
 
-	hw = &lag->pf->hw;
 	ctx = ice_get_vsi_ctx(hw, vsi_num);
 	if (!ctx) {
 		dev_warn(dev, "Unable to locate VSI context for LAG reclaim\n");
@@ -1221,11 +1216,8 @@ ice_lag_set_swid(u16 primary_swid, struct ice_lag *local_lag,
  */
 static void ice_lag_primary_swid(struct ice_lag *lag, bool link)
 {
-	struct ice_hw *hw;
-	u16 swid;
-
-	hw = &lag->pf->hw;
-	swid = hw->port_info->sw_id;
+	struct ice_hw *hw = &lag->pf->hw;
+	u16 swid = hw->port_info->sw_id;
 
 	if (ice_share_res(hw, ICE_AQC_RES_TYPE_SWID, link, swid))
 		dev_warn(ice_pf_to_dev(lag->pf), "Failure to set primary interface shared status\n");
@@ -1238,12 +1230,10 @@ static void ice_lag_primary_swid(struct ice_lag *lag, bool link)
  */
 static void ice_lag_add_prune_list(struct ice_lag *lag, struct ice_pf *event_pf)
 {
-	u16 num_vsi, rule_buf_sz, vsi_list_id, event_vsi_num, prim_vsi_idx;
-	struct ice_sw_rule_vsi_list *s_rule = NULL;
+	u16 rule_buf_sz, vsi_list_id, event_vsi_num, prim_vsi_idx, num_vsi = 1;
+	struct ice_sw_rule_vsi_list *s_rule;
 	struct device *dev;
 
-	num_vsi = 1;
-
 	dev = ice_pf_to_dev(lag->pf);
 	event_vsi_num = event_pf->vsi[0]->vsi_num;
 	prim_vsi_idx = lag->pf->vsi[0]->idx;
@@ -1279,12 +1269,10 @@ static void ice_lag_add_prune_list(struct ice_lag *lag, struct ice_pf *event_pf)
  */
 static void ice_lag_del_prune_list(struct ice_lag *lag, struct ice_pf *event_pf)
 {
-	u16 num_vsi, vsi_num, vsi_idx, rule_buf_sz, vsi_list_id;
-	struct ice_sw_rule_vsi_list *s_rule = NULL;
+	u16 vsi_num, vsi_idx, rule_buf_sz, vsi_list_id, num_vsi = 1;
+	struct ice_sw_rule_vsi_list *s_rule;
 	struct device *dev;
 
-	num_vsi = 1;
-
 	dev = ice_pf_to_dev(lag->pf);
 	vsi_num = event_pf->vsi[0]->vsi_num;
 	vsi_idx = lag->pf->vsi[0]->idx;
@@ -1707,11 +1695,9 @@ static void ice_lag_chk_disabled_bond(struct ice_lag *lag, void *ptr)
  */
 static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
 {
-	struct ice_netdev_priv *np;
-	struct ice_pf *pf;
+	struct ice_netdev_priv *np = netdev_priv(lag->netdev);
+	struct ice_pf *pf = np->vsi->back;
 
-	np = netdev_priv(lag->netdev);
-	pf = np->vsi->back;
 	ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
 }
 
@@ -1880,10 +1866,8 @@ ice_lag_event_handler(struct notifier_block *notif_blk, unsigned long event,
  */
 static int ice_register_lag_handler(struct ice_lag *lag)
 {
+	struct notifier_block *notif_blk = &lag->notif_block;
 	struct device *dev = ice_pf_to_dev(lag->pf);
-	struct notifier_block *notif_blk;
-
-	notif_blk = &lag->notif_block;
 
 	if (!notif_blk->notifier_call) {
 		notif_blk->notifier_call = ice_lag_event_handler;
@@ -1903,10 +1887,9 @@ static int ice_register_lag_handler(struct ice_lag *lag)
  */
 static void ice_unregister_lag_handler(struct ice_lag *lag)
 {
+	struct notifier_block *notif_blk = &lag->notif_block;
 	struct device *dev = ice_pf_to_dev(lag->pf);
-	struct notifier_block *notif_blk;
 
-	notif_blk = &lag->notif_block;
 	if (notif_blk->notifier_call) {
 		unregister_netdevice_notifier(notif_blk);
 		dev_dbg(dev, "LAG event handler unregistered\n");
@@ -1968,13 +1951,12 @@ ice_lag_move_vf_nodes_tc_sync(struct ice_lag *lag, struct ice_hw *dest_hw,
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
 	struct ice_aqc_cfg_txqs_buf *qbuf;
+	struct ice_hw *hw = &lag->pf->hw;
 	struct ice_sched_node *n_prt;
 	__le32 teid, parent_teid;
 	struct ice_vsi_ctx *ctx;
-	struct ice_hw *hw;
 	u32 tmp_teid;
 
-	hw = &lag->pf->hw;
 	ctx = ice_get_vsi_ctx(hw, vsi_num);
 	if (!ctx) {
 		dev_warn(dev, "LAG rebuild failed after reset due to VSI Context failure\n");
@@ -2165,9 +2147,7 @@ int ice_init_lag(struct ice_pf *pf)
  */
 void ice_deinit_lag(struct ice_pf *pf)
 {
-	struct ice_lag *lag;
-
-	lag = pf->lag;
+	struct ice_lag *lag = pf->lag;
 
 	if (!lag)
 		return;
-- 
2.47.1


