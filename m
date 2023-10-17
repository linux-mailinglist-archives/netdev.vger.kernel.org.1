Return-Path: <netdev+bounces-41947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321827CC5FC
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9330DB210E4
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1A41743;
	Tue, 17 Oct 2023 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CH3/o+YM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1214446D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:36:16 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902F92
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:36:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b201a93c9cso3476907b3a.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697553375; x=1698158175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0iwkHAvpfBOIXAZ4ZbzgTwZWwWbSALrr4ObQlytmE0g=;
        b=CH3/o+YM6ujcXe+y9R2EnW/AfxniQpQp4fDdckwtpVF0YEU3YfHl+GECTiltM/1J59
         AoBH6LFAXvNs3xvgy14Pt59Ca4wrxNVZrVU+Ux3FoxY13L6GaemkH3L+HXBWRiEIxTWn
         TuKnXfjGxZ52AkP9P9Ik7nfFIuWN5xdP2syrnCEMGS0nIkzmnjy8GyC3JLnw7nhmkKs8
         t3hbiG9XDnq8v8fEot8QR05yEHibkZZecLPhCGKiTRSLei2NHkch+1t2gRvg6cQIBvwS
         YZp9VnkLiat8zD6wjxc+JkXAzOXnfpb9V0PmTOYSklE/0LeRFQcEC3VaXNnXL6u9MjYf
         rvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697553375; x=1698158175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iwkHAvpfBOIXAZ4ZbzgTwZWwWbSALrr4ObQlytmE0g=;
        b=swTBYNyhI0E4mRE4PJBqbf8E2y/5jk+2GOiwwdZY6Z086RoFhbk/JqyuMEhlZQyu9q
         MfQ9qNZeVj9UmxTRUieN6YZovstUXHlhI2f8pDolpIgVdUEUQ6cXXU0oUI3fOxlQ3dLE
         L9elJpC3XdNMtQn6BM3Oe5OizEwRU8V7lbztRN6+vhnXzVaQn7Mfy+xDeQsDqPWT8xtc
         xRn40pKY87V5z35z91QJXfDHmakDhaZgj5xw39DhfDA5xJ7eUBSqbx33q5CxMv+JdJHT
         i+OTXu0lw8uEquf5fZvpKz0FN6Mx5zTNF7GnTWJg3dRhdbp40y8ZvmQYnZYZ829FD8++
         rteQ==
X-Gm-Message-State: AOJu0Yw2ORrlyFrHlwaWgvu6b+CGtEXcZWBUVf/n5Q2QULlUUAV3E/sC
	RQFZDiJgkevS+EXmcHCW3UjF9m5YLWL0W6cWkwavZg==
X-Google-Smtp-Source: AGHT+IEB91J2WOZHXUz3uw16/kEenoPBeF0TiNelFfc7YRrfTCe1wwaOk8bK6B1ylW9mzLvaPKaocg==
X-Received: by 2002:a05:6a21:1a5:b0:154:d3ac:2076 with SMTP id le37-20020a056a2101a500b00154d3ac2076mr2661894pzb.40.1697553374864;
        Tue, 17 Oct 2023 07:36:14 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:8ef5:7647:6178:de4e])
        by smtp.gmail.com with ESMTPSA id az7-20020a17090b028700b0027360359b70sm6421355pjb.48.2023.10.17.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:36:14 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Christian Theune <ct@flyingcircus.io>,
	Budimir Markovic <markovicbudimir@gmail.com>
Subject: [PATCH net v2] net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve
Date: Tue, 17 Oct 2023 11:36:02 -0300
Message-Id: <20231017143602.3191556-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Christian Theune says:
   I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic shaping script,
   leaving me with a non-functional uplink on a remote router.

A 'rt' curve cannot be used as a inner curve (parent class), but we were
allowing such configurations since the qdisc was introduced. Such
configurations would trigger a UAF as Budimir explains:
   The parent will have vttree_insert() called on it in init_vf(),
   but will not have vttree_remove() called on it in update_vf()
   because it does not have the HFSC_FSC flag set.

The qdisc always assumes that inner classes have the HFSC_FSC flag set.
This is by design as it doesn't make sense 'qdisc wise' for an 'rt'
curve to be an inner curve.

Budimir's original patch disallows users to add classes with a 'rt'
parent, but this is too strict as it breaks users that have been using
'rt' as a inner class. Another approach, taken by this patch, is to
upgrade the inner 'rt' into a 'sc', warning the user in the process.
It avoids the UAF reported by Budimir while also being more permissive
to bad scripts/users/code using 'rt' as a inner class.

Users checking the `tc class ls [...]` or `tc class get [...]` dumps would
observe the curve change and are potentially breaking with this change.

v1->v2: https://lore.kernel.org/all/20231013151057.2611860-1-pctammela@mojatatu.com/
- Correct 'Fixes' tag and merge with revert (Jakub)

Cc: Christian Theune <ct@flyingcircus.io>
Cc: Budimir Markovic <markovicbudimir@gmail.com>
Fixes: b3d26c5702c7 ("net/sched: sch_hfsc: Ensure inner classes have fsc curve")
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_hfsc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 3554085bc2be..880c5f16b29c 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -902,6 +902,14 @@ hfsc_change_usc(struct hfsc_class *cl, struct tc_service_curve *usc,
 	cl->cl_flags |= HFSC_USC;
 }
 
+static void
+hfsc_upgrade_rt(struct hfsc_class *cl)
+{
+	cl->cl_fsc = cl->cl_rsc;
+	rtsc_init(&cl->cl_virtual, &cl->cl_fsc, cl->cl_vt, cl->cl_total);
+	cl->cl_flags |= HFSC_FSC;
+}
+
 static const struct nla_policy hfsc_policy[TCA_HFSC_MAX + 1] = {
 	[TCA_HFSC_RSC]	= { .len = sizeof(struct tc_service_curve) },
 	[TCA_HFSC_FSC]	= { .len = sizeof(struct tc_service_curve) },
@@ -1011,10 +1019,6 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (parent == NULL)
 			return -ENOENT;
 	}
-	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
-		NL_SET_ERR_MSG(extack, "Invalid parent - parent class must have FSC");
-		return -EINVAL;
-	}
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
@@ -1065,6 +1069,12 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	cl->cf_tree = RB_ROOT;
 
 	sch_tree_lock(sch);
+	/* Check if the inner class is a misconfigured 'rt' */
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
+		NL_SET_ERR_MSG(extack,
+			       "Forced curve change on parent 'rt' to 'sc'");
+		hfsc_upgrade_rt(parent);
+	}
 	qdisc_class_hash_insert(&q->clhash, &cl->cl_common);
 	list_add_tail(&cl->siblings, &parent->children);
 	if (parent->level == 0)
-- 
2.39.2


