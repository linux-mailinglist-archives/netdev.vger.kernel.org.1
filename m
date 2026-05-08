Return-Path: <netdev+bounces-285814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mILtFUvf/WnnkAAAu9opvQ
	(envelope-from <netdev+bounces-285814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:04:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8744F6BF6
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B244307B66F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0823E1226;
	Fri,  8 May 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dL+MsT1M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE93E1D08
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245193; cv=none; b=YP5c9Sys/8Ci+XqIfLYk1tEj7PllN6TAoPQJ5FToo8HlzT1ihcyMzQoBwNOu81aDCyeEFOuO1cPf8Tvi2NByCin2Gx1GI3SeqW+Fzc4hXc+PYezphRDuYk2/AssqMHPKJnku2hMoF9kWwsB4Vb9jJh/xjbmVtkpa8fVrURgbR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245193; c=relaxed/simple;
	bh=FWfCl7UBwzOtiab25hIzZzlKGPLqepRD1UjJN8GGfV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKZgYgVy6e2AzkPpUa+uy7qYzF9uhaddBlPKhBKnKSPvtpoqYOac4jXEp/ld5YoDa2N/p4Km8k/F9S7TCUrQldMsnJfqmD2M6ilVM0TbIlpxjYNY/lmJjfrOY51Squ7Ckwe01HgCsipcTxIuLeFLPLZX2oibXEHvsid/i6Fd6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dL+MsT1M; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778245192; x=1809781192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWfCl7UBwzOtiab25hIzZzlKGPLqepRD1UjJN8GGfV0=;
  b=dL+MsT1MuXmuSIAGK1o1CTd7hz79rzXJI5wKOd9Eol+s7zoCrglz36or
   RZefgYYGbrV7GPWpq7KfilM8GAwzjssCnrnLEdeopkuTTZvovNdrb59pB
   IZD3GfBBBHpS8wQABvCGwqVQsvV5cuxssupOYo221jQzd2QgIOhTt9Amv
   1uVsPS0f48VWsSCdN8ewm7Trj5pXyqxs0+5WUaxetIuIIQnI0mj50+mMd
   OJJ5m0Fq2k7E/o4EAW+pX8Ex3RSFvmZJZTlh92FJxjLrC1MMmDYajQH9o
   ltvw2oV0BGuC57NiqDUfucmdtEJeINV70PiLzOYdmVOAMwUhbpLvVTz6S
   A==;
X-CSE-ConnectionGUID: oypccNy5Q9SGBmyuELCXew==
X-CSE-MsgGUID: 3VaeYhdeQTG5ywqGWeZ3Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79199901"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79199901"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 05:59:52 -0700
X-CSE-ConnectionGUID: mKpDa3eOSfGXvqL8lWXsbQ==
X-CSE-MsgGUID: k7a48ddlTS+z24AiWJ4EGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241730122"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 05:59:46 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 353482FC42;
	Fri,  8 May 2026 13:59:44 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	bruce.richardson@intel.com,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	padraig.j.connolly@intel.com,
	ananth.s@intel.com,
	timothy.miskell@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1 06/15] ice: rename ICE_MAX_RSS_QS_PER_VF to ICE_MAX_QS_PER_VF_VCV1
Date: Fri,  8 May 2026 14:41:59 +0200
Message-Id: <20260508124208.11622-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AD8744F6BF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,sea.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285814-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Rename ICE_MAX_RSS_QS_PER_VF to ICE_MAX_QS_PER_VF_VCV1, in preparation for
the next patch that will extend the max to 256, using old value of 16 for
the "v1" variant of virtchnl opcodes.

Suggested-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.h     |  2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h  |  9 +++---
 drivers/net/ethernet/intel/ice/ice_lib.c     |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c   |  4 +--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  | 12 ++++----
 drivers/net/ethernet/intel/ice/virt/queues.c | 30 ++++++++++----------
 6 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index f77ebcd61042..4bfffecbdc97 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -52,7 +52,7 @@ struct ice_lag {
 	u8 bond_lport_sec; /* lport values for secondary PF */
 
 	/* q_home keeps track of which interface the q is currently on */
-	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_RSS_QS_PER_VF];
+	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_QS_PER_VF_VCV1];
 
 	/* placeholder VSI for hanging VF queues from on secondary interface */
 	struct ice_vsi *sec_vf[ICE_MAX_SRIOV_VFS];
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index cdfc2a558732..36dbe5412336 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -19,7 +19,8 @@
 #define ICE_MAX_SRIOV_VFS		256
 
 /* VF resource constraints */
