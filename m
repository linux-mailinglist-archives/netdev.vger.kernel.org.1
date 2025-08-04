Return-Path: <netdev+bounces-211520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD480B19EC0
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125BE3AD008
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA40246BD8;
	Mon,  4 Aug 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Vb0yADmW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSeObrkl"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC53246BBB
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299607; cv=none; b=DMllvEl1purikdKjFmE3bEdHLid+PTJd1ro4JEu1Sktc9sKPhG4K4PtPzfdFz5Ee3EpDgdScznZEYZJzWmcgtBMhJ9ae3YlyDrVZyjjK3/0ngzV5eeI7EU2chY7P4ymM+N7Y9lesnkkomIfha13hxn21k86pddVFtnsYl7EfQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299607; c=relaxed/simple;
	bh=db5PlqPkTNUoyYEYuVqNrMySmP4fWQ+nA9FqFBy/sNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYdoRNzmkXzBa0dnUsV7P1GiQSqQIhhJpkZ3hYEYH8pcP5eRmkAejag/stT1hlLw9QryKNNgrai+CvJt+7W8sp/CIO/O0HLX58KGWyUxhSwpcO+gwFcj4oqDJO1rj5H1uv5Q4Y+U1XgdTJYlWlQ4c+A33/tF35N9iJaQo5nKKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Vb0yADmW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSeObrkl; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D3F21D000DD;
	Mon,  4 Aug 2025 05:26:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 04 Aug 2025 05:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754299604; x=
	1754386004; bh=RXurMLp793g6gxB35FS0Vs/kZ+MojVMfMZMgGJhqfMY=; b=V
	b0yADmWliKwN/zVoXWc4Iod/8VDMRyH1oFn/9hs0kHuELsLSWzizeYx89opnTTmh
	FG392HxMrXw6gavpkI7ov4a35emCV9xxIU4hlmZU6uZWM2y/8e6oJ6PM4ct3W/dV
	wOl5RpYwkl94iEcEy6fEddoD0kbXhHnl6gftYuTvCcHd1lQIpmaf5DBryykweH4S
	Lo738XHtgEifgO5gXWK04/tzkDoPphkVH5CLlg7TlwbH+mT/EkalwO0w6XMjYhi6
	d+aNbnveELUfej8buNnnBdp1oHs+W4Qu7C66t5qcsbLIL5QiidBBpY4htWrrDETF
	/c50IZgcZ2sCUYw3RYFvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754299604; x=1754386004; bh=R
	XurMLp793g6gxB35FS0Vs/kZ+MojVMfMZMgGJhqfMY=; b=bSeObrklhN9KzawVG
	ZrJNupEiYhG4JBb8y1f49uHhdCshe72kmbTKBt7wlE9Ixqfr7A8vdsTu9wMrMvUN
	UIo5AedV8ZZNm/1+qPxKEi/Poip7sLPxLdcCXvY2J4fLQ7fiLIYDMChSujUdap1s
	Y4Fd8ZJ7BpVFcJA3DWY6XSqj54ZkIsgJbHkZ8sRllQvAuNrgsNCAaY8oC6/Jie8T
	CV9zEjTzVgZnAROjQCvi/bR8N4Z/Ur7ViilDLM7mkqQVZ1zZStv9nBVrT8AafNTp
	nFB8U4J0/8JIWS9Loge5zpTbUiCdSruyeaYumo4i0gEULt5MG+A+7qTAvBtr6skj
	lLixg==
X-ME-Sender: <xms:1HyQaOLlD4H9b78Nz6ex65fhyDkHYEVzavDGFk3o05w_maplEvEbMA>
    <xme:1HyQaJPuGlVA70bGW1HfxX7ASS7aHSKP7gK7HK5bca6tqdn3or1jzwfGP30lvFwZy
    ZqNKd3--V3lSkF1LXQ>
X-ME-Received: <xmr:1HyQaJV-cTT6bGecmCX-7EdRcfEyGK4TVE2OZlV3p8oQtaMilluOcYzJ9yfL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepveetuedvgeduheeiteelhfetveefveelgeejvddttdejteeitdejgeeh
    ieeufefhnecuffhomhgrihhnpehknhhofidrnhgvthenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgv
    thdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhu
    vggrshihshhnrghilhdrnhgvthdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrrg
    htthgvkhgrsehovhhnrdhorhhg
X-ME-Proxy: <xmx:1HyQaPk6awxCWIHtPWgjZ7i-Sg9n4_aKFKtOwYMwXqZYOwZWh8TbHw>
    <xmx:1HyQaAM78H_TWzbQQZHkFm9YB665GlhMrJRUXM4RJutPI0QR78UEkw>
    <xmx:1HyQaPLigxF5KC5qj5wvOhOW2rAeL6K8jBLOdppwaeGIYA82fIzi8g>
    <xmx:1HyQaC3Pn4-mecjpDBp_xwvp0LijsUn5A_oWI6MwksTWxK9ibS9mAg>
    <xmx:1HyQaOQ1u2giUKu5gemhNJD4y0uZTeet2ZYOckOJRJ13bJGdPdpfW6qH>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:26:43 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Ansis Atteka <aatteka@ovn.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec v2 3/3] udp: also consider secpath when evaluating ipsec use for checksumming
Date: Mon,  4 Aug 2025 11:26:27 +0200
Message-ID: <fe6740ba307ad0e7b988b874cf713d553924ce0e.1754297051.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1754297051.git.sd@queasysnail.net>
References: <cover.1754297051.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b40c5f4fde22 ("udp: disable inner UDP checksum offloads in
IPsec case") tried to fix checksumming in UFO when the packets are
going through IPsec, so that we can't rely on offloads because the UDP
header and payload will be encrypted.

But when doing a TCP test over VXLAN going through IPsec transport
mode with GSO enabled (esp4_offload module loaded), I'm seeing broken
UDP checksums on the encap after successful decryption.

The skbs get to udp4_ufo_fragment/__skb_udp_tunnel_segment via
__dev_queue_xmit -> validate_xmit_skb -> skb_gso_segment and at this
point we've already dropped the dst (unless the device sets
IFF_XMIT_DST_RELEASE, which is not common), so need_ipsec is false and
we proceed with checksum offload.

Make need_ipsec also check the secpath, which is not dropped on this
callpath.

Fixes: b40c5f4fde22 ("udp: disable inner UDP checksum offloads in IPsec case")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v2: unchanged

Since the issue is related to IPsec and currently not visible as
GSO is currently broken for SW crypto, I'm including this patch in the
same series for the ipsec tree. I can split it out if that's prefered,
just let me know.

 net/ipv4/udp_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 85b5aa82d7d7..8758701c67d0 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -224,7 +224,7 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	remcsum = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TUNNEL_REMCSUM);
 	skb->remcsum_offload = remcsum;
 
-	need_ipsec = skb_dst(skb) && dst_xfrm(skb_dst(skb));
+	need_ipsec = (skb_dst(skb) && dst_xfrm(skb_dst(skb))) || skb_sec_path(skb);
 	/* Try to offload checksum if possible */
 	offload_csum = !!(need_csum &&
 			  !need_ipsec &&
-- 
2.50.0


