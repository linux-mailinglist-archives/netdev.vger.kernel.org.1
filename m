Return-Path: <netdev+bounces-211519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A3B19EBD
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1549189AA4B
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D17724469A;
	Mon,  4 Aug 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="uA6laYNZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDoEBbw/"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFDE246BB6
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299605; cv=none; b=onDy4iP36xjUIzWvL0rT3Uzte//lC5U5SfTgDck8VxVtiRJahXOKoAE6nG6JVzWgJ1ffV/54PP1uR3w269qz65wSROIi4HOWb+tfFRSe8FSgh1UinseOTRF6lficxpddbGXA3AhJ+StGj7jfWHS4BgU3t4cK2D5wrRsH9HMS6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299605; c=relaxed/simple;
	bh=vJiIH6oenImrwrjrKl8gajBlshMPRthhQFH/x1ym83I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tU8iqfShiskeJNAvnOiCJsAMK9BcMBQ46/iv8SyFQh8GYkJJAwH4ocaVcVPtXs9Ll64XsDhS0UkKl+866wbsyn9C/Bpp5OQZKBo8rfna0SW98EK84OLxYjdUB1ToysJX1xSJPkQfxcitdpRErprGsB1R8GmjVXsdni10Fj2R+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=uA6laYNZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDoEBbw/; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB1E97A00EC;
	Mon,  4 Aug 2025 05:26:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 04 Aug 2025 05:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754299601; x=
	1754386001; bh=BkOsXWg34qIrjfxsQxhlFQgZFNiTS3MV8IKcykS7Oeo=; b=u
	A6laYNZZG7TUadJHkDXg8yGV31r6BweAI89urC6bvwj3jLz6tJc2PPlTt4rMGXGk
	PXwo5Je+ZxqMjgsNpKwwNwzqAGy43XlUXCEUljuSrAhvngf5XgGEBpFPAOspxdlL
	RS7cdLb6aXdznZTBkSSFTbUqQ8kzoW90+1Kub95OwJi/Ohb8z9mYnjpmeVec8tKN
	berhWWW/tKz8feM8g4KAr0D5fc5VuzvPIHtx2lewOmlNUD5uPfxoHThrWkU0bI8L
	xXjI3Tn194NH0WPJ0JSbTKatTOmNIpmjz7NB+WCN24VX0DVwOo4g7rBMkyGC4LLO
	W9pZZ/qdrlxUv2b1Gm6TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754299601; x=1754386001; bh=B
	kOsXWg34qIrjfxsQxhlFQgZFNiTS3MV8IKcykS7Oeo=; b=KDoEBbw/xBHFKUYD/
	0cLQPEtJl9G+FMWKVrbqgBQpWQFGZ1enNS0rv8A8dwsdHCeok4qjxQp/1oFHozTW
	nTeIKnIyAHbsSviKwJ4Xlfaa1onxXb0T3U0MMt+FH08+fe05kS1Xv/SZZR/T9K7t
	BYHUV+JiQORSV9DeBiUSk18xRoIIuOlh2LSaCTINOUeHIB1vcy2D5zT6XfnwHqgV
	9SuWO+vuvbpmlCRfxr7k/fnto/Dyft1ofQ5xQtRse8pRaNmJqav560OaPOjrHbcI
	ma104nq9IFx/vq4KZq0Wa3smcxJ+Gb+HipGkXwtY94NMpUqHdJenyLldIaxvfmFe
	mSQfA==
X-ME-Sender: <xms:0XyQaBfQ8yBG3NySevOlFMw6XAku2oZmf2m7wbA9Vh15ICe2xy2hIA>
    <xme:0XyQaHqeuyS2FnUSe7Qdwm_M6h0_oTGe5xiYvGTME7OutdisV1iE_0bLtBPNGkYpI
    bitpI7uDaQbLLf-VHw>
X-ME-Received: <xmr:0XyQaK-Fqfwn8LyWnN04X8RsmP3Qn3tvT0qXGZPObbUYonBNe6RAHha5lU1p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphht
    thhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhnrhhose
    hnvhhiughirgdrtghomhdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdho
    rhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrd
    gtohhm
X-ME-Proxy: <xmx:0XyQaLf0EkiAUBTZ_cYBUVbRdf0dtLeWWIdjzIcUs7akr6UJNU_OKw>
    <xmx:0XyQaMK60pFyuM6nZot2TjOKJ078s1UPW_ZPHfWKC5IS2oQ8RHzICg>
    <xmx:0XyQaDhHZN_o-hfK1Y434p4H1z0J9kw-vAVC3ngfwTI64_z9DL-Yew>
    <xmx:0XyQaCSnHGyjCnYKyTu5AhWfGcavb_fpI3T9dZUDrcmU-rq99Ap25w>
    <xmx:0XyQaJy4ksBJm25iKIc2cDk1chNScJuWCdFroaK6VGGQlg9JdRTq_UWT>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:26:41 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec v2 2/3] xfrm: bring back device check in validate_xmit_xfrm
Date: Mon,  4 Aug 2025 11:26:26 +0200
Message-ID: <692725ef1363566cb2fe8d0c928971271f5dd503.1754297051.git.sd@queasysnail.net>
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

This is partial revert of commit d53dda291bbd993a29b84d358d282076e3d01506.

This change causes traffic using GSO with SW crypto running through a
NIC capable of HW offload to no longer get segmented during
validate_xmit_xfrm, and is unrelated to the bonding use case mentioned
in the commit.

Fixes: d53dda291bbd ("xfrm: Remove unneeded device check from validate_xmit_xfrm")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v2: only revert the unwanted changes

 net/xfrm/xfrm_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 1f88472aaac0..c7a1f080d2de 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -155,7 +155,8 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		return skb;
 	}
 
-	if (skb_is_gso(skb) && unlikely(xmit_xfrm_check_overflow(skb))) {
+	if (skb_is_gso(skb) && (unlikely(x->xso.dev != dev) ||
+				unlikely(xmit_xfrm_check_overflow(skb)))) {
 		struct sk_buff *segs;
 
 		/* Packet got rerouted, fixup features and segment it. */
-- 
2.50.0


