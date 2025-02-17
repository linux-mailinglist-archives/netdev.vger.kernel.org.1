Return-Path: <netdev+bounces-166944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA69A38008
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C62B3B4503
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A6213224;
	Mon, 17 Feb 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="mZ5chjY9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SGdGB9IQ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DE23CE;
	Mon, 17 Feb 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787830; cv=none; b=bjl9/2CKO/ZlGgtJ/DIOeiWW+DsJ8G7gljGw5pzkyhlqoNK5Ywtts/XOsIwB0e1SaX6hm4UcNKUN72Ae6C59DuTXqSQCpBG4XN5KsD0aL1kOT5DB1SMUkSkiF/HyAqRBE4VVwx47IxMLUiuLPKL2Yu1TNrNdHqf7LKdKj/I6Paw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787830; c=relaxed/simple;
	bh=V0yy5uQXxe/oiC1fUVv88PXh8gRcjQhCBqnb09zBtpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gW1iYSzGIs3BYhsaoplLLAlvPK9jwWalTuMnl4lERvYM/Jgs1/vygIhTAr3teeJxkeXoThWh56KEizbhaPwzdNvM6tUVP/QFQiY6MLSNDCQ5NbrhxPEElyevKXjhl0Ywi9iMuUQf0t6XlhxshiuyyvtsKHeryObAadz4OZCEXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mZ5chjY9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SGdGB9IQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id BD0CE13801B3;
	Mon, 17 Feb 2025 05:23:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Mon, 17 Feb 2025 05:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1739787825; x=1739874225; bh=/1i7JT5sH6
	ydG0A4CgSzgTxTAyljNmdckN6fFmsl6SQ=; b=mZ5chjY9y0DbUC6aBLHk3HeBIc
	GOhL2RJwA+A66QbIQj9aIvTOe6Ik3XQQHl9MVTT1xBOObbEyfRAbl6G5Wxc3UVdf
	F8wAeU3XWER0Ygu88UJ9Z/70I96yNoD8AqLnmg95U67hMht5npm0C4OKGHjsEn2N
	kN8QMQO7iVqcSHdbV/YoeWHcPnPQdaYjMC81o5gxcAzVMPNvvycQMkYGsFSxpFUT
	YvO0iyxZDaOaTQPzleSO/XTlDoCdr4rkPiLJ1/mx7AllzTDO4YRKQvryHMF9FVzg
	l2RgW/f96siue2fzNRMHOVKdVofvb00qtIRIMIogpLQNU7z5ZfAsX9KI1mFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739787825; x=1739874225; bh=/1i7JT5sH6ydG0A4CgSzgTxTAyljNmdckN6
	fFmsl6SQ=; b=SGdGB9IQDIbzE8PBQmkPtCyYvicgOSRAMet764Jptx+4eFRH670
	lVdCpWOo/NblNY4iBsq1YJQggNswMCeX8T8mKK52U2vUf7mbK+VlabLCtCtEX5FO
	U5SSbLm9t+J+lF+5y1V2Lx2HEAu0TfPAbT9ZvbFwrTk7AN5Z2260stgeNTtzItt5
	LlOHyoitHrm3HkDkA4OfZNl7BUdPJgp6TgAMgrTO0Iykr4BWiCrw327EXEWV5TpQ
	go7LVgUoQzvghfi/N9xheM1kMc5iV73F3XYXDXS72Z7EPK665CnlmDSqQH0tnYBz
	mLQCWgcQ7ONORdXcjoaNRw0oIRWP9NgBv/w==
X-ME-Sender: <xms:MA6zZ7zElBKpWuXNtRGF4w17qFTLn_GEQVqMrWBQpYYddbA3KDa1cg>
    <xme:MA6zZzTIXj_iVQ7DxQkeYrtsfZB6T518oB3i5m3BQoIa-43I0htOSBTuWGrWG9-RI
    BHVv-jZZI4G7b_nRr0>
X-ME-Received: <xmr:MA6zZ1VOisLHYGZVJEM3U0AWV3uk96UtzYuiy3KIaR2TKf6tJa099HYv5YeD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeevgfeitdetjedtkeehffetjeekteekgeej
    tdeiudejleehgeeuledugfehveeltdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehq
    uhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhrtghpthhtohepkh
    husggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtph
    htthhopehntggrrhgufigvlhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhhn
    ihihuhesrghmrgiiohhnrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvges
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MA6zZ1gkg0je4uSTvF6U5tV_M3EHarggc2M-PSbUuIY-BDEJXt3agg>
    <xmx:MA6zZ9BN4b8bFG8CVnTgJExGeKLvWYif7QbJlUmdhVcYXEATSyUdQA>
    <xmx:MA6zZ-KdfbsV4udSWFk7dvgm_ABIfzj7Zy4ouceBt9U5D2JEy3Yjfw>
    <xmx:MA6zZ8DWSqtQWlav-R4o1vfSf0yGIaEJK31pO5eoyISfpJZB2vBPSQ>
    <xmx:MQ6zZyLtHh9gFoul8T7IKkFnORKGa1sSNOyZ0NZew7UzctULrjl8TgEg>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 05:23:44 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Xiumei Mu <xmu@redhat.com>
