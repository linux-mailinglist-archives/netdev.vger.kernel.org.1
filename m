Return-Path: <netdev+bounces-264413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDbvAFuTqWlCAQEAu9opvQ
	(envelope-from <netdev+bounces-264413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:29:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F6213676
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5298F3072A78
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE093A8FE8;
	Thu,  5 Mar 2026 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ERCxwlgP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E23A4F59;
	Thu,  5 Mar 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720714; cv=none; b=s3HfJSK0YdAsXQ9rMOOxTFSu9ddp+z6TirVOAd4Hk9DQ7dZpU9xeVr95FlKoxJ9sXk2+hp4+l1a9zaIRxWBcBI82Dmqb5YQx59CktoeJ4NmVouYr/w/6nVa5Kfsm5BXLDoPwGoW6mMeXGsyMhMR2MAZ3pXiU4JW25F/uSxfSGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720714; c=relaxed/simple;
	bh=3XQdFhjbgdJIUtWn6GfRsfTtEWmLAQ2bUpshBd2zzSs=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k1SahZsdGlwaAQa+mq3wKyWk7vJs6hOYidZ3yJIv71OFzX5pEjGhFY18eWrngEx9s4l8KTvfw4a1cHsNXspHpbd1RercJWOq2fbhCBNShpTPFUA6ilFrAdcSiYglKLWYZMqT7Mc7yS7fAO8avyzwN7iiXtLOWMmhtpKeJbaYEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ERCxwlgP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772720706; x=1804256706;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3XQdFhjbgdJIUtWn6GfRsfTtEWmLAQ2bUpshBd2zzSs=;
  b=ERCxwlgPTb0XTTURZ+nwLLpg+43JHUcJ2agQX7U0h1CizijgCNbxlaYs
   fFeYnp4IX6HFtLFKD0xXV3ZiiT4agEV8K+Vws3sSaRqO0RyDZMXIV/bL7
   h4SRAKxy9Y8BpXlG4tVYoozwFuivTm2A8BeVsYNXIjgnrOkTSZIUHcrN5
   C2eoxJP8TPR1Oz9hvB5t7yNq1NKT9iA7CbMtNw0AyGr2IB53/JDODBIgu
   jgP3PpOvLsDym3dO9tG3cV/ep6P0QXIGxYQA5KUdHZcZhe8WALrJWTpW+
   tPZLU41ZwzeZ2973wNOosJKNPG8li7GBCYNop2rbL6B17IU1eN7tOwvXU
   A==;
X-CSE-ConnectionGUID: W2qB8Df6SwWAjn8J8nL26Q==
X-CSE-MsgGUID: Vu3QD8q5Toqq1k++QTq/ZA==
X-IronPort-AV: E=Sophos;i="6.23,103,1770620400"; 
   d="scan'208";a="61762946"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 07:25:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Mar 2026 07:24:47 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 07:24:44 -0700
Message-ID: <32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
Subject: Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Thu, 5 Mar 2026 15:24:43 +0100
In-Reply-To: <aahWu2-3YT92vMuC@shell.armlinux.org.uk>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-4-bff8ca1396f5@microchip.com>
	 <aahWu2-3YT92vMuC@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 936F6213676
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264413-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 15:58 +0000, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Tue, Mar 03, 2026 at 01:22:30PM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > Add the LAN9645X basic DSA driver with initialization, parent regmap
> > requests, port module initialization for NPI, CPU ports and front ports=
,
> > and phylink integration for MAC side configuration.
>=20
> I'm reviewing the phylink implementation only.
>=20
> > +static int lan9645x_rgmii_setup(struct lan9645x *lan9645x, int port, i=
nt speed,
> > +                             phy_interface_t mode)
> > +{
> > +     bool tx_delay =3D false, rx_delay =3D false;
> > +     u32 rx_idx, tx_idx;
> > +     u8 tx_clk;
> > +     int idx;
> > +
> > +     /* Port 4 or 7 is RGMII_0 and port 8 is RGMII_1 */
> > +     idx =3D port =3D=3D 8 ? 1 : 0;
> > +
> > +     if (!phy_interface_mode_is_rgmii(mode))
> > +             return 0;
> > +
> > +     tx_clk =3D speed =3D=3D SPEED_1000 ? 1 :
> > +              speed =3D=3D SPEED_100  ? 2 :
> > +              speed =3D=3D SPEED_10   ? 3 : 0;
> > +
> > +     lan_rmw(HSIO_RGMII_CFG_RGMII_RX_RST_SET(0) |
> > +             HSIO_RGMII_CFG_RGMII_TX_RST_SET(0) |
> > +             HSIO_RGMII_CFG_TX_CLK_CFG_SET(tx_clk),
>=20
> What exactly is this clock configuration doing?
>=20

This configures the outgoing txc clock. The encoding here is:

0: Disable TX clock generation
1: 125MHz for 1000Mbps operation
2:  25MHz for  100Mbps operation
3: 2.5MHz for   10Mbps operation

We take the RX and TX clock out of reset and configure this tx clock based =
on speed.


> > +             HSIO_RGMII_CFG_RGMII_RX_RST |
> > +             HSIO_RGMII_CFG_RGMII_TX_RST |
> > +             HSIO_RGMII_CFG_TX_CLK_CFG,
> > +             lan9645x, HSIO_RGMII_CFG(idx));
> > +
> > +     /* We configure delays on the MAC side. When the PHY is not respo=
nsible
> > +      * for delays, the MAC is, which is why RGMII_TXID results in
> > +      * rx_delay=3Dtrue.
> > +      */
> > +     if (mode =3D=3D PHY_INTERFACE_MODE_RGMII ||
> > +         mode =3D=3D PHY_INTERFACE_MODE_RGMII_TXID)
> > +             rx_delay =3D true;
> > +
> > +     if (mode =3D=3D PHY_INTERFACE_MODE_RGMII ||
> > +         mode =3D=3D PHY_INTERFACE_MODE_RGMII_RXID)
> > +             tx_delay =3D true;
>=20
> PHY_INTERFACE_MODE_RGMII means that the delays are provided by the
> board layout, so this seems wrong to me. Please review the phylib
> documentation concerning RGMII delays. I'd like Andrew to comment on
> this too.
>=20

The idea with this was, if the PHY does not provide internal delay, then
we do it in the MAC. In Documentation/networking/phy.rst I saw this:

* PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting any
  internal delay by itself, it assumes that either the Ethernet MAC (if cap=
able)
  or the PCB traces insert the correct 1.5-2ns delay

This code was intended for the Ethernet MAC case. When this delay configura=
tion
is applied the ~2ns delay is added by the MAC. For instance, the tx_delay
case will add the delay to the txc clock configured above.

I understood the section below:

  For cases where the PHY is not capable of providing this delay, but the
  Ethernet MAC driver is capable of doing so, the correct phy_interface_t v=
alue
  should be PHY_INTERFACE_MODE_RGMII, and the Ethernet MAC driver should be
  configured correctly in order to provide the required transmit and/or rec=
eive
  side delay from the perspective of the PHY device.

to mean that the mac driver is allowed to configure these delays based
on phy_interface_t. Because the mac delays can be configured assymmetricall=
y
for rx and tx, the modes PHY_INTERFACE_MODE_RGMII_TXID and
PHY_INTERFACE_MODE_RGMII_RXID are also handled.

As Vladimir mentions, there are other drivers who configure this using

rx-internal-delay-ps
tx-internal-delay-ps

Which is also done by
drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c

However, the DLL on lan969x is different. It can configure the delay
amount with CLK_SEL. On lan9645x it is simply ~2ns, on or off, in rx or tx
direction, so accepting a delay amount seemed out of place.

But I can change this to use {rx,tx}-internal-delay-ps, and enable the
delay base on these being 0 or not, if you think this is the better
way to do it.


> > +
> > +     /* Setup DLL configuration. Register layout:
> > +      * 0:        RGMII_0_RX
> > +      * 1:        RGMII_0_TX
> > +      * 2:        RGMII_1_RX
> > +      * 3:        RGMII_1_TX
> > +      * ...
> > +      * (N<<1)    RGMII_N_RX,
> > +      * (N<<1)+1: RGMII_N_TX,
> > +      */
> > +     rx_idx =3D idx << 1;
> > +     tx_idx =3D rx_idx + 1;
>=20
> Nit: I think the shift is too clever here. It's clearly:
>=20
>         rx_idx =3D idx * 2;
>         tx_idx =3D idx * 2 + 1;
>=20

I will change this.

> > +
> > +     /* Enable DLL in RGMII clock paths, deassert DLL reset, and start=
 the
> > +      * delay tune FSM.
> > +      */
> > +     lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
> > +             HSIO_DLL_CFG_DLL_RST_SET(0) |
> > +             HSIO_DLL_CFG_DLL_ENA_SET(rx_delay) |
> > +             HSIO_DLL_CFG_DELAY_ENA_SET(rx_delay),
> > +             HSIO_DLL_CFG_DLL_CLK_ENA |
> > +             HSIO_DLL_CFG_DLL_RST |
> > +             HSIO_DLL_CFG_DLL_ENA |
> > +             HSIO_DLL_CFG_DELAY_ENA,
> > +             lan9645x, HSIO_DLL_CFG(rx_idx));
> > +
> > +     lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
> > +             HSIO_DLL_CFG_DLL_RST_SET(0) |
> > +             HSIO_DLL_CFG_DLL_ENA_SET(tx_delay) |
> > +             HSIO_DLL_CFG_DELAY_ENA_SET(tx_delay),
> > +             HSIO_DLL_CFG_DLL_CLK_ENA |
> > +             HSIO_DLL_CFG_DLL_RST |
> > +             HSIO_DLL_CFG_DLL_ENA |
> > +             HSIO_DLL_CFG_DELAY_ENA,
> > +             lan9645x, HSIO_DLL_CFG(tx_idx));
> > +
> > +     return 0;
> > +}
> > +
> > +static void lan9645x_phylink_mac_config(struct lan9645x *lan9645x, int=
 port,
> > +                                     unsigned int mode,
> > +                                     const struct phylink_link_state *=
state)
> > +{
> > +     if (phy_interface_mode_is_rgmii(state->interface))
> > +             lan9645x_rgmii_setup(lan9645x, port, state->speed,
> > +                                  state->interface);
>=20
> state->speed will always be SPEED_UNKNOWN here. Please don't use
> state->speed here, it's even documented that drivers should not access
> this member in their mac_config method().
>=20

I will change this in the next version.

> > +}
> > +
> > +static int lan9645x_phylink_mac_prepare(struct lan9645x *lan9645x, int=
 port,
> > +                                     unsigned int mode,
> > +                                     phy_interface_t iface)
> > +{
> > +     switch (port) {
> > +     case 0 ... 3:
> > +             lan_rmw(HSIO_HW_CFG_GMII_ENA_SET(BIT(port)),
> > +                     HSIO_HW_CFG_GMII_ENA_SET(BIT(port)), lan9645x,
> > +                     HSIO_HW_CFG);
> > +             break;
> > +     case 4:
> > +             lan_rmw(HSIO_HW_CFG_GMII_ENA_SET(BIT(port)),
> > +                     HSIO_HW_CFG_GMII_ENA_SET(BIT(port)), lan9645x,
> > +                     HSIO_HW_CFG);
> > +
> > +             if (phy_interface_mode_is_rgmii(iface))
> > +                     lan_rmw(HSIO_HW_CFG_RGMII_0_CFG_SET(1),
> > +                             HSIO_HW_CFG_RGMII_0_CFG,
> > +                             lan9645x, HSIO_HW_CFG);
> > +
> > +             break;
> > +     case 7 ... 8:
> > +             lan_rmw(HSIO_HW_CFG_GMII_ENA_SET(BIT(port)),
> > +                     HSIO_HW_CFG_GMII_ENA_SET(BIT(port)), lan9645x,
> > +                     HSIO_HW_CFG);
> > +             break;
> > +     default:
> > +             /* Ports 5-6 are SerDes-only and need PCS support (not ye=
t
> > +              * implemented). They are excluded from phylink_get_caps.
>=20
> ... which means phylink_create() will fail, and this function will never
> be called for those ports.
>=20
> > +              */
> > +             return -EINVAL;
> > +     }
>=20
> As each of the above cases uses the exactly the same preamble, I'm
> wondering whether something like:
>=20
>         u32 mask;
>=20
>         if (port =3D=3D 5 || port =3D=3D 6 || port > 8)
>                 return -EINVAL;
>=20
>         mask =3D HSIO_HW_CFG_GMII_ENA_SET(BIT(port));
>         lan_rmw(mask, mask, lan9645x, HSIO_HW_CFG);
>=20
>=20
>         if (port =3D=3D 4 && phy_interface_mode_is_rgmii(iface))
>                 lan_rmw(HSIO_HW_CFG_RGMII_0_CFG_SET(1),
>                         HSIO_HW_CFG_RGMII_0_CFG,
>                         lan9645x, HSIO_HW_CFG);
>=20
> would be neater.
>=20

Yes this is much simpler. With the serdes ports and qsgmii support,
the cases have a bit more variability, but I will use change this
for now.

> > +
> > +     return 0;
> > +}
> > +
> > +static int lan9645x_port_is_cuphy(struct lan9645x *lan9645x, int port,
> > +                               phy_interface_t interface)
> > +{
> > +     return port >=3D 0 && port <=3D 4 && interface =3D=3D PHY_INTERFA=
CE_MODE_GMII;
> > +}
> > +
> > +static void lan9645x_phylink_mac_link_up(struct lan9645x *lan9645x, in=
t port,
> > +                                      unsigned int link_an_mode,
> > +                                      phy_interface_t interface,
> > +                                      struct phy_device *phydev, int s=
peed,
> > +                                      int duplex, bool tx_pause,
> > +                                      bool rx_pause)
> > +{
> > +     struct lan9645x_port *p =3D lan9645x_to_port(lan9645x, port);
> > +     int rx_ifg1, rx_ifg2, tx_ifg, gtx_clk =3D 0;
> > +     struct lan9645x_path_delay *path_delay;
> > +     int gspeed =3D LAN9645X_SPEED_DISABLED;
> > +     int mode =3D 0;
> > +     int fc_spd;
> > +
> > +     /* Configure speed for RGMII modules. */
> > +     if (phy_interface_mode_is_rgmii(interface))
> > +             lan9645x_rgmii_setup(lan9645x, port, speed, interface);
>=20
> You shouldn't need to do a full setup of the RGMII state here - all
> that should be done is to adjust the transmit clock speed. I would
> prefer to see lan9645x_rgmii_setup() split into a "we're configuring
> the bulk of RGMII state" function which is called from mac_config(),
> and a "we have link up, do the minimal configuration that is dependent
> on the resulting link speed" in mac_link_up().
>=20

I will try to split up the RGMII configuration like this.

> > +
> > +     if (duplex =3D=3D DUPLEX_FULL) {
> > +             mode |=3D DEV_MAC_MODE_CFG_FDX_ENA_SET(1);
> > +             rx_ifg2 =3D DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
> > +             tx_ifg =3D DEV_MAC_IFG_CFG_TX_IFG_SET(0x5);
> > +
> > +     } else {
> > +             rx_ifg2 =3D DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
> > +             tx_ifg =3D DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
> > +     }
> > +
> > +     switch (speed) {
> > +     case SPEED_10:
> > +             rx_ifg1 =3D DEV_MAC_IFG_CFG_RX_IFG1_SET(0x2);
> > +             gspeed =3D LAN9645X_SPEED_10;
> > +             break;
> > +     case SPEED_100:
> > +             rx_ifg1 =3D DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1);
> > +             gspeed =3D LAN9645X_SPEED_100;
> > +             break;
> > +     case SPEED_1000:
> > +             gspeed =3D LAN9645X_SPEED_1000;
> > +             mode |=3D DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
> > +             mode |=3D DEV_MAC_MODE_CFG_FDX_ENA_SET(1);
> > +             rx_ifg1 =3D DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1);
> > +             rx_ifg2 =3D DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
> > +             tx_ifg =3D DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
> > +             gtx_clk =3D 1;
> > +             break;
> > +     case SPEED_2500:
> > +             gspeed =3D LAN9645X_SPEED_2500;
> > +             mode |=3D DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
> > +             mode |=3D DEV_MAC_MODE_CFG_FDX_ENA_SET(1);
> > +             rx_ifg1 =3D DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1);
> > +             rx_ifg2 =3D DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
> > +             tx_ifg =3D DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
> > +             break;
> > +     default:
> > +             dev_err(lan9645x->dev, "Unsupported speed on port %d: %d\=
n",
> > +                     p->chip_port, speed);
> > +             return;
> > +     }
> > +
> > +     p->speed =3D gspeed;
> > +     p->duplex =3D duplex;
> > +     fc_spd =3D lan9645x_speed_fc_enc(p->speed);
> > +
> > +     if (phy_interface_num_ports(interface) =3D=3D 4 ||
> > +         interface =3D=3D PHY_INTERFACE_MODE_SGMII)
> > +             mode |=3D DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
>=20
> PHY_INTERFACE_MODE_SGMII in the kernel means Cisco SGMII, and does not
> include 1000BASE-X. As SGMII/BASE-X support is incomplete, I can't tell
> whether the above is correct.
>=20

