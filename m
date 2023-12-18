Return-Path: <netdev+bounces-58665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62B3817C80
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 22:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549DC1F231F3
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 21:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD387346D;
	Mon, 18 Dec 2023 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfbfSnS5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B490142361
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 21:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C559DC433C8;
	Mon, 18 Dec 2023 21:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702934175;
	bh=nyuHgPQ/4P7N0Af44SlzughgnN/b/gDVwMHBjk8o/Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfbfSnS59WpBuFlgCWRSS9mko0hWhTctnraPQ/DKqrHhwB/1lPzp3krLTZ/AYqKgn
	 Hf65ecojm8OfCDn/MvP7AKFtfDOc14r3bFGySYiGjlrDlSUDMaYuyD/QMHF1MYNEwO
	 UXggu2jQoyYjHcYRT94DKF7Q14z99+v1nSTRbApgp4ouKEFTlOcNc4y3goZqiX3BBz
	 OuXr6jcj5zbb5aQzs3GG2tPVCG+1wtxKwI921XTR+rDKfjoBWl9qOUS0EgPvbuyuVF
	 /V9Dz0Nx4MPF6SuP+qHGUKz5g6gC2t/RzWArRpZPBXxLUJzY5eUzQHVHLvlOr8PSAi
	 Tk79JJG/eSFjg==
Date: Mon, 18 Dec 2023 22:16:11 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net] net: ethernet: mtk_wed: fix possible NULL pointer
 dereference in mtk_wed_wo_queue_tx_clean()
Message-ID: <ZYC2m3mMhfOpDN2j@lore-desk>
References: <3c1262464d215faa8acebfc08869798c81c96f4a.1702827359.git.lorenzo@kernel.org>
 <20231218175548.GI6288@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wveN++/UwSMJLfks"
Content-Disposition: inline
In-Reply-To: <20231218175548.GI6288@kernel.org>


--wveN++/UwSMJLfks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Dec 17, 2023 at 04:37:40PM +0100, Lorenzo Bianconi wrote:
> > In order to avoid a NULL pointer dereference, check entry->buf pointer =
before running
> > skb_free_frag in mtk_wed_wo_queue_tx_clean routine.
> >=20
> > Fixes: 799684448e3e ("net: ethernet: mtk_wed: introduce wed wo support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo,

Hi Simon,

>=20
> can I clarify that this can actually happen?

I was able to trigger the crash on a real device (Banana Pi BPI-R4) but
with a wrong swiotlb configuration. I do not have a strong opinion, I am
fine to target net-next instead. What do you prefer?

Regards,
Lorenzo

> What I am getting at, is that if not, it might be net-next material.
> In either case, I have no objection to the change itself.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

--wveN++/UwSMJLfks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZYC2mwAKCRA6cBh0uS2t
rARmAQDp+9gK74Ive8QiJgdh7Vt7bqhv33Mrz+RLnc7jBVaoWwD5AVgfJZkjfHUS
8w0T7fZ3kTuTKUMs+g7Exe70IqHXTgc=
=nwP9
-----END PGP SIGNATURE-----

--wveN++/UwSMJLfks--

