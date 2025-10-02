Return-Path: <netdev+bounces-227529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE12BB21F9
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 02:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D0617DD6E
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F131531F9;
	Thu,  2 Oct 2025 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0MTKCUK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650C18B0F;
	Thu,  2 Oct 2025 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364235; cv=none; b=Btrjhc9gvoF43K+8sY9rDwPuQwssu5SKKC7A5nrkzdNg3XbSrAzFJWY1nUAmBdhTEPjR3P1brr2HtTawcokfXsLnCwA20IWSdNO9YhdJytcUs8qBEQQFwHmF0xkmUmAnjFZqNNHOgmMDKafB3pAEdNZbHeUAXVjn2nfyA+msCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364235; c=relaxed/simple;
	bh=zcUrMzhHcVZxKF8fljqX7zU35Og17vkLTC/PtnCKYz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/pBbE3UbpZgVlfeDoDi1+Oyf8AyEKmulrblHeJZ8ibf5GCQGQse7OsSKXTiBjtLHveEpW+ArZ7Ekjg1XZQ9BCXlo3hrybdz/0JClDZmDBVJMP53C/td5FOGM8WveakMwhEU3OM2VJLU4YpuBZKb8iBzuLo3HdKzNLLth6w66Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0MTKCUK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759364233; x=1790900233;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zcUrMzhHcVZxKF8fljqX7zU35Og17vkLTC/PtnCKYz0=;
  b=W0MTKCUKi8TPy6j1lLitJ7oMXHasCQh5Psn8wdUV5aa/WoRjD22ePeVr
   Py2bjF5kSekDBfieq47O3TwgLRMl/vkmVgi5I1AMM5zI1NKL03Z7RLauC
   pEUf7ataRO8fOZ0B8powxpBURv20mRvkVXenN2fUcDjshW/aNnJixtGtg
   hI4SecsLQvuv26kAP0cK3de6DVwxycqBv40stJ7/0iS2vdpwBEosDjoxh
   5DCHNnDRCxHpRQbVo+4VftpT1tkCsBJbzz5yIc/+q4cfxnXtg98OPodhv
   8NhrYLxhiF8kpe+6BIWakQHIM0zNGfE4cBoVYD0jKivso8UYRv8LM+tmf
   A==;
