Return-Path: <netdev+bounces-111656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258BA932019
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 07:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0CFB21721
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 05:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2362617BD2;
	Tue, 16 Jul 2024 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bigler.io header.i=@bigler.io header.b="FGcXYsxl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F0F9CC;
	Tue, 16 Jul 2024 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721108157; cv=none; b=PX1AhnHm6lgvsP9gQzsBaWaYkxaXpofXYMz+CxIU1lQAhF15DJ8F76euEDj0O1WUMad8rSf3Z1CY1CiaVcDVZZ7YfzUXZrCoy0Pw5AM0tnKodS1lyLlEby/tj2QHYUwQ8HTT7vdZu8AUgTDE/lOiDu1OIKymvkXPfbE2L1Oyt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721108157; c=relaxed/simple;
	bh=Dmn9O8OKZQ6ZWQyvbGZ7LRCbFqc86XXFqYdQZ5gRYZU=;
	h=Message-ID:Date:Subject:From:To:Cc:MIME-Version:Content-Type:
	 References:In-Reply-To; b=uuBA+qexFuPFT7CVgaYjQd20aTqwhpeXg7du7qoMdEXWwRWIrPSb7/uwvjPEgktGLAVDeDEntoUZ/2Ylk/ElJpd5uqwzWG6PTx6Ei5o/NSZRsHKRi1reEAKx+a3GNzN1RJtmqnKH8HYOR0gxrBZsBJAa5e0r4bKGMyr8MZKzkjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bigler.io; spf=pass smtp.mailfrom=bigler.io; dkim=pass (1024-bit key) header.d=bigler.io header.i=@bigler.io header.b=FGcXYsxl; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bigler.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bigler.io
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WNSTX0Cy6z5ff;
	Tue, 16 Jul 2024 07:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bigler.io;
	s=20200409; t=1721108143;
	bh=OgVrPeP7WzhNLFhvfionCV3V/8BZck/pISUNrAzyAjE=;
	h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
	b=FGcXYsxl6QTkLrbCmzNsM8Mbj4Oc06OxmM1PdXD5AuwfXQZA/0/nGb7LNx6B4yYmE
	 oa4ASozfyiyRpFNzDmRl2xW8aQzBVhiFMyEXacOjIgREVXyoZ4+q6nNcUCsZtrWnlg
	 6KMgNwVSP5qL/Vpwu5B7zfp5c8WcorvquYYn2AL8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WNSTP00f6zrMP;
	Tue, 16 Jul 2024 07:35:36 +0200 (CEST)
Message-ID: <230f26f2ac8385e8faa543261ac72ffc@mail.infomaniak.com>
Date: Tue, 16 Jul 2024 07:35:36 +0200
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
From: Stefan Bigler <linux@bigler.io>
Reply-To: Stefan Bigler <linux@bigler.io>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
 linux-doc@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
 ruanjinjie@huawei.com, steen.hegelund@microchip.com, vladimir.oltean@nxp.com,
 UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
 Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
 Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6Ik5CamNIalhBU0VUalNLSVRhRmFQeEE9PSIsInZhbHVlIjoicUIxSlZoK0tKMkh6dEhmWUVIQ1MvUT09IiwibWFjIjoiNzgwY2IwN2I5NmZkZTBlMTdlODQ4MjVkYTFlNjlmNWEzNzQ3ZDNmMzM4NDE5ODQ4MDFkODRkYzAzOGE3MTNkYyIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6InRvZURUd3IxaGNXOEVrVlVxUjd2MFE9PSIsInZhbHVlIjoiTUFVdGtqaWo2Wkhwbnpxd1Ayd0U2QT09IiwibWFjIjoiNWE1ZjFmNDFlOWYyM2FmMGRlM2ZmNGZlYTRiMWFmNjE3MDE2M2Y2YzVlNmUyYmYwNDY5YmE2MDQ2YmVmMDZkZiIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.717)
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
X-Infomaniak-Routing: alpha

Hi Parthiban

I'm using v4 of the driver an switched from ipv4 to ipv6.
I recognized, that the Neighbor Discovery is not working as expected.
The reason for this is, that the Neighbor Solicitation packet is not recive=
d.
This packet is sent with a Multicast MAC Address.
When I checked the code and compared it to the documentaton the calculation=
 of the Address Hash is not ok.
See Chapter 6.4.6 Hash Addressing

Changing the function=C2=A0lan865x_hash fixed the problem

