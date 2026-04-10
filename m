Return-Path: <netdev+bounces-277560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BVdOp1Y2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:07:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A73DC5B4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68943088E13
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5603338A715;
	Fri, 10 Apr 2026 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="gqj30+nX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201B3859E1
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851429; cv=none; b=Ic4N+Li7Kipy2abJ8iWUNrGrwbbekAith79N65bYFBVPgvqVcabMY//bdoCorutdVIcpCuBonoZBLcS5n2+6Xz5s7ozl3LYt967UMVGO8khrAqwjpn2QA3INSr3lKIMpihzKUMB3UH1Gb/1Mk6qmUEtV8rkcazGHe/eufcz2Rvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851429; c=relaxed/simple;
	bh=MKjNutxxOhZhRHppjTicIi16Kn2vGmEmoZTMrIj07fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0U0JWmSJPH6Yt15BXRjv2q8CyPM35OxWXxh821me25Zkv6OBEbOgw8JI0pL536YZVyG9d4AExPheba0NwJGnBtbf8dW5dj94XmL/yDpf754F4bOI9XTEbWHHVtppvX353G9p8luFxFLSjFIi3TCxoMKfY28cjPZ3WpYuj4hlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=gqj30+nX; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=px6A8ncmH95lh9xNQ2ZuLHA4b9oRWDfYH8fjkNpOPY4=; t=1775851421; x=1776715421; 
	b=gqj30+nXgi6+gX22IOy9XHs7yKoojJwz4G4BkDDyCAUnn5LpRzAxFCJI10GNdHfWvpOJxkIQFGC
	q8MkSsgEEMa693hNaXGXp+s4tAvTVc1QB1p4KJG0tsy3567OwA8inCyrdDLprgHgaPP13eEOxzSzf
	tXd92Yw7zGRKoEJVkwSR+TIEPT+fLw3ZujncXfFlEswpd/afz2BcNkqZc2clX97AOE2cetqhcisLw
	SulRtuYecsJYVuzq89IE6ChmkjfW5VZFXTEa9vbiXF6Nz0NXAfUOJ7rTKdFfJtMaiEcIL2c3Dg/iO
	gRFNwjWQvZajzDS7c4ToIWQIwzEWfWxwOPyQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:51553 helo=ouster2022)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wBI4o-0003MV-N2; Fri, 10 Apr 2026 13:03:41 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v18 12/15] net: homa: create homa_incoming.c
Date: Fri, 10 Apr 2026 13:03:06 -0700
Message-ID: <20260410200310.1915-13-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260410200310.1915-1-ouster@cs.stanford.edu>
References: <20260410200310.1915-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: bcb763d6d017077cd90934e2f471761e
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277560-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	NEURAL_HAM(-0.00)[-0.792];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cs.stanford.edu:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanford.edu:email,common.sport:url]
X-Rspamd-Queue-Id: 440A73DC5B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This file contains most of the code for handling incoming packets,
including top-level dispatching code plus specific handlers for each
pack type. It also contains code for dispatching fully-received
messages to waiting application threads.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

Changes for v18:
* Create new function homa_consume_rx_skb (which uses skb_attempt_defer_free)
  and use that function instead of consume_skb.
* Make sure unused fields of outgoing packets are zeroes.
* Improve error handling in homa_ack_pkt.

Changes for v16:
* Use kfree_skb_reason and consume_skb instead of kfree_skb
* Use set_bit/clear_bit/test_bit
* Simplify handling of acks; eliminate akcs and num_acks variables
  in homa_dispatch_pkts
* Check for wmem in homa_dispatch_pkts (fixes deadlock over wmem)
* Use new homa_lock_preempt() function

Changes for v14:
* Use new homa_rpc_tx_end function
* Fix race in homa_wait_shared (an RPC could get lost if it became
  ready at the same time that homa_interest_wait returned with an error)
* Handle nonblocking behavior here, rather than in homa_interest.c
* Change API for homa_wait_private to distinguish errors in an RPC from
  errors that prevented the wait operation from completing.

Changes for v11:
* Cleanup and simplify use of RPC reference counts.
* Cleanup sparse annotations.
* Rework the mechanism for waking up RPCs that stalled waiting for
  buffer pool space.

Changes for v10:
* Revise sparse annotations to eliminate __context__ definition
* Refactor resend mechanism (new function homa_request_retrans replaces
  homa_gap_retry)
* Remove log messages after alloc errors
* Fix socket cleanup race

Changes for v9:
* Add support for homa_net objects
* Use new homa_clock abstraction layer
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)

Changes for v7:
* API change for homa_rpc_handoff
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting, use
  new homa_interest struct
