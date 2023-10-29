Return-Path: <netdev+bounces-45052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FD87DABA0
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 08:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE46F1C2094F
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24E7476;
	Sun, 29 Oct 2023 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVaPCSUJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035D8F5D
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 07:52:56 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF6DF5
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 00:52:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b0c27d504fso4188677b3.1
        for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698565974; x=1699170774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TLMxcVJBr99DoA91v//eh8cnnMypK7ZZnh8xEJyBo40=;
        b=iVaPCSUJiJkovG1dAUf+4UKgy/9qdqY44RqU7P5HOzzRJwG+79oXMiNS2bpU622iWU
         cM03pn0JVbrKNaqxX4osNxiHQrZjGcvBS9t+Vl/mNiONFxYB3mxawkky36l6H8XavB0E
         93ZshPzENp8TYp1buu02lcv+G2BvS20yqJ6V5SfvuzCbRQl883iTrsyXmaVa/N3+VcjQ
         MkzBZzlEt9VAdR7DlSQNx+TLkg+Jut+skrhf0ObLbvrsfzevNkdMk7NeGaMHyyWMwquj
         mPH5Ffr/S7amF11fj3AyKyy+H1qmsMl4IOn0C7DSW8vkfngQIpWuz8wNFB3Mdy0xHRYr
         VBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698565974; x=1699170774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLMxcVJBr99DoA91v//eh8cnnMypK7ZZnh8xEJyBo40=;
        b=Jusjwuw/PNqfwznR9qJdsJX34ceTfvgIRS03pb6uJKQlqrJ4a8vQJzy+kKPR5I+IvJ
         gxrgfOUJCPKW8YCcDm2/AzK7Wnau25bJnlbd1Gm39OHKS1ABHuTwcERRtZqTWtGdJ8kd
         2gQ55ziilleiHGxmJ308zF9YqEjvai4DqLPPQp37NzmujLFG7p5zlVO28K2DcslxIdWO
         pFeEgGKO7VSWZ+jrlwq17bQ6PL0KKtnUyCgU8Jw4NIOFARjcDoxP/x58DZdu/T7oNQRV
         BjryIJVjDaoQm+JhUsidSgglidIBt6bxAjrqJVx/7x7ZK6Oa8bYaO0O9ILuJuPCpQzre
         eEHQ==
X-Gm-Message-State: AOJu0YyIEKFqMDxoZmmQH8HWbI9dMpbX9CqxLObGSht7YBM6zvCFDVrO
	YNve+Xv8g69cWAsW6fIVFjGII/WUf8BHtvY=
X-Google-Smtp-Source: AGHT+IHIB3OYqxUOkekFyIjmZBEja3p+3HT4pmXl3zRKRnrTVMvTWfkUip8Z93UP3lB4CJ28Kgqoy3rTaQlAOCc=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:690c:ec6:b0:5a7:d45d:1223 with SMTP
 id cs6-20020a05690c0ec600b005a7d45d1223mr362883ywb.3.1698565973974; Sun, 29
 Oct 2023 00:52:53 -0700 (PDT)
Date: Sun, 29 Oct 2023 07:52:41 +0000
In-Reply-To: <20231029075244.2612089-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231029075244.2612089-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231029075244.2612089-3-lixiaoyan@google.com>
Subject: [PATCH v5 net-next 2/5] cache: enforce cache groups
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
2.42.0.820.g83a721a137-goog


