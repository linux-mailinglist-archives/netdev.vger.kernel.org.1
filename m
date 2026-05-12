Return-Path: <netdev+bounces-286980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eym6OT/XAmppyAEAu9opvQ
	(envelope-from <netdev+bounces-286980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:31:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED351BDD5
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0598A30151CC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F647AF75;
	Tue, 12 May 2026 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uqONR9IH"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C544418F0;
	Tue, 12 May 2026 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570700; cv=none; b=h44/PKobQtE5XofI0i9zW+I7mL5rSorVupeo7ZWYqfoYKoYFXOjIznTywMkUiZuY4tyZY4Mcz505KYJ55aAybaAXngKZHFLAAV01udGTnSYErAFObGQq3aPQ9UaKVI4EtoHFw+xaf3szKLEx9/SWNElLoPf71Ot9X0wxjlNk2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570700; c=relaxed/simple;
	bh=1d1VxlRbneZvYycTjJliH9dA7FHgWIWCEnI03GC7gAg=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYN9r2qAPR4fHS81ZIqToiCJI0pFmOZf7v3Ju6ObD6RU5Bkn+l/lQx0qJv9P+H05P2fvdVrW+9/SV16eMDtePZU4Cc9sUYdu0tDoDruu/ZjPNPpkFEwGA+2F0w0MRLMd+/TIJ1Y4S7BjxGdBtvepsme2KSnU9b8SntJQhsaa8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uqONR9IH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778570692; x=1810106692;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1d1VxlRbneZvYycTjJliH9dA7FHgWIWCEnI03GC7gAg=;
  b=uqONR9IHBxJOuHmH/vKXAKHhWrNNbov+okfSdiwpRWzpPmTQxbOUBMB2
   eTwOkR0iCFQjmwZil/4hSu0i8CZpy+a2XPcjf2dzRmx/EfizbkuNYDdiO
   lhY4GLyrGKyc24O3E+fSHcPo8bMPJxXHcFtOp/Jy0f/S66I6a03JBhEJH
   67TLzbz06KNNAviKNPPLpqerPDk+74et7ndKnERGXymRgVKJhEiQvTTQk
   H3Nifm2TaM5qcVDuq9ELrBU06Rxv7fWh+RE9mIZDPu24WdPRIHO2rF2j8
   +goB/rleMW+bIQBINrQ3pfIokYylHwA7Fitizx99WXfJypPfY1aTO11QB
   Q==;
X-CSE-ConnectionGUID: 4pfZU+25Q3+PbLLt5KsDIw==
X-CSE-MsgGUID: wQSUnhlaSQS5FNI2VJjh7A==
X-IronPort-AV: E=Sophos;i="6.23,230,1770620400"; 
   d="scan'208";a="65690766"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2026 00:24:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 12 May 2026 00:24:43 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 12 May 2026 00:24:40 -0700
Message-ID: <9896e0cfbdd51a5572e8334768fd7a43bad7dcb6.camel@microchip.com>
Subject: Re: [PATCH net-next v4 5/9] net: dsa: lan9645x: add bridge support
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Tue, 12 May 2026 09:24:39 +0200
In-Reply-To: <20260506014609.1616782-1-kuba@kernel.org>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-5-f1b6005fa8b7@microchip.com>
	 <20260506014609.1616782-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 78ED351BDD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286980-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-05 at 18:46 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: lan9645x: add bridge support
>=20
> This patch adds hardware offload support for a single bridge device in
> the lan9645x DSA driver. It introduces the fwd_domain_lock mutex and an
> ordered workqueue, and wires up the bridge-integration switch ops.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index 6fd66ea67cfd..70f6a11f0753 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > @@ -67,7 +67,9 @@ static void lan9645x_teardown(struct dsa_switch *ds)
> >  {
> >       struct lan9645x *lan9645x =3D ds->priv;
> >=20
> > +     destroy_workqueue(lan9645x->owq);
> >       lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
> > +     mutex_destroy(&lan9645x->fwd_domain_lock);
> >  }
>=20
> [ ... ]
>=20
> > @@ -133,6 +135,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >               return err;
> >       }
> >=20
> > +     mutex_init(&lan9645x->fwd_domain_lock);
> > +
> >       /* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
> >       lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
> >              ANA_AGGR_CFG_AC_DMAC_ENA,
>=20
> [ ... ]
>=20
> > @@ -239,6 +243,11 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >=20
> >       lan9645x_port_set_tail_drop_wm(lan9645x);
> >=20
> > +     lan9645x->owq =3D alloc_ordered_workqueue("%s-owq", 0,
> > +                                             dev_name(lan9645x->dev));
> > +     if (!lan9645x->owq)
> > +             return -ENOMEM;
> > +
>=20
> Does this error path leak the fwd_domain_lock initialization and the
> NPI port setup?
>=20
> When alloc_ordered_workqueue() fails, lan9645x_setup() returns -ENOMEM
> directly.  In DSA, dsa_switch_setup() handles a failed ds->ops->setup()
> by jumping past the teardown label:
>=20
>     err =3D ds->ops->setup(ds);
>     if (err < 0)
>         goto unregister_notifier;
>=20
> So lan9645x_teardown() is never invoked on the setup failure path, and
> the mutex_destroy(&lan9645x->fwd_domain_lock) and
> lan9645x_npi_port_deinit() calls it contains are skipped.
>=20
> With CONFIG_DEBUG_MUTEXES or lockdep enabled, the mutex debug state is
> left dangling against devm-managed memory, and the NPI port hardware
> configuration performed by lan9645x_tag_npi_setup() is left in place
> until the next reset_switch().
>=20
> Should the failure path of lan9645x_setup() unwind the mutex_init()
> and lan9645x_tag_npi_setup() it performed earlier?
>=20

I will make sure to unwind this in the error path.

> >       ds->mtu_enforcement_ingress =3D true;
> >       ds->assisted_learning_on_cpu_port =3D true;
> >       ds->fdb_isolation =3D true;
> > @@ -257,6 +266,272 @@ static void lan9645x_port_phylink_get_caps(struct=
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
> > +     lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(msecs ? age_secs : 0),
> > +             ANA_AUTOAGE_AGE_PERIOD,
> > +             lan9645x, ANA_AUTOAGE);
> > +     return 0;
> > +}
>=20
> Can this silently truncate user-supplied ageing times that exceed the
> hardware field?
>=20
> ANA_AUTOAGE_AGE_PERIOD is GENMASK(20, 1), so the maximum representable
> age_secs is 2^20 - 1 =3D 1048575.  ANA_AUTOAGE_AGE_PERIOD_SET() expands
> to FIELD_PREP(), whose runtime path in include/linux/bitfield.h is:
>=20
>     ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask)
>=20
> which masks the value without any range check or warning.
>=20
> The driver does not populate ds->ageing_time_min or ds->ageing_time_max,
> and dsa_switch_ageing_time() gates its -ERANGE checks on those being
> non-zero:
>=20
>     if (ds->ageing_time_min && ageing_time < ds->ageing_time_min)
>         return -ERANGE;
>     if (ds->ageing_time_max && ageing_time > ds->ageing_time_max)
>         return -ERANGE;
>=20
> so a large ageing time set via "ip link set br0 type bridge ageing_time
> <large>" reaches this callback and is silently truncated to a short
> period.  Should lan9645x set ageing_time_min/max so out-of-range values
> are rejected instead?
>=20

That is a good idea, I will initialize ageing_time_max.

> [ ... ]
>=20
> > +static void lan9645x_host_flood_work_fn(struct work_struct *work)
> > +{
> > +     struct lan9645x_port *p =3D container_of(work, struct lan9645x_po=
rt,
> > +                                            host_flood_work);
> > +     struct lan9645x *lan9645x =3D p->lan9645x;
> > +
> > +     mutex_lock(&lan9645x->fwd_domain_lock);
> > +     __lan9645x_port_mark_host_flood(lan9645x, p->chip_port,
> > +                                     p->host_flood_uc, p->host_flood_m=
c);
> > +     __lan9645x_port_set_host_flood(lan9645x);
> > +     mutex_unlock(&lan9645x->fwd_domain_lock);
> > +}
> > +
> > +/* Called in atomic context. */
> > +static void lan9645x_port_set_host_flood(struct dsa_switch *ds, int po=
rt,
> > +                                      bool uc, bool mc)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct lan9645x_port *p;
> > +
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +
> > +     p->host_flood_uc =3D uc;
> > +     p->host_flood_mc =3D mc;
> > +     queue_work(lan9645x->owq, &p->host_flood_work);
> > +}
>=20
> Can the worker observe a mixed (uc, mc) tuple that no caller requested?
>=20
> The atomic-context writer stores p->host_flood_uc and p->host_flood_mc
> as two independent unsynchronized writes and then queues the work.  The
> worker takes fwd_domain_lock and reads both, but the writer never takes
> that lock (it cannot =E2=80=94 it is called in atomic context, and fwd_do=
main_lock
> is a mutex).
>=20
> If a second update arrives between the worker's two reads, the worker
> can program PGID_UC/MC/MCIPV4/MCIPV6 on the CPU port with a combination
> that was never requested by either call.  The state converges on the
> next work run triggered by the second queue_work(), but the hardware is
> transiently programmed with a tuple nobody asked for.
>=20
> Would it be safer to bundle both booleans into a single atomic word, or
> to use a spinlock that can be taken in atomic context to protect the
> pair of stores?
>=20

Yes I will pack these into an u8 and use {READ,WRITE}_ONCE.

> > +
> > +static int lan9645x_port_bridge_join(struct dsa_switch *ds, int port,
> > +                                  struct dsa_bridge bridge,
> > +                                  bool *tx_fwd_offload,
> > +                                  struct netlink_ext_ack *extack)
>=20
> [ ... ]


