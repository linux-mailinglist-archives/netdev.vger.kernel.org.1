Return-Path: <netdev+bounces-211216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18737B17300
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C35F1AA8254
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D883594B;
	Thu, 31 Jul 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="M4yifNTO"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210818E25;
	Thu, 31 Jul 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971370; cv=none; b=gE1VRGS+hCtxR6PwFLLUr6L9p4LGv/obiuUtKacHMVUkLLKYOs9SpEqW9KOcovldbZrEeioGrYFJpGVtMHzh4ftyx0ZOQcRoWWU5lA+0fz7hNzW9gH9ayUuahrbcnhyDMBy1rYJXq+o3WmqeKcJy0ncw3g6fQ7PRSy4SFoAPGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971370; c=relaxed/simple;
	bh=eQ/gZv6LO5Hue9eUzbsped9hjtPCsvRvn5W2HR7Wmdc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KQ8KYphuVzw1XP/karTIxuPWY5bk/ZpU8OaGXJjEiAOiVYXtzpJd7H27EkeOieLhyl6VumcqckdeY9bVYU2cSRgOc7F9vlNjXg8OeqB43ezHNQQCTSUyemQjE8s8oktImHt6vmEDvjxmuswHGkEMSZPGa8zJyg0PQseIyHxgnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=M4yifNTO; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Yrfb0HOaoHG7iPog1DBjfZMW+8NvBRkjZ6FVr4DkooM=; b=M4yifNTOJvgbXIrhWyt7VnFbod
	bzVsqfTnYcU/nnFZs8TBT9uSh0Sp46t6mGXqqC4kO3MH5wMQCvJyXnAzFz+b9GeihUicgz38qwRUq
	/QJoZUlERnPJfWlDyQBIpDFCOSxXmeJ579r3eE8tTPmIhYae3lAlZ3qs80C1RZZkqunirrDWMoDbK
	1NPX4TbE97q6lnpdjqnGD1IreBmK5Jb2sWaBaYsdz2/NvFEY/uVfKiCr98z3hxhYeEfLhRDHoenz1
	gkvRaVhHlbL7ll4Z/qzvvBRbaxlbn3K/HsGcN2Ey8U9jhdKibDjjEa2diNk1tmLaMegMHrmblLqj+
	D/SDapbA==;