-#define ICE_MAX_RSS_QS_PER_VF	16
+/* for "old" virtchnl opcodes that accept up to 16 queues */
+#define ICE_MAX_QS_PER_VF_VCV1	16
 
 struct ice_pf;
 struct ice_vf;
@@ -161,8 +162,8 @@ struct ice_vf {
 	u8 dev_lan_addr[ETH_ALEN];
 	u8 hw_lan_addr[ETH_ALEN];
 	struct ice_time_mac legacy_last_added_umac;
-	DECLARE_BITMAP(txq_ena, ICE_MAX_RSS_QS_PER_VF);
-	DECLARE_BITMAP(rxq_ena, ICE_MAX_RSS_QS_PER_VF);
+	DECLARE_BITMAP(txq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	DECLARE_BITMAP(rxq_ena, ICE_MAX_QS_PER_VF_VCV1);
 	struct ice_vlan port_vlan_info;	/* Port VLAN ID, QoS, and TPID */
 	struct virtchnl_vlan_caps vlan_v2_caps;
 	struct ice_mbx_vf_info mbx_info;
@@ -205,7 +206,7 @@ struct ice_vf {
 	u16 lldp_recipe_id;
 	u16 lldp_rule_id;
 
-	struct ice_vf_qs_bw qs_bw[ICE_MAX_RSS_QS_PER_VF];
+	struct ice_vf_qs_bw qs_bw[ICE_MAX_QS_PER_VF_VCV1];
 };
 
 /* Flags for controlling behavior of ice_reset_vf */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 2de62cde14ab..09e1dcab2179 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -925,7 +925,7 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
 		 * For VSI_LUT, LUT size should be set to 64 bytes.
 		 */
 		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
-		vsi->rss_size = ICE_MAX_RSS_QS_PER_VF;
+		vsi->rss_size = ICE_MAX_QS_PER_VF_VCV1;
 		vsi->rss_lut_type = ICE_LUT_VSI;
 		break;
 	case ICE_VSI_LB:
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 8686c382404f..0482454f453b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -398,15 +398,15 @@ static int ice_set_per_vf_res(struct ice_pf *pf, u16 num_vfs)
 	}
 
 	num_txq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
-			ICE_MAX_RSS_QS_PER_VF);
+			ICE_MAX_QS_PER_VF_VCV1);
 	avail_qs = ice_get_avail_txq_count(pf) / num_vfs;
 	if (!avail_qs)
 		num_txq = 0;
 	else if (num_txq > avail_qs)
 		num_txq = rounddown_pow_of_two(avail_qs);
 
 	num_rxq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