+static inline u32 getAddrBit(u8 addr[ETH_ALEN], u32 bit)
+{
+       return ((addr[bit/8]) >> (bit % 8)) & 1;
+}
+
 static u32 lan865x_hash(u8 addr[ETH_ALEN])
 {
-       return (ether_crc(ETH_ALEN, addr) >> 26) & GENMASK(5, 0);
+       u32 hash_index =3D 0;
+       for (int i=3D0; i<6; i++)
+       {
+               u32 hash =3D 0;
+               for (int j=3D0; j<8; j++) {
+                       hash ^=3D getAddrBit(addr, (j*6)+i);
+               }
+               hash_index |=3D (hash << i);
+       }
+       return hash_index;
 }

also the fuction lan865x_set_specific_multicast_addr() must be fixed due to=
 the overflow of the mask variable

  static void lan865x_set_specific_multicast_addr(struct net_device *netdev=
)
@@ -301,15 +315,11 @@ static void lan865x_set_specific_multicast_addr(struc=
t net_device *netdev)
=20
 =09netdev_for_each_mc_addr(ha, netdev) {
 =09=09u32 bit_num =3D lan865x_hash(ha->addr);
-=09=09u32 mask =3D BIT(bit_num);
=20
-=09=09/* 5th bit of the 6 bits hash value is used to determine which
-=09=09 * bit to set in either a high or low hash register.
-=09=09 */
-=09=09if (bit_num & BIT(5))
-=09=09=09hash_hi |=3D mask;
+=09=09if (bit_num >=3D 32)
+=09=09=09hash_hi |=3D (1 << (bit_num-32));
 =09=09else
-=09=09=09hash_lo |=3D mask;
+=09=09=09hash_lo |=3D (1 << bit_num);
 =09}
=20
 =09/* Enabling specific multicast addresses */

I would be great if the fix can be included in the new version 5 of your dr=
iver.

Thanks a lot and best regards
Stefan


Am 2024-04-18T14:56:47.000+02:00 hat Parthiban Veerasooran <Parthiban.Veera=
sooran@microchip.com> geschrieben:

