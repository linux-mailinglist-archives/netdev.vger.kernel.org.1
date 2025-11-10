Return-Path: <netdev+bounces-237225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BF1C47929
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE941888C93
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464DD26AA94;
	Mon, 10 Nov 2025 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B0vBeX50"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756D257841;
	Mon, 10 Nov 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788932; cv=none; b=pRgHTotkPcF+V9Taj4gLtQLacrYp2aRclvxYd5dZXGFLPs2Yuo3//fJTOsXmZd028PopijEHGdxVwzG6UF9SNOkrjtoWCffnjIXLyn2dKqIOLQLJw3eRjXWDENReNanBMpAAehHQDcBoYIq9xlgro2hg17+bnXopreIVX/1uo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788932; c=relaxed/simple;
	bh=G+azJXcP4oT7JjHwD0cX74wLwbf39y5vwRD/6ZACn5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wjbseh4Yzz8JzF1mrYUwT7w1SUkR0PY59B3LGtJLO1fRxZmta8xLyQ5r0OoeZ9puDZ0Fo0neBggopc64B1Bxdb1z82H+eTqeseaVmVUj+ZYLUXU735cHq/iqtzCrF2HljpPkrtNEYprhA5hVcylT49o8TD3H1NWhkPBYNINNXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B0vBeX50; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=01rfLZwpM4pmMKU3kqbEEzw3i2BzLBr0hbB6YkfV3no=; b=B0vBeX50L5XIgkqjrniD4kQSsI
	sbc+Q3WoA0Z19I03hXsGH6xMRB6yrOs2MvmnCW9nxDEe+IvAzmQts2rvB0n+uCUWjToSn28T/4WH4
	O/jWqx8JNxLcvgL+fV9SkJhzTrr6bXtzXXOwU1KVkOKIvxJjUg8lIHcD16tWYd9XzuQU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vITvF-00DX7o-GK; Mon, 10 Nov 2025 16:35:13 +0100
Date: Mon, 10 Nov 2025 16:35:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>

> +	/* Add a warning to notify the existed dts based on AST2600. It is
> +	 * recommended to update the dts to add the rx/tx-internal-delay-ps to
> +	 * specify the RGMII delay and we recommend using the "rgmii-id" for
> +	 * phy-mode property to tell the PHY enables TX/RX internal delay and
> +	 * add the corresponding rx/tx-internal-delay-ps properties.
> +	 */

I would not say that exactly. Normally you don't need
rx/tx-internal-delay-ps. It is only requires for badly designed boards
where the designer did not correctly balance the line lengths.  So i
would word this such that it is recommended to use "rgmii-id", and if
necessary, add small "rx/tx-internal-delay-ps" values.

> +	scu = syscon_regmap_lookup_by_phandle(np, "aspeed,scu");
> +	if (IS_ERR(scu)) {
> +		dev_err(dev, "failed to get aspeed,scu");
> +		return PTR_ERR(scu);
> +	}

This is an optional property. If it does not exist, you have an old DT
blob. It is not an error. So you need to do different things depending
on what the error code is. If it does not exist, just return 0 and
leave the hardware alone. If it is some other error report it, and
abort the probe.

> +
> +	ret = of_property_read_u32(np, "aspeed,rgmii-delay-ps",
> +				   &rgmii_delay_unit);
> +	if (ret) {
> +		dev_err(dev, "failed to get aspeed,rgmii-delay-ps value\n");
> +		return -EINVAL;
> +	}

Again, optional.

	Andrew

