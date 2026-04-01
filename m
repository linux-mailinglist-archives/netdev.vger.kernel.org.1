Return-Path: <netdev+bounces-274101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCccDekdzWnOaAYAu9opvQ
	(envelope-from <netdev+bounces-274101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:30:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B547B37B3FF
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB8FA305CA8A
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDBB40823E;
	Wed,  1 Apr 2026 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fvO4+brC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB33F8DE5;
	Wed,  1 Apr 2026 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047970; cv=none; b=EdjhO+vyM8WKgRsG+PexEO5GxO1ubkNZ9dcN34TlMe6og8vlz+7cBeVheuTOjmBxUWOJ2F/SJLfsYRIM/3CCupyiJ1mmMJI4Ksz5djUyvaj3E+TnoTs1C1VcrH8e4h32gwRw4Jy2bCoEqfZhRke88hnqHAAMW6+NjLhJf1Qwklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047970; c=relaxed/simple;
	bh=nMMeGeai7+jxo/XxU/rMhAsLGO/BMZd5lafH1QEnAN0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gw5A06kpvbgvGYcwm9BC5/WQ0rfYp6nePUVYqL5FdKVX7c9Md31h05Fb20b2+aovZigZWCeVBzW5vhdxaHTehYCdW0pOUS/Z8+VHFdV/TKNPrdCmOXZA8pAXBUerBOwV+UFzuSSJc3V6Qin7CdKHwXDaMlx/OLvmBOKFF909GEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fvO4+brC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775047967; x=1806583967;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nMMeGeai7+jxo/XxU/rMhAsLGO/BMZd5lafH1QEnAN0=;
  b=fvO4+brCSr02uO86HEat1UV3Iem1Kv7d0T8XNatyHDGiV6TWSyZtT66D
   HkgqNW4ZeFJqqtYw9B136HTiZEN7KC3rTEjR3EEN/UeWvpC2xg3CMnF1X
   /y7BvXMo7vRROHCNtr0WNhRjzdH5BATElNjBvewDaL1jAOPiIXPNx/kS4
   i/cNyupTvwZTbMKr7vlMkThh/WXivaCN7KtaJIvoE0IiQmvU/P5HXF0cV
   wBsHWtBcevyi9NveTiofqyCU6RKSKWpSNW1AZSbymZ6kweYRC8IuBqXSF
   TM/W3yCMOc5Dqqm4yKzkDdSflMqlHFF0zkDd73eu97WIkUIhSFadBrewD
   A==;
X-CSE-ConnectionGUID: 2YBp1MG4SB+fC8V+138tSQ==
X-CSE-MsgGUID: ezyv4A4HS1SqZZK5pn/iWw==
X-IronPort-AV: E=Sophos;i="6.23,153,1770620400"; 
   d="scan'208";a="55952462"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 05:52:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 1 Apr 2026 05:52:06 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 1 Apr 2026 05:52:03 -0700
Message-ID: <dbfadc24cc15c6b5fd1b75fe0eb11d155ee6f3c4.camel@microchip.com>
Subject: Re: [PATCH net-next v2 5/9] net: dsa: lan9645x: add bridge support
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Wed, 1 Apr 2026 14:52:02 +0200
In-Reply-To: <20260329195631.2789158-1-kuba@kernel.org>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-5-f7504e3b0681@microchip.com>
	 <20260329195631.2789158-1-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-274101-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B547B37B3FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-03-29 at 12:56 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: lan9645x: add bridge support
>=20
> This commit adds support for hardware offloading of the bridge in the
> lan9645x DSA driver. It enables a single bridge device to be used with
> the switch.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index a0908cbf89c7..599e589c4ec3 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> [ ... ]
> > @@ -145,6 +155,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >               return err;
> >       }
> >=20
> > +     mutex_init(&lan9645x->fwd_domain_lock);
> > +
> >       /* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
> >       lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
> >              ANA_AGGR_CFG_AC_DMAC_ENA,
> [ ... ]
> > @@ -240,6 +252,11 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >=20
> >       lan9645x_port_set_tail_drop_wm(lan9645x);
> >=20
> > +     lan9645x->owq =3D alloc_ordered_workqueue("%s-owq", 0,
> > +                                             dev_name(lan9645x->dev));
> > +     if (!lan9645x->owq)
> > +             return -ENOMEM;
> > +
>=20
> Is it possible that the hardware remains initialized if the call to
> alloc_ordered_workqueue fails? Because the setup callback returns an erro=
r,
> the DSA core will skip the teardown callback. This would bypass
> lan9645x_npi_port_deinit, potentially leaving the conduit netdev in a
> corrupted state with hardware tagging enabled.

I do not think it is common practice to undo switch register writes in the
error path here. We reset the switch registers in .setup. If we exit
here there is nothing to teardown.

>=20
> Also in lan9645x_setup, the initialization loop for PGID_ENTRIES iterates
> through index 88:
>=20
> for (int i =3D 0; i < PGID_ENTRIES; ++i)
>         lan_wr(ANA_PGID_CFG_OBEY_VLAN_SET(1),
>                lan9645x, ANA_PGID_CFG(i));
>=20
> Could this leave the CPU port's source configuration in an undefined stat=
e?
> The CPU port is port 9, which has its source analysis register at PGID_SR=
C
> (80) + 9 =3D 89, but the loop terminates before reaching it.
>=20

No as I mentioned in another mail this OBEY_VLAN does not make sense for
pgid 89.

> > @@ -258,6 +275,271 @@ static void lan9645x_port_phylink_get_caps(struct=
 dsa_switch *ds, int port,
> >       lan9645x_phylink_get_caps(ds->priv, port, config);
> >  }
> >=20
> > +static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned in=
t msecs)
> > +{
> > +     u32 age_secs =3D max(1, msecs / MSEC_PER_SEC / 2);
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +
> > +     /* Entry is must suffer two aging scans before it is removed, so =
it is
> > +      * aged after 2*AGE_PERIOD, and the unit is in seconds.
> > +      * An age period of 0 disables automatic aging.
> > +      */
> > +     lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(age_secs),
> > +             ANA_AUTOAGE_AGE_PERIOD,
> > +             lan9645x, ANA_AUTOAGE);
> > +     return 0;
> > +}
>=20
> Does this function properly disable automatic aging when requested? When =
the
> Linux bridge passes msecs =3D 0 to disable aging, the max macro evaluates=
 to 1.
