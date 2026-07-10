Return-Path: <netdev+bounces-306532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nYqiNrfdUGo86gIAu9opvQ
	(envelope-from <netdev+bounces-306532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:55:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2404373A760
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:55:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=bmcS8K4W;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306532-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306532-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20B3A3005317
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A6141B374;
	Fri, 10 Jul 2026 11:54:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7CD421A02;
	Fri, 10 Jul 2026 11:54:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684481; cv=none; b=FSwtL7e/WtlfQEaPDovPrirQdKqE/S2JKdg4lVfzN7CWDOj2ZUJuXyqIavVw8s+tsv3OaUnczXjURC587O95IE+6ZDD4q0Uq/ZubSMzqlnfqojFHq0maxd6XDtOoKzXxv54kJE4wYv48OQ3UvH4fF5IDTfghEhUXO8uBJLpPDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684481; c=relaxed/simple;
	bh=nFPh5ac2FjWKCd6q3wB6UC+vMdK1zYkYSuMailRysDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzGwcQod/hSMooEQt4n57niiTzCfuY27ww695XhLA3Kbi12pzJZkS+daCQ9WRFB1zPsgdvn5KVt9CkjlLmquwUm/QmkrEprMYb/1VWGEEC6XUKLhHZkvAapSO1/N0Wyp75KOyTUAUHjqRlz64VBtCzrWXb66aHbDknxxu7+MUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bmcS8K4W; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=3foEhfhb8cg0zgtGPamqg4RaUv3W2ktXLO1Kxs0TI5o=; b=bmcS8K4WGPhMj7bK/53yL57DWj
	pcB+yP4uBZ9uiOQGLUFH+I+zv9FQCOCBYpPuF0MHtjgVpYsjeEO9+e6BKJ5dC6UKukFCPzNFcrXgr
	hPzg45eyhyIYW4UgCv226nwXinbq6QXTAsp7hclpWemP2mj4v3o/VLs1OJ3HrfM4YmTxhGp7FuJ0u
	dGXKcFX2dSOM7cypzSE38CCsFYijmgyIumr8NFBv36k2ibTCjdX+PW33rRSOlR+SHrro4GYYXiLiD
	h6A/w1IfoCGwXtfD7ooPmr2BvBVXh/Qhn0hQQRAb4ryWJKYMcTvPKJITN9Ok5zDvmBN6Gog1jtFyp
	OWNUJ4rg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi9oO-004SYN-1l;
	Fri, 10 Jul 2026 11:54:32 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Jul 2026 04:38:56 -0700
Subject: [PATCH net-next v3 4/9] netconsole: move
 refill_skbs_work_handler() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-netconsole_move_more-v3-4-6f63f76b28bc@debian.org>
References: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
In-Reply-To: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2471; i=leitao@debian.org;
 h=from:subject:message-id; bh=nFPh5ac2FjWKCd6q3wB6UC+vMdK1zYkYSuMailRysDc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUN1jjepZA9fyIwSatuQFjaPZoy0Hw/iYn+Qn/
 UR8thofJJ+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDdYwAKCRA1o5Of/Hh3
 bfTMD/4ldvdlUhAKZ9QnfO6zrD0bG43ah588cLeBIKlAFL4dllbjcB3EvL66OFRmwJp60jt6LPl
 hYEhbQByr4AbLXEreuAPcNzdbrNp2KwklITa+ROAwqYYHqpaRRp7jgPNXezpfQV2ZECrOL1qSe/
 bFNdcXH9XEME92cjkxLp6d9782pYhtxUDCKn1MZMqCN5eBcxUYgLNzZE0JEKCWMbsvbDcWNMtop
 iScP6hKaDDr3vY0OqSUnWBXL7JLo0RMVUOFjcd1xlu1XSK+7nwIhFvaND0g7oqC9gqEWmIKr8JK
 91GSsslPYSd9uHXH6S8011b7z7F9chvRJw6WTXcFVvQFc4uVGT+D/59Qw10Z9NmgvO3wqbxvD/p
 d0fgdhCD6SUlzDj7IpH+YSMX7/OZTOOVO1Ve8WVDeSz6aQABHbMLOwaddJhkERm1BL3/aTHNvMK
 LLi0WKa78XyysJ4aTUi7b+LxgN8DRQ8eVL+yCmhpXz3E51Bpx5GCjrVEHIb4PYYmnxJUE00UDvH
 EFrsyRrJ/o9mMABZGit7vXhTjUKmeakf6sSKGLPe0M3jUNHFg8cs+YgFYi9HyJJyzgZlgLKaAn+
 42W/STvRGs6Oa+VP+ltet0vmIfJ89DyV2Dh5BA+8AwwKBFk3aYUcA1GcPbfG1TbbtO0UJ4u/hXm
 eSe6aiZdIfCsitA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306532-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2404373A760

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
index 1f75c4bbea8b6..96d9a47312cd7 100644
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
 /* Seed the per-target skb pool that find_skb() falls back to. The queue
  * head and refill work are set up once in alloc_and_init(); this only
  * (re)fills the pool. Pair with netconsole_skb_pool_flush().
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
index 58f30a4d5eb0f..93a16faf808c8 100644
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


