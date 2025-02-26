Return-Path: <netdev+bounces-169728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD61A4568C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 08:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2A53A6C7E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9826267F56;
	Wed, 26 Feb 2025 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldJ0zA0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A618DB11
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554539; cv=none; b=SUjXMQbUdG8zESgl/LujtBlGIkWTcYil01vc6T73WL/zOXXXJjb/ojjPnw+6hUzWy+vf1HPVCbnm88jYk/lsUtUszZRi6pNq35QnTB9S53RByjnXkwwDblppSX6bqugGTDccAkEFzqHD28s9SaN/ftHSHe9ftP/gLNfP1yQoTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554539; c=relaxed/simple;
	bh=qlUGdTR/eNVoL47QEdbsLsJVj7/CcqJ9dH4wUaYor9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxumoUcBZ57HNJJ95hLPm40+BohAkdYRFR/IwciqWn/y2eJshdU/OCv2AXqsjFirlclPELLgt0YvTKGR6nnq/vliT0jUJiN1BMdIWWlGKK55GpRBPIQtJJYwaNEvc0YoCuQs38AsjkM51axNtyRE8MAx2AvcExyAXshn8DeIxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldJ0zA0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E26C4CED6;
	Wed, 26 Feb 2025 07:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740554539;
	bh=qlUGdTR/eNVoL47QEdbsLsJVj7/CcqJ9dH4wUaYor9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldJ0zA0BbRnvj+yAh1TnSMYP5bd+966/vU80U3DkeFFmhSOuk0ooLYwbEO74+fFJo
	 uRb5SlPyxFPsDKzMghNTC/ftpPnLz75A5L5H+g/hmfvugfaQnKRAD/6Enw2df3kzEV
	 UNZ1TQCPiQt8YKhgh84RWlXrwj+XKmO15cWp4eR1tlbDVINFwBbBwlv8Oxrwcemo4E
	 o7WLsfWaWwTVzDIWBxyx3ybccFaUKR1YH27WHfbPGh2xVlnRId2NI+B3F1L7CHj4yr
	 QS97QOJXHno926cTHDcc9+1pDLoAzam0IQSwWDO0xwJ7irngyhrliu5M0Nrs3mKDTZ
	 k7SLlWAWTH+Vw==
Date: Wed, 26 Feb 2025 09:22:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com, horms@kernel.org,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org
Subject: Re: [PATCH net-next v5 07/14] xsc: Init auxiliary device
Message-ID: <20250226072215.GI53094@unreal>
References: <20250224172416.2455751-1-tianx@yunsilicon.com>
 <20250224172429.2455751-8-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224172429.2455751-8-tianx@yunsilicon.com>

On Tue, Feb 25, 2025 at 01:24:31AM +0800, Xin Tian wrote:
> Our device supports both Ethernet and RDMA functionalities, and
> leveraging the auxiliary bus perfectly addresses our needs for
> managing these distinct features. This patch utilizes auxiliary
> device to handle the Ethernet functionality, while defining
> xsc_adev_list to reserve expansion space for future RDMA
> capabilities.
> 
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> ---
>  .../ethernet/yunsilicon/xsc/common/xsc_core.h |  14 +++
>  .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
>  .../net/ethernet/yunsilicon/xsc/pci/adev.c    | 112 ++++++++++++++++++
>  .../net/ethernet/yunsilicon/xsc/pci/adev.h    |  14 +++
>  .../net/ethernet/yunsilicon/xsc/pci/main.c    |  10 ++
>  5 files changed, 152 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h

<...>

> +// adev

Please follow standard C comment style // -> /* ... */ for one line
comments. Also this "adev" comment doesn't add any information.

> +#define XSC_PCI_DRV_NAME "xsc_pci"
> +#define XSC_ETH_ADEV_NAME "eth"
> +
> +struct xsc_adev {
> +	struct auxiliary_device	adev;
> +	struct xsc_core_device	*xdev;
> +
> +	int			idx;
> +};
> +
>  // hw
>  struct xsc_reg_addr {
>  	u64	tx_db;
> @@ -354,6 +366,8 @@ enum xsc_interface_state {
>  struct xsc_core_device {
>  	struct pci_dev		*pdev;
>  	struct device		*device;
> +	int			adev_id;
> +	struct xsc_adev		**xsc_adev_list;
>  	void			*eth_priv;
>  	struct xsc_dev_resource	*dev_res;
>  	int			numa_node;
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> index 3525d1c74..ad0ecc122 100644
> --- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> @@ -6,4 +6,5 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
>  
>  obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
>  
> -xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o
> +xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o adev.o
> +
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
> new file mode 100644
> index 000000000..94db3893a
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/idr.h>
> +
> +#include "adev.h"
> +
> +static DEFINE_IDA(xsc_adev_ida);
> +
> +enum xsc_adev_idx {
> +	XSC_ADEV_IDX_ETH,
> +	XSC_ADEV_IDX_MAX

There is no need in XSC_ADEV_IDX_MAX, please rely on ARRAY_SIZE(xsc_adev_name).

> +};
> +
> +static const char * const xsc_adev_name[] = {
> +	[XSC_ADEV_IDX_ETH] = XSC_ETH_ADEV_NAME,
> +};

<...>

> +int xsc_adev_init(struct xsc_core_device *xdev)
> +{
> +	struct xsc_adev **xsc_adev_list;
> +	int adev_id;
> +	int ret;
> +
> +	xsc_adev_list = kzalloc(sizeof(void *) * XSC_ADEV_IDX_MAX, GFP_KERNEL);

kcalloc(ARRAY_SIZE(xsc_adev_name), sizeof(struct xsc_adev *), GFP_KERNEL);

Thanks

