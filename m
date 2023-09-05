Return-Path: <netdev+bounces-32059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B41179222A
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E013C1C2095E
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024DCCA78;
	Tue,  5 Sep 2023 11:33:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF5D2E6
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:33:16 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620511AB;
	Tue,  5 Sep 2023 04:33:15 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9FA2C8691E;
	Tue,  5 Sep 2023 13:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693913594;
	bh=Jhft33aHq+QeIvDce+h2eW315je88Z4I8KsPxTS6vI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LkvHbUtY9mkco62SeW7hiFN8hfjzAY3SaANBXGHAVG/Pp2ZYynEccgDtWhZIko+gC
	 WsnES8z8ZSjTLfPoRdLTWjW0ojkcg7mly5MEojSnEyeYmGMjU7CFpgJtePFaAKtIHn
	 Ed/B9mGqblRu87szpNYB8PCpliuDc7D7FVJbMlhaWbYIQOttqSjo7o8RO09q8XI7An
	 0h/ftN/ufZ8Da/8iN4UgojA9klzy+GDud74uobrK/iSX4czE8nT1ZhVXS8ncJO4AEc
	 e2VQ7229Q/b9/anpMy3R+UUihL+huwNNPaa1T88fL2Wbox8bmWgUb4sACr1zcdz18+
	 a6imN1lfqXXAA==
Date: Tue, 5 Sep 2023 13:33:12 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
 <woojung.huh@microchip.com>, Tristram.Ha@microchip.com, Florian Fainelli
 <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 UNGLinuxDriver@microchip.com, George McCollister
 <george.mccollister@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 2/4] net: dsa: Extend ksz9477 TAG setup to
 support HSR frames duplication
Message-ID: <20230905133312.6a29b654@wsk>
In-Reply-To: <20230905110056.gzkaiznlq5hcvrac@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
	<20230904120209.741207-3-lukma@denx.de>
	<20230905102239.mkufbzxwrvuatlrb@skbuf>
	<20230905124409.40c7c2f1@wsk>
	<20230905110056.gzkaiznlq5hcvrac@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vnyPXzTwN/xG0HLRGJ7QKD1";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/vnyPXzTwN/xG0HLRGJ7QKD1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Tue, Sep 05, 2023 at 12:44:09PM +0200, Lukasz Majewski wrote:
> > > Not to mention that there are other problems with the
> > > "dev->hsr_ports" concept. For example, having a hsr0 over lan0
> > > and lan1, and a hsr1 over lan2 and lan3, would set dev->hsr_ports
> > > to GENMASK(3, 0). =20
> >=20
> > I doubt that having two hsr{01} interfaces is possible with current
> > kernel. =20
>=20
> You mean 2 hsr{01} interfaces not being able to coexist in general,
> or just "offloaded" ones?

The KSZ9477 IC only allows to have two its ports from 5 available to be
configured as HSR ones (so the HW offloading would work).

And having single hsr0 with lan[12] is the used case on which I'm
focused (with offloading or pure SW).

>=20
> > The KSZ9477 allows only to have 2 ports of 5 available as HSR
> > ones.
> >=20
> > The same is with earlier chip xrs700x (but this have even bigger
> > constrain - there only ports 1 and 2 can support HSR).  =20
>=20
> > > > +	if (dev->features & NETIF_F_HW_HSR_DUP) {
> > > > +		val &=3D ~KSZ9477_TAIL_TAG_LOOKUP;   =20
> > >=20
> > > No need to unset a bit which was never set. =20
> >=20
> > I've explicitly followed the vendor's guidelines - the TAG_LOOKUP
> > needs to be cleared.
> >=20
> > But if we can assure that it is not set here I can remove it. =20
>=20
> Let's look at ksz9477_xmit(), filtering only for changes to "u16 val".
>=20
> static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
> 				    struct net_device *dev)
> {
> 	u16 val;
>=20
> 	val =3D BIT(dp->index);
>=20
> 	val |=3D FIELD_PREP(KSZ9477_TAIL_TAG_PRIO, prio);
>=20
> 	if (is_link_local_ether_addr(hdr->h_dest))
> 		val |=3D KSZ9477_TAIL_TAG_OVERRIDE;
>=20
> 	if (dev->features & NETIF_F_HW_HSR_DUP) {
> 		val &=3D ~KSZ9477_TAIL_TAG_LOOKUP;
> 		val |=3D ksz_hsr_get_ports(dp->ds);
> 	}
> }
>=20
> Is KSZ9477_TAIL_TAG_LOOKUP ever set in "val", or am I missing
> something?

No, it looks like you are not. The clearance of KSZ9477_TAIL_TAG_LOOKUP
seems to be an overkill.

>=20
> > > > +		val |=3D ksz_hsr_get_ports(dp->ds);
> > > > +	}   =20
> > >=20
> > > Would this work instead?
> > >=20
> > > 	struct net_device *hsr_dev =3D dp->hsr_dev;
> > > 	struct dsa_port *other_dp;
> > >=20
> > > 	dsa_hsr_foreach_port(other_dp, dp->ds, hsr_dev)
> > > 		val |=3D BIT(other_dp->index);
> > >  =20
> >=20
> > I thought about this solution as well, but I've been afraid, that
> > going through the loop of all 5 ports each time we want to send
> > single packet will reduce the performance.
> >=20
> > Hence, the idea with having the "hsr_ports" set once during join
> > function and then use this cached value afterwards. =20
>=20
> There was a quote about "premature optimization" which I can't quite
> remember...

Yes, using caching by default instead of list iterating is the
"premature optimization" .... :-)

>=20
> If you can see a measurable performance difference, then the list
> traversal can be converted to something more efficient.
>=20
> In this case, struct dsa_port :: hsr_dev can be converted to a larger
> struct dsa_hsr structure, similar to struct dsa_port :: bridge.
> That structure could look like this:
>=20
> struct dsa_hsr {
> 	struct net_device *dev;
> 	unsigned long port_mask;
> 	refcount_t refcount;
> };
>=20
> and you could replace the list traversal with "val |=3D
> dp->hsr->port_mask". But a more complex solution requires a
> justification, which in this case is performance-related. So
> performance data must be gathered.
>=20
> FWIW, dsa_master_find_slave() also performs a list traversal.
> But similar discussions about performance improvements didn't lead
> anywhere.

The iteration over hsr ports would simplify the code. I will use it and
provide feedback if I find performance drop.

Thanks for the feedback.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/vnyPXzTwN/xG0HLRGJ7QKD1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT3EfgACgkQAR8vZIA0
zr1l6Af/aw0BIMa9KzevizTipWG+oP1sxvbZQUQWu9Znf30Yd532IzA1Jb/r7iga
kG5DVu7T9x1LAeTPO66kNXP98c3HgI2CyTQSFB/QuioUPynQH6tbKs5uEyxwpJ0F
gCh46mXUuZZCK6hE4YADpgsQI3YT0kZaXf16Gj2XirytuZm2ZPskUV5bqLdPIQ4F
r4mfy6k/EWKFKsrDxUpFfTtsJJXLxtNJA0PXaCBtQ31n8t+OE8pix9qvgK/g3jcc
SgQeRAcszykcPYXWPtPWpIKsP5Ml1aMGYs0PAujuDHMF5IK2Ior0+Oq5UDyOj8ZT
s0DMkNa92BV+Gu+8Mch+HokXLfOtcw==
=T8Df
-----END PGP SIGNATURE-----

--Sig_/vnyPXzTwN/xG0HLRGJ7QKD1--

