Return-Path: <netdev+bounces-187629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180FDAA8619
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05761895D73
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 10:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04531A5BAA;
	Sun,  4 May 2025 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="f/0WjZL7"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0F170A11;
	Sun,  4 May 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746355665; cv=none; b=liihsZMfvew9pphMUtI+jbFVlaS9+JfWOBWNCyO9qciCW35jF3Thj5wFDVbxUCg+KeT08g9608nW+Zx0eAw+nXwp+chlBbPw0lK4C+i0prKizPJM6HvUQt7cTWn/i+1qrkOz4WSgphP3jUKQi98d0PpKnb+iKWDVJQ8oBHcRSHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746355665; c=relaxed/simple;
	bh=DaSIDWybMug7wM2DZjfgHf0CVYnoLd3P8fAA7dgVTHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyjR+HQw0bZfO99sOUDcX+UBmwTBsBzvaG547lWAhT+HpGJ6TYXcU7vNkmnDvP+7/fpraL6JvobZNVCKyxG863lJZoNFVCw9TNKRkt43AZYJk+55PM/K20nLvseymB79Cm/YY2Xuo5uXoTSYsOsr2Hx0jGXWSbTslw8s/t1iVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=f/0WjZL7; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A71B3102EBA58;
	Sun,  4 May 2025 12:47:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746355660; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IhfTm4gYA6ZM8P75W5NbdXm47wLemy063N49z30vMko=;
	b=f/0WjZL7Ek7MP9QzMy+gj+lZXrsnXitmwhnLIIzz1WrJ/BJvzlqU9rx1kIeWtOamJG89MQ
	0u+X/OUdzCKcOCFMq60O78pRy60Q7FerweCh2egWzsgADms6O0znQ44oHqYrg05lPDrw+E
	bfYbOKNBMcXKUa+J9iR2+Uaj6PfT7p1Ygj/woHFdNFrm2zLQjuIRBzqD011V96+NCgRqFA
	0TuAmXbIGwIrRMBJdAme69N0Thj2o+0qyTG8tFH4Ggoi6tIy0yJdHsVTR3RQDmGKZs7cO7
	VnjTu1dM7VTntkXiDuIPC2Zv/sfdG4fDKos/9+MHxAIFZg0mPBbbAdzlvy//6A==
Date: Sun, 4 May 2025 12:47:32 +0200
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
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v10 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250504124732.715c9552@wsk>
In-Reply-To: <a01df80b-c1ee-4c36-b400-e3044a0156e2@kernel.org>
References: <20250502074447.2153837-1-lukma@denx.de>
	<20250502074447.2153837-5-lukma@denx.de>
	<a01df80b-c1ee-4c36-b400-e3044a0156e2@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AfDEEeGl27yToBj1zNjfdtu";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/AfDEEeGl27yToBj1zNjfdtu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 02/05/2025 09:44, Lukasz Majewski wrote:
