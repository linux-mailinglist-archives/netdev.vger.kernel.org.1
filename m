Return-Path: <netdev+bounces-287009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIcpGXTpAmpKygEAu9opvQ
	(envelope-from <netdev+bounces-287009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:48:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AF751D01F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 254C8305E444
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3682386566;
	Tue, 12 May 2026 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Cd3enZ95"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C62FE071;
	Tue, 12 May 2026 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575660; cv=none; b=oeCuVIeGAq+45CijIzwaYFH62us+34j1mqR3tWhb/ofgRupAEipP9rkKRlshOx/3fqipkJHI9Pripq6nG60MlvLbPBXasfCwukBx62u0wLfL096V+3VaLLKTtMteIphLY2c/PqVQnJsFF474ZTAuOiSE5zdJ2GKop/VSVOtzicc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575660; c=relaxed/simple;
	bh=yVj6qcAQtPfLOWXdwnIyMj6OCRTMuEdBo5PeKxLotsI=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOpC0oEhPYAvg37HiWKpTqfmXsAPp5gDzvaVLyS+aOfubeLMwmNbP8+eQAmNAh8yR9cKi7tFTzdBI1ICGfGgRjZ16d8ZxLlLfM5LnjrVSB1SS1SZfeZwBBhTBH0eQsYb8wTxqSGplRcmWbZfbtr6RAbd/6Ks3XF8sR/Sw+ffSNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Cd3enZ95; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778575654; x=1810111654;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yVj6qcAQtPfLOWXdwnIyMj6OCRTMuEdBo5PeKxLotsI=;
  b=Cd3enZ95gY0e28+zXImIy8764kmU7oOIYe2PXXlg7Pvmz9o665eY4qNZ
   HVKZiJblKC546pVgmZGRBwHzm9+I/o3x4EomU3zZAfSBebwdyMLJYui57
   EaMleeIEvV1Bg3kzOOk5jdomlv5nMGnM7fZNjEzSpGGMw7YIyRYLeD2Do
   YbatP2OkLgRMkfXSJr+QWGzFYdK4PCdWGcL3EABS36EbS3n+d2K8Iv0t9
   2iNt4MvrQzdGCctNQ6lNnZuPAUNg+59rf/kbX+NycIifSHGaPDp7mhnzK
   52kPfg0Bj6ffS/EycXD9BpBFEZrdV7e/cackCFEH3KG/UoUNh7j2h2TGx
   Q==;
X-CSE-ConnectionGUID: UxxL9zsTRgKgmDgezwKYWQ==
X-CSE-MsgGUID: sjI6UnJoSPW1aPIkF8pclw==
X-IronPort-AV: E=Sophos;i="6.23,230,1770620400"; 
   d="scan'208";a="224614866"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:47:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 12 May 2026 01:47:26 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 12 May 2026 01:47:23 -0700
Message-ID: <c48f64d22429c1d4e10015033da4fff16c2a6d7d.camel@microchip.com>
Subject: Re: [PATCH net-next v4 9/9] net: dsa: lan9645x: add port statistics
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Tue, 12 May 2026 10:47:22 +0200
In-Reply-To: <20260506014618.1616861-1-kuba@kernel.org>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-9-f1b6005fa8b7@microchip.com>
	 <20260506014618.1616861-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D3AF751D01F
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
	TAGGED_FROM(0.00)[bounces-287009-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-05 at 18:46 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: lan9645x: add port statistics
>=20
> This patch wires up ethtool -S, standard ethtool group stats,
> and ndo_get_stats64 for the lan9645x DSA driver. A delayed work
> polls the 32-bit hardware counters every 3 seconds and accumulates
> them into a 64-bit software cache to handle hardware wraparound.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index 15a493c1f215..cea46bfe729e 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>=20
> [ ... ]
>=20
> > @@ -255,6 +257,12 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >       if (!lan9645x->owq)
> >               return -ENOMEM;
> >=20
> > +     err =3D lan9645x_stats_init(lan9645x);
> > +     if (err) {
> > +             dev_err(dev, "Failed to init stats.\n");
> > +             goto owq_destroy;
> > +     }
> > +
> >       ds->mtu_enforcement_ingress =3D true;
> >       ds->assisted_learning_on_cpu_port =3D true;
> >       ds->fdb_isolation =3D true;
> > @@ -265,6 +273,10 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >                lan9645x->num_phys_ports - lan9645x->num_port_dis);
> >=20
> >       return 0;
> > +
> > +owq_destroy:
> > +     destroy_workqueue(lan9645x->owq);
> > +     return err;
> >  }
>=20
> Is this owq_destroy error path reachable today?
>=20
> Looking at lan9645x_stats_init():
>=20
>     int lan9645x_stats_init(struct lan9645x *lan9645x)
>     {
>         struct lan9645x_stats *stats =3D lan9645x->stats;
>=20
>         queue_delayed_work(stats->queue, &stats->work,
>                            LAN9645X_STATS_CHECK_DELAY);
>=20
>         return 0;
>     }
>=20
> it unconditionally returns 0, so the goto owq_destroy branch is dead.
>=20
> If a future change either makes lan9645x_stats_init() return an error, or
> adds any fallible step after it in lan9645x_setup(), the cleanup would
> fall through owq_destroy without calling lan9645x_stats_deinit(), leaving
> the self-requeuing delayed work armed on stats->queue.
>=20
> Also, dsa_switch_setup() in net/dsa/dsa.c does not invoke ds->ops->teardo=
wn
> when ops->setup() itself fails, so lan9645x_teardown (which is where
> lan9645x_stats_deinit is called today) will not run in that scenario.
>=20
> Then in lan9645x_remove() -> lan9645x_stats_free() -> destroy_workqueue()=
,
> the queue would be drained with a chained self-requeue still live. Would
> adding a dedicated label that calls lan9645x_stats_deinit() before fallin=
g
> through to owq_destroy be safer for future edits?
>=20


