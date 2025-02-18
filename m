Return-Path: <netdev+bounces-167278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5EAA3995C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E8163030
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288992343C5;
	Tue, 18 Feb 2025 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o6c4u2Hq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA418C933;
	Tue, 18 Feb 2025 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875262; cv=none; b=U+vLcDpFD9w2ogMwe1HPaiB3FCVBG62WCps1lohdPDzrGxtcBYXo3nUHoFwaKC5C3R1+TWcMxAGfn4hN+Xhg18omKsLblS7KPh4yEAvBqXluOSY0xDt8ll+CrOcuufvzr9IeS5FZJaYBEp3hBJkWuxrPRSrKOYAKpvcODAswWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875262; c=relaxed/simple;
	bh=76Az1Nrp9KPwWRLvYAkwkDtEEMlYOkX/gn4Wm54Ggeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhhbVbiQ1kF30meX+ziNVD+twjlJ4E+ctfGYeihmzobSkXJFh8sjUjLiCBvi+qkv5LxXx/BFSpN/fI5FuP270mSH4raPmGTQ7FBLg8O6MHaK5awT92o5ccV0OyRjVLEd4/CF8Cx1nVEmpEoanvrJQFcRcg4dUe5I+PZn1BD3ZqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o6c4u2Hq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z8u1HFNvQFj00JNaA7UaE7kZ0fKIp/C21Or6VG3Kq3c=; b=o6c4u2Hq6aOiw0zopooYt7wvcp
	E3+jJCUM7nHq46JD0aXLOfQ5Jm9ZhiuFSdXnxjiWn9cVMEovMxHN7TD4ujzEjPQEVc6txt7E4gDph
	BHWvbtGL9aaT4ZgG0CHp7d6oKKCXz32SmZ0jB9UccZ/92My6rP3+Y5OrkuvJ8ftIm4VjlE02Pbr4k
	nIrWR3UsptipUVbzuYoaJvi8ShzHrPLpO88aDnZusLz1wytWrp0eazSi9VGFBz9Pa7EZgViJT1rCI
	Ae0dUoitzhjc8huX/pRHtI95OX5/ZxGGj5lqlzmrV1FnqdO7uzbiTcQG61C0pcjWDafsPxQS+tWSX
	ji52VNQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48852)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tkL1a-0001bu-2a;
	Tue, 18 Feb 2025 10:40:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tkL1S-0007CN-2u;
	Tue, 18 Feb 2025 10:40:14 +0000
Date: Tue, 18 Feb 2025 10:40:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Furong Xu <0x1207@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: Add glue layer for Sophgo
 SG2044 SoC
Message-ID: <Z7Rjjo5nZ0gnCbzq@shell.armlinux.org.uk>
References: <20250216123953.1252523-1-inochiama@gmail.com>
 <20250216123953.1252523-4-inochiama@gmail.com>
 <Z7IIht2Q-iXEFw7x@shell.armlinux.org.uk>
 <5e481b95-3cf8-4f71-a76b-939d96e1c4f3@lunn.ch>
 <js3z3ra7fyg4qwxbly24xqpnvsv76jyikbhk7aturqigewllbx@gvus6ub46vow>
 <24eecc48-9061-4575-9e3b-6ef35226407a@lunn.ch>
 <Z7NDakd7zpQ_345D@shell.armlinux.org.uk>
 <rsysy3p5ium5umzz34rtinppcu2b36klgjdtq5j4lm3mylbqbz@z44yeje5wgat>
 <Z7PEeGmNvlYD33rZ@shell.armlinux.org.uk>
 <6obom7jyciq2kqw5iuqlugbzbsebgd7ymnq2crlm565ybbz7de@n7o3tcqn5idi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6obom7jyciq2kqw5iuqlugbzbsebgd7ymnq2crlm565ybbz7de@n7o3tcqn5idi>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 18, 2025 at 09:01:59AM +0800, Inochi Amaoto wrote:
