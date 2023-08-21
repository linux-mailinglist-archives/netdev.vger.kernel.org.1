Return-Path: <netdev+bounces-29332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F39C782ABA
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4057E1C203DA
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2312C7475;
	Mon, 21 Aug 2023 13:40:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E26FBE
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:40:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E19EC
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:40:32 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTtpd34Q4zVkmh;
	Mon, 21 Aug 2023 21:38:17 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 21:40:30 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<rogerq@kernel.org>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: ethernet: ti: Remove unused declarations
Date: Mon, 21 Aug 2023 21:40:29 +0800
Message-ID: <20230821134029.40084-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit e8609e69470f ("net: ethernet: ti: am65-cpsw: Convert to PHYLINK")
removed am65_cpsw_nuss_adjust_link() but not its declaration.
Commit 84640e27f230 ("net: netcp: Add Keystone NetCP core ethernet driver")
declared but never implemented netcp_device_find_module().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h | 1 -
 drivers/net/ethernet/ti/netcp.h          | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index bf40c88fbd9b..f3dad2ab9828 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -192,7 +192,6 @@ struct am65_cpsw_ndev_priv {
 
 extern const struct ethtool_ops am65_cpsw_ethtool_ops_slave;
 
-void am65_cpsw_nuss_adjust_link(struct net_device *ndev);
 void am65_cpsw_nuss_set_p0_ptype(struct am65_cpsw_common *common);
 void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common);
 int am65_cpsw_nuss_update_tx_chns(struct am65_cpsw_common *common, int num_tx);
diff --git a/drivers/net/ethernet/ti/netcp.h b/drivers/net/ethernet/ti/netcp.h
index 43d5cd59b56b..7007eb8bed36 100644
--- a/drivers/net/ethernet/ti/netcp.h
+++ b/drivers/net/ethernet/ti/netcp.h
@@ -233,8 +233,6 @@ int netcp_register_rxhook(struct netcp_intf *netcp_priv, int order,
 			  netcp_hook_rtn *hook_rtn, void *hook_data);
 int netcp_unregister_rxhook(struct netcp_intf *netcp_priv, int order,
 			    netcp_hook_rtn *hook_rtn, void *hook_data);
-void *netcp_device_find_module(struct netcp_device *netcp_device,
-			       const char *name);
 
 /* SGMII functions */
 int netcp_sgmii_reset(void __iomem *sgmii_ofs, int port);
-- 
2.34.1


