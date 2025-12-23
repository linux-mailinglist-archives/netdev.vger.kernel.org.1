Return-Path: <netdev+bounces-245800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E3ACD807F
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 05:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA81930443E7
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844F302767;
	Tue, 23 Dec 2025 03:56:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-105.mail.aliyun.com (out28-105.mail.aliyun.com [115.124.28.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7930149F;
	Tue, 23 Dec 2025 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766462203; cv=none; b=rXSYllmaJLQLs+Re53LyQPEvVyItE2ryTpyo4+3gqeK8wWWiq822CmDM1QBAxI/gmDwtJVmuhwEzStWMsJ8BdqEAQ8PmGw/0rVws5979S5Ku7dNO/N7vbb6S94M5taFvFTgGYLildUMYKStt6Bs4sP8sDlyXj2yPPo7fJm5Tk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766462203; c=relaxed/simple;
	bh=cUxPYDfMy+UvtHsP6BPmG9PWUF3d9d+Fffdd6/jdak0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E9jA5+WPO4yU+Hv7iIerys3m+0IrXXwbGPsS+dqnbx4MLzw+r9eraAu1uVs2M9UlUc9jXVE6/WylgdlTrQKh9H7QLCesIc9OIaceFbMebHZrIjzbd6gTe8fdM3dfY26spy+opdXT+vc9ax8YMpc1yknTm3iGBj5bOI2mQnQhbTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.fqrxWOe_1766461878 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 11:51:19 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 net-next 00/15] nbl driver for Nebulamatrix NICs
Date: Tue, 23 Dec 2025 11:50:23 +0800
Message-ID: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch series add the nbl driver, which will support the nebula-matrix 18100 and 18110 series 
of network cards.
This submission is the first phase. which includes the PF-based and VF-based Ethernet transmit 
and receive functionality. Once this is merged. will submit addition patches to implement support
for other features. such as ethtool support, debugfs support and etc.
Our Driver architecture  supports Kernel Mode and Coexistence Mode(kernel and dpdk)

illusion.wang (15):
  net/nebula-matrix: add minimum nbl build framework
  net/nebula-matrix: add simple probe/remove.
  net/nebula-matrix: add HW layer definitions and implementation
  net/nebula-matrix: add Channel layer definitions and implementation
  net/nebula-matrix: add Resource layer definitions and implementation
  net/nebula-matrix: add intr resource definitions and implementation
  net/nebula-matrix: add vsi, queue, adminq resource definitions and
    implementation
  net/nebula-matrix: add flow resource definitions and implementation
  net/nebula-matrix: add txrx resource definitions and implementation
  net/nebula-matrix: add Dispatch layer definitions and implementation
  net/nebula-matrix: add Service layer definitions and implementation
  net/nebula-matrix: add Dev layer definitions and implementation
  net/nebula-matrix: add Dev start, stop operation
  net/nebula-matrix: fully support ndo operations
  net/nebula-matrix: add kernel/user coexist mode support

 .../ethernet/nebula-matrix/m18100.rst         |   52 +
 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |   39 +
 drivers/net/ethernet/nebula-matrix/Makefile   |    6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   41 +
 .../nbl/nbl_channel/nbl_channel.c             | 1518 +++++
 .../nbl/nbl_channel/nbl_channel.h             |  214 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c | 1063 ++++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   69 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  145 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 3277 +++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  343 ++
 .../nebula-matrix/nbl/nbl_core/nbl_dev_user.c | 1607 ++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev_user.h |   76 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 4756 ++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   89 +
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 4895 +++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.h  |  301 +
 .../nebula-matrix/nbl/nbl_core/nbl_sysfs.c    |   79 +
 .../nebula-matrix/nbl/nbl_core/nbl_sysfs.h    |   21 +
 .../nebula-matrix/nbl/nbl_hw/nbl_adminq.c     | 1520 +++++
 .../nebula-matrix/nbl/nbl_hw/nbl_adminq.h     |  196 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw.h         |  184 +
 .../nbl_hw/nbl_hw_leonis/base/nbl_datapath.h  |   14 +
 .../nbl_hw_leonis/base/nbl_datapath_dpa.h     |  765 +++
 .../nbl_hw_leonis/base/nbl_datapath_dped.h    | 2152 ++++++++
 .../nbl_hw_leonis/base/nbl_datapath_dstore.h  |  957 ++++
 .../nbl_hw_leonis/base/nbl_datapath_ucar.h    |  414 ++
 .../nbl_hw_leonis/base/nbl_datapath_upa.h     |  822 +++
 .../nbl_hw_leonis/base/nbl_datapath_uped.h    | 1499 +++++
 .../nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h   |   16 +
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_acl.h   | 2417 ++++++++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h  |  665 +++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_fem.h   | 1490 +++++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h  | 1397 +++++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_mcc.h   |  412 ++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp0.h   |  619 +++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp1.h   |  701 +++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp2.h   |  619 +++
 .../nbl_hw/nbl_hw_leonis/nbl_flow_leonis.c    | 2094 +++++++
 .../nbl_hw/nbl_hw_leonis/nbl_flow_leonis.h    |  204 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 3062 +++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  | 1844 +++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c | 3864 +++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h |   12 +
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c   | 1373 +++++
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h   |   25 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       | 1073 ++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   26 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |  187 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  |  409 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |   13 +
 .../nebula-matrix/nbl/nbl_hw/nbl_p4_actions.h |   59 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.c      |   56 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.h      |   11 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  409 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  853 +++
 .../nebula-matrix/nbl/nbl_hw/nbl_txrx.c       | 2026 +++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_txrx.h       |  188 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |  270 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |   12 +
 .../nbl/nbl_include/nbl_def_channel.h         |  785 +++
 .../nbl/nbl_include/nbl_def_common.h          |  515 ++
 .../nbl/nbl_include/nbl_def_dev.h             |   37 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |  192 +
 .../nbl/nbl_include/nbl_def_hw.h              |  142 +
 .../nbl/nbl_include/nbl_def_resource.h        |  188 +
 .../nbl/nbl_include/nbl_def_service.h         |  164 +
 .../nbl/nbl_include/nbl_include.h             |  624 +++
 .../nbl/nbl_include/nbl_product_base.h        |   21 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  477 ++
 73 files changed, 56677 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev_user.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev_user.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dpa.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_upa.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_uped.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_acl.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_fem.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_mcc.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp0.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp1.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp2.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_flow_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_flow_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_p4_actions.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

-- 
2.43.0


