Return-Path: <netdev+bounces-59236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448E681A00E
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79111F288F6
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A417536B1D;
	Wed, 20 Dec 2023 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wVOVwppj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0DC38DDA
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D941C3F04D
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703079833;
	bh=Y1f83Xk1FXiEYRkgnz968I1hevI4AFt+heHnZvXG1Zs=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=wVOVwppjEhWBqwG8C/NIn0EvOKlcx49X1Lnu9kdJ9XGApUWmnhN8VYsRag8fr5jNN
	 Q0+pse50GzLMNZMkrqfXnrZEju6Wb+v3E1OXJ92XWFSnzuautJZ2wqgHuX7myxf81t
	 XHNl/RN132P3g3luJ5zh8UrxVZ0c0ceUO9yp4pYhrnaIvvEnQ87xbMKVzBQ7nt/hC5
	 8VIFao3mze6UVa+uQGHcpDcKoJhZuixa9cCfPY2Uiov6wxU4oZ2v4lj8eBlyy6wrf4
	 n9VMVF2ezU564gqjrU1FCy6CGHVgUi5ClPsIgJV5jcCp7jKTkCYyA+7fm6lskLAoU2
	 tTEaVnWhepxaw==
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-67ef53b1f17so95026536d6.3
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 05:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703079833; x=1703684633;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1f83Xk1FXiEYRkgnz968I1hevI4AFt+heHnZvXG1Zs=;
        b=fSi1z+Y+ayT4u9HObJoGpnNEHwWv1cocg3NzsphRLW7O13p8224ycy8IMoOdhe9/nx
         LQZOjxMAO0AHbgB8JDUcH0xnK/nYmXgOENAODZGfeqZPeia54F90Nkgu3HNrK6Et43V+
         wTsbofDTWMfNYaPKmfD8W1r0o2FnUTaJS9JgA12PBxcI/wkKCUUFBZOPgbt4JXOxBXGl
         vp90M3TI1P1RDHR/53rMWmaZsGURyMoQ8Z+6O7fd5/WmiZPyzb4M3XkTA+KaiM6KeMmc
         woSPN6+83ygLRBC0pAVHqwWzdXPs11xY4WFXVuwHQoKfEgJVeeDfjXbjkYIm0WchmbXJ
         gxTg==
X-Gm-Message-State: AOJu0YyjTvU5sCk4gpafX+D54i//2n/Qr4omuY7k6M1pwYzBCLzIKPbu
	SAIcJJwYMCjkiOc0F2q+mPQHQ2zsQZKwD813eZF6abK4b/Pjd8ZKLjnIkvb1LYd3yZJQewwhwsE
	gK202Nvuh32YVXCbrxMnusxm0gPcvCRMJdOOpDKHwZrcLsp7Oaw==
X-Received: by 2002:a05:622a:1309:b0:423:98ba:1f74 with SMTP id v9-20020a05622a130900b0042398ba1f74mr24124823qtk.58.1703079832882;
        Wed, 20 Dec 2023 05:43:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErFMRLbKaj/fBOTAz8xHWWCImycUAmeJWguwHtKgu7CB99Ci5H8wT1jkWzCEL4aBoSuGhJ//HhYBVROra6w1I=
X-Received: by 2002:a05:622a:1309:b0:423:98ba:1f74 with SMTP id
 v9-20020a05622a130900b0042398ba1f74mr24124813qtk.58.1703079832635; Wed, 20
 Dec 2023 05:43:52 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Dec 2023 05:43:52 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231220004638.2463643-2-cristian.ciocaltea@collabora.com>
References: <20231220004638.2463643-1-cristian.ciocaltea@collabora.com> <20231220004638.2463643-2-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 20 Dec 2023 05:43:52 -0800
Message-ID: <CAJM55Z9DhojDTDPEqx3NO5g61=ezRg-U9odixbZugcXRRVmS7w@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] riscv: dts: starfive: jh7100: Add sysmain and gmac
 DT nodes
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel@collabora.com, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Cristian Ciocaltea wrote:
> Provide the sysmain and gmac DT nodes supporting the DWMAC found on the
> StarFive JH7100 SoC.
>
> Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7100.dtsi | 36 ++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> index c216aaecac53..2ebdebe6a81c 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -204,6 +204,37 @@ sdio1: mmc@10010000 {
>  			status = "disabled";
>  		};
>
> +		gmac: ethernet@10020000 {
> +			compatible = "starfive,jh7100-dwmac", "snps,dwmac";
> +			reg = <0x0 0x10020000 0x0 0x10000>;
> +			clocks = <&clkgen JH7100_CLK_GMAC_ROOT_DIV>,
> +				 <&clkgen JH7100_CLK_GMAC_AHB>,
> +				 <&clkgen JH7100_CLK_GMAC_PTP_REF>,
> +				 <&clkgen JH7100_CLK_GMAC_TX_INV>,
> +				 <&clkgen JH7100_CLK_GMAC_GTX>;
> +			clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "gtx";
> +			resets = <&rstgen JH7100_RSTN_GMAC_AHB>;
> +			reset-names = "ahb";
> +			interrupts = <6>, <7>;
> +			interrupt-names = "macirq", "eth_wake_irq";
> +			max-frame-size = <9000>;
> +			snps,multicast-filter-bins = <32>;
> +			snps,perfect-filter-entries = <128>;
> +			starfive,syscon = <&sysmain 0x70 0>;
> +			rx-fifo-depth = <32768>;
> +			tx-fifo-depth = <16384>;
> +			snps,axi-config = <&stmmac_axi_setup>;
> +			snps,fixed-burst;
> +			snps,force_thresh_dma_mode;

Compared to v4 you're missing a

  snps,no-pbl-x8;

here. It might be the right thing to do, but then I would have expected
it to me mentioned in the cover letter version history.

> +			status = "disabled";
> +
> +			stmmac_axi_setup: stmmac-axi-config {
> +				snps,wr_osr_lmt = <16>;
> +				snps,rd_osr_lmt = <16>;
> +				snps,blen = <256 128 64 32 0 0 0>;
> +			};
> +		};
> +
>  		clkgen: clock-controller@11800000 {
>  			compatible = "starfive,jh7100-clkgen";
>  			reg = <0x0 0x11800000 0x0 0x10000>;
> @@ -218,6 +249,11 @@ rstgen: reset-controller@11840000 {
>  			#reset-cells = <1>;
>  		};
>
> +		sysmain: syscon@11850000 {
> +			compatible = "starfive,jh7100-sysmain", "syscon";
> +			reg = <0x0 0x11850000 0x0 0x10000>;
> +		};
> +
>  		i2c0: i2c@118b0000 {
>  			compatible = "snps,designware-i2c";
>  			reg = <0x0 0x118b0000 0x0 0x10000>;
> --
> 2.43.0
>

