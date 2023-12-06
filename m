Return-Path: <netdev+bounces-54479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A31B8073A9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92F1B20E63
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF53FE4B;
	Wed,  6 Dec 2023 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wZPKD+cS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208721BD
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RNvG5s5cZKCdeL2dEGB0lOlLiGHM4L4YmHrzkWBC0uE=; b=wZPKD+cSNuA4KX/RXP/6xqj/Yq
	ZHv2ahpSbEWcw/4ObTZsbfy6qlG44CJURSeUKoP7NiKNjomEELpkTGu60GNyZ+xtrbsk0xLS0EMln
	yG7TC90iR/65STjjVX7EQYEM46sHE4bGtfLIWrXojMqq2zKo+XVC0qgJA0IRhKvwC0Cs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAtnY-002DiL-7O; Wed, 06 Dec 2023 16:26:52 +0100
Date: Wed, 6 Dec 2023 16:26:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Danzberger <dd@embedd.com>, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <19d4d689-a73e-4301-b22c-5ad2dfb4410d@lunn.ch>
References: <20231204154315.3906267-1-dd@embedd.com>
 <20231204174330.rjwxenuuxcimbzce@skbuf>
 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
 <20231205165540.jnmzuh4pb5xayode@skbuf>
 <e37d2c6678f33b490e8ab56cd1472429ca3dcc7a.camel@embedd.com>
 <20231205181735.csbtkcy3g256kwxl@skbuf>
 <52f88c8bf0897f1b97360fd4f94bdfe2e18f6cc0.camel@embedd.com>
 <20231206003706.w3azftqx7nopn4go@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206003706.w3azftqx7nopn4go@skbuf>

> So, surprisingly, there is enough redundancy between DSA mechanisms that
> platform_data kinda works.

I have x86 platforms using mv88e6xxx with platform data. Simple
systems do work, the platforms i have only make use of the internal
PHYs. This is partially because of history. DSA is older than the
adoption of DT. The mv88e6xxx driver and DSA used to be purely
platform data driven, and we have not yet broken that.

	Andrew

