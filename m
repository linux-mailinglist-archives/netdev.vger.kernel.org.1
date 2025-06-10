Return-Path: <netdev+bounces-196129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A830AAD39A0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31173A29C0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8952224AE1;
	Tue, 10 Jun 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMwjgDNq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482119CD0E
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562779; cv=none; b=pYKn/+oWD1X1cES1XLXFnIgaMuvw/KHBjKdE3nZsyw/1ALwDmk1NATNFJG3C43h+55FrP8JQq81ktYjzufX9/h/SWsnJauhTr3t9AVDMCTTYk2ZCTCEA0422ETDDRMZbIWXxKZ+N+iViviOUaVMD9hmXC56gmUdSfI+mks7Dsz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562779; c=relaxed/simple;
	bh=5avbO0Ao+zxHI6T3ghbReJ8vJ24StY6YPNICgLkqxcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd6JcSM4V6nCEFuR1DM4yIl+bYQAhYnZanKFVsF1aspk7Ur22ak/+QXb1TAbU04H1TPWEPoAREGBhmJp8vqklStFQf0kQOoWorctwJkcwMmWlzHgp42hnvEgT//aKLayLS7mnEJPArEJb+TER1jsqHNTYI3aPSUgb+nyevCTCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMwjgDNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98201C4CEED;
	Tue, 10 Jun 2025 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749562779;
	bh=5avbO0Ao+zxHI6T3ghbReJ8vJ24StY6YPNICgLkqxcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMwjgDNqWfSZV7W/JGiCqq0dEE/Ye+1kfAkZ4XV203t6F946jc0EF3npK/Q0wEoBc
	 HL3ts1Xs+3/PBc9SYwPFCnM2z+MUvlnvqBO1CV6oc8asYfAFiUzYoTylPqc7H7yohn
	 OzIYm+Tg5rTndx68BhsYHcdrKJ4seqHsBT6KkrgKQK6qpM8Lhv+lVrFkAL3iJu/r10
	 yqq+/QgT1qixROOTMkGFuHsEN6XhDY3/mIBul+to91IbppkSLTQLOBNFgRGGwEedBA
	 6RyXf6IeA24zeCsEByscH8ScHnys5UR72nWZesf6nZSo2pGx7we8ieg/YloSN2QFu4
	 BqHGpXGyuC9jw==
Date: Tue, 10 Jun 2025 15:39:34 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <aEg1lvstEFgiZST1@lore-rh-laptop>
References: <20250610-airoha-eth-lro-v1-1-3b128c407fd8@kernel.org>
 <CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfeGq5Zm6h9e=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I0VjOkFHRgh8EgMY"
Content-Disposition: inline
In-Reply-To: <CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfeGq5Zm6h9e=Q@mail.gmail.com>


--I0VjOkFHRgh8EgMY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 10, Eric Dumazet wrote:
> On Tue, Jun 10, 2025 at 2:12=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
> >
[...]
> > @@ -767,7 +887,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_=
queue *q,
> >         int qid =3D q - &qdma->q_rx[0], thr;
> >         dma_addr_t dma_addr;
> >
> > -       q->buf_size =3D PAGE_SIZE / 2;
> > +       q->buf_size =3D pp_params.max_len / (2 * (1 + lro_queue));
>=20
> Tell us more... It seems small LRO packets will consume a lot of
> space, incurring a small skb->len/skb->truesize ratio, and bad TCP WAN
> performance.

I think the main idea is forward to hw LRO queues (queues 24-31 in this
case) just specific protocols with mostly big packets but I completely
agree we have an issue for small packets. One possible approach would be
to define a threshold (e.g. 256B) and allocate a buffer or page from the
page allocator for small packets (something similar to what mt7601u driver
is doing[0]).  What do you think?

>=20
> And order-5 pages are unlikely to be available in the long run anyway.

I agree. I guess we can reduce the order to ~ 2 (something similar to
mtk_eth_soc hw LRO implementation [1]).

>=20
> LRO support would only make sense if the NIC is able to use multiple
> order-0 pages to store the payload.

The hw supports splitting big packets over multiple order-0 pages if we
increase the MTU over one page size, but according to my understanding
hw LRO requires contiguous memory to work.

Regards,
Lorenzo

[0] https://github.com/torvalds/linux/blob/master/drivers/net/wireless/medi=
atek/mt7601u/dma.c#L146
[1] https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/medi=
atek/mtk_eth_soc.c#L2258

--I0VjOkFHRgh8EgMY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaEg1kwAKCRA6cBh0uS2t
rAYMAQD0nBIhigRn4PPAvOPLw/L0LoFZ4JC7kFUvDHjLuDo7PAD+IXfceq+l1hbh
YjnyMxgeMGT9Hs0OOZbSoMd5kNU/Lwg=
=z/fk
-----END PGP SIGNATURE-----

--I0VjOkFHRgh8EgMY--

