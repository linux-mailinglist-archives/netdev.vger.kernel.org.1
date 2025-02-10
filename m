Return-Path: <netdev+bounces-164803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F99AA2F26C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63C61881E30
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8191D247DCE;
	Mon, 10 Feb 2025 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="lfsAeDpk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YIiu7rM9"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650C222575
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203327; cv=none; b=XkMHIyqeTZVUWdHKtTzXpYb49LfUI91sIDyUne/NueOd0db7CtmmQ9k0BPJ+7j9FfRmWwEyOob8qvD7xfXO3TnJsQzyPAJZjF5Y9X2mDWejJAfQPkRQZZkvcjqJSKyMzG+sKSXVQnJjDLhiNyL+3aVCcBDxc6mzYupQyMQWA3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203327; c=relaxed/simple;
	bh=vJ2vAoKP2H2NX5NJyrXDmwbCXai7W97+j15hLv57/t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bvzffbda1lTWUIqP3XG47nxh1+EyVPlz420Xsky8Sr3u07UyLHPkjky0i81kuXUy85y8NbUH1NUr4cn36ZMgcev2yJqrcu8K0MP66vFQQhoS7WfUOLSPUU8j6mTBqmBxNM0ge5qnH6rFPPKjOrahg7uCsQSNYzK7ukZeA/1PlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lfsAeDpk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YIiu7rM9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF7AE254012B;
	Mon, 10 Feb 2025 11:02:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 11:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1739203322; x=1739289722; bh=XV8UQmhXju
	orEsESH2rGfvoHP8+0ww60XAxiZANYS2c=; b=lfsAeDpkLqpXhJio/03MaWqjfw
	9W54R2fVs6JRUg01LhwtAnQHSeIWvAfXuA/ZsgFjjKqi0jxxaIDWPkpgptm18WJZ
	iob0SeLQkaXD5QlnjH+2d70O+IdrpazJ04G3QhUdW2nnPMG+mGmMquHvOyHyeuGC
	b1NF5PorePUm781zimLeybWJuzoZLqwr1t7zDQObXKLiRRGUnjBcXccFH73OTEJS
	+xCmZZsi9ARqvP/hlHRdN5iTcb+dq6nmM7UXSoCebQexRybn2ZYxf8yBDsZnJX0s
	6Xrw58Q6jvWBty/Xnk3q1thDsapRsfpaez6xoSMTu9TKUmvBE9nFPmHm1JdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739203322; x=1739289722; bh=XV8UQmhXjuorEsESH2rGfvoHP8+0ww60XAx
	iZANYS2c=; b=YIiu7rM9325SY3utdJ0/dlMrQW6ACmgQDqax6khdI826g5oUCG2
	mF/38aVAHS+s1ge7Kz+9Zi2vMqOqBRenuDjBSqeCR4DMfYcWlSCwAfKhHqIR/HgT
	zJ2e1iO69wpPxutjgXYEWE1q2yeDc3eksYjzcQ3mYnLIZh7cghEN6J7iICN27YMO
	wizUuPogHVtp+BXoHhzckDDfuF+TLHF1U/zCC/9x7tCfFNjkAvaRq7uuxiK1IynL
	wUYoNyjO3kfJvigVMoFPfQ6UUCNkct7fmNnXpsn014WDh9NX/5INr1auoSKoicNU
	a1ZSmiaN8gA58AyKaD0bBCk893NWBHK0Naw==
X-ME-Sender: <xms:-iKqZ5tWFBC7SRZvEdmrxxNR1S0JnYnvGzPXyS8W8ZfFBfFplIn1lA>
    <xme:-iKqZyc-UqfVmKZufQ-Yu6OixwAUCQG-SycPHKBk3vCjeRu9fbEI4mYipVSQhBpm_
    PT0KMiG4Zz1Gas5z-8>
X-ME-Received: <xmr:-iKqZ8zYLzd7SP0Frvpkw4Awa-SXB7YUmeK6x3Qyn4WT--mP64CRIZo1wm8a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeejtdeugfffkeejfeehkeeiiedvjeehvddu
    ffevfeetueffheegteetvdfhffevffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshihsnhgr
    ihhlrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgtrghr
    ugifvghllhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhunhhihihusegrmhgrii
    honhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopeigmhhusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:-iKqZwMDGoVLqfu_rwvEZ3AqS7K0U2vmDkMrMuP4S5Nn8JprS3BozQ>
    <xmx:-iKqZ5--z6fYsK-q1Jo2O04DsAUjUffNz8ixaWo6AO7y_Ibaryt1xQ>
    <xmx:-iKqZwWgMTaad3i_0hsgJAeyrqqdcKXBaExKSVJ4q0HVBRL4VbSASA>
    <xmx:-iKqZ6cxH_a3ZY_C-Zy4grWQU4Qyp407MvFxV0DDmAdbkXyM4ViXsg>
    <xmx:-iKqZ1SM9lard78CQYlAiOJ7BOgqtKjeODHiGcBpIOoOC9C22oo-KJx_>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 11:02:01 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Xiumei Mu <xmu@redhat.com>
Subject: [PATCH net] tcp: drop skb extensions before skb_attempt_defer_free
Date: Mon, 10 Feb 2025 17:01:44 +0100
Message-ID: <879a4592e4e4bd0c30dbe29ca189e224ec1739a5.1739201151.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
running tests that boil down to:
 - create a pair of netns
 - run a basic TCP test over ipcomp6
 - delete the pair of netns

The xfrm_state found on spi_byaddr was not deleted at the time we
delete the netns, because we still have a reference on it. This
lingering reference comes from a secpath (which holds a ref on the
xfrm_state), which is still attached to an skb. This skb is not
leaked, it ends up on sk_receive_queue and then gets defer-free'd by
skb_attempt_defer_free.

The problem happens when we defer freeing an skb (push it on one CPU's
defer_list), and don't flush that list before the netns is deleted. In
that case, we still have a reference on the xfrm_state that we don't
expect at this point.

tcp_eat_recv_skb is currently the only caller of skb_attempt_defer_free,
so I'm fixing it here. This patch also adds a DEBUG_NET_WARN_ON_ONCE
in skb_attempt_defer_free, to make sure we don't re-introduce this
problem.

Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lists")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
A few comments:
 - AFAICT this could not happen before 68822bdf76f1, since we would
   have emptied the (per-socket) defer_list before getting to ->exit()
   for the netns
 - I thought about dropping the extensions at the same time as we
   already drop the dst, but Paolo said this is probably not correct due
   to IP_CMSG_PASSSEC
 - I'm planning to rework the "synchronous" removal of xfrm_states
   (commit f75a2804da39 ("xfrm: destroy xfrm_state synchronously on
   net exit path")), which may also be able to fix this problem, but
   it is going to be a lot more complex than this patch

 net/core/skbuff.c | 1 +
 net/ipv4/tcp.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6a99c453397f..abd0371bc51a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7047,6 +7047,7 @@ nodefer:	kfree_skb_napi_cache(skb);
 
 	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
 	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
+	DEBUG_NET_WARN_ON_ONCE(skb_has_extensions(skb));
 
 	sd = &per_cpu(softnet_data, cpu);
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..e60f642485ee 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1524,6 +1524,7 @@ static void tcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
 		sock_rfree(skb);
 		skb->destructor = NULL;
 		skb->sk = NULL;
+		skb_ext_reset(skb);
 		return skb_attempt_defer_free(skb);
 	}
 	__kfree_skb(skb);
-- 
2.48.1


