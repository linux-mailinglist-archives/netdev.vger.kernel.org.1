Return-Path: <netdev+bounces-200127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9778AAE3435
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A0D7A4747
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4421E411C;
	Mon, 23 Jun 2025 04:07:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893131DE4DB;
	Mon, 23 Jun 2025 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651666; cv=none; b=ie7seR0wqqdJk2vmCqiDAqbG8uFzXKYG+jgWvwhLG+c5LZAkkUVSYUzaUfdnxqdcMYQVPdI1UNAKY9DBivJERk4tdt/ClX2+RS6XMw3h0ojB48HfLtj80Wles959MOFCxZRwfHlhoDyutp1J361BtNkrfblKPF1iOjlyYfVaJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651666; c=relaxed/simple;
	bh=i7rcD1P8laXbZBfNdu4DupjBlFmEKluMaA6OTeWwlqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbWbQ4SaNyEoLHvJoCVEZaq2tMtddqDGyj55NaDYjyx0k+CYrIegV0+FKpIIEe2/1FE8eymmsm7gHGvJ6jHV7RuJnp6z+Kwjn8O2W2hW7sUtVdsGHk75sJajM2CvZ3zm2FRvs/Mffj0MFSTZSlmUuhfBNPG/Pi7yOJvPnBV7NZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bQZJC04Ptz2TSm7;
	Mon, 23 Jun 2025 12:06:03 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E4DC1401F2;
	Mon, 23 Jun 2025 12:07:37 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 12:07:36 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net-next 6/7] net: hns3: add complete parentheses for some macros
Date: Mon, 23 Jun 2025 12:00:42 +0800
Message-ID: <20250623040043.857782-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250623040043.857782-1-shaojijie@huawei.com>
References: <20250623040043.857782-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Add complete parentheses for some macros to fix static check
warning.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index d36c4ed16d8d..dd61ddd8f904 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -692,7 +692,7 @@ static inline unsigned int hns3_page_order(struct hns3_enet_ring *ring)
 
 /* iterator for handling rings in ring group */
 #define hns3_for_each_ring(pos, head) \
-	for (pos = (head).ring; (pos); pos = (pos)->next)
+	for ((pos) = (head).ring; (pos); (pos) = (pos)->next)
 
 #define hns3_get_handle(ndev) \
 	(((struct hns3_nic_priv *)netdev_priv(ndev))->ae_handle)
-- 
2.33.0


