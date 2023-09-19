Return-Path: <netdev+bounces-34985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C707A65BA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B909D1C20EF7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CB374D7;
	Tue, 19 Sep 2023 13:51:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F63137CB6;
	Tue, 19 Sep 2023 13:51:27 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043DEEC;
	Tue, 19 Sep 2023 06:51:25 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E430986AB9;
	Tue, 19 Sep 2023 15:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695131483;
	bh=1Tzkn3x8aOBmePnbhg5ApBY8ci+Iq7Nh8pBQeSLj9fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W1jvK9IT3d6VHdtnwA+DFlKIkGwjJrpq/kwKOQKyKTtb9atKiHS0713PyUaoaNoKD
	 bcuwMIQk0Nb20aBfzhQHlITOp9dvFScgpCU60bW4tK9y1boqHjeXCvheyWhFhtx7To
	 s3DyxISG5dyyWzHfDlmT9hUOcxF8U2hQ0mf7ggXWfxj9KFWCK6A2tNmvCyp+EkC+3j
	 QKiOyC38RvbyED6lv/NRaee4lWHQtwj5evAxUfvUBR8kOaENLFBNfQ5FHaMqOMmJlu
	 Xpf9oacY3leVP1tV/rvPw7cVNr2/TrAX/3v7pDIy6+sGVyykiAsxvPEDY5wYIc/+4c
	 mhhXuZly2Oc0Q==
Date: Tue, 19 Sep 2023 15:51:16 +0200
From: Lukasz Majewski <lukma@denx.de>
To: <Parthiban.Veerasooran@microchip.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <Steen.Hegelund@microchip.com>, <rdunlap@infradead.org>,
 <horms@kernel.org>, <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
 <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
 <andrew@lunn.ch>
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Message-ID: <20230919155048.3616ffdc@wsk>
In-Reply-To: <da16882b-aea8-486b-5541-2919ff227458@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
	<20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
	<20230913104458.1d4cdd51@wsk>
	<61a58960-f2f3-4772-8f12-0d1f9cfec2c5@lunn.ch>
	<20230913152625.73e32789@wsk>
	<da16882b-aea8-486b-5541-2919ff227458@microchip.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3aHpRFr/kL4=eb6NzHUkjjL";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/3aHpRFr/kL4=eb6NzHUkjjL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Parthiban,

> Hi Lukasz,
>=20
> Sorry for the delayed response. Regarding your issue, we just noticed=20
> that you have also filed an issue in our oa tc6 lib github page. Our
> oa tc6 lib for controllers developer Thorsten will get back to you on
> this. You can get the solution from there.
>=20
> https://github.com/MicrochipTech/oa-tc6-lib/issues/14

Yes. This is filled by me :-)

I will reach Thorsten directly.

Thanks for the reply.

