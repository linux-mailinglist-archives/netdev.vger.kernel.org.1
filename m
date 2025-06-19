Return-Path: <netdev+bounces-199455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D4AE0602
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7B83B6CDF
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442892192F4;
	Thu, 19 Jun 2025 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H5f/uaEw"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46D3085B2
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336483; cv=none; b=iRpBi4gryM+Ko2iUoLtK+Tzq0BfV28pyLUabXDbrXt0oIOzz9fswqMIbyoFl+7lQBNj97bOMOu4ppGTgP/BgCQTfAduZ/0/xoeg0XjnwqOF0tsEd3ykpTMtHdK7oZC68vZoWlX/n46dxu7piE29DR4ZJ6UAdpLLiP3UWGp625T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336483; c=relaxed/simple;
	bh=aH6p6HB/Pys3+bPvWhy6OOeDMsfg4kesiNVISlZjR1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBMy4upW961xM+l4UpuBXuy4TxyFx1nhi8OtF3LzoLFqrA+V8FLP0pfpaCQGeSGvLHj5rEXgBllhVnTe8V9++zzy1lrdiIZJAa9ts6Z7cVkB3OB0+S4bJDXCnZ+BomvxE5BXS0ZidAEc/eAwmBTmJ+ht6Xws3wyTKG2ECoTx1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H5f/uaEw; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5852c15d-5bef-49b5-841a-6183493bd29c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750336478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giUaj8Z65HU2PBeP2Sd3v+QNHG/z3XgwofMJ8JENQgI=;
	b=H5f/uaEwpkx6WIgRbDa/Yyt6cZTVN/s2B2c9yZd7cwYKQGWPiuHlPQ5p67ad7nRJFRQ1a5
	DYnHMAvuVmDWSS9tnpdSD91rB0QXpY1HJlYmdXPsmPxywk7kwlKSspMwxPvnV5FXmw6REF
	cFvgYEtNJVpAsMTe5Xht5pkVOnzxL8g=
Date: Thu, 19 Jun 2025 13:34:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next, 02/10] bng_en: Add devlink interface
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com,
 Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-3-vikas.gupta@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250618144743.843815-3-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/06/2025 15:47, Vikas Gupta wrote:
