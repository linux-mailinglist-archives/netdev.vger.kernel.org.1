Return-Path: <netdev+bounces-256999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJBPLXxBhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-256999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:06:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB87EF42B
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4961C3046D8F
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34C035CBAC;
	Thu,  5 Feb 2026 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEWZ1k5d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96453359FB6
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274941; cv=none; b=uAfUWlRI4JxxgS2ISwNutgSIMkqxcFeVuuzhARRmSkLqqZbzrnuOlxFuELrVnEpsHKtcgpWcQgavDPlt635QbVAT1RPgaqj+nS1dlb+utlW9bNJZNqduhsvDFVFo3v8w+gWm6YQMBuN2IcTrke0RCHk8H5SNIe/Tt9V1PPBI1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274941; c=relaxed/simple;
	bh=Wl2FwA/sTlo7new4i4CIMIvOOBMTwCTs77t4NxvMeT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDlpYMJVmNSlA1vHf4xat34QuYgB7Bd4veqZXSguys9gn6txjmxzrSsGzB4gofJoNoMvoc+Zm7zWOHjG7pr14E/nwPAAi+r7Wif4tTn2qYDDyy7awnmJUsuaO0FSrAWu7eftvRs1rnxZ/REznNi4UlK7bphE7Qs/hozMmyx7zcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEWZ1k5d; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35334ea1f98so267169a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274941; x=1770879741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR1ArDnp08s60Jl+UA9F5jroPcofKYU3VSalxo04NKw=;
        b=CEWZ1k5dMvHRK2/dVG4FW/zauxzBXZo4cg9DAwRx0GHXgekuA6dH+n9RQ4pHfL+8BD
         CUrrbPev/vn4eV3jReN17UlgFb52SVOy+1smkD5CS6yB7yGGCXmHJ/BHo4qXJ7rPVDcv
         DtOsf1NTaC3exL9+MJnVVrOadDN8KrkhVzsuM5oTtbs5Q3/zSYe4OoEqedAVdMrRE4cl
         vW6xUoEBBu8nbweDg3AUlTOBR40H19tHggMbnC1XHkZ678bnZKL3TIEZxZIpaPDsCH66
         nIYGWvZGeV+2Xoc1RNjyMLVfsghyQ+uhHtqEq1DbAe8ByyELWkgxSoJ3iltYBFdmnuMz
         z7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274941; x=1770879741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bR1ArDnp08s60Jl+UA9F5jroPcofKYU3VSalxo04NKw=;
        b=QKRYZFQxo4zP2iKrAl4HWH7Y7vaCOXVoI9RTOoIB4fF/7+nKNoYId78qV5J6OTpiEy
         uKaMvhtMYFIIpZYsQqUR+S1FhfosZRwxAZHjEIgdWU0tfBTJuNZLleyKnCavkGyOml+c
         pI8sCjrAQnSchnApNiPAEBmG/IaivOLo4PjWegm1dMIhH6jG2ujeyeBdn0mujPwCc5qO
         d1NHsHJYDIPVNn7O7C0B0iBeprbdwHTaozzojaGr2RyRn8K2SQUlRIxnc9SdX7DOuNuL
         twZTWWuyjsLK213ZBJ2cwNBnCe8Hbo0clgE9zySblKlkKqLhDW1S48BaOsiKU8zyP7Pw
         pFNw==
X-Gm-Message-State: AOJu0YzTvMQmVYrKGLBnAVAx01ij+dkCermv5XhGNSXNvZMyaulr+/3M
	vc6BIofR9fDhScFcg8P5Trt4VgwP0ZKNl/CKqlTAZPUKN9G2Kurb4r2ZWjYM0Q==
X-Gm-Gg: AZuq6aLwNYr8mprMR8n3lLQTB0VLN6nM+RkMIksJ+A8reEw6MPIAdtx4T4Q6esurofE
	Xocere3QbpcnqoRRWhjFLaeXOm6AHSCDc2TTfpBV+ywtjRb4DM2o3H5Gaxq19LzYrd0862umSKA
	T94VmWtzFU6AARj8kODsXiTSD/MzoQTH42g2sI52oQ3yIEiFnPSg3DCn/B2BmCO9QhJpTpzJL0G
	yBlHvJjFbrUrbKX5AfQsC7P9W5mGFL3uhs+X2t2qpAUpbVal97yuBNNJSknYc5LWN3ivxPm2Z4r
	ROJQBMXwh+P6aJbCaIRYtA1Eobfj+kqsfrBHaJtYAPxLAw/2X1FScmEp3Hymb1gwQtfhQJk+9tM
	JsBS1Pf6t/yglQ+RgRjsZda5mPw4UmCuXE2KAmuAqdTwN05gwBAP0qvVJNTLJtUordXbLSBDeTC
	ts
