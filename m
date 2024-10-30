Return-Path: <netdev+bounces-140363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F99B62B2
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D5D1F22DB7
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430061EABAC;
	Wed, 30 Oct 2024 12:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D01E907F;
	Wed, 30 Oct 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290282; cv=none; b=lIEkMzDj68LpeYmDUCjPYguwnPBCvpgzKMsrUtxDSpmwm+3SMZGR2lWvye0w6XNY+wKJroCvCy9pAASJO28UWKRg1moGu5l4v/M+Edmk1elfLJhIhiEUpsO4WMX/8mpMBofe8Ww7yAJioeDzdrhnxPkMQHEBeThKH6RVN0uk+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290282; c=relaxed/simple;
	bh=sBzJNEbXkAOnL0p2d/eAsP9pguRAa27uIh7hkZVjEeU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IYnm4AlW5cI98EsDqZdVwkZRFECVgNH9Zugq0o343c9L9sHBDp6YIAvFzxp5YJBrQTVO0YD+zzigpUMzz97UroyiZep7q1uYLHRT9sjUc2k0+JQs+08IZMC4vwb/07C7ufBWkr7HYJffQl9Ow0gwKtKrgHdi0zSuZjzjHxqOPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdmBB56B6z6K5wV;
	Wed, 30 Oct 2024 20:08:50 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id A6618140AA7;
	Wed, 30 Oct 2024 20:11:15 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 13:11:07 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>, gongfan <gongfan1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Cai Huoqing
	<cai.huoqing@linux.dev>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Meny Yossefi
	<meny.yossefi@huawei.com>
Subject: [RFC net-next v01 0/1] net: hinic3: Add a driver for Huawei 3rd gen NIC
Date: Wed, 30 Oct 2024 14:25:46 +0200
Message-ID: <cover.1730290527.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

The patch-set contains driver for Huawei's 3rd generation HiNIC
Ethernet device that will be available in the future.

This is an SRIOV device, designed for data centers.
The driver supports both PFs and VFs.

gongfan (1):
  net: hinic3: Add a driver for Huawei 3rd gen NIC

 .../device_drivers/ethernet/huawei/hinic3.rst |  126 ++
 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/huawei/Kconfig           |    1 +
 drivers/net/ethernet/huawei/Makefile          |    1 +
 drivers/net/ethernet/huawei/hinic3/Kconfig    |   16 +
 drivers/net/ethernet/huawei/hinic3/Makefile   |   27 +
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 1196 +++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  |  184 +++
 .../ethernet/huawei/hinic3/hinic3_common.c    |  105 ++
 .../ethernet/huawei/hinic3/hinic3_common.h    |   57 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |   85 ++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   |  914 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   |  152 ++
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 1340 +++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_filter.c    |  405 +++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  475 ++++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  102 ++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  632 ++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   50 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  316 ++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  736 +++++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  117 ++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  576 +++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  125 ++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  324 ++++
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  503 +++++++
 .../net/ethernet/huawei/hinic3/hinic3_lld.h   |   19 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  691 +++++++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 1054 +++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |  158 ++
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  |  358 +++++
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |   78 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  389 +++++
 .../huawei/hinic3/hinic3_netdev_ops.c         |  951 ++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  808 ++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  471 ++++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  213 +++
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  897 +++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |  155 ++
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |   11 +
 .../huawei/hinic3/hinic3_queue_common.c       |   66 +
 .../huawei/hinic3/hinic3_queue_common.h       |   51 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   |  873 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |   33 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  735 +++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  174 +++
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  881 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  182 +++
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    |  142 ++
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |   96 ++
 50 files changed, 18058 insertions(+)
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
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c
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


base-commit: b8ee7a11c75436b85fa1641aa5f970de0f8a575c
-- 
2.45.2


