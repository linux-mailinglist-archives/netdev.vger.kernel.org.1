Return-Path: <netdev+bounces-200123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B6AE342B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1290316F5BC
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC07D1AA1D5;
	Mon, 23 Jun 2025 04:07:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ADEC13B;
	Mon, 23 Jun 2025 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651661; cv=none; b=FKug0XSu7N8c0vRcN6T1P8Yy+XG+ZpJpB/tZnc6AQAN7rStqXMnUCm2wLcGIU96Tk8zucHT53qdvHk5t0rYNdGgCCiNfa+oz0VYx6+sSZQNp9C3Z7lOqUPCiYui3jvbKvtkvsQFhDQHNUQhTX933BNHuswQE8Vev8T4bYJSE7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651661; c=relaxed/simple;
	bh=UIdNVAQoE4i3JnHbIbrPMnN1r1Dd3QV0MY260T0VhzM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0RDLvAagDOrU4tt76CRwOOcEK+iWbiJQC6thJ0LpWKHjil1JpYBOb5M9UGjmJYbd01mv9aaXZ2OvyOp/X7pa6QjHJecq7h1C+4ybInQChRmL7nNz6xzjlMj4iH3EP9Zly1ZVqsmQzmx+hXXFjjEqCHNy6/U/ktEaZ5ahz4m+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bQZJc15CMztS0f;
	Mon, 23 Jun 2025 12:06:24 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A09E71401E9;
	Mon, 23 Jun 2025 12:07:33 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 12:07:32 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net-next 0/7]There are some cleanup for hns3 driver
Date: Mon, 23 Jun 2025 12:00:36 +0800
Message-ID: <20250623040043.857782-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There are some cleanup for hns3 driver

---
ChangeLog:
v3 -> v4:
  - Drop the patch about pointer set to NULL operation, suggested by Jakub Kicinski
  v3: https://lore.kernel.org/all/20250621083310.52c8e7ae@kernel.org/
v2 -> v3:
  - Remove unnecessary pointer set to NULL operation, suggested by Simon Horman.
  v2: https://lore.kernel.org/all/20250617010255.1183069-1-shaojijie@huawei.com/
v1 -> v2:
  - Change commit message and title, suggested by Michal Swiatkowski.
  v1: https://lore.kernel.org/all/20250612021317.1487943-1-shaojijie@huawei.com/
---

Jian Shen (1):
  net: hns3: set the freed pointers to NULL when lifetime is not end

Jijie Shao (4):
  net: hns3: fix spelling mistake "reg_um" -> "reg_num"
  net: hns3: use hns3_get_ae_dev() helper to reduce the unnecessary
    middle layer conversion
  net: hns3: use hns3_get_ops() helper to reduce the unnecessary middle
    layer conversion
  net: hns3: add complete parentheses for some macros

Peiyang Wang (2):
  net: hns3: add \n at the end when print msg
  net: hns3: clear hns alarm: comparison of integer expressions of
    different signedness

Yonglong Liu (1):
  net: hns3: delete redundant address before the array

 .../hns3/hns3_common/hclge_comm_cmd.c         |  2 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 10 +--
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 38 +++++-----
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  4 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 74 +++++++++----------
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 15 ++--
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 34 ++++-----
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_ptp.h         |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  4 +-
 .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 27 +++----
 13 files changed, 111 insertions(+), 110 deletions(-)

-- 
2.33.0


