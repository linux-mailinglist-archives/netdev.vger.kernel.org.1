Return-Path: <netdev+bounces-168519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EA6A3F399
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E138617953A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3B71EA7C1;
	Fri, 21 Feb 2025 12:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D3F50F;
	Fri, 21 Feb 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139400; cv=none; b=arheOiGh2bMbAI8RcCwL6qQhKHXubrlIWTjsePi+e0kBktpxA5GGKOYnC8ltdgDsWl/iuj7s20VdyYtHw2WOOqQTKavehhdEQ1RMZ3LKfg9EJZf4hcKpEj/m1D+Ih2VOR1jHLepXpo0zIWEk23CxkghGq2PJVuBQHY66nObMkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139400; c=relaxed/simple;
	bh=VDs75fxQ1ceBzoUfdczYidGoMRE/lUva5DBMS7ynSYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nLeiOlaNzMez3oh7CaU2xSV7aTclIdPHdmrH53HyPOfbUaiEAHrtGLX1pY1aF2JFA1Ftdm+3OkrwnKb/QErvQXFr1qXCnvj7N+D8F6GI45YqyBeubDFo1dziBD62ZwvaTLpf0xJCAkU+KJApoqzQTfDIq/v3YN8OVdcc5rWrER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YzpZX5xClz1ltXs;
	Fri, 21 Feb 2025 19:59:16 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 120DF18001B;
	Fri, 21 Feb 2025 20:03:14 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 20:03:13 +0800
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
Subject: [PATCH v3 net-next 0/6] Support some enhances features for the HIBMCGE driver
Date: Fri, 21 Feb 2025 19:55:20 +0800
Message-ID: <20250221115526.1082660-1-shaojijie@huawei.com>
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
  net: hibmcge: Add support for rx checksum offload
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
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  20 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  |  55 +--
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 103 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c |  20 +
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |   2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 105 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 176 ++++++++-
 16 files changed, 1307 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.h

-- 
2.33.0