Yes this is for serdes ports, I will remove this.

> > +
> > +     lan_rmw(mode,
> > +             DEV_MAC_MODE_CFG_FDX_ENA |
> > +             DEV_MAC_MODE_CFG_GIGA_MODE_ENA,
> > +             lan9645x, DEV_MAC_MODE_CFG(p->chip_port));
> > +
> > +     lan_rmw(tx_ifg | rx_ifg1 | rx_ifg2,
>=20
> It only makes sense to use seperate variables if you're going to be
> placing them into the appropriate bitfield locations in a different
> part of the code to that which is making decisions about their values.
> However, I'm guessing that DEV_MAC_IFG_CFG_RX_IFG1_SET() et.al. are
> preparing the field values.
>=20
> So, I'd prefer to see a single variable called "mac_ifg_cfg" with
> the values for each field accumulated into that:
>=20
>         switch ... {
>         case SPEED_1000:
>                 mac_ifg_cfg =3D DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1) |
>                               DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2) |
>                               DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
>         }
>         ...
>         lan_rmw(mac_ifg_cfg,
>=20
> or separate variables with the creation of the register value at
> the use site:
>=20
>         switch ... {
>         case SPEED_1000:
>                 rx_ifg1 =3D 0x1;
>                 rx_ifg2 =3D 0x2;
>                 tx_ifg =3D 0x6;
>         }
>         ...
>         lan_rmw(DEV_MAC_IFG_CFG_RX_IFG1_SET(rx_ifg1) |
>                 DEV_MAC_IFG_CFG_RX_IFG2_SET(rx_ifg2) |
>                 DEV_MAC_IFG_CFG_TX_IFG_SET(tx_ifg),
>=20

I will update this for the next version.

> > +             DEV_MAC_IFG_CFG_TX_IFG |
> > +             DEV_MAC_IFG_CFG_RX_IFG1 |
> > +             DEV_MAC_IFG_CFG_RX_IFG2,
> > +             lan9645x, DEV_MAC_IFG_CFG(p->chip_port));
> > +
> > +     lan_rmw(DEV_MAC_HDX_CFG_SEED_SET(p->chip_port) |
> > +             DEV_MAC_HDX_CFG_SEED_LOAD_SET(1),
> > +             DEV_MAC_HDX_CFG_SEED |
> > +             DEV_MAC_HDX_CFG_SEED_LOAD, lan9645x,
> > +             DEV_MAC_HDX_CFG(p->chip_port));
> > +
> > +     if (lan9645x_port_is_cuphy(lan9645x, port, interface)) {
> > +             lan_rmw(CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA_SET(gtx_clk),
> > +                     CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA, lan9645x,
> > +                     CHIP_TOP_CUPHY_PORT_CFG(p->chip_port));
> > +     }
> > +
> > +     lan_rmw(DEV_MAC_HDX_CFG_SEED_LOAD_SET(0),
> > +             DEV_MAC_HDX_CFG_SEED_LOAD, lan9645x,
> > +             DEV_MAC_HDX_CFG(p->chip_port));
> > +
> > +     /* Set PFC link speed and enable map */
> > +     lan_rmw(ANA_PFC_CFG_FC_LINK_SPEED_SET(fc_spd) |
> > +             ANA_PFC_CFG_RX_PFC_ENA_SET(0),
> > +             ANA_PFC_CFG_FC_LINK_SPEED |
> > +             ANA_PFC_CFG_RX_PFC_ENA,
> > +             lan9645x, ANA_PFC_CFG(p->chip_port));
> > +
> > +     lan_rmw(DEV_PCS1G_CFG_PCS_ENA_SET(1),
> > +             DEV_PCS1G_CFG_PCS_ENA, lan9645x,
> > +             DEV_PCS1G_CFG(p->chip_port));
> > +
> > +     lan_rmw(DEV_PCS1G_SD_CFG_SD_ENA_SET(0),
> > +             DEV_PCS1G_SD_CFG_SD_ENA,
> > +             lan9645x, DEV_PCS1G_SD_CFG(p->chip_port));
> > +
> > +     lan_rmw(SYS_PAUSE_CFG_PAUSE_ENA_SET(1),
> > +             SYS_PAUSE_CFG_PAUSE_ENA,
> > +             lan9645x, SYS_PAUSE_CFG(p->chip_port));
> > +
> > +     /* Set SMAC of Pause frame (00:00:00:00:00:00) */
> > +     lan_wr(0, lan9645x, DEV_FC_MAC_LOW_CFG(p->chip_port));
> > +     lan_wr(0, lan9645x, DEV_FC_MAC_HIGH_CFG(p->chip_port));
> > +
> > +     /* Flow control */
> > +     lan_rmw(SYS_MAC_FC_CFG_FC_LINK_SPEED_SET(fc_spd) |
> > +             SYS_MAC_FC_CFG_FC_LATENCY_CFG_SET(0x7) |
> > +             SYS_MAC_FC_CFG_ZERO_PAUSE_ENA_SET(1) |
> > +             SYS_MAC_FC_CFG_PAUSE_VAL_CFG_SET(0xffff) |
> > +             SYS_MAC_FC_CFG_RX_FC_ENA_SET(rx_pause ? 1 : 0) |
> > +             SYS_MAC_FC_CFG_TX_FC_ENA_SET(tx_pause ? 1 : 0),
> > +             SYS_MAC_FC_CFG_FC_LINK_SPEED |
> > +             SYS_MAC_FC_CFG_FC_LATENCY_CFG |
> > +             SYS_MAC_FC_CFG_ZERO_PAUSE_ENA |
> > +             SYS_MAC_FC_CFG_PAUSE_VAL_CFG |
> > +             SYS_MAC_FC_CFG_RX_FC_ENA |
> > +             SYS_MAC_FC_CFG_TX_FC_ENA,
> > +             lan9645x, SYS_MAC_FC_CFG(p->chip_port));
> > +
> > +     list_for_each_entry(path_delay, &p->path_delays, list) {
> > +             if (path_delay->speed =3D=3D speed) {
> > +                     lan_wr(path_delay->rx_delay + p->rx_delay,
> > +                            lan9645x, SYS_PTP_RXDLY_CFG(p->chip_port))=
;
> > +                     lan_wr(path_delay->tx_delay,
> > +                            lan9645x, SYS_PTP_TXDLY_CFG(p->chip_port))=
;
> > +             }
> > +     }
> > +
> > +     /* Enable MAC module */
> > +     lan_wr(DEV_MAC_ENA_CFG_RX_ENA_SET(1) |
> > +            DEV_MAC_ENA_CFG_TX_ENA_SET(1),
> > +            lan9645x, DEV_MAC_ENA_CFG(p->chip_port));
> > +
> > +     /* port _must_ be taken out of reset before MAC. */
> > +     lan_rmw(DEV_CLOCK_CFG_PORT_RST_SET(0),
> > +             DEV_CLOCK_CFG_PORT_RST,
> > +             lan9645x, DEV_CLOCK_CFG(p->chip_port));
> > +
> > +     /* Take out the clock from reset. Note this write will set all th=
ese
> > +      * fields to zero:
> > +      *
> > +      * DEV_CLOCK_CFG[*].MAC_TX_RST
> > +      * DEV_CLOCK_CFG[*].MAC_RX_RST
> > +      * DEV_CLOCK_CFG[*].PCS_TX_RST
> > +      * DEV_CLOCK_CFG[*].PCS_RX_RST
> > +      * DEV_CLOCK_CFG[*].PORT_RST
> > +      * DEV_CLOCK_CFG[*].PHY_RST
> > +      *
> > +      * Note link_down will assert PORT_RST, MAC_RX_RST and MAC_TX_RST=
, so
> > +      * we are effectively taking the mac tx/rx clocks out of reset.
> > +      *
> > +      * This linkspeed field has a slightly different encoding from ot=
hers:
> > +      *
> > +      * - 0 is no-link
> > +      * - 1 is both 2500/1000
> > +      * - 2 is 100mbit
> > +      * - 3 is 10mbit
> > +      *
> > +      */
> > +     lan_wr(DEV_CLOCK_CFG_LINK_SPEED_SET(fc_spd =3D=3D 0 ? 1 : fc_spd)=
,
> > +            lan9645x,
> > +            DEV_CLOCK_CFG(p->chip_port));
> > +
> > +     /* Core: Enable port for frame transfer */
> > +     lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(1) |
> > +             QSYS_SW_PORT_MODE_SCH_NEXT_CFG_SET(1) |
> > +             QSYS_SW_PORT_MODE_INGRESS_DROP_MODE_SET(1) |
> > +             QSYS_SW_PORT_MODE_TX_PFC_ENA_SET(0),
> > +             QSYS_SW_PORT_MODE_PORT_ENA |
> > +             QSYS_SW_PORT_MODE_SCH_NEXT_CFG |
> > +             QSYS_SW_PORT_MODE_INGRESS_DROP_MODE |
> > +             QSYS_SW_PORT_MODE_TX_PFC_ENA,
> > +             lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
> > +
> > +     lan_rmw(AFI_PORT_CFG_FC_SKIP_TTI_INJ_SET(0) |
> > +             AFI_PORT_CFG_FRM_OUT_MAX_SET(16),
> > +             AFI_PORT_CFG_FC_SKIP_TTI_INJ |
> > +             AFI_PORT_CFG_FRM_OUT_MAX,
> > +             lan9645x, AFI_PORT_CFG(p->chip_port));
>=20
> This looks overly complicated for link-up events. Please look to see
> how much of this can be moved to the mac_prepare, mac_config and
> mac_finish methods, which are supposed to be doing the bulk of
> configuring the port for operating in the specified PHY interface mode.
>=20
> mac_link_up is only supposed to configure for the negotiated parameters
> such as speed, duplex, and pause and enable transmission/reception.
>=20
> Conversely, mac_link_down should just stop the transmission/reception
> of packets.
>=20
> The PCS state fiddling concerns me greatly (although I do appreciate
> you don't have that implemented fully yet) but given its presence in
> mac_link_up, I think this will cause you future problems, especially
> with inband support - the PCS link needs to remain active so it can
> participate in negotiation, thereby allowing this method to be called.
>=20
> You also don't want to be resetting the PCS on the mac_link_down()
> method for the same reason.
>=20

I agree it is complicated. This is taken from the sequence in lan966x.
Back then it took some effort, and help from design, to get it right.
So I did not have the courage to change it, but I will try to
rearrange this to be more in the spirit of phylink.

> > +}
> > +
> > +void lan9645x_phylink_port_down(struct lan9645x *lan9645x, int port)
> > +{
> > +     struct lan9645x_port *p =3D lan9645x_to_port(lan9645x, port);
> > +     u32 val;
> > +
> > +     /* 0.5: Disable any AFI */
> > +     lan_rmw(AFI_PORT_CFG_FC_SKIP_TTI_INJ_SET(1) |
> > +             AFI_PORT_CFG_FRM_OUT_MAX_SET(0),
> > +             AFI_PORT_CFG_FC_SKIP_TTI_INJ |
> > +             AFI_PORT_CFG_FRM_OUT_MAX,
> > +             lan9645x, AFI_PORT_CFG(p->chip_port));
> > +
> > +     /* wait for reg afi_port_frm_out to become 0 for the port */
> > +     if (lan9645x_rd_poll_slow(lan9645x, AFI_PORT_FRM_OUT(p->chip_port=
),
> > +                               val,
> > +                               !AFI_PORT_FRM_OUT_FRM_OUT_CNT_GET(val))=
)
> > +             dev_err(lan9645x->dev, "AFI timeout chip port %u",
> > +                     p->chip_port);
> > +
> > +     /* 2: Disable MAC frame reception */
> > +     lan_rmw(DEV_MAC_ENA_CFG_RX_ENA_SET(0),
> > +             DEV_MAC_ENA_CFG_RX_ENA,
> > +             lan9645x, DEV_MAC_ENA_CFG(p->chip_port));
> > +
> > +     /* 1: Reset the PCS Rx clock domain  */
> > +     lan_rmw(DEV_CLOCK_CFG_PCS_RX_RST_SET(1),
> > +             DEV_CLOCK_CFG_PCS_RX_RST,
> > +             lan9645x, DEV_CLOCK_CFG(p->chip_port));
> > +
> > +     p->speed =3D LAN9645X_SPEED_DISABLED;
> > +     p->duplex =3D DUPLEX_UNKNOWN;
> > +
> > +     /* 3: Disable traffic being sent to or from switch port */
> > +     lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(0),
> > +             QSYS_SW_PORT_MODE_PORT_ENA,
> > +             lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
> > +
> > +     /* 4: Disable dequeuing from the egress queues  */
> > +     lan_rmw(QSYS_PORT_MODE_DEQUEUE_DIS_SET(1),
> > +             QSYS_PORT_MODE_DEQUEUE_DIS,
> > +             lan9645x, QSYS_PORT_MODE(p->chip_port));
> > +
> > +     /* 5: Disable Flowcontrol */
> > +     lan_rmw(SYS_PAUSE_CFG_PAUSE_ENA_SET(0),
> > +             SYS_PAUSE_CFG_PAUSE_ENA,
> > +             lan9645x, SYS_PAUSE_CFG(p->chip_port));
> > +
> > +     /* 5.1: Disable PFC */
> > +     lan_rmw(QSYS_SW_PORT_MODE_TX_PFC_ENA_SET(0),
> > +             QSYS_SW_PORT_MODE_TX_PFC_ENA,
> > +             lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
> > +
> > +     /* 6: Wait a worst case time 8ms (10K jumbo/10Mbit) */
> > +     usleep_range(8 * USEC_PER_MSEC, 9 * USEC_PER_MSEC);
> > +
> > +     /* 7: Disable HDX backpressure. */
> > +     lan_rmw(SYS_FRONT_PORT_MODE_HDX_MODE_SET(0),
> > +             SYS_FRONT_PORT_MODE_HDX_MODE,
> > +             lan9645x, SYS_FRONT_PORT_MODE(p->chip_port));
> > +
> > +     /* 8: Flush the queues associated with the port */
> > +     lan_rmw(QSYS_SW_PORT_MODE_AGING_MODE_SET(3),
> > +             QSYS_SW_PORT_MODE_AGING_MODE,
> > +             lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
> > +
> > +     /* 9: Enable dequeuing from the egress queues */
> > +     lan_rmw(QSYS_PORT_MODE_DEQUEUE_DIS_SET(0),
> > +             QSYS_PORT_MODE_DEQUEUE_DIS,
> > +             lan9645x, QSYS_PORT_MODE(p->chip_port));
> > +
> > +     /* 10: Wait until flushing is complete */
> > +     if (lan9645x_rd_poll_slow(lan9645x, QSYS_SW_STATUS(p->chip_port),
> > +                               val, !QSYS_SW_STATUS_EQ_AVAIL_GET(val))=
)
> > +             dev_err(lan9645x->dev, "Flush timeout chip port %u", port=
);
> > +
> > +     /* 11: Disable MAC tx */
> > +     lan_rmw(DEV_MAC_ENA_CFG_TX_ENA_SET(0),
> > +             DEV_MAC_ENA_CFG_TX_ENA,
> > +             lan9645x, DEV_MAC_ENA_CFG(p->chip_port));
> > +
> > +     /* 12: Reset the Port and MAC clock domains */
> > +     lan_rmw(DEV_CLOCK_CFG_PORT_RST_SET(1),
> > +             DEV_CLOCK_CFG_PORT_RST,
> > +             lan9645x, DEV_CLOCK_CFG(p->chip_port));
> > +
> > +     /* Wait before resetting MAC clock domains. */
> > +     usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
> > +
> > +     lan_rmw(DEV_CLOCK_CFG_MAC_TX_RST_SET(1) |
> > +             DEV_CLOCK_CFG_MAC_RX_RST_SET(1) |
> > +             DEV_CLOCK_CFG_PORT_RST_SET(1),
> > +             DEV_CLOCK_CFG_MAC_TX_RST |
> > +             DEV_CLOCK_CFG_MAC_RX_RST |
> > +             DEV_CLOCK_CFG_PORT_RST,
> > +             lan9645x, DEV_CLOCK_CFG(p->chip_port));
> > +
> > +     /* 13: Clear flushing */
> > +     lan_rmw(QSYS_SW_PORT_MODE_AGING_MODE_SET(1),
> > +             QSYS_SW_PORT_MODE_AGING_MODE,
> > +             lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
> > +}
> > +
> > +static void lan9645x_phylink_mac_link_down(struct lan9645x *lan9645x, =
int port,
> > +                                        unsigned int link_an_mode,
> > +                                        phy_interface_t interface)
> > +{
> > +     struct lan9645x_port *p =3D lan9645x_to_port(lan9645x, port);
> > +
> > +     lan9645x_phylink_port_down(lan9645x, port);
> > +
> > +     /* 14: Take PCS out of reset */
> > +     lan_rmw(DEV_CLOCK_CFG_PCS_RX_RST_SET(0) |
> > +             DEV_CLOCK_CFG_PCS_TX_RST_SET(0),
> > +             DEV_CLOCK_CFG_PCS_RX_RST |
> > +             DEV_CLOCK_CFG_PCS_TX_RST,
> > +             lan9645x, DEV_CLOCK_CFG(p->chip_port));
> > +}
> > +
> > +static struct lan9645x_port *
> > +lan9645x_phylink_config_to_port(struct phylink_config *config)
> > +{
> > +     struct dsa_port *dp =3D dsa_phylink_to_port(config);
> > +
> > +     return lan9645x_to_port(dp->ds->priv, dp->index);
> > +}
> > +
> > +static void
> > +lan9645x_port_phylink_mac_config(struct phylink_config *config,
> > +                              unsigned int mode,
> > +                              const struct phylink_link_state *state)
> > +{
> > +     struct lan9645x_port *p =3D lan9645x_phylink_config_to_port(confi=
g);
> > +
> > +     lan9645x_phylink_mac_config(p->lan9645x, p->chip_port, mode, stat=
e);
> > +}
> > +
> > +static void lan9645x_port_phylink_mac_link_up(struct phylink_config *c=
onfig,
> > +                                           struct phy_device *phydev,
> > +                                           unsigned int link_an_mode,
> > +                                           phy_interface_t interface,
> > +                                           int speed, int duplex,
> > +                                           bool tx_pause, bool rx_paus=
e)
> > +{
> > +     struct lan9645x_port *p =3D lan9645x_phylink_config_to_port(confi=
g);
> > +
> > +     lan9645x_phylink_mac_link_up(p->lan9645x, p->chip_port, link_an_m=
ode,
> > +                                  interface, phydev, speed, duplex, tx=
_pause,
> > +                                  rx_pause);
> > +}
> > +
> > +static void lan9645x_port_phylink_mac_link_down(struct phylink_config =
*config,
> > +                                             unsigned int link_an_mode=
,
> > +                                             phy_interface_t interface=
)
> > +{
> > +     struct lan9645x_port *p =3D lan9645x_phylink_config_to_port(confi=
g);
> > +
> > +     lan9645x_phylink_mac_link_down(p->lan9645x, p->chip_port, link_an=
_mode,
> > +                                    interface);
> > +}
> > +
> > +static int lan9645x_port_phylink_mac_prepare(struct phylink_config *co=
nfig,
> > +                                          unsigned int mode,
> > +                                          phy_interface_t iface)
> > +{
> > +     struct lan9645x_port *p =3D lan9645x_phylink_config_to_port(confi=
g);
> > +
> > +     return lan9645x_phylink_mac_prepare(p->lan9645x, p->chip_port, mo=
de,
> > +                                         iface);
> > +}
> > +
> > +const struct phylink_mac_ops lan9645x_phylink_mac_ops =3D {
> > +     .mac_config                     =3D lan9645x_port_phylink_mac_con=
fig,
> > +     .mac_link_up                    =3D lan9645x_port_phylink_mac_lin=
k_up,
> > +     .mac_link_down                  =3D lan9645x_port_phylink_mac_lin=
k_down,
> > +     .mac_prepare                    =3D lan9645x_port_phylink_mac_pre=
pare,
>=20
> Please order the functions, and the initialisers here in the same order
> that they appear in struct phylink_mac_ops, which is:
>=20
>         mac_prepare (this will be called first)
>         mac_config (this will be called second)
>=20
>         mac_link_down
>         mac_link_up (this will be called last when bringing up the link)
>=20
> The configuration functions (prepare, config, finish) are specifically
> arranged in the order that they are called which helps make the code
> more readable - and if you arrange the functions in the file in the
> same order, then when one reads through the code, one reads the code in
> the order it will be executed.
>=20
> What you have is a bit like a book where the preface is oddly located
> after the main body of the text!
>=20

Thank you, I will shuffle this around.

> > +};
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_port.c
> > new file mode 100644
> > index 000000000000..038868ae0a32
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> > @@ -0,0 +1,289 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (C) 2026 Microchip Technology Inc.
> > + */
> > +
> > +#include "lan9645x_main.h"
> > +
> > +int lan9645x_port_init(struct lan9645x *lan9645x, int port)
> > +{
> > +     struct lan9645x_port *p;
> > +
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +
> > +     /* Disable learning on port */
> > +     lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(0),
> > +             ANA_PORT_CFG_LEARN_ENA,
> > +             lan9645x, ANA_PORT_CFG(p->chip_port));
> > +
> > +     lan9645x_port_set_maxlen(lan9645x, port, ETH_DATA_LEN);
> > +
> > +     lan9645x_phylink_port_down(lan9645x, port);
> > +
> > +     if (phy_interface_num_ports(p->phy_mode) =3D=3D 4)
> > +             lan_rmw(DEV_CLOCK_CFG_PCS_RX_RST_SET(0) |
> > +                     DEV_CLOCK_CFG_PCS_TX_RST_SET(0),
> > +                     DEV_CLOCK_CFG_PCS_RX_RST |
> > +                     DEV_CLOCK_CFG_PCS_TX_RST,
> > +                     lan9645x, DEV_CLOCK_CFG(p->chip_port));
>=20
> Two things I don't like here:
>=20
> 1. the use of phy_mode rather than working out another way to handle
>    this.
>=20
> 2. I think the above is just a complex way of saying
>         if (p->phy_mode =3D=3D PHY_INTERFACE_MODE_QSGMII)
>=20
>    since you don't support QUSGMII or 10G_QXGMII.
>=20
> Thanks.
>=20

Indeed, that is for QSGMII. I will remove it now, and use=C2=A0
PHY_INTERFACE_MODE_QSGMII directly when the serdes ports are implemented.

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thank you for the comments,
Emil


