Return-Path: <netdev+bounces-215174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B001B2D740
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 10:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C013A328C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296402D9EC8;
	Wed, 20 Aug 2025 08:55:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C842D979D;
	Wed, 20 Aug 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680149; cv=none; b=KY6tuzV+UgBKU0qi/CHCyl55pSAFRtmA+BrQtJK5QQU7RLkctREzWtI7aJ5+WMsQ3GLd4xgmd8JWTYrKyLDCx68LWo75yC6YslCfZCxZ2C9VKBXxHDTE2ZOU9AdBPOXwYmHgv+Id+ZIGOEtUwXUNEUaipPSibS1av8G058x9FHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680149; c=relaxed/simple;
	bh=JawRw6V0WE4zzIbEjLXD4IPWN4IGVqPMhskTv3U5c8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fe9y1kCmBGO7qtK9S9GZcXZmNbx4XqppZTCKUsPtm384NTHGqcscDA7Hr4Cx5TUQMhhWShg51UnGsaF1+QfwPWnKYbTIgzKsj3WB/Wb19g+LIFBxYY5iSmTDbEcc4HjAYRSTmFsQvUqGZT0dhQDqjfRTZ+z0toz8wXLn+OCth1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c6KwQ0tWkz2Dc4f;
	Wed, 20 Aug 2025 16:52:54 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id B1E4E1A0188;
	Wed, 20 Aug 2025 16:55:42 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 16:55:41 +0800
From: Fan Gong <gongfan1@huawei.com>
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
Subject: [PATCH net-next v14 0/1] net: hinic3: Add a driver for Huawei 3rd gen  NIC
Date: Wed, 20 Aug 2025 16:55:25 +0800
Message-ID: <cover.1746689795.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

From: Gur Stavi <gur.stavi@huawei.com>=0D

This is the 1/3 patch of the patch-set described below.=0D
=0D
The patch-set contains driver for Huawei's 3rd generation HiNIC=0D
Ethernet device that will be available in the future.=0D
=0D
This is an SRIOV device, designed for data centers.=0D
Initially, the driver only supports VFs.=0D
=0D
Following the discussion over RFC01, the code will be submitted in=0D
separate smaller patches where until the last patch the driver is=0D
non-functional. The RFC02 submission contains overall view of the entire=0D
driver but every patch will be posted as a standalone submission.=0D
=0D
Changes:=0D
=0D
RFC V01: https://lore.kernel.org/netdev/cover.1730290527.git.gur.stavi@huaw=
ei.com=0D
=0D
RFC V02: https://lore.kernel.org/netdev/cover.1733990727.git.gur.stavi@huaw=
ei.com=0D
* Reduce overall line of code by removing optional functionality.=0D
* Break down into smaller patches.=0D
=0D
PATCH 01 V01: https://lore.kernel.org/netdev/cover.1734599672.git.gur.stavi=
@huawei.com=0D
* Documentation style and consistency fixes (from Bjorn Helgaas)=0D
* Use ipoll instead of custom code (from Andrew Lunn)=0D
* Move dev_set_drvdata up in initialization order (from Andrew Lunn)=0D
* Use netdev's max_mtu, min_mtu (from Andrew Lunn)=0D
* Fix variable 'xxx' set but not used warnings (from Linux patchwork)=0D
=0D
PATCH 01 V02: https://lore.kernel.org/netdev/cover.1735206602.git.gur.stavi=
@huawei.com=0D
* Add comment regarding usage of random MAC. (Andrew Lunn)=0D
* Add COMPILE_TEST to Kconfig (Jakub Kicinski)=0D
=0D
PATCH 01 V03: https://lore.kernel.org/netdev/cover.1735735608.git.gur.stavi=
@huawei.com=0D
* Rephrase Kconfig comment (Jakub Kicinski)=0D
* Kconfig: add 'select AUXILIARY_BUS' (Kernel test robot)=0D
* ARCH=3Dum: missing include 'net/ip6_checksum.h' (Kernel test robot)=0D
=0D
PATCH 01 V04: https://lore.kernel.org/netdev/cover.1737013558.git.gur.stavi=
@huawei.com=0D
* Improve naming consistency, missing hinic3 prefixes (Suman Ghosh)=0D
* Change hinic3_remove_func to void (Suman Ghosh)=0D
* Add adev_event_unregister (Suman Ghosh)=0D
* Add comment for service types enum (Suman Ghosh)=0D
=0D
PATCH 01 V05: https://lore.kernel.org/netdev/cover.1740312670.git.gur.stavi=
@huawei.com=0D
* Fix signed-by signatures (Przemek Kitszel)=0D
* Expand initials in documentation (Przemek Kitszel)=0D
* Update copyright messages to 2025 (Przemek Kitszel)=0D
* Sort filenames in makefile (Przemek Kitszel)=0D
* Sort include statements (Przemek Kitszel)=0D
* Reduce padding in irq allocation struct (Przemek Kitszel)=0D
* Replace memset of zero with '=3D {}' init (Przemek Kitszel)=0D
* Revise mbox API to avoid using same pointer twice (Przemek Kitszel)=0D
* Use 2 underscores for header file ifdef guards (Przemek Kitszel)=0D
* Remove 'Intelligent' from Kconfig (Przemek Kitszel)=0D
* Documentation, fix line length mismatch to header (Simon Horman)=0D
=0D
PATCH 01 V06: https://lore.kernel.org/netdev/cover.1740487707.git.gur.stavi=
@huawei.com=0D
* Add hinic3 doc to device_drivers/ethernet TOC (Jakub Kicinski)=0D
=0D
PATCH 01 V07: https://lore.kernel.org/netdev/cover.1741069877.git.gur.stavi=
@huawei.com=0D
* Remove unneeded conversion to bool (Jakub Kicinski)=0D
* Use net_prefetch and net_prefetchw (Joe Damato)=0D
* Push IRQ coalescing and rss alloc/free to later patch (Joe Damato)=0D
* Pull additional rx/tx/napi code from next patch (Joe Damato)=0D
=0D
PATCH 01 V08: https://lore.kernel.org/netdev/cover.1741247008.git.gur.stavi=
@huawei.com=0D
* Fix build warning following pulling napi code from later patch (patchwork=
)=0D
* Add missing net/gro.h include for napi_gro_flush (patchwork)=0D
=0D
PATCH 01 V09: https://lore.kernel.org/netdev/cover.1742202778.git.gur.stavi=
@huawei.com=0D
* Maintain non-error paths in the main flow (Simon Horman)=0D
* Rename Pcie to PCIe in debug messages (Simon Horman)=0D
* Remove do-nothing goto label (Simon Horman)=0D
* Remove needless override of error value (Simon Horman)=0D
=0D
PATCH 01 V10: https://lore.kernel.org/netdev/cover.1744286279.git.gur.stavi=
@huawei.com=0D
* Poll Tx before polling Rx (Jakub Kicinski)=0D
* Use napi_complete_done instead of napi_complete (Jakub Kicinski)=0D
* Additional napi conformance fixes.=0D
* Rename goto labels according to target rather than source (Jakub Kicinski=
)=0D
* Call netif_carrier_off before register_netdev (Jakub Kicinski)=0D
=0D
PATCH 01 V11: https://lore.kernel.org/netdev/cover.1745221384.git.gur.stavi=
@huawei.com=0D
* Delete useless fallback to 32 bit DMA (Jakub Kicinski)=0D
=0D
PATCH 01 V12: https://lore.kernel.org/netdev/cover.1745411775.git.gur.stavi=
@huawei.com=0D
* Remove unneeded trailing coma (Christophe JAILLET)=0D
* Use kcalloc for array allocations (Christophe JAILLET)=0D
* Use existing goto label, avoid duplicating code (Christophe JAILLET)=0D
=0D
PATCH 01 V13: https://lore.kernel.org/netdev/cover.1746519748.git.gur.stavi=
@huawei.com=0D
* Use page_pool for rx buffers (Jakub Kicinski)=0D
* Wrap lines at 80 chars (Jakub Kicinski)=0D
* Consistency: rename buff to buf=0D
* Remove unneeded numeric suffixes: UL, ULL, etc.=0D
=0D
PATCH 01 V14:=0D
* Use proper api for rx frag allocation (Jakub Kicinski)=0D
* Use napi_alloc_skb instead of netdev_alloc_skb_ip_align (Jakub Kicinski)=
=0D
=0D
Fan Gong (1):=0D
  hinic3: module initialization and tx/rx logic=0D
