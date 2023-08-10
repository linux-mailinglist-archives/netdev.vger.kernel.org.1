Return-Path: <netdev+bounces-26116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE2776DC8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 03:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F2D1C21423
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 01:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF4A64B;
	Thu, 10 Aug 2023 01:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335DA4D
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:58:10 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED11982
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:58:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57320c10635so6289537b3.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691632688; x=1692237488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=02sZ2KF4/kqkk3itVZ075jQ951/44aLMfRaJz3dWZO4=;
        b=6mH2Ew/JcDBG5I+lwTS2EpGNdA9p2OpK3REUFQmgG/geEfGAlApwafQm+F8Gjno4YC
         vCDpAjVQe/ngWT9ZjuvRnO154w6wMjfn1TMqYO6+aMkf3aUUNdMJ68kQBo2qQ919+N+6
         lKxnUZJbXsq2kguUx1ebg3wjqtsA5OXafhjUWBT09q2+GKzL/W7LndWwN5JGkvJDAsIU
         f37R5BVREmn+7hqWsqzA49Zg1HbjS5FUv9sr3KyQvLdN0VbcJv5ntYIw6TECU5sCQfjR
         5iZE0rdJFNV4kBD7r9HDwuh2iYmq6tOP0IggmUN31yMTUrjT1B3pj+8C4fHWrpOgLVl5
         IaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691632688; x=1692237488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02sZ2KF4/kqkk3itVZ075jQ951/44aLMfRaJz3dWZO4=;
        b=SzUYWkq+JWN11fYwJmyTIU+gGe0ucpbb4yozRdSCUkQ8Cis1OFYw1QwP2RHeXMyDEx
         kig5qnOmVxDd1UPhasHbtaEUyF35Ko3iOviZKDC/8Dj+dxvEZboAi7zyZx+Y3FZGfVNJ
         hKAMSXiE0lQhWq7uuTnbCsvce8jT6NbHnyWtNm6iq6sPlgvvxd1H13THZH6v4NSEYmZl
         vukZ3uUitF5WkCOQW9GF6tft0rRKB01FSgZticPxdZ4vUB0Aqcks6fnrb0Ex8ORRHpmz
         OlD9wwbx+1vPoLvUfMwe3oc7s+JaBKg2DPq/T3zhBo3i0l+33HwdOR2lrhlJrYuiE9sW
         VK+A==
X-Gm-Message-State: AOJu0YytNGnOZPWRVrhlGnIiqUrZMRCfRClwvusoVe6wErd+MBlE5y7G
	5TI2sjH862pik+xPgeD9tJw0rYunXFdKDZXbrtN9KZYmT0M+ZiHXOszJgKyqULERuWdtQ7TAHZS
	rchUD//xF8B2w2/vIPOgqYZo3nueD8twUr0VdYMe/m+Nv7wC9M2c9fg8qLUNRViH5HPYRPO0Mf2
	U=
X-Google-Smtp-Source: AGHT+IGCapGPNtCMW44RrnrHw/oUHA4QZiHHbnSEAibZ2bVU1IyKSIRjwoib/ZnyU3K9b3mMe5ZiIByGi0TbafufWQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:73ad:9ed5:e067:2b9b])
 (user=almasrymina job=sendgmr) by 2002:a25:778b:0:b0:d09:17f2:d3b0 with SMTP
 id s133-20020a25778b000000b00d0917f2d3b0mr16984ybc.9.1691632688161; Wed, 09
 Aug 2023 18:58:08 -0700 (PDT)
Date: Wed,  9 Aug 2023 18:57:39 -0700
In-Reply-To: <20230810015751.3297321-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810015751.3297321-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810015751.3297321-4-almasrymina@google.com>
Subject: [RFC PATCH v2 03/11] netdev: implement netdevice devmem allocator
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
	Andy Lutomirski <luto@kernel.org>, stephen@networkplumber.org, sdf@google.com, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement netdev devmem allocator. The allocator takes a given struct
netdev_dmabuf_binding as input and allocates page_pool_iov from that
binding.

The allocation simply delegates to the binding's genpool for the
allocation logic and wraps the returned memory region in a page_pool_iov
struct.

page_pool_iov are refcounted and are freed back to the binding when the
refcount drops to 0.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/netdevice.h |  4 ++++
 include/net/page_pool.h   | 26 ++++++++++++++++++++++++++
 net/core/dev.c            | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1b7c5966d2ca..bb5296e6cb00 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5078,6 +5078,10 @@ void netif_set_tso_max_segs(struct net_device *dev, unsigned int segs);
 void netif_inherit_tso_max(struct net_device *to,
 			   const struct net_device *from);

+struct page_pool_iov *
+netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
+void netdev_free_devmem(struct page_pool_iov *ppiov);
+
 void netdev_unbind_dmabuf_to_queue(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf_to_queue(struct net_device *dev, unsigned int dmabuf_fd,
 				u32 rxq_idx,
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 61b2066d32b5..13ae7f668c9e 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -197,6 +197,32 @@ struct page_pool_iov {
 	refcount_t refcount;
 };

+static inline struct dmabuf_genpool_chunk_owner *
+page_pool_iov_owner(const struct page_pool_iov *ppiov)
+{
+	return ppiov->owner;
+}
+
+static inline unsigned int page_pool_iov_idx(const struct page_pool_iov *ppiov)
+{
+	return ppiov - page_pool_iov_owner(ppiov)->ppiovs;
+}
+
+static inline dma_addr_t
+page_pool_iov_dma_addr(const struct page_pool_iov *ppiov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = page_pool_iov_owner(ppiov);
+
+	return owner->base_dma_addr +
+	       ((dma_addr_t)page_pool_iov_idx(ppiov) << PAGE_SHIFT);
+}
+
+static inline struct netdev_dmabuf_binding *
+page_pool_iov_binding(const struct page_pool_iov *ppiov)
+{
+	return page_pool_iov_owner(ppiov)->binding;
+}
+
 struct page_pool {
 	struct page_pool_params p;

diff --git a/net/core/dev.c b/net/core/dev.c
index 02a25ccf771a..0149335a25b7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2072,6 +2072,42 @@ void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *binding)
 	kfree(binding);
 }

+struct page_pool_iov *netdev_alloc_devmem(struct netdev_dmabuf_binding *binding)
+{
+	struct dmabuf_genpool_chunk_owner *owner;
+	struct page_pool_iov *ppiov;
+	unsigned long dma_addr;
+	ssize_t offset;
+	ssize_t index;
+
+	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
+					(void **)&owner);
+	if (!dma_addr)
+		return NULL;
+
+	offset = dma_addr - owner->base_dma_addr;
+	index = offset / PAGE_SIZE;
+	ppiov = &owner->ppiovs[index];
+
+	netdev_devmem_binding_get(binding);
+
+	return ppiov;
+}
+
+void netdev_free_devmem(struct page_pool_iov *ppiov)
+{
+	struct netdev_dmabuf_binding *binding = page_pool_iov_binding(ppiov);
+
+	refcount_set(&ppiov->refcount, 1);
+
+	if (gen_pool_has_addr(binding->chunk_pool,
+			      page_pool_iov_dma_addr(ppiov), PAGE_SIZE))
+		gen_pool_free(binding->chunk_pool,
+			      page_pool_iov_dma_addr(ppiov), PAGE_SIZE);
+
+	netdev_devmem_binding_put(binding);
+}
+
 void netdev_unbind_dmabuf_to_queue(struct netdev_dmabuf_binding *binding)
 {
 	struct netdev_rx_queue *rxq;
--
2.41.0.640.ga95def55d0-goog

