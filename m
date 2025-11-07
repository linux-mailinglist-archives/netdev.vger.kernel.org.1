Return-Path: <netdev+bounces-236783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 767DCC401ED
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23BDB34E327
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80DA2E265A;
	Fri,  7 Nov 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcqrujjB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CDE2F6585
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522208; cv=none; b=J7i91WxsWNJX8k5QfMsChoDn1oXbpYO40cLmJ/k+LC+MYma0Trjlt7nRF8SIPyrcYmR/UiwhIG1Ru9ppRG/mvBDnKrtEkwMc/ov0ybrchuC8/i6jD52aA34+LP5icAsDf3B0YrnO6+g2svljP3ESCrl2+uP6TftSr9zguAyxsdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522208; c=relaxed/simple;
	bh=ayKu6qJSzYXCMxqqx8+O/4F+Us8bRURTI3A5cDLYypM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilEVVueaLo8Ecydv+vPoKR2JsfWcqrRGJzojOp37vwfi4jgPk8ogZfnfto2tjl7fvewR9mihpmIuJKeaGN3T2T/VPaLQlvJqkIMrsf9NUrXBhg9oDlPDhoUgIqZMQdq8eMqajkENKGM7AptjZP/CN6gR0c6oi7YuskNaIjafcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcqrujjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBECC4CEF7;
	Fri,  7 Nov 2025 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762522205;
	bh=ayKu6qJSzYXCMxqqx8+O/4F+Us8bRURTI3A5cDLYypM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcqrujjBziW2PnvjdzfKWfsqY1cKDz8qMBny0eqYuge1EUE++z4ZhTutoDCsjA94n
	 KkiSqfoFGO4WfZXdFy8weoDhV+xXAnay9BLKUeO+7PKRwt6E8gydq6tTYoI3K3lDer
	 9nWaOGAv/rWit2dT4Xo1tFkNRgDRAhrv4bPDhNdF8ntAK2J53etURMCQYizPMR8qT8
	 csdH8NFU/wPa+btDAlr2avZwcem3bXmBB9emaTc3kTfl3hguiSh2sKHSwXacic7jTn
	 bOhPZlS04R0XcFZhHDWHoCJFjWhPWZ0ZdF9RKoVtj5eXxkaiQqleEPrvT+iKR+DRfY
	 A+Lyy9rTz1X7Q==
Date: Fri, 7 Nov 2025 14:30:02 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <aQ30WmbN_O60vEzl@lore-desk>
References: <20250610-airoha-eth-lro-v1-1-3b128c407fd8@kernel.org>
 <CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfeGq5Zm6h9e=Q@mail.gmail.com>
 <aEg1lvstEFgiZST1@lore-rh-laptop>
 <20250611173626.54f2cf58@kernel.org>
 <aEtAZq8Th7nOdakk@lore-rh-laptop>
 <20250612155721.4bb76ab1@kernel.org>
 <aFATYATliil63D5R@lore-desk>
 <aQR2Z51Q45Zl99m_@lore-desk>
 <20251031111641.08471c44@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IjyweC8QavTyUWhR"
Content-Disposition: inline
In-Reply-To: <20251031111641.08471c44@kernel.org>


--IjyweC8QavTyUWhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 31 Oct 2025 09:42:15 +0100 Lorenzo Bianconi wrote:
> > > > Hm, truesize is the buffer size, right? If the driver allocated n b=
ytes
> > > > of memory for packets it sent up the stack, the truesizes of the sk=
bs
> > > > it generated must add up to approximately n bytes. =20
> > >=20
> > > With 'truesize' I am referring to the real data size contained in the=
 x-order
> > > page returned by the hw. If this size is small, I was thinking to jus=
t allocate
> > > a skb for it, copy the data from the x-order page into it and re-inse=
rt the
> > > x-order page into the page_pool running page_pool_put_full_page().
> > > Let me do some tests with order-2 page to see if the GRO can compensa=
te the
> > > reduced page size. =20
> >=20
> > Sorry for the late reply about this item.
> > I carried out some comparison tests between GRO-only and GRO+LRO with o=
rder-2
> > pages [0]. The system is using a 2.5Gbps link. The device is receiving =
a single TCP
> > stream. MTU is set to 1500B.
> >=20
> > - GRO only:			~1.6Gbps
> > - GRO+LRO (order-2 pages):	~2.1Gbps
> >=20
> > In both cases we can't reach the line-rate. Do you think the difference=
 can justify
> > the hw LRO support? Thanks in advance.
> > =20
> > [0] the hw LRO requires contiguous memory pages to work. I reduced the =
size to
> > order-2 from order-5 (original implementation).
>=20
> I think we're mostly advising about real world implications of=20
> the approach rather than nacking. I can't say for sure if potentially
> terrible skb->len/skb->truesize ratio will matter for a router
> application. Maybe not.
>=20
> BTW is the device doing header-data split or the LRO frame has headers
> and payload in a single buffer?

According to my understanding the hw LRO is limited to a single order-x page
containing both the headers and the payload (the hw LRO module is not capab=
le
of splitting the aggregated TCP segment over multiple pages).
What we could do is disable hw LRO by default and feed hw rx queues with
order-0 pages (current implementation). If the user enables hw LRO, we will
free order-0 pages linked to the rx DMA descriptors and allocate order-x pa=
ges
(e.g. order-2) for hw LRO queues. Disabling hw LRO will switch back to orde=
r-0
pages.

Regards,
Lorenzo

--IjyweC8QavTyUWhR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQ30WgAKCRA6cBh0uS2t
rGZOAP9M9uVRlJXXgPl6G+OORxGKlgdXBTOwtW4DApLOp26PCAEAl8At5F9pJxhs
BkRGi+/l6PhGdLpVmqI64CnAKZ+btwE=
=OyjG
-----END PGP SIGNATURE-----

--IjyweC8QavTyUWhR--

