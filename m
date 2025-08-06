Return-Path: <netdev+bounces-211957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB248B1CA30
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 18:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057157AA026
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 16:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CC429B8D2;
	Wed,  6 Aug 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpncdyqe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682D3C01
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499511; cv=none; b=bqTaodkdO02a0joiGKPAMU0Ug+ZdPle/n00SKxpqA0f4Vclzdm9XtHQjmgX0/nBtwvqxbiur+QeNYlsU18g77nsYs0zu/XdeM48TlriQFJsp7NCVtlfD9pu2z/0cnUKwzzrQRsXxU1pmDQ9AH1RIf/qNJKWIeh1vrfHpVSeyyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499511; c=relaxed/simple;
	bh=Jtywj7U0x1vz2tVy17r+y6IHA2w5Bme0QBMXBLn6Afw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JM27ODdGi/Du5XS6XjJ6p7aqDSfxv3e9tNKuKEMgXXdYzurK9APire4hjKXYTQEsxrftfoAkqRnw04jGYek0LAFpl31A2roC0BsPV3krTi3/KdZGfuwmhzimdrrqlc5q5eIMCf26K2znN/ggSNMIACLJMPlPDMRwprvG6kOs2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpncdyqe; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754499510; x=1786035510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jtywj7U0x1vz2tVy17r+y6IHA2w5Bme0QBMXBLn6Afw=;
  b=lpncdyqetPMvfC2D/v606UKVwPH/xdXJ3kLO0BoYbvs3dmzMD/Ep8url
   Wgz9MjYTYPxN1StDZoj5l4Pn/tv1CZLdO9wkjHy9ntJaHV+R8hkIncqJg
   aviev2ZubHHeiLMdv5Tzkyh0sdeeX0FhEBjqTqJKGPXlx0SByNzc46sTp
   hVXZELIXgrBD+vJdm+aeMrwgBxhnSPNJmx9IHz6Wn1ugPdDGf4/g9pjWF
   238flSrtR5+a/JF7zshmtajbl8OOtqmOmssHGYPFRkkbc87JNrJjz5nus
   zyf2qmaRC+pvkG3nnrz/BtZykzWQ6TBzgL9RzoBQ6EyKsGy1rU1Aq0viM
   w==;
X-CSE-ConnectionGUID: HBulZqpEQkeza8xa4daZQg==
X-CSE-MsgGUID: sShdhKqgT76OIcfffkFvzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60634942"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60634942"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 09:58:29 -0700
X-CSE-ConnectionGUID: N/EE/BjnRFWbOoX5MgTAaQ==
X-CSE-MsgGUID: +sC2r01pT72td3XJE72BIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="201989936"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2025 09:58:27 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	tobias.boehm@hetzner-cloud.de,
	marcus.wichelmann@hetzner-cloud.de,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v2 iwl-net] ixgbe: fix ndo_xdp_xmit() workloads
Date: Wed,  6 Aug 2025 18:58:19 +0200
Message-Id: <20250806165819.2162027-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently ixgbe driver checks periodically in its watchdog subtask if
there is anything to be transmitted (considering both Tx and XDP rings)
under state of carrier not being 'ok'. Such event is interpreted as Tx
hang and therefore results in interface reset.

This is currently problematic for ndo_xdp_xmit() as it is allowed to
produce descriptors when interface is going through reset or its carrier
is turned off.

Furthermore, XDP rings should not really be objects of Tx hang
detection. This mechanism is rather a matter of ndo_tx_timeout() being
called from dev_watchdog against Tx rings exposed to networking stack.

Taking into account issues described above, let us have a two fold fix -
do not respect XDP rings in local ixgbe watchdog and do not produce Tx
descriptors in ndo_xdp_xmit callback when there is some problem with
carrier currently. For now, keep the Tx hang checks in clean Tx irq
routine, but adjust it to not execute for XDP rings.

