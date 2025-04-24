Return-Path: <netdev+bounces-185352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC4A99DF1
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CCA5A5022
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632FC128819;
	Thu, 24 Apr 2025 01:18:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB0AD21;
	Thu, 24 Apr 2025 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745457520; cv=none; b=T3DS/5eW44JPVKupZXytaHV6LGgZ9+jsiIKk2syMFY1Ztu9iYEeSqnzQvIv7Q/jPuSL4+ha7fSEDKnGf2EssiZ8/CapYECLptyLn/4dvjtuzHZ3cHjxZrIcBaBf4NZiBNB4uRMMmixj3WoM07G4YSYZq6bhBmeywn2PnJz6ylEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745457520; c=relaxed/simple;
	bh=6QsNkW8RggGxROGxeCbIql2iwtqZ02C3h5q0Gelldzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8AIk2Cbo3s6fhtH9N3AWZoh2haP7x3jMvL7BrmEOtzJbVnm53Y1LUBV3v82UHLhgA85ZZaOGDayMMQmnBHGdYDKoANWimMrRza44loNAABgAfMS7me0Uooq3YzsUPdXGraPtvBopn5F0fyx/cRNIG8MN1crWhM+zwrn1eIauok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9F141063;
	Wed, 23 Apr 2025 18:18:31 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57A833F5A1;
	Wed, 23 Apr 2025 18:18:34 -0700 (PDT)
Date: Thu, 24 Apr 2025 02:17:26 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: allwinner: t527: add EMAC0 to Avaoto-A1
 board
Message-ID: <20250424021706.22eaab66@minigeek.lan>
In-Reply-To: <20250423-01-sun55i-emac0-v1-5-46ee4c855e0a@gentoo.org>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
	<20250423-01-sun55i-emac0-v1-5-46ee4c855e0a@gentoo.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 22:03:26 +0800
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

> On Avaoto A1 board, the EMAC0 connect to an external RTL8211F-CG PHY,

The name would be "Avaota" A1 board.

> which features a 25MHz crystal, and using PH8 pin as PHY reset.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> I don't own this board, only compose this patch according to the
> schematics. Let me know if it works.
> ---
>  arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> index 85a546aecdbe149d6bad10327fca1fb7dafff6ad..23ab89c742c679fb274babbb0205f119eb2c9baa 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> @@ -64,6 +64,23 @@ &ehci1 {
>  	status = "okay";
>  };

As for the Radxa board, we need an alias for ethernet0.

>  
> +&emac0 {
> +	phy-mode = "rgmii";

As Andrew mentioned, this should probably be "rgmii-id".

> +	phy-handle = <&ext_rgmii_phy>;

Can you please add the phy-supply here, it's reg_dcdc4.

Cheers,
Andre

> +
> +	allwinner,tx-delay-ps = <100>;
> +	allwinner,rx-delay-ps = <300>;
> +
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +	};
> +};
> +
>  &mmc0 {
>  	vmmc-supply = <&reg_cldo3>;
>  	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_DOWN)>; /* PF6 */
> 


