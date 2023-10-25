Return-Path: <netdev+bounces-44264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260287D768A
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D5D1C20C57
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6C339B1;
	Wed, 25 Oct 2023 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VXpR8QUR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05B12B6D;
	Wed, 25 Oct 2023 21:22:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A12212A;
	Wed, 25 Oct 2023 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Urn8GamAAmfRlpIyeTNJ8cL1pt8vGWoFXXcjKP9MuQE=; b=VXpR8QURtG7r8i5CpJY9UZSshe
	1Fs7I958KobVil75HdIaCvNzzUhdETy5Uvr9zrFObJp9avKLyCqXmUw0uMyPZ7lO54ZUQnLxExXsh
	oNkz7wB3W4LZuDk14kMERjVaOgOw49DWu3UMeZohNiSYEkaE25hrNGLOtkVdULYys/Rw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qvlK9-000CtD-3G; Wed, 25 Oct 2023 23:21:57 +0200
Date: Wed, 25 Oct 2023 23:21:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Enrico Mioso <mrkiko.rs@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Russell King <linux@armlinux.org.uk>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <72d0aee4-ae19-4472-aa96-87220128bca9@lunn.ch>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org>
 <20231024182842.flxrg3hjm3scnhjo@skbuf>
 <CACRpkdb-4GPnVegc+OqyPaZN2rNCkgmNL4qjf-LGnnz27+EBbg@mail.gmail.com>
 <CACRpkdaZYUxar8ESi6X7qLWJhuyRcFpYSF-70DvGdSn-rb7r6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaZYUxar8ESi6X7qLWJhuyRcFpYSF-70DvGdSn-rb7r6w@mail.gmail.com>

> The mv88e6xxx schema will look like so:
> 
>  properties:
>    compatible:
> +    oneOf:
> +      - enum:
> +          - marvell,mv88e6085
> +          - marvell,mv88e6190
> +          - marvell,mv88e6250
> (...)
> +      - items:
> +          - const: marvell,turris-mox-mv88e6085
> +          - const: marvell,mv88e6085
> +      - items:
> +          - const: marvell,turris-mox-mv88e6190
> +          - const: marvell,mv88e6190

Lets see what the DT Maintainers think of this. But if we do go this
way, i would like to see a comment here with an explanation. What we
don't want is developers thinking they should add new compatibles for
whatever board they are adding.

	 Andrew

