Return-Path: <netdev+bounces-202059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CFFAEC239
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE40172333
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583A28A1E2;
	Fri, 27 Jun 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7LZXGuM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B875289E2D;
	Fri, 27 Jun 2025 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060679; cv=none; b=dc0lEsi8Y1QZMOvqTjBmPBNbpbfFp0p4+kX/gx8hmUHyfwmC/WEOpQshhA1fl89prYKtNFu9Ek1H1A7ZM2lE8jOPrxVdC9lOgTjyIA4UoDN9VdyhEyt/X7oDb4cFMI8D5Nb4c81adMo1oHdQLBU36EhEVHNSMWmKfxNKBl5BY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060679; c=relaxed/simple;
	bh=b4bjcqtYTMlbCBJkkYv4E30QbkPwT0gz6mXrIsFMar4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX1KyYIPY+xKR8nFRRl4KMT2TqFkUNqswfwgaRe0w9mFQ+RlMgVkeXMF+uz09Ae2muQtuRQENSZsnk2vNbqvOV90S70t087kag8VH8xVA8lWEoIco7LFRoukOkt/bBhk1UKj7sLI9gSQi8mFwXP+nTC+mWLWjjccGrx4833OFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7LZXGuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4687C4CEE3;
	Fri, 27 Jun 2025 21:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751060678;
	bh=b4bjcqtYTMlbCBJkkYv4E30QbkPwT0gz6mXrIsFMar4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7LZXGuMzoYAPwAVmFLgM9ZXHBrFMbRhTDriRlOw/PJEGiL5TsFIW55+ILevN3XMZ
	 e0I6+5cJhuher+4bqd+U2LfXSYPU1v+C8ZXAhGEOqJ0SfhsGyEAePZNtQCakduJ0tv
	 3UTT1loKWWpkGN1J0XT9NCfWxPctHlKYyf4GuAqyB+iDe6ka2AUX82cXGALqIwXk7F
	 1a/R2EQr9ihzEcrnjSusgAEB93D6/wSeg0xDv4Wy5aDEHyotgzbh+Fg5R3SWQa0qXs
	 0ka6FS6xpazzLpq5KgRvPF2slmlnFRq1YDEQ/rCtEWQMLOPQH07iLvCdIQjCNuvKhX
	 JK3kJJ14iL/tg==
Date: Fri, 27 Jun 2025 16:44:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [net-next PATCH v15 02/12] dt-bindings: net: Document support
 for Airoha AN8855 Switch PBUS MDIO
Message-ID: <175106067736.193475.3574090852380015869.robh@kernel.org>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
 <20250626212321.28114-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626212321.28114-3-ansuelsmth@gmail.com>


On Thu, 26 Jun 2025 23:23:01 +0200, Christian Marangi wrote:
> Document support for Airoha AN8855 PBUS MDIO. Airoha AN8855 Switch
> expose a way to access internal PHYs via Switch register.
> This is named internally PBUS and does the function of an MDIO bus
> for the internal PHYs.
> 
> It does support a maximum of 5 PHYs (matching the number of port
> the Switch support)
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/airoha,an8855-mdio.yaml      | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


