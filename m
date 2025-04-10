Return-Path: <netdev+bounces-181233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E24BA84269
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EA09E6051
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C34283CB5;
	Thu, 10 Apr 2025 11:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263920766E;
	Thu, 10 Apr 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286271; cv=none; b=N7AzqVW818/Zg3B2rcnWqr5i43SnCbNVlUfFA1XTUP2Md0stJHZDoM6MDjWZgQA2kzDtcpIb7MOF/IvTNbOZ+cZLsPPDGEmcAByIJqQjosSJZhDuxU0amwfWtqi1gWxL+Vs7niwKBDP8kiLYjc6iWHxDJqtF+opiIKtbvfQPQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286271; c=relaxed/simple;
	bh=tZ/L1lFPR20r47xhtEb1LjsFp1pyGXsMvKeRJbX7D94=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eoupi+T71mnKz6ukiZSHttD2wWzdS1KGS5Yq+H+p9W43UHIpvpcE34XaR2SKC1wab/qddsHnfAv4VbrDjnPD0MuzaDvnqpIqPiLA09YTaF+8+dutRNRcLaFxzY4BbHpR5qcJGWkGahINxofPYwNJIcqjcOtt3ASouTSJzzhpStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZYJBC4Cb8z6K9DV;
	Thu, 10 Apr 2025 19:53:55 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id BDB901400DB;
	Thu, 10 Apr 2025 19:57:45 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Apr
 2025 13:57:33 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>, Fan Gong <gongfan1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Lee Trager
	<lee@trager.us>, <linux-doc@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>, Cai Huoqing
	<cai.huoqing@linux.dev>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Suman Ghosh
	<sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Joe
 Damato <jdamato@fastly.com>
Subject: [PATCH net-next v10 0/1] net: hinic3: Add a driver for Huawei 3rd gen NIC
Date: Thu, 10 Apr 2025 15:15:50 +0300
Message-ID: <cover.1744286279.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

PATCH 01 V10:
* Poll Tx before polling Rx (Jakub Kicinski)
* Use napi_complete_done instead of napi_complete (Jakub Kicinski)
* Additional napi conformance fixes.
* Rename goto labels according to target rather than source (Jakub Kicinski)
* Call netif_carrier_off before register_netdev (Jakub Kicinski)

Fan Gong (1):
  hinic3: module initialization and tx/rx logic

 .../device_drivers/ethernet/huawei/hinic3.rst | 137 ++++
 .../device_drivers/ethernet/index.rst         |   1 +
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/huawei/Kconfig           |   1 +
 drivers/net/ethernet/huawei/Makefile          |   1 +
 drivers/net/ethernet/huawei/hinic3/Kconfig    |  19 +
 drivers/net/ethernet/huawei/hinic3/Makefile   |  21 +
 .../ethernet/huawei/hinic3/hinic3_common.c    |  53 ++
 .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  24 +
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  53 ++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  32 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 113 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  24 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  81 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  58 ++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  53 ++
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   | 416 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_lld.h   |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 358 +++++++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  16 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |  15 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  13 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 105 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         |  77 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 230 ++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  39 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  91 +++
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  21 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    | 118 +++
 .../huawei/hinic3/hinic3_queue_common.c       |  67 ++
 .../huawei/hinic3/hinic3_queue_common.h       |  54 ++
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 404 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  91 +++
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 684 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 131 ++++
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    |  29 +
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  76 ++
 40 files changed, 3795 insertions(+)
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


base-commit: a9843689e2de1a3727d58b4225e4f8664937aefd
-- 
2.45.2


