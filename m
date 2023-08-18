Return-Path: <netdev+bounces-28864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5F0781076
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6326B2821EC
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C41EECE;
	Fri, 18 Aug 2023 16:36:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D36110
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:36:28 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE1A3AAE
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:27 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56d6dfa1f3cso690326eaf.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692376586; x=1692981386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLmjnO5KUtCrD/gaeJk57IaZoZ7aWFu8I5CCnY6/uVk=;
        b=XU7JYY0TnevfzpItaBh75PH5kC5FAnGNsSJfJdBypXtBNDMgLqqWIipjjbzZIPmkeI
         fWxu/fEIGsWmdzUqib7TE9QTgz0BhKSED1Eqn2BRUsTmWbpbWuus5sRlBTNgeInzl8Jf
         cATGykyZPAkwt2TUdRCnaGNmzbjYXC15lspOsnLn4XC0wpiQOU9McqlI9y4JmTOrmnCr
         ieOE3blJnOIbPXf+EEgwzNCJMKJ3kcjjVdzs8uXKlpBEn06zdQ++3z9wPW4F56OV6BSh
         UFUP5hq7+rih0zg6JkYUzB6Ewr4HORmC1D2myowDSj48Mvua5srMY3MVR7z43vB9CCrT
         DwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376586; x=1692981386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLmjnO5KUtCrD/gaeJk57IaZoZ7aWFu8I5CCnY6/uVk=;
        b=i9FR/w9FVhwCPsyWM3M7vLavk9tUz629qcyHAlHpm7W8Q3NTSJNH/NjyqH+/0CFyNK
         IjBFR+bJM8UUXdeIIXXwXWYXGPhCi/U8Y9FcMLm8t28wupcIZiQqUSlzi3waqhfadxfw
         70kbIwzNwB4NAcsxz1TTiffrVVu+jYrSqm0hR9fVkIxPyMzxN921oGGD+xRa55qFoK4r
         R2nNXZY/4mmV+/I7/XdpmeF5Mb6VZe9PSk0GQSq81vSKU9x8FVYPrGR7orHiaVQdMnbn
         sHy7kvgf84MdVXmpUHuwCMwmhWr7fcSZMKTSeI+z2zM/JsWYaAReba2Nw8WoYsu49Luq
         gCPw==
X-Gm-Message-State: AOJu0Yz9mUZh/ZtkXIYvwOIF3VTd3EkmR0LhwJpl+iqgQS+RO3kJGb4D
	iAgrOkVnPVdrIPji16eBvv5r1HlyGjr43BGCx50=
X-Google-Smtp-Source: AGHT+IFv39JRhX7Y5v45WIPO8y+vQVffZpfNA/IW1o6clNhy5C/pp0Rzbhy2bOmItoU0P4b3Bh29MA==
X-Received: by 2002:a05:6820:292:b0:56d:e414:d14 with SMTP id q18-20020a056820029200b0056de4140d14mr3592929ood.8.1692376586162;
        Fri, 18 Aug 2023 09:36:26 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:bdfa:b54a:9d12:de38])
        by smtp.gmail.com with ESMTPSA id f200-20020a4a58d1000000b005634e8c4bbdsm561531oob.11.2023.08.18.09.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:36:25 -0700 (PDT)
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
	shaozhengchao@huawei.com,
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 4/5] net/sched: cls_route: make netlink errors meaningful
Date: Fri, 18 Aug 2023 13:35:43 -0300
Message-Id: <20230818163544.351104-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818163544.351104-1-pctammela@mojatatu.com>
References: <20230818163544.351104-1-pctammela@mojatatu.com>
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


