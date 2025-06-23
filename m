Return-Path: <netdev+bounces-200437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F37C4AE5826
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B4547AAFBE
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BA5226D1D;
	Mon, 23 Jun 2025 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaE4FWW8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471EE1AD3FA;
	Mon, 23 Jun 2025 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722556; cv=none; b=cArkgrK3jqUr8kOp6SBTMDCorWZF848VHvhMF6AuOW26j8GoHjExr26tzR6dw+5waWPEURM0QjDC2MD6f0+GLD26DV22DxKk2wXl6Rmt4cnlHhneSFD3Njr1hdu2oX68PkEvsHKu43k32jZ9kU/g0nc3yxf/bgb8LV7NLrd6AR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722556; c=relaxed/simple;
	bh=5zjktm3bvgS8F32IewejBkzrMzWz2OzlZ2/SPTwAo2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7eUB5dk/GXCnhvTHBop7vNXs9/SPIhemKACa9Umhp4Legq7aqdc4ENr8RYHnTo7QAo9M3SPv7d2j4lKJrzqvq9gcQjrCMFHyooeupoRgzNQMVXAUzLW6ldSB8afKpWVpo0mCwPeoEC6uPtgxJVTb9+mzE882JdE36m8UOtjRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaE4FWW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429CEC4CEEA;
	Mon, 23 Jun 2025 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750722554;
	bh=5zjktm3bvgS8F32IewejBkzrMzWz2OzlZ2/SPTwAo2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WaE4FWW8lym7mVGZ9H6p/bRfhAc72NL/jCKb0eIhPocmVuUsign6EGcu4mUj6Xj0K
	 rX0brAiOwrxV2hcUEbkv3C7xVsEbD8bvjjvHLol43dqE/fi9TJsoxbkH7Qo+QUaT8F
	 F5mSwgN0fOZWgV+fo8Pk+G4S58n1r/P3ksWK5uwGzxHclWPhLDVCWfPxXiSwm82xgI
	 EhnfJPOPulffCsg+VRoSFHlebaGOaCnHu17Bb6MyqqiIFhEU0qbnmzH1w54+kfoFhw
	 sxo4g9yN6ZKZJRHnNryCe7Hl0MhHUfuEXNFpqx10woDSGA1eOMpJx1hO0C71GlV9Kz
	 aJm7fw4AmHLMQ==
Date: Mon, 23 Jun 2025 16:49:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
 <woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Russell
 King <rmk+kernel@armlinux.org.uk>, Thangaraj Samynathan
 <Thangaraj.S@microchip.com>, Rengarajan Sundararajan
 <Rengarajan.S@microchip.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v1 1/1] net: usb: lan78xx: annotate checksum
 assignment to silence sparse warnings
Message-ID: <20250623164913.474be2b3@kernel.org>
In-Reply-To: <20250620084618.1857662-1-o.rempel@pengutronix.de>
References: <20250620084618.1857662-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 10:46:18 +0200 Oleksij Rempel wrote:
> -		skb->csum = ntohs((u16)(rx_cmd_b >> RX_CMD_B_CSUM_SHIFT_));
> +		__be16 csum_raw;
> +
> +		csum_raw = (__force __be16)(rx_cmd_b >> RX_CMD_B_CSUM_SHIFT_);
> +		skb->csum = (__force __wsum)ntohs(csum_raw);

You can avoid the __force __be16 if you switch the variable to be u16
and then htons instead of ntohs
-- 
pw-bot: cr

