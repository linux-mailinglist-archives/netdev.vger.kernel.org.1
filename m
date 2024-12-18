Return-Path: <netdev+bounces-153063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E489F6B38
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9745B18981C7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7477C1F5402;
	Wed, 18 Dec 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GzDRJ6XA"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7F14AD0E;
	Wed, 18 Dec 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539638; cv=none; b=D/NpieI5RuHmh8NvccBk462P0rSNpVSaYIMbFb4AUFFV8YBYtpLPb8RWSsloX1HzN0zyZWVpnUO3an4GMSsrwCFREn3UoDfhvhxsnroFgFnYW0AVDkWTHXc0yLZkNziBHKyn1Jq9R7sYBlZtnaAAif/X2Rr04HoAaE88Bb4h5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539638; c=relaxed/simple;
	bh=LtDr4bTi4I89tipAlSWYo8BDfzHXGRZkj7MtWhbeL+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQXK63efysVbmmz0bet9rp6GnJEXm95QCCyb1asvZ7XOr2ecJY/VwbgrO9IXBw82f2umJSZmYHWG9boyt3bdO9QzJptRFa1GnmOO5s95jLLZcEOlIOB+9IhPt0GsdOIOjhjz9Eqq/TT+tS0eVH7RI9FTduiPY5IXL4iVYcGUmG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GzDRJ6XA; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=nBIeq+Yjp78pRWOuY/VWfVziqqfkWlDpUzxPnKAEnnE=; b=GzDRJ6XA5qOmGG//
	oYNa37p2Zy1TEYX7TRpyD/JR8CTHIdGo33QkD2HqDPW7AlAgTyCxJgDZZPcOgVEo/p7FKUwSsIBeI
	4cPKcqMP7NG2+IOIBMCzqvBlgulISLF//x/cM3WNH8TXBEjeQHj2GQRpFugTCyJXYZm4gOsgcJFu6
	9CkOrFy5LzZYkJR9I2uT3BTuvYISNi8z9/2gouy2Ah0oi2BNzUxRyM1wWka1wWzyxZ8ZCoRJKNElx
	D31ddGZHjLOiyYHK3C3WpIo/ddxAQlSq2oMtyyKwiu1qWA2wv+kiWFy/oL1SupDVQeaqgCFnM1Ald
	yUXyHrB3zNU0QrXYWQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNwzY-0068f8-0y;
	Wed, 18 Dec 2024 16:33:44 +0000
From: linux@treblig.org
To: salil.mehta@huawei.com,
	shenjian15@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next v2 1/4] net: hisilicon: hns: Remove unused hns_dsaf_roce_reset
Date: Wed, 18 Dec 2024 16:33:38 +0000
Message-ID: <20241218163341.40297-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218163341.40297-1-linux@treblig.org>
References: <20241218163341.40297-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

