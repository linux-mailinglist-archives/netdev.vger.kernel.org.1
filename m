Return-Path: <netdev+bounces-59169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB918199F2
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 09:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E211C22F90
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C1168D5;
	Wed, 20 Dec 2023 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEu/s0jk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6EB1CA93
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a235500d0e1so383743466b.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 00:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703059311; x=1703664111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6qwFojeAseZiqFw0AS/OLjMh8l70gGs83fGIX57eS8=;
        b=vEu/s0jkPZHYqnslqSPpyyE9UgQFXq4gQvQR1QOwZE6hQewzkbHbs7q9d70Rk7vTfj
         7nGSYzjZ6ZVLzBjoupf6FYlW+yAMR9eCvtZkGc+eI5oXRNBEBXSH8hyKZvoDEEMHLsV3
         tUUav1/2J9t5yPsa3cYuG1mQ4ieI95FeijRcCvOPk8HubLDqLfAa/XwyrBgmMquNRB2W
         adHmrhCVMA09mSW4oqSPS5kQTh+VXPrnt7PqM0nQAu0VJ7hxifuIJ/DgWBp6XQvtE3jc
         CRPIlSmZZl/1laCnBlxJlclQGkj/8NkcrSnNjtVYjPKrxaFO8Y8ai9T/dlBjuCvxt1ad
         v3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703059311; x=1703664111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6qwFojeAseZiqFw0AS/OLjMh8l70gGs83fGIX57eS8=;
        b=xJGavIU7QRBlR35Rl6/tikaSYwiO8TmKVy4Q7Fl/nX1ifKUSzkU3yWu+IHtqiO3Yfy
         d6fsjFL7G13CEhaIiQeXywzM+xb+x/8urkjU2LK2Ll0Nc3zL7/nQxlPRfjjdyVY6UcxX
         cGFZjylmbYqjbrf98YrLN7KtjFe1YgTMOJXEeppUmJzkRimh8SrGO4k7Qzqd2oBMmH4Q
         eC0WA474yNmBdDP/XopSj3uQCHQo/wfEFbmoTeruuShnG6oz8bzUtSp9y1WtJl5b7F5t
         +u7fqKR5UrQ7k1YZXF6NRKuGP2tuN6CId58R0U5wP1MnimnuU1TzigNTZ0tBbZyPvRJO
         JFSA==
X-Gm-Message-State: AOJu0YxBZt+4XHj3Nv4lzoELCEM8wB4eUKgkYNS+KeLBIcPRb++W1Yqm
	DyrsbPIWazUey/fzILO5XZZp1qpcfou4FK+6+DI=
X-Google-Smtp-Source: AGHT+IFstkKIv3GmlshOA5zE0O5rfyM7nIKCAkrHm+VvYOOBKDV2Igl0hYuTtcgmlXX/gJ7an6xiyA==
X-Received: by 2002:a17:906:257:b0:a23:48be:3eba with SMTP id 23-20020a170906025700b00a2348be3ebamr2540650ejl.142.1703059311081;
        Wed, 20 Dec 2023 00:01:51 -0800 (PST)
Received: from hades.. (ppp089210121239.access.hol.gr. [89.210.121.239])
        by smtp.gmail.com with ESMTPSA id wq8-20020a170907064800b00a2697aaac78sm223206ejb.30.2023.12.20.00.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:01:50 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: netdev@vger.kernel.org
Cc: linyunsheng@huawei.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] page_pool: Rename frag_users to pagecnt_bias
Date: Wed, 20 Dec 2023 10:01:46 +0200
Message-Id: <20231220080147.740134-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since [0] got merged, it's clear that 'pp_ref_count' is used to track
the number of users for each page. On struct page_pool though we have
a member called 'frag_users'. Despite of what the name suggests this is
not the number of users. It instead represents the number of fragments of
the current page. When we split the page this is set to the actual number
of frags and later used in page_pool_drain_frag() to infer the real number
of users.

So let's rename it to something that matches the description above

[0]
Link: https://lore.kernel.org/netdev/20231212044614.42733-2-liangchen.linux@gmail.com/
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- rename to pagecnt_bias instead of frag_cnt to match the mm subsystem
- rebase on top of -main
 include/net/page_pool/types.h | 2 +-
 net/core/page_pool.c          | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 76481c465375..d47491ba973d 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -130,7 +130,7 @@ struct page_pool {

 	bool has_init_callback;

-	long frag_users;
+	long pagecnt_bias;
 	struct page *frag_page;
 	unsigned int frag_offset;
 	u32 pages_state_hold_cnt;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4933762e5a6b..0e64d6b8e748 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -760,7 +760,7 @@ EXPORT_SYMBOL(page_pool_put_page_bulk);
 static struct page *page_pool_drain_frag(struct page_pool *pool,
 					 struct page *page)
 {
-	long drain_count = BIAS_MAX - pool->frag_users;
+	long drain_count = BIAS_MAX - pool->pagecnt_bias;

 	/* Some user is still using the page frag */
 	if (likely(page_pool_unref_page(page, drain_count)))
@@ -779,7 +779,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,

 static void page_pool_free_frag(struct page_pool *pool)
 {
-	long drain_count = BIAS_MAX - pool->frag_users;
+	long drain_count = BIAS_MAX - pool->pagecnt_bias;
 	struct page *page = pool->frag_page;

 	pool->frag_page = NULL;
@@ -821,14 +821,14 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 		pool->frag_page = page;

 frag_reset:
-		pool->frag_users = 1;
+		pool->pagecnt_bias = 1;
 		*offset = 0;
 		pool->frag_offset = size;
 		page_pool_fragment_page(page, BIAS_MAX);
 		return page;
 	}

-	pool->frag_users++;
+	pool->pagecnt_bias++;
 	pool->frag_offset = *offset + size;
 	alloc_stat_inc(pool, fast);
 	return page;
--
2.37.2


