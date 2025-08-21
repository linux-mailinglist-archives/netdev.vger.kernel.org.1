Return-Path: <netdev+bounces-215605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B718B2F7C3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCB8602B31
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636DA2E174C;
	Thu, 21 Aug 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qcmDpjoA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F4258CDC;
	Thu, 21 Aug 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778825; cv=none; b=NE8f9y+cDQfAOtt6A+GMWl5umIusIC8hGba6jGT85mzZEjSfTVh2ZaxBLT+yRE36nfXWpO1pmm6q4ng5ZSVs5CeRMIuy6ur9jMaNswVQ3AYDOIl4BgEQxbH1RYTfxb5EGbfbGxDlx2TAFBzzHQNUkSxRakSfZttUCxg2c56iOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778825; c=relaxed/simple;
	bh=T0eepIogU/C4nGtklDI6AXFgkozWLR2Zv5SLQKKQmK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVjqZHUfpx7DFWjAUQa40fCkHx3ZA7GxwLj0Gj//XjixC8veEhR4M+XGpXf/CphG45QEOr5N0kFrPhzTz94taF6ekxSLAoompwmQQHknS51cK3hUb+0ZqEw9u5TE1gBVlphNtRHKekfTTZEETTZw5kCn/FPk4ZRUZUBIzH6ZEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qcmDpjoA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XE7nezHRyctL24JiD/kzBAFcrxkUVmQDEQuFCl9Kvk0=; b=qcmDpjoAT7v7YzNJC3dMVxkjpE
	YJ6BnVDNmWlqScrdrkstznmndvy7z84GJ57AgtifwBsrQbYWTIdjrUShFU0sgZQnUQx3lV4Owkixf
	YUv2BW/3nkvUhidrh6omKtpqpTAJoqppsd2gbE6BDi/2M2Vqy35SiMH71ymAgLRvBgD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1up4H3-005Rqc-9Z; Thu, 21 Aug 2025 14:20:09 +0200
Date: Thu, 21 Aug 2025 14:20:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support
Message-ID: <ce66b757-f17d-458c-83f4-e8f2785c271c@lunn.ch>
References: <20250820075420.1601068-1-mmyangfl@gmail.com>
 <20250820075420.1601068-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820075420.1601068-2-mmyangfl@gmail.com>

> +        switch@1d {
> +            compatible = "motorcomm,yt9215";
> +            /* default 0x1d, alternate 0x0 */
> +            reg = <0x1d>;

Just curious, what does alternative 0x0 mean? Does this switch have
only one strapping pin for address, so it either uses address 0x1d or
0x0?

	Andrew

