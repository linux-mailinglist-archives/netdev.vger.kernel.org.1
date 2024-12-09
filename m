Return-Path: <netdev+bounces-150203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B5C9E975C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBFE1881D70
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D774233146;
	Mon,  9 Dec 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NxrhA0cc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB323313C
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751666; cv=none; b=ndaSHPmzZEaLVbaFFMfQXOP3jkfWdPTQurEnp3kn2yZTzdiIKO4ixF/ApTcx6UsWVa7fGwTk+BWYrkkYnTR0Od/UAku2IXx3UjcbbVGZSlsZY+tKR/63FACXaqs63G86LOY3+ibPIImpRtZYFtqj5JPIy6XV/TOrjbEJm7rwTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751666; c=relaxed/simple;
	bh=jS1f+tL1BhmQjKQgaN8uoNHbjXF2eXImmnOtunLddcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6sBw37JIjtpPb6hu4oIcNUxZIPSOFEXjSuqsxBk5hBlM8Cq534ZpF/GbtUSY5y7c+alveTUVRlnIY7ufA1ryCaNYoPWn9Dd4NPxL8xaqwn0GZKn3HD69+fzxyCU0UXtn5vdrADoiwN8A2pgS/+CayVQVVVq+qqGwN9RmnkM+U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NxrhA0cc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=av4IoxwwnMTetRXDEbyvF7gmDWy2jPDeyMe7ve9IPDs=; b=NxrhA0cco9ZaDK9vORgGjm4zhu
	aKWE5YkFP6r8X5z2HC7NvD3q+ikFT2B7Lb1IyMNl8Mvop9Ll/RI83ZAQBv0c2Uq4jbtWO6qP2I84u
	9gkdokpiKWHBJUKqHpPQ1Mk8JI+lNl5wsFLIJG15vb3+5qdqAm/Qb+T4wjxQ0rpHH2XQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKe0N-00Ffnv-Mr; Mon, 09 Dec 2024 14:40:55 +0100
Date: Mon, 9 Dec 2024 14:40:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tian Xin <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, weihg@yunsilicon.com
Subject: Re: [PATCH 08/16] net-next/yunsilicon: Add ethernet interface
Message-ID: <f4292a69-6956-4028-b5a2-c1b54893718f@lunn.ch>
References: <20241209071101.3392590-9-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209071101.3392590-9-tianx@yunsilicon.com>

On Mon, Dec 09, 2024 at 03:10:53PM +0800, Tian Xin wrote:
> From: Xin Tian <tianx@yunsilicon.com>
> 
> Build a basic netdevice driver
> 
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> ---
>  drivers/net/ethernet/yunsilicon/Makefile      |   2 +-
>  .../ethernet/yunsilicon/xsc/common/xsc_core.h |   1 +
>  .../net/ethernet/yunsilicon/xsc/net/main.c    | 135 ++++++++++++++++++
>  .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  16 +++
>  .../yunsilicon/xsc/net/xsc_eth_common.h       |  15 ++
>  5 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/main.c
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
> 
> diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
> index 950fd2663..c1d3e3398 100644
> --- a/drivers/net/ethernet/yunsilicon/Makefile
> +++ b/drivers/net/ethernet/yunsilicon/Makefile
> @@ -4,5 +4,5 @@
>  # Makefile for the Yunsilicon device drivers.
>  #
>  
> -# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
> +obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
>  obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
> \ No newline at end of file
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> index 88d4c5654..5d2b28e2e 100644
> --- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> @@ -498,6 +498,7 @@ struct xsc_core_device {
>  	struct pci_dev		*pdev;
>  	struct device		*device;
>  	struct xsc_priv		priv;
> +	void			*netdev;
>  	void			*eth_priv;
>  	struct xsc_dev_resource	*dev_res;
>  
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
> new file mode 100644
> index 000000000..243ec7ced
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#include <linux/reboot.h>

reboot.h in an ethernet driver? 

> +static int xsc_net_reboot_event_handler(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	pr_info("xsc net driver recv %lu event\n", action);
> +	xsc_remove_eth_driver();
> +
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block xsc_net_nb = {
> +	.notifier_call = xsc_net_reboot_event_handler,
> +	.next = NULL,
> +	.priority = 1,
> +};

This needs a comment explanation why this driver needs something
special during reboot.

    Andrew

---
pw-bot: cr

