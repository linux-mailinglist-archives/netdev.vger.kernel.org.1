Return-Path: <netdev+bounces-214311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447C4B28F21
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 17:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B27B6250C
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EBE2F3C0B;
	Sat, 16 Aug 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oFFND71j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC812E3717;
	Sat, 16 Aug 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357904; cv=none; b=WQZP6AB1Xs25WU4vXw9vF4bWAMCLDmU/NLBmHYj6LufT/IUHm2p+kCzExXbCVYhKlh79rd+GD+Zp8y/JRkr7i+0uj545cKCJYLtAJFfSx49T1575zFl602A3JmV1X+XZB0AvRXmsJltOPN8Sosx7o/+UTD22UiPx+tLqBpWcyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357904; c=relaxed/simple;
	bh=5STO/XpwBqv8Hr/MbjJKrklmj2I5JqDYc0nDpWPO+XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkZYtJBEdFoB0wenA4+E00FAeNBHy5iWyQPNLTBxarr/NV3vM8PoLmu/Ds7yfjCRMVFWAVvmBzYk0LYlReAtn2Af9h7uczoAZzSoKde5/tJ/PobF78Yccr1EixlWiAxxC5D02VllYOmoSJ2NuM2KxO2NhDwsBTmpCqQNDUUkPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oFFND71j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kucQfFX0WapujO2b3RkE6LfKTcIS2R/LSGVe/oUbxjs=; b=oFFND71jEJztk7u/guQAV983gk
	n2klaiQodaftwmyx+7373uM5M1pI49gAjF4wX95cEnGP/F/FIJc0vwvJFzl3+BHjRhLdnDclxKptl
	cPutdwYIBR40GMTnh8OP//J8mL4SZEi3+mEz2l/CGO6k0n+IJ4yZa24Qh2KGkg/MAemw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unIm4-004uat-QQ; Sat, 16 Aug 2025 17:24:52 +0200
Date: Sat, 16 Aug 2025 17:24:52 +0200
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
Subject: Re: [net-next v3 2/3] net: dsa: tag_yt921x: add support for
 Motorcomm YT921x tags
Message-ID: <095df250-2ef9-4589-893d-f28193076f16@lunn.ch>
References: <20250816052323.360788-1-mmyangfl@gmail.com>
 <20250816052323.360788-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816052323.360788-3-mmyangfl@gmail.com>

> +static struct sk_buff *
> +yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	unsigned int port;
> +	__be16 *tag;
> +	u16 rx;
> +
> +	if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
> +		return NULL;
> +
> +	tag = (__be16 *)skb->data;
> +
> +	/* Locate which port this is coming from */
> +	rx = ntohs(tag[1]);
> +	if (unlikely((rx & YT921X_TAG_PORT_EN) == 0)) {
> +		netdev_err(netdev, "Unexpected rx tag 0x%04x\n", rx);
> +		return NULL;
> +	}
> +
> +	port = FIELD_GET(YT921X_TAG_RX_PORT_M, rx);
> +	skb->dev = dsa_conduit_find_user(netdev, 0, port);
> +	if (unlikely(!skb->dev)) {
> +		dev_warn_ratelimited(&netdev->dev,
> +				     "Cannot locate rx port %u\n", port);
> +		return NULL;
> +	}

Why do you rate limit the second, but not the first?

	Andrew

