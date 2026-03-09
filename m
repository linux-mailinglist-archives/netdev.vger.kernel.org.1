Return-Path: <netdev+bounces-265523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M3lFZq7rmmxIQIAu9opvQ
	(envelope-from <netdev+bounces-265523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:22:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E408B238BC3
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B203164B5D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4761E3ACF13;
	Mon,  9 Mar 2026 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2NWOGvqC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12883A9DB0;
	Mon,  9 Mar 2026 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058250; cv=none; b=mwDW1SIRMf1crZ2GnIm/Cide8Tmd9jg1cC1yYWfW3YqchBoojzyB/Mnnh8OFH94aW7IBLFZTaiGpqaSMqgfDSpqtFNfRcag1hVPG7IqccSreJlROt9dzdOyxO+2q+20zJmerGzMQq82FaRyn/T310iIorpp/Slx7IWQKd8q6jSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058250; c=relaxed/simple;
	bh=CxC4gPRhEx+EnX12NY8NGaQLgGbGEevJeK1eAo6Pdx8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BaTmNTdflAbQClw8uSbmOwtJMkmm//xznwJDDV506wCrxxY4wK853BLyZnyHWBIHJeRCpoQe4NT79O4XoRd20ArOlPta/BPALxiR7c5RGdjRtTl9aBYGLA7HGDEVHEgypeTg4sf8b1DuS5qFJrIPIHsPg6wJT2C2KmF2lljBcFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2NWOGvqC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773058248; x=1804594248;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CxC4gPRhEx+EnX12NY8NGaQLgGbGEevJeK1eAo6Pdx8=;
  b=2NWOGvqCrWmKyOaoW0poa4Qn4kmGMB4zgxHwpXKtREZknqadw8xotM3D
   DVTpiF/s/7o8X6NLstnYMz9mh1WUydpsq7moB2n0zbLgskaDhRGlhbhyP
   jGWkkfi7OU1Y9riZ/zXFlFVhJVlL9xUiEVzgtMc4/rOBuXbFSy8Flxq+6
   9AKxiC6mUXB+fyS8j/OTr/TQnd/3zfnA/C6Uf5bAzgFT988/WZQFlZ0Ol
   oH6ru05H4GdnN6c7jLTwtN/xhT3sB1O78O6ov7HWVDYqJ2HUrV3VYUA8J
   JvltMza6bwRnwBnWuhKtjkP4w1myjl42yFUEwj8+wzPlq6hlxEGYhhyBs
   g==;
X-CSE-ConnectionGUID: lABlYgOLRx6xa1tNtlPVIg==
X-CSE-MsgGUID: cDPRv21cQ2igkbk4b9k7Pg==
X-IronPort-AV: E=Sophos;i="6.23,109,1770620400"; 
   d="scan'208";a="61927052"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 05:10:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 9 Mar 2026 05:10:07 -0700
Received: from [10.205.29.43] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 9 Mar 2026 05:10:04 -0700
Message-ID: <1d70dd8d53f976d5f189d4154049129ef0df0c38.camel@microchip.com>
Subject: Re: [PATCH net-next 5/8] net: dsa: lan9645x: add bridge support
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Mon, 9 Mar 2026 13:09:53 +0100
In-Reply-To: <20260303145130.rbp3qycr3eh5ifcp@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
	 <20260303145130.rbp3qycr3eh5ifcp@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E408B238BC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265523-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 16:51 +0200, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Tue, Mar 03, 2026 at 01:22:31PM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > Add support for hardware offloading of the bridge. We support a single
> > bridge device.
> >=20
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzosterga=
ard@microchip.com>
> > ---
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 196 +++++++++++++=
++++++++
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  11 ++
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |   2 +
> >  3 files changed, 209 insertions(+)
> >=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index 739013f049d0..b6efaf669a3f 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > @@ -171,6 +171,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >               return err;
> >       }
> >=20
> > +     mutex_init(&lan9645x->fwd_domain_lock);
> > +
> >       /* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
> >       lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
> >              ANA_AGGR_CFG_AC_DMAC_ENA,
> > @@ -288,6 +290,192 @@ static void lan9645x_port_phylink_get_caps(struct=
 dsa_switch *ds, int port,
> >       lan9645x_phylink_get_caps(ds->priv, port, config);
> >  }
> >=20
> > +static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned in=
t msecs)
> > +{
> > +     u32 age_secs =3D max(1, msecs / 1000 / 2);
>=20
> s/1000/MSEC_PER_SEC/
>=20

I will change this.

> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +
> > +     /* Entry is must suffer two aging scans before it is removed, so =
an
>=20
> "An entry must suffer (...), so it is aged"

I will change this.

>=20
> > +      * entry is aged after 2*AGE_PERIOD, and the unit is in seconds.
> > +      * An age period of 0 disables automatic aging.
> > +      */
> > +     lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(age_secs),
> > +             ANA_AUTOAGE_AGE_PERIOD,
> > +             lan9645x, ANA_AUTOAGE);
> > +     return 0;
> > +}
> > +
> > +static int lan9645x_port_pre_bridge_flags(struct dsa_switch *ds, int p=
ort,
> > +                                       struct switchdev_brport_flags f=
lags,
> > +                                       struct netlink_ext_ack *extack)
> > +{
> > +     if (flags.mask &
> > +         ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD))
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> > +static void lan9645x_port_pgid_set(struct lan9645x *lan9645x, u16 pgid=
,
> > +                                int chip_port, bool enabled)
> > +{
> > +     u32 reg_msk, port_msk;
> > +
> > +     WARN_ON(chip_port > CPU_PORT);
> > +
> > +     port_msk =3D ANA_PGID_PGID_SET(enabled ? BIT(chip_port) : 0);
> > +     reg_msk =3D ANA_PGID_PGID_SET(BIT(chip_port));
> > +
> > +     lan_rmw(port_msk, reg_msk, lan9645x, ANA_PGID(pgid));
> > +}
> > +
> > +static void lan9645x_port_set_learning(struct lan9645x *lan9645x, int =
port,
> > +                                    bool enabled)
> > +{
> > +     struct lan9645x_port *p;
> > +
> > +     lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(enabled), ANA_PORT_CFG_LEARN_E=
NA,
> > +             lan9645x, ANA_PORT_CFG(port));
>=20
> Actually, the port may be in an STP state where learning shouldn't be
> enabled, when this function is called. Enabling the "learning" bridge
> port flag shouldn't change that.
>=20

