Return-Path: <netdev+bounces-181693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0005BA86322
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278583B6E33
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FDC21B908;
	Fri, 11 Apr 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="U0PeYI+1"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D64213E65;
	Fri, 11 Apr 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388606; cv=none; b=MSLL5gHb1BRTuGzGg1G7jwW8L9kRXyEMkBfWT0aNWhzb50iyITXKcpjR3mCMBHWCZMWYMnHidMjLGlwlRy350smmA9q42UMngsYPf8tzIcwceIbPSRvRAmgpavSaErHbcwWgYk3RcJF5abCOscMI0Ohh67u8wTNGtuJo32+Gc7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388606; c=relaxed/simple;
	bh=bX5gf//gLe4HTi0xG4qcd5655L/UHY4vtT4unJzu7wU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+2JaX6vmzn6bgmG2FliucMy1NBCo5ZREexypH3fVN3hOWWYwyd3XurE9144l+E+ec6bdytqzFFmeW4dkfOFfzMIHeoGAuiWCPtyZ8eNUUpOXnwbRAxx5Ow3X0pfUshF2yDAUCJW1DxbqiWeIDTXKFdMBmDMCB7o4mLt8kuLp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=U0PeYI+1; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 899C0103B92D7;
	Fri, 11 Apr 2025 18:23:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744388601; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=i7toiZ3aam9FmI8Y9mV60LP7YPqeaa6HscQKkSu5zHE=;
	b=U0PeYI+1FyzkVZVseUqc/jpImE4b/LrGLZdAo9SAW+hYdtoFyX/j/n4u4iAfot99lSfS3s
	dLvlVZ0RneEYIX736NcBPca27ZjKcrlXeWjAZL97qGyK2MFyCZNS1HfMSrN4tFgclM3BQD
	pIvrpQJieTjsDIeubBD/XZmpkL1TPSYd2dqHWJPqyIMc9acJCos7eqA1QnH2BLhnU8NABW
	qi6EBMlEU6wt/Q3dvx+Ze58hBn87xfIBqgQuN7rfqseWbseTwgrwQF6GvpiQmd3vhbCcDV
	yo52dZ/Pkwm0gXveUpXo8lfvlZxjEnnHDJoDaIFqhO4NebIcWlUhYB7kLxFkSg==
Date: Fri, 11 Apr 2025 18:23:15 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next v4 4/5] net: mtip: The L2 switch driver for imx287
Message-ID: <20250411182315.17b18a7f@wsk>
In-Reply-To: <90c19e6e-235e-465d-9e1e-1ebef49156a0@gmx.net>
References: <20250407145157.3626463-1-lukma@denx.de>
	<20250407145157.3626463-5-lukma@denx.de>
	<8ceea7c4-6333-43b9-b3c2-a0dceeb62a0c@gmx.net>
	<20250410153744.17e6ee5b@wsk>
	<90c19e6e-235e-465d-9e1e-1ebef49156a0@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PnT58d9hqwB_als1lKLOmPt";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/PnT58d9hqwB_als1lKLOmPt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Am 10.04.25 um 15:37 schrieb Lukasz Majewski:
