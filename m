Return-Path: <netdev+bounces-263887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI/SG6dWqGlutQAAu9opvQ
	(envelope-from <netdev+bounces-263887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:58:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 307BF2037B1
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E9A73020538
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8B34DB74;
	Wed,  4 Mar 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kV7dIfGe"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FD3469E6;
	Wed,  4 Mar 2026 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639479; cv=none; b=O5t/R5e1he6UQVZ8Yhxszc5lTTAh2WQ+MsPqAZAC49eIDSdGiVZl2e87VrjbFStckcx5xM9DdZTDRYVnsKgkZ16PiAdlgnd2+dz+QYYNHE7rLuwxZWyEYcl4tWEnS1PJGwq2JBQ5W3kp2zLYKMpquC/iOTNFvBjcklV7zsHe/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639479; c=relaxed/simple;
	bh=z/ke89GVh8nNVji/9e66asH0wbDfoGSapcyajl2e7iQ=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVhzX/J7dbP4rgLUJwp0sXs2Fo2lZlIo7dj4ewq7h7b9gFwWUScj3M8xOApAin+tVDnOaZ4/tI65pHdon66vSDIxj9p6W9x8b1ShhOBps1eMLiO+HURuZigmITVb2N3g4bl+EB2sQUJQ2W+cE7YqKLDujZjBAwjqCEy1Dh5xJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kV7dIfGe; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772639477; x=1804175477;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=z/ke89GVh8nNVji/9e66asH0wbDfoGSapcyajl2e7iQ=;
  b=kV7dIfGe6uzj+2EpXM9KZKrNmmhPmtNRkTsJK7jxzEu7Haz1nB84TITv
   unuLHoZL3fvYutiBLhg2n1gY97pMZnrT7oAXGxPhEgEDMCyeoeTWZqDe+
   yoJkFyDrvIPtgMI+1HzdDJyFrtDDTXwT+3QNd7atrMf18wNN6P128rJJl
   H44qpa+s9/GoTpas/1JJyipDn29HNC0n4oxYhnPOva9QPjMgncmH0a2v6
   lRPMpsx3kEhz7WCsvoEpmwjy4bgVkIqyvUoRmFyP+7dgnBjpv1ep/GnW9
   6W/0dunsIL/53CJv7DxC7R3UyhjU4AHF/TGY+AAdJ4PgG2SvI8TR/2kRc
   A==;
X-CSE-ConnectionGUID: V83HfKHCTee/V7dyrK0xQA==
X-CSE-MsgGUID: rmsMDRGgStO0/5YYOxoLew==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="285599077"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:51:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 08:50:45 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 08:50:42 -0700
Message-ID: <35131cd06fc5f8b5b37f315bc5ab2b283dbe29fb.camel@microchip.com>
Subject: Re: [PATCH net-next 8/8] net: dsa: lan9645x: add port statistics
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
Date: Wed, 4 Mar 2026 16:50:41 +0100
In-Reply-To: <20260303160159.efjtqzpa2w4awxht@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-8-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-8-bff8ca1396f5@microchip.com>
	 <20260303160159.efjtqzpa2w4awxht@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 307BF2037B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263887-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 18:01 +0200, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Tue, Mar 03, 2026 at 01:22:34PM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > Add statistics support for the port counters. Chip registers are 32 bit=
,
> > so this unit is responsible maintaining a 64bit software cache, and
> > updating it frequently to handle overflows in hardware.
> >=20
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzosterga=
ard@microchip.com>
> > ---
> >  drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  82 ++
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |   3 +
> >  .../net/dsa/microchip/lan9645x/lan9645x_stats.c    | 825 +++++++++++++=
++++++++
> >  .../net/dsa/microchip/lan9645x/lan9645x_stats.h    | 288 +++++++
> >  5 files changed, 1199 insertions(+)
> >=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/=
dsa/microchip/lan9645x/Makefile
> > index a90a46f81c72..486b005cf740 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/Makefile
> > +++ b/drivers/net/dsa/microchip/lan9645x/Makefile
> > @@ -7,3 +7,4 @@ mchp-lan9645x-objs :=3D lan9645x_main.o \
> >       lan9645x_phylink.o \
> >       lan9645x_vlan.o \
> >       lan9645x_mac.o \
> > +     lan9645x_stats.o \
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index ba76279b4414..8a1de2588ab8 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/phy/phy.h>
> >=20
> >  #include "lan9645x_main.h"
> > +#include "lan9645x_stats.h"
> >=20
> >  static const char *lan9645x_resource_names[NUM_TARGETS + 1] =3D {
> >       [TARGET_GCB]          =3D "gcb",
> > @@ -79,6 +80,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
> >       debugfs_remove_recursive(lan9645x->debugfs_root);
> >       lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
> >       lan9645x_mac_deinit(lan9645x);
> > +     lan9645x_stats_deinit(lan9645x);
> >  }
> >=20
> >  static int lan9645x_change_mtu(struct dsa_switch *ds, int port, int ne=
w_mtu)
> > @@ -274,6 +276,12 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >=20
> >       lan9645x_port_set_tail_drop_wm(lan9645x);
> >=20
> > +     err =3D lan9645x_stats_init(lan9645x);
> > +     if (err) {
> > +             dev_err(dev, "Lan9645x setup: failed to init stats.");
>=20
> Missing \n.
> Also "Lan9645x" probably not required, it will be somewhere in the
> driver name.
>=20

I will remote the lan9645x and add newline.

> > +             return err;
> > +     }
> > +
> >       ds->mtu_enforcement_ingress =3D true;
> >       ds->assisted_learning_on_cpu_port =3D true;
> >       ds->fdb_isolation =3D true;
> > @@ -636,6 +644,68 @@ static int lan9645x_fdb_del(struct dsa_switch *ds,=
 int port,
> >       return __lan9645x_fdb_del(lan9645x, port, addr, vid, br);
> >  }
> >=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.h
> > index 4c7111375918..fe801d0ed39a 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> > @@ -217,6 +217,9 @@ struct lan9645x {
> >       u8 vlan_flags[VLAN_N_VID];
> >       DECLARE_BITMAP(cpu_vlan_mask, VLAN_N_VID); /* CPU VLAN membership=
 */
> >=20
> > +     /* Statistics  */
> > +     struct lan9645x_stats *stats;
> > +
> >       int num_port_dis;
> >       bool dd_dis;
> >       bool tsn_dis;
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/driv=
ers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > new file mode 100644
> > index 000000000000..43078e441e55
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > @@ -0,0 +1,825 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (C) 2026 Microchip Technology Inc.
> > + */
> > +
> > +#include <linux/workqueue.h>
> > +#include <linux/debugfs.h>
> > +
> > +#include "lan9645x_main.h"
> > +#include "lan9645x_stats.h"
> > +
> > +#define LAN9645X_STATS_CHECK_DELAY   (3 * HZ)
> > +
> > +static const struct lan9645x_stat_region lan9645x_port_stat_regions[] =
=3D {
> > +     /* RX region */
> > +     { .base_offset =3D 0x0, .cnt =3D 67, .cnts_base_idx =3D 0 },
> > +     /* TX region */
> > +     { .base_offset =3D 0x80, .cnt =3D 48, .cnts_base_idx =3D 67 },
> > +     /* DR region */
> > +     { .base_offset =3D 0x100, .cnt =3D 18, .cnts_base_idx =3D 115 },
> > +};
>=20
> Did you find any bug in ocelot_prepare_stats_regions(), which is
> supposed to automatically build regions of contiguous stats registers
> from just their declarations? Because I find this super error-prone and
> hard to maintain in the long term, especially with cherry-picks on
> stable branches and so on.
>=20

No I did not find a bug in ocelot_prepare_stats_regions. I will try to take
a look and borrow it if I can. I agree this would be terrible to maintain b=
y
hand.
I got a machine generated description of the stats registers and names from=
 the
designers and used that to generate the tables. In the out-of-tree driver
I added all the stats at once, so it was a one-off thing.

> > +
> > +static const struct lan9645x_stat_layout lan9645x_port_stats_layout[] =
=3D {
> > +     { .name =3D "rx_oct",                .offset =3D 0x0 },
>=20
> New drivers which report a counter through standard ethtool API aren't
> supposed to need a driver-specific string for it.
>=20

Ok, I was not aware, I will try to do this right.

> > +     { .name =3D "rx_uc",                 .offset =3D 0x1 },
> > +     { .name =3D "rx_mc",                 .offset =3D 0x2 },
> > +     { .name =3D "rx_bc",                 .offset =3D 0x3 },
> > +     { .name =3D "rx_short",              .offset =3D 0x4 },
> > +     { .name =3D "rx_frag",               .offset =3D 0x5 },
> > +     { .name =3D "rx_jabber",             .offset =3D 0x6 },
> > +     { .name =3D "rx_crc",                .offset =3D 0x7 },
> > +     { .name =3D "rx_symbol_err",         .offset =3D 0x8 },
> > +     { .name =3D "rx_sz_64",              .offset =3D 0x9 },
> > +     { .name =3D "rx_sz_65_127",          .offset =3D 0xa },
> > +     { .name =3D "rx_sz_128_255",         .offset =3D 0xb },
> > +     { .name =3D "rx_sz_256_511",         .offset =3D 0xc },
> > +     { .name =3D "rx_sz_512_1023",        .offset =3D 0xd },
> > +     { .name =3D "rx_sz_1024_1526",       .offset =3D 0xe },
> > +     { .name =3D "rx_sz_jumbo",           .offset =3D 0xf },
> > +     { .name =3D "rx_pause",              .offset =3D 0x10 },
> > +     { .name =3D "rx_control",            .offset =3D 0x11 },
> > +     { .name =3D "rx_long",               .offset =3D 0x12 },
> > +     { .name =3D "rx_cat_drop",           .offset =3D 0x13 },
> > +     { .name =3D "rx_red_prio_0",         .offset =3D 0x14 },
> > +     { .name =3D "rx_red_prio_1",         .offset =3D 0x15 },
> > +     { .name =3D "rx_red_prio_2",         .offset =3D 0x16 },
> > +     { .name =3D "rx_red_prio_3",         .offset =3D 0x17 },
> > +     { .name =3D "rx_red_prio_4",         .offset =3D 0x18 },
> > +     { .name =3D "rx_red_prio_5",         .offset =3D 0x19 },
> > +     { .name =3D "rx_red_prio_6",         .offset =3D 0x1a },
> > +     { .name =3D "rx_red_prio_7",         .offset =3D 0x1b },
> > +     { .name =3D "rx_yellow_prio_0",      .offset =3D 0x1c },
> > +     { .name =3D "rx_yellow_prio_1",      .offset =3D 0x1d },
> > +     { .name =3D "rx_yellow_prio_2",      .offset =3D 0x1e },
> > +     { .name =3D "rx_yellow_prio_3",      .offset =3D 0x1f },
> > +     { .name =3D "rx_yellow_prio_4",      .offset =3D 0x20 },
> > +     { .name =3D "rx_yellow_prio_5",      .offset =3D 0x21 },
> > +     { .name =3D "rx_yellow_prio_6",      .offset =3D 0x22 },
> > +     { .name =3D "rx_yellow_prio_7",      .offset =3D 0x23 },
> > +     { .name =3D "rx_green_prio_0",       .offset =3D 0x24 },
> > +     { .name =3D "rx_green_prio_1",       .offset =3D 0x25 },
> > +     { .name =3D "rx_green_prio_2",       .offset =3D 0x26 },
> > +     { .name =3D "rx_green_prio_3",       .offset =3D 0x27 },
> > +     { .name =3D "rx_green_prio_4",       .offset =3D 0x28 },
> > +     { .name =3D "rx_green_prio_5",       .offset =3D 0x29 },
> > +     { .name =3D "rx_green_prio_6",       .offset =3D 0x2a },
> > +     { .name =3D "rx_green_prio_7",       .offset =3D 0x2b },
> > +     { .name =3D "rx_assembly_err",       .offset =3D 0x2c },
> > +     { .name =3D "rx_smd_err",            .offset =3D 0x2d },
> > +     { .name =3D "rx_assembly_ok",        .offset =3D 0x2e },
> > +     { .name =3D "rx_merge_frag",         .offset =3D 0x2f },
> > +     { .name =3D "rx_pmac_oct",           .offset =3D 0x30 },
> > +     { .name =3D "rx_pmac_uc",            .offset =3D 0x31 },
> > +     { .name =3D "rx_pmac_mc",            .offset =3D 0x32 },
> > +     { .name =3D "rx_pmac_bc",            .offset =3D 0x33 },
> > +     { .name =3D "rx_pmac_short",         .offset =3D 0x34 },
> > +     { .name =3D "rx_pmac_frag",          .offset =3D 0x35 },
> > +     { .name =3D "rx_pmac_jabber",        .offset =3D 0x36 },
> > +     { .name =3D "rx_pmac_crc",           .offset =3D 0x37 },
> > +     { .name =3D "rx_pmac_symbol_err",    .offset =3D 0x38 },
> > +     { .name =3D "rx_pmac_sz_64",         .offset =3D 0x39 },
> > +     { .name =3D "rx_pmac_sz_65_127",     .offset =3D 0x3a },
> > +     { .name =3D "rx_pmac_sz_128_255",    .offset =3D 0x3b },
> > +     { .name =3D "rx_pmac_sz_256_511",    .offset =3D 0x3c },
> > +     { .name =3D "rx_pmac_sz_512_1023",   .offset =3D 0x3d },
> > +     { .name =3D "rx_pmac_sz_1024_1526",  .offset =3D 0x3e },
> > +     { .name =3D "rx_pmac_sz_jumbo",      .offset =3D 0x3f },
> > +     { .name =3D "rx_pmac_pause",         .offset =3D 0x40 },
> > +     { .name =3D "rx_pmac_control",       .offset =3D 0x41 },
> > +     { .name =3D "rx_pmac_long",          .offset =3D 0x42 },
> > +     { .name =3D "tx_oct",                .offset =3D 0x80 },
> > +     { .name =3D "tx_uc",                 .offset =3D 0x81 },
> > +     { .name =3D "tx_mc",                 .offset =3D 0x82 },
> > +     { .name =3D "tx_bc",                 .offset =3D 0x83 },
> > +     { .name =3D "tx_col",                .offset =3D 0x84 },
> > +     { .name =3D "tx_drop",               .offset =3D 0x85 },
> > +     { .name =3D "tx_pause",              .offset =3D 0x86 },
> > +     { .name =3D "tx_sz_64",              .offset =3D 0x87 },
> > +     { .name =3D "tx_sz_65_127",          .offset =3D 0x88 },
> > +     { .name =3D "tx_sz_128_255",         .offset =3D 0x89 },
> > +     { .name =3D "tx_sz_256_511",         .offset =3D 0x8a },
> > +     { .name =3D "tx_sz_512_1023",        .offset =3D 0x8b },
> > +     { .name =3D "tx_sz_1024_1526",       .offset =3D 0x8c },
> > +     { .name =3D "tx_sz_jumbo",           .offset =3D 0x8d },
> > +     { .name =3D "tx_yellow_prio_0",      .offset =3D 0x8e },
> > +     { .name =3D "tx_yellow_prio_1",      .offset =3D 0x8f },
> > +     { .name =3D "tx_yellow_prio_2",      .offset =3D 0x90 },
> > +     { .name =3D "tx_yellow_prio_3",      .offset =3D 0x91 },
> > +     { .name =3D "tx_yellow_prio_4",      .offset =3D 0x92 },
> > +     { .name =3D "tx_yellow_prio_5",      .offset =3D 0x93 },
> > +     { .name =3D "tx_yellow_prio_6",      .offset =3D 0x94 },
> > +     { .name =3D "tx_yellow_prio_7",      .offset =3D 0x95 },
> > +     { .name =3D "tx_green_prio_0",       .offset =3D 0x96 },
> > +     { .name =3D "tx_green_prio_1",       .offset =3D 0x97 },
> > +     { .name =3D "tx_green_prio_2",       .offset =3D 0x98 },
> > +     { .name =3D "tx_green_prio_3",       .offset =3D 0x99 },
> > +     { .name =3D "tx_green_prio_4",       .offset =3D 0x9a },
> > +     { .name =3D "tx_green_prio_5",       .offset =3D 0x9b },
> > +     { .name =3D "tx_green_prio_6",       .offset =3D 0x9c },
> > +     { .name =3D "tx_green_prio_7",       .offset =3D 0x9d },
> > +     { .name =3D "tx_aged",               .offset =3D 0x9e },
> > +     { .name =3D "tx_llct",               .offset =3D 0x9f },
> > +     { .name =3D "tx_ct",                 .offset =3D 0xa0 },
> > +     { .name =3D "tx_bufdrop",            .offset =3D 0xa1 },
> > +     { .name =3D "tx_mm_hold",            .offset =3D 0xa2 },
> > +     { .name =3D "tx_merge_frag",         .offset =3D 0xa3 },
> > +     { .name =3D "tx_pmac_oct",           .offset =3D 0xa4 },
> > +     { .name =3D "tx_pmac_uc",            .offset =3D 0xa5 },
> > +     { .name =3D "tx_pmac_mc",            .offset =3D 0xa6 },
> > +     { .name =3D "tx_pmac_bc",            .offset =3D 0xa7 },
> > +     { .name =3D "tx_pmac_pause",         .offset =3D 0xa8 },
> > +     { .name =3D "tx_pmac_sz_64",         .offset =3D 0xa9 },
> > +     { .name =3D "tx_pmac_sz_65_127",     .offset =3D 0xaa },
> > +     { .name =3D "tx_pmac_sz_128_255",    .offset =3D 0xab },
> > +     { .name =3D "tx_pmac_sz_256_511",    .offset =3D 0xac },
> > +     { .name =3D "tx_pmac_sz_512_1023",   .offset =3D 0xad },
> > +     { .name =3D "tx_pmac_sz_1024_1526",  .offset =3D 0xae },
> > +     { .name =3D "tx_pmac_sz_jumbo",      .offset =3D 0xaf },
> > +     { .name =3D "dr_local",              .offset =3D 0x100 },
> > +     { .name =3D "dr_tail",               .offset =3D 0x101 },
> > +     { .name =3D "dr_yellow_prio_0",      .offset =3D 0x102 },
> > +     { .name =3D "dr_yellow_prio_1",      .offset =3D 0x103 },
> > +     { .name =3D "dr_yellow_prio_2",      .offset =3D 0x104 },
> > +     { .name =3D "dr_yellow_prio_3",      .offset =3D 0x105 },
> > +     { .name =3D "dr_yellow_prio_4",      .offset =3D 0x106 },
> > +     { .name =3D "dr_yellow_prio_5",      .offset =3D 0x107 },
> > +     { .name =3D "dr_yellow_prio_6",      .offset =3D 0x108 },
> > +     { .name =3D "dr_yellow_prio_7",      .offset =3D 0x109 },
> > +     { .name =3D "dr_green_prio_0",       .offset =3D 0x10a },
> > +     { .name =3D "dr_green_prio_1",       .offset =3D 0x10b },
> > +     { .name =3D "dr_green_prio_2",       .offset =3D 0x10c },
> > +     { .name =3D "dr_green_prio_3",       .offset =3D 0x10d },
> > +     { .name =3D "dr_green_prio_4",       .offset =3D 0x10e },
> > +     { .name =3D "dr_green_prio_5",       .offset =3D 0x10f },
> > +     { .name =3D "dr_green_prio_6",       .offset =3D 0x110 },
> > +     { .name =3D "dr_green_prio_7",       .offset =3D 0x111 },
> > +};
> > +
> > +static const struct lan9645x_view_stats lan9645x_view_stat_cfgs[] =3D =
{
> > +     [LAN9645X_STAT_PORTS] =3D {
> > +       .name =3D "ports",
> > +       .type =3D LAN9645X_STAT_PORTS,
> > +       .layout =3D lan9645x_port_stats_layout,
> > +       .num_cnts =3D ARRAY_SIZE(lan9645x_port_stats_layout),
> > +       .num_indexes =3D NUM_PHYS_PORTS,
> > +       .regions =3D lan9645x_port_stat_regions,
> > +       .num_regions =3D ARRAY_SIZE(lan9645x_port_stat_regions),
>=20
> Odd to mix spaces with tabs.
>=20

Ah yes I will fix this.

> > +     },
> > +};
> > +void
> > +lan9645x_stats_get_rmon_stats(struct lan9645x *lan9645x, int port,
> > +                           struct ethtool_rmon_stats *rmon_stats,
> > +                           const struct ethtool_rmon_hist_range **rang=
es)
> > +{
> > +     u64 *port_cnt;
> > +
> > +     mutex_lock(&lan9645x->stats->hw_lock);
> > +
> > +     __lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, p=
ort);
> > +
> > +     port_cnt =3D STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> > +
> > +     rmon_stats->undersize_pkts =3D
> > +             port_cnt[SCNT_RX_SHORT] +
> > +             port_cnt[SCNT_RX_PMAC_SHORT];
>=20
> You aren't supposed to sum up eMAC + pMAC stats except when
> rmon_stats->src =3D=3D ETHTOOL_MAC_STATS_SRC_AGGREGATE. Otherwise report
> them individually.
>=20
> Same thing for lan9645x_stats_get_eth_mac_stats().

Ok thank you I will fix this.

>=20
> > +     rmon_stats->oversize_pkts =3D
> > +             port_cnt[SCNT_RX_LONG] +
> > +             port_cnt[SCNT_RX_PMAC_LONG];
> > +     rmon_stats->fragments =3D
> > +             port_cnt[SCNT_RX_FRAG] +
> > +             port_cnt[SCNT_RX_PMAC_FRAG];
> > +     rmon_stats->jabbers =3D
> > +             port_cnt[SCNT_RX_JABBER] +
> > +             port_cnt[SCNT_RX_PMAC_JABBER];
> > +
> > +     rmon_stats->hist[0] =3D
> > +             port_cnt[SCNT_RX_SZ_64] +
> > +             port_cnt[SCNT_RX_PMAC_SZ_64];
> > +     rmon_stats->hist[1] =3D
> > +             port_cnt[SCNT_RX_SZ_65_127] +
> > +             port_cnt[SCNT_RX_PMAC_SZ_65_127];
> > +     rmon_stats->hist[2] =3D
> > +             port_cnt[SCNT_RX_SZ_128_255] +
> > +             port_cnt[SCNT_RX_PMAC_SZ_128_255];
> > +     rmon_stats->hist[3] =3D
> > +             port_cnt[SCNT_RX_SZ_256_511] +
> > +             port_cnt[SCNT_RX_PMAC_SZ_256_511];
> > +     rmon_stats->hist[4] =3D
> > +             port_cnt[SCNT_RX_SZ_512_1023] +
> > +             port_cnt[SCNT_RX_PMAC_SZ_512_1023];
> > +     rmon_stats->hist[5] =3D
> > +             port_cnt[SCNT_RX_SZ_1024_1526] +
> > +             port_cnt[SCNT_RX_PMAC_SZ_1024_1526];
> > +     rmon_stats->hist[6] =3D
> > +             port_cnt[SCNT_RX_SZ_JUMBO] +
> > +             port_cnt[SCNT_RX_PMAC_SZ_JUMBO];
> > +
> > +     rmon_stats->hist_tx[0] =3D
> > +             port_cnt[SCNT_TX_SZ_64] +
> > +             port_cnt[SCNT_TX_PMAC_SZ_64];
> > +     rmon_stats->hist_tx[1] =3D
> > +             port_cnt[SCNT_TX_SZ_65_127] +
> > +             port_cnt[SCNT_TX_PMAC_SZ_65_127];
> > +     rmon_stats->hist_tx[2] =3D
> > +             port_cnt[SCNT_TX_SZ_128_255] +
> > +             port_cnt[SCNT_TX_PMAC_SZ_128_255];
> > +     rmon_stats->hist_tx[3] =3D
> > +             port_cnt[SCNT_TX_SZ_256_511] +
> > +             port_cnt[SCNT_TX_PMAC_SZ_256_511];
> > +     rmon_stats->hist_tx[4] =3D
> > +             port_cnt[SCNT_TX_SZ_512_1023] +
> > +             port_cnt[SCNT_TX_PMAC_SZ_512_1023];
> > +     rmon_stats->hist_tx[5] =3D
> > +             port_cnt[SCNT_TX_SZ_1024_1526] +
> > +             port_cnt[SCNT_TX_PMAC_SZ_1024_1526];
> > +     rmon_stats->hist_tx[6] =3D
> > +             port_cnt[SCNT_TX_SZ_JUMBO] +
> > +             port_cnt[SCNT_TX_PMAC_SZ_JUMBO];
> > +
> > +     mutex_unlock(&lan9645x->stats->hw_lock);
> > +
> > +     *ranges =3D lan9645x_rmon_ranges;
> > +}
> > +
> > +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> > +                             struct rtnl_link_stats64 *stats)
> > +{
> > +     u64 *port_cnt;
> > +
> > +     /* Avoid stats update, as this is called very often by DSA. */
> > +     mutex_lock(&lan9645x->stats->hw_lock);
>=20
> This is atomic context, you can't acquire a mutex which may be held by a
> process which sleeps, which also puts you to sleep for it.
>=20
> This is why ocelot->stats_lock is a spinlock, different from
> ocelot->stat_view_lock (your lan9645x->stats->hw_lock).
>=20
> No problem with not updating the stats upon ndo_get_stats64() call,
> given the fact that the context is atomic.
>=20

Good point. I will look into adding a spinlock, because I believe I need
some locking here to avoid torn reads if the host cpu is 32bit.
And I will add a comment about atomic context.

> > +
> > +     port_cnt =3D STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> > +
> > +     stats->rx_bytes =3D port_cnt[SCNT_RX_OCT] +
> > +                       port_cnt[SCNT_RX_PMAC_OCT];
> > +
> > +     stats->rx_packets =3D port_cnt[SCNT_RX_SHORT] +
> > +                         port_cnt[SCNT_RX_FRAG] +
> > +                         port_cnt[SCNT_RX_JABBER] +
> > +                         port_cnt[SCNT_RX_CRC] +
> > +                         port_cnt[SCNT_RX_SYMBOL_ERR] +
> > +                         port_cnt[SCNT_RX_SZ_64] +
> > +                         port_cnt[SCNT_RX_SZ_65_127] +
> > +                         port_cnt[SCNT_RX_SZ_128_255] +
> > +                         port_cnt[SCNT_RX_SZ_256_511] +
> > +                         port_cnt[SCNT_RX_SZ_512_1023] +
> > +                         port_cnt[SCNT_RX_SZ_1024_1526] +
> > +                         port_cnt[SCNT_RX_SZ_JUMBO] +
> > +                         port_cnt[SCNT_RX_LONG] +
> > +                         port_cnt[SCNT_RX_PMAC_SHORT] +
> > +                         port_cnt[SCNT_RX_PMAC_FRAG] +
> > +                         port_cnt[SCNT_RX_PMAC_JABBER] +
> > +                         port_cnt[SCNT_RX_PMAC_SZ_64] +
> > +                         port_cnt[SCNT_RX_PMAC_SZ_65_127] +
> > +                         port_cnt[SCNT_RX_PMAC_SZ_128_255] +
> > +                         port_cnt[SCNT_RX_PMAC_SZ_256_511] +
> > +                         port_cnt[SCNT_RX_PMAC_SZ_512_1023] +
> > +                         port_cnt[SCNT_RX_PMAC_SZ_1024_1526] +
> > +                         port_cnt[SCNT_RX_PMAC_SZ_JUMBO];
> > +
> > +     stats->multicast =3D port_cnt[SCNT_RX_MC] +
> > +                        port_cnt[SCNT_RX_PMAC_MC];
> > +
> > +     stats->rx_errors =3D port_cnt[SCNT_RX_SHORT] +
> > +                        port_cnt[SCNT_RX_FRAG] +
> > +                        port_cnt[SCNT_RX_JABBER] +
> > +                        port_cnt[SCNT_RX_CRC] +
> > +                        port_cnt[SCNT_RX_SYMBOL_ERR] +
> > +                        port_cnt[SCNT_RX_LONG] +
> > +                        port_cnt[SCNT_RX_PMAC_SHORT] +
> > +                        port_cnt[SCNT_RX_PMAC_FRAG] +
> > +                        port_cnt[SCNT_RX_PMAC_JABBER] +
> > +                        port_cnt[SCNT_RX_PMAC_CRC] +
> > +                        port_cnt[SCNT_RX_PMAC_SYMBOL_ERR] +
> > +                        port_cnt[SCNT_RX_PMAC_LONG];
> > +
> > +     stats->rx_dropped =3D port_cnt[SCNT_RX_LONG] +
> > +                         port_cnt[SCNT_DR_LOCAL] +
> > +                         port_cnt[SCNT_DR_TAIL] +
> > +                         port_cnt[SCNT_RX_CAT_DROP] +
> > +                         port_cnt[SCNT_RX_RED_PRIO_0] +
> > +                         port_cnt[SCNT_RX_RED_PRIO_1] +
> > +                         port_cnt[SCNT_RX_RED_PRIO_2] +
> > +                         port_cnt[SCNT_RX_RED_PRIO_3] +
> > +                         port_cnt[SCNT_RX_RED_PRIO_4] +
> > +                         port_cnt[SCNT_RX_RED_PRIO_5] +
> > +                         port_cnt[SCNT_RX_RED_PRIO_6] +
> > +                         port_cnt[SCNT_RX_RED_PRIO_7];
> > +
> > +     for (int i =3D 0; i < LAN9645X_NUM_TC; i++) {
> > +             stats->rx_dropped +=3D port_cnt[SCNT_DR_YELLOW_PRIO_0 + i=
] +
> > +                                  port_cnt[SCNT_DR_GREEN_PRIO_0 + i];
> > +     }
> > +
> > +     stats->tx_bytes =3D port_cnt[SCNT_TX_OCT] +
> > +                       port_cnt[SCNT_TX_PMAC_OCT];
> > +
> > +     stats->tx_packets =3D port_cnt[SCNT_TX_SZ_64] +
> > +                         port_cnt[SCNT_TX_SZ_65_127] +
> > +                         port_cnt[SCNT_TX_SZ_128_255] +
> > +                         port_cnt[SCNT_TX_SZ_256_511] +
> > +                         port_cnt[SCNT_TX_SZ_512_1023] +
> > +                         port_cnt[SCNT_TX_SZ_1024_1526] +
> > +                         port_cnt[SCNT_TX_SZ_JUMBO] +
> > +                         port_cnt[SCNT_TX_PMAC_SZ_64] +
> > +                         port_cnt[SCNT_TX_PMAC_SZ_65_127] +
> > +                         port_cnt[SCNT_TX_PMAC_SZ_128_255] +
> > +                         port_cnt[SCNT_TX_PMAC_SZ_256_511] +
> > +                         port_cnt[SCNT_TX_PMAC_SZ_512_1023] +
> > +                         port_cnt[SCNT_TX_PMAC_SZ_1024_1526] +
> > +                         port_cnt[SCNT_TX_PMAC_SZ_JUMBO];
> > +
> > +     stats->tx_dropped =3D port_cnt[SCNT_TX_DROP] +
> > +                         port_cnt[SCNT_TX_AGED];
> > +
> > +     stats->collisions =3D port_cnt[SCNT_TX_COL];
> > +
> > +     mutex_unlock(&lan9645x->stats->hw_lock);
> > +}
> > +
> > +void lan9645x_stats_get_eth_phy_stats(struct lan9645x *lan9645x, int p=
ort,
> > +                                   struct ethtool_eth_phy_stats *phy_s=
tats)
> > +{
> > +     u64 *port_cnt;
> > +
> > +     mutex_lock(&lan9645x->stats->hw_lock);
> > +
> > +     __lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, p=
ort);
> > +
> > +     port_cnt =3D STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> > +
> > +     switch (phy_stats->src) {
> > +     case ETHTOOL_MAC_STATS_SRC_EMAC:
> > +             phy_stats->SymbolErrorDuringCarrier =3D
> > +                     port_cnt[SCNT_RX_SYMBOL_ERR];
> > +             break;
> > +     case ETHTOOL_MAC_STATS_SRC_PMAC:
> > +             phy_stats->SymbolErrorDuringCarrier =3D
> > +                     port_cnt[SCNT_RX_PMAC_SYMBOL_ERR];
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     mutex_unlock(&lan9645x->stats->hw_lock);
> > +}
> > +
> > +void
> > +lan9645x_stats_get_eth_ctrl_stats(struct lan9645x *lan9645x, int port,
> > +                               struct ethtool_eth_ctrl_stats *ctrl_sta=
ts)
> > +{
> > +     u64 *port_cnt;
> > +
> > +     mutex_lock(&lan9645x->stats->hw_lock);
> > +
> > +     __lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, p=
ort);
> > +
> > +     port_cnt =3D STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> > +
> > +     switch (ctrl_stats->src) {
> > +     case ETHTOOL_MAC_STATS_SRC_EMAC:
> > +             ctrl_stats->MACControlFramesReceived =3D
> > +                     port_cnt[SCNT_RX_CONTROL];
> > +             break;
> > +     case ETHTOOL_MAC_STATS_SRC_PMAC:
> > +             ctrl_stats->MACControlFramesReceived =3D
> > +                     port_cnt[SCNT_RX_PMAC_CONTROL];
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     mutex_unlock(&lan9645x->stats->hw_lock);
> > +}
> > +
> > +void lan9645x_stats_get_pause_stats(struct lan9645x *lan9645x, int por=
t,
> > +                                 struct ethtool_pause_stats *ps)
> > +{
> > +     u64 *port_cnt;
> > +
> > +     mutex_lock(&lan9645x->stats->hw_lock);
> > +
> > +     __lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, p=
ort);
> > +
> > +     port_cnt =3D STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> > +
> > +     switch (ps->src) {
> > +     case ETHTOOL_MAC_STATS_SRC_EMAC:
> > +             ps->tx_pause_frames =3D port_cnt[SCNT_TX_PAUSE];
> > +             ps->rx_pause_frames =3D port_cnt[SCNT_RX_PAUSE];
> > +             break;
> > +     case ETHTOOL_MAC_STATS_SRC_PMAC:
> > +             ps->tx_pause_frames =3D port_cnt[SCNT_TX_PMAC_PAUSE];
> > +             ps->rx_pause_frames =3D port_cnt[SCNT_RX_PMAC_PAUSE];
> > +             break;
>=20
> ...no aggregate? I guess this will just return zeroes under normal
> operation, and not anything useful? Similar thing everywhere you look
> for the source of statistics.
>=20
> BTW, Ioana is working on a selftest that makes sure standard counters
> are implemeted correctly.
> https://lore.kernel.org/netdev/20260225150648.1542206-6-ioana.ciornei@nxp=
.com/
>=20
> The test packaging still needs to be improved, but it's functional.
> Maybe you could give it a run? I'm thinking it would have caught this.
>=20

I will add the aggregate handling and try out the selftest patch.

> > +     default:
> > +             break;
> > +     }
> > +
> > +     mutex_unlock(&lan9645x->stats->hw_lock);
> > +}
> > +
> > +void lan9645x_stats_get_mm_stats(struct lan9645x *lan9645x, int port,
> > +                              struct ethtool_mm_stats *stats)
> > +{
> > +     u64 *port_cnt;
> > +
> > +     mutex_lock(&lan9645x->stats->hw_lock);
> > +
> > +     __lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, p=
ort);
> > +
> > +     port_cnt =3D STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> > +
> > +     stats->MACMergeFrameAssErrorCount =3D port_cnt[SCNT_RX_ASSEMBLY_E=
RR];
> > +     stats->MACMergeFrameSmdErrorCount =3D port_cnt[SCNT_RX_SMD_ERR];
> > +     stats->MACMergeFrameAssOkCount =3D port_cnt[SCNT_RX_ASSEMBLY_OK];
> > +     stats->MACMergeFragCountRx =3D port_cnt[SCNT_RX_MERGE_FRAG];
> > +     stats->MACMergeFragCountTx =3D port_cnt[SCNT_TX_MERGE_FRAG];
> > +     stats->MACMergeHoldCount =3D port_cnt[SCNT_TX_MM_HOLD];
> > +
> > +     mutex_unlock(&lan9645x->stats->hw_lock);
> > +}
> > +
> > +void lan9645x_stats_clear_counters(struct lan9645x *lan9645x,
> > +                                enum lan9645x_view_stat_type type, int=
 idx)
