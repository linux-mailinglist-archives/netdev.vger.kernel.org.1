Return-Path: <netdev+bounces-286987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPrgFi3aAmqbyAEAu9opvQ
	(envelope-from <netdev+bounces-286987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:43:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDEB51C129
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34898301EF82
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF1480321;
	Tue, 12 May 2026 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kW4B1tLf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF693672BA;
	Tue, 12 May 2026 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571760; cv=none; b=BqDLO1Q7/4Pm/d1ePVAAVjRYc1xoWlwRik22tmJRGTqo3LnkNAAhUJB4jJqiqM+H4m4RSivHjNi4A8SDy7Sy9ts/kqRi2YSKkEo3ewXOJ/SplNukdXNVPt5yF2TXz8/Ruo7FyP8jOGaqV6Wh3BgK+CifXn34oYlySy5nTX2G1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571760; c=relaxed/simple;
	bh=M/am2wbk0iyS/OYtFwRSOMspzn/aIFuuWrjTaHbvQDk=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bijsg824zHtP7gZm8nJFWfa6oB20a0tu0orZmB/cIrv42meATo1n++ZRgjCUCJAOQL5Fayxhtc9WCVx0a1B1LzGfX9b9dwBPeQdEGjV15APPx/TpM4y4pn60p9aiAdLgaqW5zF1+XmSrgD3bqgn2tkftYQwJfacu3Ez3wdmUTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kW4B1tLf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778571757; x=1810107757;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=M/am2wbk0iyS/OYtFwRSOMspzn/aIFuuWrjTaHbvQDk=;
  b=kW4B1tLfcqxIGnx5AhII74sAzEmiqvIP2Yic9IpJ9ilsdrxnPw7llisd
   UNpac/WtvmkppA21uytxzPBhdKGFdJHiZlqQxxefD2jS0uv3S2KtJf1YN
   UZIHprQz0P/SAsDLq/jKd2glrpR+LV8qNhXwSTgwigGY1pqQJSbFl3gFr
   iueCcoyYyuUxRUeJmrfKTNRiHg8YLCNRnflk2N2bwjE3rQwlmkARJ/FiA
   Kwk1Bk3x7guGniz8AoO+qAakL7v3A8nZ93HACEiKI54iFM3uQpAFj53wp
   UbLsU1KP1JYMogVXEDyCeGZZK0qty2fuVfbiWzQ9tGwvsytQi4VxeHJh0
   w==;
X-CSE-ConnectionGUID: 0Om6zozNTp+TBx0yLmA0IA==
X-CSE-MsgGUID: UsI2EoiTSUeF8kIaUAic+Q==
X-IronPort-AV: E=Sophos;i="6.23,230,1770620400"; 
   d="scan'208";a="57378943"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2026 00:42:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 12 May 2026 00:42:33 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 12 May 2026 00:42:30 -0700
Message-ID: <d7cf71e13ea9a343fe8a285642c00a000c519d96.camel@microchip.com>
Subject: Re: [PATCH net-next v4 7/9] net: dsa: lan9645x: add mac table
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
Date: Tue, 12 May 2026 09:42:29 +0200
In-Reply-To: <20260506014614.1616825-1-kuba@kernel.org>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-7-f1b6005fa8b7@microchip.com>
	 <20260506014614.1616825-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6EDEB51C129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286987-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Action: no action

On Tue, 2026-05-05 at 18:46 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: lan9645x: add mac table integration
>=20
> This patch adds MAC table support and hooks it into the DSA FDB callbacks
> (port_fdb_add, port_fdb_del, port_fdb_dump, port_fast_age), along with a
> port-filtered flush path and a GET_NEXT-based dump helper.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/driver=
s/net/dsa/microchip/lan9645x/lan9645x_mac.c
> > new file mode 100644
> > index 000000000000..7ae23d3464f8
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
>=20
> [ ... ]
>=20
> > +void lan9645x_mac_init(struct lan9645x *lan9645x)
> > +{
> > +     u32 val;
> > +
> > +     mutex_init(&lan9645x->mact_lock);
> > +
> > +     /* Clear the MAC table */
> > +     lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_INIT),
> > +            lan9645x, ANA_MACACCESS);
> > +
> > +     if (lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
> > +                                  ANA_MACACCESS_MAC_TABLE_CMD_GET(val)=
 =3D=3D
> > +                                  CMD_IDLE))
> > +             dev_err(lan9645x->dev, "mac init timeout\n");
> > +}
>=20
> Should lan9645x_mac_init() propagate the CMD_INIT timeout instead of
> logging and returning?
>=20
> It is declared void and the only timeout handling is a dev_err().  The
> caller in lan9645x_setup() invokes it without a return value and then
> proceeds to configure flooding PGIDs, per-port CPU forwarding, and
> register the dsa_switch_ops callbacks (.port_fdb_add, .port_fdb_del,
> .port_fast_age, .port_fdb_dump) while the MAC table command engine may
> still be busy.
>=20
> For comparison, lan9645x_vlan_init() (called just above in setup) treats
> the structurally identical clear-table timeout as fatal:
>=20
>         lan_wr(ANA_VLANACCESS_VLAN_TBL_CMD_SET(VLANACCESS_CMD_INIT),
>                lan9645x, ANA_VLANACCESS);
>=20
>         err =3D lan9645x_vlan_wait_for_completion(lan9645x);
>         if (err) {
>                 dev_err(lan9645x->dev, "Vlan clear table failed\n");
>                 return err;
>         }
>=20
> Would returning an int from lan9645x_mac_init() and checking it in
> lan9645x_setup() be more consistent?
>=20

