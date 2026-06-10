Return-Path: <netdev+bounces-297854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PjyTEvjtKWoWfwMAu9opvQ
	(envelope-from <netdev+bounces-297854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 953CF66D4DA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:06:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Z9a4OiD+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297854-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297854-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41B3A31C3AED
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B465350A05;
	Wed, 10 Jun 2026 23:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6EA381AE2;
	Wed, 10 Jun 2026 23:04:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132662; cv=none; b=r9M6qW2Sh4oF4blMA6KKlHiXuKkRVgQ/M727Q/EfL+tpdoeF82gDa8qfIpdRL0QK9vygbTU3tfVJeJ6+ATMKicZEtf0l0M5Jh8yA+Y1HO1mpAa+ohd77Xa5Jk8alKWGIbkgCDG7Ob+jGsxtbBayxj0mbdNtpUck5wZd2i+b3bQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132662; c=relaxed/simple;
	bh=YMTGn3Jtq8t9a/GAlsJ7fAGE8GmUpxZi5v+8PMyag1I=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=beW6IkRiHSa+bJ4O76cS8L6I16qj4MKCXZSzBgleWoZRFyIhYRAduLJJzCJl6YHuXLMqmt6kT3qD1Zd2u2SMoXcFarH3F9hU+xJANhd0PcXuSKRp70BYjWuvVfTloV3bPu6rQP60nXt6NySSxaSiQjJvJf2hMdRi0zLnX/wOA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9a4OiD+; arc=none smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781132657; x=1812668657;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=YMTGn3Jtq8t9a/GAlsJ7fAGE8GmUpxZi5v+8PMyag1I=;
  b=Z9a4OiD+nGBiFM+awvTuoZNd/q1MjGs+V+j8oUi5B4ThK/5YaPnp2xkJ
   jcII1vTfRiTSApOqBNyUuzM1UU4ENc2gJIJOJRyj5mQE7xM7Qdp+PRX0f
   H2EmCKa3Sk5MfrlL40veEt1JwS7RQPmCrHzJhF3TvbWjJKe3pABVRzAI6
   3GOFP7Mrh0B5OLofUgnNoIjjlXdsBXrroPrbE/9YSdGIsYyqNVNtwgIuB
   T0HgkvU2GhKm9DPnaPzQFs78SZc8h0shcbaiYaR6TomLUFTZKI/sa97qM
   yglNbtbo5vLK0wd90Li/QTjXerwyNyva+LB2EeoqANCkNyZdu6HexWGx9
   A==;
X-CSE-ConnectionGUID: 5G1D77YpRt62zwisEzjR9g==
X-CSE-MsgGUID: T9DRgE4VSrGyFj/8MPQ0NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="104603458"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="104603458"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 16:04:17 -0700
X-CSE-ConnectionGUID: VAoVMoCGTiu0MuNDStwDkw==
X-CSE-MsgGUID: ve2wlplyQh68zV5YbqGBxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251409782"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa005.fm.intel.com with ESMTP; 10 Jun 2026 16:04:15 -0700
Subject: [PATCH v2 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arve Hjønnevåg <arve@android.com>, Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>, Vlastimil Babka <vbabka@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 10 Jun 2026 16:04:15 -0700
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
In-Reply-To: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
Message-Id: <20260610230415.C0521C88@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297854-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[dave.hansen@linux.intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:dave.hansen@linux.intel.com,m:aliceryhl@google.com,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:surenb@google.com,m:tkjos@android.com,m:vbabka@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 953CF66D4DA


From: Dave Hansen <dave.hansen@linux.intel.com>

== Background ==

There are basically two parallel ways to look up a VMA: the
traditional way, which is protected by mmap_lock, and the RCU-based
per-VMA lock way which is based on RCU and refcounts.

== Problem ==

The mmap_lock one is more straightforward to use but it has a big
disadvantage in that it can not be mixed with page faults since those
can take mmap_lock for read, which can deadlock when mixed with page
faults. For example:

	mmap_read_lock(mm);
	// Another thread does mmap_write_lock().
	// New mmap_lock readers are blocked.
	vma = vma_lookup(mm, address);
	// This deadlocks on mmap_read_lock() if it faults:
	copy_from_user(address);
	mmap_read_unlock(mm);

The RCU one can be mixed with faults, but it is not available in all
configs, so all RCU users need to be able to fall back to the
traditional way.

== Solution ==

Add a variant of the RCU-based lookup that waits for writers. This is
basically the same as the existing RCU-based lookup, but it also takes
mmap_lock for read and waits for writers to finish before returning
the VMA. This has some advantages:

 1. Callers do not need to have a fallback path for when they
    collide with writers.
 2. It can be used in contexts where page faults can happen because
    it can take the mmap_lock for read but never *holds* it.
 3. Its fast path does not require taking mmap_lock for read.

Basically, when applied correctly, this approach results in faster
*and* simpler code.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org

--

Changes from v1:
 * Add a comment explaining that this can not be mixed with other
   per-VMA lock or mmap_lock users. It is prone to deadlocks if so.
 * Add a FIXME about making the mmap_read_lock() killable
 * Add more chaneglog bits about the possibility for an infinite goto
   loop.
 * Adopt vma_start_read_unlocked() implementation from Lorenzo
---

 b/include/linux/mmap_lock.h |    3 +++
 b/mm/mmap_lock.c            |   27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff -puN include/linux/mmap_lock.h~lock-vma-under-rcu-wait include/linux/mmap_lock.h
--- a/include/linux/mmap_lock.h~lock-vma-under-rcu-wait	2026-06-10 15:57:55.828431712 -0700
+++ b/include/linux/mmap_lock.h	2026-06-10 15:57:55.834431925 -0700
@@ -257,6 +257,9 @@ static inline bool vma_start_read_locked
 	return vma_start_read_locked_nested(vma, 0);
 }
 
+struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
+					       unsigned long address);
+
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
 	vma_refcount_put(vma);
diff -puN mm/mmap_lock.c~lock-vma-under-rcu-wait mm/mmap_lock.c
--- a/mm/mmap_lock.c~lock-vma-under-rcu-wait	2026-06-10 15:57:55.831431819 -0700
+++ b/mm/mmap_lock.c	2026-06-10 16:02:50.723860779 -0700
@@ -338,6 +338,33 @@ inval:
 	return NULL;
 }
 
+/*
+ * Find the VMA covering 'address' and lock it for reading. Waits for writers to
+ * finish if the VMA is being modified. Returns NULL if there is no VMA covering
+ * 'address'.
+ *
+ * Use only in code paths where no mmap_lock and no VMA lock is held.
+ *
+ * The fast path does not take mmap_lock.
+ */
+struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
+					       unsigned long address)
+{
+	struct vm_area_struct *vma;
+
+	/* Fast path: return stable VMA covering 'address': */
+	vma = lock_vma_under_rcu(mm, address);
+	if (vma)
+		return vma;
+
+	/* Slow path: preclude VMA writers by getting mmap read lock. */
+	guard(rwsem_read)(&mm->mmap_lock);
+	if (!vma_start_read_locked(vma))
+		return NULL;
+
+	return vma;
+}
+
 static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_struct *mm,
 							    struct vma_iterator *vmi,
 							    unsigned long from_addr)
_

