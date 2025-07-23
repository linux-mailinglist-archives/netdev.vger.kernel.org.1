Return-Path: <netdev+bounces-209400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 001E2B0F7FE
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F336596618B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861F5149C41;
	Wed, 23 Jul 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOdbMFOA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1632E36F0;
	Wed, 23 Jul 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287723; cv=none; b=XNPuoHYV3eGJxL0ZI3l0D7zWUvamhqhlkJ2uJ/Y6Tt+6wgrZolAwweno+t/BKgRSgcQ/pkau2BsS757n6N8H9W0NkDkDfyRvw6vjG3u0QUu0X9h0TxcjncFUkXeL9kmrrEpiXq6aQbgR3s6rMxg90UD1gVqyItjslkfh8TG/hz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287723; c=relaxed/simple;
	bh=bfdY0aVwf47XiE8ZVRejqu5I4YU16Lsl9rpzoYPP11c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+YXnYYGnQ4/gK8VZW8s2L0XO3YIrWTrdotlyouMFNgHYdwh9o4XLMy54gOsP8+cK3eac9UuKbZiw0qfaEHiW4j9rbtA14u7Sh5Z3r54FpLA9tJ0JkAgxRTmmvL4zOLbjHRCTllTskr8GUHxn0nua9FOnx+ds21NQ3wKH1+bz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOdbMFOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275CFC4CEE7;
	Wed, 23 Jul 2025 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753287723;
	bh=bfdY0aVwf47XiE8ZVRejqu5I4YU16Lsl9rpzoYPP11c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOdbMFOAjPrHkyem2K8fAg4ZfGJz3RKc/Z0QsmW/z4vMpJR7kLa+Sjp9YkYnQ1TyL
	 SYta3l8yt27PDDMo+q4zdNtj9hznvhgftwL3aRclTUlvEgBLA/FE+Vn0Wpw/S9lYpn
	 MjUtb67pSB/tKwjdYknGLY3A2FkllPFKhbbgsnbI7BvHQoFKOKFq/eMosuRXRIxpRS
	 hrta77jYY+pWUZb/ov6u4nXI8w0yJGjZggBMCSgiSQJYvUp34ZaYVgjgFDhC5Qz9MW
	 etKJrZNC5Cd3g94Joam/OU9eewkUnfrimPINAx6ftuV/XPESxCw66L5tyKoUJqfJR5
	 R9ar/yGtFlFCw==
Date: Wed, 23 Jul 2025 17:21:58 +0100
From: Simon Horman <horms@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	marex@denx.de, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/7] net: dsa: microchip: Use different
 registers for KSZ8463
Message-ID: <20250723162158.GJ1036606@horms.kernel.org>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
 <20250719012106.257968-5-Tristram.Ha@microchip.com>
 <20250720101703.GQ2459@horms.kernel.org>
 <20250720102224.GR2459@horms.kernel.org>
 <DM3PR11MB873641FBBF2A79E787F13877EC5FA@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB873641FBBF2A79E787F13877EC5FA@DM3PR11MB8736.namprd11.prod.outlook.com>

On Wed, Jul 23, 2025 at 02:25:27AM +0000, Tristram.Ha@microchip.com wrote:
> > On Sun, Jul 20, 2025 at 11:17:03AM +0100, Simon Horman wrote:
> > > On Fri, Jul 18, 2025 at 06:21:03PM -0700, Tristram.Ha@microchip.com wrote:
> > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > >
> > > > KSZ8463 does not use same set of registers as KSZ8863 so it is necessary
> > > > to change some registers when using KSZ8463.
> > > >
> > > > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > > > ---
> > > > v3
> > > > - Replace cpu_to_be16() with swab16() to avoid compiler warning
> > >
> > > ...
> > >
> > > > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > b/drivers/net/dsa/microchip/ksz_common.c
> > >
> > > ...
> > >
> > > > @@ -2980,10 +2981,15 @@ static int ksz_setup(struct dsa_switch *ds)
> > > >     }
> > > >
> > > >     /* set broadcast storm protection 10% rate */
> > > > -   regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
> > > > -                      BROADCAST_STORM_RATE,
> > > > -                      (BROADCAST_STORM_VALUE *
> > > > -                      BROADCAST_STORM_PROT_RATE) / 100);
> > > > +   storm_mask = BROADCAST_STORM_RATE;
> > > > +   storm_rate = (BROADCAST_STORM_VALUE *
> > BROADCAST_STORM_PROT_RATE) / 100;
> > > > +   if (ksz_is_ksz8463(dev)) {
> > > > +           storm_mask = swab16(storm_mask);
> > > > +           storm_rate = swab16(storm_rate);
> > > > +   }
> > > > +   regmap_update_bits(ksz_regmap_16(dev),
> > > > +                      reg16(dev, regs[S_BROADCAST_CTRL]),
> > > > +                      storm_mask, storm_rate);
> > >
> > > Hi Tristram,
> > >
> > > I am confused by the use of swab16() here.
> > >
> > > Let us say that we are running on a little endian host (likely).
> > > Then the effect of this is to pass big endian values to regmap_update_bits().
> > >
> > > But if we are running on a big endian host, the opposite will be true:
> > > little endian values will be passed to regmap_update_bits().
> > >
> > >
> > > Looking at KSZ_REGMAP_ENTRY() I see:
> > >
> > > #define KSZ_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)         \
> > >         {                                                               \
> > >               ...
> > >                 .reg_format_endian = REGMAP_ENDIAN_BIG,                 \
> > >                 .val_format_endian = REGMAP_ENDIAN_BIG                  \
> > >         }
> > 
> > Update; I now see this in another patch of the series:
> > 
> > +#define KSZ8463_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)    \
> > +       {                                                               \
> >                 ...
> > +               .reg_format_endian = REGMAP_ENDIAN_BIG,                 \
> > +               .val_format_endian = REGMAP_ENDIAN_LITTLE               \
> > +       }
> > 
> > Which I understand to mean that the hardware is expecting little endian
> > values. But still, my concerns raised in my previous email of this
> > thread remain.
> > 
> > And I have a question: does this chip use little endian register values
> > whereas other chips used big endian register values?
> > 
> > >
> > > Which based on a skimming the regmap code implies to me that
> > > regmap_update_bits() should be passed host byte order values
> > > which regmap will convert to big endian when writing out
> > > these values.
> > >
> > > It is unclear to me why changing the byte order of storm_mask
> > > and storm_rate is needed here. But it does seem clear that
> > > it will lead to inconsistent results on big endian and little
> > > endian hosts.
> 
> The broadcast storm value 0x7ff is stored in registers 6 and 7 in KSZ8863
> where register 6 holds the 0x7 part while register 7 holds the 0xff part.
> In KSZ8463 register 6 is defined as 16-bit where the 0x7 part is held in
> lower byte and the 0xff part is held in higher byte.  It is necessary to
> swap the bytes when the value is passed to the 16-bit write function.

Perhaps naively, I would have expected

	.val_format_endian = REGMAP_ENDIAN_LITTLE

to handle writing the 16-bit value 0x7ff such that 0x7 is in
the lower byte, while 0xff is in the upper byte. Is that not the case?

If not, do you get the desired result by removing the swab16() calls
and using

	.val_format_endian = REGMAP_ENDIAN_BIG

But perhaps I misunderstand how .val_format_endian works.

> 
> All other KSZ switches use 8-bit access with automatic address increase
> so a write to register 0 with value 0x12345678 means 0=0x12, 1=0x34,
> 2=0x56, and 3=0x78.
> 

