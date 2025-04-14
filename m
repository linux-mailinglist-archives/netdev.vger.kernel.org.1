Return-Path: <netdev+bounces-182090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB11A87BB8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D7516FAB5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415825DD0A;
	Mon, 14 Apr 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WU/zIyYe"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9D1CD2C;
	Mon, 14 Apr 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622364; cv=none; b=Uy0MW26OrVcUr/dn79F1oRlTubJtagjr/D927VO2ce1Cj+LOPa3/e66CS86tqKy0DbXURfoErD+Lj+X3qnhs/gbgp14yrCmrH1bdMFOVbU2tXR6Sa29CLN4aSt3k9fpFSD0LfOfGQlsPDQP+lDVBxoUOSrNvwHHYRWTIQMWsOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622364; c=relaxed/simple;
	bh=TifcQAl4aS6K7rhrSCZWDyDsKVK9v6YUR2Ji4L2XBXQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lm5IK7xJPkLmbhF3ipnJKEZwVQvtlN6ZT/o+b+CxpyALN8j8rgE9jsO9yQ0RgquLXjaqtRSWK5jAI3Z94lG53/Ckkn34DolKgiZT3EYk9aeCHlHUJLnl6/I3VH6tLY8h9JS8B1C73Fd6gs1wCLwGGzR9jjbRzdtBgNs/jfeREoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WU/zIyYe; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZbhYy4WFqz9tLg;
	Mon, 14 Apr 2025 11:19:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1744622358; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJsigFcfz58hJJS0Uu3EBhrbgTwACfaSGvrpf/wE+IY=;
	b=WU/zIyYePT57G3RcGtgcCCwqI3cRxahJH88uuop+NVU3jsrmDwQyIg8KPoDCw5MLHCbZy4
	irc7LzyQiaFfe7e9niuyF+7uzdcyQdC0pKxyuilzQ8ZZuJ3AW5Gd9ulcgjGcB+smJACbps
	qsZZGunfJU6pD6ifnpiOUqme3JXom7RXSYzn9kV0v4qCF1gLLJ7cFdnZYfm0/3xLyahNFL
	eX96HxyLyi6Smb+hsCaNQ0zY78+vT07nnHpHUmKf0DJxrrY3tsTJN+iqsQEYoJ6YaenL6H
	m/TAdKktCNaoIOfi68AKBpqCeHkbM0GpXGIQNj1ni2IkdGN7q/vCmdage9i8ow==
Message-ID: <37b8ec86b98706984019b418bc20f0d0883ed555.camel@mailbox.org>
Subject: Re: [PATCH net-next v4 01/14] yt6801: Add support for a pci table
 in this module
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Frank Sae <Frank.Sae@motor-comm.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
 Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org, 
 "andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>, lee@trager.us,
 horms@kernel.org,  linux-doc@vger.kernel.org, corbet@lwn.net,
 geert+renesas@glider.be,  xiaogang.fan@motor-comm.com,
 fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Date: Mon, 14 Apr 2025 11:19:11 +0200
In-Reply-To: <20250408092835.3952-2-Frank.Sae@motor-comm.com>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
	 <20250408092835.3952-2-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 96ryrkux9bx13h3yao3hs7wc7boh1ear
X-MBO-RS-ID: 906e233922f47e34ffa

On Tue, 2025-04-08 at 17:28 +0800, Frank Sae wrote:
> Add support for a pci table in this module, and implement pci_driver
> =C2=A0function to initialize this driver, remove this driver or shutdown
> this
> =C2=A0driver.
> Implement the fxgmac_drv_probe function to init interrupts, register
> mdio
> =C2=A0and netdev.
>=20
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> ---
> =C2=A0.../ethernet/motorcomm/yt6801/yt6801_main.c=C2=A0=C2=A0 | 194
> ++++++++++++++++++
> =C2=A0.../ethernet/motorcomm/yt6801/yt6801_type.h=C2=A0=C2=A0 | 114 +++++=
+++++
> =C2=A02 files changed, 308 insertions(+)
> =C2=A0create mode 100644
> drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
> =C2=A0create mode 100644
> drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
>=20
> diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
> b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
> new file mode 100644
> index 000000000..10d63a8ed
> --- /dev/null
> +++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology
> Co.,Ltd.
> + *
> + * Below is a simplified block diagram of YT6801 chip and its
> relevant
> + * interfaces.
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ||
> + *=C2=A0 ********************++**********************
> + *=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | PCIE Endpoint |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *
> + *=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 +---------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *
> + *=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | GMAC |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> + *=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--++--+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> + *=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |**|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *
> + *=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GMII --> |**|=
 <-- MDIO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> + *=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-++--+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> + *=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | Integrated PHY |=C2=A0 YT8531S=C2=A0=C2=A0 *
