Return-Path: <netdev+bounces-46123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A59F7E18AB
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 03:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC4A1C208ED
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 02:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7B465A;
	Mon,  6 Nov 2023 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1QJZBxI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADED659
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 02:44:23 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA83123
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 18:44:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ae5b12227fso56467517b3.0
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 18:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238661; x=1699843461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYi74RniIHsB6Wn3ca/EzKecGeVK7nuy82fMJ6xIaLE=;
        b=W1QJZBxIoM0Z1SYq24KLDVp81Ac2rNgFfLg8DriWh3Uj3T2wyeCkVx/TIfj5xcPJhI
         kZI5ACxzQT5koFb6qnqAFc04SrCdUheWZkTTo5S5z4psHbVzP46syGiux40yZfZsjvOu
         yblrD4OIUmcIbM8o+mWhfVbWFvnBXVJLBhE5nrsKmaVzyfKvRh0Nv3JWNpcINe8ItvTC
         N5jVhf2SEo9c/NZsiadgrrtxu2uHFgUpKJs/kCqn20NoUql+cLv3Vr0hobYcrY/hzNlD
         7MAnFL7IILAPQDtyhKOx81dSOBs4BXApVEsF6ieQS2RUZ1EhUZRzd4DXTj+sf8QP9iV5
         Xy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238661; x=1699843461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYi74RniIHsB6Wn3ca/EzKecGeVK7nuy82fMJ6xIaLE=;
        b=Xi7nKbIJErIIWknz2XWbm7ZLAEWb7F0BHDlUjvKIjT7CADUvJn4w8dozAiLEIKk9cd
         3EuAmrsSifNg15kRB4r/54bSoCoRJnbsmeg75s36W+boauiA/vo1f1P9ZJH6c/BE48bJ
         zKix8xOzxb6tF0ZjC23HnLM2ZsakXJC3sUizpnIkJJEP+UhU3W5XyvQvPsXk3LgA0zp6
         wbZl9O5Q7TX9Ic03PZbD9paoB5j8kLSI/FgiPzLrlLbcce67x7MkBVJxKAZ5eZfl/ofv
         kI9FrW7QMFFTdC3qNLggUndKUZNlJNcRmSy5xueDYY/doWA84KL6G3CDl7SmO7nxEEze
         +Ryw==
X-Gm-Message-State: AOJu0Yyccq4cTN1sPUpzL78DEWFQhED8IYOO/DZY9zrJHPbQG0Tooh5z
	d94VCJ3t8UZPbB8DN0TI9aoutXH9CESCZGSpcdtvGw4H70g30TSNzeWX5Q9SSwQsT2XBQwW1REQ
	gIXdHhf3gqntZuLS2E76EHEuU+0vk4NbYDRtj/J1y4yONqIhRRAyq11TYTvVdawfvucoFYE7yWv
	w=
X-Google-Smtp-Source: AGHT+IE9YqB9SYLUxgQ5eT9abp+8TWDhj3Fso2Go2CEiYjAa/XP+wuQiIsvJrogX9aN67VSXhqeSBYMoIbWBDLOY2A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:ac04:0:b0:d9a:520f:1988 with SMTP
 id w4-20020a25ac04000000b00d9a520f1988mr525338ybi.4.1699238660358; Sun, 05
 Nov 2023 18:44:20 -0800 (PST)
Date: Sun,  5 Nov 2023 18:44:00 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-2-almasrymina@google.com>
Subject: [RFC PATCH v3 01/12] net: page_pool: factor out releasing DMA from
 releasing the page
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jakub Kicinski <kuba@kernel.org>

Releasing the DMA mapping will be useful for other types
of pages, so factor it out. Make sure compiler inlines it,
to avoid any regressions.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

This is implemented by Jakub in his RFC:

https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com/T/

I take no credit for the idea or implementation. This is a critical
dependency of device memory TCP and thus I'm pulling it into this series
to make it revewable and mergable.

---
 net/core/page_pool.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 5e409b98aba0..578b6f2eeb46 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -514,21 +514,16 @@ static s32 page_pool_inflight(struct page_pool *pool)
 	return inflight;
 }
 
-/* Disconnects a page (from a page_pool).  API users can have a need
- * to disconnect a page (from a page_pool), to allow it to be used as
- * a regular page (that will eventually be returned to the normal
- * page-allocator via put_page).
- */
-static void page_pool_return_page(struct page_pool *pool, struct page *page)
+static __always_inline
+void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
 {
 	dma_addr_t dma;
-	int count;
 
 	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
 		/* Always account for inflight pages, even if we didn't
 		 * map them
 		 */
-		goto skip_dma_unmap;
+		return;
 
 	dma = page_pool_get_dma_addr(page);
 
@@ -537,7 +532,19 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr(page, 0);
-skip_dma_unmap:
+}
+
+/* Disconnects a page (from a page_pool).  API users can have a need
+ * to disconnect a page (from a page_pool), to allow it to be used as
+ * a regular page (that will eventually be returned to the normal
+ * page-allocator via put_page).
+ */
+void page_pool_return_page(struct page_pool *pool, struct page *page)
+{
+	int count;
+
+	__page_pool_release_page_dma(pool, page);
+
 	page_pool_clear_pp_info(page);
 
 	/* This may be the last page returned, releasing the pool, so
-- 
2.42.0.869.gea05f2083d-goog


