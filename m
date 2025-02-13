Return-Path: <netdev+bounces-165797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CE2A33685
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C322F1881393
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977DD2063DA;
	Thu, 13 Feb 2025 04:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362BB204F88;
	Thu, 13 Feb 2025 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419400; cv=none; b=LfvplM5cmCknTBwqFDhZrS7BqNodyBYUguigyD3CWdAs+JLBKCc+1bCsK3pdT4EoKRKNL5AWYk8xzdPh2Jo3EWRgOTXIpjTQJOa9DsGPD21Nfk8LFsk4IUd0gOhcHXKKobj2zsrSaDiPgccMy2VGgmhZVlMWzq3iJoiDGSKbMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419400; c=relaxed/simple;
	bh=JAfILeMeL04VzcAXg7ADNIDQVkJerVuvH9Bs20dOfig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vB05S73nY1JMEpeMiCL0xa/TuIPwtmQFczdLCY6G28Z6Toc3jsZDiTiz7QF/V/G9Pu5ptgFLOpJeOOvBH9Jgxhi1Uh5mRyfMVf+puUE4OYTVzwXBjdpZmsGhHaFjBTEI1qlLAjI0GRSVIJ0uZNyGb3SXTfRgqmhNWb/iYma8bb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YthJV5R9Bz1V6g3;
	Thu, 13 Feb 2025 11:59:22 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FC6E140138;
	Thu, 13 Feb 2025 12:03:10 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 12:03:09 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 0/7] Support some enhances features for the HIBMCGE driver
Date: Thu, 13 Feb 2025 11:55:22 +0800
Message-ID: <20250213035529.2402283-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

In this patch set, we mainly implement some enhanced features.
It mainly includes the statistics, self test, diagnosis, and ioctl to
improve fault locating efficiency,
abnormal irq and MAC link exception handling feature
to enhance driver robustness,
and rx checksum offload feature to improve performance 
(tx checksum feature has been implemented).

Jijie Shao (7):
  net: hibmcge: Add dump statistics supported in this module
  net: hibmcge: Add self test supported in this module
  net: hibmcge: Add rx checksum offload supported in this module
  net: hibmcge: Add abnormal irq handling feature in this module
  net: hibmcge: Add mac link exception handling feature in this module
  net: hibmcge: Add BMC diagnose feature in this module
  net: hibmcge: Add ioctl supported in this module

 .../net/ethernet/hisilicon/hibmcge/Makefile   |   2 +-
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 129 +++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |   7 +-
 .../ethernet/hisilicon/hibmcge/hbg_diagnose.c | 348 +++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_diagnose.h |  11 +
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  |  84 +++-
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |   2 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 474 ++++++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h  |   5 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  35 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   3 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  |  55 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 117 +++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c |  23 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |   2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 106 ++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 182 ++++++-
 17 files changed, 1553 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.h

-- 
2.33.0


