Return-Path: <netdev+bounces-200125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FD4AE3432
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219F63B1020
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E81DE4C3;
	Mon, 23 Jun 2025 04:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B91C84D7;
	Mon, 23 Jun 2025 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651664; cv=none; b=p5wZAmaYO4bZjP1FHxDHZukkrqvzAgYnOq4SsSmM10oPCiPnuxLUiSD87Z0U4oLaH2wEnxPM59W5oT/dCdXWP98C4XhALdKUrFXwJQ50n3UYO4qCxNgvTSgE/DwNtg28fOoSriRupovfdghvDC8xAeOc07bO+dsBg5KYJNvMW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651664; c=relaxed/simple;
	bh=Fes2A/ORnekr5nBCW52fV6M/20Ly4jSsrXiQGz/y1LY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUugvDOnmnQgDJlWm9vxGlUmCzNPh4vzskohtmSQz5uNM4l8m9nRpK4mCzP9nG4AH3f3xlhijUtcV3MvIy1y9r7MPngNUxx7ZZYG0y/Dtl9vIdvp4Y/yQ7UXo3LMR+XCzS5kJR5Egdx7tZq84SlFHFHlkp8Vsxep+rlLZbSG4m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bQZFP5Jhkz2Cfb0;
	Mon, 23 Jun 2025 12:03:37 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 45BF41A016C;
	Mon, 23 Jun 2025 12:07:34 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 12:07:33 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net-next 1/7] net: hns3: fix spelling mistake "reg_um" -> "reg_num"
Date: Mon, 23 Jun 2025 12:00:37 +0800
Message-ID: <20250623040043.857782-2-shaojijie@huawei.com>
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

There are spelling mistakes in hclgevf_get_regs. Fix them.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
index 7d9d9dbc7560..9de01e344e27 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
@@ -127,37 +127,38 @@ void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
 
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	struct hnae3_queue *tqp;
-	int i, j, reg_um;
+	int i, j, reg_num;
 	u32 *reg = data;
 
 	*version = hdev->fw_version;
 	reg += hclgevf_reg_get_header(reg);
 
 	/* fetching per-VF registers values from VF PCIe register space */
-	reg_um = ARRAY_SIZE(cmdq_reg_addr_list);
-	reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_CMDQ, reg_um, reg);
-	for (i = 0; i < reg_um; i++)
+	reg_num = ARRAY_SIZE(cmdq_reg_addr_list);
+	reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_CMDQ, reg_num, reg);
+	for (i = 0; i < reg_num; i++)
 		*reg++ = hclgevf_read_dev(&hdev->hw, cmdq_reg_addr_list[i]);
 
-	reg_um = ARRAY_SIZE(common_reg_addr_list);
-	reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_COMMON, reg_um, reg);
-	for (i = 0; i < reg_um; i++)
+	reg_num = ARRAY_SIZE(common_reg_addr_list);
+	reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_COMMON, reg_num, reg);
+	for (i = 0; i < reg_num; i++)
 		*reg++ = hclgevf_read_dev(&hdev->hw, common_reg_addr_list[i]);
 
-	reg_um = ARRAY_SIZE(ring_reg_addr_list);
+	reg_num = ARRAY_SIZE(ring_reg_addr_list);
 	for (j = 0; j < hdev->num_tqps; j++) {
-		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_RING, reg_um, reg);
+		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_RING, reg_num, reg);
 		tqp = &hdev->htqp[j].q;
-		for (i = 0; i < reg_um; i++)
+		for (i = 0; i < reg_num; i++)
 			*reg++ = readl_relaxed(tqp->io_base -
 					       HCLGEVF_TQP_REG_OFFSET +
 					       ring_reg_addr_list[i]);
 	}
 
-	reg_um = ARRAY_SIZE(tqp_intr_reg_addr_list);
+	reg_num = ARRAY_SIZE(tqp_intr_reg_addr_list);
 	for (j = 0; j < hdev->num_msi_used - 1; j++) {
-		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_TQP_INTR, reg_um, reg);
-		for (i = 0; i < reg_um; i++)
+		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_TQP_INTR,
+					   reg_num, reg);
+		for (i = 0; i < reg_num; i++)
 			*reg++ = hclgevf_read_dev(&hdev->hw,
 						  tqp_intr_reg_addr_list[i] +
 						  HCLGEVF_RING_INT_REG_OFFSET * j);
-- 
2.33.0


