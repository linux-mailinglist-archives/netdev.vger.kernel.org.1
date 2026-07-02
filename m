Return-Path: <netdev+bounces-304169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VMWWMKhaRmoNRgsAu9opvQ
	(envelope-from <netdev+bounces-304169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:33:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA24E6F7A8D
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:33:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b="cEpFEgj/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304169-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304169-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55BFA304F5D1
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E309B47F2E8;
	Thu,  2 Jul 2026 12:20:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95747DFB4;
	Thu,  2 Jul 2026 12:20:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994839; cv=none; b=XS7ENJewRQx8zM1P0HVVkjnhsHTtLdgq1cBJ54+0ONjSzJP74XTko/Z7O95v4LMkP86w9/sp/e5UGtNZGAaBDBi4E75QJMqgUGFBrSfqlY65jMQRYsyU5FVNY7wdK2oZPXmiDmSzUZdnM39Nfh1P99wo0Cw6B4KhRKgAxDUm0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994839; c=relaxed/simple;
	bh=Z4fi7hF4qUAeRRQWGL/pkRYG80NZ9Oi9CgHGR2K0+/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I9PWWBNHNmVXyNOm81M3YkZdSzrz8Sq4bnRlYfbtr9gkS0zmhYbngR2wHb3BnRhLZIFZG/hkZrQvgk11BUlyj1Pf6650ugOO0pBtiffFKhPHQhIlDgLlDMspUY7fSSGEVhsA7O3Fv1nPaSuVLfJdbl6qLn5DlXCTV8rgcSpdCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cEpFEgj/; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=APS+0feuis8Vj4EOnHS62OMcNVLTOrx3AR7Djc1JWM8=; b=cEpFEgj/hpLnnq/NCJ5FTvAGcf
	L8bOQ1+j3iKPHFbOmqIJ9JafhbEmYGUeBC9TKgi2aNQy4StseOYVVQaE0p70s4q4OS878EiBzl38M
	j9LkjCszSm7hG3wsIiuIYfOZQ4w9SdNOLKJRn9Mb9zFB70fjCZbx5hCnwBXC9QO6YuXKDb1B7UZZi
	538Wd7mJ9VtI04etSM2OKhr2IfEzIc6rhBS2d1v3WKLDi+l/2O+jK7O5FoWfpNWzGVjTG5Ps+3S7g
	YZR5Nzb4dRqOYlq5r+AifXS+xKH1Df801sbXWvj2rkhb9/rLn4rckyQV0knRD+C58RCsBL5WHYtbv
	6O0etg4A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfGPC-008cQM-0T;
	Thu, 02 Jul 2026 12:20:34 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Jul 2026 05:19:46 -0700
Subject: [PATCH net-next v2 2/8] netconsole: take over skb pool lifecycle
 from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-netconsole_move_more-v2-2-1ebedd921dcb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6459; i=leitao@debian.org;
 h=from:subject:message-id; bh=Z4fi7hF4qUAeRRQWGL/pkRYG80NZ9Oi9CgHGR2K0+/g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqRleFW3UTbyYSoTfvQOcIa6eOxZvrbl7MzfIyp
 GugbIYvGL+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakZXhQAKCRA1o5Of/Hh3
 bcD1EACrk8/L+RuHCmSAfpJSMmtZgpgNP3yVsxVoUV+MDUqJdhtF9gZE1JYRhuMA0MNoviIJ+RY
 RVwjbMQHuqy36Qyj/lJQAAa55rUHFnRyGnXLWT1tcKsXAeRi8HdlEghvaayFW2IuDhi/LDR1+l9
 E+Q0yFJZLWxLt5MGqeKmbglXmpmN9nXl7LBz2vglJ213A29hIqkzI1NKuyPrNB7qJqalHaJtGiU
 g+MV+FZ97n2QnTod7dAjQrHflTJjPvRXB81yx8ttJqAirYXGT066i+dHgTMGiAqLdh/ocor7ZKx
 zYeDY0yfOdx2tDlumWjIwHM2ggBdfHpmBM5gmqgYxrQ3Q5FVzY8k8Lf+U64QE1c/BOgMtcQt9z6
 HQFbBSECO4sufzlGMSJagF7N7xl3XFIT8fcs+jOD9/YxP9Cjq5TQHKOqJgQnw5Rdm9dyOsvUCzK
 3mzf6zEwuVZyR0ini2D4RSKg7VlugXsAIlHVhegSGhNRRJsW/WC7hNuMlO96QQ7vB/1cnsW/tFF
 u3bwErTi3zQ2ws3E6QiaLhCjMICnsQ0AXToFYsfR/JS8uEPvXrL/OqbHZEnDlGU13drMkHbXR/5
 YHgcz/31E6TVl6+G7yrjFpSCEZAwkEEQXoAXxB6I6dxZXa4TuWlDaybvlAG42V/+cCm1jWK4edr
 SAAfYoyqsOt7qEA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304169-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA24E6F7A8D

The fallback skb pool fronted by find_skb() is netconsole's only client:
every other netpoll goes through __netpoll_setup() / netpoll_send_skb()
without ever touching np->skb_pool.

Today __netpoll_setup() and __netpoll_cleanup() create and destroy the
pool for everyone, paying ~48 KB of pre-allocated skbs per netpoll
instance that only netconsole uses, what a waste!

Move the responsibility to netconsole.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
 net/core/netpoll.c       | 12 +----------
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c1812a98365b7..78a4f27322fe2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -292,11 +292,35 @@ static void netcons_release_dev(struct netconsole_target *nt)
 		memset(&nt->np.dev_name, 0, IFNAMSIZ);
 }
 
