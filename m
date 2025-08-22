Return-Path: <netdev+bounces-215854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E22B30A6F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5661B1CC0378
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 00:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8954D8CE;
	Fri, 22 Aug 2025 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msvGCuMX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E80322E;
	Fri, 22 Aug 2025 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822982; cv=none; b=W8WlEHoCm0j9U3JiGvx4EegT3RbE3Y9o11x6+m64hlaDGaRMIB2cz66z0UrkhEmpMA9DvHaIfDR3hklyXEZ/3e/FzuWJ90mrl+sXifvOzLKTNhcum4doG/WYpvL3RbhyjCum7XtYEuFBM6to82Tk8u9U0PDN3DdJfyKpA+zu2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822982; c=relaxed/simple;
	bh=phIRh9Mt3+S/rwTUKbjev/Q6p8ulUBAJlUSelhRf/sY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1zVJh+UwDugIBco6imjFSwzZ6+lwhflnhUOg5LGARc6IC6M4Axh6GYDoF+rkqFLWPaitx2QJeQ5NtZe12h51SuW1JaGHyDXO9vDXBAxlq8xFApfKIl5UIwzUNuyjaIJWF1XLGi7RTX7tf4k3f9EZWVUbT7Wj039X4BccQXMa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msvGCuMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEC6C4CEEB;
	Fri, 22 Aug 2025 00:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755822981;
	bh=phIRh9Mt3+S/rwTUKbjev/Q6p8ulUBAJlUSelhRf/sY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=msvGCuMXFqCfoXk6IWjuAsPbROe5Y/mf5f6gJv2ixGlCSubOJQW+zcAkplMTsGeQt
	 yGN05AV/59CDwsAun7JH8HY1bJ0Q/1kSqTpx1eBInHVl90GBltxwTo9C/5HNZtikvB
	 kn7G5SNlNmWIPZqOxOlYaqjmhgNJb9G/dR7+vpa8jZPbB6EpKIPl4EkmJ6Uzz/W4j1
	 9lIBeoJhgd+1LFg15Zdhm14uIBHb6c2uDDsuIyDpT+VyTMRghboLVdLHiOZV7MFHV8
	 /Ehrl233plJDckMBICdTNN+nH+uwjJmXDZ5Qmr3n810Ey2kxltkvQi904cPBlcxLaQ
	 WHKHh0Eb7+Npg==
Date: Thu, 21 Aug 2025 17:36:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Xu Liang <lxu@maxlinear.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: phy: mxl-86110: add basic support
 for led_brightness_set op
Message-ID: <20250821173620.367ce05c@kernel.org>
In-Reply-To: <aKXOzyAg728qcylz@pidgin.makrotopia.org>
References: <a63f1487c3d36fc150fa3a920cd3ab19feb9b9f9.1755691622.git.daniel@makrotopia.org>
	<73c364ee-2712-4b95-a05b-886c3e4c4e15@lunn.ch>
	<aKXOzyAg728qcylz@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 14:34:07 +0100 Daniel Golle wrote:
> > > +	if (index >= MXL86110_MAX_LEDS)
> > > +		return -EINVAL;
> > > +
> > > +	/* force manual control */
> > > +	set = MXL86110_COM_EXT_LED_GEN_CFG_LFE(index);
> > > +	/* clear previous force mode */
> > > +	mask = MXL86110_COM_EXT_LED_GEN_CFG_LFM(index);
> > > +
> > > +	/* force LED to be permanently on */
> > > +	if (value != LED_OFF)
> > > +		set |= MXL86110_COM_EXT_LED_GEN_CFG_LFME(index);  
> > 
> > That is particularly complex. We know index is a u8, so why not
> > GENMASK_U8(1 + 3 * index, 3 * index)? But set is a u16, so
> > GENMASK_U16() would also be valid.  
> 
> I chose this construct to avoid reusing the macro parameter as gcc would
> rightously complain about that potentially having unexpected side-effects.
> 
> Eg.
> 
> #define FOO(a) ((a)+(a))
> 
> Now with var=10, when calling FOO(var++) the result will be 21 and
> var will be equal to 12, which isn't intuitive without seeing the
> macro definition.
> 
> Also using GENMASK_TYPE would not avoid the problem of macro
> parameter reuse.
> 
> However, I agree that the macro itself is also weirdly complex and
> confusing (but at the same time also very common, a quick grep reveals
> hundreds of occurances of that pattern in Linux sources), so maybe we
> should introduce some generic helpers for this (quite common) use-case?
> I can do that, but I certainly can't take care of migrating all the
> existing uses of this pattern to switch to the new helper.

IMHO this is one of the cases where the code would be far clearer
without he macros..

#define MXL86110_COM_EXT_LED_GEN_CFG			0xA00B
# define MXL86110_COM_EXT_LED_GEN_CFG_LFME(x)		(1 << (3 * (x)))
# define MXL86110_COM_EXT_LED_GEN_CFG_LFE(x)		(2 << (3 * (x)))
# define MXL86110_COM_EXT_LED_GEN_CFG_MASK(x)		(3 << (3 * (x)))

Right?

