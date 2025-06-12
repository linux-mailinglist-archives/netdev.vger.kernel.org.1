Return-Path: <netdev+bounces-196783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5040DAD657E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDF617ECBA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF120103A;
	Thu, 12 Jun 2025 02:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DF1EEA28;
	Thu, 12 Jun 2025 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694859; cv=none; b=dqgHyQrVFfplAFd5o0cqsWUX1OqkFjIjQKdHj4lMuX39Efhr5IM5D05hIu+Hjv3o7VqiW9aybGcAOoBIm/5vmKCr61/2FSZFyLN4taZxGoPo7J1s7GOwJBtCo0UVfOgdYw8TtwVy5MTnFMb2Fd0WMusCv0Dfa0x8djgMk15drus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694859; c=relaxed/simple;
	bh=NnhwikswnhETjKQvAQDV2EGVXVJl4fguIvILO2x5JOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WA7wo2o1KWwgdNphWe0MjT5IaZ6o2oeoSewVLdgk1n8LfW9trBI5HWposhHSymcLz7nmU9C7tbNm7bi/ABhg2X5ylQWF6gTzFGW/2KanvU1I5ZJf0iOuJ47xzK+mM4oRhJs4TVu53Xf5H/kFbtUejHmeeMbOnIXv3GRgiHM/DvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bHmSK2jzQz2TSHq;
	Thu, 12 Jun 2025 10:19:29 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EECD1A0188;
	Thu, 12 Jun 2025 10:20:49 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Jun 2025 10:20:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 1/8] net: hns3: fix spelling mistake "reg_um" -> "reg_num"
Date: Thu, 12 Jun 2025 10:13:10 +0800
Message-ID: <20250612021317.1487943-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250612021317.1487943-1-shaojijie@huawei.com>
References: <20250612021317.1487943-1-shaojijie@huawei.com>
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

There are spelling mistakes in hclgevf_get_regs. Fix them.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
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


