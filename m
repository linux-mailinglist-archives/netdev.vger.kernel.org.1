Return-Path: <netdev+bounces-274148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPutIGA7zWn2awYAu9opvQ
	(envelope-from <netdev+bounces-274148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:36:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD337D3B9
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9FCA3118372
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C3735F196;
	Wed,  1 Apr 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jIw0Pu7f"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA435DA4F;
	Wed,  1 Apr 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055671; cv=none; b=kkSSNQGw+syEw/Qrv4Jiu4JPGyr0MO4bJg9ILLsd94Tvgn0WeqFnt/fpI7HpQuIEAFUZAh84FZFgRVk3RAEPK0Ege9DveqGG89TCjrrZJM9k8PGjsnbrMxpMHXdQbS8sJwYV2Q0/XaU3+brHob93XdpjhS/GMHpO2ZqY2b9iQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055671; c=relaxed/simple;
	bh=RUwWxvVuCmARZw9VXFz52L6j5M88zNRl5Tjw3fQMR58=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HLgM9Fzs1FlYFT2fbUCJ9amaDDwkXMQjr2mIKA2utx4WxEZ/WLTR3MnvbyMO67x5hOF2H2UNt5ncMyJiIfG2HBDC2BJ5ESfJHtfQR+D8/LjgLJdSJwrhkqRSSvnv40UW69JTEIYNdl3C9bnEnu2hXompbgkWg08/3Z/5hW018NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jIw0Pu7f; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775055668; x=1806591668;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RUwWxvVuCmARZw9VXFz52L6j5M88zNRl5Tjw3fQMR58=;
  b=jIw0Pu7fOOuTpqAIqJe/BoG0ZrhT7Y9T3miuC1DbqeMGFywtItZ2pyFF
   nDtf0KJQdqX+hIljzr7rKVHyOF5fawIQD1nCRZqb/7FPlOEOXraOBf+tn
   SFAiEdrY17qK20x89HMT9RtjVSUrIDLHwedix/9iyZB+XURismRnoau4N
   8Wk5fG7vsLQgc3lgj0c8AUlK0zUHW/t4M56zYsBXmbHf9CrZtNkPZTWq8
   iQXKaw/hXsu2964bvzX8NRpyhCFw7iF97xqUO/W/SNURRbHcICTPZLmYW
   IuQ68fQVNGjdy2I5bG7UWY9j16Cry6wURYjlcLhqsf9TAQvTzBnzEzn2E
   g==;
X-CSE-ConnectionGUID: 3S/Mh0nqQ56XSMJ1idUGjw==
X-CSE-MsgGUID: Nl7rFw0pRhC0Et4Ko62vXg==
X-IronPort-AV: E=Sophos;i="6.23,153,1770620400"; 
   d="scan'208";a="286909498"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2026 08:01:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 1 Apr 2026 08:01:01 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 1 Apr 2026 08:00:58 -0700
Message-ID: <0d589c193992bb71d31689999cb027b748d69c5c.camel@microchip.com>
Subject: Re: [PATCH net-next v2 7/9] net: dsa: lan9645x: add mac table
 integration
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Wed, 1 Apr 2026 17:00:58 +0200
In-Reply-To: <20260329195635.2789227-1-kuba@kernel.org>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-7-f7504e3b0681@microchip.com>
	 <20260329195635.2789227-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274148-lists,netdev=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Queue-Id: E0FD337D3B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-03-29 at 12:56 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: lan9645x: add mac table integration
>=20
> Add MAC table support, and dsa fdb callback integration. The mactable is
> keyed on (vid,mac) and each bucket has 4 slots. A mac table entry typical=
ly
> points to a PGID index, the first 9 of which represent a front port.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/driver=
s/net/dsa/microchip/lan9645x/lan9645x_mac.c
> > index 000000000000..6335714dca21
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> [ ... ]
> > +int lan9645x_mact_entry_add(struct lan9645x *lan9645x, int pgid,
> > +                         const unsigned char *mac, u16 vid)
> > +{
> > +     struct lan9645x_mact_entry *entry;
> > +     int err;
> > +
> > +     mutex_lock(&lan9645x->mact_lock);
> > +
> > +     /* Users can not move (vid,mac) to a different port, without remo=
ving
> > +      * the original entry first. But we overwrite entry in HW, and up=
date
> > +      * software pgid for good measure.
> > +      */
> > +     entry =3D lan9645x_mact_entry_find(lan9645x, mac, vid);
> > +     if (entry) {
> > +             entry->common.pgid =3D pgid;
> > +             goto mac_learn;
> > +     }
> > +
> > +     entry =3D lan9645x_mact_entry_alloc(lan9645x, mac, vid, pgid,
> > +                                       ENTRYTYPE_LOCKED);
> > +     if (!entry) {
> > +             mutex_unlock(&lan9645x->mact_lock);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     list_add_tail(&entry->list, &lan9645x->mac_entries);
> > +
> > +mac_learn:
> > +     err =3D __lan9645x_mact_learn(lan9645x, pgid, mac, vid, ENTRYTYPE=
_LOCKED);
> > +     if (err)
> > +             lan9645x_mact_entry_dealloc(lan9645x, entry);
>=20
> If a pre-existing entry is updated but the hardware learning command fail=
s,
> will this inadvertently delete the valid software entry and cause the har=
dware
> and software tracking to become desynchronized?
>=20

I will rearrange so they stay synced.

> > +
> > +     mutex_unlock(&lan9645x->mact_lock);
> > +     return err;
> > +}
> > +
> > +int lan9645x_mact_entry_del(struct lan9645x *lan9645x, int pgid,
> > +                         const unsigned char *mac, u16 vid)
> > +{
> > +     struct lan9645x_mact_entry *entry;
> > +     int err;
> > +
> > +     mutex_lock(&lan9645x->mact_lock);
> > +
> > +     entry =3D lan9645x_mact_entry_find(lan9645x, mac, vid);
> > +     if (!entry) {
> > +             mutex_unlock(&lan9645x->mact_lock);
> > +             return -ENOENT;
> > +     }
> > +
> > +     WARN_ON(entry->common.pgid !=3D pgid);
> > +     lan9645x_mact_entry_dealloc(lan9645x, entry);
> > +     err =3D __lan9645x_mact_forget(lan9645x, mac, vid, ENTRYTYPE_LOCK=
ED);
>=20
> Does this permanently remove the software entry even if the hardware
> command to forget the entry fails?
>=20

Same here, I can rearrange so they stay synced.

> > +
> > +     mutex_unlock(&lan9645x->mact_lock);
> > +     return err;
> > +}
> [ ... ]
> > +void lan9645x_mac_deinit(struct lan9645x *lan9645x)
> > +{
> > +     mutex_destroy(&lan9645x->mact_lock);
> > +}
>=20
> Are the static MAC entries in the mac_entries list leaked here during dri=
ver
> teardown, or are they freed elsewhere?
>=20

I thought DSA core would have removed them for me, but it looks like that m=
ay not be
the case. I will add dealloc during deinit.

> > +
> > +int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
> > +                        dsa_fdb_dump_cb_t *cb, void *data)
> > +{
> > +     struct lan9645x_mact_entry entry =3D {};
> > +     u32 mach, macl, maca;
> > +     int err =3D 0;
> > +     u32 autoage;
> [ ... ]
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
>=20
> If the hardware completion times out, the loop breaks out and returns the
> local err variable which is initialized to 0. Will this suppress the hard=
ware
> timeout error code and incorrectly report a successful dump?
>=20

Yes, I will return the error.

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
>=20
> Since static FDB entries are programmed with ENTRYTYPE_LOCKED, will this
> condition exclude them from the FDB dump, preventing them from showing up
> during bridge FDB queries?
>=20

Yes that is intentional. This is for the dynamic entries which the bridge c=
ore does not
know about.

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
>=20
> Does restoring the ANA_AUTOAGE register using the autoage value saved at =
the
> start of the function race with other operations setting the aging time?
>=20
> If the aging time is updated concurrently without taking mact_lock, its n=
ewly
> configured aging period might be overwritten here.
>=20

AFAIK both run under rtnl so we do not have a race. But I will take the mac=
t_lock during
set_ageing_time.

> > +
> > +     mutex_unlock(&lan9645x->mact_lock);
> > +
> > +     return err;
> > +}
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index 046c95a72242..32c0301030a4 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> [ ... ]
> > +static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
> > +                         const unsigned char *addr, u16 vid,
> > +                         struct dsa_db db)
> > +{
> > +     struct net_device *br =3D lan9645x_db2bridge(db);
> > +     struct dsa_port *dp =3D dsa_to_port(ds, port);
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     int err;
> > +
> > +     if (IS_ERR(br))
> > +             return PTR_ERR(br);
> > +
> > +     if (dsa_port_is_cpu(dp) && !br &&
> > +         dsa_fdb_present_in_other_db(ds, port, addr, vid, db))
> > +             return 0;
> > +
> > +     if (!vid)
> > +             vid =3D lan9645x_vlan_unaware_pvid(!!br);
> > +
> > +     if (dsa_port_is_cpu(dp))
> > +             return lan9645x_mact_forget(lan9645x, addr, vid,
> > +                                         ENTRYTYPE_LOCKED);
> > +
> > +     err =3D lan9645x_mact_entry_del(lan9645x, port, addr, vid);
> > +     if (err =3D=3D -ENOENT) {
> > +             dev_dbg(lan9645x->dev,
> > +                     "fdb not found port=3D%d addr=3D%pM vid=3D%u\n", =
port, addr,
> > +                     vid);
> > +             return 0;
> > +     }
> > +
> > +     return err;
> > +}
>=20
> Since lan9645x_mact_entry_del returns -ENOENT when a MAC address is not f=
ound
> in the software tracking list, and the software list only contains static=
ally
> added entries, won't this intercept attempts to manually delete dynamical=
ly
> learned MAC addresses and return success without actually removing them f=
rom
> the hardware table?

No I do not think this is how it works. Dynamic entries are flushed with=C2=
=A0
.port_fast_age, and port_fdb_del is for static entries. We handle -ENOENT
because DSA core does not refcount fdbs for userports.

