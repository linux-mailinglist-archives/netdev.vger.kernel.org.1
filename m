Return-Path: <netdev+bounces-170677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A177A498AD
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E8D1895856
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFD126A0FC;
	Fri, 28 Feb 2025 12:01:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE292512E4;
	Fri, 28 Feb 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744108; cv=none; b=c1F8/7n1cAlf2oX8/IjhtC3iu94aIFUYkH2/0HWPFQdR1lQMS+LCQ0mVwHocMBEVP9c5PqnyeshitTIdcJ1u7uuKYGd6Kg5F98JKqpW4Pz2IGn+lokTV4646jMi0ta380/69aAgsm0/NsAFOo4JdV8jk8x9vKvUBpn0gwzvucLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744108; c=relaxed/simple;
	bh=AIHwwOm+8hG+4+GpvgViwSUl6G4FZjoJ+ZLYoKJYbBU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqHV+KtKBDa32YBdjW5qBOhqfg0737ZEDFeG7hEFgO2mLEr0dXsrnHeqawbL0wqBAA36s8JAMPXiRsP6MIXVoKfqeYWzFQnXcQPB/g2sMmwN7t0mdpZgwmat4Tx68RRziDQVFZ6cARyPq135+8GHcqDmaH8NW6h7yyOjPBZo7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z46BY6jJ9zwXD3;
	Fri, 28 Feb 2025 19:56:53 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 008D31800CD;
	Fri, 28 Feb 2025 20:01:42 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 20:01:41 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
	<shaojijie@huawei.com>
Subject: [PATCH v4 net-next 0/6] Support some enhances features for the HIBMCGE driver
Date: Fri, 28 Feb 2025 19:54:05 +0800
Message-ID: <20250228115411.1750803-1-shaojijie@huawei.com>
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

In this patch set, we mainly implement some enhanced features.
It mainly includes the statistics, diagnosis, and ioctl to
improve fault locating efficiency,
abnormal irq and MAC link exception handling feature
to enhance driver robustness,
and rx checksum offload feature to improve performance 
(tx checksum feature has been implemented).

---
ChangeLog:
v3 -> v4:
  - Don't drop packets on csum validation failure, suggested by Jakub Kicinski.
  - Fix "__umoddi3" undefined error, reported by Jakub Kicinski.
  v3: https://lore.kernel.org/all/20250221115526.1082660-2-shaojijie@huawei.com/
v2 -> v3:
  - Remove "in this module" from all patch titles,
    suggested by Kalesh Anakkur Purayil, Simon Horman and Jakub Kicinski.
  - Remove .ndo_fix_features() suggested by Jakub Kicinski.
  v2: https://lore.kernel.org/all/20250218085829.3172126-1-shaojijie@huawei.com/ 
v1 -> v2:
  - Remove self_test patch from this series, suggested by Andrew.
  - Use phy_do_ioctl() to simplify ioctl code, suggested by Andrew.
  - Replace phy_reset() with phy_stop() and phy_start(), suggested by Andrew.
  - Recalculate the interval for the scheduled task to update statistics,
    suggested by Andrew.
  - Use !! to convert integer to boolean, suggested by Simon Horman.
  v1: https://lore.kernel.org/all/20250213035529.2402283-1-shaojijie@huawei.com/
---

Jijie Shao (6):
  net: hibmcge: Add support for dump statistics
  net: hibmcge: Add support for checksum offload
  net: hibmcge: Add support for abnormal irq handling feature
  net: hibmcge: Add support for mac link exception handling feature
  net: hibmcge: Add support for BMC diagnose feature
  net: hibmcge: Add support for ioctl

 .../net/ethernet/hisilicon/hibmcge/Makefile   |   2 +-
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 122 ++++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |   7 +-
 .../ethernet/hisilicon/hibmcge/hbg_diagnose.c | 348 ++++++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_diagnose.h |  11 +
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  |  58 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |   1 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 298 +++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h  |   5 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  10 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  |  55 +--
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 103 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c |  22 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |   2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 105 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 181 ++++++++-
 16 files changed, 1304 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.h

-- 
2.33.0


