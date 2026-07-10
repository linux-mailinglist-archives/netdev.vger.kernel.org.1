Return-Path: <netdev+bounces-306531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h3mbKH/fUGqj6gIAu9opvQ
	(envelope-from <netdev+bounces-306531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:03:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1648E73A7EA
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:03:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b="Zv5oi/Hs";
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306531-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306531-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65121307A2AB
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1804218B5;
	Fri, 10 Jul 2026 11:54:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC78405C47;
	Fri, 10 Jul 2026 11:54:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684477; cv=none; b=V95zsoXauRHb2zVzguUHv3cGiRAfHHg6SqrWGdXWkbd9npQ3aX0A70KERIqrCqrKLOBh/R2UFf10ZY5/6IM3acxuZYS/df0KqcSk7HsayngMQCuuplTe884xV0GXCnMiPLYd2TTIW5hAdlsl6ZEnrZsASqDkRxhtPZHaDNgeA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684477; c=relaxed/simple;
	bh=+HnxFdzsmfYXDR6h58o2iC5lbHmhEwK1mQEqWcICEsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kr+LfigtTgKUt8D13xx3m+IYp5BudrLXO6pX0myNy4Me+9Yjss+LrNjlTJf8gLFRpAs91S+ic+8NIBbx0CzRx19z+JZcufhHp4hNWOTQsng+m+Ph5oQuP1FkmftZzqd3udCYj1uUVZMRmrlPcZPnud3xC8DoVG4OrQ8lJstjyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Zv5oi/Hs; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=7oowkfPEFAJRV1DtnDc4AIOkhoiFwcFBUYiL5AH0cQA=; b=Zv5oi/Hs12RQrmkWWNypU+DBfJ
	CTPsyrC9XKLNvAZApXVg5uIFi/T0opwH5hA0Vn0dpjVVcdsno5HnU7vTP8fAKQ9ra/bh0QTnhIBVV
	SnZ9CeaFx+QWuMLkWW1p4C0so0saEeaiEswcC3WU2bm0yjBucFH8xh68FHJZSzPwKU/6MT/buS4DO
	d6wMaECDjkFDxGFiqDNWjhe+zntlj/R/zZnRxpyfxgCqRUAhn/CygAKXteGKhgiJirXZxUEgQL21y
	yZAbdoKOKF2Wm0V0hQKZ5Cn0iaVUBK1Z/4Umj3Qt7mqEP9WG2z8NssGgMGS8+zCVrVMwTksOJ6eLG
	kxQT9NAA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi9oK-004SY1-0n;
	Fri, 10 Jul 2026 11:54:28 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Jul 2026 04:38:55 -0700
Subject: [PATCH net-next v3 3/9] netconsole: take over skb pool lifecycle
 from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-netconsole_move_more-v3-3-6f63f76b28bc@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7601; i=leitao@debian.org;
 h=from:subject:message-id; bh=+HnxFdzsmfYXDR6h58o2iC5lbHmhEwK1mQEqWcICEsI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUN1jjZ8wolZsvA4F4kkTIKqJmCr8d5fsfhZOt
 XHuCkcw0O+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDdYwAKCRA1o5Of/Hh3
 bZn2D/9ZnXs2GGZBxRM1QC1B7NMyW2J78qbCWsEghwp4pbCnS/FfmAR8z5RtkRIduz7DAemjyiq
 Jq9EMSfyO1oQU9opm5t4tlAi8CniPNUN7AtSETGW+gjrzR5XBtz35Q7/Ni+zLhVvJBvSNEZdIix
 M5OW2xHqDx3P9FHgtjtnIkTOuCtb7ieRT52E56/Zb+t42A1bW5lfqkiAWM2KBciguGmzyttwxX9
 OQLEHDvrMO9iztR9C5Jf9ElmBReJoC8eIH9cseUk+sjnTUoUUF+q0gY9ioeTCMCmeu0AzMrE25X
 DjP7g6P936qk1GMUlh/BECSddM8Gj3dag2a+84QzoiybfG9q80Jh2/pBiSzsroZOGuz59mlWJkT
 TwNsVZtz56yFjmfkqpdOMswEyZWrzdmt6nwNLMaHP3oY9CmOTuTPsBbDliCDLxZCmUk+DWnMujs
 J1rPLAb4H2VUf4SYrDHNZdg0hiu6AbZxWf6rfnj5EMD3ET5RAP24zX+eYBWDW+tL686S1OVYhWQ
 2N7Czml74nxJAGmGeklgupzLGh5xRYiMw5pfhkIJhrFGwPkzLXPwytYdanW2XbSnccm4Q0mvFVr
 Mj9QXrcoIse6ufwZE12dakG9ztCI8++H6eZHcneXV0T3IkN91wI6NzKIKDNZdhN175iy33qrmPh
 oSeLt18ITdlX5FQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306531-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1648E73A7EA

The fallback skb pool fronted by find_skb() is netconsole's only client:
every other netpoll goes through __netpoll_setup() / netpoll_send_skb()
without ever touching np->skb_pool.

Today __netpoll_setup() and __netpoll_cleanup() create and destroy the
pool for everyone, paying ~48 KB of pre-allocated skbs per netpoll
instance that only netconsole uses, what a waste!

Move the responsibility to netconsole. __netpoll_setup() did this under
the RTNL, but netconsole enables targets from enabled_store() /
alloc_param_target() without it, while the teardown path flushes the pool
(cancel_work_sync() + skb_queue_purge()) under the RTNL from
netconsole_process_cleanups_core(). Initialising the queue head and the
refill work on every enable would therefore race that flush.

They only need initialising once: after a flush the queue head is left
valid and empty and cancel_work_sync() leaves the work re-armable. Set
them up in alloc_and_init(), while the target is not yet reachable, and
let the enable paths only refill the pool via refill_skbs(), which
serialises with the flush through skb_pool.lock. See discussions in [1]

Link: https://lore.kernel.org/all/alDMvD5S7TZnoD_V@gmail.com/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++--
 net/core/netpoll.c       | 12 +----------
 2 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index a939daa07cf9d..1f75c4bbea8b6 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -292,11 +292,33 @@ static void netcons_release_dev(struct netconsole_target *nt)
 		memset(&nt->np.dev_name, 0, IFNAMSIZ);
 }
 
