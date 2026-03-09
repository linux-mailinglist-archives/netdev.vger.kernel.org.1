Return-Path: <netdev+bounces-265465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIEaDiqirmk9HAIAu9opvQ
	(envelope-from <netdev+bounces-265465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:34:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 860A92372B8
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9E5B303BA4F
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9753803C9;
	Mon,  9 Mar 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="rdIkDoMm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwV739L3"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07C3921FE
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052384; cv=none; b=nUvZbajqbtJt0u4pCVDyJosZ01rjRKwbQfGlzAhAsbMVmdZ694kZlBbfR6AGTEuqalrtWV1y7A5D8IiNIWsitywsnsfTUP+3VUp1y8XX3gzGp5v1gNfzi9+FEzlVVoYvZi86oyuZ0sA+QSNGyV81OAI0FjDANpJ7I6eRbvBKlRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052384; c=relaxed/simple;
	bh=Er3VcDkdrLNn8hy/IS7OWDnvZdyEqrzNxGviApR14Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWyu9Ban2oANZ1RCXrJoBSpoVkDk0gZeYxUDqGHLxK9Cxoh2ZyryGJ5d7u5SPE3npat0fYp3DTgUeUw1nsI1ZVabV6vRPLcrmZONB4LD7dX/H8XkEwE8QxYv2QWfhUQ88nhfPld/HrsHUI65llFauhQAHneDld0to1nJqGPgsaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=rdIkDoMm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fwV739L3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 98F281D0013C;
	Mon,  9 Mar 2026 06:33:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 09 Mar 2026 06:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773052381; x=
	1773138781; bh=G9t4V9YVDcZaPTUi4q8kssZgmDkAhCrMmt7DXiW+JnI=; b=r
	dIkDoMmU66MlHw+LUpsxdRpn0mvxTt3B2pYurn+5FZwjHEwdhEAworezY+8Sv3x6
	bBaBFGpDzw7x26jXXvUVRkAetvE4KVdCDU9sZ2kUoLk/1q8FgBfdnW5kagS91HhD
	v71Y4/Y6usRyMVvrqQOWgzjb08FgSa3/s9nXKrcvGrKXvrAS/dkBy3yy+x49+2U5
	MiDmUmTBRyREWlnaugGi/s3YbCO8We6lEGZUg7amTISLLRWDHIwMrqRjfjEC4rSq
	ejMo3twZnwuPRBCohPKOnf0DucAqYROeO7CshSYrMbfIzdEjaIZmiGaQlev95/UR
	vSUTHFJ70BqnYqACUWdUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773052381; x=1773138781; bh=G
	9t4V9YVDcZaPTUi4q8kssZgmDkAhCrMmt7DXiW+JnI=; b=fwV739L3hqd7aWzEg
	yMYuwUDectbX7Gb6VfXcg0ECvXZB/L+B4bLrVrbv7IVAckzfqIrWaGG5KVaO8K+N
	GJj04ShXrW4FxbwagoarzJp5nxtF445PJfprhn+FHxx7Am7vresHsn9Kva7/COp/
	rkKXdybTsDy767CLUCPpK53Cp9Vx8QJgdPC5ZYjPI/oOXGy+LmsOZ/tnWH6jnsBY
	zeXpcuAhA1NJTwanWvZCmf66vzBTZeok182w7vkDG4GhhtbsOU3jAYN8N4zaoDqt
	2sD89KiyvCJKamuJXxJVCU/F6AsWRU5kAOYC+xr4rURNXzyRMRB3lIWFh7OY00aV
	ehafA==
X-ME-Sender: <xms:3aGuaSZZyUEJTj_M3Z5Tap4k9U8MSnLFrf6Wyukl6M9YjpMTpbeazA>
    <xme:3aGuaQ1ncVqblH601oHUInSqb-sawxop_92Bs2CFSgGD8hfow53G7nuJriPkDZD9f
    ykdPGCOQCYMIkVwmPk75znyv94gHNiR42WaS0SWJZwPS1j8Qza7wQ>
X-ME-Received: <xmr:3aGuaQeixTJ6qaVdFVecOEkXgrwCUBJ9gQNaoFmU1j80Pxwr-ubfbnMk7O23>
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
X-ME-Proxy: <xmx:3aGuaZEtWbk7234ne56kf7Kr2qRIR11aJQTaroqpylu8rXqGHKfFng>
    <xmx:3aGuaZ0_p2ytCpoI5K44Uc30oBNcbg3UkE_haZcvLqU_-jQu9BPIgw>
    <xmx:3aGuaRlOutY3GRDdWoYpCV88be3qz6GA2XmczVKEA9aGPtaftT-T-Q>
    <xmx:3aGuaZ9zn7HNTYCUhjUTljf5Ow4eQrIdlOazE9XJv6fKlxgKTD4_CA>
    <xmx:3aGuaVsqMSofxJrT6ZpU6hY1XQAlufuCnHhD-Ho9tyqvYekW4-_dit7n>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:33:00 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 03/10] xfrm: state: fix sparse warnings around XFRM_STATE_INSERT
