Return-Path: <netdev+bounces-171910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA1AA4F4DD
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7A53A9BD4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3FFD515;
	Wed,  5 Mar 2025 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhOkWAOh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF16ADD
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142901; cv=none; b=WQYfoOhrozJe2hLy5bF3OShnzMk18nR9f9RrYGfibskEKsXKxm2Ilo55zrOMlG800U2ORW8Qf15VpRdKJ59JMHoXxRuyjuBcANg5E2q2zC5ogutDKUB8TVA0b61j4Ruj7zC5hpd8/iNMdr+8flMJ8Bzq+s+8HC8jzKjyIMxHOEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142901; c=relaxed/simple;
	bh=H/xOnBKP0O41b9YD1jTBDyIcAz/aKGm+vlvzkCA+ocI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbOXDod9MJT1A60WuQOYmNaX2oMeC9weV30P6c7YK9AFzjP09rJYtgsf97UG+BC/XsVbn/i4KpHfvW9urkjcxnX3ZpnlzHDdU2R76sd+ZZumt0JIeOMOBxMqTa7z0NQfhUbGRQyaKoDVOrzHuXrNvkv5EKbiNDdNnBOSJPR0M3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhOkWAOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B37C4CEE5;
	Wed,  5 Mar 2025 02:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741142900;
	bh=H/xOnBKP0O41b9YD1jTBDyIcAz/aKGm+vlvzkCA+ocI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZhOkWAOhp+gON2rDQVX4ah0G44IFrLnof8LYnlj2QvCL+InGzCzfsKq6QISuUerJA
	 efZpwoQYsjFPiIKGJfnjojImjOKHjEu/d2furO6FdjsMTB+yeU0FXzv9QgncTtt/c3
	 IYJqTRGiTvJwd0/MJ92i4XgcEcjNAMOt7bEboRcwHUYQDa7NkVk1onpnh4Aveu9oFg
	 VjdeRutHAQzNuoSZ4eAYZIT0WPuRd7JikAd1dQIEojVByqUrW4+fZKlUei0NfBJ3hY
	 3BI8IkdSaOzWr7YkwnyT/lTOWGbHTuWQbSWW5ls8Ac3Nyf0oi8Vfi+f90UwUItKkRA
	 BBrxhWnq8MIvg==
Date: Tue, 4 Mar 2025 18:48:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>,
 <horms@kernel.org>, <parthiban.veerasooran@microchip.com>,
 <masahiroy@kernel.org>
Subject: Re: [PATCH net-next v7 01/14] xsc: Add xsc driver basic framework
Message-ID: <20250304184819.6e28c29a@kernel.org>
In-Reply-To: <20250228154122.216053-2-tianx@yunsilicon.com>
References: <20250228154122.216053-1-tianx@yunsilicon.com>
	<20250228154122.216053-2-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 23:41:24 +0800 Xin Tian wrote:
> +config NET_VENDOR_YUNSILICON
> +	depends on ARM64 || X86_64

|| COMPILE_TEST please ?

> diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
> new file mode 100644
> index 000000000..6fc8259a7
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Makefile for the Yunsilicon device drivers.
> +#
> +
> +# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/

Why are you adding commented out lines? Add them where needed

> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
> \ No newline at end of file

new line missing

> new file mode 100644
> index 000000000..de743487e
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon driver configuration
> +#
> +
> +config YUNSILICON_XSC_ETH
> +	tristate "Yunsilicon XSC ethernet driver"
> +	default n

n is the default, you don't have to specify it

> +xsc_eth-y := main.o
> \ No newline at end of file

new line

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
> new file mode 100644
> index 000000000..2b6d79905
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon PCI configuration
> +#
> +
> +config YUNSILICON_XSC_PCI
> +	tristate "Yunsilicon XSC PCI driver"
> +	default n

no need

> +	select PAGE_POOL

Why is this in the PCI driver, not the ETH driver?
Please add this line in a patch which actually makes use of page pool

> +static int set_dma_caps(struct pci_dev *pdev)
> +{
> +	int err;
> +
> +	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> +	if (err)
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	else
> +		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));

Please grep git history for dma_set_mask_and_coherent
The fallback is unnecessary, just:

	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));

> +	if (!err)
> +		dma_set_max_seg_size(&pdev->dev, SZ_2G);
> +
> +	return err;
> +}
-- 
pw-bot: cr

