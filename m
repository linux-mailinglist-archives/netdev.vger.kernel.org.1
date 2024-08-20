Return-Path: <netdev+bounces-120204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418C19588A9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08E01F23C9D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2319538A;
	Tue, 20 Aug 2024 14:08:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB3193088;
	Tue, 20 Aug 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162920; cv=none; b=YuDhE2eoQBiZinpLMqnXONgAIVVeSGEJgDUWRUSdFky5/U7VIXL6sFs8GOCEievtsl6EVjemGIUTpRyhH1TjrCHomlhdsfYSBQn8w9Tan+gAgB2ynC5Nxp3/3ODP2zrA+RgRbVI7GrA4ok8vNgkaGDjEInFimTeKXeK0eUlGIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162920; c=relaxed/simple;
	bh=ATVyEJlwbZPimhIz3q6w8QdVcn/4THkYOQtwFB5X738=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KN2roih/fr3rsk0m08B3lvs/XxitP5WNX/AdUjhAAoJ5kEajm6cB/GmJNTeEaiaayK6+Kdsw88idFP6a2P0y+AhQKRcjlD1hLy6l1eXBe5CoF5EmYMTPLslfeH3hFryWElfKROHGdcd0sqxD39ued0CPqMYZ1oNda0FZ9WQ2Z+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WpBC52Nwjz1S8Lf;
	Tue, 20 Aug 2024 22:08:33 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C8831401F4;
	Tue, 20 Aug 2024 22:08:35 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 22:08:34 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net-next 10/11] net: hibmcge: Add maintainer for hibmcge
Date: Tue, 20 Aug 2024 22:01:53 +0800
Message-ID: <20240820140154.137876-11-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240820140154.137876-1-shaojijie@huawei.com>
References: <20240820140154.137876-1-shaojijie@huawei.com>
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
index 5dbf23cf11c8..2691a08e16db 100644
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


