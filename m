Return-Path: <netdev+bounces-167026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F83A385B5
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6701772C1
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288621D004;
	Mon, 17 Feb 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tpBEUbse"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03F21CC54;
	Mon, 17 Feb 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801488; cv=none; b=noBQYZruzQDdBvt5iSW2ftpqf/mwCT6ajmfzjYDmGNUQVQge35pQzwICR/K5suLDljHIbQfxth+gCVLTNbmdu7aZDPX+K0d48DA4oY+gf4E6rllEGBGvtEdWnMLBU4jEvAJztDt447VNAQQAwm1dHOvyI1z/m/mcQ05jprz8NwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801488; c=relaxed/simple;
	bh=CgvLbbaqhZJh2aBng8GYA6OHX8pFtBK1DgD9dwP/Izo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwSJEzafx0SvPK7S9TbhKpIP9gPju6hX5dxeh2pnyb5VLFB1icGxEivJWm9tTv6Y9JK3lR8ggJUliLMLZcReOZkUMvbaI3BdmMPNnzvCxoV501SWLHmIKk8GhXBmJkQ0+PhkyyUUK5ZuYO8HKmDx5tsVsDzIVCSrUB6nFT0iuWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tpBEUbse; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Tyg8b+xD0Br85DGNOgrIPE01EZSzRbYGNzNPsDnqag=; b=tpBEUbseu3svPJZjMXU0nSpYr8
	GmffVj6GQ869k1Jh3niah2GmA3mLVEENfzotxr/MZcFH2FhCCIZZp9Kxnz9msHHPG5C3vOB6+kUR6
	6+RgjsyJNUEgL+6lYKHDXyLR6/ewFtS87FmKFoT6ICF87RC/fVEfuEgPooJINzuvQmyjV2AyVv+vJ
	YbKo0YZXyP0coO8OvabMIii2bRao+9FXH6GvaO7AaWwc839h0w6a9KrOGu1gVklIfC15Ikw1Jj9vX
	kQjlQzNDVeKcCrSDBXVW9IiUYc+OsOsTXab9schzXS/+HNDTbVhhy9fSvNf09tdiCq2hPlM2Xz3M4
	CM1EF8aw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39042)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tk1ps-0006pq-1t;
	Mon, 17 Feb 2025 14:11:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tk1pi-0006HQ-2v;
	Mon, 17 Feb 2025 14:10:50 +0000
Date: Mon, 17 Feb 2025 14:10:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <Z7NDakd7zpQ_345D@shell.armlinux.org.uk>
References: <20250216123953.1252523-1-inochiama@gmail.com>
 <20250216123953.1252523-4-inochiama@gmail.com>
 <Z7IIht2Q-iXEFw7x@shell.armlinux.org.uk>
 <5e481b95-3cf8-4f71-a76b-939d96e1c4f3@lunn.ch>
 <js3z3ra7fyg4qwxbly24xqpnvsv76jyikbhk7aturqigewllbx@gvus6ub46vow>
 <24eecc48-9061-4575-9e3b-6ef35226407a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24eecc48-9061-4575-9e3b-6ef35226407a@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 17, 2025 at 02:25:33PM +0100, Andrew Lunn wrote:
> > I am not sure all whether devices has this clock, but it appears in
> > the databook. So I think it is possible to move this in the core so
> > any platform with these clock can reuse it.
> 
> Great
> 
> The next problem will be, has everybody called it the same thing in
> DT. Since there has been a lot of cut/paste, maybe they have, by
> accident.

Tegra186: "tx"
imx: "tx"
intel: "tx_clk"
rk: "clk_mac_speed"
s32: "tx"
starfive: "tx"
sti: "sti-ethclk"

so 50% have settled on "tx" and the rest are doing their own thing, and
that horse has already bolted.

I have some ideas on sorting this out, and I'm working on some patches
today.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