> > +
> > +static int mtip_parse_of(struct switch_enet_private *fep,
> > +			 struct device_node *np)
> > +{
> > +	struct device_node *p;
> > +	unsigned int port_num;
> > +	int ret =3D 0;
> > +
> > +	p =3D of_find_node_by_name(np, "ethernet-ports"); =20
>=20
> This should be looking for children, not any nodes. Otherwise you will
> take the ethernet ports from a next device as well.

Yes, you are right - I will replace of_find_node_by_name() with
of_get_child_by_name()

>=20
> > +
> > +	for_each_available_child_of_node_scoped(p, port) {
> > +		if (of_property_read_u32(port, "reg", &port_num))
> > +			continue;
> > +
> > +		if (port_num > SWITCH_EPORT_NUMBER) {
> > +			dev_err(&fep->pdev->dev,
> > +				"%s: The switch supports up to %d
> > ports!\n",
> > +				__func__, SWITCH_EPORT_NUMBER);
> > +			goto of_get_err;
> > +		}
> > +
> > +		fep->n_ports =3D port_num;
> > +		ret =3D of_get_mac_address(port, &fep->mac[port_num
> > - 1][0]);
> > +		if (ret)
> > +			dev_dbg(&fep->pdev->dev,
> > +				"of_get_mac_address(%pOF) failed
> > (%d)!\n",
> > +				port, ret);
> > +
> > +		ret =3D of_property_read_string(port, "label",
> > +
> > &fep->ndev_name[port_num - 1]);
> > +		if (ret < 0) {
> > +			dev_err(&fep->pdev->dev,
> > +				"%s: Cannot get ethernet port name
> > (%d)!\n",
> > +				__func__, ret);
> > +			goto of_get_err;
> > +		}
> > +
> > +		ret =3D of_get_phy_mode(port,
> > &fep->phy_interface[port_num - 1]);
> > +		if (ret < 0) {
> > +			dev_err(&fep->pdev->dev,
> > +				"%s: Cannot get PHY mode (%d)!\n",
> > __func__,
> > +				ret);
> > +			goto of_get_err;
> > +		}
> > +
> > +		fep->phy_np[port_num - 1] =3D of_parse_phandle(port,
> > +
> > "phy-handle", 0);
> > +	}
> > +
> > + of_get_err:
> > +	of_node_put(p);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mtip_sw_learning(void *arg)
> > +{
> > +	struct switch_enet_private *fep =3D arg;
> > +
> > +	while (!kthread_should_stop()) {
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		/* check learning record valid */
> > +		mtip_atable_dynamicms_learn_migration(fep,
> > fep->curr_time,
> > +						      NULL, NULL);
> > +		schedule_timeout(HZ / 100);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void mtip_mii_unregister(struct switch_enet_private *fep)
> > +{
> > +	mdiobus_unregister(fep->mii_bus);
> > +	mdiobus_free(fep->mii_bus);
> > +}
> > +
> > +static const struct mtip_devinfo mtip_imx28_l2switch_info =3D {
> > +	.quirks =3D FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_SINGLE_MDIO |
> > +		  FEC_QUIRK_SWAP_FRAME,
> > +};
> > +
> > +static const struct of_device_id mtipl2_of_match[] =3D {
> > +	{ .compatible =3D "nxp,imx28-mtip-switch",
> > +	  .data =3D &mtip_imx28_l2switch_info},
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mtipl2_of_match);
> > +
> > +static int mtip_sw_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	const struct of_device_id *of_id;
> > +	struct switch_enet_private *fep;
> > +	struct mtip_devinfo *dev_info;
> > +	int ret;
> > +
> > +	fep =3D devm_kzalloc(&pdev->dev, sizeof(*fep), GFP_KERNEL);
> > +	if (!fep)
> > +		return -ENOMEM;
> > +
> > +	of_id =3D of_match_node(mtipl2_of_match, pdev->dev.of_node);
> > +	if (of_id) {
> > +		dev_info =3D (struct mtip_devinfo *)of_id->data; =20
>=20
> Do not open-code of_device_get_match_data().

+1

>=20
> > +		if (dev_info)
> > +			fep->quirks =3D dev_info->quirks;
> > +	}
> > +
> > +	fep->pdev =3D pdev;
> > +	platform_set_drvdata(pdev, fep);
> > +
> > +	fep->enet_addr =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(fep->enet_addr))
> > +		return PTR_ERR(fep->enet_addr);
> > +
> > +	fep->irq =3D platform_get_irq_byname(pdev, "enet_switch");
> > +	if (fep->irq < 0)
> > +		return fep->irq;
> > +
> > +	ret =3D mtip_parse_of(fep, np);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "%s: OF parse error (%d)!\n",
> > __func__,
> > +			ret); =20
>=20
> Syntax is:
> return dev_err_probe
> just like you have in other places

Ok.

>=20
> > +		return ret;
> > +	}
> > +
> > +	/* Create an Ethernet device instance.
> > +	 * The switch lookup address memory starts at 0x800FC000
> > +	 */
> > +	fep->hwp_enet =3D fep->enet_addr;
> > +	fep->hwp =3D fep->enet_addr + ENET_SWI_PHYS_ADDR_OFFSET;
> > +	fep->hwentry =3D (struct mtip_addr_table __iomem *)
> > +		(fep->hwp + MCF_ESW_LOOKUP_MEM_OFFSET);
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
> > +	/* setup MII interface for external switch ports */
> > +	mtip_enet_init(fep, 1);
> > +	mtip_enet_init(fep, 2);
> > +
> > +	spin_lock_init(&fep->learn_lock);
> > +	spin_lock_init(&fep->hw_lock);
> > +	spin_lock_init(&fep->mii_lock);
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, fep->irq,
> > mtip_interrupt, 0,
> > +			       dev_name(&pdev->dev), fep);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, fep->irq,
> > +				     "Could not alloc IRQ\n");
> > +
> > +	ret =3D mtip_register_notifiers(fep);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D mtip_ndev_init(fep, pdev);
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
> > +			__func__, ret); =20
>=20
> ret =3D dev_err_probe

