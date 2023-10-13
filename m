Return-Path: <netdev+bounces-40730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D27A7C8858
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE681C210F8
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819518E20;
	Fri, 13 Oct 2023 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1g6efEz1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219119BDC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:11:22 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB46DBD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:11:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so513862b3a.1
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697209877; x=1697814677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et4aQ4p14to5tbANw/8rnLA31aavpP5b9TAwFBI5Rk4=;
        b=1g6efEz1hjku4NBTuuKyNk3OgamORJsEE9/75kAGESPL/8qRteUO4UoZRPq2dbiJwI
         eWVRDA8rq791hV2oyX/wdfkltgPQNV9fsMkco+6lU+2HN6ZgAXlmMww/+NpcNZheUtFk
         eWmNbXY00dSq5B4XYaliQQpws3iOEtNiFTd9UcIOtNJ6ymey0kGdSW8yp2tswdHhfqTx
         ZgWQ8/409dOhltkcgDV/5fR5XSPMoxjT3gP8CtII7ZpLZibY9KCVVXcWvPOyHHTp23Mr
         J22bebsTvnYZ6pUoOarM5cb1A735wnGFtoi6cmwOmeOHpIHh6p2uPK8HWMHlcTZ6dKAN
         0DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209877; x=1697814677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Et4aQ4p14to5tbANw/8rnLA31aavpP5b9TAwFBI5Rk4=;
        b=QfANB81YG1/gG1cf+BaFiS+kogAPSGXJk4dTIothBQ93SvsGB9ag78p14OZjHJC5h3
         upgcuYFnXIa45UCDlHfrT6Gh+ImtvdHY6jhV5gwwm3mnPULKlG7kACDZWn1cqtP5BjUN
         Gs27hllIy3U8fjK65d0vPfH8Rgb5Ph/lAO6LdJdi1a7fDDiUrsF6ve8ilcNc3Ih3XnYc
         ukkxMoQu68MNlUAxy25Iy4CSgkiPvMu5SXpzIhEqiUTNNTBKeNbMexKBNWE/CyAE+NmF
         VQ2PdVkXf+9/ykhEcN89K2wUleCxDI59yJe56cwHTKOmk+goKyGzloDV3lg0ghgGRsg1
         aqpw==
X-Gm-Message-State: AOJu0Yx8IUSx6j4hNFAoWijdLUkgIWYFneWN8acle9q7H/vmal4LDP6/
	lTsMFXVHa13mq8UMTPgSnovLIJaXgMeEzUmDmWt3GA==
X-Google-Smtp-Source: AGHT+IFN7XyFUEsQydS2g5aTMvIPjnewPo6Jo54CHn8bGaTdItcYrl7KG5qx3SYWZGu6kW3gWqdp0Q==
X-Received: by 2002:a05:6a00:1389:b0:6b2:baa0:6d4c with SMTP id t9-20020a056a00138900b006b2baa06d4cmr2224729pfg.33.1697209876878;
        Fri, 13 Oct 2023 08:11:16 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:aa18:90b1:177c:3fd3])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b0064f76992905sm13716881pfn.202.2023.10.13.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:11:16 -0700 (PDT)
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
Subject: [PATCH net 2/2] net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve
Date: Fri, 13 Oct 2023 12:10:57 -0300
Message-Id: <20231013151057.2611860-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013151057.2611860-1-pctammela@mojatatu.com>
References: <20231013151057.2611860-1-pctammela@mojatatu.com>
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

Cc: Christian Theune <ct@flyingcircus.io>
Cc: Budimir Markovic <markovicbudimir@gmail.com>
Fixes: 0c9570eeed69 ("net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve")
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_hfsc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 98805303218d..880c5f16b29c 100644
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
@@ -1061,6 +1069,12 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
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


