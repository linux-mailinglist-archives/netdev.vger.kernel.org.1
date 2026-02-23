Return-Path: <netdev+bounces-259990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKfYBrkrnGmcAQQAu9opvQ
	(envelope-from <netdev+bounces-259990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:28:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A501D174DE9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E935630B389D
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8135FF73;
	Mon, 23 Feb 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcI5mcM7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057335B654;
	Mon, 23 Feb 2026 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842185; cv=none; b=oH8MiSeafeeozaZTpZwARrejU3zsldndqsUMAyU6C4AAw5LnGeoVTzOsdoAFi5Avwjf/+PDGJXDA8FG3sGMkKsw8I9H7ctxS3znDSEKEIuphtNxAgVA9d3hhEn/cpkxVMjj1mzc/9CtLicQjt9P+eMekaqO8ORtjzTBFZkoVhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842185; c=relaxed/simple;
	bh=zYvKRYU44cLTr0xZ74FqQOoA6ff7ebXqgTePuAJ4LiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilWHSGJvZ5zrHXhKdnKqHD9X7gqxvHnbtbeCfkZK/oZVUWAHARUs3YvvQj3Rnjhde288mH/8ptiofSKg5DukKuCVNDsr1VO/Ka5PnEeMI3WAxMSzhavFRQX5IAOOxsn1G7046fAnHN4HTTzk7CJPgJ5oDsMtYQJ5IAVIIqHvkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcI5mcM7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771842180; x=1803378180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zYvKRYU44cLTr0xZ74FqQOoA6ff7ebXqgTePuAJ4LiA=;
  b=kcI5mcM7CsUjeJbvuywjlMfcflzZrOEAFwzIHIzqwl/bBh/pFh1tHOhp
   XIIkJVOvrxOQaV/KkeFlsKm0DTV6enA9lJwWtGo3UfWAmFjc3y5Co41c/
   gmI+5/FEp2hbaOsIU4cDgdNLmhiEMkXKo//npSPye8w17FguOk9MPZlW4
   bAfkhab2SeEmTQ5Gf3GWgArjwNGtKF4xCr/3JB479fNYY5q4UDyNObi1D
   mUUkzPla0DRCUOkKDaad7dtRaxeT243LzmfHHla0+4WTvc4OXS2SXubJt
   VDOFs9f7TRqqoJBBNsM+330UY2DvuZ2WDvy/xxmVuZRIaJCVDw5iskszl
   g==;
X-CSE-ConnectionGUID: 5zYQZRmzQPqNzJO8uCIp0w==
X-CSE-MsgGUID: qZ9rFdndSUmTiyOa4qaMJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76444731"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76444731"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 02:22:58 -0800
X-CSE-ConnectionGUID: 1BvZhXR8QiyBq2qSWiVSSQ==
X-CSE-MsgGUID: 1md0WBZzTJGtkfC9tXXX4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246121761"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 23 Feb 2026 02:22:53 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 08D632816F;
	Mon, 23 Feb 2026 10:22:50 +0000 (GMT)
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
Subject: [PATCH iwl-next 05/10] ixgbevf: support XDP multi-buffer on Rx path
Date: Mon, 23 Feb 2026 10:52:12 +0100
Message-ID: <20260223095222.3205363-6-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223095222.3205363-1-larysa.zaremba@intel.com>
References: <20260223095222.3205363-1-larysa.zaremba@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259990-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A501D174DE9
X-Rspamd-Action: no action

Implement XDP support for received fragmented packets, this requires using
some helpers from libeth_xdp.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |  3 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 88 ++++++-------------
 2 files changed, 31 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 698091d42dbd..eada53c57fcf 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
 #include <linux/u64_stats_sync.h>
+#include <net/libeth/types.h>
 #include <net/xdp.h>
 
 #include "vf.h"
@@ -106,7 +107,6 @@ struct ixgbevf_ring {
 	struct xdp_rxq_info xdp_rxq;
 	u64 hw_csum_rx_error;
 	u8 __iomem *tail;
-	struct sk_buff *skb;
 
 	/* holds the special value that gets the hardware register offset
 	 * associated with this ring, which is different for DCB and RSS modes
@@ -114,6 +114,7 @@ struct ixgbevf_ring {
 	u16 reg_idx;
 	int queue_index; /* needed for multiqueue queue management */
 	u32 rx_buf_len;
+	struct libeth_xdp_buff_stash xdp_stash;
 } ____cacheline_internodealigned_in_smp;
 
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 39124c430537..558a4fad543a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -84,6 +84,7 @@ MODULE_DEVICE_TABLE(pci, ixgbevf_pci_tbl);
 
 MODULE_DESCRIPTION("Intel(R) 10 Gigabit Virtual Function Network Driver");
 MODULE_IMPORT_NS("LIBETH");
+MODULE_IMPORT_NS("LIBETH_XDP");
 MODULE_LICENSE("GPL v2");
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
@@ -647,26 +648,6 @@ static bool ixgbevf_cleanup_headers(struct ixgbevf_ring *rx_ring,
 	return false;
 }
 
-/**
- * ixgbevf_add_rx_frag - Add contents of Rx buffer to sk_buff
- * @rx_ring: rx descriptor ring to transact packets on
- * @rx_buffer: buffer containing page to add
- * @skb: sk_buff to place the data into
- * @size: size of buffer to be added
- *
- * This function will add the data contained in rx_buffer->page to the skb.
- **/
-static void ixgbevf_add_rx_frag(const struct libeth_fqe *rx_buffer,
-				struct sk_buff *skb,
-				unsigned int size)
-{
-	u32 hr = netmem_get_pp(rx_buffer->netmem)->p.offset;
-
-	skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
-			       rx_buffer->netmem, rx_buffer->offset + hr,
-			       size, rx_buffer->truesize);
-}
-
 static inline void ixgbevf_irq_enable_queues(struct ixgbevf_adapter *adapter,
 					     u32 qmask)
 {
@@ -803,16 +784,16 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	struct ixgbevf_adapter *adapter = q_vector->adapter;
 	u16 cleaned_count = ixgbevf_desc_unused(rx_ring);
-	struct sk_buff *skb = rx_ring->skb;
 	LIBETH_XDP_ONSTACK_BUFF(xdp);
 	bool xdp_xmit = false;
 	int xdp_res = 0;
 
-	xdp->base.rxq = &rx_ring->xdp_rxq;
+	libeth_xdp_init_buff(xdp, &rx_ring->xdp_stash, &rx_ring->xdp_rxq);
 
 	while (likely(total_rx_packets < budget)) {
 		union ixgbe_adv_rx_desc *rx_desc;
 		struct libeth_fqe *rx_buffer;
+		struct sk_buff *skb;
 		unsigned int size;
 
 		/* return some buffers to hardware, one at a time is too slow */
@@ -833,42 +814,34 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		rmb();
 
 		rx_buffer = &rx_ring->rx_fqes[rx_ring->next_to_clean];
-		libeth_rx_sync_for_cpu(rx_buffer, size);
+		libeth_xdp_process_buff(xdp, rx_buffer, size);
 
-		/* retrieve a buffer from the ring */
-		if (!skb) {
-			libeth_xdp_prepare_buff(xdp, rx_buffer, size);
-			prefetch(xdp->data);
-			xdp_res = ixgbevf_run_xdp(adapter, rx_ring, xdp);
-		}
+		cleaned_count++;
+		/* fetch next buffer in frame if non-eop */
+		if (ixgbevf_is_non_eop(rx_ring, rx_desc))
+			continue;
 
+		xdp_res = ixgbevf_run_xdp(adapter, rx_ring, xdp);
 		if (xdp_res) {
 			if (xdp_res == IXGBEVF_XDP_TX)
 				xdp_xmit = true;
 
 			total_rx_packets++;
 			total_rx_bytes += size;
-		} else if (skb) {
-			ixgbevf_add_rx_frag(rx_buffer, skb, size);
-		} else {
-			skb = xdp_build_skb_from_buff(&xdp->base);
+			continue;
 		}
 
+		skb = xdp_build_skb_from_buff(&xdp->base);
+		xdp->data = NULL;
+
 		/* exit if we failed to retrieve a buffer */
-		if (unlikely(!xdp_res && !skb)) {
+		if (unlikely(!skb)) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			break;
 		}
 
-		cleaned_count++;
-
-		/* fetch next buffer in frame if non-eop */
-		if (ixgbevf_is_non_eop(rx_ring, rx_desc))
-			continue;
-
 		/* verify the packet layout is correct */
-		if (xdp_res ||
-		    unlikely(ixgbevf_cleanup_headers(rx_ring, rx_desc, skb))) {
+		if (unlikely(ixgbevf_cleanup_headers(rx_ring, rx_desc, skb))) {
 			skb = NULL;
 			continue;
 		}
@@ -892,13 +865,10 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		total_rx_packets++;
 
 		ixgbevf_rx_skb(q_vector, skb);
-
-		/* reset skb pointer */
-		skb = NULL;
 	}
 
 	/* place incomplete frames back on ring for completion */
-	rx_ring->skb = skb;
+	libeth_xdp_save_buff(&rx_ring->xdp_stash, xdp);
 
 	if (xdp_xmit) {
 		struct ixgbevf_ring *xdp_ring =
@@ -2018,10 +1988,7 @@ void ixgbevf_up(struct ixgbevf_adapter *adapter)
 static void ixgbevf_clean_rx_ring(struct ixgbevf_ring *rx_ring)
 {
 	/* Free Rx ring sk_buff */
-	if (rx_ring->skb) {
-		dev_kfree_skb(rx_ring->skb);
-		rx_ring->skb = NULL;
-	}
+	libeth_xdp_return_stash(&rx_ring->xdp_stash);
 
 	/* Free all the Rx ring pages */
 	for (u32 i = rx_ring->next_to_clean; i != rx_ring->next_to_use; ) {
@@ -4101,16 +4068,19 @@ ixgbevf_features_check(struct sk_buff *skb, struct net_device *dev,
 	return features;
 }
 
-static int ixgbevf_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
+static int ixgbevf_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
+			     struct netlink_ext_ack *extack)
 {
-	int i, frame_size = dev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+	u32 frame_size = READ_ONCE(dev->mtu) + LIBETH_RX_LL_LEN;
 	struct ixgbevf_adapter *adapter = netdev_priv(dev);
 	struct bpf_prog *old_prog;
+	bool requires_mbuf;
 
-	/* verify ixgbevf ring attributes are sufficient for XDP */
-	for (i = 0; i < adapter->num_rx_queues; i++) {
-		if (frame_size > IXGBEVF_RXBUFFER_3072)
-			return -EINVAL;
+	requires_mbuf = frame_size > IXGBEVF_RX_PAGE_LEN(LIBETH_XDP_HEADROOM);
+	if (prog && !prog->aux->xdp_has_frags && requires_mbuf) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Configured MTU requires non-linear frames and XDP prog does not support frags");
+		return -EOPNOTSUPP;
 	}
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
@@ -4130,7 +4100,7 @@ static int ixgbevf_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 		if (netif_running(dev))
 			ixgbevf_open(dev);
 	} else {
-		for (i = 0; i < adapter->num_rx_queues; i++)
+		for (int i = 0; i < adapter->num_rx_queues; i++)
 			xchg(&adapter->rx_ring[i]->xdp_prog, adapter->xdp_prog);
 	}
 
@@ -4144,7 +4114,7 @@ static int ixgbevf_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
-		return ixgbevf_xdp_setup(dev, xdp->prog);
+		return ixgbevf_xdp_setup(dev, xdp->prog, xdp->extack);
 	default:
 		return -EINVAL;
 	}
@@ -4296,7 +4266,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			    NETIF_F_HW_VLAN_CTAG_TX;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
-	netdev->xdp_features = NETDEV_XDP_ACT_BASIC;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_RX_SG;
 
 	/* MTU range: 68 - 1504 or 9710 */
 	netdev->min_mtu = ETH_MIN_MTU;
-- 
2.52.0


