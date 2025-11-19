Return-Path: <netdev+bounces-240195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4AC71513
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2FA1D2E3C6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F0C32E6A7;
	Wed, 19 Nov 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ECG1ya7r"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D92C178E
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592166; cv=none; b=cTHeUviMbji9+KxUreFxQVXCg+IFy7Nlmd4cut16+bMoy1u8/tAvxeeAZ7iHb8tCs7vsZC9AVB06m6oG6jgq7537/fX53Ob/5qeIjJFnHlcJ9zskzsTkQj2F2YisXj1uZ9O/gkiETzH6zTKOA90OprPnMfx+WIqkcfAnaHLESxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592166; c=relaxed/simple;
	bh=GGIYofSpJetz0G/DijcVeZfshF99ebnoJhj3c2n6FnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msl8610WMaUOizYJNVKnQ1h+w1xioJOHBSlqsjTAcIyA1+2kjLAYR6cqD7ABvbqmWFaUANlMSyv25Zm6YPdpB20u94PE+cw4Eo27+OiFQ98X0yOU+Bki5Y3+f1pK07Jkuka1mEBymyqRp+QzxNfRKVDTBzxUBWFyrKBjxqxNm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ECG1ya7r; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsr-006ypp-Fv; Wed, 19 Nov 2025 23:42:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=KQSx02HfqdXV3FVS/PIgGpzRzBe8PakhMgRiOJybjb4=; b=ECG1ya7rAkE2AU1b7MJ4tGMs0d
	NzA58Xj6Jm3TdE6A4Sy2Oz6zxBe1gEz7bEmIA1WSi/lP1+aVI0cQm392zRWGk17k1cWQqP03s+v6H
	RBIecCOZYZMgNuNoXXx8d/6txCveyFoNuUIAB+QVaytdgZLVV9RW1MK6AXcv7FQPGyEZBvocLbG//
	pzh+19ln/rv7FgqLLH9V2vSt1tMEMPnWT59LGf99Yw9E2+JYU+c+l+OIVwEY5BegdODJWTvlSnqU6
	qT0EI91c3XpbK5PwUiB4D5QELSK3AdWcrD5RPqf8w/hREC7lec0BSDs0yGKhTsueIe2jRHN+Ig1Yb
	zB0IuVFw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsq-0000Az-LE; Wed, 19 Nov 2025 23:42:40 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsp-00Fos6-45; Wed, 19 Nov 2025 23:42:39 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 42/44] net: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:38 +0000
Message-Id: <20251119224140.8616-43-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
and so cannot discard significant bits.

In this case the 'unsigned long' value is small enough that the result
is ok.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/core/net-sysfs.c   | 3 +--
 net/ipv4/fib_trie.c    | 2 +-
 net/ipv4/tcp_input.c   | 4 ++--
 net/ipv4/tcp_output.c  | 5 ++---
 net/ipv4/tcp_timer.c   | 4 ++--
 net/ipv6/addrconf.c    | 8 ++++----
 net/ipv6/ndisc.c       | 5 ++---
 net/packet/af_packet.c | 2 +-
 net/unix/af_unix.c     | 4 ++--
 9 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ca878525ad7c..8aaeed38be0b 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -985,8 +985,7 @@ static int netdev_rx_queue_set_rps_mask(struct netdev_rx_queue *queue,
 	struct rps_map *old_map, *map;
 	int cpu, i;
 
-	map = kzalloc(max_t(unsigned int,
-			    RPS_MAP_SIZE(cpumask_weight(mask)), L1_CACHE_BYTES),
+	map = kzalloc(max(RPS_MAP_SIZE(cpumask_weight(mask)), L1_CACHE_BYTES),
 		      GFP_KERNEL);
 	if (!map)
 		return -ENOMEM;
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 59a6f0a9638f..e85441717222 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -710,7 +710,7 @@ static unsigned char update_suffix(struct key_vector *tn)
 	 * tn->pos + tn->bits, the second highest node will have a suffix
 	 * length at most of tn->pos + tn->bits - 1
 	 */
-	slen_max = min_t(unsigned char, tn->pos + tn->bits - 1, tn->slen);
+	slen_max = min(tn->pos + tn->bits - 1, tn->slen);
 
 	/* search though the list of children looking for nodes that might
 	 * have a suffix greater than the one we currently have.  This is
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e4a979b75cc6..8c9eb91190ae 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2870,7 +2870,7 @@ static void tcp_mtup_probe_success(struct sock *sk)
 	val = (u64)tcp_snd_cwnd(tp) * tcp_mss_to_mtu(sk, tp->mss_cache);
 	do_div(val, icsk->icsk_mtup.probe_size);
 	DEBUG_NET_WARN_ON_ONCE((u32)val != val);
-	tcp_snd_cwnd_set(tp, max_t(u32, 1U, val));
+	tcp_snd_cwnd_set(tp, max(1, val));
 
 	tp->snd_cwnd_cnt = 0;
 	tp->snd_cwnd_stamp = tcp_jiffies32;
@@ -3323,7 +3323,7 @@ void tcp_rearm_rto(struct sock *sk)
 			/* delta_us may not be positive if the socket is locked
 			 * when the retrans timer fires and is rescheduled.
 			 */
-			rto = usecs_to_jiffies(max_t(int, delta_us, 1));
+			rto = usecs_to_jiffies(max(delta_us, 1));
 		}
 		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS, rto, true);
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b94efb3050d2..516ea138993d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3076,7 +3076,7 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 			jiffies_to_usecs(inet_csk(sk)->icsk_rto) :
 			tcp_rto_delta_us(sk);  /* How far in future is RTO? */
 	if (rto_delta_us > 0)
