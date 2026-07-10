Return-Path: <netdev+bounces-306685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TXDFB8ZLUWo1CAMAu9opvQ
	(envelope-from <netdev+bounces-306685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:45:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A57CB73DE7A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:45:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="g/wcoZpG";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306685-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306685-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BB0D3010624
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3219738E8A3;
	Fri, 10 Jul 2026 19:45:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B938C2DB;
	Fri, 10 Jul 2026 19:45:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712706; cv=none; b=D+fkdF0zieEEDz8dnqE73VcjmHMltCc7ha0W/sdaQhZpgWHVU/Y7Lp+txFApyFvNQec8kWdjB4RN1w8dmvifPseJxe4Bt0f4HaONY78dZOB1f7NmHXTqMs3TfFQ5Koq7POJHvVaOv8hoYiyMX12XPjObZUYwQXDxydatwyAiFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712706; c=relaxed/simple;
	bh=HIevhjnk1LDSy8iYJe7dD2+8yRMMZSbygyMze6y9eeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmjnmZr08Jhwqp5wYRnt9XRGZZK2BevGRhHVr8xYko5JBihYJohqDPI3A+J8YNKk3qLx5bEae5MNLC37KnS7Ajqb2Rg4uKsaTKba/ZfLLt/QGFEH+if/vf/qHpTcEbWE8naDEmgm50EgzY0RfBGytoxPCepX7pdtgUqLS66duY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/wcoZpG; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783712703; x=1815248703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HIevhjnk1LDSy8iYJe7dD2+8yRMMZSbygyMze6y9eeE=;
  b=g/wcoZpG2QMKy0HnZ3GUlT3SKchwsMg1oJlYcKRsEQj+YQWwb25MDp1A
   6E7MpXrA6TeOxVBF2l/8FSjHh+FSCgXLMFtrQ5hnh3B1UDqJEO7+Dgj4R
   Ik98/R6wPSlNg68TjACXu4QbvPo5vzVC2YKAQXQD3mEoTm957Hefs7tB4
   lH7osn4VU2Zw+yg7PBNHQs5j1TO0RUg/+LDTGMUQjH1aZ/fjd/JZGy+bF
   11jcnr8H0huD0z8/DR42JN44FDgbEpNQ+49+rdFL4wQxuEioM4VFK35zn
   A+2BG2KsiJ7tzgD2oE0CP2PBWrwy7zN5QZdau0kqn02ieZLTCcZTXbzHk
   A==;
X-CSE-ConnectionGUID: r1sLcloaRyG3Cfqau7di/w==
X-CSE-MsgGUID: B8JhUJx1Qri1yQWxM8CLXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101965219"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101965219"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 12:45:02 -0700
X-CSE-ConnectionGUID: l0+9joKpSVaL6G4b+SE7Kw==
X-CSE-MsgGUID: n9M4DVaDTl2Iij18QcG7kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293157278"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 10 Jul 2026 12:44:59 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net 3/5] xsk: reclaim invalid multi-buffer Tx descs in ZC path
Date: Fri, 10 Jul 2026 21:44:22 +0200
Message-Id: <20260710194424.84844-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
References: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306685-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A57CB73DE7A

The zero-copy Tx batch parser stops when it encounters an invalid
descriptor. If this happens after one or more continuation descriptors,
the Tx consumer can be advanced past fragments that are neither submitted
to the driver nor returned to userspace through the completion ring.

A similar problem occurs when a packet exceeds xdp_zc_max_segs. The
descriptors consumed up to the limit are released without completion, and
the remaining continuation descriptors can subsequently be interpreted
as the beginning of another packet.

Parse Tx batches in packet units and distinguish descriptors belonging to
complete valid packets from descriptors consumed while draining an
invalid or oversized packet. Return the former to the driver and append
the latter to the CQ address area so userspace can reclaim their UMEM
frames.

Once draining starts, continue until the packet's end-of-packet
descriptor is consumed. Preserve the drain state on the socket when EOP
has not yet been supplied, so draining can continue during a later call.
Leave incomplete but otherwise valid packets on the Tx ring. Keep the
existing handling of standalone invalid descriptors unchanged.

Shared-UMEM pools using multi-buffer Tx also need packet-framed parsing.
Walk their Tx sockets one packet at a time, preserving the existing
per-socket fairness scheme, instead of using the legacy one-descriptor
fallback. Keep that fallback for shared pools that do not use
multi-buffer Tx. Since the drain state is maintained per socket and both
the singular and shared paths can resume an interrupted drain, changing
the socket list from singular to shared requires no special bind-time
transition.

CQ entries are positional, and drivers may complete only part of the Tx
work returned by xsk_tx_peek_release_desc_batch(). Therefore, reclaim-only
entries cannot be published immediately when earlier driver-visible
descriptors are still outstanding.

Track the number of driver-visible CQ entries preceding the reclaim
entries. Let xsk_tx_completed() publish partial real Tx completions, and
publish the reclaim entries only after every earlier Tx descriptor has
completed. Complete a reclaim-only batch immediately when there is no
driver-visible work in front of it, and prevent another Tx batch from
being appended while reclaim entries remain pending.

Also cap batch processing by the size of the pool's temporary descriptor
array, as Tx rings belonging to sockets sharing a UMEM may have different
sizes.

This ensures that every descriptor consumed as part of an invalid
multi-buffer packet is eventually returned to userspace without exposing
the dropped packet to the driver or violating CQ completion ordering.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xsk_buff_pool.h |   3 +
 net/xdp/xsk.c               | 187 +++++++++++++++++++++++++++++++++---
 net/xdp/xsk_buff_pool.c     |   1 +
 net/xdp/xsk_queue.h         |  76 +++++++++++----
 4 files changed, 235 insertions(+), 32 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index ccb3b350001f..fb59e205ac7d 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -78,6 +78,9 @@ struct xsk_buff_pool {
 	u32 chunk_size;
 	u32 chunk_shift;
 	u32 frame_len;
+	u32 tx_descs_nentries;
+	u32 reclaim_descs;
+	u32 tx_zc_pending_descs;
 	u32 xdp_zc_max_segs;
 	u8 tx_metadata_len; /* inherited from umem */
 	u8 cached_need_wakeup;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 43791647cf18..7d8b42c4c214 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -499,6 +499,23 @@ void __xsk_map_flush(struct list_head *flush_list)
 
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 {
+	u32 reclaim_descs = READ_ONCE(pool->reclaim_descs);
+
+	if (unlikely(reclaim_descs)) {
+		u32 pending_descs = READ_ONCE(pool->tx_zc_pending_descs);
+
+		if (nb_entries < pending_descs) {
+			WRITE_ONCE(pool->tx_zc_pending_descs,
+				   pending_descs - nb_entries);
+			xskq_prod_submit_n(pool->cq, nb_entries);
+			return;
+		}
+
+		WRITE_ONCE(pool->tx_zc_pending_descs, 0);
+		nb_entries += reclaim_descs;
+		WRITE_ONCE(pool->reclaim_descs, 0);
+	}
+
 	xskq_prod_submit_n(pool->cq, nb_entries);
 }
 EXPORT_SYMBOL(xsk_tx_completed);
@@ -574,22 +591,169 @@ static u32 xsk_tx_peek_release_fallback(struct xsk_buff_pool *pool, u32 max_entr
 	return nb_pkts;
 }
 
+static void xsk_tx_commit_batch(struct xsk_buff_pool *pool,
+				struct xsk_tx_batch *batch,
+				u32 cq_cached_prod)
+{
+	u32 nb_descs = xsk_tx_batch_cq_descs(batch);
+
+	if (!nb_descs)
+		return;
+
+	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_descs);
+
+	if (unlikely(batch->reclaim_descs)) {
+		u32 cq_pending_descs;
+
+		/* CQ is positional. Descriptors already written but not
+		 * submitted must complete before any reclaim-only descriptors
+		 * appended below.
+		 */
+		cq_pending_descs = cq_cached_prod - xskq_get_prod(pool->cq);
+
+		WRITE_ONCE(pool->tx_zc_pending_descs, batch->tx_descs + cq_pending_descs);
+		WRITE_ONCE(pool->reclaim_descs, batch->reclaim_descs);
+		if (unlikely(!pool->tx_zc_pending_descs))
+			xsk_tx_completed(pool, 0);
+	}
+}
+
+static struct xsk_tx_batch
+__xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_sock *xs,
+				 struct xdp_desc *descs, u32 max_descs)
+{
+	struct xsk_tx_batch batch = {};
+	u32 entries;
+
+	entries = xskq_cons_nb_entries(xs->tx, max_descs);
+	if (!entries)
+		return batch;
+
+	batch = xskq_cons_read_desc_batch(xs, pool, descs, entries);
+	if (!xsk_tx_batch_cq_descs(&batch)) {
+		xs->tx->queue_empty_descs++;
+		if (batch.consumed_descs) {
+			__xskq_cons_release(xs->tx);
+			xs->sk.sk_write_space(&xs->sk);
+		}
+		return batch;
+	}
+
+	__xskq_cons_release(xs->tx);
+	xs->sk.sk_write_space(&xs->sk);
+	return batch;
+}
+
+static struct xsk_tx_batch
+xsk_tx_peek_release_shared_desc_batch(struct xsk_buff_pool *pool, u32 max_descs)
+{
+	u32 cq_descs_before, cq_descs_after;
+	struct xsk_tx_batch sum_batch = {};
+	bool budget_exhausted;
+	u32 per_socket_budget;
+	struct xdp_sock *xs;
+
+	max_descs = xskq_prod_nb_free(pool->cq, max_descs);
+	if (!max_descs)
+		return sum_batch;
+
+	/* The fairness quota must allow one maximum-sized valid packet. */
+	per_socket_budget = max_t(u32, MAX_PER_SOCKET_BUDGET,
+				  pool->xdp_zc_max_segs);
+
+again:
+	budget_exhausted = false;
+	cq_descs_before = xsk_tx_batch_cq_descs(&sum_batch);
+	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+		u32 budget, budget_left, offset, remaining;
+		struct xsk_tx_batch curr_batch;
+
+		/* Once reclaim-only descriptors have been appended to the CQ address
+		 * area, do not append driver-visible Tx descriptors from another
+		 * socket after them. xsk_tx_completed() relies on all driver-visible
+		 * descriptors preceding all reclaim-only descriptors in CQ order.
+		 */
+		if (sum_batch.reclaim_descs)
+			break;
+
+		/* be gentle when playing with pool->tx_descs */
+		offset = xsk_tx_batch_cq_descs(&sum_batch);
+		if (offset >= max_descs)
+			break;
+
+		if (xs->tx_budget_spent >= per_socket_budget) {
+			if (xskq_cons_nb_entries(xs->tx, 1))
+				budget_exhausted = true;
+			continue;
+		}
+
+		budget_left = per_socket_budget - xs->tx_budget_spent;
+		remaining = max_descs - offset;
+		budget = min(remaining, budget_left);
+
+		curr_batch = __xsk_tx_peek_release_desc_batch(pool, xs,
+							      pool->tx_descs + offset,
+							      budget);
+		if (!xsk_tx_batch_cq_descs(&curr_batch)) {
+			if (curr_batch.budget_limited && budget_left < remaining)
+				budget_exhausted = true;
+			xs->tx_budget_spent += curr_batch.consumed_descs;
+			continue;
+		}
+
+		xs->tx_budget_spent += curr_batch.consumed_descs;
+		sum_batch.tx_descs += curr_batch.tx_descs;
+		sum_batch.reclaim_descs += curr_batch.reclaim_descs;
+	}
+
+	cq_descs_after = xsk_tx_batch_cq_descs(&sum_batch);
+
+	if (sum_batch.reclaim_descs || cq_descs_after >= max_descs)
+		return sum_batch;
+
+	/* Continue filling the batch while this pass made progress */
+	if (cq_descs_before != cq_descs_after)
+		goto again;
+
+	if (!budget_exhausted)
+		return sum_batch;
+
+	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list)
+		xs->tx_budget_spent = 0;
+	goto again;
+}
+
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 {
+	struct xsk_tx_batch batch = {};
 	struct xdp_sock *xs;
+	u32 cq_cached_prod;
 
 	rcu_read_lock();
+	if (unlikely(READ_ONCE(pool->reclaim_descs)))
+		goto out;
+	nb_pkts = min(nb_pkts, pool->tx_descs_nentries);
+	if (!nb_pkts)
+		goto out;
 	if (!list_is_singular(&pool->xsk_tx_list)) {
-		/* Fallback to the non-batched version */
+		/* Keep the legacy one-descriptor fallback for non-SG users.  The
+		 * shared SG path needs packet-framed parsing so invalid/overflowed
+		 * multi-buffer packets are drained as a unit.
+		 */
+		if (pool->umem->flags & XDP_UMEM_SG_FLAG) {
+			batch = xsk_tx_peek_release_shared_desc_batch(pool, nb_pkts);
+			cq_cached_prod = pool->cq->cached_prod;
+			xsk_tx_commit_batch(pool, &batch, cq_cached_prod);
+			goto out;
+		}
+
 		rcu_read_unlock();
 		return xsk_tx_peek_release_fallback(pool, nb_pkts);
 	}
 
 	xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock, tx_list);
