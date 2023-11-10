Return-Path: <netdev+bounces-47049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A8B7E7B02
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167451C20AEF
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B3B12B95;
	Fri, 10 Nov 2023 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5611CB7
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:42:39 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3982D24C37;
	Fri, 10 Nov 2023 01:42:38 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SRYl43btkztQT9;
	Fri, 10 Nov 2023 17:42:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 17:42:35 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 0/7] There are some bugfix for the HNS3 ethernet driver
Date: Fri, 10 Nov 2023 17:37:06 +0800
Message-ID: <20231110093713.1895949-1-shaojijie@huawei.com>
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
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected

There are some bugfix for the HNS3 ethernet driver

---
ChangeLog:
v1 -> v2:
  - net: hns3: fix add VLAN fail issue, net: hns3: fix VF reset fail issue
    are modified suggested by Paolo
  v1: https://lore.kernel.org/all/20231028025917.314305-1-shaojijie@huawei.com/
---

Jian Shen (2):
  net: hns3: fix add VLAN fail issue
  net: hns3: fix incorrect capability bit display for copper port

Jijie Shao (2):
  net: hns3: fix VF reset fail issue
  net: hns3: fix VF wrong speed and duplex issue

Yonglong Liu (3):
  net: hns3: add barrier in vf mailbox reply process
  net: hns3: fix out-of-bounds access may occur when coalesce info is
    read via debugfs
  net: hns3: fix variable may not initialized problem in
    hns3_init_mac_addr()

 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  9 +++--
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 33 ++++++++++++++-----
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 25 ++++++++++++--
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |  1 +
 .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       |  7 ++++
 6 files changed, 62 insertions(+), 15 deletions(-)

-- 
2.30.0


