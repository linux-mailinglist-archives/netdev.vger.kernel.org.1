Return-Path: <netdev+bounces-285891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM06DzX//WkTlwAAu9opvQ
	(envelope-from <netdev+bounces-285891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:20:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB154F89BF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE45D3056628
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233F3F9F48;
	Fri,  8 May 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="Bt3vbYmW"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E83FA5ED;
	Fri,  8 May 2026 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253076; cv=none; b=fj66XxD7NkMsomIxLr4/HpckSblNmB5brLv4x9Rym1B6U2uV6H2oZtTDD0GS1U3xA/luFqAQQxQlXi0cCmt0UugjXKCIa6I4eiN74j64d+QjozV2PYASg+WQF5oIwofPeLUYwF2Alvo2+sJf6jWWyvl9sRHe9v2S5s4PYGRaGOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253076; c=relaxed/simple;
	bh=KCIkbM03GbD9KtBlBOfyicbz2js9nAEmJWV/dvDZ4iU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNHpVYljqNHRHUbFgVpKJ6nJL6W1Y5ySZGptKD3BGcLu6k9KBY9Wel8niDLzF5XF0F5PFh1HQ6TsRdH6cpig6BiGMOKG5RTD+su688U9kgX+px0J78idU4EtOJ48aOm9Rt9b7jMOCXZA8wKYXE16LCkBY0qF7rSUOh3mNdyIJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=Bt3vbYmW; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778253064;
	bh=KCIkbM03GbD9KtBlBOfyicbz2js9nAEmJWV/dvDZ4iU=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Bt3vbYmWimbl/Su1uw2LvnAsOwmp6a3vLlHYnHI8ngy2HjrKvPTRWfP+bDt+H3zkR
	 M5H6X5ONqHyJz+ZqM588dd+4Ua36bRSzmr+9SNb/4aYVZz2UxMGeu2JtgH46vtoLhY
	 MdW+Sbx4u4XtIvFujT/aijtobcDDvQ/lxVPKP+2I=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.131])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 648FB272013311
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 8 May 2026 17:11:04 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v11 4/4] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
Date: Fri,  8 May 2026 17:10:48 +0200
Message-ID: <20260508151048.183125-5-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BB154F89BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-285891-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tu-dortmund.de:email,tu-dortmund.de:mid,tu-dortmund.de:dkim]
X-Rspamd-Action: no action

This commit prevents tail-drop when a qdisc is present and the ptr_ring
becomes full. Once the ring reaches capacity after a produce attempt,
the netdev queue is stopped instead of dropping subsequent packets.
If no qdisc is present, the previous tail-drop behavior is preserved.

If producing an entry fails anyway due to a race, tun_net_xmit() drops
the packet. Such races are expected because LLTX is enabled and the
transmit path operates without the usual locking.

The __tun_wake_queue() function of the consumer races with the producer
for waking/stopping the netdev queue, which could result in a stalled
queue. Therefore, an smp_mb__after_atomic() is introduced that pairs
with the smp_mb() of the consumer. It follows the principle of store
buffering described in tools/memory-model/Documentation/recipes.txt:

- The producer in tun_net_xmit() first sets __QUEUE_STATE_DRV_XOFF,
  followed by an smp_mb__after_atomic() (= smp_mb()), and then reads the
  ring with __ptr_ring_check_produce().

- The consumer in __tun_wake_queue() first writes zero to the ring in
  __ptr_ring_consume(), followed by an smp_mb(), and then reads the queue
  status with netif_tx_queue_stopped().

=> Following the aforementioned principle, it is impossible for the
   producer to see a full ring (and therefore not wake the queue on the
   re-check) while the consumer simultaneously fails to see a stopped
   queue (and therefore also does not wake it).

Benchmarks:
The benchmarks show a slight regression in raw transmission performance
when using two sending threads. Packet loss also occurs only in the
two-thread sending case; no packet loss was observed with a single
sending thread.

Test setup:
AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
mitigations disabled.

Note for tap+vhost-net:
XDP drop program active in VM -> ~2.5x faster; slower for tap due to
more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)

+--------------------------+--------------+----------------+----------+
| 1 thread                 | Stock        | Patched with   | diff     |
| sending                  |              | fq_codel qdisc |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 1.132 Mpps   | 1.123 Mpps     | -0.8%    |
|            +-------------+--------------+----------------+----------+
|            | Lost/s      | 3.765 Mpps   | 0 pps          |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 3.857 Mpps   | 3.901 Mpps     | +1.1%    |
|            +-------------+--------------+----------------+----------+
| +vhost-net | Lost/s      | 0.802 Mpps   | 0 pps          |          |
+------------+-------------+--------------+----------------+----------+

+--------------------------+--------------+----------------+----------+
| 2 threads                | Stock        | Patched with   | diff     |
| sending                  |              | fq_codel qdisc |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 1.115 Mpps   | 1.081 Mpps     | -3.0%    |
|            +-------------+--------------+----------------+----------+
|            | Lost/s      | 8.490 Mpps   | 391 pps        |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 3.664 Mpps   | 3.555 Mpps     | -3.0%    |
|            +-------------+--------------+----------------+----------+
| +vhost-net | Lost/s      | 5.330 Mpps   | 938 pps        |          |
+------------+-------------+--------------+----------------+----------+

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 4ee1ed6e815a..e56358878c36 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1052,6 +1052,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
 	int len = skb->len;
+	int ret;
 
 	rcu_read_lock();
 	tfile = rcu_dereference(tun->tfiles[txq]);
@@ -1106,13 +1107,33 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	nf_reset_ct(skb);
 
-	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
+	queue = netdev_get_tx_queue(dev, txq);
+
+	spin_lock(&tfile->tx_ring.producer_lock);
+	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
+	if (!qdisc_txq_has_no_queue(queue) &&
+	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
+		netif_tx_stop_queue(queue);
+		/* Paired with smp_mb() in __tun_wake_queue() */
+		smp_mb__after_atomic();
+		if (!__ptr_ring_check_produce(&tfile->tx_ring))
+			netif_tx_wake_queue(queue);
+	}
+	spin_unlock(&tfile->tx_ring.producer_lock);
+
+	if (ret) {
+		/* This should be a rare case if a qdisc is present, but
+		 * can happen due to lltx.
+		 * Since skb_tx_timestamp(), skb_orphan(),
+		 * run_ebpf_filter() and pskb_trim() could have tinkered
+		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
+		 * we must drop instead.
+		 */
 		drop_reason = SKB_DROP_REASON_FULL_RING;
 		goto drop;
 	}
 
 	/* dev->lltx requires to do our own update of trans_start */
-	queue = netdev_get_tx_queue(dev, txq);
 	txq_trans_cond_update(queue);
 
 	/* Notify and wake up reader process */
-- 
2.43.0


