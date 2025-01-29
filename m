Return-Path: <netdev+bounces-161567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EFBA2266C
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 23:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B11F160A7B
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314217A5A4;
	Wed, 29 Jan 2025 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OsxuGJV0"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544EB1FC8
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738191136; cv=none; b=gt0R1PZ4Cs3iw+W21ZTdF7wTfxEUqn6t3jn4f4WrlXEdsSkctaf8f/TOPstdL/Bzuz0uZ6ODYpxPxWzMBJ4Gwt/rzacPQAS/WzYWHyKKlTQB82feiUd0fNSlHWOKu5SSmYs+I6Lhr1Rq4faEY7f9jLd013zWArQ9RLShVTEtBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738191136; c=relaxed/simple;
	bh=9aPLkzKtq4Ols7kgyn0d0UfXL2rJfe5kl7BKREz5L2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJeEsySacX2lErKBPvDEddWHSmuR1JPSCWrxJjxjwHplXPs5ofU4+bvSRRfkSjTjufcqmX2IKMv33CCPOWKTtZpoQDenhWcYpzQ1VCLUldDbV2/iIJdwOplHnx2qUyOAvbtxgQCwURzcEmberv6QemdEAW0XXS6bwy2HqVRumDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OsxuGJV0; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7034510382D08;
	Wed, 29 Jan 2025 23:52:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738191130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nXKVG0t4zGITf8n7S2vyu/Jwr8ecXTNlpEF1AdVYRX0=;
	b=OsxuGJV03HbhTj7h2FJSD0DY2+3CizTnOJxvf+vYr+vJ66OxB6q0JUBht4Y81CTHOD7+6O
	9II1FGet5n7ZIU5PUS2luXNs4YIdkAJVoFustXtI30KUIVNN0m7LjF348eZAfa8mG08n+O
	EGTDVH5pbuu8ziN8Tu+fl6qp1W45N3yGsh4Vx0fmPm8IafKtRmzZxi5AwgjI6pjiU4NH9n
	/SNhdi3Po36e5DNcI+8aN5b3PN1UOOeWRaxk8PQLOyMOhhg3vIIi7w3Z4S8k3F8LscOu/H
	3upR5frCt9FQ6yf8ER6Lq5EoKrNAgo2rVZZP3qltbcNSfvogZc8DIIXpPUtijQ==
Date: Wed, 29 Jan 2025 23:52:06 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <20250129235206.125142f4@wsk>
In-Reply-To: <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
	<6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
	<1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
	<6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
	<20250129121733.1e99f29c@wsk>
	<0383e3d9-b229-4218-a931-73185d393177@kontron.de>
	<20250129145845.3988cf04@wsk>
	<42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yzc38.I7onKQho4G/_1xAeb";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/yzc38.I7onKQho4G/_1xAeb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Frieder,

