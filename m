Return-Path: <netdev+bounces-208403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 896CAB0B4E0
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 12:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA06189A74D
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B281E1C02;
	Sun, 20 Jul 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnD/YkS2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C33BB48;
	Sun, 20 Jul 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753007052; cv=none; b=p/1YXZLvxGuOd/K4fcF0425/Pem2DO9xzgtt0FPuol3fHg+eZ5jiPsmMVKU2SFUD1unzDk4/colyFDRbTt0yZ3Zq05ri4By08dtDHQmfu9rotlDW7Ik9sNqOzceN+asJbTmUQ6k56TEIL75o/WXkJnMQ+VftLxRLtlyqklJvae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753007052; c=relaxed/simple;
	bh=fEK8sdabVsowQ2E2ZPuRMYsTVLmBwfbdw0hGZLDDrqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3N4r2jMWaQpp2izdH7N029SyI8N00r8lJdSmWAnedHRA9mDFdHV9pXyabkQHc+vpqhp8sDbt45Ga6S1nku92YcfJA1tW96YH6yls5ejem4QDpSfbFhSXk/5PUPqY8cjNWUFxtYdeoiQicOxrp3jrYgPApmq4jEYp2D0ZDYbuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnD/YkS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28EFC4CEE7;
	Sun, 20 Jul 2025 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753007052;
	bh=fEK8sdabVsowQ2E2ZPuRMYsTVLmBwfbdw0hGZLDDrqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnD/YkS2uJoBDU427/M2rDqYiMY5WRl9DIi0qfZwlnkFjC2+fgdR+68Si3tQOKH6w
	 7+9n9TQF2V4h7w/6Pmd1xK0rlHL28++EyUTn8Nf9NMI1ZPm/HWtlw2upqB6NS3P1vb
	 IACW8Wza4CJbORUxtSg5K+ejqoJefr5zsLJ2OVB6gAwlnOXuj7eTVGzJzqP589vQ0N
	 6DRC9QxiUZEo7yppwnriTlzRniPJLlP4IfeSonsp4mOzn3ZAiydftkRnzKtq+ExVI9
	 1nffHMqSZUDcCHYLDIA/Jo/zwHIcjZNynDHE4+ryTig2WVD2ttAclh5cdyU2X0QDxG
	 QWmGOwu3IQ7nA==
Date: Sun, 20 Jul 2025 11:24:06 +0100
From: Simon Horman <horms@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/7] net: dsa: microchip: Add KSZ8463 switch
 support to KSZ DSA driver
Message-ID: <20250720102406.GS2459@horms.kernel.org>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
 <20250719012106.257968-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719012106.257968-3-Tristram.Ha@microchip.com>

On Fri, Jul 18, 2025 at 06:21:01PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8463 switch is a 3-port switch based from KSZ8863.  Its major
> difference from other KSZ SPI switches is its register access is not a
> simple continual 8-bit transfer with automatic address increase but uses
> a byte-enable mechanism specifying 8-bit, 16-bit, or 32-bit access.  Its
> registers are also defined in 16-bit format because it shares a design
> with a MAC controller using 16-bit access.  As a result some common
> register accesses need to be re-arranged.  The 64-bit access used by
> other switches needs to be broken into 2 32-bit accesses.
> 
> This patch adds the basic structure for using KSZ8463.  It cannot use the
> same regmap table for other KSZ switches as it interprets the 16-bit
> value as little-endian and its SPI commands are different.
> 
> KSZ8463's internal PHYs use standard PHY register definitions so there is
> no need to remap things.  However, the hardware has a bug that the high
> word and low word of the PHY id are swapped.  In addition the port
> registers are arranged differently so KSZ8463 has its own mapping for
> port registers and PHY registers.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

...

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c

...

> +static inline u16 ksz8463_get_phy_addr(u16 phy, u16 reg, u16 offset)
> +{
> +	return offset + reg * 2 + phy * (P2MBCR - P1MBCR);
> +}

nit: Please do not use the inline keyword in .c files,
     unless there is a demonstrable (usually performance) reason to do so.
     Rather, let the compiler inline (or not) code as it sees fit.

...

