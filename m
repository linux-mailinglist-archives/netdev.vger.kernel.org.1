Return-Path: <netdev+bounces-178260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82ABA760E8
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 10:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188173A55E7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F71D90C8;
	Mon, 31 Mar 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="NVNNuIwB"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E41D63F5;
	Mon, 31 Mar 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408402; cv=none; b=HMZJilXAapeKkIHV3dafIrUsGTXvrzSuLoiQcpuX+OFWfEefwrxnHuJ/2ghB134nI8S1pJPx8YHpTFmdMmphYThEfX9sB3HN5xvjfYWEmk5RBcaIQvblUfZlTietF2o+g2ZLXerQSpxThkaEr+EdKxeo4kbTLIYZSMZv3l2zzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408402; c=relaxed/simple;
	bh=S3Acybsx/UewHAFX6w4+slMUnD/NCTA78a7/5EPp6dE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFbHrCwH6TWIuXEs2xJegcPwRiKngl0EHM9Q3d8Le0jyzpxhmWmCXtaw3CCECqROsg1sQXVM5r0c8LCYFqGKwxvrWmlF+gfyO/x8q14b3JPvAHOLWkUfDvK1vVBOSPFNd+cmSsm7Je5RUA1ffOXjc5NwFKLGnFGnmst4hzD2jsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=NVNNuIwB; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5DF39102F66E4;
	Mon, 31 Mar 2025 10:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743408397; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=VKP/7CeXLRMCUmW+0j2wMhdOOqp3jMDskSqTIZJkTKo=;
	b=NVNNuIwBc/++8ozhXTQxwrXwtUOOT1Gq63sVKchTTVzvl/tdClnAACl1yJRsJGEnDpDcUP
	xYEgBTPiD37Oj/QekN/7d89HIfkyv6ndLnB1+x/au5+NZyQYr/38MJNkEPYfBXYcZ5tVHA
	ZS19Ph2NClvLpcpPsfvDEgCzL/Ot+pCjJNveU11m24KwJOzoz7gSz0LhIBXz+nqU5Yi/Vh
	39OdOTCIWPPU4iYxIVyTG1teNbqGnZLxO+L9JrU1j+tb+3awTJV8VySpNq5L4ewka3Rav1
	4jbxASRzhgEGOwyd2aMIyh8RiuAEk5FQBCAX9i83ce1GTvPi1jYElwTvEVhGiw==
Date: Mon, 31 Mar 2025 10:06:32 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] net: mtip: The L2 switch driver for imx287
Message-ID: <20250331100632.68626360@wsk>
In-Reply-To: <060f8fb2-bade-4d80-93bc-effb3657d5a3@kernel.org>
References: <20250328133544.4149716-1-lukma@denx.de>
	<20250328133544.4149716-5-lukma@denx.de>
	<060f8fb2-bade-4d80-93bc-effb3657d5a3@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IGyI34+k55Z2ium1X9WZv58";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/IGyI34+k55Z2ium1X9WZv58
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 28/03/2025 14:35, Lukasz Majewski wrote:
> > +
> > +static void mtip_mii_unregister(struct switch_enet_private *fep)
> > +{
> > +	mdiobus_unregister(fep->mii_bus);
> > +	mdiobus_free(fep->mii_bus);
> > +}
> > +
> > +static const struct fec_devinfo fec_imx28_l2switch_info =3D {
> > +	.quirks =3D FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_SINGLE_MDIO,
> > +};
> > +
> > +static struct platform_device_id pdev_id =3D { =20
>=20
> That's const.
>=20
> > +	.name =3D "imx28-l2switch",
> > +	.driver_data =3D (kernel_ulong_t)&fec_imx28_l2switch_info,
> > +};
> > +
> > +static int __init mtip_sw_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	struct switch_enet_private *fep;
> > +	struct fec_devinfo *dev_info;
> > +	struct switch_t *fecp;
> > +	int ret;
> > +
> > +	fep =3D devm_kzalloc(&pdev->dev, sizeof(*fep), GFP_KERNEL);
> > +	if (!fep)
> > +		return -ENOMEM;
> > +
> > +	pdev->id_entry =3D &pdev_id; =20
>=20
> Hm? This is some odd pattern. You are supposed to use OF table and get
> matched by it, not populate some custom/odd handling of platform
> tables.

