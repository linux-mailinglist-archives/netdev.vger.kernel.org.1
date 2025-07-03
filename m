Return-Path: <netdev+bounces-203685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE6BAF6C23
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAA84A35F2
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE6717332C;
	Thu,  3 Jul 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="gJUr+y6t"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-40.ptr.blmpb.com (va-2-40.ptr.blmpb.com [209.127.231.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D618C00
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529310; cv=none; b=rhY8pTD1LTVymdD1j8Fp6Kx3xnAe2k+/sCOibQE6j+Z/zjz8fgP9UaUx1RJthDXc4ySeD9cHpNXylkhwL5f7YGDd/G/eoaRdmv2/vD+ydBPjXWCIf9QSJqo1l1Wbwkl5wxcYJ7oCWhSmTAog/snLm16MCXwxMiT1rkBrfLPZlSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529310; c=relaxed/simple;
	bh=VyoKjlR/loao0DTytUvsUcM/FE4qRzHXioqfro4hT/U=;
	h=Mime-Version:Message-Id:To:From:Date:Content-Type:Cc:Subject; b=Vn6LQKioNkO+LFxjYy0xW1cFoNyI4mZqtfgrx/gCrVFTyRJDIwVhhbCIQ1APpUywpsmaMLeUXc13Y0jRHVVJFERbRGwJwkv02P4ng0TkzDVQXKYpfG6RJomaZdwenuRE4r8BRDqp/1u5MnjqY2UhSTieCS/0yeg0QEKS9jogR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=gJUr+y6t; arc=none smtp.client-ip=209.127.231.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1751529263; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=vr5PoFm7pg87Xj3aOSXUEA0muPJNDLSjfb0SrmDRfB4=;
 b=gJUr+y6tF9y222C+IiXQXc06XLOONQ7r8SoWGw3Pb4reow3xyaDGwzYm59o7hf4Sw0TMvU
 V21nI8Sl+NQ0FC2Z/Jq2V1DzYCx0+AaY247C5DaoJm6xKeCDwMPzoqlJ7IAWtfD9UaQEG2
 HGhzWQkuDN/HHJHLQQDDhPyZruY5mEOE2Qor60X4yURf8N3xpG2ccpVgiA3XFYrajrxv2n
 TkYpFHuDdYfiT3aHeYZC6OWe76y5fYB2+jqUIV/Hl2BTkR4ss4rPA9w+b/KsbnDcCiQ9Jy
 33UDvQohE+mnYJe4KYAK123p3G/4HfthfW1jBW14kaezlM2cOcow7Sra2qlBbQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Message-Id: <20250703075341.3488773-1-tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Date: Thu, 03 Jul 2025 15:54:20 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 03 Jul 2025 15:54:20 +0800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
Subject: [PATCH net-next v12 00/14] xsc: ADD Yunsilicon XSC Ethernet Driver
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+26866372d+afbb9f+vger.kernel.org+tianx@yunsilicon.com>

The patch series adds the xsc driver, which will support the YunSilicon
MS/MC/MV series of network cards. These network cards offer support for
high-speed Ethernet and RDMA networking, with speeds of up to 200Gbps.

The Ethernet functionality is implemented by two modules. One is a
PCI driver(xsc_pci), which provides PCIe configuration,
CMDQ service (communication with firmware), interrupt handling,
hardware resource management, and other services, while offering
common interfaces for Ethernet and future InfiniBand drivers to
utilize hardware resources. The other is an Ethernet driver(xsc_eth),
which handles Ethernet interface configuration and data
transmission/reception.

- Patches 1-7 implement the PCI driver
- Patches 8-14 implement the Ethernet driver

This submission is the first phase, which includes the PF-based Ethernet
transmit and receive functionality. Once this is merged, we will submit
additional patches to implement support for other features, such as SR-IOV,
ethtool support, and a new RDMA driver.

Changes v11->v12
Link to v11: https://lore.kernel.org/netdev/20250423103923.2513425-1-tianx@yunsilicon.com/
- patch01: modify NET_VENDOR_YUNSILICON depends on: "ARM64 || X86_64" -> "64BIT" (Jakub)
- patch12: TSO byte stats include headers added after hardware segmentation (Jakub)

Changes v10->v11
Link to v10: https://lore.kernel.org/netdev/20250411065246.2303550-1-tianx@yunsilicon.com/
- patches 09,10,11: Replace "((struct xsc_adapter *)xdev->eth_priv)->netdev"
                    with helper xsc_dev_to_net_dev() (Jakub)
- patches 11,13: Use page_pool api to manage dma mapping and unmapping on rx path (Jakub)

Changes v9->v10
Link to v9: https://lore.kernel.org/netdev/20250318151449.1376756-1-tianx@yunsilicon.com/
- patch05: Remove GFP_ZERO from dma_alloc_coherent() (Jakub)
- patch05: Add XSC_ prefix to all header guards (Jakub)
- patch09: Replace ((struct xsc_adapter *)xdev->eth_priv)->netdev with a local variable (Jakub)
- patches 02,09,11,12: Unify xsc_cmd_exec() return val: return -EIO for firmware errors.
           Return the actual ret code when using xsc_cmd_exec (Jakub)
- patch09: Use ether_addr_copy() and eth_hw_addr_random() for MAC address handling (Jakub)
- patch11: Fix incorrect entry_len calculation per RX channel (Simon)
- patch12: Drop redundant adapter and adapter->xdev checks in xsc_eth_xmit_start() (Simon)
- patch13: Remove XSC_SET/GET_PFLAG and other priv_flag-related code (Simon)
- patch13: Initialize err to 0 in xsc_eth_post_rx_wqes() (Simon)
- patch14: Return -ENOMEM if kvzalloc() for adapter->stats fails (Simon)

Changes v8->v9:
Link to v8: https://lore.kernel.org/netdev/20250307100824.555320-1-tianx@yunsilicon.com/
- correct netdev feature settings in Patch09 (Paolo)
- change sizes from int to unsigned int in Patch02 (Geert)
- nit in Patch02: min_t->min, use upper_32_bits/lower_32_bits() (Simon)

Changes v7->v8:
Link to v7: https://lore.kernel.org/netdev/20250228154122.216053-1-tianx@yunsilicon.com/
- add Kconfig NET_VENDOR_YUNSILICON depends on COMPILE_TEST (Jakub)
- rm unnecessary "default n" (Jakub)
- select PAGE_POOL in ETH driver (Jakub)
- simplify dma_mask set (Jakub)
- del pci_state and pci_state_mutex (Kalesh)
- dropped intf_state and int_state_mutex too
- del some no need lables in patch1 (Kalesh)
- ensure consistent label naming throughout the patchset (Simon)
- WARN_ONCE instead of meaningless comments (Simon)
- Patch 7 add Reviewed-by from Leon Romanovsky, thanks Leon
- nits

Xin Tian (14):
  xsc: Add xsc driver basic framework
  xsc: Enable command queue
  xsc: Add hardware setup APIs
  xsc: Add qp and cq management
  xsc: Add eq and alloc
  xsc: Init pci irq
  xsc: Init auxiliary device
  xsc: Add ethernet interface
  xsc: Init net device
  xsc: Add eth needed qp and cq apis
  xsc: ndo_open and ndo_stop
  xsc: Add ndo_start_xmit
  xsc: Add eth reception data path
  xsc: add ndo_get_stats64

 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/yunsilicon/Kconfig       |   26 +
 drivers/net/ethernet/yunsilicon/Makefile      |    8 +
 .../yunsilicon/xsc/common/xsc_auto_hw.h       |   94 +
 .../ethernet/yunsilicon/xsc/common/xsc_cmd.h  |  630 ++++++
 .../yunsilicon/xsc/common/xsc_cmd_api.h       |   23 +
 .../ethernet/yunsilicon/xsc/common/xsc_cmdq.h |  234 ++
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  498 +++++
 .../yunsilicon/xsc/common/xsc_device.h        |   77 +
 .../net/ethernet/yunsilicon/xsc/net/Kconfig   |   17 +
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |    9 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 1980 +++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |   60 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  199 ++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |  555 +++++
 .../yunsilicon/xsc/net/xsc_eth_stats.c        |   46 +
 .../yunsilicon/xsc/net/xsc_eth_stats.h        |   34 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  320 +++
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  185 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |   91 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.c  |   80 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.h  |  187 ++
 .../net/ethernet/yunsilicon/xsc/net/xsc_pp.h  |   38 +
 .../net/ethernet/yunsilicon/xsc/net/xsc_pph.h |  180 ++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  197 ++
 .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |   14 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   10 +
 .../net/ethernet/yunsilicon/xsc/pci/adev.c    |  115 +
 .../net/ethernet/yunsilicon/xsc/pci/adev.h    |   14 +
 .../net/ethernet/yunsilicon/xsc/pci/alloc.c   |  234 ++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |   17 +
 .../net/ethernet/yunsilicon/xsc/pci/cmdq.c    | 1502 +++++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  148 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c  |  328 +++
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h  |   46 +
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  |  271 +++
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h  |   18 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  326 +++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.c |  426 ++++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.h |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  194 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |   14 +
 .../net/ethernet/yunsilicon/xsc/pci/vport.c   |   34 +
 46 files changed, 9516 insertions(+)
 create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd_api.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/main.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_pp.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_pph.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/vport.c

--
2.43.0

