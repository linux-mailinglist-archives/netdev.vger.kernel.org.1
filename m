Return-Path: <netdev+bounces-134536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3499A05F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229232845F8
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6B120FA86;
	Fri, 11 Oct 2024 09:51:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051420FA9F;
	Fri, 11 Oct 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640312; cv=none; b=cRTnn0CGSWImyRt7KSYZN8+BFvzID8AMmz8VYzloIxdcS3T2+zFPmxltIyxHe9IqPveY4rUheGCLK/KF10KgEa9pvia5ibLoenYNcbaTpQfkSegMoptftuwxKOZ4pVgp1LkP88C8G6/R8BBvK8S5eX7eLBzjfy47+jZUsZ/7K+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640312; c=relaxed/simple;
	bh=vW4lb5AP6JnHDHFpP+cLapCaBacyrSVQpxWPMsOux8U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iUtmm3MOhCASxNoqnYLR8G7P8vu9Oc/8X3Wz48kMlji+579NnV9HxHKCA+NO80USCGl7A35MzM3DqvNHrPq27DIRQ1KCozG9goEhCMD08Q6povdfkSLwgTXDX2YWSk+E9QRW//IsHR3PelME/T1w3rr0sKajAyYeTwM31RuBdYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XQ21V5z6Jz1SBR4;
	Fri, 11 Oct 2024 17:50:38 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FE9B1A016C;
	Fri, 11 Oct 2024 17:51:47 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 17:51:46 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/9] There are some bugfix for the HNS3 ethernet driver
Date: Fri, 11 Oct 2024 17:45:12 +0800
Message-ID: <20241011094521.3008298-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)

There are some bugfix for the HNS3 ethernet driver

Hao Lan (4):
  net: hns3: fixed reset failure issues caused by the incorrect reset
    type
  net: hns3: fix missing features due to dev->features configuration too
    early
  net: hns3: Resolved the issue that the debugfs query result is
    inconsistent.
  net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds
    issue

Jian Shen (3):
  net: hns3: add sync command to sync io-pgtable
  net: hns3: don't auto enable misc vector
  net: hns3: initialize reset_timer before hclgevf_misc_irq_init()

Jie Wang (1):
  net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

Peiyang Wang (1):
  net: hns3: default enable tx bounce buffer when smmu enabled

 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  4 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 59 ++++++++++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 +
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 44 +++++++++++---
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  3 +
 .../hisilicon/hns3/hns3pf/hclge_regs.c        |  9 +--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 40 ++++++++++---
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      |  9 +--
 9 files changed, 178 insertions(+), 25 deletions(-)

-- 
2.33.0


