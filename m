Return-Path: <netdev+bounces-222342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F613B53F1D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B59687B515B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A230126B942;
	Thu, 11 Sep 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lujBudA5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8F2DC77F;
	Thu, 11 Sep 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757633994; cv=none; b=R3cex9Tpz+BCN2X4XwMmiA5gg3l/zhThAu7GPXNZyhcQmcxFKN80MOsb5QL5fGzVKEkrlwZARdpk2i2eoYokQfOOu8dA8NtQ2Pz1Qg1799jpyUneL9rfHeY9RS+xqjSrp8Z9LsbfQzFj6rV0kwOrLnedlKNJ/pWWUlLEEf6wM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757633994; c=relaxed/simple;
	bh=QgoknCooODVZDsLdwBBv5hUTRch16VwsBQrZi8gmPXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrEUySU1rHSz4JIhA5gTTCNZNZRoFDRi7KFJ74O57D1ITsoS+4P1fm4gy3rj05Bp8YsJRra3B+dSRGAv+Ym3oAqQML+StB/gyg/A8kC7Fl778EJpE+3oLTw7gVQvoE7lSEkKzDFzuC2PQH8EZ7d7tD3NCy0LsscYlApawQCVLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lujBudA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA85C4CEF0;
	Thu, 11 Sep 2025 23:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757633993;
	bh=QgoknCooODVZDsLdwBBv5hUTRch16VwsBQrZi8gmPXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lujBudA5KBuwzJWLr8MW7rP4CB9I/5IgQ+HN+cnfp4j+2NJztsysky5XUYm1Il3SY
	 QX6UVYqohEhCu4uh7633vFng88pyMilvG3UuKS+qnikmvQQbXMQSiyyDGb6zvZE5e2
	 1mVVFs/rbpjAH1N4vpdy5o7RN7ISBTfmuvz+aOoNfdH/kmTEBQLAYxpChbpbo2l4VW
	 oXFfStfceSjsMJJip9f/T+bIpUDAF7HKEt8lrpUf/WR8mu8khI66FcJpBk1MSO2UbV
	 OPJq58qKxjqxU/9hefpDoGc5yjg5EsP8RVhpVGtR6ciWi8gxskzN+rtC5W4OuR52La
	 HGpj1VVwKkp9Q==
Date: Thu, 11 Sep 2025 16:39:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Karumanchi, Vineeth" <vineeth@amd.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, "Harini Katakam"
 <harini.katakam@xilinx.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH net v5 3/5] net: macb: move ring size computation to
 functions
Message-ID: <20250911163952.1e61c6cb@kernel.org>
In-Reply-To: <DCPUUQHYSZGE.WH37VP8WHJ8E@bootlin.com>
References: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
	<20250910-macb-fixes-v5-3-f413a3601ce4@bootlin.com>
	<ba25cca0-adbf-435b-8c21-f03c567045b1@amd.com>
	<DCPUUQHYSZGE.WH37VP8WHJ8E@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2025 11:14:52 +0200 Th=C3=A9o Lebrun wrote:
> > it would be good to have these functions as inline.
> > May be as a separate patch. =20
>=20
> I don't see why? Compilers are clever pieces, they'll know to inline it.
>=20
> If we added inline to macb_{tx,rx}_ring_size_per_queue(), should we also
> add it to macb_dma_desc_get_size()? I do not know, but my compiler
> decided to inline it as well. It might make other decisions on other
> platforms.
>=20
> Last point I see: those two functions are not called in the hotpath,
> only at alloc & free. If we talk about inline for the theoretical speed
> gain, then it doesn't matter in that case. If it is a code size aspect,
> then once again the compiler is more aware than myself.
>=20
> I don't like the tone, but it is part of the kernel doc and is on topic:
> https://www.kernel.org/doc/html/latest/process/coding-style.html#the-inli=
ne-disease

=F0=9F=91=8D=EF=B8=8F FWIW, please don't sprinkle inlines.

