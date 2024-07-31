Return-Path: <netdev+bounces-114480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F272942B24
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CFA1F2172D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E3D1A8C17;
	Wed, 31 Jul 2024 09:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8CF2E62B;
	Wed, 31 Jul 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419305; cv=none; b=uctpPTO9C0XkqosptLX1iQd4yv/OHllv0EkcCOWjYoOhcGCBRU/VOpmebj6kWmW1a2Pkf12FFX/AlfohDMm7FzBWBwX5AujcJC/M8/6lOf7FQVYookg4W70wD2qoc0lDRG/IMngUlSn3Qc1iFydxkm7aTSCOH6nYIcAeh67bTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419305; c=relaxed/simple;
	bh=iigdZH/jmo5WiWyxX6sqwboFWbK322vv9UOY8VwbH+M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZFMnH+cyEKtaUM53M5nT1goGBHWIM/00eGcUeGv2zrclVuLnGV9a9P9sWgEz+Ops7hRJEF8BXP1xbhRBcsZtJmbkBZlI0mMPP8gUUldIYIPkxwDNqj6I0p1a1HcLrIrrmwLKxMcb/a1cYwpDrwvqYfyb/d/YpuIS2qrHVizYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WYnGp1XpGz1j6ML;
	Wed, 31 Jul 2024 17:43:46 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id E705F1A0188;
	Wed, 31 Jul 2024 17:48:19 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 17:48:19 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH net-next 00/10] Add support of HIBMCGE Ethernet Driver
Date: Wed, 31 Jul 2024 17:42:35 +0800
Message-ID: <20240731094245.1967834-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)

This patch set adds the support of Hisilicon BMC Gigabit Ethernet Driver.

This patch set includes basic Rx/Tx functionality. It also includes
the registration and interrupt codes.

This work provides the initial support to the HIBMCGE and
would incrementally add features or enhancements.

Jijie Shao (10):
  net: hibmcge: Add pci table supported in this module
  net: hibmcge: Add read/write registers supported through the bar space
  net: hibmcge: Add mdio and hardware configuration supported in this
    module
  net: hibmcge: Add interrupt supported in this module
  net: hibmcge: Implement some .ndo functions
  net: hibmcge: Implement .ndo_start_xmit function
  net: hibmcge: Implement rx_poll function to receive packets
  net: hibmcge: Implement workqueue and some ethtool_ops functions
  net: hibmcge: Add a Makefile and update Kconfig for hibmcge
  net: hibmcge: Add maintainer for hibmcge

 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/hisilicon/Kconfig        |  17 +-
 drivers/net/ethernet/hisilicon/Makefile       |   1 +
 .../net/ethernet/hisilicon/hibmcge/Makefile   |  10 +
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 152 +++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  |  56 +++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h  |  11 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 369 ++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  78 ++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 205 +++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.h  |  13 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 362 ++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.h |  14 +
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 276 ++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |  13 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 115 +++++
 .../hisilicon/hibmcge/hbg_reg_union.h         | 266 ++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 410 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.h |  37 ++
 19 files changed, 2411 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/Makefile
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h

-- 
2.33.0


