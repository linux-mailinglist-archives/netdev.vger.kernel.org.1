Return-Path: <netdev+bounces-291307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN2qCvU/FGoXLQcAu9opvQ
	(envelope-from <netdev+bounces-291307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:26:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6E25CA744
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C76C4301A282
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C00382293;
	Mon, 25 May 2026 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="x56yXkAf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4A3815EE
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711975; cv=none; b=JKP+i65PJIkzMOorkvqtsgyr1es+gKBPYi5/gt2mih/YiGYrhO+Iz+Tj672jPyBWCpr5gUJQMJGg9V1fFHpyG49/LJJl669fMOtTGcVKyPczTcmftcIoWd1wSFUNp0asxk3ixKN13Ajn/vYJzglWXoXmW2CELM9JsYCAzfvEF8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711975; c=relaxed/simple;
	bh=NlRaPo+/TIto/as/R0nl2NMMMjuQAomRWephPK7r1rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4HJZiD8V6Z0JfYPa99ZX2fYAL++Xym+27JEJXhJYUlJMHqVl2nxPhDS40IQyDnkKp2KaYtUAFzrTPkiQlqxLaFnKxPW7ozGBQw0NGEPCCiyPUhoXWR5dXbcMMUA0ZZ0BKCKv3KlbRsJAd4JMWjKdILwzB5Qny8FZBISW7CzvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=x56yXkAf; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5148cbdea08so80322811cf.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779711973; x=1780316773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jevbolCdVaOvpuOb+BI6Jt/Hrv2mm7IdLESqpbHQPUE=;
        b=x56yXkAfwiO9PZ10YJKPu73lPNTzNvemGJ8cqrSQg21Z85l8YmhPf1BNbbrmUbGyWJ
         tRZzXYeBfVoY1RRB7QQAx9hcZ+5a0jFsXJawfUF8paHpJ330rwJF/OzzjP9bTLLDLNKm
         PgmkStFDzAXNwFLft0smpLk7D39HFwSpri4jEI0tYa9q6CrF3v3nijUNLX6uytDpfTrZ
         2b5DT/hbp6CaRGlVpuEC0VBB9gCi2I9fpAneAgBUyGSlJM6Qx/8UofJf8UEXshOPu6ML
         6fODYDAb3ZZfDpxQxDZhlabQNIYKMxRGaDCF5cYV1RH4KR33u7AzLK1aRlouQ/FkviPv
         8sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711973; x=1780316773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jevbolCdVaOvpuOb+BI6Jt/Hrv2mm7IdLESqpbHQPUE=;
        b=OFq+XxjesXa4bUxAJbaFsgiMg9rbNnaOf46xMR/poFu0sIt0qPNuRWpQseZdO/l3KY
         1Jz1ztHdOl7CKPh0zXZn0CS1KOaN3l2Tzj6Shh//aUxp61+O4TNc5getwTWsiBtOb8Dp
         Jp8an/W/ASS0RH2ZBl6rYh6rQGus5kPuY/xs85UVHaHz659cPTJOipzYpQ/jhBy9+QkC
         xchbFF+3i5bfF5v7+mmoPQGy7DeJ0KXmNY/Xh7Wsx3+sMcFR7+vfwgaKvMCx+CAE3/fv
         0te3zN97eK2IlwvjDE8zmRstupSY1Iizfov6POZIxu1JyisBznb1s2VB1F+cAx5x9jgo
         ct0Q==
X-Gm-Message-State: AOJu0YxVA6GId05vk/760E7kmfeskU2xMo2RZ47bGjKxRWGa9bBFSyqt
	8yD5N7oGm3SCr9MajHRS313JR1Lj1FEnrx8AyG3oyuhZtoy68lPjRcb+1lJsVBMoU6VY0mtzkgt
	EftBaVQ==
X-Gm-Gg: Acq92OGwNDjeu+3NDWC88l7RvWgoccSJLeeGzveDJxqnZ5XweB8t6HDfDdzdpjtU1oc
	BIuuP9SWEnSslCVMTTM1K2O81sJ7doRknJQv1LyC6qcPrg8l0Tb5q5h86fcepT0MKpUdHM3/Iq7
	jToY6dbjAOyVAG6qnEenk5V8g8SIh5YJrT7CsiQjS6Q4KqRS72uqZ0c4Em+CNAIS2wYxNHAh9Ch
	HFH8vs+XxqPf1YiopYilpVUGEq6Zpp+cVdGwhIKI5FbfswaxIWKXZZBNW4gJ+WblCZ26oZSo4Ca
	xW5D+2Sf1MGNpPlD7crRAsFUT6Wc2V/eo3auDjZvM0tpK7M93T74kOHVC4yRNGeERiaqjwAEDBk
	nBlP/lYCkpsFCW3DjFSYpzTpFs2EVe5boJ8PZyivaC2HfUdp5Eiee3PLASzsPZn4FVB0NSiDevt
	RzSUsTj10IVXWyka1f18HpF+vVQMg=
X-Received: by 2002:a05:622a:4a09:b0:50f:bd79:2642 with SMTP id d75a77b69052e-516d463bd85mr204585101cf.48.1779711972808;
        Mon, 25 May 2026 05:26:12 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm91351761cf.24.2026.05.25.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:12 -0700 (PDT)
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
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v6 1/9] net: Introduce skb tc depth field to track packet loops
Date: Mon, 25 May 2026 08:25:48 -0400
Message-Id: <20260525122556.973584-2-jhs@mojatatu.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291307-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,mojatatu.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,networkplumber.org:email]
X-Rspamd-Queue-Id: 8C6E25CA744
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a 2-bit per-skb tc depth field to track packet loops across the stack.

