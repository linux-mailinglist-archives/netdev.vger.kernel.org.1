Return-Path: <netdev+bounces-301443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kTEwHJ3IOmplGwgAu9opvQ
	(envelope-from <netdev+bounces-301443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:55:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9986B9488
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:55:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OUBCrjYC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301443-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301443-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC7523110816
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D093905EB;
	Tue, 23 Jun 2026 17:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772038D41F
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237024; cv=none; b=O7roIEa2nBELRlMlg+6TI4k8c/TZfsZ4aGaH8K5rdxuwQvjTvNfy6rAB6oRz1EJwz/M2G2zMr1b4hdUvp+RnUVaxjQe0nfZ0M0JgfJUCJRhg/9Zk8PcorlRj8jmXD6QmN2puovDQjs9zOuFGsD0POT4QShFBY8iK2NYXaeoX4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237024; c=relaxed/simple;
	bh=uLRpEqXC6ltaZA/TfQVam4YHmcsCd3E2XQtc5Q/Kb/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utI67DDoTs0KwT4zLjRBgE+RjqaHxSzrCK0t80zXCbQ0VkHFhj6H69rTvh+L8e1ZLw4EGYYibkq0x7iIuYCsSDqv4atBtJTvlhenGlFXy8/RNIzu+It6Gl1sPqxvEgCMn54+R7jvoX49m97V99qMqLkp/bxP4FBGPCHKhxPhQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUBCrjYC; arc=none smtp.client-ip=209.85.161.52
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69e9b037d82so112069eaf.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237020; x=1782841820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5lBU+X/j5ynvyZ1nhRbGNr0iJKCv1ezBJqgvlthURQ=;
        b=OUBCrjYChhAX9eI/IDcwfWwaKj4gKfk6vSb/xq+vP/cpwhS9Qb7p2ZE0PN16PxFUII
         2R4U8hLvUZwy4f7ivT6L1Wa6kOjXr6K/cXIhh/BzOFL08gL+Br+bFJ9P3hrA/rM4OFEh
         UiR6llObgfHta6MGIWFbJ+708my8w1KTI/kzoL16uSGoAwWmk5YK1IP/nGioPLr21RZb
         YnifLC6ph2Cw0sBgRuHGBYAxXmCfsIrNDiFSif9UVoRTnNkZzLdzKb5fExh7wK8bvqC/
         ok56r8wrXx/gYDYDn5CnWkYFNvxq+7FAw/YBFbvyrlR1hPxloQXkZGSNH32m6s6ZZOKf
         voiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237020; x=1782841820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H5lBU+X/j5ynvyZ1nhRbGNr0iJKCv1ezBJqgvlthURQ=;
        b=B/7lv9g+lG5uHdpiSjw12iN0auMcXuCZnaqzWbYxNA/fJdOyEqgjCEEajft3c/2bhJ
         D0flY7KWj+W2zaX6vJ9086JI06/uEoqIhCYJOSx2G2wwj1nhwBO5r5pfqBSsiFZj2LAq
         FivC+IgSbwEb+uLlo4tbJTZNlHATnNuPMPyEStwnDr4ZdbJlEiKENcKRuCt+zpDhUaxF
         cmzwTpjuosOcnINAjagsTsA44ctrXQR5UwgE+O/YHRUwP2GN7UlafvfMXGPZZ0DFiDmf
         PBQcY2hU85mWUHhA7jES2/DlkPRDneKIg7omu2R2G2eF7Rmu176meRREDHABIMhRC4S7
         3C1Q==
X-Gm-Message-State: AOJu0YzdB4OAs0pXYmYWHEh/KLJkwY3yvqLLp0ujIfGc/JmQAcqRb7Se
	n8Ii3tyoxpDlnKwMvC8rWXLWROg7V+bHaPSPU+DHSZyLqJaqIjmhyo95
X-Gm-Gg: AfdE7cnZBLquyNqsCcZz32Lax1h2kFQs16+wQGAzpdFxPBc7DTA8nnllIiS7mh3EH+J
	Fk4i3zks8Xq7rMbQuoThjFiBLF7/Hdi7ChfCDKCDw613DnPDSiUcncDJ7nzmFG2MTIw5J8wd69A
	md7gB+zDps5Bt7q32kzI9yJwbN1a34Rznu9CsbxMw5LeSna1+G+68nKN5z+AEgiJSXQ3UCxdp1O
	EwTQeKRg7+4RsEwbYzXF5978nVZQI+GMeK8FVj2VBXEkgVgNUWa8cV89PLCtF8QfjtZR6bL6+72
	TA1TwSmOXkDVnHite73l9O2/ViOdh7/K/PDzKAS3NPifvPoj5hLbeYP0CZb46X8yzzQO3MZEIJF
	dP31h3PnkvM0nSOzwnYGdT9PKqX7ND4tuf70Dcs08YGcvZmAcu+6Xba6rDiu3qYpK9XVM1q4s59
	h5/Q56fPzxgPGkCQ==
X-Received: by 2002:a05:6820:a28d:10b0:6a1:160a:25de with SMTP id 006d021491bc7-6a1160a2b68mr1777761eaf.16.1782237020004;
        Tue, 23 Jun 2026 10:50:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9faf29asm7885023eaf.8.2026.06.23.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:19 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 08/15] bpf: Add a few bpf_cgroup_array_* helper functions