> + *=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-++-+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *
> + *=C2=A0 ********************||******************* **
> + */
> +
> +#include <linux/module.h>
> +#include "yt6801_type.h"
> +
> +static void fxgmac_phy_release(struct fxgmac_pdata *priv)
> +{
> +	fxgmac_io_wr_bits(priv, EPHY_CTRL, EPHY_CTRL_RESET, 1);
> +	fsleep(100);
> +
> +static void fxgmac_phy_reset(struct fxgmac_pdata *priv)
> +{
> +	fxgmac_io_wr_bits(priv, EPHY_CTRL, EPHY_CTRL_RESET, 0);
> +	fsleep(1500);
> +}
> +
> +static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *priv)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(priv->dev);
> +	int req_vectors =3D FXGMAC_MAX_DMA_CHANNELS;
> +
> +	/* Since we have FXGMAC_MAX_DMA_CHANNELS channels, we must
> ensure the
> +	 * number of cpu core is ok. otherwise, just roll back to
> legacy.
> +	 */
> +	if (num_online_cpus() < FXGMAC_MAX_DMA_CHANNELS - 1)
> +		goto enable_msi_interrupt;
> +
> +	priv->msix_entries =3D
> +		kcalloc(req_vectors, sizeof(struct msix_entry),
> GFP_KERNEL);
> +	if (!priv->msix_entries)
> +		goto enable_msi_interrupt;
> +
> +	for (u32 i =3D 0; i < req_vectors; i++)
> +		priv->msix_entries[i].entry =3D i;
> +
> +	if (pci_enable_msix_exact(pdev, priv->msix_entries,
> req_vectors) < 0) {
> +		/* Roll back to msi */
> +		kfree(priv->msix_entries);
> +		priv->msix_entries =3D NULL;
> +		dev_err(priv->dev, "Enable MSIx failed, clear msix
> entries.\n");
> +		goto enable_msi_interrupt;
> +	}
> +
> +	priv->int_flag &=3D ~INT_FLAG_INTERRUPT;
> +	priv->int_flag |=3D INT_FLAG_MSIX;
> +	priv->per_channel_irq =3D 1;
> +	return;
> +
> +enable_msi_interrupt:
> +	priv->int_flag &=3D ~INT_FLAG_INTERRUPT;
> +	if (pci_enable_msi(pdev) < 0) {
> +		priv->int_flag |=3D INT_FLAG_LEGACY;
> +		dev_err(priv->dev, "rollback to LEGACY.\n");
> +	} else {
> +		priv->int_flag |=3D INT_FLAG_MSI;
> +		dev_err(priv->dev, "rollback to MSI.\n");
> +		priv->dev_irq =3D pdev->irq;
> +	}
> +}
> +
> +static int fxgmac_drv_probe(struct device *dev, struct
> fxgmac_resources *res)
> +{
> +	struct fxgmac_pdata *priv;
> +	struct net_device *ndev;
> +	int ret;
> +
> +	ndev =3D alloc_etherdev_mq(sizeof(struct fxgmac_pdata),
> +				 FXGMAC_MAX_DMA_RX_CHANNELS);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	SET_NETDEV_DEV(ndev, dev);
> +	priv =3D netdev_priv(ndev);
> +
> +	priv->dev =3D dev;
> +	priv->ndev =3D ndev;
> +	priv->dev_irq =3D res->irq;
> +	priv->hw_addr =3D res->addr;
> +	priv->msg_enable =3D NETIF_MSG_DRV;
> +	priv->dev_state =3D FXGMAC_DEV_PROBE;
> +
> +	/* Default to legacy interrupt */
> +	priv->int_flag &=3D ~INT_FLAG_INTERRUPT;
> +	priv->int_flag |=3D INT_FLAG_LEGACY;
> +
> +	pci_set_drvdata(to_pci_dev(priv->dev), priv);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		fxgmac_init_interrupt_scheme(priv);
> +
> +	ret =3D fxgmac_init(priv, true);
> +	if (ret < 0) {
> +		dev_err(dev, "fxgmac init failed:%d\n", ret);
> +		goto err_free_netdev;
> +	}
> +
> +	fxgmac_phy_reset(priv);
> +	fxgmac_phy_release(priv);
> +	ret =3D fxgmac_mdio_register(priv);
> +	if (ret < 0) {
> +		dev_err(dev, "Register fxgmac mdio failed:%d\n",
> ret);
> +		goto err_free_netdev;
> +	}
> +
> +	netif_carrier_off(ndev);
> +	ret =3D register_netdev(ndev);
> +	if (ret) {
> +		dev_err(dev, "Register ndev failed:%d\n", ret);
> +		goto err_free_netdev;
> +	}
> +
> +	return 0;
> +
> +err_free_netdev:
> +	free_netdev(ndev);
> +	return ret;
> +}
> +
> +static int fxgmac_probe(struct pci_dev *pcidev, const struct
> pci_device_id *id)
> +{
> +	struct fxgmac_resources res;
> +	int err;
> +
> +	err =3D pcim_enable_device(pcidev);
> +	if (err)
> +		return err;
> +
> +	memset(&res, 0, sizeof(res));
> +	res.irq =3D pcidev->irq;
> +	res.addr=C2=A0 =3D pcim_iomap_region(pcidev, 0, pci_name(pcidev));

This is actually a slight misuse: the "name" parameter should be your
driver's name, not the PCI device's name.

That string gets printed in case of a request collision regarding that
device, and the print is only useful if it says who stole the region,
not on which device sth was stolen.

(pcim_iomap_region() doesn't copy the string, so be careful to put it
in the TEXT segment or sth like that)

Regards
P.


> +	err =3D PTR_ERR_OR_ZERO(res.addr);
> +	if (err)
> +		return err;
> +
> +	pci_set_master(pcidev);
> +	return fxgmac_drv_probe(&pcidev->dev, &res);
> +}
> +
> +static void fxgmac_remove(struct pci_dev *pcidev)
> +{
> +	struct fxgmac_pdata *priv =3D dev_get_drvdata(&pcidev->dev);
> +	struct net_device *ndev =3D priv->ndev;
> +
> +	unregister_netdev(ndev);
> +	fxgmac_phy_reset(priv);
> +	free_netdev(ndev);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI) &&
> +	=C2=A0=C2=A0=C2=A0 FIELD_GET(INT_FLAG_MSIX, priv->int_flag)) {
> +		pci_disable_msix(pcidev);
> +		kfree(priv->msix_entries);
> +		priv->msix_entries =3D NULL;
> +	}
> +}
> +
> +#define MOTORCOMM_PCI_ID			0x1f0a
> +#define YT6801_PCI_DEVICE_ID			0x6801
> +
> +static const struct pci_device_id fxgmac_pci_tbl[] =3D {
> +	{ PCI_DEVICE(MOTORCOMM_PCI_ID, YT6801_PCI_DEVICE_ID) },
> +	{ 0 }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, fxgmac_pci_tbl);
> +
> +static struct pci_driver fxgmac_pci_driver =3D {
> +	.name		=3D FXGMAC_DRV_NAME,
> +	.id_table	=3D fxgmac_pci_tbl,
> +	.probe		=3D fxgmac_probe,
> +	.remove		=3D fxgmac_remove,
> +};
> +
> +module_pci_driver(fxgmac_pci_driver);
> +
> +MODULE_AUTHOR("Motorcomm Electronic Tech. Co., Ltd.");
> +MODULE_DESCRIPTION(FXGMAC_DRV_DESC);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
> b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
> new file mode 100644
> index 000000000..bb6c2640a
> --- /dev/null
> +++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
> @@ -0,0 +1,114 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology
> Co.,Ltd. */
> +
> +#ifndef YT6801_TYPE_H
> +#define YT6801_TYPE_H
> +
> +#include <linux/netdevice.h>
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +
> +#define FXGMAC_DRV_NAME		"yt6801"
> +#define FXGMAC_DRV_DESC		"Motorcomm Gigabit Ethernet
> Driver"
> +
> +#define FXGMAC_RX_BUF_ALIGN	64
> +#define FXGMAC_TX_MAX_BUF_SIZE	(0x3fff & ~(FXGMAC_RX_BUF_ALIGN -
> 1))
> +#define FXGMAC_RX_MIN_BUF_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN +
> VLAN_HLEN)
> +
> +/* Descriptors required for maximum contiguous TSO/GSO packet */
> +#define FXGMAC_TX_MAX_SPLIT	((GSO_MAX_SIZE /
> FXGMAC_TX_MAX_BUF_SIZE) + 1)
> +
> +/* Maximum possible descriptors needed for a SKB */
> +#define FXGMAC_TX_MAX_DESC_NR	(MAX_SKB_FRAGS + FXGMAC_TX_MAX_SPLIT
> + 2)
> +
> +#define FXGMAC_DMA_STOP_TIMEOUT		5
> +#define FXGMAC_JUMBO_PACKET_MTU		9014
> +#define FXGMAC_MAX_DMA_RX_CHANNELS	4
> +#define FXGMAC_MAX_DMA_TX_CHANNELS	1
> +#define
> FXGMAC_MAX_DMA_CHANNELS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +	(FXGMAC_MAX_DMA_RX_CHANNELS + FXGMAC_MAX_DMA_TX_CHANNELS)
> +
> +#define EPHY_CTRL				0x1004
> +#define EPHY_CTRL_RESET				BIT(0)
> +#define EPHY_CTRL_STA_LINKUP			BIT(1)
> +#define EPHY_CTRL_STA_DUPLEX			BIT(2)
> +#define EPHY_CTRL_STA_SPEED			GENMASK(4, 3)
> +
> +struct fxgmac_resources {
> +	void __iomem *addr;
> +	int irq;
> +};
> +
> +enum fxgmac_dev_state {
> +	FXGMAC_DEV_OPEN		=3D 0x0,
> +	FXGMAC_DEV_CLOSE	=3D 0x1,
> +	FXGMAC_DEV_STOP		=3D 0x2,
> +	FXGMAC_DEV_START	=3D 0x3,
> +	FXGMAC_DEV_SUSPEND	=3D 0x4,
> +	FXGMAC_DEV_RESUME	=3D 0x5,
> +	FXGMAC_DEV_PROBE	=3D 0xFF,
> +};
> +
> +struct fxgmac_pdata {
> +	struct net_device *ndev;
> +	struct device *dev;
> +	struct phy_device *phydev;
> +
> +	void __iomem *hw_addr;			/* Registers base */
> +
> +	/* Device interrupt */
> +	int dev_irq;
> +	unsigned int per_channel_irq;
> +	u32 channel_irq[FXGMAC_MAX_DMA_CHANNELS];
> +	struct msix_entry *msix_entries;
> +#define INT_FLAG_INTERRUPT		GENMASK(4, 0)
> +#define INT_FLAG_MSI			BIT(1)
> +#define INT_FLAG_MSIX			BIT(3)
> +#define INT_FLAG_LEGACY			BIT(4)
> +#define INT_FLAG_RX0_NAPI		BIT(18)
> +#define INT_FLAG_RX1_NAPI		BIT(19)
> +#define INT_FLAG_RX2_NAPI		BIT(20)
> +#define INT_FLAG_RX3_NAPI		BIT(21)
> +#define INT_FLAG_RX0_IRQ		BIT(22)
> +#define INT_FLAG_RX1_IRQ		BIT(23)
> +#define INT_FLAG_RX2_IRQ		BIT(24)
> +#define INT_FLAG_RX3_IRQ		BIT(25)
> +#define INT_FLAG_TX_NAPI		BIT(26)
> +#define INT_FLAG_TX_IRQ			BIT(27)
> +#define INT_FLAG_LEGACY_NAPI		BIT(30)
> +#define INT_FLAG_LEGACY_IRQ		BIT(31)
> +	u32 int_flag;		/* interrupt flag */
> +
> +	u32 msg_enable;
> +	enum fxgmac_dev_state dev_state;
> +};
> +
> +static inline u32 fxgmac_io_rd(struct fxgmac_pdata *priv, u32 reg)
> +{
> +	return ioread32(priv->hw_addr + reg);
> +}
> +
> +static inline u32
> +fxgmac_io_rd_bits(struct fxgmac_pdata *priv, u32 reg, u32 mask)
> +{
> +	u32 cfg =3D fxgmac_io_rd(priv, reg);
> +
> +	return FIELD_GET(mask, cfg);
> +}
> +
> +static inline void fxgmac_io_wr(struct fxgmac_pdata *priv, u32 reg,
> u32 set)
> +{
> +	iowrite32(set, priv->hw_addr + reg);
> +}
> +
> +static inline void
> +fxgmac_io_wr_bits(struct fxgmac_pdata *priv, u32 reg, u32 mask, u32
> set)
> +{
> +	u32 cfg =3D fxgmac_io_rd(priv, reg);
> +
> +	cfg &=3D ~mask;
> +	cfg |=3D FIELD_PREP(mask, set);
> +	fxgmac_io_wr(priv, reg, cfg);
> +}
> +
> +#endif /* YT6801_TYPE_H */


