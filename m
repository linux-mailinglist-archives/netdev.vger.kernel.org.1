Return-Path: <netdev+bounces-135644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE45299EA21
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B199628737D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E52296CE;
	Tue, 15 Oct 2024 12:41:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80C2281DF;
	Tue, 15 Oct 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996110; cv=none; b=J3R5DLUv18J2tgQbmowJOe1f9gEB32AklidWyS1TcwH3I29xpKiuneaa8cFuvNUJA3+jwrbenTLuWqFIOAWMHu0U6k0qg0g65hE2iNhx4zSBQd8Sizt5GXX97fmVLfbRCYSvbgH2MiCiJhGxw7AomsOo2Cl7VTZShl4pPdXpTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996110; c=relaxed/simple;
	bh=ZAaOgVmO3LVGg2S+VqLswSzGdiIeG38JaxHZdu0HdBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dryABu0ODwcenTlbKBw8nvtxyN2FUF0Ro6Nx+MFIsshMDwiJ+PEJjgoqGTiztG3B9ySXrE6jQox3Y02jqhCWJ50sBasejW/W/mz8IyFeet4LjU7iMiJBIhiCwWjwyeEqdPwxJlcrrTcEcTrypnqnLEEhHRp4ZucSbjGtZTO3Fo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XSYbh26nBz1gx27;
	Tue, 15 Oct 2024 20:40:32 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id E0AA31400D2;
	Tue, 15 Oct 2024 20:41:45 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:41:45 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>, <christophe.jaillet@wanadoo.fr>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V12 RESEND net-next 10/10] net: hibmcge: Add maintainer for hibmcge
Date: Tue, 15 Oct 2024 20:35:16 +0800
Message-ID: <20241015123516.4035035-11-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241015123516.4035035-1-shaojijie@huawei.com>
References: <20241015123516.4035035-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Add myself as the maintainer for the hibmcge ethernet driver.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v11 -> v12:
  - remove the W entry of hibmcge driver from MAINTAINERS, suggested by Jakub.
  v11: https://lore.kernel.org/all/20241008022358.863393-1-shaojijie@huawei.com/
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 560a65b85297..b5242fdb564d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10278,6 +10278,12 @@ S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/net/ethernet/hisilicon/hns3/
 
+HISILICON NETWORK HIBMCGE DRIVER
+M:	Jijie Shao <shaojijie@huawei.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/hisilicon/hibmcge/
+
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Jian Shen <shenjian15@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
-- 
2.33.0


