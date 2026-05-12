Return-Path: <netdev+bounces-286976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CM1JwrVAmpLyAEAu9opvQ
	(envelope-from <netdev+bounces-286976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:21:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB4351BBA3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70627300A8DC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA90441024;
	Tue, 12 May 2026 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Vef5nYBw"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD147B41C;
	Tue, 12 May 2026 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570135; cv=none; b=DMYgTG/RgQ1qiBLP84c05oWPC8csfdR7jSrT22ZNWUXaZoIs+4c6+BqntzcvFs0/QakgLzHh8YHaJZsBu6jH6ZkxRAVBUEjMoS2rl5Tu5ImpljXJrBAZCUJWq1JQszCg4Y+TeqZAmy646JKwoqUGwmbp5VPaOZohWMRLLqiZMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570135; c=relaxed/simple;
	bh=GGE06DAj+4IqOdJ5cqIYPBVMHvlsSfv2BWQTB9qiVPk=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fPGKZTXV2duKVIyikTkPj8KKP6/Kux1XC62pFOyPgyzxJ3UGhTRZLqMQ1z7rtf1o1nqZ4SSLWekk94xMmH9GPZ8B0uRCGzyycNTr/8UN+DsE8f7RxPOQQE3/vivpmmmIrfOhF9mTpXfAiKyNha5Yz8SeFXnm0lfRVD3oLB8QdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Vef5nYBw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778570129; x=1810106129;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GGE06DAj+4IqOdJ5cqIYPBVMHvlsSfv2BWQTB9qiVPk=;
  b=Vef5nYBwMzWjyh4hrihZ+48bIvc+yfOoXTPqqXBtfkwxezIzF5yfhVye
   aSEJ2R6v2JbUFuFJ7jLqjjAbcqAa1KzeVRIojFvPHkeQ7oVHXTtksHd2N
   jW81BxjH0MiI2NU0RTxJcKj81wGYPvgthJvUdaI/+fY3yd1IKP2A7SoB5
   pAICEijVkdelkfqwhJOrfO2SRMkOGdB8rCFKUjFus/ZzPvGQIBItu1u6x
   0I3Bof/OPOlkbg5ZaxIBHPf3ThHfmoQmAu75Ua9rop63Y2qT+6LFRb5pc
   6IWZVtgvHlc+mwSvAU7ksi96NOC1AfbbWGw4wiRnGPu3nJXpxTCcGdL9j
   g==;
X-CSE-ConnectionGUID: cnjrhXucQkCxa+XjepAKqg==
X-CSE-MsgGUID: HOapYMa5QiiVHtGRFj/coA==
X-IronPort-AV: E=Sophos;i="6.23,230,1770620400"; 
   d="scan'208";a="56597075"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2026 00:15:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 12 May 2026 00:15:21 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 12 May 2026 00:15:18 -0700
Message-ID: <4dc940e788e0f2b238deed8231b04af145a2c106.camel@microchip.com>
Subject: Re: [PATCH net-next v4 4/9] net: dsa: lan9645x: add basic dsa
 driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Tue, 12 May 2026 09:15:17 +0200
In-Reply-To: <20260506014555.1616575-1-kuba@kernel.org>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-4-f1b6005fa8b7@microchip.com>
	 <20260506014555.1616575-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: ECB4351BBA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286976-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Action: no action

On Tue, 2026-05-05 at 18:45 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: lan9645x: add basic dsa driver for LAN9645X
>=20
> This patch introduces a new DSA driver for the Microchip LAN9645X switch
> family, covering probe/setup/teardown, NPI CPU port wiring, per-port
> initialisation, and phylink MAC integration. A few questions inline.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/Kconfig b/drivers/net/d=
sa/microchip/lan9645x/Kconfig
> > new file mode 100644
> > index 000000000000..4d9fdf34104e
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/Kconfig
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config NET_DSA_MICROCHIP_LAN9645X
> > +     tristate "Microchip Lan9645x switch support"
> > +     depends on NET_DSA
> > +     select NET_DSA_TAG_LAN9645X
> > +     help
> > +       This driver adds DSA support for Microchip Lan9645x switch chip=
s.
>=20
> The driver is non-functional without a parent MFD that registers the name=
d
> regmaps ("gcb", "qs", "chip_top", "rew", "sys", "hsio", "dev", "dev1" ..
> "dev8", "qsys", "afi", "ana") consumed by lan9645x_request_target_regmaps=
().
>=20
> Should this Kconfig depend on the parent provider symbol so that selectin=
g
> this option without the parent driver does not produce a module whose pro=
be
> always fails?
>=20
> Is there a companion parent-driver patch this patch depends on? If so,
> would it be worth naming it in the commit message and documenting the
> ordering?
>=20

I mention this in the cover letter. The plan is to send the parent MFD in
another series. This switch driver will be one of the child devices, and
from what I can tell there are requirements to how many child devices an
MFD driver should have before qualifying as such. So there is a bit of
and chicken and egg problem. The first version of the MFD driver will
have 3 children

* pinctrl
* MDIO controller
* dsa switch

and uses the same approach as drivers/mfd/ocelot-spi.c. I can not depend
on the Kconfig symbol here, because the symbol does not exist at this point=
.
I have not include the MFD patches here because it targets another tree,
and this was already quite large.

I am happy to do this is in some other way if the maintainers think that
would be better?

At any rate, I can add some of this information to the commit message,
so it is not just in the cover letter.

> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > new file mode 100644
> > index 000000000000..6fd66ea67cfd
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > @@ -0,0 +1,423 @@
>=20
> [ ... ]
>=20
> > +static const char *lan9645x_resource_names[NUM_TARGETS + 1] =3D {
> > +     [TARGET_GCB]          =3D "gcb",
> > +     [TARGET_QS]           =3D "qs",
> > +     [TARGET_CHIP_TOP]     =3D "chip_top",
> > +     [TARGET_REW]          =3D "rew",
> > +     [TARGET_SYS]          =3D "sys",
> > +     [TARGET_HSIO]         =3D "hsio",
> > +     [TARGET_DEV]          =3D "dev",
> > +     [TARGET_DEV + 1]      =3D "dev1",
> > +     [TARGET_DEV + 2]      =3D "dev2",
> > +     [TARGET_DEV + 3]      =3D "dev3",
> > +     [TARGET_DEV + 4]      =3D "dev4",
> > +     [TARGET_DEV + 5]      =3D "dev5",
> > +     [TARGET_DEV + 6]      =3D "dev6",
> > +     [TARGET_DEV + 7]      =3D "dev7",
> > +     [TARGET_DEV + 8]      =3D "dev8",
>=20
> The first DEV instance is named "dev", while the rest are "dev1" through
> "dev8". Is this asymmetry intentional, or should the first be "dev0" to
> match the natural per-port numbering? Without the parent driver available
> in this series, it is hard to tell which naming scheme the parent actuall=
y
> registers.
>=20
> If the parent registers "dev0".."dev8" then dev_get_regmap(parent, "dev")
> returns NULL and probe fails with -ENODEV.
>=20

See my answer above. I thought it was best to send them seperately, but I
can include the MFD patches here if that is preferred.

> [ ... ]
>=20
> > +static void lan9645x_set_feat_dis(struct lan9645x *lan9645x)
> > +{
> > +     u32 feat_dis;
> > +
> > +     /* The features which can be physically disabled on some SKUs are=
:
> > +      * 1) Number of ports can be 5, 7 or 9. Any ports can be used, th=
e chip
> > +      *    tracks how many are active.
> > +      * 2) HSR/PRP. The duplicate discard table can be disabled.
> > +      * 3) TAS, frame preemption and PSFP can be disabled.
> > +      */
> > +     feat_dis =3D lan_rd(lan9645x, GCB_FEAT_DISABLE);
> > +
> > +     lan9645x->num_port_dis =3D
> > +             GCB_FEAT_DISABLE_FEAT_NUM_PORTS_DIS_GET(feat_dis);
> > +     lan9645x->dd_dis =3D GCB_FEAT_DISABLE_FEAT_DD_DIS_GET(feat_dis);
> > +     lan9645x->tsn_dis =3D GCB_FEAT_DISABLE_FEAT_TSN_DIS_GET(feat_dis)=
;
> > +}
>=20
> Where are num_port_dis, dd_dis and tsn_dis consulted after this read?
>=20
> ds->num_ports is hardcoded to NUM_PHYS_PORTS (9) in lan9645x_probe(), and
> there does not appear to be any rejection of TSN or HSR/PRP configuration
> on SKUs where tsn_dis=3D1 or dd_dis=3D1 in this patch. On a 5-port SKU
> (num_port_dis=3D4), would the driver still register 9 DSA ports and allow
> DT to bring up a fused-off port?
>=20

Ah yes, there was supposed to be some validation during setup which makes
sure the number of ports enabled in the DT does not exceed the number of
supported ports by the SKU. I will add that, and remove the dd_dis/tsn_dis,
which are not used at this point.

> > +static int lan9645x_setup(struct dsa_switch *ds)
> > +{
>=20
> [ ... ]
>=20
> > +     dev_info(lan9645x->dev,
> > +              "SKU features: tsn_dis=3D%d hsr_dis=3D%d max_ports=3D%d\=
n",
> > +              lan9645x->tsn_dis, lan9645x->dd_dis,
> > +              lan9645x->num_phys_ports - lan9645x->num_port_dis);
>=20
> The log prints the field called dd_dis in struct lan9645x under the name
> hsr_dis. Should the label in the format string match the struct field
> name, or should the field be renamed?
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c b/dr=
ivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> > new file mode 100644
> > index 000000000000..9eac32ca342c
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> > @@ -0,0 +1,383 @@
>=20
> [ ... ]
>=20
> > +/* Port 4 or 7 is RGMII_0 and port 8 is RGMII_1 */
> > +#define RGMII_IDX(port) ((port) =3D=3D 8 ? 1 : 0)
> > +
> > +void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
> > +                            struct phylink_config *c)
> > +{
> > +     c->mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
> > +                           MAC_100 | MAC_1000FD | MAC_2500FD;
> > +
> > +     switch (port) {
> > +     case 0 ... 3:
> > +             __set_bit(PHY_INTERFACE_MODE_GMII, c->supported_interface=
s);
> > +             break;
> > +     case 4:
> > +             __set_bit(PHY_INTERFACE_MODE_GMII, c->supported_interface=
s);
> > +             phy_interface_set_rgmii(c->supported_interfaces);
> > +             break;
> > +     case 5 ... 6:
> > +             /* SerDes ports: QSGMII/SGMII/1000BASEX/2500BASEX modes
> > +              * require PCS support which is not yet implemented.
> > +              */
> > +             break;
> > +     case 7 ... 8:
> > +             /* QSGMII mode on ports 7-8 requires SerDes PCS support,
> > +              * which is not yet implemented.
> > +              */
> > +             phy_interface_set_rgmii(c->supported_interfaces);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +}
>=20
> mac_capabilities advertises MAC_2500FD for every port, but none of the
> supported_interfaces entries allow negotiating 2.5 Gb/s. GMII and RGMII
> do not carry 2.5 Gb/s, and ports 5-6 have an empty supported_interfaces
> bitmap. Should MAC_2500FD be dropped until a PCS-capable interface is
> added, or should it be set only on ports that will actually support it?
>=20
> For ports 5 and 6, supported_interfaces is left empty. Will phylink_creat=
e()
> succeed for those ports given no interface mode is permitted, or will the=
y
> be silently unusable?
>=20
> The commit message states:
>=20
>     The lan9645x switch is a multi-port Gigabit AVB/TSN Ethernet Switch
>     with five integrated 10/100/1000Base-T PHYs. In addition to the
>     integrated PHYs, it supports up to 2 RGMII/RMII, up to 2
>     BASE-X/SERDES/2.5GBASE-X and one Quad-SGMII/Quad-USGMII interfaces.
>=20
> Given ports 5-6 have no supported_interfaces and ports 7-8 expose only
> RGMII in this patch, would it help to note in the commit message that
> SerDes, QSGMII/USGMII and 2.5GBASE-X are not wired up yet?
>=20

I will remove MAC_2500FD and update the commit message to be clear about
current limitations vs. SerDes ports. With empty supported interfaces
DSA core will flip the ports to UNUSED if they are defined in the DT.

> [ ... ]
>=20
> > +static int lan9645x_phylink_mac_prepare(struct phylink_config *config,
> > +                                     unsigned int mode,
> > +                                     phy_interface_t iface)
> > +{
> > +     struct lan9645x_port *p =3D lan9645x_phylink_config_to_port(confi=
g);
> > +     struct lan9645x *lan9645x =3D p->lan9645x;
> > +     int port =3D p->chip_port;
> > +     bool is_rgmii;
> > +     u32 mask;
> > +
> > +     if (port =3D=3D 5 || port =3D=3D 6 || port > 8)
> > +             return -EINVAL;
> > +
> > +     mask =3D HSIO_HW_CFG_GMII_ENA_SET(BIT(port));
> > +     lan_rmw(mask, mask, lan9645x, HSIO_HW_CFG);
> > +
> > +     is_rgmii =3D phy_interface_mode_is_rgmii(iface);
> > +     if (port =3D=3D 4)
> > +             lan_rmw(HSIO_HW_CFG_RGMII_0_CFG_SET(is_rgmii),
> > +                     HSIO_HW_CFG_RGMII_0_CFG,
> > +                     lan9645x, HSIO_HW_CFG);
> > +
> > +     return 0;
> > +}
>=20
> The HSIO_HW_CFG_RGMII_0_CFG bit is only written when port =3D=3D 4, but t=
he
> comment above RGMII_IDX() states:
>=20
>     /* Port 4 or 7 is RGMII_0 and port 8 is RGMII_1 */
>     #define RGMII_IDX(port) ((port) =3D=3D 8 ? 1 : 0)
>=20
> Port 7 also maps to RGMII_0. If port 7 is configured for RGMII, does the
> RGMII_0 mux ever get routed to port 7? And if port 4 is later configured
> in GMII mode, the write HSIO_HW_CFG_RGMII_0_CFG_SET(0) would run and
> appear to reroute RGMII_0 away from port 7.
>=20
> Is there meant to be mutual-exclusion between port 4 and port 7 in RGMII
> mode, and a write path for port 7 as well?

Yes this is a 2:1 mux. I thought the interface modes were fixed from the DT=
,
except perhaps for SFPs, but I will update this to properly handle the
muxing in a dynamic fashion.

>=20
> > +static void lan9645x_rgmii_dll_config(struct lan9645x_port *p)
> > +{
> > +     u32 rx_idx, tx_idx;
> > +
> > +     /* DLL register layout:
> > +      * (N*2):   RGMII_N_RX
> > +      * (N*2)+1: RGMII_N_TX
> > +      */
> > +     rx_idx =3D RGMII_IDX(p->chip_port) * 2;
> > +     tx_idx =3D RGMII_IDX(p->chip_port) * 2 + 1;
> > +
> > +     /* Enable DLL in RGMII clock paths, deassert DLL reset, and start=
 the
> > +      * delay tune FSM.
> > +      */
> > +     lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
> > +             HSIO_DLL_CFG_DLL_RST_SET(0) |
> > +             HSIO_DLL_CFG_DLL_ENA_SET(p->rx_internal_delay) |
> > +             HSIO_DLL_CFG_DELAY_ENA_SET(p->rx_internal_delay),
> > +             HSIO_DLL_CFG_DLL_CLK_ENA |
> > +             HSIO_DLL_CFG_DLL_RST |
> > +             HSIO_DLL_CFG_DLL_ENA |
> > +             HSIO_DLL_CFG_DELAY_ENA,
> > +             p->lan9645x, HSIO_DLL_CFG(rx_idx));
> > +
> > +     lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
> > +             HSIO_DLL_CFG_DLL_RST_SET(0) |
> > +             HSIO_DLL_CFG_DLL_ENA_SET(p->tx_internal_delay) |
> > +             HSIO_DLL_CFG_DELAY_ENA_SET(p->tx_internal_delay),
> > +             HSIO_DLL_CFG_DLL_CLK_ENA |
> > +             HSIO_DLL_CFG_DLL_RST |
> > +             HSIO_DLL_CFG_DLL_ENA |
> > +             HSIO_DLL_CFG_DELAY_ENA,
> > +             p->lan9645x, HSIO_DLL_CFG(tx_idx));
> > +}
>=20
> This function consults only p->rx_internal_delay and p->tx_internal_delay
> and never looks at the phy_interface_t. Phylink expects the MAC to apply
> internal delay only when the interface is RGMII_ID, RGMII_TXID or
> RGMII_RXID, and not when the interface is plain PHY_INTERFACE_MODE_RGMII
> (where the PHY provides delay).
>=20
> With a DT that specifies phy-mode =3D "rgmii" and nonzero
> rx-internal-delay-ps, will both the PHY and the MAC add delay?
>=20
> And with phy-mode =3D "rgmii-id" but no {rx,tx}-internal-delay-ps propert=
y
> in DT, will the MAC fail to add delay on either side?
>=20

The bots like to come back to this. The function is only called when
phy_interface_mode_is_rgmii.

With respect to the mechanics of it all, I believe this is how you support
MAC-2-MAC configurations where one side needs to add the delays.
The PHY_INTERFACE_MODE_* is not supposed to be used for this, as I=C2=A0
understand it.

I originally did it that way, and was instructed to change it to this.

> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_port.c
> > new file mode 100644
> > index 000000000000..394a20ee678f
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
>=20
> [ ... ]
>=20
> > +int lan9645x_port_setup(struct dsa_switch *ds, int port)
> > +{
> > +     struct dsa_port *dp =3D dsa_to_port(ds, port);
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct lan9645x_port *p;
> > +
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +
> > +     if (dp->dn) {
> > +             u32 val;
> > +
> > +             if (!of_property_read_u32(dp->dn, "rx-internal-delay-ps",=
 &val))
> > +                     p->rx_internal_delay =3D val > 0;
> > +
> > +             if (!of_property_read_u32(dp->dn, "tx-internal-delay-ps",=
 &val))
> > +                     p->tx_internal_delay =3D val > 0;
> > +     }
>=20
> The u32 picosecond value from DT is collapsed to a boolean via "val > 0",
> discarding the tap selection. Is the discarded precision intentional, and
> if so, why read the value as u32 in the first place rather than using
> of_property_read_bool() on a differently-named property?

I will add some explicit validation. The hardware only supports 2ns on/off.=
 I will
add a comment about that, and reject unsupported values.


