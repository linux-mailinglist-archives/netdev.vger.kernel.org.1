Return-Path: <netdev+bounces-272197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCNGJ9t4xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:20:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23253339F8D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5591C30635B2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133373A6F0A;
	Thu, 26 Mar 2026 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Id50Te6J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75983A6416
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549064; cv=none; b=LUVx+ekuRojIOB7k4XnP4/PPJOugVWq1PXmnDBGYl0/EzCCBdE1EWZ5jfUnL6nK3vOFBr0e5tM+t+HEWTe+qMI0N8V9pAKRW23vGWvnNOyUSWfTiXoPsflXMOP8CmUM/VMD2SHetoCUqlmMGqeERh58Q/OiyzTtLiI88AXcVQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549064; c=relaxed/simple;
	bh=mArRWUbnReNXeDuPsvJkqLTeL18eozIQGlQ4EBv2OJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbFqPMKLXQ3zYXc7Dt+3y/X0oOcUyfoVCoytaFfNdLjB4kJE0fy9zqMNXoXDZZEDHfcInyr9xeTOOphmoFIB1yRdXl92DIJ7pLn7x2l9JacwJbHmIQebU9xNGEn15Ode4zMKJVxmOiyxpsZhIwqzYrW+zr1FGaJwH7ECQ+firBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Id50Te6J; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad4d639db3so6120255ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774549061; x=1775153861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL3YJ0V6J4xlK4RXV+20W1VV+9Vfq7bs9W3HHr+lr9M=;
        b=Id50Te6JZEFMhKv0SuUlli+4wkobJll1WpOtwmcqyzpcCsHHTv2NGWIeYaKbJGfWHs
         +4zS2VlJiLM8OpRZnQJ+uPFx6krULpdaf/izHhADvYdV+rJ/TcaIQ1VY/+mSYQdfCaTa
         GlpPZg65fnqp1ITXJxxPlamf57bwIHFzeft+V1ACOSQ8Z2xaSmrXMsjlZlmigsv5yQfR
         moVbhuWG29JTxjYp8ZvtTen+6Ipob/xCLCsuUrjx1YekX6G4rmepY5e+NmqqsXcgCOcH
         71cdeO+RmexVa5RxCzjlrdQRhvlh9uiJCLTF2uEqdnZ0btkpW0Iokqi3Sj6G/prpD2IO
         RBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549061; x=1775153861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hL3YJ0V6J4xlK4RXV+20W1VV+9Vfq7bs9W3HHr+lr9M=;
        b=CuS9Xvbi8tH5tH33vnJWpJes0ehyDagA/ykgosLkz6+T5+FGUxomvrqsTH+tCuNAr3
         8kBNgBwgb7E6J9GEGRUvLAwKsiyUxzhfSOxHSSptUAJnJXY9guOmo5KDGTv0dnGwtrFG
         cUJN81qLWDqJby6XIoJ9P8rGSNDJOZdogR4BPHNm/zkssZYTMwNLjs+yMELkdqt8+9Zi
         le0WCscfMRaLaBqO+5VyG01p4DztYqCLsnkpBFve6x8evhBCqjBIG9hlHbopdecpeUQy
         KFnoFE7njW1dOYW/9b7NDUfRDQttAQIoEspaoLuHJX6qKjqX1vaJ43/g95R9JPcvh/AW
         2exw==
X-Gm-Message-State: AOJu0YxERWOvua5QqjVxP1luLeZ/5wII/bVJBuNjZcRFbIHo8iKTWaVi
	k0cgGlnfQ1VEdVtI0Lq1aT1PfzATG0Q3pKM5heubHjcG2I0734HEIstRdnxRyoN8oIiF5LkwtyS
	o1W8q
X-Gm-Gg: ATEYQzwNK98NAAlOpRbtQG6UUhRfCv1x+gw5mksvf+oyfwlBIi3aYcG4MYToReXai76
	ihAL3cLx8Xr6XHc7VNBH6UbKe5r6cOq2z2Q2rQqoowEer/2wWlOJlsiRKsezz+1E6OsIy7G7lr+
	OhiIU6MTE/FGkafma0qFR1QjbDopM3LKgg7BKmVqimX9rAT1TPp8htiof4GC2a2QvLDK7/tIs5t
	ZSdetfRKvZqtzUamLjEmCyEf2tuAp8MIg5OvGD3Wou5TNQQ4FKOeR6/Taw/oMsfzS72YOmP1Jtn
	kj+87/SD7OTZDkWIo5uyiz71TOhOANlvlvY28raONIS53BySXwzlwQbakIohtkXAcysccKwxX6y
	YujoVPiKSh/rpRwTysUcD1qR6kcvb+rqGwsuczNl074ma8oddHl8/9FiuPD3u2SqaHh2ylbbPBt
	4nJk/OSjQfDcbbt87qFQYBppAc/xmoUJl8
X-Received: by 2002:a17:902:ea0c:b0:2b0:c650:6300 with SMTP id d9443c01a7336-2b0c6507204mr20801815ad.27.1774549060983;
        Thu, 26 Mar 2026 11:17:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8c4bd3sm38590245ad.63.2026.03.26.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Victor Nogueira <victor@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/7] net/sched: fix packet loop on netem when duplicate is on
Date: Thu, 26 Mar 2026 11:01:03 -0700
Message-ID: <20260326181701.308275-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181701.308275-1-stephen@networkplumber.org>
References: <20260326181701.308275-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272197-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu.com:email,networkplumber-org.20230601.gappssmtp.com:dkim,syst3mfailure.io:email,willsroot.io:email]
X-Rspamd-Queue-Id: 23253339F8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jamal Hadi Salim <jhs@mojatatu.com>

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
index 0ccf74a9cb82..6086700eb1e7 100644
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
@@ -539,11 +540,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
2.53.0


