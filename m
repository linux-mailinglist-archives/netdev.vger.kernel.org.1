Return-Path: <netdev+bounces-201029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A445AE7E71
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4BF16C7FC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87832285C80;
	Wed, 25 Jun 2025 10:04:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F81F460B;
	Wed, 25 Jun 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845881; cv=none; b=sjhBT6nW4s16Vbs+RA/Fy6K8lJxm/6hSR3LmeJRj9kiVxXxjZG1jgbWlWHd0Ww+7hgMQssKkIYX3g3VPgmbZKSW4g/aQTrgf2SXR/dZ5iu3Tx2Dk5VGkepEN4XL+HP2DiZP8yJS/LdcZetoKTVgR9/sUPafM7zV9GC6VYa60/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845881; c=relaxed/simple;
	bh=GvIaJF5+J/InRTOZVzTLzmt/zTQ4aOIgzf23NRiEfPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y8ZhxOybLJzK7432FILUhhehTeRYBfrtvbD+4kYnsTUm14TYQZrf82kYxApxoXpjrkF1Fqd6DCDrtjn3JYqHwgCF6WPp1ySNbFiglL7G8VP6bpADJP9NtrLsriVbgK0lIPu5Q1iONQmP06VGqy7y+rosLk7VHqOqJ3rAWQOhoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bRyB25xydz2QTxx;
	Wed, 25 Jun 2025 18:05:30 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A9B4E1A016C;
	Wed, 25 Jun 2025 18:04:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Jun
 2025 18:04:34 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] net: Remove unused function first_net_device_rcu()
Date: Wed, 25 Jun 2025 18:21:55 +0800
Message-ID: <20250625102155.483570-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

This is unused since commit f04565ddf52e ("dev: use name hash for
dev_seq_ops")

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/netdevice.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 03c26bb0fbbe..431d5ca10905 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3316,13 +3316,6 @@ static inline struct net_device *first_net_device(struct net *net)
 		net_device_entry(net->dev_base_head.next);
 }
 
-static inline struct net_device *first_net_device_rcu(struct net *net)
-{
-	struct list_head *lh = rcu_dereference(list_next_rcu(&net->dev_base_head));
-
-	return lh == &net->dev_base_head ? NULL : net_device_entry(lh);
-}
-
 int netdev_boot_setup_check(struct net_device *dev);
 struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
 				   const char *hwaddr);
-- 
2.34.1


