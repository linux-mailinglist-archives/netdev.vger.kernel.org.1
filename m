Return-Path: <netdev+bounces-303230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zangBjrPQ2qaiwoAu9opvQ
	(envelope-from <netdev+bounces-303230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:14:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA76E54A2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:14:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b="cj//GVQT";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303230-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303230-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07F8D301FBBD
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ABD40B36D;
	Tue, 30 Jun 2026 14:11:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0AE3F788D;
	Tue, 30 Jun 2026 14:11:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828698; cv=none; b=Xhp/N+1XS79DOp02n/fqa24L3ikSgxKOplxYge+x8u/4Po2GlmtEYvijfoZReTuUWvCE4hWeNXl7NHICzMbhquQR9CYiOsoKgwNxv7xny2eQm1DsfzwNX92OppWFs7+3s6NOVDRrS0+SWnM7tbKZRRPGehAaIGkB6FPLSjPVTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828698; c=relaxed/simple;
	bh=1OwlXTtbur5y73MCuBDgvs91ZkbzDnDY/gx1SFyQIgA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gm59cF6WDgsMia37LoJEzv2CBv49O7HCMhsZd1/TQ38I3WJ9fKwiXAZr00q8TkX9Zp88+HMW3dC3jq82y88onl94TxIsFx6O5sN6uatmCzjCyid+lwBJx7PYxwpw8XPVLSyhU4WOVb+08prf33XGgpc4tMJxbq63ijqcGGLc0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cj//GVQT; arc=none smtp.client-ip=203.205.221.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782828693; bh=xE0XGmsE5I2PPzhJkvXNUerH91+gi+wDHfdP2poQzAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cj//GVQToSqDrG/NOInn9OCkbvVy5+z5fhwnjUW5wB1JHXOWZzPR97kT6LreZYZg/
	 rfAZGNenEjJlwaXR8W3z+q8bI4jovHzXk3RETfS/NRFBaN2bhiYH3EKF+a/5CmOgEd
	 nRQmGJ0opp43Gj4+kZNK30bOk5Y8uhTIbKVbG6XI=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 2DD106C9; Tue, 30 Jun 2026 22:11:29 +0800
X-QQ-mid: xmsmtpt1782828689tcwjqfyml
Message-ID: <tencent_5E4F8F8DADA5DE0DAD924ADD835DD7991707@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7RXc99ezP3qCoo/N31NL1uX2ChppuHCgzfrWXuKljfo1n0+2uj4
	 YhaWepoY7N9PA/tzH4ayNzqEixAdDnZ/y/G6i91RPKnKuFBqfbrJXrVfIlUfDimGyuyPeTcs/8p/
	 0ugl4L9w4SMsiAQdQH2zo6cw8sZcoSP9F7cEzZ34JDBokLNAajMteNi7Q8s9Okh28pfOOhdlDlND
	 xOEryhaAdu3EXrDtr3h6NxE3UmnzcdjZ4znnpFoXjvbG/SETsRkMdnuyAV/Lk++1DTbl8AJb3JIP
	 YL22PCVw5ZVXK3yMkOnk9I/lZ7SViDYIxwhNAJOTt66+kM6tK6TEFdnMVchEpDGbBR6AwzKNLrlk
	 8SOAE0q3/SollUd/s5s7mYlUy9Chvz415VVBYDO/4SucmbRQYVfmKxq9tBHr+sjae0VhRLe8w3s1
	 iSDfpH5pS5vZ3GNriI7fFbqENrcg7HdXS95M8S+OEODe+sGTaKVcLAiXAl99+HeUOFwGSLJ6OuDt
	 dku5f9bwk6MHMu3jufBlgPQkxwha9yEvVhySwE/8zBA3wxf6ApLjfIWDc15rMwGs3P1an2F8OmUi
	 ugkW3C57LiBvud6eZje02qWQn8TkVncGkMoUg3xSAyzkPYTzKjvajYUusiVDmcHfD5TjJSRQo3e7
	 IcveUvB4dbmTk12T8u0xYh36HTWj6E7xyoEjkY54xu9sGCHNGTC1PXIexawGuTkuisp+ZtCIAAOk
	 d17xy9+gDX+4iVZQmMsZ+83hAqhvjBaZABzVmin5GDAYAuSWT2sr0Ujuiu7uOf2pRJob6qm3NMrE
	 Dcv/0a62BxzEXMVNeOzVTa2yTp0lBUjMt2cvU7pQf1Zt4CXyE5XuyLrBG5xWGDLhDfjJG0hWd42z
	 1TcktfzosrWCHnYXsT6xWey0T4uM+ZUIkPtHXi/VEvkR1svq37pGsp0yop4qShQag/pGwltUdSjY
	 l+bTACTdqsNwC8TnqumES/uKrsy+BsK4uvemEDKj3xBVS6SzHABL5UttOoaS3ijlEJOWSKARdVyd
	 1Op1Po1I//ELinp7uXIyKns1FGy0qgHhxwcpX0zw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Edward Adam Davis <eadavis@qq.com>
To: sashiko-bot@kernel.org
Cc: eadavis@qq.com,
	jiayuan.chen@linux.dev,
	sashiko-reviews@lists.linux.dev,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH v4] bpf: Fix smp_processor_id() call trace for preemptible kernels
Date: Tue, 30 Jun 2026 22:11:29 +0800
X-OQ-MSGID: <20260630141128.958557-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630132226.C44601F000E9@smtp.kernel.org>
References: <20260630132226.C44601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303230-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[qq.com,linux.dev,lists.linux.dev,kernel.org,vger.kernel.org,iogearbox.net,gmail.com,etsalapatis.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[eadavis@qq.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashiko-bot@kernel.org,m:eadavis@qq.com,m:jiayuan.chen@linux.dev,m:sashiko-reviews@lists.linux.dev,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jolsa@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:song@kernel.org,m:syzkaller-bugs@googlegroups.com,m:yonghong.song@linux.dev,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34DA76E54A2

bpf_mem_cache_free_rcu() maybe called in preemptible context, this
will trigger the below warning message:

BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.17/5820
caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
Call Trace:
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
 rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
 __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c:3349
 bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
 __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1

this_cpu_ptr() access needs to be guarded against migration.
Wrapping this batch operation in bpf_disable_instrumentation() risk
blinding BPF tracing globally on the CPU if preemption occurs.

bpf_disable_instrumentation() increments the per-CPU bpf_prog_active counter.
Because migrate_disable() and rcu_read_lock() do not disable preemption under
CONFIG_PREEMPT_RCU, the task can be preempted during this potentially long
loop.

If preempted, bpf_prog_active would remain elevated on that CPU, which could
cause subsequent tasks scheduled on the same CPU to silently drop BPF tracing
events (kprobes, tracepoints, perf).

Therefore, we fix this by disabling preemption rather than prohibiting
migration.

Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().")
Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: using guard against preemption
v2 -> v3: replace get/put_cpu() to bpf_disable/enable_instrumentation()
v3 -> v4: disable preempt to make this_cpu_ptr() work

 kernel/bpf/hashtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..7b98c2eea685 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3345,8 +3345,10 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 	}
 
 	if (do_delete) {
+		get_cpu();
 		for (i = 0; i < total; i++)
 			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
+		put_cpu();
 	}
 
 	rcu_read_unlock();
-- 
2.43.0


