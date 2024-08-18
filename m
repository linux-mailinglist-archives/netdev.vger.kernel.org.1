Return-Path: <netdev+bounces-119451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5445955B0A
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 07:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D7E281A35
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 05:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034B947A;
	Sun, 18 Aug 2024 05:38:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90589463
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723959503; cv=none; b=YkhLjN1Cdf5eQI7YvSOZ6KMXhVZXLtxtKr6sCNde1VLDfGzTjwjdZ84liBftJ/MPBtO5qIekQnR8B5x0JPh+frM4WfWa/KLYFld1FoFEKgGKaUpus72z28shZjoyFhGbnaNXsedd/1ueWmhvCo+txO231w9XLVBdtmAme74zHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723959503; c=relaxed/simple;
	bh=hU5JPVZ3CIttnzErl4IVSWJTS73zHhKoKDLS6+0NXmU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sgOKdM4ZVeGxIesIIyoG1en41m6RotqBQPKqlv/PDoGV8n+xAPh0UjG5dCodQCXAjQunxc6NJBSz0Or6fM5948vsZVN5En0MKWEhh7YjRE2jb8dsxZnGqdSvX8LIm96cKAMd4uOo0PUJKCOp73xb4miDkSiZAcBFEguZ91mw23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wmkx44gq2z1xvBh;
	Sun, 18 Aug 2024 13:36:24 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id B7EE21400F4;
	Sun, 18 Aug 2024 13:38:17 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 18 Aug
 2024 13:38:16 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH net-next] net: hns3: Use ARRAY_SIZE() to improve readability
Date: Sun, 18 Aug 2024 13:25:18 +0800
Message-ID: <20240818052518.45489-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500003.china.huawei.com (7.202.181.241)

There is a helper function ARRAY_SIZE() to help calculating the
u32 array size, and we don't need to do it mannually. So, let's
use ARRAY_SIZE() to calculate the array size, and improve the code
readability.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
index 65b9dcd38137..6db415d8b917 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
@@ -134,17 +134,17 @@ void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
 	reg += hclgevf_reg_get_header(reg);
 
 	/* fetching per-VF registers values from VF PCIe register space */
-	reg_um = sizeof(cmdq_reg_addr_list) / sizeof(u32);
+	reg_um = ARRAY_SIZE(cmdq_reg_addr_list);
 	reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_CMDQ, reg_um, reg);
 	for (i = 0; i < reg_um; i++)
 		*reg++ = hclgevf_read_dev(&hdev->hw, cmdq_reg_addr_list[i]);
 
-	reg_um = sizeof(common_reg_addr_list) / sizeof(u32);
+	reg_um = ARRAY_SIZE(common_reg_addr_list);
 	reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_COMMON, reg_um, reg);
 	for (i = 0; i < reg_um; i++)
 		*reg++ = hclgevf_read_dev(&hdev->hw, common_reg_addr_list[i]);
 
-	reg_um = sizeof(ring_reg_addr_list) / sizeof(u32);
+	reg_um = ARRAY_SIZE(ring_reg_addr_list);
 	for (j = 0; j < hdev->num_tqps; j++) {
 		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_RING, reg_um, reg);
 		for (i = 0; i < reg_um; i++)
@@ -153,7 +153,7 @@ void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
 						  HCLGEVF_RING_REG_OFFSET * j);
 	}
 
-	reg_um = sizeof(tqp_intr_reg_addr_list) / sizeof(u32);
+	reg_um = ARRAY_SIZE(tqp_intr_reg_addr_list);
 	for (j = 0; j < hdev->num_msi_used - 1; j++) {
 		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_TQP_INTR, reg_um, reg);
 		for (i = 0; i < reg_um; i++)
-- 
2.17.1


