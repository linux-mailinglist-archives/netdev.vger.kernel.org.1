Return-Path: <netdev+bounces-28335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19177F13D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8391C21291
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04E679D5;
	Thu, 17 Aug 2023 07:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C620EF
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:32:39 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 962B31FCE;
	Thu, 17 Aug 2023 00:32:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37H7Vmb56024651, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37H7Vmb56024651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Aug 2023 15:31:48 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 17 Aug 2023 15:32:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Aug 2023 15:32:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 17 Aug 2023 15:32:07 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek automotive PCIe driver code
Thread-Topic: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Thread-Index: AQHZz4Ya38d07ViN20S7bf3O9T4Qta/q9pcAgAMgk2A=
Date: Thu, 17 Aug 2023 07:32:07 +0000
Message-ID: <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
 <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
In-Reply-To: <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Tue, Aug 15, 2023 at 10:37:55PM +0800, Justin Lai wrote:
> > This patch is to add the ethernet device driver for the PCIe interface
> > of Realtek Automotive Ethernet Switch, applicable to RTL9054, RTL9068,
> RTL9072, RTL9075, RTL9068, RTL9071.
> >
> > Below is a simplified block diagram of the chip and its relevant interf=
aces.
> >
> >           *************************
> >           *                       *
> >           *  CPU network device   *
> >           *    ____________       *
> >           *   |            |      *
> >           *   |  PCIE Host |      *
> >           *************************
> >                     ||
> >                    PCIE
> >                     ||
> >   ****************************************
> >   *          | PCIE Endpoint |           *
> >   *          |---------------|           *
> >   *              | GMAC |                *
> >   *              |------|  Realtek       *
> >   *                 ||   RTL90xx Series  *
> >   *                 ||                   *
> >   *    _____________||______________     *
> >   *   |            |MAC|            |    *
> >   *   |            |---|            |    *
> >   *   |                             |    *
> >   *   |     Ethernet Switch Core    |    *
> >   *   |                             |    *
> >   *   |  -----             -----    |    *
> >   *   |  |MAC| ............|MAC|    |    *
> >   *   |__|___|_____________|___|____|    *
> >   *      |PHY| ............|PHY|         *
> >   *      -----             -----         *
> >   *********||****************||***********
> > This driver is mainly used to control GMAC, but does not control the sw=
itch
> core, so it is not the same as DSA.
> > In addition, the GMAC is not directly connected to the PHY, but
> > directly connected to the mac of the switch core, so there is no need f=
or PHY
> handing.
>=20
> So this describes your board? Is the MAC and the swtich two separate chip=
s? Is
> it however possible to connect the GMAC to a PHY? Could some OEM purchase
> the chipset and build a board with a PHY? We write MAC drivers around wha=
t
> the MAC can do, not what one specific board allows.
>=20
> What MAC drivers do to support being connected to a switch like this is u=
se a
> fixed-link PHY, via phylink. This gives a virtual PHY, which supports one=
 speed.
> The MAC driver then just uses the phylink API as normal.
>=20
> On your board, how is the switch controlled? Is there an MDIO bus as part=
 of
> the MAC? If so, you should add an MDIO bus master driver.
=20

Hi, Andrew

The block of the Realtek RTL90xx series is our entire chip architecture, th=
e GMAC is connected to the switch core, and there is no PHY in between. So =
customers don't need to consider that.

