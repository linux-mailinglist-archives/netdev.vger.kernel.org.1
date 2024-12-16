Return-Path: <netdev+bounces-152406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A88A9F3CF8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 22:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE4216B8A7
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0F1D61A7;
	Mon, 16 Dec 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQKdIwfW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BC1D5CFD
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385498; cv=none; b=h0ONpjbzCz2UcbHqYi5DF/CvhW+k2zGIJs+j1kOr8ShYEVALF8A8/4P04yG0gTJlv9eNCsZ2SWc+xSq9tJrUawZSAzew+6SSmOYheyq/wxitkServwBFazD0LeZeTF40CrRHAZrqKkN+ejP85++sDXkOzINC1WhIuKs6KYAxBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385498; c=relaxed/simple;
	bh=nP/i3H9N13bGLmo/L+MKF938O7RUON3jWLJWCZnrwA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nml942fAdeJyhNnoonHlePmHyvmXiuxMd8319Oy/Btr2mCcAHOxyoufYp0IAZerRELrb9ASc9m2ljfJgf/F2e4fQFQfErUlX2hWtnpXng74rrPcq8D1lc+AX/BHTasxzVsDMhniCoTvka9jfJKadF2JmL9T+wHLrHg29QEH5pg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQKdIwfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19B5C4CED0;
	Mon, 16 Dec 2024 21:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734385497;
	bh=nP/i3H9N13bGLmo/L+MKF938O7RUON3jWLJWCZnrwA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQKdIwfWOrEK39/GzpcXPOIB+Dt5w2iWPsD2+U1hfisxOCzXNaUKP2nHHmf0RG77f
	 Ze3UnKUHIqZnQGyDfkvlekeXMzKpZjWiwtEgrqJFMDXBHJFKCfWXhZuU0aApWU8MMZ
	 +mi2HPX5ztv1s92CJAb4vXkpaWaAqpGietXZpcYyHQzSJRugFTknBIXJdebsUyZV51
	 l/7QKRMOOWKtZV/XYzH8txZITOpoH9aHE97+pqneKwqxULEP5Rdu+9mwXwB0URZjiN
	 5fvDjWhku5wQCq2svglWVhtyXf/RSGRv3Fp6VLhkGVE6zzQ+5bMVnOu9ZBcHOeKV0u
	 oWpNmuADNaQoA==
Date: Mon, 16 Dec 2024 22:44:54 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z2CfVnhNGYMRv4cN@lore-desk>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <Z2B-S7nQO3HK8BGl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G46z46ek6CcqYjSd"
Content-Disposition: inline
In-Reply-To: <Z2B-S7nQO3HK8BGl@pengutronix.de>


--G46z46ek6CcqYjSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Dec 16, 2024 at 08:01:33PM +0100, Lorenzo Bianconi wrote:
> > > On Mon, Dec 16, 2024 at 01:09:01PM +0100, Lorenzo Bianconi wrote:
> > > > I guess what I did not make clear here is that we are discussing ab=
out
> > > > 'routed' traffic (sorry for that). The traffic is received from the=
 WAN
> > > > interface and routed to a DSA port (or the other way around).
> > > > In this scenario the 3-way handshake will be received by the CPU vi=
a the
> > > > WAN port (or the conduit port) while the subsequent packets will be=
 hw
> > > > forwarded from WAN to LAN (or LAN to WAN). For EN7581 [0], the traf=
fic
> > > > will be received by the system from GDM2 (WAN) and the PSE/PPE bloc=
ks
> > > > will forward it to the GDM1 port that is connected to the DSA cpu p=
ort.
> > > >=20
> > > > The proposed series is about adding the control path to apply a giv=
en Qdisc
> > > > (ETS or TBF for EN7581) to the traffic that is following the descri=
bed path
> > > > without creating it directly on the DSA switch port (for the reason=
s described
> > > > before). E.g. the user would want to apply an ETS Qdisc just for tr=
affic
> > > > egressing via lan0.
> > > >=20
> > > > This series is not strictly related to the airoha_eth flowtable off=
load
> > > > implementation but the latter is required to have a full pictures o=
f the
> > > > possible use case (this is why I was saying it is better to post it=
 first).
> > >=20
> > > It's good to know this does not depend on flowtable.
> > >=20
> > > When you add an offloaded Qdisc to the egress of a net device, you do=
n't
> > > affect just the traffic L3 routed to that device, but all traffic (al=
so
> > > includes the packets sent to it using L2 forwarding). As such, I simp=
ly
> > > don't believe that the way in which the UAPI is interpreted here (root
> > > egress qdisc matches only routed traffic) is proper.
> > >=20
> > > Ack?
> >=20
> > Considering patch [0], we are still offloading the Qdisc on the provided
> > DSA switch port (e.g. LANx) via the port_setup_tc() callback available =
in
> > dsa_user_setup_qdisc(), but we are introducing even the ndo_setup_tc_co=
nduit()
> > callback in order to use the hw Qdisc capabilities available on the mac=
 chip
