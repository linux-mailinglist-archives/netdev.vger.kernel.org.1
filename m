Return-Path: <netdev+bounces-151356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771E59EE576
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54702167148
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526012054E8;
	Thu, 12 Dec 2024 11:51:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E48158DB1;
	Thu, 12 Dec 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004274; cv=none; b=NsWGVhJueTZZMUWoTMa7jOwLBJhzs4Ku1Khmu4AxbGo1k89ZMEQ+e1zgFeOd6y3pg0aDTFpONtMRgqRaJFcOWfBKOTfpBwd6jIdjxmbOXPxV7UwwSWNhFYINWx/QOkOjbvFVGHhS545SItbzl+XbvWsH44kPayuxWOazFGyI8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004274; c=relaxed/simple;
	bh=oubn445uqd0v0CXdIPwBnssEZajwfyX6Dn3lPr8i5DE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=utmtnu+OeUcluo4SrMgmlNMKcJA9HYTV30wmKsKI1ksIGANtsgQGeyQP20LFE40sbfqHpvpWZI3+2NcI3bcT8eH9/CflxvKWQLXn9xP4Lz+ZW6gveej/xEQe6+rt26mJ1aIxrpWs41cGDJskKEe71isLpvzjaoMmvGCDn/uFEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y89kl3SYqz6LDfv;
	Thu, 12 Dec 2024 19:50:07 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id E6EED1403A0;
	Thu, 12 Dec 2024 19:51:02 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Dec
 2024 12:50:53 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>, gongfan <gongfan1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Cai Huoqing
	<cai.huoqing@linux.dev>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Meny Yossefi
	<meny.yossefi@huawei.com>
Subject: [RFC net-next v02 0/3] net: hinic3: Add a driver for Huawei 3rd gen NIC
Date: Thu, 12 Dec 2024 14:04:14 +0200
Message-ID: <cover.1733990727.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

The patch-set contains driver for Huawei's 3rd generation HiNIC
Ethernet device that will be available in the future.

This is an SRIOV device, designed for data centers.
Initially, the driver only supports VFs.

Following the discussion over RFC01, the code will be submitted in
separate smaller patches where until the last patch the driver is
non-functional.
This RFC02 is an overall view of the entire driver but every patch will be
posted as a standalone submission.

Changes:

V01: https://lore.kernel.org/netdev/cover.1730290527.git.gur.stavi@huawei.com
* Reduce overall line of code by removing optional functionality.
* Break down into smaller patches.

gongfan (3):
  net: hinic3: module initialization and tx/rx logic
  net: hinic3: management interfaces
  net: hinic3: sw and hw initialization code

 .../device_drivers/ethernet/huawei/hinic3.rst | 136 +++
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/huawei/Kconfig           |   1 +
 drivers/net/ethernet/huawei/Makefile          |   1 +
 drivers/net/ethernet/huawei/hinic3/Kconfig    |  16 +
 drivers/net/ethernet/huawei/hinic3/Makefile   |  25 +
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 898 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  | 150 +++
 .../ethernet/huawei/hinic3/hinic3_common.c    |  98 ++
 .../ethernet/huawei/hinic3/hinic3_common.h    |  54 ++
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  74 ++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   | 786 +++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   | 128 +++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    | 266 ++++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  62 ++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 412 ++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  42 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 248 +++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c | 569 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  82 ++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 430 +++++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  91 ++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 172 ++++
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   | 417 ++++++++
 .../net/ethernet/huawei/hinic3/hinic3_lld.h   |  20 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 417 ++++++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 844 ++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  | 147 +++
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  14 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 212 +++++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 518 ++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 395 ++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  76 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 107 +++
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    | 885 +++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    | 142 +++
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |  10 +
 .../huawei/hinic3/hinic3_queue_common.c       |  65 ++
 .../huawei/hinic3/hinic3_queue_common.h       |  51 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 378 ++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  14 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 620 ++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    | 104 ++
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 817 ++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 141 +++
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    | 132 +++
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  87 ++
 48 files changed, 11382 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
 create mode 100644 drivers/net/ethernet/huawei/hinic3/Kconfig
 create mode 100644 drivers/net/ethernet/huawei/hinic3/Makefile
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_common.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_common.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
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
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_wq.h


base-commit: 65fb414c93f486cef5408951350f20552113abd0
--
2.45.2


