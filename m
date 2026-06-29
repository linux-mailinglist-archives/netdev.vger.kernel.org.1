Return-Path: <netdev+bounces-302766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HOw+JMe1QmopAAoAu9opvQ
	(envelope-from <netdev+bounces-302766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF6F6DDF18
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:13:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=bLjQTIIC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302766-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302766-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC431304045F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8133803E8;
	Mon, 29 Jun 2026 18:12:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1DD3803D7
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756754; cv=none; b=WyzF6Jfl1CYzNrYxEFRR26mIKOy1FDb8SwV8wilEzRDhlfe49tw0AWGCxZU2hux78JgblXfaZO/nIVUgTU3Idfp+NVHJgXuB5QtwbRhwYS//qViBzmLFtBpFuVSQUc2Qm02L9d9sj+wQC9kRUEMNJY+/crla1+0H0OForU9fICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756754; c=relaxed/simple;
	bh=b2p74CR7pczfhrBQGObICUGP3KrtQ9sYd7Tr4V1yOu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cfgSFOTAYnOE2j/Ryk/zFr7//YCXnEsLD7i5hmz5vbeYxdEVAfbvy5rBZgL8rtg9Y4GYyqpk+BJQpmnENAEzq9vyLz6Zrn94YX7Bl8Vo3x2Nv35CvG1oUNxLwq3oPOHDWRjL+dTHhjiObmUcDX3IleGMN4TFQUXTIffH0VTx6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLjQTIIC; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845c605617dso2895006b3a.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756752; x=1783361552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RG6U2cYi1fsF14Gow/zEswwtuv3YZZrPJjXb+Z/vrCY=;
        b=bLjQTIICEePgJ84XvqlnDJKoYZd9Oo49/KUm/JxE3s39EXNPSVcssUfTQ/Auw9UO9w
         wxD4pjsNpxFNd6xL6JQTVRG+LMqMzMe/EIM7NoiB6I+K2kW3uQMO2KSE3RsvjUzzzFnZ
         c5ssnCZUzg+/Of1isZsKw1zCwoInCeS8WQlMm+P6PKDNK7kSLI1vGhEUXAFfof8WdAFa
         heA2BfDXfVrFCjZbO49Rhie9e1GvFbhXzInAeqO1kU66mUYq+42W88uZZMuIlr0mB+x7
         C1YbMPF9NhwAdyP1QuWjq/2Y6PEGc582DrF3MaZLHB9d0sopADEZAa7ELKOYpylGjQZ8
         awrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756752; x=1783361552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RG6U2cYi1fsF14Gow/zEswwtuv3YZZrPJjXb+Z/vrCY=;
        b=FssA63gA/0Z2xL1lHcHBhrUR8RKC1/uFUGaTqGYTJ+xvv6TGpaYcWuLrOjQlfb1ENT
         PviIwglwXBvRZZ5x9Q0YbTKWOVH0xbtMlAqN9qQDtw49PnPXszwQa4sCMQEydlRHQ1oo
         +H9uS4JYf8Bjowne01n/IkKi3s84OvKo0HnS5JutM/FRpFKSCIxEu1vO+aaiKYzc1p4S
         rAGDdksNtWyRVWpVH6Fa8VRUORBsB1ZnSsHWR85iEPfvF1jkNDUo/z4FIvkwXQSUggHu
         ybgmONKD09zC791C0s01+6H2QHkFrm4JMEc52oB1xPVQuEQhv+1AH3XurYzzpcNdP/QM
         3j0A==
X-Forwarded-Encrypted: i=1; AFNElJ+Sr7Rmyc3BzN+G3Oj6vgGxqAgp08GKKgs6Em9sdmFuiLLzqQMnTV1nFCreqlOUGEG1blEhxvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOA/IiCiNFKfOSln7V6nAyKpwUibvlvCPe2g0YvmlAyQweIyT8
	sxM/hVXXFxUQDCajuAkIu9YbdROOyxw8JvuOnTmeaiB0dimh895z/8LA9VJG3k10Xg9NwmYnNqR
	DTKniPg==
X-Received: from pgap127.prod.google.com ([2002:a63:4285:0:b0:c98:1a89:bad5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4c03:b0:3bf:bde7:d671
 with SMTP id adf61e73a8af0-3bfc50a7f6amr512864637.20.1782756752125; Mon, 29
 Jun 2026 11:12:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:10:55 +0000
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/10] ipv4: fib: Protect fib_new_table() with spinlock.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302766-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCF6F6DDF18

fib_newrule() will drop RTNL except for the first IPv4 rule.

Then, fib4_rule_configure() could call fib_empty_table() and create
a new IPv4 fib_table without RTNL.

Currently, net->ipv4.fib_table_hash[] is only protected by RTNL.

As a prep, let's protect net->ipv4.fib_table_hash[] with a dedicated
spinlock.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/ipv4.h |  1 +
 net/ipv4/fib_frontend.c  | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 6e27c56514df..59506320558a 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -127,6 +127,7 @@ struct netns_ipv4 {
 	atomic_t		fib_num_tclassid_users;
 #endif
 	struct hlist_head	*fib_table_hash;
+	spinlock_t		fib_table_hash_lock;
 	struct sock		*fibnl;
 	struct hlist_head	*fib_info_hash;
 	unsigned int		fib_info_hash_bits;
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 42212970d735..336d70649eb9 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -76,7 +76,7 @@ static int __net_init fib4_rules_init(struct net *net)
 
 struct fib_table *fib_new_table(struct net *net, u32 id)
 {
-	struct fib_table *tb, *alias = NULL;
+	struct fib_table *tb, *new_tb, *alias = NULL;
 	unsigned int h;
 
 	if (id == 0)
@@ -85,14 +85,27 @@ struct fib_table *fib_new_table(struct net *net, u32 id)
 	if (tb)
 		return tb;
 
+	if (!check_net(net))
+		return NULL;
+
 	if (id == RT_TABLE_LOCAL && !net->ipv4.fib_has_custom_rules)
 		alias = fib_new_table(net, RT_TABLE_MAIN);
 
-	if (check_net(net))
-		tb = fib_trie_table(id, alias);
-	if (!tb)
+	new_tb = fib_trie_table(id, alias);
+	if (!new_tb)
 		return NULL;
 
+	spin_lock(&net->ipv4.fib_table_hash_lock);
+
+	tb = fib_get_table(net, id);
+	if (tb) {
+		spin_unlock(&net->ipv4.fib_table_hash_lock);
+		fib_free_table(new_tb);
+		return tb;
+	}
+
+	tb = new_tb;
+
 	switch (id) {
 	case RT_TABLE_MAIN:
 		rcu_assign_pointer(net->ipv4.fib_main, tb);
@@ -106,6 +119,9 @@ struct fib_table *fib_new_table(struct net *net, u32 id)
 
 	h = id & (FIB_TABLE_HASHSZ - 1);
 	hlist_add_head_rcu(&tb->tb_hlist, &net->ipv4.fib_table_hash[h]);
+
+	spin_unlock(&net->ipv4.fib_table_hash_lock);
+
 	return tb;
 }
 EXPORT_SYMBOL_GPL(fib_new_table);
@@ -1565,6 +1581,7 @@ static int __net_init ip_fib_net_init(struct net *net)
 	net->ipv4.sysctl_fib_multipath_hash_fields =
 		FIB_MULTIPATH_HASH_FIELD_DEFAULT_MASK;
 #endif
+	spin_lock_init(&net->ipv4.fib_table_hash_lock);
 
 	/* Avoid false sharing : Use at least a full cache line */
 	size = max_t(size_t, size, L1_CACHE_BYTES);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


