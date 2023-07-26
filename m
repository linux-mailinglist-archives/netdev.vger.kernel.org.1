Return-Path: <netdev+bounces-21176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9286762AF3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 07:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950EA1C210C0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B9263CC;
	Wed, 26 Jul 2023 05:50:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A91FB9
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:50:43 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A811982
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 22:50:42 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qOXPd-00042j-DG; Wed, 26 Jul 2023 07:50:17 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A5F631FAD5F;
	Wed, 26 Jul 2023 05:50:11 +0000 (UTC)
Date: Wed, 26 Jul 2023 07:50:11 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Johannes Zink <j.zink@pengutronix.de>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	kernel test robot <lkp@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, patchwork-jzi@pengutronix.de
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <20230726-subsector-unguided-8f1fc1edb037-mkl@pengutronix.de>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n73y6rsllricxc2b"
Content-Disposition: inline
In-Reply-To: <20230725200606.5264b59c@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--n73y6rsllricxc2b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.07.2023 20:06:06, Jakub Kicinski wrote:
> On Mon, 24 Jul 2023 12:01:31 +0200 Johannes Zink wrote:
> > The IEEE1588 Standard specifies that the timestamps of Packets must be
> > captured when the PTP message timestamp point (leading edge of first
> > octet after the start of frame delimiter) crosses the boundary between
> > the node and the network. As the MAC latches the timestamp at an
> > internal point, the captured timestamp must be corrected for the
> > additional path latency, as described in the publicly available
> > datasheet [1].
> >=20
> > This patch only corrects for the MAC-Internal delay, which can be read
> > out from the MAC_Ingress_Timestamp_Latency register, since the Phy
> > framework currently does not support querying the Phy ingress and egress
> > latency. The Closs Domain Crossing Circuits errors as indicated in [1]
> > are already being accounted in the stmmac_get_tx_hwtstamp() function and
> > are not corrected here.
> >=20
> > As the Latency varies for different link speeds and MII
> > modes of operation, the correction value needs to be updated on each
> > link state change.
> >=20
> > As the delay also causes a phase shift in the timestamp counter compared
> > to the rest of the network, this correction will also reduce phase error
> > when generating PPS outputs from the timestamp counter.
> >=20
> > [1] i.MX8MP Reference Manual, rev.1 Section 11.7.2.5.3 "Timestamp
> > correction"
>=20
> Hi Richard,
>=20
> any opinion on this one?
>=20
> The subject read to me like it's about *MII clocking delays, I figured
> you may have missed it, too.

The patch description clarifies what is being corrected, namely the
"MAC-internal delay, which can be read out from the
MAC_Ingress_Timestamp_Latency register".

The next step would be to correct PHY latency, but there is no support
for querying PHY latency yet.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n73y6rsllricxc2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTAtA0ACgkQvlAcSiqK
BOj+xAf9HnUMaNIWiFRIZoj3nuV0Sm7RBhk/exT6G18NMZPSk82FtzDgOsBQmJba
Jg1SR+1P8sQl41S08+MUGp8la2aafbin8uKx59u9Cc2awqTCm8LKkH0Dy6VbIs+0
kzwv9OnjeUW59XCtw14bf6A98IzSF7EjUQbYHohSzu3rpPcP8FUFHn80E3Mx7eMf
lCUbHVKVSwk0UX/SEic4hBowFTIn5IOLhpvSShLGBTkG+Cwl2t7xQikqtlrrzoBd
cFA14fvDpoeN/zSkP/L+5RPheqpAsNMxfz/W1+c84+6k06yMZrg+0nlkD0u18MNg
nsLo15Uu8pW06snGCiGSny4ZBzEUQQ==
=o4NS
-----END PGP SIGNATURE-----

--n73y6rsllricxc2b--

