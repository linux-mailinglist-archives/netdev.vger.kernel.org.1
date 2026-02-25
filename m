Return-Path: <netdev+bounces-261045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLtgNuM8n2kiZgQAu9opvQ
	(envelope-from <netdev+bounces-261045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:18:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 411A819C23D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ABDF30A6264
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47E2E54BD;
	Wed, 25 Feb 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCcIVGly"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C62E62B4;
	Wed, 25 Feb 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043451; cv=none; b=Kxz4yMRy77pukae++eS9dUBSUnZN8i5oCTjYXDqHRgP+W+C24aOUZOqvkCs7asbGcisSlfa8eWsuMj8wuyU4erBT5PhudtDcpFV7zjs+GR/Sfd3QrmHuJmJiROIZfOjUhv5ALRLQefwOQ7OpmNUZAzEhgfmt26qW1ditk2pB+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043451; c=relaxed/simple;
	bh=Ke6+QbjnyUTSUQFkmee1e2Rk94DLTg4rABOI+jHVLmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBHNfmQoD8hSg3UP88bihKRDmWQxMOpqVD0mIpxnedy7tR5Y5LwqGzKgM/jIhURO8wJAefa3GpXB3rzWwomwJp3lmhMv1E6wF/DOHqg/sXOWTzYQqTicQWL3uv7vzDX5o8Z5UBHWkL1j3O0L5ak9fE7NEKwZx/wihsj4SQ+wmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCcIVGly; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772043449; x=1803579449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ke6+QbjnyUTSUQFkmee1e2Rk94DLTg4rABOI+jHVLmM=;
  b=SCcIVGlyedpvYyF68cuUubWSYF6qjGmBAB8fukcQaJM4lZMdAv172slV
   WendmCaNRpt/nEMJ94WHqWv+cRDRpboE7Ks7whH+HA0VUA69qGLbJZuf8
   DajitjJBa4x+ZwTBK/iqg1TCkwXEUf/zUXE1nZPy2blklt/YyLRiVSEw+
   St3RDXPTxg8MP+jSmtEEubZqAAqvZQoB3H0lRpvDuy+lX2TZ0SmO2jjnn
   01dp43wDgpzCP4dqSe/iM0okWsu5YNCTTsUna8+A7Iq8qeYbZ98N8dXWn
   U4wGo19X8t1W/EbAGMwOS7ZU/hDdHNUBnAxX5sEBO1fqecKfqD6zKSwBe
   Q==;
X-CSE-ConnectionGUID: BMm0xOkPRdWeXhKb3sL+ew==
X-CSE-MsgGUID: E2l6AeLEQxWYjrvfK+hANg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="72967642"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="72967642"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 10:17:29 -0800
X-CSE-ConnectionGUID: qnQOEIZYQBuArrbrS9tX7g==
X-CSE-MsgGUID: 2FR3vcgmT0+xhiWLOmEyMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="254070301"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 25 Feb 2026 10:17:24 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 571AB32C86;
	Wed, 25 Feb 2026 18:17:22 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v2 01/10] ixgbevf: remove legacy Rx
Date: Wed, 25 Feb 2026 18:46:35 +0100
Message-ID: <20260225174646.3514556-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225174646.3514556-1-larysa.zaremba@intel.com>
References: <20260225174646.3514556-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261045-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 411A819C23D
X-Rspamd-Action: no action

Similarly as in commit 53844673d555 ("iavf: kill "legacy-rx" for good"),
drop skb construction logic in favor of only using napi_build_skb() as a
superior option that reduces the need to allocate and copy memory.

As IXGBEVF_PRIV_FLAGS_LEGACY_RX is the only private flag in ixgbevf,
entirely remove private flags support from the driver.

