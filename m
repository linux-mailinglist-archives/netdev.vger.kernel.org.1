Return-Path: <netdev+bounces-277558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMm/Cn9Y2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:07:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC803DC576
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB81630137AD
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16C838B12E;
	Fri, 10 Apr 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="CT7ARphn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD538A715
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851427; cv=none; b=BWJvGvHaXz8wRA90zyVS1Gyp+dXGi4ziFJhFUkVMOTN2wpuVxXIafu/SKh9HZSsRcjVYw1kH6Ym7sZuw/mXTmRwuDFthZR+OtxrJUzTAdGm0vzjov7hbCMl8s8YdCaEwACFtHu3N3pmqTjHXap+VVJ22kW6cTxquELcWBvHPBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851427; c=relaxed/simple;
	bh=vmBI81PHMScWMegQhFA66nR8Fa7J/QTovBBQTl6YUMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hO0OKmZi2p9EStvBbHJcFptF948B0WYO0IdvHVWdwdPMnZXMOFfKY2By6PP2m/Lm8YEAQFJOHY+zXsnNFlBU99LhutL/PoIBVWhqsu2qP32M9UOwwnT/6cczxHpOcndH7qq/PAY7Kb8jR8C2oFpU8hJahUuURMDZbt1nY1vemCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=CT7ARphn; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9D/V+bJj28+0DhWtJc6Fg8PXYABdpHQwagcLvCYktp4=; t=1775851423; x=1776715423; 
	b=CT7ARphnOvkjVURJrDBsngQFb/QIOvPBE/jcuaRJJqPSiHRZeb/GF/Dw67V9d5LVgm8w3/JirKQ
	mtt1PFxxpKFWmd3B4Jg+iL6wwFyOGP6DnK0ouXwi8Aeqhim2L8eoD0fUR31cOSKxIhgtH57B4VWc3
	wO3sCJ3kMmlzVrpHZSajlgXqMGtMhYk8wCs8zSYrJmRsydnpb5pRtEQTA6VzVP3NaC7BLS1IDdG5X
	/Xz8n4tks67NWj12Cvyh/oFnqQ3vXqIN1d1OYZDkG4Qw7CBlVTAuspJomI8o1n0+tm0PZVPtKajWJ
	BCW3BFptMv7LwktRznHcpd06fQpJEA1c8byw==;
Received: from ouster448.stanford.edu ([172.24.72.71]:51553 helo=ouster2022)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wBI4r-0003MV-6s; Fri, 10 Apr 2026 13:03:42 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v18 13/15] net: homa: create homa_timer.c
Date: Fri, 10 Apr 2026 13:03:07 -0700
Message-ID: <20260410200310.1915-14-ouster@cs.stanford.edu>
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
X-Scan-Signature: 0ecaf295db8a04c0f692789316a3d0cf
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277558-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	NEURAL_HAM(-0.00)[-0.886];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanford.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cs.stanford.edu:mid]
X-Rspamd-Queue-Id: 7AC803DC576
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index b1ca8b25fb9a..4a8df43003de 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -385,6 +385,9 @@ void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
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


