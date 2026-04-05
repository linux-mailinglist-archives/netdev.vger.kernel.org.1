Return-Path: <netdev+bounces-275488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMq9G2fS0mlSbQcAu9opvQ
	(envelope-from <netdev+bounces-275488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 23:21:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F5239FDAA
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 23:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803B23005D0B
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 21:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D57381B15;
	Sun,  5 Apr 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FFAeFY5l"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5702EA171;
	Sun,  5 Apr 2026 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775424100; cv=none; b=Qy4YlPnv0h6g/T7N8aZe3r1VT+KA8yR1nj4qAekjbZtcEIoKKGXfA7Zp0j4VufYWrx6WSCWVTSHt6A2hyHI2M7lt0Oo6dCLCZAoprH3yCLYR2BvD+n1W0y5MbL8pgCaT5IaxGZrnuOg8O8M1O3Eh4MSLV/GbovK8laiFvQ6mFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775424100; c=relaxed/simple;
	bh=smBEkfJVMvE9JpAt/tYUQtsG5hM+BmqdIRF6hKqdm6Y=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJ23sImeOEuXDf6+i+anQgXKHJkJU2+JWUQ6O6MxS011sw29HPqBbLA0obhhnxdItzK0jh475G3gTNHf1tzjTDXVqOZvSUhr9JgAL32Klh14wJEGryY1Xj8NxPYbR9MXDn4AqRxlXRHXmPJZMJyEl8MFIGTqssqw9SU/Mr8xJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FFAeFY5l; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775424097; x=1806960097;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=smBEkfJVMvE9JpAt/tYUQtsG5hM+BmqdIRF6hKqdm6Y=;
  b=FFAeFY5lSrkDwFPc+9Y7n323MOA/aOjWcXXW+58nFFSUd0ykHNw2P3SX
   DuA8TG5h7kK+EmeS6haXLkVQ9yQEkwni0fQTWukUHN/A0ClxJgf2Bn23+
   R28SMQeRMfEt3GJ0PQYPMCRsAX8RYnbJ23M6IZctbHeg8MOJur6GPI+YX
   osRFAV8iEtNy97IV388AxJki34F99FtAk9EmilKF+T7PJEPnQiJc2x1yz
   nLuL7r0vExO7q62cHplRnTLcBcxVBRGxXCyrnr2uzOyxkyZsn9awyA8ut
   R7E/o3eTbIvO0dy9DyYw7D3pbmgo/gzyVJoK8UPYvXurbQ2qdgD5DTeuy
   Q==;
X-CSE-ConnectionGUID: 3hR2YZPbRIeZSHW6XVbcTw==
X-CSE-MsgGUID: U1+0SH7sT0SWzBcpIQ0AHw==
X-IronPort-AV: E=Sophos;i="6.23,162,1770620400"; 
   d="scan'208";a="222950560"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 14:21:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 5 Apr 2026 14:21:00 -0700
Received: from [10.205.29.28] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 5 Apr 2026 14:20:56 -0700
Message-ID: <041be3126e287a2e7c1b5d05c0f1116c5e4a4095.camel@microchip.com>
Subject: Re: [PATCH net-next v2 8/9] net: dsa: lan9645x: add mdb management
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Sun, 5 Apr 2026 23:20:46 +0200
In-Reply-To: <20260329195637.2789256-1-kuba@kernel.org>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-8-f7504e3b0681@microchip.com>
	 <20260329195637.2789256-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275488-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C2F5239FDAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-03-29 at 12:56 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Subject: net: dsa: lan9645x: add mdb management
>=20
> Add support for dsa mdb callbacks. L2 multicast and IP multicast is
> handled differently. IP multicast stores the port group mask inline in
> the mac table. L2 multicast points to a PGID index, which encodes the
> port group mask.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c b/driver=
s/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> > new file mode 100644
> > index 000000000000..4cf92887a4eb
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> > @@ -0,0 +1,391 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (C) 2026 Microchip Technology Inc.
> > + */
> > +
> > +#include "lan9645x_main.h"
>=20
> [ ... ]
>=20
> > +static void lan9645x_mdb_encode_mac(unsigned char *mac,
> > +                                 struct lan9645x_mdb_entry *mdb_entry,
> > +                                 enum macaccess_entry_type type)
> > +{
> > +     ether_addr_copy(mac, mdb_entry->mac);
> > +
> > +     /* The HW encodes the portmask in the high bits of the mac for ip
> > +      * multicast entries, to save on the limited PGID resources.
> > +      *
> > +      * IPv4 Multicast DMAC: 0x01005Exxxxxx
> > +      * IPv6 Multicast DMAC: 0x3333xxxxxxxx
> > +      *
> > +      * which gives us 24 or 16 bits to encode the portmask.
> > +      */
> > +     if (type =3D=3D ENTRYTYPE_MACV4) {
> > +             mac[0] =3D 0;
> > +             mac[1] =3D mdb_entry->ports >> 8;
> > +             mac[2] =3D mdb_entry->ports & 0xff;
> > +     } else if (type =3D=3D ENTRYTYPE_MACV6) {
> > +             mac[0] =3D mdb_entry->ports >> 8;
> > +             mac[1] =3D mdb_entry->ports & 0xff;
> > +     }
> > +}
>=20
> Does this code need to mask out BIT(CPU_PORT) from mdb_entry->ports?
>=20
> For L2 multicast, the CPU port is explicitly stripped from the PGID portm=
ask
> to avoid conflicting instructions, since CPU_PORT forwarding is handled b=
y the
> cpu_copy flag. Here, the IP multicast portmask is encoded directly into t=
he
> MAC address using the full mdb_entry->ports. Could this cause hardware to
> receive conflicting instructions (forwarding to port 9 and copying to the=
 CPU
> extraction queue), leading to duplicate multicast packets for the CPU?
>=20

No this is fine.

> [ ... ]
>=20
> > +static struct lan9645x_pgid_entry *
> > +lan9645x_mdb_pgid_entry_create(struct lan9645x *lan9645x, u16 ports)
> > +{
> > +     struct lan9645x_pgid_entry *pgid_entry =3D NULL;
> > +     int index;
> > +
> > +     for (index =3D PGID_GP_START; index < PGID_GP_END; index++) {
>=20
> Is it safe to start the search at PGID_GP_START (defined as CPU_PORT)?
>=20
> Hardware uses ANA_PGID(DEST_IDX) to forward unicast traffic, and MAC tabl=
e
> entries for the CPU have DEST_IDX =3D 9. When the first L2 multicast grou=
p is
> added, it appears this loop will allocate PGID index 9, overwriting the
> unicast portmask for the CPU port. Could this cause all unicast traffic
> destined for the CPU to be flooded to the external physical ports in the
> multicast group instead?
>=20

No this is safe, PGID 9 is not used to forward anything to the CPU.

> > +             bool used =3D false;
> > +
> > +             list_for_each_entry(pgid_entry, &lan9645x->pgid_entries, =
list) {
> > +                     if (pgid_entry->index =3D=3D index) {
> > +                             used =3D true;
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             if (!used)
> > +                     return lan9645x_pgid_entry_alloc(lan9645x, index,
> > +                                                      ports);
> > +     }
> > +
> > +     return ERR_PTR(-ENOSPC);
> > +}
>=20
> [ ... ]
>=20
> > +static int __lan9645x_mdb_add(struct lan9645x *lan9645x, int chip_port=
,
> > +                           const unsigned char addr[ETH_ALEN], u16 vid=
,
> > +                           enum macaccess_entry_type type)
> > +{
> > +     struct lan9645x_pgid_entry *old_pgid, *new_pgid;
> > +     struct lan9645x_mdb_entry *mdb_entry;
> > +     unsigned char mac[ETH_ALEN];
> > +     int err, pgid_index;
> > +     bool cpu_copy;
> > +
> > +     mdb_entry =3D lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
> > +     if (!mdb_entry) {
> > +             mdb_entry =3D lan9645x_mdb_entry_alloc(lan9645x, addr, vi=
d);
> > +             if (IS_ERR(mdb_entry))
> > +                     return PTR_ERR(mdb_entry);
> > +     }
> > +
> > +     if (mdb_entry->ports & BIT(chip_port))
> > +             return 0;
> > +
> > +     mdb_entry->ports |=3D BIT(chip_port);
> > +
> > +     /* Encode mac for IP mc */
> > +     lan9645x_mdb_encode_mac(mac, mdb_entry, type);
> > +
> > +     /* Update PGID ptr for non-IP entries (L2 multicast) */
> > +     old_pgid =3D mdb_entry->pgid;
> > +     new_pgid =3D lan9645x_mdb_pgid_entry_get(lan9645x, mdb_entry, typ=
e);
> > +     if (IS_ERR(new_pgid)) {
> > +             /* Out of PGIDs or mem. Continue forwarding to old port
> > +              * group, or remove if fresh mdb_entry.
> > +              */
> > +             mdb_entry->ports &=3D ~BIT(chip_port);
> > +             if (!mdb_entry->ports)
> > +                     lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
> > +
> > +             return PTR_ERR(new_pgid);
> > +     }
> > +     mdb_entry->pgid =3D new_pgid;
> > +
> > +     cpu_copy =3D !!(mdb_entry->ports & BIT(CPU_PORT));
> > +     pgid_index =3D lan9645x_mdb_pgid_index(mdb_entry, type);
> > +
> > +     /* Make sure to write on top of existing entry, so we do not disr=
upt
> > +      * flowing traffic.
> > +      */
> > +     err =3D lan9645x_mact_learn_cpu_copy(lan9645x, pgid_index, mac,
> > +                                        mdb_entry->vid, type, cpu_copy=
);
> > +     lan9645x_pgid_entry_put(lan9645x, old_pgid);
> > +     return err;
> > +}
>=20
> What happens if lan9645x_mact_learn_cpu_copy() fails and returns an error=
?
>=20
> The software MDB state (mdb_entry->ports and mdb_entry->pgid) is updated =
and
> the old PGID reference is dropped via lan9645x_pgid_entry_put() before
> verifying if the hardware MAC table update succeeds.
>=20
> If the hardware update fails, the software state isn't rolled back, leavi=
ng
> them out of sync. Furthermore, the dropped old_pgid reference could allow=
 the
> index to be reallocated to a new multicast group while the hardware still
> points to the old PGID index, potentially causing silent traffic cross-ta=
lk.
>=20


I will change the mac table write error path, so hw/sw stay synced.


> > +
> > +static int __lan9645x_mdb_del(struct lan9645x *lan9645x, int chip_port=
,
> > +                           const unsigned char addr[ETH_ALEN], u16 vid=
,
> > +                           enum macaccess_entry_type type)
> > +{
> > +     struct lan9645x_pgid_entry *old_pgid, *new_pgid;
> > +     struct lan9645x_mdb_entry *mdb_entry;
> > +     unsigned char mac[ETH_ALEN];
> > +     int err, pgid_index;
> > +     bool cpu_copy;
> > +
> > +     mdb_entry =3D lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
> > +     if (!mdb_entry)
> > +             return -ENOENT;
> > +
> > +     if (!(mdb_entry->ports & BIT(chip_port)))
> > +             return 0;
> > +
> > +     mdb_entry->ports &=3D ~BIT(chip_port);
> > +
> > +     /* Encode mac for IP mc */
> > +     lan9645x_mdb_encode_mac(mac, mdb_entry, type);
> > +
> > +     /* Update PGID ptr for non-IP entries (L2 multicast) */
> > +     old_pgid =3D mdb_entry->pgid;
> > +     new_pgid =3D lan9645x_mdb_pgid_entry_get(lan9645x, mdb_entry, typ=
e);
> > +     if (IS_ERR(new_pgid)) {
> > +             /* Continue forwarding to old port group. */
> > +             mdb_entry->ports |=3D BIT(chip_port);
> > +             return PTR_ERR(new_pgid);
> > +     }
> > +     mdb_entry->pgid =3D new_pgid;
> > +
> > +     if (!mdb_entry->ports) {
> > +             lan9645x_mact_forget(lan9645x, mac, mdb_entry->vid, type)=
;
> > +             lan9645x_pgid_entry_put(lan9645x, old_pgid);
> > +             lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
> > +             return 0;
> > +     }
>=20
> Similar to the addition path above, if lan9645x_mact_forget() fails, its
> return value is ignored, and the software MDB entry and PGID are freed
> anyway. This could also lead to hardware/software state desynchronization=
.
>=20
> > +
> > +     cpu_copy =3D !!(mdb_entry->ports & BIT(CPU_PORT));
> > +     pgid_index =3D lan9645x_mdb_pgid_index(mdb_entry, type);
> > +
> > +     err =3D lan9645x_mact_learn_cpu_copy(lan9645x, pgid_index, mac,
> > +                                        mdb_entry->vid, type, cpu_copy=
);
> > +     lan9645x_pgid_entry_put(lan9645x, old_pgid);
> > +     return err;
> > +}


