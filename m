Return-Path: <netdev+bounces-181644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBEDA85F0A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25EAD4C2B4E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3439C1D5CF2;
	Fri, 11 Apr 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="iFu2QJV3"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6919005D;
	Fri, 11 Apr 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378181; cv=none; b=SZe/d8ePwCUk/qM3qbGjEb7/WghSa0cXPQ7dLHAkQ5Ilnqkmq2mDs/QesssDBjepPNt8/Kyh9UQ2cR37J5Qf1IErRAX68FX+m+RB0jyWnbbhaJ63jZia8vksWsOtnnW6QBXRHftXKN5cOXCr8WFJ6+2m9GeNfjJHQnMo/JLteUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378181; c=relaxed/simple;
	bh=WtYAtu+NmsllU6F+82YMJeomg+9D9xmjlNH4mfwh3Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZ96ukg1M+QyJI33I54VqDi1D/3ReKZRChslMXMvmXUzFIB7zmYQrGsL5gAEhUYZip4sQY0jJhdIzgzB47f2kux2bpEN4o+P/Bj4MtW5r38fxrR6gPYz3oKqGm5u+pyP4BSOyegTg7efx68mCKeTs7IRdkgFC/X9F/6Pg+8oHFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=iFu2QJV3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744378151; x=1744982951; i=wahrenst@gmx.net;
	bh=tbaNocLjhfci7COa0du/8a3Z6zhu4sS9nBTlQidcANU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iFu2QJV3km17DWUv1RMovghE+MUXlVP2wDTztP1KCNnOgcuR7MNHH/YysoPWLUzP
	 u62y5hgUY30zxV182JpL8rwXxFwMIurCNebKxgJPo5M1aQSPfYO8f1GvEnF8T7wXq
	 Z+8t8bxMUdGbbFgYS6jZiGdQYve5fC/Qo+CjgtEFVEe6fyAZLa/ZMlc9TBZq5h8eg
	 ME+V8LwiuwBSw+zA7MWJDujjCUTlsD0ZrbI2IhaqU93gOXSDPK0G8CSBdcfaVAo/z
	 pDilZIsyK3rJCL5XqRaXPhhJX6oncXnuBpUO+Si706hQDPEm5u92pzFyBiZ/Eb4kD
	 9nwKjjMeiDn6WLfCUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1tSW330iOA-00c0LM; Fri, 11
 Apr 2025 15:29:11 +0200
Message-ID: <90c19e6e-235e-465d-9e1e-1ebef49156a0@gmx.net>
Date: Fri, 11 Apr 2025 15:29:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v4 4/5] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20250407145157.3626463-1-lukma@denx.de>
 <20250407145157.3626463-5-lukma@denx.de>
 <8ceea7c4-6333-43b9-b3c2-a0dceeb62a0c@gmx.net> <20250410153744.17e6ee5b@wsk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250410153744.17e6ee5b@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KHhCgaw4fSaOA6B4jcV4pU7jzCZaybUsmlgiWW2wG4QnG9Azonv
 iNYgQD9Ps2oUF/5hzg1CJ1c4r7478xqJ6QvsLUKrf1A9z/NW6eqWB4TKxqUTEvayfdLaLSb
 9k2uUG/UEzxn/h7sYW7xeXuy2ftVsYsg6ijOH+e2lmpyxKoqaxak2FlSiPm+KkWDw4m/x1S
 UNlJuZe2XLDSzQt9R9Iuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x+lmbmyxDaQ=;xgH65VonI71YkZ7aaL5ob3Ra4UX
 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
 bWPWXfM2/K64TN10oE8gIQ=

