Return-Path: <netdev+bounces-35772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD05A7AB0A3
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 13:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 1EB901F22AD4
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DCD1F190;
	Fri, 22 Sep 2023 11:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C831F197
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:29:15 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFBE18F;
	Fri, 22 Sep 2023 04:29:12 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D1356833DE;
	Fri, 22 Sep 2023 13:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695382151;
	bh=MK5/SbyuTC3L8ig6HYjeZ0VwjMB8mk5/yG61uFAtrPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZWX2eEZOgIHA5sDF5YvC//jcPOBo0iCniWMupOFMZukivxK8ua3+41FXZronARit
	 N1i2ykY0Wb6Tr8dzO0lZ8EEL/JqUGlucXL0dAp1US4SSPvzPy0/zzZrgDO3rouaWdB
	 ppDeUodcuJY0ZxTpasBAh2Bh6qnCJuWHaNDKCZ1Qa4RD6GbGPcEkTDXyCj7CI5FSAX
	 UTLVXePJhRpKVORmie0QqblFsCFwHh7w5ch5ZQAGRxdaB0DXrEczE2AjRbumIVTUVb
	 aZyMEH+h/ldMxtJHvtge3ahabYA9Fn7fguuTZTutMkrcbM9C+v8fHA323n303YOLW4
	 E3KIS0Jljipgw==
Date: Fri, 22 Sep 2023 13:29:04 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>, Andrew
 Lunn <andrew@lunn.ch>, davem@davemloft.net, Woojung Huh
 <woojung.huh@microchip.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Oltean
 <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v5 net-next 5/5] net: dsa: microchip: Enable HSR
 offloading for KSZ9477
Message-ID: <20230922132904.750688b6@wsk>
In-Reply-To: <20230921193224.l3ojpdcsb4bpfl7d@skbuf>
References: <20230920114343.1979843-1-lukma@denx.de>
	<20230920114343.1979843-1-lukma@denx.de>
	<20230920114343.1979843-6-lukma@denx.de>
	<20230920114343.1979843-6-lukma@denx.de>
	<20230921193224.l3ojpdcsb4bpfl7d@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZkQKSAsAEu=jIHC9=1/H+QD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/ZkQKSAsAEu=jIHC9=1/H+QD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Wed, Sep 20, 2023 at 01:43:43PM +0200, Lukasz Majewski wrote:
> > +void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
> > net_device *hsr) +{
> > +	struct ksz_device *dev =3D ds->priv;
> > +	struct net_device *slave;
> > +	u8 data;
> > +
> > +	/* Program which port(s) shall support HSR */
> > +	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
> > +
> > +	/* Forward frames between HSR ports (i.e. bridge together
> > HSR ports) */
> > +	ksz9477_cfg_port_member(dev, port,
> > +				BIT(dsa_upstream_port(ds, port)) |
> > BIT(port)); =20
>=20
> Isn't this supposed to be
>=20
> 	ksz9477_cfg_port_member(dev, port,
> 				BIT(dsa_upstream_port(ds, port)) |
> BIT(pair));
>=20
> where "pair" is not even passed as an argument to ksz9477_hsr_join(),
> but represents the *other* port in the HSR ring, not this one?

Unfortunately, yes...

The code as it is now -> would set for port lan1 0x21 and lan2 0x22.

However the setup shall be 0x23 for both ports.

More info here:
https://github.com/Microchip-Ethernet/EVB-KSZ9477/issues/98#issuecomment-17=
01557449

I will setup this register from dev->hsr_ports when both HSR ports are
known.


>=20
> > +
> > +	if (!dev->hsr_ports) {
> > +		/* Enable discarding of received HSR frames */
> > +		ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
> > +		data |=3D HSR_DUPLICATE_DISCARD;
> > +		data &=3D ~HSR_NODE_UNICAST;
> > +		ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
> > +	}
> > +
> > +	/* Enable per port self-address filtering.
> > +	 * The global self-address filtering has already been
> > enabled in the
> > +	 * ksz9477_reset_switch() function.
> > +	 */
> > +	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL,
> > PORT_SRC_ADDR_FILTER, true); +
> > +	/* Setup HW supported features for lan HSR ports */
> > +	slave =3D dsa_to_port(ds, port)->slave;
> > +	slave->features |=3D KSZ9477_SUPPORTED_HSR_FEATURES;
> > +}
> > diff --git a/drivers/net/dsa/microchip/ksz_common.h
> > b/drivers/net/dsa/microchip/ksz_common.h index
> > 1f3fb6c23f36..1f447a34f555 100644 ---
> > a/drivers/net/dsa/microchip/ksz_common.h +++
> > b/drivers/net/dsa/microchip/ksz_common.h @@ -101,6 +101,11 @@
> > struct ksz_ptp_irq { int num;
> >  };
> > =20
> > +struct ksz_switch_macaddr {
> > +	unsigned char addr[ETH_ALEN];
> > +	refcount_t refcount;
> > +};
> > +
> >  struct ksz_port {
> >  	bool remove_tag;		/* Remove Tag flag set,
> > for ksz8795 only */ bool learning;
> > @@ -169,6 +174,10 @@ struct ksz_device {
> >  	struct mutex lock_irq;		/* IRQ Access */
> >  	struct ksz_irq girq;
> >  	struct ksz_ptp_data ptp_data;
> > +
> > +	struct ksz_switch_macaddr *switch_macaddr;
> > +	struct net_device *hsr_dev;     /* HSR */ =20
>=20
> Please be consistent with the lines above, and use tabs to align the
> "/* HSR */" comment.
>=20
> > +	u8 hsr_ports;
> >  };
> > =20
> >  /* List of supported models */
> > --=20
> > 2.20.1
> >  =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ZkQKSAsAEu=jIHC9=1/H+QD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUNeoAACgkQAR8vZIA0
zr1qBgf9Gl4/9eaXbxvpqOLABYM08KHwyHKzlbxSnzuRR9YfTxl3JEHp85xiX+VW
nbXqAT1RsmlQLVrHJCFITzX1p+mrp6Y2EovNgZoGSzpNPWy0PivMYlioYYGumlC1
if6YImV5b9WuZv1cYdlbTDcqPsK1O9LAgVI0Pc+DYUosB6jwFfjzE+7Wb3wgHOFR
oEVPgsX45yt8s+reXTZenIyefvDK83n4DODG1HFi9jcXoqkSobBTTcJQY9LhnXfa
n26nDdeS+2GPQBbNApGUbxY0xptiGJ7rB+uuvF02cWCWQPfuvzkzKuKTTU0WidRV
n4OUZN2kp6ZCNZwFSPktTyh798Ujng==
=pD1i
-----END PGP SIGNATURE-----

--Sig_/ZkQKSAsAEu=jIHC9=1/H+QD--

