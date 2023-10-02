Return-Path: <netdev+bounces-37413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE35A7B53CC
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4568D283B9B
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40218C2E;
	Mon,  2 Oct 2023 13:17:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1118E30
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:17:50 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57235AD
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:17:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d865f1447a2so21515802276.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696252667; x=1696857467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKYrJ0sSn9lpNL8ZCIPRba7t8pP3Xfi2eXOfhQuPt6A=;
        b=XoBSNAGxqn4kM5ZxvRYI+AykVdddM34MXhX/xxm0/9DY+KLQVRy+dyKB4xKK1n/IRf
         2RyqlxVLBltrrJeaws5WkshNsKuXO0BshClo7BqYZgTaN46/dRzpngnV+DJJYis4jIQ+
         YbRxe8Lh1Pfe8V9VYcunF7dp/NRqmHZaMMzGoYyto/wL6fG3vTpEb8TMBpcrF7R1cZQ0
         f9l96rRnbpAYxHWEofRZDRSVVRw2j7vBbR6wpzH2XAKS8BdO6+R4+P7PQThwGq60wnk4
         q5AjnvERfv0ifoKI8FfqnDjK9GThKWKt2LuYmViB7Y4LZr+6WZje2XZ/eBhQFZy6Kwz8
         eiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252667; x=1696857467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKYrJ0sSn9lpNL8ZCIPRba7t8pP3Xfi2eXOfhQuPt6A=;
        b=eG91pOXtUNw7ev7NAgrTjYKxJZUf7WT1RzVMEWINQ0eUzAVnHDAp18gMItrEALzlS9
         1YpIgJxP/0fkEjk14uqdnV7WH+3UIV2wUbvePhrHlNSFgUz/GUZORLeOTm4gRq1D6WXo
         5HVummB0+vEzdGgdaT5GoYQ1h9AmwNSIq3LW0vGKm+ZdixL/N0cevM/OvcNxP9U4/fNV
         0om98qIgXtZZmjT177dhNQcGE21qP8ZTOA2bbWPovgUIn31tx/FuOatxIEk7jslBkbcw
         trouoCAxBGOcO8+wjLOdtVoJ4ZaqzFQU4dkejSZ2c65s5qhoZBDKxexy15XGyckkFQn4
         V6Vg==
X-Gm-Message-State: AOJu0Yy+seuuL2cFnr6fvsvb+0Uig0UfW6SI/tMWRAE650RD9K3TJLRR
	UhpuO0dsrQIQCiBmIW8dvgMd5mCRrs+EOQ==
X-Google-Smtp-Source: AGHT+IEQHd0tjglaqsYFcFFvIyYM8ZZc6h37q7fSg+rchebDsHaZhdZT9d1M0v7BJwsl+nbBUw6YMlNFLRpgwg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:1983:0:b0:d89:425b:77bd with SMTP id
 125-20020a251983000000b00d89425b77bdmr172266ybz.1.1696252667579; Mon, 02 Oct
 2023 06:17:47 -0700 (PDT)
Date: Mon,  2 Oct 2023 13:17:36 +0000
In-Reply-To: <20231002131738.1868703-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231002131738.1868703-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002131738.1868703-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] net_sched: export pfifo_fast prio2band[]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Dave Taht <dave.taht@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

pfifo_fast prio2band[] is renamed to sch_default_prio2band[]
and exported because we want to share it in FQ.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-By: Dave Taht <dave.taht@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
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


