Return-Path: <netdev+bounces-103183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB6A906B0F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD5E1F24278
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7621411E0;
	Thu, 13 Jun 2024 11:35:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802713791B
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278510; cv=none; b=ZXQjutyubmDPUPKcck3gqHbYwNOVMVZ1w6ymLAAefQtaD99iPgem3XlKLHvpAe36ZgKHLG4N45EU2CetON9OSkdDAqbY4tlTQVSuexJ++nOHZxT9mHE0p3lhU0gpbxVWNEcPDrhrxu3jOTky3k+MGtYYQuArM0h4REtyxiAj+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278510; c=relaxed/simple;
	bh=411jdRd95UVtOVhzhAL/MScr7hrzJJFkCp5F5nacH1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIXPlccJqczarip9ZGVM93TmdZT9ZlnVIwN3/mFuWltIlfdxAnPEmDk3QNnoHcHhH6oVCN/qx0MW3xJg+vRk03J29reF16xosr5ZWavhMgSba24vIplbUWiSTa9fBpanIj+t1kKkunFYSXZb7gBbzq3v42RLrJ72onW+vmrSYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f23f3da48so108394f8f.3
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 04:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278507; x=1718883307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnvzKohC6/VQtG9qzbGO2WJakeWLSmwNV62Agu28J5I=;
        b=BT+0NJipEFm1+vYwEIdQf6csgULMoejzSffTUSphMcHKQZOww8H62y6nTkdirP6WAH
         8D90xL4piTzsAdD8EGTWdcbG7meA4YZV3XfxmZ5+EhbOD68cokKUD3etifRDVx2uqqDt
         uswgvJLcGJHtXza0DkyMpYRFN9o7iSBv1tzUvWt45eC3LmFh4s6U9P1f8LPM7lOQaosZ
         LxxaBOppdRmv1uSLT7xeXeX3+/2RhQ2tGsjv3cMXP71eHG7chQqn4wE211DaHoEbZTLk
         fZeMdhd0UHKjTN1hpfwZKf0nJ08dD70sh7sTYkIEzqCT6IDhIZSGQ6lq/YZm9tnqT+W0
         ecXw==
X-Gm-Message-State: AOJu0YxBmGTBTOraz7s8hDK4N+lIJFQGVjJIgUNiMRf+WxifaRA/87Hw
	sO2OZlMtndaKICE8z8cn01qWhNQlHk4/8JcQPhcIzPflUqYz8/YXeLd2T4AIVT8=
X-Google-Smtp-Source: AGHT+IHz9GIJzAcDnpL24yilGl8f4GB8qgm/37I6cM+//uaJO2WdTQgFnJ0xDQqjP7QQ+Oy1QdEJMw==
X-Received: by 2002:a05:6000:2a6:b0:35f:2929:846e with SMTP id ffacd0b85a97d-360799f4055mr134403f8f.1.1718278506540;
        Thu, 13 Jun 2024 04:35:06 -0700 (PDT)
Received: from vastdata-ubuntu2.vstd.int (46-117-188-129.bb.netvision.net.il. [46.117.188.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c79bsm1486602f8f.41.2024.06.13.04.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:35:06 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] net: micro-optimize skb_datagram_iter
Date: Thu, 13 Jun 2024 14:35:04 +0300
Message-ID: <20240613113504.1079860-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only use the mapping in a single context in a short and contained scope,
so kmap_local_page is sufficient and cheaper. This will also allow
skb_datagram_iter to be called from softirq context.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 net/core/datagram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index a8b625abe242..ac74df248205 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -436,14 +436,14 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 		end = start + skb_frag_size(frag);
 		if ((copy = end - offset) > 0) {
 			struct page *page = skb_frag_page(frag);
-			u8 *vaddr = kmap(page);
+			u8 *vaddr = kmap_local_page(page);
 
 			if (copy > len)
 				copy = len;
 			n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
 					vaddr + skb_frag_off(frag) + offset - start,
 					copy, data, to);
-			kunmap(page);
+			kunmap_local(vaddr);
 			offset += n;
 			if (n != copy)
 				goto short_copy;
-- 
2.43.0


