Return-Path: <netdev+bounces-94415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF8B8BF661
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B172821D1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183EC23746;
	Wed,  8 May 2024 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x9VQ9QBj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0091EB3F
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150256; cv=none; b=aK90v+IuXH3csr3hU7+C4kTIexs0cq9loKnUJewtszF3MYdwRZ+wHkxTpui/x+NhTglCK84zbESeopk12c15951fk30h1VMcTEe4BqAz8bPdeD9I2GQlAOBTcvt6WFmsMrC9DKKVNqDLpeMghMx0LhbRbkrO4N7g6RrKyq6TW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150256; c=relaxed/simple;
	bh=hcwYkt96xwHkA7ahkN8VHJK+7gLlmBNZ4M8oYBXSh2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CdBgLLPdKxAnPMkNYfozIk8PzV/LfmpsOcS0S/inhBE8kxl6jQaEP3fOH3cB26o/AcNKzasEKJYx3GmWp0MfbEjTC5FSt/in4SrwoxFjRXndSCCuVOCND14maB/wcIMtJ4+MXzNNxTI2YYUF014OBf7VbeQUpRAo5j3dwNUyi+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x9VQ9QBj; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715150245; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6bPNehLJ+wlPYqvVl2prLGx5zEg+cgzpA4yB2IiN51c=;
	b=x9VQ9QBj45+Yc4oJIdBoVe5OQjiyq8CjuJ+YUyoti1+Celd64lte+jo6XSwWeFFhmIzkRR6EN8ACOVMVhBqQhvwfeIg/CQXU5nTVvPtWnn62+RxU8uOAvkNoFv9sV6iggpbMfQifQGnvATAZ+1fo/6P+AdtJ2U96CgiLcbzPQJ0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W62X2px_1715150243;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62X2px_1715150243)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 14:37:24 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next v4 4/4] virtio_net: remove the misleading comment
Date: Wed,  8 May 2024 14:37:18 +0800
Message-Id: <20240508063718.69806-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
References: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: cadd21343bbc
Content-Transfer-Encoding: 8bit

We call the build_skb() actually without copying data.
The comment is misleading. So remove it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 070a6ed0d812..7c2b2b02338b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -739,7 +739,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	/* copy small packet so we can reuse these pages */
 	if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
 		skb = virtnet_build_skb(buf, truesize, p - buf, len);
 		if (unlikely(!skb))
-- 
2.32.0.3.g01195cf9f


