Return-Path: <netdev+bounces-185380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94289A99F86
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 05:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6423B0267
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B81A8403;
	Thu, 24 Apr 2025 03:24:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34319ADA2;
	Thu, 24 Apr 2025 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745465064; cv=none; b=KR6lag/+mhvkJzjiWPCvM+sQbI7QbaGpboEJxiEvUXIc9YmKv+cGsMIE2IPybQjPdFnuJOjVpT5Sdsr1RxhvP+8wE5NCfWhtgf3Ri59y5CYIV8uu9qjW0oN4xTaw2kUuGx0LVyTfIdFUKaMxK4HxBm4v6NLGvvV2KSHNVxteU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745465064; c=relaxed/simple;
	bh=itub4aTQPUiiZAXFKiJAcDWZ7EfwN5bRQbzE2Xx+7yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMceNSrRV154e+jvUI7fYrIMD0GppCJXKnhcOOQheyRh+au4Bn6gl+7TH9DhMc9HnSdoVFaXDEUX5ChfXeqOTqeSAarKo4Ej4BVZ8kFdSr3K9gDF4oFBaCXkb4x+QeX6b/l7tU7fVAxfCpHLMXGOAvAO/13Hpl7sLnb4WzVTFmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C8D4D342FAE;
	Thu, 24 Apr 2025 03:24:21 +0000 (UTC)
Date: Thu, 24 Apr 2025 03:24:17 +0000
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
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <20250424032417-GYA47799@gentoo>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
 <20250424014341.7006ea65@minigeek.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424014341.7006ea65@minigeek.lan>

Hi Andre,

On 01:43 Thu 24 Apr     , Andre Przywara wrote:
> On Wed, 23 Apr 2025 22:03:25 +0800
> Yixun Lan <dlan@gentoo.org> wrote:
> 
> Hi Yixun,
> 
> > On Radxa A5E board, the EMAC0 connect to an external YT8531C PHY,
> > which features a 25MHz crystal, and using PH8 pin as PHY reset.
> > 
> > Tested on A5E board with schematic V1.20.
> 
> Can you please add a name to the /aliases node, to make U-Boot add a
> MAC address?
> 	ethernet0 = &emac0;
> 
> > 
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
> > index 912e1bda974ce5f64c425e371357b1a78b7c13dd..b3399a28badb5172801e47b8a45d5b753fc56ef1 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
> > @@ -54,6 +54,23 @@ &ehci1 {
> >  	status = "okay";
> >  };
> >  
> > +&emac0 {
> > +	phy-mode = "rgmii";
> > +	phy-handle = <&ext_rgmii_phy>;
> 
> Can you please add the phy-supply here, which should be CLDO3? It's
> referenced by other nodes, so would be enabled already,but each node
> should be self-contained.
right, I was about to check and then forgot.. will add it back next version

-- 
Yixun Lan (dlan)