Date: Tue, 23 Jun 2026 10:49:56 -0700
Message-ID: <20260623175006.3136053-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-301443-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF9986B9488

From: Martin KaFai Lau <martin.lau@kernel.org>

In the upcoming patch, the array can store a struct_ops map.
The array could have a cfi_stubs acting as a dummy instead of
the dummy_bpf_prog. The array logic will need to skip the cfi_stubs
also in order to support storing struct_ops map in the array.

bpf_cgroup_array_length(), bpf_cgroup_array_copy_to_user(), and
bpf_cgroup_array_delete_safe_at() are added as a preparation work
to allow skipping the cfi_stubs in the upcoming patch. This patch
only skips the dummy_bpf_prog which is the same as the existing behavior.
The current bpf_prog_array_*() callers are changed to call the new
bpf_cgroup_array_*(). This is a no-op change.

Unlike bpf_prog_array_copy_to_user(), bpf_cgroup_array_copy_to_user()
does not need a temporary buffer. The cgroup caller already holds
cgroup_mutex and dereferences the effective array with
rcu_dereference_protected(), so it does not copy to userspace
from an RCU read-side critical section. Details in commit 0911287ce32b.

Another addition is the bpf_cgroup_array_free(). This prepares
the array to have a different rcu gp for the struct_ops use case,
for example, a struct_ops could have mix of sleepable ops and
non-sleepable ops. In this patch, bpf_cgroup_array_free() only
goes through the regular rcu gp. This is a no-op change also.

bpf_prog_dummy() is also added to return the global dummy_bpf_prog.

bpf_cgroup_array_dummy() is added to decide the sentinel based on atype.
It now always returns bpf_prog_dummy(). In the upcoming patch,
it can return a cfi_stubs if the atype belongs to a struct_ops.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/cgroup.c | 79 +++++++++++++++++++++++++++++++++++++++------
 kernel/bpf/core.c   |  5 +++
 3 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 047ffc029666..e371a4733135 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2561,6 +2561,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *include_prog,
 			u64 bpf_cookie,
 			struct bpf_prog_array **new_array);
+struct bpf_prog *bpf_prog_dummy(void);
 
 struct bpf_run_ctx {};
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 7abbe12e108f..081d81de1816 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -319,6 +319,67 @@ static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
 	link->cgroup = NULL;
 }
 
