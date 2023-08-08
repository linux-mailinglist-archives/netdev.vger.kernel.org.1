Return-Path: <netdev+bounces-25210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C18D773607
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 03:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21C5281611
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 01:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FE0391;
	Tue,  8 Aug 2023 01:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B637E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 01:47:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B410F3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 18:47:28 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKbZR1wwJztS5Z;
	Tue,  8 Aug 2023 09:43:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 09:47:26 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <lizetao1@huawei.com>, <shayagr@amazon.com>, <thomas.lendacky@amd.com>,
	<leon@kernel.org>, <khalasa@piap.pl>, <u.kleine-koenig@pengutronix.de>,
	<wsa+renesas@sang-engineering.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next] bcm63xx_enet: Remove redundant initialization owner
Date: Tue, 8 Aug 2023 09:47:02 +0800
Message-ID: <20230808014702.2712699-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The platform_register_drivers() will set "THIS_MODULE" to driver.owner when
register a platform_driver driver, so it is redundant initialization to set
driver.owner in the statement. Remove it for clean code.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 2cf96892e565..a741070f1f9a 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1940,7 +1940,6 @@ static struct platform_driver bcm63xx_enet_driver = {
 	.remove	= bcm_enet_remove,
 	.driver	= {
 		.name	= "bcm63xx_enet",
-		.owner  = THIS_MODULE,
 	},
 };
 
@@ -2761,7 +2760,6 @@ static struct platform_driver bcm63xx_enetsw_driver = {
 	.remove	= bcm_enetsw_remove,
 	.driver	= {
 		.name	= "bcm63xx_enetsw",
-		.owner  = THIS_MODULE,
 	},
 };
 
@@ -2791,7 +2789,6 @@ struct platform_driver bcm63xx_enet_shared_driver = {
 	.probe	= bcm_enet_shared_probe,
 	.driver	= {
 		.name	= "bcm63xx_enet_shared",
-		.owner  = THIS_MODULE,
 	},
 };
 
-- 
2.34.1


