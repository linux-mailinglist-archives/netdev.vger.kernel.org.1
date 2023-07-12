Return-Path: <netdev+bounces-17067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5758275018D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E9B1C20E33
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D40393;
	Wed, 12 Jul 2023 08:31:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AB362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:31:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A649DF;
	Wed, 12 Jul 2023 01:31:43 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E2B8D1C0D20; Wed, 12 Jul 2023 10:31:41 +0200 (CEST)
Date: Wed, 12 Jul 2023 10:31:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, Qingfang DENG <qingfang.deng@siflower.com.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	Masahide NAKAMURA <nakam@linux-ipv6.org>,
	Ville Nuorvala <vnuorval@tcs.hut.fi>,
	Netdev <netdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 6.4 0/6] 6.4.3-rc2 review
Message-ID: <ZK5k7YnVA39sSXOv@duo.ucw.cz>
References: <20230709203826.141774942@linuxfoundation.org>
 <CA+G9fYtEr-=GbcXNDYo3XOkwR+uYgehVoDjsP0pFLUpZ_AZcyg@mail.gmail.com>
 <20230711201506.25cc464d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qQR1/1cW9OcS5FMZ"
Content-Disposition: inline
In-Reply-To: <20230711201506.25cc464d@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--qQR1/1cW9OcS5FMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-=
rc
> >   git_sha: 3e37df3ffd9a648c9f88f6bbca158e43d5077bef
>=20
> I can't find this sha :( Please report back if you can still repro this
> and how we get get the relevant code

That sha seems to be:

commit 3e37df3ffd9a648c9f88f6bbca158e43d5077bef
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sun Jul 9 22:38:22 2023 +0200

    Linux 6.4.3-rc2

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qQR1/1cW9OcS5FMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZK5k7QAKCRAw5/Bqldv6
8gxrAKC0sRGnPwvEXzxK6ANn6c7JfCq4iwCfQSl6TCDucoiD+CImzIBUPHQlBw8=
=jygc
-----END PGP SIGNATURE-----

--qQR1/1cW9OcS5FMZ--

