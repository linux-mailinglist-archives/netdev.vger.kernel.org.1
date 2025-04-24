Return-Path: <netdev+bounces-185582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8382CA9AFFD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E871D1B61AE8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F8754F81;
	Thu, 24 Apr 2025 14:00:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471531F5E6;
	Thu, 24 Apr 2025 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503244; cv=none; b=bSO11JMR2ULdGiTkV4qDJurS/w11LKFzBw85jY8//kf5gASLTkekd55OXJDWDov7UY6ftcQbISX8hErK3RWeRojGdXXIlT1bwHOXeAAMTlXwZ/RBuWObdDlrJaDvjEpnZ/4tSwguBzdC9ASGUdVKugypQ2fQ4olmRgl6ZhVeJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503244; c=relaxed/simple;
	bh=VXBgvoZTtrA5JYDFoyhknIVGp8ZSKhzEYnqrJP640i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHFdg9VH4MVpcjDq5aqtyhE3pM4yLNiLZUmTEANpbHblp9o5XZF9y6MhsCE5mypQGrAeRC11UHwfaX5Q0BaE4mMaZpsEz01TjxkFYb7NX5q3nkknqbkOk0qC0DXwlQ39ArRWkUIQvt1QixbSud+R1fazinOEfQaBSiHrvC3yL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FFAC1063;
	Thu, 24 Apr 2025 07:00:37 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C995C3F66E;
	Thu, 24 Apr 2025 07:00:39 -0700 (PDT)
Date: Thu, 24 Apr 2025 15:00:37 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <20250424150037.0f09a867@donnerap.manchester.arm.com>
In-Reply-To: <4ba3e7b8-e680-40fa-b159-5146a16a9415@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
	<20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
	<aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
	<20250424014120.0d66bd85@minigeek.lan>
	<835b58a3-82a0-489e-a80f-dcbdb70f6f8d@lunn.ch>
	<20250424134104.18031a70@donnerap.manchester.arm.com>
	<4ba3e7b8-e680-40fa-b159-5146a16a9415@lunn.ch>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 14:57:27 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

Hi Andrew,

> > > Just to be clear, you tried it with "rgmii-id" and the same <300> and
> > > <400> values?  
> > 
> > Yes, sorry, I wasn't clear: I used rgmii-id, then experimented with those
> > values.  
> 
> O.K, great.
> 
> I do suspect the delays are not actually in pico seconds. But without
> a data sheet, it is hard to know.
> 
>        if (!of_property_read_u32(node, "allwinner,rx-delay-ps", &val)) {
>                 if (val % 100) {
>                         dev_err(dev, "rx-delay must be a multiple of 100\n");
>                         return -EINVAL;
>                 }
>                 val /= 100;
>                 dev_dbg(dev, "set rx-delay to %x\n", val);
>                 if (val <= gmac->variant->rx_delay_max) {
>                         reg &= ~(gmac->variant->rx_delay_max <<
>                                  SYSCON_ERXDC_SHIFT);
>                         reg |= (val << SYSCON_ERXDC_SHIFT);
> 
> So the code divides by 100 and writes it to a register. But:
> 
> static const struct emac_variant emac_variant_h3 = {
>         .rx_delay_max = 31,
> 
> 
> static const struct emac_variant emac_variant_r40 = {
>         .rx_delay_max = 7,
> };
> 
> With the change from 7 to 31, did the range get extended by a factor
> of 4, or did the step go down by a factor of 4, and the / 100 should
> be / 25? I suppose the git history might have the answer in the commit
> message, but i'm too lazy to go look.

IIRC this picosecond mapping was somewhat made up, to match common DT
properties. The manual just says:
====================
12:10  R/W  default: 0x0 ETXDC: Configure EMAC Transmit Clock Delay Chain.
====================

So the unit is really unknown, but is probably some kind of internal cycle count.
The change from 7 to 31 is purely because the bitfield grew from 3 to 5
bits. We don't know if the underlying unit changed on the way.
Those values are just copied from whatever the board vendor came up with,
we then multiply them by 100 and put them in the mainline DT. Welcome to
the world of Allwinner ;-)

And git history doesn't help, it's all already in the first commit for this
driver. I remember some discussions on the mailing list, almost 10 years
ago, but this requires even more digging ...

Cheers,
Andre



> 
> I briefly tried "rgmii", and I couldn't get a lease, so I quite
> > confident it's rgmii-id, as you said. The vendor DTs just use "rgmii", but
> > they might hack the delay up another way (and I cannot be asked to look at
> > that awful code).
> > 
> > Cheers,
> > Andre  


