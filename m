Return-Path: <netdev+bounces-277336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOokGo3d2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:22:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A281F3D61CC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 492F830086F1
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61D34EEE5;
	Fri, 10 Apr 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="f2NUPdv3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E728E0F
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819810; cv=none; b=O4Y6o0rCJnComr/6G5VkNk7BbxOgabFhuAgVwmIeRXPb465fzDrY3tS3hSNbCtvY/XjaqGhr0ndwmUq8P9VPR47nYovyOWVJBVDsIK0zUfk8wUKmRIzjwRUJMoO6h/Lz26vmprcFualLAusWQ8tVjKMgP1lYpJP9/e2zthEfzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819810; c=relaxed/simple;
	bh=ABGLbCpLP3AOhHFqHom1LM4VqxDRcXQoeNkm2Yg/Oew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdKYwySnqN6Wkk0oV5V/uFuajdixZAdbvsbG8q3vSgoEv2ixgmuWsWXyBv0rNHv9EYqCbamRxjDoU3ATwSdk5czGYpEen6o8HyjlgMCtERciatVwEsSpF4wWb3yeha1W+MdmggTJT88qBLB8jYLa+DLOJDgf0JjN4PAiswIKMD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=f2NUPdv3; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a6cf8242so14181141cf.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1775819807; x=1776424607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/pdVTXleOZbHzYXJKkXcGjY0fz5tuS3semDRdQ++sA=;
        b=f2NUPdv3aTLSxRUbdx2GCmH0WisDx7M2p7to6AKkiT1HrzOxfxGXg/nenU0PC1vrBt
         VdMH6gxlpmd9F/4GTVOgk9zSbB4uxPUuk33x7/NWk8CjRyqmZFRShTHFITiwuwuyZtRe
         57nYxLjYcAepK3KOusY+Lf/PuklgqBBL8Pv+BeTgOZB6DEHiLc56bCzH/j3CfEfsct92
         YeLYzEgl4C+PlP88MayzkS8ZPHgqM3hnLP/pWZLPreYR3cmkJmLzlNfpLs46DPI/5bET
         iW7irlfJ1Zexx3f077WSdmQmDz8hyLUlGyXO9DPZdXX3Co0b+wjusPvKIDR88Tgg8Wy0
         qomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775819807; x=1776424607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/pdVTXleOZbHzYXJKkXcGjY0fz5tuS3semDRdQ++sA=;
        b=RtDG2BfLWrUL2qjCYIaF3yvSH//C2P7fl9gXM5KLSeDRt3dsUrorbdYGYBHuAuI2Jn
         D2IaNf9Q1DlgMDdY9SWb8SlWHmuYSW4OXFAtGOWgWJSbXMmfdSSOAvANbRJ/cyhUYZ6j
         rPiQqeQP7XngVt2lbUS7+Jh21w5PbxkaIB83QbMFhFglkaSGLURGFSyNX1mKHAX1S8GU
         UlrA90CR+EZ3+KhmLcW+unrODYe0eEwuy3XCE/tXVzQkNUWSbWhTX5Q8RHld6FIrTPjN
         oLw+RtbfbPxz2qxw1g+XeRmLh9xuERrjMJU5dcLyD+yvi7hAgqx33580Z/zs40YCXOI/
         jmHA==
X-Gm-Message-State: AOJu0YxeKZZUDzmg71RSMl5IdcQ0zKWaZPqdsSwMr7wyX5dr4lE0twUU
	aMC+4XavHB4p0XxhKfYwWFrfZwVHl/GXrf7VMS8nxjAliXwqFhdusb5//x28IR6ZlXUQ4QVFg5g
	+7ss=
X-Gm-Gg: AeBDiet8QHd5sb6XbUC89BUOR69w/k30Bgt5Yg+WUQKddtSuqDDdoss8Iys0Rf1bbr+
	4MPyLtgcJk/smajpQNrq6DItNsUXMkCreVC3JnpeIvmJCuBtRgpIlSLv6YlZEqIjJZj0LkeoLWg
	iAzwLQwy/sJwheAkx9F1no6AVwx0IIojo7NsR6Xbjd5AcZwyMRwRpiDW9xgdhvoGkkAKeT0ftlX
	ysgy7CZDwTY1n4dlFCMAiaI/5d4yIERbBVaLa2MQm7aHEWrUuu3MCWNys5HT1JOltHpObZXNzb0
	on+ryqi5KDXRGG128azQl5DSrGcN/C5BUpEK5R0Qq6TQM+PUSBgq6IzcxqZ2RbIZKIUnCEOeoeq
	PF4NEq8GV8r3uLiUvgACICpAq3wZp6sBlOjjS6rQR61se7shvIdRFjeiKEGGm0CgzxjdTIrOOqR
	p4WIqRzLlpxHufkgwxyixQv1z+5Lw=
X-Received: by 2002:a05:622a:558e:b0:50b:41b7:d6c2 with SMTP id d75a77b69052e-50dd5bee7d7mr42003651cf.47.1775819806823;
        Fri, 10 Apr 2026 04:16:46 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd54dd34fsm18832511cf.15.2026.04.10.04.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 04:16:46 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	zdi-disclosures@trendmicro.com,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 1/1] net/sched: act_ct: Only release RCU read lock after ct_ft
