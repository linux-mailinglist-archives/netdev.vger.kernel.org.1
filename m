Return-Path: <netdev+bounces-28461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DC77F7F5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C97281FB1
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B121429C;
	Thu, 17 Aug 2023 13:42:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715C13AFE
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:42:39 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BC926BC
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:42:37 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRR1L6nX9zNmrP;
	Thu, 17 Aug 2023 21:39:02 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 21:42:34 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <madalin.bucur@nxp.com>, <sean.anderson@seco.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<pantelis.antoniou@gmail.com>, <camelia.groza@nxp.com>,
	<christophe.leroy@csgroup.eu>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH net-next] net: freescale: Remove unused declarations
Date: Thu, 17 Aug 2023 21:41:59 +0800
Message-ID: <20230817134159.38484-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 5d93cfcf7360 ("net: dpaa: Convert to phylink") removed
fman_set_mac_active_pause()/fman_get_pause_cfg() but not declarations.
Commit 48257c4f168e ("Add fs_enet ethernet network driver, for several
embedded platforms.") declared but never implemented
fs_enet_platform_init() and fs_enet_platform_cleanup().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/freescale/fman/mac.h        | 4 ----
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/mac.h b/drivers/net/ethernet/freescale/fman/mac.h
index ad06f8d7924b..fe747915cc73 100644
--- a/drivers/net/ethernet/freescale/fman/mac.h
+++ b/drivers/net/ethernet/freescale/fman/mac.h
@@ -68,10 +68,6 @@ struct dpaa_eth_data {
 
 extern const char	*mac_driver_description;
 
-int fman_set_mac_active_pause(struct mac_device *mac_dev, bool rx, bool tx);
-
-void fman_get_pause_cfg(struct mac_device *mac_dev, bool *rx_pause,
-			bool *tx_pause);
 int fman_set_multi(struct net_device *net_dev, struct mac_device *mac_dev);
 
 #endif	/* __MAC_H */
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
index d371072fff60..759bb7080e22 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -208,11 +208,6 @@ void fs_cleanup_bds(struct net_device *dev);
 #define DRV_MODULE_NAME		"fs_enet"
 #define PFX DRV_MODULE_NAME	": "
 
-/***************************************************************************/
-
-int fs_enet_platform_init(void);
-void fs_enet_platform_cleanup(void);
-
 /***************************************************************************/
 /* buffer descriptor access macros */
 
-- 
2.34.1


