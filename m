Return-Path: <netdev+bounces-19314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595C475A440
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7236E1C2121F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 02:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29067F7;
	Thu, 20 Jul 2023 02:08:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA164F
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:08:11 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643AA2107
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:08:09 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R5x0940jMzrRq6;
	Thu, 20 Jul 2023 10:07:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 10:08:06 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <netdev@vger.kernel.org>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lanhao@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <wangjie125@huawei.com>, <shenjian15@huawei.com>
Subject: [PATCH net 0/4] There are some bugfix for the HNS3 ethernet driver
Date: Thu, 20 Jul 2023 10:05:06 +0800
Message-ID: <20230720020510.2223815-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are some bugfix for the HNS3 ethernet driver

Hao Lan (2):
  net: hns3: fix the imp capability bit cannot exceed 32 bits issue
  net: hns3: add tm flush when setting tm

Jijie Shao (2):
  net: hns3: fix wrong tc bandwidth weight data issue
  net: hns3: fix wrong bw weight of disabled tc issue

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  7 ++-
 .../hns3/hns3_common/hclge_comm_cmd.c         | 22 ++++++--
 .../hns3/hns3_common/hclge_comm_cmd.h         |  2 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  3 ++
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 51 ++++++++++++++++---
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |  3 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 34 ++++++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |  4 ++
 8 files changed, 110 insertions(+), 16 deletions(-)

-- 
2.30.0


