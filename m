Return-Path: <netdev+bounces-152204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CE59F3182
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9626E1886120
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F2204F9D;
	Mon, 16 Dec 2024 13:30:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E53FD4;
	Mon, 16 Dec 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355855; cv=none; b=Z426o2yH9a9rjIyLibQzO80unVoWE/+x+9nRLfWTJkS/4onVO4XqnvjXKRoZqJazEKb/ozqE1QDF0bEU0+1gytLUBWSUmmnMSsA+1pWreYhNdKXT0Bu64vJ4jgvJBXZJYPp1Qao+BcvyZsouf59CBH7uFWtbLRcaMl55XQBXtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355855; c=relaxed/simple;
	bh=zhHngj4Pi5/YkHSEUwNIJqChG7QvJm/9H+bn4MeBShs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eyd3hGF5WhbS8ySSxahZH0GKS5LNyFReAI2ICIdsNz+u8GeWb6KDRgYbS0DQTTHGlEvvoXn9VOM1SoYuz9VEFxb59OpCai6hY4zuzp2RA/HwZHiwPBWaGWUfBpQZQEQrdc1j6ET8BU7JeWKvofNlO2/1emBAd7HD4Mv8k/WKb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YBgk92ljDz1kw5r;
	Mon, 16 Dec 2024 21:28:17 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CBB7140156;
	Mon, 16 Dec 2024 21:30:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Dec 2024 21:30:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net 0/7] There are some bugfix for the HNS3 ethernet driver
Date: Mon, 16 Dec 2024 21:23:39 +0800
Message-ID: <20241216132346.1197079-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There's a series of bugfix that's been accepted:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=d80a3091308491455b6501b1c4b68698c4a7cd24

However, The series is making the driver poke into IOMMU internals instead of
implementing appropriate IOMMU workarounds. After discussion, the series was reverted:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=249cfa318fb1b77eb726c2ff4f74c9685f04e568

But only two patches are related to the IOMMU.
Other patches involve only the modification of the driver.
This series resends other patches.

---
ChangeLog:
v1 -> v2:
  - Fix a data inconsistency issue caused by simultaneous access of multiple readers,
    suggested by Jakub.
  v1: https://lore.kernel.org/all/20241107133023.3813095-1-shaojijie@huawei.com/
---
Hao Lan (4):
  net: hns3: fixed reset failure issues caused by the incorrect reset
    type
  net: hns3: fix missing features due to dev->features configuration too
    early
  net: hns3: Resolved the issue that the debugfs query result is
    inconsistent.
  net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds
    issue

Jian Shen (2):
  net: hns3: don't auto enable misc vector
  net: hns3: initialize reset_timer before hclgevf_misc_irq_init()

Jie Wang (1):
  net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  3 -
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 96 ++++++-------------
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  1 -
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 45 +++++++--
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  3 +
 .../hisilicon/hns3/hns3pf/hclge_regs.c        |  9 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 40 ++++++--
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      |  9 +-
 8 files changed, 113 insertions(+), 93 deletions(-)

-- 
2.33.0