>=20
> Never called, please remove. Don't leave dead code in the driver.
>=20

I will remove it.

> > +{
> > +     struct lan9645x_view_stats *vstats =3D
> > +             lan9645x_get_vstats(lan9645x, type);
> > +     u64 *idx_grp;
> > +     int cntr;
> > +     u32 sel;
> > +
> > +     switch (type) {
> > +     case LAN9645X_STAT_PORTS:
> > +             /* Drop, TX and RX counters */
> > +             sel =3D BIT(2) | BIT(1) | BIT(0);
> > +             break;
> > +     case LAN9645X_STAT_ISDX:
> > +             /* ISDX and FRER seq gen */
> > +             sel =3D BIT(5) | BIT(3);
> > +             break;
> > +     case LAN9645X_STAT_ESDX:
> > +             /* ESDX */
> > +             sel =3D BIT(6);
> > +             break;
> > +     case LAN9645X_STAT_SFID:
> > +             /* Stream filter */
> > +             sel =3D BIT(4);
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     mutex_lock(&lan9645x->stats->hw_lock);
> > +
> > +     lan_wr(SYS_STAT_CFG_STAT_CLEAR_SHOT_SET(sel) |
> > +            SYS_STAT_CFG_STAT_VIEW_SET(idx),
> > +            lan9645x, SYS_STAT_CFG);
> > +
> > +     idx_grp =3D STATS_INDEX(vstats, idx);
> > +     for (cntr =3D 0; cntr < vstats->num_cnts; cntr++)
> > +             idx_grp[cntr] =3D 0;
> > +
> > +     mutex_unlock(&lan9645x->stats->hw_lock);
> > +}
> > +
> > +static void lan9645x_check_stats_work(struct work_struct *work)
> > +{
> > +     struct delayed_work *del_work =3D to_delayed_work(work);
> > +     struct lan9645x_stats *stats;
> > +
> > +     stats =3D container_of(del_work, struct lan9645x_stats, work);
> > +
> > +     lan9645x_stats_update(stats->lan9645x);
> > +
> > +     queue_delayed_work(stats->queue, &stats->work,
> > +                        LAN9645X_STATS_CHECK_DELAY);
> > +}
> > +
> > +static int lan9645x_stats_debugfs_show(struct seq_file *m, void *unuse=
d)
> > +{
> > +     struct lan9645x_view_stats *vstats =3D m->private;
> > +     int idx, cntr;
> > +     size_t total;
> > +     u64 *snap;
> > +
> > +     total =3D vstats->num_cnts * vstats->num_indexes;
> > +
> > +     /* Snapshot counters under lock to avoid holding hw_lock during
> > +      * slow seq_printf output.
> > +      */
> > +     snap =3D kmalloc_array(total, sizeof(u64), GFP_KERNEL);
> > +     if (!snap)
> > +             return -ENOMEM;
> > +
> > +     mutex_lock(&vstats->stats->hw_lock);
> > +     memcpy(snap, vstats->cnts, total * sizeof(u64));
> > +     mutex_unlock(&vstats->stats->hw_lock);
> > +
> > +     for (idx =3D 0; idx < vstats->num_indexes; idx++) {
> > +             for (cntr =3D 0; cntr < vstats->num_cnts; cntr++) {
> > +                     seq_printf(m, "%s_%d_%-*s %llu\n", vstats->name, =
idx,
> > +                                30, vstats->layout[cntr].name,
> > +                                snap[vstats->num_cnts * idx + cntr]);
> > +             }
> > +     }
> > +
> > +     kfree(snap);
> > +     return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(lan9645x_stats_debugfs);
>=20
> What is the purpose of a 'stats' debugfs?
>=20
> If this is about standard ethtool stats on the CPU port, we need a
> larger discussion about this, since it is a common problem for multiple
> drivers.
>=20
> I had a prototype patch to permit "ethtool" to be run on devlink ports
> (we do have one of those on the CPU port). But I never had time to start
> a discussion about it.
>=20

Yes I used it to expose _all_ hardware counters for all views and indices. =
In
particular, the cpu port. I used it for debugging, but I will remove it
and the parent debugfs.
Is devlink a valid use for something like this?


> > +
> > +static void lan9645x_stats_debugfs(struct lan9645x *lan9645x,
> > +                                struct dentry *parent)
> > +{
> > +     struct lan9645x_stats *stats =3D lan9645x->stats;
> > +     struct dentry *dir;
> > +     int i;
> > +
> > +     dir =3D debugfs_create_dir("stats", parent);
> > +     if (PTR_ERR_OR_ZERO(dir))
> > +             return;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(stats->view); i++)
> > +             debugfs_create_file(stats->view[i].name, 0444, dir,
> > +                                 &stats->view[i],
> > +                                 &lan9645x_stats_debugfs_fops);
> > +}
> > +
> > +static int lan9645x_view_stat_init(struct lan9645x *lan9645x,
> > +                                struct lan9645x_view_stats *vstat,
> > +                                const struct lan9645x_view_stats *cfg)
> > +{
> > +     size_t total =3D cfg->num_cnts * cfg->num_indexes;
> > +
> > +     memcpy(vstat, cfg, sizeof(*cfg));
> > +
> > +     vstat->cnts =3D devm_kcalloc(lan9645x->dev, total, sizeof(u64),
> > +                                GFP_KERNEL);
> > +     if (!vstat->cnts)
> > +             return -ENOMEM;
> > +
> > +     vstat->buf =3D devm_kcalloc(lan9645x->dev, total, sizeof(u32),
> > +                               GFP_KERNEL);
> > +     if (!vstat->buf)
> > +             return -ENOMEM;
> > +
> > +     vstat->stats =3D lan9645x->stats;
> > +
> > +     return 0;
> > +}
> > +
> > +int lan9645x_stats_init(struct lan9645x *lan9645x)
> > +{
> > +     const struct lan9645x_view_stats *vs;
> > +     struct lan9645x_stats *stats;
> > +     int err, i;
> > +
> > +     lan9645x->stats =3D devm_kzalloc(lan9645x->dev, sizeof(*stats),
> > +                                    GFP_KERNEL);
> > +     if (!lan9645x->stats)
> > +             return -ENOMEM;
> > +
> > +     stats =3D lan9645x->stats;
> > +     stats->lan9645x =3D lan9645x;
> > +
> > +     mutex_init(&stats->hw_lock);
> > +     stats->queue =3D alloc_ordered_workqueue("lan9645x-stats", 0);
> > +     if (!stats->queue)
> > +             return -ENOMEM;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(lan9645x_view_stat_cfgs); i++) {
> > +             vs =3D &lan9645x_view_stat_cfgs[i];
> > +
> > +             if (!vs->num_cnts)
> > +                     continue;
> > +
> > +             err =3D lan9645x_view_stat_init(lan9645x, &stats->view[vs=
->type],
> > +                                           vs);
> > +             if (err)
>=20
> stats->queue is leaked.
>=20

Ah yes, thanks.

> > +                     return err;
> > +     }
> > +
> > +     INIT_DELAYED_WORK(&stats->work, lan9645x_check_stats_work);
> > +     queue_delayed_work(stats->queue, &stats->work,
> > +                        LAN9645X_STATS_CHECK_DELAY);
> > +
> > +     lan9645x_stats_debugfs(lan9645x, lan9645x->debugfs_root);
> > +
> > +     return 0;
> > +}
> >=20
> >=20
>=20

Thank you for the comments,
Emil

