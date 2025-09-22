Return-Path: <netdev+bounces-225340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA85B92666
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18CB57AB79F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E0313E2B;
	Mon, 22 Sep 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPPtVhHX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C434305E33;
	Mon, 22 Sep 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561744; cv=none; b=lnAtRiW1Sza9NkdxSPpP4vIdCaiqXCddwaVB1VVsE9calSg+VX/j/J1HdTaCD23+63fJxqY2q+JsPc6Ucgv+qfFG4KCvccEjN7jKLE67EBkMgcGMFWYH/EWfICmb+rPqbPulrcOWEoXammesbhl/z2YOvDXLX15hVKLveR4N8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561744; c=relaxed/simple;
	bh=qy1QbR66kQUDGYOnr92+yGqpqDsKbyUc8q+DQOYC8sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tViFq9AIoy6Cdj15DD7BxNjNKaUNvjgCSFC4TFd8Wzo8rfKcu1QXvUWW4O+hIkkPjBYdq7nZXD71Me3JUZIyE7kyyuJ6hY9t+vn/8gbqxg/nYMmtiv+kqsYoTYrmOhQnDKzAWMvfYXY2IqWKwr74zDH+nE4Ic+8HhOhOjbJ5CbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPPtVhHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8396C4CEF5;
	Mon, 22 Sep 2025 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758561744;
	bh=qy1QbR66kQUDGYOnr92+yGqpqDsKbyUc8q+DQOYC8sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPPtVhHXH0/j78nfPB92exe0uKQvzKlcDNjJPt44XHxjO5B8Tmn7e6SmWluIFh0aG
	 xtxoOtms5E6kBV5xRLvcJTIcsPdZqBqoUbhbfCzGGIwm0pAWeKBtkJrnU1HOkXwlJN
	 uiBD/gq4szUvsjJJCjrzR04phylNsu3ENHn5h3sWpITod1YdkMAmtG1sRKcVZlWN6C
	 KStGYMhXMLOPGCWX3hMKk4p0pf7VpDntc1jN0y8qD6XWRVsSjgj/FAy+tKE8AzK5Gh
	 v6gk/ER5sXMQ7S5vcMV8ynjR92S+y/4/Q9sLD+NSm6gJz7wnCItja9AJYI+uRk6x++
	 l5hKpn91TBOOg==
Date: Mon, 22 Sep 2025 12:22:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marek Vasut <marex@denx.de>, Vladimir Oltean <olteanv@gmail.com>,
	UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>,
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v3 2/3] dt-bindings: net: dsa: microchip: Add
 strap description to set SPI mode
Message-ID: <175856174145.496533.6230819934968287513.robh@kernel.org>
References: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
 <20250918-ksz-strap-pins-v3-2-16662e881728@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-ksz-strap-pins-v3-2-16662e881728@bootlin.com>


On Thu, 18 Sep 2025 10:33:51 +0200, Bastien Curutchet (Schneider Electric) wrote:
> At reset, KSZ8463 uses a strap-based configuration to set SPI as
> interface bus. If the required pull-ups/pull-downs are missing (by
> mistake or by design to save power) the pins may float and the
> configuration can go wrong preventing any communication with the switch.
> 
> Add a 'reset' pinmux state
> Add a KSZ8463 specific strap description that can be used by the driver
> to drive the strap pins during reset. Two GPIOs are used. Users must
> describe either both of them or none of them.
> 
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