Date: Mon,  9 Mar 2026 11:32:36 +0100
Message-ID: <f1ab586cf6c4f3c0b52972748266a234428b1d87.1773051558.git.sd@queasysnail.net>
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
X-Rspamd-Queue-Id: 860A92372B8
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
	TAGGED_FROM(0.00)[bounces-265465-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

We're under xfrm_state_lock in all those cases, use
xfrm_state_deref_prot(state_by*) to avoid sparse warnings:

net/xfrm/xfrm_state.c:2597:25: warning: cast removes address space '__rcu' of expression
net/xfrm/xfrm_state.c:2597:25: warning: incorrect type in argument 2 (different address spaces)
net/xfrm/xfrm_state.c:2597:25:    expected struct hlist_head *h
net/xfrm/xfrm_state.c:2597:25:    got struct hlist_head [noderef] __rcu *

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e9bf160a30f8..3ad25b85cd92 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1563,23 +1563,23 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			list_add(&x->km.all, &net->xfrm.state_all);
 			h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
 			XFRM_STATE_INSERT(bydst, &x->bydst,
-					  net->xfrm.state_bydst + h,
+					  xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h,
 					  x->xso.type);
 			h = xfrm_src_hash(net, daddr, saddr, encap_family);
 			XFRM_STATE_INSERT(bysrc, &x->bysrc,
-					  net->xfrm.state_bysrc + h,
+					  xfrm_state_deref_prot(net->xfrm.state_bysrc, net) + h,
 					  x->xso.type);
 			INIT_HLIST_NODE(&x->state_cache);
 			if (x->id.spi) {
 				h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
 				XFRM_STATE_INSERT(byspi, &x->byspi,
-						  net->xfrm.state_byspi + h,
+						  xfrm_state_deref_prot(net->xfrm.state_byspi, net) + h,
 						  x->xso.type);
 			}
 			if (x->km.seq) {
 				h = xfrm_seq_hash(net, x->km.seq);
 				XFRM_STATE_INSERT(byseq, &x->byseq,
-						  net->xfrm.state_byseq + h,
+						  xfrm_state_deref_prot(net->xfrm.state_byseq, net) + h,
 						  x->xso.type);
 			}
 			x->lft.hard_add_expires_seconds = net->xfrm.sysctl_acq_expires;
@@ -1730,25 +1730,29 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 
 	h = xfrm_dst_hash(net, &x->id.daddr, &x->props.saddr,
 			  x->props.reqid, x->props.family);
-	XFRM_STATE_INSERT(bydst, &x->bydst, net->xfrm.state_bydst + h,
+	XFRM_STATE_INSERT(bydst, &x->bydst,
+			  xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h,
 			  x->xso.type);
 
 	h = xfrm_src_hash(net, &x->id.daddr, &x->props.saddr, x->props.family);
-	XFRM_STATE_INSERT(bysrc, &x->bysrc, net->xfrm.state_bysrc + h,
+	XFRM_STATE_INSERT(bysrc, &x->bysrc,
+			  xfrm_state_deref_prot(net->xfrm.state_bysrc, net) + h,
 			  x->xso.type);
 
 	if (x->id.spi) {
 		h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto,
 				  x->props.family);
 
-		XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h,
+		XFRM_STATE_INSERT(byspi, &x->byspi,
+				  xfrm_state_deref_prot(net->xfrm.state_byspi, net) + h,
 				  x->xso.type);
 	}
 
 	if (x->km.seq) {
 		h = xfrm_seq_hash(net, x->km.seq);
 
-		XFRM_STATE_INSERT(byseq, &x->byseq, net->xfrm.state_byseq + h,
+		XFRM_STATE_INSERT(byseq, &x->byseq,
+				  xfrm_state_deref_prot(net->xfrm.state_byseq, net) + h,
 				  x->xso.type);
 	}
 
@@ -1868,10 +1872,12 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 			      ktime_set(net->xfrm.sysctl_acq_expires, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		list_add(&x->km.all, &net->xfrm.state_all);
-		XFRM_STATE_INSERT(bydst, &x->bydst, net->xfrm.state_bydst + h,
+		XFRM_STATE_INSERT(bydst, &x->bydst,
+				  xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h,
 				  x->xso.type);
 		h = xfrm_src_hash(net, daddr, saddr, family);
-		XFRM_STATE_INSERT(bysrc, &x->bysrc, net->xfrm.state_bysrc + h,
+		XFRM_STATE_INSERT(bysrc, &x->bysrc,
+				  xfrm_state_deref_prot(net->xfrm.state_bysrc, net) + h,
 				  x->xso.type);
 
 		net->xfrm.state_num++;
@@ -2602,7 +2608,9 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 		if (!x0) {
 			x->id.spi = newspi;
 			h = xfrm_spi_hash(net, &x->id.daddr, newspi, x->id.proto, x->props.family);
-			XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h, x->xso.type);
+			XFRM_STATE_INSERT(byspi, &x->byspi,
+					  xfrm_state_deref_prot(net->xfrm.state_byspi, net) + h,
+					  x->xso.type);
 			spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 			err = 0;
 			goto unlock;
-- 
2.51.2


