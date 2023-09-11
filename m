Return-Path: <netdev+bounces-32782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C840B79A6CA
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DE41C209D6
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF24CC120;
	Mon, 11 Sep 2023 09:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3D4BE7C
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:38:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8BDEE;
	Mon, 11 Sep 2023 02:38:32 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B75581C0006; Mon, 11 Sep 2023 11:38:30 +0200 (CEST)
Date: Mon, 11 Sep 2023 11:38:30 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 7/8] wifi: cfg80211: ocb: don't leave if not
 joined
Message-ID: <ZP7gFtW+U07CpC/K@duo.ucw.cz>
References: <20230908182127.3461199-1-sashal@kernel.org>
 <20230908182127.3461199-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zZsMGIhynDkbXF0"
Content-Disposition: inline
In-Reply-To: <20230908182127.3461199-7-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--4zZsMGIhynDkbXF0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> If there's no OCB state, don't ask the driver/mac80211 to
> leave, since that's just confusing. Since set/clear the
> chandef state, that's a simple check.

This is not queued for 5.10. Mistake?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4zZsMGIhynDkbXF0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7gFgAKCRAw5/Bqldv6
8tPKAJ0ZLwIUgSYRZlbf8Uohwr5HVJ6hQACgwgVm1eyNnOoNGQRa72F8vHVKJWc=
=p2UP
-----END PGP SIGNATURE-----

--4zZsMGIhynDkbXF0--

