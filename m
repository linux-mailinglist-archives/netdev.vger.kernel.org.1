Return-Path: <netdev+bounces-287240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCEtHSJcA2qE5QEAu9opvQ
	(envelope-from <netdev+bounces-287240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:58:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FB852545E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D33253013A75
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA8D3D5C10;
	Tue, 12 May 2026 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="U6ZRy8MF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvYqkRbt"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F93D5C21
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605080; cv=none; b=G9/A5YW1akTVlr9ZzHjfYOYvM5Zy8e5Iu/bqOkoqeuwmFXz28zw1NJhBht0kxkpYzjtmGpGJBzsJoFOaH3AVLD9uQ0uqvuWm4S5P1IoQG2rcN2oLIoM6WrZBk0h/ecTCJscRVMee4lAc8uTh5K+muLytSrD+oP/Kj29bZX2yAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605080; c=relaxed/simple;
	bh=NmyU+LzzDIVulR+Wa58VSzqOQTcNA5ulDK0vhrFu6CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVDwEs1umvy32AZagEKVg3GFrvt1EV3FcofuYZ0dIL5tlVqfgthF04mM0BuWK2dyA6NFwc1/GLXORIctwhcRT72yGaxx5HY4Vdfai+Jpi2XChv+oJ+6G/rX9X1CzYKE4XNy9x9QmE01y7r01CZzbaKlHgMZfskqlZqa+G0PQv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=U6ZRy8MF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvYqkRbt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 88997EC023F;
	Tue, 12 May 2026 12:57:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 12 May 2026 12:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778605077; x=
	1778691477; bh=C8+Mu4wSB6ALx3Xp69hOWTqTS8HOJYoIAdW81FNJXtk=; b=U
	6ZRy8MFieuOVD3dsrCUduPF5cJyXwzDn0czgGoz6V7Ed/OBXGv/tFs9bfBaJjUXl
	z3rxyqPppNRLDbfs65JdjEDcMH8u38dGWjJrsCAwGDwkYN/9fZWx2J5xTPHDBGtd
	eaC9JZn8ny+ZnOsyJkWKrTUWEke4pNcpfLxUeaAuks05pomeeUKjHH1NA7Xj/HNV
	fwaRgGodmlB0CNZqzNEtfs8s0l3M74fYFRGbmlqUQT3dX3CAzfUswqNqt1swQlAD
	OjR/VlOqV9VLIYLKRoBCXGH57GsuitOQm1aRHVtZzg0og0ufW4emLBp6pSxak417
	d48G5zbMtYGbQJTwMda+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778605077; x=1778691477; bh=C
	8+Mu4wSB6ALx3Xp69hOWTqTS8HOJYoIAdW81FNJXtk=; b=cvYqkRbtFWANQu/CZ
	6ECl0l2F1zTDzPUm6kdvsUovrYJVagsUrfJMCcHqQkeRnGMwkBwHW8eROp1BFTus
	FYDTrN6YjLYX7zN/5zsA/YIkAadKPGHCK2k1zx6V45ngM0Ji/L/MVIHlAfPC+71i
	91qCyWL+0eYuuliDB+WkdJtV3AZQBd0105e2JR6mJ5lW1N4ORXlqnYPRyHBO476M
	nwApLlu6+Ajg6Gx88dre9e/r4LF3jGbsondT4jUO4ZE6N3BmIzD71HRnArr8K9WJ
	+FVivbpzWxnXy+rXV3WKD6CvoTZSK11mIKIR63VJhs5xbF4x1cex2IF+BnI45bxl
	I5Ycw==
X-ME-Sender: <xms:FVwDam1Tx_yXJ_UOYA2_vcnZ3mRvS-HSwS0h-EzHDfGM4YVrLJkElw>
    <xme:FVwDalY90NF3Uf0-r9cWUFOfkPngiWvEIIr7Vnv0R5KhSaVVHZViUf9MfdBKSdqGc
    BUWaFaG-q_9Rk4Xhx0KNHGQ7xYUJ2TTTIjC7NrJHuABXGFkt3ZRgLE>
X-ME-Received: <xmr:FVwDaggEA0a6JthYK1mVD5HMJNCiA91RDxQ-srIyhL78D51o5zbGewx2wnJrlyeZ_Roctcl-8C6gEB50RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FVwDak-mjHUlFOE5jXqlLmusH2ALkK_U6t6niwFVKkkUjiXevg0LMw>
    <xmx:FVwDauNlAwB8UMDzGtBC44UQxcBNQzU6tZTF7jnJndJ0hB1HcUnyDA>
    <xmx:FVwDanos5vgA-v12J0kzItHLxLTUgGs1lgKzgJ--CebCjdLUNB1_Dw>
    <xmx:FVwDar4-Lp9C0L9HHs9u0svYLTjlgc9SmhHZegIEEN0DFEOCMGFEGQ>
    <xmx:FVwDaiLe2z6fXgP0umIGiWCR2cLH7KTr0y8AJEMn61gE_VgqctcUTizF>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:57:56 -0400 (EDT)
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
	Alice Mikityanska <alice@isovalent.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next v4 01/12] net/sched: act_csum: don't mangle UDP tunnel GSO packets
Date: Tue, 12 May 2026 18:56:37 +0200
Message-ID: <20260512165648.386518-2-alice.kernel@fastmail.im>
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
X-Rspamd-Queue-Id: 18FB852545E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com,redhat.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-287240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	NEURAL_HAM(-0.00)[-0.972];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Similar to commit add641e7dee3 ("sched: act_csum: don't mangle TCP and
UDP GSO packets"), UDP tunnel GSO packets going through act_csum
shouldn't have their checksum calculated at this point, because it will
be done after segmentation. Setting the checksum in act_csum modifies
skb->ip_summed and prevents inner IP csum offload from kicking in,
resulting in a packet with a bad checksum.

Add UDP tunnel GSO packets to the exceptions, and also add UDP GSO
(SKB_GSO_UDP_L4), as the same logic as in the commit mentioned above
applies to UDP GSO too.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/sched/act_csum.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index a9e4635d899e..078d3a27130b 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -259,7 +259,9 @@ static int tcf_csum_ipv4_udp(struct sk_buff *skb, unsigned int ihl,
 	const struct iphdr *iph;
 	u16 ul;
 
-	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type &
+	    (SKB_GSO_UDP | SKB_GSO_UDP_L4 |
+	     SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM))
 		return 1;
 
 	/*
@@ -315,7 +317,9 @@ static int tcf_csum_ipv6_udp(struct sk_buff *skb, unsigned int ihl,
 	const struct ipv6hdr *ip6h;
 	u16 ul;
 
-	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type &
+	    (SKB_GSO_UDP | SKB_GSO_UDP_L4 |
+	     SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM))
 		return 1;
 
 	/*
-- 
2.54.0


