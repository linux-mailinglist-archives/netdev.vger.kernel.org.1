Return-Path: <netdev+bounces-287246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBOJFT1eA2rH5QEAu9opvQ
	(envelope-from <netdev+bounces-287246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:07:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB53B5256FA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7045031131CB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036643D79E9;
	Tue, 12 May 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="d8j0mRvY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwWS9AJ8"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB83D966A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605098; cv=none; b=lrdPlUm1ZNzkv1xHJa78aBpStLzYH4fbqoeAS4/h7EDmNuwcxICTIe2fiZwO65qnczo8qxy2vwrYsmXA4E+zWbxgjva9gJa4tJE6mjP8ozHuvx5rlZHeIOd/x9Kcv6+rGEfHu4DvVCtcDqljwTwrGlejjuNKWgMa08jjSW80cTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605098; c=relaxed/simple;
	bh=rUZrbdwHAwb7qWJQb4BsVCIuGGGQAGGDIxyzU2HxUiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9iVsXbcsBzT3hbLDytjHfw2njiUHNjctcwH6IeYsRDGAWBZpJL8nvUjLH3m1cnrGSmNETp4lv3P9WwgAOmbdBeH1k0zE6q7WGW9gX3oTg5WMuX4cry2gdwQvdwufIyePvBfj35BcBRNRk1RQTrKgMTcgxOoOtlgsjOLKdNrWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=d8j0mRvY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VwWS9AJ8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E9050EC021B;
	Tue, 12 May 2026 12:58:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 12:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778605096; x=
	1778691496; bh=rfFyIvJs81dzmkJ3vIBIPvSyawjdHVpKW9tl4634oqU=; b=d
	8j0mRvYrngDSyRPpS6OV+YQ9Xi6wZrfWXB4wHGjVZm+Cv6hcQuPfwCkcwn8fqVf9
	BhvU0pUw2DQx3Sjw0pQ8VRr00Evy/z8WSuaksqy8aS5QgdWE1K04h705acP5ia54
	UBLUAXk4AVY/dEdnmQ/HWDDoZ/5xiW4L3929Q8P9351t0dzHF1Z9UlaZPnRVcs8v
	U0l53auFEL7X/GfO1+d2N2dKY+6MA7UafP0LeQ1UZcznKRSrUFz62BMUWVQSPLwX
	WbZuXPnUnqbh7lfZOAMGhmk6DUZrNbZKIxAima4iWjGRBhzSEIEYrq6w3NkyT1my
	WLz2/4izaqG5nXtYpx8GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778605096; x=1778691496; bh=r
	fFyIvJs81dzmkJ3vIBIPvSyawjdHVpKW9tl4634oqU=; b=VwWS9AJ8ubloCSKfS
	vhb92ByVbDUdWco5BGsApXYXWnDTGIWjagqVQpH7o4mB//bagOLBgXbgq16nArlF
	yu0WAewMWdeu0L1mOZBU62HUU7omDv3cQdgt++a9BfiIOOoO01lp8DtO2zKTDSMB
	WxPrXaOmqLxLAlZ6g6YI+GGu0Kz0UWAtKiXKFx84giQKOJFhIHHEfjm5Fk7Ei3K3
	rjulwPvWP1DlcCDfsYzIpvEBCB7I8M437Z0o5TTK9QhojPa1DDgun1c584Lgry61
	YJsxEjNfou7ztLaQDNjYAcuHWeDzQAiuo5MvE8EPrpazW6ZgxxNlA6hwJQ9LyFFS
	sEwaQ==
X-ME-Sender: <xms:KFwDaq_RZaPUFhjdsfKDpmo04d6-K39IREx3tALYjITTKecyzz1NQA>
    <xme:KFwDapO_l_sqTEd_oq_uRnjK4ViL4EwYBUnmsadsh7QC21ciaZ1NE0D9Hh4Y6WLRp
    OFKpe6r7F1cf7se7b0To0eRCNpS_o3pqmHZfT1-C8Y2yg8OSBiv3XM>
X-ME-Received: <xmr:KFwDam2_OgHOBdCsoiSs0X7qxa9O49WGyesLGMbHIa1jbb4o2_RbMF4US75vrOQH7wmbTNhCi4b-y3FbLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KFwDaie74R0hs4hoQu6N-WX0EH1RJl0drq_eeShk0O0CrV3lX_lduA>
    <xmx:KFwDanb3NLGpUzVvpfFGeU0UHK0-4LMiBuuPbTXAQ2G0F6QHb1BL3g>
    <xmx:KFwDanXf4boSIKkhPiUl4Jw-moGUuXU2FncVwGAVZ7WGWTuwavoZpw>
    <xmx:KFwDaqRIeNXCfI6WGTZaQ_WIeSiateZA3jEIyk6bzaWf1IwuqwnNgA>
    <xmx:KFwDauHhR_4TIftfpf9i14dmOEZ1eqM0ysfE3l5dvAwPIuY3p_1WnV-y>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:58:16 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v4 07/12] udp: Support BIG TCP GSO packets where they can occur
