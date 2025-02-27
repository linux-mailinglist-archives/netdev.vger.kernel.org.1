Return-Path: <netdev+bounces-170149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DFFA477CC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EF918851C9
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B86E22578D;
	Thu, 27 Feb 2025 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="CFWjik4d"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-17.ptr.blmpb.com (va-1-17.ptr.blmpb.com [209.127.230.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FEB222577
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644944; cv=none; b=JXIT+sXfYyJcVl+OAhqf1W3w25Gn1RIyWOMC3vlUxZWMESAIBYEYzNBuxWkNgsvmT4qpWyN+iVTjBP9mY6kZEMFsGmd5Er8Q4+s8CZmArrOMLhgHEva8g7stifyUoLUkViXwxklToKbgE9R80uOuJ/CuM3Tk/ZxJ5EFrd9xIHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644944; c=relaxed/simple;
	bh=jqyq20HRMdG8sFaewxLdU8o1W6khf203yrS+m7SUqoc=;
	h=From:Message-Id:Mime-Version:Cc:Subject:Content-Type:To:Date; b=FlzJjdPLlGiszMvVSoZcMZsInULxJe204cwsWBgbaGDsp9h/osWJhh8M0JTuGF5phMaOKppF1VyNz/3msG7Gm3BuNhwlhb839g8mqSSxR/pXZtduPh6xJsd+4u3pSNRwz6J/M3NQiLEeWJskpSJF2aBhg7MgpGC0cKI4X9502QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=CFWjik4d; arc=none smtp.client-ip=209.127.230.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740644799; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=DHvChLxOLUbbPXIyvVwZKB3X7GoGTmkoAqtbQvtj17Q=;
 b=CFWjik4dY69w1Yqkv+1QFcw6BxT9NePO5JiCe2PzejJ+27ltXxWt/uMvy9UjMl+GZIGrD7
 K2JzrbCyjZ2iKYUW4HldxedeBbYiE9yZKNPDjwXhUoX1tHYMV/zZjHvxOIjsnhzFT1fAfA
 I/9PkFnMnHvSYcNFz3u8NQPui5zKCsGC0CuK6f7Hg74+Pa9aYEa9VMBtrcJ3Ssali29KCR
 xALo62e6QUC2ogTGDj8M3FMjNaLR4BmfT715A+dKSdYzvvem+mHo4BDitOcEVp8RM7BHjH
 /c4KBWc9TNttm4iXFuRSxBnlilQAJ0syn0z2Z+fH5VpTj4R0Eh3EZx82FGS2xw==
From: "Xin Tian" <tianx@yunsilicon.com>
Message-Id: <20250227082558.151093-1-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Subject: [PATCH net-next v6 00/14] xsc: ADD Yunsilicon XSC Ethernet Driver
Content-Type: text/plain; charset=UTF-8
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 27 Feb 2025 16:26:36 +0800
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Date: Thu, 27 Feb 2025 16:26:36 +0800
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+267c021bd+26011a+vger.kernel.org+tianx@yunsilicon.com>

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

Change v5->v6:
Link to v5: https://lore.kernel.org/netdev/20250224172416.2455751-1-tianx@yunsilicon.com/
1. fix error return in xsc_adev_init
- Jakub Kicinski
2. comment style // -> /* ... */
3. remove XSC_ADEV_IDX_MAX, and use ARRAY_SIZE() instead
4. kcalloc for array alloc instead of kzalloc
- Leon Romanovsky
5. prefetch/perfetchw to net_prefetch/net_prefetch
- Joe Damato

Changes v4->v5:
Link to v4: https://lore.kernel.org/netdev/20250213091402.2067626-1-tianx@yunsilicon.com/
1. free xsc_adev in release callback
- for Leon Romanovsky
2. Add more detailed description for patches
3. use FIELD_PREP() and FIELD_GET() instead of XSC_SET/GET_FIELD
4. fix sparse complains about endian and types
5. use unsigned types for unsigned values
6. del BITS_PER_LONG == 64 check in xsc_buf_alloc
7. use GENMASK and DIV_ROUND_UP to replace the unclear code
- for Simon Horman

Changes v3->v4:
Link to v3: https://lore.kernel.org/netdev/20250115102242.3541496-1-tianx@yunsilicon.com/
1. pci_ioremap_bar returns a negative value in pci_init.
2. Adjust the declaration order to follow the reverse xmastree rule.
3. Split lines that exceed 80 columns.
4. Use XSC_SET_FIELD and XSC_GET_FIELD instead of bitfields.
- for Simon Horman
5. Use big-endian consistently in cmds
6. Add comments for sem and rsv0.
7. Change mode to enum in xsc_cmd, and rename bitmask to cmd_entry_mask.
8. Remove unnecessary header files such as kernel.h and init.h.
9. Add the xsc prefix to function names.
10. Return ENOSPC if alloc_ent fails.
11. Adjust the position of free_cmd.
12. Separate different categories of #include statements with blank lines.
13. Use status instead of admin_status xsc_event_set_port_admin_status_mbox_in
- for Przemek Kitszel

Changes v2->v3:
Link to v2: https://lore.kernel.org/netdev/20241230101513.3836531-1-tianx@yunsilicon.com/
1. Use auxiliary bus for ethernet functionality.
- Leon Romanovsky comments
2. Remove netdev from struct xsc_core_device, as it can be accessed via eth_priv.
- Andrew Lunn comments

Changes v1->v2:
Link to v1: https://lore.kernel.org/netdev/20241218105023.2237645-1-tianx@yunsilicon.com/
1. Remove the last two patches to reduce the total code submitted.
- Jakub Kicinski comments
2. Remove the custom logging interfaces and switch to using
   pci_xxx/netdev_xxx logging interfaces. Delete the related
   module parameters.
3. No use of inline functions in .c files.
4. Remove unnecessary license information.
5. Remove unnecessary void casts.
- Andrew Lunn comments
6. Use double underscore (__) for header file macros.
7. Fix the depend field in Kconfig.
8. Add sign-off for co-developers.
9. use string directly in MODULE_DESCRIPTION
10. Fix poor formatting issues in the code.
11. Modify some macros that don't use the XSC_ prefix.
12. Remove unused code from xsc_cmd.h that is not part of this patch series.
13. No comma after items in a complete enum.
14. Use the BIT() macro to define constants related to bit operations.
15. Add comments to clarify names like ver, cqe, eqn, pas, etc.
- Przemek Kitszel comments

Changes v0->v1:
1. name xsc_core_device as xdev instead of dev
2. modify Signed-off-by tag to Co-developed-by
3. remove some obvious comments
4. remove unnecessary zero-init and NULL-init
5. modify bad-named goto labels
6. reordered variable declarations according to the RCT rule
- Przemek Kitszel comments
7. add MODULE_DESCRIPTION()
- Jeff Johnson comments
8. remove unnecessary dev_info logs
9. replace these magic numbers with #defines in xsc_eth_common.h
10. move code to right place
11. delete unlikely() used in probe
12. remove unnecessary reboot callbacks
- Andrew Lunn comments

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
 .../ethernet/yunsilicon/xsc/common/xsc_cmdq.h |  234 ++
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  514 +++++
 .../yunsilicon/xsc/common/xsc_device.h        |   77 +
 .../yunsilicon/xsc/common/xsc_driver.h        |   25 +
 .../ethernet/yunsilicon/xsc/common/xsc_pp.h   |   38 +
 .../net/ethernet/yunsilicon/xsc/net/Kconfig   |   17 +
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |    9 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 1994 +++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |   57 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  239 ++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |  602 +++++
 .../yunsilicon/xsc/net/xsc_eth_stats.c        |   46 +
 .../yunsilicon/xsc/net/xsc_eth_stats.h        |   34 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  320 +++
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  188 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |   91 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.c  |   91 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.h  |  187 ++
 .../net/ethernet/yunsilicon/xsc/net/xsc_pph.h |  180 ++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  206 ++
 .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |   16 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   10 +
 .../net/ethernet/yunsilicon/xsc/pci/adev.c    |  115 +
 .../net/ethernet/yunsilicon/xsc/pci/adev.h    |   14 +
 .../net/ethernet/yunsilicon/xsc/pci/alloc.c   |  234 ++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |   17 +
 .../net/ethernet/yunsilicon/xsc/pci/cmdq.c    | 1576 +++++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  155 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c  |  343 +++
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h  |   46 +
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  |  278 +++
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h  |   18 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  389 ++++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.c |  429 ++++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.h |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  194 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |   15 +
 .../net/ethernet/yunsilicon/xsc/pci/vport.c   |   32 +
 46 files changed, 9825 insertions(+)
 create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h
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
2.18.4

