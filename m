Return-Path: <netdev+bounces-276573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H+AKNFs1mkQFQgAu9opvQ
	(envelope-from <netdev+bounces-276573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:57:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D1A3BDE81
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B422D3011F27
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038B73D3D03;
	Wed,  8 Apr 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wa8GA1tN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12335F615;
	Wed,  8 Apr 2026 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660238; cv=none; b=NpagxgMl/eA56OP3b4jgygj31gWjGHJ1Br9L+DTWo3sSY855YE+Piu5PQWFRzNlURjHZRKAdzcqNUg91YuCdvl4Y9oEaEqBpbuHvZFt2h4jfcja67O7FFwpxt3VmtNJmxwi9r3UkbrtpO22GafTByon/UXc36gzAKqNfeXAoakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660238; c=relaxed/simple;
	bh=yGyYG3kYnwvnmoKOqCcE/jreYBBuJDrnP3z1enhlA3U=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MDrFGyBXnPvpGR9CT+6NbbOU6whIOgxa2SAZV8ksjR/IrD7dF28yxlduF90ZLD8TIcxzBrXdV+Qt7D5ynFIVdZA1r2dbIoJZHIHjAw7vDOewTTJNI4cHxPnpARIbS8znneMAwunDwTZTwZShIJymtGrophmI1Ghs2BVjj8D/FoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wa8GA1tN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775660237; x=1807196237;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yGyYG3kYnwvnmoKOqCcE/jreYBBuJDrnP3z1enhlA3U=;
  b=Wa8GA1tNqGB5ABiNd67cbwM+vfOHSmLUvOQaWp9UGJOTEk0KRAtnqH7z
   4FHicCTvDaVMbujUsPQd/gjzZlq9/JL6Udo5e/WpBExRoafk0r9ce44n8
   ROS0GVxzQOaz9pfjTrIp3wLT95A4k9r4CgTbBaMS19ECJMSQj9rJ3Tzfw
   a2kNzfJfaVyGHHLRx4XmGeTrOXykGMI//b7BuMAiaVsd+V5WA3U+7OHEt
   s07Al/u/guFwWG1bxfYunEQMq206o8W7opaN6LBYVvY+xG8GudnQZIVSh
   H6GieLUPGG8xMlqflqJNMobj5UN0Pscg0CdKa2bemRWG/ntJL29TLxTeA
   A==;
X-CSE-ConnectionGUID: gQGTKAFDQTK6Jv4TFw4tMQ==
X-CSE-MsgGUID: 5DhuSRy2RJavtfmLCXKB2w==
X-IronPort-AV: E=Sophos;i="6.23,167,1770620400"; 
   d="scan'208";a="223089188"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2026 07:57:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 8 Apr 2026 07:57:08 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 8 Apr 2026 07:57:05 -0700
Message-ID: <d511e0fdee36b6b1088be9b214f545fcca14f87f.camel@microchip.com>
Subject: Re: [PATCH net-next v2 4/9] net: dsa: lan9645x: add basic dsa
 driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <woojung.huh@microchip.com>,
	<linux@armlinux.org.uk>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Wed, 8 Apr 2026 16:57:05 +0200
In-Reply-To: <20260407091217.rrwzho3lcmfip3y5@skbuf>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-4-f7504e3b0681@microchip.com>
	 <20260329195629.2789129-1-kuba@kernel.org>
	 <c1b824a3e597b37df133053f6b216e9196b130d5.camel@microchip.com>
	 <20260407091217.rrwzho3lcmfip3y5@skbuf>
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
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276573-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04D1A3BDE81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-07 at 12:12 +0300, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Wed, Apr 01, 2026 at 01:46:19PM +0200, Jens Emil Schulz Ostergaard wro=
te:
> > On Sun, 2026-03-29 at 12:56 -0700, Jakub Kicinski wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> > >=20
> > > This is an AI-generated review of your patch. The human sending this
> > > email has considered the AI review valid, or at least plausible.
> > > ---
> > > Subject: net: dsa: lan9645x: add basic dsa driver for LAN9645X
> > >=20
> > > This commit adds a basic DSA driver for the Microchip LAN9645X switch=
. It
> > > includes initialization, port module setup for NPI, CPU, and front po=
rts,
> > > and phylink integration for MAC side configuration.
> > >=20
> > > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c b/driv=
ers/net/dsa/microchip/lan9645x/lan9645x_npi.c
> > > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
> > > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
> > > [ ... ]
> > > > +static void disable_conduit_ipv6(struct lan9645x *lan9645x,
> > > > +                              struct net_device *conduit)
> > > > +{
> > > > +     struct inet6_dev *dev_v6;
> > > > +
> > > > +     if (!conduit)
> > > > +             return;
> > > > +
> > > > +     /* IPv6 on the conduit will generate frames bypassing our tag=
 driver, so
> > > > +      * they lack an IFH. This will be garbage in garbage out and =
we want to
> > > > +      * avoid this.
> > > > +      */
> > > > +     rtnl_lock();
> > > > +     dev_v6 =3D __in6_dev_get(conduit);
> > > > +     if (dev_v6) {
> > > > +             WRITE_ONCE(dev_v6->cnf.disable_ipv6, 1);
> > > > +             dev_warn(lan9645x->dev, "Disabled IPv6 on conduit dev=
ice: %s\n",
> > > > +                      netdev_name(conduit));
> > > > +     }
> > > > +     rtnl_lock();
> > > > +}
> > >=20
> > > Does directly modifying dev_v6->cnf.disable_ipv6 bypass the proper sy=
sctl
> > > teardown path (addrconf_disable_ipv6) and leave the IPv6 stack in an
> > > inconsistent state on the conduit device by failing to clean up route=
s,
> > > addresses, and MLD memberships?
> > >=20
> > > Is it a layering violation for a switch driver to alter the networkin=
g
> > > configuration of an external upper device, especially since this chan=
ge
> > > isn't reverted during driver unbind?
> >=20
> > Yes this will bypass the sysctl teardown path. I can change this to ins=
tead
> > read disable_ipv6 state and warn the user that their device is misconfi=
gured.
>=20
> I don't want to have to deal with a DSA driver altering the conduit
> configuration outside of the DSA core. NACK to any attempts of trying
> this.
>=20
> Define "garbage in, garbage out" for your case. The packets are sent to
> random ports? Normally, switches are configured by their drivers to drop
> those packets that don't contain DSA tags. You can also do that, by
> setting up the switch to require an injection prefix.
>=20
> > > [ ... ]
> > > > +     /* Configure IFH prefix mode for NPI port. */
> > > > +     lan_rmw(SYS_PORT_MODE_INCL_XTR_HDR_SET(LAN9645X_TAG_PREFIX_LO=
NG) |
> > > > +             SYS_PORT_MODE_INCL_INJ_HDR_SET(LAN9645X_TAG_PREFIX_NO=
NE),
> > > > +             SYS_PORT_MODE_INCL_XTR_HDR |
> > > > +             SYS_PORT_MODE_INCL_INJ_HDR,
> > > > +             lan9645x,
> > > > +             SYS_PORT_MODE(p->chip_port));
> > >=20
> > > Setting LAN9645X_TAG_PREFIX_NONE means the hardware interprets the fi=
rst
> > > bytes of any frame received from the host as an IFH command structure=
.
> > >=20
> > > Does this allow a local user to transmit crafted frames (for example,=
 via
> > > raw sockets or standard protocols) whose MAC address bytes map to mal=
icious
> > > IFH commands, thereby bypassing VLAN isolation or flooding the switch=
?
> > >=20
> > > Should the hardware be configured to require a strict prefix, such as
> > > LAN9645X_TAG_PREFIX_LONG, for injected frames to prevent this?
> >=20
> > A prefix offers no protection against the described scenario. The curre=
nt
> > configuration is correct. If a prefix is configured frames MUST contain=
 the
> > prefix. With the conduit exposed in userspace this is not something we =
can
> > guarantee.
>=20
> The short prefix prevents user space from sending frames by mistake
> which will reach the wire (daemons attaching to all interfaces, like for =
DHCP).
> It still allows user space to intentionally inject frames into the
> switch (for example from XDP on the conduit).
>=20
> I recommend you go for the short prefix and drop the conduit alterations.
>=20


By garbage in, garbage out I mean frames will be interpreted as having
an IFH, and may be sent to random ports depending the bytes in the
frame.

Unfortunately, configuring an injection prefix is not a good solution.
If an injection prefix is configured frames MUST contain this prefix. If
frames are received which do not contain the prefix they will corrupt
the queue system leaving the port unusable.

Since the driver does not have control over frames sent to the NPI port,
an injection prefix configuration is highly undesirable.

I will remove the conduit alterations.


> > > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/dri=
vers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > > [ ... ]
> > > > +static int lan9645x_setup(struct dsa_switch *ds)
> > > > +{
> > > > +     struct lan9645x *lan9645x =3D ds->priv;
> > > > +     struct device *dev =3D lan9645x->dev;
> > > > +     u32 all_phys_ports;
> > > > +     int err;
> > > > +
> > > > +     lan9645x->num_phys_ports =3D ds->num_ports;
> > > > +     all_phys_ports =3D GENMASK(lan9645x->num_phys_ports - 1, 0);
> > > > +
> > > > +     err =3D lan9645x_reset_switch(lan9645x);
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > > > +     lan9645x->ports =3D devm_kcalloc(lan9645x->dev, lan9645x->num=
_phys_ports,
> > > > +                                    sizeof(struct lan9645x_port *)=
,
> > > > +                                    GFP_KERNEL);
> > >=20
> > > Since the DSA .setup callback can be invoked multiple times during th=
e
> > > platform device's lifetime (for example, when the DSA master interfac=
e is
> > > unbound and bound again), does using devm_kcalloc here cause a memory=
 leak?
> > > Should these allocations be moved to .probe or managed with kcalloc a=
nd
> > > freed in .teardown?
> > >=20
> >=20
> > Hmm I do not think this is right? I think dsa_tree_teardown is called f=
rom
> > dsa_switch_remove which is called by the switch drivers .remove.
> >=20
> > So I do not think you can get multiple setup/teardown cycles during the=
 device
> > lifetime?
> >=20
> > As far as I can tell both felix and ksz use device managed allocations =
in their
> > setup callback.
>=20
> It's valid feedback in general. In a multi-switch tree, ds->ops->setup()
> is called when the tree is complete, and ds->ops->teardown() when the
> first switch disappears. If there are 2 switches and you unbind and
> rebind the driver from A, then switch B will see a ds->ops->teardown()
> call followed by ds->ops->setup().
>=20
> In your case, since the switch doesn't support cascading, it probably
> doesn't matter. But the LLM doesn't have the context to know that.
>=20


OK, I was not aware of this. I tried following the callstack and it did not=
 seem
like the described scenario was possible. If device managed allocations are=
 fine
when you do not support cascading, I would prefer to keep them.

> > > [ ... ]
> > > > +     /* Set all the entries to obey VLAN. */
> > > > +     for (int i =3D 0; i < PGID_ENTRIES; ++i)
> > > > +             lan_wr(ANA_PGID_CFG_OBEY_VLAN_SET(1),
> > > > +                    lan9645x, ANA_PGID_CFG(i));
> > >=20
> > > PGID_ENTRIES is defined as 89, so this loop initializes indices 0 thr=
ough
> > > 88. Since the CPU port is index 9, its source PGID is PGID_SRC + CPU_=
PORT
> > > (80 + 9 =3D 89).
> > >=20
> > > Is index 89 left uninitialized, breaking the OBEY_VLAN rule and allow=
ing
> > > CPU-injected frames to leak across VLAN boundaries?
> > >=20
> >=20
> > No I this misunderstands OBEY_VLAN. When set the vlan table can control
> > whether cpu copy from the pgid table is enabled. It makes no sense for =
PGID 89.
>=20
> Explain that in a comment.
>=20

I will add a comment about this.

> > > [ ... ]
> > > > +     /* Multicast to all front ports */
> > > > +     lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MC));
> > > > +
> > > > +     /* IP multicast to all front ports */
> > > > +     lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MCIPV4));
> > > > +     lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MCIPV6));
> > > > +
> > > > +     /* Unicast to all front ports */
> > > > +     lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_UC));
> > > > +
> > > > +     /* Broadcast to all ports */
> > > > +     lan_wr(BIT(CPU_PORT) | all_phys_ports, lan9645x, ANA_PGID(PGI=
D_BC));
> > >=20
> > > PGID_BC includes BIT(CPU_PORT) and all_phys_ports (which includes the=
 NPI
> > > port). Will this forward broadcast frames to both the CPU extraction =
queue
> > > and the NPI port's normal egress queue, causing duplicate frames for =
the host?
> > >=20
> > > Conversely, the multicast masks and PGID_UC exclude BIT(CPU_PORT). Do=
es
> > > this cause them to bypass the CPU extraction queue entirely, thereby
> > > lacking the LONG extraction prefix and breaking the host's DSA tagger=
 parsing?
