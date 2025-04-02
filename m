Return-Path: <netdev+bounces-178781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8347A78E03
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8877A5235
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA3F239570;
	Wed,  2 Apr 2025 12:16:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812D238D56;
	Wed,  2 Apr 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596189; cv=none; b=lpn5IT4W1Y26oHNekgk6cM6Bzm5vsjna890QfZzyhKtCJOHUtQvxTKT5XHPA1COKzKH0rYI7NvFLej3BcBFUzr7hjWP+3sGaM/C0mqFVAKqlUhTyq9wM3YmJ8ccfkknjwLiJN1gLg+sLgZH4Ed2Mfx9xp/MDDxyq0At4zL6097g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596189; c=relaxed/simple;
	bh=E6gt0WJkhjRjFt7M2cbh0RKeQPvQw7plIkjnWKi1IQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmai1bjkh0qg0Gi9cJ3uEuPmetSl4cQEqOH9mf8K3FATgrka0tpxsWvLQKhfclg/uh1mzz9LWe2Ez4Y6kAXynugQNDKXkTqQgqbYvR4l2CEJGFGHdqaBA4Z29xR1Qu4WBflVlqQATVnYGU34MKWnqdOi9yNgs2k7ympOFSaIWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZSNzv41wyzHrGB;
	Wed,  2 Apr 2025 20:12:59 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E5B7E180103;
	Wed,  2 Apr 2025 20:16:19 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 20:16:19 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 2/3] net: hns3: fix spelling mistake "reg_um" -> "reg_num"
Date: Wed, 2 Apr 2025 20:10:00 +0800
Message-ID: <20250402121001.663431-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250402121001.663431-1-shaojijie@huawei.com>
References: <20250402121001.663431-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Hao Lan <lanhao@huawei.com>

There are spelling mistakes in hclgevf_get_regs. Fix them.

Signed-off-by: Hao Lan <lanhao@huawei.com>
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


