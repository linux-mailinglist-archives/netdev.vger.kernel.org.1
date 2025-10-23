Return-Path: <netdev+bounces-232288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A720C03E8D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3443A55DE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53882296BD4;
	Thu, 23 Oct 2025 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVF6wdZN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196119463
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263870; cv=none; b=gJ6NvM4V7+b+KfkvmrVZT3oo7vsAaXoQLuE9x5QXYWFeOkqJp7osgMW52FF/cSmIEOXJzkb+Si+v5qwlBkOxeq9lVxjvhzxqVOsHULj1Wo6SZnFbUADV7t0QdE/JMTa1xSY01Kn+yoUBLS/7pbQhCDorTYMzhSTDSqu72ADjiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263870; c=relaxed/simple;
	bh=EjlYwcPaVvFzATfag5yUcw1n4hi7Y0mjUzvinT0L/jM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XLgj4SkyZs7fZ9IRCGpQoZ21AddNuL5nvM6bG2tKgzM9ffPaVHp/gf8+sFN8tRIBe9iZ59NnwXCkWVXcr4vUCMm/+oeUl7WEpxlqGhL9nWHMIoguCrZNR9UIRhvPu6sYSv+cLgKu8TBII5PBtLbXv3PZgyzz3j80us/iT45d4Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVF6wdZN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761263868; x=1792799868;
  h=from:to:cc:subject:date:message-id;
  bh=EjlYwcPaVvFzATfag5yUcw1n4hi7Y0mjUzvinT0L/jM=;
  b=eVF6wdZN2eINl9yC3DWFeAgMpuiGX777a1sNChYfhAmj5rQnI7frcZtM
   bsbNIxJVzPDDGJwXQUKblONQRa4eA1xXcA8w0kJUVhhf2n16nNqr5xiSE
   3ZBje9RMpW0gyEILfGn/tMt8lHR36g3oUncrkiROivXoHoceTqSWoxDlj
   OD7z4aAyEm/udkEn2gd9u9MMj1IdXgEVrlPtHJXntPKl0zWi4M4LLjLHW
   lx0NrhYtNoG9N3hTxEUVZe6Ew4RsBCgne/+NlOtEiHauwMajF8SNgToIJ
   JVTmh/RxN9pgdQvgny/oH4LP559Hyn1bp/5KC4uKTLhaxmTQla3kccVNH
   Q==;