>  The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE-T1x
> MAC-PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
> MAC integration provides the low pin count standard SPI interface to any
> microcontroller therefore providing Ethernet functionality without
> requiring MAC integration within the microcontroller. The LAN8650/1
> operates as an SPI client supporting SCLK clock rates up to a maximum of
> 25 MHz. This SPI interface supports the transfer of both data (Ethernet
> frames) and control (register access).
>=20
> By default, the chunk data payload is 64 bytes in size. The Ethernet
> Media Access Controller (MAC) module implements a 10 Mbps half duplex
> Ethernet MAC, compatible with the IEEE 802.3 standard. 10BASE-T1S
> physical layer transceiver integrated is into the LAN8650/1. The PHY and
> MAC are connected via an internal Media Independent Interface (MII).
>=20
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com=
>
> ---
>  MAINTAINERS                                   |   6 +
>  drivers/net/ethernet/microchip/Kconfig        |   1 +
>  drivers/net/ethernet/microchip/Makefile       |   1 +
>  .../net/ethernet/microchip/lan865x/Kconfig    |  19 +
>  .../net/ethernet/microchip/lan865x/Makefile   |   6 +
>  .../net/ethernet/microchip/lan865x/lan865x.c  | 384 ++++++++++++++++++
>  6 files changed, 417 insertions(+)
>  create mode 100644 drivers/net/ethernet/microchip/lan865x/Kconfig
>  create mode 100644 drivers/net/ethernet/microchip/lan865x/Makefile
>  create mode 100644 drivers/net/ethernet/microchip/lan865x/lan865x.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 603528948f61..f41b7f2257d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14374,6 +14374,12 @@ L:=09netdev@vger.kernel.org
>  S:=09Maintained
>  F:=09drivers/net/ethernet/microchip/lan743x_*
> =20
> +MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
> +M:=09Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> +L:=09netdev@vger.kernel.org
> +S:=09Maintained
> +F:=09drivers/net/ethernet/microchip/lan865x/lan865x.c
> +
>  MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
>  M:=09Arun Ramadoss <arun.ramadoss@microchip.com>
>  R:=09UNGLinuxDriver@microchip.com
> diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/etherne=
t/microchip/Kconfig
> index 43ba71e82260..06ca79669053 100644
> --- a/drivers/net/ethernet/microchip/Kconfig
> +++ b/drivers/net/ethernet/microchip/Kconfig
> @@ -56,6 +56,7 @@ config LAN743X
>  =09  To compile this driver as a module, choose M here. The module will =
be
>  =09  called lan743x.
> =20
> +source "drivers/net/ethernet/microchip/lan865x/Kconfig"
>  source "drivers/net/ethernet/microchip/lan966x/Kconfig"
>  source "drivers/net/ethernet/microchip/sparx5/Kconfig"
>  source "drivers/net/ethernet/microchip/vcap/Kconfig"
> diff --git a/drivers/net/ethernet/microchip/Makefile b/drivers/net/ethern=
et/microchip/Makefile
> index bbd349264e6f..15dfbb321057 100644
> --- a/drivers/net/ethernet/microchip/Makefile
> +++ b/drivers/net/ethernet/microchip/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_LAN743X) +=3D lan743x.o
> =20
>  lan743x-objs :=3D lan743x_main.o lan743x_ethtool.o lan743x_ptp.o
> =20
> +obj-$(CONFIG_LAN865X) +=3D lan865x/
>  obj-$(CONFIG_LAN966X_SWITCH) +=3D lan966x/
>  obj-$(CONFIG_SPARX5_SWITCH) +=3D sparx5/
>  obj-$(CONFIG_VCAP) +=3D vcap/
> diff --git a/drivers/net/ethernet/microchip/lan865x/Kconfig b/drivers/net=
/ethernet/microchip/lan865x/Kconfig
> new file mode 100644
> index 000000000000..f3d60d14e202
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan865x/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Microchip LAN865x Driver Support
> +#
> +
> +if NET_VENDOR_MICROCHIP
> +
> +config LAN865X
> +=09tristate "LAN865x support"
> +=09depends on SPI
> +=09depends on OA_TC6
> +=09help
> +=09  Support for the Microchip LAN8650/1 Rev.B1 MACPHY Ethernet chip. It
> +=09  uses OPEN Alliance 10BASE-T1x Serial Interface specification.
> +
> +=09  To compile this driver as a module, choose M here. The module will =
be
> +=09  called lan865x.
> +
> +endif # NET_VENDOR_MICROCHIP
> diff --git a/drivers/net/ethernet/microchip/lan865x/Makefile b/drivers/ne=
t/ethernet/microchip/lan865x/Makefile
> new file mode 100644
> index 000000000000..9f5dd89c1eb8
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan865x/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the Microchip LAN865x Driver
> +#
> +
> +obj-$(CONFIG_LAN865X) +=3D lan865x.o
> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/n=
et/ethernet/microchip/lan865x/lan865x.c
> new file mode 100644
> index 000000000000..9abefa8b9d9f
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -0,0 +1,384 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Microchip's LAN865x 10BASE-T1S MAC-PHY driver
> + *
> + * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/phy.h>
> +#include <linux/oa_tc6.h>
> +
> +#define DRV_NAME=09=09=09"lan865x"
> +
> +/* MAC Network Control Register */
> +#define LAN865X_REG_MAC_NET_CTL=09=090x00010000
> +#define MAC_NET_CTL_TXEN=09=09BIT(3) /* Transmit Enable */
> +#define MAC_NET_CTL_RXEN=09=09BIT(2) /* Receive Enable */
> +
> +#define LAN865X_REG_MAC_NET_CFG=09=090x00010001 /* MAC Network Configura=
tion Reg */
> +#define MAC_NET_CFG_PROMISCUOUS_MODE=09BIT(4)
> +#define MAC_NET_CFG_MULTICAST_MODE=09BIT(6)
> +#define MAC_NET_CFG_UNICAST_MODE=09BIT(7)
> +
> +#define LAN865X_REG_MAC_L_HASH=09=090x00010020 /* MAC Hash Register Bott=
om */
> +#define LAN865X_REG_MAC_H_HASH=09=090x00010021 /* MAC Hash Register Top =
*/
> +#define LAN865X_REG_MAC_L_SADDR1=090x00010022 /* MAC Specific Addr 1 Bot=
tom Reg */
> +#define LAN865X_REG_MAC_H_SADDR1=090x00010023 /* MAC Specific Addr 1 Top=
 Reg */
> +
> +/* OPEN Alliance Configuration Register #0 */
> +#define OA_TC6_REG_CONFIG0=09=090x0004
> +#define CONFIG0_ZARFE_ENABLE=09=09BIT(12)
> +
> +struct lan865x_priv {
> +=09struct work_struct multicast_work;
> +=09struct net_device *netdev;
> +=09struct spi_device *spi;
> +=09struct oa_tc6 *tc6;
> +};
> +
> +static int lan865x_set_hw_macaddr_low_bytes(struct oa_tc6 *tc6, const u8=
 *mac)
