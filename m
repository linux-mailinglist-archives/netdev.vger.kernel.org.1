Return-Path: <netdev+bounces-224827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C7B8AD53
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF621895B87
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06463322771;
	Fri, 19 Sep 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoKU9pu+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8A322A29
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304464; cv=none; b=p8IqPMw69w+z6NLr43jEl8knX0cbWqVYnkGyOtUPCktv+SwAqyVYidASMk12RzWCIPSktSwe4V8b3zg9U4y5AIOkG2XbpAtOhc6cnE6YJBqsBndJy17sHoGe7Qn/pzERF5fWIgcJYkEUvSNUI60iEoCQmUnyHHm7ovrwO6z+hNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304464; c=relaxed/simple;
	bh=YiQqcGrD46Iv4e09feMm8xC4xb3pr+0dhoqa1pdrnEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0mn9hS9zZB32cQGeg1yxZij+EuBIroIDYIAAmWtAK3w+WWo7Xb75663GY7dqFdupLGzdUUvckGZQY+l6uelluCFhHCokn8Y+38m/EEcVU/+Jjn8jAAbCerRtWiPvwnydDAH5nPMTd214vZfy2SA72eqS4z/hxk8n6QQMNly+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoKU9pu+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758304464; x=1789840464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YiQqcGrD46Iv4e09feMm8xC4xb3pr+0dhoqa1pdrnEE=;
  b=GoKU9pu+/IQhF2Zhprl58OY7Fg9EHcBY/OZ/ps6eniz1uNkCmiC/R2HA
   QZamEas28O0MsV20XQ+7pCA2DjKB5SYc9+u6diUPLdHw9atP5qgZ0kUm0
   6JqcI2O2KOmVf5KjMPbjq9FOBAHUU7T2ecwRbn2lTd+TsUZ6D0CFzcBtn
   F33Yjc6D03wBJji6tajyyBIP7WfwWRSTj5nMui31JylkIaM1sjpKM+WqZ
   VrFqE4h6T37CMX9LCT7bi4eQtAc641CRplJGxyZ2g9FdWO+rRvd/TdMtO
   51ZfkJEiQxeXv2/QY16Vy1oFy246uWHXMm8iZCzHBIGdlO5X0LotSlxnc
   g==;
X-CSE-ConnectionGUID: Wo1iyQGgStKq9qmhD8pxUA==
X-CSE-MsgGUID: hODrkBAEQwKdIMo3FibHAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="78097083"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="78097083"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:54:21 -0700
X-CSE-ConnectionGUID: u6a8P7SmQCeaEj2zlAoNYQ==
X-CSE-MsgGUID: 4vowIdeiQyuumr/wrceSxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176709488"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 10:54:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Milena Olech <milena.olech@intel.com>,
	anthony.l.nguyen@intel.com,
	anton.nadezhdin@intel.com,
	konstantin.ilichev@intel.com,
	richardcochran@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net-next 4/7] idpf: add HW timestamping statistics
Date: Fri, 19 Sep 2025 10:54:07 -0700
Message-ID: <20250919175412.653707-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
References: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

Add HW timestamping statistics support - through implementing get_ts_stats.
Timestamp statistics include correctly timestamped packets, discarded,
skipped and flushed during PTP release.

Most of the stats are collected per vport, only requests skipped due to
lack of free latch index are collected per Tx queue.

Statistics can be obtained using kernel ethtool since version 6.10
with:
ethtool -I -T <interface>

The output will include:
Statistics:
  tx_pkts: 15
  tx_lost: 0
  tx_err: 0

Signed-off-by: Milena Olech <milena.olech@intel.com>
Co-developed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 17 ++++++
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 56 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 11 +++-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  4 ++
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 6e79fa8556e9..6db6d6f0562a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -256,6 +256,21 @@ enum idpf_vport_flags {
 	IDPF_VPORT_FLAGS_NBITS,
 };
 
