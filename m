Return-Path: <netdev+bounces-119581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A566B956452
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31ED2B22363
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D5015B12C;
	Mon, 19 Aug 2024 07:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6260158DBF;
	Mon, 19 Aug 2024 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051990; cv=none; b=VOCGly2GVLKaP6arLi3piA3c/88a2LreF7Wd1JVZfAjoiXSNiK2LwRf3De1KTxFpWVjH4wCHKj6zmRtT5Nc2DI2eUvGF2w2R92BviuSpeu+jYcvL6NoQAihVkW7ov+ehPLuri+S9B8aHGeFPCU0kfMhNR4T6wdTeRpedDQ2ahYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051990; c=relaxed/simple;
	bh=FUNzXNrbapU3n6e0WZbt99HmwGqTa790/oN7vqUdLBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQ1prwpHpmvEOFC0V1OMjcFYU6/Gsr36EzCLjjPuXiDqe2yWq+RgTxKt3QLSSINfgLQmYyk52AsIrTRVStCWdMGNfU4SlCGOLDpCEVsqwwlf23NOAAhoFeMrItXX95Qn1Uk3gb8ASLv1ZMvxR8Mg0P4Kq0UopTASPrw02dWElZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WnP990Qx6zyQBs;
	Mon, 19 Aug 2024 15:19:09 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 7603F1400CD;
	Mon, 19 Aug 2024 15:19:45 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 15:19:44 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 10/11] net: hibmcge: Add maintainer for hibmcge
Date: Mon, 19 Aug 2024 15:12:28 +0800
Message-ID: <20240819071229.2489506-11-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240819071229.2489506-1-shaojijie@huawei.com>
References: <20240819071229.2489506-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


