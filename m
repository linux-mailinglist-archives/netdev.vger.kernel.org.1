Return-Path: <netdev+bounces-226775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703C6BA5181
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122B2327675
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E3B28689A;
	Fri, 26 Sep 2025 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb8aoaVB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BCA28506D;
	Fri, 26 Sep 2025 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919258; cv=none; b=HLwH7qnYmSeApVLtlaSUVTPmfta0U/ikHY3J4/hSRem7X2Fgn6DCRpQ31AOVDm2InSY4biclT9erw5EFL6DBIDq1YX3HGojd6HJLvCBnt31NvfFxi0xosKvWb9kjqhJ7XA69iVAfYBCjw6jRRv74vaZSMnkOC3+QIDfD5E1wSKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919258; c=relaxed/simple;
	bh=TdFnS5IuKE3uwZ8a0wnKec7iCVl2zZ7Otv46KeGrOQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWSJVRnS/ke93s3q/25dUdbZnwNUkue4OX+5CRrO8EVCjiFhHfMqUVjHvKxzAJNC4ITn7U0jPXytLpM6tXnMmwXI2KvSrabCrHwyopQOIEORvek8TLyyK1LdSDEUaVIwuxSd9CRFveAV7tKIYLwcm6rD+82z2KUdd3TR08wUz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb8aoaVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DE6C4CEF4;
	Fri, 26 Sep 2025 20:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919257;
	bh=TdFnS5IuKE3uwZ8a0wnKec7iCVl2zZ7Otv46KeGrOQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kb8aoaVB9QOlSGQGdUW5WWJrs4RXWPB4cG9bO1YC8Sxb7zlSMI7Ov4SONYkO0Uomo
	 eDsnSgh24yXNuYDHWxet1F6C5I8RaMlBce6OTvOY0grv0v1J1L8MPXXqLgCQdcezCZ
	 i6WzmRZk7SbEHEp7rUEK1FYR3SSLmVL/z9vy/sRIV4950D5gzWdFOql+Wf13JDrcGY
	 bkEXzE6i3oEDon3TTEUcGSxp4htzX5DXqbys+KNHk34DzszpUg5q1C5iIFOih/evq8
	 PvdkS3FLYcEbhd60ZDmQEcTJzssQAXhWVAP6XyWWbTH0BfVnbT9JfS9HnbWPsPYqrJ
	 Fzy4GW7M7PuVg==
Date: Fri, 26 Sep 2025 13:40:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, "Harini Katakam"
 <harini.katakam@xilinx.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Sean Anderson" <sean.anderson@linux.dev>
Subject: Re: [PATCH net v6 0/5] net: macb: various fixes
Message-ID: <20250926134056.383c57a2@kernel.org>
In-Reply-To: <DD2KKUEVR7P1.TFVYX7PES9FS@bootlin.com>
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
	<DD2KKUEVR7P1.TFVYX7PES9FS@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Sep 2025 09:56:25 +0200 Th=C3=A9o Lebrun wrote:
> On Tue Sep 23, 2025 at 6:00 PM CEST, Th=C3=A9o Lebrun wrote:
> > This would have been a RESEND if it wasn't for that oneline RCT fix.
> > Rebased and tested on the latest net/main as well, still working fine
> > on EyeQ5 hardware.
> >
> > Fix a few disparate topics in MACB:
> >
> > [PATCH net v6 1/5] dt-bindings: net: cdns,macb: allow tsu_clk without t=
x_clk
> > [PATCH net v6 2/5] net: macb: remove illusion about TBQPH/RBQPH being p=
er-queue
> > [PATCH net v6 3/5] net: macb: move ring size computation to functions
> > [PATCH net v6 4/5] net: macb: single dma_alloc_coherent() for DMA descr=
iptors
> > [PATCH net v6 5/5] net: macb: avoid dealing with endianness in macb_set=
_hwaddr() =20
>=20
> What's the state of maintainers minds for this series? It has been
> stable for some time, tested on sam9x75 (by Nicolas Ferre) & EyeQ5
> and Simon Horman has added his reviewed-by this morning (thanks!).
> But of course I am biased.

We'll get to it.. having the revisions a few days apart rather than=20
a few weeks apart helps maintainers remember the details, and generally
leads to lower wait times. FWIW.

> I am asking because merging would benefit my pending series.

Sorry, if the merge window opens on Sunday there's no chance of
making progress on your pending series.

