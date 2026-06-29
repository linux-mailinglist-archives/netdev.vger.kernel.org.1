Return-Path: <netdev+bounces-302600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pnPsM65dQmor5gkAu9opvQ
	(envelope-from <netdev+bounces-302600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:57:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 292946D9B56
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:57:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=OkIzixf9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302600-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302600-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B1F302AE23
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC13FC5D9;
	Mon, 29 Jun 2026 11:46:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6563FBEC6;
	Mon, 29 Jun 2026 11:46:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733563; cv=none; b=l/hbHK8sGJIltgsyyEYxg34vkLyCkckGcwoSvpylFovKZHrr4XPZ5oMDTLXvIQqfMaeLjgq94FJabq0WbvSrmWFC8QzMmYzKaUjXW3x4SBMbe8g2bDcoOZ5Wf0AmRhM/QHH2C7J8+4vrgJ0ki2/vBPQpNEVEiXIMaFce5lCNqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733563; c=relaxed/simple;
	bh=IF96HeklOgAGTm1osRmKbtYFi3k+gEdlq8UOwVNhp6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XHLspYbslYTBzbHWx/yQVv86zD9vhk/v8YNfAB/bSL+C9ZTh0xwkcfoDZncTSZgCYxK5DzPzTRCpSz9DQzY1bTNLFHaPniM50e/6OokA0mlFlC9EFlCrleGcoDlOUAhCqkUAzQnAmVCZhE8Jv02jYHIeLyXVWJKwU8MkCteU1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OkIzixf9; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=99pjMwtVTFNYiHB1I4KcazgslaG7xYVoOMlREyGTp7c=; b=OkIzixf9OAiZsTlnQBtpaTr2/Z
	QXl3t+fq4RD+yHir0scEqcmu9a3AhFiwQ7pUr4nh0ZJmtv25iwz4DTX+sNILZiQTGbiCxVAce0GkJ
	4nJ7nDHaqM2RXYCsaAnJrFhQvaTDQinzhdc3EAU9IZqe+/aeeB9zmy4sM19aU9rGVUyyN7Xj9t2Om
	Idjgoatv900x9Ch75X8pc5H37hFbSAaHC/LPEpL2rUWU1ZMU0xYQlcFZymoRkl/7+vegvia9+aI5C
	nMX8+PRA9R31NpchjF0Cq95mSVzexAoQGNdGGCKAQKN/LUhGqvnMNu5G97tf7ndi/7kkQZ6xYgFGM
	xmRubPeg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weAR4-006GeD-0e;
	Mon, 29 Jun 2026 11:45:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 29 Jun 2026 04:45:41 -0700
Subject: [PATCH net-next 2/2] netpoll: do not warn when the best-effort
 pool refill fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-netpoll_no_warn-v1-2-f380f0b2cd0c@debian.org>
References: <20260629-netpoll_no_warn-v1-0-f380f0b2cd0c@debian.org>
In-Reply-To: <20260629-netpoll_no_warn-v1-0-f380f0b2cd0c@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asantostc@gmail.com, gustavold@gmail.com, vlad.wing@gmail.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=leitao@debian.org;
 h=from:subject:message-id; bh=IF96HeklOgAGTm1osRmKbtYFi3k+gEdlq8UOwVNhp6I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqQlrpa5lTj3WcjNRalcmTnQ+1u6rdhIUa9LqRZ
 osznye/BZSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakJa6QAKCRA1o5Of/Hh3
 bbvoD/wJ6MmaMzb3lYSEOHur6VPY4kFFN0lKVWSoxsfjSq4nppVCUQI8isUPLQG2gGoNlNs3z3y
 BAJzwEZcBa7JcM2bwKPzwBYUl8gDsNSKVUtFdVaZegCZhIQMzilWHUeWIDcFLSC23sygG0tiXtt
 Osjp3n3beIrDVok4eoEuGMgcJ9C1kdgkNaEJyPJP++7oWcEv2nRjsOyMjSpRbLrMx/iez8rcmcx
 lAXhxgkpHCevwlhtygp9T3aJ6ubmRf/gggxR6x80KtQjzccLaMj7bEsGON/MNuMqHRqsUnXuamo
 EItPoTTQOKfX/8zSIwUpsJ54zg3QNn+hOAnFB1iF25IMwsr0RppeIiuyjS4D06W9xvCURH/zp30
 7hpxSouOAPp4/eLShAhnHsaWws76r+F2hA33FlilhlRkpqd22DnHqjxWap7IttRxdWkGCIUl7p3
 AjTP/hsyBSUs3xvqsQVtfqi/90omcdlc7KfhS1R7owGMrwU+sjVHmOvP32wLz6Pyb6kPTos43nS
 2cODNQJ0upr+dSs6x0O4SIGe3TSG2e7Lp2qTdXOMjW+dSoRBOFLZc//kI39JyUrPwtfQiOZQf+4
 +DNqTCh+t8KRVq5y0q9KsnQ7JvUqJzQVSmt9LX5C11WgvhfDnoLuBnKBMWqFyD0zpDCoWF8gDLr
 c+wKILEbiISB/Ew==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302600-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:vlad.wing@gmail.com,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 292946D9B56

refill_skbs() tops up the per-netpoll skb pool with GFP_ATOMIC and
simply stops on the first allocation failure, leaving the pool partially
filled; a later refill tops it up once memory frees up. The allocation
failing is therefore an expected and fully handled condition, but
without __GFP_NOWARN the page allocator emits a warn_alloc() splat with
a full stack trace on every miss.

Pass __GFP_NOWARN so the best-effort refill stays quiet, mirroring the
same change in netconsole's find_skb().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 229dde818ab33..85aa513508811 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -221,7 +221,7 @@ static void refill_skbs(struct netpoll *np)
 	skb_pool = &np->skb_pool;
 
 	while (READ_ONCE(skb_pool->qlen) < MAX_SKBS) {
-		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
+		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC | __GFP_NOWARN);
 		if (!skb)
 			break;
 

-- 
2.53.0-Meta


