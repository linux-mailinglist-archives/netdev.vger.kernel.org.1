Return-Path: <netdev+bounces-284393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCsSGAXw+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:26:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 673544CE72F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 932A83002B74
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24774342C9E;
	Tue,  5 May 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="nt+Jk6Nw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87779242D72
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987283; cv=none; b=iQ9pMtpHIBZbnfRkxFXVEb5xJLkXZSpLlBy4fpOBxSKSFXr/8W8wTyv1Yvd12FW3OcDa/fTYZMc9ZpMrGW1o9YZGZNRnjrHeJppPKOXb+iyCAqPUJ3F8FJexFzwwh8La4Iugfd4564wlbek1uSCw79Eq7+2HjBgLdtZ9EhY2I1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987283; c=relaxed/simple;
	bh=2r4mESJuqT5psaOK7TO9QI+GZumNWqCL7bB9RDgQkqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TveV5jAMMNZCxbvjnn3aHGDdtDA9jVQd4aI70M8AM/tTDnICiMITpIvk7VOZlkJ/yXtjuaGlFXvUhjqTqhrJwip/46Kq//IcJJcxcexwmXkIsgb+RXu0r+DQ9bV7e62wJGAHveGkA67OcJlojx+uJgfKXScfWDzpSyvH2YVbvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=nt+Jk6Nw; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb40149037so513732885a.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777987279; x=1778592079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zlIwOmWjJUP6182LzMfSF4tDYCvP8C7fu6JM/91Fs8=;
        b=nt+Jk6Nwfem5p+ZrSIfaDuv6HWuO6xenc0/DIV+HYrurfEBXS1aBvvAkj72MQv2J3F
         Kmv3oHMKkmRVwSD4WKBMlbNX6VnDYfv5qVWqq1esW2fthZscpa3Sulz3pJFoy5hZTKt9
         sXMrnRdoPNmTVGZP+o64hnqUAYOBTzDvDmJp90Rp1unJMXrNWPuDsOoZQYVF3gmrqnRU
         Pdx3y3J/dxx7cxNvV3Y3TacLNc70EcdeyzOtJeDDVPxiyU9sfylbsSFKqKoiIZuJ+bn7
         WI8fY+8tubLrMgcW0uidW5ajN1MMa1NGE/2CfG1JmmVblJnD0OvJFzO89OZxifEZYLCo
         bClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987279; x=1778592079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zlIwOmWjJUP6182LzMfSF4tDYCvP8C7fu6JM/91Fs8=;
        b=Rmgp2o+4auDN0rSEyu+H7RFK+jYB6XZUwLfN7TwHCGE3Ar7/daYY2/kIWw6feTnXeu
         +0q5LDKDLurWyJ876aJB7VBEwHu68fgOIlevIEU5s1plhmkiQUo9CWe+zW/DxJiiXpgD
         sv+BYc5+Q5N+31IkiPPAT4bn/4SmHP7Z9R/7RsgdtWFvWRrg46tbl2gSbKk+LWOhzQQd
         uK2nJKzlSYX0sXWrk+u3HxjjESpsUFQ2cnjkvAedZeMRuxAjfDRchXpk2YNgwGuHEVyq
         Cj2l4uiPc9lPX3TwjUvq7iBCP9Oe1F1mLyAWm4cO2gnzfhdP/m2oqrn8lQVJX7umOK98
         JshQ==
X-Gm-Message-State: AOJu0YwuhhKfgyD7DvrAA8FBN9NfKetX63HEx312yoY9M+8LDOhNXQZO
	nb8sosRPTd2pCmB3eFANfhulyloS/IdNTlYNr8iYmK/9lsk6Y2i5FQ/jSTNNCJmnEWw+mfl0CkZ
	NTnA=
X-Gm-Gg: AeBDiesoL8UCpZERqMR6zfIuZ4zNl9AFsjxrivihMjSDP9XGgXwzt/B/FKVVt6u9R3N
	co9UhugCwFR9WDXOR791YR0a84nAWpMuzz67aOh9oWHmWlc3MPCDxWJHclUBp9sTHL78sY7e4pv
	rt5USDe18dSKtH4Isig9Y/8PhEhd7p087VYArcM1XB4HvZObnBydZ1lSpW8zNBr7ZEMfLhSrquO
	dmNUXO7QGMYcc6p4dUAKi5BtmnfyN6FttHGqySDY1WlRcj1vIAycY4cTms8k+XqyMmKFt/ExFdK
	2CqYJlPDX36AWCKFq6tR0i7LfR4boWE81e+tiq2nbp1HVFuCjzKNaTNkcroeMUjmw6d5EtyYnkm
	tQe5hDSAmotGBUX4LpOiUe+TlCO0ys3bOpnY9bbOmazXznuoL2truNBNGZ9XK5oKwwsKE7Gg1VJ
	D1tBOhr8+Go0TRS5qGISwQRCb3qiKqGtrKiF+03gAkxSbRDZlo
X-Received: by 2002:a05:620a:25d3:b0:8dc:eca0:35bd with SMTP id af79cd13be357-8fd158e5b7amr1978725985a.5.1777987278785;
        Tue, 05 May 2026 06:21:18 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253bc9sm1493975285a.27.2026.05.05.06.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:21:18 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	horms@kernel.org,
	vinicius.gomes@intel.com,
	graypanda.inzag@gmail.com,
	victor@mojatatu.com,
	security@kernel.org
