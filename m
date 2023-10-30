Return-Path: <netdev+bounces-45148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B893F7DB2CD
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 06:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A9F2813E0
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 05:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C95137D;
	Mon, 30 Oct 2023 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDIq70a+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA621366
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 05:26:01 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1459A9
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 22:25:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7af69a4baso41254927b3.0
        for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 22:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698643559; x=1699248359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TLMxcVJBr99DoA91v//eh8cnnMypK7ZZnh8xEJyBo40=;
        b=MDIq70a+FiavkZkuuzkmk7qyMG72GJACTz1E7aiNc8AHnTdtwHujMzl5qGL5muUiQ3
         bgvKHq19lM0/GNFWPLWMho8pl16GZVvU7NpQoP5jpUsI5QGGpEpFX2BQyZU7j+xNBMBn
         42JdJPzkKwcRcHk1kFTSXKf6/aN1/sWFM2NxfxLY33DY/JqVf0Wl16SeFfNSDmK6iyO8
         uiLXo/tUZlZG8lXNuAWtdQhiuZ1SV54OxM68Fc+p+Hk/2c5D0/j80bpzfCnLnNS1BIro
         GdzKgBEcKuv3pBLA3nymb6kTcWhmxG+p9yWR3xI7eVtkuBntjUhKforo7N2raBybh79R
         psCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698643559; x=1699248359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLMxcVJBr99DoA91v//eh8cnnMypK7ZZnh8xEJyBo40=;
        b=B7iQA1yYe36jEcu3HQ30C6sylF3ObD24NE95aAQVuJDqA8TCkGaN642wUTwL+MMVub
         MUp0sh8brCqNVrGHJsBzCuCVPKlbeKclvlsXuRpV7puvKJ8kh6TnZcWC2EvyDt7qGL9H
         O3dsFNwPsKDQn6w8cSEsLKIOyKinZjtb60flAzD6FD7TcnomUHyDTvkOTkpxkVVH5Mzd
         kVu5F94YuIN83NuPCr9TlmFARh43lLiV3IG0LqaJwEjSVqelClEK7zzf+plYI/oucJFm
         QXLUr8732icn8pfnKsgKVrkQ2spQZwet9z6gP2VkERpUYhAatqUh4k7hhSyd4N9Sknmx
         3Nyg==
X-Gm-Message-State: AOJu0Yxw9zYKK/eRYZTA521ZvrYk0KrQnHNyj88DD8X/G5+1RJw0rbct
	4t3K5Or/lIG8U4eOD5rCFS2ddJc1QZXMlss=
X-Google-Smtp-Source: AGHT+IGvKAbvMTQWQJhSW05pe9YMrmUCCMDTFsSmSzqksA5mLJa0drB2L3lGofTymjCteAPgO0ynSuqUOcPSXow=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:690c:2a45:b0:5af:a9ab:e131 with SMTP
 id ej5-20020a05690c2a4500b005afa9abe131mr153412ywb.1.1698643559264; Sun, 29
 Oct 2023 22:25:59 -0700 (PDT)
Date: Mon, 30 Oct 2023 05:25:47 +0000
In-Reply-To: <20231030052550.3157719-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231030052550.3157719-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030052550.3157719-3-lixiaoyan@google.com>
Subject: [PATCH v6 net-next 2/5] cache: enforce cache groups
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


