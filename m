Return-Path: <netdev+bounces-47527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158717EA6FA
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 018F8B20ACB
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2373E467;
	Mon, 13 Nov 2023 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vV1Z2NUU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C483E466
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:33:15 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69FC6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:33:13 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5af9ad9341fso70275717b3.2
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699918393; x=1700523193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zle4ISef2+j80rtH4JGNBCkHVauIyTC4nsEMpCsnoW4=;
        b=vV1Z2NUUcfJm7icy1Lk6ZQI4bk4FRI25PJO7FX9QDCd8SnHcJ9FduO8LLUsr/HQR2E
         b5qYt/0sZcQO3XJXwtNVgV/wiwV83AQcllieRDkH4IgaUlH1gz6O5EB6J+E6HLuBKZ9m
         S9FAvNgUolt3Rele35bu/E/dvOHR2HBTtWgQoIa1YD36oLPlKJK8yzAYpa656Z3AN56t
         W7GgFJVyJTH3H1btJMOIG8iPvwpWF6v34An2kBz7PMZ7Pov2YAzyifswnZJQpfFMgD3g
         DI+NYUZcAEI34J61Im8Qn41WyfYUysTt47Jc7+vOecDjZzRUo1VF+OU1JhQECeVqxP6c
         bLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918393; x=1700523193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zle4ISef2+j80rtH4JGNBCkHVauIyTC4nsEMpCsnoW4=;
        b=KKx23uvuU/d3T5XKmUCAKauyt6MwY2mkOmD3hL7prXiEC1Ns1VMh1ReNfPxisygTjc
         uuq2DAzM1nO165JOFbwkM3yh12m4lrRO8IQtK9tyHQkJntGIv3XQz2QCLfz7clHBluPZ
         O0c3FyYTUOKi7xPly1W6fj71EWLuPDwNNk6E5lgRND5Z79YctPdL+ufnazKaQ/RP0Q24
         aWiEZzsDapFOFAnLbJoSrvhelc7QncPEj396vltGlUlrNCjJ4D8ECdCI+E9RvY3DvkVF
         iGuYeRratXP+rEv4FVyEY01m5lTmbIbdrS8dNR37MD08xB00B5PZLsg+vkVt8jz44ubp
         qUSQ==
X-Gm-Message-State: AOJu0YwiAABfMWg6Ky0beI6trZWuJrqcDBE5JnWBZDd4N7aOTbBntzzf
	tAO7UXz1bpXGkpeoEoMmB2bIaxC7/WSmG4M=
X-Google-Smtp-Source: AGHT+IFKdDfS7A3HnTzXCBEzqf6HJcCqrkatV1kCoZdnleWGTXpaHpXmHiIQse4ntkFoZsaU7ud2AQIgl4GxDhY=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:c04e:0:b0:da0:4f83:60c1 with SMTP id
 c75-20020a25c04e000000b00da04f8360c1mr194430ybf.9.1699918393083; Mon, 13 Nov
 2023 15:33:13 -0800 (PST)
Date: Mon, 13 Nov 2023 23:32:58 +0000
In-Reply-To: <20231113233301.1020992-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231113233301.1020992-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231113233301.1020992-3-lixiaoyan@google.com>
Subject: [PATCH v7 net-next 2/5] cache: enforce cache groups
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Set up build time warnings to safeguard against future header changes of
organized structs.

Warning includes:

1) whether all variables are still in the same cache group
2) whether all the cache groups have the sum of the members size (in the
   maximum condition, including all members defined in configs)

Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/cache.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 9900d20b76c28..0ecb17bb68837 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -85,6 +85,31 @@
 #define cache_line_size()	L1_CACHE_BYTES
 #endif
 
+#ifndef __cacheline_group_begin
+#define __cacheline_group_begin(GROUP) \
+	__u8 __cacheline_group_begin__##GROUP[0]
+#endif
+
+#ifndef __cacheline_group_end
+#define __cacheline_group_end(GROUP) \
+	__u8 __cacheline_group_end__##GROUP[0]
+#endif
+
+#ifndef CACHELINE_ASSERT_GROUP_MEMBER
+#define CACHELINE_ASSERT_GROUP_MEMBER(TYPE, GROUP, MEMBER) \
+	BUILD_BUG_ON(!(offsetof(TYPE, MEMBER) >= \
+		       offsetofend(TYPE, __cacheline_group_begin__##GROUP) && \
+		       offsetofend(TYPE, MEMBER) <= \
+		       offsetof(TYPE, __cacheline_group_end__##GROUP)))
+#endif
+
+#ifndef CACHELINE_ASSERT_GROUP_SIZE
+#define CACHELINE_ASSERT_GROUP_SIZE(TYPE, GROUP, SIZE) \
+	BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GROUP) - \
+		     offsetofend(TYPE, __cacheline_group_begin__##GROUP) > \
+		     SIZE)
+#endif
+
 /*
  * Helper to add padding within a struct to ensure data fall into separate
  * cachelines.
-- 
2.43.0.rc0.421.g78406f8d94-goog


