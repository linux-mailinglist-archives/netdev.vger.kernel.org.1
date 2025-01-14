Return-Path: <netdev+bounces-158215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB33A1116C
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5761888DB6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3B209671;
	Tue, 14 Jan 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtatnGMV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B62066EA;
	Tue, 14 Jan 2025 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884073; cv=none; b=jzoaTJa520zYxE5OWlGylDglkr3JZOZoLoHLqER+/YPzdln7cTPkQ7SpcHxsnWV5TfpFg+NMn91OIIdi0veV94hYK97fH6UPA69qSesZwCYL1wk00595JOVDyice7XJR36hOfxEk0LyPdwOtpint3j8fXukRYPIK3nf9DFMeqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884073; c=relaxed/simple;
	bh=MsjZ4CtuKkX2wvVRKgcL8WTZmMPeHu69t0uOloOTQ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvcT/uh3mnPvudCTr4XEZqURecEIXWfPIJv3rL/3Za9y3/WrGu+Dq265mVXlTfli7SZga7tyeP3PkFNtLa0illzY7nVbWsTQm0BFGcr8oNx64DvMA4SfKGCogRBTOcdg/FmDCckUY5MUgFhQ3QH3949g/n9L1qcq2Vq/ukGyAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtatnGMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A4AC4CEDD;
	Tue, 14 Jan 2025 19:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736884072;
	bh=MsjZ4CtuKkX2wvVRKgcL8WTZmMPeHu69t0uOloOTQ6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JtatnGMVODyegv/CTTIokOQagjRF6w6iaxG6O0ua8VLQTR4ZpgyuEqZEu0xe3Ew7R
	 XOct0DKOBerowvncxq+a0fty+mcVyqO/HejCqHaQvy7giv86spFWMwFLkBMbcd/zfr
	 ukVkreewFK63XOx4UDQit2yNnJq7l2Z5qdMF4j4FkCpILjO5dUTPDh4wj4J7LgqbNO
	 0jMwQeXvQ0XQ5EseugH2/SOXz9+eW/SOAl7kx+RIZTmZtntGmOOwtXzEHjsgkV0RD2
	 kktQH1hq7k+zw1qEFcBWNnGTQ0SI4awG8yeFOtCgilK2Pbv6l8SMQZ9WntSPGZtn5I
	 qVe4jULPSKCDg==
Date: Tue, 14 Jan 2025 13:47:51 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: ethernet-controller: Add mac
 offset option
Message-ID: <20250114194751.GA1601275-robh@kernel.org>
References: <20241220-net-mac-nvmem-offset-v1-0-e9d1da2c1681@linaro.org>
 <20241220-net-mac-nvmem-offset-v1-1-e9d1da2c1681@linaro.org>
 <20241231133533.GA50130-robh@kernel.org>
 <CACRpkdbF9ezSg0qR=RwFpHJNf5P7i4cS+CmRkReNScKk5mxB0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbF9ezSg0qR=RwFpHJNf5P7i4cS+CmRkReNScKk5mxB0g@mail.gmail.com>

On Mon, Jan 13, 2025 at 03:59:24PM +0100, Linus Walleij wrote:
> On Tue, Dec 31, 2024 at 2:35 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Dec 20, 2024 at 08:17:06PM +0100, Linus Walleij wrote:
> 
> > > In practice (as found in the OpenWrt project) many devices
> > > with multiple ethernet interfaces just store a base MAC
> > > address in NVMEM and increase the lowermost byte with one for
> > > each interface, so as to occupy less NVMEM.
> > >
> > > Support this with a per-interface offset so we can encode
> > > this in a predictable way for each interface sharing the
> > > same NVMEM cell.
> >
> > This has come up several times before[1][2][3]. Based on those I know
> > this is not sufficient with the different variations of how MAC
> > addresses are shared. OTOH, I don't think a bunch of properties to deal
> > with all the possible transforms works either. It will be one of those
> > cases of properties added one-by-one where we end up with something
> > poorly designed. I think probably we want to just enumerate different
> > schemes and leave it to code to deal with each scheme.
> 
> The problem here is that the code needs some handle on which
> ethernet instance we are dealing with so the bindings need some
> way to pass that along from the consumer.
> 
> What about a third, implementation-defined nvmem cell?
> #mac-index-cells = <1>; or however we best deal with
> this.

We have #nvmem-cells-cells, doesn't that work?

> If it really is per-machine then maybe this is simply one of those
> cases where the kernel should:
> 
> if (IS_ENABLED(CONFIG_ARCH_FOO) &&
>    of_machine_is_compatible("foo,bar-machine)) {
>     // Read third cell if present
>     // Add to minor mac address
> }

Where would that go? I think it needs to be in the nvmem driver because 
that is what knows the format of the data and the transform needed.

> 
> > Or we could just say it is the bootloader's problem to figure this out
> > and populate the DT using the existing properties for MAC addresses.
> > Though bootloaders want to use DT too...
> 
> In my current case it's so fantastically organized that if the bootloader
> goes into TFTP boot it will use *another* unique MAC address.
> (Yes, it's fantastic.)

Fun.

Rob

