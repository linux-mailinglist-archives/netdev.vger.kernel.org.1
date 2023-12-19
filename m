Return-Path: <netdev+bounces-59039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A388191EA
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 22:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19B21F23BF1
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0AC3B29D;
	Tue, 19 Dec 2023 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="r91WcHkF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A03B2BD
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d0a679fca7so2811652b3a.2
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 13:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703019849; x=1703624649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs+cSQCBJyAxSPUcytmGfDGwcvea+TXK48eVoO+ZZxM=;
        b=r91WcHkFUHCQ5SAxBq1DMCCRf01qUer6dm3fGeY4q73QJqhgnLFgUaW2t7VBHRhoPq
         Gclgz5RAJZRAfzQNPk4NKuG7cLsz0B2OK+YXeF7+9jDVRzhztHRIs4MAZp1qvaBMQB2Z
         mSIf8mIfXWJ2/8kCnkDZIywuZFMQKRamlowq/ZW9nU4rkSFNfh/UM2sxMYqjIz3ZgRuJ
         WNPNtYIKRZY+o/48hBHtR2aVcCGdnmXWvSSX5INpCXs7e2Zr4lhh5Pp0Ux1/2ZbmxbDk
         jwk1jbFsDpjLGSGvrNZea3M/hwA5QhXrKsuaiFxd+21Eprag4UMoYBmoyOl0wi5lAVg8
         X+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703019849; x=1703624649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs+cSQCBJyAxSPUcytmGfDGwcvea+TXK48eVoO+ZZxM=;
        b=n8GJEebNhpCox47pMPcbQyVbO08syTiXuWSUnYEEBwPxT8C9xm5ADVb2HFEtZnIFHx
         GaBuNPVdhii3P8EXyBtFSOKkAMn0YNz9QRHRc5c2Z/vR/mC3NKoq4J66fKcoH/UAXV2b
         lcXjhGtEVBt02HUyEuh801M5p6nduzE1wmgzvvbYb7vHpWidwensTRFp1o9e7W23EJ1R
         5k6EJWaEzCjsfRd+CTQgyA4Z+w/cZwAatheQ6SilKDyfmEwQXuZMlddycZrzmktduwou
         MZ19x10C7aUpVg+y9umeiswuRi7k+wY90L6nXEd7APSPhZs4fAorQtxgufmyKZJoZr44
         a9Tw==
X-Gm-Message-State: AOJu0YyLXRFfDHRuzMIvGvKM+bLPQPCg3jcUzgdWwRvz9u5BRtiBGkzZ
	bMOO6dABFZ3nKf1Adhks0wddfOUIAxj6mnW/ibNMOQ==
X-Google-Smtp-Source: AGHT+IHjfDQaUz2sKAkFTiAhNVlx7Yd3lLWWRw8dr6FWMxhyPk+XlzUgXZXfLatLI87/PuyoBdiiAg==
X-Received: by 2002:a05:6a20:3ca3:b0:18b:ec94:deed with SMTP id b35-20020a056a203ca300b0018bec94deedmr9799295pzj.45.1703019849709;
        Tue, 19 Dec 2023 13:04:09 -0800 (PST)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090ab38900b0028b07d1f647sm2076812pjr.23.2023.12.19.13.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 13:04:09 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC PATCH v3 05/20] net: page_pool: add ->scrub mem provider callback
Date: Tue, 19 Dec 2023 13:03:42 -0800
Message-Id: <20231219210357.4029713-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231219210357.4029713-1-dw@davidwei.uk>
References: <20231219210357.4029713-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

page pool is now waiting for all ppiovs to return before destroying
itself, and for that to happen the memory provider might need to push
some buffers, flush caches and so on.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/types.h | 1 +
 net/core/page_pool.c          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index a701310b9811..fd846cac9fb6 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -134,6 +134,7 @@ enum pp_memory_provider_type {
 struct pp_memory_provider_ops {
 	int (*init)(struct page_pool *pool);
 	void (*destroy)(struct page_pool *pool);
+	void (*scrub)(struct page_pool *pool);
 	struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
 	bool (*release_page)(struct page_pool *pool, struct page *page);
 };
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 71af9835638e..9e3073d61a97 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -947,6 +947,8 @@ static int page_pool_release(struct page_pool *pool)
 {
 	int inflight;
 
+	if (pool->mp_ops && pool->mp_ops->scrub)
+		pool->mp_ops->scrub(pool);
 	page_pool_scrub(pool);
 	inflight = page_pool_inflight(pool);
 	if (!inflight)
-- 
2.39.3


