Return-Path: <netdev+bounces-267606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HweF/Z+tGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:17:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DE28A16E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 925D4309F098
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8837C92C;
	Fri, 13 Mar 2026 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ugojGCBW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB436DA10
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436625; cv=none; b=RTYcHXT+6bLw9DgDDvz9Sw+AkNmaL+vtNBkd045Of2Jl/KcezeiFecDiX5ld4DMUtG/tInneRPfsSdni31SUGrRPjoT2W+NwEBXYFm4rHT0v7OtdQ53kDLElZogJxLkaYz996YSzO3RRTAJn2F4mN5WkutqsY6rHkVCMoKk9jOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436625; c=relaxed/simple;
	bh=DLuRUgUbq6hEa68nv+TpNPOWo/SRn0zHG2x4Fa9R+ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C03lD2C7Ekg9K7ryGmTarO+XIadvA2vCR3oDS1GHt4bWGXFvP/NejB+YJabL/xpm7Lwa6PXKRDRoDIP7aXJe+660Yo5JoKJsbJs+jfVTy/F3NvsrypDtT37g6BAJcloczaTI/XHym1Um/YO3xzF7qyyLkE2/mFBK1L5J0fe5D+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ugojGCBW; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso1128107a12.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436624; x=1774041424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgeOHZnCUQ0UMbyKSrvMETMddysqYMYVIqRv2/Q1+lw=;
        b=ugojGCBWCK21yrpDQGXES6sMrfi4UXDDbgY3i69+XW29UAcqmR8Anex6RNb9yEhUYv
         orC0/Wr5dfkRExoelY4Fq+95ZHDpPSTB6bk4FgbZP1SlBOV+3SiXIOrIXxFQVjTNCFTL
         DNtWOpT2Uq+b6qkhKYwNHT/GiJzuaNRsf1a/nvwQ0UxZFInTGfZuBRfWZ5DugndlKlUS
         /b4cEc+QM6qL66XJCkWrwch+clivL/DlAWsCS3RcGX8suDB+8iFbPY30iynOaQjrkXaT
         di+hkkqplYnKz2eqoL5OloWvVMjx5CsbOUt/o7BHYEPHXxy6Jh91LTyUWBPhnVmaE4aI
         UYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436624; x=1774041424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgeOHZnCUQ0UMbyKSrvMETMddysqYMYVIqRv2/Q1+lw=;
        b=YylcBmY7j7wgtN4WUrRt9NuldOtNsld8cQgzDHh6JBxXnNhDv8BVIVHU8GrDse2RRQ
         0a3k7sTGUTk6uvrOYpIqzcx6GWOuyHGIxxiKgem+CmAhsStzplwU7lge1oajSFNvdMPw
         IS8ICa1ibZIr4UWZsMSr7CRwcafKz4yV82hmlQDvfpvfDzTB6cvlzt3kFYB6yL/SwB36
         AhRQPKJSSDy0zOFCiq4i/TM9ou55auQdgI8Is+KGQVbNvm55P5WZgDWt6aCHrIi/PtpM
         rDfXk5CplouyGFTxGcdAyuZX0BEyveRT6nByfjYOTvnxqSmMcsKauDp559V0SVyn5xA7
         BMdQ==
X-Gm-Message-State: AOJu0YwnBt1K4I4JKB1gPxO3OmSo1SJ6jchDKqFjasStdk4G/OrF6I3S
	IG/JpV/MvMq6XJ6j0P7s+gtD8eAzL5peub/Psxa6LA3RFrDDczN9ab9B4MIjpTHyyJziTMcBBlH
	D31Njyow=