-		timeout = min_t(u32, timeout, usecs_to_jiffies(rto_delta_us));
+		timeout = min(timeout, usecs_to_jiffies(rto_delta_us));
 
 	tcp_reset_xmit_timer(sk, ICSK_TIME_LOSS_PROBE, timeout, true);
 	return true;
@@ -4382,8 +4382,7 @@ void tcp_send_delayed_ack(struct sock *sk)
 		 * directly.
 		 */
 		if (tp->srtt_us) {
-			int rtt = max_t(int, usecs_to_jiffies(tp->srtt_us >> 3),
-					TCP_DELACK_MIN);
+			int rtt = max(usecs_to_jiffies(tp->srtt_us >> 3), TCP_DELACK_MIN);
 
 			if (rtt < max_ato)
 				max_ato = rtt;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 2dd73a4e8e51..9d5fc405e76a 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -43,7 +43,7 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 	if (remaining <= 0)
 		return 1; /* user timeout has passed; fire ASAP */
 
-	return min_t(u32, icsk->icsk_rto, msecs_to_jiffies(remaining));
+	return min(icsk->icsk_rto, msecs_to_jiffies(remaining));
 }
 
 u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
@@ -504,7 +504,7 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 		 */
 		if (rtx_delta > user_timeout)
 			return true;
-		timeout = min_t(u32, timeout, msecs_to_jiffies(user_timeout));
+		timeout = umin(timeout, msecs_to_jiffies(user_timeout));
 	}
 	/* Note: timer interrupt might have been delayed by at least one jiffy,
 	 * and tp->rcv_tstamp might very well have been written recently.
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 40e9c336f6c5..930e34af4331 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1422,11 +1422,11 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	if_public_preferred_lft = ifp->prefered_lft;
 
 	memset(&cfg, 0, sizeof(cfg));
-	cfg.valid_lft = min_t(__u32, ifp->valid_lft,
-			      READ_ONCE(idev->cnf.temp_valid_lft) + age);
+	cfg.valid_lft = min(ifp->valid_lft,
+			    READ_ONCE(idev->cnf.temp_valid_lft) + age);
 	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
-	cfg.preferred_lft = min_t(__u32, if_public_preferred_lft, cfg.preferred_lft);
-	cfg.preferred_lft = min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
+	cfg.preferred_lft = min(if_public_preferred_lft, cfg.preferred_lft);
+	cfg.preferred_lft = min(cfg.valid_lft, cfg.preferred_lft);
 
 	cfg.plen = ifp->prefix_len;
 	tmp_tstamp = ifp->tstamp;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f427e41e9c49..b3bcbf0d864b 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1731,9 +1731,8 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 		neigh_release(neigh);
 	}
 
-	rd_len = min_t(unsigned int,
-		       IPV6_MIN_MTU - sizeof(struct ipv6hdr) - sizeof(*msg) - optlen,
-		       skb->len + 8);
+	rd_len = min(IPV6_MIN_MTU - sizeof(struct ipv6hdr) - sizeof(*msg) - optlen,
+		     skb->len + 8);
 	rd_len &= ~0x7;
 	optlen += rd_len;
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 173e6edda08f..af0c74f7b4d4 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3015,7 +3015,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	hlen = LL_RESERVED_SPACE(dev);
 	tlen = dev->needed_tailroom;
 	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
-	linear = max(linear, min_t(int, len, dev->hard_header_len));
+	linear = max(linear, min(len, dev->hard_header_len));
 	skb = packet_alloc_skb(sk, hlen + tlen, hlen, len, linear,
 			       msg->msg_flags & MSG_DONTWAIT, &err);
 	if (skb == NULL)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 768098dec231..e573fcb21a01 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2448,7 +2448,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			/* allow fallback to order-0 allocations */
 			size = min_t(int, size, SKB_MAX_HEAD(0) + UNIX_SKB_FRAGS_SZ);
 
-			data_len = max_t(int, 0, size - SKB_MAX_HEAD(0));
+			data_len = max(0, size - (int)SKB_MAX_HEAD(0));
 
 			data_len = min_t(size_t, size, PAGE_ALIGN(data_len));
 
@@ -3054,7 +3054,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			sunaddr = NULL;
 		}
 
-		chunk = min_t(unsigned int, unix_skb_len(skb) - skip, size);
+		chunk = min(unix_skb_len(skb) - skip, size);
 		chunk = state->recv_actor(skb, skip, chunk, state);
 		if (chunk < 0) {
 			if (copied == 0)
-- 
2.39.5


