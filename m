Return-Path: <netdev+bounces-287190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FqqDAY9A2oq2AEAu9opvQ
	(envelope-from <netdev+bounces-287190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:45:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DB522D5E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64228309477B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D8F3AB481;
	Tue, 12 May 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOFUtDd3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E73A7D81
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594952; cv=none; b=YzuEz3JSjqUWxZ8FKQumeO6VO0SupYmdltRKVdanVIs6ipwehBAnn/ysm5sBwylx8OmiN7dnK8IdRt605z7KVGXjCm+dkpzknJSbs6qUtwWPpL4YHh1CLcf1vhOX23i3RzrYVcjoe7qWb3T/5QuDtQxpb4aEvkEimc6iFLaumSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594952; c=relaxed/simple;
	bh=nBacYxhuC6bRW2k/59nME7qF1sTS/76EbllfIfcCE0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNLKR7Cq7UWvZ/JekoRLjJLFL6etHbamSai0I95WIcrDyITxe8vAlt2bWLOa6kdpZoyfG5iIuu+6LbROFHjAYNvjuYilj8VOvxjNWHpBvswjKD+ALWqQwlkFYtXUPY/ZPAalrzA/iCWtbG6QwLrDGkWp9z1WOuryNTyTL6sr5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOFUtDd3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778594950; x=1810130950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nBacYxhuC6bRW2k/59nME7qF1sTS/76EbllfIfcCE0w=;
  b=KOFUtDd3wzhXSCZRVdIjFq3bOGxkspSKzlMci9tYHELCFLCwHWgKVZZl
   raS4R6Kd7nAWRytDxxzUGZ0XQsITxtOnmNTnYRAEUwzeqxvAbCnQ4oich
   5B+0d9n5I2V0B8qd8g8n9OihM8wanyxbK/9SwRLThl2BUxcgr9edCGRUf
   fYs1pySjFDF3pyFa7W2CLUSfnZu4gS9QxzuvmLs7uyfyxHVr4kEzfAB1x
   f/7KTw/2OjFrWAB85kKxmAtRuehLGmTWk8DA16hUM6vTMb/iP3knI9YXY
   qIyRUsRtU80anz0okWphrBZ7dzty/h8f+NC5Fz8SRhIBc9RIRKjaTa+Ry
   A==;
X-CSE-ConnectionGUID: +Le+tLGDTEKJ7QjmqNqszQ==
X-CSE-MsgGUID: VX58kbavRmGMDQe6UrSCdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96929655"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="96929655"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:09:09 -0700
X-CSE-ConnectionGUID: D/4kVDM+TnyCxThvEfzQOQ==
X-CSE-MsgGUID: IAYq5IS4QWy1JjpFoOLmoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="275892471"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 12 May 2026 07:09:08 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 1/8] ixgbe: rename numa_node to node in struct ixgbe_q_vector
Date: Tue, 12 May 2026 16:08:57 +0200
Message-ID: <20260512140904.4105236-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
References: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 348DB522D5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287190-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jacob Keller <jacob.e.keller@intel.com>

The 'numa_node' field in struct ixgbe_q_vector shadows the 'numa_node'
accessor for struct device, which triggers a sparse warning about
shadowing a built-in object.  The stored value here is a plain NUMA
node number, not a device attribute, so rename it to 'node' to avoid
the shadow and keep the naming consistent with other Intel drivers.

Update all three usage sites in ixgbe_lib.c and ixgbe_main.c.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 9b82175..cf2df18 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -515,7 +515,7 @@ struct ixgbe_q_vector {
 	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	cpumask_t affinity_mask;
-	int numa_node;
+	int node;
 	char name[IFNAMSIZ + 9];
 
 	/* for dynamic allocation of rings associated with this q_vector */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 1db4bd5..5a4f05d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -864,7 +864,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 	/* setup affinity mask and node */
 	if (cpu != -1)
 		cpumask_set_cpu(cpu, &q_vector->affinity_mask);
-	q_vector->numa_node = node;
+	q_vector->node = node;
 
 #ifdef CONFIG_IXGBE_DCA
 	/* initialize CPU for DCA */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2646ee6..65426a1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7074,7 +7074,7 @@ int ixgbe_setup_tx_resources(struct ixgbe_ring *tx_ring)
 	size = sizeof(struct ixgbe_tx_buffer) * tx_ring->count;
 
 	if (tx_ring->q_vector)
-		ring_node = tx_ring->q_vector->numa_node;
+		ring_node = tx_ring->q_vector->node;
 
 	tx_ring->tx_buffer_info = vmalloc_node(size, ring_node);
 	if (!tx_ring->tx_buffer_info)
@@ -7175,7 +7175,7 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 	size = sizeof(struct ixgbe_rx_buffer) * rx_ring->count;
 
 	if (rx_ring->q_vector)
-		ring_node = rx_ring->q_vector->numa_node;
+		ring_node = rx_ring->q_vector->node;
 
 	rx_ring->rx_buffer_info = vmalloc_node(size, ring_node);
 	if (!rx_ring->rx_buffer_info)
-- 
2.52.0