Date: Tue, 12 May 2026 18:56:43 +0200
Message-ID: <20260512165648.386518-8-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512165648.386518-1-alice.kernel@fastmail.im>
References: <20260512165648.386518-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB53B5256FA
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-287246-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.977];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Wherever a GSO packet can occur, and its length is used to fill the UDP
header, use udp_set_len that assigns 0 if the length doesn't fit 16
bits, so that the packet can be properly parsed and segmented later,
instead of having truncated length.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/fou_core.c                    | 2 +-
 net/ipv6/fou6.c                        | 2 +-
 net/netfilter/ipvs/ip_vs_xmit.c        | 2 +-
 net/netfilter/nf_conntrack_proto_udp.c | 4 +++-
 net/psp/psp_main.c                     | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index a50740d0f288..aef3ce1dec7a 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -1040,7 +1040,7 @@ static void fou_build_udp(struct sk_buff *skb, struct ip_tunnel_encap *e,
 
 	uh->dest = e->dport;
 	uh->source = sport;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 	udp_set_csum(!(e->flags & TUNNEL_ENCAP_FLAG_CSUM), skb,
 		     fl4->saddr, fl4->daddr, skb->len);
 
diff --git a/net/ipv6/fou6.c b/net/ipv6/fou6.c
index 588929409241..4b659ca60ba9 100644
--- a/net/ipv6/fou6.c
+++ b/net/ipv6/fou6.c
@@ -30,7 +30,7 @@ static void fou6_build_udp(struct sk_buff *skb, struct ip_tunnel_encap *e,
 
 	uh->dest = e->dport;
 	uh->source = sport;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 	udp6_set_csum(!(e->flags & TUNNEL_ENCAP_FLAG_CSUM6), skb,
 		      &fl6->saddr, &fl6->daddr, skb->len);
 
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index ae3ed2c00ec3..c51ebd83a476 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1100,7 +1100,7 @@ ipvs_gue_encap(struct net *net, struct sk_buff *skb,
 	dport = cp->dest->tun_port;
 	udph->dest = dport;
 	udph->source = sport;
-	udp_set_len_short(udph, skb->len);
+	udp_set_len(udph, skb->len);
 	udph->check = 0;
 
 	*next_protocol = IPPROTO_UDP;
diff --git a/net/netfilter/nf_conntrack_proto_udp.c b/net/netfilter/nf_conntrack_proto_udp.c
index 8a5675983e7c..0854f9e498e7 100644
--- a/net/netfilter/nf_conntrack_proto_udp.c
+++ b/net/netfilter/nf_conntrack_proto_udp.c
@@ -45,9 +45,11 @@ static bool udp_validate_len(struct sk_buff *skb,
 			     const struct udphdr *hdr,
 			     unsigned int dataoff)
 {
-	unsigned int udplen = udp_get_len_short(hdr);
+	unsigned int udplen = ntohs(hdr->len);
 	unsigned int skblen = skb->len - dataoff;
 
+	if (!udplen && skblen >= GRO_LEGACY_MAX_SIZE)
+		return true;
 	if (udplen > skblen || udplen < sizeof(*hdr))
 		return false;
 	return true;
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index ce7a0ade450f..0475e680651d 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -211,7 +211,7 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
 		uh->source = udp_flow_src_port(net, skb, 0, 0, false);
 	}
 	uh->check = 0;
-	udp_set_len_short(uh, udp_len);
+	udp_set_len(uh, udp_len);
 
 	psph->nexthdr = IPPROTO_TCP;
 	psph->hdrlen = PSP_HDRLEN_NOOPT;
-- 
2.54.0