> On Mon, Feb 17, 2025 at 11:21:28PM +0000, Russell King (Oracle) wrote:
> > On Tue, Feb 18, 2025 at 06:50:24AM +0800, Inochi Amaoto wrote:
> > > On Mon, Feb 17, 2025 at 02:10:50PM +0000, Russell King (Oracle) wrote:
> > > > On Mon, Feb 17, 2025 at 02:25:33PM +0100, Andrew Lunn wrote:
> > > > > > I am not sure all whether devices has this clock, but it appears in
> > > > > > the databook. So I think it is possible to move this in the core so
> > > > > > any platform with these clock can reuse it.
> > > > > 
> > > > > Great
> > > > > 
> > > > > The next problem will be, has everybody called it the same thing in
> > > > > DT. Since there has been a lot of cut/paste, maybe they have, by
> > > > > accident.
> > > > 
> > > > Tegra186: "tx"
> > > > imx: "tx"
> > > > intel: "tx_clk"
> > > > rk: "clk_mac_speed"
> > > > s32: "tx"
> > > > starfive: "tx"
> > > > sti: "sti-ethclk"
> > > > 
> > > 
> > > The dwc-qos-eth also use clock name "tx", but set the clock with
> > > extra calibration logic.
> > 
> > Yep, that's what I meant by "Tegra186" above.
> > 
> > > > so 50% have settled on "tx" and the rest are doing their own thing, and
> > > > that horse has already bolted.
> > > > 
> > > 
> > > The "rx" clock in s32 also uses the same logic. I think the core also
> > > needs to take it, as this rx clock is also mentioned in the databook.
> > 
> > The "rx" clock on s32 seems to only be set to 125MHz, and the driver
> > seems to be limited to RGMII.
> > 
> > This seems weird as the receive clock is supposed to be supplied by the
> > PHY, and is recovered from the media (and thus will be 2.5, 25 or
> > 125MHz as determined by the PHY.) So, I'm not sure that the s32 "rx"
> > clock is really the clk_rx_i clock supplied to the DWMAC core.
> > 
> > Certainly on stm32mp151, it states that ETH_RX_CLK in RGMII mode will
> > be 2.5, 25 or 125MHz provided by the PHY, and the clock tree indicates
> > that ETH_RX_CLK in RGMII mode will be routed directly to the clk_rx_i
> > input on the DWMAC(4) core.
> > 
> 
> RGMII is not the problem. The databook says the RGMII clock (rx/tx)
> follows this set rate logic. 

Sorry, I find this ambiguous. "This" doesn't tell me whether you are
referring to either what s32 does (setting the "rx" clock to 125MHz
only) or what RGMII spec says about RX_CLK (which is that it comes from
the PHY and is 2.5/25/125MHz) which stm32mp151 agrees with and feeds
the PHY's RX_CLK to the clk_rx_i inputs on the DWMAC in RGMII, GMII
and MII modes.

clk_rx_i comes through a bunch of muxes on stm32mp151. When the clock
tree is configured for RMII mode, the rate on clk_rx_i depends on the
MAC speed (10/100Mbps).

This suggests as far as the core is concerned, the clock supplied as
clk_rx_i isn't a fixed rate clock but depends on the speed just like
the transmit clock.

> For other things, I agree with you. A fixed "rx" clock does reach the
> limit of what I know. And the databook told nothing about it. As we
> can not determine the rx clock of s32 and it may be set for the phy,
> it will be better to not move it into the core.

I'm intending to leave s32's rx clock alone for this reason as it does
not match what I expect. Maybe on s32 there is a bunch of dividers
which are selected by the mac_speed_o signals from the core to divide
the 125MHz clock down to 25 or 2.5MHz for 100 and 10Mbps respectively.
As I don't know, it's safer that I leave it alone as that means the
"rx" clock used there is not clk_rx_i.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