I've removed it and fully utilized struct of_device_id. I will just use
the OF approach without utilizing platform device.

I think that it is better to just switch to OF.

>=20
> > +
> > +	dev_info =3D (struct fec_devinfo
> > *)pdev->id_entry->driver_data; =20
>=20
> I did not notice it before, but that's a no - you cannot drop the
> cast. Driver data is always const.

The platform device ID approach has been dropped and completely
replaced with OF.

>=20
> > +	if (dev_info)
> > +		fep->quirks =3D dev_info->quirks;
> > +
> > +	fep->pdev =3D pdev;
> > +	platform_set_drvdata(pdev, fep);
> > +
> > +	fep->enet_addr =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(fep->enet_addr))
> > +		return PTR_ERR(fep->enet_addr);
> > +
> > +	fep->irq =3D platform_get_irq(pdev, 0);
> > +	if (fep->irq < 0)
> > +		return fep->irq;
> > +
> > +	ret =3D mtip_parse_of(fep, np);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "%s: OF parse error (%d)!\n",
> > __func__,
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Create an Ethernet device instance.
> > +	 * The switch lookup address memory starts at 0x800FC000
> > +	 */
> > +	fep->hwp_enet =3D fep->enet_addr;
> > +	fecp =3D (struct switch_t *)(fep->enet_addr +
> > ENET_SWI_PHYS_ADDR_OFFSET); +
> > +	fep->hwp =3D fecp;
> > +	fep->hwentry =3D (struct mtip_addr_table_t *)
> > +		((unsigned long)fecp + MCF_ESW_LOOKUP_MEM_OFFSET);
> > +
> > +	ret =3D devm_regulator_get_enable_optional(&pdev->dev,
> > "phy");
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "Unable to get and enable
> > 'phy'\n"); +
> > +	fep->clk_ipg =3D devm_clk_get_enabled(&pdev->dev, "ipg");
> > +	if (IS_ERR(fep->clk_ipg))
> > +		return dev_err_probe(&pdev->dev,
> > PTR_ERR(fep->clk_ipg),
> > +				     "Unable to acquire 'ipg'
> > clock\n"); +
> > +	fep->clk_ahb =3D devm_clk_get_enabled(&pdev->dev, "ahb");
> > +	if (IS_ERR(fep->clk_ahb))
> > +		return dev_err_probe(&pdev->dev,
> > PTR_ERR(fep->clk_ahb),
> > +				     "Unable to acquire 'ahb'
> > clock\n"); +
> > +	fep->clk_enet_out =3D
> > devm_clk_get_optional_enabled(&pdev->dev,
> > +
> > "enet_out");
> > +	if (IS_ERR(fep->clk_enet_out))
> > +		return dev_err_probe(&pdev->dev,
> > PTR_ERR(fep->clk_enet_out),
> > +				     "Unable to acquire 'enet_out'
> > clock\n"); +
> > +	spin_lock_init(&fep->learn_lock);
> > +	spin_lock_init(&fep->hw_lock);
> > +	spin_lock_init(&fep->mii_lock);
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, fep->irq,
> > mtip_interrupt, 0,
> > +			       "mtip_l2sw", fep);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, fep->irq,
> > +				     "Could not alloc IRQ\n");
> > +
> > +	ret =3D mtip_register_notifiers(fep);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D mtip_ndev_init(fep);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "%s: Failed to create virtual
> > ndev (%d)\n",
> > +			__func__, ret);
> > +		goto ndev_init_err;
> > +	}
> > +
> > +	ret =3D mtip_switch_dma_init(fep);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "%s: ethernet switch init fail
> > (%d)!\n",
> > +			__func__, ret);
> > +		goto dma_init_err;
> > +	}
> > +
> > +	ret =3D mtip_mii_init(fep, pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "%s: Cannot init phy bus
> > (%d)!\n", __func__,
> > +			ret);
> > +		goto mii_init_err;
> > +	}
> > +	/* setup timer for learning aging function */
> > +	timer_setup(&fep->timer_aging, mtip_aging_timer, 0);
> > +	mod_timer(&fep->timer_aging,
> > +		  jiffies +
> > msecs_to_jiffies(LEARNING_AGING_INTERVAL)); +
> > +	fep->task =3D kthread_run(mtip_sw_learning, fep,
> > "mtip_l2sw_learning");
> > +	if (IS_ERR(fep->task)) {
> > +		ret =3D PTR_ERR(fep->task);
> > +		dev_err(&pdev->dev, "%s: learning kthread_run
> > error (%d)!\n",
> > +			__func__, ret);
> > +		goto task_learning_err;
> > +	}
> > +
> > +	/* setup MII interface for external switch ports*/
> > +	mtip_enet_init(fep, 1);
> > +	mtip_enet_init(fep, 2);
> > +
> > +	return 0;
> > +
> > + task_learning_err:
> > +	del_timer(&fep->timer_aging);
> > +	mtip_mii_unregister(fep);
> > + mii_init_err:
> > + dma_init_err:
> > +	mtip_ndev_cleanup(fep);
> > + ndev_init_err:
> > +	mtip_unregister_notifiers(fep);
> > +
> > +	return ret;
> > +}
> > +
> > +static void mtip_sw_remove(struct platform_device *pdev)
> > +{
> > +	struct switch_enet_private *fep =3D
> > platform_get_drvdata(pdev); +
> > +	mtip_unregister_notifiers(fep);
> > +	mtip_ndev_cleanup(fep);
> > +
> > +	mtip_mii_remove(fep);
> > +
> > +	kthread_stop(fep->task);
> > +	del_timer(&fep->timer_aging);
> > +	platform_set_drvdata(pdev, NULL);
> > +
> > +	kfree(fep);
> > +}
> > +
> > +static const struct of_device_id mtipl2_of_match[] =3D {
> > +	{ .compatible =3D "nxp,imx287-mtip-switch", },
> > +	{ /* sentinel */ }
> > +}; =20
>=20
> Missing module device table.

