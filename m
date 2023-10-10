Return-Path: <netdev+bounces-39479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4ED7BF6EF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B741E281B40
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60B168B6;
	Tue, 10 Oct 2023 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HyKucTHG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DBF16429
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:13:30 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A877A9
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:13:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-406619b53caso50022005e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696929207; x=1697534007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3LNEM/3RYbYoGteRoHDoFeUwZb7H2Soc5dB4GPyq1k=;
        b=HyKucTHGvrBlSTIG6eMArv3KITLMcmOFRhJ85yGPh9tBfuCOx58sYPuiAyfW0v/qej
         Txm/sdFgSzmtts8FriFdUUuFML2tprAGdfj2AulonAjXQvfhFwqUurGeUY4ToFSq3G3M
         EgkjJTp7eDjUMGLZerEXgaauDxdftvfYQDG+SNU/bQDO6UZvE0waoJ3hFwImqvXHxura
         xewLHj7xwX7J2dmwGdTq3hlnypCIBT0KfS2ln6jD7uvUEzJzs5VD9tJ5wrXhdVvVEj35
         OYS/6h2W9ZwkqGcIDNTd3F9njFGJYpCnAGq0hP+EaNkMMenS0tvzp+efJYdDicOP6a7k
         zw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696929207; x=1697534007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3LNEM/3RYbYoGteRoHDoFeUwZb7H2Soc5dB4GPyq1k=;
        b=tjefS1AB6EHyjyJe4v4uYZtS5l5NRvMya48CWHJ9Q3fYvism+Cf7n2vmY7eS2TSHIY
         TzIxBk6iNddAYXNYR1NeoKp5wgcCrAn1TAza6OKNdE2dEFTzlmzSraFIs1xxk0ljKVEr
         vErMcqChEcAh8h4Ke0oA3qOPDz63vk7TwLX1HHXdR/bVbmJVihFipXTDZC7O/eldC0Xt
         2FbFz2X54PCQNS9DbCGxetHo9cVagarQhuwYFdagtTSTaf+AjVPjedUUy2KRto7+axYr
         x2nojUyyuHPtHmFo5o29nK//A7I4DtLcYvDwdwAa/s6hnUxCe+iUFDMR5Xr6uJySfWLF
         XvRA==
X-Gm-Message-State: AOJu0YwdSVlNGvdn7bsjSaOCyROenZvyE+kAK5t3kIPctjHVAhLviCty
	Hk0Xvb44w5wxdC2ZD9JafTS2N8/CJSQlcaWWMbM=
X-Google-Smtp-Source: AGHT+IHphsgrkj4nXJpaB5VYldmA7Bb2WqSVArv4uzp6n8tng/aaWMsKlvAGSAGI1G+Kogi6dOv2TA==
X-Received: by 2002:a05:600c:378d:b0:401:a0b1:aef6 with SMTP id o13-20020a05600c378d00b00401a0b1aef6mr15950497wmr.2.1696929206900;
        Tue, 10 Oct 2023 02:13:26 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040535648639sm13508236wmm.36.2023.10.10.02.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:13:26 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v2 1/3] net: treat possible_net_t net pointer as an RCU one and add read_pnet_rcu()
Date: Tue, 10 Oct 2023 11:13:21 +0200
Message-ID: <20231010091323.195451-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010091323.195451-1-jiri@resnulli.us>
References: <20231010091323.195451-1-jiri@resnulli.us>
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

From: Jiri Pirko <jiri@nvidia.com>

Make the net pointer stored in possible_net_t structure annotated as
an RCU pointer. Change the access helpers to treat it as such.
Introduce read_pnet_rcu() helper to allow caller to dereference
the net pointer under RCU read lock.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 include/net/net_namespace.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index eb6cd43b1746..13b3a4e29fdb 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -368,21 +368,30 @@ static inline void put_net_track(struct net *net, netns_tracker *tracker)
 
 typedef struct {
 #ifdef CONFIG_NET_NS
-	struct net *net;
+	struct net __rcu *net;
 #endif
 } possible_net_t;
 
 static inline void write_pnet(possible_net_t *pnet, struct net *net)
 {
 #ifdef CONFIG_NET_NS
-	pnet->net = net;
+	rcu_assign_pointer(pnet->net, net);
 #endif
 }
 
 static inline struct net *read_pnet(const possible_net_t *pnet)
 {
 #ifdef CONFIG_NET_NS
-	return pnet->net;
+	return rcu_dereference_protected(pnet->net, true);
+#else
+	return &init_net;
+#endif
+}
+
+static inline struct net *read_pnet_rcu(possible_net_t *pnet)
+{
+#ifdef CONFIG_NET_NS
+	return rcu_dereference(pnet->net);
 #else
 	return &init_net;
 #endif
-- 
2.41.0


