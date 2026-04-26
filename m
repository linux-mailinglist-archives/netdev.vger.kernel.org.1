Return-Path: <netdev+bounces-281184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HDzBPFi7mnTtAAAu9opvQ
	(envelope-from <netdev+bounces-281184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:09:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F9A46AD84
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BDFD300461F
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D920437C900;
	Sun, 26 Apr 2026 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="YcaCGIEK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBFA37B3F9
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230572; cv=none; b=gdw2gMQKDWHITOc4OOwA0YXVbGB2f/c4e7WAzm+5RKQeTa5O3bpkVkeg7hQ+fnc1z1Qb6H44vrrGvNn+9EoOsWFet9SGFwF2zd1tYJlW9IrK2PzYShqYW0j8A0wbGcb/Od3aclZxgYuPjOt8rAIzf6OCfIkyZDceOdXwZ+qQma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230572; c=relaxed/simple;
	bh=HXDnuDpouIyLDrFkgjAoL1VPjF4DSnY0pETnCz2b9ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZjq/AsjppEsAhILn78wdh9VBE/J8MLsDOPO8asEDOzPPzllH0HUpYs8t1HXDuKJkkcHIT+KQ5iKa89WIkHhzhDWwfWghf0jgmmXw/TdXHv/ucN6FOMLqt7DIZE10Hhw2FcChFZiSxfhJJfzoJqzIqGnJolPjqWOs6+KqNgIq74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=YcaCGIEK; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso153120416d6.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777230568; x=1777835368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nry6L3wAL8tEcnt66RATfsEHOOjZrdSPj89oefdiTRE=;
        b=YcaCGIEKOHbfPnGS9R2jbHKyNo93jwZEijevy8mrujqJf6+jleZ8oKecMa4eebJ11+
         FqaLqQcgdY1Y3DzPEoEkQpqPFnpWiN761rC87NorrChxPxHwSQ6c3cH4qjOBQgz8sftn
         XzdJqK7xo8kBZB4oylTtoXUwrosnhYfe9l0iRfFLFHBysKxqm4MX+C4s2rTih2qjphr8
         gG0GZN1EgSxUo64FWHhHixIv4+xwzwJMLMILOUZQGLbk3xb3OVlwcT8f8A/ErnQNEzFy
         6QQCdztgkk83XFz8Sj9wY4gso4lxGxyGWRcxkOeYAxemOL0CMI53n0ItSYy9adsZdzu9
         wSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230568; x=1777835368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nry6L3wAL8tEcnt66RATfsEHOOjZrdSPj89oefdiTRE=;
        b=bDo+HffVuVh+oB6hnJBlpoHIgNPKo/yKQPJqLYCylkxQBv+elVGdvG86iwA5uY58/E
         +om/Bkl3qZPY5HbG7MWeugKpJtM6ukblAwDhzUav6M/MyWa9kw/RGGi9gowYCWCLkT2U
         wPYPbXtCovILIcKSF4vl5+HeTi3o0zr2lfw89A4M5wuVW4tQTED2K7VtpXoNDu9bWaa+
         W3GUrN64OlFD4lSEPIGudWV+Vw82YsTPckf77Cxw5aYxWHP9N4JohrTKOB+j6qlOMQPd
         QcNSZ8z+L0m+hwLGF/E6JNlyRwESKd/nU4mqViubEfZJMCCZdbfTD5tIhYYX1uWQdnbJ
         hWEg==
X-Gm-Message-State: AOJu0YxxyT210DlOSqpdQp/v6StaVBmePMUITCRO+yJmenp3ILyjRFZi
	2Y1zoX6y7tlI3lUpRNiCx+TAls6gX4w7uplkNapptL5+deYd0E9NEAiJ0Y2hDTJ86MAyZ0aGuua
	mdJ0=
X-Gm-Gg: AeBDiesJZdoZ89UfLPpk7f6hFgMMiiB+Yw9DwzNsLmw1SUMNIbcuyfAFESkeiQSNfHb
	1RlzJhc/IiXkq8Kn90OCvxgC4qfzhHlPIdBvAsGb5NS4TKEEMgtH3/5io5tDy+dnoIEG/G4gQ6y
	VGlGF5yIT0V8EYxaZSFgP3E0zKtKWOFEJnCuOQUEg/mHvom1lvXQncvoA85DSdAF08T44lG1Y9Q
	XRLggdLe4vFvc9x+EAZAUdZLJ5M1LVj1cu5WneTxYHkMqKGxF4xSxDj+CKIRAOejAjQ1gq/eH5T
	GG+cN5veo8HwH/Y/NWdBV5MGN8/bhnzdY/PNVZlIi1msVjfSYUMXne5aDiFdHQdBq4sAioDAxJk
	LWvb315FLT2Qet/NYe32Sq7cNk98k8jeqjsPAC0pP2b/le/1gL1S2eOyF3F+KHXGdvIUEgCTEuC
	aHfR79kaizUjDbpJhhLw9IrhVUbhOMAtLnK1sGCW4989sNWv2ohe0v0FcGkikAh/XqcmdtQex61
	vDnxTIqwdqPEBLegrZIY1ZdNVmUuebwlnP7rInC/A==
X-Received: by 2002:a05:6214:4703:b0:89c:8709:d238 with SMTP id 6a1803df08f44-8b02816d232mr539962426d6.40.1777230568570;
        Sun, 26 Apr 2026 12:09:28 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm245421306d6.30.2026.04.26.12.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:09:27 -0700 (PDT)
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
Subject: [PATCH net 4/9] net/sched: fix packet loop on netem when duplicate is on
Date: Sun, 26 Apr 2026 15:09:11 -0400
Message-Id: <20260426190916.128489-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426190916.128489-1-jhs@mojatatu.com>
References: <20260426190916.128489-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1F9A46AD84
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-281184-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:mid,mojatatu.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,willsroot.io:email,syst3mfailure.io:email]

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
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 8c6dea196089..d595eb03dca8 100644
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


