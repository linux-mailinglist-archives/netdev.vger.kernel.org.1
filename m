Return-Path: <netdev+bounces-227238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D24BAAD68
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69EEB4E0608
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6478C19E81F;
	Tue, 30 Sep 2025 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygq4Hwhl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389534BA4D;
	Tue, 30 Sep 2025 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759194487; cv=none; b=kIG1TScYZO3SS8AJ0OXzGPnmTbf1EfncIWohHHZOg6/gEWT+Zch/cT/JTDBsgW9ZQclxNH9UvvZcNXy01EhmILhtvDQ9OEHj1RJsRUgE7egN6SGCbecaJdRJmh4HP9PcRzBti+XFCHjXdE57eIqgFouN+nCWkP0gI8ZDYK7NDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759194487; c=relaxed/simple;
	bh=bHK1Tz54e/Ifee6N7/zns9tcx8F25+FcDpSUAMb1Lb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKyopiUztm0IxPn8Cy1Z4A2FQzgK19VvZl9ymZNCl4SglLJBcqKI1fpJai0UqVz6y9D76eJfUm/a8vCEhbrgEjd2qM/AxvpoHwkzJlpjHePPEhOpqy+Y6p2Ht9n9smNaRbI/XaTRq2NKPY4GVUNMwuuenRu+e2RyuusD7Z0XpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ygq4Hwhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B454AC4CEF4;
	Tue, 30 Sep 2025 01:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759194486;
	bh=bHK1Tz54e/Ifee6N7/zns9tcx8F25+FcDpSUAMb1Lb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ygq4HwhlykpA5CGfYsyjzP8zgqMVS1ZAhFUon3xmKXRU21GqqzwTGl8bmgWxlYSVn
	 gLz5fQ2dKiM8rRY3F6CrfiVHbnQLvXNSKm+pVehSjR0t9jKqK369WJ/gm1ot3ksySY
	 klbd8NsjCGKEuZnC+cw3Wl1JhH7ojDg5LQeWB+l+XxZhg5O3hI1F7KPDfAcGn44OEP
	 dIMZCqONsnhGcxZMt/sBewGBBUeyEXXmj671Q52PF/DrUDQxPEVWTIsHvcqnGgdTXY
	 iE4z2qKM50gNJysR3PY01mzmDK5SsSvzbqLPo2TixLRvMsTRO6O2W8VRQo36GyIQZi
	 CWKrN4SfMGYjA==
Date: Mon, 29 Sep 2025 18:08:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Chen-Yu Tsai <wens@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH net-next v8 2/2] net: stmmac: Add support for Allwinner
 A523 GMAC200
Message-ID: <20250929180804.3bd18dd9@kernel.org>
In-Reply-To: <20250925191600.3306595-3-wens@kernel.org>
References: <20250925191600.3306595-1-wens@kernel.org>
	<20250925191600.3306595-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 03:15:59 +0800 Chen-Yu Tsai wrote:
> The Allwinner A523 SoC family has a second Ethernet controller, called
> the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
> numbering. This controller, according to BSP sources, is fully
> compatible with a slightly newer version of the Synopsys DWMAC core.
> The glue layer around the controller is the same as found around older
> DWMAC cores on Allwinner SoCs. The only slight difference is that since
> this is the second controller on the SoC, the register for the clock
> delay controls is at a different offset. Last, the integration includes
> a dedicated clock gate for the memory bus and the whole thing is put in
> a separately controllable power domain.

Hi Andrew, does this look good ?

thread: https://lore.kernel.org/20250925191600.3306595-3-wens@kernel.org

