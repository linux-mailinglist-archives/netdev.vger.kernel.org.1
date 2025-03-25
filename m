Return-Path: <netdev+bounces-177426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733B1A70236
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D5716F1B4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D4D258CE1;
	Tue, 25 Mar 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="cXvxuRhx"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B418BC3B;
	Tue, 25 Mar 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909317; cv=none; b=EB/LUWX+DDe+ziWDl6v50eL32rYr+09n/QHKUTMzJ81cNqwNLoWdnk0k7yLl9ZFuZN3FlMN/4L6fwBaHblBzwNZkN9Si0nrtIiAigQmKKM4blMxXgPubLK0WCGZEdjk45V+5EDfPL40BNC9NEbOUiQ3T3wCQ3dz5Ozhk2hW5r3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909317; c=relaxed/simple;
	bh=eh8XNzF0dC5hzcHiZVl91chINXxcVrjgR/sD0fl0YeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQdVEcKrMBSy2iFbNjgGeoPi2I37ppXhRcHCYdzkQ4Ki9XFAxp2Oq7Y+Pce9XvVlOpQgmt7rdFKAOS06rHpbyShh6pfXyw4LrJbTT5EN6fjy+pe6yaETftDGy0ZtcQd1sAkLqQ6y6pjKIoAi+tqujLb4frFPXeHT0W6nihCJyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=cXvxuRhx; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7E76102F66E1;
	Tue, 25 Mar 2025 14:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742909311; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lp1xXlGfpColhg0+n1ZdYqVOlPI1NjNGyjYPUGRBcBE=;
	b=cXvxuRhx06SaLJAL+abXeIjaG2WBmk92+Md/LdiJor4BM6rK3kkUWVmW/M7q3gUMc8UapI
	Iv12IzrjwHf0H8WbL79N0zuaQCM1IP+weBRyYuDKL9Oy5B7Gef+CMYs0mW5xC+iMATZY7L
	IZ6r99E6vXEMd6z+JpJCdATeV32LR8EjHy297k3Kj0/9HDs10wvoYB2uQnwK+OJYyFMO2B
	l16VsJSLUaMu+EDiAQYkcE/XD0tekA6P/0EzfgpohOzQfZw2LJ8DERK2RPWs24YRsZQN6Y
	oqg9MkqyftxPt7FlxGio3MR73PJ6pUs0gGChHZKtnXEEMCyXXUm8qzvsVe5Xdg==
Date: Tue, 25 Mar 2025 14:28:10 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, Andrew Lunn <andrew+netdev@lunn.ch>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 5/5] net: mtip: The L2 switch driver for imx287
Message-ID: <20250325142810.0aa07912@wsk>
In-Reply-To: <32d93a90-3601-4094-8054-2737a57acbc7@kernel.org>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-6-lukma@denx.de>
	<32d93a90-3601-4094-8054-2737a57acbc7@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ToD0LkzQNNSL0fAVtNGYYTF";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/ToD0LkzQNNSL0fAVtNGYYTF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 25/03/2025 12:57, Lukasz Majewski wrote:
