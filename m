Return-Path: <netdev+bounces-288009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MW4CJDhBWpsdAIAu9opvQ
	(envelope-from <netdev+bounces-288009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:52:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B205354380A
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9C3C302BC54
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220C423168;
	Thu, 14 May 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="ShlPo6cu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE64219F2
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770095; cv=none; b=pmanIgwe2wACpbMjs6Dw9WrtoG1fH8nW8IkwGFxZtqxnq28Q5nShZEBP1McfoCQqjHN49CdH+BMstbL/LbuhmniyogLTIfCEZGE4n/2AcFQ6KVb3CoTtJJs62w4v6b5RAfJiADjY9HrkdGLeq4nlXHRJdQtOc1HKKHr+xH7UOBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770095; c=relaxed/simple;
	bh=J73eyIqZWe8SzqpAEmh8X74kEt0VGq36CPD4scKMq6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OiIRQ0OmRl/gyRsROvn9b4nnORKODwvmBCZ5D0dinEawEoqH69ddGSlBpzimUhhDSSxP74hVwr6HkhBGgACv4cXvd/iOVGFuCN9+lo66QGPy37YLu3uqbP3xMpQBrlp9fK3LELdA4KXSPn6YDV1p2aYwP4SIVBgl7m/hr9ElSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=ShlPo6cu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9116861f004so70199685a.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778770088; x=1779374888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPRKee6ktKIH+bQQFFCDcM1a1o28h/D2H40LySc+CM8=;
        b=ShlPo6cuRtb0l1p0dAvywK4sR/706SPdTWtfi9rHjnfKbdiaWH8qVgW4T1OG1Rqu4n
         6PRoISZkJnlB73NS/gOgnFuXNV9cnehLafp8qwPXWnCu3wJIf9UAkb/l+JUw8c7h8/lj
         CapTJb8UQxdcAdYk5MqgV/s65AJ2P+9jTdO/7J8RbW1NixlaWMCb97l+LWHx4EkEDLQb
         sDe5M89foJmfzE1r0/KTwrGps0FTcn6on49XBUXdwIvd/APxVfK9N2cXVk/wVyZk4T7h
         SKK/OZHIMUAusWpB3IVDMsyCbGwzjoHboNg0RPMvfL0I8wBG8ZJA++gRgSP7WRs7+zU7
         tL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770088; x=1779374888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SPRKee6ktKIH+bQQFFCDcM1a1o28h/D2H40LySc+CM8=;
        b=CNkPCZm2f3/G9saOkQmb5sotIqkoPA+MAydgPG3Fds5tvLsSPo47+vF53zYhXfGJX3
         SI6bFHRD06Do7WhRWH7jFc1i/Vj3usJTOIt3HX+876EYt2GN8yO2ML+aAkgWDBL3shDZ
         AqDaFGCUaNbBWbcGeutyPzDfMcMRNeQjFimQb+ftFWk97sf9UZlBebgBt48HW0/3QCjJ
         kYm8MOB/CSgtNUS3WSeCFlxi7/vHPoWVtqW30ViF2bTomkbNXzZ5GLhfEvP4nguFKCGP
         dkPNShkASVdpFTibQ13/bJt2y/UdiHZ5rZ9KpuaEU2JF/lD8sE5mw0fZMSG7YQct20J9
         PCBg==
X-Gm-Message-State: AOJu0Yx9xA4P6TzbNZtlcX+fHvBxnRhAxKSZBdWK0R0aCAFOF1Dlb03+
	C6sSy37Ed1LPQqAM6dOfAvcjCl7HT3jmrRNAmC1jbjXCRAhTjE/FTQt0I6ivK6N8d/smt/dvAle
	UpmulzA==
X-Gm-Gg: Acq92OHjXRqi+HrwFj0+oiUpHhEjfD60dD7ePNMQPRSkYM/agXyJIvWUSkgsHnXVA87
	N36FhlEAj+5HdpSi0s+DnRLMEzpFhaqnBXRr5bKmZ9S+v4qN0Q8xIgoW0x4JfBywOQSb1WEfK0H
	EuAMcZ5DNSY1OQN1ooY0rluOBpfTozAP+IvHx0U/pcIT3sS+TFTWtmHSQ3QhdyQboYsdl3U1q7e
	eFZANIs96+0bno+T9DbEaFAKZYxLNEcMIqQTVD95qW/j/4dX0NybkhIAWh19VQusrrsqp4olng+
	VPqI0lNz09anzJkNHYlbJsiUjdV29lC7fXnJj3uWr49jQqKOh/3w4+r0VCiYqkxgI3Zc/5oQHgd
	KPwvYXIMfYdLjEx0PxF+DBr008p3sOxEUTfDJYzsk3//WvSUyoZQDSpNzCX0pvbgzg+VpoOZkfy
	KSya+lqcr1vapibMWJhQMPhLkB7uE=
X-Received: by 2002:a05:622a:30a:b0:50f:b9e7:3031 with SMTP id d75a77b69052e-5162f44359cmr106989371cf.7.1778770087935;
        Thu, 14 May 2026 07:48:07 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm19125461cf.10.2026.05.14.07.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:07 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	savy@syst3mfailure.io,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	hxzene@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v5 4/9] net/sched: fix packet loop on netem when duplicate is on
Date: Thu, 14 May 2026 10:47:42 -0400
Message-Id: <20260514144747.527175-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514144747.527175-1-jhs@mojatatu.com>
References: <20260514144747.527175-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B205354380A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288009-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:email,mojatatu.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,willsroot.io:email]
X-Rspamd-Action: no action

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
2.34.1