Thank you, I will check stp_state before writing to HW, similar to=C2=A0
set_stp_state.

> > +
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +     p->learn_ena =3D enabled;
> > +}
> > +
> > +static int lan9645x_port_bridge_flags(struct dsa_switch *ds, int port,
> > +                                   struct switchdev_brport_flags f,
> > +                                   struct netlink_ext_ack *extack)
> > +{
> > +     struct lan9645x *l =3D ds->priv;
>=20
> Could we have some consistency in variable naming throughout the driver,
> at least for the main private structure? I don't have an issue with it
> being called l, it's just that I would prefer it being called the same
> everywhere.
>=20

I will use lan9645x everywhere.

> > +
> > +     if (WARN_ON(port =3D=3D l->npi))
> > +             return -EINVAL;
> > +
> > +     if (f.mask & BR_LEARNING)
> > +             lan9645x_port_set_learning(l, port, !!(f.val & BR_LEARNIN=
G));
> > +
> > +     if (f.mask & BR_FLOOD)
> > +             lan9645x_port_pgid_set(l, PGID_UC, port, !!(f.val & BR_FL=
OOD));
> > +
> > +     if (f.mask & BR_MCAST_FLOOD) {
> > +             bool ena =3D !!(f.val & BR_MCAST_FLOOD);
> > +
> > +             lan9645x_port_pgid_set(l, PGID_MC, port, ena);
> > +             lan9645x_port_pgid_set(l, PGID_MCIPV4, port, ena);
> > +             lan9645x_port_pgid_set(l, PGID_MCIPV6, port, ena);
> > +     }
> > +
> > +     if (f.mask & BR_BCAST_FLOOD)
> > +             lan9645x_port_pgid_set(l, PGID_BC, port,
> > +                                    !!(f.val & BR_BCAST_FLOOD));
> > +
> > +     return 0;
> > +}
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_port.c
> > index 038868ae0a32..b60c64458957 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> > @@ -15,6 +15,8 @@ int lan9645x_port_init(struct lan9645x *lan9645x, int=
 port)
> >               ANA_PORT_CFG_LEARN_ENA,
> >               lan9645x, ANA_PORT_CFG(p->chip_port));
> >=20
> > +     p->learn_ena =3D false;
> > +
>=20
> This is already zero-initialized memory.

Removed.

>=20
> >       lan9645x_port_set_maxlen(lan9645x, port, ETH_DATA_LEN);
> >=20
> >       lan9645x_phylink_port_down(lan9645x, port);
> >=20
> > --
> > 2.52.0
> >=20



Thanks,
Emil

