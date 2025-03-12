Return-Path: <netdev+bounces-174083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5896CA5D603
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 07:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF7416A875
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 06:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1A1E377F;
	Wed, 12 Mar 2025 06:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5931D86F2;
	Wed, 12 Mar 2025 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760636; cv=none; b=gXdDH4YCYnM8hNy8p2udqI+PNsI+Rb9QzmeszatBOf41ue/PJAu14ErpxPo9KFvINlY9+Kx8dbdygkaShuouKaJs3ok7qpxlOES2l6uU9S35p9FZ+F6dQZANCEzFxYkREyvL5sPQ3jx7c8Wj6BnaD7yLMQtMQxy7PIOO/06DrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760636; c=relaxed/simple;
	bh=mml8n8fGPf3faaPFSXbVSSAyj/LWLLVVRLIZLQHPhjg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LdwO0KH6OTqHqZxi2OvX9eBOAKT2QBBRk1WG/v9WOIKnJ7QOoo71xD0kKDDaYX3z0MyFgchQDa7OjbuYlLDdmAaOSw/vwWMaDcQXRZrWgN0qD1SaGkMwc18rEj0lfJ5m47tBmFbeYgeNjTZQZUzfalVUfJQh18xtauoQRid+wG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZCLBt45w7zqVTs;
	Wed, 12 Mar 2025 14:22:14 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D7B781402C1;
	Wed, 12 Mar 2025 14:23:43 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Mar
 2025 14:23:43 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] net: skbuff: Remove unused skb_add_data()
Date: Wed, 12 Mar 2025 14:34:50 +0800
Message-ID: <20250312063450.183652-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Since commit a4ea4c477619 ("rxrpc: Don't use a ring buffer for call Tx
queue") this function is not used anymore.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/skbuff.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 14517e95a46c..bbc3b656c856 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3865,25 +3865,6 @@ static inline int __must_check skb_put_padto(struct sk_buff *skb, unsigned int l
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i)
 	__must_check;
 
-static inline int skb_add_data(struct sk_buff *skb,
-			       struct iov_iter *from, int copy)
-{
-	const int off = skb->len;
-
-	if (skb->ip_summed == CHECKSUM_NONE) {
-		__wsum csum = 0;
-		if (csum_and_copy_from_iter_full(skb_put(skb, copy), copy,
-					         &csum, from)) {
-			skb->csum = csum_block_add(skb->csum, csum, off);
-			return 0;
-		}
-	} else if (copy_from_iter_full(skb_put(skb, copy), copy, from))
-		return 0;
-
-	__skb_trim(skb, off);
-	return -EFAULT;
-}
-
 static inline bool skb_can_coalesce(struct sk_buff *skb, int i,
 				    const struct page *page, int off)
 {
-- 
2.34.1