-	if (!xs) {
-		nb_pkts = 0;
+	if (!xs)
 		goto out;
-	}
 
 	nb_pkts = xskq_cons_nb_entries(xs->tx, nb_pkts);
 
@@ -603,19 +767,18 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 	if (!nb_pkts)
 		goto out;
 
-	nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
-	if (!nb_pkts) {
-		xs->tx->queue_empty_descs++;
+	batch = __xsk_tx_peek_release_desc_batch(pool, xs, pool->tx_descs,
+						 nb_pkts);
+	nb_pkts = xsk_tx_batch_cq_descs(&batch);
+	if (!nb_pkts)
 		goto out;
-	}
 
-	__xskq_cons_release(xs->tx);
-	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_pkts);
-	xs->sk.sk_write_space(&xs->sk);
+	cq_cached_prod = pool->cq->cached_prod;
+	xsk_tx_commit_batch(pool, &batch, cq_cached_prod);
 
 out:
 	rcu_read_unlock();
-	return nb_pkts;
+	return batch.tx_descs;
 }
 EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
 
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 1f28a9641571..b862addcd8fd 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -48,6 +48,7 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 	if (!pool->tx_descs)
 		return -ENOMEM;
 
+	pool->tx_descs_nentries = xs->tx->nentries;
 	return 0;
 }
 
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 3e3fbb73d23e..a15ff1929db6 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -58,6 +58,18 @@ struct parsed_desc {
 	u32 valid;
 };
 