When compared to iavf changes, ixgbevf has a single complication: MAC type
82599 cannot finely limit the DMA write size with RXDCTL.RLPML, only 1024
increments through SRRCTL are available, see commit fe68195daf34
("ixgbevf: Require large buffers for build_skb on 82599VF") and commit
2bafa8fac19a ("ixgbe: don't set RXDCTL.RLPML for 82599"). Therefore, this
is a special case requiring legacy RX unless large buffers are used. For
now, solve this by always using large buffers for this MAC type.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |  48 --------
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |  13 +--
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 106 ++----------------
 3 files changed, 13 insertions(+), 154 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 537a60d5276f..274eef39c586 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -72,13 +72,6 @@ static const char ixgbe_gstrings_test[][ETH_GSTRING_LEN] = {
 
 #define IXGBEVF_TEST_LEN (sizeof(ixgbe_gstrings_test) / ETH_GSTRING_LEN)
 
-static const char ixgbevf_priv_flags_strings[][ETH_GSTRING_LEN] = {
-#define IXGBEVF_PRIV_FLAGS_LEGACY_RX	BIT(0)
-	"legacy-rx",
-};
-
-#define IXGBEVF_PRIV_FLAGS_STR_LEN ARRAY_SIZE(ixgbevf_priv_flags_strings)
-
 static int ixgbevf_get_link_ksettings(struct net_device *netdev,
 				      struct ethtool_link_ksettings *cmd)
 {
@@ -216,8 +209,6 @@ static void ixgbevf_get_drvinfo(struct net_device *netdev,
 	strscpy(drvinfo->driver, ixgbevf_driver_name, sizeof(drvinfo->driver));
 	strscpy(drvinfo->bus_info, pci_name(adapter->pdev),
 		sizeof(drvinfo->bus_info));
-
-	drvinfo->n_priv_flags = IXGBEVF_PRIV_FLAGS_STR_LEN;
 }
 
 static void ixgbevf_get_ringparam(struct net_device *netdev,
@@ -409,8 +400,6 @@ static int ixgbevf_get_sset_count(struct net_device *netdev, int stringset)
 		return IXGBEVF_TEST_LEN;
 	case ETH_SS_STATS:
 		return IXGBEVF_STATS_LEN;
-	case ETH_SS_PRIV_FLAGS:
-		return IXGBEVF_PRIV_FLAGS_STR_LEN;
 	default:
 		return -EINVAL;
 	}
@@ -538,10 +527,6 @@ static void ixgbevf_get_strings(struct net_device *netdev, u32 stringset,
 			p += ETH_GSTRING_LEN;
 		}
 		break;
-	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, ixgbevf_priv_flags_strings,
-		       IXGBEVF_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
-		break;
 	}
 }
 
@@ -931,37 +916,6 @@ static int ixgbevf_get_rxfh(struct net_device *netdev,
 	return err;
 }
 
-static u32 ixgbevf_get_priv_flags(struct net_device *netdev)
-{
-	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
-	u32 priv_flags = 0;
-
-	if (adapter->flags & IXGBEVF_FLAGS_LEGACY_RX)
-		priv_flags |= IXGBEVF_PRIV_FLAGS_LEGACY_RX;
-
-	return priv_flags;
-}
-
-static int ixgbevf_set_priv_flags(struct net_device *netdev, u32 priv_flags)
-{
-	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
-	unsigned int flags = adapter->flags;
-
-	flags &= ~IXGBEVF_FLAGS_LEGACY_RX;
-	if (priv_flags & IXGBEVF_PRIV_FLAGS_LEGACY_RX)
-		flags |= IXGBEVF_FLAGS_LEGACY_RX;
-
-	if (flags != adapter->flags) {
-		adapter->flags = flags;
-
-		/* reset interface to repopulate queues */
-		if (netif_running(netdev))
-			ixgbevf_reinit_locked(adapter);
-	}
-
-	return 0;
-}
-
 static const struct ethtool_ops ixgbevf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.get_drvinfo		= ixgbevf_get_drvinfo,
