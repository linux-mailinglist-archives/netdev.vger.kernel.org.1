Return-Path: <netdev+bounces-222436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52246B54302
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 08:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E201C86D07
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0CF2D8360;
	Fri, 12 Sep 2025 06:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B62D7385;
	Fri, 12 Sep 2025 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658553; cv=none; b=E3ujC7avsClrS0qOUkTKhtHPjMCn3EAOLsMYHU6RkAp/8tOf35Sm/NaZUgS2PTjf3iRHncsfNFmaRW4Slke69Z1PkES37pT0OZid4GhngU/gNGOaXP41Ps2CglGCtVeMcYS2ZXs8crxaW5Hf9qGb++nx+noU2hDZh5IPLdzieco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658553; c=relaxed/simple;
	bh=s6eDdhRxwiAGwBQu1EeWsS2Kiz3ungjNpeZ+VY7CMBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rb9hhed3crTe50VwIkBPCONgZGTlWntQTio/S3vQWEPuoG9lEUoP+gt4if7dpVW1d3+7VLjL4xI6Ytf5AUFcGskAvaImzGREkYtJW2edLeynhsBVVpxTDBLiRzjqOxUxnqJHXVHLzZPHkYKYdn4wogIRveT9APjnJfCZWLKZcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cNPZ61724z2VRp6;
	Fri, 12 Sep 2025 14:25:50 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ECB31A016C;
	Fri, 12 Sep 2025 14:29:08 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Sep 2025 14:29:06 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v06 14/14] hinic3: Fix code style (Missing a blank line before return)
Date: Fri, 12 Sep 2025 14:28:31 +0800
Message-ID: <e4b34db5ee423ca554ff60b49a9ecd7f84c32110.1757653621.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1757653621.git.zhuyikai1@h-partners.com>
References: <cover.1757653621.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Fix code style of missing a blank line before return.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c     | 5 +++++
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c | 1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c      | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 10477fb9cc34..3db8241a3b0c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -122,6 +122,7 @@ static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
 			goto err_del_adevs;
 	}
 	mutex_unlock(&pci_adapter->pdev_mutex);
+
 	return 0;
 
 err_del_adevs:
@@ -133,6 +134,7 @@ static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
 		}
 	}
 	mutex_unlock(&pci_adapter->pdev_mutex);
+
 	return -ENOMEM;
 }
 
@@ -154,6 +156,7 @@ struct hinic3_hwdev *hinic3_adev_get_hwdev(struct auxiliary_device *adev)
 	struct hinic3_adev *hadev;
 
 	hadev = container_of(adev, struct hinic3_adev, adev);
+
 	return hadev->hwdev;
 }
 
@@ -335,6 +338,7 @@ static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
 
 err_out:
 	dev_err(&pdev->dev, "PCIe device probe function failed\n");
+
 	return err;
 }
 
@@ -367,6 +371,7 @@ static int hinic3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_out:
 	dev_err(&pdev->dev, "PCIe device probe failed\n");
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 9349b8a314ae..979f47ca77f9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -112,6 +112,7 @@ int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
 	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
 
 	func_tbl_cfg.mtu = new_mtu;
+
 	return hinic3_set_function_table(hwdev, BIT(L2NIC_FUNC_TBL_CFG_MTU),
 					 &func_tbl_cfg);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index dea882260b11..92c43c05e3f2 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -116,6 +116,7 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
 	}
 	dma_unmap_single(&pdev->dev, dma_info[0].dma, dma_info[0].len,
 			 DMA_TO_DEVICE);
+
 	return err;
 }
 
@@ -601,6 +602,7 @@ netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 
 err_drop_pkt:
 	dev_kfree_skb_any(skb);
+
 	return NETDEV_TX_OK;
 }
 
-- 
2.43.0