> +{
> +=09u32 regval;
> +
> +=09regval =3D (mac[3] << 24) | (mac[2] << 16) | (mac[1] << 8) | mac[0];
> +
> +=09return oa_tc6_write_register(tc6, LAN865X_REG_MAC_L_SADDR1, regval);
> +}
> +
> +static int lan865x_set_hw_macaddr(struct lan865x_priv *priv, const u8 *m=
ac)
> +{
> +=09int restore_ret;
> +=09u32 regval;
> +=09int ret;
> +
> +=09/* Configure MAC address low bytes */
> +=09ret =3D lan865x_set_hw_macaddr_low_bytes(priv->tc6, mac);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* Prepare and configure MAC address high bytes */
> +=09regval =3D (mac[5] << 8) | mac[4];
> +=09ret =3D oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_SADDR1, re=
gval);
> +=09if (!ret)
> +=09=09return 0;
> +
> +=09/* Restore the old MAC address low bytes from netdev if the new MAC
> +=09 * address high bytes setting failed.
> +=09 */
> +=09restore_ret =3D lan865x_set_hw_macaddr_low_bytes(priv->tc6,
> +=09=09=09=09=09=09       priv->netdev->dev_addr);
> +=09if (restore_ret)
> +=09=09return restore_ret;
> +
> +=09return ret;
> +}
> +
> +static void
> +lan865x_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *i=
nfo)
> +{
> +=09strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> +=09strscpy(info->bus_info, dev_name(netdev->dev.parent),
> +=09=09sizeof(info->bus_info));
> +}
> +
> +static const struct ethtool_ops lan865x_ethtool_ops =3D {
> +=09.get_drvinfo        =3D lan865x_get_drvinfo,
> +=09.get_link_ksettings =3D phy_ethtool_get_link_ksettings,
> +=09.set_link_ksettings =3D phy_ethtool_set_link_ksettings,
> +};
> +
> +static int lan865x_set_mac_address(struct net_device *netdev, void *addr=
)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +=09struct sockaddr *address =3D addr;
> +=09int ret;
> +
> +=09ret =3D eth_prepare_mac_addr_change(netdev, addr);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09if (ether_addr_equal(address->sa_data, netdev->dev_addr))
> +=09=09return 0;
> +
> +=09ret =3D lan865x_set_hw_macaddr(priv, address->sa_data);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09eth_hw_addr_set(netdev, address->sa_data);
> +
> +=09return 0;
> +}
> +
> +static u32 lan865x_hash(u8 addr[ETH_ALEN])
> +{
> +=09return (ether_crc(ETH_ALEN, addr) >> 26) & GENMASK(5, 0);
> +}
> +
> +static void lan865x_set_specific_multicast_addr(struct net_device *netde=
v)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +=09struct netdev_hw_addr *ha;
> +=09u32 hash_lo =3D 0;
> +=09u32 hash_hi =3D 0;
> +
> +=09netdev_for_each_mc_addr(ha, netdev) {
> +=09=09u32 bit_num =3D lan865x_hash(ha->addr);
> +=09=09u32 mask =3D BIT(bit_num);
> +
> +=09=09/* 5th bit of the 6 bits hash value is used to determine which
> +=09=09 * bit to set in either a high or low hash register.
> +=09=09 */
> +=09=09if (bit_num & BIT(5))
> +=09=09=09hash_hi |=3D mask;
> +=09=09else
> +=09=09=09hash_lo |=3D mask;
> +=09}
> +
> +=09/* Enabling specific multicast addresses */
> +=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH, hash_hi)=
) {
> +=09=09netdev_err(netdev, "Failed to write reg_hashh");
> +=09=09return;
> +=09}
> +
> +=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH, hash_lo)=
)
> +=09=09netdev_err(netdev, "Failed to write reg_hashl");
> +}
> +
> +static void lan865x_multicast_work_handler(struct work_struct *work)
> +{
> +=09struct lan865x_priv *priv =3D container_of(work, struct lan865x_priv,
> +=09=09=09=09=09=09 multicast_work);
> +=09u32 regval =3D 0;
> +
> +=09if (priv->netdev->flags & IFF_PROMISC) {
> +=09=09/* Enabling promiscuous mode */
> +=09=09regval |=3D MAC_NET_CFG_PROMISCUOUS_MODE;
> +=09=09regval &=3D (~MAC_NET_CFG_MULTICAST_MODE);
> +=09=09regval &=3D (~MAC_NET_CFG_UNICAST_MODE);
> +=09} else if (priv->netdev->flags & IFF_ALLMULTI) {
> +=09=09/* Enabling all multicast mode */
> +=09=09regval &=3D (~MAC_NET_CFG_PROMISCUOUS_MODE);
> +=09=09regval |=3D MAC_NET_CFG_MULTICAST_MODE;
> +=09=09regval &=3D (~MAC_NET_CFG_UNICAST_MODE);
> +=09} else if (!netdev_mc_empty(priv->netdev)) {
> +=09=09lan865x_set_specific_multicast_addr(priv->netdev);
> +=09=09regval &=3D (~MAC_NET_CFG_PROMISCUOUS_MODE);
> +=09=09regval &=3D (~MAC_NET_CFG_MULTICAST_MODE);
> +=09=09regval |=3D MAC_NET_CFG_UNICAST_MODE;
> +=09} else {
> +=09=09/* enabling local mac address only */
> +=09=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH, 0)) {
> +=09=09=09netdev_err(priv->netdev, "Failed to write reg_hashh");
> +=09=09=09return;
> +=09=09}
> +=09=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH, 0)) {
> +=09=09=09netdev_err(priv->netdev, "Failed to write reg_hashl");
> +=09=09=09return;
> +=09=09}
> +=09}
> +=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CFG, regval)=
)
> +=09=09netdev_err(priv->netdev,
> +=09=09=09   "Failed to enable promiscuous/multicast/normal mode");
> +}
> +
> +static void lan865x_set_multicast_list(struct net_device *netdev)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +
> +=09schedule_work(&priv->multicast_work);
> +}
> +
> +static netdev_tx_t lan865x_send_packet(struct sk_buff *skb,
> +=09=09=09=09       struct net_device *netdev)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +
> +=09return oa_tc6_start_xmit(priv->tc6, skb);
> +}
> +
> +static int lan865x_hw_disable(struct lan865x_priv *priv)
> +{
> +=09u32 regval;
> +
> +=09if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, =C2=
=AEval))
> +=09=09return -ENODEV;
> +
> +=09regval &=3D ~(MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN);
> +
> +=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval)=
)
> +=09=09return -ENODEV;
> +
> +=09return 0;
> +}
> +
> +static int lan865x_net_close(struct net_device *netdev)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +=09int ret;
> +
> +=09netif_stop_queue(netdev);
> +=09phy_stop(netdev->phydev);
> +=09ret =3D lan865x_hw_disable(priv);
> +=09if (ret) {
> +=09=09netdev_err(netdev, "Failed to disable the hardware: %d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int lan865x_hw_enable(struct lan865x_priv *priv)
> +{
> +=09u32 regval;
> +
> +=09if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, =C2=
=AEval))
> +=09=09return -ENODEV;
> +
> +=09regval |=3D MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN;
> +
> +=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval)=
)
> +=09=09return -ENODEV;
> +
> +=09return 0;
> +}
> +
> +static int lan865x_net_open(struct net_device *netdev)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +=09int ret;
> +
> +=09ret =3D lan865x_hw_enable(priv);
> +=09if (ret) {
> +=09=09netdev_err(netdev, "Failed to enable hardware: %d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09phy_start(netdev->phydev);
> +
> +=09return 0;
> +}
> +
> +static const struct net_device_ops lan865x_netdev_ops =3D {
> +=09.ndo_open=09=09=3D lan865x_net_open,
> +=09.ndo_stop=09=09=3D lan865x_net_close,
> +=09.ndo_start_xmit=09=09=3D lan865x_send_packet,
> +=09.ndo_set_rx_mode=09=3D lan865x_set_multicast_list,
> +=09.ndo_set_mac_address=09=3D lan865x_set_mac_address,
> +};
> +
> +static int lan865x_set_zarfe(struct lan865x_priv *priv)
> +{
> +=09u32 regval;
> +=09int ret;
> +
> +=09ret =3D oa_tc6_read_register(priv->tc6, OA_TC6_REG_CONFIG0, =C2=AEval=
);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* Set Zero-Align Receive Frame Enable */
> +=09regval |=3D CONFIG0_ZARFE_ENABLE;
> +
> +=09return oa_tc6_write_register(priv->tc6, OA_TC6_REG_CONFIG0, regval);
> +}
> +
> +static int lan865x_probe(struct spi_device *spi)
> +{
> +=09struct net_device *netdev;
> +=09struct lan865x_priv *priv;
> +=09int ret;
> +
> +=09netdev =3D alloc_etherdev(sizeof(struct lan865x_priv));
> +=09if (!netdev)
> +=09=09return -ENOMEM;
> +
> +=09priv =3D netdev_priv(netdev);
> +=09priv->netdev =3D netdev;
> +=09priv->spi =3D spi;
> +=09spi_set_drvdata(spi, priv);
> +=09INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
> +
> +=09priv->tc6 =3D oa_tc6_init(spi, netdev);
> +=09if (!priv->tc6) {
> +=09=09ret =3D -ENODEV;
> +=09=09goto free_netdev;
> +=09}
> +
> +=09/* As per the point s3 in the below errata, SPI receive Ethernet fram=
e
> +=09 * transfer may halt when starting the next frame in the same data bl=
ock
> +=09 * (chunk) as the end of a previous frame. The RFA field should be
> +=09 * configured to 01b or 10b for proper operation. In these modes, onl=
y
> +=09 * one receive Ethernet frame will be placed in a single data block.
> +=09 * When the RFA field is written to 01b, received frames will be forc=
ed
> +=09 * to only start in the first word of the data block payload (SWO=3D0=
). As
> +=09 * recommended, ZARFE bit in the OPEN Alliance CONFIG0 register is se=
t
> +=09 * to 1 for proper operation.
> +=09 *
> +=09 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/Pro=
ductDocuments/Errata/LAN8650-1-Errata-80001075.pdf
> +=09 */
> +=09ret =3D lan865x_set_zarfe(priv);
> +=09if (ret) {
> +=09=09dev_err(&spi->dev, "Failed to set ZARFE: %d\n", ret);
> +=09=09goto oa_tc6_exit;
> +=09}
> +
> +=09/* Get the MAC address from the SPI device tree node */
> +=09if (device_get_ethdev_address(&spi->dev, netdev))
> +=09=09eth_hw_addr_random(netdev);
> +
> +=09ret =3D lan865x_set_hw_macaddr(priv, netdev->dev_addr);
> +=09if (ret) {
> +=09=09dev_err(&spi->dev, "Failed to configure MAC: %d\n", ret);
> +=09=09goto oa_tc6_exit;
> +=09}
> +
> +=09netdev->if_port =3D IF_PORT_10BASET;
> +=09netdev->irq =3D spi->irq;
> +=09netdev->netdev_ops =3D &lan865x_netdev_ops;
> +=09netdev->ethtool_ops =3D &lan865x_ethtool_ops;
> +
> +=09ret =3D register_netdev(netdev);
> +=09if (ret) {
> +=09=09dev_err(&spi->dev, "Register netdev failed (ret =3D %d)", ret);
> +=09=09goto oa_tc6_exit;
> +=09}
> +
> +=09return 0;
> +
> +oa_tc6_exit:
> +=09oa_tc6_exit(priv->tc6);
> +free_netdev:
> +=09free_netdev(priv->netdev);
> +=09return ret;
> +}
> +
> +static void lan865x_remove(struct spi_device *spi)
> +{
> +=09struct lan865x_priv *priv =3D spi_get_drvdata(spi);
> +
> +=09cancel_work_sync(&priv->multicast_work);
> +=09unregister_netdev(priv->netdev);
> +=09oa_tc6_exit(priv->tc6);
> +=09free_netdev(priv->netdev);
> +}
> +
> +static const struct of_device_id lan865x_dt_ids[] =3D {
> +=09{ .compatible =3D "microchip,lan8651", "microchip,lan8650" },
> +=09{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
> +
> +static struct spi_driver lan865x_driver =3D {
> +=09.driver =3D {
> +=09=09.name =3D DRV_NAME,
> +=09=09.of_match_table =3D lan865x_dt_ids,
> +=09 },
> +=09.probe =3D lan865x_probe,
> +=09.remove =3D lan865x_remove,
> +};
> +module_spi_driver(lan865x_driver);
> +
> +MODULE_DESCRIPTION(DRV_NAME " 10Base-T1S MACPHY Ethernet Driver");
> +MODULE_AUTHOR("Parthiban Veerasooran <parthiban.veerasooran@microchip.co=
m>");
> +MODULE_LICENSE("GPL");
> --=20
> 2.34.1

