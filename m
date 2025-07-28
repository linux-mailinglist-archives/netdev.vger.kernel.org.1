Return-Path: <netdev+bounces-210560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE39B13EFB
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6150E4E4455
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E126D4E4;
	Mon, 28 Jul 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YFdULwoB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCE145A1F;
	Mon, 28 Jul 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717225; cv=none; b=su3EACuDlRpdZzhWc6f/ZKX2b9lQmIb/p2tdF0GT7iCfnHvWEvh7QRhyRtxiNRNNEYaUmJYO2ItTRItw8soK9z3z6wXpkYPvUMXx4AzS4WjRwYsqlMsZHjF26guYxu0yLT/giYlpCm0xpQiNdMl6gwCWRN7x6pc6v8uIbErwI9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717225; c=relaxed/simple;
	bh=WeJb/ApjvcbFncdxETVdczEpNUNn1MkfRDrriLyIUzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jScSw+ZLaLbmt/bofqgXPpuKtEE4wQ33DAcK/qzggURIR8rpsmnxlUaG28ZqBuokpif3XMrtaOFX2zBU/+6vDrB9p9/QLk7PIaaXUiRarLEL7er+ppT6gd2VVfYvEfMdxrkg1ZvlQu3dEtgzbTlq9PyPU/SaX+YNwO+ls+nxGPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YFdULwoB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q0NF0L3kcXAIrlIUaY/JZCJLHtTs0ZlzHcUdeIHuQes=; b=YFdULwoBKH8lALuAaM6Ubz8QzV
	wjHrW0iCk5dDulWWurBeJg99G/q/tLpP0xi4V1TdN1kxGQPBiH6PR6QynS+fdE64dxYcbN7TwhsTR
	4f6sktlQnJnkvbKz846r+1LMZsditTsUH3f7N9H6w1yeviP3WbpZBLT6jX1CZ9c27kSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugPxO-0036Tn-0m; Mon, 28 Jul 2025 17:40:06 +0200
Date: Mon, 28 Jul 2025 17:40:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: realtek: Add support for use of
 an optional mdio node
Message-ID: <2f942223-8683-4808-8f7a-4f46e18f402d@lunn.ch>
References: <20250727180305.381483-1-jonas@kwiboo.se>
 <20250727180305.381483-3-jonas@kwiboo.se>
 <2504b605-24e7-4573-bec0-78f55688a482@lunn.ch>
 <badef015-22ff-4232-a4d0-80d2034113ca@kwiboo.se>
 <9702f3da-f755-4392-bf2b-28814ee0a8c7@lunn.ch>
 <1c639c62-cc07-4b3d-a18b-77f93668b88f@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c639c62-cc07-4b3d-a18b-77f93668b88f@kwiboo.se>

> When it comes to having the switch being described as an interrupt
> controller in the DT is also very wrong, the switch only consume a
> single HW interrupt. The fact that the driver creates virtual irq for
> each port is purely a software construct and is not something that
> should be reflected in the DT.

I think that is not always clear cut. Switches can be considered SoC
of their own. They have multiple hardware blocks, which can be
described independent, just like a traditional SoC and its .dtsi
file. The switch blocks can then be connected together in the same way
SoCs are.

I've not looked at this particular switch driver, but the Marvell
switches have a similar single interrupt output pin connected to the
host SoC. Within the switch, there are at least two cascaded interrupt
controllers. We implement standard Linux interrupt controllers for
these. That allows us to use standard DT properties to link the
internal PHY interrupts to these interrupt controllers.

	 Andrew

