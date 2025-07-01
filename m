Return-Path: <netdev+bounces-202901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A167AEF991
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994F13AB392
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A8274671;
	Tue,  1 Jul 2025 13:01:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC714A60C;
	Tue,  1 Jul 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374904; cv=none; b=pKJpfXMqFddvGKvL/FUDMmd6MQz5th8nEvCOyy1lMwXDCrxWq2CcUAkHiOXEo3FR4WuG1kRXTtqNDXxwNs6wz2YQsqvrs+F4QYwpPrv87EIDU1KKcsMacr+4BFqm/jx0l5zh1bI2yl3/Jf3Z2kJE1uvW8SkhyWGFQiA/Kiuv8vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374904; c=relaxed/simple;
	bh=LA2ArV5iKjCvKVcMwoIx6D3lwI8PFzt6jo7T774jI/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hzsQKR88k8SrJlFZBh7D7i23L1FVUIwlVUNgK/0E9/SNiQVV1g1bK6L5ahL6+8M9cZPixDe5WNIH58/UAWxXWeTvGFxBqYuGqU3/13iEKHrm4OG6IdZSImDQCJjK3kIJmVke8UhPNQQaqX6OiH5NdO1oMoMpwdMvr/HZehlCzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bWjj72lPrz14Lnv;
	Tue,  1 Jul 2025 20:56:59 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 738481800B1;
	Tue,  1 Jul 2025 21:01:39 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 21:01:38 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH v4 net-next 0/3] Support some features for the HIBMCGE driver
Date: Tue, 1 Jul 2025 20:54:43 +0800
Message-ID: <20250701125446.720176-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Support some features for the HIBMCGE driver

---
ChangeLog:
v3 -> v4:
  - Fix git log syntax issues, suggested by Larysa Zaremba
  v3: https://lore.kernel.org/all/20250626020613.637949-1-shaojijie@huawei.com/
v2 -> v3:
  - Use fixed_phy to re-implement the no-phy scenario, suggested by Andrew Lunn
  v2: https://lore.kernel.org/all/20250623034129.838246-1-shaojijie@huawei.com/
v1 -> v2:
  - Fix code formatting errors, reported by Jakub Kicinski
  v1: https://lore.kernel.org/all/20250619144423.2661528-1-shaojijie@huawei.com/
---

Jijie Shao (3):
  net: hibmcge: support scenario without PHY
  net: hibmcge: adjust the burst len configuration of the MAC controller
    to improve TX performance.
  net: hibmcge: configure FIFO thresholds according to the MAC
    controller documentation

 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 57 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 38 +++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  8 +++
 3 files changed, 103 insertions(+)

-- 
2.33.0


