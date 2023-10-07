Return-Path: <netdev+bounces-38723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF77BC452
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 05:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940F528204B
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 03:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95369CA6C;
	Sat,  7 Oct 2023 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2017D4
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 03:15:39 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6802CBD;
	Fri,  6 Oct 2023 20:15:37 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S2VhW6GX8zVlX2;
	Sat,  7 Oct 2023 11:12:11 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 11:15:34 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net-next 0/2] add vf fault detect support for HNS3 ethernet driver
Date: Sat, 7 Oct 2023 11:12:13 +0800
Message-ID: <20231007031215.1067758-1-shaojijie@huawei.com>
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

add vf fault detect support for HNS3 ethernet driver

Jie Wang (2):
  net: hns3: add hns3 vf fault detect cap bit support
  net: hns3: add vf fault detect support

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   5 +
 .../hns3/hns3_common/hclge_comm_cmd.c         |   1 +
 .../hns3/hns3_common/hclge_comm_cmd.h         |   2 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |   3 +
 .../hisilicon/hns3/hns3pf/hclge_err.c         | 116 +++++++++++++++++-
 .../hisilicon/hns3/hns3pf/hclge_err.h         |   2 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   3 +-
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   2 +
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |   2 +-
 9 files changed, 129 insertions(+), 7 deletions(-)

-- 
2.30.0


