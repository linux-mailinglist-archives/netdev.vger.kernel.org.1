Return-Path: <netdev+bounces-196141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C08AD3B20
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE07A3A4D33
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9328A146D65;
	Tue, 10 Jun 2025 14:31:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE0D517;
	Tue, 10 Jun 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565881; cv=none; b=U7vtHyfC33zc57s1panJ5Dfuo/P8QIDP/EKLeATHP4WBAeoalGsJ5ktZFfYVGEGEdVkBU76Rzl4KD6XCi4Xg2AYgOVL2Aasy9PROPfvQT5EKsgOwMt4JPDm08WG03UQBxU66QjA7If5aXyqrnZjdYztXo0tEoj30DM3x7GKA3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565881; c=relaxed/simple;
	bh=zogKX7O9FU9YCjq+AK7VcXHV4pgLgzrBdCfhDHJ1vhA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O5onwxErhFPi/tNIG8ME3mBhXIInIyXsThfupvpslSijJjIMy8GRu9cs5FO62W6uz2QaDSrdrIW8NgsTmq6HOGNFlfs8jejSDtXlWpYngKeV71NjzQtNJO2Eu1+0MeU6aXvJZmu/ISWlv0W/sMYFkyFZFsA7koypfLhH0kFOAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bGrm570ZQz2ZP3p;
	Tue, 10 Jun 2025 22:29:57 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C33BD140119;
	Tue, 10 Jun 2025 22:31:15 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 22:31:14 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
	<mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v01 0/1] net: hinic3: Add a driver for Huawei 3rd gen  NIC
Date: Tue, 10 Jun 2025 22:30:59 +0800
Message-ID: <cover.1749561390.git.root@localhost.localdomain>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This is the 2/3 patch of the patch-set described below.

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

PATCH 01 V14: https://lore.kernel.org/netdev/cover.1746689795.git.gur.stavi@huawei.com
* Use proper api for rx frag allocation (Jakub Kicinski)
* Use napi_alloc_skb instead of netdev_alloc_skb_ip_align (Jakub Kicinski)

PATCH 01 V15: https://lore.kernel.org/netdev/cover.1747556339.git.gur.stavi@huawei.com
* For tx, Use wake/stop macros from netdev_queues.h (Jakub Kicinski)
* Remove some internal flags

PATCH 01 V16: https://lore.kernel.org/netdev/cover.1747640393.git.gur.stavi@huawei.com
* Fix unused-but-set-variable warning (kernel test robot)
* In get_used function, add READ_ONCE for work queue producer/consumer indices.

PATCH 01 V17: https://lore.kernel.org/netdev/cover.1747736586.git.gur.stavi@huawei.com
* Remove minus sign from NETDEV_TX_BUSY (Jakub Kicinski)

PATCH 02 V01:

Fan Gong (1):
  hinic3: management interfaces

 drivers/net/ethernet/huawei/hinic3/Makefile   |   4 +-
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 907 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  | 156 +++
 .../ethernet/huawei/hinic3/hinic3_common.c    |  30 +
 .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  79 ++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   | 795 +++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   | 130 +++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  42 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  31 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  36 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 152 ++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  16 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 137 ++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  54 ++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 834 +++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  | 127 +++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  14 +-
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    | 108 +++
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  10 +
 21 files changed, 3692 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h


base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
-- 
2.43.0


