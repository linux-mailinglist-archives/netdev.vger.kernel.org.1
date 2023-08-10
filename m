Return-Path: <netdev+bounces-26117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C80D776DCA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 03:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD41A1C21435
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 01:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2632AA4D;
	Thu, 10 Aug 2023 01:58:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78A655
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:58:13 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0BE1994
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:58:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5867fe87d16so6410207b3.2
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 18:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691632691; x=1692237491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PF7UhYesGVhoeJAxt80bdAiasdVmkSyS3tHMUDi8SQw=;
        b=pYFgcIsw4RGjSJ6O/WDPYvQAw5gzuBsFuvmi3RCtRNsk292HSz6F6Rq0SBmGzE9+v4
         6x/jBSlOkk/J+Yh3t/KTzU3FjaGbJ1FFnGn4rCiMW1WOCebJU52pQfzMGVgw3dCLCtGh
         ibdISG2VQMfwETS3995hpQNOYOrj6xJozdLmzr81MayqFjb/03ruiIH3Glj9WZwG5EjN
         RQKnQQbvKQVhynHpODxT7SyW85JCXAEYDtyJ8SWBS0iWtFhq7fF90spF53UKp4OsuKxW
         lPcMHahFVO0cPAIAIcp3vK/wY25c3Sh6fLtdc5SiYM3yvZuHjR3wr5RO5McZK+W8FoXx
         NzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691632691; x=1692237491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PF7UhYesGVhoeJAxt80bdAiasdVmkSyS3tHMUDi8SQw=;
        b=XDZE1rLSZ8n72HEZR+pLd9m0DS1jjlVc27iwlpSkyuL1aV0nYUDyTGv4iYpavMh5lk
         TJjREjwk5ejAVr6KxGWXQ06VU96+3DdcBuH50aHUgfhhlIiTPnlDM9lZn9EPsnraOjHS
         mJuoMFNLYNY7j+6DUJ1NkiwT6OGMNG05R35eOiewAVhImTVw1Cn6uMNNf2kZbmSWBA7G
         9cVOevmgIJpjS0DsWfIQH0KHyu20440i5R9e7g6iq+hRjbjNtAN/UcR3SNIbnD+KpT/N
         rgiq9D4YXh0wr7fMwfp3E6wc8bsl7qH5Lf/tW3j54kCqYI/iPMPpiROLnsSurxeXQX6y
         y+7A==
X-Gm-Message-State: AOJu0YwoQRjt0BZAUhGcP/Fg4ZwcazUG5wh/Og/7XNOgPSFOqF5XssBo
	FNZNx1ZQUQupIGhvZ5HXsNuBJTey48WNZePlQ3t9mLSDDDidH4zoQWzvb9Bv5YSIHiBqIJt+YCd
	N8maDpACQC8LUCgIlKAGYKNm5FjfL2DZdnenxpp14FkfpFH3Okdwa9WsT3pu2Ci7cCsYRiUJq/A
	8=
X-Google-Smtp-Source: AGHT+IGkjMr8m1EAO46mSdbpgOuU+k68iX+xxQzg7fLvTju4OvFhxMgZfxumSDV1ACjEoW/UuxWxOjwMGm+YP0pA8A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:73ad:9ed5:e067:2b9b])
 (user=almasrymina job=sendgmr) by 2002:a25:d8c2:0:b0:d43:78e8:f628 with SMTP
 id p185-20020a25d8c2000000b00d4378e8f628mr17793ybg.6.1691632691163; Wed, 09
 Aug 2023 18:58:11 -0700 (PDT)
Date: Wed,  9 Aug 2023 18:57:40 -0700
In-Reply-To: <20230810015751.3297321-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810015751.3297321-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810015751.3297321-5-almasrymina@google.com>
Subject: [RFC PATCH v2 04/11] memory-provider: updates to core provider API
 for devmem TCP
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Hari Ramakrishnan <rharix@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Andy Lutomirski <luto@kernel.org>, stephen@networkplumber.org, sdf@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement a few updates to Jakub's RFC memory provider[1] API to make it
suitable for device memory TCP:

1. Currently for devmem TCP the driver's netdev_rx_queue holds a
reference to the netdev_dmabuf_binding struct and needs to pass that to
the page_pool's memory provider somehow. For PoC purposes, create a
pp->mp_priv field that is set by the driver. Likely needs a better API
(likely dependent on the general memory provider API).

2. The current memory_provider API gives the memory_provider the option
to override put_page(), but tries page_pool_clear_pp_info() after the
memory provider has released the page. IMO if the page freeing is
delegated to the provider then the page_pool should not modify the
page after release_page() has been called.

[1]: https://lore.kernel.org/netdev/20230707183935.997267-1-kuba@kernel.org/

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/page_pool.h | 1 +
 net/core/page_pool.c    | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 13ae7f668c9e..e395f82e182b 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -78,6 +78,7 @@ struct page_pool_params {
 	struct device	*dev; /* device, for DMA pre-mapping purposes */
 	struct napi_struct *napi; /* Sole consumer of pages, otherwise NULL */
 	u8		memory_provider; /* haaacks! should be user-facing */
+	void		*mp_priv; /* argument to pass to the memory provider */
 	enum dma_data_direction dma_dir; /* DMA mapping direction */
 	unsigned int	max_len; /* max DMA sync memory size */
 	unsigned int	offset;  /* DMA addr offset */
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d50f6728e4f6..df3f431fcff3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -241,6 +241,7 @@ static int page_pool_init(struct page_pool *pool,
 		goto free_ptr_ring;
 	}

+	pool->mp_priv = pool->p.mp_priv;
 	if (pool->mp_ops) {
 		err = pool->mp_ops->init(pool);
 		if (err) {
@@ -564,16 +565,16 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
 	else
 		__page_pool_release_page_dma(pool, page);

-	page_pool_clear_pp_info(page);
-
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
 	 */
 	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
 	trace_page_pool_state_release(pool, page, count);

-	if (put)
+	if (put) {
+		page_pool_clear_pp_info(page);
 		put_page(page);
+	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
 	 * __page_cache_release() call).
--
2.41.0.640.ga95def55d0-goog

