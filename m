Return-Path: <netdev+bounces-211513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D9B19E4C
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A6D16FB11
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70A24469A;
	Mon,  4 Aug 2025 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="stE82VZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jgau77CO"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05B246799
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298362; cv=none; b=GXzWtLXdL+xqwPVQf5ihjk/tKD920QNi9alSpWe/G2C1Aj9SJBmrbwGHw9zl+PM8EBx9yEuwgsctNgzYg02l+TMyswGZqcNn3LoNufX8RcT7cWUz3MJA3gV6CJz5KJsfq+IVzFqYMX4DpaJeQ+WRWBfdmN31f/wHD+ioXLG1WR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298362; c=relaxed/simple;
	bh=UEWNFZuFB3T68g8Jczf1ar/uvZclDkj1aIzuWTtqSr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r51RGL4S3AvxKH5pH9bYVVpu8izADPp4qm/6wJ9eSOl4qSoFR1iaEx/DwRJVUEE1S4BPdN1IzyKsULDFu4LvU3MlVEhzOVd76GWUZlTnZFCecV9QJqTV38ug7/zR2XtT4DCKqyjfbyMPmctpt0bJlZ1Kwj6+t7ij5pWILKr9Xjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=stE82VZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jgau77CO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 37C401D000D9;
	Mon,  4 Aug 2025 05:05:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 04 Aug 2025 05:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1754298357; x=1754384757; bh=eFS3d3L/IM
	mUBqctBUBdM6QArqx14vozeDEmn7cNfaM=; b=stE82VZ7BzAGbxlsTOws2FM0TG
	mH0677mPof71cpJLG0uwDNUI+luZGdmyiRBAW159Gvnu8jteo9/aTX7psuM5tbEB
	WK9kld7MW6re2DWKnuW1J1Bj/GOTiEjcldvbuMuehqnScWOoWRL1fU7WBcc/oaSJ
	vwPYtKY0AWMCwcc7LLkpkNuLdtAa9xwIHsZUeAHCIeePyS2qJgGo+Ma4NiKoDHtI
	pezqKtiuLYtGaC6cdFqV2+xX8vMmVgdXt7G5KxVthp1PtdzWzjf3xX/z6d741pQK
	7unNUZBdrGHYVbMrZdyHU577IO7TsZKsK/aWq6tNjyEYnGUkEw7oxQ/x8FUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754298357; x=1754384757; bh=eFS3d3L/IMmUBqctBUBdM6QArqx14vozeDE
	mn7cNfaM=; b=Jgau77CO/OVM5OElJILZNIXtKUmlZ+RawAZ/ipRxQH8dIFJtqdT
	hks6Itg3WmqHubzZObanVdHHQge8v4UqvVQ9jrpqXZZoBO8sYNgBjXF/xL1PhE5m
	vt5OKTkiCb358Q4BJwKPnAEkdaVrxIlqjyn/hNM0pkZYy0q6KYBx8ujjYWjy+jgr
	x+SpSKm+vs5HrKFtytYcazidYctWrZtj/CWGJoRry5EfhcnqBDECPKyABS08oq09
	1p+raIJmh6CX9Mn/l0Jg9Bo2rQE6XrTHhRydkfQ1yUGUDpa7qJKgj+O7e6WT41xo
	SmI9rIi6zNWUICf1DNuIYYxImTOGKnniy/w==
X-ME-Sender: <xms:83eQaJH1Bfw8P2bbPy5_H_PA_50ke0_LdmW6XbUwGP4bypu7FC4VRA>
    <xme:83eQaLSSYlxaOESDrS_1eNNsSC0VbhjMvr9qfsfUzRALpipkecb6FkHldo5hBq8i4
    v5N5qosoW3g2MU9d5s>
X-ME-Received: <xmr:83eQaGxMn7DxmcP3w5RZItPwNL8UHMlFd785i7rGfdMe9qUzltK9aX-2-jZR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddukeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnheptefhieejudeileehvefhjefhudduheekleelvedvkeffieevjedvgfeljefh
    udefnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgv
    rghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthhopehsthgvfh
    hfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopehhvghr
    sggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepuggrvh
    gvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopeigihihohhurdifrghnghgt
    ohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehshiiisghothdoieeigedurgeiud
    hfvgdtvgdvvgeklegrvgektgehsehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:83eQaHcgS5YeobgwDUkazsUwC2A9frmtSPFSsCDpB__obakvaxxTKQ>
    <xmx:83eQaJO6k31ksfcfvWsT3T4VrhDBrJeznzbcDkNFXAhYh-fUlMzoAg>
    <xmx:83eQaCvTzS0XubXhq-b_3XsuvvHezngkNk55YTHkgithlBPhlaiLyA>
    <xmx:83eQaKBrs5TrIyWSJjiv8-N4-mCy2khq54c_uY4jAwTwhALNqG_cFA>
    <xmx:9XeQaKWow7V5oER3wHBLBHOmxU-w96DPu40wc9pPKHtcPP3BXegZHeM7>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:05:55 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
Subject: [PATCH ipsec] xfrm: flush all states in xfrm_state_fini
Date: Mon,  4 Aug 2025 11:05:43 +0200
Message-ID: <beb8eb1b675f18281f67665f6181350f33be519f.1753820150.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reverting commit f75a2804da39 ("xfrm: destroy xfrm_state
synchronously on net exit path"), I incorrectly changed
xfrm_state_flush's "proto" argument back to IPSEC_PROTO_ANY. This
reverts some of the changes in commit dbb2483b2a46 ("xfrm: clean up
xfrm protocol checks"), and leads to some states not being removed
when we exit the netns.

Pass 0 instead of IPSEC_PROTO_ANY from both xfrm_state_fini
xfrm6_tunnel_net_exit, so that xfrm_state_flush deletes all states.

Fixes: 2a198bbec691 ("Revert "xfrm: destroy xfrm_state synchronously on net exit path"")
Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
Tested-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/ipv6/xfrm6_tunnel.c | 2 +-
 net/xfrm/xfrm_state.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 5120a763da0d..0a0eeaed0591 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -334,7 +334,7 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
 	unsigned int i;
 
-	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
+	xfrm_state_flush(net, 0, false);
 	xfrm_flush_gc();
 
 	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 97ff756191ba..5f1da305eea8 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3278,7 +3278,7 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
+	xfrm_state_flush(net, 0, false);
 	flush_work(&xfrm_state_gc_work);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
-- 
2.50.0


