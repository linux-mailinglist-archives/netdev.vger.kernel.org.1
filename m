Return-Path: <netdev+bounces-165253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD0A3146D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5113A913D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214BE262163;
	Tue, 11 Feb 2025 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="oRmIiDmN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZG0dsze"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66725A2DB
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299899; cv=none; b=CBiy5yXxJ56wZIXQCy0iNEE5oXrRkiqQNOh22ZqAR7Uqllhj8/OZwJ429HpptzELumgUbrucFyy4dIoelnV053TsJVP8Mhu7+oyCeMGWN3rsc2Ctp0mCPxKmK/SFQmZGupHqeToQHhnlt9QJkA8PRKdsJuE46G1I6rHa92VzyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299899; c=relaxed/simple;
	bh=HKxgrwAh3FcbnMG/8b9QVIFKvO4nlG0oz6AXX60Ccq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+ShjXGWZK/uX6mfp4+yuOYDBJ4WYuLb3iMfm7GVvbBPZZY7U4KRQbicdhk7zwWqMFuQoorSgr6uyWoXV7oNMem/54Y+GQNadSWNfB/hmxRuKnlLoaHsNoz1BR/YyHl1QqYNBPebQBS0J09FpxVO1iA8BXD0eAuTDqJoB0wW4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=oRmIiDmN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZG0dsze; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9CA41140158;
	Tue, 11 Feb 2025 13:51:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 11 Feb 2025 13:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739299893; x=1739386293; bh=8N/1GAZaVBVTAacADspEgcDNnznGhRfc
	c2xZkVkP8u8=; b=oRmIiDmNA8z3wtylHKEoT6FTa9a7aB/35CgG7OLLNsTQiyoX
	vrycB7YgsnQEJfQg3qokK9FKrMGIDKbxdC3iZXF52MFZVbcoRhYNb6orKiTFPJXI
	ejuJopYyjPIG0JgL9idKU38DXD2KafJUfXHfh5wI6SiaERV4nWFxaQlB+yGnlafa
	bDQMUOlAVk5oaZdkAhrBorkKh9VT5qZXpgOCGjzyEyJ9GJCpWzGredKRHCQxQOv/
	Io6uqeaioXZInX5mzb/EAoRW+ISh/mIFTzTNyJtb1KAGGcbDsDzrY92bk3o2RTNd
	uSPfIF9ixjQH+6jVwWRoULq6WxP940yiBiy3+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739299893; x=
	1739386293; bh=8N/1GAZaVBVTAacADspEgcDNnznGhRfcc2xZkVkP8u8=; b=f
	ZG0dsze4Mcb9oH851pvuGi8qerd0fTPPUHpMR8mBnH11BPyAnzI9oUhxELl+mZTL
	5ZnOBNe5/GQcP72nBxByYKfsGQx569k7wNPBElvzgkE5qogkl7Ci0VrCh112ONrJ
	d/jydfyD4U1Z+s2KE+IKPjz8TpkR9K+h+tzoi5qMWyfvSNcP3biOgmFOVyXZRbQB
	vNFy4T8MhSU5JHScnwn4UO/1OvY1ZmLCIHGNNVFuDgWw7rGq5Sg+QI0wyVKZ6rCR
	v3Q6tAzQyZLJMNCueQw1w2MltPYNPq6PPxtq52VZOI635GTRTo0k9NmetDP97xUO
	WSiW/4rSRlZ0shvfEo9LA==
X-ME-Sender: <xms:NZyrZ8ey2ksUqsl3_MzHtNL-Y144dGOc6xtqD8N8BRAAP7yBBUPzFw>
    <xme:NZyrZ-MEJ3Lkg0ymVKQbJsYiGF4Kaxo2npyaVswpwfPHQRUdf-WFH1TtOJfMdL9f0
    52hMZn3I6aRoi4e18w>
X-ME-Received: <xmr:NZyrZ9hepfvaNXvH9FZHaGE_ujxtDIgsPJt1oFfuUDtxSdP4fEMRv1I03RDe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepveduvddtveehteekvdeiueegheei
    veejkeetfefgfeeffeejgfdvfedtleeufeegnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    ugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgtrghrugifvghl
    lhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhunhhihihusegrmhgriihonhdrtg
    homhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    peigmhhusehrvgguhhgrthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmoh
    horhgvrdgtohhm
X-ME-Proxy: <xmx:NZyrZx_eorw8SlWxkSIGGi_WTIWTe0l-w8h2KlBu4Asz1H0y1EfpPA>
    <xmx:NZyrZ4sxwIeSK-wEUViS0uq3kSjt40k1cNZ5Gn9VuJz_CdYKkTNoUQ>
    <xmx:NZyrZ4GWYjDVT-ocn1NH7Zue18cO1IYfKgQvIpelquWBQT6TJD1UDA>
    <xmx:NZyrZ3OMuzwldk7quBqMr9q_iwX0uv_t7reYy65GP9HkfXj1mQmcFw>
    <xmx:NZyrZ2CtSWFOj2_OJnbRw6y8Dq5ksGIQnAO_F-1oRnRmUqkw9resSYSl>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 13:51:32 -0500 (EST)