> On 29.01.25 2:58 PM, Lukasz Majewski wrote:
> > Hi Frieder,
> >  =20
> >> Hi Lukasz,
> >>
> >> On 29.01.25 12:17 PM, Lukasz Majewski wrote: =20
> >>> Hi Frieder,
> >>>    =20
> >>>> On 29.01.25 8:24 AM, Frieder Schrempf wrote:   =20
> >>>>> Hi Andrew,
> >>>>>
> >>>>> On 28.01.25 6:51 PM, Andrew Lunn wrote:     =20
> >>>>>> On Tue, Jan 28, 2025 at 05:14:46PM +0100, Frieder Schrempf
> >>>>>> wrote:     =20
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> I'm trying out HSR support on KSZ9477 with v6.12. My setup
> >>>>>>> looks like this:
> >>>>>>>
> >>>>>>> +-------------+         +-------------+
> >>>>>>> |             |         |             |
> >>>>>>> |   Node A    |         |   Node D    |
> >>>>>>> |             |         |             |
> >>>>>>> |             |         |             |
> >>>>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
> >>>>>>> +--+-------+--+         +--+------+---+
> >>>>>>>    |       |               |      |
> >>>>>>>    |       +---------------+      |
> >>>>>>>    |                              |
> >>>>>>>    |       +---------------+      |
> >>>>>>>    |       |               |      |
> >>>>>>> +--+-------+--+         +--+------+---+
> >>>>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
> >>>>>>> |             |         |             |
> >>>>>>> |             |         |             |
> >>>>>>> |   Node B    |         |   Node C    |
> >>>>>>> |             |         |             |
> >>>>>>> +-------------+         +-------------+
> >>>>>>>
> >>>>>>> On each device the LAN1 and LAN2 are added as HSR slaves.
> >>>>>>> Then I try to do ping tests between each of the HSR
> >>>>>>> interfaces.
> >>>>>>>
> >>>>>>> The result is that I can reach the neighboring nodes just
> >>>>>>> fine, but I can't reach the remote node that needs packages
> >>>>>>> to be forwarded through the other nodes. For example I can't
> >>>>>>> ping from node A to C.
> >>>>>>>
> >>>>>>> I've tried to disable HW offloading in the driver and then
> >>>>>>> everything starts working.
> >>>>>>>
> >>>>>>> Is this a problem with HW offloading in the KSZ driver, or am
> >>>>>>> I missing something essential?     =20
> >>>
> >>> Thanks for looking and testing such large scale setup.
> >>>    =20
> >>>>>>
> >>>>>> How are IP addresses configured? I assume you have a bridge,
> >>>>>> LAN1 and LAN2 are members of the bridge, and the IP address is
> >>>>>> on the bridge interface?     =20
> >>>>>
> >>>>> I have a HSR interface on each node that covers LAN1 and LAN2 as
> >>>>> slaves and the IP addresses are on those HSR interfaces. For
> >>>>> node A:
> >>>>>
> >>>>> ip link add name hsr type hsr slave1 lan1 slave2 lan2
> >>>>> supervision 45 version 1
> >>>>> ip addr add 172.20.1.1/24 dev hsr
> >>>>>
> >>>>> The other nodes have the addresses 172.20.1.2/24, 172.20.1.3/24
> >>>>> and 172.20.1.4/24 respectively.
> >>>>>
> >>>>> Then on node A, I'm doing:
> >>>>>
> >>>>> ping 172.20.1.2 # neighboring node B works
> >>>>> ping 172.20.1.4 # neighboring node D works
> >>>>> ping 172.20.1.3 # remote node C works only if I disable
> >>>>> offloading     =20
> >>>>
> >>>> BTW, it's enough to disable the offloading of the forwarding for
> >>>> HSR frames to make it work.
> >>>>
> >>>> --- a/drivers/net/dsa/microchip/ksz9477.c
> >>>> +++ b/drivers/net/dsa/microchip/ksz9477.c
> >>>> @@ -1267,7 +1267,7 @@ int ksz9477_tc_cbs_set_cinc(struct
> >>>> ksz_device *dev, int port, u32 val)
> >>>>   * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as
> >>>> HSR frames
> >>>>   * can be forwarded in the switch fabric between HSR ports.
> >>>>   */
> >>>> -#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
> >>>> NETIF_F_HW_HSR_FWD)
> >>>> +#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)
> >>>>
> >>>>  void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
> >>>> net_device *hsr)
> >>>>  {
> >>>> @@ -1279,16 +1279,6 @@ void ksz9477_hsr_join(struct dsa_switch
> >>>> *ds, int port, struct net_device *hsr)
> >>>>         /* Program which port(s) shall support HSR */
> >>>>         ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port),
> >>>> BIT(port));
> >>>>
> >>>> -       /* Forward frames between HSR ports (i.e. bridge together
> >>>> HSR ports) */
> >>>> -       if (dev->hsr_ports) {
> >>>> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
> >>>> -                       hsr_ports |=3D BIT(hsr_dp->index);
> >>>> -
> >>>> -               hsr_ports |=3D BIT(dsa_upstream_port(ds, port));
> >>>> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
> >>>> -                       ksz9477_cfg_port_member(dev,
> >>>> hsr_dp->index, hsr_ports);
> >>>> -       }
> >>>> -
> >>>>         if (!dev->hsr_ports) {
> >>>>                 /* Enable discarding of received HSR frames */
> >>>>                 ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);   =20
> >>>
> >>> This means that KSZ9477 forwarding is dropping frames when HW
> >>> acceleration is used (for non "neighbour" nodes).
> >>>
> >>> On my setup I only had 2 KSZ9477 devel boards.
> >>>
> >>> And as you wrote - the SW based one works, so extending
> >>> https://elixir.bootlin.com/linux/v6.12-rc2/source/tools/testing/selft=
ests/net/hsr
> >>>
> >>> would not help in this case.   =20
> >>
> >> I see. With two boards you can't test the accelerated forwarding.
> >> So how did you test the forwarding at all? Or are you telling me,
> >> that this was added to the driver without prior testing (which
> >> seems a bit bold and unusual)? =20
> >=20
> > The packet forwarding is for generating two frames copies on two HSR
> > coupled ports on a single KSZ9477: =20
>=20
> Isn't that what duplication aka NETIF_F_HW_HSR_DUP is for?

