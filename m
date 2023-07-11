Return-Path: <netdev+bounces-16964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E4F74F986
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913DD281916
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998131EA97;
	Tue, 11 Jul 2023 21:01:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3241ED24
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 21:01:20 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F5310EF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:01:19 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a3a8d21208so5363230b6e.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689109278; x=1691701278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUzpFQyAUrW6n50WA4a2cK2TtZnq8gyOTaEzArpZSgM=;
        b=zh9RcHcgOYX1he0ZvHiplZ9YaMvrfQa/jXJDQOUzHPlu2swaCWz4IT6c0fK5tyuin3
         pGtf8Zu80UyGOwW9ZUSwj5RMKpEd+1V0ARW6MUAj26SXH/FZzltE/TrJFfNWFm584wHx
         JoJfw44BjFHn3T8VDHuzcfvxP5vwTHzfyRZVeGQbZrvgW+SRsVHZZ0Uk1QknouMatpoN
         aMh8Tw2WvCVeLi3Ob2g3hHkl959/AFvL4R9/olcDKNkUJo+XLIDqfar6bWkwWMZy5bwU
         niZtF2uJX5WDdzjdhuw1/3hdNpQPH6oMqNNFhxL1/LXouCK5aop+KRNUfogCB86f7MyX
         h2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109278; x=1691701278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUzpFQyAUrW6n50WA4a2cK2TtZnq8gyOTaEzArpZSgM=;
        b=jGETH4FOMpftNf1QnLHPP7Va4Snaqy5nTdh36u53crnrpuDtuW1HPn6vN1saLC0Dk9
         uhn/HPLouvZqLf7hoDbAvfkqAS/isC2YqhzF2LcoiROsE6tRHkcg1qfIOuxv7soS9hkt
         wAziwVrZjO955xcfUzAV7hzwiQuCF6LWNvlJHoycCCbzZXS2OBG6ffuDeMdthyRFH0sL
         8rP6VAjvpBJt6UiD2NcAN5/bcO0GpTGtnGZYobG1ZwLvMvCHf5W5muUHyNX1DZXooHFC
         o6DUA5Ifr6ShEXI3pQYIH4Fuh+l2duyyI/W8TI5minLoWXuaSL19CIUrenca8Ec+kRRT
         nZNw==
X-Gm-Message-State: ABy/qLbr/rWUtv+yuK85yiv8CC5/2+jCrWOsBl6+srZEA3oo97YLjuPY
	p+rDaK1oa0TJ4YCi+y6CqEW+gC9p0Y/J2TcfBug=
X-Google-Smtp-Source: APBJJlFxJsM4fimMcBBgdZaafK/iWn0CtcIu3/VZJES7uhBnCEqNriTKnJ+A0AoK04IbRgEWHfRsqA==
X-Received: by 2002:a05:6808:1596:b0:3a1:ecdf:5f74 with SMTP id t22-20020a056808159600b003a1ecdf5f74mr21715314oiw.43.1689109278594;
        Tue, 11 Jul 2023 14:01:18 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:d1e8:1b90:7e91:3217])
        by smtp.gmail.com with ESMTPSA id d5-20020a05680808e500b003a1e965bf39sm1290575oic.2.2023.07.11.14.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:01:18 -0700 (PDT)
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
	simon.horman@corigine.com,
	paolo.valente@unimore.it,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net v3 1/4] net/sched: sch_qfq: reintroduce lmax bound check for MTU
Date: Tue, 11 Jul 2023 18:01:00 -0300
Message-Id: <20230711210103.597831-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711210103.597831-1-pctammela@mojatatu.com>
References: <20230711210103.597831-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

25369891fcef deletes a check for the case where no 'lmax' is
specified which 3037933448f6 previously fixed as 'lmax'
could be set to the device's MTU without any bound checking
for QFQ_LMAX_MIN and QFQ_LMAX_MAX. Therefore, reintroduce the check.

Fixes: 25369891fcef ("net/sched: sch_qfq: refactor parsing of netlink parameters")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_qfq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index dfd9a99e6257..63a5b277c117 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -423,10 +423,17 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	else
 		weight = 1;
 
-	if (tb[TCA_QFQ_LMAX])
+	if (tb[TCA_QFQ_LMAX]) {
 		lmax = nla_get_u32(tb[TCA_QFQ_LMAX]);
-	else
+	} else {
+		/* MTU size is user controlled */
 		lmax = psched_mtu(qdisc_dev(sch));
+		if (lmax < QFQ_MIN_LMAX || lmax > QFQ_MAX_LMAX) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "MTU size out of bounds for qfq");
+			return -EINVAL;
+		}
+	}
 
 	inv_w = ONE_FP / weight;
 	weight = ONE_FP / inv_w;
-- 
2.39.2


