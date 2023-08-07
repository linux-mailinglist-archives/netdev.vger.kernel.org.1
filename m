Return-Path: <netdev+bounces-24934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10070772329
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B059B281244
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309DFC0A;
	Mon,  7 Aug 2023 11:56:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF3FBF0
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 11:56:18 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6A983;
	Mon,  7 Aug 2023 04:56:16 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKDpg1Z73zfbmg;
	Mon,  7 Aug 2023 19:38:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 19:39:27 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 0/4] There are some bugfix for the HNS3 ethernet driver
Date: Mon, 7 Aug 2023 19:34:48 +0800
Message-ID: <20230807113452.474224-1-shaojijie@huawei.com>
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
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are some bugfix for the HNS3 ethernet driver

ChangeLog:
v1->v2:
  delete two patches in this patchset: 
    net: hns3: fix wrong print link down up
    - This patch is being analyzed according to Andrew Lunn's suggestion
    net: hns3: fix side effects passed to min_t()
    - This patch is unnecessary suggested by David Laight
  v1: https://lore.kernel.org/all/20230728075840.4022760-2-shaojijie@huawei.com/
 
Jian Shen (1):
  net: hns3: restore user pause configure when disable autoneg

Jie Wang (2):
  net: hns3: refactor hclge_mac_link_status_wait for interface reuse
  net: hns3: add wait until mac link down

Yonglong Liu (1):
  net: hns3: fix deadlock issue when externel_lb and reset are executed
    together

 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 14 ++++++++-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 29 ++++++++++++++-----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |  1 +
 4 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.30.0


