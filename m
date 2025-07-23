Return-Path: <netdev+bounces-209409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C66B0F8AA
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2C1AC2313
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E120E717;
	Wed, 23 Jul 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m4EPov57"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707CA20C00E;
	Wed, 23 Jul 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290609; cv=none; b=LVytbD+3KHte70UV573LnH/Pm8CaMJ5ZXj33kcfVI3QpWgqiTRSTmEXQLZ0McbQ2/9RaStorlsVoV7S18lpvwd6CTPsB2oIF5RPtlG30MBlH5+RtXZAnb/58QozxEezNZQAiAc3wsKmiryYZO/Imh9/YL+IO4xcAs4MDNDAObM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290609; c=relaxed/simple;
	bh=YeQYhjTp5dduT427Tt7El0kEHKxVmhQSi0aw79AHZek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1uIUXcoMpARePohzuCMfEEmC0TQ87TbD3mmEPf0wgNEmhyQlpAPYDcmuApSn4PWJ9YGbz9rbP45QPxnZqgbgqBWm7JkUL0lqRC+RAxmen6rb3ECR7iqKZnQ/sbop3tXD4+t75JubrKSVZWWxoV1M0GKtjN7jG1yTUcYgpXUfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m4EPov57; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eEQLl89P4OrcuStEjktKkoC3l8QiiX66+dxj6MpfBDE=; b=m4EPov57YzBTbrZgGZ/wo7y9/4
	OWl5BKdeEkLsvOhqGneoQOaYRwMbJdYu7aCKyClbLj8ZYZQwvTCAAdLbHqbNqk/8Rl39l9VPu7HvM
	7QlYgIPDGSOjFlHnLwzCpc2wi6z4PG540Y9V2ApIquOIedeIEKsh62eT7Vs0XT99PmUU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uecyX-002fdW-Mm; Wed, 23 Jul 2025 19:09:53 +0200
Date: Wed, 23 Jul 2025 19:09:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/6] net: dsa: microchip: Add KSZ8463 switch
 support to KSZ DSA driver
Message-ID: <b20340d8-e4e5-45b7-907f-be35a7809b91@lunn.ch>
References: <20250723022612.38535-1-Tristram.Ha@microchip.com>
 <20250723022612.38535-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723022612.38535-3-Tristram.Ha@microchip.com>

> This patch adds the basic structure for using KSZ8463.  It cannot use the
> same regmap table for other KSZ switches as it interprets the 16-bit
> value as little-endian and its SPI commands are different.

Thanks for adding the custom regmap. It makes the patch much smaller
and less intrusive.

	Andrew