> Since writing 1 configures an aggressive 2-second aging period, it appear=
s
> this might not fulfill the user's intent.
>=20

Yes that is right. I will change it to:


	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(msecs ? age_secs : 0),
		ANA_AUTOAGE_AGE_PERIOD,
		lan9645x, ANA_AUTOAGE);


> [ ... ]
> > +static void __lan9645x_port_set_host_flood(struct lan9645x *lan9645x, =
int port,
> > +                                        bool uc, bool mc)
> > +{
> > +     bool mc_ena, uc_ena;
> > +
> > +     lockdep_assert_held(&lan9645x->fwd_domain_lock);
> > +
> > +     /* We want promiscuous and all_multi to affect standalone ports, =
for
> > +      * debug and test purposes.
> > +      *
> > +      * However, the linux bridge is incredibly eager to put bridged p=
orts in
> > +      * promiscuous mode.
> > +
> > +      * This is unfortunate since lan9645x flood masks are global and =
not per
> > +      * ingress port. When some port triggers unknown uc/mc to the CPU=
, the
> > +      * traffic from any port is forwarded to the CPU.
> > +      *
> > +      * If the host CPU is weak, this can cause tremendous stress. The=
refore,
> > +      * we compromise by ignoring this host flood request for bridged =
ports.
> > +      */
> > +     if (lan9645x_port_is_bridged(lan9645x_to_port(lan9645x, port)))
> > +             return;
>=20
> Will ignoring the host flood request for bridged ports break IPv6 Neighbo=
r
> Discovery? IPv6 ND relies on multicast, and the PGID_MC and PGID_MCIPV6 m=
asks
> do not include the CPU port by default. By ignoring the bridge's request =
to
> enable multicast flooding, the CPU port may fail to receive ICMPv6 ND pac=
kets.
>=20

No that is handled by other mechanisms. There are explicit handles to make =
sure
such traffic reaches the cpu.

> [ ... ]
> > +/* Called in atomic context */
> > +static void lan9645x_port_set_host_flood(struct dsa_switch *ds, int po=
rt,
> > +                                      bool uc, bool mc)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct lan9645x_host_flood_work *w;
> > +
> > +     w =3D kzalloc_obj(*w, GFP_ATOMIC);
>=20
> Is kzalloc_obj an available kernel function? Using it might cause a build
> error, as the standard API would be kzalloc(sizeof(*w), GFP_ATOMIC).
>=20
> > +     if (!w)
> > +             return;
>=20
> Are there consequences to returning silently when the allocation fails?
> If this allocation fails under memory pressure, the network stack will st=
ill
> assume the configuration was successfully applied, leaving the hardware s=
tate
> out of sync.
>=20

But we can not return any error in the dsa op to the network stack, so I th=
ink
this is our only option.

> [ ... ]
> > +static int lan9645x_port_bridge_join(struct dsa_switch *ds, int port,
> > +                                  struct dsa_bridge bridge,
> > +                                  bool *tx_fwd_offload,
> > +                                  struct netlink_ext_ack *extack)
> > +{
> [ ... ]
> > +     /* The bridge puts ports in IFF_ALLMULTI before calling
> > +      * port_bridge_join, so clean up before the port is marked as bri=
dged.
> > +      */
> > +     __lan9645x_port_set_host_flood(lan9645x, port, false, false);
> > +     lan9645x->bridge_mask |=3D BIT(p->chip_port);
> > +
> > +     mutex_unlock(&lan9645x->fwd_domain_lock);
> > +
> > +     /* Later: stp_state_set updates forwarding */
> > +
> > +     return 0;
> > +}
>=20
> Could clearing the host flood masks here lead to lost hardware state when=
 the
> port leaves the bridge? If a user previously enabled IFF_PROMISC or
> IFF_ALLMULTI on the standalone port, the software netdev flags remain set=
.
> When lan9645x_port_bridge_leave is called, it does not restore the hardwa=
re's
> promiscuous or multicast state to match the unchanged software flags.
>=20

Yes this is a bug. I will split flood requests and register writes, and mak=
e sure
the requested state is restored on bridge leave.

> > +static void lan9645x_port_bridge_stp_state_set(struct dsa_switch *ds, =
int port,
> > +                                            u8 state)
> > +{
> > +     struct lan9645x *lan9645x;
> > +     struct lan9645x_port *p;
> > +     bool learn_ena;
> > +
> > +     lan9645x =3D ds->priv;
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +
> > +     mutex_lock(&lan9645x->fwd_domain_lock);
> > +
> > +     p->stp_state =3D state;
> > +
> > +     if (state =3D=3D BR_STATE_FORWARDING)
> > +             lan9645x->bridge_fwd_mask |=3D BIT(p->chip_port);
> > +     else
> > +             lan9645x->bridge_fwd_mask &=3D ~BIT(p->chip_port);
> > +
> > +     learn_ena =3D (state =3D=3D BR_STATE_LEARNING ||
> > +                  state =3D=3D BR_STATE_FORWARDING) && p->learn_ena;
> > +
> > +     lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(learn_ena),
> > +             ANA_PORT_CFG_LEARN_ENA, lan9645x,
> > +             ANA_PORT_CFG(p->chip_port));
> > +
> > +     lan9645x_update_fwd_mask(lan9645x);
> > +     mutex_unlock(&lan9645x->fwd_domain_lock);
> > +}
>=20
> Are ingress data frames correctly dropped for ports in non-forwarding STP
> states? When the port is removed from bridge_fwd_mask,
> lan9645x_update_fwd_mask calculates the source PGID mask as
> bridge_mask & bridge_fwd_mask & ~BIT(dp->index).
>=20
> This evaluates to the set of all other forwarding ports in the bridge. Si=
nce
> ingress forwarding is not explicitly disabled on the port (for example, b=
y
> setting ANA_PORT_CFG_PORTID_VAL to NONE), data frames received on a block=
ing
> or learning port can enter the analyzer and be forwarded.
>=20

