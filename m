Return-Path: <netdev+bounces-223703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F3DB5A155
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF57316A824
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D22F2F5A29;
	Tue, 16 Sep 2025 19:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A561FBEA2;
	Tue, 16 Sep 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050492; cv=none; b=WsvAGpLrVMWaVX9ill/wHab4Y6fsPaNjkrNftVaNr6VDuDQh26sVRHYxIbJ/UAWV5NgcsjULW+jXthd+rgiQDY32uBKculfmgPV3gWnYqbjBxAyNFd4SsdrPRork6KN9uDyk4nWGee0yJQZlbq6NGKT0D/VOiaVcvF7THwiWzn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050492; c=relaxed/simple;
	bh=VVgIyIvhFIRGLe9aaJKQZNnY2mT71sn0CpTCBtep7UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpZ+gsRSnSajLP1ZBD0Y0Xn8LWEv8+QoId1MCwHldiIU16IHCZ+q3TMre9CBS0of/wwpy+qxV8k6z0DZyFznWQBt32Wt3D6tgNsKkWqv9iiFTsFYvUAYX7Xm5txd30rk2VJA5zEx0Hgvz0FcKg03cbHqTh6m30R5amNSaYdh/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.98.2)
	(envelope-from <joerg@jo-so.de>)
	id 1uybEV-00000001VFD-2hyk;
	Tue, 16 Sep 2025 21:20:55 +0200
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98.2)
	(envelope-from <joerg@jo-so.de>)
	id 1uybEU-000000028Ed-48e9;
	Tue, 16 Sep 2025 21:20:54 +0200
Date: Tue, 16 Sep 2025 21:20:54 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, 
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be, 
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com, alexanderduyck@fb.com, 
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org, rdunlap@infradead.org, 
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v12 2/5] net: rnpgbe: Add n500/n210 chip support
 with BAR2 mapping
Message-ID: <qbvrpeywjv6jvngkdtfcducex4jpsgqktfqs6ar2plc5bcgt5o@7bsfau64w3om>
OpenPGP: id=7D2C9A23D1AEA375; url=https://jo-so.de/pgp-key.txt;
 preference=signencrypt
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-3-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="knfqrve42bbn7g3c"
Content-Disposition: inline
In-Reply-To: <20250916112952.26032-3-dong100@mucse.com>


--knfqrve42bbn7g3c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v12 2/5] net: rnpgbe: Add n500/n210 chip support
 with BAR2 mapping
MIME-Version: 1.0

Dong Yibo schrieb am Di 16. Sep, 19:29 (+0800):
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/ne=
t/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 60bbc806f17b..0afe39621661 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -2,8 +2,11 @@
>  /* Copyright(c) 2020 - 2025 Mucse Corporation. */
> =20
>  #include <linux/pci.h>
> +#include <net/rtnetlink.h>
> +#include <linux/etherdevice.h>
> =20
>  #include "rnpgbe.h"
> +#include "rnpgbe_hw.h"
> =20
>  static const char rnpgbe_driver_name[] =3D "rnpgbe";
> =20
> @@ -25,6 +28,54 @@ static struct pci_device_id rnpgbe_pci_tbl[] =3D {
>  	{0, },
>  };
> =20
> +/**
> + * rnpgbe_add_adapter - Add netdev for this pci_dev
> + * @pdev: PCI device information structure
> + * @board_type: board type
> + *
> + * rnpgbe_add_adapter initializes a netdev for this pci_dev
> + * structure. Initializes Bar map, private structure, and a
> + * hardware reset occur.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int rnpgbe_add_adapter(struct pci_dev *pdev,
> +			      int board_type)
> +{
> +	struct net_device *netdev;
> +	void __iomem *hw_addr;
> +	struct mucse *mucse;
> +	struct mucse_hw *hw;
> +	int err;
> +
> +	netdev =3D alloc_etherdev_mq(sizeof(struct mucse), RNPGBE_MAX_QUEUES);
> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	SET_NETDEV_DEV(netdev, &pdev->dev);
> +	mucse =3D netdev_priv(netdev);
> +	mucse->netdev =3D netdev;
> +	mucse->pdev =3D pdev;
> +	pci_set_drvdata(pdev, mucse);
> +
> +	hw =3D &mucse->hw;
> +	hw_addr =3D devm_ioremap(&pdev->dev,
> +			       pci_resource_start(pdev, 2),
> +			       pci_resource_len(pdev, 2));
> +	if (!hw_addr) {
> +		err =3D -EIO;
> +		goto err_free_net;
> +	}
> +
> +	hw->hw_addr =3D hw_addr;
> +
> +	return 0;
> +
> +err_free_net:
> +	free_netdev(netdev);
> +	return err;
> +}
> +
>  /**
>   * rnpgbe_probe - Device initialization routine
>   * @pdev: PCI device information struct
> @@ -37,6 +88,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] =3D {
>   **/
>  static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id=
 *id)
>  {
> +	int board_type =3D id->driver_data;
>  	int err;
> =20
>  	err =3D pci_enable_device_mem(pdev);
> @@ -63,6 +115,9 @@ static int rnpgbe_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *id)
>  		dev_err(&pdev->dev, "pci_save_state failed %d\n", err);
>  		goto err_free_regions;
>  	}
> +	err =3D rnpgbe_add_adapter(pdev, board_type);

Would an empty line before this assignment make the code more readable?



--=20
Professor: =E2=80=9AGott=E2=80=98, unverst=C3=A4ndliches und mythisches Wes=
en, das sich einmal
  pro Woche im Kreis der Sterblichen manifestiert um Weisheit auf Folien
  unter das Volk zu bringen.		(Dschungelbuch=C2=A011, FSU=C2=A0Jena)

--knfqrve42bbn7g3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCaMm4kwAKCRB9LJoj0a6j
dcomAPwK0FbLAeUxOE6JiQpjcigplrvqMi5jCaJJvPAK7Fxo2QD/SnaCTg1bNL5B
nDsd8Xyg2CtKj9MluTtobPMagELo2nw=
=fT2B
-----END PGP SIGNATURE-----

--knfqrve42bbn7g3c--