Ok. I will add it.

>=20
> > +
> > +static struct platform_driver mtipl2plat_driver =3D {
> > +	.driver         =3D {
> > +		.name   =3D "mtipl2sw",
> > +		.of_match_table =3D mtipl2_of_match,
> > +		.suppress_bind_attrs =3D true,
> > +	},
> > +	.probe          =3D mtip_sw_probe,
> > +	.remove_new     =3D mtip_sw_remove,
> > +};
> > +
> > +module_platform_driver(mtipl2plat_driver);
> > +MODULE_AUTHOR("Lukasz Majewski <lukma@denx.de>");
> > +MODULE_DESCRIPTION("Driver for MTIP L2 on SOC switch");
> > +MODULE_VERSION(VERSION); =20
>=20
> What is the point of paralell versioning with the kernel? Are you
> going to keep this updated or - just like in other cases - it will
> stay always theh same. Look for example at net/bridge/br.c or some
> other files - they are always the same even if driver changed
> significantly.
>=20
> BTW, this would be 1.0, not 1.4. Your out of tree versioning does not
> matter.

I'm going to drop it totally. The "versioning" was only required when
switching between major LTS kernels.

I'd be more than happy to just use kernel SHA1, when this driver is
pulled.


>=20
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:mtipl2sw"); =20
>=20
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong (e.g. misses either
> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
> for incomplete ID table.
>=20

I will remove it.

>=20
> Best regards,
> Krzysztof


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/IGyI34+k55Z2ium1X9WZv58
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfqTQgACgkQAR8vZIA0
zr0P4wgAqeuR1TJvv0OA0PlghS9c+/mjpfCrtGgdqfe+VjVHrxHtPlyanr9JHc0u
czdrMwXZ/Byv/HOBlM91evBIaKwJqUXjMownhbaSGqmEJc/3eVfuCJa3Q6GYZQX5
Xb3uFM45m4JrYM4UMgVmT7pe41s8aLQv5anyWOTkXhvY+HGFXCP9CXuuAwhqGCcC
dLuL4W6Rr7CiKnNvm2Urd+kcno6PJisyQACiTqUbo1lEu+B0Dl5pVBse0lzKeOP8
5ve4ZUVGTtz0waOFYq19jmHv/JUzwuTQ61ClxtINHpZpu/CHZkX3EcBxLzTrkMKa
LiHvQmLcE7fmnrcIbN2M7iaPuAeVlA==
=vMBn
-----END PGP SIGNATURE-----

--Sig_/IGyI34+k55Z2ium1X9WZv58--