Subject: [PATCH net 1/2] net/sched: sch_cbs: Call qdisc_reset for child qdisc
Date: Tue,  5 May 2026 09:21:01 -0400
Message-Id: <20260505132102.128903-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 673544CE72F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-284393-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,davemloft.net,kernel.org,google.com,redhat.com,resnulli.us,intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,mojatatu.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,mojatatu-com.20251104.gappssmtp.com:dkim]

During a reset, CBS is not calling reset on its child qdisc, which
might cause qlen/backlog accounting issues. For example, if we have CBS
with a QFQ parent and a netem child with delay, we can create a scenario
where the parent's qlen underflows. QFQ, specifically, uses qlen to
check whether it should dereference a pointer, so this scenario may cause
a null-ptr deref in QFQ:

[   43.875639][  T319] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] SMP KASAN NOPTI
[   43.876124][  T319] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
[   43.876417][  T319] CPU: 10 UID: 0 PID: 319 Comm: ping Not tainted 7.0.0-13039-ge728258debd5 #773 PREEMPT(full)
[   43.876751][  T319] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   43.876949][  T319] RIP: 0010:qfq_dequeue+0x35c/0x1650
[   43.877123][  T319] Code: 00 fc ff df 80 3c 02 00 0f 85 17 0e 00 00 4c 8d 73 48 48 89 9d b8 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 76 0c 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b
[   43.877648][  T319] RSP: 0018:ffff8881017ef4f0 EFLAGS: 00010216
[   43.877845][  T319] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
[   43.878073][  T319] RDX: 0000000000000009 RSI: 0000000c40000000 RDI: ffff88810eef02b0
[   43.878306][  T319] RBP: ffff88810eef0000 R08: ffff88810eef0280 R09: 1ffff1102120fd63
[   43.878523][  T319] R10: 1ffff1102120fd66 R11: 1ffff1102120fd67 R12: 0000000c40000000
[   43.878742][  T319] R13: ffff88810eef02b8 R14: 0000000000000048 R15: 0000000020000000
[   43.878959][  T319] FS:  00007f9c51c47c40(0000) GS:ffff88817a0be000(0000) knlGS:0000000000000000
[   43.879214][  T319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.879403][  T319] CR2: 000055e69a2230a8 CR3: 000000010c07a000 CR4: 0000000000750ef0
[   43.879621][  T319] PKRU: 55555554
[   43.879735][  T319] Call Trace:
[   43.879844][  T319]  <TASK>
[   43.879924][  T319]  __qdisc_run+0x169/0x1900
[   43.880075][  T319]  ? dev_qdisc_enqueue+0x8b/0x210
[   43.880222][  T319]  __dev_queue_xmit+0x2346/0x37a0
[   43.880376][  T319]  ? register_lock_class+0x3f/0x800
[   43.880531][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.880684][  T319]  ? __pfx___dev_queue_xmit+0x10/0x10
[   43.880834][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.880977][  T319]  ? __lock_acquire+0x819/0x1df0
[   43.881124][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.881275][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.881418][  T319]  ? __asan_memcpy+0x3c/0x60
[   43.881563][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.881708][  T319]  ? eth_header+0x165/0x1a0
[   43.881853][  T319]  ? lockdep_hardirqs_on_prepare+0xdb/0x1a0
[   43.882031][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.882174][  T319]  ? neigh_resolve_output+0x3cc/0x7e0
[   43.882325][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.882471][  T319]  ip_finish_output2+0x6b6/0x1e10

Fix this by calling qdisc_reset for CBS' child qdisc

Fixes: 585d763af09c ("net/sched: Introduce Credit Based Shaper (CBS) qdisc")
Reported-by: Junyoung Jang <graypanda.inzag@gmail.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Junyoung Jang <graypanda.inzag@gmail.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_cbs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 8c9a0400c862..1efd72581614 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -243,6 +243,16 @@ static struct sk_buff *cbs_dequeue(struct Qdisc *sch)
 	return q->dequeue(sch);
 }
 
+static void cbs_reset(struct Qdisc *sch)
+{
+	struct cbs_sched_data *q = qdisc_priv(sch);
+
+	qdisc_reset(q->qdisc);
+	qdisc_watchdog_cancel(&q->watchdog);
+	q->credits = 0;
+	q->last = 0;
+}
+
 static const struct nla_policy cbs_policy[TCA_CBS_MAX + 1] = {
 	[TCA_CBS_PARMS]	= { .len = sizeof(struct tc_cbs_qopt) },
 };
@@ -540,7 +550,7 @@ static struct Qdisc_ops cbs_qdisc_ops __read_mostly = {
 	.dequeue	=	cbs_dequeue,
 	.peek		=	qdisc_peek_dequeued,
 	.init		=	cbs_init,
-	.reset		=	qdisc_reset_queue,
+	.reset		=	cbs_reset,
 	.destroy	=	cbs_destroy,
 	.change		=	cbs_change,
 	.dump		=	cbs_dump,
-- 
2.34.1