* Reject unauthorized incoming request messages
* Improve documentation for code that spins (and reduce spin length)
* Use RPC reference counts, eliminate RPC_HANDING_OFF flag
* Replace erroneous use of "safe" list iteration with "rcu" version
* Remove locker argument from locking functions
* Check incoming messages against HOMA_MAX_MESSAGE_LENGTH
* Use u64 and __u64 properly
---
 net/homa/homa_impl.h     |  16 +
 net/homa/homa_incoming.c | 906 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 922 insertions(+)
 create mode 100644 net/homa/homa_incoming.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index e997f1f6cb3b..b1ca8b25fb9a 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -359,22 +359,38 @@ static inline bool homa_make_header_avl(struct sk_buff *skb)
 
 extern unsigned int homa_net_id;
 
+void     homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+		      struct homa_rpc *rpc);
+void     homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb);
+void     homa_consume_rx_skb(struct sk_buff *skb);
+int      homa_copy_to_user(struct homa_rpc *rpc);
+void     homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
 void     homa_destroy(struct homa *homa);
+void     homa_dispatch_pkts(struct sk_buff *skb);
 int      homa_fill_data_interleaved(struct homa_rpc *rpc,
 				    struct sk_buff *skb, struct iov_iter *iter);
+struct homa_gap *homa_gap_alloc(struct list_head *next, int start, int end);
 int      homa_init(struct homa *homa);
 int      homa_message_out_fill(struct homa_rpc *rpc,
 			       struct iov_iter *iter, int xmit);
 void     homa_message_out_init(struct homa_rpc *rpc, int length);
+void     homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+			   struct homa_rpc *rpc);
 void     homa_net_destroy(struct homa_net *hnet);
 int      homa_net_init(struct homa_net *hnet, struct net *net,
 		       struct homa *homa);
+void     homa_request_retrans(struct homa_rpc *rpc);
+void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
+			 struct homa_sock *hsk);
 void     homa_rpc_handoff(struct homa_rpc *rpc);
 int      homa_rpc_tx_end(struct homa_rpc *rpc);
 void     homa_spin(int ns);
 struct sk_buff *homa_tx_data_pkt_alloc(struct homa_rpc *rpc,
 				       struct iov_iter *iter, int offset,
 				       int length, int max_seg_data);
