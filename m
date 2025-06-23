Return-Path: <netdev+bounces-200128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5BAE3438
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CF917057F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010211E5B8A;
	Mon, 23 Jun 2025 04:07:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74BD1DE8B0;
	Mon, 23 Jun 2025 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651666; cv=none; b=Gvy7CzGdChTHesVW8fYelloZKScpIzkxDQHdibxokDN4cBiuBxgnzJeXtTIx5pxrQNxARs8Nyqrvii14UzklMyeIl1FEWemubt8UKeK0w7/CF8tiTIZM3Pn2X0TMz0nl02XJD5jUB4/VkE3VoHYoZchFrvmhDCmci/U2/qLTLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651666; c=relaxed/simple;
	bh=+tBSu5LsdSDBgkNL2VMMqzgKYdCOguwmHcZyQ2R4FX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzjOf/cT/VWGk0BI4+0MVLYXKE40QNYoWa7rrdj4TGsswdOoP/7bXGUYlRMPSLTmYv/RO5Yc3KlzeTvokrao/eFBNc3OjHBzfh0nUdgD9Ayv8jYV8cas8/0OhhIC1KfFZ2wcqDuxz52wmgmbg2kZN3IB+oLYwm6f5KGNbNvqoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bQZH9211Yz28fQW;
	Mon, 23 Jun 2025 12:05:09 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 289EA1401F2;
	Mon, 23 Jun 2025 12:07:36 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 12:07:35 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net-next 4/7] net: hns3: add \n at the end when print msg
Date: Mon, 23 Jun 2025 12:00:40 +0800
Message-ID: <20250623040043.857782-5-shaojijie@huawei.com>
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

From: Peiyang Wang <wangpeiyang1@huawei.com>

To make the print message more clearly, add \n at the and of message if
it is missing currently.

Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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
index c590daad497c..c615834dfd84 100644
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
 
@@ -1321,7 +1321,7 @@ static int hns3_nway_reset(struct net_device *netdev)
 		return 0;
 
 	if (hns3_nic_resetting(netdev)) {
-		netdev_err(netdev, "dev resetting!");
+		netdev_err(netdev, "dev resetting!\n");
 		return -EBUSY;
 	}
 
@@ -1937,7 +1937,7 @@ static int hns3_set_tunable(struct net_device *netdev,
 	int i, ret = 0;
 
 	if (hns3_nic_resetting(netdev) || !priv->ring) {
-		netdev_err(netdev, "failed to set tunable value, dev resetting!");
+		netdev_err(netdev, "failed to set tunable value, dev resetting!\n");
 		return -EBUSY;
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5acefd57df45..205cdbb81743 100644
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
index f1657f50cdda..ffe51a68384c 100644
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


