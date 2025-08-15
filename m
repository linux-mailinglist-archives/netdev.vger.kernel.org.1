Return-Path: <netdev+bounces-214024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D73B27E00
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6EBA4E26D3
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1EB2FE577;
	Fri, 15 Aug 2025 10:11:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8252FE075;
	Fri, 15 Aug 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252697; cv=none; b=tsONmVE8+LiFNrWjVgcGXWrxDlTTmgDLmFdkZ8oqhPcONLuWQeO2HhjS73JHfaoIy0hpykyYNJF6ScUlor+gFNtuUnmKXhm5RPPqzgp+bfHJmpXfW+UNh0YOctmC3UzsZ4oJE6iwe3S9F2ElCqgBBx5NQgm8gk9jGrfwFg7u7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252697; c=relaxed/simple;
	bh=RfED2PCOz+YUn4/E3zPIkHvesjtY22YQB1eAiG0o3+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTvVRfGjVUE530MD7/jeOEp2vi/Duk/3HDm3Bd/CJlodZhSKpKLo0Oo4h14F8Bd1OqW+HzezwVibelakmniaEYE+dUc6IS2qlKp4D+fGLZ2wBH7ZTS1HMPnjGeCp+tYxUP36Whv0MYzaQkOnpNMbofnH4YXQs3aashAebBWlwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c3HvQ4zB5zvWxS;
	Fri, 15 Aug 2025 18:11:30 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C453180B54;
	Fri, 15 Aug 2025 18:11:32 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 18:11:31 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 2/2] net: hns3: change the function return type from int to bool
Date: Fri, 15 Aug 2025 18:04:14 +0800
Message-ID: <20250815100414.949752-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250815100414.949752-1-shaojijie@huawei.com>
References: <20250815100414.949752-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

hclge_only_alloc_priv_buff() only return true or false,
So, change the function return type from integer to boolean.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f209a05e2033..f5457ae0b64f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2182,8 +2182,8 @@ static bool hclge_drop_pfc_buf_till_fit(struct hclge_dev *hdev,
 	return hclge_is_rx_buf_ok(hdev, buf_alloc, rx_all);
 }
 
-static int hclge_only_alloc_priv_buff(struct hclge_dev *hdev,
-				      struct hclge_pkt_buf_alloc *buf_alloc)
+static bool hclge_only_alloc_priv_buff(struct hclge_dev *hdev,
+				       struct hclge_pkt_buf_alloc *buf_alloc)
 {
 #define COMPENSATE_BUFFER	0x3C00
 #define COMPENSATE_HALF_MPS_NUM	5
-- 
2.33.0