X-Gm-Gg: ATEYQzxBZPFez31qQp18b6IfDLlfI7vAf2nAk3tsa0d+keSO+L25PM5OyOVLocUjJ8Q
	KmZ9el3Yvvpi/sHAIaMkucXirNyQY9G/YV/rUbVGCLzTdKx+PwvGXZ5SalY6rUm9w56ws6mwQqZ
	RKeS1Efi0viPwZ4D8jqggxR6oqJpm0YYZjWowDZf2aj4CJ4qgJy/mVPolqh7alsqFjsAJ2QCC6d
	4tCvdhpTx+/Volc7DsgxNPV6uZkB5PKZuhcWgBp29HNFA3bzqKXzyhAMasTujoElJ3Ip6mqk0FE
	IAf8Dzug0OTlE/aqCKbNzJyRPojus0zImjjnfnbpF5bOvWloIcC4lpnZmRuX+Ejgab25l6ug0bi
	PEn6HGn4UmhObtmuWzwqNX44vbipOexOPTEmfwdSLPgcG+8cTXY9ucWRrOl5gqt/1ZQp74UgkRQ
	6zGQbRpIrvf2iJAJKcYBKkR4i2yk3kc/mU
X-Received: by 2002:a17:903:1b06:b0:2ae:4f6a:d2e6 with SMTP id d9443c01a7336-2aeca9438c3mr53663565ad.20.1773436623944;
        Fri, 13 Mar 2026 14:17:03 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@vger.kernel.org,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [PATCH 03/12] net/sched: netem: add per-CPU recursion guard for duplication
Date: Fri, 13 Mar 2026 14:15:03 -0700
Message-ID: <20260313211646.12549-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267606-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B00DE28A16E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a per-CPU recursion depth counter to netem_enqueue(). When netem
duplicates a packet, the clone is re-enqueued at the root qdisc. If
the tree contains other netem instances, this can recurse without
bound, causing soft lockups and OOM.

This approach was previously considered but rejected on the grounds
that netem_dequeue calling enqueue on a child netem could bypass the
depth check. That concern does not apply: the child netem's
netem_enqueue() increments the same per-CPU counter, so the total
nesting depth across all netem instances in the call chain is tracked
correctly.

A depth limit of 4 is generous for any legitimate configuration.

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220774
Cc: stable@vger.kernel.org
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 0ccf74a9cb82..085fa3ad6f83 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -21,6 +21,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/reciprocal_div.h>
 #include <linux/rbtree.h>
+#include <linux/percpu.h>
 
 #include <net/gso.h>
 #include <net/netlink.h>
@@ -29,6 +30,15 @@
 
 #define VERSION "1.3"
 
+/*
+ * Limit for recursion from duplication.
+ * Duplicated packets are re-enqueued at the root qdisc, which may
+ * reach this or another netem instance, causing nested calls to
+ * netem_enqueue(). This per-CPU counter limits the total depth.
+ */
+static DEFINE_PER_CPU(unsigned int, netem_enqueue_depth);
+#define NETEM_RECURSION_LIMIT	4
+
 /*	Network Emulation Queuing algorithm.
 	====================================
 
@@ -460,6 +470,14 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	/* Do not fool qdisc_drop_all() */
 	skb->prev = NULL;
 
+	/* Guard against recursion from duplication re-injection. */
+	if (unlikely(this_cpu_inc_return(netem_enqueue_depth) >
+		     NETEM_RECURSION_LIMIT)) {
+		this_cpu_dec(netem_enqueue_depth);
+		qdisc_drop(skb, sch, to_free);
+		return NET_XMIT_DROP;
+	}
+
 	/* Random duplication */
 	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
 		++count;
@@ -474,6 +492,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (count == 0) {
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
+		this_cpu_dec(netem_enqueue_depth);
 		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	}
 
@@ -529,6 +548,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		qdisc_drop_all(skb, sch, to_free);
 		if (skb2)
 			__qdisc_drop(skb2, to_free);
+		this_cpu_dec(netem_enqueue_depth);
 		return NET_XMIT_DROP;
 	}
 
@@ -643,8 +663,10 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		/* Parent qdiscs accounted for 1 skb of size @prev_len */
 		qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len));
 	} else if (!skb) {
+		this_cpu_dec(netem_enqueue_depth);
 		return NET_XMIT_DROP;
 	}
+	this_cpu_dec(netem_enqueue_depth);
 	return NET_XMIT_SUCCESS;
 }
 
-- 
2.51.0


