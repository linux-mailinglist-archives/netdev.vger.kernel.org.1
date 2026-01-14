Return-Path: <netdev+bounces-249790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B4D1E043
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFAEA3069FD4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E99352C2F;
	Wed, 14 Jan 2026 10:22:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E46634CFD3
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386171; cv=none; b=Aajswi7rEImt4eRcoyyuX3Ss5/Gv+SH5h+/1Oyal9M9+IR1lD3zntw09qqn1DS2Fkje6sOlylaNYYYOMNrBKIf+ZGbvC1+qXkvvgpb18l3V7rO/WxJaW1xf1G+aAtK2CCpNFLnXcqEleB6YRCKGoAsHqsRBagp9tUIHatw//SW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386171; c=relaxed/simple;
	bh=c271p6I9h+njsMMtosYmdrxw0pvOwhe1g08YutppGwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmOSkBtPzzESyMd1KVuQ+KAr9uG621YMWgUjQWF/YuLSzQCDWByIT3lxrXrRJVuFwovp1E6JqVbnFj7e2Q43NHIojav9ZetgJND7Qa0dYj7zyYxfXQNHN/iOcALdkF3ras1YLxz8fJXYymo3ia6p1cAOCJPFbS2YmWDSKkRNdDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfy1L-0002Jm-Jf; Wed, 14 Jan 2026 11:22:35 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfy1M-000ZXo-09;
	Wed, 14 Jan 2026 11:22:35 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 10E764CCB11;
	Wed, 14 Jan 2026 10:22:35 +0000 (UTC)
Date: Wed, 14 Jan 2026 11:22:34 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] can: j1939: deactivate session upon receiving the second
 rts
Message-ID: <20260114-sticky-inescapable-spoonbill-52932b-mkl@pengutronix.de>
References: <faee3f3c-b03d-4937-9202-97ec5920d699@I-love.SAKURA.ne.jp>
 <4b1fbe9d-5ca2-41e9-b252-1304cc7c215a@I-love.SAKURA.ne.jp>
 <aWZXX_FWwXu-ejEk@pengutronix.de>
 <b1212653-8fa1-44e1-be9d-12f950fb3a07@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ji4kfrvki5qyngl2"
Content-Disposition: inline
In-Reply-To: <b1212653-8fa1-44e1-be9d-12f950fb3a07@I-love.SAKURA.ne.jp>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--ji4kfrvki5qyngl2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: deactivate session upon receiving the second
 rts
MIME-Version: 1.0

On 14.01.2026 00:28:47, Tetsuo Handa wrote:
> Since j1939_session_deactivate_activate_next() in j1939_tp_rxtimer() is
> called only when the timer is enabled, we need to call
> j1939_session_deactivate_activate_next() if we cancelled the timer.
> Otherwise, refcount for j1939_session leaks, which will later appear as
>
>   unregister_netdevice: waiting for vcan0 to become free. Usage count =3D=
 2.
>
> problem.
>
> Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D881d65229ca4f9ae8c84
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Can you provide a Fixes tag? No need to resend. I'll add it while
applying.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ji4kfrvki5qyngl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlnbmcACgkQDHRl3/mQ
kZybNggAh19lbL39wxJiK5QEaIOOY/V4D1H2THlLkpROgsCZ0gg50xyJ2u4iDyo6
jDgJU5MlNJN7tfJetS2XN9d22u7+kEtAfV7j7Xz2oap8baZVlcty9r8sNf/LHJS+
HcHNLgew2Ibfz0UQ4TJnnfBzV+E2woG31g9NlLLlKt6Qm9CFXWXoMoCP4M4kUUKH
cu7/tWmZf+MvmIQpv74k8JSn3iaNO04P0ukrpJjkgoNM1NZzLQxHfIMmF/sLECGp
llmHWK+xcp6yH7nnwn4NOU2U9blNL+/hsoWfDtc7RkRlQ4dSLDGQPemk7FwcVDR1
qg3FpP2ScBALuT/PE2e+PWytpaWIkA==
=0Ni/
-----END PGP SIGNATURE-----

--ji4kfrvki5qyngl2--

