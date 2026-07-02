Return-Path: <netdev+bounces-304170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rx0UJppYRmocRQsAu9opvQ
	(envelope-from <netdev+bounces-304170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:24:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 205AE6F7879
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:24:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=GoG+OPoh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304170-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304170-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E6D03026AE0
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE0F47DF8F;
	Thu,  2 Jul 2026 12:20:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8948034D;
	Thu,  2 Jul 2026 12:20:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994843; cv=none; b=lIePguHGvsOlxlMYy9E4jlrFygeqTBEvAzYHcOSgnRSeeGHsD7pUBTAUD2SLkxd/NbUe37GmosTJx0JwunLxN2426xqThusxOzb9Mg4qhlTVP1bHvf1oF5xyRtYtafbriwmcUyU9KvVZDcW590c8ToIpaKDpqBurspgTT1qD7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994843; c=relaxed/simple;
	bh=0ThWpvu+u8I46Mlfxxm4A0z2go2lo6ujJH2oBZMMg1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFLtbDTHt/AYEOU8Hy4CukkMREoh8yU5YKS2YBWO7Uhf2LMbckAawRnDx5TuHbbq43UxEq0WKjfPBJDwnMTcSfQZNIrwAvhDI/Zy+yd3mYr0Vr+eVB15pwmcYPAttUKtGw3HOOouBIuq63VPV+gv2hTdBCBJvQJ/OTZYjuOuqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GoG+OPoh; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=TGx5VY3ERjSYqAcxjm9X6+Nhm8noUM4A9BBQEFNdiks=; b=GoG+OPohKUpPLUknNEJ7XwaOS5
	zWo61M5xRABT9vM0HAX5Uv1qatZ4FpkrXuMKC0zn9cMULnkP6pLuhNjnxI6VRS/sM1QHWC3Jmb1Nv
	Im+TRzwEdqFHiJFDLbRfhyNPhjpfpKowTjUPr4XWidFxwwRRAcLv/h+dWZ/1nzZFyhfJyHVQWeVGo
	itWVfRiy7Q5p5VSgrfyh5jMbVGpMKAdgj2RbfpURsSJs/mv94nVbX4RaWc4VtLSRnbifQYponewrq
	/Y+pP1ny67GT5AHSK9cy8VC3lVgMrzwt/yYm6gvsbOZ5xs75dzeLaq85nArlqmWiN8XEnxt1gBjvm
	r+nuRj+w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfGPG-008cQZ-0q;
	Thu, 02 Jul 2026 12:20:38 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Jul 2026 05:19:47 -0700
Subject: [PATCH net-next v2 3/8] netconsole: move
 refill_skbs_work_handler() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-netconsole_move_more-v2-3-1ebedd921dcb@debian.org>
References: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
In-Reply-To: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424; i=leitao@debian.org;
 h=from:subject:message-id; bh=0ThWpvu+u8I46Mlfxxm4A0z2go2lo6ujJH2oBZMMg1A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqRleFHszTowoPKQ23s/LnOfPFQfh1Q7UOjTxG5
 XXk9nGpbtiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakZXhQAKCRA1o5Of/Hh3
 bUGmD/9219sc+OCElsiyQrS5DsnnBpVaerR1fGEw/WjQHH95xnz4IHAswP3DE4QAyxVecGmmQ0P
 TKfDb6xX8DRGDbzyvVYinfBJqu8d7L4tqizcIxTv3IrvziDC54oBYFVPRuiKaWpuIr/YYrRV4yB
 3vY9fEtiRVly9XK9I7Y3BOzl4TvRcSSJ8zWNS6iXJvLJSseyRXLVoy/xTvG4tiZCHwRIHtOPyRF
 BHLKXFKuQ3kH5O4tjqMB96sO5eB9jCkfzTxQm2hIghpV4D/06PAB0ohiasY7Zy+Du/AVer5Jzyd
 gfEA2mu6Dqdlp/JhPL/o/uFN7S2geflUMvdz+5teObQbF474YAw5WzvYKQIUQRYELgwdFCpw7M4
 efSbDv5mShAl9bjg0nHH5ZqkNO9wVWNX8vuQsc7NRelM1//TNJ7WziBEDjXES1KMxhY2Cqle3vZ
 M4DT4taC4meu1J+Dql55DsPw9Iwcdz0We8S4/X8FuAVl2rW3bPxa/UzuIOrjjSoPNWA6Q/+1x3W
 BhgQxEiBI/CQaWVxSROTd/R1F9CTimKbp/PCo/xLC7+yKtb2qA24iAcyiAigAH5u2PFQ8SZC9y2
 uuFrl/bH2i36RwR8vUxU39H2QyMGJpiiwcoFiwlXJVPM4SrbOHtD2oxbclMmzj2+UniVgrtzscD
 sviMXK7ICPDebMg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304170-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 205AE6F7879

The work handler is wired via INIT_WORK() in
netconsole_skb_pool_init() and has no other callers since the
previous patch took the skb pool lifecycle out of __netpoll_setup().
Move the function body into drivers/net/netconsole.c as a
file-static helper, drop EXPORT_SYMBOL_GPL() and remove the
prototype from <linux/netpoll.h>.

Pure code motion: the body is unchanged and still calls the
exported refill_skbs() in net/core/netpoll.c.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 8 ++++++++
 include/linux/netpoll.h  | 1 -
 net/core/netpoll.c       | 9 ---------
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 78a4f27322fe2..59b1f7d6f103a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -292,6 +292,14 @@ static void netcons_release_dev(struct netconsole_target *nt)
 		memset(&nt->np.dev_name, 0, IFNAMSIZ);
 }
 
+static void refill_skbs_work_handler(struct work_struct *work)
+{
+	struct netpoll *np =
+		container_of(work, struct netpoll, refill_wq);
+
+	refill_skbs(np);
+}
+
 /* Initialise the per-target skb pool that find_skb() falls back to and
  * seed it. Pair with netconsole_skb_pool_flush() at the matching
  * netpoll teardown.
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index a7b96e1792207..51e5863d8e678 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -91,7 +91,6 @@ void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
 void refill_skbs(struct netpoll *np);
-void refill_skbs_work_handler(struct work_struct *work);
 void skb_pool_flush(struct netpoll *np);
 
 #ifdef CONFIG_NETPOLL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index fd21e69c8214e..7088cf0df43ce 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -362,15 +362,6 @@ void skb_pool_flush(struct netpoll *np)
 }
 EXPORT_SYMBOL_GPL(skb_pool_flush);
 
-void refill_skbs_work_handler(struct work_struct *work)
-{
-	struct netpoll *np =
-		container_of(work, struct netpoll, refill_wq);
-
-	refill_skbs(np);
-}
-EXPORT_SYMBOL_GPL(refill_skbs_work_handler);
-
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 {
 	struct netpoll_info *npinfo;

-- 
2.53.0-Meta


