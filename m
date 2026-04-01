Return-Path: <netdev+bounces-274143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLBpHgk5zWnfawYAu9opvQ
	(envelope-from <netdev+bounces-274143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:26:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE21437D09C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFCBB32E320D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688F472786;
	Wed,  1 Apr 2026 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="yeqm1NmD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76446AF05
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055223; cv=none; b=TzOTiC4/U93ZD5RgrXPT9YmEDpQ9StQY9z4sxVazDDTqpC34maTATjcYy3OZiuKgi90qK2eJRN+gzhyL4TalmpIkIN7vnS4euVePqfLdxOhzFWtuBC6W2wKBLge1/T4C7ngI6s06wR+RIZfB7FgRjCffw8u2g/QcGkHzT7ttHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055223; c=relaxed/simple;
	bh=/maizwT8ZGLjouDwcq4bTwlangICy3f4G/zLNjuMzbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9X91o4jWl5ct5NWTIHI8k9okn++Z1f+/81p0VzOcXNvWW4P9XXOO8MMAt/X9AXZc7hmvh9HYAv2CgmZnB1gKTiNsZ7DGFEZ3IGzIWQyxVlY5NGol6SKbyFc+L9Glpb96WGu+Khec3ar0fVEjF1PnZlOKBr3JFPoNIgEx5wzyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=yeqm1NmD; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so13737763eec.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775055222; x=1775660022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB0cCE3WCvRC67Xf0AcW1ajnHgViG1QsyhPCjiMGj9k=;
        b=yeqm1NmDZa8s7bPxYQoO5mj7wQXWqjoeq4ICYcYgjXEdSafA2kIAudKSdse1uBUHs1
         zkHDAh+5272v6gxIvUlt08TZJz/Avj3yAQwcbpC5cQHL3jL99LwdIfmnTQYpA0JJkYcD
         fVDQ6k0QFrze1Nuue/r273BXCP2WL5C6EXRrzeabpp6lyNCpalr/PCxOMOXyfemNVwCk
         F+wgziwgLJhYx8qg5VcFjqv3/UzTa8sp3/PZZycz3BPNj/fy17QOy8953d+dSM5bUrqz
         lHaAdtvyTdOwiPxiobOThHptnq8OBSbT+IyzYPUvo9FfdtS/j6MRFVKDSi44udvT6iXp
         0zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055222; x=1775660022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iB0cCE3WCvRC67Xf0AcW1ajnHgViG1QsyhPCjiMGj9k=;
        b=E6esS5wSXrJXltvOHjaLOyFiOPYoNj7dQg1OOLG/oECuRBxdJRyZoepqmoR4kQuY/W
         RZ91AkfdOwC8AOGDjENTzSxmh7S+KaFKsWkrBb/3+V9QpzgXzpAB7zda/NuOgctp62sw
         MFFBb60eKe2hjcVvsxT2cd/+Pir02Y6hyzqcTR6g/tFLtm6/IPM3urlBRJTvdYHNUzKA
         bCwsVBlN6qLmaBoZj8cZFduQvef3XyUftlt3fG6EhwEAxFeRLti7wkFbIMbhtGdOEIx0
         gr9oZsRZ8RNpAiNM87rfL/xtFrbLIHIjB5hGWQvMNdo0X4XwxrNnJ3hjam/oW5a9/U0O
         9c2g==
X-Gm-Message-State: AOJu0YyPuCBO37kq+u76uj86nHb2FDbIHJxAlS0C1rueJcuI3qWJgOpB
	JBSk30+i42mn1DIeDjIdrVVg2amYWnKrjWy4TV0UTUr4uW1ab/4T1HMn0lx7HUScsKYdE56toZv
	pITfJ
X-Gm-Gg: ATEYQzz9UZeiARcLlonCK13IYRutXApKCmF1IQkXycUP7xdrV0GaVT9d8h8+kkuoDGU
	ONho/ZcFtlZx5Ze2lbt4kTpfOhcxU8zviurrxfT85Z9g2GDi9J+coOMIomke19X8A1whH5Wj3rA
	+RAhHAlYAgzzzrF5m2FDbAlkaj5ecZIKeBaP2Y9aSuP7aDMnpysuH7QFGIO0WPdbjAkEoURfL+E
	twTv+pvFsm/m4ZEQ5xwhj1Fbsn6qNMzVH++vPSVUQvI4HuWCIrjvabgTgKmzEFbMIohgSBD1lGx
	PsoP1C3zHVFn/jAjO+Y7Q4SXi1yNyzzgfub/V4R0MH/8wdvMjUWRNTcYL9LFK3A7s5fGorN956g
	9vc4/nFtWOhT+IR3Y1e48oWzMjMOilRF1v1tzt4myY/UEROi4RWTc79dg1D55MvtT5zx+90FLv2
	V59SVg36OI4OrO0Jk/wRnwnrpQ4jLMM8l/
X-Received: by 2002:a05:7300:6d1f:b0:2c1:55fd:50bb with SMTP id 5a478bee46e88-2c9327a243cmr2436416eec.20.1775055221725;
        Wed, 01 Apr 2026 07:53:41 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm12804830eec.6.2026.04.01.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:53:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 5/7] net/sched: netem: null-terminate tfifo linear queue tail
Date: Wed,  1 Apr 2026 07:51:57 -0700
Message-ID: <20260401145332.78285-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401145332.78285-1-stephen@networkplumber.org>
References: <20260401145332.78285-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274143-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20230601.gappssmtp.com:dkim,networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE21437D09C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When tfifo_enqueue() appends a packet to the linear queue tail,
nskb->next is never set to NULL. The list terminates correctly
only by accident if the skb arrived with next already NULL.

Explicitly null-terminate the tail to prevent list corruption.

Fixes: d66280b12bd7 ("net: netem: use a list in addition to rbtree")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index ce12b64603b2..4b27fab72fef 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -398,6 +398,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 			q->t_tail->next = nskb;
 		else
 			q->t_head = nskb;
+		nskb->next = NULL;
 		q->t_tail = nskb;
 	} else {
 		struct rb_node **p = &q->t_root.rb_node, *parent = NULL;
-- 
2.53.0


