Return-Path: <netdev+bounces-161472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC1A21C01
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60ED33A18D3
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D3619309E;
	Wed, 29 Jan 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CPx1WP7/"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13490193402
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149467; cv=none; b=FLBqv3Gy7VNb/2Wkk03t9fLVFqblKfCtNB80H7+ea4TMNPOyL1KlO9+dvhEHifIswJ6r+GxbUDBirpWK4pmzPpjtVMW84Yg+Z8IBy+fgdNfOvfLrE/8qHpi04ZVcLuHDvip/AoQV5T+FOL4lM5bZPqG1H0V9KVDzETeyOQxD5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149467; c=relaxed/simple;
	bh=Rs7t400t3K/snNydKY6QXRT1o35UqLBcFjmk1GHOtNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sf9Ibmp2BN5RmqfOBi4yxL9L7r2oZiX2tPjT8IP93+AG51GvWz1vKG7VnGPBDXtlgXQCiXoMw6/eQEzF9UBwiKf9y7o6U7U+MZKgxokmr39KoV20aASbYu4BZ19ql2bqOr2Y0ATm5lqrEdv1Ucx0242NWRjkAgIoMp/UUw7qf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CPx1WP7/; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F3A210382D08;
	Wed, 29 Jan 2025 12:17:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738149456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ziy1ypHtia2yId+y4hV3A3o3cfZYjun/vD8J2OHDDn0=;
	b=CPx1WP7/KcgnngugWTuJv2QHq+tdvc/EQTgwpjFyzoQB35389OuzhA17h6ZTsV7v9cEEye
	5fyeCT3GYuWuh67VNww29Zn+5i3+dRmgDLf2RWT0SJE74IWNk485yhUcaaAJu1GAlfZ2zF
	/KBM3jlgcrtcgFU0AsyJ93VcgNUWxB65l06FvFscemG9+rUcd4YAzKxdniH6R+CDQew5uP
	gFpsKBMDghQhkKgym9bdiznrZbGUkd01V0Nvey7vwW6yrpdrzT2a5ArVqzuOsozzwezvhU
	BRBf9oTfb0ydIAebe5H5Kwv/zbJD7GmGtPY30ZLKM9rkfhYJokG4W4yrZ24BnA==
Date: Wed, 29 Jan 2025 12:17:33 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <20250129121733.1e99f29c@wsk>
In-Reply-To: <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
	<6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
	<1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
	<6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/So5pYf1mL79BM27in9zoJC2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/So5pYf1mL79BM27in9zoJC2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Frieder,

> On 29.01.25 8:24 AM, Frieder Schrempf wrote:
> > Hi Andrew,
> >=20
> > On 28.01.25 6:51 PM, Andrew Lunn wrote: =20
> >> On Tue, Jan 28, 2025 at 05:14:46PM +0100, Frieder Schrempf wrote: =20
> >>> Hi,
> >>>
> >>> I'm trying out HSR support on KSZ9477 with v6.12. My setup looks
> >>> like this:
> >>>
> >>> +-------------+         +-------------+
> >>> |             |         |             |
> >>> |   Node A    |         |   Node D    |
> >>> |             |         |             |
> >>> |             |         |             |
> >>> | LAN1   LAN2 |         | LAN1   LAN2 |
> >>> +--+-------+--+         +--+------+---+
> >>>    |       |               |      |
> >>>    |       +---------------+      |
> >>>    |                              |
> >>>    |       +---------------+      |
> >>>    |       |               |      |
> >>> +--+-------+--+         +--+------+---+
> >>> | LAN1   LAN2 |         | LAN1   LAN2 |
> >>> |             |         |             |
> >>> |             |         |             |
> >>> |   Node B    |         |   Node C    |
> >>> |             |         |             |
> >>> +-------------+         +-------------+
> >>>
> >>> On each device the LAN1 and LAN2 are added as HSR slaves. Then I
> >>> try to do ping tests between each of the HSR interfaces.
> >>>
> >>> The result is that I can reach the neighboring nodes just fine,
> >>> but I can't reach the remote node that needs packages to be
> >>> forwarded through the other nodes. For example I can't ping from
> >>> node A to C.
> >>>
> >>> I've tried to disable HW offloading in the driver and then
> >>> everything starts working.
> >>>
> >>> Is this a problem with HW offloading in the KSZ driver, or am I
> >>> missing something essential? =20

