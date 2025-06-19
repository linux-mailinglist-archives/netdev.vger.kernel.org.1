Return-Path: <netdev+bounces-199452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17526AE05C0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071DD1882DD0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D6A2459CF;
	Thu, 19 Jun 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oJe4224K"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34423E340
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335935; cv=none; b=TDpAxtXZ1Pd3nZqBwG2vCInof9OypDUfJdKwm87Df97pX+AF1XDPf3FUBq7H1GPVrJWJPSEttSPVoNAXsahOqQMdFxkyNFWvcAOu4OzbSgTMvwm1/t2KSzQEEVQnugSTkFy+xbq9Gky4Viq/AFgyPFtXQdIGcxyjOHIn2NpId28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335935; c=relaxed/simple;
	bh=2uqUEkLoOGHPgRUgeKr7HTWKvKpF3jQ6yu3Bk+AnzKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWBQ4oDrm4i+hvNPTGq+r+eYbVUfJqUf9liZYWJTp2foWu8dJyz0VWRK/AKB9XFl2UU8zMYg5FkWRyApLrKYuwXFRkv1Zr4NIhdDU2r2W+c82PobJwhBfE0fj5aKlNpW1nlmKNKkCtjohoCKB3SZ1P4vznbDFDo3X2TlksymscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oJe4224K; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <204a4dd1-62c6-4b7a-a8b4-ae0443517ad9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750335930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UrbHzjs1c0jORZasxILNsJ9l+lfSshbXE7NAvyGZhw=;
	b=oJe4224KUOHtFymN9TxDTJffXLZjbQ6cMTTt+wf8P1hsJpp28zQrHAeMNMdu1lOnUEpa6m
	pTczgAywSCathrkfpX+F4hFUBPtc3yfVfsuQ9PM10gWHf556a6j+afqHaeqfKKonjMPdC5
	w1SvTf79Z21VxcFTrwhOWABNjGIQKU4=
Date: Thu, 19 Jun 2025 13:25:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next, 01/10] bng_en: Add PCI interface
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com,
 Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-2-vikas.gupta@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250618144743.843815-2-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/06/2025 15:47, Vikas Gupta wrote:
> Add basic pci interface to the driver which supports
> the BCM5770X NIC family.
> 
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> ---
>   MAINTAINERS                                   |   6 +
>   drivers/net/ethernet/broadcom/Kconfig         |   8 +
>   drivers/net/ethernet/broadcom/Makefile        |   1 +
>   drivers/net/ethernet/broadcom/bnge/Makefile   |   5 +
>   drivers/net/ethernet/broadcom/bnge/bnge.h     |  16 ++
>   .../net/ethernet/broadcom/bnge/bnge_core.c    | 149 ++++++++++++++++++
>   6 files changed, 185 insertions(+)
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/Makefile
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge.h
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_core.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 507c5ff6f620..af349b77a92e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4854,6 +4854,12 @@ F:	drivers/firmware/broadcom/tee_bnxt_fw.c
>   F:	drivers/net/ethernet/broadcom/bnxt/
>   F:	include/linux/firmware/broadcom/tee_bnxt_fw.h
>   
> +BROADCOM BNG_EN 800 GIGABIT ETHERNET DRIVER
> +M:	Vikas Gupta <vikas.gupta@broadcom.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/ethernet/broadcom/bnge/
> +
>   BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS
>   M:	Arend van Spriel <arend.vanspriel@broadcom.com>
>   L:	linux-wireless@vger.kernel.org
> diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
> index 81a74e07464f..e2c1ac91708e 100644
> --- a/drivers/net/ethernet/broadcom/Kconfig
> +++ b/drivers/net/ethernet/broadcom/Kconfig
> @@ -253,6 +253,14 @@ config BNXT_HWMON
>   	  Say Y if you want to expose the thermal sensor data on NetXtreme-C/E
>   	  devices, via the hwmon sysfs interface.
>   
> +config BNGE
> +	tristate "Broadcom Ethernet device support"
> +	depends on PCI
> +	help
> +	  This driver supports Broadcom 50/100/200/400/800 gigabit Ethernet cards.
> +	  The module will be called bng_en. To compile this driver as a module,
> +	  choose M here.
> +
>   config BCMASP
>   	tristate "Broadcom ASP 2.0 Ethernet support"
>   	depends on ARCH_BRCMSTB || COMPILE_TEST
> diff --git a/drivers/net/ethernet/broadcom/Makefile b/drivers/net/ethernet/broadcom/Makefile
> index bac5cb6ad0cd..10cc1c92ecfc 100644
> --- a/drivers/net/ethernet/broadcom/Makefile
> +++ b/drivers/net/ethernet/broadcom/Makefile
> @@ -18,3 +18,4 @@ obj-$(CONFIG_BGMAC_PLATFORM) += bgmac-platform.o
>   obj-$(CONFIG_SYSTEMPORT) += bcmsysport.o
>   obj-$(CONFIG_BNXT) += bnxt/
>   obj-$(CONFIG_BCMASP) += asp2/
> +obj-$(CONFIG_BNGE) += bnge/
> diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
> new file mode 100644
> index 000000000000..0c3d632805d1
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_BNGE) += bng_en.o
> +
> +bng_en-y := bnge_core.o
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
> new file mode 100644
> index 000000000000..b49c51b44473
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Broadcom */
> +
> +#ifndef _BNGE_H_
> +#define _BNGE_H_
> +
> +#define DRV_NAME	"bng_en"
> +#define DRV_SUMMARY	"Broadcom 800G Ethernet Linux Driver"
> +
> +extern char bnge_driver_name[];
> +
> +enum board_idx {
> +	BCM57708,
> +};
> +
> +#endif /* _BNGE_H_ */
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> new file mode 100644
> index 000000000000..3778210da98d
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2025 Broadcom.
> +
> +#include <linux/init.h>
> +#include <linux/crash_dump.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "bnge.h"
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION(DRV_SUMMARY);
> +
> +char bnge_driver_name[] = DRV_NAME;
> +
> +static const struct {
> +	char *name;
> +} board_info[] = {
> +	[BCM57708] = { "Broadcom BCM57708 50Gb/100Gb/200Gb/400Gb/800Gb Ethernet" },
> +};
> +
> +static const struct pci_device_id bnge_pci_tbl[] = {
> +	{ PCI_VDEVICE(BROADCOM, 0x1780), .driver_data = BCM57708 },
> +	/* Required last entry */
> +	{0, }
> +};
> +MODULE_DEVICE_TABLE(pci, bnge_pci_tbl);
> +
> +static void bnge_print_device_info(struct pci_dev *pdev, enum board_idx idx)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	dev_info(dev, "%s found at mem %lx\n", board_info[idx].name,
> +		 (long)pci_resource_start(pdev, 0));
> +
> +	pcie_print_link_status(pdev);
> +}
> +
> +static void bnge_pci_disable(struct pci_dev *pdev)
> +{
> +	pci_release_regions(pdev);
> +	if (pci_is_enabled(pdev))
> +		pci_disable_device(pdev);
> +}
> +
> +static int bnge_pci_enable(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = pci_enable_device(pdev);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Cannot enable PCI device, aborting\n");
> +		return rc;
> +	}
> +
> +	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
> +		dev_err(&pdev->dev,
> +			"Cannot find PCI device base address, aborting\n");
> +		rc = -ENODEV;
> +		goto err_pci_disable;
> +	}
> +
> +	rc = pci_request_regions(pdev, bnge_driver_name);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Cannot obtain PCI resources, aborting\n");
> +		goto err_pci_disable;
> +	}
> +
> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) != 0 &&
> +	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
> +		dev_err(&pdev->dev, "System does not support DMA, aborting\n");
> +		rc = -EIO;
> +		goto err_pci_release;
> +	}