As I mentioned - the NETIF_F_HW_HSR_DUP is to remove duplicated frames.

NETIF_F_HW_HSR_FWD is to in-hw generate frame copy for HSR port to be
sent:
https://elixir.bootlin.com/linux/v6.13/source/drivers/net/dsa/microchip/ksz=
9477.c#L1252

>=20
> >=20
> > https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Applicat=
ionNotes/ApplicationNotes/AN3474-KSZ9477-High-Availability-Seamless-Redunda=
ncy-Application-Note-00003474A.pdf
> >=20
> > The KSZ9477 chip also supports RX packet duplication removal, but
> > cannot guarantee 100% success (so as a fallback it is done in SW).
> >=20
> > The infrastructure from:
> > https://elixir.bootlin.com/linux/v6.13/source/tools/testing/selftests/n=
et/hsr/hsr_redbox.sh#L50
> >=20
> > is enough to test HW accelerated forwarding (of KSZ9477) from NS1
> > and NS2. =20
>=20
> I'm not really sure if I get it. In this setup NS1 and NS2 are
> connected via HSR link (two physical links). On one side packets are
> sent duplicated on both physical ports. On the receiving side the
> duplication is removed and one packet is forwarded to the CPU.
>=20
> Where is forwarding involved here?=20

In-HW forwarding is when KSZ9477 duplicates frame to be send on second
HSR aware port.

(only 2 of them can be coupled to have in-hw support for duplication
and forwarding. Creating more hsr "interfaces" would just use SW).

> Isn't forwarding only for cases
> with one intermediate node between the sending and receiving node?

This kind of "forwarding" is done in software in the hsr driver.

>=20
> >  =20
> >>
> >> Anyway, do you have any suggestions for debugging this?
> >> Unfortunately I know almost nothing about this topic. But I can
> >> offer to test on my setup, at least for now. I don't know how long
> >> I will still have access to the hardware. =20
> >=20
> > For some reason only frames to neighbours are delivered.
> >=20
> > So those are removed at some point (either in KSZ9477 HW or in HSR
> > driver itself).
> >=20
> > Do you have some dumps from tshark/wireshark to share?
> >  =20
> >>
> >> If we can't find a proper solution in the long run, I will probably
> >> send a patch to disable the accelerated forwarding to at least make
> >> HSR work by default. =20
> >=20
> > As I've noted above - the HW accelerated forwarding is in the
> > KSZ9477 chip. =20
>=20
> Yeah, but if the HW accelerated forwarding doesn't work

The "forwarding" in KSZ9477 IC works OK, as frames are duplicated (i.e.
forwarded) to both HSR coupled ports.

The problem is with dropping frames travelling in connected KSZ9477
devices.

> it would be
> better to use no acceleration and have it work in SW at least by
> default, right?

IMHO, it would be best to fix the code.

>=20
> >=20
> > The code which you uncomment, is following what I've understood from
> > the standard (and maybe the bug is somewhere there). =20
>=20
> Ok, thanks for explaining. I will see if I can find some time to
> gather some more information on the problem.

That would be very helpful. Thanks in advance for it.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/yzc38.I7onKQho4G/_1xAeb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmeasRYACgkQAR8vZIA0
zr0VjAgAg3S/GY2arMuccRKR4EUdt6yNhv6HvmKm4ycuLc31gyQiZFvQT6HFXSlV
LQ4tvcKRNWOUOYsu/SdIS0hdK+n4j6YFu5YKrvQcJ0vmYN+f5HL4GBWoFXrR6Ib+
GadlOtqIJjz0jX1LVvxdh/84y2zPoQCcO/vgXGCul6leqlqVv062UIY9mDAjPXLJ
jsdyfTT5jwRQlX5nf7TOtE8UACFIKKpPP4vPedyywsjnM+NA714/FTZofn8qZvL4
0GmBpsnB6q/cn8Hzbcq54LQjRApY1lq8PdvYHi3LGFBB7Ef36yXoIY6eBLcYJLdm
Hgf91rq06sxPMxcNgue1EhAe1DMfbw==
=ND6J
-----END PGP SIGNATURE-----

--Sig_/yzc38.I7onKQho4G/_1xAeb--

