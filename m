Return-Path: <netdev+bounces-145854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCC19D12F6
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82670B2B17E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EE81A00EE;
	Mon, 18 Nov 2024 14:20:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A931E871;
	Mon, 18 Nov 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939637; cv=none; b=WB0Ms8kw2IFX2755j24OhZQ0jD6C1e5Vod0WcYKwyyBDAFFRXjHd1lOqrWk3T7qnd11yZNcvaapg4XhwlXZOvNJ0ClzaMW1Ff8ixsENopLgTbsii95ZNP/i7LsPXyqvkwtGMastRuG1AMGJ+4iyHSUuW/xGJ9r4bYw1VDRzsPO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939637; c=relaxed/simple;
	bh=od27YTOLWJwus4fUiXspHE28dQESQbsEE3snxn5gzCE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WKqMxKnp3bfGYYnzf8U2/zC0lVNd0RL3b43P82z+CAWwXqqXKAo7r2+qbUglRWLzGlneH+mPY34/gdfvUKnThhoWzzidMJUPkEcxyZe5iUgvb6FYiNDJID/uL7/QpYa1LBDg8/Dk3+BcCRXyzT6Vg94rv5X2WDa0Kj4tKinKafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XsV963SZMz2GZkv;
	Mon, 18 Nov 2024 22:18:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 13E00140135;
	Mon, 18 Nov 2024 22:20:31 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Nov 2024 22:20:30 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V4 net-next 0/7] Support some features for the HIBMCGE driver
Date: Mon, 18 Nov 2024 22:13:32 +0800
Message-ID: <20241118141339.3224263-1-shaojijie@huawei.com>
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

In this patch series, The HIBMCGE driver implements some functions
such as dump register, unicast MAC address filtering, debugfs and reset.

---
ChangeLog:
v3 -> v4:
  - Support auto-neg pause, suggested by Andrew.
  v3: https://lore.kernel.org/all/20241111145558.1965325-1-shaojijie@huawei.com/
v2 -> v3:
  -  Not not dump in ethtool statistics which can be accessed via standard APIs,
     suggested by Jakub. The relevant patche is removed from this patch series,
     and the statistically relevant patches will be sent separately.
  v2: https://lore.kernel.org/all/20241026115740.633503-1-shaojijie@huawei.com/
v1 -> v2:
  - Remove debugfs file 'dev_specs' because the dump register
    does the same thing, suggested by Andrew.
  - Move 'tx timeout cnt' from debugfs to ethtool -S, suggested by Andrew.
  - Ignore the error code of the debugfs initialization failure, suggested by Andrew.
  - Add a new patch for debugfs file 'irq_info', suggested by Andrew.
  - Add somme comments for filtering, suggested by Andrew.
  - Not pass back ASCII text in dump register, suggested by Andrew.
  v1: https://lore.kernel.org/all/20241023134213.3359092-1-shaojijie@huawei.com/
---

Jijie Shao (7):
  net: hibmcge: Add debugfs supported in this module
  net: hibmcge: Add irq_info file to debugfs
  net: hibmcge: Add unicast frame filter supported in this module
  net: hibmcge: Add register dump supported in this module
  net: hibmcge: Add pauseparam supported in this module
  net: hibmcge: Add reset supported in this module
  net: hibmcge: Add nway_reset supported in this module

 .../net/ethernet/hisilicon/hibmcge/Makefile   |   3 +-
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  28 +++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  | 165 +++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.h  |  12 +
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  | 133 ++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |  13 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 178 ++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  40 ++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   5 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 229 ++++++++++++++++--
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c |  12 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  39 +++
 12 files changed, 829 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h

-- 
2.33.0


