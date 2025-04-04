Return-Path: <netdev+bounces-179339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71607A7C090
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86161796E7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B4D1F2B88;
	Fri,  4 Apr 2025 15:29:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA73D6F;
	Fri,  4 Apr 2025 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743780554; cv=none; b=iY4wdcbZxUJAAZeYHclH3wNg0W2enN+gOd4N4+MGoB24vJqczrTQEep4UxN/zIWTcX+hhpc3dm3geSAqtUd8IPw/77CaZ9xM8xJVsoBpvB+KrKhxABHmbFW4LcS6q6UaIgCtgUoHnW+RG5IzfwZlF1vBVetNVbNYsRpTHNUE+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743780554; c=relaxed/simple;
	bh=SWfKABsP6PS4dxpQPvAETNqmzdEbTRbmiYiJ5wxXlfM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qF00SMwTBkaDzih08zIQrOEWEPdPsSyVK5/JnunFGfbMGPkTLLW4BPeR9iPMqXLc6tC42B47z4xubK30fhC7EevG2y1CJD7SjlUISLry1qBeNBXWxxjMXBPKMWpCkiDQLuYhFHmJMiNXqKs2ssLeAae3BqOgafkx7thmiKi2bBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTj946F3Zz6K932;
	Fri,  4 Apr 2025 23:25:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B9E631409C9;
	Fri,  4 Apr 2025 23:29:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 17:29:09 +0200
Date: Fri, 4 Apr 2025 16:29:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v12 02/23] sfc: add cxl support
Message-ID: <20250404162907.00000faa@huawei.com>
In-Reply-To: <20250331144555.1947819-3-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
	<20250331144555.1947819-3-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 31 Mar 2025 15:45:34 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Some trivial formatting stuff.  With that tidied up and taking into
account I don't know the sfc side of things at all.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/net/ethernet/sfc/Kconfig      |  8 ++++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 55 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 +++++
>  6 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 3eb55dcfa8a6..c5fb71e601e7 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -65,6 +65,14 @@ config SFC_MCDI_LOGGING
>  	  Driver-Interface) commands and responses, allowing debugging of
>  	  driver/firmware interaction.  The tracing is actually enabled by
>  	  a sysfs file 'mcdi_logging' under the PCI device.
Odd spacing.  Maybe a blank line here and one less below?
> +config SFC_CXL
> +	bool "Solarflare SFC9100-family CXL support"
> +	depends on SFC && CXL_BUS >= SFC
> +	default SFC
> +	help
> +	  This enables SFC CXL support if the kernel is configuring CXL for
> +	  using CTPIO with CXL.mem
> +
>  
>  source "drivers/net/ethernet/sfc/falcon/Kconfig"

> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index f70a7b7d6345..a2626bcd6a41 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1201,14 +1201,24 @@ struct efx_nic {
>  	atomic_t n_rx_noskb_drops;
>  };
>  
> +#ifdef CONFIG_SFC_CXL
> +struct efx_cxl;
> +#endif
> +
>  /**
>   * struct efx_probe_data - State after hardware probe
>   * @pci_dev: The PCI device
>   * @efx: Efx NIC details
> + * @cxl: details of related cxl objects

Details of CXL objects.  If NIC gets capitals - we want the too :)
(both to start description and for the CXL).

> + * @cxl_pio_initialised: cxl initialization outcome.
>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
>  	struct efx_nic efx;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_cxl *cxl;
> +	bool cxl_pio_initialised;
> +#endif
>  };
>  
>  static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)