+struct xsk_tx_batch {
+	u32 tx_descs;
+	u32 reclaim_descs;
+	u32 consumed_descs;
+	bool budget_limited;
+};
+
+static inline u32 xsk_tx_batch_cq_descs(const struct xsk_tx_batch *batch)
+{
+	return batch->tx_descs + batch->reclaim_descs;
+}
+
 /* The structure of the shared state of the rings are a simple
  * circular buffer, as outlined in
  * Documentation/core-api/circular-buffers.rst. For the Rx and
@@ -263,17 +275,18 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
 	parsed->mb = xp_mb_desc(desc);
 }
 
-static inline
-u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
-			      u32 max)
+static inline struct xsk_tx_batch
+xskq_cons_read_desc_batch(struct xdp_sock *xs, struct xsk_buff_pool *pool,
+			  struct xdp_desc *descs, u32 max)
 {
-	u32 cached_cons = q->cached_cons, nb_entries = 0;
-	struct xdp_desc *descs = pool->tx_descs;
-	u32 total_descs = 0, nr_frags = 0;
+	bool drain = READ_ONCE(xs->drain_cont);
+	u32 cached_cons, nb_entries = 0, released;
+	struct xsk_tx_batch batch = {};
+	struct xsk_queue *q = xs->tx;
+	u32 nr_frags = 0;
+
+	cached_cons = q->cached_cons;
 
-	/* track first entry, if stumble upon *any* invalid descriptor, rewind
-	 * current packet that consists of frags and stop the processing
-	 */
 	while (cached_cons != q->cached_prod && nb_entries < max) {
 		struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
 		u32 idx = cached_cons & q->ring_mask;
@@ -282,26 +295,49 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 		descs[nb_entries] = ring->desc[idx];
 		cached_cons++;
 		parse_desc(q, pool, &descs[nb_entries], &parsed);
-		if (unlikely(!parsed.valid))
-			break;
+		if (unlikely(!parsed.valid)) {
+			if (!drain && !nr_frags && !parsed.mb)
+				break;
+
+			drain = true;
+		}
+
+		nr_frags++;
+		nb_entries++;
 
 		if (likely(!parsed.mb)) {
-			total_descs += (nr_frags + 1);
-			nr_frags = 0;
-		} else {
-			nr_frags++;
-			if (nr_frags == pool->xdp_zc_max_segs) {
+			if (unlikely(drain)) {
+				batch.reclaim_descs = nr_frags;
+				WRITE_ONCE(xs->drain_cont, false);
 				nr_frags = 0;
 				break;
 			}
+
+			batch.tx_descs += nr_frags;
+			nr_frags = 0;
+			continue;
+		}
+
+		if (nr_frags == pool->xdp_zc_max_segs)
+			drain = true;
+	}
+
+	if (nr_frags) {
+		if (drain) {
+			batch.reclaim_descs = nr_frags;
+			WRITE_ONCE(xs->drain_cont, true);
+		} else {
+			if (nb_entries == max)
+				batch.budget_limited = true;
+			cached_cons -= nr_frags;
 		}
-		nb_entries++;
 	}
 
-	cached_cons -= nr_frags;
+	released = cached_cons - q->cached_cons;
 	/* Release valid plus any invalid entries */
-	xskq_cons_release_n(q, cached_cons - q->cached_cons);
-	return total_descs;
+	xskq_cons_release_n(q, released);
+	batch.consumed_descs = released;
+	return batch;
 }
 
 /* Functions for consumers */
-- 
2.43.0


