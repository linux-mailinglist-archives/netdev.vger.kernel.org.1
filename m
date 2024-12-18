Return-Path: <netdev+bounces-153051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059069F6ABA
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D031216DF7E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73CF1F2C52;
	Wed, 18 Dec 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z3Q4/1os";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GiiJrHUG"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318DC1F0E33
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538069; cv=none; b=AAo6J7ulbmXyHFpJSMDHDI1vqTPQQC7nJncT5TZliK0D39JzZvOiVjTabhFAJaUMc1KWa9hQcDRPAkrifyaylPv4zI/tt4PUNeWLne7+KqZTC1qWu1jqqY5S3+8hwdwNM0hlDfwE9ze+1P6j1iU05yXr1vUQxSpTXqYab2HSl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538069; c=relaxed/simple;
	bh=bIg68ejAndcBnYy/n4U4zDLW2MdbriWerUmcNUgM74I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2kSi/JlUg1eKurAvyO8iJ4d2BMw40QCSILoPqZDnK/EGuDt2Ok+l/fgR5Bnvv2PdM3PWUB8Qcffc1JFQAIOM075x5fVC44fVXX/TvdIrvt3GzcOta7MHzSqx3QNgFUovfotPwfBrWwJO1eFqJAJx4j0zw0beihpMv3W3xUqdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z3Q4/1os; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GiiJrHUG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 17:07:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734538066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjGrcdkcnKpsJYfXbIraumjNLvjLW6aohiB6ZRHf1W0=;
	b=z3Q4/1osNTQuIeSXg6jYGjqsG9/yy537IuEhuk8UImnK6g87H3omNMfrbbITzPhNC0jrE0
	QfUyuTKgzL1uwcYdXntd+Wjzc9rBTOSuK+KxSk2p2Oth5/KFxXhHj6Jrvl9N4ppuMMRiOM
	OG/Ob20i2wUmYRztL1YDBFkkETyqKuihco3B2c4URPYtkYNqtPnRL203PFCsaZcaNSSSAW
	SBJwa/iF1PsNz0+IYK76WsbK3bo/vwUdFyd6GSDsGkBwFoWPGvaELyGBtL9Glq2BwQhEYN
	yS4IarrDI9aWv8hJEiWDPgrDz4qEPD4DcsaMQaO1Cgf0hQIj80PeBAb9uUWIjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734538066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjGrcdkcnKpsJYfXbIraumjNLvjLW6aohiB6ZRHf1W0=;
	b=GiiJrHUGifphFjBtt1DgYydooh4erNvbXvtKyJ3YXNMt9g8uZSpdxWboaMeed5xzY8fkju
	wYe+m+EHO+u97xAw==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Network Development <netdev@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: xfrm in RT
Message-ID: <20241218160745.G1WJ-lWR@linutronix.de>
References: <CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com>
 <Z2KImhGE2TfpgG4E@gauss3.secunet.de>
 <20241218154426.E4hsgTfF@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218154426.E4hsgTfF@linutronix.de>

On 2024-12-18 16:44:27 [+0100], To Steffen Klassert wrote:
> time (your current get_cpu() -> put_cpu() span) you could do something
> like

While at, may I promote rcuref? This would get rid of your cmpxchg()
loop that you have otherwise in refcount_inc_not_zero(). In case you
have performance test:

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 32c09e85a64ce..eb152ebc0832c 100644
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
@@ -188,7 +188,7 @@ struct xfrm_state {
 	struct hlist_node	state_cache;
 	struct hlist_node	state_cache_input;
 
-	refcount_t		refcnt;
+	rcuref_t		ref;
 	spinlock_t		lock;
 
 	u32			pcpu_num;
@@ -857,24 +857,24 @@ void __xfrm_state_destroy(struct xfrm_state *, bool);
 
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
index 66b108a5b87d4..35ed7c35292a3 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -53,7 +53,7 @@ static HLIST_HEAD(xfrm_state_dev_gc_list);
 
 static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
 {
-	return refcount_inc_not_zero(&x->refcnt);
+	return rcuref_get(&x->ref);
 }
 
 static inline unsigned int xfrm_dst_hash(struct net *net,
@@ -662,7 +662,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 
 	if (x) {
 		write_pnet(&x->xs_net, net);
-		refcount_set(&x->refcnt, 1);
+		rcuref_init(&x->ref, 1);
 		atomic_set(&x->tunnel_users, 0);
 		INIT_LIST_HEAD(&x->km.all);
 		INIT_HLIST_NODE(&x->state_cache);

Sebastian

