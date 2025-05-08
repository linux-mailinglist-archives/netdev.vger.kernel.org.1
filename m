Return-Path: <netdev+bounces-188906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B98FAAF4CF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421581C0278A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 07:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347922068A;
	Thu,  8 May 2025 07:39:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC01DDC23;
	Thu,  8 May 2025 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689970; cv=none; b=FONHadyob53xKuHjiLjGyRpYAleUp9gbTdHdmefpGdB/TXzWQpFpaYzkHorHbYzlrGBAJ7mpmk5/DPdBfxOWIRydWFRDns++Wa/WG3KWiHzkkHz9vn0lErNuCDekTYxQfriizX84f+yxrU1jYaLo9RjSkL27pa0abMFdDfJ0qcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689970; c=relaxed/simple;
	bh=iwshjshchRv7Y/2BDCydnzDw5INFJq1LJCEHROTNVX8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O3jPBnsZOAHaKaGhfbHcuNWxZeerbtrlMj6fGARCl2tz2j3s1g408Ib1xLj4xknFBdfEfWVa+lNJybMiaGHlGWwLkTbjm4IB1JnyxZBj/6l+c5m2XL6UVpuOXf1Lmi2X1TiZReFvk58AK7P7ctJcGtNwvu+fiYTosLj4f6hLv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZtP8k17Lhz6H6mv;
	Thu,  8 May 2025 15:36:54 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id B55FC1402C8;
	Thu,  8 May 2025 15:39:23 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 8 May
 2025 09:39:12 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>, Fan Gong <gongfan1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh
	<sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Joe
 Damato <jdamato@fastly.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v14 0/1] net: hinic3: Add a driver for Huawei 3rd gen NIC
Date: Thu, 8 May 2025 10:56:46 +0300
Message-ID: <cover.1746689795.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)

This is the 1/3 patch of the patch-set described below.

The patch-set contains driver for Huawei's 3rd generation HiNIC
Ethernet device that will be available in the future.

This is an SRIOV device, designed for data centers.
Initially, the driver only supports VFs.

Following the discussion over RFC01, the code will be submitted in
separate smaller patches where until the last patch the driver is
non-functional. The RFC02 submission contains overall view of the entire
driver but every patch will be posted as a standalone submission.

Changes:

RFC V01: https://lore.kernel.org/netdev/cover.1730290527.git.gur.stavi@huawei.com

RFC V02: https://lore.kernel.org/netdev/cover.1733990727.git.gur.stavi@huawei.com
* Reduce overall line of code by removing optional functionality.
* Break down into smaller patches.

PATCH 01 V01: https://lore.kernel.org/netdev/cover.1734599672.git.gur.stavi@huawei.com
* Documentation style and consistency fixes (from Bjorn Helgaas)
* Use ipoll instead of custom code (from Andrew Lunn)
* Move dev_set_drvdata up in initialization order (from Andrew Lunn)
* Use netdev's max_mtu, min_mtu (from Andrew Lunn)
* Fix variable 'xxx' set but not used warnings (from Linux patchwork)

PATCH 01 V02: https://lore.kernel.org/netdev/cover.1735206602.git.gur.stavi@huawei.com
* Add comment regarding usage of random MAC. (Andrew Lunn)
* Add COMPILE_TEST to Kconfig (Jakub Kicinski)

PATCH 01 V03: https://lore.kernel.org/netdev/cover.1735735608.git.gur.stavi@huawei.com
* Rephrase Kconfig comment (Jakub Kicinski)
* Kconfig: add 'select AUXILIARY_BUS' (Kernel test robot)
* ARCH=um: missing include 'net/ip6_checksum.h' (Kernel test robot)

PATCH 01 V04: https://lore.kernel.org/netdev/cover.1737013558.git.gur.stavi@huawei.com
* Improve naming consistency, missing hinic3 prefixes (Suman Ghosh)
* Change hinic3_remove_func to void (Suman Ghosh)
* Add adev_event_unregister (Suman Ghosh)
* Add comment for service types enum (Suman Ghosh)

PATCH 01 V05: https://lore.kernel.org/netdev/cover.1740312670.git.gur.stavi@huawei.com
* Fix signed-by signatures (Przemek Kitszel)
* Expand initials in documentation (Przemek Kitszel)
* Update copyright messages to 2025 (Przemek Kitszel)
* Sort filenames in makefile (Przemek Kitszel)
* Sort include statements (Przemek Kitszel)
* Reduce padding in irq allocation struct (Przemek Kitszel)
* Replace memset of zero with '= {}' init (Przemek Kitszel)
* Revise mbox API to avoid using same pointer twice (Przemek Kitszel)
* Use 2 underscores for header file ifdef guards (Przemek Kitszel)
* Remove 'Intelligent' from Kconfig (Przemek Kitszel)
* Documentation, fix line length mismatch to header (Simon Horman)

