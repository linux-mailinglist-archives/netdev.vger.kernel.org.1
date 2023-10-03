Return-Path: <netdev+bounces-37762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEACC7B70A7
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 20:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C849A1C2032D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815D3C68D;
	Tue,  3 Oct 2023 18:19:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5CE36B18
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 18:19:24 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442290
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:19:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8191a1d5acso1419204276.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696357162; x=1696961962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0kRX0mHyjN+ltUV2mI07fVi115pYU+W9FTrXUUL/GJw=;
        b=h3CPIMJGVrUkb948WgcuLyD/KkxLCY8PCHeUfnbOku/E5JGYVihGU4qMeR/acM4kHw
         TZE7+UOLotlcPrxRsVaW0arIWS/oXPOHtgh8R9g+jrB9eZSyVCMClzEPTb+iQlWaSjPS
         BE7r1+W73Dz5jXgieDyiSwSI4kY2RWLJaiUf/U7LWjzkkl/XSWsv+mRW63S8Qj9O7iNh
         089YYlj2ooVPQXdP7+07GxnOu0gXqSFOuoJSbEFeUgj/5N3OAaMsyThSnMlJ0FFx5lgr
         qUldDVUzf5lKpcF/MleNfS4kvEBg7nRY+fBnXQdIWgAVmx/ES9QaAcs2Gns+poBKSL9W
         ZZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696357162; x=1696961962;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kRX0mHyjN+ltUV2mI07fVi115pYU+W9FTrXUUL/GJw=;
        b=n+3+BVLhKbbQQZgXfEtnGVfqZXMVJ/m9LcAETJiIVvsuP18I0+3yMUEVnB0Mi14WF1
         iBhhq3B59+KDV8B8yr0CB4ULSoeVIXvJiowUMRlzjmdBzehFuI1O9m0py6OnVghHjlBt
         D0KVguawR4sM9wDRHydPlQarJ+ykebXevtuli7epnb9Z+nzWw7Uy3/kjKPxOyGZ+BM3P
         8pkxVV7jzaeT/EQzmguTOwEjuIQih5DEOfiZMOfvRZKAn01olRUyleltTIRUCJ3ByxLs
         SGpc5B7TEQx+IgH20ZfghA/oKRG/CGVy2K+B3u11uLp4dCZeyNqaivMzdHaFXA1rfFSO
         jbjQ==
X-Gm-Message-State: AOJu0Yw48hOhDxloEgxRBh29MEd7/WGj1Rxo9sOWqluGWvBaRIoFKYbp
	zyEkHwgqzRJ6CEjqwu3NU31asmZwQJH4Yg==
X-Google-Smtp-Source: AGHT+IEmXtB+PD3QqdVUWU9nRZ/s6THlKgvqKFJihDFvLjjtiVuIYZb+cMqzpgIA0amQwjrfuiiP/S144gVE4g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c057:0:b0:d77:f4f5:9e4 with SMTP id
 c84-20020a25c057000000b00d77f4f509e4mr630ybf.2.1696357162366; Tue, 03 Oct
 2023 11:19:22 -0700 (PDT)
Date: Tue,  3 Oct 2023 18:19:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003181920.3280453-1-edumazet@google.com>
Subject: [PATCH net-next] net: skb_queue_purge_reason() optimizations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

1) Exit early if the list is empty.

2) splice the list into a local list,
   so that we block hard irqs only once.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 87f5372b197fff4ffef5df34ef126eb1e297ae4c..0401f40973a584ba4a89509b02510c8352bd6fb5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3722,10 +3722,19 @@ EXPORT_SYMBOL(skb_dequeue_tail);
 void skb_queue_purge_reason(struct sk_buff_head *list,
 			    enum skb_drop_reason reason)
 {
-	struct sk_buff *skb;
+	struct sk_buff_head tmp;
+	unsigned long flags;
+
+	if (skb_queue_empty_lockless(list))
+		return;
+
+	__skb_queue_head_init(&tmp);
+
+	spin_lock_irqsave(&list->lock, flags);
+	skb_queue_splice_init(list, &tmp);
+	spin_unlock_irqrestore(&list->lock, flags);
 
-	while ((skb = skb_dequeue(list)) != NULL)
-		kfree_skb_reason(skb, reason);
+	__skb_queue_purge_reason(&tmp, reason);
 }
 EXPORT_SYMBOL(skb_queue_purge_reason);
 
-- 
2.42.0.582.g8ccd20d70d-goog


