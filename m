Return-Path: <netdev+bounces-282132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFPBL/k/8WmhfAEAu9opvQ
	(envelope-from <netdev+bounces-282132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:17:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BF48CF1B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0BBC3031AD8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CDE38A29A;
	Tue, 28 Apr 2026 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="QhVQCFQQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B33890EE
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418154; cv=none; b=JxXRyJq51Wl52raET5Zeih2Y1cXuAMRwb3qaLqo9TUi68r4NxJovjxQwxAVKKJwS+1J0mBSCUrl0rPTmpT/WINwykMyUwK6AjbPiFLh8QaaUqOI8qagmrKFt4N2E4kcETBmWdmblLeqZWNiFN8xXgoDiH1JghC/RF/SnzV4Vhls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418154; c=relaxed/simple;
	bh=lUg7jaEM2niUDefmDaQv517z2sHB/JCDsMu2S2I1eBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUVz18I11GR6SvMs50UfyeIqXvQIjluRiQ7deyOGfbW5nJkETYavHYlCbef2ynCNjd6+k7Xo4vXcd6MSPEfo5AD8ERIhm8trnrTJaLYhbK64pZ1Q5t8exib8gfi471SGMaUBwDkvRAFsmc7g5cUYhRImO073BQjAkhw3QcI7cuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=QhVQCFQQ; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IaSsbSaG/di2Hofrl5BE4c1yo1vrhk7N4Jo9ql76nJs=; t=1777418152; x=1778282152; 
	b=QhVQCFQQ49ZiuVXv+uiezb/rJzeHg3ZFHcTJYc4M+fgbSy2qxu9XGDZPl1MjEgyeUcaD0OJCjHW
	G0ZIxkjr5zOvukA5HmkNZLnVQpSQVWMT7wGbgBL4UVPc4wg2YKbAEA1dESTij6t1kmjTa45BIjz0n
	f00KjLber9J6FtJWLF+248cPkLvcncN4+gO/VkB0B/SagL87/O+t+e2q3mYXIrrwl4FRQAiN643Xz
	eJBmv7YsbYowPh2LOHaDrNx2FF4bWj5KjUn5lk+GjQMN1J/0KMru8SkjhuFmrPHnnRwZGDYA7jBGH
	IZACVVZ49DPORYjTOxfVRQjQ2HtYmu7L/vGg==;
Received: from ouster448.stanford.edu ([172.24.72.71]:54475 helo=ouster2022)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wHreh-0005UM-G1; Tue, 28 Apr 2026 16:15:52 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v19 13/15] net: homa: create homa_timer.c
Date: Tue, 28 Apr 2026 16:15:16 -0700
Message-ID: <20260428231520.1857-14-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428231520.1857-1-ouster@cs.stanford.edu>
References: <20260428231520.1857-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 0ecaf295db8a04c0f692789316a3d0cf
X-Rspamd-Queue-Id: 332BF48CF1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282132-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	NEURAL_HAM(-0.00)[-0.850];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanford.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cs.stanford.edu:mid]

This file contains code that wakes up periodically to check for
missing data, initiate retransmissions, and declare peer nodes
"dead".

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v14:
* Use new homa_rpc_tx_end function

Changes for v11:
* Cleanup sparse annotations.

Changes for v10:
* Refactor resend mechanism

Changes for v9:
* Reflect changes in socket and peer management
* Minor name changes for clarity

Changes for v7:
* Interface changes to homa_sock_start_scan etc.
* Remove locker argument from locking functions
* Use u64 and __u64 properly
---
 net/homa/homa_impl.h  |   3 +
 net/homa/homa_timer.c | 136 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 net/homa/homa_timer.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index f9722161140d..8796926d979d 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -387,6 +387,9 @@ void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
 void     homa_rpc_handoff(struct homa_rpc *rpc);
 int      homa_rpc_tx_end(struct homa_rpc *rpc);
 void     homa_spin(int ns);
+void     homa_timer(struct homa *homa);
+void     homa_timer_check_rpc(struct homa_rpc *rpc);
+int      homa_timer_main(void *transport);
 struct sk_buff *homa_tx_data_pkt_alloc(struct homa_rpc *rpc,
 				       struct iov_iter *iter, int offset,
 				       int length, int max_seg_data);
