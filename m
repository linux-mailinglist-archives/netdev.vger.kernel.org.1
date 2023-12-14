Return-Path: <netdev+bounces-57488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953C18132C0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F56B215C8
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91D59E31;
	Thu, 14 Dec 2023 14:16:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831B7A7;
	Thu, 14 Dec 2023 06:16:08 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SrZ9s5x3kz29g0N;
	Thu, 14 Dec 2023 22:14:57 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 51C0A1A0190;
	Thu, 14 Dec 2023 22:16:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 22:16:05 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <lanhao@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net-next 0/3] There are some features for the HNS3 ethernet driver
Date: Thu, 14 Dec 2023 22:11:32 +0800
Message-ID: <20231214141135.613485-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)

There are some features for the HNS3 ethernet driver

---
changeLog:
v1 -> v2:
  - Delete a patch for ethtool -S to dump page pool statistics, suggested by Jakub Kicinski
  - Delete two patches about CMIS transceiver modules because
    ethtool get_module_eeprom_by_page op is not implemented, suggested by Jakub Kicinski
  v1: https://lore.kernel.org/all/20231211020816.69434-1-shaojijie@huawei.com/
---

Hao Lan (1):
  net: hns3: add command queue trace for hns3

Jijie Shao (1):
  net: hns3: support dump pfc frame statistics in tx timeout log

Peiyang Wang (1):
  net: hns3: dump more reg info based on ras mod

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   6 +
 .../hns3/hns3_common/hclge_comm_cmd.c         |  19 +
 .../hns3/hns3_common/hclge_comm_cmd.h         |  16 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   6 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |   6 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.h     |   3 +
 .../hisilicon/hns3/hns3pf/hclge_err.c         | 434 +++++++++++++++++-
 .../hisilicon/hns3/hns3pf/hclge_err.h         |  36 ++
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  47 ++
 .../hisilicon/hns3/hns3pf/hclge_trace.h       |  94 ++++
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  40 ++
 .../hisilicon/hns3/hns3vf/hclgevf_trace.h     |  50 ++
 12 files changed, 746 insertions(+), 11 deletions(-)

-- 
2.30.0


