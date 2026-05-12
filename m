Return-Path: <netdev+bounces-286988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB4DEQrbAmrJyAEAu9opvQ
	(envelope-from <netdev+bounces-286988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:47:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C0551C211
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58E83302445F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE9A481222;
	Tue, 12 May 2026 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ImWiGKN8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45694480DC9;
	Tue, 12 May 2026 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571944; cv=none; b=A5DhURcQuENJp59YF1JeVe/yZRwCID5awZH+KE9zSXHkIB86osOusUqbWeFv/ncXSoB2+nInu6KZLwRkeJvewwmElyha60wb2QZRDgx6V2H4mRSt6gI78mPdqdySUlkrLRpNEmAAtuLWPYZBgvBk1HZ5cIQM9D++vL58OfB1F+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571944; c=relaxed/simple;
	bh=Rr03NR4nj+PXY2Go2NPeoJ6eZbZIwlqJ5SdV9WcHg9Y=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=suK0LPc4CnTMNBMi3ltggVAV+e27lzVvuHaNLXw8UpQ61Lw2k0ATb4lofAJeKebIE2+/R2gEXLBV0Xee0IyFXlJiKi90SlxxOQQe/1nTLb1rMonC9zjx3FyB2wHhlyDL8Qxss7yZ0sw1c/sa4K2OocJrEL38gqYom3iyTzzM1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ImWiGKN8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778571938; x=1810107938;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Rr03NR4nj+PXY2Go2NPeoJ6eZbZIwlqJ5SdV9WcHg9Y=;
  b=ImWiGKN8ho/LpehnHZ9zaPG8QsLxPFuwDvjBRxb9wJM593kLVYwj6yQt
   CN0UwphUS5YtylZ0Arx0FGaHvALF5jfSrzd4r5sL9wXJzXBCcVJVw7k/6
   v9Opvk1JRa0Rvq8V/CcYbt6V2i7qlbAvu5KT8eO3evMYBpfNZGhG+lqae
   Cyeg8bd3JZxEJWZ401URnVc7V4AaLyQ4jyZF6OtlMHTp7rdnVKqJpMC0L
   RRfhkT8P1O2kVu405oKKd/eurV1Q1YplDQC8n3bKVddSklEGnQpmNjgBS
   uyHO3szhhN0MimkCJWlA9TRL2ubTC376Bp8DPguUIZcRvSkeffJ8FmBBI
   Q==;
X-CSE-ConnectionGUID: OyC0JCsKQAONdiAid1+YGg==
X-CSE-MsgGUID: e8IoqHhgRVqSZW8UBlT4jA==
X-IronPort-AV: E=Sophos;i="6.23,230,1770620400"; 
   d="scan'208";a="57379055"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2026 00:45:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 12 May 2026 00:45:29 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 12 May 2026 00:45:26 -0700
Message-ID: <f4c4ad7d6c690cec90fa1cb3373286d01b32db52.camel@microchip.com>
Subject: Re: [PATCH net-next v4 8/9] net: dsa: lan9645x: add mdb management
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Tue, 12 May 2026 09:45:25 +0200
In-Reply-To: <20260506014616.1616843-1-kuba@kernel.org>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-8-f1b6005fa8b7@microchip.com>
	 <20260506014616.1616843-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B5C0551C211
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286988-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-05 at 18:46 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: lan9645x: add mdb management
>=20
> This change adds DSA mdb callbacks for lan9645x, with distinct handling
> for L2 multicast (PGID-backed) and IP multicast (port mask inline in
> the mac table).
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index b21e1bf25b0c..15a493c1f215 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > @@ -70,6 +70,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
> >       destroy_workqueue(lan9645x->owq);
> >       lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
> >       lan9645x_mac_deinit(lan9645x);
> > +     lan9645x_mdb_deinit(lan9645x);
> >       mutex_destroy(&lan9645x->fwd_domain_lock);
> >  }
> >=20
> > @@ -141,6 +142,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >       if (err)
> >               return err;
> >       lan9645x_mac_init(lan9645x);
> > +     lan9645x_mdb_init(lan9645x);
>=20
> Is lan9645x_mdb_deinit() reachable when lan9645x_setup() fails after
> this point?
>=20
> lan9645x_setup() continues after lan9645x_mdb_init() with operations
> that can fail, including alloc_ordered_workqueue() near the bottom of
> the function which returns -ENOMEM. On error from ds->ops->setup(),
> dsa_switch_setup() in net/dsa/dsa.c jumps directly to the notifier
> cleanup path and does not invoke ds->ops->teardown:
>=20
>         err =3D ds->ops->setup(ds);
>         if (err < 0)
>                 goto unregister_notifier;
>=20
> Since lan9645x_teardown() is where lan9645x_mdb_deinit() runs,
> the freshly initialized mdb_lock (and its lockdep map) is never
> torn down if setup fails after lan9645x_mdb_init().
>=20
> Could lan9645x_mdb_init() be moved later in setup (after the steps
> that can still fail), or could setup-time error unwinding be added
> for mdb_lock, mact_lock and fwd_domain_lock? The same pattern exists
> for mact_lock (from lan9645x_mac_init()) and fwd_domain_lock, and this
> change adds mdb_lock to the same class of resources.

Yes I will add this deinit to the unwind in the error path.

>=20
> >=20
> >       /* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
> >       lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_port.c
> > index 661cd00465e2..5dee92940f89 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> > @@ -189,6 +189,14 @@ int lan9645x_port_setup(struct dsa_switch *ds, int=
 port)
> >               ANA_PORT_CFG_PORTID_VAL,
> >               lan9645x, ANA_PORT_CFG(p->chip_port));
> >=20
> > +     lan_rmw(ANA_CPU_FWD_CFG_IGMP_REDIR_ENA_SET(true) |
> > +             ANA_CPU_FWD_CFG_MLD_REDIR_ENA_SET(true) |
> > +             ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA_SET(true),
> > +             ANA_CPU_FWD_CFG_IGMP_REDIR_ENA |
> > +             ANA_CPU_FWD_CFG_MLD_REDIR_ENA |
> > +             ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA,
> > +             lan9645x, ANA_CPU_FWD_CFG(p->chip_port));
> > +
>=20
> Should this block be guarded for the NPI (CPU-facing) port?
>=20
> The IGMP/MLD redirect and IPMC control-copy bits are enabled here for
> every chip_port that lan9645x_port_setup() is called on, with no
> check for whether the port is the NPI. The VLAN host-mode call a few
> lines below explicitly excludes the NPI:
>=20
>         if (p->chip_port !=3D lan9645x->npi)
>                 lan9645x_vlan_set_hostmode(p);
>=20
> In the related driver for the same family, drivers/net/ethernet/mscc/
> ocelot_net.c, ocelot_port_attr_mc_set() toggles these same bits only
> on user ports in response to SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED.
>=20
> Can CPU-injected IGMP/MLD/IPMC-control frames end up being redirected
> or copied back to the CPU with this configuration, or does IFH_BYPASS=3D1
> fully suppress these classifiers on NPI ingress? If the latter, the
> bits on the NPI are at least wasteful; if the former, duplicate
> delivery or a trap loop seems possible.

No it does work, but it does makes more sense to not do this for the
npi port. I will change this.

>=20
> >       if (p->chip_port !=3D lan9645x->npi)
> >               lan9645x_vlan_set_hostmode(p);
> >=20


