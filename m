Return-Path: <netdev+bounces-265463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GUZLP6hrmk9HAIAu9opvQ
	(envelope-from <netdev+bounces-265463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:33:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 341A723729A
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D57D63033393
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F0B3921E5;
	Mon,  9 Mar 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="lZxAT+f6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zQACgtbv"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6E83921C4
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052381; cv=none; b=BXsoR5VdWBsY2DsXfBAXo3pnG6zYKEwKAYXqCAEXwxS9v+vOYEEeH4fymvT0KaSNo+V3IH6VdufCVHwFzeiAi4RvuRHgZfPJX9P959RlX6KeMIE9Fy6UH4rTH39HUKXCCcqjPb7itcEt+YTzporPQ8DnalFtoK4ZLlRavfxdDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052381; c=relaxed/simple;
	bh=jefWBt4NYKhq3u3tnav0lkMPv9RrhRskSg4/phaG9hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkppZvMQB2ypB7soeETJg0zhi4dYMigigXcSyjpqAdK5LIGuuLRs67UJ1yqTvhmAG0nBYpYdipBg/2cV8dIhGQHFjm5exCvlqGKGSE9jmrXBz1A4FY48W1KqSsEojhQNpizKHHD1D5IbQxkVnuHgr8LBGGUuadHv1mH4YRZtV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lZxAT+f6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zQACgtbv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 070507A0033;
	Mon,  9 Mar 2026 06:32:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Mar 2026 06:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773052376; x=
	1773138776; bh=HdKEmYbbCvTn9xF0RzIm4l92ZjSTGhnZDw23SoHhmQY=; b=l
	ZxAT+f6kQ1syyGHtuAJPCpgm4cvpkl8L2V56yhiqLKMY35OaOqVAoAlQDnN8Kpkm
	0bC79KpqJ+T3o6lnVWXMjk6P7qd/CB6Q10c6/jBuigJEGky1vgEE44zOwdHyIUH1
	TJ33Gv/0TB+4/vISKAZ9ilOz789oIUGgFR+who8WGtlHGuLhetXYfMV5zWWvDoMx
	duw3y6d3F+ei4lrM+l7ozOIroBWM5qQLM00pRj7xdRjA7/ymVgEucGqzGfdK7Nxw
	Mk0Xa8M1Gen3E3L5QgEydHUAAnzoOqS4fX4CXvHL4xA4/RFfDEqJfTGy7mRLCa8Y
	yY5nGpEW4gQNmiHzvqzXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773052376; x=1773138776; bh=H
	dKEmYbbCvTn9xF0RzIm4l92ZjSTGhnZDw23SoHhmQY=; b=zQACgtbvS1awyt0fb
	AMRh9m26y29qci8iu/IRCj6JNp6zgoa6B/XMOhVWDZqv9NvMYmpm7Xxyla3L0CjZ
	cONSRtdrrDJq+zQMAZNu4vML24FSnuJ6+qPwSDHpOT7eYDDkTyni5JwEYixwI5WR
	PobEqFT9dCpEvvZBjoN2absF9vunmfdwIcLo7Joitt4/3xX7UlfAs25lgWLWElEC
	BcE90JUfFd0iZh90wcDrWdNc7/yMg87YI5ODDHvwvg4JnN4qgOSG+IbHgoJW5M0k
	f7xYt6/k9n3KSg/M38Bao0M9A9H025rM++KTY7wWYohWnsGFUNQIgpHPkgxFvgi6
	JhOyA==
X-ME-Sender: <xms:2KGuaWUAyxUJaWjzwVsPUXpzekBBqCXaN1D0j8OQdvit09c36WKIOg>
    <xme:2KGuaeA2fOsfRTFgSPuCiWoknK8bmeYHJQmvh678yvYmwa7GqsM2t4yQOczzcBba0
    TAGofDs3d27lli2eTkK9VoNBAxLTsdS1D78sauUbS0Q5fVRwib_w-g>
X-ME-Received: <xmr:2KGuad6wmzv3HPiFAuKWLT799RkNhS_XUjOSHU84nQiz0bF1DBBqGA2CsVOn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeejkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdroh
    hrghdrrghupdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:2KGuaRypBu661XvxiWGNfep5AA92BFhTTJwUnu7QzekXQvJXF_JSZg>
    <xmx:2KGuacy7pyV_LNGUS6-hxoXjFHZOS4zDJ9xPKmsGuska670NLYAxOA>
    <xmx:2KGuaRxo1UhN6_t6QA6uFo8oo1Es70kNoC-OokS0RhNuuKZHRa2zYQ>
    <xmx:2KGuaeY4TDWV85oKSOC8nLecE0kBUB12CLS7ZoryF0ojCFCEriGSFA>
    <xmx:2KGuaVJAFUU7FuEEfXMdXRATIczfP-OeXuRS6sXkLdMmJNWF5eKmdh09>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:32:56 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on xfrm_state_hold_rcu
Date: Mon,  9 Mar 2026 11:32:34 +0100
Message-ID: <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1773051558.git.sd@queasysnail.net>
References: <cover.1773051558.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 341A723729A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265463-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

In all callers, x is not an __rcu pointer. We can drop the annotation to
avoid sparse warnings:

net/xfrm/xfrm_state.c:58:39: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_state.c:58:39:    expected struct refcount_struct [usertype] *r
net/xfrm/xfrm_state.c:58:39:    got struct refcount_struct [noderef] __rcu *
net/xfrm/xfrm_state.c:1166:42: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_state.c:1166:42:    expected struct xfrm_state [noderef] __rcu *x
net/xfrm/xfrm_state.c:1166:42:    got struct xfrm_state *[assigned] x
(repeated for each caller)

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 98b362d51836..7a68c594ce37 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -53,7 +53,7 @@ static DECLARE_WORK(xfrm_state_gc_work, xfrm_state_gc_task);
 static HLIST_HEAD(xfrm_state_gc_list);
 static HLIST_HEAD(xfrm_state_dev_gc_list);
 
-static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
+static inline bool xfrm_state_hold_rcu(struct xfrm_state *x)
 {
 	return refcount_inc_not_zero(&x->refcnt);
 }
-- 
2.51.2