The previous per-CPU loop counters like MIRRED_NEST_LIMIT
assume a single call stack and lose state in two cases:
1) When a packet is queued and reprocessed later (e.g., egress->ingress
   via backlog), the per-cpu state is gone by the time it is dequeued.
2) With XPS/RPS a packet may arrive on one CPU and be processed on
   another.

A per-skb field solves both by travelling with the packet itself.

The field fits in existing padding, using 2 bits that were previously a
hole:

pahole before(-) and after (+) diff looks like:
   __u8       slow_gro:1;           /*   132: 3  1 */
   __u8       csum_not_inet:1;      /*   132: 4  1 */
   __u8       unreadable:1;         /*   132: 5  1 */
 + __u8       tc_depth:2;           /*   132: 6  1 */

 - /* XXX 2 bits hole, try to pack */
   /* XXX 1 byte hole, try to pack */

   __u16      tc_index;             /*   134     2 */

There used to be a ttl field which was removed as part of tc_verd in commit
aec745e2c520 ("net-tc: remove unused tc_verd fields").  It was already
unused by that time, due to remove earlier in commit c19ae86a510c ("tc: remove
unused redirect ttl").

The first user of this field is netem, which increments tc_depth on
duplicated packets before re-enqueueing them at the root qdisc.  On
re-entry, netem skips duplication for any skb with tc_depth already set,
bounding recursion to a single level regardless of tree topology.

The other user is mirred which increments it on each pass
and limits to depth to MIRRED_DEFER_LIMIT (3).

The new field was called ttl in earlier versions of this patch
but renamed to tc_depth to avoid confusion with IP ttl.

Note (looking at you Sashiko! Dont ignore me and continue bringing this up):
1. Since both mirred and netem utilize the same 2-bit tc_depth field it is
   possible when netem and mirred are used together that netem qdisc to skip
   the duplication step. This is a known trade-off, as a 2-bit field cannot
   independently track both features' recursion depths and it is not considered
   sane to have a setup that addresses both features on at the same time.

2. skb_scrub_packet does not clear tc_depth. This means a packet's loop history
  is preserved even across namespaces. While this might be restrictive for
  some topologies, it is also design intent to provide robustness against loops
  across namespaces.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/skbuff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..3f06254ab1b7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -821,6 +821,7 @@ enum skb_tstamp_type {
  *	@_sk_redir: socket redirection information for skmsg
  *	@_nfct: Associated connection, if any (with nfctinfo bits)
  *	@skb_iif: ifindex of device we arrived on
+ *	@tc_depth: counter for packet duplication
  *	@tc_index: Traffic control index
  *	@hash: the packet hash
  *	@queue_mapping: Queue mapping for multiqueue devices
@@ -1030,6 +1031,7 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
+	__u8			tc_depth:2;
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
-- 
2.54.0


