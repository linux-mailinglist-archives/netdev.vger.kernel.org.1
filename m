Return-Path: <netdev+bounces-304304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OMJNGBL+Rmo/gQsAu9opvQ
	(envelope-from <netdev+bounces-304304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:10:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F36FD8DD
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:10:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=kK+PWMG0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304304-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304304-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D8BB304585D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F374145B27;
	Fri,  3 Jul 2026 00:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342640855
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037415; cv=none; b=lvWlhedqHoERFfxvRlhEuUYLtPgYr7Vr0+4T45Hl3TgP8hlTDnfFdVz7QtXRUwRvxH8cVYwIb0WaoSUuMpcETzRKoj25s3L4+iEBVDW2YF6vdUcZUjzaE6cWk8QKRRq54T0cJxgsU8GlTLtsagTcSYy8+IY8PTyyHuW5/vB21yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037415; c=relaxed/simple;
	bh=JxsE9m5REMf87+P1b3FwkitHXu9vKQ71LozXv0lBwno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XEspYXONvrGKBwl0Rx90xKAL14yrxdc1FrqJ76TrFZiFLvd+OKJ+fAsZIPQdSWTwIUYdGCH0MmJbwqHaBZDfM/tDhGQdM7VpyPdHNwdEqmMYcbjPlwaJ3VdoGsjJ2XNQm1KUI0QnFPE0vrfCCV6yRar5wF1TqH8GbCdkKG92QBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kK+PWMG0; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c825562f8bso36238075ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037414; x=1783642214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9EEFFRPjsAGZ/FBfdqh7kwb+gY00dfuyduPcYJ3gDw=;
        b=kK+PWMG0uhHyQM9JvdSlraSrnQ+sN0vUUy0wUkIPseSqV3B5wR81+AZSzKAK+KnG42
         wlqHt4ZUzNm9PClyN7jzGHe9rN52gzTJInEYJW3ldwmnR1Qj/TYDOvY3P9VoM/zIlMAM
         cDjYqkLEjgw0gO1nIauMQ4RKPw4Is2/lw02LsuATHGGyx+eTf0R5qckxbcUeKTaW7BS6
         b9wjK7yWjVvcP7fc90l+ygz0E5RWZveddGk3ITk5wsvmlaVnfjkS2s+cBPz8laRqVzNJ
         OBbEBdW3MXhe5oh7Z6093qS89sW6DYLYrlcX1JxiBRmaxOHexeUboUhXllr1tu0DBfXT
         mNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037414; x=1783642214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9EEFFRPjsAGZ/FBfdqh7kwb+gY00dfuyduPcYJ3gDw=;
        b=FEisCT1gRPM841PxX/9SkpvpwYq/ZmbDK+ujd8ohlt/Lso80EvoQNKLZtmCvahZ5hU
         gCsBj4xxsAjyQ2CArCatmOrBSl8gYqHmUEnIzJdi8U5UvPWxsPN+sM1+HDj3jGWAMQ15
         JuGaHHPhjULNsL1aRFVdd1WRumTvOyTMAfxQLMEW4YaHL8rI5jFI31XSLfqfP4RXAgqq
         HNGylpS0pKghe+qefKd0e7JaNb/+TyipLj4ybim3gXnGg3jTzKNn8MgvPzUOMMId4qLT
         /Q66gkV5n3/JryM/bVMxFrX0itFOZDZyI9t/FCFj66SLq6bk+/jCbOPIDDztU1+UyYf5
         xF6A==
X-Forwarded-Encrypted: i=1; AHgh+RpjhjsvnHF44gMLZ8KnF0MVpoE2S9L4YhXuzvJ2vo9z5B1jftvSu+2mNevOIUgfdC26j8mOH54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4na2TD0lijtPdoPtStjSXQUkW+m740gAvJxm3UPQm9nLUDW+
	DaUi3c/rTIfdZ8jxDiNk7cdct7A7AwsppY8/VtX7pit4bI8fgnkN0ahFD8L7+jl4tcIco0C9hq6
	5lM06xw==
X-Received: from plkp7.prod.google.com ([2002:a17:902:6b87:b0:2ca:be81:b451])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b4e:b0:2c9:97a7:3288
 with SMTP id d9443c01a7336-2ca7e888ce7mr90509295ad.42.1783037413683; Thu, 02
 Jul 2026 17:10:13 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:14 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 03/14] rtnetlink: Add per-netns rtnl_work.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304304-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C89F36FD8DD

