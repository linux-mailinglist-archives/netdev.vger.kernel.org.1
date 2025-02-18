Return-Path: <netdev+bounces-167248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAD6A39676
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8AB188F916
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DC622D782;
	Tue, 18 Feb 2025 09:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F601EB1A6;
	Tue, 18 Feb 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869584; cv=none; b=SW0CpUqI/k9vw5Cmnnq2qfZtEfLNMYZc5b/OtPV8GLM16nVvXUeahJnokPcSfJ92SqJg/rntBHoiyS8089s5Vi0xfa33bH41lpoyBvWcLFaWSQ54/OlE8vLgDsmxjL59DfpJ+zsZLi3CQ8oek6t1mAUc+Z55BrHp3pd0BQZmn50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869584; c=relaxed/simple;
	bh=HW1cKeUppOYj7zZ3UrGYK50X+pAOl67uFRhyYb1lTqc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tvkGOTVTJjyq37ytGqme0naG+QxMXW3Cv/cWYQXnTovnmAGf4gzRDtc6U2oL2MCqtsvuABegNYcMkl3H5fbsbVxrTERBaQlSmohxfk3ewqvxxz8Xia38I/VsWvKG3FhyOY7P47rj672MRqNTr6p5wXKVKJnzLEa2PPQCYFRuo1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yxtnv0DYnzkXTn;
	Tue, 18 Feb 2025 17:02:27 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0329E1800ED;
	Tue, 18 Feb 2025 17:06:06 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 17:06:05 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net-next 0/6] Support some enhances features for the HIBMCGE driver
Date: Tue, 18 Feb 2025 16:58:23 +0800
Message-ID: <20250218085829.3172126-1-shaojijie@huawei.com>
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
  net: hibmcge: Add dump statistics supported in this module
  net: hibmcge: Add rx checksum offload supported in this module
  net: hibmcge: Add abnormal irq handling feature in this module
  net: hibmcge: Add mac link exception handling feature in this module
  net: hibmcge: Add BMC diagnose feature in this module
  net: hibmcge: Add ioctl supported in this module

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
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 110 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c |  20 +
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |   2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 105 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 176 ++++++++-
 16 files changed, 1314 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.h

-- 
2.33.0


