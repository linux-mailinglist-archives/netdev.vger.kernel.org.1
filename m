Return-Path: <netdev+bounces-274070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNfBLMQIzWl/ZgYAu9opvQ
	(envelope-from <netdev+bounces-274070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:00:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCD637A04B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A475D315E23F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4B3FBEB2;
	Wed,  1 Apr 2026 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lJm91keW"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F63F99FE;
	Wed,  1 Apr 2026 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775043996; cv=none; b=ixGLLjeWDEbB/qzkmIXBXQ7G1vEbWpQkyuNpmdM0EJ+nArFfw2LuhCaVAaJB75MPVG57ti8XEKw2BKHRPGJ5Cu3pU4WfB3e1nwEND4dqu8Bax4t4Ro3ivePFwR00Dfa8qO9IN7VwMjSHg8bRrfKShiNpl1M3OEWo8jmzvKgEat4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775043996; c=relaxed/simple;
	bh=J0tXdtjtJPWdv5fayQmXySE8O9F6f5dWFGFHgxV0VVk=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i9kb+ouQABTWeN/WH4/FxWJcocnJoNy6z2Kz10ezcfDJe25QnwFBn6bnQE/4oefg+youXM1wqZBsKOZKkwiD0K7p+FMkxFFprC13fhsFfFSOtEIdBbnV3gY1O8Zq4nokjv0SGufHGRwowDmX9YihnxRcDV64ZRWnJS9aQOkJWco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lJm91keW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775043993; x=1806579993;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=J0tXdtjtJPWdv5fayQmXySE8O9F6f5dWFGFHgxV0VVk=;
  b=lJm91keWWXo4zP+TpxDiZaxynAqJouTCKxvLrhiEfNpB0m5Tyc4UbVXq
   prMg5aAb1tc0Vy7SWxXOVglMlujaBfGbv0ZNXg6R3qPZllphWW/9pXnqx
   SlisIwWXxS5P2yKECEZyByrTm8bEPLo1CsIxJLTVpuGibKNg7dyCUBuj1
   7ZQb93eaaV2BDk0tWQIZCVlQEVjbLho2i6GgEhZKdtGBIKkJ4cKbpWHyd
   CZc6OozkrWlwhoGC3Qf4l9CqkzXNxRI2sLXd0BkNFCVvKyKez2q9CuTIx
   6ZHORplY8x1Hffeo9o1GMcpO3mHSCsQM/5iu+kLtvLG0IXtsglidqTZfc
   w==;
X-CSE-ConnectionGUID: adCyKUvVQWe/kWMNmwYgWw==
X-CSE-MsgGUID: aVyuZm3iSH6jVrRmYxda1w==
X-IronPort-AV: E=Sophos;i="6.23,153,1770620400"; 
   d="scan'208";a="55527396"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 04:46:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 1 Apr 2026 04:46:23 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 1 Apr 2026 04:46:20 -0700
Message-ID: <c1b824a3e597b37df133053f6b216e9196b130d5.camel@microchip.com>
Subject: Re: [PATCH net-next v2 4/9] net: dsa: lan9645x: add basic dsa
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
Date: Wed, 1 Apr 2026 13:46:19 +0200
In-Reply-To: <20260329195629.2789129-1-kuba@kernel.org>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-4-f7504e3b0681@microchip.com>
	 <20260329195629.2789129-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274070-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Queue-Id: 0FCD637A04B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-03-29 at 12:56 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Subject: net: dsa: lan9645x: add basic dsa driver for LAN9645X
>=20
> This commit adds a basic DSA driver for the Microchip LAN9645X switch. It
> includes initialization, port module setup for NPI, CPU, and front ports,
> and phylink integration for MAC side configuration.
>=20
> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c b/drivers/=
net/dsa/microchip/lan9645x/lan9645x_npi.c
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
> [ ... ]
> > +static void disable_conduit_ipv6(struct lan9645x *lan9645x,
> > +                              struct net_device *conduit)
> > +{
> > +     struct inet6_dev *dev_v6;
> > +
> > +     if (!conduit)
> > +             return;
> > +
> > +     /* IPv6 on the conduit will generate frames bypassing our tag dri=
ver, so
> > +      * they lack an IFH. This will be garbage in garbage out and we w=
ant to
> > +      * avoid this.
> > +      */
> > +     rtnl_lock();
> > +     dev_v6 =3D __in6_dev_get(conduit);
> > +     if (dev_v6) {
> > +             WRITE_ONCE(dev_v6->cnf.disable_ipv6, 1);
> > +             dev_warn(lan9645x->dev, "Disabled IPv6 on conduit device:=
 %s\n",
> > +                      netdev_name(conduit));
> > +     }
> > +     rtnl_lock();
> > +}
>=20
> Does directly modifying dev_v6->cnf.disable_ipv6 bypass the proper sysctl
> teardown path (addrconf_disable_ipv6) and leave the IPv6 stack in an
> inconsistent state on the conduit device by failing to clean up routes,
> addresses, and MLD memberships?
>=20
> Is it a layering violation for a switch driver to alter the networking
> configuration of an external upper device, especially since this change
> isn't reverted during driver unbind?
>=20


Yes this will bypass the sysctl teardown path. I can change this to instead
read disable_ipv6 state and warn the user that their device is misconfigure=
d.

> [ ... ]
> > +void lan9645x_npi_port_init(struct lan9645x *lan9645x,
> > +                         struct dsa_port *cpu_port)
> > +{
> > +     int port =3D cpu_port->index;
> > +     struct lan9645x_port *p;
> > +
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +     lan9645x->npi =3D port;
>=20
> In a cascaded multi-switch DSA topology, cpu_port->index may belong to a
> different switch and be greater than 8. If lan9645x_to_port returns NULL,
> will this cause a panic when dereferencing p->chip_port below?
>=20
> [ ... ]
> > +     /* Configure IFH prefix mode for NPI port. */
> > +     lan_rmw(SYS_PORT_MODE_INCL_XTR_HDR_SET(LAN9645X_TAG_PREFIX_LONG) =
|
> > +             SYS_PORT_MODE_INCL_INJ_HDR_SET(LAN9645X_TAG_PREFIX_NONE),
> > +             SYS_PORT_MODE_INCL_XTR_HDR |
> > +             SYS_PORT_MODE_INCL_INJ_HDR,
> > +             lan9645x,
> > +             SYS_PORT_MODE(p->chip_port));
>=20
> Setting LAN9645X_TAG_PREFIX_NONE means the hardware interprets the first
> bytes of any frame received from the host as an IFH command structure.
>=20
> Does this allow a local user to transmit crafted frames (for example, via
> raw sockets or standard protocols) whose MAC address bytes map to malicio=
us
> IFH commands, thereby bypassing VLAN isolation or flooding the switch?
>=20
> Should the hardware be configured to require a strict prefix, such as
> LAN9645X_TAG_PREFIX_LONG, for injected frames to prevent this?
>=20

A prefix offers no protection against the described scenario. The current
configuration is correct. If a prefix is configured frames MUST contain the
prefix. With the conduit exposed in userspace this is not something we can
guarantee.


> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers=
/net/dsa/microchip/lan9645x/lan9645x_main.c
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> [ ... ]
> > +static int lan9645x_setup(struct dsa_switch *ds)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct device *dev =3D lan9645x->dev;
> > +     u32 all_phys_ports;
> > +     int err;
> > +
> > +     lan9645x->num_phys_ports =3D ds->num_ports;
> > +     all_phys_ports =3D GENMASK(lan9645x->num_phys_ports - 1, 0);
> > +
> > +     err =3D lan9645x_reset_switch(lan9645x);
> > +     if (err)
> > +             return err;
> > +
> > +     lan9645x->ports =3D devm_kcalloc(lan9645x->dev, lan9645x->num_phy=
s_ports,
> > +                                    sizeof(struct lan9645x_port *),
> > +                                    GFP_KERNEL);
>=20
> Since the DSA .setup callback can be invoked multiple times during the
> platform device's lifetime (for example, when the DSA master interface is
> unbound and bound again), does using devm_kcalloc here cause a memory lea=
k?
> Should these allocations be moved to .probe or managed with kcalloc and
> freed in .teardown?
>=20

Hmm I do not think this is right? I think dsa_tree_teardown is called from
dsa_switch_remove which is called by the switch drivers .remove.

So I do not think you can get multiple setup/teardown cycles during the dev=
ice
lifetime?

As far as I can tell both felix and ksz use device managed allocations in t=
heir
setup callback.

> [ ... ]
> > +     /* Set all the entries to obey VLAN. */
> > +     for (int i =3D 0; i < PGID_ENTRIES; ++i)
> > +             lan_wr(ANA_PGID_CFG_OBEY_VLAN_SET(1),
> > +                    lan9645x, ANA_PGID_CFG(i));
>=20
> PGID_ENTRIES is defined as 89, so this loop initializes indices 0 through
> 88. Since the CPU port is index 9, its source PGID is PGID_SRC + CPU_PORT
> (80 + 9 =3D 89).
>=20
> Is index 89 left uninitialized, breaking the OBEY_VLAN rule and allowing
> CPU-injected frames to leak across VLAN boundaries?
>=20

No I this misunderstands OBEY_VLAN. When set the vlan table can control
whether cpu copy from the pgid table is enabled. It makes no sense for PGID=
 89.

> [ ... ]
> > +     /* Multicast to all front ports */
> > +     lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MC));
> > +
> > +     /* IP multicast to all front ports */
> > +     lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MCIPV4));
> > +     lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MCIPV6));
> > +
> > +     /* Unicast to all front ports */
> > +     lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_UC));
> > +
> > +     /* Broadcast to all ports */
> > +     lan_wr(BIT(CPU_PORT) | all_phys_ports, lan9645x, ANA_PGID(PGID_BC=
));
>=20
> PGID_BC includes BIT(CPU_PORT) and all_phys_ports (which includes the NPI
> port). Will this forward broadcast frames to both the CPU extraction queu=
e
> and the NPI port's normal egress queue, causing duplicate frames for the =
host?
>=20
> Conversely, the multicast masks and PGID_UC exclude BIT(CPU_PORT). Does
> this cause them to bypass the CPU extraction queue entirely, thereby
> lacking the LONG extraction prefix and breaking the host's DSA tagger par=
sing?
>=20

