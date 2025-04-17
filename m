Return-Path: <netdev+bounces-183708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF9A9196B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63674616CF
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280A422D4F4;
	Thu, 17 Apr 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="maRnWN4q"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83992225A20;
	Thu, 17 Apr 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885949; cv=none; b=JT8gYldO1HGQnNr6xi6i2/vGfxxWU5GUa3almAwoYsPgzzRzzszzvasELH/jXLqEaJITMOAxSnJzXTFs3abTy6VDZe/Ewl3UMY/9eRvsv5Z+bYkMN7Mg4mX+ZekXZA41x4x30WR1k2fD6656dIsj+ChRUTVYQUVqswIYad6qr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885949; c=relaxed/simple;
	bh=JXNnza6TCTBZKgO7gZBCAURaTrCDAcbcYvPLPMNdtuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVemVtPNxz65pZY1a+kil4TdwSv2Cz9SpzpcaEBzIU32IWtUIp1WTzN1N8+v3aCR+DKCjXyhz6Q3KGi61xbwQgWvBHf5EzLDcPPCVZj/F///M7ynDgio/Jg0xI6RWBS2lcNfvOBc12hGOTl+Ppi/NIKyhjUm1d5ibGngCuUW/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=maRnWN4q; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744885943; x=1745490743; i=wahrenst@gmx.net;
	bh=cqSaf8rDN3chacUYKHYwfsLm2Xs63kxH8aD36Nl91EQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=maRnWN4qPHEDnOHOeT8zc/epnTPeFFdaberh54GZPmAKTxZY8CFhfisgsNTSl4+S
	 g3maG9Jkoh/5vNxUHENsV+aJLMi/hOK9VSvcirDgTPrFnUdGfdKeZUcg1r1BkQkKs
	 8kPSTw0rUNPiacxNxrEaQTa7PPG5YPnX6f9xZ0AkYaQaiV3OXeTqNQiIoYgdRjeK7
	 QPPlWMaVDSBAbF3ftSpcXC6qGdIwYkTQLvwUsenvBeDyhzfSQd6o9x1KJs6lH8tDh
	 nYozLHwtfKuDdMeyogtViDx/0OsikYg4fFGT4KPq35ArmEpjttdPkJVNCPMaBlWpZ
	 ZwIlBlYdD2ClfLA/8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1v6AOQ1W1l-00ylpt; Thu, 17
 Apr 2025 12:32:23 +0200
Message-ID: <23a1112f-32db-4034-b1ec-ba8617f58d34@gmx.net>
Date: Thu, 17 Apr 2025 12:32:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 4/6] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Simon Horman <horms@kernel.org>
References: <20250414140128.390400-1-lukma@denx.de>
 <20250414140128.390400-5-lukma@denx.de>
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
In-Reply-To: <20250414140128.390400-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3BmvOOoTeTaG416G9qFUrv+BY11aAY0LUkjnEZnZn09F8Q4ejSC
 vyM3MrOU0IRmL6mvkLuPUch0wuoA5urVYxNUarn8PBp9vzFpA5sUULb8s3ns0Q0cdZwCpwl
 e31jnT1dCpB1Z976ry/8HpE6TcP+on43dr4br7zj7XZCmiV1/pnCfzDlnYMcyX7eM0VVihI
 31Kcttxf/zF1dWQ6/e0sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J4QOngHswgo=;83nRc7PJ9U7G2KBlk0w9OslYtrk
 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
 /3Sx3eCYesRJhQHejG8S7A=

Hi Lukasz,

