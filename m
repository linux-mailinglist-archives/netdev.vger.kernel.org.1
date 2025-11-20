Return-Path: <netdev+bounces-240486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521CC75703
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D14594E9633
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6F30BB8F;
	Thu, 20 Nov 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAj9QzVW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3AE27EFFA;
	Thu, 20 Nov 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656569; cv=none; b=Dgx8VhxApl+pEXJQa1yvu5N0TW2h8m8BLFo2Lq1XQlZH/orCjwFGzpzXx3fztdNq5r1IwSXsR3JgiAvdWhZd86JtdUNDn1l/koITQ55NbPDQ4zxbbPI2jeho4GBkWVtCq1rNCCBKHCMXyUTV81VuJYqULsNwptFMzZlPZpj+URg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656569; c=relaxed/simple;
	bh=YRYt8ETs3OYqxLgqPPbGFfPhfdf9q3Lnly9EjVX5qnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaUbhL90PbcXBz8puWVz9UtiETKJrePn6Ov+Ct5XX691frTIYnjHcSUCXOn/7NMLxDoqiq/p/3z3otCGZKYLgq7S2GXnkdpTxTKypySeCXZti5OiPofVvqdJvkK8XsvWoqkG2cLy0869InOFCTJtukw62VQG+Qwvtxt/mLf2kI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAj9QzVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69F4C4CEF1;
	Thu, 20 Nov 2025 16:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763656569;
	bh=YRYt8ETs3OYqxLgqPPbGFfPhfdf9q3Lnly9EjVX5qnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAj9QzVWaF2gAEZNWSn0uLbOziYnGWGHoIbaaJjQEZV0JUjy6ysEfN2BxjH4SlTUm
	 th02uRBJomrN93ktge86ANyo4jo7Nd20QcfcMDjvELE3ToplB99ZBDEJGwCwTzlL5W
	 FF7GdktUlqOwQ3XcrL/vzTOFni3L5oj3zh1HPkKKOu7ZxbCGV9icy9Z4LUb8URcCCF
	 B+Op1/ZJSdEbWhy4jOO+L87GNObfBpYFXY9iJjaYKNMGJgDC/IzdQstB1FkTOTU2C8
	 UzqPHvhyH4ozASOxuplgDOXNqXapFQlzSEm9KwN/TkqWhGcw7/Po4PrnR0OOkk+Po4
	 kdmAK/SEUohHQ==
Date: Thu, 20 Nov 2025 16:36:03 +0000
From: Lee Jones <lee@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/15] net: dsa: sja1105: transition OF-based
 MDIO drivers to standalone
Message-ID: <20251120163603.GK661940@google.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-9-vladimir.oltean@nxp.com>
 <20251120144046.GE661940@google.com>
 <20251120151458.e5syoeay45fuajlt@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120151458.e5syoeay45fuajlt@skbuf>

On Thu, 20 Nov 2025, Vladimir Oltean wrote:

> Hi Lee,
> 
> Thank you for commenting on the patch!
> 
> On Thu, Nov 20, 2025 at 02:40:46PM +0000, Lee Jones wrote:
> > The MFD API is not to be {ab}used out side of drivers/mfd.
> 
> If mfd_add_devices() is not to be used outside of drivers/mfd, why
> export it to the global include/linux/mfd/core.h in the first place,
> rather than make the header available just to drivers/mfd?

That's a good question.

mfd_add_devices() has been exported since its inception nearly 20 years
ago.  But it wasn't {ab}used outside of the subsystem until 2011 when it
somehow found its way into the NVEC Staging driver and then into some
IIO driver in 2015, etc.  Since then other 8 instances have slipped
through the gaps without me noticing.  I'd love to remove the global
export, but something would need to be done about those 10 occurrences
before hand and I just don't have the time to invest in that right now.

> > Maybe of_platform_populate() will scratch your itch instead.
> 
> I did already explore of_platform_populate() on this thread which asked
> for advice (to which you were also copied):
> https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/
> 
>     It looks like of_platform_populate() would be an alternative option for
>     this task, but that doesn't live up to the task either. It will assume
>     that the addresses of the SoC children are in the CPU's address space
>     (IORESOURCE_MEM), and attempt to translate them. It simply doesn't have
>     the concept of IORESOURCE_REG. The MFD drivers which call
>     of_platform_populate() (simple-mfd-i2c.c) simply don't have unit
>     addresses for their children, and this is why address translation isn't
>     a problem for them.
> 
> I'm not trying to start an argument, but as you can see, I've been stuck
> on this problem for years, and I'm between a rock and a hard place.

I get that.  Equally, I'm not trying to be suborn, but those are the
rule's I've been attempting to stick to for the last decade and a bit to
prevent (minor) chaos.

The canonical answer goes 3 ways: If you want to use the MFD API, move
the handling to drivers/mfd.  If it's possible, use one of the
predetermined helpers like of_platform_populate() (and I think we
authored another one that worked around some of its issues, but I forget
where we put it!).  Or if all else fails, you have to register the
device the old fashioned way with the platform_device_*() API.

-- 
Lee Jones [李琼斯]

