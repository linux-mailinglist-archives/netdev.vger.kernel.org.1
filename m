Return-Path: <netdev+bounces-185526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8143FA9ACCE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BDE3AC45F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00352227E99;
	Thu, 24 Apr 2025 12:05:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382C91FAC46;
	Thu, 24 Apr 2025 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496331; cv=none; b=q5Y7zK2VN8TPE+3wqH+cGcejgebjJO6c6TfvInSLdzw1fq2NGzbR4GfFdMMyEwPK1YVvku719lftTJVagZPutL9g2W02ge3V/zYSDpe5ZzaEdnVrT8N8Gs6rxLv+XJ1//G/C2BmTJDcVlB7QDaKBH+fY9pjKBPhLAT5OVNblc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496331; c=relaxed/simple;
	bh=s1lwQ6KQJegruKsJwhoAbmV6Zxh4FSZt6yJYj9j9ISg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bp9d3nZFwZSInPIcU6SV51/famccQoFlIkfTcXCenAkT7OeXRcF9AGpnrmT056pLbms5DNBWWA1niRgaHXYUYjpkR/1Xb4u8mdJ2otjzedTfUTy/1cyOtZPIXy3Hmkpa7s47wPviZVmcQoie/clOGOzrbSkboRNq5jDFw1LaTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83B231063;
	Thu, 24 Apr 2025 05:05:24 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B57FC3F59E;
	Thu, 24 Apr 2025 05:05:26 -0700 (PDT)
Date: Thu, 24 Apr 2025 13:05:23 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <20250424130523.6ceecca3@donnerap.manchester.arm.com>
In-Reply-To: <20250424100514-GYA48784@gentoo>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
	<20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
	<aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
	<20250424014120.0d66bd85@minigeek.lan>
	<20250424100514-GYA48784@gentoo>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 10:05:14 +0000
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

> Hi Andrew, Andre,
> 
> On 01:42 Thu 24 Apr     , Andre Przywara wrote:
> > On Wed, 23 Apr 2025 18:58:37 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> > Hi,
> >   
> > > > +&emac0 {
> > > > +	phy-mode = "rgmii";    
> > > 
> > > Does the PCB have extra long clock lines in order to provide the
> > > needed 2ns delay? I guess not, so this should be rgmii-id.  
> > 
> > That's a good point, and it probably true.
> >   
> > >   
> > > > +	phy-handle = <&ext_rgmii_phy>;
> > > > +
> > > > +	allwinner,tx-delay-ps = <300>;
> > > > +	allwinner,rx-delay-ps = <400>;    
> > > 
> > > These are rather low delays, since the standard requires 2ns. Anyway,
> > > once you change phy-mode, you probably don't need these.  
> >   
> As I tested, drop these two properties making ethernet unable to work,
> there might be some space to improve, but currently I'd leave it for now

Yes, I think we need those delays to be programmed into the syscon clock
register, and have been doing so for years.

> > Those go on top of the main 2ns delay, I guess to accommodate some skew
> > between the RX and TX lines, or to account for extra some PCB delay
> > between clock and data? The vendor BSP kernels/DTs program those board
> > specific values, so we have been following suit for a while, for the
> > previous SoCs as well.
> > I just tried, it also works with some variations of those values, but
> > setting tx-delay to 0 stops communication.
> >   
> I'd not bother to try other combinations, and just stick to vendor's settings

I learned to not rely too much on Allwinner BSP settings ;-)

And it's quite easy to experiment, actually: you can write directly to
0x3000030, for instance using devmem or peekpoke, at Linux runtime. Run
some tests or benchmarks, then try a new setting, without rebooting.

Cheers,
Andre.

