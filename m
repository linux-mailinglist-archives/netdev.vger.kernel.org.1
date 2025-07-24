Return-Path: <netdev+bounces-209719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6ABB1091E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CCB4E7445
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EECA270EC5;
	Thu, 24 Jul 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="UuipYI7w"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EDB270EAA;
	Thu, 24 Jul 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356301; cv=none; b=AehgL54hvQbMw/Ev+0tGGgmC2UdAT41NDYzbR62rMt7Hs2eVNrwc1elPdwYiGq+Vviy+fuDgrDMrNT924G7l8y6l4ONeGEasFAiWsoHs7Nas1oPtefFs92kG+Zhwkzu24k2BuK9c1h+D8yZl1Qzzst0ESxqLgZSG5/Jp3owLnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356301; c=relaxed/simple;
	bh=0qomIO0tpsR6Tvc9gHTcOmpa9P1ET+k5IjBhCYdEKhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7GWEum9Q4A93bnmygJWC+dUADC+tJeW3vtMMe8+BZYjBmI2BJt1Af7+aQFqnlZqLxC9f4+131Vnsnrs+B44B5MrVKsRvYlSISbtS1U/RlSFW6Y+gnoFxI4CdgPknhj0xPQ4oYG646RP/5kOKx5kiSCrQ2iy+bsRv0lSQcr4zrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=UuipYI7w; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F041710391E80;
	Thu, 24 Jul 2025 13:24:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753356296; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qR3ZiIHu9HqpVWUj5J80buPqUyaRwiPieVKbB5bOnt0=;
	b=UuipYI7wr6Xec4L5rKC1MoLDym1dM9RdnFnVFkGIpZtK0A1eSKsvXQE4Ew4Gc7a5Go5Zsf
	ag5i4xu5CAvulB97GJGyfF6GSkxgEdK7utdhik3jNlb7EaozAospcIOlxUoLZc3Ew5WfQZ
	Lu9dKuyoz2/PoC5fnJDYnrpvDW90E5FQ+VxgMioK2F35X2/PBgykSUdwH8+sf2YjJ0j/lM
	PnxMu3ZOqMHpxpIuaBP1ycO9kCPWDMdXY9EBL+q0PubH8Xz/Gqj+mCUXI7mOujVFsbiX70
	pzKS7P7fA99YpcBndr+xQ3Kn0JsphGaBXrLkgAdqAj8WVefiFC8bkcrN9OyRxw==
Date: Thu, 24 Jul 2025 13:24:49 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "n.zhandarovich@fintech.ru" <n.zhandarovich@fintech.ru>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "m-karicheri2@ti.com" <m-karicheri2@ti.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>
Subject: Re: [EXT] Re: [RFC PATCH net-next] net: hsr: create an API to get
 hsr port type
Message-ID: <20250724132449.38f0e59a@wsk>
In-Reply-To: <DB9PR04MB92591B3DA0F1CB9CBDE83C24F05EA@DB9PR04MB9259.eurprd04.prod.outlook.com>
References: <20250723104754.29926-1-xiaoliang.yang_1@nxp.com>
	<20250723141451.314b9b77@wsk>
	<DB9PR04MB92591B3DA0F1CB9CBDE83C24F05EA@DB9PR04MB9259.eurprd04.prod.outlook.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.aSIQCRVpkbCdC75m5Hzx4a";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/.aSIQCRVpkbCdC75m5Hzx4a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Xiaoliang,

> Hi Lukasz,
>=20
> >=20
> > Hi Xiaoliang,
> >  =20
> > > If a switch device has HSR hardware ability and HSR configuration
> > > offload to hardware. The device driver needs to get the HSR port
> > > type when joining the port to HSR. Different port types require
> > > different settings for the hardware, like HSR_PT_SLAVE_A,
> > > HSR_PT_SLAVE_B, and HSR_PT_INTERLINK. Create the API
> > > hsr_get_port_type() and export it.=20
> >=20
> > Could you describe the use case in more detail - as pointed out by
> > Vladimir?
> >=20
> > In my use case - when I use the KSZ9477 switch I just provide
> > correct arguments for the iproute2 configuration:
> >=20
> > # Configuration - RedBox (EVB-KSZ9477):
> > if link set lan1 down;ip link set lan2 down ip link add name hsr0
> > type hsr slave1 lan1 slave2 lan2 supervision 45
> > 	 version 1
> > ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink
> > lan3 supervision 45 version 1
> > ip link set lan4 up;ip link set lan5 up
> > ip link set lan3 up
> > ip addr add 192.168.0.11/24 dev hsr1
> > ip link set hsr1 up
> >=20
> > # Configuration - DAN-H (EVB-KSZ9477):
> > ip link set lan1 down;ip link set lan2 down ip link add name hsr0
> > type hsr slave1 lan1 slave2 lan2 supervision 45
> > 	version 1
> > ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision
> > 45 version 1
> > ip link set lan4 up;ip link set lan5 up
> > ip addr add 192.168.0.12/24 dev hsr1
> > ip link set hsr1 up
> >=20
> > More info (also regarding HSR testing with QEMU) can be found from:
> > https://lpc.events/event/18/contributions/1969/attachments/1456/3092/lp=
c-
> > 2024-HSR-v1.0-e26d140f6845e94afea.pdf
> >=20
> >=20
> > As fair as I remember - the Node Table can be read from debugfs.
> >=20
> > However, such approach has been regarded as obsolete - by the
> > community.
> >=20
> > In the future development plans there was the idea to use netlink
> > (or iproute separate program) to get the data now available in
> > debugfs and extend it to also print REDBOX node info (not only
> > DANH).=20
> I need to offload the NETIF_F_HW_HSR_TAG_INS and NETIF_F_HW_HSR_TAG_RM
> to hardware.

I've recently added some "offloading" support for KSZ9477 switch IC.
You can use it as a reference.

> The hardware needs to know which ports are slave ports,
> which is interlink port.

This information you provide to the network driver when you call:

ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45
version 1

Then the lan1 is configured as slave 1 and lan2 as slave 2

For interlink (RedBOX):

ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink=20
lan3 supervision 45 version 1

>=20
> Hardware remove HSR tag on interlink port if it is egress port, keep
> the HSR tag on HSR slave ports. The frames from ring network are
> removed HSR tag and forwarded to interlink port in hardware, not
> received in HSR stack.

Just out of curiosity - which HW IP block has such great capability to
remove in HW HSR tag from RedBox frames?

>=20
> Thanks,
> Xiaoliang




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/.aSIQCRVpkbCdC75m5Hzx4a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmiCGAEACgkQAR8vZIA0
zr2dTQf+Kr+Knz9PyyqN3O6Lmmt/d2AXSZxx7wyvLXmXEHhP/z2sDlCWU/VpQLJC
HJ1u0/V3x7D65t7SJWrAljxcQ7hncO+j1Dv3ouNTXs7iWZTmDTHVfyDqjEWM9UqR
lxN90XcEi+LLC7z9Cw/kAIQb0D0obR/A9b8541ySlnQOmibexyH2LCVxbtFMyaES
hR3oItemNAQaUB1/REVKSd4XUsCo13rnmXdva5+EKEx8i84K8maPo05CdEYcl9E9
Ss4bjlNegnaa2jwf4OyrV1CU7lLC1LB2pFFcfvZyp+nl7FEwa4c/3kzo5ostDdDb
ZG9GvIyfIrMXwXXPrNop3+YP8vFyQw==
=HtnZ
-----END PGP SIGNATURE-----

--Sig_/.aSIQCRVpkbCdC75m5Hzx4a--

