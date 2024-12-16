Return-Path: <netdev+bounces-152410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35749F3D77
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 23:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03950169162
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 22:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF61D89F0;
	Mon, 16 Dec 2024 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf5Zuh7C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848801D89EF
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734388101; cv=none; b=ilqSgz0ZFr4LPQJWs8PWpbeZa9EQmXtS2QQxU0UCzlXhjRd7rDcxpKIfTwIedPKjf0v+amJeeMEDkXJXMEuY2u/BkPkGJs0VffKAWQJdKwvTdP0JFE2xh3H9Ps1LwdC76frM+gCo1Lp+D62DggUA/Sn+SCJLekhW8Ct8GnG+S50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734388101; c=relaxed/simple;
	bh=UiN9+z/4H7nASajFbWTnAtoNnt/mEsWJ9abwG3/H4JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrTJjCfjwMNaHxROp6o6BdS3NUqLWnkzob76HGDlDQwSNClweKrPMdy2Y0hTIBio5t3TxzUy1pF6Ec0gZ0sPj5yKuz1VbXd7ZxHtKK/kVWv9HV17Jz7H5qEYD8Jk5O6vf/NdRAVwD45xQOg9/5XSJYBJy3FBnry3k5AxYAk3lec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf5Zuh7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9575DC4CED3;
	Mon, 16 Dec 2024 22:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734388100;
	bh=UiN9+z/4H7nASajFbWTnAtoNnt/mEsWJ9abwG3/H4JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nf5Zuh7CfxleXEdtT5GoC2qnmZ0BzSCvB48q9SEkr/gHKQ+MDzgDpheGy63WbNzJH
	 ppMJqrgj14wA38AiZ/pWPoifagDvmdL2UUWYokQWcrosRVj1fCJfRlPgxeAtDSI5Al
	 zX3E2kqQArkbeHqBEXgAFTJN0uwUyd21CkC0Z/fvl5q7kxKEn9t8EE+KRzeC/d0hgb
	 wjvo0I6y0W/wylVW6PoZvXrVSmNLaa8OirDU9pywN4NDRcl1cYfjRFbPghrJIp6Cyo
	 uTAC53DOEjKgQBwqiNrbTrjrhA9uqoaKbhrAPzDZNbirdlt42HUD7w22AJ2/Mc4iqZ
	 /7FP/SNXwZrlw==
Date: Mon, 16 Dec 2024 23:28:18 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z2CpgqpIR5_MXTO7@lore-desk>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <20241216194641.b7altsgtjjuloslx@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CJbmCgRntwAP0sFC"
Content-Disposition: inline
In-Reply-To: <20241216194641.b7altsgtjjuloslx@skbuf>


--CJbmCgRntwAP0sFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Dec 16, 2024 at 08:01:33PM +0100, Lorenzo Bianconi wrote:
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
>=20
> Not quite, no.
>=20
> ndo_setup_tc_conduit() does not have the same instruments to offload
> what port_setup_tc() can offload. It is not involved in all data paths
> that port_setup_tc() has to handle. Please ack this. So if port_setup_tc()

Can you please elaborate on this? Both (->ndo_setup_tc_conduit() and
->port_setup_tc()) refer to the same DSA user port (please take a look the
callback signature).

> returns -EOPNOTSUPP, the entire dsa_user_setup_qdisc() should return
> -EOPNOTSUPP, UNLESS you install packet traps on all other offloaded data
> paths in the switch, such that all packets that egress the DSA user port
> are handled by ndo_setup_tc_conduit()'s instruments.

Uhm, do you mean we are changing the user expected result in this way?
It seems to me the only case we are actually changing is if port_setup_tc()
callback is not supported by the DSA switch driver while ndo_setup_tc_condu=
it()
one is supported by the mac chip. In this case the previous implementation
returns -EOPNOTSUPP while the proposed one does not report any error.
Do we really care about this case? If so, I guess we can rework
dsa_user_setup_qdisc().

>=20
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
> > traffic is routed from the WAN port to a given DSA switch port.
>=20
> And I don't believe it should, in this way.

Can you please elaborate on this? IIUC it seems even Oleksij has a use-case
for this.

>=20
> > If we do:
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
> > > Also, flower is a classifier, not an action. It doesn't mangle packets
> > > by the very definition of what a classifier is.
> >=20
> > yes, but goal of the series is the Queue scheduler offloading, not
> > classifier/action. Agree?
>=20
> Classifiers + flowid are an instrument to direct packets to classes of a
> classful egress Qdisc. They seem perfectly relevant to the discussion,
> given the information I currently have.

yep, sure. We will need a tc classifier to set the flow-id (I used flower d=
uring
development). What I mean is the series is taking care just of Qdisc offloa=
ding.

>=20
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
> We need something as the root Qdisc of the conduit which exposes its
> hardware capabilities. I just assumed that would be a simple (and single)
> ETS, you can correct me if I am wrong.
>=20
> On conduit egress, what is the arbitration scheme between the traffic
> destined towards each DSA user port (channel, as the driver calls them)?
> How can this be best represented?

The EN7581 supports up to 32 different 'channels' (each of them support 8
different hw queues). You can define an ETS and/or TBF Qdisc for each chann=
el.
My idea is to associate a channel to each DSA switch port, so the user can
define independent QoS policies for each DSA ports (e.g. shape at 100Mbps l=
an0,
apply ETS on lan1, ...) configuring the mac chip instead of the hw switch.
The kernel (if the traffic is not offloaded) or the PPE block (if the traff=
ic
is offloaded) updates the channel and queue information in the DMA descript=
or
(please take a look to [0] for the first case).

>=20
> IIUC, in your patch set, you expose the conduit hardware QoS capabilities
> as if they can be perfectly virtualized among DSA user ports, and as if
> each DSA user port can have its own ETS root Qdisc, completely independent
> of each other, as if the packets do not serialize on the conduit <-> CPU
> port link, and as if that is not a bottleneck. Is that really the case?

correct

> If so (but please explain how), maybe you really need your own root Qdisc
> driver, with one class per DSA user port, and those classes have ETS
> attached to them.

Can you please clarify what do you mean with 'root Qdisc driver'?

Regards,
Lorenzo

[0] https://patchwork.kernel.org/project/netdevbpf/patch/a7d8ec3d70d7a0e220=
8909189e46a63e769f8f9d.1733930558.git.lorenzo@kernel.org/

--CJbmCgRntwAP0sFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ2CpggAKCRA6cBh0uS2t
rBbmAP0SGeXSlGqydCGPjaqgLcNPBHC+FyAu0qh6B2nnkWwwIQD+NHcnATDDWaHW
DVu2BFeG81/GtE5ilCdDfpyj/YscCgM=
=09KQ
-----END PGP SIGNATURE-----

--CJbmCgRntwAP0sFC--

