Return-Path: <netdev+bounces-200119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D4AE3416
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 05:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD83A7A6C3A
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 03:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E991D5175;
	Mon, 23 Jun 2025 03:48:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576E1C68A6;
	Mon, 23 Jun 2025 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750650506; cv=none; b=uZWoGxKh0VZxUfjb6aLyXvz7OJlYvYyryfJXVcMphFRtkWdkGJtLJuDW9UHkA/OdGXJYnfKbD3LeEpiThmexkPwfP5xYYXXUht1e7oQk7CurkrHpmzE9op4AIsW29FS302fRGnP/B00CXo4ftJNFFy4jDRNS4so5E1Uk/TCeW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750650506; c=relaxed/simple;
	bh=fcad8TgSJmkQL+qqOmgutlkuTenLrTLLO3Yu2wXy2Dc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eyUEcyITEkh6JB1YzHFPGtXjAWgGr8HdcWwI3Rp+z+qVea47spIEzPhpKsG1NxIhYspNqvPJPsJkVT452c1HTLYCD9MR1JXxIU3CZTDaAaJfw00T8TxkUqHcEfPWDGyg/Hr1S2a+p0DBRcdfsP3zVUdhgkQ8dYX+41x9v398qwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bQYs15kvPz1cyTW;
	Mon, 23 Jun 2025 11:45:57 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6984F14027D;
	Mon, 23 Jun 2025 11:48:15 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 11:48:14 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net-next 0/3] Support some features for the HIBMCGE driver
Date: Mon, 23 Jun 2025 11:41:26 +0800
Message-ID: <20250623034129.838246-1-shaojijie@huawei.com>
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
v1 -> v2:
  - Fix code formatting errors, reported by Jakub Kicinski
  v1: https://lore.kernel.org/all/20250619144423.2661528-1-shaojijie@huawei.com/
---

Jijie Shao (3):
  net: hibmcge: support scenario without PHY.
  net: hibmcge: adjust the burst len configuration of the MAC controller
    to improve TX performance.
  net: hibmcge: configure FIFO thresholds according to the MAC
    controller documentation

 .../ethernet/hisilicon/hibmcge/hbg_diagnose.c |   6 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  |   3 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 100 +++++++++++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  57 ++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  41 ++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c |  76 ++++++++++---
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |   3 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   9 ++
 8 files changed, 274 insertions(+), 21 deletions(-)

-- 
2.33.0


