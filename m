Return-Path: <netdev+bounces-115488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD857946977
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D601C20B46
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2789514C5A1;
	Sat,  3 Aug 2024 11:24:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FA4A2F;
	Sat,  3 Aug 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722684265; cv=none; b=OzfbRW6B/gcThSgVEZImhsZQNfKEn6y/UwubGFih32pX+nwO6ZKnabqhlHuhqFeLXFHz/nwOx/rN1geWQPhtkYn6m/9c8jXrcfYviIN61R0fDZwyykNnEtyg7V3f1MxtNfi5cceKUQ0ux00T8fSRiPkgj4UINr73yO8ElT8y7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722684265; c=relaxed/simple;
	bh=QOq6wHXEkhUZJb1Apls6Ho2udiLfWrwewUlY5suZM1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JhQDnVlTqvalnnFMCAaiO4EUpJ5vk+SXkzUB7c4YVEpwkaCH76lnAO6Jdmx7nJwZ1i4ZyiwHMy6lA2xm7dGPVaD6OnZLsknVeZkGxRrvUrD9xyWAhSreflWWZUffgkdz1XHpiUQZRqRYIAE0LhAMafTiM3TqNTi9XijDBs/+tRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WbgM61R9wz1L9fc;
	Sat,  3 Aug 2024 19:24:02 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AC8D1800D0;
	Sat,  3 Aug 2024 19:24:17 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 3 Aug
 2024 19:24:16 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <danieller@nvidia.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] ethtool: cmis_cdb: Remove unused declaration ethtool_cmis_page_fini()
Date: Sat, 3 Aug 2024 19:22:13 +0800
Message-ID: <20240803112213.4044015-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

ethtool_cmis_page_fini() is declared but never implemented.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ethtool/cmis.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index e71cc3e1b7eb..3e7c293af78c 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -108,7 +108,6 @@ void ethtool_cmis_cdb_check_completion_flag(u8 cmis_rev, u8 *flags);
 
 void ethtool_cmis_page_init(struct ethtool_module_eeprom *page_data,
 			    u8 page, u32 offset, u32 length);
-void ethtool_cmis_page_fini(struct ethtool_module_eeprom *page_data);
 
 struct ethtool_cmis_cdb *
 ethtool_cmis_cdb_init(struct net_device *dev,
-- 
2.34.1


