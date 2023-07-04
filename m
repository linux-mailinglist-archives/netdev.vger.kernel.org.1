Return-Path: <netdev+bounces-15393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AC8747517
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661681C20A2A
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72146AD8;
	Tue,  4 Jul 2023 15:15:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD776AA4
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:15:16 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63B3E6D
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:15:15 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b8b6f7399aso2708280a34.1
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688483715; x=1691075715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkcs2uqOK1YLIQFLRBJYOV4viM2JPisuB2yz4G0LUz0=;
        b=ZLcH84fwj2VQz16eYLooBFUH80fd5KOm9II4KTKPnaaUxd56wNo4DBVmAqO8lHpc8x
         9cwXikiWF/F2/+vOffXryxVOOT+PCzSr9YBwA+LDTKLPPoRZ95iVjWfEgYzzQ7foLRmR
         SdJovwvsNl7ZhYYfdcQQjXZYw/TJ0f0P+YSj2q+KwoFvKFr4cPjP9sqq+EfzePt6WmCg
         UkoxbM2z6llSxRDV0k3hpBmneX9CFdPACvDsbphLodi2dSf+VHGPOWB4DWUEOnGaRIxt
         3l9HPfIjrZCNnOjBmjrwTbhdOpee0d60xKDoU8c3Pr1gvXD9GtbdHYylqPUQkdaanNOZ
         aafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483715; x=1691075715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkcs2uqOK1YLIQFLRBJYOV4viM2JPisuB2yz4G0LUz0=;
        b=KKx7z79Ij7vOPWXgchT+NZ0v1F8dlfmJoumzVXHOye0LdVxWw3Jq6QqvCIrVn3AgFR
         dYQrEH73AbZN5KK0lKl0qkgOgtCcN7F6KH3+SjGj+NqrIiEQgbZBKtSxzgGOcaarUr3L
         pW+wK++GMaGUIeQMHNka1U60YnVC+F25JgSry6p2buSa5zZaObewwEpSf9pYezDb6rCa
         HqaTivsvTnQpcSh7rDt2aPOy4LR8cBdqrwu5u+hS4jXGmT3U1UpcIkSNNDXzX5yqw98z
         ucYaTtOsXGr6MA/ihMt2z8R7/fxFMkW4O/UBm7V3M6sU5ZoqU2mAnng+HG+9+dzFvO21
         nSgA==
X-Gm-Message-State: AC+VfDxSfT84LVTtLEjMOhx3aAfxisyQr9QY/pqRqI+T+03t2mGtYkXz
	zJfZYoCh+q08GXP8TseBGyxzcufZ9TMRHpKFdVo=
X-Google-Smtp-Source: ACHHUZ4K65UmG41YyyUvLfGZAUEQdW8175+IEzpiJGrXH7c8Sqnfik753aV9Jo4VXbtW0hhDmfFy4Q==
X-Received: by 2002:a9d:7cc8:0:b0:6b8:7a64:cedc with SMTP id r8-20020a9d7cc8000000b006b87a64cedcmr12939040otn.14.1688483715045;
        Tue, 04 Jul 2023 08:15:15 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id s1-20020a9d7581000000b006b8abc7a738sm3946146otk.69.2023.07.04.08.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:15:14 -0700 (PDT)
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
Subject: [PATCH net 3/5] net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
Date: Tue,  4 Jul 2023 12:14:54 -0300
Message-Id: <20230704151456.52334-4-victor@mojatatu.com>
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

When u32_replace_hw_knode fails, we need to undo the tcf_bind_filter
operation done at u32_set_parms.

Fixes: d34e3e181395 ("net: cls_u32: Add support for skip-sw flag to tc u32 classifier.")

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_u32.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d15d50de7980..e193db39bee2 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -712,11 +712,13 @@ static const struct nla_policy u32_policy[TCA_U32_MAX + 1] = {
 	[TCA_U32_FLAGS]		= { .type = NLA_U32 },
 };
 
+#define U32_SET_FLAGS_BOUND 0x1
+
 static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 			 unsigned long base,
 			 struct tc_u_knode *n, struct nlattr **tb,
 			 struct nlattr *est, u32 flags, u32 fl_flags,
-			 struct netlink_ext_ack *extack)
+			 u8 *set_flags, struct netlink_ext_ack *extack)
 {
 	int err, ifindex = -1;
 
@@ -763,6 +765,7 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 	if (tb[TCA_U32_CLASSID]) {
 		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
 		tcf_bind_filter(tp, &n->res, base);
+		*set_flags |= U32_SET_FLAGS_BOUND;
 	}
 
 	if (ifindex >= 0)
@@ -853,6 +856,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		      struct netlink_ext_ack *extack)
 {
 	struct tc_u_common *tp_c = tp->data;
+	u8 set_flags = 0;
 	struct tc_u_hnode *ht;
 	struct tc_u_knode *n;
 	struct tc_u32_sel *s;
@@ -905,7 +909,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 
 		err = u32_set_parms(net, tp, base, new, tb,
 				    tca[TCA_RATE], flags, new->flags,
-				    extack);
+				    &set_flags, extack);
 
 		if (err) {
 			__u32_destroy_key(new);
@@ -914,6 +918,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 
 		err = u32_replace_hw_knode(tp, new, flags, extack);
 		if (err) {
+			if (set_flags & U32_SET_FLAGS_BOUND)
+				tcf_unbind_filter(tp, &new->res);
+
 			__u32_destroy_key(new);
 			return err;
 		}
@@ -1075,14 +1082,14 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 #endif
 
 	err = u32_set_parms(net, tp, base, n, tb, tca[TCA_RATE],
-			    flags, n->flags, extack);
+			    flags, n->flags, &set_flags, extack);
 	if (err == 0) {
 		struct tc_u_knode __rcu **ins;
 		struct tc_u_knode *pins;
 
 		err = u32_replace_hw_knode(tp, n, flags, extack);
 		if (err)
-			goto errhw;
+			goto errunbind;
 
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
@@ -1100,7 +1107,10 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		return 0;
 	}
 
-errhw:
+errunbind:
+	if (set_flags & U32_SET_FLAGS_BOUND)
+		tcf_unbind_filter(tp, &n->res);
+
 #ifdef CONFIG_CLS_U32_MARK
 	free_percpu(n->pcpu_success);
 #endif
-- 
2.25.1