Date: Fri, 10 Apr 2026 07:16:27 -0400
Message-Id: <20260410111627.46611-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277336-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,mojatatu.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim,trendmicro.com:email]
X-Rspamd-Queue-Id: A281F3D61CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When looking up a flow table in act_ct in tcf_ct_flow_table_get(),
rhashtable_lookup_fast() internally opens and closes an RCU read critical
section before returning ct_ft.
The tcf_ct_flow_table_cleanup_work() can complete before refcount_inc_not_zero()
is invoked on the returned ct_ft resulting in a UAF on the already freed ct_ft
object. This vulnerability can lead to privilege escalation.

Analysis from zdi-disclosures@trendmicro.com:
When initializing act_ct, tcf_ct_init() is called, which internally triggers
tcf_ct_flow_table_get().

static int tcf_ct_flow_table_get(struct net *net, struct tcf_ct_params *params)

{
                struct zones_ht_key key = { .net = net, .zone = params->zone };
                struct tcf_ct_flow_table *ct_ft;
                int err = -ENOMEM;

                mutex_lock(&zones_mutex);
                ct_ft = rhashtable_lookup_fast(&zones_ht, &key, zones_params); // [1]
                if (ct_ft && refcount_inc_not_zero(&ct_ft->ref)) // [2]
                                goto out_unlock;
                ...
}

static __always_inline void *rhashtable_lookup_fast(
                struct rhashtable *ht, const void *key,
                const struct rhashtable_params params)
{
                void *obj;

                rcu_read_lock();
                obj = rhashtable_lookup(ht, key, params);
                rcu_read_unlock();

                return obj;
}

At [1], rhashtable_lookup_fast() looks up and returns the corresponding ct_ft
from zones_ht . The lookup is performed within an RCU read critical section
through rcu_read_lock() / rcu_read_unlock(), which prevents the object from
being freed. However, at the point of function return, rcu_read_unlock() has
already been called, and there is nothing preventing ct_ft from being freed
before reaching refcount_inc_not_zero(&ct_ft->ref) at [2]. This interval becomes
the race window, during which ct_ft can be freed.

Free Process:

tcf_ct_flow_table_put() is executed through the path tcf_ct_cleanup() call_rcu()
tcf_ct_params_free_rcu() tcf_ct_params_free() tcf_ct_flow_table_put().

static void tcf_ct_flow_table_put(struct tcf_ct_flow_table *ct_ft)
{
                if (refcount_dec_and_test(&ct_ft->ref)) {
                                rhashtable_remove_fast(&zones_ht, &ct_ft->node, zones_params);
                                INIT_RCU_WORK(&ct_ft->rwork, tcf_ct_flow_table_cleanup_work); // [3]
                                queue_rcu_work(act_ct_wq, &ct_ft->rwork);
                }
}

At [3], tcf_ct_flow_table_cleanup_work() is scheduled as RCU work

static void tcf_ct_flow_table_cleanup_work(struct work_struct *work)

{
                struct tcf_ct_flow_table *ct_ft;
                struct flow_block *block;

                ct_ft = container_of(to_rcu_work(work), struct tcf_ct_flow_table,
                                                                rwork);
                nf_flow_table_free(&ct_ft->nf_ft);
                block = &ct_ft->nf_ft.flow_block;
                down_write(&ct_ft->nf_ft.flow_block_lock);
                WARN_ON(!list_empty(&block->cb_list));
                up_write(&ct_ft->nf_ft.flow_block_lock);
                kfree(ct_ft); // [4]

                module_put(THIS_MODULE);
}

tcf_ct_flow_table_cleanup_work() frees ct_ft at [4]. When this function executes
between [1] and [2], UAF occurs.

This race condition has a very short race window, making it generally
difficult to trigger. Therefore, to trigger the vulnerability an msleep(100) was
inserted after[1]

Fixes: 138470a9b2cc2 ("net/sched: act_ct: fix lockdep splat in tcf_ct_flow_table_get")
Reported-by: zdi-disclosures@trendmicro.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_ct.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 7d5e50c921a0..6158e13c98d3 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -328,9 +328,13 @@ static int tcf_ct_flow_table_get(struct net *net, struct tcf_ct_params *params)
 	int err = -ENOMEM;
 
 	mutex_lock(&zones_mutex);
-	ct_ft = rhashtable_lookup_fast(&zones_ht, &key, zones_params);
-	if (ct_ft && refcount_inc_not_zero(&ct_ft->ref))
+	rcu_read_lock();
+	ct_ft = rhashtable_lookup(&zones_ht, &key, zones_params);
+	if (ct_ft && refcount_inc_not_zero(&ct_ft->ref)) {
+		rcu_read_unlock();
 		goto out_unlock;
+	}
+	rcu_read_unlock();
 
 	ct_ft = kzalloc_obj(*ct_ft);
 	if (!ct_ft)
-- 
2.34.1