diff --git a/net/homa/homa_timer.c b/net/homa/homa_timer.c
new file mode 100644
index 000000000000..dcfdcc06c8ab
--- /dev/null
+++ b/net/homa/homa_timer.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+
+
+/* This file handles timing-related functions for Homa, such as retries
+ * and timeouts.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "homa_stub.h"
+
+/**
+ * homa_timer_check_rpc() -  Invoked for each RPC during each timer pass; does
+ * most of the work of checking for time-related actions such as sending
+ * resends, aborting RPCs for which there is no response, and sending
+ * requests for acks. It is separate from homa_timer because homa_timer
+ * got too long and deeply indented.
+ * @rpc:     RPC to check; must be locked by the caller.
+ */
+void homa_timer_check_rpc(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa *homa = rpc->hsk->homa;
+	int tx_end = homa_rpc_tx_end(rpc);
+
+	/* See if we need to request an ack for this RPC. */
+	if (!homa_is_client(rpc->id) && rpc->state == RPC_OUTGOING &&
+	    tx_end == rpc->msgout.length) {
+		if (rpc->done_timer_ticks == 0) {
+			rpc->done_timer_ticks = homa->timer_ticks;
+		} else {
+			/* >= comparison that handles tick wrap-around. */
+			if ((rpc->done_timer_ticks + homa->request_ack_ticks
+					- 1 - homa->timer_ticks) & 1 << 31) {
+				struct homa_need_ack_hdr h;
+
+				homa_xmit_control(NEED_ACK, &h, sizeof(h), rpc);
+			}
+		}
+	}
+
+	if (rpc->state == RPC_INCOMING) {
+		if (rpc->msgin.num_bpages == 0) {
+			/* Waiting for buffer space, so no problem. */
+			rpc->silent_ticks = 0;
+			return;
+		}
+	} else if (!homa_is_client(rpc->id)) {
+		/* We're the server and we've received the input message;
+		 * no need to worry about retries.
+		 */
+		rpc->silent_ticks = 0;
+		return;
+	}
+
+	if (rpc->state == RPC_OUTGOING) {
+		if (tx_end < rpc->msgout.length) {
+			/* There are granted bytes that we haven't transmitted,
+			 * so no need to be concerned; the ball is in our court.
+			 */
+			rpc->silent_ticks = 0;
+			return;
+		}
+	}
+
+	if (rpc->silent_ticks < homa->resend_ticks)
+		return;
+	if (rpc->silent_ticks >= homa->timeout_ticks) {
+		homa_rpc_abort(rpc, -ETIMEDOUT);
+		return;
+	}
+	if (((rpc->silent_ticks - homa->resend_ticks) % homa->resend_interval)
+			== 0)
+		homa_request_retrans(rpc);
+}
+
+/**
+ * homa_timer() - This function is invoked at regular intervals ("ticks")
+ * to implement retries and aborts for Homa.
+ * @homa:    Overall data about the Homa protocol implementation.
+ */
+void homa_timer(struct homa *homa)
+{
+	struct homa_socktab_scan scan;
+	struct homa_sock *hsk;
+	struct homa_rpc *rpc;
+	int rpc_count = 0;
+
+	homa->timer_ticks++;
+
+	/* Scan all existing RPCs in all sockets. */
+	for (hsk = homa_socktab_start_scan(homa->socktab, &scan);
+			hsk; hsk = homa_socktab_next(&scan)) {
+		while (hsk->dead_skbs >= homa->dead_buffs_limit)
+			/* If we get here, it means that Homa isn't keeping
+			 * up with RPC reaping, so we'll help out.  See
+			 * "RPC Reaping Strategy" in homa_rpc_reap code for
+			 * details.
+			 */
+			if (homa_rpc_reap(hsk, false) == 0)
+				break;
+
+		if (list_empty(&hsk->active_rpcs) || hsk->shutdown)
+			continue;
+
+		if (!homa_protect_rpcs(hsk))
+			continue;
+		rcu_read_lock();
+		list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+			homa_rpc_lock(rpc);
+			if (rpc->state == RPC_IN_SERVICE) {
+				rpc->silent_ticks = 0;
+				homa_rpc_unlock(rpc);
+				continue;
+			}
+			rpc->silent_ticks++;
+			homa_timer_check_rpc(rpc);
+			homa_rpc_unlock(rpc);
+			rpc_count++;
+			if (rpc_count >= 10) {
+				/* Give other kernel threads a chance to run
+				 * on this core.
+				 */
+				rcu_read_unlock();
+				schedule();
+				rcu_read_lock();
+				rpc_count = 0;
+			}
+		}
+		rcu_read_unlock();
+		homa_unprotect_rpcs(hsk);
+	}
+	homa_socktab_end_scan(&scan);
+	homa_skb_release_pages(homa);
+	homa_peer_gc(homa->peertab);
+}
-- 
2.43.0


