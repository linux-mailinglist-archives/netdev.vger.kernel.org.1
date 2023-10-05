Return-Path: <netdev+bounces-38192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06FD7B9B81
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 09:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A00AB28174D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 07:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1252569D;
	Thu,  5 Oct 2023 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSqc7DGm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46A7F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:49:30 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C787ECD;
	Thu,  5 Oct 2023 00:49:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0ecb9a075so4459395ad.2;
        Thu, 05 Oct 2023 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696492169; x=1697096969; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNVpwFwUzdTjdcx8LxWNrxnvfOWjcBf4eGnf1qLnD3E=;
        b=VSqc7DGmLlZKs7rgnu6vEWoDfjJWmFLe2Kgr5lBVrvMzbWWYxPoN5vsz0bpSBkrjWo
         o7mTvL0aSDEGUYLkfbWEl/I+7JiPXy/zNx2Qxn2jLox47zMFEuD0nJsbXkNQ8V1KRb3W
         EuZ1ezjATUBLfQzVRwXsytGy44Xo00Qb8HLe5xn/214gU5umLfMMm3qXSBN08K1hQJ8g
         uiEfLNmOpDv+fbjYXc+I+ChMQPag6i0chZlIGtsoGrk68jGpfDxBkXARezACZTq5msX1
         PsU4ZCZrk3mIh96CKfryaemqPR6R9/wdUQwSgyRD+OvKDbfl/eCKHCOjZjl5GlRhuK/4
         ytLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696492169; x=1697096969;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNVpwFwUzdTjdcx8LxWNrxnvfOWjcBf4eGnf1qLnD3E=;
        b=BWQy7VbPXV307LNXuPxhZM7tEYUDAdeE59/DhVW5JKD4bzausXZYidmH4aXH4jhKU1
         Z+IcjboRY2RuyCo2Lp18G/6QhbpEedYkCqORVi9pWUqAfAYvru2bKPxgOLS3uE2HfhGp
         LThfMJ0cn0rBc5+eNqus0+EMO8sh9NJ58R52TOdf9hGU1N/wWRIuAOqbRw1WHoWY2cax
         t1q9QT16tsRusvweLgyelKOSZ0j8nEuK5VJDTsb83lS6XQxW0vmjI4TyQjF7LkB6p8vK
         nKo98s+1gkQvrM9uPUpcgdH/grMzBKQkE/IIYNQuK5BbeRNO53aBqDXArVZbPcvdMb0v
         YpUw==
X-Gm-Message-State: AOJu0YxIRK8P04bzqku/i8GRDubakBJniC2Cy7nLU6hnuucBwtHoR+V5
	ZRiouddvZoliWTUYkW2HUF0=
X-Google-Smtp-Source: AGHT+IFzKI5i0LPDa9jvu3lqeTN/TjsrZlfUF/B0Jien7fzcUl1Oz4tSh5fXEFo/KKGJ9jm0xHiL/A==
X-Received: by 2002:a17:902:d4c4:b0:1c1:e7b2:27af with SMTP id o4-20020a170902d4c400b001c1e7b227afmr4822042plg.57.1696492168788;
        Thu, 05 Oct 2023 00:49:28 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ea8c00b001bf846dd2d0sm920239plb.13.2023.10.05.00.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:49:28 -0700 (PDT)
From: Chengfeng Ye <dg573847474@gmail.com>
To: 3chas3@gmail.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2 2/2] atm: solos-pci: Fix potential deadlock on &tx_queue_lock
Date: Thu,  5 Oct 2023 07:49:17 +0000
Message-Id: <20231005074917.65161-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

As &card->tx_queue_lock is acquired under softirq context along the
following call chain from solos_bh(), other acquisition of the same
lock inside process context should disable at least bh to avoid double
lock.

<deadlock #2>
pclose()
--> spin_lock(&card->tx_queue_lock)
<interrupt>
   --> solos_bh()
   --> fpga_tx()
   --> spin_lock(&card->tx_queue_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_irqsave()
on &card->tx_queue_lock under process context code consistently to
prevent the possible deadlock scenario.

Fixes: 213e85d38912 ("solos-pci: clean up pclose() function")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
V2: add fix tag, and split into two patches

 drivers/atm/solos-pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 48cf9b36b61a..247e9200e312 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -955,16 +955,17 @@ static void pclose(struct atm_vcc *vcc)
 	unsigned char port = SOLOS_CHAN(vcc->dev);
 	struct sk_buff *skb, *tmpskb;
 	struct pkt_hdr *header;
+	unsigned long flags;
 
 	/* Remove any yet-to-be-transmitted packets from the pending queue */
-	spin_lock(&card->tx_queue_lock);
+	spin_lock_irqsave(&card->tx_queue_lock, flags);
 	skb_queue_walk_safe(&card->tx_queue[port], skb, tmpskb) {
 		if (SKB_CB(skb)->vcc == vcc) {
 			skb_unlink(skb, &card->tx_queue[port]);
 			solos_pop(vcc, skb);
 		}
 	}
-	spin_unlock(&card->tx_queue_lock);
+	spin_unlock_irqrestore(&card->tx_queue_lock, flags);
 
 	skb = alloc_skb(sizeof(*header), GFP_KERNEL);
 	if (!skb) {
-- 
2.17.1