>=20
> Best Regards,
> Parthiban V
>=20
> On 13/09/23 6:56 pm, Lukasz Majewski wrote:
> > Hi Andrew,
> >  =20
> >>> Just maybe mine small remark. IMHO the reset shall not pollute the
> >>> IRQ hander. The RESETC is just set on the initialization phase and
> >>> only then shall be served. Please correct me if I'm wrong, but it
> >>> will not be handled during "normal" operation. =20
> >>
> >> This is something i also wondered. Maybe if the firmware in the
> >> MAC-PHY crashes, burns, and a watchdog reset it, could it assert
> >> RESETC? I think maybe a WARN_ON_ONCE() for RESETC in the interrupt
> >> handler would be useful, but otherwise ignore it. Probe can then
> >> poll during its reset.
> >> =20
> >>>> +				regval =3D RESETC;
> >>>> +				/* SPI host should write RESETC
> >>>> bit with one to
> >>>> +				 * clear the reset interrupt
> >>>> status.
> >>>> +				 */
> >>>> +				ret =3D oa_tc6_perform_ctrl(tc6,
> >>>> OA_TC6_STS0,
> >>>> +
> >>>> &regval, 1, true,
> >>>> +
> >>>> false); =20
> >>>
> >>> Is this enough to have the IRQ_N deasserted (i.e. pulled HIGH)?
> >>>
> >>> The documentation states it clearly that one also needs to set
> >>> SYNC bit (BIT(15)) in the OA_CONFIG0 register (which would have
> >>> the 0x8006 value).
> >>>
> >>> Mine problem is that even after writing 0x40 to OA_STATUS0 and
> >>> 0x8006 to OA_CONFIG0 the IRQ_N is still LOW (it is pulled up via
> >>> 10K resistor).
> >>>
> >>> (I'm able to read those registers and those show expected values)
> >>> =20
> >>
> >> What does STATUS0 and STATUS1 contain? =20
> >=20
> > STATUS0 =3D> 0x40, which is expected.
> >=20
> > Then I do write 0x40 to STATUS0 -> bit6 (RESETC) is R/W1C
> >=20
> > After reading the same register - I do receive 0x00 (it has been
> > cleared).
> >=20
> > Then I write 0x8006 to OA_CONFIG0.
> >=20
> > (Those two steps are regarded as "configuration" of LAN865x device
> > in the documentation)
> >=20
> > In this patch set -> the OA_COFIG0 also has the 0x6 added to
> > indicate the SPI transfer chunk.
> >=20
> > Dump of OA registers:
> > {0x11, 0x7c1b3, 0x5e5, 0x0, 0x8006, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
> > 0x3000, 0x1fbf, 0x3ffe0003, 0x0, 0x0}
> >=20
> > Status 0 (0x8) -> 0x0
> > Status 1 (0x9) -> 0x0
> >  =20
> >> That might be a dumb question,
> >> i've not read the details for interrupt handling yet, but maybe
> >> there is another interrupt pending? Or the interrupt mask needs
> >> writing? =20
> >=20
> > All the interrupts on MASK{01} are masked.
> >=20
> > Changing it to:
> > sts &=3D ~(OA_IMASK0_TXPEM | OA_IMASK0_TXBOEM | OA_IMASK0_TXBUEM |
> > OA_IMASK0_RXBOEM | OA_IMASK0_LOFEM | OA_IMASK0_HDREM
> >=20
> > doesn't fix this problem.
> >  =20
> >> =20
> >>> Was it on purpose to not use the RST_N pin to perform GPIO based
> >>> reset?
> >>>
> >>> When I generate reset pulse (and keep it for low for > 5us) the
> >>> IRQ_N gets high. After some time it gets low (as expected). But
> >>> then it doesn't get high any more. =20
> >>
> >> Does the standard say RST_N is mandatory to be controlled by
> >> software? I could imagine RST_N is tied to the board global reset
> >> when the power supply is stable. =20
> >=20
> > It can be GPIO controlled. However, it is not required. I've tied
> > it to 3V3 and also left NC, but no change.
> >  =20
> >> Software reset is then used at probe time. =20
> >=20
> > I've reconfigured the board to use only SW based reset (i.e. set
> > bit0 in OA_RESET - 0x3).
> >  =20
> >>
> >> So this could be a board design decision. I can see this code
> >> getting extended in the future, an optional gpiod passed to the
> >> core for it to use. =20
> >=20
> > I can omit the RST_N control. I'd just expect the IRQ_N to be high
> > after reset.
> >  =20
> >> =20
> >>>> msecs_to_jiffies(1)); =20
> >>>
> >>> Please also clarify - does the LAN8651 require up to 1ms "settle
> >>> down" (after reset) time before it gets operational again? =20
> >>
> >> If this is not part of the standard, it really should be in the MAC
> >> driver, or configurable, since different devices might need
> >> different delays. But ideally, if the status bit says it is good
> >> to go, i would really expect it to be good to go. So this probably
> >> should be a LAN8651 quirk. =20
> >=20
> > The documentation is silent about the "settle down time". The only
> > requirements is for RST_N assertion > 5us. However, when the IRQ_N
> > goes low, and the interrupt is served - it happens that I cannot
> > read ID from the chip via SPI.
> >  =20
> >>
> >> 	Andrew =20
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > --
> >=20
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/3aHpRFr/kL4=eb6NzHUkjjL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUJp1QACgkQAR8vZIA0
zr39kwf/YdnjjI5hILbSVJf1iY+T/de1T8Ni2UI2gJpq3nRKyyIFlKSPeYsdXtna
54zI4ptmwPeReYU1fovVZDMCXNgEBs5FMoc9P71rnKPIlE0OT92JVomgrMU8HjUv
d2UpgOvoh+xW4WI9++2jhZCAjQm7KD30JVsFzZ0lU7AL5B4RPieHyF02ORPsvlcW
nbz0yhyrk5gEZndjxPnYkzwi22ZhcatCSOLmPkG3REnZiTOgcMxGBFB/6SPhC3Xd
vNJJarWEG5ERlaJKNWOzrYGfCzzWi3F/VVMZZGfJnvoECr2qAzd2hm57pizw2F7x
FGMx8Ulj7ggukio8zvNZ/k95kDjylA==
=TBN6
-----END PGP SIGNATURE-----

--Sig_/3aHpRFr/kL4=eb6NzHUkjjL--

