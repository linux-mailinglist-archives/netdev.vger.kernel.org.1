Return-Path: <netdev+bounces-291310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SflxOhpAFGo3LQcAu9opvQ
	(envelope-from <netdev+bounces-291310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6959F5CA771
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6E613021D2A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2FA382F0C;
	Mon, 25 May 2026 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="A+lTfFBV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978C382363
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711979; cv=none; b=q8vjRtBnOYioBeOdUATJ4I3OQ6QTgkCvG+Q2IPVEmsCBst8iwJSdXu1DsWFzJmdz+BjwPYjLZwqhV4AD8b3T5ra32Vo/HsWpPIn5asSGP2ES7Npb7nhCIRji9Q/QC7dKtg9nzomeXRDOppVDrp/RRxQ/q6wnu25oZjPhF1O6vd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711979; c=relaxed/simple;
	bh=yPgjTOZ+CHlxQxQltL0lUsh+r0mNPXrybIy7UuiXCSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecWyBwwmAyyQbh44bU1fCubMkCYghAOsLupPV0eXc7xJWAmNURf/dosww0sOK1S3XnNTXnVSpoTEIBi/kG4nrC9SiI7zafImGY37cjZtiB+CY8Q7rtIw3j/9iiGG4yCNizxeJCpb8FqkNFsUSDcKnCgZhmhBa+0BleZ+vso0zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=A+lTfFBV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-512f750d4b2so104975631cf.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779711977; x=1780316777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91XcBUqYBHCm5bvozs7KldmJh5O+F8tZzxFjm3TrM/E=;
        b=A+lTfFBVhISs360px6emURqrpWm0paLs+Hu6JypzcchMgbBmOBGEFRGvnt48q9Wueh
         tUlp7hlVG5rVVlJYzq9HN+OUk73TFoBEKRBrWJBfv3eYcsBWjAlHa/oQZw58YNWZQl+8
         /wjSZU4g9vB6c0vx2gw/dsm/HvxnOadyXJZAoXYZ3lDAfSR/FGRAajgP67EZVri2l1zg
         W1SZeYPsmoCCHnxC4Kna6EdHnbIj28KklLGjc8D9/X0JkhYjMWT210qrUXmnRfXX3UwX
         NyPbaj4GNnMxPY5cvX+/HvgmTW+XuM7ESDg4eGFd9S/0HsqzrxKGUhJfE0/WsDvI8DlJ
         vuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711977; x=1780316777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91XcBUqYBHCm5bvozs7KldmJh5O+F8tZzxFjm3TrM/E=;
        b=dJXCh+HlIVuJX1s49lq8i9s7GIU36JwqenwP5lpeuWlPzD/hxQoAHSbMtWTJ4IP9Mj
         9C0iJaYk29PcC6c6F7k/ZUnENBkzhUJZCZJoYSKDJaJpcrhW+VRiNz5eW/YVNidK/kx+
         CaUIna6oOGgyNgl7mjwivjsC5Mx4MA/24eSKXkuaFB+gc+GX1fjtRsXCK9uiylUPH7IL
         vVWIV60EA5jZxWsv9Vd6MteV8vvN/Ys+8Mq7ClzYDos5wwe5eWLgz+/kAeajG6P53C2Y
         ZRY2ndM6gHuiijW0sLET1BYoNri/wKOYCLL6soDYox/foYjAf7V4zqvwgbgEGwODYcbJ
         MlIg==
X-Gm-Message-State: AOJu0YxaUwnzJjtLOJ4NreoTK5omsMRiHSnVMomk7hMIxQw0NzvfCVsc
	Q3+yhoBA3GjQM9dfvVpUmgeIycUL7gnhagmZAzTGrlDzBS91B3H1Cu/YX/DtDZy36MLeN9dYl0F
	MPRquDw==
X-Gm-Gg: Acq92OHjGfC7daYKhl0VqJb8za/RIqu4Gj0B+LxdIK+xSqnpTJiXH05mTdedIJ7ed4Q
	3kjuzYJ+MWWTRNtUZs8eymNS1oIUQjc10wXxiAiG5tF77vNFf3yi49zfO0WklufDxtsZ9tG6BPG
	nYdmeU3GWOnOInOBVnUSunsvi/0+a8c+SsGbGV4UmY5SkAx+fn2OQoRU4roysNFFH4o1jmMCxYD
	f2OTc8vIwW1T/P1ap9/6CvYYrZLYgFj0JP9kgX81D9xbNbiEeq2VdowA+trDFBwGPJZ0iTCaLOy
	nm+vTKmd2+c/FlT7dExQE7RaLZDdg5SIpTL09sVNZmmUqEmrEwsZwxGbsrf2Mr8X+dSfM1tS3zu
	64vmQxBd02RdWLT6TrMufRNBya0SYz1PrK3++GhT3vIYEvH/3emvtZlGG4jiW1luO6E28idOpdP
	FwDpqJmgYb1SiNfFH4R4CS30LA+lU=
X-Received: by 2002:a05:622a:5811:b0:50b:4b3c:7554 with SMTP id d75a77b69052e-516d4285a0emr211824851cf.10.1779711977199;
        Mon, 25 May 2026 05:26:17 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm91351761cf.24.2026.05.25.05.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:16 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	will@willsroot.io,
	hxzene@gmail.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [PATCH net v6 4/9] net/sched: fix packet loop on netem when duplicate is on
Date: Mon, 25 May 2026 08:25:51 -0400
Message-Id: <20260525122556.973584-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525122556.973584-1-jhs@mojatatu.com>
References: <20260525122556.973584-1-jhs@mojatatu.com>
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
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291310-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com,syst3mfailure.io];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,mojatatu.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,networkplumber.org:email,willsroot.io:email,mojatatu-com.20251104.gappssmtp.com:dkim,syst3mfailure.io:email]
X-Rspamd-Queue-Id: 6959F5CA771
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When netem duplicates a packet it re-enqueues the copy at the root qdisc.
If another netem sits in the tree the copy can be duplicated
again, recursing until the stack or memory is exhausted.

The original duplication guard temporarily zeroed q->duplicate around
the re-enqueue, but that does not cover all cases because it is
per-qdisc state shared across all concurrent enqueue paths
and is not safe without additional locking.

Use the skb tc_depth field introduced in an earlier patch:
 - increment it on the duplicate before re-enqueue
 - skip duplication for any skb whose tc_depth is already non-zero.

This marks the packet itself rather than mutating qdisc state,
therefore it is safe regardless of tree topology or concurrency.

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Closes: https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: William Liu <will@willsroot.io>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_netem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index d97acd2f3923..17a79fe2f091 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (q->duplicate && skb->tc_depth == 0 &&
+	    q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
 		++count;
 
 	/* Drop packet? */
@@ -540,11 +541,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 */
 	if (skb2) {
 		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
 
-		q->duplicate = 0;
+		skb2->tc_depth++; /* prevent duplicating a dup... */
 		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
 		skb2 = NULL;
 	}
 
-- 
2.54.0