+void     homa_rpc_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
+int      homa_wait_private(struct homa_rpc *rpc, int nonblocking);
+struct homa_rpc *homa_wait_shared(struct homa_sock *hsk, int nonblocking);
 int      homa_xmit_control(enum homa_packet_type type, void *contents,
 			   size_t length, struct homa_rpc *rpc);
 int      __homa_xmit_control(void *contents, size_t length,
diff --git a/net/homa/homa_incoming.c b/net/homa/homa_incoming.c
new file mode 100644
index 000000000000..7cb9a096cbec
--- /dev/null
+++ b/net/homa/homa_incoming.c
@@ -0,0 +1,906 @@
+// SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+
+
+/* This file contains functions that handle incoming Homa messages. */
+
+#include "homa_impl.h"
+#include "homa_interest.h"
+#include "homa_peer.h"
+#include "homa_pool.h"
+
+/**
+ * homa_message_in_init() - Constructor for homa_message_in.
+ * @rpc:          RPC whose msgin structure should be initialized. The
+ *                msgin struct is assumed to be zeroes.
+ * @length:       Total number of bytes in message.
+ * Return:        Zero for successful initialization, or a negative errno
+ *                if rpc->msgin could not be initialized.
+ */
+int homa_message_in_init(struct homa_rpc *rpc, int length)
+	__must_hold(rpc->bucket->lock)
+{
+	int err;
+
+	if (length > HOMA_MAX_MESSAGE_LENGTH)
+		return -EINVAL;
+
+	rpc->msgin.length = length;
+	__skb_queue_head_init(&rpc->msgin.packets);
+	INIT_LIST_HEAD(&rpc->msgin.gaps);
+	rpc->msgin.bytes_remaining = length;
+	err = homa_pool_alloc_msg(rpc);
+	if (err != 0) {
+		rpc->msgin.length = -1;
+		return err;
+	}
+	return 0;
+}
+
+/**
+ * homa_gap_alloc() - Allocate a new gap and add it to a gap list.
+ * @next:   Add the new gap just before this list element.
+ * @start:  Offset of first byte covered by the gap.
+ * @end:    Offset of byte just after the last one covered by the gap.
+ * Return:  Pointer to the new gap, or NULL if memory couldn't be allocated
+ *          for the gap object.
+ */
+struct homa_gap *homa_gap_alloc(struct list_head *next, int start, int end)
+{
+	struct homa_gap *gap;
+
+	gap = kmalloc_obj(*gap, GFP_ATOMIC);
+	if (!gap)
+		return NULL;
+	gap->start = start;
+	gap->end = end;
+	gap->time = homa_clock();
+	list_add_tail(&gap->links, next);
+	return gap;
+}
+
+/**
+ * homa_request_retrans() - The function is invoked when it appears that
+ * data packets for a message have been lost. It issues RESEND requests
+ * as appropriate and may modify the state of the RPC.
+ * @rpc:     RPC for which incoming data is delinquent; must be locked by
+ *           caller.
+ */
+void homa_request_retrans(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_resend_hdr resend;
+	struct homa_gap *gap;
+	int offset, length;
+
+	if (rpc->msgin.length >= 0) {
+		/* Issue RESENDS for any gaps in incoming data. */
+		list_for_each_entry(gap, &rpc->msgin.gaps, links) {
+			resend.offset = htonl(gap->start);
+			resend.length = htonl(gap->end - gap->start);
+			homa_xmit_control(RESEND, &resend, sizeof(resend), rpc);
+		}
+
+		/* Issue a RESEND for any granted data after the last gap. */
+		offset = rpc->msgin.recv_end;
+		length = rpc->msgin.length - rpc->msgin.recv_end;
+		if (length <= 0)
+			return;
+	} else {
+		/* No data has been received for the RPC. Ask the sender to
+		 * resend everything it has sent so far.
+		 */
+		offset = 0;
+		length = -1;
+	}
+
+	resend.offset = htonl(offset);
+	resend.length = htonl(length);
+	homa_xmit_control(RESEND, &resend, sizeof(resend), rpc);
+}
+
+/**
+ * homa_add_packet() - Add an incoming packet to the contents of a
+ * partially received message.
+ * @rpc:   Add the packet to the msgin for this RPC.
+ * @skb:   The new packet. This function takes ownership of the packet
+ *         (the packet will either be freed or added to rpc->msgin.packets).
+ */
+void homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
+	struct homa_gap *gap, *dummy, *gap2;
+	int start = ntohl(h->seg.offset);
+	int length = homa_data_len(skb);
+	enum skb_drop_reason reason;
+	int end = start + length;
+
+	if ((start + length) > rpc->msgin.length) {
+		reason = SKB_DROP_REASON_PKT_TOO_BIG;
+		goto discard;
+	}
+
+	if (start == rpc->msgin.recv_end) {
+		/* Common case: packet is sequential. */
+		rpc->msgin.recv_end += length;
+		goto keep;
+	}
+
+	if (start > rpc->msgin.recv_end) {
+		/* Packet creates a new gap. */
+		if (!homa_gap_alloc(&rpc->msgin.gaps,
+				    rpc->msgin.recv_end, start)) {
+			reason = SKB_DROP_REASON_NOMEM;
+			goto discard;
+		}
+		rpc->msgin.recv_end = end;
+		goto keep;
+	}
+
+	/* Must now check to see if the packet fills in part or all of
+	 * an existing gap.
+	 */
+	list_for_each_entry_safe(gap, dummy, &rpc->msgin.gaps, links) {
+		/* Is packet at the start of this gap? */
+		if (start <= gap->start) {
+			if (end <= gap->start)
+				continue;
+			if (start < gap->start) {
+				reason = SKB_DROP_REASON_DUP_FRAG;
+				goto discard;
+			}
+			if (end > gap->end) {
+				reason = SKB_DROP_REASON_DUP_FRAG;
+				goto discard;
+			}
+			gap->start = end;
+			if (gap->start >= gap->end) {
+				list_del(&gap->links);
+				kfree(gap);
+			}
+			goto keep;
+		}
+
+		/* Is packet at the end of this gap? BTW, at this point we know
+		 * the packet can't cover the entire gap.
+		 */
+		if (end >= gap->end) {
+			if (start >= gap->end)
+				continue;
+			if (end > gap->end) {
+				reason = SKB_DROP_REASON_DUP_FRAG;
+				goto discard;
+			}
+			gap->end = start;
+			goto keep;
+		}
+
+		/* Packet is in the middle of the gap; must split the gap. */
+		gap2 = homa_gap_alloc(&gap->links, gap->start, start);
+		if (!gap2) {
+			reason = SKB_DROP_REASON_NOMEM;
+			goto discard;
+		}
+		gap2->time = gap->time;
+		gap->start = end;
+		goto keep;
+	}
+	/* Packet doesn't overlap any gap, so it is a duplicate. */
+	reason = SKB_DROP_REASON_DUP_FRAG;
+
+discard:
+	kfree_skb_reason(skb, reason);
+	return;
+
+keep:
+	__skb_queue_tail(&rpc->msgin.packets, skb);
+	rpc->msgin.bytes_remaining -= length;
+}
+
+/**
+ * homa_consume_rx_skb() - Invoked to free an incoming skb that has been
+ * processed normally. Contains optimizations to minimize overhead during
+ * the execution of this function.
+ * @skb:    Buffer to free. Should be for an incoming skb, which was
+ *          processed normally.
+ */
+void homa_consume_rx_skb(struct sk_buff *skb)
+{
+	skb_orphan(skb);
+	skb_attempt_defer_free(skb);
+}
+
+/**
+ * homa_copy_to_user() - Copy as much data as possible from incoming
+ * packet buffers to buffers in user space.
+ * @rpc:     RPC for which data should be copied. Must be locked by caller.
+ * Return:   Zero for success or a negative errno if there is an error.
+ *           It is possible for the RPC to be freed while this function
+ *           executes (it releases and reacquires the RPC lock). If that
+ *           happens, -EINVAL will be returned and the state of @rpc
+ *           will be RPC_DEAD. Clears the RPC_PKTS_READY bit in @rpc->flags
+ *           if all available packets have been copied out.
+ */
+int homa_copy_to_user(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+#define MAX_SKBS 20
+	struct sk_buff *skbs[MAX_SKBS];
+	int error = 0;
+	int n = 0;             /* Number of filled entries in skbs. */
+	int i;
+
+	/* Tricky note: we can't hold the RPC lock while we're actually
+	 * copying to user space, because (a) it's illegal to hold a spinlock
+	 * while copying to user space and (b) we'd like for homa_softirq
+	 * to add more packets to the RPC while we're copying these out.
+	 * So, collect a bunch of packets to copy, then release the lock,
+	 * copy them, and reacquire the lock.
+	 */
+	while (true) {
+		struct sk_buff *skb;
+
+		if (rpc->state == RPC_DEAD) {
+			error = -EINVAL;
+			break;
+		}
+
+		skb = __skb_dequeue(&rpc->msgin.packets);
+		if (skb) {
+			skbs[n] = skb;
+			n++;
+			if (n < MAX_SKBS)
+				continue;
+		}
+		if (n == 0) {
+			clear_bit(RPC_PKTS_READY, &rpc->flags);
+			break;
+		}
+
+		/* At this point we've collected a batch of packets (or
+		 * run out of packets); copy any available packets out to
+		 * user space.
+		 */
+		homa_rpc_unlock(rpc);
+
+		/* Each iteration of this loop copies out one skb. */
+		for (i = 0; i < n; i++) {
+			struct homa_data_hdr *h = (struct homa_data_hdr *)
+					skbs[i]->data;
+			int pkt_length = homa_data_len(skbs[i]);
+			int offset = ntohl(h->seg.offset);
+			int buf_bytes, chunk_size;
+			struct iov_iter iter;
+			int copied = 0;
+			char __user *dst;
+
+			/* Each iteration of this loop copies to one
+			 * user buffer.
+			 */
+			while (copied < pkt_length) {
+				chunk_size = pkt_length - copied;
+				dst = homa_pool_get_buffer(rpc, offset + copied,
+							   &buf_bytes);
+				if (buf_bytes < chunk_size) {
+					if (buf_bytes == 0) {
+						/* skb has data beyond message
+						 * end?
+						 */
+						break;
+					}
+					chunk_size = buf_bytes;
+				}
+				error = import_ubuf(READ, dst, chunk_size,
+						    &iter);
+				if (error)
+					goto free_skbs;
+				error = skb_copy_datagram_iter(skbs[i],
+							       sizeof(*h) +
+							       copied,  &iter,
+							       chunk_size);
+				if (error)
+					goto free_skbs;
+				copied += chunk_size;
+			}
+		}
+
+free_skbs:
+		for (i = 0; i < n; i++)
+			homa_consume_rx_skb(skbs[i]);
+		n = 0;
+		homa_rpc_lock_preempt(rpc);
+		if (error)
+			break;
+	}
+	return error;
+}
+
+/**
+ * homa_dispatch_pkts() - Top-level function that processes a batch of packets,
+ * all related to the same RPC.
+ * @skb:       First packet in the batch, linked through skb->next.
+ */
+void homa_dispatch_pkts(struct sk_buff *skb)
+{
+#define MAX_ACKS 10
+	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
+	u64 id = homa_local_id(h->common.sender_id);
+	int dport = ntohs(h->common.dport);
+	struct homa_rpc *rpc = NULL;
+	struct homa_sock *hsk;
+	struct homa_net *hnet;
+	struct sk_buff *next;
+
+	/* Find the appropriate socket.*/
+	hnet = homa_net(dev_net(skb->dev));
+	hsk = homa_sock_find(hnet, dport);
+	if (!hsk || (!homa_is_client(id) && !hsk->is_server)) {
+		if (skb_is_ipv6(skb))
+			icmp6_send(skb, ICMPV6_DEST_UNREACH,
+				   ICMPV6_PORT_UNREACH, 0, NULL, IP6CB(skb));
+		else
+			icmp_send(skb, ICMP_DEST_UNREACH,
+				  ICMP_PORT_UNREACH, 0);
+		while (skb) {
+			next = skb->next;
+			kfree_skb(skb);
+			skb = next;
+		}
+		if (hsk)
+			sock_put(&hsk->sock);
+		return;
+	}
+
+	/* Each iteration through the following loop processes one packet. */
+	for (; skb; skb = next) {
+		h = (struct homa_data_hdr *)skb->data;
+		next = skb->next;
+
+		/* Relinquish the RPC lock temporarily if it's needed
+		 * elsewhere.
+		 */
+		if (rpc) {
+			if (test_bit(APP_NEEDS_LOCK, &rpc->flags)) {
+				homa_rpc_unlock(rpc);
+
+				/* This short spin is needed to ensure that the
+				 * other thread gets the lock before this thread
+				 * grabs it again below (the need for this
+				 * was confirmed experimentally in 2/2025;
+				 * without it, the handoff fails 20-25% of the
+				 * time). Furthermore, the call to homa_spin
+				 * seems to allow the other thread to acquire
+				 * the lock more quickly.
+				 */
+				homa_spin(100);
+				homa_rpc_lock(rpc);
+			}
+		}
+
+		/* If we don't already have an RPC, find it, lock it,
+		 * and create a reference on it.
+		 */
+		if (!rpc) {
+			if (!homa_is_client(id)) {
+				/* We are the server for this RPC. */
+				if (h->common.type == DATA) {
+					int created;
+
+					/* Create a new RPC if one doesn't
+					 * already exist.
+					 */
+					rpc = homa_rpc_alloc_server(hsk, &saddr,
+								    h,
+								    &created);
+					if (IS_ERR(rpc)) {
+						rpc = NULL;
+						goto discard;
+					}
+				} else {
+					rpc = homa_rpc_find_server(hsk, &saddr,
+								   id);
+				}
+			} else {
+				rpc = homa_rpc_find_client(hsk, id);
+			}
+			if (rpc)
+				homa_rpc_hold(rpc);
+		}
+		if (unlikely(!rpc)) {
+			if (h->common.type != NEED_ACK &&
+			    h->common.type != ACK &&
+			    h->common.type != RESEND)
+				goto discard;
+		} else {
+			if (h->common.type == DATA ||
+			    h->common.type == BUSY)
+				rpc->silent_ticks = 0;
+			rpc->peer->outstanding_resends = 0;
+		}
+
+		switch (h->common.type) {
+		case DATA:
+			homa_data_pkt(skb, rpc);
+			break;
+		case RESEND:
+			homa_resend_pkt(skb, rpc, hsk);
+			break;
+		case RPC_UNKNOWN:
+			homa_rpc_unknown_pkt(skb, rpc);
+			break;
+		case BUSY:
+			/* Nothing to do for these packets except reset
+			 * silent_ticks, which happened above.
+			 */
+			goto discard;
+		case NEED_ACK:
+			homa_need_ack_pkt(skb, hsk, rpc);
+			break;
+		case ACK:
+			homa_ack_pkt(skb, hsk, rpc);
+			break;
+		default:
+			goto discard;
+		}
+		continue;
+
+discard:
+		kfree_skb(skb);
+	}
+	if (rpc) {
+		homa_rpc_put(rpc);
+		homa_rpc_unlock(rpc);
+	}
+
+	/* We need to reap dead RPCs here under two conditions:
+	 * 1. The socket has hit its limit on tx buffer space and threads are
+	 *    blocked waiting for skbs to be released.
+	 * 2. A large number of dead RPCs have accumulated, and it seems
+	 *    that the reaper isn't keeping up when invoked only at
+	 *    "convenient" times (see "RPC Reaping Strategy" in homa_rpc_reap
+	 *    code for details).
+	 */
+	if (hsk->dead_skbs > 0) {
+		int waiting_for_wmem = test_bit(SOCK_NOSPACE,
+						&hsk->sock.sk_socket->flags);
+		if (waiting_for_wmem ||
+		    hsk->dead_skbs >= 2 * hsk->homa->dead_buffs_limit)
+			homa_rpc_reap(hsk, waiting_for_wmem);
+	}
+	sock_put(&hsk->sock);
+}
+
+/**
+ * homa_data_pkt() - Handler for incoming DATA packets
+ * @skb:     Incoming packet; size known to be large enough for the header.
+ *           This function now owns the packet.
+ * @rpc:     Information about the RPC corresponding to this packet.
+ *           Must be locked by the caller.
+ */
+void homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
+
+	if (h->ack.client_id) {
+		const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+
+		homa_rpc_unlock(rpc);
+		homa_rpc_acked(rpc->hsk, &saddr, &h->ack);
+		homa_rpc_lock(rpc);
+		if (rpc->state == RPC_DEAD)
+			goto discard;
+	}
+
+	if (rpc->state != RPC_INCOMING && homa_is_client(rpc->id)) {
+		if (unlikely(rpc->state != RPC_OUTGOING))
+			goto discard;
+		rpc->state = RPC_INCOMING;
+		if (homa_message_in_init(rpc, ntohl(h->message_length)) != 0)
+			goto discard;
+	} else if (rpc->state != RPC_INCOMING) {
+		/* Must be server; note that homa_rpc_alloc_server already
+		 * initialized msgin and allocated buffers.
+		 */
+		if (unlikely(rpc->msgin.length >= 0))
+			goto discard;
+	}
+
+	if (rpc->msgin.num_bpages == 0)
+		/* Drop packets that arrive when we can't allocate buffer
+		 * space. If we keep them around, packet buffer usage can
+		 * exceed available cache space, resulting in poor
+		 * performance.
+		 */
+		goto discard;
+
+	homa_add_packet(rpc, skb);
+
+	if (skb_queue_len(&rpc->msgin.packets) != 0 &&
+	    !test_bit(RPC_PKTS_READY, &rpc->flags)) {
+		set_bit(RPC_PKTS_READY, &rpc->flags);
+		homa_rpc_handoff(rpc);
+	}
+
+	return;
+
+discard:
+	kfree_skb(skb);
+}
+
+/**
+ * homa_resend_pkt() - Handler for incoming RESEND packets
+ * @skb:     Incoming packet; size already verified large enough for header.
+ *           This function now owns the packet.
+ * @rpc:     Information about the RPC corresponding to this packet; must
+ *           be locked by caller, but may be NULL if there is no RPC matching
+ *           this packet
+ * @hsk:     Socket on which the packet was received.
+ */
+void homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
+		     struct homa_sock *hsk)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_resend_hdr *h = (struct homa_resend_hdr *)skb->data;
+	int offset = ntohl(h->offset);
+	int length = ntohl(h->length);
+	int end = offset + length;
+	struct homa_busy_hdr busy;
+	int tx_end;
+
+	if (!rpc) {
+		homa_xmit_unknown(skb, hsk);
+		goto done;
+	}
+
+	tx_end = homa_rpc_tx_end(rpc);
+	if (!homa_is_client(rpc->id) && rpc->state != RPC_OUTGOING) {
+		/* We are the server for this RPC and don't yet have a
+		 * response message, so send BUSY to keep the client
+		 * waiting.
+		 */
+		homa_xmit_control(BUSY, &busy, sizeof(busy), rpc);
+		goto done;
+	}
+
+	if (length == -1)
+		end = tx_end;
+
+	homa_resend_data(rpc, offset, (end > tx_end) ? tx_end : end);
+
+	if (offset >= tx_end) {
+		/* We have chosen not to transmit any of the requested data;
+		 * send BUSY so the receiver knows we are alive.
+		 */
+		homa_xmit_control(BUSY, &busy, sizeof(busy), rpc);
+		goto done;
+	}
+
+done:
+	homa_consume_rx_skb(skb);
+}
+
+/**
+ * homa_rpc_unknown_pkt() - Handler for incoming RPC_UNKNOWN packets.
+ * @skb:     Incoming packet; size known to be large enough for the header.
+ *           This function now owns the packet.
+ * @rpc:     Information about the RPC corresponding to this packet. Must
+ *           be locked by caller.
+ */
+void homa_rpc_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	if (homa_is_client(rpc->id)) {
+		if (rpc->state == RPC_OUTGOING) {
+			int tx_end = homa_rpc_tx_end(rpc);
+
+			/* It appears that everything we've already transmitted
+			 * has been lost; retransmit it.
+			 */
+			homa_resend_data(rpc, 0, tx_end);
+			goto done;
+		}
+	} else {
+		homa_rpc_end(rpc);
+	}
+done:
+	homa_consume_rx_skb(skb);
+}
+
+/**
+ * homa_need_ack_pkt() - Handler for incoming NEED_ACK packets
+ * @skb:     Incoming packet; size already verified large enough for header.
+ *           This function now owns the packet.
+ * @hsk:     Socket on which the packet was received.
+ * @rpc:     The RPC named in the packet header, or NULL if no such
+ *           RPC exists. The RPC has been locked by the caller.
+ */
+void homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+		       struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_common_hdr *h = (struct homa_common_hdr *)skb->data;
+	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	u64 id = homa_local_id(h->sender_id);
+	struct homa_ack_hdr ack;
+	struct homa_peer *peer;
+
+	/* Don't ack if it's not safe for the peer to purge its state
+	 * for this RPC (the RPC still exists and we haven't received
+	 * the entire response), or if we can't find peer info.
+	 */
+	if (rpc && (rpc->state != RPC_INCOMING ||
+		    rpc->msgin.bytes_remaining)) {
+		homa_request_retrans(rpc);
+		goto done;
+	} else {
+		peer = homa_peer_get(hsk, &saddr);
+		if (IS_ERR(peer))
+			goto done;
+	}
+
+	/* Send an ACK for this RPC. At the same time, include all of the
+	 * other acks available for the peer. Note: can't use rpc below,
+	 * since it may be NULL.
+	 */
+	memset(&ack, 0, sizeof(ack));
+	ack.common.type = ACK;
+	ack.common.sport = h->dport;
+	ack.common.dport = h->sport;
+	ack.common.sender_id = cpu_to_be64(id);
+	ack.num_acks = htons(homa_peer_get_acks(peer,
+						HOMA_MAX_ACKS_PER_PKT,
+						ack.acks));
+	__homa_xmit_control(&ack, sizeof(ack), peer, hsk);
+	homa_peer_release(peer);
+
+done:
+	homa_consume_rx_skb(skb);
+}
+
+/**
+ * homa_ack_pkt() - Handler for incoming ACK packets
+ * @skb:     Incoming packet; size already verified large enough for header.
+ *           This function now owns the packet.
+ * @hsk:     Socket on which the packet was received.
+ * @rpc:     The RPC named in the packet header, or NULL if no such
+ *           RPC exists. The RPC lock will be dead on return.
+ */
+void homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+		  struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	struct homa_ack_hdr *h = (struct homa_ack_hdr *)skb->data;
+	int i, count;
+
+	if (rpc)
+		homa_rpc_end(rpc);
+
+	count = ntohs(h->num_acks);
+	if (count > HOMA_MAX_ACKS_PER_PKT)
+		count = HOMA_MAX_ACKS_PER_PKT;
+	if (count > 0) {
+		if (rpc) {
+			/* Must temporarily release rpc's lock because
+			 * homa_rpc_acked needs to acquire RPC locks.
+			 */
+			homa_rpc_unlock(rpc);
+			for (i = 0; i < count; i++)
+				homa_rpc_acked(hsk, &saddr, &h->acks[i]);
+			homa_rpc_lock(rpc);
+		} else {
+			for (i = 0; i < count; i++)
+				homa_rpc_acked(hsk, &saddr, &h->acks[i]);
+		}
+	}
+	homa_consume_rx_skb(skb);
+}
+
+/**
+ * homa_wait_private() - Waits until the response has been received for
+ * a specific RPC or the RPC has failed with an error.
+ * @rpc:          RPC to wait for; an error will be returned if the RPC is
+ *                not a client RPC or not private. Must be locked by caller.
+ * @nonblocking:  Nonzero means return immediately if @rpc not ready.
+ * Return:        0 means that @rpc is ready for attention: either its response
+ *                has been received or it has an unrecoverable error such as
+ *                ETIMEDOUT (in rpc->error). Nonzero means some other error
+ *                (such as EINTR or EINVAL) occurred before @rpc became ready
+ *                for attention; in this case the return value is a negative
+ *                errno.
+ */
+int homa_wait_private(struct homa_rpc *rpc, int nonblocking)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_interest interest;
+	int result;
+
+	if (!test_bit(RPC_PRIVATE, &rpc->flags))
+		return -EINVAL;
+
+	/* Each iteration through this loop waits until rpc needs attention
+	 * in some way (e.g. packets have arrived), then deals with that need
+	 * (e.g. copy to user space). It may take many iterations until the
+	 * RPC is ready for the application.
+	 */
+	while (1) {
+		result = 0;
+		if (!rpc->error)
+			rpc->error = homa_copy_to_user(rpc);
+		if (rpc->error)
+			break;
+		if (rpc->msgin.length >= 0 &&
+		    rpc->msgin.bytes_remaining == 0 &&
+		    skb_queue_len(&rpc->msgin.packets) == 0)
+			break;
+
+		if (nonblocking) {
+			result = -EAGAIN;
+			break;
+		}
+
+		result = homa_interest_init_private(&interest, rpc);
+		if (result != 0)
+			break;
+
+		homa_rpc_unlock(rpc);
+		result = homa_interest_wait(&interest);
+
+		homa_rpc_lock_preempt(rpc);
+		homa_interest_unlink_private(&interest);
+
+		/* Abort on error, but if the interest actually got ready
+		 * in the meantime the ignore the error (loop back around
+		 * to process the RPC).
+		 */
+		if (result != 0 && atomic_read(&interest.ready) == 0)
+			break;
+	}
+
+	return result;
+}
+
+/**
+ * homa_wait_shared() - Wait for the completion of any non-private
+ * incoming message on a socket.
+ * @hsk:          Socket on which to wait. Must not be locked.
+ * @nonblocking:  Nonzero means return immediately if no RPC is ready.
+ *
+ * Return:    Pointer to an RPC with a complete incoming message or nonzero
+ *            error field, or a negative errno (usually -EINTR). If an RPC
+ *            is returned it will be locked and referenced; the caller
+ *            must release the lock and the reference.
+ */
+struct homa_rpc *homa_wait_shared(struct homa_sock *hsk, int nonblocking)
+	__cond_acquires(nonnull, rpc->bucket->lock)
+{
+	struct homa_interest interest;
+	struct homa_rpc *rpc;
+	int result;
+
+	INIT_LIST_HEAD(&interest.links);
+	init_waitqueue_head(&interest.wait_queue);
+	/* Each iteration through this loop waits until an RPC needs attention
+	 * in some way (e.g. packets have arrived), then deals with that need
+	 * (e.g. copy to user space). It may take many iterations until an
+	 * RPC is ready for the application.
+	 */
+	while (1) {
+		homa_sock_lock(hsk);
+		if (hsk->shutdown) {
+			rpc = ERR_PTR(-ESHUTDOWN);
+			homa_sock_unlock(hsk);
+			goto done;
+		}
+		if (!list_empty(&hsk->ready_rpcs)) {
+			rpc = list_first_entry(&hsk->ready_rpcs,
+					       struct homa_rpc,
+					       ready_links);
+			homa_rpc_hold(rpc);
+			list_del_init(&rpc->ready_links);
+			if (!list_empty(&hsk->ready_rpcs)) {
+				/* There are still more RPCs available, so
+				 * let Linux know.
+				 */
+				hsk->sock.sk_data_ready(&hsk->sock);
+			}
+			homa_sock_unlock(hsk);
+		} else if (nonblocking) {
+			rpc = ERR_PTR(-EAGAIN);
+			homa_sock_unlock(hsk);
+
+			/* This is a good time to cleanup dead RPCS. */
+			homa_rpc_reap(hsk, false);
+			goto done;
+		} else {
+			homa_interest_init_shared(&interest, hsk);
+			homa_sock_unlock(hsk);
+			result = homa_interest_wait(&interest);
+
+			if (result != 0) {
+				int ready;
+
+				/* homa_interest_wait returned an error, so we
+				 * have to do two things. First, unlink the
+				 * interest from the socket. Second, check to
+				 * see if in the meantime the interest received
+				 * a handoff. If so, ignore the error. Very
+				 * important to hold the socket lock while
+				 * checking, in order to eliminate races with
+				 * homa_rpc_handoff.
+				 */
+				homa_sock_lock(hsk);
+				homa_interest_unlink_shared(&interest);
+				ready = atomic_read(&interest.ready);
+				homa_sock_unlock(hsk);
+				if (ready == 0) {
+					rpc = ERR_PTR(result);
+					goto done;
+				}
+			}
+
+			rpc = interest.rpc;
+			if (!rpc) {
+				rpc = ERR_PTR(-ESHUTDOWN);
+				goto done;
+			}
+		}
+
+		homa_rpc_lock_preempt(rpc);
+		if (!rpc->error)
+			rpc->error = homa_copy_to_user(rpc);
+		if (rpc->error) {
+			if (rpc->state != RPC_DEAD)
+				break;
+		} else if (rpc->msgin.bytes_remaining == 0 &&
+		    skb_queue_len(&rpc->msgin.packets) == 0)
+			break;
+		homa_rpc_put(rpc);
+		homa_rpc_unlock(rpc);
+	}
+
+done:
+	return rpc;
+}
+
+/**
+ * homa_rpc_handoff() - This function is called when the input message for
+ * an RPC is ready for attention from a user thread. It notifies a waiting
+ * reader and/or queues the RPC, as appropriate.
+ * @rpc:                RPC to handoff; must be locked.
+ */
+void homa_rpc_handoff(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_sock *hsk = rpc->hsk;
+	struct homa_interest *interest;
+
+	if (test_bit(RPC_PRIVATE, &rpc->flags)) {
+		homa_interest_notify_private(rpc);
+		return;
+	}
+
+	/* Shared RPC; if there is a waiting thread, hand off the RPC;
+	 * otherwise enqueue it.
+	 */
+	homa_sock_lock(hsk);
+	if (hsk->shutdown) {
+		homa_sock_unlock(hsk);
+		return;
+	}
+	if (!list_empty(&hsk->interests)) {
+		interest = list_first_entry(&hsk->interests,
+					    struct homa_interest, links);
+		list_del_init(&interest->links);
+		interest->rpc = rpc;
+		homa_rpc_hold(rpc);
+		atomic_set_release(&interest->ready, 1);
+		wake_up(&interest->wait_queue);
+	} else if (list_empty(&rpc->ready_links)) {
+		list_add_tail(&rpc->ready_links, &hsk->ready_rpcs);
+		hsk->sock.sk_data_ready(&hsk->sock);
+	}
+	homa_sock_unlock(hsk);
+}
+
-- 
2.43.0