+/* Seed the per-target skb pool that find_skb() falls back to. The queue
+ * head and refill work are set up once in alloc_and_init(); this only
+ * (re)fills the pool. Pair with netconsole_skb_pool_flush().
+ */
+static void netconsole_skb_pool_init(struct netconsole_target *nt)
+{
+	refill_skbs(&nt->np);
+}
+
+static void netconsole_skb_pool_flush(struct netconsole_target *nt)
+{
+	skb_pool_flush(&nt->np);
+}
+
 /* Attempts to resume logging to a deactivated target. */
 static void resume_target(struct netconsole_target *nt)
 {
+	/* Initialise the skb pool before netpoll_setup() makes nt->np.dev
+	 * visible to target_list walkers (e.g. netconsole_netdev_event),
+	 * which otherwise may move the target to the cleanup list and
+	 * call netconsole_skb_pool_flush() on uninitialised state.
+	 */
+	netconsole_skb_pool_init(nt);
+
 	if (netpoll_setup(&nt->np)) {
 		/* netpoll fails setup once, do not try again. */
+		netconsole_skb_pool_flush(nt);
 		nt->state = STATE_DISABLED;
 		return;
 	}
@@ -358,6 +380,7 @@ static void process_resume_target(struct work_struct *work)
 	rtnl_lock();
 	if (nt->state == STATE_ENABLED && nt->np.dev &&
 	    nt->np.dev->reg_state != NETREG_REGISTERED) {
+		netconsole_skb_pool_flush(nt);
 		netcons_release_dev(nt);
 		nt->state = STATE_DISABLED;
 	}
@@ -398,6 +421,9 @@ static struct netconsole_target *alloc_and_init(void)
 	eth_broadcast_addr(nt->np.remote_mac);
 	nt->state = STATE_DISABLED;
 	INIT_WORK(&nt->resume_wq, process_resume_target);
+	/* Set up the skb pool primitives once; enabling only refills it. */
+	skb_queue_head_init(&nt->np.skb_pool);
+	INIT_WORK(&nt->np.refill_wq, refill_skbs_work_handler);
 
 	return nt;
 }
