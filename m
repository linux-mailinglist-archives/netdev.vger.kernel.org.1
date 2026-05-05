Return-Path: <netdev+bounces-284404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHVeMcXv+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:25:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736514CE6DD
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8810B3022BBE
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF55478E42;
	Tue,  5 May 2026 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BXgEBxws"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1633343C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987424; cv=none; b=IWxqRp/qrFm9UAkJRl4LS/ybchFnlnpP4mp6HTBDzoBEP2+1Fyl8jp8eLN3AeISXKuDoajetY4CirCDchrBXHJ0Jb+B2uvO/KT+LxpAtv6Abtn5lsW28u/XoMKhduujJ8zvaWBm/8tPH+mIOzMaaZ6ewzRDdWxN/s+79tzhuwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987424; c=relaxed/simple;
	bh=bshQs1T4vcWynZkH4cc0udK8pzmlWOJz6aH5XGBW1uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBeq0BKaUyuZONmls6lkw9vA4oR2/6VHwS98YhuLjjbFJomM7f1SRdn/CfnwK2VtIWwVpZ9/wthFoyMqSRIlGygYbZi8Yo9jMIlz6WNdmUo604uJdQ5g6DCALHGrms5D4nfOtXv7paS1VtRgaPk5HvRwcX7UIsofTq1TDMLFvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BXgEBxws; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A3B7D20743;
	Tue,  5 May 2026 15:23:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wgI6DfUDxWKj; Tue,  5 May 2026 15:23:34 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E6D65206E9;
	Tue,  5 May 2026 15:23:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E6D65206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777987413;
	bh=pUHY7aOXlt1mS76NWVKlJpNjKRUiEZtLk1hf7BrsxiU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BXgEBxws6Lf7i6VW7kAih+A1ZDhD7jD2D6xHBRy9CTzNSoDLeuGBkWy7WYk3nmGYe
	 HD/0WwEEd/2egjdR2f3x0tfuN/hE1eu2m87XtdYsVZwE/ESqxRQ3hosNllcJZgr0tb
	 tG1T8RJD/RXgELiRKXktL0JsbOZccf6iRoxVGdg8TfVRwEAsb7Rv39HkE9Wz9wU0N1
	 fG3NtdZoIvcoFprIvAihKxnkad9rSYFrdLbnxk7qmE1fLuyhmxPifRITlg7YXGH6q7
	 uGlUMdebFPVtVOoCkeF0FKPoesI3dq4+91LASvCiJXW8ZcOFfkIRyeD6hJj+GwfXYh
	 mnDE0f+j89KKg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 15:23:33 +0200
Received: (nullmailer pid 1364098 invoked by uid 1000);
	Tue, 05 May 2026 13:23:30 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 7/8] xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete
Date: Tue, 5 May 2026 15:23:03 +0200
Message-ID: <20260505132326.1362733-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505132326.1362733-1-steffen.klassert@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 736514CE6DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-284404-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,secunet.com:email,secunet.com:dkim,secunet.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Michal Kosiorek <mkosiorek121@gmail.com>

KASAN reproduces a slab-use-after-free in __xfrm_state_delete()'s
hlist_del_rcu calls under syzkaller load on linux-6.12.y stable
(reproduced on 6.12.47, also reachable via the same code path on
torvalds/master and on the ipsec tree). Nine unique signatures cluster
in the xfrm_state lifecycle, the load-bearing one being:

  BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:990 [inline]
  BUG: KASAN: slab-use-after-free in hlist_del_rcu include/linux/rculist.h:516 [inline]
  BUG: KASAN: slab-use-after-free in __xfrm_state_delete net/xfrm/xfrm_state.c
  Write of size 8 at addr ffff8881198bcb70 by task kworker/u8:9/435

  Workqueue: netns cleanup_net
  Call Trace:
   __hlist_del / hlist_del_rcu
   __xfrm_state_delete
   xfrm_state_delete
   xfrm_state_flush
   xfrm_state_fini
   ops_exit_list
   cleanup_net

