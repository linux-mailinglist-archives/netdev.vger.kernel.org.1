Return-Path: <netdev+bounces-292188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOOJAmmuFmojogcAu9opvQ
	(envelope-from <netdev+bounces-292188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:42:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349175E13ED
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA4D3029253
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3BC3DFC6A;
	Wed, 27 May 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="h/SkTlcn"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745F3C81A3
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871333; cv=none; b=oHrNbbfREK+uwPFclMh3Q5f5G9lgybjcYezqK2F3r+1UaUaakPDUKvvPqQItkRb+TcwT6URB3Nl728cH0PcOCvLhj6o1FB70O5Dh5/aztVfNdrs/ducqSwvBztGHpeCIujXx0Qx+FUEEEhkMYt3c31R6NkhtgoaXIeZ6MvdMB20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871333; c=relaxed/simple;
	bh=9dhDMfEROxTjZNrBlGNCsh+iKL0HiWJECPUSQMm8kf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bW/eAJ3n+c7ZIcBPoHQRkZphAWKpMI76VT4HLaBI0DaAISzIVxx8IA9spNY+ukMkc7VoUDtLoleUSfudRzDGNBz1Ub8sF2T1w3LiPGBROOCuXmCsx51CltcaJJ34RuDUFRsNFVaWMy9euRm6efWQvJ+xbBeD4wRCEupM5BFiiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=h/SkTlcn; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 18815205F0;
	Wed, 27 May 2026 10:42:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nqx05LiqWKCK; Wed, 27 May 2026 10:42:03 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 53E6E20520;
	Wed, 27 May 2026 10:42:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 53E6E20520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779871323;
	bh=RY+ndBRW5bRN4I0j9i4rqRaM+kzkpQoVjhrjBLX+osE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=h/SkTlcneBOdJ6pykKLTzEi30NB4HvDcTS1yQ9qMaV0oQf8KMU5jb1voBudCTaSIL
	 Eu0sTp25VHvbJCdJfMg8/axeuHf6SNMCoGlagwBJb1Qu1VMErdUMHnHZtX6klrfUKo
	 BqWLGNUrFnzjl/+qss9Rj1QmpWbF+Sr3pCOMe31G86kn0DJrou1aVg3PfO0VrMaYZU
	 Cko6JFdbQRb2W3c03WpA2uzwCuwhQLihE+5kOYfiScd4+g+RUG7m4ud9lsKckF3/F3
	 Mza5A2Dh+XTcKmn0UQ4ah7SnzTRqmIqKFnMaMOLcJ9ww5UuQlzgEdDcGKIOxPLB0wG
	 TQ/SWFGOj5iUw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 10:42:02 +0200
Received: (nullmailer pid 3494009 invoked by uid 1000);
	Wed, 27 May 2026 08:42:01 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 8/9] xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit
Date: Wed, 27 May 2026 10:41:26 +0200
Message-ID: <20260527084148.3489759-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527084148.3489759-1-steffen.klassert@secunet.com>
References: <20260527084148.3489759-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-292188-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,secunet.com:email,secunet.com:mid,secunet.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 349175E13ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Usama Arif <usama.arif@linux.dev>

The struct pernet_operations docstring in include/net/net_namespace.h
explicitly warns against blocking RCU primitives in .exit handlers:

    Exit methods using blocking RCU primitives, such as
    synchronize_rcu(), should be implemented via exit_batch.
    [...]
    Please, avoid synchronize_rcu() at all, where it's possible.

    Note that a combination of pre_exit() and exit() can
    be used, since a synchronize_rcu() is guaranteed between
    the calls.

xfrm_policy_fini() violates this: it calls synchronize_rcu() before
freeing the policy_bydst hash tables (so no RCU reader is mid-
traversal at free time), but runs from xfrm_net_ops.exit -- once per
namespace -- so a cleanup_net() of N namespaces pays N full RCU
grace periods serially.

Use the documented pre_exit/exit split. Move the policy flush (and
the workqueue drains it depends on) into a new .pre_exit handler;
xfrm_policy_fini() then runs in .exit and frees the hash tables
after the synchronize_rcu_expedited() that cleanup_net() guarantees
between the two phases. Providing O(1) RCU grace periods per batch
instead of O(N).

Observed on Linux 6.18 with a workload doing unshare(CLONE_NEWNET)
at ~13/sec sustained: cleanup_net() and the netns_wq rescuer kthread
both stuck in xfrm_policy_fini()'s synchronize_rcu(), >300k struct
net accumulated in the cleanup queue, Percpu in /proc/meminfo climbed
to 130+ GB on 256-CPU hosts, and memcg OOMs followed. setup_net and
__put_net counts were balanced, ruling out a refcount leak.

Fixes: 069daad4f2ae ("xfrm: Wait for RCU readers during policy netns exit")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 59968dcbafe1..dd09d2063da2 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4276,21 +4276,21 @@ static int __net_init xfrm_policy_init(struct net *net)
 	return -ENOMEM;
 }
 
-static void xfrm_policy_fini(struct net *net)
+static void __net_exit xfrm_net_pre_exit(struct net *net)
 {
-	struct xfrm_pol_inexact_bin *b, *t;
-	unsigned int sz;
-	int dir;
-
 	disable_work_sync(&net->xfrm.policy_hthresh.work);
-
 	flush_work(&net->xfrm.policy_hash_work);
 #ifdef CONFIG_XFRM_SUB_POLICY
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_SUB, false);
 #endif
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_MAIN, false);
+}
 
-	synchronize_rcu();
+static void xfrm_policy_fini(struct net *net)
+{
+	struct xfrm_pol_inexact_bin *b, *t;
+	unsigned int sz;
+	int dir;
 
 	WARN_ON(!list_empty(&net->xfrm.policy_all));
 
@@ -4368,6 +4368,7 @@ static void __net_exit xfrm_net_exit(struct net *net)
 
 static struct pernet_operations __net_initdata xfrm_net_ops = {
 	.init = xfrm_net_init,
+	.pre_exit = xfrm_net_pre_exit,
 	.exit = xfrm_net_exit,
 };
 
-- 
2.43.0


