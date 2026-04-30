Return-Path: <netdev+bounces-282903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK7xOCB382mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:37:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3B44A4E71
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DFBD303465A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF2329BDBF;
	Thu, 30 Apr 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="fsMUFG1q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E227A123
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563034; cv=none; b=mc2hPwYv7G5CRTax0AB5BmkqgJadQXcWlH9lJSguZ0TfdqZqV+1M8lTlSuYF23nulxz8u+9DwfAi1GqgrDXyqtAZPIwwTp4AKgb/Pur8u9I3eTJqo8iaNBTB+GmooeO5tDKjFQ/BDXidaHHvCeOxwTES7lPq91ZASfaevSjsxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563034; c=relaxed/simple;
	bh=AQod7Z3vBXi7GLgv7aJ9RS4Ri6kONs3+lhD2VSQ0iBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xh6Y+CWjqP0cdfvXsS4fIYw/8SM4Xfh4Zor4Z4ZEQjcwPMgeQNRqmEGpIklo+Iz/68KM2PtHm6qCS/yNSLxBz44DhWYPBc6f2+FpqqhChBR7B6eeSO0DEO3pSEpQT9mzik4ZRyOXqs59uDZ3Iqc1L8Wiq1GPrcVKB20uZvY+FQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=fsMUFG1q; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e5bea4045so7754231cf.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777563031; x=1778167831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lvJAuBtx6u7Jt9OXcsd2Lp87vUF1cpUlCvS747GXao=;
        b=fsMUFG1qtn/qY2ASNYT4fCDvuYCNUbohd8pJppz0cfmT6j32WI8DI9YcjSHOQjVBuc
         gW5BO9Cagnn2MvlinRE2hF5ione/bp8T9uq+sVfPKOhhzvz84dzuXbU/2rlLOAWMYi7P
         zmzjTpNJEQDEiSb1hpLt5AUEZpIpSCMWxHkN6HiNCAtk/WU1jl7LgwR7C1Cl1MemgJHn
         O7b47w/wPBiyg++0vbbS1ml3SkFWRER/GXqkSb8n1TtMuBD90KfKDvsiYF/53JxwUFe0
         oCXMJyENMbxpQFai2VA2TNqNz9k8LKjtd65+2VqnB7UNrw+roccwDGFOZ0/R2vRw/1o/
         wrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563031; x=1778167831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4lvJAuBtx6u7Jt9OXcsd2Lp87vUF1cpUlCvS747GXao=;
        b=lx5iz4xwC3w9IL55hmNjWpfw/3dHIrM72gcey6WC0aMFR9Z5Sn300TqsIpULMQQ3D+
         QsRXZIZ4WEw0FBAavCvk9jmpGe/8fj2jg9HaV0yJN9Z7MDwSsgbZuY7Z8KHwHHp8QKGQ
         MTQXuhOxteS8xDq3DgH1m3yRATLFz3CBDoYccujBaESUMlvsTP2YnmSH3XPAZLzB4Nv2
         KG8TvZHrs7/nj7OU4Lg1HmhcU429W4ThUUXymKiDAzGbWzckJAGtVo6sJH8KwX0PBE7L
         5XRykW0RZjmRQ6Dl23tbvxs1/XHlpWA0jOINj8E+Hs1/6TzltUj7lRfHQxTF+1bAf2MQ
         Ut8Q==
X-Gm-Message-State: AOJu0YzdEaKm7uIbY8et62k7FkJqIsTg4qIpT68EbQ0LuQcR168duc17
	0UyrvXcnKpuJdY0s0aFnNq+/1IFZVBZTXglhAfZgaHDD5iw75zZIXJxzinkGNUacR0tQ1aWuf0a
	2efg=
X-Gm-Gg: AeBDietaUKL3HQykA3MmbmmnxCyJCRWe26Te01apNxTe7YAmM/Ns1xzHOnN6gwKo5Nn
	RLD3eNU4821O9DinLSSsz7ZU6laX417ksVyF+uIdNRatYHOPcuAo/1c65QCmyeJyNgQn6dXkKTa
	y17hfGYMhEIzcKx1bxKopCpnHqw5GuBcyir8fLPwowceQ5x0ykgNbMVBo3F070HqEwVF2Bs/zYo
	9NLZ24nBKfppdp9j9d7lz8z9hpVY9DPlIcmP5zM33uO+bIC6kHXNdc3RLmWfbqbXkut89q43nxP
	WU6DPOaJKOjb9vogkt44TVss+PBjqwPkEWX7sQN5y5BAuVs7552h6hhNuIFRuN2LYzxrwzgQQtd
	uVWxtq/yeg/XSa1UdbmBESSQyGc73MJzSkOeQQy2PQPEi+8PQDt0pbuTLi4zbgsLFtWSh0GLwDm
	Aj1nQ9o6y4lagMjjxAiSFSASP6oL1DhuhGhRklFQ==
