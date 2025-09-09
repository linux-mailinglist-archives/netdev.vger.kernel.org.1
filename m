Return-Path: <netdev+bounces-221181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2005EB4ACBD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3FF1C24C74
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF59D326D54;
	Tue,  9 Sep 2025 11:48:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A003322DC2
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418518; cv=none; b=khKSK/8tyeLwmHQDDV+Ld8DGuF2ThIr+zujqzjidy94cSWo+kiCmvEpNqVsirdU0eX1aLwylamku1kB7iokw7UcRzpB0Y6wIWgLMtAIeANf1455GMvK6OuVmSHcKYliZJJYqggTwF+XqtDIgNL916GasK/1SJrzXcNH1owQ1R1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418518; c=relaxed/simple;
	bh=043hCoM+AFPSLJebSeLJZ3V5npElSfYglJ1Em1klq2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9+KBkGqC4bh9VFmN25RPHbMFB+ddDDrjJyNrx5KLMGF1Rpwb+YVDdPsjGd76eY/p8x8sJmsJ+3EdlzPgiwAgiBcZD9sMEhCkDOlfae9UvXNsz4vIzyiQphyouUrH0JKL/Fa502o9o/faM0DRFSnVlViy6y0B2XCUYrMM5R9eME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvwph-0003pA-II; Tue, 09 Sep 2025 13:48:21 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvwpg-000PdL-0t;
	Tue, 09 Sep 2025 13:48:20 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DCC37469E83;
	Tue, 09 Sep 2025 11:48:19 +0000 (UTC)
Date: Tue, 9 Sep 2025 13:48:19 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH] can: j1939: implement NETDEV_UNREGISTER notification
 handler
Message-ID: <20250909-eminent-gazelle-from-sirius-57ff0c-mkl@pengutronix.de>
References: <50055a40-6fd9-468f-8e59-26d1b5b3c23d@I-love.SAKURA.ne.jp>
 <aKg9mTaSxzBVpTVI@pengutronix.de>
 <bb595640-0597-4d18-a9e1-f6eb8e6bb50e@I-love.SAKURA.ne.jp>
 <c1e50f41-da30-4cea-859c-05db0ab8040b@I-love.SAKURA.ne.jp>
 <ac9db9a4-6c30-416e-8b94-96e6559d55b2@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nix5qo54czp344ou"
Content-Disposition: inline
In-Reply-To: <ac9db9a4-6c30-416e-8b94-96e6559d55b2@I-love.SAKURA.ne.jp>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--nix5qo54czp344ou
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: implement NETDEV_UNREGISTER notification
 handler
MIME-Version: 1.0

On 25.08.2025 23:07:24, Tetsuo Handa wrote:
> syzbot is reporting
>=20
>   unregister_netdevice: waiting for vcan0 to become free. Usage count =3D=
 2
>=20
> problem, for j1939 protocol did not have NETDEV_UNREGISTER notification
> handler for undoing changes made by j1939_sk_bind().
>=20
> Commit 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct
> callback") expects that a call to j1939_priv_put() can be unconditionally
> delayed until j1939_sk_sock_destruct() is called. But we need to call
> j1939_priv_put() against an extra ref held by j1939_sk_bind() call
> (as a part of undoing changes made by j1939_sk_bind()) as soon as
> NETDEV_UNREGISTER notification fires (i.e. before j1939_sk_sock_destruct()
> is called via j1939_sk_release()). Otherwise, the extra ref on "struct
> j1939_priv" held by j1939_sk_bind() call prevents "struct net_device" from
> dropping the usage count to 1; making it impossible for
> unregister_netdevice() to continue.
>=20
> Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D881d65229ca4f9ae8c84
> Tested-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Fixes: 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct =
callback")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to linux-can.

> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -1303,6 +1303,55 @@ void j1939_sk_netdev_event_netdown(struct j1939_pr=
iv *priv)
>  	read_unlock_bh(&priv->j1939_socks_lock);
>  }
> =20
> +void j1939_sk_netdev_event_unregister(struct j1939_priv *priv)
> +{
> +	struct sock *sk;
> +	struct j1939_sock *jsk;
> +	bool wait_rcu =3D false;
> +
> + rescan: /* The caller is holding a ref on this "priv" via j1939_priv_ge=
t_by_ndev(). */
   ^^

I've removed the space while applying the patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nix5qo54czp344ou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAFAAACgkQDHRl3/mQ
kZxAUwf9FZ+BFFz8LaPIT5LOqADuG61A3eMvYR/9mfoxOEHypL9Sbre540OgeWRT
kq9d7iL6g4rvLINaM+4KOJJ+jEQyuJE3lCFKLP9fDrtVODELzlx3lX7gOyJEKRNE
R0g2ERmhYMJqzgnZpRwt4Pof/I6sYM0fTDugN2PxIF7i2RwXC+qw1jq7q4fzxgHE
A0wAeXujBgpBdoaaNcwLhsVDgm2l860F0yN8Crii0UlXL0CY9frsHKF0uRQTyHl6
jEbXFW9UWk4RlUjTrK4+Qx/DDjD+cgpNgAnENZKGpP+mFvpfsdqEeGfbw/kRsym7
9+DJPH/rTIZdfLyiAniwW/IOqyzxTA==
=akSg
-----END PGP SIGNATURE-----

--nix5qo54czp344ou--