X-CSE-ConnectionGUID: kur40+5qSjO01d8E/N9Gaw==
X-CSE-MsgGUID: x6ipaQwvSEGRY7bKmsIbcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88913034"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="88913034"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 16:57:45 -0700
X-CSE-ConnectionGUID: 4SsdLDpkQIuIjZxqJ84N2A==
X-CSE-MsgGUID: WUEIDtjaSfqOlrUYoIjnTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="183468481"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa006.jf.intel.com with ESMTP; 23 Oct 2025 16:57:46 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	aleksander.lobakin@intel.com
Subject: [PATCH iwl-next] idpf: convert vport state to bitmap
Date: Thu, 23 Oct 2025 16:50:49 -0700
Message-Id: <20251023235049.2199-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Convert vport state to a bitmap and remove the DOWN state which is
redundant in the existing logic. There are no functional changes aside
from the use of bitwise operations when setting and checking the states.
Removed the double underscore to be consistent with the naming of other
bitmaps in the header and renamed current_state to vport_is_up to match
the meaning of the new variable.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Chittim Madhu <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
This patch was previously submitted as part of series to -net:
https://lore.kernel.org/netdev/20250822035248.22969-2-emil.s.tantilov@intel.com/
Changed to -next, as the related follow-up patch was rejected:
https://lore.kernel.org/netdev/20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com/
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 12 ++++------
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 12 +++++-----
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 24 +++++++++----------
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  4 ++--
 drivers/net/ethernet/intel/idpf/xdp.c         |  2 +-
 7 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index f0387b83a9ed..dab36c0c3cdc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -131,14 +131,12 @@ enum idpf_cap_field {
 
 /**
  * enum idpf_vport_state - Current vport state
- * @__IDPF_VPORT_DOWN: Vport is down
- * @__IDPF_VPORT_UP: Vport is up
- * @__IDPF_VPORT_STATE_LAST: Must be last, number of states
+ * @IDPF_VPORT_UP: Vport is up
+ * @IDPF_VPORT_STATE_NBITS: Must be last, number of states
  */
 enum idpf_vport_state {
-	__IDPF_VPORT_DOWN,
-	__IDPF_VPORT_UP,
-	__IDPF_VPORT_STATE_LAST,
+	IDPF_VPORT_UP,
+	IDPF_VPORT_STATE_NBITS
 };
 
 /**
@@ -162,7 +160,7 @@ struct idpf_netdev_priv {
 	u16 vport_idx;
 	u16 max_tx_hdr_size;
 	u16 tx_max_bufs;
-	enum idpf_vport_state state;
+	DECLARE_BITMAP(state, IDPF_VPORT_STATE_NBITS);
 	struct rtnl_link_stats64 netstats;
 	spinlock_t stats_lock;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 4c6e52253ae4..3fbe94a4ce6b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -414,7 +414,7 @@ static int idpf_get_rxfh(struct net_device *netdev,
 	}
 
 	rss_data = &adapter->vport_config[np->vport_idx]->user_config.rss_data;
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
@@ -464,7 +464,7 @@ static int idpf_set_rxfh(struct net_device *netdev,
 	}
 
 	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
@@ -1195,7 +1195,7 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (np->state != __IDPF_VPORT_UP) {
+	if (!test_bit(IDPF_VPORT_UP, np->state)) {
 		idpf_vport_ctrl_unlock(netdev);
 
 		return;
@@ -1347,7 +1347,7 @@ static int idpf_get_q_coalesce(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	if (q_num >= vport->num_rxq && q_num >= vport->num_txq) {
@@ -1535,7 +1535,7 @@ static int idpf_set_coalesce(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	for (i = 0; i < vport->num_txq; i++) {
@@ -1738,7 +1738,7 @@ static void idpf_get_ts_stats(struct net_device *netdev,
 		ts_stats->err = u64_stats_read(&vport->tstamp_stats.discarded);
 	} while (u64_stats_fetch_retry(&vport->tstamp_stats.stats_sync, start));
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto exit;
 
 	for (u16 i = 0; i < vport->num_txq_grp; i++) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index bd38ecc7872c..d9f6e9c0dcf9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -542,7 +542,7 @@ static int idpf_del_mac_filter(struct idpf_vport *vport,
 	}
 	spin_unlock_bh(&vport_config->mac_filter_list_lock);
 
-	if (np->state == __IDPF_VPORT_UP) {
+	if (test_bit(IDPF_VPORT_UP, np->state)) {
 		int err;
 
 		err = idpf_add_del_mac_filters(vport, np, false, async);
@@ -613,7 +613,7 @@ static int idpf_add_mac_filter(struct idpf_vport *vport,
 	if (err)
 		return err;
 
-	if (np->state == __IDPF_VPORT_UP)
+	if (test_bit(IDPF_VPORT_UP, np->state))
 		err = idpf_add_del_mac_filters(vport, np, true, async);
 
 	return err;
@@ -917,7 +917,7 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 
-	if (np->state <= __IDPF_VPORT_DOWN)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return;
 
 	if (rtnl)
@@ -944,7 +944,7 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 	idpf_xdp_rxq_info_deinit_all(vport);
 	idpf_vport_queues_rel(vport);
 	idpf_vport_intr_rel(vport);
-	np->state = __IDPF_VPORT_DOWN;
+	clear_bit(IDPF_VPORT_UP, np->state);
 
 	if (rtnl)
 		rtnl_unlock();
@@ -1370,7 +1370,7 @@ static int idpf_up_complete(struct idpf_vport *vport)
 		netif_tx_start_all_queues(vport->netdev);
 	}
 
-	np->state = __IDPF_VPORT_UP;
+	set_bit(IDPF_VPORT_UP, np->state);
 
 	return 0;
 }
@@ -1416,7 +1416,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 	struct idpf_vport_config *vport_config;
 	int err;
 
-	if (np->state != __IDPF_VPORT_DOWN)
+	if (test_bit(IDPF_VPORT_UP, np->state))
 		return -EBUSY;
 
 	if (rtnl)
@@ -1628,7 +1628,7 @@ void idpf_init_task(struct work_struct *work)
 
 	/* Once state is put into DOWN, driver is ready for dev_open */
 	np = netdev_priv(vport->netdev);
-	np->state = __IDPF_VPORT_DOWN;
+	clear_bit(IDPF_VPORT_UP, np->state);
 	if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED, vport_config->flags))
 		idpf_vport_open(vport, true);
 
