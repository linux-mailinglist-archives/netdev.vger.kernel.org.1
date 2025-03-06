Return-Path: <netdev+bounces-172461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A66A54C36
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5222A18966E5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239420E6E8;
	Thu,  6 Mar 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nEtjtyQ0"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E220E6E0;
	Thu,  6 Mar 2025 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267786; cv=none; b=KJd4WGMELuTk0HttQzMcf6VrkZkyd+AqjC+LuzWpnOZ/P0RfoVxlvS/KII6gVR6PKT87FmuZxx7/weYHxPUxBActr7eWCtY6UCIHgxhqfRdPEP95SbVona1gMbwTId6gTwPFHDW4VFMsXXFJMl9Ceb4uRoLd0+Nh0jMAY1sIez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267786; c=relaxed/simple;
	bh=yJ2qSR9GQZrAqXGTRIfLZ3P5TOERzkV9N2WRJ0ySwG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DdAeDDrsadqS4FXG9ANF2xF9nc9xDZVk594O9WlgZ6QpW0TTwNQGOR/lBRhlYCdqSkS4c95fzeutMtrbRZBPb/Gd+uHKAR2shZeTorQNwxUqkL6R4KNiKHjnxX9JcEMIe2dDFRoLKm7J9UzyhjbEToxAB4YePSuNUrgrb1MW8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nEtjtyQ0; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z7qyj6j5wz9sq9;
	Thu,  6 Mar 2025 14:29:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741267774; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HCWghEoRmY3q5i+9iaFbdBZz5vLotiHqKjbDiczyjE=;
	b=nEtjtyQ0tlThp6Cus3eztikORJNPkzKfgg0bB02cDUlelHYT4Fub4sRohFYbSC4qWjjfUO
	vAi0JUpBnIiOzpVJOOrUDy+WkTK9jNO0s4HyhkWgyxA9kgcVqhXLslFaljoxk9JkxwZ+mN
	EJJrkYNAb56elssBQmtsR0BbWU65lw2XrW8kjd8WpZT/vsGknv3fKid1NTq15N3qJ+EOAw
	KpUuqs6bJxlcE7C9DIVim0sXBhILahFdJpYmiHJXTWiCgyxFBuw0jhhczG4oqzMJslVFGq
	8t7mhpspkCHYjlCGCW25n8OXvbghGdTR7yr/3hsnhCS3XIKtmjtJfx7knbZN3w==
Message-ID: <1482683f626c0743e3ec53161dd291de3a6726f6.camel@mailbox.org>
Subject: Re: [PATCH net-next v3 02/14] motorcomm:yt6801: Add support for a
 pci table in this module
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Frank Sae <Frank.Sae@motor-comm.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
 Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org, 
 xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com,
 hua.sun@motor-comm.com
Date: Thu, 06 Mar 2025 14:29:29 +0100
In-Reply-To: <20250228100020.3944-3-Frank.Sae@motor-comm.com>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
	 <20250228100020.3944-3-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: ec5928313f90d20e28f
X-MBO-RS-META: u8qb5wxg3wi6mtz64fqxwffpoc5ni1ns

