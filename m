Return-Path: <netdev+bounces-294139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPcMNIayHmr7JAAAu9opvQ
	(envelope-from <netdev+bounces-294139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:37:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03D462CB83
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 792A03006924
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8AF3D3D09;
	Tue,  2 Jun 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgq40C9T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FA1A6811
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395671; cv=none; b=rVhcurt/5wvRMnkSkp4+SzJHtjefmqMRWJSPm2EZtyS2N6pLnAk+Zb+tTuyG69UcQW3jz5BnzBA5tozr6w0tYGpcWSG7+Ijn+ejA+R+9KHFnl9inF6w2XDmTvaTnhgztFkG67oax3+QWBKBuVm5zIOAUaL828lNhdwGfBpRAY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395671; c=relaxed/simple;
	bh=+4cHcDc8kuAJc5aNRNtmAM0yDMNGCgeOgwIdNSW4zwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hCnHD3KWO2KZSLen6krIOpQ5ioJLaEDtLQtVU38vNZHl3zKf6pHhKd4TQU0XfJ0qiBHR2+0xMpRU7ku4tqsOMRjqvUGSJ0pJ33xV/9s34V0ILghpX5qG2Ic6IT4rNNJIin/8WlK9PUHbt3O1xacOBqkRbAl2hy8YTh5Ih+J1xvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgq40C9T; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0b9328c4aso18448615ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780395669; x=1781000469; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ikY1El5docE8q+sLqTg4r7/Wm1ohIOfVrhz9dhSUA/E=;
        b=fgq40C9TYIWL+fv6LbkJpmGDIES7/9bEpbivS4wivAPUci37biZSP+rPFqqaIMxhS6
         qnIUtqObTORqhzVwkpuXuaOI2ez/UPLocoqASPhZsIiyN3YzKUiEMX8TmK35BWmofEI4
         lfZ7sC/hTGwzDe0JDm8GPtF4Q+9emyjx+K/RGNKMT27PRU8UgTtKo0vpCYuL+vVp/L5L
         NOLo85kmNenkdZE0O8MDxw4NFcyoYT7pgeLyrOSUPtqGpdbqZf04bU6undTc6zsh5y1k
         fs57pfvYZWacYIfqwr+JdxGTcGy9oW5naS9jpJ9NEZgxFV0KcwGN6EmnKyI2z1/1BUSo
         guOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395669; x=1781000469;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikY1El5docE8q+sLqTg4r7/Wm1ohIOfVrhz9dhSUA/E=;
        b=aOriEIcu76INKd/rmjpecg99MzQkGF+0J9sNHwQxCaz9iS+1SA4x5QYK4Cg81xj5gi
         2zEoy7v3jn1dwAa80cSgIcIghppySnSDI5kHBo90D4Sw0y0V1XzVDjlTDRUzqnF8ixAJ
         yKSmLugmBj8xDXCWelWLYeEyh83r+/YgNbl0hwS/hs2RSCnrW9PipQIzZ8bJpwMsk3q8
         pKYidnyDY8+PXHTXxxz2fHhwLckERVOPmxX29IcizNr8IA2zoB0g+soL11j/o7oWFf46
         SZtur0chrJIqa+ly72CpqmDmjaYhax2dWNbxBxpb6GtXZrYmNlId7qkhIOSHiCjPo65S
         B5OA==
X-Forwarded-Encrypted: i=1; AFNElJ+F6e/C+KK+zWuMaGbAwQyPxIp9aTRh1DHKqSL65FqvRhwJMZlH5kPsoxNgMWAb6weXWvFOjtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXH6yGqYBEknh8ualWrkWCxwRB2oaIGXWJBmjGVI0dRsFIL2q
	Dx1AXMfvCdWwTFgpF9gDWkUaHXpEu4IxMwHPEvmVKUnlFZf11sgPhFsn
X-Gm-Gg: Acq92OHtdkXdn6SrqII9RHHyBpmDqsCpBNj1Gqj5H4dr6vSmv/EFGr0KaNuk/WYD/Py
	qD769e9wvuZADBtGQUVacjOfWP5imFti6iMkQnql4LUMVvMqlGXavQ1RqUcXmLDhpuJZtgOg34V
	YAcHMPPILHLuZDtM3NqVjpK+Jr9O1La8HDh1wANkDBvZDFo34nH5ennu1gLiMPkWCYekVwL98KQ
	YKvXL1nAOQl10hnOS37oPdzbsGVVlE808KVRzx54ltkwwWBYq8bHMsr4Tw8I1ihw11E3HGVwb6Q
	jpW7v78N0IYPTDV/GjbdWGWn07/rNNI7asxgad0APWI1CBXmePxT5KnNsNEf4Ur5eUeXmJzBo0D
	P9UQpsTVrLWh9PmER0i7kxR3CBTm+TpCN9u53q1Fjf+1fFnj9ZrUefBWva6mK4iBEC0CCk6wIrH
	fIEmvjIU0mwKGriS5yjJp96QWpQ3BVnYmAUycP+mClfzaJRa/puxpN/Y4cxgoJTLcP
X-Received: by 2002:a17:903:1c6:b0:2ba:25ca:b49f with SMTP id d9443c01a7336-2bf367d6cf2mr167163525ad.17.1780395669392;
        Tue, 02 Jun 2026 03:21:09 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a2dbfbsm131215415ad.37.2026.06.02.03.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:21:08 -0700 (PDT)
Date: Tue, 2 Jun 2026 19:21:05 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] inet: frags: fix use-after-free caused by the
 fqdir_pre_exit() flush