We have some externally controlled interfaces to control switch core, such =
as I2C, MDIO, SPI, etc., but these are not controlled by GMAC .=20
> >
> +/**************************************************************
> ******
> > +**********
> > + *  This product is covered by one or more of the following patents:
> > + *  US6,570,884, US6,115,776, and US6,327,625.
> > +
> >
> +***************************************************************
> ******
> > +*********/
>=20
> How many other drivers mentions patents? I'm not a lawyer, but doesn't th=
e
> GPL say something about this?
>=20
> > +/* 0x05F3 =3D 1522bye + 1 */
> > +#define RX_BUF_SIZE 0x05F3u
>=20
> Why not just use:
>=20
> #define RX_BUF_SIZE 1522 + 1
>=20
> You don't need the comment then. Better still if you can express this in =
terms
> of ETH_FRAME_LEN, ETH_FCS_LEN etc.
>=20
> > +/* write/read MMIO register */
> > +#define RTL_W8(reg, val8)   writeb((val8), ioaddr + (reg))
> > +#define RTL_W16(reg, val16) writew((val16), ioaddr + (reg)) #define
> > +RTL_W32(reg, val32) writel((val32), ioaddr + (reg))
>=20
> macros should only access what is passed to them. ioaddr is not passed...
>=20
> Using small functions would be better, you can then do type checking, ens=
ure
> that val8 is a u8, val16 is a u16 etc.
>=20
> >
> +/**************************************************************
> ******
> > +*********/ #define RTL_NETIF_RX_SCHEDULE_PREP(dev, napi)
> > +napi_schedule_prep(napi)
> > +#define __RTL_NETIF_RX_SCHEDULE(dev, napi)    __napi_schedule(napi)
>=20
> No wrappers. Also, it seems odd you are using a __foo function. Anything =
with
> a __ prefix is mean to be hidden.
>=20
> > +#include <linux/module.h>
> > +#include <linux/version.h>
> > +#include <linux/cdev.h>
> > +#include <linux/pci.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/etherdevice.h>
> > +#include <linux/delay.h>
> > +#include <linux/if_vlan.h>
> > +#include <linux/crc32.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/in.h>
> > +#include <linux/ip.h>
> > +#include <linux/ipv6.h>
> > +#include <linux/tcp.h>
> > +#include <linux/init.h>
> > +#include <linux/rtnetlink.h>
> > +#include <linux/prefetch.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/mdio.h>
> > +#include <net/ip6_checksum.h>
> > +#include <net/pkt_cls.h>
> > +#include <linux/io.h>
> > +#include <asm/irq.h>
> > +
> > +#include "rtase.h"
> > +
> > +/* Maximum number of multicast addresses to filter (vs. Rx-all-multica=
st).
> > + * The RTL chips use a 64 element hash table based on the Ethernet CRC=
.
> > + */
> > +#define _R(NAME, MAC, JUM_FRAME_SZ)
> \
> > +
> {
>   \
> > +             .name =3D NAME, .mcfg =3D MAC, .jumbo_frame_sz =3D
> JUM_FRAME_SZ \
> > +     }
> > +
> > +static const struct {
> > +     const char *name;
> > +     u8 mcfg;
> > +     u16 jumbo_frame_sz;
> > +} rtl_chip_info[] =3D {_R("RTL9072", CFG_METHOD_1, JUMBO_FRAME_9K),
> > +
> > +                  _R("Unknown", CFG_METHOD_DEFAULT,
> JUMBO_FRAME_1K)};
> > +#undef _R
>=20
> The R macro just seems like obfuscation.
>=20
> >
> +/**************************************************************
> ******
> > +**********
> > + * Module Parameters
> > +
> >
> +***************************************************************
> ******
> > +*********/
> > +static unsigned int txq_ctrl =3D 1;
> > +static unsigned int func_txq_num =3D 1; static unsigned int
> > +func_rxq_num =3D 1; static unsigned int interrupt_num =3D 1; static in=
t
> > +rx_copybreak;
> > +
> > +module_param(txq_ctrl, uint, 0);
> > +MODULE_PARM_DESC(txq_ctrl, "The maximum number of TX queues for
> > +PF.");
> > +
> > +module_param(func_txq_num, uint, 0);
> > +MODULE_PARM_DESC(func_txq_num, "TX queue number for this
> function.");
> > +
> > +module_param(func_rxq_num, uint, 0);
> > +MODULE_PARM_DESC(func_rxq_num, "RX queue number for this
> function.");
> > +
> > +module_param(interrupt_num, uint, 0);
> MODULE_PARM_DESC(interrupt_num,
> > +"Interrupt Vector number for this function.");
> > +
> > +module_param(rx_copybreak, int, 0);
> > +MODULE_PARM_DESC(rx_copybreak, "Copy breakpoint for
> > +copy-only-tiny-frames");
>=20
> No module parameters. Please delete them.
>=20
> > +static int rtase_open(struct net_device *dev); static netdev_tx_t
> > +rtase_start_xmit(struct sk_buff *skb, struct net_device *dev); static
> > +void rtase_set_rx_mode(struct net_device *dev); static int
> > +rtase_set_mac_address(struct net_device *dev, void *p); static int
> > +rtase_change_mtu(struct net_device *dev, int new_mtu); static void
> > +rtase_tx_timeout(struct net_device *dev, unsigned int txqueue);
> > +static void rtase_get_stats64(struct net_device *dev, struct
> > +rtnl_link_stats64 *stats); static int rtase_vlan_rx_add_vid(struct
> > +net_device *dev, __be16 protocol, u16 vid); static int
> > +rtase_vlan_rx_kill_vid(struct net_device *dev, __be16 protocol, u16
> > +vid); static int rtase_setup_tc(struct net_device *dev, enum
> > +tc_setup_type type, void *type_data);
> > +
> > +static irqreturn_t rtase_interrupt(int irq, void *dev_instance);
> > +static irqreturn_t rtase_q_interrupt(int irq, void *dev_instance);
> > +static void rtase_hw_config(struct net_device *dev); static int
> > +rtase_close(struct net_device *dev); static void rtase_down(struct
> > +net_device *dev); static s32 rtase_init_ring(const struct net_device
> > +*dev); static void rtase_init_netdev_ops(struct net_device *dev);
> > +static void rtase_rar_set(const struct rtase_private *tp, const
> > +uint8_t *addr); static void rtase_desc_addr_fill(const struct
> > +rtase_private *tp); static void rtase_tx_desc_init(struct
> > +rtase_private *tp, u16 idx); static void rtase_rx_desc_init(struct
> > +rtase_private *tp, u16 idx); static void rtase_set_mar(const struct
> > +rtase_private *tp); static s32 tx_handler(struct rtase_ring *ring,
> > +s32 budget); static s32 rx_handler(struct rtase_ring *ring, s32
> > +budget); static int rtase_poll(struct napi_struct *napi, int budget);
> > +static void rtase_sw_reset(struct net_device *dev); static void
> > +rtase_hw_start(const struct net_device *dev); static void
> > +rtase_dump_tally_counter(const struct rtase_private *tp, dma_addr_t
> > +paddr); static void mac_ocp_write(const struct rtase_private *tp, u16
> > +reg_addr, u16 value);
>=20
> Remove all these put the code in the right order so that they are not nee=
ded.
> The only time you need forward definitions is for recursion.
>=20
>=20
>     Andrew

Thanks for your quick review. I will make some code modifications for the p=
roblems you mentioned

>=20
> ---
> pw-bot: cr
>=20
> ------Please consider the environment before printing this e-mail.

