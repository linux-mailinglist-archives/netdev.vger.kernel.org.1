Return-Path: <netdev+bounces-24335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC49976FD30
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3279A1C20ACC
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4938A92D;
	Fri,  4 Aug 2023 09:25:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E18479
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:25:10 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EFA49C6
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 02:25:09 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHKwP0kF0zGpnq;
	Fri,  4 Aug 2023 17:21:41 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 17:25:07 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <netdev@vger.kernel.org>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>, <nnac123@linux.ibm.com>,
	<davem@davemloft.net>
Subject: [PATCH -next] ibmvnic: remove unused rc variable
Date: Fri, 4 Aug 2023 17:21:43 +0800
Message-ID: <20230804092143.1356733-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
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

gcc with W=1 reports
drivers/net/ethernet/ibm/ibmvnic.c:194:13: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
                                            ^
This variable is not used so remove it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308040609.zQsSXWXI-lkp@intel.com/
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 763d613adbcc..01535b03eab6 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -191,9 +191,8 @@ static void ibmvnic_clean_affinity(struct ibmvnic_adapter *adapter)
 	struct ibmvnic_sub_crq_queue **rxqs;
 	struct ibmvnic_sub_crq_queue **txqs;
 	int num_rxqs, num_txqs;
-	int rc, i;
+	int i;
 
-	rc = 0;
 	rxqs = adapter->rx_scrq;
 	txqs = adapter->tx_scrq;
 	num_txqs = adapter->num_active_tx_scrqs;
-- 
2.25.1