Date: Tue, 11 Feb 2025 19:51:30 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>, Xiumei Mu <xmu@redhat.com>,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH net] tcp: drop skb extensions before
 skb_attempt_defer_free
Message-ID: <Z6ucMj5FukT_lecR@hog>
References: <879a4592e4e4bd0c30dbe29ca189e224ec1739a5.1739201151.git.sd@queasysnail.net>
 <CANn89iJbzed1HnW7QHSRWno92hLAbQH+iaitAutqRh=CK9koaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJbzed1HnW7QHSRWno92hLAbQH+iaitAutqRh=CK9koaw@mail.gmail.com>

2025-02-10, 17:24:43 +0100, Eric Dumazet wrote:
> On Mon, Feb 10, 2025 at 5:02 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
> >
> > Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
> > running tests that boil down to:
> >  - create a pair of netns
> >  - run a basic TCP test over ipcomp6
> >  - delete the pair of netns
> >
> > The xfrm_state found on spi_byaddr was not deleted at the time we
> > delete the netns, because we still have a reference on it. This
> > lingering reference comes from a secpath (which holds a ref on the
> > xfrm_state), which is still attached to an skb. This skb is not
> > leaked, it ends up on sk_receive_queue and then gets defer-free'd by
> > skb_attempt_defer_free.
> >
> > The problem happens when we defer freeing an skb (push it on one CPU's
> > defer_list), and don't flush that list before the netns is deleted. In
> > that case, we still have a reference on the xfrm_state that we don't
> > expect at this point.
> >
> > tcp_eat_recv_skb is currently the only caller of skb_attempt_defer_free,
> > so I'm fixing it here. This patch also adds a DEBUG_NET_WARN_ON_ONCE
> > in skb_attempt_defer_free, to make sure we don't re-introduce this
> > problem.
> >
> > Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lists")
> > Reported-by: Xiumei Mu <xmu@redhat.com>
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > ---
> > A few comments:
> >  - AFAICT this could not happen before 68822bdf76f1, since we would
> >    have emptied the (per-socket) defer_list before getting to ->exit()
> >    for the netns
> >  - I thought about dropping the extensions at the same time as we
> >    already drop the dst, but Paolo said this is probably not correct due
> >    to IP_CMSG_PASSSEC
> 
> I think we discussed this issue in the past.
> 
> Are you sure IP_CMSG_PASSSEC  is ever used by TCP ?

After checking, I don't think so. The only way TCP can get to
IP_CMSG_PASSSEC is through the error queue, so it shouldn't matter.

The original commit (2c7946a7bf45 ("[SECURITY]: TCP/UDP getpeersec"))
also says that TCP should be using SO_PEERSEC for that purpose
(although likely based on the secpath as well, but not packet per
packet).

Based on the chat you had with Paul Moore back in November, it seems
any point after tcp_filter should be fine:

https://lore.kernel.org/netdev/CAHC9VhS3yuwrOPcH5_iRy50O_TtBCh_OVWHZgzfFTYqyfrw_zQ@mail.gmail.com


> Many layers in TCP can aggregate packets, are they aware of XFRM yet ?

I'm not so familiar with the depths of TCP, but with what you're
suggesting below, AFAIU the cleanup should happen before any
aggregation attempt (well, there's GRO...).


[...]
> If we think about it, storing thousands of packets in TCP sockets receive queues
> with XFRM state is consuming memory for absolutely no purpose.

True. I went with the simpler (less likely to break things
unexpectedly) fix for v1.

> It is worth noting MPTCP  calls skb_ext_reset(skb) after
> commit 4e637c70b503b686aae45716a25a94dc3a434f3a ("mptcp: attempt
> coalescing when moving skbs to mptcp rx queue")
> 
> I would suggest calling secpath_reset() earlier in TCP, from BH
> handler, while cpu caches are hot,
> instead of waiting for recvmsg() to drain the receive queue much later ?

Ok. So in the end it would look a lot like what you proposed in a
discussion with Ilya:
https://lore.kernel.org/netdev/CANn89i+JdDukwEhZ%3D41FxY-w63eER6JVixkwL+s2eSOjo6aWEQ@mail.gmail.com/

(as Paolo noticed, we can't just do skb_ext_reset because at least in
tcp_data_queue the MPTCP extension has just been attached)

An additional patch could maybe add DEBUG_NET_WARN_ON_ONCE at the time
we add skbs to sk_receive_queue, to check we didn't miss (or remove in
the future) places where the dst or secpath should have been dropped?

-------- 8< --------
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5b2b04835688..87c1e98d76cf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -683,6 +683,12 @@ void tcp_fin(struct sock *sk);
 void tcp_check_space(struct sock *sk);
 void tcp_sack_compress_send_ack(struct sock *sk);
 
+static inline void tcp_skb_cleanup(struct sk_buff *skb)
+{
+	skb_dst_drop(skb);
+	secpath_reset(skb);
+}
+
 /* tcp_timer.c */
 void tcp_init_xmit_timers(struct sock *);
 static inline void tcp_clear_xmit_timers(struct sock *sk)
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 0f523cbfe329..b815b9fc604c 100644
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
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eb82e01da911..bb0811c38908 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
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
Sabrina

