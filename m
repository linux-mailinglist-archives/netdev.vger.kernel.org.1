Return-Path: <netdev+bounces-185868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1383FA9BF2B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6024117718A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523E22DF91;
	Fri, 25 Apr 2025 07:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFDB22A801;
	Fri, 25 Apr 2025 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564787; cv=none; b=izAwf7wKAtLXjPDuP6ohpkm3CscccsbArmfndaenxLvNJXUlpbkaiZQp6Rrdvia6mx2HQInR3KJOZmnIrj+f92enVHe0ahkeBplC36bcTMUW0GSBmDZfQgCocpUA+Cxt/a7eDf7LpruhcsPML9HQQzvw93bNcYMtnbMhBrKZZAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564787; c=relaxed/simple;
	bh=ctvHIsXYgGV/juygw8FG9JQyVXTMWfgzu1EuIdKbLnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHoTLrKHX555rxAN6v9uNEBp5mLgwtreQd8W0WoBPW/qE+wcyTBkzbo7vPjh7tqRoJYMtIfmL/GVQo+nggH97wskNl+gPmy5CLCTvWvPtVnW331o/Dwmz+93VUAR/IT+7mDIOa3K2c+PzYQU+er5WA10W/wPBt59DAJ5wMAPwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id CE285340BEA;
	Fri, 25 Apr 2025 07:06:24 +0000 (UTC)
Date: Fri, 25 Apr 2025 07:06:20 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet
 MAC
Message-ID: <20250425070120-GYB50408@gentoo>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
 <20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org>
 <CAGb2v66a4ERAf_YhPkMWJjm26SsfjO3ze_Zp=QqkXNDLaLnBRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v66a4ERAf_YhPkMWJjm26SsfjO3ze_Zp=QqkXNDLaLnBRg@mail.gmail.com>

Hi Chen-Yu,

On 13:26 Fri 25 Apr     , Chen-Yu Tsai wrote:
> On Thu, Apr 24, 2025 at 6:09 PM Yixun Lan <dlan@gentoo.org> wrote:
> >
> > Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
> > including the A527/T527 chips. MAC0 is compatible to the A64 chip which
> > requires an external PHY. This patch only add RGMII pins for now.
> >
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 40 ++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > index ee485899ba0af69f32727a53de20051a2e31be1d..c9a9b9dd479af05ba22fe9d783e32f6d61a74ef7 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > @@ -126,6 +126,15 @@ pio: pinctrl@2000000 {
> >                         interrupt-controller;
> >                         #interrupt-cells = <3>;
> >
> > +                       rgmii0_pins: rgmii0-pins {
> > +                               pins = "PH0", "PH1", "PH2", "PH3", "PH4",
> > +                                      "PH5", "PH6", "PH7", "PH9", "PH10",
> > +                                      "PH14", "PH15", "PH16", "PH17", "PH18";
> > +                               allwinner,pinmux = <5>;
> > +                               function = "emac0";
> > +                               drive-strength = <40>;
> 
> We should probably add
> 
>                                   bias-disable;
> 
> to explicitly turn off pull-up and pull-down.
> 
I will test this and address in v3
(saw your comment in v1, but I sent v2 too quickly)

-- 
Yixun Lan (dlan)

