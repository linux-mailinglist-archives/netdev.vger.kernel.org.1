Return-Path: <netdev+bounces-48584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5F57EEE6E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177331F26115
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9E4DF60;
	Fri, 17 Nov 2023 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCBDB7
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:27:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3v8A-0001R7-GJ; Fri, 17 Nov 2023 10:27:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3v85-009e7I-Fr; Fri, 17 Nov 2023 10:27:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3v85-002ydb-63; Fri, 17 Nov 2023 10:27:13 +0100
Date: Fri, 17 Nov 2023 10:27:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Marek Majtyka <alardam@gmail.com>, Simon Horman <horms@kernel.org>,
	Mugunthan V N <mugunthanvnm@ti.com>, Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Stanislav Fomichev <sdf@google.com>, kernel@pengutronix.de,
	Alex Elder <elder@linaro.org>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	linux-omap@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH 0/7] net: ethernet: Convert to platform remove callback
Message-ID: <20231117092713.sohg4bp5d5ppfrbs@pengutronix.de>
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikrofhj5vz4fdzqm"
Content-Disposition: inline
In-Reply-To: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--ikrofhj5vz4fdzqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 17, 2023 at 10:16:56AM +0100, Uwe Kleine-K=F6nig wrote:
> after three fixes this series converts the remaining four platform
> drivers below drivers/net/ethernet that don't use .remove_new yet to do
> that.
>=20
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> The TL;DR; is to prevent bugs like the three fixed here.

I completely barfed this series, sorry for that.

I forgot to mention "net-next" in the subject. The first three patches
are fixes, but I don't think they are urgent enough to fasttrack them.

And somehow To: got empty, there must be something fishy in my scripts.
I will take care that this won't happen again.

Mea culpa,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ikrofhj5vz4fdzqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVXMfAACgkQj4D7WH0S
/k5XAgf/Sx/TIM0jqFYiDbyHQ+/dBw1HREsGYcWq91GT6jcIUmcAIfmgkih90Y6V
Xd3tt2Zf5QlviwOxO03hJ6amRu/RWZL0B40xMOMWL18US/1EglJWYfrd3+QE3364
YWUwnOfBlmQeCCyQTtvJXDz97+v9TxNfCgVSYbGIbTivZwgRgXYHw0NNHdURsoCv
ex53lSnsVnGQfLMRV9xTYNeMPZAGO5qUy3rwL3GD061hsIqr0iUZxw7xww61BV/J
wQ3p5Se8S79z7gvDL12/1aKT8723BnpiWj61lV2urYngi5dW/1yYJkgy8EfrzzYj
NlAYPeRXiKTxWctZ1grvd+4sO83wGw==
=ZNwr
-----END PGP SIGNATURE-----

--ikrofhj5vz4fdzqm--

