Return-Path: <netdev+bounces-263862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HZXLpdPqGmvsgAAu9opvQ
	(envelope-from <netdev+bounces-263862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:28:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6007202AA5
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C93C8306FCDD
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20ED33A007;
	Wed,  4 Mar 2026 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B++dUHFp"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38C731E106;
	Wed,  4 Mar 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637844; cv=none; b=rTh+chI3wP7TGhikp7yam1qbDiPRh6cevTjOawSdA5iF5XTwcxIY+ZKYcGKA2AzU6JqSyygr0aaGQuGZvbp0mGonveC+x8FFqzkWnTHQ63WybDGCvLjDbQJsjJbwJ7FRK67GsDBdjnhVbZxIZbXNtev2Rxp+WR0JLsnlxKsmEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637844; c=relaxed/simple;
	bh=Hw4fGNIjdfhodMoIpG7Z7KS180pIXRVgFvIDKZ363S0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EOAfsB7cW7tmEnqwhZXmhKhUdin26hfWPgOo4wkel3fLhgco+ydhEXYAAxNFMEawP5RHGBVKHjPHVdxGio2TDMWytR16CbrX9f0cwObCOmvmuItrzkz3vN7r/Is2UPywnHZq3yoLdHVCE5UTSdj6HuUksPkvbUWlG3bvkszJvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B++dUHFp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772637843; x=1804173843;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Hw4fGNIjdfhodMoIpG7Z7KS180pIXRVgFvIDKZ363S0=;
  b=B++dUHFpqNDqZuN/A4dhLW25cyqfucR434WWGcanyk+3YMV1p7EmZ7J8
   MbjbSwjqlSpN3xPVg9BcLE+9HoHRTBAL9yaKu2uSXF/EA8QhmjITA6t0s
   ZN6u/bAzKKqLP8z2r/r6Ic8qBwFS57hBZ+5muePL04tJbbUnynx2O1e82
   lk/JLP8gy9tDqzitDAMOWXOsIyWPKLDvNkyMAqTH784miUIo2ieKKx11p
   KvXg45PQVSTt2B4Y+tyhw67jVUl0Mbgh+dN8bWsJToDx/U7xqNAfdjBy5
   M6aZJ0uz5GxD9ljFST3mm09HjXvsMU82XjkOKdg/wwdC4yGsm4oTiXirj
   g==;
X-CSE-ConnectionGUID: t9hixU6yQkmR9P9EAoZgiw==
X-CSE-MsgGUID: X1AgBhfqSsufSel+8TYbEw==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="285597312"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2026 08:24:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 4 Mar 2026 08:23:55 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 08:23:52 -0700
Message-ID: <67a34d22b8f59964fd3bfaee99c8418a21526f3e.camel@microchip.com>
Subject: Re: [PATCH net-next 7/8] net: dsa: lan9645x: add mac table
 integration
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
Date: Wed, 4 Mar 2026 16:23:51 +0100
In-Reply-To: <20260303152709.nospd2qq3dju2tev@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-7-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-7-bff8ca1396f5@microchip.com>
	 <20260303152709.nospd2qq3dju2tev@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E6007202AA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263862-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 17:27 +0200, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Tue, Mar 03, 2026 at 01:22:33PM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > Add MAC table support, and dsa fdb callback integration. The mactable i=
s
> > keyed on (vid,mac) and each bucket has 4 slots. A mac table entry
> > typically points to a PGID index, the first 9 of which represent a fron=
t
> > port.
> >=20
> > Mac table entries for L2 multicast will use a PGID containing a group
> > port mask. For IP multicast entries in the mac table a trick us used,
> > where the group port mask is packed into the MAC data, exploiting the
> > fact that the top bits are fixed, and that the number of switch ports i=
s
> > small enough to fit in the redundant bits.
> >=20
> > Therefore, we can avoid using sparse PGID resources for IP multicast
> > entries in the mac table.
> >=20
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzosterga=
ard@microchip.com>
> > ---
> >  drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  | 413 +++++++++++++=
++++++++
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 110 +++++-
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  48 +++
> >  4 files changed, 571 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/=
dsa/microchip/lan9645x/Makefile
> > index bb5eec14d225..a90a46f81c72 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/Makefile
> > +++ b/drivers/net/dsa/microchip/lan9645x/Makefile
> > @@ -6,3 +6,4 @@ mchp-lan9645x-objs :=3D lan9645x_main.o \
> >       lan9645x_port.o \
> >       lan9645x_phylink.o \
> >       lan9645x_vlan.o \
> > +     lan9645x_mac.o \
>=20
> Is there some particular ordering here? Because it's surely not
> alphabetical.
>=20

I just add new files at the end, I thought that made the most sense. Should=
 they be
sorted by name?

> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/driver=
s/net/dsa/microchip/lan9645x/lan9645x_mac.c
> > new file mode 100644
> > index 000000000000..3226cff16e8c
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> > @@ -0,0 +1,413 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (C) 2026 Microchip Technology Inc.
> > + */
> > +
> > +#include "lan9645x_main.h"
> > +
> > +#define LAN9645X_MAC_COLUMNS 4
>=20
> Doesn't appear used.

I will remove it.

>=20
> > +
> > +#define CMD_IDLE             0
> > +#define CMD_LEARN            1
> > +#define CMD_FORGET           2
> > +#define CMD_AGE                      3
> > +#define CMD_GET_NEXT         4
> > +#define CMD_INIT             5
> > +#define CMD_READ             6
> > +#define CMD_WRITE            7
> > +#define CMD_SYNC_GET_NEXT    8
> > +
> > +#define LAN9645X_INVALID_ROW (-1)
> > +
> > +static bool lan9645x_mact_entry_equal(struct lan9645x_mact_entry *entr=
y,
> > +                                   const unsigned char *mac, u16 vid)
> > +{
> > +     /* The hardware table is keyed on (vid,mac) */
> > +     return entry->common.key.vid =3D=3D vid &&
> > +             ether_addr_equal(mac, entry->common.key.mac);
>=20
> Can you please align the "entry" with "ether_addr_equal".
> I think there's more coding style inconsistencies of the same type in
> the submission that I went over and omitted to comment on.
>=20

I will go over the patches and fix this where applicable.

> > +}
> > +
> > +static struct lan9645x_mact_entry *
> > +lan9645x_mact_entry_find(struct lan9645x *lan9645x, const unsigned cha=
r *mac,
> > +                      u16 vid)
> > +{
> > +     struct lan9645x_mact_entry *entry;
> > +
> > +     lockdep_assert_held(&lan9645x->mac_entry_lock);
> > +
> > +     list_for_each_entry(entry, &lan9645x->mac_entries, list)
> > +             if (lan9645x_mact_entry_equal(entry, mac, vid))
> > +                     return entry;
> > +
> > +     return NULL;
> > +}
> > +
> > +static struct lan9645x_mact_entry *
> > +lan9645x_mact_entry_alloc(struct lan9645x *lan9645x, const unsigned ch=
ar *mac,
> > +                       u16 vid, u8 pgid, enum macaccess_entry_type typ=
e)
> > +{
> > +     struct lan9645x_mact_entry *entry;
> > +
> > +     entry =3D kzalloc_obj(*entry);
> > +     if (!entry)
> > +             return NULL;
> > +
> > +     INIT_LIST_HEAD(&entry->list);
>=20
> This isn't needed on individual list elements, only on the head.
>=20
> > +     ether_addr_copy(entry->common.key.mac, mac);
> > +     entry->common.key.vid =3D vid;
> > +     entry->common.pgid =3D pgid;
> > +     entry->common.row =3D LAN9645X_INVALID_ROW;
>=20
> Do you use the row for anything?
>=20

No I will remove it, and the LIST_INIT above.

> > +     entry->common.type =3D type;
> > +
> > +     dev_dbg(lan9645x->dev,
> > +             "mact_entry_alloc mac=3D%pM vid=3D%u pgid=3D%u type=3D%d"=
,
> > +             entry->common.key.mac, entry->common.key.vid,
> > +             entry->common.pgid, entry->common.type);
> > +     return entry;
> > +}
> > +
> > +static void lan9645x_mact_entry_dealloc(struct lan9645x *lan9645x,
> > +                                     struct lan9645x_mact_entry *entry=
)
> > +{
> > +     if (!entry)
> > +             return;
> > +
> > +     dev_dbg(lan9645x->dev,
> > +             "mact_entry_dealloc mac=3D%pM vid=3D%u pgid=3D%u type=3D%=
d",
> > +             entry->common.key.mac, entry->common.key.vid,
> > +             entry->common.pgid, entry->common.type);
> > +
> > +     list_del(&entry->list);
> > +     kfree(entry);
> > +}
> > +
> > +static int lan9645x_mac_wait_for_completion(struct lan9645x *lan9645x,
> > +                                         u32 *maca)
> > +{
> > +     u32 val =3D 0;
> > +     int err;
> > +
> > +     lockdep_assert_held(&lan9645x->mact_lock);
> > +
> > +     err =3D lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
> > +                                    ANA_MACACCESS_MAC_TABLE_CMD_GET(va=
l) =3D=3D
> > +                                    CMD_IDLE);
> > +     if (err)
> > +             return err;
> > +
> > +     if (maca)
> > +             *maca =3D val;
> > +
> > +     return 0;
> > +}
> > +
> > +static void lan9645x_mact_parse(u32 machi, u32 maclo, u32 maca,
> > +                             struct lan9645x_mact_common *rentry)
> > +{
> > +     u64 addr =3D ANA_MACHDATA_MACHDATA_GET(machi);
> > +
> > +     addr =3D addr << 32 | maclo;
> > +     u64_to_ether_addr(addr, rentry->key.mac);
> > +     rentry->key.vid =3D ANA_MACHDATA_VID_GET(machi);
> > +     rentry->pgid =3D ANA_MACACCESS_DEST_IDX_GET(maca);
> > +     rentry->type =3D ANA_MACACCESS_ENTRYTYPE_GET(maca);
> > +}
> > +
> > +static void lan9645x_mac_select(struct lan9645x *lan9645x,
> > +                             const unsigned char *addr, u16 vid)
> > +{
> > +     u64 maddr =3D ether_addr_to_u64(addr);
> > +
> > +     lockdep_assert_held(&lan9645x->mact_lock);
> > +
> > +     lan_wr(ANA_MACHDATA_VID_SET(vid) |
> > +            ANA_MACHDATA_MACHDATA_SET(maddr >> 32),
> > +            lan9645x,
> > +            ANA_MACHDATA);
> > +
> > +     lan_wr(maddr & GENMASK(31, 0),
> > +            lan9645x,
> > +            ANA_MACLDATA);
> > +}
> > +
> > +static int __lan9645x_mact_forget(struct lan9645x *lan9645x,
> > +                               const unsigned char mac[ETH_ALEN],
> > +                               unsigned int vid,
> > +                               enum macaccess_entry_type type)
> > +{
> > +     lockdep_assert_held(&lan9645x->mact_lock);
> > +
> > +     lan9645x_mac_select(lan9645x, mac, vid);
> > +
> > +     lan_wr(ANA_MACACCESS_ENTRYTYPE_SET(type) |
> > +            ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_FORGET),
> > +            lan9645x,
> > +            ANA_MACACCESS);
> > +
> > +     return lan9645x_mac_wait_for_completion(lan9645x, NULL);
> > +}
> > +
> > +int lan9645x_mact_forget(struct lan9645x *lan9645x,
> > +                      const unsigned char mac[ETH_ALEN], unsigned int =
vid,
> > +                      enum macaccess_entry_type type)
> > +{
> > +     int ret;
>=20
> Inconsistent use of "err" and "ret" throughout the driver.
> Pick one and stick to it.
>=20

I will fix this in the next version.


> > +
> > +     mutex_lock(&lan9645x->mact_lock);
> > +     ret =3D __lan9645x_mact_forget(lan9645x, mac, vid, type);
> > +     mutex_unlock(&lan9645x->mact_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static bool lan9645x_mac_ports_use_cpu(const unsigned char *mac,
> > +                                    enum macaccess_entry_type type)
> > +{
> > +     u32 mc_ports;
> > +
> > +     switch (type) {
> > +     case ENTRYTYPE_MACV4:
> > +             mc_ports =3D (mac[1] << 8) | mac[2];
> > +             break;
> > +     case ENTRYTYPE_MACV6:
> > +             mc_ports =3D (mac[0] << 8) | mac[1];
> > +             break;
> > +     default:
> > +             return false;
> > +     }
> > +
> > +     return !!(mc_ports & BIT(CPU_PORT));
> > +}
> > +
> > +static int __lan9645x_mact_learn_cpu_copy(struct lan9645x *lan9645x, i=
nt port,
> > +                                       const unsigned char *addr, u16 =
vid,
> > +                                       enum macaccess_entry_type type,
> > +                                       bool cpu_copy)
> > +{
> > +     lockdep_assert_held(&lan9645x->mact_lock);
> > +
> > +     lan9645x_mac_select(lan9645x, addr, vid);
> > +
> > +     lan_wr(ANA_MACACCESS_VALID_SET(1) |
> > +            ANA_MACACCESS_DEST_IDX_SET(port) |
> > +            ANA_MACACCESS_MAC_CPU_COPY_SET(cpu_copy) |
> > +            ANA_MACACCESS_ENTRYTYPE_SET(type) |
> > +            ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_LEARN),
> > +            lan9645x, ANA_MACACCESS);
> > +
> > +     return lan9645x_mac_wait_for_completion(lan9645x, NULL);
> > +}
> > +
> > +static int __lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
> > +                              const unsigned char *addr, u16 vid,
> > +                              enum macaccess_entry_type type)
> > +{
> > +     bool cpu_copy =3D lan9645x_mac_ports_use_cpu(addr, type);
> > +
> > +     return __lan9645x_mact_learn_cpu_copy(lan9645x, port, addr, vid, =
type,
> > +                                           cpu_copy);
> > +}
> > +
> > +int lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
> > +                     const unsigned char *addr, u16 vid,
> > +                     enum macaccess_entry_type type)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&lan9645x->mact_lock);
> > +     ret =3D __lan9645x_mact_learn(lan9645x, port, addr, vid, type);
> > +     mutex_unlock(&lan9645x->mact_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +int lan9645x_mact_flush(struct lan9645x *lan9645x, int port)
> > +{
> > +     int err =3D 0;
>=20
> This is overwritten with the lan9645x_mac_wait_for_completion() result
> and never read. You don't need to zero-initialize it.
>=20

I will remove this.

> > +
> > +     mutex_lock(&lan9645x->mact_lock);
> > +     /* MAC table entries with dst index matching port are aged on sca=
n. */
> > +     lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
> > +            ANA_ANAGEFIL_PID_VAL_SET(port),
> > +            lan9645x, ANA_ANAGEFIL);
> > +
> > +     /* Flushing requires two scans. First sets AGE_FLAG=3D1, second r=
emoves
> > +      * entries with AGE_FLAG=3D1.
> > +      */
> > +     lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_AGE),
> > +            lan9645x,
> > +            ANA_MACACCESS);
> > +
> > +     err =3D lan9645x_mac_wait_for_completion(lan9645x, NULL);
> > +     if (err)
> > +             goto mact_unlock;
> > +
> > +     lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_AGE),
> > +            lan9645x,
> > +            ANA_MACACCESS);
> > +
> > +     err =3D lan9645x_mac_wait_for_completion(lan9645x, NULL);
> > +
> > +mact_unlock:
> > +     lan_wr(0, lan9645x, ANA_ANAGEFIL);
> > +     mutex_unlock(&lan9645x->mact_lock);
> > +     return err;
> > +}
> > +
> > +int lan9645x_mact_entry_add(struct lan9645x *lan9645x, int pgid,
> > +                         const unsigned char *mac, u16 vid)
> > +{
> > +     struct lan9645x_mact_entry *entry;
> > +     int ret =3D 0;
> > +
> > +     /* Users can not move (vid,mac) to a different port, without remo=
ving
> > +      * the original entry first. But we overwrite entry in HW, and up=
date
> > +      * software pgid for good measure.
> > +      */
> > +     mutex_lock(&lan9645x->mac_entry_lock);
> > +     entry =3D lan9645x_mact_entry_find(lan9645x, mac, vid);
> > +     if (entry) {
> > +             entry->common.pgid =3D pgid;
> > +             mutex_unlock(&lan9645x->mac_entry_lock);
> > +             goto mac_learn;
> > +     }
> > +
> > +     entry =3D lan9645x_mact_entry_alloc(lan9645x, mac, vid, pgid,
> > +                                       ENTRYTYPE_LOCKED);
> > +     if (!entry) {
> > +             mutex_unlock(&lan9645x->mac_entry_lock);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     list_add_tail(&entry->list, &lan9645x->mac_entries);
> > +     mutex_unlock(&lan9645x->mac_entry_lock);
> > +
> > +mac_learn:
> > +     WARN_ON(entry->common.pgid !=3D pgid);
> > +     ret =3D lan9645x_mact_learn(lan9645x, pgid, mac, vid, ENTRYTYPE_L=
OCKED);
>=20
> Same comment about multiple critical sections getting opened and closed.
> It makes you wonder what can happen in between them. Any reason why you
> don't call __lan9645x_mact_learn()?
>=20

There is a lock for the mac_entry list (mac_entry_lock) and one for the mac
table (mact_lock) which __lan9645x_mact_learn would not take. But they
are not used independently here, and as you mention not interleaved right.
I will strip this down to 1 lock for both mac_entry list and mac table.

> > +     if (ret) {
> > +             mutex_lock(&lan9645x->mac_entry_lock);
> > +             lan9645x_mact_entry_dealloc(lan9645x, entry);
> > +             mutex_unlock(&lan9645x->mac_entry_lock);
> > +     }
> > +     return ret;
> > +}
> > +
> > +int lan9645x_mact_entry_del(struct lan9645x *lan9645x, int pgid,
> > +                         const unsigned char *mac, u16 vid)
> > +{
> > +     struct lan9645x_mact_entry *entry;
> > +
> > +     mutex_lock(&lan9645x->mac_entry_lock);
> > +     entry =3D lan9645x_mact_entry_find(lan9645x, mac, vid);
> > +     if (entry) {
> > +             WARN_ON(entry->common.pgid !=3D pgid);
> > +             lan9645x_mact_entry_dealloc(lan9645x, entry);
> > +             mutex_unlock(&lan9645x->mac_entry_lock);
> > +             goto forget;
> > +     }
> > +     mutex_unlock(&lan9645x->mac_entry_lock);
> > +     return -ENOENT;
> > +
> > +forget:
> > +     return lan9645x_mact_forget(lan9645x, mac, vid, ENTRYTYPE_LOCKED)=
;
>=20
> I don't understand why you release the mac_entry_lock just for
> lan9645x_mact_forget() to acquire it again. Can't stuff happen in the
> split second where the MAC table is unlocked? It seems at least more
> straightforward to call __lan9645x_mact_forget() under the locked
> section rather than do the jump.
>=20
> And it also seems more straightforward to invert the branch where the
> entry is found in the MAC table with the one where it isn't. This allows
> the more complex code to be less indented.
>=20

Yes, as mentioned above I think you are right about the gap, but they are
different locks. The idea was you could potentially iterate the list withou=
t
locking the mactable. But I will reduce it to 1 lock and use=C2=A0
__lan9645x_mact_forget.

> > +}
> > +
> > +void lan9645x_mac_init(struct lan9645x *lan9645x)
> > +{
> > +     mutex_init(&lan9645x->mac_entry_lock);
> > +     mutex_init(&lan9645x->mact_lock);
> > +     mutex_init(&lan9645x->fwd_domain_lock);
> > +     INIT_LIST_HEAD(&lan9645x->mac_entries);
> > +
> > +     /* Clear the MAC table */
> > +     mutex_lock(&lan9645x->mact_lock);
> > +     lan_wr(CMD_INIT, lan9645x, ANA_MACACCESS);
> > +     lan9645x_mac_wait_for_completion(lan9645x, NULL);
> > +     mutex_unlock(&lan9645x->mact_lock);
>=20
> mutex_init() immediately followed by mutex_lock() is an antipattern.
> mutex_init() is run from a context with no concurrent threads that can
> acquire the lock.
> mutex_lock() is run from a context where concurrent threads are possible.
> The two put together are a logical inconsistency, it means acquiring the
> lock is unnecessary.
>=20

Thanks, I was not aware. I will remove the lock here.

> > +}
> > +
> > +void lan9645x_mac_deinit(struct lan9645x *lan9645x)
> > +{
> > +     mutex_destroy(&lan9645x->mac_entry_lock);
> > +     mutex_destroy(&lan9645x->mact_lock);
> > +     mutex_destroy(&lan9645x->fwd_domain_lock);
> > +}
> > +
> > +int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
> > +                        dsa_fdb_dump_cb_t *cb, void *data)
> > +{
> > +     struct lan9645x_mact_entry entry =3D { 0 };
>=20
> Just {}.
> https://lore.kernel.org/netdev/20210810091238.GB1343@shell.armlinux.org.u=
k/
>=20

I will change this where applicable.

> > +     u32 mach, macl, maca;
> > +     int err =3D 0;
> > +     u32 autoage;
> > +
> > +     mach =3D 0;
> > +     macl =3D 0;
>=20
> You have two choices.
>=20
> You can fold these into their declaration: "u32 mach =3D 0, macl =3D 0, m=
aca;",
> _if_ you're going to write them as variables:
>         lan_wr(mach, lan9645x, ANA_MACHDATA);
>         lan_wr(macl, lan9645x, ANA_MACLDATA);
>=20
> Or you can remove the initializer, which is overwritten by the first
> variable assignment in the while (1) loop, without the variables ever
> being read in the meantime.

>=20
>=20
>=20
> I will just remove the initializers.
>=20
> > +     entry.common.type =3D ENTRYTYPE_NORMAL;
> > +
> > +     mutex_lock(&lan9645x->mact_lock);
> > +
> > +     /* The aging filter works both for aging scans and GET_NEXT table=
 scans.
> > +      * With it, the HW table iteration only stops at entries matching=
 our
> > +      * filter. Since DSA calls us for each port on a table dump, this=
 helps
> > +      * avoid unnecessary work.
>=20
> Nice. I think this is the first driver I see which doesn't do duplicated
> work here. I vaguely remember testing this feature on Ocelot too, but it
> didn't work.
>=20

With register IO over SPI this is painfully slow without the hardware itera=
tion. Ocelot
is before my time, so I was not aware the age filters were broken there.

> > +      *
> > +      * Disable automatic aging temporarily. First save current state.
> > +      */
> > +     autoage =3D lan_rd(lan9645x, ANA_AUTOAGE);
> > +
> > +     /* Disable aging */
> > +     lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(0),
> > +             ANA_AUTOAGE_AGE_PERIOD,
> > +             lan9645x, ANA_AUTOAGE);
> > +
> > +     /* Setup filter on our port */
> > +     lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
> > +            ANA_ANAGEFIL_PID_VAL_SET(port),
> > +            lan9645x, ANA_ANAGEFIL);
> > +
> > +     lan_wr(0, lan9645x, ANA_MACHDATA);
> > +     lan_wr(0, lan9645x, ANA_MACLDATA);
> > +
> > +     while (1) {
> > +             /* NOTE: we rely on mach, macl and type being set correct=
ly in
> > +              * the registers from previous round, vis a vis the GET_N=
EXT
> > +              * semantics, so locking entire loop is important.
> > +              */
> > +             lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_GET_NEXT) |
> > +                    ANA_MACACCESS_ENTRYTYPE_SET(entry.common.type),
> > +                    lan9645x, ANA_MACACCESS);
> > +
> > +             if (lan9645x_mac_wait_for_completion(lan9645x, &maca))
> > +                     break;
> > +
> > +             if (ANA_MACACCESS_VALID_GET(maca) =3D=3D 0)
> > +                     break;
> > +
> > +             mach =3D lan_rd(lan9645x, ANA_MACHDATA);
> > +             macl =3D lan_rd(lan9645x, ANA_MACLDATA);
> > +
> > +             lan9645x_mact_parse(mach, macl, maca, &entry.common);
> > +
> > +             if (ANA_MACACCESS_DEST_IDX_GET(maca) =3D=3D port &&
> > +                 entry.common.type =3D=3D ENTRYTYPE_NORMAL) {
> > +                     if (entry.common.key.vid > VLAN_MAX)
> > +                             entry.common.key.vid =3D 0;
> > +
> > +                     err =3D cb(entry.common.key.mac, entry.common.key=
.vid,
> > +                              false, data);
> > +                     if (err)
> > +                             break;
> > +             }
> > +     }
> > +
> > +     /* Remove aging filters and restore aging */
> > +     lan_wr(0, lan9645x, ANA_ANAGEFIL);
> > +     lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(ANA_AUTOAGE_AGE_PERIOD_GET(aut=
oage)),
> > +             ANA_AUTOAGE_AGE_PERIOD,
> > +             lan9645x, ANA_AUTOAGE);
> > +
> > +     mutex_unlock(&lan9645x->mact_lock);
> > +
> > +     return err;
> > +}
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index 1c8f20452487..ba76279b4414 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > @@ -78,6 +78,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
> >=20
> >       debugfs_remove_recursive(lan9645x->debugfs_root);
> >       lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
> > +     lan9645x_mac_deinit(lan9645x);
> >  }
> >=20
> >  static int lan9645x_change_mtu(struct dsa_switch *ds, int port, int ne=
w_mtu)
> > @@ -171,8 +172,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >               return err;
> >       }
> >=20
> > -     mutex_init(&lan9645x->fwd_domain_lock);
>=20
> Why did you have to move this to lan9645x_mac_init()? It has changed
> position since the beginning of the series. Also, it isn't related to
> the MAC table.
>=20

I was just used to having it there, but I think you are right. I will keep =
it in
lan9645x_setup.

>=20
> >       lan9645x_vlan_init(lan9645x);
> > +     lan9645x_mac_init(lan9645x);
> >=20
> >       /* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
> >       lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |


