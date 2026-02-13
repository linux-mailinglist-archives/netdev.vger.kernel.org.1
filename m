Return-Path: <netdev+bounces-258556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCK3OJOdjmkODQEAu9opvQ
	(envelope-from <netdev+bounces-258556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:42:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914F132B48
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6357311FCB4
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8F423EA85;
	Fri, 13 Feb 2026 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W9uGt6Pm"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843C23AB9D
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770954050; cv=none; b=hTIQj8rpLMIGvML1KHA9Rg9Z32HOU1H3tIY7y+Sif7doUx5D/5Hbr9IXsfvf2zW9Rwpg9QS+8kCJN73HJ94I47GZwf/T+Y2dB+JMnWeSYoFCz4N1PEMaksWpysPPYDAYGoUEzTXn/hogXBCRfR32T9w6ADJG7/Ks/2kJ+N+hsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770954050; c=relaxed/simple;
	bh=BLNu40kz4Uqp4vj+JT3+8GUPomqXmYGnaG4tEokqe1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pP6cD/l4tZGZZXZ5K2VnQ0/wFsZ7P5LGa13XNh8Gf2pqwPuYPDPw6IRvZv1t/XR/fVcyCwvJ5d+CQtN1EAaMhgjTlff55iGjGf1lIKjaV05JsX8THTlU6rh6Ax2aTcf+2vpWRkDH2xvOUosc4NI0H6WxCt0K+mT9jQvgKx9ZBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W9uGt6Pm; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770954046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKVv5p2vMJc0Ryhiqg/jw184uo3Yf5fu6IfmcvOGrD8=;
	b=W9uGt6PmnO/LdU6pn+1wRsRWE2SA+og4JJu/La7BhRepN3q15UwRSg/Xlk45YmSpToEqhj
	0waomJi4Wt7WON8kTFmI2bXQijiooOdUgKJWubjgENeAYQrPoJZAY45gcCEHs5gCBG+H9S
	nKM8c4FA638kp2lWShjXneU2yD9TLLc=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xxx@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf v3 2/2] bpf: devmap: fix race in bq_xmit_all on PREEMPT_RT
Date: Fri, 13 Feb 2026 11:40:15 +0800
Message-ID: <20260213034018.284146-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260213034018.284146-1-jiayuan.chen@linux.dev>
References: <20260213034018.284146-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258556-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,linutronix.de,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,google.com,goodmis.org,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,linux.dev:mid,linux.dev:dkim,linux.dev:email,linutronix.de:email]
X-Rspamd-Queue-Id: 4914F132B48
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

On PREEMPT_RT kernels, the per-CPU xdp_dev_bulk_queue (bq) can be
accessed concurrently by multiple preemptible tasks on the same CPU.

The original code assumes bq_enqueue() and __dev_flush() run atomically
with respect to each other on the same CPU, relying on
local_bh_disable() to prevent preemption. However, on PREEMPT_RT,
local_bh_disable() only calls migrate_disable() (when
PREEMPT_RT_NEEDS_BH_LOCK is not set) and does not disable
preemption, which allows CFS scheduling to preempt a task during
bq_xmit_all(), enabling another task on the same CPU to enter
bq_enqueue() and operate on the same per-CPU bq concurrently.

This leads to several races:

1. Double-free / use-after-free on bq->q[]: bq_xmit_all() snapshots
   cnt = bq->count, then iterates bq->q[0..cnt-1] to transmit frames.
   If preempted after the snapshot, a second task can call bq_enqueue()
   -> bq_xmit_all() on the same bq, transmitting (and freeing) the
   same frames. When the first task resumes, it operates on stale
   pointers in bq->q[], causing use-after-free.

2. bq->count and bq->q[] corruption: concurrent bq_enqueue() modifying
   bq->count and bq->q[] while bq_xmit_all() is reading them.

3. dev_rx/xdp_prog teardown race: __dev_flush() clears bq->dev_rx and
   bq->xdp_prog after bq_xmit_all(). If preempted between
   bq_xmit_all() return and bq->dev_rx = NULL, a preempting
   bq_enqueue() sees dev_rx still set (non-NULL), skips adding bq to
   the flush_list, and enqueues a frame. When __dev_flush() resumes,
   it clears dev_rx and removes bq from the flush_list, orphaning the
   newly enqueued frame.

4. __list_del_clearprev() on flush_node: similar to the cpumap race,
   both tasks can call __list_del_clearprev() on the same flush_node,
   the second dereferences the prev pointer already set to NULL.

The race between task A (__dev_flush -> bq_xmit_all) and task B
(bq_enqueue -> bq_xmit_all) on the same CPU:

  Task A (xdp_do_flush)          Task B (ndo_xdp_xmit redirect)
  ----------------------         --------------------------------
  __dev_flush(flush_list)
    bq_xmit_all(bq)
      cnt = bq->count  /* e.g. 16 */
      /* start iterating bq->q[] */
    <-- CFS preempts Task A -->
                                   bq_enqueue(dev, xdpf)
                                     bq->count == DEV_MAP_BULK_SIZE
                                     bq_xmit_all(bq, 0)
                                       cnt = bq->count  /* same 16! */
                                       ndo_xdp_xmit(bq->q[])
                                       /* frames freed by driver */
                                       bq->count = 0
    <-- Task A resumes -->
      ndo_xdp_xmit(bq->q[])
      /* use-after-free: frames already freed! */

