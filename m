Return-Path: <netdev+bounces-33819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D547A7A0549
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDB41F239B6
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA274208B1;
	Thu, 14 Sep 2023 13:16:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5E241E0
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 13:16:24 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC06D1A5;
	Thu, 14 Sep 2023 06:16:23 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id ABE75869AC;
	Thu, 14 Sep 2023 15:16:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694697381;
	bh=ANW6iuO+Xs9Oa8d3ExuX6O0xpKVHUpI7ARHH9sJ/4Yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LEE3Asju9BEDGUQiGjX4B2oBdKbLwXaOE4er7l2IV6T/gzXW34VZfE7TLHWi38+gr
	 3KuhGbEJL0Fi4x5QeGVFkEzuIVaRDb831ZgyHiU153+dDn/ZIg7fxsxJoZ7q4lpceN
	 XTde2xPzSDBYtzf1TnYt9BYX5LAlv5XBxOQSH2mW6N++x2kD7BeiCBOHclEz1WA7LH
	 XJFHDCX+Zzkd+zfZ5qnj1WORbdSKyMrGHimix7QDfmw6SAUj2y3ksII+SPhIwylYeL
	 EGqkVUAtwfDq5bvoFK12iLNoKl5kLdHOAGL6+hr3sazlf4wQSlHMqr00u9ITsi5HP8
	 NE+694p1zAhqQ==
Date: Thu, 14 Sep 2023 15:16:14 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Kristian Overskeid <koverskeid@gmail.com>, Matthieu
 Baerts <matthieu.baerts@tessares.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: hsr: Provide fix for HSRv1 supervisor
 frames decoding
Message-ID: <20230914151614.79e92ec9@wsk>
In-Reply-To: <20230914125531.Svewd4AN@linutronix.de>
References: <20230914124731.1654059-1-lukma@denx.de>
	<20230914125531.Svewd4AN@linutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nQN16FnpF.iji1Liwm+YTjm";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/nQN16FnpF.iji1Liwm+YTjm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sebastian Andrzej,

> On 2023-09-14 14:47:30 [+0200], Lukasz Majewski wrote:
> > Provide fix to decode correctly supervisory frames when HSRv1
> > version of the HSR protocol is used. =20
>=20
> I'm going take this, reword the commit message and send it along with
> fixes to the test suite we actually have=E2=80=A6
>=20

+1

> Sebastian

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/nQN16FnpF.iji1Liwm+YTjm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUDB54ACgkQAR8vZIA0
zr2J5gf6A8WQQ3GICf0k5qddIcAkJoi/TEw4Ioa4+MkJE5MgFXd6Z88g07rYokgv
IJ2yMAush/snYwR0NRkVj/FSB++vP9He7USmnaXgZHPD0LZy5MgsVUU3bgxyUona
2ClbHqN1b09lu01J8CKQlxi8DUdbO+HIJ/a3rUPKVaTLLoUr9aQs0xLTjrPB/d/W
elBm+NTes0dqrILmGVo8Zmw+SFSNh00SC6HhtE/xAGPR/cjA9K9Cbw37LWvqaKp7
/m0MVpegECcgdrPMQKKkb9A26yQSQ8CShBvACjwAAOkARHE44UR6gtQgJiZF+3hl
hxuE4IkFz3OPvrkuVVqVLC4u1IxilQ==
=RLb6
-----END PGP SIGNATURE-----

--Sig_/nQN16FnpF.iji1Liwm+YTjm--

