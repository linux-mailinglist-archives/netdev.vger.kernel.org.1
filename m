Return-Path: <netdev+bounces-118072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59B295071C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643EE1F23F92
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A99A19306B;
	Tue, 13 Aug 2024 14:02:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A019DF87;
	Tue, 13 Aug 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557768; cv=none; b=W3pz6w/JPi8MMlLQ3Nkbv+4rhzw0pA9wh62tY8CJWp90y6S8OWIT9vtcruSvs5MjoIfS2BvweY0sXvbCheluT5ft0Ys3FFSfnI1td0pzyCnnM9dDwfNuHCxlRq5T2QnqNUUS9WVEY9h3O8n9YHmVaNPZNiXcN3sypZEimL1kYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557768; c=relaxed/simple;
	bh=FUNzXNrbapU3n6e0WZbt99HmwGqTa790/oN7vqUdLBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rA5CGP062A6tugpayqXPl1oFA4qBIyCwUkzYJvC2bZ7H+AHwBft32Vm2ceLs3ckK/9XAb427Jp6Etmc+6RcIZnRpZS1vk7Cep47HW4WIHUAX/bm3IgFSTh3Sb+z0cE6RaC2g2GUjKprvXPdMkr2NDtqyVWIbNibHBalv8fETHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WjtP11RxYzyPpf;
	Tue, 13 Aug 2024 22:02:13 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 16DE01400FD;
	Tue, 13 Aug 2024 22:02:42 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 22:02:41 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <andrew@lunn.ch>,
	<jdamato@fastly.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH V2 net-next 10/11] net: hibmcge: Add maintainer for hibmcge
Date: Tue, 13 Aug 2024 21:56:39 +0800
Message-ID: <20240813135640.1694993-11-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240813135640.1694993-1-shaojijie@huawei.com>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Add myself as the maintainer for the hibmcge ethernet driver.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b291c3a9aa4..d53608f348e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10123,6 +10123,13 @@ S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/net/ethernet/hisilicon/hns3/
 
+HISILICON NETWORK HIBMCGE DRIVER
+M:	Jijie Shao <shaojijie@huawei.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+W:	http://www.hisilicon.com
+F:	drivers/net/ethernet/hisilicon/hibmcge/
+
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
-- 
2.33.0


