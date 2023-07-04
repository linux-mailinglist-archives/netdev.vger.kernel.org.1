Return-Path: <netdev+bounces-15392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B347747515
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDF7280E85
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AEC63CF;
	Tue,  4 Jul 2023 15:15:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280AC6AA4
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:15:14 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E629BE6D
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:15:12 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b73c2b6dcfso3401539a34.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688483712; x=1691075712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2leKZ3yL9UO2V7GrVLbVDJCzI/nN3a1it0oG3ZCpbl0=;
        b=wexMa+jJPD1ckeEbjUV5GjJsBOtQs9B6ajcINpizKr56k93onXeB3QxQ1wqD67i9LZ
         C9FsD6LDzSe+rhWII+7fDY6xUkELKs5tWT+gM7P+F7Iqke3SlrhszjPO6IQNWI3okUIS
         OXHAagwdEmJSfS7QBUibBs1DzC7g6feT+ZOCiHcAvogl4v4oXkdhNEF1ENeEADrcTZLW
         Q6QjVXUi4lYL47msoo8whaiM3fUwGIUamVCJY7WmuII2rwXy9V7MiJMtASLC8K3lj+hm
         Gh2GMzJ5lkrnnN1cPXW3rdpeeuY/hlKaS/rtR5v8PwweoNj1g1v/MBr3zqS2gwNJvutR
         4Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483712; x=1691075712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2leKZ3yL9UO2V7GrVLbVDJCzI/nN3a1it0oG3ZCpbl0=;
        b=Sl0z1rCT3LqCv5ofODFynwt59v1f2yU0HbUDdmd65P3Ld2wW8+wKne0vuN50H9yY0q
         h0L+S/Rr9IqL/+EBTF222+PKikIH1hPA0QBs1wISqjibA+h4YO2r/LHiGMJHy7xHhbCs
         If0hp0Pj9iyLfkcOB8BHyF/snjAi+P02H5Hghg6JxEh35RgLBmZf+fBbaz6EztHXBXXw
         Mg0TBdJUn3YygvEuTzN/gD8tS0Q7aBxvpCXUf0/ynkC6qO3cBCkAohwgXUWHjlD/Y7bl
         mp0ryn+GpWKd68CMYCvULJ0r6LGRtjKGF9SKfUs+zdRVWxci2IWYdTA1bseurZ71jIsZ
         /3Wg==
X-Gm-Message-State: AC+VfDwPgcyynQv3k+zSoEcczCDw3OVxxiaAuyQZgxN8tZixMLTqqDG+
	VEm4jImQ0psbw7+UxnHSXPeC8wpWfhS0Gy+P2iw=
X-Google-Smtp-Source: ACHHUZ697jqZ/5+Uom4BXRM8Hpln2I5dhsEERp1ZXOUFEYtZ7Hm8JRcpN8M2tkftzeYOLl5Z4KSjHQ==
X-Received: by 2002:a05:6830:11:b0:6b7:2f39:3a93 with SMTP id c17-20020a056830001100b006b72f393a93mr10143598otp.0.1688483711983;
        Tue, 04 Jul 2023 08:15:11 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id s1-20020a9d7581000000b006b8abc7a738sm3946146otk.69.2023.07.04.08.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:15:11 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pctammela@mojatatu.com,
	kernel@mojatatu.com
Subject: [PATCH net 2/5] net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms
Date: Tue,  4 Jul 2023 12:14:53 -0300
Message-Id: <20230704151456.52334-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704151456.52334-1-victor@mojatatu.com>
References: <20230704151456.52334-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In case an error occurred after mall_set_parms executed successfully, we
must undo the tcf_bind_filter call it issues.

Fix that by calling tcf_unbind_filter in err_replace_hw_filter label.

Fixes: ec2507d2a306 ("net/sched: cls_matchall: Fix error path")

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_matchall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index fa3bbd187eb9..02830409e013 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -163,7 +163,7 @@ static int mall_set_parms(struct net *net, struct tcf_proto *tp,
 			  struct cls_mall_head *head,
 			  unsigned long base, struct nlattr **tb,
 			  struct nlattr *est, u32 flags, u32 fl_flags,
-			  struct netlink_ext_ack *extack)
+			  bool *bound_to_filter, struct netlink_ext_ack *extack)
 {
 	int err;
 
@@ -175,6 +175,7 @@ static int mall_set_parms(struct net *net, struct tcf_proto *tp,
 	if (tb[TCA_MATCHALL_CLASSID]) {
 		head->res.classid = nla_get_u32(tb[TCA_MATCHALL_CLASSID]);
 		tcf_bind_filter(tp, &head->res, base);
+		*bound_to_filter = true;
 	}
 	return 0;
 }
@@ -186,6 +187,7 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 		       struct netlink_ext_ack *extack)
 {
 	struct cls_mall_head *head = rtnl_dereference(tp->root);
+	bool bound_to_filter = false;
 	struct nlattr *tb[TCA_MATCHALL_MAX + 1];
 	struct cls_mall_head *new;
 	u32 userflags = 0;
@@ -227,7 +229,7 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 	}
 
 	err = mall_set_parms(net, tp, new, base, tb, tca[TCA_RATE],
-			     flags, new->flags, extack);
+			     flags, new->flags, &bound_to_filter, extack);
 	if (err)
 		goto err_set_parms;
 
@@ -246,6 +248,8 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 	return 0;
 
 err_replace_hw_filter:
+	if (bound_to_filter)
+		tcf_unbind_filter(tp, &new->res);
 err_set_parms:
 	free_percpu(new->pf);
 err_alloc_percpu:
-- 
2.25.1