> > Hi Stefan,
> > =20
> >> Hi Lukasz,
> >>
> >> thanks for sending this to linux-arm-kernel
> >>
> >> Am 07.04.25 um 16:51 schrieb Lukasz Majewski: =20
> >>> This patch series provides support for More Than IP L2 switch
> >>> embedded in the imx287 SoC.
> >>>
> >>> This is a two port switch (placed between uDMA[01] and
> >>> MAC-NET[01]), which can be used for offloading the network
> >>> traffic.
> >>>
> >>> It can be used interchangeably with current FEC driver - to be
> >>> more specific: one can use either of it, depending on the
> >>> requirements.
> >>>
> >>> The biggest difference is the usage of DMA - when FEC is used,
> >>> separate DMAs are available for each ENET-MAC block.
> >>> However, with switch enabled - only the DMA0 is used to
> >>> send/receive data to/form switch (and then switch sends them to
> >>> respecitive ports).
> >>>
> >>> Signed-off-by: Lukasz Majewski<lukma@denx.de>
> >>> ---
> >>> Changes for v2:
> >>>
> >>> - Remove not needed comments
> >>> - Restore udelay(10) for switch reset (such delay is explicitly
> >>> specifed in the documentation
> >>> - Add COMPILE_TEST
> >>> - replace pr_* with dev_*
> >>> - Use for_each_available_child_of_node_scoped()
> >>> - Use devm_* function for memory allocation
> >>> - Remove printing information about the HW and SW revision of the
> >>> driver
> >>> - Use devm_regulator_get_optional()
> >>> - Change compatible prefix from 'fsl' to more up to date 'nxp'
> >>> - Remove .owner =3D THIS_MODULE
> >>> - Use devm_platform_ioremap_resource(pdev, 0);
> >>> - Use devm_request_irq()
> >>> - Use devm_regulator_get_enable_optional()
> >>> - Replace clk_prepare_enable() and devm_clk_get() with single
> >>>     call to devm_clk_get_optional_enabled()
> >>> - Cleanup error patch when function calls in probe fail
> >>> - Refactor the mtip_reset_phy() to serve as mdio bus reset
> >>> callback
> >>> - Add myself as the MTIP L2 switch maintainer (squashed the
> >>> separated commit)
> >>> - More descriptive help paragraphs (> 4 lines)
> >>>
> >>> Changes for v3:
> >>> - Remove 'bridge_offloading' module parameter (to bridge ports
> >>> just after probe)
> >>> - Remove forward references
> >>> - Fix reverse christmas tree formatting in functions
> >>> - Convert eligible comments to kernel doc format
> >>> - Remove extra MAC address validation check at
> >>> esw_mac_addr_static()
> >>> - Remove mtip_print_link_status() and replace it with
> >>> phy_print_status()
> >>> - Avoid changing phy device state in the driver (instead use
> >>> functions exported by the phy API)
> >>> - Do not print extra information regarding PHY (which is printed
> >>> by phylib) - e.g. net lan0: lan0: MTIP eth L2 switch
> >>> 1e:ce:a5:0b:4c:12
> >>> - Remove VERSION from the driver - now we rely on the SHA1 in
> >>> Linux mainline tree
> >>> - Remove zeroing of the net device private area (shall be already
> >>> done during allocation)
> >>> - Refactor the code to remove mtip_ndev_setup()
> >>> - Use -ENOMEM instead of -1 return code when allocation fails
> >>> - Replace dev_info() with dev_dbg() to reduce number of
> >>> information print on normal operation
> >>> - Return ret instead of 0 from mtip_ndev_init()
> >>> - Remove fep->mii_timeout flag from the driver
> >>> - Remove not used stop_gpr_* fields in mtip_devinfo struct
> >>> - Remove platform_device_id description for mtipl2sw driver
> >>> - Add MODULE_DEVICE_TABLE() for mtip_of_match
> >>> - Remove MODULE_ALIAS()
> >>>
> >>> Changes for v4:
> >>> - Rename imx287 with imx28 (as the former is not used in kernel
> >>> anymore)
> >>> - Reorder the place where ENET interface is initialized - without
> >>> this change the enet_out clock has default (25 MHz) value, which
> >>> causes issues during reset (RMII's 50 MHz is required for proper
> >>> PHY reset).
> >>> - Use PAUR instead of PAUR register to program MAC address
> >>> - Replace eth_mac_addr() with eth_hw_addr_set()
> >>> - Write to HW the randomly generated MAC address (if required)
> >>> - Adjust the reset code
> >>> - s/read_atable/mtip_read_atable/g and
> >>> s/write_atable/mtip_write_atable/g
> >>> - Add clk_disable() and netif_napi_del() when errors occur during
> >>>     mtip_open() - refactor the error handling path.
> >>> - Refactor the mtip_set_multicast_list() to write (now) correct
> >>> values to ENET-FEC registers.
> >>> - Replace dev_warn() with dev_err()
> >>> - Use GPIO_ACTIVE_LOW to indicate polarity in DTS
> >>> - Refactor code to check if network device is the switch device
> >>> - Remove mtip_port_dev_check()
> >>> - Refactor mtip_ndev_port_link() avoid starting HW offloading for
> >>> bridge when MTIP ports are parts of two distinct bridges
> >>> - Replace del_timer() with timer_delete_sync()
> >>> ---
> >>>    MAINTAINERS                                   |    7 +
> >>>    drivers/net/ethernet/freescale/Kconfig        |    1 +
> >>>    drivers/net/ethernet/freescale/Makefile       |    1 +
> >>>    drivers/net/ethernet/freescale/mtipsw/Kconfig |   13 +
> >>>    .../net/ethernet/freescale/mtipsw/Makefile    |    3 +
> >>>    .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 1970
> >>> +++++++++++++++++ .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |
> >>> 782 +++++++ .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  122 +
> >>>    .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  449 ++++
> >>>    9 files changed, 3348 insertions(+)
> >>>    create mode 100644
> >>> drivers/net/ethernet/freescale/mtipsw/Kconfig create mode 100644
> >>> drivers/net/ethernet/freescale/mtipsw/Makefile create mode 100644
> >>> drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c create mode
> >>> 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h create
> >>> mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
> >>> create mode 100644
> >>> drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 4c5c2e2c1278..9c5626c2b3b7 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -9455,6 +9455,13 @@ S:	Maintained
> >>>    F:	Documentation/devicetree/bindings/i2c/i2c-mpc.yaml
> >>>    F:	drivers/i2c/busses/i2c-mpc.c
> >>>
> >>> +FREESCALE MTIP ETHERNET SWITCH DRIVER
> >>> +M:	Lukasz Majewski<lukma@denx.de>
> >>> +L:	netdev@vger.kernel.org
> >>> +S:	Maintained
> >>> +F:
> >>> Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> >>> +F:	drivers/net/ethernet/freescale/mtipsw/* +
> >>>    FREESCALE QORIQ DPAA ETHERNET DRIVER
> >>>    M:	Madalin Bucur<madalin.bucur@nxp.com>
> >>>    L:	netdev@vger.kernel.org
> >>> diff --git a/drivers/net/ethernet/freescale/Kconfig
> >>> b/drivers/net/ethernet/freescale/Kconfig index
> >>> a2d7300925a8..056a11c3a74e 100644 ---
> >>> a/drivers/net/ethernet/freescale/Kconfig +++
> >>> b/drivers/net/ethernet/freescale/Kconfig @@ -60,6 +60,7 @@ config
> >>> FEC_MPC52xx_MDIO
> >>>
> >>>    source "drivers/net/ethernet/freescale/fs_enet/Kconfig"
> >>>    source "drivers/net/ethernet/freescale/fman/Kconfig"
> >>> +source "drivers/net/ethernet/freescale/mtipsw/Kconfig"
> >>>
> >>>    config FSL_PQ_MDIO
> >>>    	tristate "Freescale PQ MDIO" diff --git
> >>> a/drivers/net/ethernet/freescale/Makefile
> >>> b/drivers/net/ethernet/freescale/Makefile index
> >>> de7b31842233..0e6cacb0948a 100644 ---
> >>> a/drivers/net/ethernet/freescale/Makefile +++
> >>> b/drivers/net/ethernet/freescale/Makefile @@ -25,3 +25,4 @@
> >>> obj-$(CONFIG_FSL_DPAA_ETH) +=3D dpaa/ obj-$(CONFIG_FSL_DPAA2_ETH) +=3D
> >>> dpaa2/ obj-y +=3D enetc/ +obj-y +=3D mtipsw/ diff --git
> >>> a/drivers/net/ethernet/freescale/mtipsw/Kconfig
> >>> b/drivers/net/ethernet/freescale/mtipsw/Kconfig new file mode
> >>> 100644 index 000000000000..450ff734a321 --- /dev/null +++
> >>> b/drivers/net/ethernet/freescale/mtipsw/Kconfig @@ -0,0 +1,13 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only +config FEC_MTIP_L2SW +
> >>> tristate "MoreThanIP L2 switch support to FEC driver"
> >>> +	depends on OF
> >>> +	depends on NET_SWITCHDEV
> >>> +	depends on BRIDGE
> >>> +	depends on ARCH_MXS || ARCH_MXC || COMPILE_TEST
> >>> +	help
> >>> +	  This enables support for the MoreThan IP L2 switch on
> >>> i.MX
> >>> +	  SoCs (e.g. iMX28, vf610). It offloads bridging to this
> >>> IP block's =20
> >> This is confusing. The Kconfig and most of the code looks prepared
> >> for other platforms than i.MX28, but there is only a i.MX28 OF
> >> compatible. =20
> > I've took the approach to upstream the driver in several steps.
> > The first step is this patch set - add the code for a single
> > platform (imx28).
> >
> > And Yes, I also have on my desk another board with soc having this
> > IP block (vf610).
> >
> > However, I will not start any other upstream work until patches from
> > this "step" are not pulled.
> >
> > (To follow "one things at a time" principle)
> > =20
> >> I don't like that Kconfig pretent something, which is not
> >> true. =20
> > If you prefer I can remove 'depends on ARCH_MXC' and the vf610
> > SoC... (only to add it afterwards). =20
> In case you want to do "one thing at a time", please remove this.

+1

> >>> +
> >>> +static void mtip_config_switch(struct switch_enet_private *fep)
> >>> +{
> >>> +	struct switch_t *fecp =3D fep->hwp;
> >>> +
> >>> +	esw_mac_addr_static(fep);
> >>> +
> >>> +	writel(0, &fecp->ESW_BKLR);
> >>> +
> >>> +	/* Do NOT disable learning */
> >>> +	mtip_port_learning_config(fep, 0, 0, 0);
> >>> +	mtip_port_learning_config(fep, 1, 0, 0);
> >>> +	mtip_port_learning_config(fep, 2, 0, 0); =20
> >> Looks like the last 2 parameter are always 0? =20
> > Those functions are defined in mtipl2sw_mgnt.c file.
> >
> > I've followed the way legacy (i.e. vendor) driver has defined them.
> > In this particular case the last '0' is to not enable interrupt for
> > learning. =20
> This wasn't my concern. The question was "why do we need a parameter
> if it's always the same?". But you answered this further below, so
> i'm fine.

Ok.

> >>> +
> >>> +static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
> >>> +{
> >>> +	struct switch_enet_private *fep =3D ptr_fep;
> >>> +	struct switch_t *fecp =3D fep->hwp;
> >>> +	irqreturn_t ret =3D IRQ_NONE;
> >>> +	u32 int_events, int_imask;
> >>> +
> >>> +	/* Get the interrupt events that caused us to be here */
> >>> +	do {
> >>> +		int_events =3D readl(&fecp->ESW_ISR);
> >>> +		writel(int_events, &fecp->ESW_ISR);
> >>> +
> >>> +		if (int_events & (MCF_ESW_ISR_RXF |
> >>> MCF_ESW_ISR_TXF)) {
> >>> +			ret =3D IRQ_HANDLED;
> >>> +			/* Disable the RX interrupt */
> >>> +			if (napi_schedule_prep(&fep->napi)) {
> >>> +				int_imask =3D
> >>> readl(&fecp->ESW_IMR);
> >>> +				int_imask &=3D ~MCF_ESW_IMR_RXF;
> >>> +				writel(int_imask,
> >>> &fecp->ESW_IMR);
> >>> +				__napi_schedule(&fep->napi);
> >>> +			}
> >>> +		}
> >>> +	} while (int_events); =20
> >> This looks bad, in case of bad hardware / timing behavior this
> >> interrupt handler will loop forever. =20
> > The 'writel(int_events, &fecp->ESW_ISR);'
> >
> > clears the interrupts, so after reading them and clearing (by
> > writing the same value), the int_events shall be 0.
> >
> > Also, during probe the IRQ mask for switch IRQ is written, so only
> > expected (and served) interrupts are delivered. =20
> This was not my point. A possible endless loop especially in a
> interrupt handler should be avoided. The kernel shouldn't trust the
> hardware and the driver should be fair to all the other interrupts
> which might have occurred.

Ok.

> > +
> > +static int mtip_rx_napi(struct napi_struct *napi, int budget)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(napi->dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct switch_t *fecp =3D fep->hwp;
> > +	int pkts, port;
> > +
> > +	pkts =3D mtip_switch_rx(napi->dev, budget, &port);
> > +	if (!fep->br_offload &&
> > +	    (port =3D=3D 1 || port =3D=3D 2) && fep->ndev[port - 1]) =20
> >> (port > 0) && fep->ndev[port - 1]) =20
> > This needs to be kept as is - only when port is set to 1 or 2 (after
> > reading the switch internal register) this shall be executed. =20
> Oops, missed that
> > (port also can be 0xFF or 0x3 -> then we shall send frame to both
> > egress ports). =20
> Maybe we should use defines for such special values

Port =3D 1 or port =3D 2 seems to be self explanatory.

Nonetheless, I've added MTIP_PORT_FORWARDING_INIT for 0xFF initial
forwarding value.

> > This code is responsible for port separation when bridge HW
> > offloading is disabled.
> >
> > =20
> >>> +		of_get_mac_address(port, &fep->mac[port_num -
> >>> 1][0]); =20
> >> This can fail =20
> > I will add:
> >
> > ret =3D of_get_mac_address(port, &fep->mac[port_num - 1][0]);
> > if (ret)
> > 	dev_warn(dev, "of_get_mac_address(%pOF) failed\n", port);
> >
> > as it is also valid to not have the mac address defined in DTS (then
> > some random based value is generated). =20
> AFAIK this is a little bit more complex. It's possible that the MAC is
> stored within a NVMEM and the driver isn't ready (EPROBE_DEFER).
>=20

In my use case - always the local mac address is provided during
production (to ethernet-port nodes).

The other possibility is no MAC address provided, that is why there is
dev_warn().

> Are you sure about the randomize fallback behavior of
> of_get_mac_address() ?
>=20
> I tought you still need to call eth_random_addr().
>=20

The "random" MAC address is generated in another place - namely
mtip_setup_mac();

>=20
> >>> +
> >>> +int mtip_set_vlan_verification(struct switch_enet_private *fep,
> >>> int port,
> >>> +			       int vlan_domain_verify_en,
> >>> +			       int vlan_discard_unknown_en)
> >>> +{
> >>> +	struct switch_t *fecp =3D fep->hwp;
> >>> +
> >>> +	if (port < 0 || port > 2) {
> >>> +		dev_err(&fep->pdev->dev, "%s: Port (%d) not
> >>> supported!\n",
> >>> +			__func__, port);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	if (vlan_domain_verify_en =3D=3D 1) {
> >>> +		if (port =3D=3D 0)
> >>> +			writel(readl(&fecp->ESW_VLANV) |
> >>> MCF_ESW_VLANV_VV0,
> >>> +			       &fecp->ESW_VLANV);
> >>> +		else if (port =3D=3D 1)
> >>> +			writel(readl(&fecp->ESW_VLANV) |
> >>> MCF_ESW_VLANV_VV1,
> >>> +			       &fecp->ESW_VLANV);
> >>> +		else if (port =3D=3D 2)
> >>> +			writel(readl(&fecp->ESW_VLANV) |
> >>> MCF_ESW_VLANV_VV2,
> >>> +			       &fecp->ESW_VLANV);
> >>> +	} else if (vlan_domain_verify_en =3D=3D 0) {
> >>> +		if (port =3D=3D 0)
> >>> +			writel(readl(&fecp->ESW_VLANV) &
> >>> ~MCF_ESW_VLANV_VV0,
> >>> +			       &fecp->ESW_VLANV);
> >>> +		else if (port =3D=3D 1)
> >>> +			writel(readl(&fecp->ESW_VLANV) &
> >>> ~MCF_ESW_VLANV_VV1,
> >>> +			       &fecp->ESW_VLANV);
> >>> +		else if (port =3D=3D 2)
> >>> +			writel(readl(&fecp->ESW_VLANV) &
> >>> ~MCF_ESW_VLANV_VV2,
> >>> +			       &fecp->ESW_VLANV);
> >>> +	}
> >>> +
> >>> +	if (vlan_discard_unknown_en =3D=3D 1) {
> >>> +		if (port =3D=3D 0)
> >>> +			writel(readl(&fecp->ESW_VLANV) |
> >>> MCF_ESW_VLANV_DU0,
> >>> +			       &fecp->ESW_VLANV);
> >>> +		else if (port =3D=3D 1)
> >>> +			writel(readl(&fecp->ESW_VLANV) |
> >>> MCF_ESW_VLANV_DU1,
> >>> +			       &fecp->ESW_VLANV);
> >>> +		else if (port =3D=3D 2)
> >>> +			writel(readl(&fecp->ESW_VLANV) |
> >>> MCF_ESW_VLANV_DU2,
> >>> +			       &fecp->ESW_VLANV);
> >>> +	} else if (vlan_discard_unknown_en =3D=3D 0) {
> >>> +		if (port =3D=3D 0)
> >>> +			writel(readl(&fecp->ESW_VLANV) &
> >>> ~MCF_ESW_VLANV_DU0,
> >>> +			       &fecp->ESW_VLANV);
> >>> +		else if (port =3D=3D 1)
> >>> +			writel(readl(&fecp->ESW_VLANV) &
> >>> ~MCF_ESW_VLANV_DU1,
> >>> +			       &fecp->ESW_VLANV);
> >>> +		else if (port =3D=3D 2)
> >>> +			writel(readl(&fecp->ESW_VLANV) &
> >>> ~MCF_ESW_VLANV_DU2,
> >>> +			       &fecp->ESW_VLANV);
> >>> +	} =20
> >> This looks like a lot of copy & paste =20
> > IMHO, the readability of the code is OK. =20
> Actually the concern was about maintenance.

IMHO, (for me) the maintenance cost of this code is acceptable.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/PnT58d9hqwB_als1lKLOmPt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmf5QfMACgkQAR8vZIA0
zr2f+QgAlF7OeAre3nTYFZiVN+1Yt/F4dKrvb0XOQzfy1iWSxYZi1P9OPSFHznwL
dKLMe43mE85YlVOGRjHYncTNvMaFABZj1AWKTxSQB4xSb4Ksjl3L8nOL1z7sNZHL
fKJuVUaT8v2yu7+/SlYt4ea1Bp3+U+ZTU/JAJn2apb89RLxde1Y0/YT9PtB/OLbN
LlmpYnB6PblMqL6UqNXObbu3R3aIyAfEjcSbUwfB06sCCnl0DvBMLTrhAPYe1Y8C
n8Ghz4dHx6Jwqzb78mG7cX2qHpUuafCc06kwbqJhVRgRjnSPVFJpn3iR78aaObWy
7Dxjr0qTlChyq+91qF9OVCm3OxrZ6A==
=pTcG
-----END PGP SIGNATURE-----

--Sig_/PnT58d9hqwB_als1lKLOmPt--

