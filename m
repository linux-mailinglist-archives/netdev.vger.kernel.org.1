Return-Path: <netdev+bounces-180773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAF3A826DE
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CEB168DEC
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B9264626;
	Wed,  9 Apr 2025 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ccPvPTfw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aURgHABY"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129925DB18
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207222; cv=none; b=mj/qzjU72XUJoOCDjSOVfD7/I2A6Zlk4fZ4o1SvKGWK79dF94T5J7OqOmhIyLjVi/0L1xYZAlwRyHFceiwrSRG7MF1kpQs7I7TbgeT+ZkQfz2abJMO/wpUFy2rOsn34EVLDmbJIUqwKTzS+WeXguevh0wUywu8gsi09vsNJIHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207222; c=relaxed/simple;
	bh=lCsYCcJqq8GoZT3GuyIpO0wH+Pxfk/uTQO/E+N2vH9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZU558FQBka2bG6vgRHJcJhOzTDHcekt49olk6GrMy0l/dUzhJD4O2qf4piqDBRDI3Wd2b54klH/km3wyaWrZsoybaJfl1qvNYad/JaMIk6qnFCXktK7PjMHeKZNWwF6/QQ3gW5BM5XsmtnNUque4as8u7Nj/Se4wQzyMQM4JUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ccPvPTfw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aURgHABY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 410BE254019C;
	Wed,  9 Apr 2025 10:00:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 09 Apr 2025 10:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744207217; x=
	1744293617; bh=J7Eq8gli40xl+GI/MO76tS28PbOCpf69OqzmuKMxSwU=; b=c
	cPvPTfw47Ejzqsnag+26o3LAtTaRKBg48mk1Nni3z1KmnIbjIuvfiFzv60d7G6SY
	VdieD86jhcHzqnTNplkcjC0+uI/Sjt3H3yA6WUldUyBsuW5HQVs3881hWMGdZbIC
	SmdKmPx2ypGhuMAlHTKOsUf8L4UugxSqR4eD2OmXW1j/gwI0nAimRxezS6g+WMd9
	arsjS3hY3WB2qG04v3/eAFHlkY3eDbTn/GAttecyPwgg9unqjbCBbezF6Oxul/e0
	VXn2PvMakEAEm3g/4erThtzE90Wu5WmWro+TXmAJZfE0Zbvlyi7ZfIydoKxZpBv2
	0fiSw6ldwbbLckpALPQqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744207217; x=1744293617; bh=J
	7Eq8gli40xl+GI/MO76tS28PbOCpf69OqzmuKMxSwU=; b=aURgHABYH4u4RCrYR
	mOCa5Xvh/LCUqIpG5zjpnIvIRdLXAIAe3vcjnIBLkssoddQdl+O5UstFT6Kyn1Tx
	vnt6BJsk+huMHz0wcS2JKfuQwPwimUWudI2HQPogweH8Azdf60vpTIBVAn0sWRTJ
	YY5pVLw7sAlHmYG9Y8iYKFQVvDEMDS+dO6InEebd/o9QOHgjLCJU012cpnsvUbF6
	bd754kwwR3Rl34tTxXlcU5fWBy1MQE9VddTQJJZjFu1L5ctEt4DvXzMAwQ9PmrLT
	MdcL8IzzsCguTRxmeb63IC2A3r5JkgGHACRq/lBRh8CCgdt2I/RQ8LqXksqaRzqU
	difpw==
X-ME-Sender: <xms:cH32Z24n6oJmjByIPNhjF4vjYE_AoH6JWG2lPQvo8uEl3eKkaMTb7Q>
    <xme:cH32Z_65fSImYkrzPSZJ-CBQJbj9p61II_SCqsmGp72TpqV9EdOWnvPMC9XxzzUyZ
    6DOWkAfCi1OYwTsI7Q>
X-ME-Received: <xmr:cH32Z1e9KlY9gL7iUDzCGnmpNcmLexSbLOn_JyYD6yl_Jroq79fbpvfEJinb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepieeiueeiteehtdefheekhffhgeev
    uefhteevueeljeeijeeiveehgfehudfghefgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshih
    shhnrghilhdrnhgvthdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehs
    vggtuhhnvghtrdgtohhm
X-ME-Proxy: <xmx:cH32ZzI0ZlmMW6Mt9RZb9UGtKI1rGRCWNvnOibIuTNiXnUAYzEObVw>
    <xmx:cH32Z6LpxJkKIT4y59AnudFvXlRE8Ws5GclqBz1-581vcLZh1fwLig>
    <xmx:cH32Z0yi_cABUkd8pJ_wdqz1MXuU85jXTUBg3OqidXvpHYHdY86nfw>
    <xmx:cH32Z-LzewSwOsCPDOjKSagWZA2FVkL7KekrSpo8nOrI3RNRQv2bqg>
    <xmx:cX32Z6vsir7FraVVNoFe4nv_Kxnj7H5nUgsUjiUwOY7YN-mIZNlelMi3>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 10:00:16 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec 1/2] espintcp: fix skb leaks
Date: Wed,  9 Apr 2025 15:59:56 +0200
Message-ID: <66e251a2e391e15a62c1026761e2076accf55db0.1744206087.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744206087.git.sd@queasysnail.net>
References: <cover.1744206087.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few error paths are missing a kfree_skb.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/ipv4/esp4.c     | 4 +++-
 net/ipv6/esp6.c     | 4 +++-
 net/xfrm/espintcp.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 0e4076866c0a..876df672c0bf 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -199,8 +199,10 @@ static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
 
 	sk = esp_find_tcp_sk(x);
 	err = PTR_ERR_OR_ZERO(sk);
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		goto out;
+	}
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk))
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9e73944e3b53..574989b82179 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -216,8 +216,10 @@ static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
 
 	sk = esp6_find_tcp_sk(x);
 	err = PTR_ERR_OR_ZERO(sk);
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		goto out;
+	}
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk))
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index fe82e2d07300..fc7a603b04f1 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -171,8 +171,10 @@ int espintcp_queue_out(struct sock *sk, struct sk_buff *skb)
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
 
 	if (skb_queue_len(&ctx->out_queue) >=
-	    READ_ONCE(net_hotdata.max_backlog))
+	    READ_ONCE(net_hotdata.max_backlog)) {
+		kfree_skb(skb);
 		return -ENOBUFS;
+	}
 
 	__skb_queue_tail(&ctx->out_queue, skb);
 
-- 
2.49.0


