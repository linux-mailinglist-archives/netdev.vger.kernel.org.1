Return-Path: <netdev+bounces-161510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998FAA21E3E
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB5418812C7
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2D912E1CD;
	Wed, 29 Jan 2025 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="cta61Mbu"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6162C9D
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159133; cv=none; b=u2dkZwak7qPCbdRm9UOHY2iyAdU9OIm9bA/R1+lvWAapayHB8VtxX+fJRsgdbtLu3mB3BRvbrO1A1+EJjcTwwuX+zD5y1IbUFbsB/lyEK2nSGegZVtayYL5O9sGosCJG9FsU2/5WV9fWDQMONDAnLPbVmyTG84a4FCtKyRRyQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159133; c=relaxed/simple;
	bh=VMUE5bD4XpFTtlj/cPSJQ9Yx2YKerHHRM/CJ6a4hEBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQ+R6NRskoo6v2nZlsDg8XMS2FYkNua9CZAhUZ0i0KqmCQpeI5ycOP4Zf1dI3PAF6fGzxh/VqYI3EQDg/TMbBFl96AbTezCDYRsJf/oQM92z0QOktZD3K2A18uE+02kHosRYglLjNU2JTnbklJalNpjnZDgJ8acn8mWifQQ46Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=cta61Mbu; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBA5410382D0A;
	Wed, 29 Jan 2025 14:58:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738159128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XwNWjVSirBCeUAz5vB2N+XcCdunryDumbcMHnGJhS7s=;
	b=cta61Mbu2lpP1tUNRL8gutAimMjDYyreg2+mnA2imaiEfIm7JpOz3PZYKqM6+d46KyjID/
	Ct+GN4aKhCWrE08+NeBNgfNxdbSQKV31YpNIrVg8eQ16syTvaj5aKe4PRDJa1IoVbxccQ4
	mvZKiC2NcJlY0nv/75CujcvsV8Cef30Nt+MnvQ2y2Na7JDYyEq7V7ol+BX4jPX6pC069mM
	hUjqNYzTuybkZlRtNp/Pj/7Xmdfgs1zO3ZU450PtbHcOMqkJ95s7jzI5Agpw4PX0WHg6AJ
	1pvayoWYe6ppJzB19jJgzxxUxmjN5C/OA8sex7CP+WOIEarb9Crni0lUiP9AQw==
Date: Wed, 29 Jan 2025 14:58:45 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <20250129145845.3988cf04@wsk>
In-Reply-To: <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
	<6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
	<1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
	<6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
	<20250129121733.1e99f29c@wsk>
	<0383e3d9-b229-4218-a931-73185d393177@kontron.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hOTeB3eIytrPud.v0LBNOXL";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/hOTeB3eIytrPud.v0LBNOXL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Frieder,