I will replace two above lines with:
ret =3D dev_err_probe(&pdev->dev, PTR_ERR(fep->task),
	"learning kthread_run error\n");


>=20
> > +		goto task_learning_err;
> > +	}
> > +
> > +	return 0;
> > +
> > + task_learning_err:
> > +	timer_delete_sync(&fep->timer_aging);
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
> > +	timer_delete_sync(&fep->timer_aging);
> > +	platform_set_drvdata(pdev, NULL);
> > +
> > +	kfree(fep); =20
>=20
> Jakub already pointed out that tools would find this bug but also
> testing. This was not ever tested. If it was, you would see nice clear
> double free.
>=20
> All last three versions had trivial issues which are pointed out by
> tooling, compilers, static analyzers. Before you post next version.
> please run standard kernel tools for static analysis, like coccinelle,
> smatch and sparse, and fix reported warnings. Also please check for
> warnings when building with W=3D1 with clang. Most of these commands
> (checks or W=3D1 build) can build specific targets, like some directory,
> to narrow the scope to only your code. The code here looks like it
> needs a fix. Feel free to get in touch if the warning is not clear.
>=20

Ok.

> You do not nede the the top-level, one of the most busy maintainers to
> point out the issues which compilers find as well. Using reviewers
> instead of automated tools is the easiest way to get grumpy responses.
>=20

Maybe I've striven to upstream the code too much recently as it takes
already 6 years (with 3 major rewrites of the code)...

Nonetheless, the code shall pass all required checks, so it is my
responsibility to fix it.

>=20
> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/AfDEEeGl27yToBj1zNjfdtu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgXRcQACgkQAR8vZIA0
zr2KUgf+KD52u499Vgab9Jt2UEJlNsvU+T9rSy8O33sf3yMI5jpkhWQVXZ0AxFzt
vp4H9atKGi4oTP9cJiTmMLFTC1ARgZic1WGey+3FldZt39npXjoTWpj3pDT2k6UI
/JRCb7AaOZ5G+bCDoOus7yzuY/8aGxIpJBOFAFBnBorxGxy/yhthfIDrjTiW76ko
nVU4gLHEpK3oFkEbAzHAthqOYs9kNg2ajtwnAaVqP65m23DV5NzThQjJLWHHCxW4
zccjGMissxmwfWyv80W6aq/7B2dRMTzbsSE1mZ4qmUAz4r7cifcvbRcLzqmpq3NY
XwYYClvl5wKMHyGVj6dEOis6gaSQCw==
=kSSl
-----END PGP SIGNATURE-----

--Sig_/AfDEEeGl27yToBj1zNjfdtu--