X-Received: by 2002:a05:622a:993:b0:50d:8792:b6d1 with SMTP id d75a77b69052e-5102adba99emr49041571cf.38.1777563030989;
        Thu, 30 Apr 2026 08:30:30 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103b398312sm876591cf.10.2026.04.30.08.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:30:30 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	ghandatmanas@gmail.com,
	rakshitawasthi17@gmail.com,
	security@kernel.org
Subject: [PATCH net 1/3] net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked
Date: Thu, 30 Apr 2026 11:29:55 -0400
Message-Id: <20260430152957.194015-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430152957.194015-1-jhs@mojatatu.com>
References: <20260430152957.194015-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A3B44A4E71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282903-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,davemloft.net,kernel.org,google.com,redhat.com,resnulli.us,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,mojatatu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim]

When red qdisc has children (eg qfq qdisc) whose peek() callback is
qdisc_peek_dequeued(), we could get a kernel panic. When the parent of such
qdiscs (eg illustrated in patch #3 as tbf) wants to retrieve an skb from
its child (red in this case), it will do the following:
 1a. do a peek() - and when sensing there's an skb the child can offer, then
     - the child in this case(red) calls its child's (qfq) peek.
        qfq does the right thing and will return the gso_skb queue packet.
        Note: if there wasnt a gso_skb entry then qfq will store it there.
 1b. invoke a dequeue() on the child (red). And herein lies the problem.
     - red will call the child's dequeue() which will essentially just
       try to grab something of qfq's queue.

[   78.667668][  T363] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
[   78.667927][  T363] CPU: 1 UID: 0 PID: 363 Comm: ping Not tainted 7.1.0-rc1-00033-g46f74a3f7d57-dirty #790 PREEMPT(full)
[   78.668263][  T363] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   78.668486][  T363] RIP: 0010:qfq_dequeue+0x446/0xc90 [sch_qfq]
[   78.668718][  T363] Code: 54 c0 e8 dd 90 00 f1 48 c7 c7 e0 03 54 c0 48 89 de e8 ce 90 00 f1 48 8d 7b 48 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74 05 e8 ef a1 e1 f1 48 8b 7b 48 48 8d 54 24 58 48 8d
[   78.669312][  T363] RSP: 0018:ffff88810de573e0 EFLAGS: 00010216
[   78.669533][  T363] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   78.669790][  T363] RDX: 0000000000000009 RSI: 0000000000000004 RDI: 0000000000000048
[   78.670044][  T363] RBP: ffff888110dc4000 R08: ffffffffb1b0885a R09: fffffbfff6ba9078
[   78.670297][  T363] R10: 0000000000000003 R11: ffff888110e31c80 R12: 0000001880000000
[   78.670560][  T363] R13: ffff888110dc4150 R14: ffff888110dc42b8 R15: 0000000000000200
[   78.670814][  T363] FS:  00007f66a8f09c40(0000) GS:ffff888163428000(0000) knlGS:0000000000000000
[   78.671110][  T363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.671324][  T363] CR2: 000055db4c6a30a8 CR3: 000000010da67000 CR4: 0000000000750ef0
[   78.671585][  T363] PKRU: 55555554
[   78.671713][  T363] Call Trace:
[   78.671843][  T363]  <TASK>
[   78.671936][  T363]  ? __pfx_qfq_dequeue+0x10/0x10 [sch_qfq]
[   78.672148][  T363]  ? __pfx__printk+0x10/0x10
[   78.672322][  T363]  ? srso_alias_return_thunk+0x5/0xfbef5
[   78.672496][  T363]  ? lockdep_hardirqs_on_prepare+0xa8/0x1a0
[   78.672706][  T363]  ? srso_alias_return_thunk+0x5/0xfbef5
[   78.672875][  T363]  ? trace_hardirqs_on+0x19/0x1a0
[   78.673047][  T363]  red_dequeue+0x65/0x270 [sch_red]
[   78.673217][  T363]  ? srso_alias_return_thunk+0x5/0xfbef5
[   78.673385][  T363]  tbf_dequeue.cold+0xb0/0x70c [sch_tbf]
[   78.673566][  T363]  __qdisc_run+0x169/0x1900

The right thing to do in #1b is to grab the skb off gso_skb queue.
This patchset fixes that issue by changing #1b to use qdisc_dequeue_peeked()
method instead.


Fixes: 77be155cba4e ("pkt_sched: Add peek emulation for non-work-conserving qdiscs.")
Reported-by: Manas <ghandatmanas@gmail.com>
Reported-by: Rakshit Awasthi <rakshitawasthi17@gmail.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_red.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 432b8a3000a5..4d0e44a2e7c6 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -162,7 +162,7 @@ static struct sk_buff *red_dequeue(struct Qdisc *sch)
 	struct red_sched_data *q = qdisc_priv(sch);
 	struct Qdisc *child = q->qdisc;
 
-	skb = child->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
 		qdisc_qstats_backlog_dec(sch, skb);
-- 
2.34.1


