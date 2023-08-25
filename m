Return-Path: <netdev+bounces-30746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC62788CD6
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E042816B6
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE71774B;
	Fri, 25 Aug 2023 15:52:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37113174F3
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:52:27 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA3810D
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:52:26 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a76d882052so781650b6e.0
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692978745; x=1693583545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLmjnO5KUtCrD/gaeJk57IaZoZ7aWFu8I5CCnY6/uVk=;
        b=R6cvZAQMIck6RPUCmyl9Zw+odkD7vlJth0JnJ1cOdiwb8BFhbEHzjPD6qy4ITETTf+
         nIad62R8lauuKF51+G6yCPAGLE9vb0b1f7zNvyKAj8JHXEzAp8RWuAXjzAZDe2AVPv+n
         oIkG7hAnu/yBTmD2xYq0FyN3a4974S+vTdLD0PnXVQVpf5T/t1JoswJjFZKS+Z5Rr5hT
         EoM7h1DT//tsELC+xM+aBoDAx8+e0D64rFaHhLCIY/AyH6nnC7Wf4LzAAUavWefmas+o
         nHWvQonzHt+SzmKOQfuI1iUI7exTbWG+A2VfsXVuzIQcp7sZOHiRisHIRsogTPfv7hv/
         3MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692978745; x=1693583545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLmjnO5KUtCrD/gaeJk57IaZoZ7aWFu8I5CCnY6/uVk=;
        b=IsrayjCiykOltPNIuRvGyG3JfEhJ7iQ53FV3XXP4VKAdeMLu8g0MO2sYKvhDiYu/H2
         45eLHfCkQ99IgJvzeX+IkbzDaSTBbBaFbIWigF8FzplRW9HHiE/rNOs4toZgcjtFKCkb
         1ugsFFufupe/zZw5QlpMzX5NSXEZ0iFw9V5ufpPr8jnxyvFB06ksW73xksxAyPf4zKYJ
         WFQBUfJz3c7ohBaAkE1PcsF8njQe22q/SbUuiglpyiaoB6wOkZeeoHORnyFdbeUP+hUL
         YE2Dhzo2LcbaPGRBLJfvzhke766APHbv+cf1dHiuN73+sY8yxQDi+OPLnUaemMBgnIX1
         N5zA==
X-Gm-Message-State: AOJu0YwzcRI1oLggeS5OFjmrFL2dzBliCRPmD+Ze0wfdo7eWU2eFUI/5
	TXU6AWe8troCKlWL+vuYejiZhARcbbOZiS2R8Fc=
X-Google-Smtp-Source: AGHT+IFIKnrhO+/mOSKmEIGfhd8Cqmd61ZlIHGvyPtauitYOPh4tLbB07yfw14cg8AV7q0QhM40huQ==
X-Received: by 2002:aca:231a:0:b0:3a8:84a9:242c with SMTP id e26-20020aca231a000000b003a884a9242cmr3029811oie.42.1692978745437;
        Fri, 25 Aug 2023 08:52:25 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:6001:c5a2:ad40:e52a])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0568081a1c00b003a88a9af01esm856678oib.49.2023.08.25.08.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:52:25 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 4/4] net/sched: cls_route: make netlink errors meaningful
Date: Fri, 25 Aug 2023 12:51:48 -0300
Message-Id: <20230825155148.659895-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825155148.659895-1-pctammela@mojatatu.com>
References: <20230825155148.659895-1-pctammela@mojatatu.com>
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

Use netlink extended ack and parsing policies to return more meaningful
errors instead of the relying solely on errnos.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_route.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 1e20bbd687f1..b34cf02c6c51 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -400,30 +400,32 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 		if (new && handle & 0x8000)
 			return -EINVAL;
 		to = nla_get_u32(tb[TCA_ROUTE4_TO]);
-		if (to > 0xFF)
-			return -EINVAL;
 		nhandle = to;
 	}
 
+	if (tb[TCA_ROUTE4_FROM] && tb[TCA_ROUTE4_IIF]) {
+		NL_SET_ERR_MSG(extack,
+			       "'from' and 'fromif' are mutually exclusive");
+		return -EINVAL;
+	}
+
 	if (tb[TCA_ROUTE4_FROM]) {
-		if (tb[TCA_ROUTE4_IIF])
-			return -EINVAL;
 		id = nla_get_u32(tb[TCA_ROUTE4_FROM]);
-		if (id > 0xFF)
-			return -EINVAL;
 		nhandle |= id << 16;
 	} else if (tb[TCA_ROUTE4_IIF]) {
 		id = nla_get_u32(tb[TCA_ROUTE4_IIF]);
-		if (id > 0x7FFF)
-			return -EINVAL;
 		nhandle |= (id | 0x8000) << 16;
 	} else
 		nhandle |= 0xFFFF << 16;
 
 	if (handle && new) {
 		nhandle |= handle & 0x7F00;
-		if (nhandle != handle)
+		if (nhandle != handle) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Unexpected handle %x (expected %x)",
+					   handle, nhandle);
 			return -EINVAL;
+		}
 	}
 
 	if (!nhandle) {
@@ -478,7 +480,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	struct route4_filter __rcu **fp;
 	struct route4_filter *fold, *f1, *pfp, *f = NULL;
 	struct route4_bucket *b;
-	struct nlattr *opt = tca[TCA_OPTIONS];
 	struct nlattr *tb[TCA_ROUTE4_MAX + 1];
 	unsigned int h, th;
 	int err;
@@ -489,10 +490,12 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 		return -EINVAL;
 	}
 
-	if (opt == NULL)
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tca, TCA_OPTIONS)) {
+		NL_SET_ERR_MSG_MOD(extack, "missing options");
 		return -EINVAL;
+	}
 
-	err = nla_parse_nested_deprecated(tb, TCA_ROUTE4_MAX, opt,
+	err = nla_parse_nested_deprecated(tb, TCA_ROUTE4_MAX, tca[TCA_OPTIONS],
 					  route4_policy, NULL);
 	if (err < 0)
 		return err;
-- 
2.39.2