@@ -984,8 +938,6 @@ static const struct ethtool_ops ixgbevf_ethtool_ops = {
 	.get_rxfh_key_size	= ixgbevf_get_rxfh_key_size,
 	.get_rxfh		= ixgbevf_get_rxfh,
 	.get_link_ksettings	= ixgbevf_get_link_ksettings,
-	.get_priv_flags		= ixgbevf_get_priv_flags,
-	.set_priv_flags		= ixgbevf_set_priv_flags,
 };
 
 void ixgbevf_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 516a6fdd23d0..ae2763fea2be 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -73,7 +73,6 @@ struct ixgbevf_rx_queue_stats {
 
 enum ixgbevf_ring_state_t {
 	__IXGBEVF_RX_3K_BUFFER,
-	__IXGBEVF_RX_BUILD_SKB_ENABLED,
 	__IXGBEVF_TX_DETECT_HANG,
 	__IXGBEVF_HANG_CHECK_ARMED,
 	__IXGBEVF_TX_XDP_RING,
@@ -176,21 +175,13 @@ struct ixgbevf_ring {
 #define clear_ring_uses_large_buffer(ring) \
 	clear_bit(__IXGBEVF_RX_3K_BUFFER, &(ring)->state)
 
-#define ring_uses_build_skb(ring) \
-	test_bit(__IXGBEVF_RX_BUILD_SKB_ENABLED, &(ring)->state)
-#define set_ring_build_skb_enabled(ring) \
-	set_bit(__IXGBEVF_RX_BUILD_SKB_ENABLED, &(ring)->state)
-#define clear_ring_build_skb_enabled(ring) \
-	clear_bit(__IXGBEVF_RX_BUILD_SKB_ENABLED, &(ring)->state)
-
 static inline unsigned int ixgbevf_rx_bufsz(struct ixgbevf_ring *ring)
 {
 #if (PAGE_SIZE < 8192)
 	if (ring_uses_large_buffer(ring))
 		return IXGBEVF_RXBUFFER_3072;
 
-	if (ring_uses_build_skb(ring))
-		return IXGBEVF_MAX_FRAME_BUILD_SKB;
+	return IXGBEVF_MAX_FRAME_BUILD_SKB;
 #endif
 	return IXGBEVF_RXBUFFER_2048;
 }
@@ -377,8 +368,6 @@ struct ixgbevf_adapter {
 	u32 flags;
 	bool link_state;
 
-#define IXGBEVF_FLAGS_LEGACY_RX		BIT(1)
-
 #ifdef CONFIG_XFRM
 	struct ixgbevf_ipsec *ipsec;
 #endif /* CONFIG_XFRM */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d5ce20f47def..fc48c89c7bb8 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -602,7 +602,7 @@ static bool ixgbevf_is_non_eop(struct ixgbevf_ring *rx_ring,
 
 static inline unsigned int ixgbevf_rx_offset(struct ixgbevf_ring *rx_ring)
 {
-	return ring_uses_build_skb(rx_ring) ? IXGBEVF_SKB_PAD : 0;
+	return IXGBEVF_SKB_PAD;
 }
 
 static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
@@ -832,9 +832,7 @@ static void ixgbevf_add_rx_frag(struct ixgbevf_ring *rx_ring,
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
 #else
-	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
-				SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size) :
-				SKB_DATA_ALIGN(size);
+	unsigned int truesize = SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size);
 #endif
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
 			rx_buffer->page_offset, size, truesize);
@@ -845,74 +843,6 @@ static void ixgbevf_add_rx_frag(struct ixgbevf_ring *rx_ring,
 #endif
 }
 
-static
-struct sk_buff *ixgbevf_construct_skb(struct ixgbevf_ring *rx_ring,
-				      struct ixgbevf_rx_buffer *rx_buffer,
-				      struct xdp_buff *xdp,
-				      union ixgbe_adv_rx_desc *rx_desc)
-{
-	unsigned int size = xdp->data_end - xdp->data;
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
-#else
-	unsigned int truesize = SKB_DATA_ALIGN(xdp->data_end -
-					       xdp->data_hard_start);
-#endif
-	unsigned int headlen;
-	struct sk_buff *skb;
-
-	/* prefetch first cache line of first page */
-	net_prefetch(xdp->data);
-
-	/* Note, we get here by enabling legacy-rx via:
-	 *
-	 *    ethtool --set-priv-flags <dev> legacy-rx on
-	 *
-	 * In this mode, we currently get 0 extra XDP headroom as
-	 * opposed to having legacy-rx off, where we process XDP
-	 * packets going to stack via ixgbevf_build_skb().
-	 *
-	 * For ixgbevf_construct_skb() mode it means that the
-	 * xdp->data_meta will always point to xdp->data, since
-	 * the helper cannot expand the head. Should this ever
-	 * changed in future for legacy-rx mode on, then lets also
-	 * add xdp->data_meta handling here.
-	 */
-
-	/* allocate a skb to store the frags */
-	skb = napi_alloc_skb(&rx_ring->q_vector->napi, IXGBEVF_RX_HDR_SIZE);
-	if (unlikely(!skb))
-		return NULL;
-
-	/* Determine available headroom for copy */
-	headlen = size;
-	if (headlen > IXGBEVF_RX_HDR_SIZE)
-		headlen = eth_get_headlen(skb->dev, xdp->data,
-					  IXGBEVF_RX_HDR_SIZE);
-
-	/* align pull length to size of long to optimize memcpy performance */
-	memcpy(__skb_put(skb, headlen), xdp->data,
-	       ALIGN(headlen, sizeof(long)));
-
-	/* update all of the pointers */
-	size -= headlen;
-	if (size) {
-		skb_add_rx_frag(skb, 0, rx_buffer->page,
-				(xdp->data + headlen) -
-					page_address(rx_buffer->page),
-				size, truesize);
-#if (PAGE_SIZE < 8192)
-		rx_buffer->page_offset ^= truesize;
-#else
-		rx_buffer->page_offset += truesize;
-#endif
-	} else {
-		rx_buffer->pagecnt_bias++;
-	}
-
-	return skb;
-}
-
 static inline void ixgbevf_irq_enable_queues(struct ixgbevf_adapter *adapter,
 					     u32 qmask)
 {
@@ -1092,10 +1022,8 @@ static unsigned int ixgbevf_rx_frame_truesize(struct ixgbevf_ring *rx_ring,
 #if (PAGE_SIZE < 8192)
 	truesize = ixgbevf_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
 #else
-	truesize = ring_uses_build_skb(rx_ring) ?
-		SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size) +
-		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
-		SKB_DATA_ALIGN(size);
+	truesize = SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size) +
+		   SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 #endif
 	return truesize;
 }
@@ -1182,12 +1110,9 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			total_rx_bytes += size;
 		} else if (skb) {
 			ixgbevf_add_rx_frag(rx_ring, rx_buffer, skb, size);
-		} else if (ring_uses_build_skb(rx_ring)) {
+		} else {
 			skb = ixgbevf_build_skb(rx_ring, rx_buffer,
 						&xdp, rx_desc);
-		} else {
-			skb = ixgbevf_construct_skb(rx_ring, rx_buffer,
-						    &xdp, rx_desc);
 		}
 
 		/* exit if we failed to retrieve a buffer */
