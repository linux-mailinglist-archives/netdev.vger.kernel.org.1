Return-Path: <netdev+bounces-37226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E47B44D1
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 02:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D5FE8B2098A
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C82385;
	Sun,  1 Oct 2023 00:38:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5737F
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 00:38:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34760D3;
	Sat, 30 Sep 2023 17:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MgPUZu5lJ2mnvysZdGu2Kc1b7RZofo72Va4okUfyrCQ=; b=Ob5YNP+BeMVGp1+WORUo6wyT3r
	nXWuhetfvuluA+OOZ6++X9e1KBQVYrek64A1gAO8ppWpcGI7dDukk2oA59ATyRxvtlpkq76QdMpT6
	y6CxcSGnp0duFCVe+k8aHrF5Hz4lV1YV1ECG0IS4w6sR0V1p4sL1x0ka98W2Qy4r2O4zAxg+rN7ix
	G6xTRXVnOgwu06JxyMQBbzPce0kWEei6MdcS7zTjmUOPNDcpLAG+TFPsRoO/7p5nLtsdt0Ufwc/Iv
	/uOqu5Ea0FfKG8iQv6mfFXf0rGLVYp0+IOWrsff7SAKDITOZpAJrEAHbx4SSD004YzR5GegLwvTcB
	0jYTmRFg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qmkTv-00AI3H-0l;
	Sun, 01 Oct 2023 00:38:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] page_pool: fix documentation typos
Date: Sat, 30 Sep 2023 17:38:45 -0700
Message-ID: <20231001003846.29541-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Correct grammar for better readability.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/net/page_pool/helpers.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -16,13 +16,13 @@
  * page_pool_alloc_pages() call.  Drivers should use
  * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
  *
- * API keeps track of in-flight pages, in order to let API user know
+ * The API keeps track of in-flight pages, in order to let API users know
  * when it is safe to free a page_pool object.  Thus, API users
  * must call page_pool_put_page() to free the page, or attach
- * the page to a page_pool-aware objects like skbs marked with
+ * the page to a page_pool-aware object like skbs marked with
  * skb_mark_for_recycle().
  *
- * API user must call page_pool_put_page() once on a page, as it
+ * API users must call page_pool_put_page() once on a page, as it
  * will either recycle the page, or in case of refcnt > 1, it will
  * release the DMA mapping and in-flight state accounting.
  */