The other observed signatures hit the same slab object from
__xfrm_state_lookup, xfrm_alloc_spi, __xfrm_state_insert and an OOB
write variant of __xfrm_state_delete, all on the byseq/byspi
hash chains.

__xfrm_state_delete() guards its byseq and byspi unhashes with
value-based predicates:

	if (x->km.seq)
		hlist_del_rcu(&x->byseq);
	if (x->id.spi)
		hlist_del_rcu(&x->byspi);

while everywhere else in the file (e.g. state_cache, state_cache_input)
the safer hlist_unhashed() check is used. xfrm_alloc_spi() sets
x->id.spi = newspi inside xfrm_state_lock and then immediately inserts
into byspi, but a path that observes x->id.spi != 0 outside of
xfrm_state_lock can still skip-or-hit the byspi unhash inconsistently
with whether x is actually on the list. The same holds for x->km.seq
versus byseq, and the bydst/bysrc unhashes have no predicate at all,
so a second __xfrm_state_delete() on the same object writes through
LIST_POISON pprev.

The defensive change here:

  - Use hlist_del_init_rcu() instead of hlist_del_rcu() on bydst,
    bysrc, byseq and byspi so a second deletion is a no-op rather
    than a write through LIST_POISON pprev. The byseq/byspi nodes
    are already initialised in xfrm_state_alloc().
  - Test hlist_unhashed() rather than the value predicate for
    byseq/byspi, so the unhash decision tracks list state rather than
    mutable scalar fields.

Empirical verification: applied this patch on top of v6.12.47, rebuilt,
and re-ran the same syzkaller harness for 1h16m on a previously-crashy
configuration that produced ~100 hits each of slab-use-after-free
Read in xfrm_alloc_spi / Read in __xfrm_state_lookup / Write in
__xfrm_state_delete. After the patch, 7.1M execs across 32 VMs at
~1550 exec/sec produced zero xfrm_state UAF/OOB hits. /proc/slabinfo
confirms the xfrm_state slab is actively allocated and freed during
the run (~143 KiB resident), so the fuzzer is still exercising those
code paths -- they just no longer crash.

Reproduction:

  - Linux 6.12.47 x86_64 + KASAN_GENERIC + KASAN_INLINE + KCOV
  - syzkaller @ 746545b8b1e4c3a128db8652b340d3df90ce61db
  - 32 QEMU/KVM VMs x 2 vCPU on AWS c5.metal bare metal
  - 9 unique signatures collected in ~9h, all within xfrm_state
    lifecycle

Fixes: fe9f1d8779cb ("xfrm: add state hashtable keyed by seq")
Fixes: 7b4dc3600e48 ("[XFRM]: Do not add a state whose SPI is zero to the SPI hash.")
Reported-by: Michal Kosiorek <mkosiorek121@gmail.com>
Tested-by: Michal Kosiorek <mkosiorek121@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michal Kosiorek <mkosiorek121@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374abca..686014d39429 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -818,17 +818,17 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		list_del(&x->km.all);
-		hlist_del_rcu(&x->bydst);
-		hlist_del_rcu(&x->bysrc);
-		if (x->km.seq)
-			hlist_del_rcu(&x->byseq);
+		hlist_del_init_rcu(&x->bydst);
+		hlist_del_init_rcu(&x->bysrc);
+		if (!hlist_unhashed(&x->byseq))
+			hlist_del_init_rcu(&x->byseq);
 		if (!hlist_unhashed(&x->state_cache))
 			hlist_del_rcu(&x->state_cache);
 		if (!hlist_unhashed(&x->state_cache_input))
 			hlist_del_rcu(&x->state_cache_input);
 
-		if (x->id.spi)
-			hlist_del_rcu(&x->byspi);
+		if (!hlist_unhashed(&x->byspi))
+			hlist_del_init_rcu(&x->byspi);
 		net->xfrm.state_num--;
 		xfrm_nat_keepalive_state_updated(x);
 		spin_unlock(&net->xfrm.xfrm_state_lock);
-- 
2.43.0


