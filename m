Return-Path: <netdev+bounces-216311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833FFB33124
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237CA7A7D52
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6D322B5AD;
	Sun, 24 Aug 2025 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hZkRoESl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D01FB3;
	Sun, 24 Aug 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756048941; cv=none; b=TJFeG0itQBC1yPzEurOG5hw70gMwPGvHEPNUPCWRRhjxd2d5sQFViH5AZl+e8vCzJSZwl9sjmJGP4JBlrSEDI85eY6Vx5PR2x5OAvnYd3zsIn1h8VawRtASIU163/irwF6/nC6yl/SZanjF5APQR2yLIeZK/O/dlSewjajFzUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756048941; c=relaxed/simple;
	bh=4kLuxK8jCVjLtWIsTNzDWHDRIzn9V3ffHYNkulU+10g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDaWTJzMO6bioZOcp/wm955BaFTlocg5I9DRaOqti8xeIiTXHTRO0oqDWfBMxCK1+/TZwTu6hJo7QdNM/8atEbaHTVCFCkZoFIe4LfiSGd6N42sUStHVo2IRvg4z5ikvgcf8iWaOk/Ktd7ubYNTKz3y44QHpQtBy9MDrw1QDGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hZkRoESl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xt44HhPp9zEbrB0nhDDVzGBPmch5sFqvtKj/zCr7LZs=; b=hZkRoESlDM+TIXXco/k6P3KrjD
	S2qyHgEU8ivZV9F5UhFcM3PKq6JchjnUQNenW2yVbVaML6+G/i+UIuPkof2LFS7sQ5DGfi13+SVBL
	OeYLASB6vOfPvwfqLwIXJy/tZqMaArzCMfjcQWXdFGMFLqjS0T61L+f0eZEz4/sZPX3M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqCXr-005qBI-8v; Sun, 24 Aug 2025 17:22:11 +0200
Date: Sun, 24 Aug 2025 17:22:11 +0200
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
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <f0dd9bb9-63bc-4ca4-bc4f-99b2e583f94d@lunn.ch>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824005116.2434998-4-mmyangfl@gmail.com>

> +
> +/******** hardware definitions ********/

> +/******** driver definitions ********/

> +/******** smi ********/

Comments like this don't add any value. And sometimes you need to move
functions around because we don't allow forward references.

	Andrew

