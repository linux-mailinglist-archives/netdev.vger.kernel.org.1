Return-Path: <netdev+bounces-55669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A180BEEC
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 03:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0D280C89
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 02:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB5125AB;
	Mon, 11 Dec 2023 02:12:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46609F2;
	Sun, 10 Dec 2023 18:12:39 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SpQHh2tXlzsRs5;
	Mon, 11 Dec 2023 10:12:32 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C96C1800B8;
	Mon, 11 Dec 2023 10:12:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:12:36 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/6] There are some features for the HNS3 ethernet driver
Date: Mon, 11 Dec 2023 10:08:10 +0800
Message-ID: <20231211020816.69434-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

There are some features for the HNS3 ethernet driver

Hao Lan (3):
  net: hns3: add command queue trace for hns3
  net: hns3: Add support for some CMIS transceiver modules
  net: sfp: Synchronize some CMIS transceiver modules from ethtool

Jian Shen (1):
  net: hns3: add support for page_pool_get_stats

Jijie Shao (1):
  net: hns3: support dump pfc frame statistics in tx timeout log

Peiyang Wang (1):
  net: hns3: dump more reg info based on ras mod

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   6 +
 .../hns3/hns3_common/hclge_comm_cmd.c         |  19 +
 .../hns3/hns3_common/hclge_comm_cmd.h         |  16 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  11 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   1 +
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  46 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.h    |   2 +
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |   6 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.h     |   3 +
 .../hisilicon/hns3/hns3pf/hclge_err.c         | 434 +++++++++++++++++-
 .../hisilicon/hns3/hns3pf/hclge_err.h         |  36 ++
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  47 ++
 .../hisilicon/hns3/hns3pf/hclge_trace.h       |  94 ++++
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  40 ++
 .../hisilicon/hns3/hns3vf/hclgevf_trace.h     |  50 ++
 include/linux/sfp.h                           |  12 +
 16 files changed, 811 insertions(+), 12 deletions(-)

-- 
2.30.0