I will make lan9645x_stats_init return void. There is nothing after
lan9645x_stats_init which can fail, so at this point a label for=C2=A0
lan9645x_stats_deinit would be dead also?

> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/driv=
ers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > new file mode 100644
> > index 000000000000..46ac62b4016f
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
>=20
> [ ... ]
>=20
> > +static const struct lan9645x_ethtool_stat lan9645x_port_ethtool_stats[=
] =3D {
> > +     { "rx_cat_drop",        SCNT_RX_CAT_DROP },
> > +     { "rx_red_prio_0",      SCNT_RX_RED_PRIO_0 },
>=20
> Per Documentation/networking/statistics.rst and the netdev stats hierarch=
y,
> counters that have a standard uAPI must not be duplicated in ethtool -S.
>=20
> The rx_cat_drop counter is summed into stats->rx_dropped in
> lan9645x_stats_get_stats64():
>=20
>     stats->rx_dropped =3D c[SCNT_RX_LONG] +
>                         c[SCNT_DR_LOCAL] +
>                         c[SCNT_DR_TAIL] +
>                         c[SCNT_RX_CAT_DROP] +
>                         ...
>=20
> Since rtnl_link_stats64.rx_dropped is reachable via "ip -s link show",
> does exposing rx_cat_drop here duplicate a value already covered by the
> standard uAPI?
>=20
> [ ... ]
>=20
> > +     { "tx_drop",            SCNT_TX_DROP },
>=20
> Similarly, tx_drop feeds stats->tx_dropped:
>=20
>     stats->tx_dropped =3D c[SCNT_TX_DROP] + c[SCNT_TX_AGED];
>=20
> Should tx_drop be dropped from the ethtool -S list for the same reason?
>=20
> [ ... ]
>=20
> > +     { "tx_aged",            SCNT_TX_AGED },
> > +     { "tx_bufdrop",         SCNT_TX_BUFDROP },
>=20
> tx_aged is also summed into stats->tx_dropped in
> lan9645x_stats_get_stats64(), so does it fall under the same duplicate-uA=
PI
> concern as tx_drop?
>=20
> A related question about tx_bufdrop: if SCNT_TX_BUFDROP represents transm=
it
> frames dropped due to buffer exhaustion, why is it not included in
> stats->tx_dropped alongside SCNT_TX_DROP and SCNT_TX_AGED?
>=20
>     stats->tx_dropped =3D c[SCNT_TX_DROP] + c[SCNT_TX_AGED];
>=20
> If tx_bufdrop is in fact a transmit-drop cause, would users of
> ip -s link show see an under-reported tx_dropped relative to the private
> ethtool counter?


Yes, I think this is a bug, and bufdrop should be added here. I will make s=
ure
there no overlap, and otherwise add it.

>=20
> > +     { "dr_local",           SCNT_DR_LOCAL },
> > +     { "dr_tail",            SCNT_DR_TAIL },
>=20
> dr_local and dr_tail are also fed into stats->rx_dropped:
>=20
>     stats->rx_dropped =3D c[SCNT_RX_LONG] +
>                         c[SCNT_DR_LOCAL] +
>                         c[SCNT_DR_TAIL] +
>                         ...
>=20
> Would it be appropriate to drop these from the ethtool -S list as well,
> given they are already aggregated into the standard rx_dropped counter?
>=20
> [ ... ]
>=20
> > +};
>=20
> [ ... ]
>=20
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
>=20
> The commit message says this worker "update[s] it frequently to handle
> overflows in hardware."
>=20
> Looking at lan9645x_stats_add_cnt():
>=20
>     static inline void lan9645x_stats_add_cnt(u64 *cnt, u32 val)
>     {
>         if (val < (*cnt & U32_MAX))
>             *cnt +=3D (u64)1 << 32; /* value has wrapped */
>=20
>         *cnt =3D (*cnt & ~(u64)U32_MAX) + val;
>     }
>=20
> this compensates for at most one 32-bit wrap per polling interval. If two
> or more wraps happen between reads, the low-half comparison no longer
> detects the missed wrap and the 64-bit counter silently loses 2^32 per
> missed wrap.
>=20
> At the chip's 2.5 Gbps line rate (LAN9645X_SPEED_2500 in lan9645x_main.h)=
,
> a 32-bit byte counter wraps roughly every 13.7 s, so two wraps happen in
> about 27.5 s. The polling interval is LAN9645X_STATS_CHECK_DELAY =3D 3 * =
HZ,
> but there is no upper bound on the actual elapsed time between reads:
> delayed work can be stretched by system suspend/resume, heavy CPU load, o=
r
> regmap/SPI contention.
>=20
> Would it be worthwhile to either bound the worst-case polling gap
> (e.g. a suspend/resume hook that forces a read, or a timestamp-based
> sanity check that detects a stretched interval and logs a warning) so
> that rx_bytes/tx_bytes reported to ndo_get_stats64 and ethtool cannot
> silently undercount by multiples of 2^32?
>=20

It is true, and the timing is chosen so at most 1 wrap is supposed to occur=
.
I believe this is the exact pattern already used by ocelot, lan966x, sparx5
and lan969x.

Maybe I misunderstand the suspend/resume comment. We do not implement
support to suspend/resume, but if we did, then I assume you can suspend
for an arbitrary amount of time, so doing an additional read on=C2=A0
suspend/resume will not solve this problem?

The hw counters are 32bit. To stay synced they must never wrap more than
once. I think the only way avoid this problem is if we can make absolute
guarantees about how often the polling code runs?

> [ ... ]


