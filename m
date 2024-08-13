Return-Path: <netdev+bounces-118080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E77950758
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FD21C228BC
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F9F19B3DD;
	Tue, 13 Aug 2024 14:16:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8E17A583;
	Tue, 13 Aug 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558608; cv=none; b=FmGFqN1xwOTCjG+pjL2VRkjIpAG7U9UCLT0SNCSgWrC2Tst+QyuAeKlWEWpe7m153sBykyUKR1ntmJIo4vVFnNo+ehaggwFvFAfQuawjDGAawWiPIZ3k9QZnTzv0DZ9YzEmOrEL/Oec8GuosceDEau6c66RwqP344A9YV1ADONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558608; c=relaxed/simple;
	bh=Bf7vbcp9hZN0Q8ioLIpv1rvS6+C5bmt+l7YFAiKaSz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fvGWbeM8FE8MgBTf5FSnovlbongfz1ChyUngiY7qA83ujJWiOjhHShDzu5g2BpVXbhFu8+Z7QzFjL8VUbMJeG+ngZyDWs7ypksXAxJOVxydiLJtP+q8RxujnpUcnPGtXgN+FeLUMn6taefnfTfqdueMF7VkuxJhUHrEaGxYVBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WjtjT3MGhzcd50;
	Tue, 13 Aug 2024 22:16:29 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 72B011400FD;
	Tue, 13 Aug 2024 22:16:43 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 22:16:42 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/5] There are some bugfix for the HNS3 ethernet driver
Date: Tue, 13 Aug 2024 22:10:19 +0800
Message-ID: <20240813141024.1707252-1-shaojijie@huawei.com>
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

Jie Wang (2):
  net: hns3: fix a deadlock problem when config TC during resetting
  net: hns3: fix wrong use of semaphore up

Peiyang Wang (3):
  net: hns3: use the user's cfg after reset
  net: hns3: void array out of bound when loop tnl_num
  net: hns3: use correct release function during uninitialization

 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  3 ++
 .../hisilicon/hns3/hns3pf/hclge_err.c         |  6 ++--
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 30 +++++++++++++------
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  3 ++
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  4 +--
 5 files changed, 32 insertions(+), 14 deletions(-)

-- 
2.33.0