hns_dsaf_roce_reset() has been unused since 2021's
commit 38d220882426 ("RDMA/hns: Remove support for HIP06")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../ethernet/hisilicon/hns/hns_dsaf_main.c    | 109 ------------------
 .../ethernet/hisilicon/hns/hns_dsaf_main.h    |   2 -
 2 files changed, 111 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index 851490346261..6b6ced37e490 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -3019,115 +3019,6 @@ static struct platform_driver g_dsaf_driver = {
 
 module_platform_driver(g_dsaf_driver);
 
-/**
- * hns_dsaf_roce_reset - reset dsaf and roce
- * @dsaf_fwnode: Pointer to framework node for the dasf
- * @dereset: false - request reset , true - drop reset
- * return 0 - success , negative -fail
- */
-int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
-{
-	struct dsaf_device *dsaf_dev;
-	struct platform_device *pdev;
-	u32 mp;
-	u32 sl;
-	u32 credit;
-	int i;
-	static const u32 port_map[DSAF_ROCE_CREDIT_CHN][DSAF_ROCE_CHAN_MODE_NUM] = {
-		{DSAF_ROCE_PORT_0, DSAF_ROCE_PORT_0, DSAF_ROCE_PORT_0},
-		{DSAF_ROCE_PORT_1, DSAF_ROCE_PORT_0, DSAF_ROCE_PORT_0},
-		{DSAF_ROCE_PORT_2, DSAF_ROCE_PORT_1, DSAF_ROCE_PORT_0},
-		{DSAF_ROCE_PORT_3, DSAF_ROCE_PORT_1, DSAF_ROCE_PORT_0},
-		{DSAF_ROCE_PORT_4, DSAF_ROCE_PORT_2, DSAF_ROCE_PORT_1},
-		{DSAF_ROCE_PORT_4, DSAF_ROCE_PORT_2, DSAF_ROCE_PORT_1},
-		{DSAF_ROCE_PORT_5, DSAF_ROCE_PORT_3, DSAF_ROCE_PORT_1},
-		{DSAF_ROCE_PORT_5, DSAF_ROCE_PORT_3, DSAF_ROCE_PORT_1},
-	};
-	static const u32 sl_map[DSAF_ROCE_CREDIT_CHN][DSAF_ROCE_CHAN_MODE_NUM] = {
-		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_0},
-		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_1, DSAF_ROCE_SL_1},
-		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_2},
-		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_1, DSAF_ROCE_SL_3},
-		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_0},
-		{DSAF_ROCE_SL_1, DSAF_ROCE_SL_1, DSAF_ROCE_SL_1},
-		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_2},
-		{DSAF_ROCE_SL_1, DSAF_ROCE_SL_1, DSAF_ROCE_SL_3},
-	};
-
-	/* find the platform device corresponding to fwnode */
-	if (is_of_node(dsaf_fwnode)) {
-		pdev = of_find_device_by_node(to_of_node(dsaf_fwnode));
-	} else if (is_acpi_device_node(dsaf_fwnode)) {
-		pdev = hns_dsaf_find_platform_device(dsaf_fwnode);
-	} else {
-		pr_err("fwnode is neither OF or ACPI type\n");
-		return -EINVAL;
-	}
-
-	/* check if we were a success in fetching pdev */
-	if (!pdev) {
-		pr_err("couldn't find platform device for node\n");
-		return -ENODEV;
-	}
-
-	/* retrieve the dsaf_device from the driver data */
-	dsaf_dev = dev_get_drvdata(&pdev->dev);
-	if (!dsaf_dev) {
-		dev_err(&pdev->dev, "dsaf_dev is NULL\n");
-		put_device(&pdev->dev);
-		return -ENODEV;
-	}
-
-	/* now, make sure we are running on compatible SoC */
-	if (AE_IS_VER1(dsaf_dev->dsaf_ver)) {
-		dev_err(dsaf_dev->dev, "%s v1 chip doesn't support RoCE!\n",
-			dsaf_dev->ae_dev.name);
-		put_device(&pdev->dev);
-		return -ENODEV;
-	}
-
-	/* do reset or de-reset according to the flag */
-	if (!dereset) {
-		/* reset rocee-channels in dsaf and rocee */
-		dsaf_dev->misc_op->hns_dsaf_srst_chns(dsaf_dev, DSAF_CHNS_MASK,
-						      false);
-		dsaf_dev->misc_op->hns_dsaf_roce_srst(dsaf_dev, false);
-	} else {
-		/* configure dsaf tx roce correspond to port map and sl map */
-		mp = dsaf_read_dev(dsaf_dev, DSAF_ROCE_PORT_MAP_REG);
-		for (i = 0; i < DSAF_ROCE_CREDIT_CHN; i++)
-			dsaf_set_field(mp, 7 << i * 3, i * 3,
-				       port_map[i][DSAF_ROCE_6PORT_MODE]);
-		dsaf_set_field(mp, 3 << i * 3, i * 3, 0);
-		dsaf_write_dev(dsaf_dev, DSAF_ROCE_PORT_MAP_REG, mp);
-
-		sl = dsaf_read_dev(dsaf_dev, DSAF_ROCE_SL_MAP_REG);
-		for (i = 0; i < DSAF_ROCE_CREDIT_CHN; i++)
-			dsaf_set_field(sl, 3 << i * 2, i * 2,
-				       sl_map[i][DSAF_ROCE_6PORT_MODE]);
-		dsaf_write_dev(dsaf_dev, DSAF_ROCE_SL_MAP_REG, sl);
-
-		/* de-reset rocee-channels in dsaf and rocee */
-		dsaf_dev->misc_op->hns_dsaf_srst_chns(dsaf_dev, DSAF_CHNS_MASK,
-						      true);
-		msleep(SRST_TIME_INTERVAL);
-		dsaf_dev->misc_op->hns_dsaf_roce_srst(dsaf_dev, true);
-
-		/* enable dsaf channel rocee credit */
-		credit = dsaf_read_dev(dsaf_dev, DSAF_SBM_ROCEE_CFG_REG_REG);
-		dsaf_set_bit(credit, DSAF_SBM_ROCEE_CFG_CRD_EN_B, 0);
-		dsaf_write_dev(dsaf_dev, DSAF_SBM_ROCEE_CFG_REG_REG, credit);
-
-		dsaf_set_bit(credit, DSAF_SBM_ROCEE_CFG_CRD_EN_B, 1);
-		dsaf_write_dev(dsaf_dev, DSAF_SBM_ROCEE_CFG_REG_REG, credit);
-	}
-
-	put_device(&pdev->dev);
-
-	return 0;
-}
-EXPORT_SYMBOL(hns_dsaf_roce_reset);
-
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
 MODULE_DESCRIPTION("HNS DSAF driver");
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
index 0eb03dff1a8b..c90f41c75500 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
@@ -463,6 +463,4 @@ int hns_dsaf_clr_mac_mc_port(struct dsaf_device *dsaf_dev,
 			     u8 mac_id, u8 port_num);
 int hns_dsaf_wait_pkt_clean(struct dsaf_device *dsaf_dev, int port);
 
-int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset);
-
 #endif /* __HNS_DSAF_MAIN_H__ */
-- 
2.47.1