Yes this is a bug, I need to use a zero mask for the src pgid when a port i=
s
in non-forwarding STP state.

> > +static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port=
,
> > +                                    struct dsa_bridge bridge)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct lan9645x_port *p;
> > +
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +
> > +     mutex_lock(&lan9645x->fwd_domain_lock);
> > +
> > +     lan9645x->bridge_mask &=3D ~BIT(p->chip_port);
> > +
> > +     /* Last port leaving clears bridge dev */
> > +     if (!lan9645x->bridge_mask)
> > +             lan9645x->bridge =3D NULL;
> > +
> > +     lan9645x_update_fwd_mask(lan9645x);
> > +
> > +     mutex_unlock(&lan9645x->fwd_domain_lock);
> > +}
>=20
> Should p->learn_ena be reset when a port leaves the bridge?
>=20
> During port_bridge_flags, p->learn_ena is set to true. When leaving the
> bridge, this flag remains true. The DSA core will transition the leaving
> port to BR_STATE_FORWARDING, which calls lan9645x_port_bridge_stp_state_s=
et
> and leaves hardware learning enabled. This can pollute the shared FDB wit=
h
> MAC addresses from standalone ports, leading to silent packet drops if
> bridged ports attempt to forward traffic to them.


No I believe DSA core takes care of this with dsa_port_clear_brport_flags.

