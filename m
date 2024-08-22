Return-Path: <netdev+bounces-120879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39995B1F3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825CE1C22F0E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990B185B6C;
	Thu, 22 Aug 2024 09:39:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427018453F;
	Thu, 22 Aug 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319584; cv=none; b=iHp1ruHgcmrFL1hsgJ0otauvepdMrwTX07i3646xosieAYPk6PuRMLI6CIZOrpqOuY5pO4SEqOxFqnuUNHFld9HIoxDor2Pn4kJQPC3M0di8/UGRt1p3QsL3bPhXOXTcnx8jsv5oTALeGTB0ktJnc/qrglIrCV+8uYyQqv67YkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319584; c=relaxed/simple;
	bh=ATVyEJlwbZPimhIz3q6w8QdVcn/4THkYOQtwFB5X738=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOMyURxyfGc+HF+TM4rom/swFkwboWIZ+5BQFzaCMtMNLxehnJyQfB2bR5MTp+QtoAWO82YToppOBNz4OmIM6lqh66s4bvF7SV554pwCNzjd9rkO4FyeIKlxz+wqwdQ4burpo1IaaC3weoDiwAd5H+OCayE5fY6ae0XZlwyAL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WqJ774WRSz13pJk;
	Thu, 22 Aug 2024 17:38:59 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id CF1B214037B;
	Thu, 22 Aug 2024 17:39:39 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 17:39:38 +0800
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
Subject: [PATCH V3 net-next 10/11] net: hibmcge: Add maintainer for hibmcge
Date: Thu, 22 Aug 2024 17:33:33 +0800
Message-ID: <20240822093334.1687011-11-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240822093334.1687011-1-shaojijie@huawei.com>
References: <20240822093334.1687011-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


