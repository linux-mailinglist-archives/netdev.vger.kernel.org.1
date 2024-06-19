Return-Path: <netdev+bounces-105021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2C790F735
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552D91F236C0
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA27158A3B;
	Wed, 19 Jun 2024 19:53:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049C1876;
	Wed, 19 Jun 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718826783; cv=none; b=hZaCC5ZDy53/5yOYS/ZpIVRXGLZt01SRXaNVI4l1p4B6C06BuvZL0/K/2vR6IuE0G/s6EFLjIjQjb53ux2NIy2hwrWlsSbR4KYnnd3HZk96lXz0V98OmRWA2YJL43iEYIjyIXSCIR2Ju5S9OAMhuoChqKTvNtvqOXnGglcn240k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718826783; c=relaxed/simple;
	bh=hAa58ykzdUm4sWV2raSDGbF4KtGeoHp4ZJ5LE2Yj+2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRCFfllUQwzvX6qlLY7SmbYwtOaEfyLQCbReS2nNz9S7QSVQx5OIUxHuyOSfezqBc9bNu/pvtx9+Np9EgyZB5/7esPF56Jsbkt2ENV8aJvvlo76ve2cKC/8BUwlIC5Ghe6DgBlnBAqlnF/ZiQSdXph2m55O8v00Of/ouoACiC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616dc.versanet.de ([94.134.22.220] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sK1ML-0000cJ-Uc; Wed, 19 Jun 2024 21:52:45 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] ARM: dts: rockchip: rk3xxx: fix emac node
Date: Wed, 19 Jun 2024 21:52:44 +0200
Message-ID: <24211354.RjEADstKbi@diego>
In-Reply-To: <12f50bef-ba6e-4d96-8ced-08682c931da9@gmail.com>
References:
 <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
 <12f50bef-ba6e-4d96-8ced-08682c931da9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 18. Juni 2024, 18:13:56 CEST schrieb Johan Jonker:
> In the combined DT of rk3066a/rk3188 the emac node uses as place holder
> the compatible string "snps,arc-emac". The last real user nSIM_700
> of the "snps,arc-emac" compatible string in a driver was removed in 2019.
> Rockchip emac nodes don't make use of this common fall back string.
> In order to removed unused driver code replace this string with
> "rockchip,rk3066-emac".
> As we are there remove the blank lines and sort.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I think this is fine going through the network tree together with the
other two patches.


> ---
> 
> [PATCH 8/8] ARC: nSIM_700: remove unused network options
> https://lore.kernel.org/all/20191023124417.5770-9-Eugeniy.Paltsev@synopsys.com/
> ---
>  arch/arm/boot/dts/rockchip/rk3066a.dtsi | 4 ----
>  arch/arm/boot/dts/rockchip/rk3xxx.dtsi  | 7 ++-----
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rockchip/rk3066a.dtsi b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
> index 5e0750547ab5..3f6d49459734 100644
> --- a/arch/arm/boot/dts/rockchip/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
> @@ -896,7 +896,3 @@ &vpu {
>  &wdt {
>  	compatible = "rockchip,rk3066-wdt", "snps,dw-wdt";
>  };
> -
> -&emac {
> -	compatible = "rockchip,rk3066-emac";
> -};
> diff --git a/arch/arm/boot/dts/rockchip/rk3xxx.dtsi b/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
> index f37137f298d5..e6a78bcf9163 100644
> --- a/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
> +++ b/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
> @@ -194,17 +194,14 @@ usb_host: usb@101c0000 {
>  	};
> 
>  	emac: ethernet@10204000 {
> -		compatible = "snps,arc-emac";
> +		compatible = "rockchip,rk3066-emac";
>  		reg = <0x10204000 0x3c>;
>  		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		rockchip,grf = <&grf>;
> -
>  		clocks = <&cru HCLK_EMAC>, <&cru SCLK_MAC>;
>  		clock-names = "hclk", "macref";
>  		max-speed = <100>;
>  		phy-mode = "rmii";
> -
> +		rockchip,grf = <&grf>;
>  		status = "disabled";
>  	};
> 
> --
> 2.39.2
> 
> 





