Return-Path: <netdev+bounces-260252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDASLmTdnGl/LwQAu9opvQ
	(envelope-from <netdev+bounces-260252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:06:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7135B17ECC2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D93C306A326
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5FE37D12E;
	Mon, 23 Feb 2026 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="h5aT7BJ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gyZiY6Dy"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB5E37D11D
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887928; cv=none; b=iStrKLiXpOQIDz1y0EU7XdrQhXOT5pWCsPYcefXovDPscYGNg0t2qZpePIxiMlb5ozvN3Hz7KfdQISyKliK6QZyf8ysHoeZNsJTUjRUSOwOrsyOnmXIsomypK0WJB/4QyEozE/ram3U30/XkRCw65wJwWo7xJMEMmshV9xxuh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887928; c=relaxed/simple;
	bh=QKn9zYGU2s+JE5mgIoxkIMlPwFbRfY7LvNtW9eB7MnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upKSkDBLlANCecGlNLhY4s+PQ0sa05ZOdcuP3R+98Yoy0cmQ50z+grrMNKOqzbds4vD8B3Z8iED5klZZQ9cQTcOPvqQiWbPRRuurSDAFKbF9lKFVCel3l/0Wh+HjLbnQcazQvjGw3bOhrvyBnTjxGAKA7OJOvVkmKJmVv6oSL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=h5aT7BJ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gyZiY6Dy; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6960A1D001A1;
	Mon, 23 Feb 2026 18:05:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 23 Feb 2026 18:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1771887925; x=
	1771974325; bh=it3Q7TTB2vbHOHxY71iyRf+joOS9QIZpoUhZXsZA57Q=; b=h
	5aT7BJ4Wy6Oj+9C26M/XG5fZu1HNr16OfXeG/An+CtNyrK2bJ6d2eMeE2uF12CG6
	fL4valiPW2IrnlfyzI6cCmJzxCKUcRhL+7FOgb1jrfOmIz0R65s996PI+i9ON+dd
	ovtcgSmNlVy5/Xise1deeKPB1HKldEJF34VIHWOVrHHgN8sRUkVcH2YWMbGBf5we
	rpffu48THb9f5QZtvEqppteJascywHbZzTt0V+crCY8T66l2F0GGqJ6rP9ai72mn
	+xq9UnXRuNcLNJ3Qw/X9IGcZy1dEJzUgfDoD2uzvooq9bUxkcUoFGo9EXdzUDHiB
	wN4cdLneOPAxidYjD8IlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771887925; x=1771974325; bh=i
	t3Q7TTB2vbHOHxY71iyRf+joOS9QIZpoUhZXsZA57Q=; b=gyZiY6Dy7K4rsBiQk
	G0Fmb5AF6f4yrHauDqq+yI8j/b+pf5NC0gpmA5SYA/W0r74Ijl7/33VZwLXvgWOJ
	SPVlpIEdFsexz5RWoTi90tYapR+tlCzAwb+k14b3G5m0FRTfdNqN3GLdW4JaSeq5
	CL2xUB5pjzD1rIMo9493uw5IiNcfoXkXULQpu4qBbec6WfEOnPbPztDHPSX3kWno
	A7SfLIeXV+39ToPBXKb0mmC2lHJ8vVzoywtl6wbjX5pqKnC/goquN75QSIdwOPl/
	rvtX6J2mJq57kVLYyqBgJ2tlYykmh5OyrK+4JaAbkUEfigYCVD0OCwJsNUGtz80x
	gB8NQ==
X-ME-Sender: <xms:Nd2cafXa0t_3C_4M1ifAsunoZSlWqdihJelBhnF2iT1ziUmzIWV-6g>
    <xme:Nd2caTCm8Vv27Cu7W62HXSBKsXAyFQJvZAGq075TSb_TMnMiDoqNln9pKiXShc2If
    Vvz3g6iabgyt5LBXMlguRetyxhZrWNhqu_ssiX3ROjhVdMVwJk9o8V8>
X-ME-Received: <xmr:Nd2cae71XZ3v3YkRJnTwCTACMngXjcrj9-dayXJs--3dQbkpPCEl2VAc3lXV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekheefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Nd2caexwiqJOzDuNK4eH1DlUIda3wcVe9f8CZ0-oc_CRImXeZBvN4Q>
    <xmx:Nd2caVyvCPvoWYffbwSHSt3TH8n7XXH0BNF5TCTLIHghgafxN7LFoA>
    <xmx:Nd2caWx8sKZU6XucAij0nm0mMlu1b1Y4q8Ngb8KDEeU0zlpSQVW6qg>
    <xmx:Nd2cafa-kxmZ8Ozz_M-x8N1vkxNa1-I6ADWUQXErUJdT9pm1fS7riA>
    <xmx:Nd2caWLDgyAlIZnyuzUs4pE-yzCudD0L3IqzXBJv9-bch05yCdhP-KbI>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 18:05:24 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec 1/4] xfrm: add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi
Date: Tue, 24 Feb 2026 00:05:11 +0100
Message-ID: <3a4747b8d94bee94392fa2d38275d4b0cdb1533e.1771876412.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1771876412.git.sd@queasysnail.net>
References: <cover.1771876412.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260252-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:mid,queasysnail.net:dkim,queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 7135B17ECC2
X-Rspamd-Action: no action

We're returning an error caused by invalid user input without setting
an extack. Add one.

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac2c5..3e6477c6082e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1850,6 +1850,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
 		if (pcpu_num >= num_possible_cpus()) {
 			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "pCPU number too big");
 			goto out_noput;
 		}
 	}
@@ -3001,8 +3002,10 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (attrs[XFRMA_SA_PCPU]) {
 		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
 		err = -EINVAL;
-		if (x->pcpu_num >= num_possible_cpus())
+		if (x->pcpu_num >= num_possible_cpus()) {
+			NL_SET_ERR_MSG(extack, "pCPU number too big");
 			goto free_state;
+		}
 	}
 
 	err = verify_newpolicy_info(&ua->policy, extack);
-- 
2.51.2


