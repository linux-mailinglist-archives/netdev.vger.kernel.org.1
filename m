Return-Path: <netdev+bounces-235359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C741C2F353
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 04:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2DC3BF08F
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 03:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF1B2DC321;
	Tue,  4 Nov 2025 03:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rp/1Rkqf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C862D063F;
	Tue,  4 Nov 2025 03:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228181; cv=none; b=uFV3ufhF8WLgqr0vaQUQulsF6fDArZDnGld5UW3arha+JH2ZXoQ0XKaKMYBEl3/Z3f56XjhONFWeOHWidsB+wUtgrE3wBxPfgRIaUjEH4TOQYyFr9g+O0Hg7dByytZ/7YYIGpXoFj1GyDzB4RjtrsCZV3UcSM7x22CszOYM2lkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228181; c=relaxed/simple;
	bh=O93tWsPnFO0chqLwNLgPGezobulYVvCBaRLjERLw7Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx9lzJmqWV2Ty6xeC9o+ISpEb53R57gxki5cioCrG94QOan1gwOamhXyzPUh26rlHdFs9QsBabkNSZOY2NYNQ3eDky2NguoqSQ6XCn503KXe5pclJDB1+1DosMzF2NR2zU3J8LT+FVNxdqrdVqEmiXvq4TUm+4j/d6jestSQX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rp/1Rkqf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KKcdMdVUcB++neaXWMBwYyImzHSwG/N24sLqEytUYkY=; b=Rp/1RkqfFdft8wuBvYka9zL9cx
	CNK1zBVvheHgxEvgA12K3H++qoqgHv0N0at+AD4RyEfKhnKqbGYWkMoLVN2BeoJe/LRt29ANKTkNX
	hUy+7UU69/9XNJI1txi2rLjg1487X5K1IdO/TOISULFGdhupCnOuJiimTsCRY67x2Nx0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG82j-00CqtK-Be; Tue, 04 Nov 2025 04:49:13 +0100
Date: Tue, 4 Nov 2025 04:49:13 +0100
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
Subject: Re: [PATCH net-next v3 3/4] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Message-ID: <aeb33ab2-4a50-4651-8bd7-8fa2bf854c87@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-3-e2af2656f7d7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-rgmii_delay_2600-v3-3-e2af2656f7d7@aspeedtech.com>

> +	scu = <&syscon>;

This property can be moved into the .dtsi file. It should not matter
if .dts files are using the old compatible, it will be ignored. But
having it in the .dtsi makes it easier to .dts files changing to the
new compatible.

	Andrew