X-CSE-ConnectionGUID: J1I/RGsxRKeHgHAkdJW8LA==
X-CSE-MsgGUID: fQx4D2YJRGGd/04EjEwxSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61561607"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="61561607"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:10 -0700
X-CSE-ConnectionGUID: yQCzogjDQPe+Vg3R3iXRfQ==
X-CSE-MsgGUID: vuFunNifQwiNVB3FG1+nRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="184105717"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 01 Oct 2025 17:14:12 -0700
Subject: [PATCH net 2/8] idpf: convert vport state to bitmap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-jk-iwl-net-2025-10-01-v1-2-49fa99e86600@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
In-Reply-To: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Anton Nadezhdin <anton.nadezhdin@intel.com>, 
 Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Chittim Madhu <madhu.chittim@intel.com>, 
 Samuel Salin <Samuel.salin@intel.com>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=9941;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=9kFg7yE9fFG8aNMXu0iUB+HAE2YsjKmMp1ucoLrlBoo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoy7R5p5VuWYSrEI39fxfF75K7Fpmn7lcsbVWqIfjvPuq
 b/kdkm/o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlwP2dk2Lx/lfk/D3YRjneS
 vrMcmBo7zpsz/TqeMcH6m8ZNN1eBbYwM/fIB9Xop4UV53zRsVjbfCv7k05/2o4FVu+ur1pOVJrX
 MAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Emil Tantilov <emil.s.tantilov@intel.com>

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
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/idpf/idpf.h             | 12 +++++------
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     | 10 ++++-----
 drivers/net/ethernet/intel/idpf/idpf_lib.c         | 24 +++++++++++-----------
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  4 ++--
 6 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index f4c0eaf9bde3..cfbf3a716f34 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -130,14 +130,12 @@ enum idpf_cap_field {
 
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
@@ -159,7 +157,7 @@ struct idpf_netdev_priv {
 	u32 link_speed_mbps;
 	u16 vport_idx;
 	u16 max_tx_hdr_size;
-	enum idpf_vport_state state;
+	DECLARE_BITMAP(state, IDPF_VPORT_STATE_NBITS);
 	struct rtnl_link_stats64 netstats;
 	spinlock_t stats_lock;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 0eb812ac19c2..f84e247399a7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -386,7 +386,7 @@ static int idpf_get_rxfh(struct net_device *netdev,
 	}
 
 	rss_data = &adapter->vport_config[np->vport_idx]->user_config.rss_data;
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
@@ -436,7 +436,7 @@ static int idpf_set_rxfh(struct net_device *netdev,
 	}
 
 	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
@@ -1167,7 +1167,7 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (np->state != __IDPF_VPORT_UP) {
+	if (!test_bit(IDPF_VPORT_UP, np->state)) {
 		idpf_vport_ctrl_unlock(netdev);
 
 		return;
@@ -1319,7 +1319,7 @@ static int idpf_get_q_coalesce(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	if (q_num >= vport->num_rxq && q_num >= vport->num_txq) {
@@ -1507,7 +1507,7 @@ static int idpf_set_coalesce(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	for (i = 0; i < vport->num_txq; i++) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 513032cb5f08..89d30c395533 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -517,7 +517,7 @@ static int idpf_del_mac_filter(struct idpf_vport *vport,
 	}
 	spin_unlock_bh(&vport_config->mac_filter_list_lock);
 
-	if (np->state == __IDPF_VPORT_UP) {
+	if (test_bit(IDPF_VPORT_UP, np->state)) {
 		int err;
 
 		err = idpf_add_del_mac_filters(vport, np, false, async);
@@ -588,7 +588,7 @@ static int idpf_add_mac_filter(struct idpf_vport *vport,
 	if (err)
 		return err;
 
-	if (np->state == __IDPF_VPORT_UP)
+	if (test_bit(IDPF_VPORT_UP, np->state))
 		err = idpf_add_del_mac_filters(vport, np, true, async);
 
 	return err;
@@ -888,7 +888,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 
-	if (np->state <= __IDPF_VPORT_DOWN)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return;
 
 	netif_carrier_off(vport->netdev);
@@ -911,7 +911,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 	idpf_vport_intr_deinit(vport);
 	idpf_vport_queues_rel(vport);
 	idpf_vport_intr_rel(vport);
-	np->state = __IDPF_VPORT_DOWN;
+	clear_bit(IDPF_VPORT_UP, np->state);
 }
 
 /**
@@ -1332,7 +1332,7 @@ static int idpf_up_complete(struct idpf_vport *vport)
 		netif_tx_start_all_queues(vport->netdev);
 	}
 
-	np->state = __IDPF_VPORT_UP;
+	set_bit(IDPF_VPORT_UP, np->state);
 
 	return 0;
 }
@@ -1377,7 +1377,7 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	struct idpf_vport_config *vport_config;
 	int err;
 
-	if (np->state != __IDPF_VPORT_DOWN)
+	if (test_bit(IDPF_VPORT_UP, np->state))
 		return -EBUSY;
 
 	/* we do not allow interface up just yet */
@@ -1569,7 +1569,7 @@ void idpf_init_task(struct work_struct *work)
 
 	/* Once state is put into DOWN, driver is ready for dev_open */
 	np = netdev_priv(vport->netdev);
-	np->state = __IDPF_VPORT_DOWN;
+	clear_bit(IDPF_VPORT_UP, np->state);
 	if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED, vport_config->flags))
 		idpf_vport_open(vport);
 
@@ -1768,7 +1768,7 @@ static void idpf_set_vport_state(struct idpf_adapter *adapter)
 			continue;
 
 		np = netdev_priv(adapter->netdevs[i]);
-		if (np->state == __IDPF_VPORT_UP)
+		if (test_bit(IDPF_VPORT_UP, np->state))
 			set_bit(IDPF_VPORT_UP_REQUESTED,
 				adapter->vport_config[i]->flags);
 	}
@@ -1906,7 +1906,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 			     enum idpf_vport_reset_cause reset_cause)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
-	enum idpf_vport_state current_state = np->state;
+	bool vport_is_up = test_bit(IDPF_VPORT_UP, np->state);
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport *new_vport;
 	int err;
@@ -1957,7 +1957,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		goto free_vport;
 	}
 
-	if (current_state <= __IDPF_VPORT_DOWN) {
+	if (!vport_is_up) {
 		idpf_send_delete_queues_msg(vport);
 	} else {
 		set_bit(IDPF_VPORT_DEL_QUEUES, vport->flags);
@@ -1990,7 +1990,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (err)
 		goto err_open;
 
-	if (current_state == __IDPF_VPORT_UP)
+	if (vport_is_up)
 		err = idpf_vport_open(vport);
 
 	goto free_vport;
@@ -2000,7 +2000,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 				 vport->num_rxq, vport->num_bufq);
 
 err_open:
-	if (current_state == __IDPF_VPORT_UP)
+	if (vport_is_up)
 		idpf_vport_open(vport);
 
 free_vport:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index b19b462e0bb6..06199fde3b57 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -571,7 +571,7 @@ static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 	np = netdev_priv(tx_q->netdev);
 	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
-	dont_wake = np->state != __IDPF_VPORT_UP ||
+	dont_wake = !test_bit(IDPF_VPORT_UP, np->state) ||
 		    !netif_carrier_ok(tx_q->netdev);
 	__netif_txq_completed_wake(nq, ss.packets, ss.bytes,
 				   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index eaad52a83b04..d6affa6535f7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1869,7 +1869,7 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		/* Update BQL */
 		nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
-		dont_wake = !complq_ok || np->state != __IDPF_VPORT_UP ||
+		dont_wake = !complq_ok || !test_bit(IDPF_VPORT_UP, np->state) ||
 			    !netif_carrier_ok(tx_q->netdev);
 		/* Check if the TXQ needs to and can be restarted */
 		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index c1f34381333d..e68572c602eb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -68,7 +68,7 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
 
 	vport->link_up = v2e->link_status;
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return;
 
 	if (vport->link_up) {
@@ -2432,7 +2432,7 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
 
 
 	/* Don't send get_stats message if the link is down */
-	if (np->state <= __IDPF_VPORT_DOWN)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return 0;
 
 	stats_msg.vport_id = cpu_to_le32(vport->vport_id);

-- 
2.51.0.rc1.197.g6d975e95c9d7


