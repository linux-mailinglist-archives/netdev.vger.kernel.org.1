Return-Path: <netdev+bounces-198365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C12CADBE63
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4729B1892CD1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D9D1C8FBA;
	Tue, 17 Jun 2025 01:10:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73A1465B4;
	Tue, 17 Jun 2025 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122600; cv=none; b=RJTwJNk1PLqkMUBmuE7/bU5uIPwTECUihjuI1rZVljC244W2m+MYCH0vwidAoz/8P73zcO4dEmhpVOyGauZVvXY6W0sjuacKxRJlWZHaMLQUUxGQ4FdvjaOD7DOIccguDPeHdjbmOuSyMML0IV7Z+yjSHfkIRxuJ5zep2sVPBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122600; c=relaxed/simple;
	bh=mAy3QesswNfPjmSLyb63R9mpAsFg1CBlK80iMlxmUq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNSTwSfIAqdtwP7KBvNRlyWlnvOZ4FpravF8wsPFHdK6HN4Qmky1N0a5vzcMwlW1lV4Mg3n/e374TYiF7r+2y2Cvdf3ewIk4aY5qb59pQdziSua9EDKf3PZl42nh8nsLUgG2Wq8krQve0n9pWuMnn3xKQhJlbidRApgTkGc/G4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bLpf55tktz2TS1w;
	Tue, 17 Jun 2025 09:08:29 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 61ABE1402C1;
	Tue, 17 Jun 2025 09:09:56 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Jun 2025 09:09:55 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net-next 4/8] net: hns3: add \n at the end when print msg
Date: Tue, 17 Jun 2025 09:02:51 +0800
Message-ID: <20250617010255.1183069-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250617010255.1183069-1-shaojijie@huawei.com>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Peiyang Wang <wangpeiyang1@huawei.com>

To make the print message more clearly, add \n at the and of message if
it is missing currently.

Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c        |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c     | 10 +++++-----
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 208a2dfc07ec..dc1e15926482 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2447,7 +2447,7 @@ static int hns3_nic_set_features(struct net_device *netdev,
 	if ((netdev->features & NETIF_F_HW_TC) > (features & NETIF_F_HW_TC) &&
 	    h->ae_algo->ops->cls_flower_active(h)) {
 		netdev_err(netdev,
-			   "there are offloaded TC filters active, cannot disable HW TC offload");
+			   "there are offloaded TC filters active, cannot disable HW TC offload\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 5e01dd55d660..6a244ba5e051 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -436,7 +436,7 @@ static void hns3_self_test(struct net_device *ndev,
 		data[i] = HNS3_NIC_LB_TEST_UNEXECUTED;
 
 	if (hns3_nic_resetting(ndev)) {
-		netdev_err(ndev, "dev resetting!");
+		netdev_err(ndev, "dev resetting!\n");
 		goto failure;
 	}
 
@@ -794,7 +794,7 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 		break;
 	default:
 
-		netdev_warn(netdev, "Unknown media type");
+		netdev_warn(netdev, "Unknown media type\n");
 		return 0;
 	}
 
@@ -842,7 +842,7 @@ static int hns3_check_ksettings_param(const struct net_device *netdev,
 	if (cmd->base.duplex == DUPLEX_HALF &&
 	    media_type != HNAE3_MEDIA_TYPE_COPPER) {
 		netdev_err(netdev,
-			   "only copper port supports half duplex!");
+			   "only copper port supports half duplex!\n");
 		return -EINVAL;
 	}
 
@@ -1308,7 +1308,7 @@ static int hns3_nway_reset(struct net_device *netdev)
 		return 0;
 
 	if (hns3_nic_resetting(netdev)) {
-		netdev_err(netdev, "dev resetting!");
+		netdev_err(netdev, "dev resetting!\n");
 		return -EBUSY;
 	}
 
@@ -1924,7 +1924,7 @@ static int hns3_set_tunable(struct net_device *netdev,
 	int i, ret = 0;
 
 	if (hns3_nic_resetting(netdev) || !priv->ring) {
-		netdev_err(netdev, "failed to set tunable value, dev resetting!");
+		netdev_err(netdev, "failed to set tunable value, dev resetting!\n");
 		return -EBUSY;
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a5b480d59fbf..e0a2ca21ee46 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11423,7 +11423,7 @@ static int hclge_pci_init(struct hclge_dev *hdev)
 		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			dev_err(&pdev->dev,
-				"can't set consistent PCI DMA");
+				"can't set consistent PCI DMA\n");
 			goto err_disable_device;
 		}
 		dev_warn(&pdev->dev, "set DMA mask to 32 bits\n");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index c4f35e8e2177..e3f86638540b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2625,7 +2625,7 @@ static int hclgevf_pci_init(struct hclgevf_dev *hdev)
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
-		dev_err(&pdev->dev, "can't set consistent PCI DMA, exiting");
+		dev_err(&pdev->dev, "can't set consistent PCI DMA, exiting\n");
 		goto err_disable_device;
 	}
 
-- 
2.33.0


