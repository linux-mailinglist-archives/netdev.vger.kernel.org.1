Return-Path: <netdev+bounces-134284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3843A9989B7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491CA1C24E5E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357041CC172;
	Thu, 10 Oct 2024 14:28:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7A1CB316;
	Thu, 10 Oct 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570510; cv=none; b=r3QUlRiuYugXKkOani3T0C66sWj/QeL83Zwz5QIU5sCiysgxDXlEOfcLRRebLayJE4lYpHmktVvKZy5B0Z81+XKjI8raZmRvztIYL5BzUXY7/oCjVEnJtJgSYcg6MTOpnodrvTKkohOaC7qdYZpohOQA0WAXfQdyLLTssZxuprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570510; c=relaxed/simple;
	bh=WhR7JRhlqDvT6PC+KEKiTIWJ+x448tdFPNQbQJzmnV4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HItg80J87wFE4IFvbpH4Y75GstorEXK85/Kp2clqWZ0V/DOZivZ5M+s2+JHLzzR21esm4bk3Zmg200k53/prTyNJv2/sWKky84qEfP+ttGM8Lh1iGIFf2iP0/X8Ar3iCbFmEJQNiuw24Fz1Qanw3pzsBOIeIyPBv45TmYBdyAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPXBy3t4yzyS3h;
	Thu, 10 Oct 2024 22:27:06 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 175551401E9;
	Thu, 10 Oct 2024 22:28:24 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 22:28:23 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>, <christophe.jaillet@wanadoo.fr>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V12 net-next 00/10] Add support of HIBMCGE Ethernet Driver
Date: Thu, 10 Oct 2024 22:21:29 +0800
Message-ID: <20241010142139.3805375-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)

This patch set adds the support of Hisilicon BMC Gigabit Ethernet Driver.

This patch set includes basic Rx/Tx functionality. It also includes
the registration and interrupt codes.

This work provides the initial support to the HIBMCGE and
would incrementally add features or enhancements.

---
ChangeLog:
v11 -> v12:
  - Fix some warnings detected by checkpatch, suggested by Jakub and Simon Horman.
     ./scripts/checkpatch.pl --strict --codespell --max-line-length=80
  - remove the W entry of hibmcge driver from MAINTAINERS, suggested by Jakub.
  v11: https://lore.kernel.org/all/20241008022358.863393-1-shaojijie@huawei.com/
v10 -> v11:
  - Delete devm_netdev_alloc_pcpu_stats to prevent memory leak,
    suggested by Jakub.
  - Use the same pattern for 'control' and 'ctrl', suggested by Christophe JAILLET.
  - hbg_mdio_init_hw() return void because no error patch,
    suggested by Christophe JAILLET.
  - Fix a syntax error in comment, suggested by Christophe JAILLET.
  - return -EBUSY in ndo.change_mtu if interface is running, suggested by Jakub.
  - Remove unnecessary declares for struct, suggested by Jakub.
  - fix budget to 128 in TX napi.poll(), suggested by Jakub.
  - Not call napi_complete_done() if packet_done >= budget in napi.poll(),
    suggested by Jakub.
  - Use devm_kmalloc() instead of devm_kzalloc() for tx_ring->tout_log_buf,
    suggested by Christophe JAILLET.
  - Not refill the buffers if budget is 0 in RX napi.poll(), suggested by Jakub.
  - Remove "ccflags-y += -I$(src)" from Makefile, suggested by Jakub.
  - Use napi_gro_receive() instead of netif_receive_skb(), suggested by Jakub.
  - Remove ndo.get_stats64() because dev_get_tstats64() do same thing.
  v10: https://lore.kernel.org/all/20240912025127.3912972-1-shaojijie@huawei.com/
v9 -> v10:
  - Drop patch "add ndo_validate_addr check in dev_set_mac_address"
  - Add validation for mac address in hbg_net_set_mac_address()
  - Add "select MOTORCOMM_PHY" and "select REALTEK_PHY" in Kconfig.
  - Use ETH_DATA_LEN instead of HBG_DEFAULT_MTU_SIZE, suggested by Andrew.
  - Delete error description about genphy in commit log, suggested by Andrew.
  v9: https://lore.kernel.org/all/20240910075942.1270054-1-shaojijie@huawei.com/
v8 -> v9:
  - Remove HBG_NIC_STATE_OPEN in ndo.open() and ndo.stop(),
    suggested by Kalesh and Andrew
  v8: https://lore.kernel.org/all/20240909023141.3234567-1-shaojijie@huawei.com/
v7 -> v8:
  - Set netdev->pcpu_stat_type to NETDEV_PCPU_STAT_TSTATS, suggested by Jakub
  v7: https://lore.kernel.org/all/20240905143120.1583460-1-shaojijie@huawei.com/
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

Jijie Shao (10):
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

 MAINTAINERS                                   |   6 +
 drivers/net/ethernet/hisilicon/Kconfig        |  18 +-
 drivers/net/ethernet/hisilicon/Makefile       |   1 +
 .../net/ethernet/hisilicon/hibmcge/Makefile   |   8 +
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 131 ++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  |  17 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h  |  11 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 271 ++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  59 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 127 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.h  |  11 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 253 +++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 222 ++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |  12 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 143 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 409 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.h |  39 ++
 17 files changed, 1737 insertions(+), 1 deletion(-)
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


