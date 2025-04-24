Return-Path: <netdev+bounces-185381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6391AA99F8A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 05:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32123B869F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A561A3BC0;
	Thu, 24 Apr 2025 03:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A542A82;
	Thu, 24 Apr 2025 03:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745465111; cv=none; b=U5RB7/iJvPUDQ92GUe5QiUbFySu14UI4b/I8FrNvCZCbe1f9zHF+TRdTogrdwit1hdXlUbea7N8B7eq+OSWWAhZ8lSqCgj7ZK40d5GhAYMUIeeCvT32Nxpw9WL4BkLz9CCzYcbwF4Zqqz5A0C38yBMd88M0mvMwoynzZ+TJPAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745465111; c=relaxed/simple;
	bh=fmK306GqM09TGZOU24Fy14i1C+SkYrZmUh5ZU5CZGW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/Adyky9w9zU9m+Eo6xtYMvrsjOb1RqpeMWEC0AqJR1gJLcgHLqWzLT14C+Ya7O6Gv+W9LVfoh1y3xGVO9m9pno8e/IASAEsL4MQgxUKeF3rQHSYCbwGXQMPsDP0kNpsrVslzGhujnbE0eILPtp/9gjo9oSsV8skQ+xvAXyzwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4ED3333BE00;
	Thu, 24 Apr 2025 03:25:09 +0000 (UTC)
Date: Thu, 24 Apr 2025 03:25:05 +0000
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
Subject: Re: [PATCH 5/5] arm64: dts: allwinner: t527: add EMAC0 to Avaoto-A1
 board
Message-ID: <20250424032505-GYB47799@gentoo>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-5-46ee4c855e0a@gentoo.org>
 <20250424021706.22eaab66@minigeek.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424021706.22eaab66@minigeek.lan>

hi Andre,

On 02:17 Thu 24 Apr     , Andre Przywara wrote:
> On Wed, 23 Apr 2025 22:03:26 +0800
> Yixun Lan <dlan@gentoo.org> wrote:
> 
> Hi,
> 
> > On Avaoto A1 board, the EMAC0 connect to an external RTL8211F-CG PHY,
> 
> The name would be "Avaota" A1 board.
> 
> > which features a 25MHz crystal, and using PH8 pin as PHY reset.
> > 
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> > I don't own this board, only compose this patch according to the
> > schematics. Let me know if it works.
> > ---
> >  arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> > index 85a546aecdbe149d6bad10327fca1fb7dafff6ad..23ab89c742c679fb274babbb0205f119eb2c9baa 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> > @@ -64,6 +64,23 @@ &ehci1 {
> >  	status = "okay";
> >  };
> 
> As for the Radxa board, we need an alias for ethernet0.
> 
> >  
> > +&emac0 {
> > +	phy-mode = "rgmii";
> 
> As Andrew mentioned, this should probably be "rgmii-id".
> 
> > +	phy-handle = <&ext_rgmii_phy>;
> 
> Can you please add the phy-supply here, it's reg_dcdc4.
> 
> Cheers,
> Andre
> 
> > +
> > +	allwinner,tx-delay-ps = <100>;
> > +	allwinner,rx-delay-ps = <300>;
> > +
> > +	status = "okay";
> > +};
> > +
> > +&mdio0 {
> > +	ext_rgmii_phy: ethernet-phy@1 {
> > +		compatible = "ethernet-phy-ieee802.3-c22";
> > +		reg = <1>;
> > +	};
> > +};
> > +
> >  &mmc0 {
> >  	vmmc-supply = <&reg_cldo3>;
> >  	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_DOWN)>; /* PF6 */
> > 
> 

all above comments make sense, will address in next version
-- 
Yixun Lan (dlan)

