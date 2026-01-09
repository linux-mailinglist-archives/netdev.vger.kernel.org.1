Return-Path: <netdev+bounces-248422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DEAD08646
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E71C5301C57D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7135F3375AA;
	Fri,  9 Jan 2026 10:02:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-24.us.a.mail.aliyun.com (out198-24.us.a.mail.aliyun.com [47.90.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC8335579;
	Fri,  9 Jan 2026 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952968; cv=none; b=K4syJxS98tGO3lenkcAxuYccpM/l6O6B7rluLfEH822rcuImIJTQwtoeUqKUk+tHr/ypz/I+WyD6iHUt5AkbMc1GxyylevH9aJVrJOZqDiNRwopLdsC0S4NoD7X4grUaTlqZvRsHjpessSryXi7WFbedWOUndAr80rOj9ZF+ZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952968; c=relaxed/simple;
	bh=QYg2CX5+iyZOnKmruyny7+n3docOmdqdBgyPVOTHDUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RJVoGL4ucORgGNAkO2KZB3W4JOgAz3HP5ruQjlGlaWfiA79sbRcT9OOkTcE7arEjWlsWCH+NYu1ixvsc/gb0IL6g2yZkpDzOdW4/w04I2Wnj5+WI91oMQE/utChkMKBtxbTM+dgsXCGRNgF8hE0CG6a39/WTtcXmOcnRtcCrG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQATv_1767952944 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:24 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 net-next 00/15] nbl driver for Nebulamatrix NICs
Date: Fri,  9 Jan 2026 18:01:18 +0800
Message-ID: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch series add the nbl driver, which will support nebula-matrix
18100 and 18110 series of network cards.
This submission is the first phase. which includes the PF-based and
VF-based Ethernet transmit and receive functionality. Once this is
merged. will submit addition patches to implement support for other
features. such as ethtool support, debugfs support and etc.

Changes v1->v2
Link to v1: https://lore.kernel.org/netdev/20251223035113.31122-1-illusion.wang@nebula-matrix.com/
1.Format Issues and Compilation Issues
- Paolo Abeni
2.add sysfs patch and drop coexisting patch
- Andrew Lunn
3.delete some unimportant ndo operations
4.add machine generated headers patch
5.Modify the issues found in patch1-2 and apply the same fixes to other
patches
6.modify issues found by nipa

illusion.wang (15):
  net/nebula-matrix: add minimum nbl build framework
  net/nebula-matrix: add simple probe/remove
  net/nebula-matrix: add HW layer definitions and implementation
  net/nebula-matrix: add machine-generated headers and chip definitions
  net/nebula-matrix: add channel layer definitions and implementation
  net/nebula-matrix: add resource layer definitions and implementation
  net/nebula-matrix: add intr resource definitions and implementation
  net/nebula-matrix: add vsi, queue, adminq resource definitions and
    implementation
  net/nebula-matrix: add flow resource definitions and implementation
  net/nebula-matrix: add txrx resource definitions and implementation
  net/nebula-matrix: add Dispatch layer definitions and implementation
  net/nebula-matrix: add Service layer definitions and implementation
  net/nebula-matrix: add Dev init,remove operation
  net/nebula-matrix: add Dev start, stop operation
  net/nebula-matrix: add st_sysfs and vf name sysfs

 .../ethernet/nebula-matrix/m18100.rst         |   52 +
 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |   39 +
 drivers/net/ethernet/nebula-matrix/Makefile   |    6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   29 +
 .../nbl/nbl_channel/nbl_channel.c             | 1482 ++++++
 .../nbl/nbl_channel/nbl_channel.h             |  205 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  784 +++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   54 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  144 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 3194 ++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  270 ++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 4265 +++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   78 +
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 3804 +++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.h  |  240 +
 .../nebula-matrix/nbl/nbl_core/nbl_sysfs.c    |   85 +
 .../nebula-matrix/nbl/nbl_core/nbl_sysfs.h    |   20 +
 .../nebula-matrix/nbl/nbl_hw/nbl_adminq.c     | 1446 ++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_adminq.h     |  160 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw.h         |  172 +
 .../nbl_hw/nbl_hw_leonis/base/nbl_datapath.h  |   11 +
 .../nbl_hw_leonis/base/nbl_datapath_dped.h    | 2152 +++++++++
 .../nbl_hw_leonis/base/nbl_datapath_dstore.h  |  929 ++++
 .../nbl_hw_leonis/base/nbl_datapath_ucar.h    |  414 ++
 .../nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h   |   10 +
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h  |  665 +++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h  | 1397 ++++++
 .../nbl_hw/nbl_hw_leonis/nbl_flow_leonis.c    | 2268 +++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_flow_leonis.h    |  204 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 3186 ++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  | 1714 +++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c | 3863 +++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h |   12 +
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c   | 1430 ++++++
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h   |   23 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       | 1067 +++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   28 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |  156 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  |  448 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |   13 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.c      |   60 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.h      |   11 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  444 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  878 ++++
 .../nebula-matrix/nbl/nbl_hw/nbl_txrx.c       | 2150 +++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_txrx.h       |  184 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |  168 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |   12 +
 .../nbl/nbl_include/nbl_def_channel.h         |  715 +++
 .../nbl/nbl_include/nbl_def_common.h          |  410 ++
 .../nbl/nbl_include/nbl_def_dev.h             |   32 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |  190 +
 .../nbl/nbl_include/nbl_def_hw.h              |  157 +
 .../nbl/nbl_include/nbl_def_resource.h        |  183 +
 .../nbl/nbl_include/nbl_def_service.h         |  156 +
 .../nbl/nbl_include/nbl_include.h             |  542 +++
 .../nbl/nbl_include/nbl_product_base.h        |   20 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  435 ++
 61 files changed, 43278 insertions(+)
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
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h
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
2.47.3


