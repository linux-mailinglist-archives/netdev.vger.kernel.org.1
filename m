Return-Path: <netdev+bounces-44409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD0F7D7E5D
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE901C20F23
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C751A590;
	Thu, 26 Oct 2023 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cO56CG2W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C31A58A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:20:17 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F7C1A2
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:20:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cafa90160so494283276.2
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698308414; x=1698913214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=95BJUK6w9rQC76aImC1lM6iRdy5XAs4ZVlWb+aV3KGE=;
        b=cO56CG2WCwTvK/udmVy8RRTabtYIEa+eafIcO3KZWGOwlKiVGLOzpdHifhd9Co4Qyl
         b4vbqCSFzQN00tpTIvEh90+S5jOKoySW0KZqmGZo2o1GAzzJpqktbLbkOjJHkbBmwOwn
         VSe2Ap9kpT/fWwmZtOnxEsrujA8GifCL4vd1/k9PKlxU/F1sqq5g3o0Oua1JxwvLV5M7
         ZEFTzFgb0JS2rTtloAyFxNHaR70ucOchDYDVgoN8qJQht1Z/Mzl9lRWn5AW4N3joXnW8
         +E7FwasP1wN2evg7OcpBT2Vxt4MMlbERe2O9A2gAcEV7x5JBlLSHBllVtbpymZ9/7rn6
         xoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698308414; x=1698913214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95BJUK6w9rQC76aImC1lM6iRdy5XAs4ZVlWb+aV3KGE=;
        b=eWTLE/NZ0qjwL+UNGVVfbplskKgesVHWGsjUgxHWDDfSKbCwP2uO6qlcw+s/SrQFUc
         +NZtQXIRdRaHxUVLOUng/hY0jLRy8zC5FAbARikFgX+SPyubMhdTmQyejkKgtxijByLy
         v7U+2umO2uzUzWu/cALaT9VR9GvVwGQohY7TAP09oQePX8n33CIHuL6NvJvA8V6QzP3i
         FY5s8p9Hj9KImR1/B5Bb2pPEsm1UVQR8tXTTfZ7VHZmrim8H2Upa+SoPMxHHQYnfkKwI
         XfHhOov4vgzYUNhiZFHdQlupzwFlebFxXUct8SNPIp90fKIieDN4CU3SuK6CR8Okw6PM
         WhAg==
X-Gm-Message-State: AOJu0YwvhsOdfuyUh0OGi/OD1Ce+LY5pSNX9TNy2/mS3D9n/qicUJrzD
	XLCWqI19U21wJimJh2i9RO9Y3Lar+3ufwPA=
X-Google-Smtp-Source: AGHT+IF8mwDm53cDiZAEAwBSQ19GrMI1zC5NjfWtQYgWBPVKJh/1QoMJPc1vAGE58i28gWESEGqYU6y8i/P/kp0=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:6902:105:b0:da0:3da9:ce08 with SMTP
 id o5-20020a056902010500b00da03da9ce08mr150482ybh.10.1698308414651; Thu, 26
 Oct 2023 01:20:14 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:19:55 +0000
In-Reply-To: <20231026081959.3477034-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026081959.3477034-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231026081959.3477034-3-lixiaoyan@google.com>
Subject: [PATCH v4 net-next 2/6] cache: enforce cache groups
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Set up build time warnings to safegaurd against future header changes of
organized structs.

Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/cache.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 9900d20b76c28..4e547beccd6a5 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -85,6 +85,24 @@
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
 /*
  * Helper to add padding within a struct to ensure data fall into separate
  * cachelines.
-- 
2.42.0.758.gaed0368e0e-goog