> Allocate a base device and devlink interface with minimal
> devlink ops.
> Add dsn and board related information.
> Map PCIe BAR (bar0), which helps to communicate with the
> firmware.
> 
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/Kconfig         |   1 +
>   drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
>   drivers/net/ethernet/broadcom/bnge/bnge.h     |  11 ++
>   .../net/ethernet/broadcom/bnge/bnge_core.c    |  43 +++++
>   .../net/ethernet/broadcom/bnge/bnge_devlink.c | 147 ++++++++++++++++++
>   .../net/ethernet/broadcom/bnge/bnge_devlink.h |  18 +++
>   6 files changed, 222 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
> 
> diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
> index e2c1ac91708e..0fc10e6c6902 100644
> --- a/drivers/net/ethernet/broadcom/Kconfig
> +++ b/drivers/net/ethernet/broadcom/Kconfig
> @@ -256,6 +256,7 @@ config BNXT_HWMON
>   config BNGE
>   	tristate "Broadcom Ethernet device support"
>   	depends on PCI
> +	select NET_DEVLINK
>   	help
>   	  This driver supports Broadcom 50/100/200/400/800 gigabit Ethernet cards.
>   	  The module will be called bng_en. To compile this driver as a module,
> diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
> index 0c3d632805d1..e021a14d2fa0 100644
> --- a/drivers/net/ethernet/broadcom/bnge/Makefile
> +++ b/drivers/net/ethernet/broadcom/bnge/Makefile
> @@ -2,4 +2,5 @@
>   
>   obj-$(CONFIG_BNGE) += bng_en.o
>   
> -bng_en-y := bnge_core.o
> +bng_en-y := bnge_core.o \
> +	    bnge_devlink.o
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
> index b49c51b44473..19d85aabab4e 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
> @@ -13,4 +13,15 @@ enum board_idx {
>   	BCM57708,
>   };
>   
> +struct bnge_dev {
> +	struct device	*dev;
> +	struct pci_dev	*pdev;
> +	u64	dsn;
> +#define BNGE_VPD_FLD_LEN	32
> +	char		board_partno[BNGE_VPD_FLD_LEN];
> +	char		board_serialno[BNGE_VPD_FLD_LEN];
> +
> +	void __iomem	*bar0;
> +};
> +
>   #endif /* _BNGE_H_ */
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> index 3778210da98d..1a46c7663012 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> @@ -7,6 +7,7 @@
>   #include <linux/pci.h>
>   
>   #include "bnge.h"
> +#include "bnge_devlink.h"
>   
>   MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION(DRV_SUMMARY);
> @@ -85,8 +86,19 @@ static int bnge_pci_enable(struct pci_dev *pdev)
>   	return rc;
>   }
>   
> +static void bnge_unmap_bars(struct pci_dev *pdev)
> +{
> +	struct bnge_dev *bd = pci_get_drvdata(pdev);
> +
> +	if (bd->bar0) {
> +		pci_iounmap(pdev, bd->bar0);
> +		bd->bar0 = NULL;
> +	}
> +}
> +
>   static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   {
> +	struct bnge_dev *bd;
>   	int rc;
>   
>   	if (pci_is_bridge(pdev))
> @@ -108,13 +120,44 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   
>   	bnge_print_device_info(pdev, ent->driver_data);
>   
> +	bd = bnge_devlink_alloc(pdev);
> +	if (!bd) {
> +		dev_err(&pdev->dev, "Devlink allocation failed\n");
> +		rc = -ENOMEM;
> +		goto err_pci_disable;
> +	}
> +
> +	bnge_devlink_register(bd);
> +
> +	bd->bar0 = pci_ioremap_bar(pdev, 0);
> +	if (!bd->bar0) {
> +		dev_err(&pdev->dev, "Failed mapping BAR-0, aborting\n");
> +		rc = -ENOMEM;
> +		goto err_devl_unreg;
> +	}
> +
>   	pci_save_state(pdev);
>   
>   	return 0;
> +
> +err_devl_unreg:
> +	bnge_devlink_unregister(bd);
> +	bnge_devlink_free(bd);
> +
> +err_pci_disable:
> +	bnge_pci_disable(pdev);
> +	return rc;
>   }
>   
>   static void bnge_remove_one(struct pci_dev *pdev)
>   {
> +	struct bnge_dev *bd = pci_get_drvdata(pdev);
> +
> +	bnge_unmap_bars(pdev);
> +
> +	bnge_devlink_unregister(bd);
> +	bnge_devlink_free(bd);
> +
>   	bnge_pci_disable(pdev);
>   }
>   
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> new file mode 100644
> index 000000000000..d406338da130
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2025 Broadcom.
> +
> +#include <linux/unaligned.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include <net/devlink.h>
> +
> +#include "bnge.h"
> +#include "bnge_devlink.h"
> +
> +static int bnge_dl_info_put(struct bnge_dev *bd, struct devlink_info_req *req,
> +			    enum bnge_dl_version_type type, const char *key,
> +			    char *buf)
> +{
> +	if (!strlen(buf))
> +		return 0;
> +
> +	switch (type) {
> +	case BNGE_VERSION_FIXED:
> +		return devlink_info_version_fixed_put(req, key, buf);
> +	case BNGE_VERSION_RUNNING:
> +		return devlink_info_version_running_put(req, key, buf);
> +	case BNGE_VERSION_STORED:
> +		return devlink_info_version_stored_put(req, key, buf);
> +	}
> +
> +	return 0;
> +}
> +
> +static void bnge_vpd_read_info(struct bnge_dev *bd)
> +{
> +	struct pci_dev *pdev = bd->pdev;
> +	unsigned int vpd_size, kw_len;
> +	int pos, size;
> +	u8 *vpd_data;
> +
> +	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
> +	if (IS_ERR(vpd_data)) {
> +		pci_warn(pdev, "Unable to read VPD\n");
> +		return;
> +	}
> +
> +	pos = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> +					   PCI_VPD_RO_KEYWORD_PARTNO, &kw_len);
> +	if (pos < 0)
> +		goto read_sn;
> +
> +	size = min_t(int, kw_len, BNGE_VPD_FLD_LEN - 1);
> +	memcpy(bd->board_partno, &vpd_data[pos], size);
> +
> +read_sn:
> +	pos = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> +					   PCI_VPD_RO_KEYWORD_SERIALNO,
> +					   &kw_len);
> +	if (pos < 0)
> +		goto exit;
> +
> +	size = min_t(int, kw_len, BNGE_VPD_FLD_LEN - 1);
> +	memcpy(bd->board_serialno, &vpd_data[pos], size);
> +
> +exit:
> +	kfree(vpd_data);
> +}
> +
> +static int bnge_devlink_info_get(struct devlink *devlink,
> +				 struct devlink_info_req *req,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct bnge_dev *bd = devlink_priv(devlink);
> +	int rc;
> +
> +	if (bd->dsn) {
> +		char buf[32];
> +		u8 dsn[8];
> +		int rc;
> +
> +		put_unaligned_le64(bd->dsn, dsn);
> +		sprintf(buf, "%02X-%02X-%02X-%02X-%02X-%02X-%02X-%02X",
> +			dsn[7], dsn[6], dsn[5], dsn[4],
> +			dsn[3], dsn[2], dsn[1], dsn[0]);
> +		rc = devlink_info_serial_number_put(req, buf);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (strlen(bd->board_serialno)) {
> +		rc = devlink_info_board_serial_number_put(req,
> +							  bd->board_serialno);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_FIXED,
> +			      DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
> +			      bd->board_partno);
> +
> +	return rc;

As extack is available, it may be a good idea to put a bit of readable
description into extack in error cases

> +}
> +
> +static const struct devlink_ops bnge_devlink_ops = {
> +	.info_get = bnge_devlink_info_get,
> +};
> +
> +void bnge_devlink_free(struct bnge_dev *bd)
> +{
> +	struct devlink *devlink = priv_to_devlink(bd);
> +
> +	devlink_free(devlink);
> +}
> +
> +struct bnge_dev *bnge_devlink_alloc(struct pci_dev *pdev)
> +{
> +	struct devlink *devlink;
> +	struct bnge_dev *bd;
> +
> +	devlink = devlink_alloc(&bnge_devlink_ops, sizeof(*bd), &pdev->dev);
> +	if (!devlink)
> +		return NULL;
> +
> +	bd = devlink_priv(devlink);
> +	pci_set_drvdata(pdev, bd);
> +	bd->dev = &pdev->dev;
> +	bd->pdev = pdev;
> +
> +	bd->dsn = pci_get_dsn(pdev);
> +	if (!bd->dsn)
> +		pci_warn(pdev, "Failed to get DSN\n");
> +
> +	bnge_vpd_read_info(bd);
> +
> +	return bd;
> +}
> +
> +void bnge_devlink_register(struct bnge_dev *bd)
> +{
> +	struct devlink *devlink = priv_to_devlink(bd);
> +
> +	devlink_register(devlink);
> +}
> +
> +void bnge_devlink_unregister(struct bnge_dev *bd)
> +{
> +	struct devlink *devlink = priv_to_devlink(bd);
> +
> +	devlink_unregister(devlink);
> +}
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
> new file mode 100644
> index 000000000000..c6575255e650
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Broadcom */
> +
> +#ifndef _BNGE_DEVLINK_H_
> +#define _BNGE_DEVLINK_H_
> +
> +enum bnge_dl_version_type {
> +	BNGE_VERSION_FIXED,
> +	BNGE_VERSION_RUNNING,
> +	BNGE_VERSION_STORED,
> +};
> +
> +void bnge_devlink_free(struct bnge_dev *bd);
> +struct bnge_dev *bnge_devlink_alloc(struct pci_dev *pdev);
> +void bnge_devlink_register(struct bnge_dev *bd);
> +void bnge_devlink_unregister(struct bnge_dev *bd);
> +
> +#endif /* _BNGE_DEVLINK_H_ */