@@ -1827,7 +1827,7 @@ static void idpf_set_vport_state(struct idpf_adapter *adapter)
 			continue;
 
 		np = netdev_priv(adapter->netdevs[i]);
-		if (np->state == __IDPF_VPORT_UP)
+		if (test_bit(IDPF_VPORT_UP, np->state))
 			set_bit(IDPF_VPORT_UP_REQUESTED,
 				adapter->vport_config[i]->flags);
 	}
@@ -1965,7 +1965,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 			     enum idpf_vport_reset_cause reset_cause)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
-	enum idpf_vport_state current_state = np->state;
+	bool vport_is_up = test_bit(IDPF_VPORT_UP, np->state);
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport *new_vport;
 	int err;
@@ -2016,7 +2016,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		goto free_vport;
 	}
 
-	if (current_state <= __IDPF_VPORT_DOWN) {
+	if (!vport_is_up) {
 		idpf_send_delete_queues_msg(vport);
 	} else {
 		set_bit(IDPF_VPORT_DEL_QUEUES, vport->flags);
@@ -2049,7 +2049,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (err)
 		goto err_open;
 
-	if (current_state == __IDPF_VPORT_UP)
+	if (vport_is_up)
 		err = idpf_vport_open(vport, false);
 
 	goto free_vport;
@@ -2059,7 +2059,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 				 vport->num_rxq, vport->num_bufq);
 
 err_open:
-	if (current_state == __IDPF_VPORT_UP)
+	if (vport_is_up)
 		idpf_vport_open(vport, false);
 
 free_vport:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 61e613066140..e3ddf18dcbf5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -570,7 +570,7 @@ static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 	np = netdev_priv(tx_q->netdev);
 	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
-	dont_wake = np->state != __IDPF_VPORT_UP ||
+	dont_wake = !test_bit(IDPF_VPORT_UP, np->state) ||
 		    !netif_carrier_ok(tx_q->netdev);
 	__netif_txq_completed_wake(nq, ss.packets, ss.bytes,
 				   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 828f7c444d30..1993a3b0da59 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2275,7 +2275,7 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		/* Update BQL */
 		nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
-		dont_wake = !complq_ok || np->state != __IDPF_VPORT_UP ||
+		dont_wake = !complq_ok || !test_bit(IDPF_VPORT_UP, np->state) ||
 			    !netif_carrier_ok(tx_q->netdev);
 		/* Check if the TXQ needs to and can be restarted */
 		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index cbb5fa30f5a0..44cd4b466c48 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -68,7 +68,7 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
 
 	vport->link_up = v2e->link_status;
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return;
 
 	if (vport->link_up) {
@@ -2755,7 +2755,7 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
 
 
 	/* Don't send get_stats message if the link is down */
-	if (np->state <= __IDPF_VPORT_DOWN)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return 0;
 
 	stats_msg.vport_id = cpu_to_le32(vport->vport_id);
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 21ce25b0567f..958d16f87424 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -418,7 +418,7 @@ static int idpf_xdp_setup_prog(struct idpf_vport *vport,
 	if (test_bit(IDPF_REMOVE_IN_PROG, vport->adapter->flags) ||
 	    !test_bit(IDPF_VPORT_REG_NETDEV, cfg->flags) ||
 	    !!vport->xdp_prog == !!prog) {
-		if (np->state == __IDPF_VPORT_UP)
+		if (test_bit(IDPF_VPORT_UP, np->state))
 			idpf_xdp_copy_prog_to_rqs(vport, prog);
 
 		old = xchg(&vport->xdp_prog, prog);
-- 
2.37.3


