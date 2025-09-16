Return-Path: <netdev+bounces-223688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB0B5A0DC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843761C04822
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7702DBF45;
	Tue, 16 Sep 2025 19:00:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBB32D5D4;
	Tue, 16 Sep 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049249; cv=none; b=C8B5/SMzAz5lEc62LYJPBD9cBRbp3BTYGkyUIjL2+Ytb65GX++YS4mh7LMSLupYVXq07Cs+gbkW2jkLHxNm17woYrd2nt5x/QYmCgh5VKRIme64gQlXQlDbwklvaKVw9+sNjaepkBxXwpbcBI4Na3b40gdtviwI3b/0EhN71E7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049249; c=relaxed/simple;
	bh=/rgxq4FRkkAatSQxJg1/+3l0fRdSYyVMBLI8ihCClYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciS2rEQaSk2EQonoKI+hWTCiBYA6+jbW4DKBy/0QebjkjfjRSk2qSB7KYPAWs8y96giXP9qw0fqePbryiHY7Z2VFf7UlrxiTRlyJ3ie3PFnXdejym1ufs3k5nLQznh5wOjYDn2T6vufgk2OF3Cl81qDKnKtY9p4MT1hozKRkWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.98.2)
	(envelope-from <joerg@jo-so.de>)
	id 1uyaud-00000001UpH-35cH;
	Tue, 16 Sep 2025 21:00:23 +0200
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98.2)
	(envelope-from <joerg@jo-so.de>)
	id 1uyaud-000000027gj-0U27;
	Tue, 16 Sep 2025 21:00:23 +0200
Date: Tue, 16 Sep 2025 21:00:23 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, 
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be, 
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com, alexanderduyck@fb.com, 
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org, rdunlap@infradead.org, 
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v12 1/5] net: rnpgbe: Add build support for
 rnpgbe
Message-ID: <mr6wuiqeucy6shybrqrg3pwim22ep5tbdivspsjwpo5335ri7j@u4jcc6os3ndr>
OpenPGP: id=7D2C9A23D1AEA375; url=https://jo-so.de/pgp-key.txt;
 preference=signencrypt
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="trz2bbyp7goo7nx7"
Content-Disposition: inline
In-Reply-To: <20250916112952.26032-2-dong100@mucse.com>


--trz2bbyp7goo7nx7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v12 1/5] net: rnpgbe: Add build support for
 rnpgbe
MIME-Version: 1.0

Dong Yibo schrieb am Di 16. Sep, 19:29 (+0800):
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/ne=
t/ethernet/mucse/rnpgbe/rnpgbe_main.c
> new file mode 100644
> index 000000000000..60bbc806f17b
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#include <linux/pci.h>
> +
> +#include "rnpgbe.h"
> +
> +static const char rnpgbe_driver_name[] =3D "rnpgbe";
> +
> +/* rnpgbe_pci_tbl - PCI Device ID Table
> + *
> + * { PCI_DEVICE(Vendor ID, Device ID),
> + *   driver_data (used for different hw chip) }
> + */
> +static struct pci_device_id rnpgbe_pci_tbl[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N500_QUAD_PORT),
> +	  .driver_data =3D board_n500},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N500_DUAL_PORT),
> +	  .driver_data =3D board_n500},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N210),
> +	  .driver_data =3D board_n210},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N210L),
> +	  .driver_data =3D board_n210},

Should there be a space before }?

> +	/* required last entry */
> +	{0, },
> +};
> +
> +/**
> + * rnpgbe_probe - Device initialization routine
> + * @pdev: PCI device information struct
> + * @id: entry in rnpgbe_pci_tbl
> + *
> + * rnpgbe_probe initializes a PF adapter identified by a pci_dev
> + * structure.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id=
 *id)
> +{
> +	int err;

In rnpgbe_mbx.c you use `int ret` for this pattern. I think you should unify
this. But I'm more in favour of `err` than `ret`.

> +
> +	err =3D pci_enable_device_mem(pdev);
> +	if (err)
> +		return err;
> +
> +	err =3D dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"No usable DMA configuration, aborting %d\n", err);
> +		goto err_disable_dev;
> +	}
> +
> +	err =3D pci_request_mem_regions(pdev, rnpgbe_driver_name);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"pci_request_selected_regions failed %d\n", err);
> +		goto err_disable_dev;
> +	}
> +
> +	pci_set_master(pdev);
> +	err =3D pci_save_state(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "pci_save_state failed %d\n", err);
> +		goto err_free_regions;
> +	}
> +
> +	return 0;
> +err_free_regions:
> +	pci_release_mem_regions(pdev);
> +err_disable_dev:
> +	pci_disable_device(pdev);
> +	return err;
> +}
> +
> +/**
> + * rnpgbe_remove - Device removal routine
> + * @pdev: PCI device information struct
> + *
> + * rnpgbe_remove is called by the PCI subsystem to alert the driver
> + * that it should release a PCI device. This could be caused by a
> + * Hot-Plug event, or because the driver is going to be removed from
> + * memory.
> + **/
> +static void rnpgbe_remove(struct pci_dev *pdev)
> +{
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +/**
> + * rnpgbe_dev_shutdown - Device shutdown routine
> + * @pdev: PCI device information struct
> + **/
> +static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
> +{
> +	pci_disable_device(pdev);
> +}
> +
> +/**
> + * rnpgbe_shutdown - Device shutdown routine
> + * @pdev: PCI device information struct
> + *
> + * rnpgbe_shutdown is called by the PCI subsystem to alert the driver
> + * that os shutdown. Device should setup wakeup state here.
> + **/
> +static void rnpgbe_shutdown(struct pci_dev *pdev)
> +{
> +	rnpgbe_dev_shutdown(pdev);

Is this the only user of rnpgbe_dev_shutdown?

> +}
> +
> +static struct pci_driver rnpgbe_driver =3D {
> +	.name =3D rnpgbe_driver_name,
> +	.id_table =3D rnpgbe_pci_tbl,
> +	.probe =3D rnpgbe_probe,
> +	.remove =3D rnpgbe_remove,
> +	.shutdown =3D rnpgbe_shutdown,
> +};
> +
> +module_pci_driver(rnpgbe_driver);
> +
> +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
> +MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
> +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.25.1
>=20
>=20

--=20
Als deutscher Tourist im Ausland steht man vor der Frage, ob man sich
anst=E4ndig benehmen muss oder ob schon deutsche Touristen dagewesen sind.
                                                (Kurt Tucholsky)

--trz2bbyp7goo7nx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCaMmzxQAKCRB9LJoj0a6j
dSVyAQC4VqtXOkURplHbCIfta22QVK4Vlmem6/yJlEBnh3O6bgD/Q7r+2UJGJp64
0om4OmUSW+7Q3Tvw3GrR145+DmJqTFM=
=AZSs
-----END PGP SIGNATURE-----

--trz2bbyp7goo7nx7--

