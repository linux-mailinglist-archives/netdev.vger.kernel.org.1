Return-Path: <netdev+bounces-267058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENVCBVK7smmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:10:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B36272504
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF5BF31AEC50
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC113C6A2E;
	Thu, 12 Mar 2026 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="DknabfDH"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5223C4566;
	Thu, 12 Mar 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320825; cv=none; b=QfcGdirBN473ZwRvs0aOz837eqksG84vqQbtZOHST5pSPELm14HrzQRY1eqSqPjhOSGnZc7QKhtV0VGLEUxTEtIOff+b8AY2/FZR3qNlL4emysryjb0wGDL2uL3sPnwwFiqoR9Rwr5JH7a6c8UTkTfnnT3FBJNLBAq0vGTwC2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320825; c=relaxed/simple;
	bh=14g8Dn3IYRYwobx+qBN31EM/eWBQu9pcStubPs0cKHc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrItxwnIkSpvkt7Y8NPg17GHGfbSI1GpLa7oXzRlZQ6u2JtTf931haTk2iFH8bDVlivjv++48iQqveJjBB9CAwDOjPDYKg3rx+7OgbDTxbUaUk6aZTzlUOXnXMVNFKTlYJ8yPxjXj+XyPzDgoP1s4yJwSg9eOrTsEPzcdAR20II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=DknabfDH; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1773320812;
	bh=14g8Dn3IYRYwobx+qBN31EM/eWBQu9pcStubPs0cKHc=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=DknabfDHUcW1dg3aQivqf4TQmz8Lm6eGW3e0/Qt/nDgixLG060gF/35aeJttA+sKX
	 h2KpKNBEvPv3tOvGJmQLFFOcrjWdQwgh7+xV+7gMpr4UAaM06OZ1YH2m8MzPiXnWeM
	 6cJe4xBcyTpGFmyoCOUjKMPr33vv2ea5dJwsUF+g=
Received: from simon-Latitude-5450.fritz.box ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 62CD6mqn014094
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 14:06:52 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
Date: Thu, 12 Mar 2026 14:06:39 +0100
Message-ID: <20260312130639.138988-5-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-267058-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:dkim,tu-dortmund.de:email,tu-dortmund.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72B36272504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This commit prevents tail-drop when a qdisc is present and the ptr_ring
becomes full. Once an entry is successfully produced and the ptr_ring
reaches capacity, the netdev queue is stopped instead of dropping
subsequent packets.

If producing an entry fails anyways due to a race, tun_net_xmit returns
NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
LLTX is enabled and the transmit path operates without the usual locking.

The existing __tun_wake_queue() function wakes the netdev queue. Races
between this wakeup and the queue-stop logic could leave the queue
stopped indefinitely. To prevent this, a memory barrier is enforced
(as discussed in a similar implementation in [1]), followed by a recheck
that wakes the queue if space is already available.

If no qdisc is present, the previous tail-drop behavior is preserved.

Benchmarks:
The benchmarks show a slight regression in raw transmission performance,
though no packets are lost anymore.

The previously introduced threshold to only wake after the queue stopped
and half of the ring was consumed showed to be a descent choice:
Waking the queue whenever a consume made space in the ring strongly
degrades performance for tap, while waking only when the ring is empty
is too late and also hurts throughput for tap & tap+vhost-net.
Other ratios (3/4, 7/8) showed similar results (not shown here), so
1/2 was chosen for the sake of simplicity for both tun/tap and
tun/tap+vhost-net.

Test setup:
AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
Average over 20 runs @ 100,000,000 packets. SRSO and spectre v2
mitigations disabled.

Note for tap+vhost-net:
XDP drop program active in VM -> ~2.5x faster, slower for tap due to
more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)

+--------------------------+--------------+----------------+----------+
| 1 thread                 | Stock        | Patched with   | diff     |
| sending                  |              | fq_codel qdisc |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Transmitted | 1.151 Mpps   | 1.139 Mpps     | -1.1%    |
|            +-------------+--------------+----------------+----------+
|            | Lost/s      | 3.606 Mpps   | 0 pps          |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Transmitted | 3.948 Mpps   | 3.738 Mpps     | -5.3%    |
|            +-------------+--------------+----------------+----------+
| +vhost-net | Lost/s      | 496.5 Kpps   | 0 pps          |          |
+------------+-------------+--------------+----------------+----------+

+--------------------------+--------------+----------------+----------+
| 2 threads                | Stock        | Patched with   | diff     |
| sending                  |              | fq_codel qdisc |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Transmitted | 1.133 Mpps   | 1.109 Mpps     | -2.1%    |
|            +-------------+--------------+----------------+----------+
|            | Lost/s      | 8.269 Mpps   | 0 pps          |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Transmitted | 3.820 Mpps   | 3.513 Mpps     | -8.0%    |
|            +-------------+--------------+----------------+----------+
| +vhost-net | Lost/s      | 4.961 Mpps   | 0 pps          |          |
+------------+-------------+--------------+----------------+----------+

[1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.org/

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b86582cc6cb6..9b7daec69acd 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
 	int len = skb->len;
+	bool qdisc_present;
+	int ret;
 
 	rcu_read_lock();
 	tfile = rcu_dereference(tun->tfiles[txq]);
@@ -1063,13 +1065,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	nf_reset_ct(skb);
 
-	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
+	queue = netdev_get_tx_queue(dev, txq);
+	qdisc_present = !qdisc_txq_has_no_queue(queue);
+
+	spin_lock(&tfile->tx_ring.producer_lock);
+	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
+	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
+		netif_tx_stop_queue(queue);
+		/* Avoid races with queue wake-ups in __tun_wake_queue by
+		 * waking if space is available in a re-check.
+		 * The barrier makes sure that the stop is visible before
+		 * we re-check.
+		 */
+		smp_mb__after_atomic();
+		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
+			netif_tx_wake_queue(queue);
+	}
+	spin_unlock(&tfile->tx_ring.producer_lock);
+
+	if (ret) {
+		/* If a qdisc is attached to our virtual device,
+		 * returning NETDEV_TX_BUSY is allowed.
+		 */
+		if (qdisc_present) {
+			rcu_read_unlock();
+			return NETDEV_TX_BUSY;
+		}
 		drop_reason = SKB_DROP_REASON_FULL_RING;
 		goto drop;
 	}
 
 	/* dev->lltx requires to do our own update of trans_start */
-	queue = netdev_get_tx_queue(dev, txq);
 	txq_trans_cond_update(queue);
 
 	/* Notify and wake up reader process */
-- 
2.43.0