Thanks for looking and testing such large scale setup.

> >>
> >> How are IP addresses configured? I assume you have a bridge, LAN1
> >> and LAN2 are members of the bridge, and the IP address is on the
> >> bridge interface? =20
> >=20
> > I have a HSR interface on each node that covers LAN1 and LAN2 as
> > slaves and the IP addresses are on those HSR interfaces. For node A:
> >=20
> > ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45
> > version 1
> > ip addr add 172.20.1.1/24 dev hsr
> >=20
> > The other nodes have the addresses 172.20.1.2/24, 172.20.1.3/24 and
> > 172.20.1.4/24 respectively.
> >=20
> > Then on node A, I'm doing:
> >=20
> > ping 172.20.1.2 # neighboring node B works
> > ping 172.20.1.4 # neighboring node D works
> > ping 172.20.1.3 # remote node C works only if I disable offloading =20
>=20
> BTW, it's enough to disable the offloading of the forwarding for HSR
> frames to make it work.
>=20
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -1267,7 +1267,7 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device
> *dev, int port, u32 val)
>   * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as HSR
> frames
>   * can be forwarded in the switch fabric between HSR ports.
>   */
> -#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
> NETIF_F_HW_HSR_FWD)
> +#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)
>=20
>  void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
> net_device *hsr)
>  {
> @@ -1279,16 +1279,6 @@ void ksz9477_hsr_join(struct dsa_switch *ds,
> int port, struct net_device *hsr)
>         /* Program which port(s) shall support HSR */
>         ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
>=20
> -       /* Forward frames between HSR ports (i.e. bridge together HSR
> ports) */
> -       if (dev->hsr_ports) {
> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
> -                       hsr_ports |=3D BIT(hsr_dp->index);
> -
> -               hsr_ports |=3D BIT(dsa_upstream_port(ds, port));
> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
> -                       ksz9477_cfg_port_member(dev, hsr_dp->index,
> hsr_ports);
> -       }
> -
>         if (!dev->hsr_ports) {
>                 /* Enable discarding of received HSR frames */
>                 ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);

This means that KSZ9477 forwarding is dropping frames when HW
acceleration is used (for non "neighbour" nodes).

On my setup I only had 2 KSZ9477 devel boards.

And as you wrote - the SW based one works, so extending
https://elixir.bootlin.com/linux/v6.12-rc2/source/tools/testing/selftests/n=
et/hsr

would not help in this case.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/So5pYf1mL79BM27in9zoJC2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmeaDk0ACgkQAR8vZIA0
zr27QQgApqeB3/bqsRziOTBoYql4YZr7YyTFSJhY1Xpntd+XWkyo0xKsr3vaYcX/
UE1Ta1QKAG531cKpvl/yAHbfOcYUO/3MWrxuJwL05j/I3/3/kcuPyzQHjYkguvZW
MH37F4WsYYBAezdZF76n/IPJlMnc3oG5C/KZLf8diCqwtoRm58Tw/NDVmVN4P+mC
5ho0tZ4ISiWIX0tsQYBeYmxLOnTb1UZHz/s1jrD/inU4z+iyMDRjKofxQjRupKEr
cn7atukJSnTHDDb1U7CQw5Mcto/p8ONQ2aUdH1tlzP4dS7Csf1zFPGQsXbQKQvyD
HVbs8p9aFGhSHl5Doaq372S+EDH1iQ==
=SSMd
-----END PGP SIGNATURE-----

--Sig_/So5pYf1mL79BM27in9zoJC2--

