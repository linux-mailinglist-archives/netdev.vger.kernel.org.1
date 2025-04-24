Return-Path: <netdev+bounces-185382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D9A99F95
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 05:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E8F447B07
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194C1A9B4C;
	Thu, 24 Apr 2025 03:28:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C9519ADA2;
	Thu, 24 Apr 2025 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745465322; cv=none; b=GxnBZnz5+xxgrhK512hoqlNLHbhF8X/GpQBTLremSOketNnylOLM3rhL/rGOJz6nRabIc0ibnHoy4d1iJy1OX7jwJQHmtDUkyI2nRpAY62iHJvGCCogKHdlEe7o2u63ky4ldgmfefhDmZWCWLw+a4c/EkmV5hpQ8oopHplLKVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745465322; c=relaxed/simple;
	bh=I7bN184Qa6b68f8r0qfbTkBDm69Fk0wjcaJ3BS1XiGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXR6lnzI/Y4HMpXtfpKnC5GZoPVm7RzxDtZicyiLXy8K58rJMn4ZrKM1gtE3o10Jz3JbIRpgIYm413xIKzKHQjE7hlu3Zi1oHaJaw91dRc2iQzIa+wFxAiDJghDbcwgd3OlknERS1vzPZdB/PNFkOzirFC/awJDojZTIdyWSJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 55D0D342FED;
	Thu, 24 Apr 2025 03:28:40 +0000 (UTC)
Date: Thu, 24 Apr 2025 03:28:36 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
Message-ID: <20250424032836-GYC47799@gentoo>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-3-46ee4c855e0a@gentoo.org>
 <20250424014314.146e088f@minigeek.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424014314.146e088f@minigeek.lan>

Hi Andre,

On 01:43 Thu 24 Apr     , Andre Przywara wrote:
> On Wed, 23 Apr 2025 22:03:24 +0800
> Yixun Lan <dlan@gentoo.org> wrote:
> 
> Hi Yixun,
> 
> thanks for sending those patches!
> 
> > Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
> > including the A527/T527 chips.
> 
> maybe add here that MAC0 is compatible to the A64, and requires an
> external PHY. And that we only add the RGMII pins for now.
> 
ok

> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 42 ++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > index ee485899ba0af69f32727a53de20051a2e31be1d..c3ba2146c4b45f72c2a5633ec434740d681a21fb 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > @@ -126,6 +126,17 @@ pio: pinctrl@2000000 {
> >  			interrupt-controller;
> >  			#interrupt-cells = <3>;
> >  
> > +			emac0_pins: emac0-pins {
> 
> Both the alias and the node name should contain rgmii instead of emac0,
> as the other SoCs do, I think:
> 			rgmii0_pins: rgmii0-pins {
> 
ok
> > +				pins = "PH0", "PH1", "PH2", "PH3",
> > +					"PH4", "PH5", "PH6", "PH7",
> > +					"PH9", "PH10","PH13","PH14",
> > +					"PH15","PH16","PH17","PH18";
> 
> I think there should be a space behind each comma, and the
> first quotation marks in each line should align.
> 
will do

> PH13 is EPHY-25M, that's the (optional) 25 MHz output clock pin, for
> PHYs without a crystal. That's not controlled by the MAC, so I would
> leave it out of this list, as also both the Avaota and the Radxa don't
> need it. If there will be a user, they can add this separately.
> 
make sense

> > +				allwinner,pinmux = <5>;
> > +				function = "emac0";
> > +				drive-strength = <40>;
> > +				bias-pull-up;
> 
> Shouldn't this be push-pull, so no pull-up?
> 
will drop

> The rest looks correct, when compared to the A523 manual.
> 
thanks for review

-- 
Yixun Lan (dlan)

