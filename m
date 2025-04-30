Return-Path: <netdev+bounces-187013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85BAA4765
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8461680F0
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E59523505E;
	Wed, 30 Apr 2025 09:38:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E02A8D0;
	Wed, 30 Apr 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005912; cv=none; b=L1sfx/QfYFhszPsOGNw+OOz31rYd4BN4bixqgs86/R5/lSH8kfH6IypntQCMAfHnjNqAe+QS8i0HIvSncsyNIwvcWcuFGHq2/9rqxpYOz7xB5r/Ns0Ku8KvwYE28J8OLopLwcYWeXxHJpLkweGB0cWPnLJiiiHTmvz55tGQle8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005912; c=relaxed/simple;
	bh=J9MA1CFTkDvQAT6jfH24C7DenJO8AjvSGaQy/5JePO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DK4ZrwFIaBL5qaZLIQbr8ALABYtgIN4XZq8WVJD9wVSyfqPBeuH9k03zffOiYmvIDP2N/S2nh4b8fm9Wh5sTskUbHscGfwjftIwDtTwWzimPTu0WdR4Q06bCHGG9x1YO4MCzj6z80WJv0aL7IAUFJhNFTD1DfPy68l+QUNVonQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZnXDB412Rz2TS2D;
	Wed, 30 Apr 2025 17:38:02 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DAB71A016C;
	Wed, 30 Apr 2025 17:38:28 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Apr 2025 17:38:27 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 0/2] There are some bugfix for hibmcge driver
Date: Wed, 30 Apr 2025 17:31:25 +0800
Message-ID: <20250430093127.2400813-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There are some bugfix for hibmcge driver

Jijie Shao (2):
  net: hibmcge: fix incorrect statistics update issue
  net: hibmcge: fix wrong ndo.open() after reset fail issue.

 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c | 3 +++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c    | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.33.0


