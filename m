Return-Path: <netdev+bounces-29496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D64E7837D9
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 04:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A97280F3D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 02:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2325E15C0;
	Tue, 22 Aug 2023 02:20:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE82110A
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:20:33 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B5D113;
	Mon, 21 Aug 2023 19:20:32 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVCf01ll9zNnCZ;
	Tue, 22 Aug 2023 10:16:56 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 10:20:29 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<saeedm@nvidia.com>, <leon@kernel.org>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>, <davem@davemloft.net>,
	<maciej.fijalkowski@intel.com>, <michal.simek@amd.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 2/2] net: dm9051: Use PTR_ERR_OR_ZERO() to simplify code
Date: Tue, 22 Aug 2023 10:14:55 +0800
Message-ID: <20230822021455.205101-2-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822021455.205101-1-liaoyu15@huawei.com>
References: <20230822021455.205101-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/net/ethernet/davicom/dm9051.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/davicom/dm9051.c b/drivers/net/ethernet/davicom/dm9051.c
index 70728b2e5f18..829ec35d094b 100644
--- a/drivers/net/ethernet/davicom/dm9051.c
+++ b/drivers/net/ethernet/davicom/dm9051.c
@@ -1161,9 +1161,7 @@ static int dm9051_phy_connect(struct board_info *db)
 
 	db->phydev = phy_connect(db->ndev, phy_id, dm9051_handle_link_change,
 				 PHY_INTERFACE_MODE_MII);
-	if (IS_ERR(db->phydev))
-		return PTR_ERR_OR_ZERO(db->phydev);
-	return 0;
+	return PTR_ERR_OR_ZERO(db->phydev);
 }
 
 static int dm9051_probe(struct spi_device *spi)
-- 
2.25.1