X-Received: by 2002:a17:90b:562d:b0:343:7714:4cab with SMTP id 98e67ed59e1d1-354871950damr4487164a91.22.1770274940878;
        Wed, 04 Feb 2026 23:02:20 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35489313becsm2368633a91.5.2026.02.04.23.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:20 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 10/17] bpf: Support lockless unlink when freeing map or local storage
Date: Wed,  4 Feb 2026 23:01:59 -0800
Message-ID: <20260205070208.186382-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256999-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DB87EF42B
X-Rspamd-Action: no action

Introduce bpf_selem_unlink_nofail() to properly handle errors returned
from rqspinlock in bpf_local_storage_map_free() and
bpf_local_storage_destroy() where the operation must succeeds.

The idea of bpf_selem_unlink_nofail() is to allow an selem to be
partially linked and use atomic operation on a bit field, selem->state,
to determine when and who can free the selem if any unlink under lock
fails. An selem initially is fully linked to a map and a local storage.
Under normal circumstances, bpf_selem_unlink_nofail() will be able to
grab locks and unlink a selem from map and local storage in sequeunce,
just like bpf_selem_unlink(), and then free it after an RCU grace period.
However, if any of the lock attempts fails, it will only clear
SDATA(selem)->smap or selem->local_storage depending on the caller and
set SELEM_MAP_UNLINKED or SELEM_STORAGE_UNLINKED according to the
caller. Then, after both map_free() and destroy() see the selem and the
state becomes SELEM_UNLINKED, one of two racing caller can succeed in
cmpxchg the state from SELEM_UNLINKED to SELEM_TOFREE, ensuring no
double free or memory leak.

To make sure bpf_obj_free_fields() is done only once and when map is
still present, it is called when unlinking an selem from b->list under
b->lock.

To make sure uncharging memory is done only when the owner is still
present in map_free(), block destroy() from returning until there is no
pending map_free().

Since smap may not be valid in destroy(), bpf_selem_unlink_nofail()
skips bpf_selem_unlink_storage_nolock_misc() when called from destroy().
This is okay as bpf_local_storage_destroy() will return the remaining
amount of memory charge tracked by mem_charge to the owner to uncharge.
It is also safe to skip clearing local_storage->owner and owner_storage
as the owner is being freed and no users or bpf programs should be able
to reference the owner and using local_storage.

Finally, access of selem, SDATA(selem)->smap and selem->local_storage
are racy. Callers will protect these fields with RCU.

Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |   9 ++-
 kernel/bpf/bpf_local_storage.c    | 116 ++++++++++++++++++++++++++++--
 2 files changed, 118 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index a34ed7fa81d8..69a5d8aa765d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -68,6 +68,11 @@ struct bpf_local_storage_data {
 	u8 data[] __aligned(8);
 };
 
+#define SELEM_MAP_UNLINKED	(1 << 0)
+#define SELEM_STORAGE_UNLINKED	(1 << 1)
+#define SELEM_UNLINKED		(SELEM_MAP_UNLINKED | SELEM_STORAGE_UNLINKED)
+#define SELEM_TOFREE		(1 << 2)
+
 /* Linked to bpf_local_storage and bpf_local_storage_map */
 struct bpf_local_storage_elem {
 	struct hlist_node map_node;	/* Linked to bpf_local_storage_map */
@@ -80,8 +85,9 @@ struct bpf_local_storage_elem {
 						 * after raw_spin_unlock
 						 */
 	};
+	atomic_t state;
 	bool use_kmalloc_nolock;
-	/* 7 bytes hole */
+	/* 3 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -97,6 +103,7 @@ struct bpf_local_storage {
 	struct rcu_head rcu;
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 	u64 mem_charge;		/* Copy of mem charged to owner. Protected by "lock" */
+	refcount_t owner_refcnt;/* Used to pin owner when map_free is uncharging */
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index f8cfef31e3b8..4bd0b5552c33 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+		atomic_set(&selem->state, 0);
 		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 		if (value) {
@@ -194,9 +195,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 	/* The bpf_local_storage_map_free will wait for rcu_barrier */
 	smap = rcu_dereference_check(SDATA(selem)->smap, 1);
 
-	migrate_disable();
-	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	migrate_enable();
+	if (smap) {
+		migrate_disable();
+		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+		migrate_enable();
+	}
 	kfree_nolock(selem);
 }
 
@@ -221,7 +224,8 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		 * is only supported in task local storage, where
 		 * smap->use_kmalloc_nolock == true.
 		 */
-		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+		if (smap)
+			bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 		__bpf_selem_free(selem, reuse_now);
 		return;
 	}
@@ -255,7 +259,7 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *selem,
 						 struct bpf_local_storage_map *smap,
 						 struct bpf_local_storage *local_storage,
