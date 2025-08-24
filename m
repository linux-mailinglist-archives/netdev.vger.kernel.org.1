Return-Path: <netdev+bounces-216313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D2B3313E
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 17:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A23200BEA
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB8275865;
	Sun, 24 Aug 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EheM/1lt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B014F125;
	Sun, 24 Aug 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756049674; cv=none; b=k3OtmLhgZKa0Jq8/ifTeTTRQYGae15wE29m58MZxXjkEwbPFPozZJ10yCMG9xJIAC0UC/xp5F5KZ2TiSxG0KzXkCNGlO+sYPbAKwQfuhhY5/0AkBtCI68fQx765UOl4Cnl7OrGXjYe96Belw5/P8Funp2npicKIhoFT+BVjoXf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756049674; c=relaxed/simple;
	bh=+a9m7QQZk/61tJ8oasLXUNRg2pvRs+/sNxMyl1nSfqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUxb/akxXYWyiM3rFLcFmY77vatTJnGQMNtAuhJaHUWv+G6SB0xpmYqm6fAEKWFPwccBl9j/eP1V8VuD60Dfh8yerqvYeKAPJ4RnQB258a4tHEtdFFo1rVFF+VRGIJecVmzIviMkqhdmRO/G1ObuKatMd8+Qs6UlmoMDY6Ussb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EheM/1lt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KrI2xk9zX8LNZ0JPxtdB/UHd7Wtwi0qjAQ2ViTZN6RU=; b=EheM/1ltn01lAlVJetP+wLvzIc
	VcLoSgTT4+Lp5/vsA5QfFDOCoC2IanCunHcvPdaL3Mb9exW22IwLWfs1DOJhvIL74Mp+VhoOPQtQm
	im3EBmFmVT/ABNtp3u08U0cpJd+mBZfUZ2tLDTEVoyGLUbLP1/3181soMfhf7UwwEZ1Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqCjg-005qFP-2N; Sun, 24 Aug 2025 17:34:24 +0200
Date: Sun, 24 Aug 2025 17:34:24 +0200
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
Message-ID: <6809357f-b826-445b-9aac-5dd951bd5d83@lunn.ch>
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

> +static void yt921x_smi_acquire(struct yt921x_priv *priv)
> +{
> +	if (priv->smi_ops->acquire)
> +		priv->smi_ops->acquire(priv->smi_ctx);
> +}
> +
> +static void yt921x_smi_release(struct yt921x_priv *priv)
> +{
> +	if (priv->smi_ops->release)
> +		priv->smi_ops->release(priv->smi_ctx);
> +}

What happens if priv->smi_ops->acquire and priv->smi_ops->release are
not implemented? Very likely, it will mostly work, but have subtle bug
which are going to be hard to observe and find.

You want bugs to be obvious, so they are quick and easy to find. The
best way to make the bug of missing locking obvious is to jump through
a NULL pointer and get an Opps. The stack trace will make it obvious
what has happened.

> +
> +static int yt921x_smi_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
> +{
> +	return priv->smi_ops->read(priv->smi_ctx, reg, valp);
> +}
> +
> +static int yt921x_smi_read_burst(struct yt921x_priv *priv, u32 reg, u32 *valp)
> +{
> +	int res;
> +
> +	yt921x_smi_acquire(priv);
> +	res = yt921x_smi_read(priv, reg, valp);
> +	yt921x_smi_release(priv);

I don't understand the name _burst here? Why is it called
that. Looking at other drivers, _u32 would be more common, especially
if you have functions to read a _u16, _u8 etc.

   Andrew