Am 14.04.25 um 16:01 schrieb Lukasz Majewski:
> This patch series provides support for More Than IP L2 switch embedded
> in the imx287 SoC.
>
> This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> which can be used for offloading the network traffic.
>
> It can be used interchangeably with current FEC driver - to be more
> specific: one can use either of it, depending on the requirements.
>
> The biggest difference is the usage of DMA - when FEC is used, separate
> DMAs are available for each ENET-MAC block.
> However, with switch enabled - only the DMA0 is used to send/receive dat=
a
> to/form switch (and then switch sends them to respecitive ports).
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
>
> - Remove not needed comments
> - Restore udelay(10) for switch reset (such delay is explicitly specifed
>    in the documentation
> - Add COMPILE_TEST
> - replace pr_* with dev_*
> - Use for_each_available_child_of_node_scoped()
> - Use devm_* function for memory allocation
> - Remove printing information about the HW and SW revision of the driver
> - Use devm_regulator_get_optional()
> - Change compatible prefix from 'fsl' to more up to date 'nxp'
> - Remove .owner =3D THIS_MODULE
> - Use devm_platform_ioremap_resource(pdev, 0);
> - Use devm_request_irq()
> - Use devm_regulator_get_enable_optional()
> - Replace clk_prepare_enable() and devm_clk_get() with single
>    call to devm_clk_get_optional_enabled()
> - Cleanup error patch when function calls in probe fail
> - Refactor the mtip_reset_phy() to serve as mdio bus reset callback
> - Add myself as the MTIP L2 switch maintainer (squashed the separated
>    commit)
> - More descriptive help paragraphs (> 4 lines)
>
> Changes for v3:
> - Remove 'bridge_offloading' module parameter (to bridge ports just afte=
r probe)
> - Remove forward references
> - Fix reverse christmas tree formatting in functions
> - Convert eligible comments to kernel doc format
> - Remove extra MAC address validation check at esw_mac_addr_static()
> - Remove mtip_print_link_status() and replace it with phy_print_status()
> - Avoid changing phy device state in the driver (instead use functions
>    exported by the phy API)
> - Do not print extra information regarding PHY (which is printed by phyl=
ib) -
>    e.g. net lan0: lan0: MTIP eth L2 switch 1e:ce:a5:0b:4c:12
> - Remove VERSION from the driver - now we rely on the SHA1 in Linux
>    mainline tree
> - Remove zeroing of the net device private area (shall be already done
>    during allocation)
> - Refactor the code to remove mtip_ndev_setup()
> - Use -ENOMEM instead of -1 return code when allocation fails
> - Replace dev_info() with dev_dbg() to reduce number of information prin=
t
>    on normal operation
> - Return ret instead of 0 from mtip_ndev_init()
> - Remove fep->mii_timeout flag from the driver
> - Remove not used stop_gpr_* fields in mtip_devinfo struct
> - Remove platform_device_id description for mtipl2sw driver
> - Add MODULE_DEVICE_TABLE() for mtip_of_match
> - Remove MODULE_ALIAS()
>
> Changes for v4:
> - Rename imx287 with imx28 (as the former is not used in kernel anymore)
> - Reorder the place where ENET interface is initialized - without this
>    change the enet_out clock has default (25 MHz) value, which causes
>    issues during reset (RMII's 50 MHz is required for proper PHY reset).
> - Use PAUR instead of PAUR register to program MAC address
> - Replace eth_mac_addr() with eth_hw_addr_set()
> - Write to HW the randomly generated MAC address (if required)
> - Adjust the reset code
> - s/read_atable/mtip_read_atable/g and s/write_atable/mtip_write_atable/=
g
> - Add clk_disable() and netif_napi_del() when errors occur during
>    mtip_open() - refactor the error handling path.
> - Refactor the mtip_set_multicast_list() to write (now) correct values t=
o
>    ENET-FEC registers.
> - Replace dev_warn() with dev_err()
> - Use GPIO_ACTIVE_LOW to indicate polarity in DTS
> - Refactor code to check if network device is the switch device
> - Remove mtip_port_dev_check()
> - Refactor mtip_ndev_port_link() avoid starting HW offloading for bridge
>    when MTIP ports are parts of two distinct bridges
> - Replace del_timer() with timer_delete_sync()
>
> Changes for v5:
> - Fix spelling in Kconfig
> - Replace tmp with reg or register name
> - Replace tmpaddr with mac_addr
> - Use mac address assignment (from registers) code similar to fec_main.c=
 (as it
>    shall handle properly generic endianess)
> - Add description for fep: in the mtip_update_atable_static() kernel doc
> - Replace writel(bdp, &fep->cur_rx) with fep->cur_rx =3D bdp;
> - Fix spelling of transmit
> - Remove not needed white spaces in mtipl2sw.h
> - Remove '_t' from struct mtip_addr_table_t
> - Provide proper alignment in the mtipl2sw.h
> - Add blank line after local header in mtipl2sw_br.c
> - Use %p instead of %x (and cast) for fep in debug message
> - Disable L2 switch in-HW offloading when only one
>    of eligible ports is removed from the bridge
> - Sort includes in the patch set alphabethically
> - Introduce FEC_QUIRK_SWAP_FRAME to avoid #ifdef for imx28 proper operat=
ion
> - Move 'mtip_port_info g_info' to struct switch_enet_private
> - Replace some unsigned int with u32 (on data fields with 32 bit size)
> - Remove not relevant comments from mtip_enet_init()
> - Refactor functions definitions to be void when no other
>    value than 0 is returned.
> - Use capital letters in HEX constants
> - Use u32 instead of unsigned int when applicable
> - Add error handling code after the dma_map_single() is called
> - The MCF_FEC_MSCR register can be written unconditionally
>    for all supported platforms.
> - Use IS_ENABLED() instead of #ifdef in mtip_timeout()
> - Replace dev_info() with dev_warn_ratelimited() in mtip_switch_rx()
> - Add code to handle situation when there is no memory
> - Remove kfree(fep->mii_bus->irq)
> - Provide more verbose output of mdio_{read|write} functions
> - Handle error when clk_enable() fails in mtip_open()
> - Use dev_dbg() at mtip_set_multicast_list()
> - Simplify the mtip_is_switch_netdev_port() function to return condition=
 check value
> - Add dev_dbg() when of_get_mac_address() fails (as it may not be provid=
ed)
> - Remove return ret; in mtip_register_notifiers()
> - Replace int to bool in mtipl2sw_mgnt.c file's function definitions
> - Replace unsigned int/long with u32 where applicable (where access to
>    32 bit registers is performed)
> - Refactor code in mtip_{read|write}_atable() to be more readable
> - Remove code added for not (yet) supported IMX's vf610 SoC
> - Remove do { } while(); loop from mtip_interrupt() function
> - Introduce MTIP_PORT_FORWARDING_INIT to indicate intial value for
>    port forwarding
> - Replace 'unsigned long' to 'u32' in mtipl2sw.h
> - Replace 'unsigned short' to 'u16' in mtipl2sw.h
> - use %#x in dev_dbg()
> - Call SET_NETDEV_DEV() macro to set network device' parent - otherwise
>    phy_attach_direct() will fail.
> ---
>   MAINTAINERS                                   |    7 +
>   drivers/net/ethernet/freescale/Kconfig        |    1 +
>   drivers/net/ethernet/freescale/Makefile       |    1 +
>   drivers/net/ethernet/freescale/mtipsw/Kconfig |   13 +
>   .../net/ethernet/freescale/mtipsw/Makefile    |    3 +
>   .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 1990 +++++++++++++++++
>   .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  788 +++++++
>   .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  120 +
>   .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  449 ++++
>   9 files changed, 3372 insertions(+)
>   create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
>   create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
>   create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
>   create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
>   create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
>   create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt=
.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1248443035f4..af4e42a33c99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9448,6 +9448,13 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/i2c/i2c-mpc.yaml
>   F:	drivers/i2c/busses/i2c-mpc.c
>  =20
> +FREESCALE MTIP ETHERNET SWITCH DRIVER
> +M:	Lukasz Majewski <lukma@denx.de>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> +F:	drivers/net/ethernet/freescale/mtipsw/*
> +
>   FREESCALE QORIQ DPAA ETHERNET DRIVER
>   M:	Madalin Bucur <madalin.bucur@nxp.com>
>   L:	netdev@vger.kernel.org
> diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethern=
et/freescale/Kconfig
> index a2d7300925a8..056a11c3a74e 100644
> --- a/drivers/net/ethernet/freescale/Kconfig
> +++ b/drivers/net/ethernet/freescale/Kconfig
> @@ -60,6 +60,7 @@ config FEC_MPC52xx_MDIO
>  =20
>   source "drivers/net/ethernet/freescale/fs_enet/Kconfig"
>   source "drivers/net/ethernet/freescale/fman/Kconfig"
> +source "drivers/net/ethernet/freescale/mtipsw/Kconfig"
>  =20
>   config FSL_PQ_MDIO
>   	tristate "Freescale PQ MDIO"
> diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ether=
net/freescale/Makefile
> index de7b31842233..0e6cacb0948a 100644
> --- a/drivers/net/ethernet/freescale/Makefile
> +++ b/drivers/net/ethernet/freescale/Makefile
> @@ -25,3 +25,4 @@ obj-$(CONFIG_FSL_DPAA_ETH) +=3D dpaa/
>   obj-$(CONFIG_FSL_DPAA2_ETH) +=3D dpaa2/
>  =20
>   obj-y +=3D enetc/
> +obj-y +=3D mtipsw/
> diff --git a/drivers/net/ethernet/freescale/mtipsw/Kconfig b/drivers/net=
/ethernet/freescale/mtipsw/Kconfig
> new file mode 100644
> index 000000000000..0ae58e7b1ca6
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config FEC_MTIP_L2SW
> +	tristate "MoreThanIP L2 switch support to FEC driver"
> +	depends on OF
> +	depends on NET_SWITCHDEV
> +	depends on BRIDGE
> +	depends on ARCH_MXS || COMPILE_TEST
I think we should align the dependencies with FEC:

depends on SOC_IMX28 || COMPILE_TEST
> +	help
> +	  This enables support for the MoreThan IP L2 switch on i.MX
> +	  SoCs (e.g. iMX287). It offloads bridging to this IP block's
> +	  hardware and allows switch management with standard Linux tools.
> +	  This switch driver can be used interchangeable with the already
> +	  available FEC driver, depending on the use case's requirements.
> diff --git a/drivers/net/ethernet/freescale/mtipsw/Makefile b/drivers/ne=
t/ethernet/freescale/mtipsw/Makefile
> new file mode 100644
> index 000000000000..4d69db2226a6
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_FEC_MTIP_L2SW) +=3D mtipl2sw.o mtipl2sw_mgnt.o mtipl2sw_br=
.o
> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/=
net/ethernet/freescale/mtipsw/mtipl2sw.c
> new file mode 100644
> index 000000000000..50f5a0c1bc8c
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> @@ -0,0 +1,1990 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  L2 switch Controller (Ethernet L2 switch) driver for MTIP block.
> + *
> + *  Copyright (C) 2025 DENX Software Engineering GmbH
> + *  Lukasz Majewski <lukma@denx.de>
> + *
> + *  Based on a previous work by:
> + *
> + *  Copyright 2010-2012 Freescale Semiconductor, Inc.
> + *  Alison Wang (b18965@freescale.com)
> + *  Jason Jin (Jason.jin@freescale.com)
> + *
> + *  Copyright (C) 2010-2013 Freescale Semiconductor, Inc. All Rights Re=
served.
> + *  Shrek Wu (B16972@freescale.com)
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/etherdevice.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_net.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/skbuff.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +
> +#include "mtipl2sw.h"
> +
> +static void swap_buffer(void *bufaddr, int len)
> +{
> +	int i;
> +	unsigned int *buf =3D bufaddr;
> +
> +	for (i =3D 0; i < len; i +=3D 4, buf++)
> +		swab32s(buf);
> +}
> +
> +struct mtip_devinfo {
> +	u32 quirks;
> +};
> +
> +static void mtip_enet_init(struct switch_enet_private *fep, int port)
> +{
> +	void __iomem *enet_addr =3D fep->enet_addr;
> +	u32 mii_speed, holdtime, reg;
> +
> +	if (port =3D=3D 2)
> +		enet_addr +=3D MCF_ESW_ENET_PORT_OFFSET;
> +
> +	reg =3D MCF_FEC_RCR_PROM | MCF_FEC_RCR_MII_MODE |
> +		MCF_FEC_RCR_MAX_FL(1522);
> +
> +	if (fep->phy_interface[port - 1]  =3D=3D PHY_INTERFACE_MODE_RMII)
> +		reg |=3D MCF_FEC_RCR_RMII_MODE;
> +
> +	writel(reg, enet_addr + MCF_FEC_RCR);
> +
> +	writel(MCF_FEC_TCR_FDEN, enet_addr + MCF_FEC_TCR);
> +	writel(MCF_FEC_ECR_ETHER_EN, enet_addr + MCF_FEC_ECR);
> +
> +	mii_speed =3D DIV_ROUND_UP(clk_get_rate(fep->clk_ipg), 5000000);
> +	mii_speed--;
> +
> +	holdtime =3D DIV_ROUND_UP(clk_get_rate(fep->clk_ipg), 100000000) - 1;
> +
> +	fep->phy_speed =3D mii_speed << 1 | holdtime << 8;
> +
> +	writel(fep->phy_speed, enet_addr + MCF_FEC_MSCR);
> +}
> +
> +static void mtip_setup_mac(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> +	struct switch_enet_private *fep =3D priv->fep;
> +	unsigned char *iap, mac_addr[ETH_ALEN];
> +
> +	/* Use MAC address from DTS */
> +	iap =3D &fep->mac[priv->portnum - 1][0];
> +
> +	/* Use MAC address set by bootloader */
> +	if (!is_valid_ether_addr(iap)) {
> +		*((__be32 *)&mac_addr[0]) =3D
> +			cpu_to_be32(readl(fep->enet_addr + MCF_FEC_PALR));
> +		*((__be16 *)&mac_addr[4]) =3D
> +			cpu_to_be16(readl(fep->enet_addr +
> +					  MCF_FEC_PAUR) >> 16);
> +		iap =3D &mac_addr[0];
> +	}
> +
> +	/* Use random MAC address */
> +	if (!is_valid_ether_addr(iap)) {
> +		eth_hw_addr_random(dev);
> +		dev_info(&fep->pdev->dev, "Using random MAC address: %pM\n",
> +			 dev->dev_addr);
> +		iap =3D (unsigned char *)dev->dev_addr;
> +	}
> +
> +	/* Adjust MAC if using macaddr (and increment if needed) */
> +	eth_hw_addr_gen(dev, iap, priv->portnum - 1);
> +}
> +
> +/**
> + * crc8_calc - calculate CRC for MAC storage
> + *
> + * @pmacaddress: A 6-byte array with the MAC address. The first byte is
> + *               the first byte transmitted.
> + *
> + * Calculate Galois Field Arithmetic CRC for Polynom x^8+x^2+x+1.
> + * It omits the final shift in of 8 zeroes a "normal" CRC would do
> + * (getting the remainder).
> + *
> + *  Examples (hexadecimal values):<br>
> + *   10-11-12-13-14-15  =3D> CRC=3D0xc2
> + *   10-11-cc-dd-ee-00  =3D> CRC=3D0xe6
> + *
> + * Return: The 8-bit CRC in bits 7:0
> + */
> +static int crc8_calc(unsigned char *pmacaddress)
> +{
> +	int byt; /* byte index */
> +	int bit; /* bit index */
> +	int crc =3D 0x12;
> +	int inval;
> +
> +	for (byt =3D 0; byt < ETH_ALEN; byt++) {
> +		inval =3D (((int)pmacaddress[byt]) & 0xFF);
> +		/* shift bit 0 to bit 8 so all our bits
> +		 * travel through bit 8
> +		 * (simplifies below calc)
> +		 */
> +		inval <<=3D 8;
> +
> +		for (bit =3D 0; bit < 8; bit++) {
> +			/* next input bit comes into d7 after shift */
> +			crc |=3D inval & 0x100;
> +			if (crc & 0x01)
> +				/* before shift  */
> +				crc ^=3D 0x1C0;
> +
> +			crc >>=3D 1;
> +			inval >>=3D 1;
> +		}
> +	}
> +	/* upper bits are clean as we shifted in zeroes! */
> +	return crc;
> +}
> +
> +static void mtip_read_atable(struct switch_enet_private *fep, int index=
,
> +			     u32 *read_lo, u32 *read_hi)
> +{
> +	struct addr_table64b_entry *atable_base =3D
> +		fep->hwentry->mtip_table64b_entry;
> +
> +	*read_lo =3D readl(&atable_base[index].lo);
> +	*read_hi =3D readl(&atable_base[index].hi);
> +}
> +
> +static void mtip_write_atable(struct switch_enet_private *fep, int inde=
x,
> +			      u32 write_lo, u32 write_hi)
> +{
> +	struct addr_table64b_entry *atable_base =3D
> +		fep->hwentry->mtip_table64b_entry;
> +
> +	writel(write_lo, &atable_base[index].lo);
> +	writel(write_hi, &atable_base[index].hi);
> +}
> +
> +/**
> + * mtip_portinfofifo_read - Read element from receive FIFO
> + *
> + * @fep: Structure describing switch
> + *
> + * Read one element from the HW receive FIFO (Queue)
> + * if available and return it.
> + *
> + * Return: mtip_port_info or NULL if no data is available.
> + */
> +static
> +struct mtip_port_info *mtip_portinfofifo_read(struct switch_enet_privat=
e *fep)
> +{
> +	struct mtip_port_info *info =3D &fep->g_info;
> +	struct switch_t *fecp =3D fep->hwp;
> +	u32 reg;
> +
> +	reg =3D readl(&fecp->ESW_LSR);
> +	if (reg =3D=3D 0) {
> +		dev_dbg(&fep->pdev->dev, "%s: ESW_LSR =3D 0x%x\n", __func__, reg);
> +		return NULL;
> +	}
> +
> +	/* read word from FIFO */
> +	info->maclo =3D readl(&fecp->ESW_LREC0);
> +	if (info->maclo =3D=3D 0) {
> +		dev_dbg(&fep->pdev->dev, "%s: mac lo 0x%x\n", __func__,
> +			info->maclo);
> +		return NULL;
> +	}
> +
> +	/* read 2nd word from FIFO */
> +	reg =3D readl(&fecp->ESW_LREC1);
> +	info->machi =3D reg & 0xFFFF;
> +	info->hash  =3D (reg >> 16) & 0xFF;
> +	info->port  =3D (reg >> 24) & 0xF;
> +
> +	return info;
> +}
> +
> +static void mtip_atable_get_entry_port_number(struct switch_enet_privat=
e *fep,
> +					      unsigned char *mac_addr, u8 *port)
> +{
> +	int block_index, block_index_end, entry;
> +	u32 mac_addr_lo, mac_addr_hi;
> +	u32 read_lo, read_hi;
> +
> +	mac_addr_lo =3D (u32)((mac_addr[3] << 24) | (mac_addr[2] << 16) |
> +			    (mac_addr[1] << 8) | mac_addr[0]);
> +	mac_addr_hi =3D (u32)((mac_addr[5] << 8) | (mac_addr[4]));
> +
> +	block_index =3D GET_BLOCK_PTR(crc8_calc(mac_addr));
> +	block_index_end =3D block_index + ATABLE_ENTRY_PER_SLOT;
> +
> +	/* now search all the entries in the selected block */
> +	for (entry =3D block_index; entry < block_index_end; entry++) {
> +		mtip_read_atable(fep, entry, &read_lo, &read_hi);
> +		*port =3D MTIP_PORT_FORWARDING_INIT;
> +
> +		if (read_lo =3D=3D mac_addr_lo &&
> +		    ((read_hi & 0x0000FFFF) =3D=3D
> +		     (mac_addr_hi & 0x0000FFFF))) {
> +			/* found the correct address */
> +			if ((read_hi & (1 << 16)) && (!(read_hi & (1 << 17))))
> +				*port =3D AT_EXTRACT_PORT(read_hi);
> +			break;
> +		}
> +	}
> +
> +	dev_dbg(&fep->pdev->dev, "%s: MAC: %pM PORT: 0x%x\n", __func__,
> +		mac_addr, *port);
> +}
> +
> +/* Clear complete MAC Look Up Table */
> +void mtip_clear_atable(struct switch_enet_private *fep)
> +{
> +	int index;
> +
> +	for (index =3D 0; index < 2048; index++)
There are a lot of defines for this magic number, please use one of them
> +		mtip_write_atable(fep, index, 0, 0);
> +}
> +
> +/**
> + * mtip_update_atable_static - Update switch static address table
> + *
> + * @mac_addr: Pointer to the array containing MAC address to
> + *            be put as static entry
> + * @port:     Port bitmask numbers to be added in static entry,
> + *            valid values are 1-7
> + * @priority: The priority for the static entry in table
> + *
> + * @fep:      Pointer to the structure describing the switch
> + *
> + * Updates MAC address lookup table with a static entry.
> + *
> + * Searches if the MAC address is already there in the block and replac=
es
> + * the older entry with the new one. If MAC address is not there then p=
uts
> + * a new entry in the first empty slot available in the block.
> + *
> + * Return: 0 for a successful update else -ENOSPC when no slot availabl=
e
> + */
> +static int mtip_update_atable_static(unsigned char *mac_addr, unsigned =
int port,
> +				     unsigned int priority,
> +				     struct switch_enet_private *fep)
> +{
> +	unsigned long block_index, entry, index_end;
> +	u32 write_lo, write_hi, read_lo, read_hi;
> +
> +	write_lo =3D (u32)((mac_addr[3] << 24) | (mac_addr[2] << 16) |
> +			 (mac_addr[1] << 8) | mac_addr[0]);
> +	write_hi =3D (u32)(0 | (port << AT_SENTRY_PORTMASK_shift) |
> +			 (priority << AT_SENTRY_PRIO_shift) |
> +			 (AT_ENTRY_TYPE_STATIC << AT_ENTRY_TYPE_shift) |
> +			 (AT_ENTRY_RECORD_VALID << AT_ENTRY_VALID_shift) |
> +			 (mac_addr[5] << 8) | (mac_addr[4]));
> +
> +	block_index =3D GET_BLOCK_PTR(crc8_calc(mac_addr));
> +	index_end =3D block_index + ATABLE_ENTRY_PER_SLOT;
> +	/* Now search all the entries in the selected block */
> +	for (entry =3D block_index; entry < index_end; entry++) {
> +		mtip_read_atable(fep, entry, &read_lo, &read_hi);
> +		/* MAC address matched, so update the
> +		 * existing entry
> +		 * even if its a dynamic one
> +		 */
> +		if (read_lo =3D=3D write_lo &&
> +		    ((read_hi & 0x0000FFFF) =3D=3D
> +		     (write_hi & 0x0000FFFF))) {
> +			mtip_write_atable(fep, entry, write_lo, write_hi);
> +			return 0;
> +		} else if (!(read_hi & (1 << 16))) {
> +			/* Fill this empty slot (valid bit zero),
> +			 * assuming no holes in the block
> +			 */
> +			mtip_write_atable(fep, entry, write_lo, write_hi);
> +			fep->at_curr_entries++;
> +			return 0;
> +		}
> +	}
> +
> +	/* No space available for this static entry */
> +	return -ENOSPC;
> +}
> +
> +static bool mtip_update_atable_dynamic1(u32 write_lo, u32 write_hi,
> +					int block_index, unsigned int port,
> +					unsigned int curr_time,
> +					struct switch_enet_private *fep)
> +{
> +	unsigned long entry, index_end;
> +	int time, timeold, indexold;
> +	u32 read_lo, read_hi;
> +	unsigned long conf;
> +
> +	/* prepare update port and timestamp */
> +	conf =3D AT_ENTRY_RECORD_VALID << AT_ENTRY_VALID_shift;
> +	conf |=3D AT_ENTRY_TYPE_DYNAMIC << AT_ENTRY_TYPE_shift;
> +	conf |=3D curr_time << AT_DENTRY_TIME_shift;
> +	conf |=3D port << AT_DENTRY_PORT_shift;
> +	conf |=3D write_hi;
> +
> +	/* linear search through all slot
> +	 * entries and update if found
> +	 */
> +	index_end =3D block_index + ATABLE_ENTRY_PER_SLOT;
> +	/* Now search all the entries in the selected block */
> +	for (entry =3D block_index; entry < index_end; entry++) {
> +		mtip_read_atable(fep, entry, &read_lo, &read_hi);
> +		if (read_lo =3D=3D write_lo &&
> +		    ((read_hi & 0x0000FFFF) =3D=3D
> +		     (write_hi & 0x0000FFFF))) {
> +			/* found correct address,
> +			 * update timestamp.
> +			 */
> +			mtip_write_atable(fep, entry, write_lo, conf);
> +
> +			return false;
> +		} else if (!(read_hi & (1 << 16))) {
> +			/* slot is empty, then use it
> +			 * for new entry
> +			 * Note: There are no holes,
> +			 * therefore cannot be any
> +			 * more that need to be compared.
> +			 */
> +			mtip_write_atable(fep, entry, write_lo, conf);
> +			/* statistics (we do it between writing
> +			 *  .hi an .lo due to
> +			 * hardware limitation...
> +			 */
> +			fep->at_curr_entries++;
> +			/* newly inserted */
> +
> +			return true;
> +		}
> +	}
> +
> +	/* No more entry available in block overwrite oldest */
> +	timeold =3D 0;
> +	indexold =3D 0;
> +	for (entry =3D block_index; entry < index_end; entry++) {
> +		mtip_read_atable(fep, entry, &read_lo, &read_hi);
> +		time =3D AT_EXTRACT_TIMESTAMP(read_hi);
> +		dev_dbg(&fep->pdev->dev, "%s : time %x currtime %x\n",
> +			__func__, time, curr_time);
> +		time =3D TIMEDELTA(curr_time, time);
> +		if (time > timeold) {
> +			/* is it older ? */
> +			timeold =3D time;
> +			indexold =3D entry;
> +		}
> +	}
> +
> +	mtip_write_atable(fep, indexold, write_lo, conf);
> +
> +	/* Statistics (do it inbetween writing to .lo and .hi */
> +	fep->at_block_overflows++;
> +	dev_err(&fep->pdev->dev, "%s update time, at_block_overflows %x\n",
> +		__func__, fep->at_block_overflows);
> +	/* newly inserted */
> +	return true;
> +}
> +
> +/* dynamicms MAC address table learn and migration */
> +static void
> +mtip_atable_dynamicms_learn_migration(struct switch_enet_private *fep,
> +				      int curr_time, unsigned char *mac,
> +				      u8 *rx_port)
> +{
> +	u8 port =3D MTIP_PORT_FORWARDING_INIT;
> +	struct mtip_port_info *port_info;
> +	u32 rx_mac_lo, rx_mac_hi;
> +	unsigned long flags;
> +	int index;
> +
> +	spin_lock_irqsave(&fep->learn_lock, flags);
> +
> +	if (mac && is_valid_ether_addr(mac)) {
> +		rx_mac_lo =3D (u32)((mac[3] << 24) | (mac[2] << 16) |
> +				  (mac[1] << 8) | mac[0]);
> +		rx_mac_hi =3D (u32)((mac[5] << 8) | (mac[4]));
> +	}
> +
> +	port_info =3D mtip_portinfofifo_read(fep);
> +	while (port_info) {
> +		/* get block index from lookup table */
> +		index =3D GET_BLOCK_PTR(port_info->hash);
> +		mtip_update_atable_dynamic1(port_info->maclo, port_info->machi,
> +					    index, port_info->port,
> +					    curr_time, fep);
> +
> +		if (mac && is_valid_ether_addr(mac) &&
> +		    port =3D=3D MTIP_PORT_FORWARDING_INIT) {
> +			if (rx_mac_lo =3D=3D port_info->maclo &&
> +			    rx_mac_hi =3D=3D port_info->machi) {
> +				/* The newly learned MAC is the source of
> +				 * our filtered frame.
> +				 */
> +				port =3D (u8)port_info->port;
> +			}
> +		}
> +		port_info =3D mtip_portinfofifo_read(fep);
> +	}
> +
> +	if (rx_port)
> +		*rx_port =3D port;
> +
> +	spin_unlock_irqrestore(&fep->learn_lock, flags);
> +}
> +
> +static void mtip_aging_timer(struct timer_list *t)
> +{
> +	struct switch_enet_private *fep =3D from_timer(fep, t, timer_aging);
> +
> +	if (fep)
> +		fep->curr_time =3D mtip_timeincrement(fep->curr_time);
> +
> +	mod_timer(&fep->timer_aging,
> +		  jiffies + msecs_to_jiffies(LEARNING_AGING_INTERVAL));
I'm not sure that fep can actually be NULL. If it's possible please=20
return in order to avoid a NULL pointer deference here, otherwise drop=20
the check.

Thanks