=0D
 .../device_drivers/ethernet/huawei/hinic3.rst | 137 ++++=0D
 .../device_drivers/ethernet/index.rst         |   1 +=0D
 MAINTAINERS                                   |   7 +=0D
 drivers/net/ethernet/huawei/Kconfig           |   1 +=0D
 drivers/net/ethernet/huawei/Makefile          |   1 +=0D
 drivers/net/ethernet/huawei/hinic3/Kconfig    |  20 +=0D
 drivers/net/ethernet/huawei/hinic3/Makefile   |  21 +=0D
 .../ethernet/huawei/hinic3/hinic3_common.c    |  53 ++=0D
 .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +=0D
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  25 +=0D
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  53 ++=0D
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  32 +=0D
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +=0D
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 113 +++=0D
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  24 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  81 +++=0D
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  21 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  58 ++=0D
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  53 ++=0D
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   | 414 +++++++++++=0D
 .../net/ethernet/huawei/hinic3/hinic3_lld.h   |  21 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 357 +++++++++=0D
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  16 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |  15 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  13 +=0D
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 105 +++=0D
 .../huawei/hinic3/hinic3_netdev_ops.c         |  78 ++=0D
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 233 ++++++=0D
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  41 ++=0D
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  89 +++=0D
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  21 +=0D
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    | 120 ++++=0D
 .../huawei/hinic3/hinic3_queue_common.c       |  68 ++=0D
 .../huawei/hinic3/hinic3_queue_common.h       |  54 ++=0D
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 341 +++++++++=0D
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  90 +++=0D
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 678 ++++++++++++++++++=0D
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 131 ++++=0D
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    |  29 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  76 ++=0D
 40 files changed, 3731 insertions(+)=0D
 create mode 100644 Documentation/networking/device_drivers/ethernet/huawei=
/hinic3.rst=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/Kconfig=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/Makefile=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_common.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_common.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_lld.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_main.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interfac=
e.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c=
=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.=
c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.=
h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_tx.h=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_wq.c=0D
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_wq.h=0D
=0D
=0D
base-commit: 836b313a14a316290886dcc2ce7e78bf5ecc8658=0D
-- =0D
2.45.2=0D
=0D

