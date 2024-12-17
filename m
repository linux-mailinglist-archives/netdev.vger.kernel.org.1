Return-Path: <netdev+bounces-152479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F03B9F4121
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 04:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2E7188A475
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA0B42AAB;
	Tue, 17 Dec 2024 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="HGwOZq2B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iWoXXXzh"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFA288B1;
	Tue, 17 Dec 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734404945; cv=none; b=rKRfanZecYMWfsvdRDuC2Ozx1tG7ZX9lDluo1rKWkTCnqPqRLZCgsASZ1mfQu6u5EEla3pJQ3aMQB6TRl9Vev/vJ8fUOszWXmoz72J4+2JWy3557oPDZzEU+NdeP2MVhVhjYBf5AFx8t/10hPGQq/sX4S8zuZDf9Rn8Iv13s6XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734404945; c=relaxed/simple;
	bh=RIDos4l/17u//yQ878YYYZi94Fi7AB2Btn2RXy+v5vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8By3B3iwpLvQQ3Yr1q3GfqJ70OvxAdoCaF8hQ3dJWXJnF8nqgm2hDyPF/x4TaGwo0nmjhTiSpw/ZpCTca0GEZ4+Wg2nnWFdQwNRQMnBM2UkZhKsnGH5xI5LAq01/WgeLT82xpxYAdYBVwEwwbSg0SueC8HJ14oAdrPmRDQbF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=HGwOZq2B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iWoXXXzh; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B903114012E;
	Mon, 16 Dec 2024 22:09:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Dec 2024 22:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1734404940; x=1734491340; bh=YMYmGjTpbD1LWBNys/n4b
	6hDesh8RNR2ZQpLI4bG7f8=; b=HGwOZq2BhikAoANui6l0/g3C3Waxt56Sj7jOy
	EMS34iaBwA6gcmlG6n2vHemYx6LYA1SqukkKe8VkkdLElpcYogq595WLkhY9LxjU
	KxMqGSEXWxBq2SG9sovWyH3Raj5HxwCRFg+A70k7wwMjYzOAp+CtcXhDWOgguBXX
	0Fc8xeYO0itGZYkyTkaxAepHvMfUWXisSu0VSgFU/TL4S6Sm6uQKBNMj3+g/lN2o
	OcGes6BFgTBsY5Bpac4QMtl4UHTs0xeAoe1ljg8QkNwlIhk+gU3jrQsAqUQR46Sw
	QDuOzFTDBzOQRfIfN0pZNFBaG/UeX4hLVAot+BJE6c+7WuSig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734404940; x=1734491340; bh=YMYmGjTpbD1LWBNys/n4b6hDesh8RNR2ZQp
	LI4bG7f8=; b=iWoXXXzh7NGLz4qlvJzzCBmVnNDEp8VwAGNsTZ8oRw1H8DlV+Ty
	fC/fvI9MFLaq8fbZZbMKipqUwkls5U5w2KXA+XasOaPjRLkYJOF3lWGvFjGgiVxT
	37EEYNzDQb2CQVy9GWsIN0xPPEjG6zE6RS0ctAhtqnanA72pmQtssffF7QSQe0Xb
	PlDSP0H0Yt9dV8vkAbooJ6dUtrJi22Cv5MTizafzHRkJA5iJKGK/y1GNxH9SoZRe
	VwMwmcuGlquE+kmvDaFx4N4FOdc108cA4h2GD0yIZZJui50j3Q1A/xPPZDrmyaDl
	Mg2Z7MB1qaXkDPmkRCYA+COQIca4Vx6hlfg==
X-ME-Sender: <xms:TOtgZ67XcdiK2KE0OYIXpLfNcI5ka0W6KVl_iuz9J4FCycX9dO3FOQ>
    <xme:TOtgZz5FnXC98oDVUk-L7zpscrH2nq8oO8N6KMnxV5lc3d56RbgbKX1K5qENDsErm
    HFSIi17iHRxpQsOodY>
X-ME-Received: <xmr:TOtgZ5eHtM8z1rv4i9C-pQfiqBDWxixbYTodZ_ysgxVRcEHnWL2kgPd5HQ8bhh8GQ5ynZYddsiEa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgggfestdekredtredttdenucfhrhhomhepofgriihinhcutehlucfjrgguuggrugcu
    oehmrgiiihhnsehgvghtshhtrghtvgdruggvvheqnecuggftrfgrthhtvghrnheptddvgf
    fgjeduueduiefghedvtdetfeehffevjedtfffgtdfhkefhueehvdfgvddvnecuffhomhgr
    ihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgriihinhesghgvthhsthgrthgv
    rdguvghvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgrhhgv
    rhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhgriihinhesghgvthhsthgrthgvrdguvghv