No this is not how it works. Generally when you configure the CPU port to u=
se
an NPI port, the hardware manages this internally. You do you have to start
using the npi port number all of a sudden.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c b/driv=
ers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> [ ... ]
> > +static int lan9645x_phylink_mac_prepare(struct phylink_config *config,
> > +                                     unsigned int mode,
> > +                                     phy_interface_t iface)
> > +{
> > +     struct lan9645x_port *p =3D lan9645x_phylink_config_to_port(confi=
g);
> > +     struct lan9645x *lan9645x =3D p->lan9645x;
> > +     int port =3D p->chip_port;
> > +     u32 mask;
> > +
> > +     if (port =3D=3D 5 || port =3D=3D 6 || port > 8)
> > +             return -EINVAL;
> > +
> > +     mask =3D HSIO_HW_CFG_GMII_ENA_SET(BIT(port));
> > +     lan_rmw(mask, mask, lan9645x, HSIO_HW_CFG);
> > +
> > +     if (port =3D=3D 4 && phy_interface_mode_is_rgmii(iface))
> > +             lan_rmw(HSIO_HW_CFG_RGMII_0_CFG_SET(1),
> > +                     HSIO_HW_CFG_RGMII_0_CFG,
> > +                     lan9645x, HSIO_HW_CFG);
>=20
> The lan9645x_phylink_get_caps function advertises RGMII support for ports
> 4, 7, and 8. Does restricting the hardware multiplexer configuration here=
 to
> port 4 break connectivity for ports 7 and 8 when used in RGMII mode?
>=20

Yes. The multiplexing controls which port module RGMII0 should use. It is e=
ither port 4 or
port 7. So you can not use RGMII on both port 4 and 7 at the same time.
In theory you could use port 8, but the intended use for this is when QSGMI=
I is enabled. This
will always use port modules 5-8. The multiplexing makes it possible to sti=
ll use
1 RGMII port in this case.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers=
/net/dsa/microchip/lan9645x/lan9645x_port.c
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> [ ... ]
> > +int lan9645x_port_set_maxlen(struct lan9645x *lan9645x, int port, size=
_t sdu)
> > +{
> > +     struct lan9645x_port *p =3D lan9645x_to_port(lan9645x, port);
> > +     int maxlen =3D sdu + ETH_HLEN + ETH_FCS_LEN;
>=20
> Does this maximum frame length calculation drop standard 1500-byte MTU
> frames that are 802.1Q VLAN tagged (1522 bytes total), since it does not
> account for VLAN_HLEN?
>=20

I was about to say that the VLAN overhead is managed seperately via the DEV=
_MAC_TAGS_CFG
register.

However, after testing I see there is a bug here. We only configure=C2=A0DE=
V_MAC_TAGS_CFG
for vlan aware ports. This is a problem in the vlan unaware case.
Furthermore, the NPI port does not get this configuration. I will move the=
=20
DEV_MAC_TAGS_CFG configuration to port_setup, so we always allow 2x VLAN ta=
gs overhead
in both vlan aware and unaware mode, and towards the CPU.

> [ ... ]
> > +int lan9645x_port_setup(struct dsa_switch *ds, int port)
> > +{
> > +     struct dsa_port *dp =3D dsa_to_port(ds, port);
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct lan9645x_port *p;
> > +
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +
> > +     if (dp->dn) {
> > +             p->rx_internal_delay =3D
> > +                     of_property_present(dp->dn, "rx-internal-delay-ps=
");
> > +             p->tx_internal_delay =3D
> > +                     of_property_present(dp->dn, "tx-internal-delay-ps=
");
> > +     }
>=20
> These are standard integer properties specifying delays in picoseconds. I=
f
> a user explicitly disables the delay via devicetree using a value of 0,
> will of_property_present evaluate to true and enable the hardware delay
> anyway? Should of_property_read_u32 be used instead to check the value?

A value of 0 is not allowed per the bindings. The bindings enforce that if =
this
is present the value must be 2000.


