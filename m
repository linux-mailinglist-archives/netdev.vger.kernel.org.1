Return-Path: <netdev+bounces-142960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A099C0C9B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC2A2826AB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF05E216DE3;
	Thu,  7 Nov 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1ceALmO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B42161F3;
	Thu,  7 Nov 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999369; cv=none; b=p5xY0whQGmlWSGy22E45TTcD1jawQIyGlK/nrkSALpzJLImuLTjhl1hBzZKXGgipqt8ztjkwPZCFF4mEnZmF0rnWjsen9F6ZdrAr0TdO1NWfYA1VaDBab23EWBhRr02+V5dni9Ck4FkLpAvN0mJTSHZ3ApWJb8yqgMYmeA8fzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999369; c=relaxed/simple;
	bh=9f54dxIl3eMwRNQ9RNH0nhNpQ6mFCD7DUPK+U+I+s2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB5ItX5L7V23S3/X11N900WjspwUMig2NVYIniYFNVcHTkd6ScdQPzuAKCaUeoVNA7EEzmJa4HKtQWW7ia8a19PMX0WvwK9BidqLm3LYsFwjUAiJx5N0rHsc9ay0DSSy0pec1742QJH8pmozaHxeUjby/m+GbbQe7TqzqFyOvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1ceALmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243F8C4CECC;
	Thu,  7 Nov 2024 17:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730999369;
	bh=9f54dxIl3eMwRNQ9RNH0nhNpQ6mFCD7DUPK+U+I+s2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1ceALmOpXVDmMxRbzPEfjf44ktMb8IJIw5lCn4O2WlljA5gnCeFuqPvPRcu98S4V
	 6HAILwGAs7kg8T56TOAySl75Sp1LxU3tBT53AkwaWgpikEnuuALLIP2KJZJwpXv6W0
	 9Ghf5BuxO0K+n81/KZhb1PcxyiH6msIl3EWOog8mq1rYdc0o1rizGr+Kn5BdR+CKJh
	 +H11tCH5HBVLIDlDemnlhdooj3Z8xdwOlQJdtkPLI6fgPxN8/TSnVpBXbmdzifW4MQ
	 qAExp1IDuQTjDvnnukK3cn4UfHgedhjHz6g+pX4clyeJlf6w0mAtZu13eHXdULURBr
	 2TkK3rA5gn+Gw==
Date: Thu, 7 Nov 2024 17:09:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton
 MA35 family GMAC
Message-ID: <20241107-slip-graceful-767507d20d1b@spud>
References: <20241106111930.218825-1-a0987203069@gmail.com>
 <20241106111930.218825-2-a0987203069@gmail.com>
 <20241106-bloated-ranch-be94506d360c@spud>
 <7c2f6af3-5686-452a-8d8a-191899b3d225@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yB3ZUxT4SMqLRowR"
Content-Disposition: inline
In-Reply-To: <7c2f6af3-5686-452a-8d8a-191899b3d225@gmail.com>


--yB3ZUxT4SMqLRowR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 06:15:51PM +0800, Joey Lu wrote:
> Conor Dooley =E6=96=BC 11/6/2024 11:44 PM =E5=AF=AB=E9=81=93:
> > On Wed, Nov 06, 2024 at 07:19:28PM +0800, Joey Lu wrote:
> > > +  nuvoton,sys:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: phandle to access GCR (Global Control Register) reg=
isters.
> > Why do you need a phandle to this? You appear to have multiple dwmacs on
> > your device if the example is anything to go by, how come you don't need
> > to access different portions of this depending on which dwmac instance
> > you are?
> On our platform, a system register is required to specify the TX/RX clock
> path delay control, switch modes between RMII and RGMII, and configure ot=
her
> related settings.
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: stmmaceth
> > > +
> > > +  mac-id:
> > > +    maxItems: 1
> > > +    description:
> > > +      The interface of MAC.
> > A vendor prefix is required for custom properties, but I don't think you
> > need this and actually it is a bandaid for some other information you're
> > missing. Probably related to your nuvoton,sys property only being a
> > phandle with no arguments.
> This property will be removed.

I'm almost certain you can't just remove this property, because you need
it to tell which portion of the GCR is applicable to the dwmac instance
in question. Instead, you need to ad an argument to your phandle. The
starfive dwmac binding/driver has an example of what you can do.

--yB3ZUxT4SMqLRowR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyz0QgAKCRB4tDGHoIJi
0lP1AP97tmKwKt+UudFKraxNYO3cXznEar2+8w3QtbqK/bnqlwD9H1utLpv2RnF0
zj3DwLQ3RnwTIwDLuyIHy2v/2FNbawI=
=i7sq
-----END PGP SIGNATURE-----

--yB3ZUxT4SMqLRowR--

