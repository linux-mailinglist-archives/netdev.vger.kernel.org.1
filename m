Return-Path: <netdev+bounces-297028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o8IuDoH/J2rI6wIAu9opvQ
	(envelope-from <netdev+bounces-297028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:56:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2465FBC5
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:56:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b="ab/hNcSi";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297028-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297028-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47D01309C9F9
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13F64028D9;
	Tue,  9 Jun 2026 11:50:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD13FDBEC;
	Tue,  9 Jun 2026 11:50:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005837; cv=none; b=Nbf/PD91BsqxF8io7ULnaM/lcJzqqBoU1JjHlkalGuCcrfb4Iz8MT+MuvGAHc2ZIRXW66YaboyqPKhlDFRbeBokj0qHE5QWzPdmyrh8T/Y1gFEJvxV6BZBxF71pVAwM9+wvKvzr4GDSca05tAT4ZN34CppPZIRcPcVb9GvyumXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005837; c=relaxed/simple;
	bh=MU6EDuK1Hk2ydJJG7HBbqIXO3OkmP0YpxmgZiKbMHfI=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYFKi0Ah3DYg7CbjJKtaC9NR/L7uSKROzg6dTn3WsTp5rR36cA8dGQWO1qIC08j1OnSXH7n8zHhQHad5ySLNd3he6PK/W2NEDw2eo2hgpnh3tiwMOGHLFXzlo9u4icarwwWvHdZ3qFijGmhCQwFOpE4agG74XadSsndF+QUo170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ab/hNcSi; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781005837; x=1812541837;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MU6EDuK1Hk2ydJJG7HBbqIXO3OkmP0YpxmgZiKbMHfI=;
  b=ab/hNcSi2IHuoRpLH7liPOxJsKVtPfPlBEwnokOvlex/RN3L4ghpeFJl
   L/k9EdAqPEcMjf6JnZSGmry3Uj8k6UkjOimsBjZX/oKwQ5I0ieSdpZYJP
   s/IdKS2aPCqefQyBkyiqyPMgWv7fHoKAkpEHTGjfdaI1nCxJWJEfJO2U1
   Pze+MhAmnFyfC8pPAhee+1/RTYe3WDZdnk6/Y6k73BwKBMrMSW3WwZSfO
   3ZsYVisTPcPOg6WtDEFrY4G+i8R1EMUJgjipPQ9DqP1MoMq4/cG1q4NaY
   BoolZ377h7I71KJ1TADAB4uGjZargiJyADQoKtwzSel182km4a7vICpXy
   Q==;
X-CSE-ConnectionGUID: zFAq9PcuQ9yx5sJ3gBlw8g==
X-CSE-MsgGUID: z2vqpbSORsSg5f6Ep0ddDA==
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="58821459"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jun 2026 04:50:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Jun 2026 04:50:34 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 9 Jun 2026 04:50:30 -0700
Message-ID: <39e0626955d50970208bdccc74c40c83e6ad1ea0.camel@microchip.com>
Subject: Re: [PATCH net-next v7 4/9] net: dsa: lan9645x: add basic dsa
 driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Tue, 9 Jun 2026 13:50:30 +0200
In-Reply-To: <44c635f8-e17e-44bf-b34b-60abcde29577@lunn.ch>
References: <20260603-dsa_lan9645x_switch_driver_base-v7-0-b2f90e676707@microchip.com>
	 <20260603-dsa_lan9645x_switch_driver_base-v7-4-b2f90e676707@microchip.com>
	 <9ee993d0-9a71-48ff-b368-fcebe1ee9e48@lunn.ch>
	 <a9ab4d129f2e3158c1a7b01d0a975fac00a05893.camel@microchip.com>
	 <44c635f8-e17e-44bf-b34b-60abcde29577@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297028-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:UNGLinuxDriver@microchip.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:woojung.huh@microchip.com,m:linux@armlinux.org.uk,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid,microchip.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DB2465FBC5

On Tue, 2026-06-09 at 10:48 +0200, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Tue, Jun 09, 2026 at 09:08:13AM +0200, Jens Emil Schulz Ostergaard wro=
te:
> > On Mon, 2026-06-08 at 20:00 +0200, Andrew Lunn wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> > >=20
> > > > +     dsa_switch_for_each_user_port(dp, ds) {
> > > > +             if (dp->cpu_dp->ds !=3D ds) {
> > > > +                     dev_err(ds->dev,
> > > > +                             "NPI port on a remote switch is not s=
upported\n");
> > > > +                     return -EINVAL;
> > > > +             }
> > > > +
> > > > +             if (first_cpu_dp && dp->cpu_dp !=3D first_cpu_dp) {
> > > > +                     dev_err(ds->dev, "Multiple NPI ports not supp=
orted\n");
> > > > +                     return -EINVAL;
> > > > +             }
> > > > +
> > > > +             first_cpu_dp =3D dp->cpu_dp;
> > >=20
> > > The reason i asked about NPI ports is because this is looping over
> > > user ports. Yet you say one of these user ports is a CPU port. That
> > > cannot be correct.
> > >=20
> > > The first port returned by dsa_tree_for_each_cpu_port() would be
> > > first_cpu_dp.
> > >=20
> > >         Andrew
> >=20
> >=20
> > I tried to mimic the approach in drivers/net/dsa/ocelot/felix.c:
> >=20
> > static int felix_tag_npi_setup(struct dsa_switch *ds)
> > {
> >       struct dsa_port *dp, *first_cpu_dp =3D NULL;
> >       struct ocelot *ocelot =3D ds->priv;
> >=20
> >       dsa_switch_for_each_user_port(dp, ds) {
> >               if (first_cpu_dp && dp->cpu_dp !=3D first_cpu_dp) {
> >                       dev_err(ds->dev, "Multiple NPI ports not supporte=
d\n");
> >                       return -EINVAL;
> >               }
> >=20
> >               first_cpu_dp =3D dp->cpu_dp;
> >       }
> >=20
> >       if (!first_cpu_dp)
> >               return -EINVAL;
> >=20
> >       felix_npi_port_init(ocelot, first_cpu_dp->index);
> >=20
> >       return 0;
> > }
> >=20
> > Perhaps I misunderstand you, but there could be confusion about
> > terminology. The chip designers have a concept of CPU port, which is
> > used liberally in the datasheet, and in this driver code.
>=20
> > However, the concept is different from the DSA concept of a CPU port.
>=20
> And that is a problem because somebody reviewing this code is likely
> to know DSA concepts much more than the individual devices concepts.
> To aid overall Maintenance of all the DSA drivers, the driver should
> try to keep with DSA meanings.

I have tried to explain the relationship between switch CPU port and NPI
port in comments, but I am sure it could be clearer. I am also guilty of
thinking in terms of these concepts because it is how the terms are used
in the office, in the registers and datasheet and so on. It is hard
writing a driver without knowing this distinction.


>=20
> > Let us call the first switch CPU port, and the second DSA CPU port.
> >=20
> > The port we want to use as a DSA CPU port, i.e. the port with the
> > 'ethernet =3D <&host_port>;' property in the device tree, will be
> > configured to be an NPI port for injection/extraction for the switch CP=
U
> > port (which is not a physical port on the device).
>=20
> > Therefore, this NPI port is not iterated by
> > dsa_switch_for_each_user_port. The switch CPU port (index 9) is also no=
t
> > iterated by it. It is a chip internal construct with no representation
> > in the device tree, and no struct dsa_port.
>=20
> So first_cpu_dp is not a DSA CPU port. It is also not a NAPI port,
> since that is a DSA CPU port. Then what is it? Why do you need the
> concept of a switch CPU port?
>=20
>         Andrew

But first_cpu_dp _is_ a DSA CPU port (and the NPI port). What I meant is
that we are iterating user ports with dsa_switch_for_each_user_port, so
the iteration variable dp is never a DSA CPU port (and therefore not the
NPI port). But we set first_cpu_dp =3D dp->cpu_dp, not first_cpu_dp =3D dp,
so first_cpu_dp is indeed a DSA CPU port.

We find it here so we can pass it to lan9645x_npi_port_init to configure
the port module at index first_cpu_dp->index as an NPI port. In this
particular function, the switch CPU port does not occur or play a role,
I was just trying to explain the relationship in general.

Thanks,
Emil