X-ME-Proxy: <xmx:TOtgZ3LRxte4OhTIJJcD-8w2lNEfaP_RMVjXiTIWmBa-iTq8ln2NEA>
    <xmx:TOtgZ-JdL635TaBnMOOqe3iKZOy-jRhuzyz3OlgejR3xWm5lI1u-Vg>
    <xmx:TOtgZ4yhwlTS28-4f_znHf67UMZoQ9oKQxI50wrKX-setwVxB7BZCA>
    <xmx:TOtgZyIisLsSzh6GAIfJ2H5kaj30JdpnK21nB-jBBm9G0plbj0F4Jw>
    <xmx:TOtgZ7AskTLnWn9dE7zrYIBFSRB6Ps_vCZx7KguGHEoLip3NkflSiZ7S>
Feedback-ID: i0ed1493d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 22:08:57 -0500 (EST)
From: Mazin Al Haddad <mazin@getstate.dev>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mazin Al Haddad <mazin@getstate.dev>,
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Subject: [PATCH] ip6_tunnel: Fix uninit-value in ip6_tnl_xmit
Date: Tue, 17 Dec 2024 06:07:51 +0300
Message-ID: <20241217030751.11226-1-mazin@getstate.dev>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When taking the branch with skb_realloc_headroom, pskb_expand_head is
called, as such, pointers referencing content within the new skb's header
are invalid. Currently, the assignment of hop_limit accesses the now
invalid pointer in the network header of this "new" skb. Fix this by
moving the logic to assign hop_limit earlier so that the assignment
references the original un-resized skb instead.

uninit-value in ip6table_mangle_hook+0x97d/0x9c0 net/ipv6/netfilter/ip6table_mangle.c:72
 ip6t_mangle_out net/ipv6/netfilter/ip6table_mangle.c:56 [inline]
 ip6table_mangle_hook+0x97d/0x9c0 net/ipv6/netfilter/ip6table_mangle.c:72
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 __ip6_local_out+0x5ac/0x640 net/ipv6/output_core.c:143
 ip6_local_out+0x4c/0x210 net/ipv6/output_core.c:153
 ip6tunnel_xmit+0x129/0x460 include/net/ip6_tunnel.h:161
 ip6_tnl_xmit+0x341a/0x3860 net/ipv6/ip6_tunnel.c:1281

Uninit was stored to memory at:
 ip6_tnl_xmit+0x34f7/0x3860 net/ipv6/ip6_tunnel.c:1277
 __gre6_xmit+0x14b9/0x1550 net/ipv6/ip6_gre.c:815
 ip6gre_xmit_ipv4 net/ipv6/ip6_gre.c:839 [inline]
 ip6gre_tunnel_xmit+0x18f7/0x2030 net/ipv6/ip6_gre.c:922

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_track_caller_noprof+0x6c7/0xf90 mm/slub.c:4283
 kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:609
 pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
 skb_realloc_headroom+0x140/0x2b0 net/core/skbuff.c:2355
 ip6_tnl_xmit+0x2106/0x3860 net/ipv6/ip6_tunnel.c:1227
 __gre6_xmit+0x14b9/0x1550 net/ipv6/ip6_gre.c:815
 ip6gre_xmit_ipv4 net/ipv6/ip6_gre.c:839 [inline]
 ip6gre_tunnel_xmit+0x18f7/0x2030 net/ipv6/ip6_gre.c:922

Reported-by: syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
Signed-off-by: Mazin Al Haddad <mazin@getstate.dev>
---
 net/ipv6/ip6_tunnel.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 48fd53b98972..62a51f03360d 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1098,7 +1098,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	unsigned int max_headroom = psh_hlen;
 	__be16 payload_protocol;
 	bool use_cache = false;
-	u8 hop_limit;
+	u8 hop_limit = 0;
 	int err = -1;
 
 	payload_protocol = skb_protocol(skb, true);
@@ -1215,6 +1215,15 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 
 	skb_scrub_packet(skb, !net_eq(t->net, dev_net(dev)));
 
+	if (hop_limit == 0) {
+		if (payload_protocol == htons(ETH_P_IP))
+			hop_limit = ip_hdr(skb)->ttl;
+		else if (payload_protocol == htons(ETH_P_IPV6))
+			hop_limit = ipv6_hdr(skb)->hop_limit;
+		else
+			hop_limit = ip6_dst_hoplimit(dst);
+	}
+
 	/*
 	 * Okay, now see if we can stuff it in the buffer as-is.
 	 */
@@ -1243,15 +1252,6 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	}
 	skb_dst_set(skb, dst);
 
-	if (hop_limit == 0) {
-		if (payload_protocol == htons(ETH_P_IP))
-			hop_limit = ip_hdr(skb)->ttl;
-		else if (payload_protocol == htons(ETH_P_IPV6))
-			hop_limit = ipv6_hdr(skb)->hop_limit;
-		else
-			hop_limit = ip6_dst_hoplimit(dst);
-	}
-
 	/* Calculate max headroom for all the headers and adjust
 	 * needed_headroom if necessary.
 	 */
-- 
2.46.0