Received: from [122.175.9.182] (port=48191 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uhU4f-0000000EGfX-2qBf;
	Thu, 31 Jul 2025 10:16:02 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id E5B941781F30;
	Thu, 31 Jul 2025 19:45:55 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id C5B5C1783F55;
	Thu, 31 Jul 2025 19:45:55 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RGkdA-2r7jyA; Thu, 31 Jul 2025 19:45:55 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 7E4051781F30;
	Thu, 31 Jul 2025 19:45:55 +0530 (IST)
Date: Thu, 31 Jul 2025 19:45:55 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	s hauer <s.hauer@pengutronix.de>, m-karicheri2 <m-karicheri2@ti.com>, 
	glaroque <glaroque@baylibre.com>, afd <afd@ti.com>, 
	saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	kory maincent <kory.maincent@bootlin.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	horms <horms@kernel.org>, s-anna <s-anna@ti.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <234831131.78058.1753971355358.JavaMail.zimbra@couthit.local>
In-Reply-To: <1d39a02c-92e6-4ebe-8917-cc7c2ebb70b2@oracle.com>
References: <20250724072535.3062604-1-parvathi@couthit.com> <20250724072535.3062604-3-parvathi@couthit.com> <1d39a02c-92e6-4ebe-8917-cc7c2ebb70b2@oracle.com>
Subject: Re: [PATCH net-next v12 2/5] net: ti: prueth: Adds ICSSM Ethernet
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds ICSSM Ethernet driver
Thread-Index: wj03l94gG4u1FVHPYBiI8HEpNdo3ng==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On 7/24/2025 12:53 PM, Parvathi Pudi wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>=20
>> Updates Kernel configuration to enable PRUETH driver and its dependencie=
s
>> along with makefile changes to add the new PRUETH driver.
>>=20
>> Changes includes init and deinit of ICSSM PRU Ethernet driver including
>> net dev registration and firmware loading for DUAL-MAC mode running on
>> PRU-ICSS2 instance.
>>=20
>> Changes also includes link handling, PRU booting, default firmware loadi=
ng
>> and PRU stopping using existing remoteproc driver APIs.
>>=20
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>> ---
>>   drivers/net/ethernet/ti/Kconfig              |  12 +
>>   drivers/net/ethernet/ti/Makefile             |   3 +
>>   drivers/net/ethernet/ti/icssm/icssm_prueth.c | 610 +++++++++++++++++++
>>   drivers/net/ethernet/ti/icssm/icssm_prueth.h | 100 +++
>>   4 files changed, 725 insertions(+)
>>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.c
>>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.h
>>=20
>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/K=
config
>> index a07c910c497a..ab20f22524cb 100644
>> --- a/drivers/net/ethernet/ti/Kconfig
>> +++ b/drivers/net/ethernet/ti/Kconfig
>> @@ -229,4 +229,16 @@ config TI_ICSS_IEP
>>   =09  To compile this driver as a module, choose M here. The module
>>   =09  will be called icss_iep.
>>  =20
>> +config TI_PRUETH
>> +=09tristate "TI PRU Ethernet EMAC driver"
>> +=09depends on PRU_REMOTEPROC
>> +=09depends on NET_SWITCHDEV
>> +=09select TI_ICSS_IEP
>> +=09imply PTP_1588_CLOCK
>> +=09help
>> +=09  Some TI SoCs has Programmable Realtime Units (PRUs) cores which ca=
n
>=20
> Some TI SoCs have Programmable Realtime Unit (PRU)
>=20

Sure, We will address this.

>> +=09  support Single or Dual Ethernet ports with help of firmware code r=
unning
>=20
> with the help of firmware code running
>=20

Sure, We will address this.

>> +=09  on PRU cores. This driver supports remoteproc based communication =
to
>> +=09  PRU firmware to expose ethernet interface to Linux.
>=20
> ethernet -> Ethernet
>=20

Sure, We will address this.

>> +
>>   endif # NET_VENDOR_TI
>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/=
Makefile
>> index cbcf44806924..93c0a4d0e33a 100644
>> --- a/drivers/net/ethernet/ti/Makefile
>> +++ b/drivers/net/ethernet/ti/Makefile
>> @@ -3,6 +3,9 @@
>>   # Makefile for the TI network device drivers.
>>   #
>>  =20
>> +obj-$(CONFIG_TI_PRUETH) +=3D icssm-prueth.o
>> +icssm-prueth-y :=3D icssm/icssm_prueth.o
>> +
>>   obj-$(CONFIG_TI_CPSW) +=3D cpsw-common.o
>>   obj-$(CONFIG_TI_DAVINCI_EMAC) +=3D cpsw-common.o
>>   obj-$(CONFIG_TI_CPSW_SWITCHDEV) +=3D cpsw-common.o
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> new file mode 100644
>> index 000000000000..375fd636684d
>> --- /dev/null
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> @@ -0,0 +1,610 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/* Texas Instruments ICSSM Ethernet Driver
>> + *
>> + * Copyright (C) 2018-2022 Texas Instruments Incorporated -
>> https://urldefense.com/v3/__https://www.ti.com/__;!!ACWV5N9M2RV99hQ!KJSw=
49T9tFMkKlUCkufdpPMrYbxZqO8afwgd1oNYrR_r0dienongkVB3K8jc1UDBehhE_eMQGHAGYrv=
O9wPpJQ$
>> + *
>> + */
>> +
>> +#include <linux/etherdevice.h>
>> +#include <linux/genalloc.h>
>> +#include <linux/if_bridge.h>
>> +#include <linux/if_hsr.h>
>> +#include <linux/if_vlan.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/net_tstamp.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_mdio.h>
>> +#include <linux/of_net.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/phy.h>
>> +#include <linux/remoteproc/pruss.h>
>> +#include <linux/ptp_classify.h>
>> +#include <linux/regmap.h>
>> +#include <linux/remoteproc.h>
>> +#include <net/pkt_cls.h>
>> +
>> +#include "icssm_prueth.h"
>> +
>> +/* called back by PHY layer if there is change in link state of hw port=
*/
>> +static void icssm_emac_adjust_link(struct net_device *ndev)
>> +{
>> +=09struct prueth_emac *emac =3D netdev_priv(ndev);
>> +=09struct phy_device *phydev =3D emac->phydev;
>> +=09bool new_state =3D false;
>> +=09unsigned long flags;
>> +
>> +=09spin_lock_irqsave(&emac->lock, flags);
>> +
>> +=09if (phydev->link) {
>> +=09=09/* check the mode of operation */
>> +=09=09if (phydev->duplex !=3D emac->duplex) {
>> +=09=09=09new_state =3D true;
>> +=09=09=09emac->duplex =3D phydev->duplex;
>> +=09=09}
>> +=09=09if (phydev->speed !=3D emac->speed) {
>> +=09=09=09new_state =3D true;
>> +=09=09=09emac->speed =3D phydev->speed;
>> +=09=09}
>> +=09=09if (!emac->link) {
>> +=09=09=09new_state =3D true;
>> +=09=09=09emac->link =3D 1;
>> +=09=09}
>> +=09} else if (emac->link) {
>> +=09=09new_state =3D true;
>> +=09=09emac->link =3D 0;
>> +=09}
>> +
>> +=09if (new_state)
>> +=09=09phy_print_status(phydev);
>> +
>> +=09if (emac->link) {
>> +=09       /* reactivate the transmit queue if it is stopped */
>> +=09=09if (netif_running(ndev) && netif_queue_stopped(ndev))
>> +=09=09=09netif_wake_queue(ndev);
>> +=09} else {
>> +=09=09if (!netif_queue_stopped(ndev))
>> +=09=09=09netif_stop_queue(ndev);
>> +=09}
>> +
>> +=09spin_unlock_irqrestore(&emac->lock, flags);
>> +}
>> +
>> +static int icssm_emac_set_boot_pru(struct prueth_emac *emac,
>> +=09=09=09=09   struct net_device *ndev)
>> +{
>> +=09const struct prueth_firmware *pru_firmwares;
>> +=09struct prueth *prueth =3D emac->prueth;
>> +=09const char *fw_name;
>> +=09int ret;
>> +
>> +=09pru_firmwares =3D &prueth->fw_data->fw_pru[emac->port_id - 1];
>=20
> If emac->port_id =3D=3D 0, this will index at -1
>=20

We will enter this API for emac->port_id as 1 or  2 always due to the
reason that the physical port indexes are 1 for MII0 and 2 for MII1
which are nothing but PRU0 and PRU1 respectively. Zero is for HOST port
which is a virtual port no PRU core associated to it but it is the ARM
core which is initializing the PRU=E2=80=99s.

>> +=09fw_name =3D pru_firmwares->fw_name[prueth->eth_type];
>> +=09if (!fw_name) {
>> +=09=09netdev_err(ndev, "eth_type %d not supported\n",
>> +=09=09=09   prueth->eth_type);
>> +=09=09return -ENODEV;
>> +=09}
>> +
>> +=09ret =3D rproc_set_firmware(emac->pru, fw_name);
>> +=09if (ret) {
>> +=09=09netdev_err(ndev, "failed to set PRU0 firmware %s: %d\n",
>=20
> Hardcoded PRU0 in Logs, what if PRU1
>=20

Sure, We will address this.

We will post the next version soon after net-next is open.


Thanks and Regards,
Parvathi.