Message-ID: <ah6ukYq5G98LshdA@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: F03D462CB83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-294139-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On netns teardown, fqdir_pre_exit() walks the fqdir rhashtable and
flushes every fragment queue that is not yet complete using
inet_frag_queue_flush(). That helper frees all the skbs queued on the
fragment queue but does not set INET_FRAG_COMPLETE, and leaves
q->fragments_tail and q->last_run_head pointing at the freed skbs.
The queue itself stays in the rhashtable.

fqdir_pre_exit() first lowers high_thresh to 0 to stop new queue lookups,
but it cannot stop a fragment that already obtained the queue through
inet_frag_find() earlier and stalled just before taking the queue lock.
Once that fragment resumes after the flush and takes the queue lock,
it passes the INET_FRAG_COMPLETE check and then dereferences the freed
fragments_tail. inet_frag_queue_insert() reads FRAG_CB() and ->len of
that pointer and, on the append path, writes ->next_frag, causing a
slab use-after-free. IPv6, nf_conntrack_reasm6 and 6lowpan reassembly
share the same flush path and are affected as well.

Reset rb_fragments, fragments_tail and last_run_head in
inet_frag_queue_flush() so a flushed queue no longer points at the
freed skbs. A fragment that resumes after the flush and takes the
queue lock then finds an empty queue and starts a new run instead of
dereferencing the freed fragments_tail. ip_frag_reinit() already
performed this reset after its own flush, so drop the now duplicate
code there.

Cc: stable@vger.kernel.org
Fixes: 006a5035b495 ("inet: frags: flush pending skbs in fqdir_pre_exit()")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Move the queue pointer reset into inet_frag_queue_flush() to remove the
duplicate reset in ip_frag_reinit().
- Drop the INET_FRAG_COMPLETE setting since it leaks the queue on the
fqdir_pre_exit() path.
- v1: https://lore.kernel.org/all/ah1Sw2g-I89BRRiT@v4bel/
---
 net/ipv4/inet_fragment.c | 3 +++
 net/ipv4/ip_fragment.c   | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 393770920abd..1127519b8416 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -328,6 +328,9 @@ void inet_frag_queue_flush(struct inet_frag_queue *q,
 	reason = reason ?: SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 	sum = inet_frag_rbtree_purge(&q->rb_fragments, reason);
 	sub_frag_mem_limit(q->fqdir, sum);
+	q->rb_fragments = RB_ROOT;
+	q->fragments_tail = NULL;
+	q->last_run_head = NULL;
 }
 EXPORT_SYMBOL(inet_frag_queue_flush);
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 56b0f738d2f2..c790d2f49487 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -250,9 +250,6 @@ static int ip_frag_reinit(struct ipq *qp)
 	qp->q.flags = 0;
 	qp->q.len = 0;
 	qp->q.meat = 0;
-	qp->q.rb_fragments = RB_ROOT;
-	qp->q.fragments_tail = NULL;
-	qp->q.last_run_head = NULL;
 	qp->iif = 0;
 	qp->ecn = 0;
 
-- 
2.43.0