+/* Initialise the per-target skb pool that find_skb() falls back to and
+ * seed it. Pair with netconsole_skb_pool_flush() at the matching
+ * netpoll teardown.
+ */
+static void netconsole_skb_pool_init(struct netconsole_target *nt)
+{
+	skb_queue_head_init(&nt->np.skb_pool);
+	INIT_WORK(&nt->np.refill_wq, refill_skbs_work_handler);
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
@@ -358,6 +382,7 @@ static void process_resume_target(struct work_struct *work)
 	rtnl_lock();
 	if (nt->state == STATE_ENABLED && nt->np.dev &&
 	    nt->np.dev->reg_state != NETREG_REGISTERED) {
+		netconsole_skb_pool_flush(nt);
 		netcons_release_dev(nt);
 		nt->state = STATE_DISABLED;
 	}
@@ -417,6 +442,7 @@ static void netconsole_process_cleanups_core(void)
 	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list) {
 		/* all entries in the cleanup_list needs to be disabled */
 		WARN_ON_ONCE(nt->state == STATE_ENABLED);
+		netconsole_skb_pool_flush(nt);
 		netcons_release_dev(nt);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
@@ -758,9 +784,19 @@ static ssize_t enabled_store(struct config_item *item,
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
@@ -1514,8 +1550,10 @@ static void drop_netconsole_target(struct config_group *group,
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
@@ -2330,10 +2368,18 @@ static struct netconsole_target *alloc_param_target(char *target_config,
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
@@ -2355,6 +2401,8 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 static void free_param_target(struct netconsole_target *nt)
 {
 	cancel_work_sync(&nt->resume_wq);
+	if (nt->state == STATE_ENABLED)
+		netconsole_skb_pool_flush(nt);
 	netpoll_cleanup(&nt->np);
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	kfree(nt->userdata);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index d990bfdfbad4d..fd21e69c8214e 100644
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
@@ -669,8 +661,6 @@ static void __netpoll_cleanup(struct netpoll *np)
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	}
-
-	skb_pool_flush(np);
 }
 
 void __netpoll_free(struct netpoll *np)

-- 
2.53.0-Meta