> > (e.g. EN7581) for the routed traffic from WAN to LANx. We will still ap=
ply
> > the Qdisc defined on LANx for L2 traffic from LANy to LANx. Agree?
> >=20
> > >=20
> > > > > I'm trying to look at the big picture and abstract away the flowt=
able a
> > > > > bit. I don't think the tc rule should be on the user port. Can the
> > > > > redirection of packets destined towards a particular switch port =
be
> > > > > accomplished with a tc u32 filter on the conduit interface instea=
d?
> > > > > If the tc primitives for either the filter or the action don't ex=
ist,
> > > > > maybe those could be added instead? Like DSA keys in "flower" whi=
ch gain
> > > > > introspection into the encapsulated packet headers?
> > > >=20
> > > > The issue with the current DSA infrastructure is there is no way to=
 use
> > > > the conduit port to offload a Qdisc policy to a given lan port sinc=
e we
> > > > are missing in the APIs the information about what user port we are
> > > > interested in (this is why I added the new netdev callback).
> > >=20
> > > How does the introduction of ndo_setup_tc_conduit() help, since the p=
roblem
> > > is elsewhere? You are not making "tc qdisc add lanN root ets" work co=
rrectly.
> > > It is simply not comparable to the way in which it is offloaded by
> > > drivers/net/dsa/microchip/ksz_common.c, even though the user space
> > > syntax is the same. Unless you're suggesting that for ksz it is not
> > > offloaded correctly?
> >=20
> > nope, I am not saying the current Qdisc DSA infrastructure is wrong, it=
 just
> > does not allow to exploit all hw capabilities available on EN7581 when =
the
> > traffic is routed from the WAN port to a given DSA switch port. If we d=
o:
> >=20
> > $tc qdisc add dev lan0 root handle 1: ets strict 8 priomap ...
> >=20
> > in the current upstream implementation we do:
> >   dsa_user_setup_tc():
> >      ...
> >        -> ds->ops->port_setup_tc(ds, dp->index, type, type_data)
> >           (it applies the Qdisc on lan0 configuring the hw switch)
> >=20
> > adding the ndo_setup_tc_conduit() callback we have:
> >=20
> >   dsa_user_setup_qdisc()
> >     ...
> >       -> conduit->netdev_ops->ndo_setup_tc_conduit(conduit, dp->index, =
type, type_data)
> >          (it applies the Qdisc on EN7581 mac chip for the routed traffi=
c destinated to lan0)
> >=20
> >       -> ds->ops->port_setup_tc(ds, dp->index, type, type_data)
> >          (it applies the Qdisc on lan0 configuring the hw switch)
> >=20
> > >=20
> > > Oleksij, am I missing something?
> > >=20
> > > > Please consider here we are discussing about Qdisc policies and not=
 flower
> > > > rules to mangle the traffic.
> > >=20
> > > What's a Qdisc policy?
> >=20
> > I mean a queue scheduler algorithm (e.g. TBF, ETS, HTB, ...)
> >=20
> > >=20
> > > Also, flower is a classifier, not an action. It doesn't mangle packets
> > > by the very definition of what a classifier is.
> >=20
> > yes, but goal of the series is the Queue scheduler offloading, not
> > classifier/action. Agree?
> >=20
> > >=20
> > > > The hw needs to be configured in advance to apply the requested pol=
icy
> > > > (e.g TBF for traffic shaping).
> > >=20
> > > What are you missing exactly to make DSA packets go to a particular
> > > channel on the conduit?
> > >=20
> > > For Qdisc offloading you want to configure the NIC in advance, of cou=
rse.
> > >=20
> > > Can't you do something like this to guide packets to the correct chan=
nels?
> > >=20
> > > tc qdisc add dev eth0 clsact
> > > tc qdisc add dev eth0 root handle 1: ets strict 8 priomap ...
> > > tc filter add dev eth0 egress ${u32 or flower filter to match on DSA =
tagged packets} \
> > > 	flowid 1:1
> >=20
> > If we apply the Qdisc directly on the conduit port (eth0) we can just a=
pply the
> > queue scheduler on all the traffic egressing via the DSA switch while I=
 would
> > like to apply it on per DSA port basis (but using the mac chip hw capab=
ilities),
> > got my point?
>=20
> Hm, I guess I have similar use case in one of my projects. In my case, th=
e CPU
> interface is 1Gbit the switch ports are 100Mbit each. It is still
> possible to keep the CPU interface busy by sending 1Gbit UDP stream, so
> 900Mbit is dropped by the switch. I would like to have traffic limiter
> per virtual DSA port on the SoC site to reduce the load on DSA conduit.
> Currently it was not possible.

Does the mac chip in your setup support TX shaping (e.g. via HTB or TBF)?
If so, I guess you could do it via the ndo_setup_tc_conduit() callback.

Regards,
Lorenzo

>=20
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--G46z46ek6CcqYjSd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ2CfVgAKCRA6cBh0uS2t
rNwwAQCeMWEiLiC+pddOg1tg3YKpxzc6RPOfdJdGxpyyORyrLgEA9UndP7qxWUCJ
TfgEmTJrBAOx8LJtOzAVgySVBhg2DAQ=
=hC2G
-----END PGP SIGNATURE-----

--G46z46ek6CcqYjSd--

