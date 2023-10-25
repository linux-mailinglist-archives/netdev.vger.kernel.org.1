Return-Path: <netdev+bounces-44063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8F7D5F77
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2792B211FC
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B479917ED;
	Wed, 25 Oct 2023 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y6pkMVGf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E317EC
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:24:22 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189BA128
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:24:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a8ee6a1801so64838407b3.3
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698197060; x=1698801860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3g14t+5qsI65xyEWsJP7vu00PnJ3vaZ3BJ65yO1jio=;
        b=y6pkMVGfzB1l/JPfSn++wDDk7PzJzcsS8C/DRTZ9FSEHNmWst5h0yKXmzuNtrEALNY
         /35Nrnf4XII5DiqInJrdKg3kMEnhpn10mOXAPDKeYZ3e29hSGjajOfRKSMsJhbYQr0BO
         Mx3Dl1N7Wn0EdHYAeOwRXbK0keDFrnlnKifiWffBYiiK8WPvfj/7i9JDExqEtGh2yLoJ
         Jivgwi8p298958nDRo6LV08FmTaUOUCYruFrx837HpMfsIYxPO2wslaFNxiQLIw6weJD
         hjmvtUYRiGExUmSKSniW0fkpNl7vgyAcYxwS/wTT/ZStYgbtMVKIV+JjeTdDSpfI4BCy
         k5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698197060; x=1698801860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3g14t+5qsI65xyEWsJP7vu00PnJ3vaZ3BJ65yO1jio=;
        b=SqLpyVTjQl5A0NOHc4nzru6gKLU0xgngZ37JGLQ+XKyObkrvHowLdyRVcLo2BgcE8l
         AyaSuTp3j3KZv2PUo2k47LS9FfAlPvawRWwXa2n1qx+JzODMK8CB5hgUBI1oq0w9LxVt
         2H9K7ObvCOR5lr7Tw+nNjuYL2RJalSk5uI40x/0Xv5e28es1uwENtVYHXSpKhSMrEVYS
         IKAqz3GF+Gvpg24HKpK6YntYfnEZBhzDofe25Eh4O8CIdLOl6CXKK4MPt+VOCSTshKHV
         yxLz9BJXSDk+i66esIQabu9fTNWJZKtCqkb6XR9A5vhSTYl55pwOwhbuxnuGSLrFhRgw
         14Sg==
X-Gm-Message-State: AOJu0Yy3Zs/gCWrPACfC5IheVkoe+MvHaEuSD4U8JZoTjEywnDhbeu4/
	9z3vdPBa/mTU56AmBFczOHuUsuVdxqJPp7U=
X-Google-Smtp-Source: AGHT+IES/6ZeBUDNQY/I4S0Mu1aSTmV31IE2BzXJrDRimWBENQMm9lQCZx1bYRqxed1PCGIDfTYrbmUSDWXEmNo=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a0d:cac6:0:b0:5a7:b543:7f0c with SMTP id
 m189-20020a0dcac6000000b005a7b5437f0cmr322042ywd.10.1698197060283; Tue, 24
 Oct 2023 18:24:20 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:24:07 +0000
In-Reply-To: <20231025012411.2096053-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231025012411.2096053-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025012411.2096053-3-lixiaoyan@google.com>
Subject: [PATCH v3 net-next 2/6] cache: enforce cache groups
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

Set up build time warnings to safegaurd against future header changes of
organized structs.

Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
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


