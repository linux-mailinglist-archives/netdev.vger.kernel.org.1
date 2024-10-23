Return-Path: <netdev+bounces-138254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9BC9ACB8A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA241F22232
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2001B4F31;
	Wed, 23 Oct 2024 13:49:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DDE56A;
	Wed, 23 Oct 2024 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691346; cv=none; b=D82Y7KlQYC5FFh2Nebe8I/5Xu3FMN6TxcXSQsAl/8awJE6rQ0t0c1xOA53wgSvFwZbRyFzsqQaQ2U46KS8KZoAKZPrWcO4K759OLCxV7TaE0Me22AAo22uLWbYAZLLAjgKUoJhWA8VvNg0Ddu/Hrn+B+Axwp7mUQiV5fb3E1CNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691346; c=relaxed/simple;
	bh=/Dl79uYt3FP/aVGky1G7amvnAPx+KC0WUbIWc+Pe9G8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c1mg4R96Eu0j3+NBeZOBVhWOyaMoSnpEOJYETDtltIr3A4PknsSvbe0mQxdLNO7yZ/3J6M+XhcCAkhja/Q9gx5xxBkyI3pHTR89mZ3o1UBLj74BVtWZ7/Z9NqfK59IWc2FafRwog+ikEX3R5rU78C8/CzL3QWR2QYmoif6som54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XYVjN10c0z1jvmV;
	Wed, 23 Oct 2024 21:47:36 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 4622E180019;
	Wed, 23 Oct 2024 21:48:59 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 21:48:58 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 0/7] Support some features for the HIBMCGE driver
Date: Wed, 23 Oct 2024 21:42:06 +0800
Message-ID: <20241023134213.3359092-1-shaojijie@huawei.com>
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
 kwepemm000007.china.huawei.com (7.193.23.189)

In this patch series, The HIBMCGE driver implements some functions
such as statistics query, dump register, unicast MAC address filtering,
debugfs and reset.

Jijie Shao (7):
  net: hibmcge: Add dump statistics supported in this module
  net: hibmcge: Add debugfs supported in this module
  net: hibmcge: Add unicast frame filter supported in this module
  net: hibmcge: Add register dump supported in this module
  net: hibmcge: Add pauseparam supported in this module
  net: hibmcge: Add nway_reset supported in this module
  net: hibmcge: Add reset supported in this module

 .../net/ethernet/hisilicon/hibmcge/Makefile   |   3 +-
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 135 +++++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  | 190 +++++++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.h  |  12 +
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  | 140 +++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |  13 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 381 ++++++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h  |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  48 ++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   6 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 266 +++++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 136 +++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 171 +++++++-
 13 files changed, 1471 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h

-- 
2.33.0