@@ -1958,8 +1883,7 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 
 #if (PAGE_SIZE < 8192)
 		/* Limit the maximum frame size so we don't overrun the skb */
-		if (ring_uses_build_skb(ring) &&
-		    !ring_uses_large_buffer(ring))
+		if (!ring_uses_large_buffer(ring))
 			rxdctl |= IXGBEVF_MAX_FRAME_BUILD_SKB |
 				  IXGBE_RXDCTL_RLPML_EN;
 #endif
@@ -1978,22 +1902,16 @@ static void ixgbevf_set_rx_buffer_len(struct ixgbevf_adapter *adapter,
 	struct net_device *netdev = adapter->netdev;
 	unsigned int max_frame = netdev->mtu + ETH_HLEN + ETH_FCS_LEN;
 
-	/* set build_skb and buffer size flags */
-	clear_ring_build_skb_enabled(rx_ring);
+	/* set buffer size flags */
 	clear_ring_uses_large_buffer(rx_ring);
 
-	if (adapter->flags & IXGBEVF_FLAGS_LEGACY_RX)
-		return;
-
 	if (PAGE_SIZE < 8192)
-		if (max_frame > IXGBEVF_MAX_FRAME_BUILD_SKB)
+		/* 82599 can't rely on RXDCTL.RLPML to restrict
+		 * the size of the frame
+		 */
+		if (max_frame > IXGBEVF_MAX_FRAME_BUILD_SKB ||
+		    adapter->hw.mac.type == ixgbe_mac_82599_vf)
 			set_ring_uses_large_buffer(rx_ring);
-
-	/* 82599 can't rely on RXDCTL.RLPML to restrict the size of the frame */
-	if (adapter->hw.mac.type == ixgbe_mac_82599_vf && !ring_uses_large_buffer(rx_ring))
-		return;
-
-	set_ring_build_skb_enabled(rx_ring);
 }
 
 /**
-- 
2.52.0