Yes I think that is a good idea, I will return an error here.

> [ ... ]
>=20
> > +int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
> > +                        dsa_fdb_dump_cb_t *cb, void *data)
> > +{
> > +     u8 mac[ETH_ALEN] __aligned(2);
> > +     u32 mach, macl, maca;
> > +     int err =3D 0;
> > +     u32 autoage;
> > +     u64 addr;
> > +     u16 vid;
> > +     u8 type;
>=20
> [ ... ]
>=20
> > +             type =3D ANA_MACACCESS_ENTRYTYPE_GET(maca);
> > +             mach =3D lan_rd(lan9645x, ANA_MACHDATA);
> > +             macl =3D lan_rd(lan9645x, ANA_MACLDATA);
> > +
> > +             if (ANA_MACACCESS_DEST_IDX_GET(maca) =3D=3D port &&
> > +                 type =3D=3D ENTRYTYPE_NORMAL) {
> > +                     addr =3D (u64)ANA_MACHDATA_MACHDATA_GET(mach) << =
32 |
> > +                            macl;
> > +                     u64_to_ether_addr(addr, mac);
> > +                     vid =3D ANA_MACHDATA_VID_GET(mach);
> > +                     if (vid > VLAN_MAX)
> > +                             vid =3D 0;
> > +
> > +                     err =3D cb(mac, vid, false, data);
> > +                     if (err)
> > +                             break;
> > +             }
> > +     }
>=20
> Does this filter cause user-added FDB entries to be invisible to
> 'bridge fdb show'?
>=20
> lan9645x_fdb_add() unconditionally programs entries as ENTRYTYPE_LOCKED:
>=20
>         return lan9645x_mact_learn(lan9645x, dest, addr, vid, ENTRYTYPE_L=
OCKED);
>=20
> but the dump above only reports entries matching ENTRYTYPE_NORMAL, so any
> entry installed via 'bridge fdb add dev swpN <mac> self [static]' is
> present in hardware and not reported through port_fdb_dump.
>=20
> For NTF_SELF entries the DSA core path
> (net/dsa/user.c:dsa_user_port_fdb_do_dump) depends on port_fdb_dump to
> surface entries that are not tracked in the bridge software FDB.
>=20
> Separately, the callback hardcodes is_static=3Dfalse for every reported
> entry:
>=20
>         err =3D cb(mac, vid, false, data);
>=20
> If the ENTRYTYPE_LOCKED filter is relaxed, would is_static need to be
> derived from the entry type, similar to ocelot_fdb_dump() in
> drivers/net/ethernet/mscc/ocelot.c which uses
> (entry.type =3D=3D ENTRYTYPE_LOCKED)?


This is intentional, we only dump the dynamically learned entries which
the network stack can not know about. The static entries are already
reported, for instance

bridge fdb add dev swpN <mac> self

will show up on the conduit, and get programmed toward the CPU_PORT in
hardware.

Including these would duplicate entries in bridge fdb show. I will add
a comment about this.


>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index c99189ce586e..b21e1bf25b0c 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > @@ -139,6 +140,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >       err =3D lan9645x_vlan_init(lan9645x);
> >       if (err)
> >               return err;
> > +     lan9645x_mac_init(lan9645x);
>=20
> Related to the lan9645x_mac_init() comment above, should this call
> check a return value and abort setup on failure rather than continuing
> to register switch ops with a potentially wedged MAC table engine?
>=20

Yes I will add this.

> [ ... ]
>=20
> > +static int lan9645x_fdb_add(struct dsa_switch *ds, int port,
> > +                         const unsigned char *addr, u16 vid,
> > +                         struct dsa_db db)
> > +{
> > +     struct net_device *br =3D lan9645x_db2bridge(db);
> > +     struct dsa_port *dp =3D dsa_to_port(ds, port);
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     int dest;
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
> > +     dest =3D dsa_port_is_cpu(dp) ? PGID_CPU : port;
> > +
> > +     return lan9645x_mact_learn(lan9645x, dest, addr, vid, ENTRYTYPE_L=
OCKED);
> > +}
>=20
> See the question above about lan9645x_mact_dsa_dump() filtering on
> ENTRYTYPE_NORMAL: entries created here with ENTRYTYPE_LOCKED do not
> appear to be reported by port_fdb_dump.

But they are reported by other means already, so we try to avoid the
duplication.


