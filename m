Return-Path: <netdev+bounces-17846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB77B75335D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179891C21596
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE37479;
	Fri, 14 Jul 2023 07:42:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6887472
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:42:23 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF28213C
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 00:42:22 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qKDRB-0000Y7-NC; Fri, 14 Jul 2023 09:42:01 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3A2BA1F0C60;
	Fri, 14 Jul 2023 07:42:00 +0000 (UTC)
Date: Fri, 14 Jul 2023 09:41:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kumari Pallavi <kumari.pallavi@intel.com>
Cc: "rcsekar@samsung.com" <rcsekar@samsung.com>,
	"Sangannavar, Mallikarjunappa" <mallikarjunappa.sangannavar@intel.com>,
	"Nikula, Jarkko" <jarkko.nikula@intel.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Thokala, Srikanth" <srikanth.thokala@intel.com>
Subject: Re: RE: RE: [RESEND] [PATCH 1/1] can: m_can: Control tx and rx flow
 to avoid communication stall
Message-ID: <20230714-sublime-vanilla-239fd808904c-mkl@pengutronix.de>
References: <20230623085920.12904-1-kumari.pallavi@intel.com>
 <20230705-return-slogan-36c499673bb6-mkl@pengutronix.de>
 <SJ1PR11MB608478D62EDFAEDDBE8C0890872DA@SJ1PR11MB6084.namprd11.prod.outlook.com>
 <20230707-breeder-shaft-61b826633b7e-mkl@pengutronix.de>
 <SJ1PR11MB60842B19103EC186A4FDB0838734A@SJ1PR11MB6084.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="miqxsq6fpespuq3y"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60842B19103EC186A4FDB0838734A@SJ1PR11MB6084.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--miqxsq6fpespuq3y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.07.2023 07:26:01, Kumari Pallavi wrote:
> > On 07.07.2023 05:38:09, Kumari Pallavi wrote:
> > > > >  			if (netif_queue_stopped(dev) &&
> > > > >  			    !m_can_tx_fifo_full(cdev))
> > > > >  				netif_wake_queue(dev);
> > > > > @@ -1787,6 +1787,7 @@ static netdev_tx_t m_can_start_xmit(struct
> > > > > sk_buff
> > > > *skb,
> > > > >  		}
> > > > >  	} else {
> > > > >  		cdev->tx_skb =3D skb;
> > > > > +		m_can_write(cdev, M_CAN_IE, IR_ALL_INT & (IR_TEFN));
> > > >
> > > > - What's the purpose of  "()" around IR_TEFN?
> > > > - "IR_ALL_INT & (IR_TEFN)" is equal to IR_TEFN, isn't it?
> > > > - This basically disables all other interrupts, is this what you wa=
nt to
> > > >   do?
> > > > - What happens if the bus is busy with high prio CAN frames and you=
 want
> > > >   to send low prio ones? You will not get any RX-IRQ, this doesn't =
look
> > > >   correct to me.
> > > >
> > >
> > > Even though the RX interrupt is disabled (in IE), if there is an TX
> > > interrupt and the RF0N bit is set (in IR), the RX packet will still be
> > > serviced because the TX and RX share the same IRQ handler.
> >=20
> > If the bus is busy with high prio CAN frames and the m_can wants to sen=
d a low
> > prio frame, the m_can will not be able to send it's CAN frame, there wi=
ll be not
> > TX interrupt. If there are enough high prio CAN frames the RX buffer wi=
ll
> > overflow.
>=20
> Sorry for late reply, I agree let me see if I can try to simulate this
> scenario using CAN analyzer. I already stressed the current solution
> for more than 10 days and didn't observe any issue. However, I will
> try to incorporate this scenario for stress as well and come back.

=46rom my point of view, this is a conceptional problem of this
workaround.

To test this issue, saturate the bus with CAN frames ID 0x0. Then on the
m_can send CAN frames with ID=3D0x7ff.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--miqxsq6fpespuq3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSw/EUACgkQvlAcSiqK
BOhcVgf9FVeqrRcMiUN45YcPm3fqfWnz9r+Y6QUSPJtSjJQF+Q3+eXW3MpR2MLII
meoPMDZpPYd7EDwGW9syPTz0bC5TNFn+YGwsiLZDhCsj6vMXoan+pOrqq9DdrN61
avCLdSGN51pfw5lqyc/RelE8ffHljCjrSpqogLUt7+M4qqeW9z7PZS1yv+lL4mj9
J7sqRa3aK8mElz5cqeknElDATEkmVWrlHW3WIosWgB54/C8J+zbDrTTjipS5eww6
STj2jtlFIyUibyxqkL8Edf8k65wxRlyyN7dc/LdDEpQhuf50qVKE1iMSayOMSJ7R
ZATUbj82zvuju12MGl6yYZMO/s7pVw==
=NiAl
-----END PGP SIGNATURE-----

--miqxsq6fpespuq3y--