On Fri, 2025-02-28 at 18:00 +0800, Frank Sae wrote:
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
> =C2=A0.../ethernet/motorcomm/yt6801/yt6801_net.c=C2=A0=C2=A0=C2=A0 | 111
> ++++++++++++++++++
> =C2=A0.../ethernet/motorcomm/yt6801/yt6801_pci.c=C2=A0=C2=A0=C2=A0 | 104 =
++++++++++++++++
> =C2=A02 files changed, 215 insertions(+)
> =C2=A0create mode 100644
> drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
>=20
> diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
> b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
> index 7cf4d1581..c54550cd4 100644
> --- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
> +++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
> @@ -97,3 +97,114 @@ static int fxgmac_mdio_register(struct
> fxgmac_pdata *priv)
> =C2=A0	priv->phydev =3D phydev;
> =C2=A0	return 0;
> =C2=A0}
> +
> +static void fxgmac_phy_release(struct fxgmac_pdata *priv)
> +{
> +	FXGMAC_IO_WR_BITS(priv, EPHY_CTRL, RESET, 1);
> +	fsleep(100);
> +}
> +
> +void fxgmac_phy_reset(struct fxgmac_pdata *priv)
> +{
> +	FXGMAC_IO_WR_BITS(priv, EPHY_CTRL, RESET, 0);
> +	fsleep(1500);
> +}
> +
> +#ifdef CONFIG_PCI_MSI
> +static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *priv)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(priv->dev);
> +	int req_vectors =3D FXGMAC_MAX_DMA_CHANNELS;
> +
> +	/* Since we have FXGMAC_MAX_DMA_CHANNELS channels, we must
> +	 *=C2=A0 ensure the number of cpu core is ok. otherwise, just
> roll back to legacy.
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
> +		yt_err(priv, "enable MSIx err, clear msix
> entries.\n");
> +		goto enable_msi_interrupt;
> +	}
> +
> +	FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, INTERRUPT,
> BIT(INT_FLAG_MSIX_POS));
> +	priv->per_channel_irq =3D 1;
> +	return;
> +
> +enable_msi_interrupt:
> +	if (pci_enable_msi(pdev) < 0) {
> +		FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, INTERRUPT,
> BIT(INT_FLAG_LEGACY_POS));
> +		yt_err(priv, "MSI err, rollback to LEGACY.\n");
> +	} else {
> +		FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, INTERRUPT,
> BIT(INT_FLAG_MSI_POS));
> +		priv->dev_irq =3D pdev->irq;
> +	}
> +}
> +#endif
> +
> +int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources
> *res)
> +{
> +	struct fxgmac_pdata *priv;
> +	struct net_device *netdev;
> +	int ret;
> +
> +	netdev =3D alloc_etherdev_mq(sizeof(struct fxgmac_pdata),
> +				=C2=A0=C2=A0 FXGMAC_MAX_DMA_RX_CHANNELS);
> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	SET_NETDEV_DEV(netdev, dev);
> +	priv =3D netdev_priv(netdev);
> +
> +	priv->dev =3D dev;
> +	priv->netdev =3D netdev;
> +	priv->dev_irq =3D res->irq;
> +	priv->hw_addr =3D res->addr;
> +	priv->msg_enable =3D NETIF_MSG_DRV;
> +	priv->dev_state =3D FXGMAC_DEV_PROBE;
> +
> +	/* Default to legacy interrupt */
> +	FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, INTERRUPT,
> BIT(INT_FLAG_LEGACY_POS));
> +	pci_set_drvdata(to_pci_dev(priv->dev), priv);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		fxgmac_init_interrupt_scheme(priv);
> +
> +	ret =3D fxgmac_init(priv, true);
> +	if (ret < 0) {
> +		yt_err(priv, "fxgmac_init err:%d\n", ret);
> +		goto err_free_netdev;
> +	}
> +
> +	fxgmac_phy_reset(priv);
> +	fxgmac_phy_release(priv);
> +	ret =3D fxgmac_mdio_register(priv);
> +	if (ret < 0) {
> +		yt_err(priv, "fxgmac_mdio_register err:%d\n", ret);
> +		goto err_free_netdev;
> +	}
> +
> +	netif_carrier_off(netdev);
> +	ret =3D register_netdev(netdev);
> +	if (ret) {
> +		yt_err(priv, "register_netdev err:%d\n", ret);
> +		goto err_free_netdev;
> +	}
> +
> +	return 0;
> +
> +err_free_netdev:
> +	free_netdev(netdev);
> +	return ret;
> +}
> diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
> b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
> new file mode 100644
> index 000000000..1b80ae15a
> --- /dev/null
> +++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
> @@ -0,0 +1,104 @@
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
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#ifdef CONFIG_PCI_MSI
> +#include <linux/pci.h>
> +#endif
> +
> +#include "yt6801.h"
> +
> +static int fxgmac_probe(struct pci_dev *pcidev, const struct
> pci_device_id *id)
> +{
> +	struct device *dev =3D &pcidev->dev;
> +	struct fxgmac_resources res;
> +	int i, ret;
> +
> +	ret =3D pcim_enable_device(pcidev);
> +	if (ret) {
> +		dev_err(dev, "%s pcim_enable_device err:%d\n",
> __func__, ret);
> +		return ret;
> +	}
> +
> +	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (pci_resource_len(pcidev, i) =3D=3D 0)
> +			continue;
> +
> +		ret =3D pcim_iomap_regions(pcidev, BIT(i),
> FXGMAC_DRV_NAME);

This function is deprecated.

Use pcim_iomap_region() instead.

> +		if (ret) {
> +			dev_err(dev, "%s, pcim_iomap_regions
> err:%d\n",
> +				__func__, ret);
> +			return ret;
> +		}
> +		break;
> +	}
> +
> +	pci_set_master(pcidev);
> +
> +	memset(&res, 0, sizeof(res));
> +	res.irq =3D pcidev->irq;
> +	res.addr =3D pcim_iomap_table(pcidev)[i];

This function is also deprecated. You can use the function mentioned
above to obtain the mapping addr.


P.

> +
> +	return fxgmac_drv_probe(&pcidev->dev, &res);
> +}
> +
> +static void fxgmac_remove(struct pci_dev *pcidev)
> +{
> +	struct fxgmac_pdata *priv =3D dev_get_drvdata(&pcidev->dev);
> +	struct net_device *netdev =3D priv->netdev;
> +	struct device *dev =3D &pcidev->dev;
> +
> +	unregister_netdev(netdev);
> +	fxgmac_phy_reset(priv);
> +	free_netdev(netdev);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI) &&
> +	=C2=A0=C2=A0=C2=A0 FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, MSIX)) {
> +		pci_disable_msix(pcidev);
> +		kfree(priv->msix_entries);
> +		priv->msix_entries =3D NULL;
> +	}
> +
> +	dev_dbg(dev, "%s has been removed\n", netdev->name);
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