-			ICE_MAX_RSS_QS_PER_VF);
+			ICE_MAX_QS_PER_VF_VCV1);
 	avail_qs = ice_get_avail_rxq_count(pf) / num_vfs;
 	if (!avail_qs)
 		num_rxq = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index f1f437b1af1b..8e88ab8547ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -535,8 +535,8 @@ static void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
 static void ice_set_vf_state_qs_dis(struct ice_vf *vf)
 {
 	/* Clear Rx/Tx enabled queues flag */
-	bitmap_zero(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
-	bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
+	bitmap_zero(vf->txq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	bitmap_zero(vf->rxq_ena, ICE_MAX_QS_PER_VF_VCV1);
 	clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
 }
 
@@ -1217,13 +1217,13 @@ bool ice_is_vf_trusted(struct ice_vf *vf)
  * ice_vf_has_no_qs_ena - check if the VF has any Rx or Tx queues enabled
  * @vf: the VF to check
  *
- * Returns true if the VF has no Rx and no Tx queues enabled and returns false
- * otherwise
+ * Return: true if the VF has no Rx and no Tx queues enabled and returns false
+ * otherwise.
  */
 bool ice_vf_has_no_qs_ena(struct ice_vf *vf)
 {
-	return bitmap_empty(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
-		bitmap_empty(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
+	return bitmap_empty(vf->rxq_ena, ICE_MAX_QS_PER_VF_VCV1) &&
+	       bitmap_empty(vf->txq_ena, ICE_MAX_QS_PER_VF_VCV1);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 28adc24197b8..7b165ee11a90 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -171,8 +171,8 @@ static int ice_vf_cfg_q_quanta_profile(struct ice_vf *vf, u16 quanta_size,
 static bool ice_vc_validate_vqs_bitmaps(struct virtchnl_queue_select *vqs)
 {
 	if ((!vqs->rx_queues && !vqs->tx_queues) ||
-	    vqs->rx_queues >= BIT(ICE_MAX_RSS_QS_PER_VF) ||
-	    vqs->tx_queues >= BIT(ICE_MAX_RSS_QS_PER_VF))
+	    vqs->rx_queues >= BIT(ICE_MAX_QS_PER_VF_VCV1) ||
+	    vqs->tx_queues >= BIT(ICE_MAX_QS_PER_VF_VCV1))
 		return false;
 
 	return true;
@@ -317,7 +317,7 @@ int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 	 * programmed using ice_vsi_cfg_txqs
 	 */
 	q_map = vqs->rx_queues;
-	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
+	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_QS_PER_VF_VCV1) {
 		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
@@ -330,7 +330,7 @@ int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 	}
 
 	q_map = vqs->tx_queues;
-	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
+	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_QS_PER_VF_VCV1) {
 		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
@@ -461,7 +461,7 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (vqs->tx_queues) {
 		q_map = vqs->tx_queues;
 
-		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
+		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_QS_PER_VF_VCV1) {
 			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
@@ -476,7 +476,7 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 
 	q_map = vqs->rx_queues;
 	if (q_map) {
-		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
+		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_QS_PER_VF_VCV1) {
 			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
@@ -519,7 +519,7 @@ ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi,
 	q_vector->num_ring_tx = 0;
 
 	qmap = map->rxq_map;
-	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_RSS_QS_PER_VF) {
+	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_QS_PER_VF_VCV1) {
 		vsi_q_id = vsi_q_id_idx;
 
 		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
@@ -534,7 +534,7 @@ ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi,
 	}
 
 	qmap = map->txq_map;
-	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_RSS_QS_PER_VF) {
+	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_QS_PER_VF_VCV1) {
 		vsi_q_id = vsi_q_id_idx;
 
 		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
@@ -658,7 +658,7 @@ int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (qbw->num_queues > ICE_MAX_RSS_QS_PER_VF ||
+	if (qbw->num_queues > ICE_MAX_QS_PER_VF_VCV1 ||
 	    qbw->num_queues > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -750,7 +750,7 @@ int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (end_qid > ICE_MAX_RSS_QS_PER_VF ||
+	if (end_qid > ICE_MAX_QS_PER_VF_VCV1 ||
 	    end_qid > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -818,7 +818,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (!vsi)
 		goto error_param;
 
-	if (qci->num_queue_pairs > ICE_MAX_RSS_QS_PER_VF ||
+	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF_VCV1 ||
 	    qci->num_queue_pairs > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(pf), "VF-%d requesting more than supported number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -996,16 +996,16 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (!req_queues) {
 		dev_err(dev, "VF %d tried to request 0 queues. Ignoring.\n",
 			vf->vf_id);
-	} else if (req_queues > ICE_MAX_RSS_QS_PER_VF) {
+	} else if (req_queues > ICE_MAX_QS_PER_VF_VCV1) {
 		dev_err(dev, "VF %d tried to request more than %d queues.\n",
-			vf->vf_id, ICE_MAX_RSS_QS_PER_VF);
-		vfres->num_queue_pairs = ICE_MAX_RSS_QS_PER_VF;
+			vf->vf_id, ICE_MAX_QS_PER_VF_VCV1);
+		vfres->num_queue_pairs = ICE_MAX_QS_PER_VF_VCV1;
 	} else if (req_queues > cur_queues &&
 		   req_queues - cur_queues > tx_rx_queue_left) {
 		dev_warn(dev, "VF %d requested %u more queues, but only %u left.\n",
 			 vf->vf_id, req_queues - cur_queues, tx_rx_queue_left);
 		vfres->num_queue_pairs = min_t(u16, max_allowed_vf_queues,
-					       ICE_MAX_RSS_QS_PER_VF);
+					       ICE_MAX_QS_PER_VF_VCV1);
 	} else {
 		/* request is successful, then reset VF */
 		vf->num_req_qs = req_queues;
-- 
2.39.3


