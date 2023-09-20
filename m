Return-Path: <netdev+bounces-35319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9DA7A8DAE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 22:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2E1281DA9
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B2B405C1;
	Wed, 20 Sep 2023 20:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE519BC2
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:17:21 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC13A1
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bee08c13aso3347107b3.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695241039; x=1695845839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uj6P0v48M4kybTeH39AjAjcaPQnv+wxriaAZEolvkjk=;
        b=dQVLk4sMO4mfSItaqZ8Q3R9pCU3UTrLlgOubCzN2Y85rZkZK29/p7K3xVvV4FjQzul
         2sni9rjy6pxhIZG0O9NZla2jsjT/lFt885bngr63eNufnzu6okEbB53V6Qhb5dJ4YJv7
         Z5HihyXjvPSQElF0Q5VDnp+vZJfpezwFqx2NiB5vGTN9VrBxL8g0N40C4VHUbnbfIcBI
         /SgIXlGsF6HGiJt1uylmb1ZrX/dq/U8AYO8IwFBW9XhMkMM6gNFVdyCHQ9N0WpmePazE
         FPJgX7+OZ3ZiTLdYFqRt4bHvGefFirV5B9EFCy/9Ht330Beu0q+MCM3S2NOcm+KXeYBp
         R7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695241039; x=1695845839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uj6P0v48M4kybTeH39AjAjcaPQnv+wxriaAZEolvkjk=;
        b=Dq2dASmkJa0u/iQMRk+VKXFVhuWVEMiezZdiaRwj/Uf7HQtiLMhRcHQzC1IEJyp4ZD
         B0fbudcaVbCEZSAZhxzJU/0V+bHNu/XCsk5RiD9cKDrBMccGr9khzzyWREgsdDaYkPHP
         yN13FLyeWrgFE7xcdoi4bSJuG52EdoSd5OD5uhDjHibramqQygrEVlnGuUzAn0s01Fl7
         IKvXeec3HlUFgrR0nruAqk+LpZSwYOeBtDdkqZhTYyiO4U+qx4pA71YNa/xFRYAgyyf8
         Nm42ZaxwquEQTjyiY641XV5G1cPlJ6nTEBT4GDjVS3WK2S4nLwkIsqHVJ/ke7aA2F0U+
         PI3Q==
X-Gm-Message-State: AOJu0YyFXIMZ/vRf4PAYEqqCLJUnhLeZ8YGFuFbV1mbbHJhhRYrxjWcP
	jJOYC6wUVUxIREQK/mkJzNwm9KAWPjGfDQ==
X-Google-Smtp-Source: AGHT+IEvF/5LS2F4K69LwpAFVU48JW47ngatRsUCLXgFlHUYVAPqcPGFTmOlIVihI0UpFkpj7l9A4K4lnOVVeA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4323:0:b0:59b:d857:8317 with SMTP id
 q35-20020a814323000000b0059bd8578317mr54494ywa.2.1695241039004; Wed, 20 Sep
 2023 13:17:19 -0700 (PDT)
Date: Wed, 20 Sep 2023 20:17:11 +0000
In-Reply-To: <20230920201715.418491-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920201715.418491-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920201715.418491-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/5] net_sched: constify qdisc_priv()
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

In order to propagate const qualifiers, we change qdisc_priv()
to accept a possibly const argument.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/pkt_sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 15960564e0c364ef430f1e3fcdd0e835c2f94a77..9fa1d0794dfa5241705f9a39c896ed44519a9f13 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -20,10 +20,10 @@ struct qdisc_walker {
 	int	(*fn)(struct Qdisc *, unsigned long cl, struct qdisc_walker *);
 };
 
-static inline void *qdisc_priv(struct Qdisc *q)
-{
-	return &q->privdata;
-}
+#define qdisc_priv(q)							\
+	_Generic(q,							\
+		 const struct Qdisc * : (const void *)&q->privdata,	\
+		 struct Qdisc * : (void *)&q->privdata)
 
 static inline struct Qdisc *qdisc_from_priv(void *priv)
 {
-- 
2.42.0.459.ge4e396fd5e-goog


