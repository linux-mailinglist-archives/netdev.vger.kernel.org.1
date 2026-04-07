Return-Path: <netdev+bounces-275900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NqLZMBXA1GnQwwcAu9opvQ
	(envelope-from <netdev+bounces-275900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:28:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A05D83AB521
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D8263005995
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637993A874E;
	Tue,  7 Apr 2026 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P0JaqAs1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D933A4F4B;
	Tue,  7 Apr 2026 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550381; cv=none; b=tz6h3Z72gxWi7pOxzvtloWwjVVg/nJ48FveLpiynLh/CcQu+d7FTdxDNQZpeVEA3qgpH41lqRjPiKI45anj4Lqjtdh9Kc53vDoTqsVUbU78YxVTywsC29zoWHKRoQjRGgddc6JhNys3aXUuRtkxI9dWxCvnxm81en7PaNVJJKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550381; c=relaxed/simple;
	bh=tY0z2SBtaP5zGJ6er61MXnQImsJxvOIEZCLnIFziXMM=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYf1PMyRyngvxEqrcXYjQER6URT1JFERqcxwzqDI9Fdf+Bp8a4W4fBhZV9/GdxY0kzEdxUfDW5ZtCuQvNC9nypx+4E8p1uon9tEmBVftIyHS+MR5MuLH7VymTNyvJm4jOQUFSKLy1kECEoI0ljghAABbtWT07vwaVd+hPUZjd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P0JaqAs1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775550378; x=1807086378;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tY0z2SBtaP5zGJ6er61MXnQImsJxvOIEZCLnIFziXMM=;
  b=P0JaqAs1jmiOegBrsfk/la0zzmTzGJ5Bb/F3PXnS89qnmpXpUlIhQ0Fh
   9ZXhh8LXYqsMqPTgYslk7AyOdAk8bPldhb4l5rZ1tL0xjhNx2AGvKTK/X
   8vMb8DL+waQL3Aj3fCqSoXrcWospNIUnYDYaATSybMq0wO6yfKD/5sSG1
   gKi/c79w6CPHCJwF9ZQvGPRxO3UdVR0dSn87HhPuodLK0jB5zABmChTkH
   VwKDx8xVArDi2Uhyoe6X7iLwGCzm96aNQodJu5OG8YhyMxF1T2FI35/Pv
   I1NH4j6LohjhdJG8AI4DyW/+/RDNn55tETlvikRVpOqmVklqF80Rf7VNZ
   A==;
X-CSE-ConnectionGUID: zOPkbQXqQ1K0HC3GgLO8Dw==
X-CSE-MsgGUID: CWpYdt2xSWWqerXc4zHxUg==
X-IronPort-AV: E=Sophos;i="6.23,165,1770620400"; 
   d="scan'208";a="55001812"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2026 01:26:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 7 Apr 2026 01:25:43 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 7 Apr 2026 01:25:40 -0700
Message-ID: <e5e5a5b5f7ac6f70c556f1b8274aebe8a04f58b0.camel@microchip.com>
Subject: Re: [PATCH net-next v2 9/9] net: dsa: lan9645x: add port statistics
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Tue, 7 Apr 2026 10:25:39 +0200
In-Reply-To: <20260329195639.2789284-1-kuba@kernel.org>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-9-f7504e3b0681@microchip.com>
	 <20260329195639.2789284-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275900-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Queue-Id: A05D83AB521
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-03-29 at 12:56 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: lan9645x: add port statistics
>=20
> Add statistics support for the port counters. Chip registers are 32 bit,
> so this unit is responsible maintaining a 64bit software cache, and
> updating it frequently to handle overflows in hardware.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index 24a60f40f6b8..9a46c08dad59 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> [ ... ]
> > @@ -262,6 +264,12 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >       if (!lan9645x->owq)
> >               return -ENOMEM;
> >=20
> > +     err =3D lan9645x_stats_init(lan9645x);
> > +     if (err) {
> > +             dev_err(dev, "Failed to init stats.\n");
> > +             goto owq_destroy;
> > +     }
> > +
> [ ... ]
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/driv=
ers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > index 000000000000..3e82a859f173
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> [ ... ]
> > +static const struct lan9645x_ethtool_stat lan9645x_port_ethtool_stats[=
] =3D {
> > +     { "rx_uc",              SCNT_RX_UC },
> > +     { "rx_cat_drop",        SCNT_RX_CAT_DROP },
> [ ... ]
> > +     { "tx_uc",              SCNT_TX_UC },
> > +     { "tx_drop",            SCNT_TX_DROP },
> [ ... ]
> > +};
>=20
> Is it necessary to duplicate standard networking statistics in the driver
> private ethtool output?
>=20
> The networking subsystem guidelines state that stats possessing a standar=
d UAPI
> representation, such as tx_dropped and rx_packets in struct rtnl_link_sta=
ts64,
> should not be duplicated in the ethtool -S output.
>=20
> Could these redundant strings be removed since the driver natively suppor=
ts
> them via lan9645x_stats_get_stats64?
>=20


I do not think they are redundant. They are only available in an aggregated=
 form
via rtnl_link_stats64, not directly. Information is lost if they are remove=
d.

> [ ... ]
> > +static const struct lan9645x_view_stats lan9645x_view_stat_cfgs[] =3D =
{
> > +     [LAN9645X_STAT_PORTS] =3D {
> > +             .name =3D "ports",
> > +             .type =3D LAN9645X_STAT_PORTS,
> > +             .layout =3D lan9645x_port_stats_layout,
> > +             .num_cnts =3D ARRAY_SIZE(lan9645x_port_stats_layout),
> > +             .num_indexes =3D NUM_PHYS_PORTS,
> > +     },
> > +};
> [ ... ]
> > +static u64 *lan9645x_stats_view_idx_update(struct lan9645x *lan9645x,
> > +                                        enum lan9645x_view_stat_type v=
type,
> > +                                        int idx)
> > +{
> > +     struct lan9645x_stats *s =3D lan9645x->stats;
> > +
> > +     mutex_lock(&s->hw_lock);
> > +     __lan9645x_stats_view_idx_update(lan9645x, vtype, idx);
> > +     mutex_unlock(&s->hw_lock);
> > +
> > +     return STAT_COUNTERS(lan9645x, vtype, idx);
> > +}
>=20
> Does this code overflow the allocated buffer when called for the CPU port=
?
>=20
> The stats buffer cnts is allocated using num_indexes, which is NUM_PHYS_P=
ORTS
> (9). This covers ports 0 to 8. However, the CPU port is defined as index =
9
> (CPU_PORT =3D 9).
>=20
> When the DSA core invokes stat callbacks like get_ethtool_stats or get_st=
ats64
> for the CPU port, the idx argument is 9. While the helper
> __lan9645x_stats_view_idx_update skips the hardware read for out-of-bound=
s
> indices, lan9645x_stats_view_idx_update ignores that failure and returns =
the
> result of STAT_COUNTERS(lan9645x, vtype, idx).
>=20
> This computes a pointer past the end of the cnts array, which the callers=
 then
> blindly dereference, potentially leaking kernel memory or causing a crash=
. Can
> bounds checking be added to the callers, or should the buffer be sized to
> include the CPU port?
>=20

No this is not called for the CPU port index 9.

> [ ... ]
> > +void lan9645x_stats_get_ethtool_stats(struct lan9645x *lan9645x, int p=
ort,
> > +                                   u64 *data)
> > +{
> > +     struct lan9645x_stats *stats =3D lan9645x->stats;
> > +     u64 *c;
> > +     int i;
> > +
> > +     c =3D lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORT=
S, port);
> > +
> > +     spin_lock(&stats->sw_lock);
> > +     for (i =3D 0; i < ARRAY_SIZE(lan9645x_port_ethtool_stats); i++)
> > +             *data++ =3D c[lan9645x_port_ethtool_stats[i].idx];
> > +     spin_unlock(&stats->sw_lock);
> > +}
> [ ... ]
> > +/* Called in atomic context */
> > +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> > +                             struct rtnl_link_stats64 *stats)
> > +{
> > +     struct lan9645x_stats *s =3D lan9645x->stats;
> > +     u64 *c;
> > +
> > +     c =3D STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> > +
> > +     spin_lock(&s->sw_lock);
>=20
> Can this code deadlock when a softirq interrupts a process holding the lo=
ck?
>=20
> The sw_lock spinlock protects the 64-bit software stats counters. In
> lan9645x_stats_get_stats64, which acts as the ndo_get_stats64 callback, t=
his
> lock is acquired using a plain spin_lock. The code comment notes this fun=
ction
> is called in atomic context (such as from NET_RX_SOFTIRQ via dev_get_stat=
s).
>=20
> Concurrently, process context paths like lan9645x_stats_get_ethtool_stats=
 and
> lan9645x_check_stats_work also acquire sw_lock using plain spin_lock. Bec=
ause
> plain spin_lock does not disable softirqs, if a softirq preempts the exec=
ution
> on a CPU while process context holds sw_lock, the softirq will spin
> indefinitely waiting for the lock.
>=20
> Should the process-context acquisitions use spin_lock_bh instead?
>=20

As far as I can tell ndo_get_stats64 is not called from softirq. Ocelot als=
o uses
a plain spin_lock here. Since no softirq path touches this lock, there is n=
o
deadlock.

> [ ... ]
> > +int lan9645x_stats_init(struct lan9645x *lan9645x)
> > +{
> > +     const struct lan9645x_view_stats *vs;
> > +     struct lan9645x_stats *stats;
> > +     int err, i;
> > +
> > +     lan9645x->stats =3D devm_kzalloc(lan9645x->dev, sizeof(*stats),
> > +                                    GFP_KERNEL);
>=20
> Will this memory be leaked when the DSA switch unbinds and rebinds?
>=20
> The lan9645x_stats_init function allocates lan9645x->stats, vstat->cnts, =
and
> vstat->buf using devm_kzalloc and devm_kcalloc. This function is called f=
rom
> lan9645x_setup, which is the DSA .setup callback.
>=20
> The DSA tree lifecycle is independent of the platform device lifecycle. I=
f the
> master netdevice is unbound and bound again, the DSA switch's .teardown a=
nd
> .setup callbacks will be invoked multiple times. Because .teardown cannot=
 free
> devres-managed memory, the memory tied to the platform device will be lea=
ked
> on every setup cycle until the switch's platform device itself is destroy=
ed.
>=20
> Could this use standard kzalloc allocations paired with kfree in teardown=
?

Similar comment as the devm_* comment for the .setup function. I do not thi=
nk
this is a problem, since there can not be multiple setup/teardown cycles
during the device lifetime. dsa_tree_teardown is only called from=C2=A0
dsa_switch_remove which is called by the switch drivers .remove.


As far as I can tell both felix and ksz use device managed allocations in t=
heir
setup callback.





