Return-Path: <netdev+bounces-255984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMC7MXX6gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:26:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDD0D0813
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3073060BED
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD96F3033C7;
	Mon,  2 Feb 2026 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="qKemJCIG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wpV9VGIb"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628B3016E5
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060240; cv=none; b=OqCPiX26K3x2E5KsLCj4m+lGtrUM+R1v/v7shy9PRETax6GI8OjVuFltOeqeaH9HVmALfAS3pm8TIUaLxeZGS69UtSHLEnWK/6J8uDn5F+Kz5fOU/MCGxXUwZEvut878tUdQvDw/g0w9TeD2QYn/TzT4VxvCnDD8l0pqNE4e7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060240; c=relaxed/simple;
	bh=nahnnWxCnABF9qTG+jTt9zk1OwoKN2plbZBRVKWJo5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYQZSk/HDgaRJRWILcOu0G7D/vYNtFcOiNLU0TzqiZMonkAsSScNlbh8bWf1epbLpBaoAzawSsgpQvottCBH98fmY8XpXhZVlU/O50fVMhj3ppmYMeTTGNaweI2/0WlNxVx77w3ZJ8sqV4TS0iTF6ntfl2JtYsqB290lP0D20VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=qKemJCIG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wpV9VGIb; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 450561D0007E;
	Mon,  2 Feb 2026 14:23:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 02 Feb 2026 14:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060238; x=
	1770146638; bh=llgShHhwtiFWxKoRX+Fhp/bqOw/RoHI3FheDy6ytQ5U=; b=q
	KemJCIGW9h1gMFfvfDCHyBQV3sDVFGFkW3Hvj3D0XYD7lmL5WlAbq7VUBES2InW7
	nvCbYnudMEtGt/303gDM/n6sTuKi3gNNuXofrBFfohwKoAUbKzgVhbYcVDTWairU
	AQ9ZS15vXHjfGaIEBtr/rjF2zeDR5UjInzokEoNid/a1GAvrOytihYKqW4OhWRKW
	631qUNKUj4z31e7bGr22b5WwL53d2HmqgylCzMoQuXuKtrOrPc+LjLlsezotsgcF
	ZqFSl6RdDaabDUftBpB9ji4EoAb1U8ibg18fCTs6daN19g315u6eOAGpLldBnPHJ
	kdpXRFGbD8BYj5+aFS24A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060238; x=1770146638; bh=l
	lgShHhwtiFWxKoRX+Fhp/bqOw/RoHI3FheDy6ytQ5U=; b=wpV9VGIbKoDqSssvS
	3nBPLI8UqpwqHHE5FSR3EPiFvd4qWGRAMbgEd60c5t5B5EQ71DsEY9prJwRfQrRH
	IRA4SjkoQMouhoz4fUWTiyXiWXuUI9mpv6/xe8RlNyu5qadoNA9AspBmp/pA3TtD
	oXsfE8HQ9PNeYxIDcNlb0XiKai5bivvD60lKsJ95DKa8A57Xqvdu6RRZbeMMHgiC
	Xh5I/+Ii5Lt4h1YSHErjo8nUARuhIsys8iInU2CToZ+/T9/4U9ilvkRF7vqxIjVT
	wGRT5RmcD53VqSkzXEekmmnC5JcgKWsEX3AVnp84lFwCT7LqtYxJI0ZVGgVaftU5
	tfOYA==
X-ME-Sender: <xms:zfmAadHkibZHhoX8hpROpqIleLgmSAd9_SP7HOVVD_GX-H4p41Qe3g>
    <xme:zfmAaYuxYB01F6e7ynl3QLstDecDdFKiwzgXzF7M0N3UYkmDGR-IRm6Np8oGRv9mB
    QXZczwbXUi8kmsy7XvhRxn3V8Rzjo_r153qhv60vvcNcBv-hBB9Zsw>