> Hi Lukasz,
>=20
> On 29.01.25 12:17 PM, Lukasz Majewski wrote:
> > Hi Frieder,
> >  =20
> >> On 29.01.25 8:24 AM, Frieder Schrempf wrote: =20
> >>> Hi Andrew,
> >>>
> >>> On 28.01.25 6:51 PM, Andrew Lunn wrote:   =20
> >>>> On Tue, Jan 28, 2025 at 05:14:46PM +0100, Frieder Schrempf
> >>>> wrote:   =20
> >>>>> Hi,
> >>>>>
> >>>>> I'm trying out HSR support on KSZ9477 with v6.12. My setup looks
> >>>>> like this:
> >>>>>
> >>>>> +-------------+         +-------------+
> >>>>> |             |         |             |
> >>>>> |   Node A    |         |   Node D    |
> >>>>> |             |         |             |
> >>>>> |             |         |             |
> >>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
> >>>>> +--+-------+--+         +--+------+---+
> >>>>>    |       |               |      |
> >>>>>    |       +---------------+      |
> >>>>>    |                              |
> >>>>>    |       +---------------+      |
> >>>>>    |       |               |      |
> >>>>> +--+-------+--+         +--+------+---+
> >>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
> >>>>> |             |         |             |
> >>>>> |             |         |             |
> >>>>> |   Node B    |         |   Node C    |
> >>>>> |             |         |             |
> >>>>> +-------------+         +-------------+
> >>>>>
> >>>>> On each device the LAN1 and LAN2 are added as HSR slaves. Then I
> >>>>> try to do ping tests between each of the HSR interfaces.
> >>>>>
> >>>>> The result is that I can reach the neighboring nodes just fine,
> >>>>> but I can't reach the remote node that needs packages to be
> >>>>> forwarded through the other nodes. For example I can't ping from
> >>>>> node A to C.
> >>>>>
> >>>>> I've tried to disable HW offloading in the driver and then
> >>>>> everything starts working.
> >>>>>
> >>>>> Is this a problem with HW offloading in the KSZ driver, or am I
> >>>>> missing something essential?   =20
> >=20
> > Thanks for looking and testing such large scale setup.
> >  =20
> >>>>
> >>>> How are IP addresses configured? I assume you have a bridge, LAN1
> >>>> and LAN2 are members of the bridge, and the IP address is on the
> >>>> bridge interface?   =20
> >>>
> >>> I have a HSR interface on each node that covers LAN1 and LAN2 as
> >>> slaves and the IP addresses are on those HSR interfaces. For node
> >>> A:
> >>>
> >>> ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision
> >>> 45 version 1
> >>> ip addr add 172.20.1.1/24 dev hsr
> >>>
> >>> The other nodes have the addresses 172.20.1.2/24, 172.20.1.3/24
> >>> and 172.20.1.4/24 respectively.
> >>>
> >>> Then on node A, I'm doing:
> >>>
> >>> ping 172.20.1.2 # neighboring node B works
> >>> ping 172.20.1.4 # neighboring node D works
> >>> ping 172.20.1.3 # remote node C works only if I disable
> >>> offloading   =20
> >>
> >> BTW, it's enough to disable the offloading of the forwarding for
> >> HSR frames to make it work.
> >>
> >> --- a/drivers/net/dsa/microchip/ksz9477.c
> >> +++ b/drivers/net/dsa/microchip/ksz9477.c
> >> @@ -1267,7 +1267,7 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device
> >> *dev, int port, u32 val)
> >>   * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as
> >> HSR frames
> >>   * can be forwarded in the switch fabric between HSR ports.
> >>   */
> >> -#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
> >> NETIF_F_HW_HSR_FWD)
> >> +#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)
> >>
> >>  void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
> >> net_device *hsr)
> >>  {
> >> @@ -1279,16 +1279,6 @@ void ksz9477_hsr_join(struct dsa_switch *ds,
> >> int port, struct net_device *hsr)
> >>         /* Program which port(s) shall support HSR */
> >>         ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
> >>
> >> -       /* Forward frames between HSR ports (i.e. bridge together
> >> HSR ports) */
> >> -       if (dev->hsr_ports) {
> >> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
> >> -                       hsr_ports |=3D BIT(hsr_dp->index);
> >> -
> >> -               hsr_ports |=3D BIT(dsa_upstream_port(ds, port));
> >> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
> >> -                       ksz9477_cfg_port_member(dev, hsr_dp->index,
> >> hsr_ports);
> >> -       }
> >> -
> >>         if (!dev->hsr_ports) {
> >>                 /* Enable discarding of received HSR frames */
> >>                 ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data); =20
> >=20
> > This means that KSZ9477 forwarding is dropping frames when HW
> > acceleration is used (for non "neighbour" nodes).
> >=20
> > On my setup I only had 2 KSZ9477 devel boards.
> >=20
> > And as you wrote - the SW based one works, so extending
> > https://elixir.bootlin.com/linux/v6.12-rc2/source/tools/testing/selftes=
ts/net/hsr
> >=20
> > would not help in this case. =20
>=20
> I see. With two boards you can't test the accelerated forwarding. So
> how did you test the forwarding at all? Or are you telling me, that
> this was added to the driver without prior testing (which seems a bit
> bold and unusual)?

The packet forwarding is for generating two frames copies on two HSR
coupled ports on a single KSZ9477:

https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ApplicationN=
otes/ApplicationNotes/AN3474-KSZ9477-High-Availability-Seamless-Redundancy-=
Application-Note-00003474A.pdf

The KSZ9477 chip also supports RX packet duplication removal, but
cannot guarantee 100% success (so as a fallback it is done in SW).

The infrastructure from:
https://elixir.bootlin.com/linux/v6.13/source/tools/testing/selftests/net/h=
sr/hsr_redbox.sh#L50

is enough to test HW accelerated forwarding (of KSZ9477) from NS1 and
NS2.

>=20
> Anyway, do you have any suggestions for debugging this? Unfortunately
> I know almost nothing about this topic. But I can offer to test on my
> setup, at least for now. I don't know how long I will still have
> access to the hardware.

For some reason only frames to neighbours are delivered.

So those are removed at some point (either in KSZ9477 HW or in HSR
driver itself).

Do you have some dumps from tshark/wireshark to share?

>=20
> If we can't find a proper solution in the long run, I will probably
> send a patch to disable the accelerated forwarding to at least make
> HSR work by default.

As I've noted above - the HW accelerated forwarding is in the KSZ9477
chip.

The code which you uncomment, is following what I've understood from
the standard (and maybe the bug is somewhere there).

>=20
> Thanks
> Frieder




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/hOTeB3eIytrPud.v0LBNOXL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmeaNBUACgkQAR8vZIA0
zr2f/AgA0/7oD3FF0dRUkcPtRFQFrllb68zq3MQa6IgJqYsErSa68pX7bP45LhVx
Y9rAUHBBBwuaeCyjTS/NqGZACroB+yAFTWp2p0asIayhe/aP3dg/+EMOTaryq6cm
FmgJ+2961yPADNKpm1OOgFQH13HuAaZAnwe/RM9s12Q0S/yMEDH1f4x9RMlhUNqm
IJl1AVSYswE1pWmV38hs8cQoDoGquStjeFm2Rf2mH2cQhuL7Gs1EqkWCmbzpFvUw
i4HnL2ZLX72SF4JkUxZNcw7bDQtLsmwqC5YaEDJk7HgY8WWa55y4AQ656MaDNjEA
EBnNSLzSAF5XdkN5YokNTd/nReMO3Q==
=G5Yd
-----END PGP SIGNATURE-----

--Sig_/hOTeB3eIytrPud.v0LBNOXL--

