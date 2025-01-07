Return-Path: <netdev+bounces-156051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E7FA04BF3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CF93A13BC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BBC1F669F;
	Tue,  7 Jan 2025 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVoYtMb2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1F56446
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286943; cv=none; b=AnN14SUCYYmNjie0cAZ3WIeLj3iydrkrXLfRjqa85vNMxjDmQNtbC40C5y6/zoWZjOpZmTd4FqcCCdFj206uUalVnd9GW4WnwzTtpvxvL5TsEQP6PHIdursi6wlH6I62Ugdd2AVhOgSq5D4bCwfyRYW9IzGbOd545uOjBXzPU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286943; c=relaxed/simple;
	bh=jtmnWEARWEmD43FDdt9F+BHYo1jphXJeqPvu4IFcjkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhdvtLOsXyKWbH7Lu+7gMYdsorpFDULoJQjLBNXZyZp7N+pu7+s8Pm4PTPXdP0FBg8OL9UKDjwyxf2I73vngUILbKV/rEbUTkUdTFqLoaXCbvnPV6O6nO4t6bx2u988Mm32FF+HAbTMrxtos8SQHaoJtuLLvb61L+xbC6JUz0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVoYtMb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CFFC4CED6;
	Tue,  7 Jan 2025 21:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736286943;
	bh=jtmnWEARWEmD43FDdt9F+BHYo1jphXJeqPvu4IFcjkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVoYtMb2lHtH0/uYJDLRVOiHAMjmdE1b0iUlXhpMQ15n/SMSqRrR2b004IrUwheGd
	 qyg/hyC8QZCOGZiFjr7cqJbGvUlmoiZqKKxdy2QLY89ciGs725kz8Z6DVGldgvIgo2
	 vBRB4/f3lXTMCi61aD3GVtFioYTbZ6zw+DYSgebyZ08eaBZ6L+tC4/YN+1uAwNmzzp
	 I/xDuStj50j3hR7Ix/3kN61S6MtMPpJvyqwDAej80IYiUHvriyNTMaNaHF+nURV6dn
	 tLW0z2PzXTDJ7+Q4oTJb0KM/6gBR9Jps2zWosoX5ftn+N/yiy5I1ce9fdw6+UzC018
	 ksBbCeT5r4wHg==
Date: Tue, 7 Jan 2025 22:55:40 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: patchwork-bot+netdevbpf@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next 0/4] net: airoha: Add Qdisc offload support
Message-ID: <Z32i3EGrLfE2OlLN@lore-desk>
References: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
 <173625003251.4120801.586359106755098449.git-patchwork-notify@kernel.org>
 <CAKa-r6v0bEjQfbSG75E9kV1Qki-5eAbrqiy2maB2iG2O4Wf5Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rv8LOhYFLOQcML4d"
Content-Disposition: inline
In-Reply-To: <CAKa-r6v0bEjQfbSG75E9kV1Qki-5eAbrqiy2maB2iG2O4Wf5Xw@mail.gmail.com>


--Rv8LOhYFLOQcML4d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> hi,
>=20
> On Tue, Jan 7, 2025 at 12:40=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
> >
> > Hello:
> >
> > This series was applied to netdev/net-next.git (main)
> > by Paolo Abeni <pabeni@redhat.com>:
> >
> > On Fri, 03 Jan 2025 13:17:01 +0100 you wrote:
> > > Introduce support for ETS and HTB Qdisc offload available on the Airo=
ha
> > > EN7581 ethernet controller.
> > >
> > > ---
> > > Lorenzo Bianconi (4):
> > >       net: airoha: Enable Tx drop capability for each Tx DMA ring
> > >       net: airoha: Introduce ndo_select_queue callback
> > >       net: airoha: Add sched ETS offload support
>=20
> I was about to comment that ETS offload code probably still lacks
> validation of priomap [1]. Otherwise every ETS priomap will behave
> like the one that's implemented in hardware. It can be addressed in a
> follow-up commit, probably.

sorry, I forgot about it. I am fine to enforce priomap if it is required wi=
th a
follow-up patch.=20

Regards,
Lorenzo

>=20
> thanks,
> --
> davide
>=20
> [1] https://lore.kernel.org/netdev/CAKa-r6shd3+2zgeEzVVJR7fKWdpjKv1YJxS3z=
+y7QWqDf8zDZQ@mail.gmail.com/
>=20

--Rv8LOhYFLOQcML4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ32i3AAKCRA6cBh0uS2t
rIr6AQD7Gjch5GSpHsIaSEqrXwCHjxSHuhrQdfBAepQ5SPB4UgD+Ox/WGqd9I9jr
x8iG9A7gy4ZsLv9KHdYITc7HfixhugA=
=ibn2
-----END PGP SIGNATURE-----

--Rv8LOhYFLOQcML4d--

