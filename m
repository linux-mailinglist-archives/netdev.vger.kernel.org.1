Return-Path: <netdev+bounces-267878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPoLOIv6tWkI8AAAu9opvQ
	(envelope-from <netdev+bounces-267878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E5B28F9F2
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA2573029440
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ED41A2545;
	Sun, 15 Mar 2026 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HXJGz4yu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C519F11B
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533826; cv=none; b=tyi9bp20T8kRzCCoBCCNbguvb2PN5gUR1/JQVTIJ868UrvRVDlfyD6zae0BkphSXS4GrPqYuWTZGZqhS4nvgRPjw7pCaH5SzMP6r5KNgTYvIkDzNEGGaPTbxyV3i6ZIZpEAPfecrkDFCOhRTZvZyCoihyHOiJBV6aRfb5Xwlc6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533826; c=relaxed/simple;
	bh=DLuRUgUbq6hEa68nv+TpNPOWo/SRn0zHG2x4Fa9R+ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjHCTl1IP6T656HnLBy9ooV0EeVU28+MgO6uYL0+1ik3oLlN943aipVnAr30zCdAlD+8mbLsSugB9l4L8Pt+adYI6wmDP2XtDho5I2+4M8ouJLHOz2hQGaOd9CQkLEZY5jJZCC2bexgRcR/W/0QyMW6kyKW1kYg0htRb+KJJOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=HXJGz4yu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-359ff894f0dso1222490a91.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533824; x=1774138624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgeOHZnCUQ0UMbyKSrvMETMddysqYMYVIqRv2/Q1+lw=;
        b=HXJGz4yu0DlIkyvydjsWTbEDduFNCI9A7mkDF/NQ6S50hsv1Ls6btKDGui12lXsFA9
         JVSwcJcIpJzzxiQak0C//lIWAlCrwFwQFl/w2ezd+aDVOilMpVyGyopUk8EsjaSLLGAU
         eUGt3DmUBVFs0/I/SQFLZb9A4XpanA1I3gj43ihI8swtdTiRwqtDqEOjYEjVwyFFDqy9
         NLgSek2vff6Oc5s7Jfdj0frJSp7FsKu2ia6V/QtdUKbYpVWsw4v/yk6Lqm1FMgyU5fLP
         PbMHlWrk7yIUqb18SiYlCeTvp43opCYZ7c454maPS52WvXf0qSVIEl2+k29UwDJOSjTV
         Y1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533824; x=1774138624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgeOHZnCUQ0UMbyKSrvMETMddysqYMYVIqRv2/Q1+lw=;
        b=QELMihjDCN/rYVUKecJA8xYahGOX9fytQ5aaXKtio/u9gsRyeT/SR3Ke+IXdXqDoKs
         r9QaAM1z2ErOoW+KNdrpHcsoREuZ33ty0cPFLA+JpY3A5vo8zNm/9HK4g0BGom5yvhbt
         cLKG4MQ1C5dx0/7iWidu+2psxiFZDWY/HnxsL9ZXiTC+uH3+AwHVLzEKtNJq0Y3UUMMs
         cbcziD4Q8PxbT5YgUWwkyY8XIVqBuxyNnh8dMfKvOCKaNCp0XSOSIB5OQMCPDcNrlqdZ
         Ez/6Qx9Z6ymw6gr7x6MwxpICmhNkQqQ7zlGv5oU+kvATAwolWc5/EhxmcT/IcJRgFVW+
         76Hg==
X-Gm-Message-State: AOJu0YzAFgqZwHAPT35269C6EPKaS1OVq7oUxnfVJP57o0fwDd53ULar
	GhoThBwy9syoL3am6bNCi3Ggsxivn3TAz/rmGwTK/DqQt9Ku7D3zTeJZKyoO832raoa7vl0c6vt
	tvXg7
X-Gm-Gg: ATEYQzwT9/h6U6CSN5W3gW3qoQ3BiHY6GlNaX2SVXmEAmog4NtaUiYgbvrHvcKJ+0rq
	KtsfKM3PA/Qfgvkzk30+8dfw/mfRzzuT+tNKYsNpv+xnrf+i1ogzLNFjCZMyKSlIKhhdObs4qI2
	s0/0diJThEmiSxfwBbs7tcHxxZht0aTMwkRCwFbyRIU2s1eHfF1+Jb+uS/bJ1L2A2bPJGov5g1R
	+/zTwEEVbwMyvcI3Q8slnGnECXt35evn/5ikU/8bHv2Q2/zrJBdzx0oTzVlFN+lgrC3RKPixnDj
	Uxj0U1hFkg/iWcfgQQUMHh3rGptxUI+xZpFr7PRIOmmbTPzWNORz8ruHlhueU91r+51a4EhAZS+
	6edh/tD0EM/q+cRK++AFPG5mapKytK/rwwx22SrbRTdbl6UMk6nKoN4xR886iEEM2UVueU4gWvm
	FGt2ksYKWgJiU4BYeBhrtIlVfI8ysunDet
X-Received: by 2002:a17:903:2ec6:b0:2ae:c9be:5f2c with SMTP id d9443c01a7336-2aecaa15da9mr81894805ad.21.1773533824514;
        Sat, 14 Mar 2026 17:17:04 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@vger.kernel.org,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [PATCH net v2 02/10] net/sched: netem: add per-CPU recursion guard for duplication
Date: Sat, 14 Mar 2026 17:14:06 -0700
Message-ID: <20260315001649.23931-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267878-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,willsroot.io:email,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: 29E5B28F9F2
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