> > >=20
> >=20
> > No this is not how it works. Generally when you configure the CPU port =
to use
> > an NPI port, the hardware manages this internally. You do you have to s=
tart
> > using the npi port number all of a sudden.
>=20
> The comment is fair though. Why would you set all_phys_ports to
> GENMASK(lan9645x->num_phys_ports - 1, 0) when you can compute the mask
> of user ports which are enabled? It seems sloppy at best, and also
> contradictory (comments say "all front ports", but code includes the NPI
> port in this mask).
>=20

I will use dsa_user_ports(ds) as the base mask for the flood masks.

> > > [ ... ]
> > > > +int lan9645x_port_setup(struct dsa_switch *ds, int port)
> > > > +{
> > > > +     struct dsa_port *dp =3D dsa_to_port(ds, port);
> > > > +     struct lan9645x *lan9645x =3D ds->priv;
> > > > +     struct lan9645x_port *p;
> > > > +
> > > > +     p =3D lan9645x_to_port(lan9645x, port);
> > > > +
> > > > +     if (dp->dn) {
> > > > +             p->rx_internal_delay =3D
> > > > +                     of_property_present(dp->dn, "rx-internal-dela=
y-ps");
> > > > +             p->tx_internal_delay =3D
> > > > +                     of_property_present(dp->dn, "tx-internal-dela=
y-ps");
> > > > +     }
> > >=20
> > > These are standard integer properties specifying delays in picosecond=
s. If
> > > a user explicitly disables the delay via devicetree using a value of =
0,
> > > will of_property_present evaluate to true and enable the hardware del=
ay
> > > anyway? Should of_property_read_u32 be used instead to check the valu=
e?
> >=20
> > A value of 0 is not allowed per the bindings. The bindings enforce that=
 if this
> > is present the value must be 2000.
>=20
> Bindings may change. Please use of_property_read_u32().
>=20


I will switch to of_property_read_u32.