X-ME-Received: <xmr:zfmAababwhQ8HIkZdvE0-OPwID__WDvEz5oOjeiZC_LczES-mu8yLyjEjmI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:zvmAaQ5w93PvnRLOy39yRcd3_KnmX_apD1A4YzGjTExp6jxJ1tKYeA>
    <xmx:zvmAab9U2bjBWHNDfOytuswR1Jf1eY7PdaU6VnCGCc02gx1mvlwC5g>
    <xmx:zvmAaUb7asYzqg4Q0ZRFpIZlMrPI2hM-caWDhH17RZpInrKj1iURFQ>
    <xmx:zvmAac7Dw2vh-aDJlqfayqwHAR1GtVHkfPbv3L9dFFQLz0n1I70oLA>
    <xmx:zvmAaZz2Z3Vl6bgIiTVXNuLtrqxGK0hWgeGPZ2X2niG1YFYiP3yyha0R>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:23:57 -0500 (EST)
From: Alice Mikityanska <alice.projects@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v3 02/11] net/ipv6: Drop HBH for BIG TCP on TX side
Date: Mon,  2 Feb 2026 21:23:29 +0200
Message-ID: <20260202192338.2373930-3-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202192338.2373930-1-alice.projects@fastmail.im>
References: <20260202192338.2373930-1-alice.projects@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-255984-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 2DDD0D0813
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

BIG TCP IPv6 inserts a hop-by-hop extension header to indicate the real
IPv6 payload length when it doesn't fit into the 16-bit field in the
IPv6 header itself. While it helps tools parse the packet, it also
requires every driver that supports TSO and BIG TCP to remove this
8-byte extension header. It might not sound that bad until we try to
apply it to tunneled traffic. Currently, the drivers don't attempt to
strip HBH if skb->encapsulation = 1. Moreover, trying to do so would
require dissecting different tunnel protocols and making corresponding
adjustments on case-by-case basis, which would slow down the fastpath
(potentially also requiring adjusting checksums in outer headers).

At the same time, BIG TCP IPv4 doesn't insert any extra headers and just
calculates the payload length from skb->len, significantly simplifying
implementing BIG TCP for tunnels.

Stop inserting HBH when building BIG TCP GSO SKBs.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/ipv6.h  |  1 -
 net/ipv6/ip6_output.c | 20 +++-----------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 9dd05743de36..e9c7127aaef3 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -175,7 +175,6 @@ struct inet6_skb_parm {
 #define IP6SKB_L3SLAVE         64
 #define IP6SKB_JUMBOGRAM      128
 #define IP6SKB_SEG6	      256
-#define IP6SKB_FAKEJUMBO      512
 #define IP6SKB_MULTIPATH      1024
 #define IP6SKB_MCROUTE        2048
 };
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f904739e99b9..ed1b8e62ef61 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -179,8 +179,7 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 static int ip6_finish_output_gso(struct net *net, struct sock *sk,
 				 struct sk_buff *skb, unsigned int mtu)
 {
-	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
+	if (!skb_gso_validate_network_len(skb, mtu))
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -273,8 +272,6 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
-	struct hop_jumbo_hdr *hop_jumbo;
-	int hoplen = sizeof(*hop_jumbo);
 	struct net *net = sock_net(sk);
 	unsigned int head_room;
 	struct net_device *dev;
@@ -287,7 +284,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	rcu_read_lock();
 
 	dev = dst_dev_rcu(dst);
-	head_room = sizeof(struct ipv6hdr) + hoplen + LL_RESERVED_SPACE(dev);
+	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
@@ -312,19 +309,8 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 					     &fl6->saddr);
 	}
 
-	if (unlikely(seg_len > IPV6_MAXPLEN)) {
-		hop_jumbo = skb_push(skb, hoplen);
-
-		hop_jumbo->nexthdr = proto;
-		hop_jumbo->hdrlen = 0;
-		hop_jumbo->tlv_type = IPV6_TLV_JUMBO;
-		hop_jumbo->tlv_len = 4;
-		hop_jumbo->jumbo_payload_len = htonl(seg_len + hoplen);
-
-		proto = IPPROTO_HOPOPTS;
+	if (unlikely(seg_len > IPV6_MAXPLEN))
 		seg_len = 0;
-		IP6CB(skb)->flags |= IP6SKB_FAKEJUMBO;
-	}
 
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
-- 
2.52.0


