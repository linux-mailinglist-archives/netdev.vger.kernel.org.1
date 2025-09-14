Return-Path: <netdev+bounces-222848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D4B569C1
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831577A8EEA
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C839020298D;
	Sun, 14 Sep 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fF/26pSt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4781E47B3;
	Sun, 14 Sep 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757860036; cv=none; b=g614fhLQ2Rs8X6hxrwgTVZ7Vu5SzfkyUIByN9/VLUN/7jvzO7aNGOdByp2eLP5uFjnjSkPnVxQ98OzU0m8EJqhRGIHPe3kfJNXzXqdsCc8Dao5D9BQX7rSVf/Z4M6JBueEXn/aYgpBqMIFB/jtUSH6j8zO1x6qSSw6Qz7oasMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757860036; c=relaxed/simple;
	bh=l9i1JOoE9xct7TAw7yGRuCGe7oON0LrN12HBv4aua6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEQCO5Ubwk07KNR+liJNpfyrz32A7DsQCTshmisihKzZtf+S6E7FuXrDpE9UEVOhcKoItggadTXLX0eIDkNYlXPioxdkXUr6POMgrov0/AGhFf3W+S0RlIei+ZqBAk/bnHz7aQcNXCmpUWzleb4KfE0U+gJllZQOY0WX3lyfChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fF/26pSt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=an9Yth3zuqwupnWSHxyQHPNMhHnRBJyE4Xw/D6M144A=; b=fF/26pStELSIaGPcAH6ff7U6dr
	L1qbzoep8I4H4LOyTOr4NFtZCf8zQqVMHii8T2GKxQrmrARzobsesSnyZT2BaTOAxq3Vsde3knI2A
	GLNjO6WhwwG+Xskn5DhtUht1TEQg+mY0+EfUOGsAb3mBr/0hrlmsMK0rtE7sE7nuCzew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxngk-008LrZ-1F; Sun, 14 Sep 2025 16:26:46 +0200
Date: Sun, 14 Sep 2025 16:26:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Vivian Wang <uwu@dram.page>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH net-next v12 4/5] riscv: dts: spacemit: Add Ethernet
 support for BPI-F3
Message-ID: <6ace8fca-21db-40f1-b44d-28e4a1d3d2da@lunn.ch>
References: <20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn>
 <20250914-net-k1-emac-v12-4-65b31b398f44@iscas.ac.cn>
 <007c08ab-b432-463f-abd8-215371e117c4@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007c08ab-b432-463f-abd8-215371e117c4@iscas.ac.cn>

On Sun, Sep 14, 2025 at 12:31:04PM +0800, Vivian Wang wrote:
> On 9/14/25 12:23, Vivian Wang wrote:
> > Banana Pi BPI-F3 uses an RGMII PHY for each port and uses GPIO for PHY
> > reset.
> >
> > Tested-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> > Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> > Reviewed-by: Yixun Lan <dlan@gentoo.org>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 48 +++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > index fe22c747c5012fe56d42ac8a7efdbbdb694f31b6..33e223cefd4bd3a12fae176ac6cddd8276cb53dc 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > @@ -11,6 +11,8 @@ / {
> >  	compatible = "bananapi,bpi-f3", "spacemit,k1";
> >  
> >  	aliases {
> > +		ethernet0 = &eth0;
> > +		ethernet1 = &eth1;
> 
> Hi Andrew,
> 
> I added these two aliases in v12, but kept your Reviewed-by for v11
> because this is fairly trivial. Same for patch 5.
> 
> Is this okay?

Yes, this is fine.

	Andrew

