Return-Path: <netdev+bounces-238895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A73C60BC9
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8A964E0FA8
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8631419D8AC;
	Sat, 15 Nov 2025 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BqUkofmW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3675809;
	Sat, 15 Nov 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763243201; cv=none; b=E6wo+/TQoDQt6ECS0UVmAzTFv4lRrdMhX1TKRDgZrEW9gsbTIOBMgleNA2VzSAtmJG0gLQHy4mVv0ziTUACHjUEiuVSM5Av3b23kcICvrYWB1d/IsBIFHvComt5It5ITjopFjNv75BrKn3gr3K254YeHvQqMfINeKT24NvD3AsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763243201; c=relaxed/simple;
	bh=DS7jnr7LQcK8wBxZTxE00YtiWyfNkU3wGfkFfgB9S2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKUrWEyRtYJfgG8Tl9P797rL14kTYM0cdbJomJl0Lsa8YxIIEN4DASEeHeQOkMlA8CqQAIlHg+pPSLNbX5qSBJRM4KNxfo1HtBnje4suYIljzmQPUeUX90J39oT5BwhZFiLFFWuCHLMrQcBY3bB8EtYKzpgpXG7p9uyUiwmkNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BqUkofmW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/whuAK3kZgLzmadCmNYa4Vh8RN8Z7SP1J4SvcMcHv2Q=; b=BqUkofmWLA/5XsBL3zG6W2CG9A
	2w8hAJDCdvu170jvmqVCh3C7wzLAfwYwGsO7TlSjv4QZyuFKHdKFjBZt+zm705bTebsUzav8cupwK
	AUWns5itZzZxccGXPwG6PL43hFGPs/s9dw/D5mG+LY37jHakJ8jsJNv+muqE7HUbJMJw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKO60-00E7C7-S7; Sat, 15 Nov 2025 22:46:12 +0100
Date: Sat, 15 Nov 2025 22:46:12 +0100
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
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>

> Based on the above information, I have attempted to outline my understanding.
> 1. 'rgmii' + MAC delay:
> Add warming, keep MAC delay and pass "rgmii-id" to PHY driver.

Think about that. What delays do you get as a result?

> 2. 'rgmii-id' + MAC delay:
> disable MAC delay and pass "rgmii-id" to PHY driver
> 
> 3. 'rgmii-id' + no MAC delay:
> Keep disabling MAC delay and pass "rgmii-id" to PHY driver
> 
> 4. 'rgmii-txid' or 'rgmii-rxid':
> Keep original setting

> I have some idea to discuss with you.
> 1. On 'rgmii', I want to add warming and directly disable MAC delay and pass 'rgmii-id' 
> to PHY driver.

Yep.

> 
> 2. On 'rgmii-id', ignore if enabling MAC delay, all disable MAC delay and pass ' rgmii-id'
> to PHY driver.
> 
> 3. On 'rgmii-txid' or 'rgmii-rxid', keep the above item 4.
> 
> Actually, it's difficult for the driver to determine whether the MAC delay is enabled or not.
> Our design doesn't use a single bit to indicate the delay state. Instead, the delay setting is 
> derived from the user's configured delay value.

But you can turn it back to ps. I would say, if it is > 1000, the
intention is it provides the 2ns delay. If it is < 1000 it is just a
minor tuning value because of bad board design.

Do you have experience from the field, what do real boards use? Are
they all inserting the same 2ns? Or is each customer tuning their
bootloader to configure the hardware differently per board design?

You might even need a more complex solution. If the bootloader is
adding a delay between say 200ps and 1600ps, it suggests a poorly
designed board, and the PHY adding 2ns is not going to work. There is
a need for rx-internal-delay-ps or tx-internal-delay-ps in DT. You can
give a warning, and indicate what values are needed, but leave the
hardware alone. If the bootloader is setting the delay > 1600, passing
_RGMII_ID to the PHY, and disabling MAC delays is likely to work, so
you just need to warn about phy-mode being wrong. If the bootloader is
inserting < 200ps, and phy-mode is rgmii-id, that is just fine
tuning. Maybe suggest rx-internal-delay-ps or tx-internal-delay-ps be
added in DT, but leave it alone.

Whatever you do, you need a lot of comments in the code and the commit
message to help developers understand why they are seeing warnings and
what they need to do.

	Andrew

