Return-Path: <netdev+bounces-175780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA72A67776
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA39F880617
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA5020E024;
	Tue, 18 Mar 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="i/qCPP5M"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17A146D65
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310941; cv=none; b=BpEzdB/SmkQky6FQR0DMf3iMU40CWUeqDolYkrHuiHZcpapNE5hp+IhPIE5FNHAEL1gb0sRjZWoDTcxZ/QRd6bRvPlTVnkpLXnHCVDM1xjXLOgbUdLLjNMMJq8WtUB2Wsy0uRL1+LNqP5jzTBN78ujSjihNoNhux3F4rkTvPO/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310941; c=relaxed/simple;
	bh=dbrAd354cltippqkS1BT0083iEoM3MOeeOUbNc9FYH4=;
	h=Message-Id:Content-Type:Cc:Date:Mime-Version:From:Subject:To; b=SjRgdoEMdtSxN78Th+2E594BCoIsMvlreETTKdxH95nMV/dnNc1TiUIU6DPSBP1/ewWSqjKIywndxjEmBvybnXCXABUk4GmFeMg4Y5DAXt0cUQocA3ff7lo+vWAB2IyRVkc2xjmZwUlJAIqQTqsMaaTfOvQPCwoH/9a1ZiMp64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=i/qCPP5M; arc=none smtp.client-ip=209.127.231.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1742310928; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=SGAJWnQpfu0cuWNSAphgScgVHLVGmkgPn4ItWZJbIIw=;
 b=i/qCPP5M9EGi0O9+n7okonekBnNi4lgRPAtu3cSCRj8d/y9QdyLMVpGLz+NU2WinxJ/Jm4
 tHAjoI7v7ZLIH1twXkEINouAiHmHqybTHPsiSL0t8577iFNhm11cX0eHa9Zjw8F7Mo5beP
 S/zlb8bhqYSzxNj1VAK43F7c7ybS/UN7C6MhKkKgIjsMvym28hjKaP97Dz3h8B3/dD/Koc
 F5Lb9ZvX2GE/sAR9mMe2sRvuJEFWG0fB9W13ML/RVWPTDZR9VizwxOJphoaALahPCZDRd0
 mg4hGgUTSE+Irga0fi+IGUUTHz9WNBC8NSEJGG7rl7KZFZvxSJWoytOh3bAsDg==
Message-Id: <20250318151449.1376756-1-tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
Date: Tue, 18 Mar 2025 23:15:26 +0800
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Tue, 18 Mar 2025 23:15:26 +0800
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: [PATCH net-next v9 00/14] xsc: ADD Yunsilicon XSC Ethernet Driver
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>
X-Lms-Return-Path: <lba+267d98e0e+3271b2+vger.kernel.org+tianx@yunsilicon.com>

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

Changes v8->v9:
Link to v8: https://lore.kernel.org/netdev/20250307100824.555320-1-tianx@yunsilicon.com/
1. correct netdev feature settings in Patch09 (Paolo)
2. change sizes from int to unsigned int in Patch02 (Geert)
3. nit in Patch02: min_t->min, use upper_32_bits/lower_32_bits() (Simon)

Changes v7->v8:
Link to v7: https://lore.kernel.org/netdev/20250228154122.216053-1-tianx@yunsilicon.com/
1. add Kconfig NET_VENDOR_YUNSILICON depneds on COMPILE_TEST (Jakub)
2. rm unnecessary "default n" (Jakub)
3. select PAGE_POOL in ETH driver (Jakub)
4. simplify dma_mask set (Jakub)
5. del pci_state and pci_state_mutex (Kalesh)
6. I checked and droped intf_state and int_state_mutex too
7. del some no need lables in patch1 (Kalesh)
8. ensure consistent label naming throughout the patchset (Simon)
9. WARN_ONCE instead of meaningless comments (Simon)
10. Patch 7 add Reviewed-by from Leon Romanovsky, thanks Leon
11. nits

Changes v6->v7:
Link to v6: https://lore.kernel.org/netdev/20250227082558.151093-1-tianx@yunsilicon.com/
1. use _pool_zalloc/vzalloc instead of (_pool_alloc/vmalloc + memset 0)
2. correct kfree for kvmalloc memory
3. del comment using NULL adapter pointer
4. correct num_dma type to int in xsc_eth_tx.c
- Jakub Kicinski

Changes v5->v6:
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
- Leon Romanovsky
2. Add more detailed description for patches
3. use FIELD_PREP() and FIELD_GET() instead of XSC_SET/GET_FIELD
4. fix sparse complains about endian and types
5. use unsigned types for unsigned values
6. del BITS_PER_LONG == 64 check in xsc_buf_alloc
7. use GENMASK and DIV_ROUND_UP to replace the unclear code
- Simon Horman

Changes v3->v4:
Link to v3: https://lore.kernel.org/netdev/20250115102242.3541496-1-tianx@yunsilicon.com/
1. pci_ioremap_bar returns a negative value in pci_init.
2. Adjust the declaration order to follow the reverse xmastree rule.
3. Split lines that exceed 80 columns.
4. Use XSC_SET_FIELD and XSC_GET_FIELD instead of bitfields.
- Simon Horman
5. Use big-endian consistently in cmds
6. Add comments for sem and rsv0.
7. Change mode to enum in xsc_cmd, and rename bitmask to cmd_entry_mask.
8. Remove unnecessary header files such as kernel.h and init.h.
9. Add the xsc prefix to function names.
10. Return ENOSPC if alloc_ent fails.
11. Adjust the position of free_cmd.
12. Separate different categories of #include statements with blank lines.
13. Use status instead of admin_status xsc_event_set_port_admin_status_mbox_in
- Przemek Kitszel

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
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  498 ++++
 .../yunsilicon/xsc/common/xsc_device.h        |   77 +
 .../yunsilicon/xsc/common/xsc_driver.h        |   26 +
 .../ethernet/yunsilicon/xsc/common/xsc_pp.h   |   38 +
 .../net/ethernet/yunsilicon/xsc/net/Kconfig   |   17 +
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |    9 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 1993 +++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |   55 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  224 ++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |  601 +++++
 .../yunsilicon/xsc/net/xsc_eth_stats.c        |   46 +
 .../yunsilicon/xsc/net/xsc_eth_stats.h        |   34 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  321 +++
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  188 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |   91 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.c  |   80 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.h  |  187 ++
 .../net/ethernet/yunsilicon/xsc/net/xsc_pph.h |  180 ++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  206 ++
 .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |   14 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   10 +
 .../net/ethernet/yunsilicon/xsc/pci/adev.c    |  115 +
 .../net/ethernet/yunsilicon/xsc/pci/adev.h    |   14 +
 .../net/ethernet/yunsilicon/xsc/pci/alloc.c   |  234 ++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |   17 +
 .../net/ethernet/yunsilicon/xsc/pci/cmdq.c    | 1571 +++++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  155 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c  |  340 +++
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h  |   46 +
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  |  283 +++
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h  |   18 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  326 +++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.c |  426 ++++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.h |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  194 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |   14 +
 .../net/ethernet/yunsilicon/xsc/pci/vport.c   |   32 +
 46 files changed, 9709 insertions(+)
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
2.43.0