Subject: [PATCH net v2] tcp: drop secpath at the same time as we currently drop dst
Date: Mon, 17 Feb 2025 11:23:35 +0100
Message-ID: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
running tests that boil down to:
 - create a pair of netns
 - run a basic TCP test over ipcomp6
 - delete the pair of netns

The xfrm_state found on spi_byaddr was not deleted at the time we
delete the netns, because we still have a reference on it. This
lingering reference comes from a secpath (which holds a ref on the
xfrm_state), which is still attached to an skb. This skb is not
leaked, it ends up on sk_receive_queue and then gets defer-free'd by
skb_attempt_defer_free.

The problem happens when we defer freeing an skb (push it on one CPU's
defer_list), and don't flush that list before the netns is deleted. In
that case, we still have a reference on the xfrm_state that we don't
expect at this point.

We already drop the skb's dst in the TCP receive path when it's no
longer needed, so let's also drop the secpath. At this point,
tcp_filter has already called into the LSM hooks that may require the
secpath, so it should not be needed anymore. However, in some of those
places, the MPTCP extension has just been attached to the skb, so we
cannot simply drop all extensions.

Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lists")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v1: drop all extensions just before calling skb_attempt_defer_free
    https://lore.kernel.org/netdev/879a4592e4e4bd0c30dbe29ca189e224ec1739a5.1739201151.git.sd@queasysnail.net/
v2: - drop only secpath, as soon as possible - per Eric's feedback
    - add debug warns if trying to add to sk_receive_queue an skb with
      a dst or a secpath

@Eric feel free to add some tags (Suggested-by? sign-off?) for the
code I adapted from
https://lore.kernel.org/netdev/CANn89i+JdDukwEhZ%3D41FxY-w63eER6JVixkwL+s2eSOjo6aWEQ@mail.gmail.com/

 include/net/tcp.h       | 14 ++++++++++++++
 net/ipv4/tcp_fastopen.c |  4 ++--
 net/ipv4/tcp_input.c    |  8 ++++----
 net/ipv4/tcp_ipv4.c     |  2 +-
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5b2b04835688..930cda5b5eb9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -41,6 +41,7 @@
 #include <net/inet_ecn.h>
 #include <net/dst.h>
 #include <net/mptcp.h>
+#include <net/xfrm.h>
 
 #include <linux/seq_file.h>
 #include <linux/memcontrol.h>
@@ -683,6 +684,19 @@ void tcp_fin(struct sock *sk);
 void tcp_check_space(struct sock *sk);
 void tcp_sack_compress_send_ack(struct sock *sk);
 
+static inline void tcp_cleanup_skb(struct sk_buff *skb)
+{
+	skb_dst_drop(skb);
+	secpath_reset(skb);
+}
+
+static inline void tcp_add_receive_queue(struct sock *sk, struct sk_buff *skb)
+{
+	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
+	DEBUG_NET_WARN_ON_ONCE(secpath_exists(skb));
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+}
+
 /* tcp_timer.c */
 void tcp_init_xmit_timers(struct sock *);
 static inline void tcp_clear_xmit_timers(struct sock *sk)
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 0f523cbfe329..32b28fc21b63 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -178,7 +178,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	if (!skb)
 		return;
 
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 	/* segs_in has been initialized to 1 in tcp_create_openreq_child().
 	 * Hence, reset segs_in to 0 before calling tcp_segs_in()
 	 * to avoid double counting.  Also, tcp_segs_in() expects
@@ -195,7 +195,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
-	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	tcp_add_receive_queue(sk, skb);
 	tp->syn_data_acked = 1;
 
 	/* u64_stats_update_begin(&tp->syncp) not needed here,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eb82e01da911..6821e5540a53 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4970,7 +4970,7 @@ static void tcp_ofo_queue(struct sock *sk)
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
 		fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
 		if (!eaten)
-			__skb_queue_tail(&sk->sk_receive_queue, skb);
+			tcp_add_receive_queue(sk, skb);
 		else
 			kfree_skb_partial(skb, fragstolen);
 
@@ -5162,7 +5162,7 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 				  skb, fragstolen)) ? 1 : 0;
 	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
 	if (!eaten) {
-		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		tcp_add_receive_queue(sk, skb);
 		skb_set_owner_r(skb, sk);
 	}
 	return eaten;
@@ -5245,7 +5245,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 		__kfree_skb(skb);
 		return;
 	}
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 	__skb_pull(skb, tcp_hdr(skb)->doff * 4);
 
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
@@ -6226,7 +6226,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPHITS);
 
 			/* Bulk data transfer: receiver */
-			skb_dst_drop(skb);
+			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cc2b5194a18d..2632844d2c35 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2027,7 +2027,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	 */
 	skb_condense(skb);
 
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 
 	if (unlikely(tcp_checksum_complete(skb))) {
 		bh_unlock_sock(sk);
-- 
2.48.1


