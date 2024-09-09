Return-Path: <netdev+bounces-126448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774BE9712BB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7331F233CC
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C01B2533;
	Mon,  9 Sep 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="qrwqWohr"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1171B150A;
	Mon,  9 Sep 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872314; cv=none; b=AIAFg6BZMh1d2aIgKCpKB+TSvc1YnF5NrG3m9ILFVAvuGSD4Ul53Sj+yel0f0yExryK4CftIQ5+2gBOocbIzPdAph399/KeGitk78oF94CZzMG0yaDr04hjuYmG45nqo6Ha+jKNgiPiRCu0dWz4wkiW+XZdd+d1uFPRRyHGsAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872314; c=relaxed/simple;
	bh=BtIb6N/65OadEVbzYDIoljRr+q5odejFkgXYzE+ot9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rscKeRmOl/xShiIqMS+KwVw4eJ4w4IG9uQnfTB0GCGBf3p6LwbUdkns6iDVXhpm21O2W+1YwegbsMa2kdkMSPU5NbNU0w4Ey0+7P709CmUisiZ3umTwNjisjpdErMaH3tm/hW1f21b07D6dhEqvvWkWsgSShrObeMsogyYts6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=qrwqWohr; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9273888D08;
	Mon,  9 Sep 2024 10:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725872304;
	bh=m6dN1ufqowxfvuhPSE7wesgvmyXMXmsyT3a/MEsiJ9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qrwqWohr1WXSwj3fE2907xEAa4lTMNBOOpaD3Z5d1XqWP49svEF3VDPq2SprPFqGA
	 5uTW7JA4MWjcK2tORZwvcPAP3T0h78XLqrbPY4E5D9LYb/4XOI+xUcmjnLsD2bL/3y
	 OdNskHviflAuF5n0j/RrqDhOLO40QezBmMezOU7D6JzdedNCZra6jYGCADFlcy43Qw
	 zMZhPPkNwQigYsJvz7hICNqZAYcj5CQw7dRkhSaTegQipF260g6skrGvPdlRccdKtK
	 31EXV22JFBPDQaG3Z/7inlTcUSGjPhHNSx8eZvLd41rsSPcuznlhPthFDXminaQ1rP
	 R/an7xFzdd+kg==
Date: Mon, 9 Sep 2024 10:58:22 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ricardo@marliere.net,
 m-karicheri2@ti.com, n.zhandarovich@fintech.ru, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: hsr: prevent NULL pointer dereference in
 hsr_proxy_announce()
Message-ID: <20240909105822.16362339@wsk>
In-Reply-To: <20240907190341.162289-1-aha310510@gmail.com>
References: <20240907190341.162289-1-aha310510@gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g5vQTmOQi/JcuOEiHPFvrW5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/g5vQTmOQi/JcuOEiHPFvrW5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jeongjun,

> In the function hsr_proxy_annouance() added in the previous commit=20
> 5f703ce5c981 ("net: hsr: Send supervisory frames to HSR network=20
> with ProxyNodeTable data"), the return value of the
> hsr_port_get_hsr() function is not checked to be a NULL pointer,
> which causes a NULL pointer dereference.

Thank you for your patch.

The code in hsr_proxy_announcement() is _only_ executed (the timer is
configured to trigger this function) when hsr->redbox is set, which
means that somebody has called earlier iproute2 command:

ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3
supervision 45 version 1

>=20
> To solve this, we need to add code to check whether the return value=20
> of hsr_port_get_hsr() is NULL.
>=20
> Reported-by: syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com
> Fixes: 5f703ce5c981 ("net: hsr: Send supervisory frames to HSR
> network with ProxyNodeTable data") Signed-off-by: Jeongjun Park
> <aha310510@gmail.com> ---
>  net/hsr/hsr_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index e4cc6b78dcfc..b3191968e53a 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -427,6 +427,9 @@ static void hsr_proxy_announce(struct timer_list
> *t)
>  	 * of SAN nodes stored in ProxyNodeTable.
>  	 */
>  	interlink =3D hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
> +	if (!interlink)
> +		goto done;
> +
>  	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list)
> { if (hsr_addr_is_redbox(hsr, node->macaddress_A))
>  			continue;
> @@ -441,6 +444,7 @@ static void hsr_proxy_announce(struct timer_list
> *t) mod_timer(&hsr->announce_proxy_timer, jiffies + interval);
>  	}
> =20
> +done:
>  	rcu_read_unlock();
>  }
> =20
> --



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/g5vQTmOQi/JcuOEiHPFvrW5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbeuK4ACgkQAR8vZIA0
zr3aWQf+LpYtx8KQQR5W5bNOlDJ7ql9rMWJUeO+uDIvvDuLJP8bf7uaJ5+i9RKZW
HbKqOx7rYgVmqj5Aax91wIDdXY4NB7jqg0BOfCB67E45a/sVLaLqjnhqXgI6EPQ0
yLHszr6Tte0VxjbjL66BE0jU5HUi5Xm4tyr9rHKywp4b8bz1iVBgStiQNuh2bNTI
GTo6MBPaiDBHlYLp8Z+ZYGfaASzLxxam3Tw/bqe9o9vFxp50/cqyLdqqqH2z8IsF
D03sUeqR/6Nshir1tKUWXLNHtY5295NgLQNKHlFNpdJ1+3JAERjXrbT3hrWiQ4SN
/acWEqui6OstJunaMWX8YxW8xA7Fwg==
=A/M4
-----END PGP SIGNATURE-----

--Sig_/g5vQTmOQi/JcuOEiHPFvrW5--