+static void bpf_cgroup_array_free(struct bpf_prog_array *array)
+{
+	if (!array || array == &bpf_empty_prog_array)
+		return;
+	kfree_rcu(array, rcu);
+}
+
+static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
+{
+	return bpf_prog_dummy();
+}
+
+static int bpf_cgroup_array_length(struct bpf_prog_array *array,
+				   enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_prog_array_item *item;
+	int cnt = 0;
+
+	for (item = array->items; item->prog; item++)
+		if (item->prog != bpf_cgroup_array_dummy(atype))
+			cnt++;
+
+	return cnt;
+}
+
+static int bpf_cgroup_array_copy_to_user(struct bpf_prog_array *array,
+					 __u32 __user *prog_ids, int cnt,
+					 enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_prog_array_item *item;
+	int i = 0;
+	u32 id;
+
+	for (item = array->items; item->prog && i < cnt; item++) {
+		if (item->prog == bpf_cgroup_array_dummy(atype))
+			continue;
+		id = item->prog->aux->id;
+		if (copy_to_user(prog_ids + i, &id, sizeof(id)))
+			return -EFAULT;
+		i++;
+	}
+	return item->prog ? -ENOSPC : 0;
+}
+
+static int bpf_cgroup_array_delete_safe_at(struct bpf_prog_array *array,
+					   int index, enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_prog_array_item *item;
+
+	for (item = array->items; item->prog; item++) {
+		if (item->prog == bpf_cgroup_array_dummy(atype))
+			continue;
+		if (!index) {
+			WRITE_ONCE(item->prog, bpf_cgroup_array_dummy(atype));
+			return 0;
+		}
+		index--;
+	}
+	return -ENOENT;
+}
+
 /**
  * cgroup_bpf_release() - put references of all bpf programs and
  *                        release all cgroup bpf data
@@ -356,7 +417,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		old_array = rcu_dereference_protected(
 				cgrp->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
-		bpf_prog_array_free(old_array);
+		bpf_cgroup_array_free(old_array);
 	}
 
 	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
@@ -530,7 +591,7 @@ static void activate_effective_progs(struct cgroup *cgrp,
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
 	 */
-	bpf_prog_array_free(old_array);
+	bpf_cgroup_array_free(old_array);
 }
 
 /**
@@ -570,7 +631,7 @@ static int cgroup_bpf_inherit(struct cgroup *cgrp)
 	return 0;
 cleanup:
 	for (i = 0; i < NR; i++)
-		bpf_prog_array_free(arrays[i]);
+		bpf_cgroup_array_free(arrays[i]);
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
@@ -625,7 +686,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 
 		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
 			if (unlikely(desc->bpf.inactive)) {
-				bpf_prog_array_free(desc->bpf.inactive);
+				bpf_cgroup_array_free(desc->bpf.inactive);
 				desc->bpf.inactive = NULL;
 			}
 			continue;
@@ -644,7 +705,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 	css_for_each_descendant_pre(css, &cgrp->self) {
 		struct cgroup *desc = container_of(css, struct cgroup, self);
 
-		bpf_prog_array_free(desc->bpf.inactive);
+		bpf_cgroup_array_free(desc->bpf.inactive);
 		desc->bpf.inactive = NULL;
 	}
 
@@ -1166,7 +1227,7 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog_list *pl,
 				lockdep_is_held(&cgroup_mutex));
 
 		/* Remove the program from the array */
-		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
+		WARN_ONCE(bpf_cgroup_array_delete_safe_at(progs, pos, atype),
 			  "Failed to purge a prog from array at index %d", pos);
 	}
 }
@@ -1296,7 +1357,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
-			total_cnt += bpf_prog_array_length(effective);
+			total_cnt += bpf_cgroup_array_length(effective, atype);
 		} else {
 			total_cnt += prog_list_length(&cgrp->bpf.progs[atype], NULL);
 		}
@@ -1326,8 +1387,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
-			cnt = min_t(int, bpf_prog_array_length(effective), total_cnt);
-			ret = bpf_prog_array_copy_to_user(effective, prog_ids, cnt);
+			cnt = min_t(int, bpf_cgroup_array_length(effective, atype), total_cnt);
+			ret = bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype);
 		} else {
 			struct hlist_head *progs;
 			struct bpf_prog_list *pl;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..1837bb7bb4e9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2740,6 +2740,11 @@ void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
 	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
 }
 
+struct bpf_prog *bpf_prog_dummy(void)
+{
+	return &dummy_bpf_prog.prog;
+}
+
 int bpf_prog_array_length(struct bpf_prog_array *array)
 {
 	struct bpf_prog_array_item *item;
-- 
2.53.0-Meta


