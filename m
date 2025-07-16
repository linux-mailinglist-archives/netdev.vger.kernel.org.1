Return-Path: <netdev+bounces-207429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0DB072AD
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E66177C15
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A62F3C00;
	Wed, 16 Jul 2025 10:07:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F642F365E;
	Wed, 16 Jul 2025 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660475; cv=none; b=t5xq52Idho7gP3n6AlgATnaRltpjoAI86q42IBE9eimo7APH2OU/tYPQW8ppECTHkgu404G5BGtW6Z+kgLmvPRTx/37HOB2GgjjmsWJrtobMkmDHX+NLelAo2V8ULIsb1dlUeYKEXqqHZWtslDrQFD09eZl47l/erXO2QX6azsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660475; c=relaxed/simple;
	bh=wtCtfoLOKLhSrGkFybhLu5kAKltwZN4Sl2YTS75EJMs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d5MZuWCwiRRR4G105ruZoulithIuh1OAi63pqfxyIoAEHp13DBzFgJHnDc/lT2dX3WjAkwPqddvF3PUqUjWyy9tjeBhj/SCndxfT72kVhIa5r5mMPjPV6wHG7KkmPQhFDnLAflQqyLPviq0t4h5rZZAlEMuDp6zSuP5c47Swmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bhs7P6LM7z14LxW;
	Wed, 16 Jul 2025 18:02:57 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A00EA180466;
	Wed, 16 Jul 2025 18:07:44 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Jul 2025 18:07:43 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 0/2] net: hibmcge: Add support for PHY LEDs on YT8521
Date: Wed, 16 Jul 2025 18:00:39 +0800
Message-ID: <20250716100041.2833168-1-shaojijie@huawei.com>
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

net: hibmcge: Add support for PHY LEDs on YT8521

Jijie Shao (2):
  net: phy: motorcomm: Add support for PHY LEDs on YT8521
  net: hibmcge: Add support for PHY LEDs on YT8521

 drivers/net/ethernet/hisilicon/Kconfig        |   8 ++
 .../net/ethernet/hisilicon/hibmcge/Makefile   |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_led.c  | 132 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_led.h  |  17 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   7 +
 drivers/net/phy/motorcomm.c                   | 120 ++++++++++++++++
 6 files changed, 285 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_led.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_led.h

-- 
2.33.0


