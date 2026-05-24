Return-Path: <netdev+bounces-291204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBDaCccjE2oA8QYAu9opvQ
	(envelope-from <netdev+bounces-291204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:13:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD95C30E3
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F4B4301F995
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA83A872E;
	Sun, 24 May 2026 16:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA33A7D63
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639147; cv=none; b=N9ThsVHNlDRzXwKz40ff1Js4XYNRU6JiBmovLwsRBpen33QuP3HqRtfNCnC5dpinZVMz0YI2rUem6n4wjtFjNljpVyQkIr9Du45Cms1gapTnTEjuHYE0WQjX7vruQAJdwNLkpYwKALwkgRaH0s4uQGY71vjSqqtLW4L2D89HPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639147; c=relaxed/simple;
	bh=5/m2fXEcKTwq4VE2M3CiECuFwRYgiwJCNHqcIKe3YtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkg3duymDWHdTrkRvk5ereG/xqAzulvU6x6W8KcQq4Y5jR7ORlX1xPRhEZrmbRiUDZw24GqQUp58YD3dfw2EpzY208v7j2CXYFFVXU8NsR3IjucylkUraJov2cCJsA50zxFkKRujJ44smLPQeQEuyp8wk52kjWoSrW9wqKyNxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4855003fa6cso1621999b6e.3
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779639145; x=1780243945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a2y50PnAa7g4k/kKUP511R8FfNJbjHYAN7KunxmODts=;
        b=Sg8+8KE/DrRouOUUpJ+6vDCuTo5KRsP+KST4/yv/V6XSC1KN/cK50Kmq2K6zGH7ivw
         Kgnx+eYuzmSL6hbSh4vlrHhPHVWjyzHTeZ4eiJi2DrLsUG2Z0cnUwEPYGD+rfFDngtqy
         ZYbcPC+DbB/gh4VqB/6sx1bvCs5gYGhTAgAfZIvVwLF9SYGRFVs/em4qx8SOPRgSIk0F
         p2Iw5DG6Mo1M8qbKs/O4x/F3MDU/+m8CBItmxhCiIZRx09957c9rFiyBLZfYa4befqLS
         ecJCjGp3pzq2prrTHpZwN4N9pUhCNt+6qFsNpxTOiXtWEOdnwJIUcMJuMo+a+FAsiUrO
         HZKw==
X-Gm-Message-State: AOJu0YzYpRnfktr6a9m0oT8qwTsJO/oh81JuEAEWjfec5IUio5SI+zUv
	6ItUECuY4RNWlq4a4aivVJLPFOXvmzs7mMPYCVM9rGhJp81b94vvFzrKv+ib0A77
X-Gm-Gg: Acq92OHWjdBvvbSqUPXxHx3sWlbQ8RFr0rKUADusI1ZiToI2RpWm+9alqmJXVwMpBI1
	2tpVluNOFXThpUgcFArcI6rSpsComjnZhMMmRlQvJt5XjqIyN0RuqaHX2wU5Pwnn3GiWfRrLsj9
	q6gxKAx6upHRShAtMcsMVxL+1TtZCfuAAsyClOOnALqGn+doO5DCqkdd8RF/N62tJgV8s9j0Tlf
	ewQj5zxhSxXSvyNWUdy2dUHiniru8zAz9XjkoG7ZRv7mAj1pqaAnJbixPbMETzlxeGxXKktP1BK
	KAJRIFYkj5sJ6SrBIdHvCuSNQa0vcThSR0dRNS56ssNPuBMuZPf1gTh7iKxzNvjWm8GdhPJ1gOs
	g9lsAyjpeyDg46Saz1Cx3bJ6w82r9Jauy35VCtyMjAXt76VWjPJ4NtKd5/cjhgURomW6uDcLN4y
	4lVM+SY1JBKIP2oA==
X-Received: by 2002:a05:6808:c1ae:b0:479:d16e:9619 with SMTP id 5614622812f47-4854a27111emr6939423b6e.43.1779639144986;
        Sun, 24 May 2026 09:12:24 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554041ccasm3466118b6e.0.2026.05.24.09.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 09:12:24 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 09:12:18 -0700
Subject: [PATCH 2/9] netconsole: take over skb pool lifecycle from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-netconsole_move_more-v1-2-909d1ab398b4@debian.org>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
In-Reply-To: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=7752; i=leitao@debian.org;
 h=from:subject:message-id; bh=5/m2fXEcKTwq4VE2M3CiECuFwRYgiwJCNHqcIKe3YtI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEyNl49Q26LAEvxIZTEXRoIXWm3bJsHNlyyewR
 L0NbFgoc0eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMjZQAKCRA1o5Of/Hh3
 bRG2D/946bEbT2U/pu14FaNnejmEZ3OBAIEv7PLH7oMhI8B7JQNPvA+LSRiWZupSYcOwaLg3/L+
 1+OocNFout0KUstLIZZgDJA+CxHVSh2iVTosTpbxmvCIp/+EDfPbgRoHm/FNSybOXatp+mU/vLT
 EJSkvP+SCEseosxWtevl+0X/qg+SlbWdQ5qLp1lfxMiUgQkjlx3rh8hXOBOjHZq7qRePicOFAPw
 xBzFfgRVUP+pphDVL0QTAwNJ8Zer4WZ81HJpMUaCHxEEw5qSIN3emPw6ChO4gcg8dEIDqu3i+5g
 YrPCH1FoxPsFRZ6xVd14+RWAvty83720j3H+QFcfsr2bc7qiezmCejAd0Fy6QozTvhY/LpuNO9o
 okrkJFJvOb2pwoGq/beGJWwYCVxMecsPFkYkk+qU2UwFNbACYBsnKCIRr309A5K/x+O5YY0GvWI
 bE2OrR293iEmvCn2AiSce+QtrQPstnhqno5VWeKvk5dL4sZgG8IJqGG7Qpjmzwc7hPsJ729YH0b
 6snQq8UDkq/Z6hxyPWu4XRPwaQlJ6JNPqThwYeeVbeQCQnwU6j7bx5XAoH6tn47h9u4zMdTQ8uK
 RQDkgM3//8wNfUtMQGDimdrp7VCa0GDOa8S2xq2trVoPF2DpTlcm7OIUCiZF5fXv6rhhe00zhVV
 Q8UJfz+T37scK5g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291204-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.776];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7EBD95C30E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fallback skb pool fronted by find_skb() is netconsole's only