Cc: Tobias Böhm <tobias.boehm@hetzner-cloud.de>
Reported-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Closes: https://lore.kernel.org/netdev/eca1880f-253a-4955-afe6-732d7c6926ee@hetzner-cloud.de/
Fixes: 6453073987ba ("ixgbe: add initial support for xdp redirect")
Fixes: 33fdc82f0883 ("ixgbe: add support for XDP_TX action")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v1->v2:
* collect tags
* fix typos (Dawid)
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 34 ++++++-------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 03d31e5b131d..7c0db3b3ee8e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -967,10 +967,6 @@ static void ixgbe_update_xoff_rx_lfc(struct ixgbe_adapter *adapter)
 	for (i = 0; i < adapter->num_tx_queues; i++)
 		clear_bit(__IXGBE_HANG_CHECK_ARMED,
 			  &adapter->tx_ring[i]->state);
-
-	for (i = 0; i < adapter->num_xdp_queues; i++)
-		clear_bit(__IXGBE_HANG_CHECK_ARMED,
-			  &adapter->xdp_ring[i]->state);
 }
 
 static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
@@ -1264,10 +1260,13 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 				   total_bytes);
 	adapter->tx_ipsec += total_ipsec;
 
+	if (ring_is_xdp(tx_ring))
+		return !!budget;
+
 	if (check_for_tx_hang(tx_ring) && ixgbe_check_tx_hang(tx_ring)) {
 		/* schedule immediate reset if we believe we hung */
 		struct ixgbe_hw *hw = &adapter->hw;
-		e_err(drv, "Detected Tx Unit Hang %s\n"
+		e_err(drv, "Detected Tx Unit Hang\n"
 			"  Tx Queue             <%d>\n"
 			"  TDH, TDT             <%x>, <%x>\n"
 			"  next_to_use          <%x>\n"
@@ -1275,16 +1274,14 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 			"tx_buffer_info[next_to_clean]\n"
 			"  time_stamp           <%lx>\n"
 			"  jiffies              <%lx>\n",
-			ring_is_xdp(tx_ring) ? "(XDP)" : "",
 			tx_ring->queue_index,
 			IXGBE_READ_REG(hw, IXGBE_TDH(tx_ring->reg_idx)),
 			IXGBE_READ_REG(hw, IXGBE_TDT(tx_ring->reg_idx)),
 			tx_ring->next_to_use, i,
 			tx_ring->tx_buffer_info[i].time_stamp, jiffies);
 
-		if (!ring_is_xdp(tx_ring))
-			netif_stop_subqueue(tx_ring->netdev,
-					    tx_ring->queue_index);
+		netif_stop_subqueue(tx_ring->netdev,
+				    tx_ring->queue_index);
 
 		e_info(probe,
 		       "tx hang %d detected on queue %d, resetting adapter\n",
@@ -1297,9 +1294,6 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 		return true;
 	}
 
-	if (ring_is_xdp(tx_ring))
-		return !!budget;
-
 #define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
 	txq = netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
 	if (!__netif_txq_completed_wake(txq, total_packets, total_bytes,
@@ -7796,12 +7790,9 @@ static void ixgbe_check_hang_subtask(struct ixgbe_adapter *adapter)
 		return;
 
 	/* Force detection of hung controller */
-	if (netif_carrier_ok(adapter->netdev)) {
+	if (netif_carrier_ok(adapter->netdev))
 		for (i = 0; i < adapter->num_tx_queues; i++)
 			set_check_for_tx_hang(adapter->tx_ring[i]);
-		for (i = 0; i < adapter->num_xdp_queues; i++)
-			set_check_for_tx_hang(adapter->xdp_ring[i]);
-	}
 
 	if (!(adapter->flags & IXGBE_FLAG_MSIX_ENABLED)) {
 		/*
@@ -8016,13 +8007,6 @@ static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)
 			return true;
 	}
 
-	for (i = 0; i < adapter->num_xdp_queues; i++) {
-		struct ixgbe_ring *ring = adapter->xdp_ring[i];
-
-		if (ring->next_to_use != ring->next_to_clean)
-			return true;
-	}
-
 	return false;
 }
 
@@ -10825,6 +10809,10 @@ static int ixgbe_xdp_xmit(struct net_device *dev, int n,
 	if (unlikely(test_bit(__IXGBE_DOWN, &adapter->state)))
 		return -ENETDOWN;
 
+	if (!netif_carrier_ok(adapter->netdev) ||
+	    !netif_running(adapter->netdev))
+		return -ENETDOWN;
+
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
 		return -EINVAL;
 
-- 
2.38.1