> > This patch series provides support for More Than IP L2 switch
> > embedded in the imx287 SoC.
> >=20
> > This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> > which can be used for offloading the network traffic.
> >=20
> > It can be used interchangeable with current FEC driver - to be more
> > specific: one can use either of it, depending on the requirements.
> >=20
> > The biggest difference is the usage of DMA - when FEC is used,
> > separate DMAs are available for each ENET-MAC block.
> > However, with switch enabled - only the DMA0 is used to
> > send/receive data.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  drivers/net/ethernet/freescale/Kconfig        |    1 +
> >  drivers/net/ethernet/freescale/Makefile       |    1 +
> >  drivers/net/ethernet/freescale/mtipsw/Kconfig |   10 +
> >  .../net/ethernet/freescale/mtipsw/Makefile    |    6 +
> >  .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 2108
> > +++++++++++++++++ .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |
> > 784 ++++++ .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  113 +
> >  .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  434 ++++
> >  8 files changed, 3457 insertions(+)
> >  create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
> >  create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
> >  create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> >  create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
> >  create mode 100644
> > drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c create mode
> > 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
> >=20
> > diff --git a/drivers/net/ethernet/freescale/Kconfig
> > b/drivers/net/ethernet/freescale/Kconfig index
> > a2d7300925a8..056a11c3a74e 100644 ---
> > a/drivers/net/ethernet/freescale/Kconfig +++
> > b/drivers/net/ethernet/freescale/Kconfig @@ -60,6 +60,7 @@ config
> > FEC_MPC52xx_MDIO=20
> >  source "drivers/net/ethernet/freescale/fs_enet/Kconfig"
> >  source "drivers/net/ethernet/freescale/fman/Kconfig"
> > +source "drivers/net/ethernet/freescale/mtipsw/Kconfig"
> > =20
> >  config FSL_PQ_MDIO
> >  	tristate "Freescale PQ MDIO"
> > diff --git a/drivers/net/ethernet/freescale/Makefile
> > b/drivers/net/ethernet/freescale/Makefile index
> > de7b31842233..0e6cacb0948a 100644 ---
> > a/drivers/net/ethernet/freescale/Makefile +++
> > b/drivers/net/ethernet/freescale/Makefile @@ -25,3 +25,4 @@
> > obj-$(CONFIG_FSL_DPAA_ETH) +=3D dpaa/ obj-$(CONFIG_FSL_DPAA2_ETH) +=3D
> > dpaa2/=20
> >  obj-y +=3D enetc/
> > +obj-y +=3D mtipsw/
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/Kconfig
> > b/drivers/net/ethernet/freescale/mtipsw/Kconfig new file mode 100644
> > index 000000000000..5cc9b758bad4
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> > @@ -0,0 +1,10 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config FEC_MTIP_L2SW
> > +	tristate "MoreThanIP L2 switch support to FEC driver"
> > +	depends on OF
> > +	depends on NET_SWITCHDEV
> > +	depends on BRIDGE
> > +	depends on ARCH_MXS || ARCH_MXC =20
>=20
> Missing compile test

Could you be more specific?

I'm compiling and testing this driver for the last week... (6.6 LTS +
net-next).

>=20
> > +	help
> > +		This enables support for the MoreThan IP L2 switch
> > on i.MX
> > +		SoCs (e.g. iMX28, vf610). =20
>=20
> Wrong indentation. Look at other Kconfig files.

The indentation from Kconfig from FEC:

<tab>help
<tab><2 spaces>FOO BAR....

also causes the checkpatch on net-next to generated WARNING.

>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/Makefile
> > b/drivers/net/ethernet/freescale/mtipsw/Makefile new file mode
> > 100644 index 000000000000..e87e06d6870a
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/mtipsw/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for the L2 switch from MTIP embedded in NXP SoCs =20
>=20
> Drop, obvious.

Ok.

