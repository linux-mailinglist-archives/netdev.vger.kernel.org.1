Return-Path: <netdev+bounces-214984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C7B2C750
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78A41960347
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880DB2765C5;
	Tue, 19 Aug 2025 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kicv+klc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58646227EB9;
	Tue, 19 Aug 2025 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614536; cv=none; b=O8fnt7zCr1m9+1PYSp/hyJwCJggyfg+FtXMs7stqpmujHDdjQIHnKgAIfrrZug7ohaRK4I0zAEXRpB2TKHRhodGQ/5MS7LrWXXzlcU4XfYr9xWZBbEDjKUnsug79DAbOj5biTVQPhj/O8HPYkdAg1QcoaFWkUx38VK6YgBwiOT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614536; c=relaxed/simple;
	bh=cqwQADpES4py+UAccBwue5Qou0LgZbNLPNo27fvu4p0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZLrKt/dg1qhN6kX29TDBHhSakRWd9/X6izsAwtYtn9M2aEZisMeOQkJqJc4M0FnMwcAinWL+AH3FaeaZpWGYtDSH6zl+ixBN/B3IofJOzHxs0l7bVXf0FxdFHrZN9nOyP55oCWI0an18GnEPkPq1H48gsSfK2gYUctc/1Gk/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kicv+klc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC71C4CEF1;
	Tue, 19 Aug 2025 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755614536;
	bh=cqwQADpES4py+UAccBwue5Qou0LgZbNLPNo27fvu4p0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kicv+klc2cIfiXFaq2sWfwYPPMXQsWzdHFOAlFRIs5e3dbX95dkJ7kDUog6a62sOh
	 jPJwjboA5nDUPvI4at1SAw8OWQ+a9SvASNHzu5wg+9sBB56p/iyIhXs0rX87l+cozs
	 UmkXEwwGbg3p8q+o2yCwCztEeZolwoCccDFGHK4Sxzbd2q3Ng1BsOCTND2d9zqP/kc
	 cP7JvWhhOKDowMXIP0YJfXGW1kMYsFtJlFvulYGeabY4C7cMwViRgbzh1wTezFEd5g
	 2Z41X0WxNsA7oiNTqBtCB/gmEqWfbjW3evPvSoEFgj8Mzlx/YWCcYHGm2N5lfEY403
	 tGxAqddpzvM9A==
Date: Tue, 19 Aug 2025 07:42:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v18 5/7] net: mtip: Add mtip_switch_{rx|tx} functions
 to the L2 switch driver
Message-ID: <20250819074214.23d4332a@kernel.org>
In-Reply-To: <20250819103119.42a64541@wsk>
References: <20250813070755.1523898-1-lukasz.majewski@mailbox.org>
	<20250813070755.1523898-6-lukasz.majewski@mailbox.org>
	<20250815183359.352a0ecb@kernel.org>
	<20250819103119.42a64541@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Aug 2025 10:31:19 +0200 =C5=81ukasz Majewski wrote:
> > The rx buffer circulation is very odd. =20
>=20
> The fec_main.c uses page_pool_alloc_pages() to allocate RX page from
> the pool.
>=20
> At the RX function the __build_skb(data, ...) is called to create skb.
>=20
> Last step with the RX function is to call skb_mark_for_recycle(skb),
> which sets skb->pp_recycle =3D 1.
>=20
> And yes, in the MTIP I do copy the data to the newly created skb in RX
> function (anyway, I need to swap bytes in the buffer).=20
>=20
> It seems like extra copy is performed in the RX function.

Right, so the use of page pool is entirely pointless.
The strength of the page pool is recycling the pages.
If you don't free / allocate pages on the fast path you're=20
just paying the extra overhead (of having a populated cache)

> > Also you are releasing the page to be recycled without clearing it
> > from the ring. I think you'd free it again on shutdown, so it's a
> > double-free. =20
>=20
> No, the page is persistent. It will be removed when the driver is
> closed and memory for pages and descriptors is released.

So remove the page_pool_recycle_direct() call, please:

  static int mtip_switch_rx(struct net_device *dev, int budget, int *port)
	...
	skb =3D netdev_alloc_skb(pndev, pkt_len + NET_IP_ALIGN);
	if (unlikely(!skb)) {
			...
			page_pool_recycle_direct(fep->page_pool, page);

