Return-Path: <netdev+bounces-125571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A2A96DBFB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B250BB20EB6
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA717C9B;
	Thu,  5 Sep 2024 14:37:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10CD17557;
	Thu,  5 Sep 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547041; cv=none; b=LOUK0o8s1+1jTwCp6xrcVoQEbq4vEOM/nMkgXE6zC8h4+iSyBdfz3SnbaHwEQiOZuiQb3dtOoZa839Vtb4h3nfe2pLS8MVVkeDFO/kwQNPD/fONANQZPKvSYKufWZwCTtgnMGWlZlss9z1zncD/8o49uyFK3wGw9piHUJyces8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547041; c=relaxed/simple;
	bh=k/QU0CcyD79/nK/+rX6MONDshlt9AIogk8ZQxoRBEtk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I/jkM6MhigwHk+kO+o6MbtbwTeI/cUI1wWgLc0W7owBltcNjcmvAIakCcWsxbKHJUVVu1R/Un/xw7KGSxmcf3kozhAsMY9AgrLohzuPeuQjkYw5SbV2gpqEbmV1Au8amPLfGGZWwbKlyH/vhFhArwtLh/EZB0SSW6cfOHLZmezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X022S30pNz1xwv2;
	Thu,  5 Sep 2024 22:35:12 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id AB7B71400D2;
	Thu,  5 Sep 2024 22:37:13 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 22:37:12 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <shaojijie@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <zhuyuan@huawei.com>, <forest.zhouchang@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V7 net-next 00/11] Add support of HIBMCGE Ethernet Driver
Date: Thu, 5 Sep 2024 22:31:09 +0800
Message-ID: <20240905143120.1583460-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)

This patch set adds the support of Hisilicon BMC Gigabit Ethernet Driver.

This patch set includes basic Rx/Tx functionality. It also includes
the registration and interrupt codes.

This work provides the initial support to the HIBMCGE and
would incrementally add features or enhancements.

---
ChangeLog:
v6 -> v7:
  - Move the define inside the function body to the top of the .c file,
    suggested by Paolo and Andrew.
  - Respect the reverse x-mas tree order, suggested by Paolo.
  - Add check for netif_txq_maybe_stop(), suggested by Paolo.
  - Use dev_sw_netstats_tx_add() instead of dev->stats, suggested by Paolo.
  - Modify net_dev to netdev, suggested by Paolo.
  v6: https://lore.kernel.org/all/20240830121604.2250904-12-shaojijie@huawei.com/
v5 -> v6:
  - Delete netif_carrier_off() in .ndo_open() and .ndo_stop(),
    suggested by Jakub and Andrew.
  - Remove hbg_txrx_init() from probe path, alloc ring buffer in .ndo_open(),
    and release ring buffer in .ndo_stop(), suggested by Jakub and Andrew.
  v5: https://lore.kernel.org/all/20240827131455.2919051-1-shaojijie@huawei.com/
v4 -> v5:
  - Delete unnecessary semicolon, suggested by Jakub.
  v4: https://lore.kernel.org/all/20240826081258.1881385-1-shaojijie@huawei.com/
v3 -> v4:
  - Delete INITED_STATE in priv, suggested by Andrew.
  - Delete unnecessary defensive code in hbg_phy_start()
    and hbg_phy_stop(), suggested by Andrew.
  v3: https://lore.kernel.org/all/20240822093334.1687011-1-shaojijie@huawei.com/
v2 -> v3:
  - Add "select PHYLIB" in Kconfig, reported by Jakub.
  - Use ndo_validate_addr() instead of is_valid_ether_addr()
    in dev_set_mac_address(), suggested by Jakub and Andrew.
  v2: https://lore.kernel.org/all/20240820140154.137876-1-shaojijie@huawei.com/
v1 -> v2:
  - fix build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202408192219.zrGff7n1-lkp@intel.com/
    Closes: https://lore.kernel.org/oe-kbuild-all/202408200026.q20EuSHC-lkp@intel.com/
  v1: https://lore.kernel.org/all/20240819071229.2489506-1-shaojijie@huawei.com/
RFC v2 -> v1:
  - Use FIELD_PREP/FIELD_GET instead of union, suggested by Andrew.
  - Delete unnecessary defensive code, suggested by Andrew.
  - A few other minor changes.
  RFC v2: https://lore.kernel.org/all/20240813135640.1694993-1-shaojijie@huawei.com/
RFC v1 -> RFC v2:
  - Replace linkmode_copy() with phy_remove_link_mode() to
    simplify the PHY configuration process, suggested by Andrew.
  - Delete hbg_get_link_status() from the scheduled task, suggested by Andrew.
  - Delete validation for mtu in hbg_net_change_mtu(), suggested by Andrew.
  - Delete validation for mac address in hbg_net_set_mac_address(),
    suggested by Andrew.
  - Use napi_complete_done() to simplify the process, suggested by Joe Damato.
  - Use ethtool_op_get_link(), phy_ethtool_get_link_ksettings(),
    and phy_ethtool_set_link_ksettings() to simplify the code, suggested by Andrew.
  - Add the check on the return value of phy_connect_direct(),
    suggested by Jonathan.
  - Adjusted the layout to place the fields and register definitions
    in one place, suggested by Jonathan.
  - Replace request_irq with devm_request_irq, suggested by Jonathan.
  - Replace BIT_MASK() with BIT(), suggested by Jonathan.
  - Introduce irq_handle in struct hbg_irq_info in advance to reduce code changes,
    suggested by Jonathan.
  - Delete workqueue for this patch set, suggested by Jonathan.
  - Support to compile this driver on all arch in Kconfig,
    suggested by Andrew and Jonathan.
  - Add a patch to add is_valid_ether_addr check in dev_set_mac_address,
    suggested by Andrew.
  - A few other minor changes.
  RFC v1: https://lore.kernel.org/all/20240731094245.1967834-1-shaojijie@huawei.com/
---

Jijie Shao (11):
  net: hibmcge: Add pci table supported in this module
  net: hibmcge: Add read/write registers supported through the bar space
  net: hibmcge: Add mdio and hardware configuration supported in this
    module
  net: hibmcge: Add interrupt supported in this module
  net: hibmcge: Implement some .ndo functions
  net: hibmcge: Implement .ndo_start_xmit function
  net: hibmcge: Implement rx_poll function to receive packets
  net: hibmcge: Implement some ethtool_ops functions
  net: hibmcge: Add a Makefile and update Kconfig for hibmcge
  net: hibmcge: Add maintainer for hibmcge
  net: add ndo_validate_addr check in dev_set_mac_address

 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/hisilicon/Kconfig        |  16 +-
 drivers/net/ethernet/hisilicon/Makefile       |   1 +
 .../net/ethernet/hisilicon/hibmcge/Makefile   |  10 +
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 137 ++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  |  17 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h  |  11 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 279 ++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  59 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 125 +++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.h  |  11 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 270 +++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 244 ++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |  12 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 143 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 430 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.h |  37 ++
 net/core/dev.c                                |   5 +
 18 files changed, 1813 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/Makefile
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h

-- 
2.33.0