>=20
>=20
> ...
>=20
> > +
> > +static int mtip_parse_of(struct switch_enet_private *fep,
> > +			 struct device_node *np)
> > +{
> > +	struct device_node *port, *p;
> > +	unsigned int port_num;
> > +	int ret;
> > +
> > +	p =3D of_find_node_by_name(np, "ethernet-ports");
> > +
> > +	for_each_available_child_of_node(p, port) {
> > +		if (of_property_read_u32(port, "reg", &port_num))
> > +			continue;
> > +
> > +		fep->n_ports =3D port_num;
> > +		of_get_mac_address(port, &fep->mac[port_num -
> > 1][0]); +
> > +		ret =3D of_property_read_string(port, "label",
> > +
> > &fep->ndev_name[port_num - 1]);
> > +		if (ret < 0) {
> > +			pr_err("%s: Cannot get ethernet port name
> > (%d)!\n",
> > +			       __func__, ret);
> > +			goto of_get_err; =20
>=20
> Just use scoped loop.

I've used for_each_available_child_of_node(p, port) {} to iterate
through children.

Is it wrong?

>=20
> > +		}
> > +
> > +		ret =3D of_get_phy_mode(port,
> > &fep->phy_interface[port_num - 1]);
> > +		if (ret < 0) {
> > +			pr_err("%s: Cannot get PHY mode (%d)!\n",
> > __func__,
> > +			       ret); =20
>=20
> No, drivers do not use pr_xxx. From where did you get this code?

There have been attempts to upstream this driver since 2020...
The original code is from - v4.4 for vf610 and 2.6.35 for imx287.

It has been then subsequently updated/rewritten for:

- 4.19-cip
- 5.12 (two versions for switchdev and DSA)
- 6.6 LTS
- net-next.

The pr_err() were probably added by me as replacement for
"printk(KERN_ERR". I can change them to dev_* or netdev_*. This shall
not be a problem.

>=20
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
> > +	return 0;
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
> > +static const struct fec_devinfo fec_imx28_l2switch_info =3D {
> > +	.quirks =3D FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_SINGLE_MDIO,
> > +};
> > +
> > +static struct platform_device_id pdev_id =3D {
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
> > +	struct resource *r;
> > +	int err, ret;
> > +	u32 rev;
> > +
> > +	pr_info("Ethernet Switch Version %s\n", VERSION); =20
>=20
> Drivers use dev, not pr. Anyway drop. Drivers do not have versions and
> should be silent on success.

As I've written above - there are several "versions" on this particular
driver. Hence the information.

I would opt for dev_info() for backwards compatibility.

>=20
> > +
> > +	fep =3D kzalloc(sizeof(*fep), GFP_KERNEL); =20
>=20
> Why not devm? See last comment here (at the end).

As I've written above - no problem to change it.

>=20
> > +	if (!fep)
> > +		return -ENOMEM;
> > +
> > +	pdev->id_entry =3D &pdev_id;
> > +
> > +	dev_info =3D (struct fec_devinfo
> > *)pdev->id_entry->driver_data;
> > +	if (dev_info)
> > +		fep->quirks =3D dev_info->quirks;
> > +
> > +	fep->pdev =3D pdev;
> > +	platform_set_drvdata(pdev, fep);
> > +
> > +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	fep->enet_addr =3D devm_ioremap_resource(&pdev->dev, r); =20
>=20
> Use proper wrapper.

I've followed following pattern:
https://elixir.bootlin.com/linux/v6.13.7/source/lib/devres.c#L180

>=20
> > +	if (IS_ERR(fep->enet_addr)) {
> > +		ret =3D PTR_ERR(fep->enet_addr);
> > +		goto failed_ioremap;
> > +	}
> > +
> > +	fep->irq =3D platform_get_irq(pdev, 0);
> > +
> > +	ret =3D mtip_parse_of(fep, np);
> > +	if (ret < 0) {
> > +		pr_err("%s: OF parse error (%d)!\n", __func__,
> > ret);
> > +		goto failed_parse_of;
> > +	}
> > +
> > +	/* Create an Ethernet device instance.
> > +	 * The switch lookup address memory starts 0x800FC000
> > +	 */
> > +	fep->hwp_enet =3D fep->enet_addr;
> > +	fecp =3D (struct switch_t *)(fep->enet_addr +
> > ENET_SWI_PHYS_ADDR_OFFSET); +
> > +	fep->hwp =3D fecp;
> > +	fep->hwentry =3D (struct mtip_addr_table_t *)
> > +		((unsigned long)fecp + MCF_ESW_LOOKUP_MEM_OFFSET);
> > +
> > +	rev =3D readl(&fecp->ESW_REVISION);
> > +	pr_info("Ethernet Switch HW rev 0x%x:0x%x\n",
> > +		MCF_MTIP_REVISION_CUSTOMER_REVISION(rev),
> > +		MCF_MTIP_REVISION_CORE_REVISION(rev)); =20
>=20
> Drop

Ok.

>=20
> > +
> > +	fep->reg_phy =3D devm_regulator_get(&pdev->dev, "phy");
> > +	if (!IS_ERR(fep->reg_phy)) {
> > +		ret =3D regulator_enable(fep->reg_phy);
> > +		if (ret) {
> > +			dev_err(&pdev->dev,
> > +				"Failed to enable phy regulator:
> > %d\n", ret);
> > +			goto failed_regulator;
> > +		}
> > +	} else {
> > +		if (PTR_ERR(fep->reg_phy) =3D=3D -EPROBE_DEFER) {
> > +			ret =3D -EPROBE_DEFER;
> > +			goto failed_regulator;
> > +		}
> > +		fep->reg_phy =3D NULL; =20
>=20
> I don't understand this code. Do you want to re-implement
> get_optional? But why?

Here the get_optional() shall be used.

>=20
> > +	}
> > +
> > +	fep->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
> > +	if (IS_ERR(fep->clk_ipg))
> > +		fep->clk_ipg =3D NULL; =20
>=20
> Why?

I will update the code.

>=20
> > +
> > +	fep->clk_ahb =3D devm_clk_get(&pdev->dev, "ahb");
> > +	if (IS_ERR(fep->clk_ahb))
> > +		fep->clk_ahb =3D NULL;
> > +
> > +	fep->clk_enet_out =3D devm_clk_get(&pdev->dev, "enet_out");
> > +	if (IS_ERR(fep->clk_enet_out))
> > +		fep->clk_enet_out =3D NULL;
> > +

devm_clk_get_optional() shall be used for 'enet_out'.

> > +	ret =3D clk_prepare_enable(fep->clk_ipg);
> > +	if (ret) {
> > +		pr_err("%s: clock ipg cannot be enabled\n",
> > __func__);
> > +		goto failed_clk_ipg;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(fep->clk_ahb);
> > +	if (ret) {
> > +		pr_err("%s: clock ahb cannot be enabled\n",
> > __func__);
> > +		goto failed_clk_ahb;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(fep->clk_enet_out);
> > +	if (ret)
> > +		pr_err("%s: clock clk_enet_out cannot be
> > enabled\n", __func__); +
> > +	spin_lock_init(&fep->learn_lock);
> > +
> > +	ret =3D mtip_reset_phy(pdev);
> > +	if (ret < 0) {
> > +		pr_err("%s: GPIO PHY RST error (%d)!\n", __func__,
> > ret);
> > +		goto get_phy_mode_err;
> > +	}
> > +
> > +	ret =3D request_irq(fep->irq, mtip_interrupt, 0,
> > "mtip_l2sw", fep);
> > +	if (ret) {
> > +		pr_err("MTIP_L2: Could not alloc IRQ(%d)!\n",
> > fep->irq);
> > +		goto request_irq_err;
> > +	}
> > +
> > +	spin_lock_init(&fep->hw_lock);
> > +	spin_lock_init(&fep->mii_lock);
> > +
> > +	ret =3D mtip_register_notifiers(fep);
> > +	if (ret)
> > +		goto clean_unregister_netdev;
> > +
> > +	ret =3D mtip_ndev_init(fep);
> > +	if (ret) {
> > +		pr_err("%s: Failed to create virtual ndev (%d)\n",
> > +		       __func__, ret);
> > +		goto mtip_ndev_init_err;
> > +	}
> > +
> > +	err =3D mtip_switch_dma_init(fep);
> > +	if (err) {
> > +		pr_err("%s: ethernet switch init fail (%d)!\n",
> > __func__, err);
> > +		goto mtip_switch_dma_init_err;
> > +	}
> > +
> > +	err =3D mtip_mii_init(fep, pdev);
> > +	if (err)
> > +		pr_err("%s: Cannot init phy bus (%d)!\n",
> > __func__, err); +
> > +	/* setup timer for learning aging function */
> > +	timer_setup(&fep->timer_aging, mtip_aging_timer, 0);
> > +	mod_timer(&fep->timer_aging,
> > +		  jiffies +
> > msecs_to_jiffies(LEARNING_AGING_INTERVAL)); +
> > +	fep->task =3D kthread_run(mtip_sw_learning, fep,
> > "mtip_l2sw_learning");
> > +	if (IS_ERR(fep->task)) {
> > +		ret =3D PTR_ERR(fep->task);
> > +		pr_err("%s: learning kthread_run error (%d)!\n",
> > __func__, ret);
> > +		goto fail_task_learning;
> > +	}
> > +
> > +	/* setup MII interface for external switch ports*/
> > +	mtip_enet_init(fep, 1);
> > +	mtip_enet_init(fep, 2);
> > +
> > +	return 0;
> > +
> > + fail_task_learning:
> > +	mtip_mii_unregister(fep);
> > +	del_timer(&fep->timer_aging);
> > + mtip_switch_dma_init_err:
> > +	mtip_ndev_cleanup(fep);
> > + mtip_ndev_init_err:
> > +	mtip_unregister_notifiers(fep);
> > + clean_unregister_netdev:
> > +	free_irq(fep->irq, NULL);
> > + request_irq_err:
> > +	platform_set_drvdata(pdev, NULL);
> > + get_phy_mode_err:
> > +	if (fep->clk_enet_out)
> > +		clk_disable_unprepare(fep->clk_enet_out);
> > +	clk_disable_unprepare(fep->clk_ahb);
> > + failed_clk_ahb:
> > +	clk_disable_unprepare(fep->clk_ipg);
> > + failed_clk_ipg:
> > +	if (fep->reg_phy) {
> > +		regulator_disable(fep->reg_phy);
> > +		devm_regulator_put(fep->reg_phy);
> > +	}
> > + failed_regulator:
> > + failed_parse_of:
> > +	devm_ioremap_release(&pdev->dev, r);
> > + failed_ioremap:
> > +	kfree(fep);
> > +	return err;
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
> > +	{ .compatible =3D "fsl,imx287-mtip-switch", },
> > +	{ /* sentinel */ }
> > +};
> > +
> > +static struct platform_driver mtipl2plat_driver =3D {
> > +	.probe          =3D mtip_sw_probe,
> > +	.remove         =3D mtip_sw_remove,
> > +	.driver         =3D {
> > +		.name   =3D "mtipl2sw",
> > +		.owner  =3D THIS_MODULE, =20
>=20
> Oh no, please do not send us 10-12 year old code. This is long, looong
> time gone. If you copied this pattern,

I've stated the chronology of this particular driver. It is working
with recent kernels.

> then for sure you copied all
> other issues we fixed during last 10 years, so basically you ask us to
> re-review the same code we already fixed.

I cannot agree with this statement.

Even better, the code has passed net-next's checkpatch.pl without
complaining about the "THIS_MODULE" statement.

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

--Sig_/ToD0LkzQNNSL0fAVtNGYYTF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfir2oACgkQAR8vZIA0
zr3towf9EuQrYlNola8c/k9YF80cYGUON/OajGVZmP3RKqYfRLoiAdGI08XlKQ6M
hPsQKJknU2sU8bLLfgtew+V45LNqIXIz57uFyhq3FkcGBHT6FktHKE2RBSTF0BOZ
cYxhHpWBZifarcyilRC6H2e2yH6s7rgidHP9X+8c1UdNgP/TWTWmtKWupeoON4eN
dB4EASHTLb6gMoj9mv2irCjg8scy0M8GBkkdmAtZcRsSY2awW66YB2bY9aRIpPdZ
6/2XLeTl1etM5XDo9axJuARajA8eieRl2DFOod2nxsW78bSIlUyxvmA+iiSeBBz6
TCLV3LIke2w9jE30lk43sZIjSvyElA==
=EPeC
-----END PGP SIGNATURE-----

--Sig_/ToD0LkzQNNSL0fAVtNGYYTF--

