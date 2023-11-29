Return-Path: <netdev+bounces-51982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 742C57FCD49
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCBB1F20FCF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E55242;
	Wed, 29 Nov 2023 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqrNH8Vy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F13A19A4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:12:44 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c115026985so6040747b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701227564; x=1701832364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZhQ5pyhSu2aC+i2aVP3kNto/sJoMVZjpeEiZjmVcRs=;
        b=bqrNH8VyQbIIPVbHP3qi26vxtLsyeIBrUqFHEbT7nWg7nkv0hNdg7i4T3uOXwAad5E
         nO+qhxirrnbOBP0UQGG5v/mGST3l830FCQhpWMB2GOkZwWyIJQ/TBdq0B00rjHnOHZvl
         b2BgXYuh7BhKYeB3D1dhlobIMqcYTtDsdDC2Kurw5R40JanM2ue/MGscrDyj67VY6W5V
         7J53mcKyHzGzy3jdkjpTQknJO7cfIHSi4Rs+tBmbUmShz5W9ARmxHMilvsgHQNczQ/vn
         9qQjGxVhEPNxHDOGjVc9ZsYk+YRVxDIlMeu40zIS9D+/sb7Ah4Sxnjy3YouFsDKunMP3
         5j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701227564; x=1701832364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZhQ5pyhSu2aC+i2aVP3kNto/sJoMVZjpeEiZjmVcRs=;
        b=SHW2/XTOtm1FUHLQs/Yh+Eqjh2H81Q2Yeg6jlKiwWT693oUtcOGOFWqKaKw9OsepaN
         hTwx8tp1fmLzXZiJaj8yMOBpopEikmpV5LE4Dn/U4iJhzKKMucGaInmSGRHQX0kXLAgS
         w9xURkOy7mSvWPynoW2Tig3aR2uPtEaCa4m0WU48qTqsBpS85kIO8mwrKlux2R1A7qA0
         boGKcCM056+H51Oen2Av9de19XHxC+qSD5erVMLMpuGzW/vaqpv8Nb6RkjZ3OxI9PHGW
         fZsZ67DG/1JHSR6awWW7rzTp9rWLwZ+Qy1gnP8zIqZ/rRCPaPPS/PSLfYaZaDisphQki
         1SOw==
X-Gm-Message-State: AOJu0YzIFkYiSjgrm6brN9CLS+8IcLL3tZhrnB4wYHL9A4sIm/9NVo/M
	g0V7MMQMMsAsceibOPySzlM=
X-Google-Smtp-Source: AGHT+IFS463sOjjqsuSCXjK5dty4tcKth0NS3/VxeZkBQl0dhRNCDHzq+uwJ7dI9ezaE73E36uGzYA==
X-Received: by 2002:a05:6a20:258f:b0:18c:6559:37f8 with SMTP id k15-20020a056a20258f00b0018c655937f8mr15546782pzd.34.1701227564132;
        Tue, 28 Nov 2023 19:12:44 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001cfc46baa40sm5669287plx.158.2023.11.28.19.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 19:12:43 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Cc: netdev@vger.kernel.org,
	linux-mm@kvack.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v4 3/4] skbuff: Add a function to check if a page belongs to page_pool
Date: Wed, 29 Nov 2023 11:12:00 +0800
Message-Id: <20231129031201.32014-4-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231129031201.32014-1-liangchen.linux@gmail.com>
References: <20231129031201.32014-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap code for checking if a page is a page_pool page into a
function for better readability and ease of reuse.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 net/core/skbuff.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..310207389f51 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -890,6 +890,11 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
+static inline bool skb_frag_is_pp_page(struct page *page)
+{
+	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
+}
+
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 bool napi_pp_put_page(struct page *page, bool napi_safe)
 {
@@ -905,7 +910,7 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
 	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
 	 * to avoid recycling the pfmemalloc page.
 	 */
-	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
+	if (unlikely(!skb_frag_is_pp_page(page)))
 		return false;
 
 	pp = page->pp;
-- 
2.31.1