The biggest blocker to per-netns RTNL is netdev unregistration.

It starts within a single netns (e.g., during a device lookup or
netns dismantle), but it can eventually involve multiple namespaces,
such as when upper ipvlan devices reside in different netns.

This prevents us from acquiring multiple rtnl_net_lock()s beforehand.

When we encounter such a cross-netns device, we must delegate the
unregistration to the work of the netns where the device actually
resides.

Let's add per-netns rtnl_work to support the deferred netdev
unregistration.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/rtnetlink.h   |  8 ++++++++
 include/net/net_namespace.h |  1 +
 net/core/net_namespace.c    |  1 +
 net/core/rtnetlink.c        | 26 ++++++++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index ea39dd23a197..95729339e7a5 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -115,6 +115,10 @@ bool rtnl_net_is_locked(struct net *net);
 
 bool lockdep_rtnl_net_is_held(struct net *net);
 
+void rtnl_net_queue_work(struct net *net);
+void rtnl_net_flush_workqueue(void);
+void rtnl_net_work_func(struct work_struct *work);
+
 #define rcu_dereference_rtnl_net(net, p)				\
 	rcu_dereference_check(p, lockdep_rtnl_net_is_held(net))
 #define rtnl_net_dereference(net, p)					\
@@ -150,6 +154,10 @@ static inline void ASSERT_RTNL_NET(struct net *net)
 	ASSERT_RTNL();
 }
 
+static inline void rtnl_net_flush_workqueue(void)
+{
+}
+
 #define rcu_dereference_rtnl_net(net, p)		\
 	rcu_dereference_rtnl(p)
 #define rtnl_net_dereference(net, p)			\
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 80de5e98a66d..a989019af5f7 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -197,6 +197,7 @@ struct net {
 #ifdef CONFIG_DEBUG_NET_SMALL_RTNL
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
+	struct work_struct	rtnl_work;
 #endif
 #if IS_ENABLED(CONFIG_VSOCKETS)
 	struct netns_vsock	vsock;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d9dafe24f57e..d1aeff9de580 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -422,6 +422,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 #ifdef CONFIG_DEBUG_NET_SMALL_RTNL
 	mutex_init(&net->rtnl_mutex);
 	lock_set_cmp_fn(&net->rtnl_mutex, rtnl_net_lock_cmp_fn, NULL);
+	INIT_WORK(&net->rtnl_work, rtnl_net_work_func);
 #endif
 
 	INIT_LIST_HEAD(&net->ptype_all);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7207da002fb5..7959519e7375 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -273,6 +273,26 @@ bool lockdep_rtnl_net_is_held(struct net *net)
 	return lockdep_rtnl_is_held() && lockdep_is_held(&net->rtnl_mutex);
 }
 EXPORT_SYMBOL(lockdep_rtnl_net_is_held);
+
+static struct workqueue_struct *rtnl_net_wq;
+
+void rtnl_net_queue_work(struct net *net)
+{
+	queue_work(rtnl_net_wq, &net->rtnl_work);
+}
+
+void rtnl_net_flush_workqueue(void)
+{
+	flush_workqueue(rtnl_net_wq);
+}
+
+void rtnl_net_work_func(struct work_struct *work)
+{
+	struct net *net = container_of(work, struct net, rtnl_work);
+
+	rtnl_net_lock(net);
+	rtnl_net_unlock(net);
+}
 #else
 static int rtnl_net_cmp_locks(const struct net *net_a, const struct net *net_b)
 {
@@ -7226,4 +7246,10 @@ void __init rtnetlink_init(void)
 	register_netdevice_notifier(&rtnetlink_dev_notifier);
 
 	rtnl_register_many(rtnetlink_rtnl_msg_handlers);
+
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	rtnl_net_wq = create_workqueue("rtnl_net");
+	if (!rtnl_net_wq)
+		panic("Could not create rtnl_net workq");
+#endif
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog


