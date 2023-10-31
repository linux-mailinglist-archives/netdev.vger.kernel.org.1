Return-Path: <netdev+bounces-45437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E87DCF5C
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B4C280A06
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B31A5AB;
	Tue, 31 Oct 2023 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="X2cLZTD/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE019BAD
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:41:03 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35637ED
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:41:02 -0700 (PDT)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F7AE3F6A0
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1698763258;
	bh=bM2sMwP6Emxus/eSEbKlChfhnru0P5WYRen9BWIIMG8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=X2cLZTD/EvL5niE57t6mvqmMHl3VGajjHMYMfTMCqOcvrbCP/pShUShNXW5OkR33J
	 QWzjLcLOUTWzDyxSeoYXpsfV8P3xZMvT5eE6C9EY14vmEsyuuj1+cTPHV5xyupXvPq
	 3+/lJKIws5d+tC2DSAmAYwDeGPIywzoKT+l11yq+u6RyaN4B7c5MduM+2lLgAdLbJx
	 VCIkMnWzkFZzPm46maRZQUNIGeoPFCwjoGLD95imoevLXcmc3EodH694xXcp6fsD55
	 irsT4TUOylS5xUzIgUWWQLXJ0LYiKqxh2M8MkPj/aYGiAmC/03pYWoQA+z09NYYCIy
	 YVm2ThM7SO9gw==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1e9c2c00182so7535610fac.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698763257; x=1699368057;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bM2sMwP6Emxus/eSEbKlChfhnru0P5WYRen9BWIIMG8=;
        b=YdSmKsw7QPeTFFmhZTSm+k7L3TmhNdf8AtCAW/MTdiC4fzOI0xiIXHkO4qmxFgF7uy
         9zis7HJfF64u5yR5SPjLBtjMKRHaYrHUyWMlENZ+d5yKQjrl1gg01IgvaOiT+TjzEGYp
         i7rNBVrShPWy8l24PqG1nSFe4v83sVYqmNVokAyUfZrpmMlAF8YPI6cjOJDfgZjzFE7q
         1jIGfFNejOze6E3hX7JfDy55boZYzVFLMNniz5A5j+8V8xhH7euvUx+6HEHrSQTt1Xda
         xI+fyx+SMgol0Jz0MmV5Wv53xYBQxs7lTq70uAAEaCr1zuSJQCx6wIwAIenJxCo0tPd7
         GEOQ==
X-Gm-Message-State: AOJu0YyrlHj8DcMWS0lDImKo6a5EEWRNPnr8JJNOhX0SnYHrjHPpjD3x
	QJh5EOcwePnoEUtm64ony3gdu4ltput7vEQYhmy+YRwneXoPpfGowShoHzYfoEOmGTky6ymVl0v
	mx15gU4RpBt8IT1s0fW3SKTL+1M6Dqgw9Gtp68KTZj6VYTshXow==
X-Received: by 2002:a05:6870:1b16:b0:1ef:d51b:5f50 with SMTP id hl22-20020a0568701b1600b001efd51b5f50mr7603582oab.22.1698763257485;
        Tue, 31 Oct 2023 07:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFANyRAH1nXo4IUkrqN1HKuYxzfESQEmdy7ahALAdU7wdendE3vJG+CITZSdHBFI/mTHqrjKI5/+mlEUc3+Ggo=
X-Received: by 2002:a05:6870:1b16:b0:1ef:d51b:5f50 with SMTP id
 hl22-20020a0568701b1600b001efd51b5f50mr7603564oab.22.1698763257269; Tue, 31
 Oct 2023 07:40:57 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Oct 2023 07:40:56 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231029042712.520010-9-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com> <20231029042712.520010-9-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 31 Oct 2023 07:40:56 -0700
Message-ID: <CAJM55Z_2hdsvw8gdYLs2kZbRrH6xcM6+xCZn8BCf5zsWYyhY3w@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] riscv: dts: starfive: Add pool for coherent DMA
 memory on JH7100 boards
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Samin Guo <samin.guo@starfivetech.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Cristian Ciocaltea wrote:
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> The StarFive JH7100 SoC has non-coherent device DMAs, but most drivers
> expect to be able to allocate coherent memory for DMA descriptors and
> such. However on the JH7100 DDR memory appears twice in the physical
> memory map, once cached and once uncached:
>
>   0x00_8000_0000 - 0x08_7fff_ffff : Off chip DDR memory, cached
>   0x10_0000_0000 - 0x17_ffff_ffff : Off chip DDR memory, uncached
>
> To use this uncached region we create a global DMA memory pool there and
> reserve the corresponding area in the cached region.
>
> However the uncached region is fully above the 32bit address limit, so add
> a dma-ranges map so the DMA address used for peripherals is still in the
> regular cached region below the limit.

Adding these nodes to the device tree won't actually do anything without
enabling CONFIG_DMA_GLOBAL_POOL as is done here:

https://github.com/esmil/linux/commit/e14ad9ff67fd51dcc76415d4cc7f3a30ffcba379

>
> Link: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> index b93ce351a90f..504c73f01f14 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> @@ -39,6 +39,30 @@ led-ack {
>  			label = "ack";
>  		};
>  	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		dma-reserved {
> +			reg = <0x0 0xfa000000 0x0 0x1000000>;
> +			no-map;
> +		};
> +
> +		linux,dma {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10 0x7a000000 0x0 0x1000000>;
> +			no-map;
> +			linux,dma-default;
> +		};
> +	};
> +
> +	soc {
> +		dma-ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x7a000000>,
> +			     <0x00 0xfa000000 0x10 0x7a000000 0x00 0x01000000>,
> +			     <0x00 0xfb000000 0x00 0xfb000000 0x07 0x85000000>;
> +	};
>  };
>
>  &gpio {
> --
> 2.42.0
>

