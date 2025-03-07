Return-Path: <netdev+bounces-172870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7BEA565A1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC837A5FE2
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F7E20E302;
	Fri,  7 Mar 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="T0HfLPvk"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-14.ptr.blmpb.com (va-1-14.ptr.blmpb.com [209.127.230.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F020E6F2
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344066; cv=none; b=c/2xdZVh3K3AIKRvcqrEj90e2EqWrcL46rhvZU/4/mpGIEFdvzAvVMiTzzDRnOIV9L+rS1uSgeG3/jJpvgKfsu2YVJVI9+xNW9PDu/5gWXx5h7tAjx/Ulg5ZwlxT9gilor6Ize2YMkYQ6GlZh9pOifw5OwCC2hEWsIUDPoH5YlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344066; c=relaxed/simple;
	bh=V9ryqXo2CF47dIRh18uFDY89hVfy81vfU1544e96CPM=;
	h=To:Cc:Message-Id:Date:Mime-Version:References:Content-Type:From:
	 Subject:In-Reply-To; b=h9HYI45T2QURoJgHQP9+qGh+wDXhLpja4lwwI1ZCUtIwKo18zO+5BnR8wNbECCEYBOJP90Ijg9M2Rk5jCipabfRFPnENXzMbDW0H/dMSxTpimqYfxHe4gX4R4UEe7OBwToK3EeewIcUZK6dkaHy7sPA7O/kdRcD4lyTzxTAUQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=T0HfLPvk; arc=none smtp.client-ip=209.127.230.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741344052; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sQpZchRqH24STk9QIJLpNT9JOfjsvF0CuV0A+ZmRlhk=;
 b=T0HfLPvkh2cqXwoER1Ings044n5brWKHNHlQvfeZDtZbIyU/BpNP9D7ao3iWu5AXSvV+uq
 U9sBMT/SpG2JssO5EELGVNA1weQ9PsGdZcyEZH0W+298TZJlPRdvcQDgCKTqGbJEhHmuYO
 KmhEEZx8hbO000bSKJ0hJPxj5/ZsG8McmF6eBimREiHBQ5cuhUQjAvMjTWdJCb/TBAxXpr
 LPPgD5bdFAWIK5rdJRox3ropFjfgNG5xzSeJ1Sx67FBi2ecQ0OiQAhFLCqYJ4SvTvRf8DO
 cEz3JnpDhSq60MGTo4K750dpLt04V4sGW+XlK8aZ339mMTFcfI38XG3C45+Qiw==
To: <netdev@vger.kernel.org>, <horms@kernel.org>, <kuba@kernel.org>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>, 
	<kalesh-anakkur.purayil@broadcom.com>, <geert+renesas@glider.be>
Message-Id: <eed857bc-1d8f-4d3d-aeaa-868b6957ddca@yunsilicon.com>
Date: Fri, 7 Mar 2025 18:40:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307100824.555320-1-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267cacd32+58ee53+vger.kernel.org+tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: Re: [PATCH net-next v8 00/14] xsc: ADD Yunsilicon XSC Ethernet Driver
X-Original-From: Xin Tian <tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <20250307100824.555320-1-tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Fri, 07 Mar 2025 18:40:49 +0800
Content-Transfer-Encoding: 7bit

Hi, Jakub, Simon, all

Our patch set is quite large, and the feedback so far has mainly focused on
the first 7 patches, with less attention on the later ones.

To make it easier to review and merge, I'm considering splitting the 
patch set
into two parts: submitting the PCI driver now and the Ethernet driver
in a later series.

Would this approach be better? Is it appropriate to submit a PCI driver
without actual functionality to net-next?

Thanks,
Xin


On 2025/3/7 18:09, Xin Tian wrote:
> The patch series adds the xsc driver, which will support the YunSilicon
> MS/MC/MV series of network cards. These network cards offer support for
> high-speed Ethernet and RDMA networking, with speeds of up to 200Gbps.
>
> The Ethernet functionality is implemented by two modules. One is a
> PCI driver(xsc_pci), which provides PCIe configuration,
> CMDQ service (communication with firmware), interrupt handling,
> hardware resource management, and other services, while offering
> common interfaces for Ethernet and future InfiniBand drivers to
> utilize hardware resources. The other is an Ethernet driver(xsc_eth),
> which handles Ethernet interface configuration and data
> transmission/reception.
>
> - Patches 1-7 implement the PCI driver
> - Patches 8-14 implement the Ethernet driver
>
> This submission is the first phase, which includes the PF-based Ethernet
> transmit and receive functionality. Once this is merged, we will submit
> additional patches to implement support for other features, such as SR-IOV,
> ethtool support, and a new RDMA driver.
>
> Change v7->v8:
> Link to v7: https://lore.kernel.org/netdev/20250228154122.216053-1-tianx@yunsilicon.com/
> 1. add Kconfig NET_VENDOR_YUNSILICON depneds on COMPILE_TEST (Jakub)
> 2. rm unnecessary "default n" (Jakub)
> 3. select PAGE_POOL in ETH driver (Jakub)
> 4. simplify dma_mask set (Jakub)
> 5. del pci_state and pci_state_mutex (Kalesh)
> 6. I checked and droped intf_state and int_state_mutex too
> 7. del some no need lables in patch1 (Kalesh)
> 8. ensure consistent label naming throughout the patchset (Simon)
> 9. WARN_ONCE instead of meaningless comments (Simon)
> 10. nits
>
> Change v6->v7:
> Link to v6: https://lore.kernel.org/netdev/20250227082558.151093-1-tianx@yunsilicon.com/
> 1. use _pool_zalloc/vzalloc instead of (_pool_alloc/vmalloc + memset 0)
> 2. correct kfree for kvmalloc memory
> 3. del comment using NULL adapter pointer
> 4. correct num_dma type to int in xsc_eth_tx.c
> - Jakub Kicinski
>
> Change v5->v6:
> Link to v5: https://lore.kernel.org/netdev/20250224172416.2455751-1-tianx@yunsilicon.com/
> 1. fix error return in xsc_adev_init
> - Jakub Kicinski
> 2. comment style // -> /* ... */
> 3. remove XSC_ADEV_IDX_MAX, and use ARRAY_SIZE() instead
> 4. kcalloc for array alloc instead of kzalloc
> - Leon Romanovsky
> 5. prefetch/perfetchw to net_prefetch/net_prefetch
> - Joe Damato
>
> Changes v4->v5:
> Link to v4: https://lore.kernel.org/netdev/20250213091402.2067626-1-tianx@yunsilicon.com/
> 1. free xsc_adev in release callback
> - Leon Romanovsky
> 2. Add more detailed description for patches
> 3. use FIELD_PREP() and FIELD_GET() instead of XSC_SET/GET_FIELD
> 4. fix sparse complains about endian and types
> 5. use unsigned types for unsigned values
> 6. del BITS_PER_LONG == 64 check in xsc_buf_alloc
> 7. use GENMASK and DIV_ROUND_UP to replace the unclear code
> - Simon Horman
>
> Changes v3->v4:
> Link to v3: https://lore.kernel.org/netdev/20250115102242.3541496-1-tianx@yunsilicon.com/
> 1. pci_ioremap_bar returns a negative value in pci_init.
> 2. Adjust the declaration order to follow the reverse xmastree rule.
> 3. Split lines that exceed 80 columns.
> 4. Use XSC_SET_FIELD and XSC_GET_FIELD instead of bitfields.
> - Simon Horman
> 5. Use big-endian consistently in cmds
> 6. Add comments for sem and rsv0.
> 7. Change mode to enum in xsc_cmd, and rename bitmask to cmd_entry_mask.
> 8. Remove unnecessary header files such as kernel.h and init.h.
> 9. Add the xsc prefix to function names.
> 10. Return ENOSPC if alloc_ent fails.
> 11. Adjust the position of free_cmd.
> 12. Separate different categories of #include statements with blank lines.
> 13. Use status instead of admin_status xsc_event_set_port_admin_status_mbox_in
> - Przemek Kitszel
>
> Changes v2->v3:
> Link to v2: https://lore.kernel.org/netdev/20241230101513.3836531-1-tianx@yunsilicon.com/
> 1. Use auxiliary bus for ethernet functionality.
> - Leon Romanovsky comments
> 2. Remove netdev from struct xsc_core_device, as it can be accessed via eth_priv.
> - Andrew Lunn comments
>
> Changes v1->v2:
> Link to v1: https://lore.kernel.org/netdev/20241218105023.2237645-1-tianx@yunsilicon.com/
> 1. Remove the last two patches to reduce the total code submitted.
> - Jakub Kicinski comments
> 2. Remove the custom logging interfaces and switch to using
>     pci_xxx/netdev_xxx logging interfaces. Delete the related
>     module parameters.
> 3. No use of inline functions in .c files.
> 4. Remove unnecessary license information.
> 5. Remove unnecessary void casts.
> - Andrew Lunn comments
> 6. Use double underscore (__) for header file macros.
> 7. Fix the depend field in Kconfig.
> 8. Add sign-off for co-developers.
> 9. use string directly in MODULE_DESCRIPTION
> 10. Fix poor formatting issues in the code.
> 11. Modify some macros that don't use the XSC_ prefix.
> 12. Remove unused code from xsc_cmd.h that is not part of this patch series.
> 13. No comma after items in a complete enum.
> 14. Use the BIT() macro to define constants related to bit operations.
> 15. Add comments to clarify names like ver, cqe, eqn, pas, etc.
> - Przemek Kitszel comments
>
> Changes v0->v1:
> 1. name xsc_core_device as xdev instead of dev
> 2. modify Signed-off-by tag to Co-developed-by
> 3. remove some obvious comments
> 4. remove unnecessary zero-init and NULL-init
> 5. modify bad-named goto labels
> 6. reordered variable declarations according to the RCT rule
> - Przemek Kitszel comments
> 7. add MODULE_DESCRIPTION()
> - Jeff Johnson comments
> 8. remove unnecessary dev_info logs
> 9. replace these magic numbers with #defines in xsc_eth_common.h
> 10. move code to right place
> 11. delete unlikely() used in probe
> 12. remove unnecessary reboot callbacks
> - Andrew Lunn comments
>
> Xin Tian (14):
>    xsc: Add xsc driver basic framework
>    xsc: Enable command queue
>    xsc: Add hardware setup APIs
>    xsc: Add qp and cq management
>    xsc: Add eq and alloc
>    xsc: Init pci irq
>    xsc: Init auxiliary device
>    xsc: Add ethernet interface
>    xsc: Init net device
>    xsc: Add eth needed qp and cq apis
>    xsc: ndo_open and ndo_stop
>    xsc: Add ndo_start_xmit
>    xsc: Add eth reception data path
>    xsc: add ndo_get_stats64
>
>   MAINTAINERS                                   |    7 +
>   drivers/net/ethernet/Kconfig                  |    1 +
>   drivers/net/ethernet/Makefile                 |    1 +
>   drivers/net/ethernet/yunsilicon/Kconfig       |   26 +
>   drivers/net/ethernet/yunsilicon/Makefile      |    8 +
>   .../yunsilicon/xsc/common/xsc_auto_hw.h       |   94 +
>   .../ethernet/yunsilicon/xsc/common/xsc_cmd.h  |  630 ++++++
>   .../ethernet/yunsilicon/xsc/common/xsc_cmdq.h |  234 ++
>   .../ethernet/yunsilicon/xsc/common/xsc_core.h |  500 +++++
>   .../yunsilicon/xsc/common/xsc_device.h        |   77 +
>   .../yunsilicon/xsc/common/xsc_driver.h        |   25 +
>   .../ethernet/yunsilicon/xsc/common/xsc_pp.h   |   38 +
>   .../net/ethernet/yunsilicon/xsc/net/Kconfig   |   17 +
>   .../net/ethernet/yunsilicon/xsc/net/Makefile  |    9 +
>   .../net/ethernet/yunsilicon/xsc/net/main.c    | 1984 +++++++++++++++++
>   .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |   55 +
>   .../yunsilicon/xsc/net/xsc_eth_common.h       |  239 ++
>   .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |  601 +++++
>   .../yunsilicon/xsc/net/xsc_eth_stats.c        |   46 +
>   .../yunsilicon/xsc/net/xsc_eth_stats.h        |   34 +
>   .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  321 +++
>   .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  188 ++
>   .../yunsilicon/xsc/net/xsc_eth_txrx.h         |   91 +
>   .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.c  |   80 +
>   .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.h  |  187 ++
>   .../net/ethernet/yunsilicon/xsc/net/xsc_pph.h |  180 ++
>   .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  206 ++
>   .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |   14 +
>   .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   10 +
>   .../net/ethernet/yunsilicon/xsc/pci/adev.c    |  115 +
>   .../net/ethernet/yunsilicon/xsc/pci/adev.h    |   14 +
>   .../net/ethernet/yunsilicon/xsc/pci/alloc.c   |  234 ++
>   .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |   17 +
>   .../net/ethernet/yunsilicon/xsc/pci/cmdq.c    | 1568 +++++++++++++
>   drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  155 ++
>   drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |   14 +
>   drivers/net/ethernet/yunsilicon/xsc/pci/eq.c  |  340 +++
>   drivers/net/ethernet/yunsilicon/xsc/pci/eq.h  |   46 +
>   drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  |  283 +++
>   drivers/net/ethernet/yunsilicon/xsc/pci/hw.h  |   18 +
>   .../net/ethernet/yunsilicon/xsc/pci/main.c    |  326 +++
>   .../net/ethernet/yunsilicon/xsc/pci/pci_irq.c |  426 ++++
>   .../net/ethernet/yunsilicon/xsc/pci/pci_irq.h |   14 +
>   drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  194 ++
>   drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |   14 +
>   .../net/ethernet/yunsilicon/xsc/pci/vport.c   |   32 +
>   46 files changed, 9713 insertions(+)
>   create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/main.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_pph.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/vport.c
>
> --
> 2.43.0

