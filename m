Return-Path: <netdev+bounces-37273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774567B482E
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EFA0928228A
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846ED179B1;
	Sun,  1 Oct 2023 14:51:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956616414
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 14:51:10 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A05D8
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 07:51:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a21c283542so61487917b3.3
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696171868; x=1696776668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntMnGTm5yN134wP9+7LPVLHxPmVMWR6Fvgd111gFySk=;
        b=AxPiFpdDwOTUxYOPY14zREoXwfYPnGhxhIrxTTrJa5Ns5e4WIQaGin+sG3YnnsB0p1
         8/QeYX2kLofmIlva2MiXQwos4llJ6AdjsccX86wEvhVnpEkKvpB85+1RDdaHKC6Gt5zy
         hCF5L6NCIIvNw/YbScy3HAyUyXP0cmZ5xGvy8votFanB/89BhMA0rsk3YHZaj83ATDLe
         zz/gyxtI6HncmCa/kSErxWlmjOcb7E6wXFRNjfKQvqbcubim85Fv04y8ia7lBbZKetmZ
         mYx+QfU2W67QJTWI49RWsSTeiXuL1yfrMCwOXFzpC1xJup/a7W0VUP8Gtc8RiE05YMb+
         lMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696171868; x=1696776668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntMnGTm5yN134wP9+7LPVLHxPmVMWR6Fvgd111gFySk=;
        b=hVc9/qFYwYm/0tD+uHVOqCr19xnzqWxfr1ipVxfOJYuUh1KHY5PzV/wxEKLey40hxO
         jgtdD0dDo94EKoxf/T5aPqxHT0C+4LGEYAApO5EZGoNMjecm1N4kXgJO49yK4iwuk5qW
         DBavNXWZRRLh7wK0Kxh+hvtRxxK3NPcnMZYl73J4GlazdCQMXLmCjHIl6U1I3D5OoLri
         VTUgRUgZ6cjwEwQ8yCjOdnH8Ivgu9wD7yjLXZx7CedSSW7R/vQnb/1T0CJcATWSdveVl
         g0lH2ZZbuU7CD6rCwjM3k2YZajK9ExA4SPmegNmX6eFhCk3IxJIDt32cUMur7DSwg5m7
         7JkQ==
X-Gm-Message-State: AOJu0YzbvCE5r+GLMdOBQVjgUWMwMy3JSCR7eDgspRy0fOsBdxE9mCSF
	sOfHqoWb66sZeSJuMkhboTdP3ay4l+ha1Q==
X-Google-Smtp-Source: AGHT+IHcPuNC13jJwOgcEHGXY7xQhMX5uScBm4qWodDjDjdU8OJzr9xqd+TxukM3s48QqBn2XGg1UOEPk/SGPw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b612:0:b0:59b:edd3:fdab with SMTP id
 u18-20020a81b612000000b0059bedd3fdabmr156943ywh.4.1696171868380; Sun, 01 Oct
 2023 07:51:08 -0700 (PDT)
Date: Sun,  1 Oct 2023 14:51:00 +0000
In-Reply-To: <20231001145102.733450-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231001145102.733450-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231001145102.733450-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net_sched: export pfifo_fast prio2band[]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

pfifo_fast prio2band[] is renamed to sch_default_prio2band[]
and exported because we want to use it in FQ.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 1 +
 net/sched/sch_generic.c   | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f232512505f89622517f87a24b35c3a441c81b3d..c7318c73cfd632b730ca1e943c777f0475cd6458 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -587,6 +587,7 @@ static inline void sch_tree_unlock(struct Qdisc *q)
 extern struct Qdisc noop_qdisc;
 extern struct Qdisc_ops noop_qdisc_ops;
 extern struct Qdisc_ops pfifo_fast_ops;
+extern const u8 sch_default_prio2band[TC_PRIO_MAX + 1];
 extern struct Qdisc_ops mq_qdisc_ops;
 extern struct Qdisc_ops noqueue_qdisc_ops;
 extern const struct Qdisc_ops *default_qdisc_ops;
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 5d7e23f4cc0ee4c8c2c39cf10405f56fb6f0bfe1..4195a4bc26ca7932edb7b60b383f7887d960f3ca 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -694,9 +694,10 @@ struct Qdisc_ops noqueue_qdisc_ops __read_mostly = {
 	.owner		=	THIS_MODULE,
 };
 
-static const u8 prio2band[TC_PRIO_MAX + 1] = {
-	1, 2, 2, 2, 1, 2, 0, 0 , 1, 1, 1, 1, 1, 1, 1, 1
+const u8 sch_default_prio2band[TC_PRIO_MAX + 1] = {
+	1, 2, 2, 2, 1, 2, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1
 };
+EXPORT_SYMBOL(sch_default_prio2band);
 
 /* 3-band FIFO queue: old style, but should be a bit faster than
    generic prio+fifo combination.
@@ -721,7 +722,7 @@ static inline struct skb_array *band2list(struct pfifo_fast_priv *priv,
 static int pfifo_fast_enqueue(struct sk_buff *skb, struct Qdisc *qdisc,
 			      struct sk_buff **to_free)
 {
-	int band = prio2band[skb->priority & TC_PRIO_MAX];
+	int band = sch_default_prio2band[skb->priority & TC_PRIO_MAX];
 	struct pfifo_fast_priv *priv = qdisc_priv(qdisc);
 	struct skb_array *q = band2list(priv, band);
 	unsigned int pkt_len = qdisc_pkt_len(skb);
@@ -830,7 +831,7 @@ static int pfifo_fast_dump(struct Qdisc *qdisc, struct sk_buff *skb)
 {
 	struct tc_prio_qopt opt = { .bands = PFIFO_FAST_BANDS };
 
-	memcpy(&opt.priomap, prio2band, TC_PRIO_MAX + 1);
+	memcpy(&opt.priomap, sch_default_prio2band, TC_PRIO_MAX + 1);
 	if (nla_put(skb, TCA_OPTIONS, sizeof(opt), &opt))
 		goto nla_put_failure;
 	return skb->len;
-- 
2.42.0.582.g8ccd20d70d-goog