Am 10.04.25 um 15:37 schrieb Lukasz Majewski:
> Hi Stefan,
>
>> Hi Lukasz,
>>
>> thanks for sending this to linux-arm-kernel
>>
>> Am 07.04.25 um 16:51 schrieb Lukasz Majewski:
>>> This patch series provides support for More Than IP L2 switch
>>> embedded in the imx287 SoC.
>>>
>>> This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
>>> which can be used for offloading the network traffic.
>>>
>>> It can be used interchangeably with current FEC driver - to be more
>>> specific: one can use either of it, depending on the requirements.
>>>
>>> The biggest difference is the usage of DMA - when FEC is used,
>>> separate DMAs are available for each ENET-MAC block.
>>> However, with switch enabled - only the DMA0 is used to
>>> send/receive data to/form switch (and then switch sends them to
>>> respecitive ports).
>>>
>>> Signed-off-by: Lukasz Majewski<lukma@denx.de>
>>> ---
>>> Changes for v2:
>>>
>>> - Remove not needed comments
>>> - Restore udelay(10) for switch reset (such delay is explicitly
>>> specifed in the documentation
>>> - Add COMPILE_TEST
>>> - replace pr_* with dev_*
>>> - Use for_each_available_child_of_node_scoped()
>>> - Use devm_* function for memory allocation
>>> - Remove printing information about the HW and SW revision of the
>>> driver
>>> - Use devm_regulator_get_optional()
>>> - Change compatible prefix from 'fsl' to more up to date 'nxp'
>>> - Remove .owner =3D THIS_MODULE
>>> - Use devm_platform_ioremap_resource(pdev, 0);
>>> - Use devm_request_irq()
>>> - Use devm_regulator_get_enable_optional()
>>> - Replace clk_prepare_enable() and devm_clk_get() with single
>>>     call to devm_clk_get_optional_enabled()
>>> - Cleanup error patch when function calls in probe fail
>>> - Refactor the mtip_reset_phy() to serve as mdio bus reset callback
>>> - Add myself as the MTIP L2 switch maintainer (squashed the
>>> separated commit)
>>> - More descriptive help paragraphs (> 4 lines)
>>>
>>> Changes for v3:
>>> - Remove 'bridge_offloading' module parameter (to bridge ports just
>>> after probe)
>>> - Remove forward references
>>> - Fix reverse christmas tree formatting in functions
>>> - Convert eligible comments to kernel doc format
>>> - Remove extra MAC address validation check at esw_mac_addr_static()
>>> - Remove mtip_print_link_status() and replace it with
>>> phy_print_status()
>>> - Avoid changing phy device state in the driver (instead use
>>> functions exported by the phy API)
>>> - Do not print extra information regarding PHY (which is printed by
>>> phylib) - e.g. net lan0: lan0: MTIP eth L2 switch 1e:ce:a5:0b:4c:12
>>> - Remove VERSION from the driver - now we rely on the SHA1 in Linux
>>>     mainline tree
>>> - Remove zeroing of the net device private area (shall be already
>>> done during allocation)
>>> - Refactor the code to remove mtip_ndev_setup()
>>> - Use -ENOMEM instead of -1 return code when allocation fails
>>> - Replace dev_info() with dev_dbg() to reduce number of information
>>> print on normal operation
>>> - Return ret instead of 0 from mtip_ndev_init()
>>> - Remove fep->mii_timeout flag from the driver
>>> - Remove not used stop_gpr_* fields in mtip_devinfo struct
>>> - Remove platform_device_id description for mtipl2sw driver
>>> - Add MODULE_DEVICE_TABLE() for mtip_of_match
>>> - Remove MODULE_ALIAS()
>>>
>>> Changes for v4:
>>> - Rename imx287 with imx28 (as the former is not used in kernel
>>> anymore)
>>> - Reorder the place where ENET interface is initialized - without
>>> this change the enet_out clock has default (25 MHz) value, which
>>> causes issues during reset (RMII's 50 MHz is required for proper
>>> PHY reset).
>>> - Use PAUR instead of PAUR register to program MAC address
>>> - Replace eth_mac_addr() with eth_hw_addr_set()
>>> - Write to HW the randomly generated MAC address (if required)
>>> - Adjust the reset code
>>> - s/read_atable/mtip_read_atable/g and
>>> s/write_atable/mtip_write_atable/g
>>> - Add clk_disable() and netif_napi_del() when errors occur during
>>>     mtip_open() - refactor the error handling path.
>>> - Refactor the mtip_set_multicast_list() to write (now) correct
>>> values to ENET-FEC registers.
>>> - Replace dev_warn() with dev_err()
>>> - Use GPIO_ACTIVE_LOW to indicate polarity in DTS
>>> - Refactor code to check if network device is the switch device
>>> - Remove mtip_port_dev_check()
>>> - Refactor mtip_ndev_port_link() avoid starting HW offloading for
>>> bridge when MTIP ports are parts of two distinct bridges
>>> - Replace del_timer() with timer_delete_sync()
>>> ---
>>>    MAINTAINERS                                   |    7 +
>>>    drivers/net/ethernet/freescale/Kconfig        |    1 +
>>>    drivers/net/ethernet/freescale/Makefile       |    1 +
>>>    drivers/net/ethernet/freescale/mtipsw/Kconfig |   13 +
>>>    .../net/ethernet/freescale/mtipsw/Makefile    |    3 +
>>>    .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 1970
>>> +++++++++++++++++ .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |
>>> 782 +++++++ .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  122 +
>>>    .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  449 ++++
>>>    9 files changed, 3348 insertions(+)
>>>    create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
>>>    create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
>>>    create mode 100644
>>> drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c create mode 100644
>>> drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h create mode 100644
>>> drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c create mode
>>> 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 4c5c2e2c1278..9c5626c2b3b7 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -9455,6 +9455,13 @@ S:	Maintained
>>>    F:	Documentation/devicetree/bindings/i2c/i2c-mpc.yaml
>>>    F:	drivers/i2c/busses/i2c-mpc.c
>>>
>>> +FREESCALE MTIP ETHERNET SWITCH DRIVER
>>> +M:	Lukasz Majewski<lukma@denx.de>
>>> +L:	netdev@vger.kernel.org
>>> +S:	Maintained
>>> +F:
>>> Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
>>> +F:	drivers/net/ethernet/freescale/mtipsw/* +
>>>    FREESCALE QORIQ DPAA ETHERNET DRIVER
>>>    M:	Madalin Bucur<madalin.bucur@nxp.com>
>>>    L:	netdev@vger.kernel.org
>>> diff --git a/drivers/net/ethernet/freescale/Kconfig
>>> b/drivers/net/ethernet/freescale/Kconfig index
>>> a2d7300925a8..056a11c3a74e 100644 ---
>>> a/drivers/net/ethernet/freescale/Kconfig +++
>>> b/drivers/net/ethernet/freescale/Kconfig @@ -60,6 +60,7 @@ config
>>> FEC_MPC52xx_MDIO
>>>
>>>    source "drivers/net/ethernet/freescale/fs_enet/Kconfig"
>>>    source "drivers/net/ethernet/freescale/fman/Kconfig"
>>> +source "drivers/net/ethernet/freescale/mtipsw/Kconfig"
>>>
>>>    config FSL_PQ_MDIO
>>>    	tristate "Freescale PQ MDIO" diff --git
>>> a/drivers/net/ethernet/freescale/Makefile
>>> b/drivers/net/ethernet/freescale/Makefile index
>>> de7b31842233..0e6cacb0948a 100644 ---
>>> a/drivers/net/ethernet/freescale/Makefile +++
>>> b/drivers/net/ethernet/freescale/Makefile @@ -25,3 +25,4 @@
>>> obj-$(CONFIG_FSL_DPAA_ETH) +=3D dpaa/ obj-$(CONFIG_FSL_DPAA2_ETH) +=3D
>>> dpaa2/ obj-y +=3D enetc/ +obj-y +=3D mtipsw/ diff --git
>>> a/drivers/net/ethernet/freescale/mtipsw/Kconfig
>>> b/drivers/net/ethernet/freescale/mtipsw/Kconfig new file mode
>>> 100644 index 000000000000..450ff734a321 --- /dev/null +++
>>> b/drivers/net/ethernet/freescale/mtipsw/Kconfig @@ -0,0 +1,13 @@ +#
>>> SPDX-License-Identifier: GPL-2.0-only +config FEC_MTIP_L2SW +
>>> tristate "MoreThanIP L2 switch support to FEC driver"
>>> +	depends on OF
>>> +	depends on NET_SWITCHDEV
>>> +	depends on BRIDGE
>>> +	depends on ARCH_MXS || ARCH_MXC || COMPILE_TEST
>>> +	help
>>> +	  This enables support for the MoreThan IP L2 switch on
>>> i.MX
>>> +	  SoCs (e.g. iMX28, vf610). It offloads bridging to this
>>> IP block's
>> This is confusing. The Kconfig and most of the code looks prepared for
>> other platforms than i.MX28, but there is only a i.MX28 OF
>> compatible.
> I've took the approach to upstream the driver in several steps.
> The first step is this patch set - add the code for a single platform
> (imx28).
>
> And Yes, I also have on my desk another board with soc having this IP
> block (vf610).
>
> However, I will not start any other upstream work until patches from
> this "step" are not pulled.
>
> (To follow "one things at a time" principle)
>
>> I don't like that Kconfig pretent something, which is not
>> true.
> If you prefer I can remove 'depends on ARCH_MXC' and the vf610 SoC...
> (only to add it afterwards).
In case you want to do "one thing at a time", please remove this.
>>> +
>>> +static void mtip_config_switch(struct switch_enet_private *fep)
>>> +{
>>> +	struct switch_t *fecp =3D fep->hwp;
>>> +
>>> +	esw_mac_addr_static(fep);
>>> +
>>> +	writel(0, &fecp->ESW_BKLR);
>>> +
>>> +	/* Do NOT disable learning */
>>> +	mtip_port_learning_config(fep, 0, 0, 0);
>>> +	mtip_port_learning_config(fep, 1, 0, 0);
>>> +	mtip_port_learning_config(fep, 2, 0, 0);
>> Looks like the last 2 parameter are always 0?
> Those functions are defined in mtipl2sw_mgnt.c file.
>
> I've followed the way legacy (i.e. vendor) driver has defined them. In
> this particular case the last '0' is to not enable interrupt for
> learning.
This wasn't my concern. The question was "why do we need a parameter if
it's always the same?". But you answered this further below, so i'm fine.
>>> +
>>> +static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
>>> +{
>>> +	struct switch_enet_private *fep =3D ptr_fep;
>>> +	struct switch_t *fecp =3D fep->hwp;
>>> +	irqreturn_t ret =3D IRQ_NONE;
>>> +	u32 int_events, int_imask;
>>> +
>>> +	/* Get the interrupt events that caused us to be here */
>>> +	do {
>>> +		int_events =3D readl(&fecp->ESW_ISR);
>>> +		writel(int_events, &fecp->ESW_ISR);
>>> +
>>> +		if (int_events & (MCF_ESW_ISR_RXF |
>>> MCF_ESW_ISR_TXF)) {
>>> +			ret =3D IRQ_HANDLED;
>>> +			/* Disable the RX interrupt */
>>> +			if (napi_schedule_prep(&fep->napi)) {
>>> +				int_imask =3D readl(&fecp->ESW_IMR);
>>> +				int_imask &=3D ~MCF_ESW_IMR_RXF;
>>> +				writel(int_imask, &fecp->ESW_IMR);
>>> +				__napi_schedule(&fep->napi);
>>> +			}
>>> +		}
>>> +	} while (int_events);
>> This looks bad, in case of bad hardware / timing behavior this
>> interrupt handler will loop forever.
> The 'writel(int_events, &fecp->ESW_ISR);'
>
> clears the interrupts, so after reading them and clearing (by writing
> the same value), the int_events shall be 0.
>
> Also, during probe the IRQ mask for switch IRQ is written, so only
> expected (and served) interrupts are delivered.
This was not my point. A possible endless loop especially in a interrupt
handler should be avoided. The kernel shouldn't trust the hardware and
the driver should be fair to all the other interrupts which might have
occurred.
> +
> +static int mtip_rx_napi(struct napi_struct *napi, int budget)
> +{
> +	struct mtip_ndev_priv *priv =3D netdev_priv(napi->dev);
> +	struct switch_enet_private *fep =3D priv->fep;
> +	struct switch_t *fecp =3D fep->hwp;
> +	int pkts, port;
> +
> +	pkts =3D mtip_switch_rx(napi->dev, budget, &port);
> +	if (!fep->br_offload &&
> +	    (port =3D=3D 1 || port =3D=3D 2) && fep->ndev[port - 1])
>> (port > 0) && fep->ndev[port - 1])
> This needs to be kept as is - only when port is set to 1 or 2 (after
> reading the switch internal register) this shall be executed.
Oops, missed that
> (port also can be 0xFF or 0x3 -> then we shall send frame to both
> egress ports).
Maybe we should use defines for such special values
> This code is responsible for port separation when bridge HW offloading
> is disabled.
>
>
>>> +		of_get_mac_address(port, &fep->mac[port_num -
>>> 1][0]);
>> This can fail
> I will add:
>
> ret =3D of_get_mac_address(port, &fep->mac[port_num - 1][0]);
> if (ret)
> 	dev_warn(dev, "of_get_mac_address(%pOF) failed\n", port);
>
> as it is also valid to not have the mac address defined in DTS (then
> some random based value is generated).
AFAIK this is a little bit more complex. It's possible that the MAC is
stored within a NVMEM and the driver isn't ready (EPROBE_DEFER).

Are you sure about the randomize fallback behavior of of_get_mac_address()=
 ?

I tought you still need to call eth_random_addr().


>>> +
>>> +int mtip_set_vlan_verification(struct switch_enet_private *fep,
>>> int port,
>>> +			       int vlan_domain_verify_en,
>>> +			       int vlan_discard_unknown_en)
>>> +{
>>> +	struct switch_t *fecp =3D fep->hwp;
>>> +
>>> +	if (port < 0 || port > 2) {
>>> +		dev_err(&fep->pdev->dev, "%s: Port (%d) not
>>> supported!\n",
>>> +			__func__, port);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (vlan_domain_verify_en =3D=3D 1) {
>>> +		if (port =3D=3D 0)
>>> +			writel(readl(&fecp->ESW_VLANV) |
>>> MCF_ESW_VLANV_VV0,
>>> +			       &fecp->ESW_VLANV);
>>> +		else if (port =3D=3D 1)
>>> +			writel(readl(&fecp->ESW_VLANV) |
>>> MCF_ESW_VLANV_VV1,
>>> +			       &fecp->ESW_VLANV);
>>> +		else if (port =3D=3D 2)
>>> +			writel(readl(&fecp->ESW_VLANV) |
>>> MCF_ESW_VLANV_VV2,
>>> +			       &fecp->ESW_VLANV);
>>> +	} else if (vlan_domain_verify_en =3D=3D 0) {
>>> +		if (port =3D=3D 0)
>>> +			writel(readl(&fecp->ESW_VLANV) &
>>> ~MCF_ESW_VLANV_VV0,
>>> +			       &fecp->ESW_VLANV);
>>> +		else if (port =3D=3D 1)
>>> +			writel(readl(&fecp->ESW_VLANV) &
>>> ~MCF_ESW_VLANV_VV1,
>>> +			       &fecp->ESW_VLANV);
>>> +		else if (port =3D=3D 2)
>>> +			writel(readl(&fecp->ESW_VLANV) &
>>> ~MCF_ESW_VLANV_VV2,
>>> +			       &fecp->ESW_VLANV);
>>> +	}
>>> +
>>> +	if (vlan_discard_unknown_en =3D=3D 1) {
>>> +		if (port =3D=3D 0)
>>> +			writel(readl(&fecp->ESW_VLANV) |
>>> MCF_ESW_VLANV_DU0,
>>> +			       &fecp->ESW_VLANV);
>>> +		else if (port =3D=3D 1)
>>> +			writel(readl(&fecp->ESW_VLANV) |
>>> MCF_ESW_VLANV_DU1,
>>> +			       &fecp->ESW_VLANV);
>>> +		else if (port =3D=3D 2)
>>> +			writel(readl(&fecp->ESW_VLANV) |
>>> MCF_ESW_VLANV_DU2,
>>> +			       &fecp->ESW_VLANV);
>>> +	} else if (vlan_discard_unknown_en =3D=3D 0) {
>>> +		if (port =3D=3D 0)
>>> +			writel(readl(&fecp->ESW_VLANV) &
>>> ~MCF_ESW_VLANV_DU0,
>>> +			       &fecp->ESW_VLANV);
>>> +		else if (port =3D=3D 1)
>>> +			writel(readl(&fecp->ESW_VLANV) &
>>> ~MCF_ESW_VLANV_DU1,
>>> +			       &fecp->ESW_VLANV);
>>> +		else if (port =3D=3D 2)
>>> +			writel(readl(&fecp->ESW_VLANV) &
>>> ~MCF_ESW_VLANV_DU2,
>>> +			       &fecp->ESW_VLANV);
>>> +	}
>> This looks like a lot of copy & paste
> IMHO, the readability of the code is OK.
Actually the concern was about maintenance.