-						 bool free_local_storage)
+						 bool free_local_storage, bool pin_owner)
 {
 	void *owner = local_storage->owner;
 	u32 uncharge = smap->elem_size;
@@ -264,6 +268,9 @@ static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *
 	    SDATA(selem))
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
+	if (pin_owner && !refcount_inc_not_zero(&local_storage->owner_refcnt))
+		return;
+
 	uncharge += free_local_storage ? sizeof(*local_storage) : 0;
 	mem_uncharge(smap, local_storage->owner, uncharge);
 	local_storage->mem_charge -= uncharge;
@@ -274,6 +281,9 @@ static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *
 		/* After this RCU_INIT, owner may be freed and cannot be used */
 		RCU_INIT_POINTER(*owner_storage(smap, owner), NULL);
 	}
+
+	if (pin_owner)
+		refcount_dec(&local_storage->owner_refcnt);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -295,7 +305,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 						    &local_storage->list);
 
 	bpf_selem_unlink_storage_nolock_misc(selem, smap, local_storage,
-					     free_local_storage);
+					     free_local_storage, false);
 
 	hlist_del_init_rcu(&selem->snode);
 
@@ -412,6 +422,94 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	return err;
 }
 
+/*
+ * Unlink an selem from map and local storage with lockless fallback if callers
+ * are racing or rqspinlock returns error. It should only be called by
+ * bpf_local_storage_destroy() or bpf_local_storage_map_free().
+ */
+static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
+				    struct bpf_local_storage_map_bucket *b)
+{
+	bool in_map_free = !!b, free_storage = false;
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map *smap;
+	unsigned long flags;
+	int err, unlink = 0;
+
+	local_storage = rcu_dereference_check(selem->local_storage, bpf_rcu_lock_held());
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+
+	if (smap) {
+		b = b ? : select_bucket(smap, local_storage);
+		err = raw_res_spin_lock_irqsave(&b->lock, flags);
+		if (!err) {
+			/*
+			 * Call bpf_obj_free_fields() under b->lock to make sure it is done
+			 * exactly once for an selem. Safe to free special fields immediately
+			 * as no BPF program should be referencing the selem.
+			 */
+			if (likely(selem_linked_to_map(selem))) {
+				hlist_del_init_rcu(&selem->map_node);
+				bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+				unlink++;
+			}
+			raw_res_spin_unlock_irqrestore(&b->lock, flags);
+		}
+		/*
+		 * Highly unlikely scenario: resource leak
+		 *
+		 * When map_free(selem1), destroy(selem1) and destroy(selem2) are racing
+		 * and both selem belong to the same bucket, if destroy(selem2) acquired
+		 * b->lock and block for too long, neither map_free(selem1) and
+		 * destroy(selem1) will be able to free the special field associated
+		 * with selem1 as raw_res_spin_lock_irqsave() returns -ETIMEDOUT.
+		 */
+		WARN_ON_ONCE(err && in_map_free);
+		if (!err || in_map_free)
+			RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
+	}
+
+	if (local_storage) {
+		err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+		if (!err) {
+			if (likely(selem_linked_to_storage(selem))) {
+				free_storage = hlist_is_singular_node(&selem->snode,
+								      &local_storage->list);
+				 /*
+				  * Okay to skip clearing owner_storage and storage->owner in
+				  * destroy() since the owner is going away. No user or bpf
+				  * programs should be able to reference it.
+				  */
+				if (smap && in_map_free)
+					bpf_selem_unlink_storage_nolock_misc(
+						selem, smap, local_storage,
+						free_storage, true);
+				hlist_del_init_rcu(&selem->snode);
+				unlink++;
+			}
+			raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+		}
+		if (!err || !in_map_free)
+			RCU_INIT_POINTER(selem->local_storage, NULL);
+	}
+
+	if (unlink != 2)
+		atomic_or(in_map_free ? SELEM_MAP_UNLINKED : SELEM_STORAGE_UNLINKED, &selem->state);
+
+	/*
+	 * Normally, an selem can be unlinked under local_storage->lock and b->lock, and
+	 * then freed after an RCU grace period. However, if destroy() and map_free() are
+	 * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
+	 * the selem only after both map_free() and destroy() see the selem.
+	 */
+	if (unlink == 2 ||
+	    atomic_cmpxchg(&selem->state, SELEM_UNLINKED, SELEM_TOFREE) == SELEM_UNLINKED)
+		bpf_selem_free(selem, true);
+
+	if (free_storage)
+		bpf_local_storage_free(local_storage, true);
+}
+
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_map *smap,
 				      struct bpf_local_storage_elem *selem)
@@ -478,6 +576,7 @@ int bpf_local_storage_alloc(void *owner,
 	storage->owner = owner;
 	storage->mem_charge = sizeof(*storage);
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
+	refcount_set(&storage->owner_refcnt, 1);
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 
@@ -746,6 +845,11 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 
 	if (free_storage)
 		bpf_local_storage_free(local_storage, true);
+
+	if (!refcount_dec_and_test(&local_storage->owner_refcnt)) {
+		while (refcount_read(&local_storage->owner_refcnt))
+			cpu_relax();
+	}
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
-- 
2.47.3