According to https://docs.kernel.org/core-api/dma-api-howto.html the
code above is not correct. dma_set_mask_and_coherent() will never return
fail when DMA_BIT_MASK(64).


> +
> +	pci_set_master(pdev);
> +
> +	return 0;
> +
> +err_pci_release:
> +	pci_release_regions(pdev);
> +
> +err_pci_disable:
> +	pci_disable_device(pdev);
> +	return rc;
> +}
> +
> +static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	int rc;
> +
> +	if (pci_is_bridge(pdev))
> +		return -ENODEV;
> +
> +	if (!pdev->msix_cap) {
> +		dev_err(&pdev->dev, "MSIX capability missing, aborting\n");
> +		return -ENODEV;
> +	}
> +
> +	if (is_kdump_kernel()) {
> +		pci_clear_master(pdev);
> +		pcie_flr(pdev);
> +	}
> +
> +	rc = bnge_pci_enable(pdev);
> +	if (rc)
> +		return rc;
> +
> +	bnge_print_device_info(pdev, ent->driver_data);
> +
> +	pci_save_state(pdev);
> +
> +	return 0;
> +}
> +
> +static void bnge_remove_one(struct pci_dev *pdev)
> +{
> +	bnge_pci_disable(pdev);
> +}
> +
> +static void bnge_shutdown(struct pci_dev *pdev)
> +{
> +	pci_disable_device(pdev);
> +
> +	if (system_state == SYSTEM_POWER_OFF) {
> +		pci_wake_from_d3(pdev, 0);
> +		pci_set_power_state(pdev, PCI_D3hot);
> +	}
> +}
> +
> +static struct pci_driver bnge_driver = {
> +	.name		= bnge_driver_name,
> +	.id_table	= bnge_pci_tbl,
> +	.probe		= bnge_probe_one,
> +	.remove		= bnge_remove_one,
> +	.shutdown	= bnge_shutdown,
> +};
> +
> +static int __init bnge_init_module(void)
> +{
> +	return pci_register_driver(&bnge_driver);
> +}
> +module_init(bnge_init_module);
> +
> +static void __exit bnge_exit_module(void)
> +{
> +	pci_unregister_driver(&bnge_driver);
> +}
> +module_exit(bnge_exit_module);


