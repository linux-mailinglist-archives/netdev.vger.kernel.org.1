Return-Path: <netdev+bounces-164204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EC0A2CEAE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 22:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F1E3AB4F3
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6228119CC0C;
	Fri,  7 Feb 2025 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GfjTnA6S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKIg0Pji"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3C195FE5
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962173; cv=none; b=iAIRP8hELTSPw8jw1mZAFQn3fNIHi002Wk6bVXVaWLUwS3Oxk+CM9vPCRzTPeyFKgYs8cneWHLZu6gXuzb10J2ltWgpWOOMwGr+e+Ph+5fJv20nBReBc/0pnBgcJZm0YGEU1Eszn9HBPqu/mMmsDOwuJG4TUGztU7wvlWYor7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962173; c=relaxed/simple;
	bh=GyIuDUCTfnK5crOfHqPiKPskoEXJZSx8KLSdOl+CzEE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d+oxfj2Ww2bqgtDlwKu26aNmtFuyn1h7cA4Tcfx1QAJ+xsCPmuVMyiKYaKIE3zwXfyOUjPeLv6P7VxdCg0n6VQkFLHwJvFJyAQWpRvGpWoa+0S3eLvD/GlONRrKgGEfYaKc6UyVhLkt9uatg4Xrhf38KNZ8HSoO8Kn1gBLNmyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GfjTnA6S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKIg0Pji; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Feb 2025 22:02:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738962169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yhN9r2CaCp1jXj4DmGNvzG0PyWhJIAbJ9XhfQFAOHL4=;
	b=GfjTnA6SX1HyObAy4XjiAK8DnXNqLfAooG3LjDutYMkwOsbPOHnWVvo7ZYPR1JiwCIdXkW
	hpUggRFCr8m+ZTlURNuTHziRAbfE8ANbbHxOhfNfNW21v4MA0aFFFu2T4OUcH8SejnYp8e
	5u4w9T/vj4mRD1bpr2JzQhTMdltfw9jgoo7XNK29YdIUjkibymLytgGwpcAaP8fF9V/jzb
	LumdMdX52BlFX0NmGpMjYLdkWvwWPtqO7gzQUIWQBbCRE3VkCwDW0i66G5w0ieh7rQ0m0B
	NxwPk9YnNgLpG9Oh5CKJXuDq3v30tf4lLIK5JxNy3AM/jf3oNL0kGqQ45Uvb/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738962169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yhN9r2CaCp1jXj4DmGNvzG0PyWhJIAbJ9XhfQFAOHL4=;
	b=vKIg0PjiQPzbgqb0+KeHmhVgxOWFOJ37FCv8uuZoyqpayZs0upjvsawlFiHgzZ44Eo4VJR
	haaqbGsRkYL630Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH net-next] xfrm: Use rcuref_t for xfrm_state' reference
 counting.
Message-ID: <20250207210248.qy4i5Wkl@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

xfrm_state::ref is used for reference counting of xfrm_state itself. The
structure already follows RCU rules for its lifetime.

Using rcuref_t instead of refcount_t has the advantage that
refcount_inc_not_zero() can be replaced with a regular rcuref_get()
which does not suffer from a cmpxchg() loop. The cmpxchg() loop might be
repeated several times if there are puts or gets in parallel.

Replace xfrm_state's reference counting with rcuref_t. The
__xfrm_state_put() and xfrm_state_hold() which should always succeed
have a warning in case they don't succeed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/net/xfrm.h    | 12 ++++++------
 net/xfrm/xfrm_state.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index ed4b83696c77f..3da13b8a5afda 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -14,7 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/audit.h>
 #include <linux/slab.h>
-#include <linux/refcount.h>
+#include <linux/rcuref.h>
 #include <linux/sockptr.h>
 
 #include <net/sock.h>
@@ -189,7 +189,7 @@ struct xfrm_state {
 	struct hlist_node	state_cache;
 	struct hlist_node	state_cache_input;
 
-	refcount_t		refcnt;
+	rcuref_t		ref;
 	spinlock_t		lock;
 
 	u32			pcpu_num;
@@ -901,24 +901,24 @@ void __xfrm_state_destroy(struct xfrm_state *, bool);
 
 static inline void __xfrm_state_put(struct xfrm_state *x)
 {
-	refcount_dec(&x->refcnt);
+	WARN_ON(rcuref_put(&x->ref));
 }
 
 static inline void xfrm_state_put(struct xfrm_state *x)
 {
-	if (refcount_dec_and_test(&x->refcnt))
+	if (rcuref_put(&x->ref))
 		__xfrm_state_destroy(x, false);
 }
 
 static inline void xfrm_state_put_sync(struct xfrm_state *x)
 {
-	if (refcount_dec_and_test(&x->refcnt))
+	if (rcuref_put(&x->ref))
 		__xfrm_state_destroy(x, true);
 }
 
 static inline void xfrm_state_hold(struct xfrm_state *x)
 {
-	refcount_inc(&x->refcnt);
+	WARN_ON(!rcuref_get(&x->ref));
 }
 
 static inline bool addr_match(const void *token1, const void *token2,
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ad2202fa82f34..ded79ec53cbdd 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -55,7 +55,7 @@ static HLIST_HEAD(xfrm_state_dev_gc_list);
 
 static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
 {
-	return refcount_inc_not_zero(&x->refcnt);
+	return rcuref_get(&x->ref);
 }
 
 static inline unsigned int xfrm_dst_hash(struct net *net,
@@ -738,7 +738,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 
 	if (x) {
 		write_pnet(&x->xs_net, net);
-		refcount_set(&x->refcnt, 1);
+		rcuref_init(&x->ref, 1);
 		atomic_set(&x->tunnel_users, 0);
 		INIT_LIST_HEAD(&x->km.all);
 		INIT_HLIST_NODE(&x->state_cache);
-- 
2.47.2


