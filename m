Return-Path: <netdev+bounces-22183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37765766655
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D065F282FF6
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9572AC8EA;
	Fri, 28 Jul 2023 08:02:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D62F35
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:02:08 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2559D558B;
	Fri, 28 Jul 2023 01:01:50 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RC0SN1ZhjzrS0g;
	Fri, 28 Jul 2023 16:00:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:01:47 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/6] There are some bugfix for the HNS3 ethernet driver
Date: Fri, 28 Jul 2023 15:58:34 +0800
Message-ID: <20230728075840.4022760-1-shaojijie@huawei.com>
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are some bugfix for the HNS3 ethernet driver

Jian Shen (1):
  net: hns3: restore user pause configure when disable autoneg

Jie Wang (2):
  net: hns3: refactor hclge_mac_link_status_wait for interface reuse
  net: hns3: add wait until mac link down

Peiyang Wang (1):
  net: hns3: fix wrong print link down up

Yonglong Liu (2):
  net: hns3: fix side effects passed to min_t()
  net: hns3: fix deadlock issue when externel_lb and reset are executed
    together

 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 17 ++++++++--
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 32 ++++++++++++++-----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |  1 +
 4 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.30.0


