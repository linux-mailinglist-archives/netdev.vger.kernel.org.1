Return-Path: <netdev+bounces-196778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B394FAD6573
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B67E3AC9DA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B51865FA;
	Thu, 12 Jun 2025 02:20:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE563A9;
	Thu, 12 Jun 2025 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694854; cv=none; b=eQ5VApaQIfLsPWmT2Z29DWBbRE1K3smJ+rlaIjfMmsPLbDlskRPPD/ymsX3JnZOoW1D6S0ErBNCoDQ0mPnNMqaf/en3CDZp3GvK+FjW7XsqOUbnk1hbAUDXmopluAtO7ai7UnNO/3Ccbes02/WVXJqYSoQ/S0W73dvOHaUPt07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694854; c=relaxed/simple;
	bh=v+H0NYczBPNYQW/oj1vIVu2DS0mrlIjyYMqtYLQYzoY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bxfWmwqSR6sI8tq/YrwPYSxmiwHjHEGsd1mGVkBkVsKFgv3TPt9G3AHMXWK4Zikp/g9dZGkIJJCeev8jlLp2ySFG/uxGn/PWDK+WfOELrsWWR5LwAt9NEsf2d3Hqsq2dpIGM4cOhIbvUS+yjQToUPhr3ze+Q/bW7qMxQ+8J/hUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bHmNd43Gmz10Wks;
	Thu, 12 Jun 2025 10:16:17 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DF2D0140202;
	Thu, 12 Jun 2025 10:20:48 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Jun 2025 10:20:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 0/8] There are some cleanup for hns3 driver
Date: Thu, 12 Jun 2025 10:13:09 +0800
Message-ID: <20250612021317.1487943-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There are some cleanup for hns3 driver

Jian Shen (1):
  net: hns3: set the freed pointers to NULL when lifetime is not end

Jijie Shao (4):
  net: hns3: fix spelling mistake "reg_um" -> "reg_num"
  net: hns3: add the hns3_get_ae_dev() helper
  net: hns3: add the hns3_get_ops() helper
  net: hns3: add complete parentheses for some macros

Peiyang Wang (2):
  net: hns3: add \n at the end when print msg
  net: hns3: clear hns alarm: comparison of integer expressions of
    different signedness

Yonglong Liu (1):
  net: hns3: delete redundant address before the array

 .../hns3/hns3_common/hclge_comm_cmd.c         |  2 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 12 +--
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 38 +++++-----
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  4 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 75 ++++++++++---------
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 15 ++--
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 38 +++++-----
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_ptp.h         |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  8 +-
 .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 27 +++----
 13 files changed, 121 insertions(+), 111 deletions(-)

-- 
2.33.0