+/**
+ * struct idpf_tstamp_stats - Tx timestamp statistics
+ * @stats_sync: See struct u64_stats_sync
+ * @packets: Number of packets successfully timestamped by the hardware
+ * @discarded: Number of Tx skbs discarded due to cached PHC
+ *	       being too old to correctly extend timestamp
+ * @flushed: Number of Tx skbs flushed due to interface closed
+ */
+struct idpf_tstamp_stats {
+	struct u64_stats_sync stats_sync;
+	u64_stats_t packets;
+	u64_stats_t discarded;
+	u64_stats_t flushed;
+};
+
 struct idpf_port_stats {
 	struct u64_stats_sync stats_sync;
 	u64_stats_t rx_hw_csum_err;
@@ -328,6 +343,7 @@ struct idpf_fsteer_fltr {
  * @tx_tstamp_caps: Capabilities negotiated for Tx timestamping
  * @tstamp_config: The Tx tstamp config
  * @tstamp_task: Tx timestamping task
+ * @tstamp_stats: Tx timestamping statistics
  */
 struct idpf_vport {
 	u16 num_txq;
@@ -386,6 +402,7 @@ struct idpf_vport {
 	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
 	struct kernel_hwtstamp_config tstamp_config;
 	struct work_struct tstamp_task;
+	struct idpf_tstamp_stats tstamp_stats;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 0eb812ac19c2..786d0bacdd3c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1685,6 +1685,61 @@ static int idpf_get_ts_info(struct net_device *netdev,
 	return err;
 }
 
+/**
+ * idpf_get_ts_stats - Collect HW tstamping statistics
+ * @netdev: network interface device structure
+ * @ts_stats: HW timestamping stats structure
+ *
+ * Collect HW timestamping statistics including successfully timestamped
+ * packets, discarded due to illegal values, flushed during releasing PTP and
+ * skipped due to lack of the free index.
+ */
+static void idpf_get_ts_stats(struct net_device *netdev,
+			      struct ethtool_ts_stats *ts_stats)
+{
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
+	struct idpf_vport *vport;
+	unsigned int start;
+
+	idpf_vport_ctrl_lock(netdev);
+	vport = idpf_netdev_to_vport(netdev);
+	do {
+		start = u64_stats_fetch_begin(&vport->tstamp_stats.stats_sync);
+		ts_stats->pkts = u64_stats_read(&vport->tstamp_stats.packets);
+		ts_stats->lost = u64_stats_read(&vport->tstamp_stats.flushed);
+		ts_stats->err = u64_stats_read(&vport->tstamp_stats.discarded);
+	} while (u64_stats_fetch_retry(&vport->tstamp_stats.stats_sync, start));
+
+	if (np->state != __IDPF_VPORT_UP)
+		goto exit;
+
+	for (u16 i = 0; i < vport->num_txq_grp; i++) {
+		struct idpf_txq_group *txq_grp = &vport->txq_grps[i];
+
+		for (u16 j = 0; j < txq_grp->num_txq; j++) {
+			struct idpf_tx_queue *txq = txq_grp->txqs[j];
+			struct idpf_tx_queue_stats *stats;
+			u64 ts;
+
+			if (!txq)
+				continue;
+
+			stats = &txq->q_stats;
+			do {
+				start = u64_stats_fetch_begin(&txq->stats_sync);
+
+				ts = u64_stats_read(&stats->tstamp_skipped);
+			} while (u64_stats_fetch_retry(&txq->stats_sync,
+						       start));
+
+			ts_stats->lost += ts;
+		}
+	}
+
+exit:
+	idpf_vport_ctrl_unlock(netdev);
+}
+
 static const struct ethtool_ops idpf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
@@ -1711,6 +1766,7 @@ static const struct ethtool_ops idpf_ethtool_ops = {
 	.set_ringparam		= idpf_set_ringparam,
 	.get_link_ksettings	= idpf_get_link_ksettings,
 	.get_ts_info		= idpf_get_ts_info,
+	.get_ts_stats		= idpf_get_ts_stats,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index ee21f2ff0cad..142823af1f9e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -618,8 +618,13 @@ u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp)
 
 	discard_time = ptp->cached_phc_jiffies + 2 * HZ;
 
-	if (time_is_before_jiffies(discard_time))
+	if (time_is_before_jiffies(discard_time)) {
+		u64_stats_update_begin(&vport->tstamp_stats.stats_sync);
+		u64_stats_inc(&vport->tstamp_stats.discarded);
+		u64_stats_update_end(&vport->tstamp_stats.stats_sync);
+
 		return 0;
+	}
 
 	return idpf_ptp_tstamp_extend_32b_to_64b(ptp->cached_phc_time,
 						 lower_32_bits(in_tstamp));
@@ -853,10 +858,14 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 
 	/* Remove list with latches in use */
 	head = &vport->tx_tstamp_caps->latches_in_use;
+	u64_stats_update_begin(&vport->tstamp_stats.stats_sync);
 	list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
+		u64_stats_inc(&vport->tstamp_stats.flushed);
+
 		list_del(&ptp_tx_tstamp->list_member);
 		kfree(ptp_tx_tstamp);
 	}
+	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
 
 	spin_unlock_bh(&vport->tx_tstamp_caps->latches_lock);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 4f1fb0cefe51..8a2e0f8c5e36 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -521,6 +521,10 @@ idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
 	list_add(&ptp_tx_tstamp->list_member,
 		 &tx_tstamp_caps->latches_free);
 
+	u64_stats_update_begin(&vport->tstamp_stats.stats_sync);
+	u64_stats_inc(&vport->tstamp_stats.packets);
+	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
+
 	return 0;
 }
 
-- 
2.47.1