@@ -417,6 +443,7 @@ static void netconsole_process_cleanups_core(void)
 	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list) {
 		/* all entries in the cleanup_list needs to be disabled */
 		WARN_ON_ONCE(nt->state == STATE_ENABLED);
+		netconsole_skb_pool_flush(nt);
 		netcons_release_dev(nt);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
@@ -758,9 +785,19 @@ static ssize_t enabled_store(struct config_item *item,
 		 */
 		netconsole_print_banner(&nt->np);
 
+		/* Initialise the skb pool before netpoll_setup() so the pool
+		 * is valid as soon as nt->np.dev becomes visible to
+		 * target_list walkers (netconsole_netdev_event), which would
+		 * otherwise call netconsole_skb_pool_flush() on uninitialised
+		 * state.
+		 */
+		netconsole_skb_pool_init(nt);
+
 		ret = netpoll_setup(&nt->np);
-		if (ret)
+		if (ret) {
+			netconsole_skb_pool_flush(nt);
 			goto out_unlock;
+		}
 
 		nt->state = STATE_ENABLED;
 		pr_info("network logging started\n");
@@ -1514,8 +1551,10 @@ static void drop_netconsole_target(struct config_group *group,
 	 * netpoll_cleanup() is idempotent (it skips when np->dev is NULL), so
 	 * it is safe even if the cleanup worker already tore the netpoll down.
 	 */
-	if (needs_cleanup)
+	if (needs_cleanup) {
+		netconsole_skb_pool_flush(nt);
 		netpoll_cleanup(&nt->np);
+	}
 
 	config_item_put(&nt->group.cg_item);
 }
@@ -2330,10 +2369,18 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	if (err)
 		goto fail;
 
+	/* Initialise the skb pool before netpoll_setup() so the pool is
+	 * valid as soon as nt->np.dev becomes visible. The target is not
+	 * yet on target_list, so a netdev event cannot reach it here, but
+	 * mirror the configfs path for symmetry.
+	 */
+	netconsole_skb_pool_init(nt);
+
 	err = netpoll_setup(&nt->np);
 	if (err) {
 		pr_err("Not enabling netconsole for %s%d. Netpoll setup failed\n",
 		       NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
+		netconsole_skb_pool_flush(nt);
 		if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
 			/* only fail if dynamic reconfiguration is set,
 			 * otherwise, keep the target in the list, but disabled.
@@ -2355,6 +2402,8 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 static void free_param_target(struct netconsole_target *nt)
 {
 	cancel_work_sync(&nt->resume_wq);
+	if (nt->state == STATE_ENABLED)
+		netconsole_skb_pool_flush(nt);
 	netpoll_cleanup(&nt->np);
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	kfree(nt->userdata);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e062d88d10a37..58f30a4d5eb0f 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -377,9 +377,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	const struct net_device_ops *ops;
 	int err;
 
-	skb_queue_head_init(&np->skb_pool);
-	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
-
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
 		       ndev->name);
@@ -414,9 +411,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	np->dev = ndev;
 	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 
-	/* fill up the skb queue */
-	refill_skbs(np);
-
 	/* last thing to do is link it to the net device structure */
 	rcu_assign_pointer(ndev->npinfo, npinfo);
 
@@ -606,7 +600,7 @@ int netpoll_setup(struct netpoll *np)
 
 	err = __netpoll_setup(np, ndev);
 	if (err)
-		goto flush;
+		goto put;
 	rtnl_unlock();
 
 	/* Make sure all NAPI polls which started before dev->npinfo
@@ -617,8 +611,6 @@ int netpoll_setup(struct netpoll *np)
 
 	return 0;
 
-flush:
-	skb_pool_flush(np);
 put:
 	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (ip_overwritten)
@@ -662,8 +654,6 @@ static void __netpoll_cleanup(struct netpoll *np)
 		disable_delayed_work_sync(&npinfo->tx_work);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	}
-
-	skb_pool_flush(np);
 }
 
 void __netpoll_free(struct netpoll *np)

-- 
2.53.0-Meta