client: every other netpoll consumer (bonding, team, vlan, bridge,
macvlan, dsa) goes through __netpoll_setup() / netpoll_send_skb()
without ever touching np->skb_pool. Today __netpoll_setup() and
__netpoll_cleanup() create and destroy the pool for everyone, paying
~48 KB of pre-allocated skbs per netpoll instance that almost
nobody uses.

Move the responsibility to netconsole. Add netconsole-side
netconsole_skb_pool_{init,flush}() wrappers that call the (now
exported) refill_skbs(), refill_skbs_work_handler() and
skb_pool_flush() helpers, and wire them at the same three netpoll
setup paths (resume_target, enabled_store, alloc_param_target) and
matching teardowns (netconsole_process_cleanups_core,
drop_netconsole_target, free_param_target).

Init runs *before* netpoll_setup(), and the failure path flushes
before returning. netpoll_setup() makes nt->np.dev visible to
target_list walkers (notably netconsole_netdev_event); if a
NETDEV_UNREGISTER / NETDEV_RELEASE / NETDEV_JOIN raced and moved
the target to target_cleanup_list before init had run,
netconsole_process_cleanups_core() would call
netconsole_skb_pool_flush() on an uninitialised refill_wq /
skb_pool, splatting WARN_ON(!work->func) in flush_work() and
acquiring an uninitialised spinlock in skb_queue_purge_reason().
Doing init first preserves the pre-series invariant that the pool
is valid whenever nt->np.dev is observable.

Drop the corresponding init/flush from __netpoll_setup(),
__netpoll_cleanup() and the netpoll_setup() error path; the now
empty 'flush' label is also removed. The fields and helpers stay
in struct netpoll for now; subsequent patches relocate the helper
functions and then the fields themselves.

For non-netconsole consumers, np->skb_pool / np->refill_wq are
never initialised, never refilled and never flushed by netpoll
itself, but they are also never read by anyone, so the change is a
no-op for them.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++--
 net/core/netpoll.c       | 12 +-----------
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d804d44af87c..b84de3ba44c3 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -283,11 +283,35 @@ static bool bound_by_mac(struct netconsole_target *nt)
 	return is_valid_ether_addr(nt->np.dev_mac);
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
@@ -389,6 +413,7 @@ static void netconsole_process_cleanups_core(void)
 	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list) {
 		/* all entries in the cleanup_list needs to be disabled */
 		WARN_ON_ONCE(nt->state == STATE_ENABLED);
+		netconsole_skb_pool_flush(nt);
 		do_netpoll_cleanup(&nt->np);
 		if (bound_by_mac(nt))
 			memset(&nt->np.dev_name, 0, IFNAMSIZ);
@@ -732,9 +757,19 @@ static ssize_t enabled_store(struct config_item *item,
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
@@ -1474,8 +1509,10 @@ static void drop_netconsole_target(struct config_group *group,
 	 * The target may have never been enabled, or was manually disabled
 	 * before being removed so netpoll may have already been cleaned up.
 	 */
-	if (nt->state == STATE_ENABLED)
+	if (nt->state == STATE_ENABLED) {
+		netconsole_skb_pool_flush(nt);
 		netpoll_cleanup(&nt->np);
+	}
 
 	config_item_put(&nt->group.cg_item);
 }
@@ -2257,10 +2294,18 @@ static struct netconsole_target *alloc_param_target(char *target_config,
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
@@ -2282,6 +2327,8 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 static void free_param_target(struct netconsole_target *nt)
 {
 	cancel_work_sync(&nt->resume_wq);
+	if (nt->state == STATE_ENABLED)
+		netconsole_skb_pool_flush(nt);
 	netpoll_cleanup(&nt->np);
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	kfree(nt->userdata);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 84cbfa85028a..a4d176ff9376 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -382,9 +382,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	const struct net_device_ops *ops;
 	int err;
 
-	skb_queue_head_init(&np->skb_pool);
-	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
-
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
 		       ndev->name);
@@ -419,9 +416,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	np->dev = ndev;
 	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 
-	/* fill up the skb queue */
-	refill_skbs(np);
-
 	/* last thing to do is link it to the net device structure */
 	rcu_assign_pointer(ndev->npinfo, npinfo);
 
@@ -611,7 +605,7 @@ int netpoll_setup(struct netpoll *np)
 
 	err = __netpoll_setup(np, ndev);
 	if (err)
-		goto flush;
+		goto put;
 	rtnl_unlock();
 
 	/* Make sure all NAPI polls which started before dev->npinfo
@@ -622,8 +616,6 @@ int netpoll_setup(struct netpoll *np)
 
 	return 0;
 
-flush:
-	skb_pool_flush(np);
 put:
 	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (ip_overwritten)
@@ -674,8 +666,6 @@ static void __netpoll_cleanup(struct netpoll *np)
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	}
-
-	skb_pool_flush(np);
 }
 
 void __netpoll_free(struct netpoll *np)

-- 
2.54.0