To reproduce, insert an mdelay(100) in bq_xmit_all() after
"cnt = bq->count" and before the actual transmit loop. Then pin two
threads to the same CPU, each running BPF_PROG_TEST_RUN with an XDP
program that redirects to a DEVMAP entry (e.g. a veth pair). CFS
timeslicing during the mdelay window causes interleaving. Without the
fix, KASAN reports null-ptr-deref due to operating on freed frames:

  BUG: KASAN: null-ptr-deref in __build_skb_around+0x22d/0x340
  Write of size 32 at addr 0000000000000d50 by task devmap_race_rep/449

  CPU: 0 UID: 0 PID: 449 Comm: devmap_race_rep Not tainted 6.19.0+ #31 PREEMPT_RT
  Call Trace:
   <TASK>
   __build_skb_around+0x22d/0x340
   build_skb_around+0x25/0x260
   __xdp_build_skb_from_frame+0x103/0x860
   veth_xdp_rcv_bulk_skb.isra.0+0x162/0x320
   veth_xdp_rcv.constprop.0+0x61e/0xbb0
   veth_poll+0x280/0xb50
   __napi_poll.constprop.0+0xa5/0x590
   net_rx_action+0x4b0/0xea0
   handle_softirqs.isra.0+0x1b3/0x780
   __local_bh_enable_ip+0x12a/0x240
   xdp_test_run_batch.constprop.0+0xedd/0x1f60
   bpf_test_run_xdp_live+0x304/0x640
   bpf_prog_test_run_xdp+0xd24/0x1b70
   __sys_bpf+0x61c/0x3e00
   </TASK>

  Kernel panic - not syncing: Fatal exception in interrupt

Fix this by adding a local_lock_t to xdp_dev_bulk_queue and acquiring
it in bq_enqueue() and __dev_flush(). These paths already run under
local_bh_disable(), so use local_lock_nested_bh() which on non-RT is
a pure annotation with no overhead, and on PREEMPT_RT provides a
per-CPU sleeping lock that serializes access to the bq.

Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/devmap.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..10cf0731f91d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -45,6 +45,7 @@
  * types of devmap; only the lookup and insertion is different.
  */
 #include <linux/bpf.h>
+#include <linux/local_lock.h>
 #include <net/xdp.h>
 #include <linux/filter.h>
 #include <trace/events/xdp.h>
@@ -60,6 +61,7 @@ struct xdp_dev_bulk_queue {
 	struct net_device *dev_rx;
 	struct bpf_prog *xdp_prog;
 	unsigned int count;
+	local_lock_t bq_lock;
 };
 
 struct bpf_dtab_netdev {
@@ -381,6 +383,8 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	int to_send = cnt;
 	int i;
 
+	lockdep_assert_held(&bq->bq_lock);
+
 	if (unlikely(!cnt))
 		return;
 
@@ -425,10 +429,12 @@ void __dev_flush(struct list_head *flush_list)
 	struct xdp_dev_bulk_queue *bq, *tmp;
 
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
+		local_lock_nested_bh(&bq->dev->xdp_bulkq->bq_lock);
 		bq_xmit_all(bq, XDP_XMIT_FLUSH);
 		bq->dev_rx = NULL;
 		bq->xdp_prog = NULL;
 		__list_del_clearprev(&bq->flush_node);
+		local_unlock_nested_bh(&bq->dev->xdp_bulkq->bq_lock);
 	}
 }
 
@@ -451,12 +457,16 @@ static void *__dev_map_lookup_elem(struct bpf_map *map, u32 key)
 
 /* Runs in NAPI, i.e., softirq under local_bh_disable(). Thus, safe percpu
  * variable access, and map elements stick around. See comment above
- * xdp_do_flush() in filter.c.
+ * xdp_do_flush() in filter.c. PREEMPT_RT relies on local_lock_nested_bh()
+ * to serialise access to the per-CPU bq.
  */
 static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
 {
-	struct xdp_dev_bulk_queue *bq = this_cpu_ptr(dev->xdp_bulkq);
+	struct xdp_dev_bulk_queue *bq;
+
+	local_lock_nested_bh(&dev->xdp_bulkq->bq_lock);
+	bq = this_cpu_ptr(dev->xdp_bulkq);
 
 	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
 		bq_xmit_all(bq, 0);
@@ -477,6 +487,8 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	}
 
 	bq->q[bq->count++] = xdpf;
+
+	local_unlock_nested_bh(&dev->xdp_bulkq->bq_lock);
 }
 
 static inline int __xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
@@ -1115,8 +1127,13 @@ static int dev_map_notification(struct notifier_block *notifier,
 		if (!netdev->xdp_bulkq)
 			return NOTIFY_BAD;
 
-		for_each_possible_cpu(cpu)
-			per_cpu_ptr(netdev->xdp_bulkq, cpu)->dev = netdev;
+		for_each_possible_cpu(cpu) {
+			struct xdp_dev_bulk_queue *bq;
+
+			bq = per_cpu_ptr(netdev->xdp_bulkq, cpu);
+			bq->dev = netdev;
+			local_lock_init(&bq->bq_lock);
+		}
 		break;
 	case NETDEV_UNREGISTER:
 		/* This rcu_read_lock/unlock pair is needed because
-- 
2.43.0