PATCH 01 V06: https://lore.kernel.org/netdev/cover.1740487707.git.gur.stavi@huawei.com
* Add hinic3 doc to device_drivers/ethernet TOC (Jakub Kicinski)

PATCH 01 V07: https://lore.kernel.org/netdev/cover.1741069877.git.gur.stavi@huawei.com
* Remove unneeded conversion to bool (Jakub Kicinski)
* Use net_prefetch and net_prefetchw (Joe Damato)
* Push IRQ coalescing and rss alloc/free to later patch (Joe Damato)
* Pull additional rx/tx/napi code from next patch (Joe Damato)

PATCH 01 V08: https://lore.kernel.org/netdev/cover.1741247008.git.gur.stavi@huawei.com
* Fix build warning following pulling napi code from later patch (patchwork)
* Add missing net/gro.h include for napi_gro_flush (patchwork)

PATCH 01 V09: https://lore.kernel.org/netdev/cover.1742202778.git.gur.stavi@huawei.com
* Maintain non-error paths in the main flow (Simon Horman)
* Rename Pcie to PCIe in debug messages (Simon Horman)
* Remove do-nothing goto label (Simon Horman)
* Remove needless override of error value (Simon Horman)

PATCH 01 V10: https://lore.kernel.org/netdev/cover.1744286279.git.gur.stavi@huawei.com
* Poll Tx before polling Rx (Jakub Kicinski)
* Use napi_complete_done instead of napi_complete (Jakub Kicinski)
* Additional napi conformance fixes.
* Rename goto labels according to target rather than source (Jakub Kicinski)
* Call netif_carrier_off before register_netdev (Jakub Kicinski)

PATCH 01 V11: https://lore.kernel.org/netdev/cover.1745221384.git.gur.stavi@huawei.com
* Delete useless fallback to 32 bit DMA (Jakub Kicinski)

PATCH 01 V12: https://lore.kernel.org/netdev/cover.1745411775.git.gur.stavi@huawei.com
* Remove unneeded trailing coma (Christophe JAILLET)
* Use kcalloc for array allocations (Christophe JAILLET)
* Use existing goto label, avoid duplicating code (Christophe JAILLET)

PATCH 01 V13: https://lore.kernel.org/netdev/cover.1746519748.git.gur.stavi@huawei.com
* Use page_pool for rx buffers (Jakub Kicinski)
* Wrap lines at 80 chars (Jakub Kicinski)
* Consistency: rename buff to buf
* Remove unneeded numeric suffixes: UL, ULL, etc.

PATCH 01 V14:
* Use proper api for rx frag allocation (Jakub Kicinski)
* Use napi_alloc_skb instead of netdev_alloc_skb_ip_align (Jakub Kicinski)

Fan Gong (1):
  hinic3: module initialization and tx/rx logic

 .../device_drivers/ethernet/huawei/hinic3.rst | 137 ++++
 .../device_drivers/ethernet/index.rst         |   1 +
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/huawei/Kconfig           |   1 +
 drivers/net/ethernet/huawei/Makefile          |   1 +
 drivers/net/ethernet/huawei/hinic3/Kconfig    |  20 +
 drivers/net/ethernet/huawei/hinic3/Makefile   |  21 +
 .../ethernet/huawei/hinic3/hinic3_common.c    |  53 ++
 .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  25 +
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  53 ++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  32 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 113 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  24 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  81 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  58 ++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  53 ++
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   | 414 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_lld.h   |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 357 +++++++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  16 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |  15 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  13 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 105 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         |  78 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 233 ++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  41 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  89 +++
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  21 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    | 120 ++++
 .../huawei/hinic3/hinic3_queue_common.c       |  68 ++
 .../huawei/hinic3/hinic3_queue_common.h       |  54 ++
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 341 +++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  90 +++
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 678 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 131 ++++
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    |  29 +
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  76 ++
 40 files changed, 3731 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
 create mode 100644 drivers/net/ethernet/huawei/hinic3/Kconfig
 create mode 100644 drivers/net/ethernet/huawei/hinic3/Makefile
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_common.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_common.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_lld.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_main.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_wq.h


base-commit: 836b313a14a316290886dcc2ce7e78bf5ecc8658
-- 
2.45.2


