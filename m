Return-Path: <netdev+bounces-45440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC037DCFC7
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D771C20895
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 14:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF0410A0A;
	Tue, 31 Oct 2023 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sX7GjokI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587C23A2
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:56:45 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20670E4
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:56:44 -0700 (PDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 29AD7404AC
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1698764202;
	bh=FpYMLQZ13miVSKwRHhEO2KWJ/cMhZ5Lcm8HLU14KOBM=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=sX7GjokIyPfT7ocMf3q5IyOgNF2X5mzUsRXRTerXslKvzApNm/E2MoncESX5yaV+7
	 83OUANO7AMIczA7d7oe++VzH1tMBP9yERk2aUxP3E7xT0KFeuswBBJMg+MeAzOv10o
	 AW80hkMSZaZpySaBzQZ7i0+0Hc9OP0iKzZMpCXgADyYm8GFULX6MLLenvoABocb/mO
	 iO72nXddHVGWBvWF0/uuc8Uu4b0Go40/ii3GkWSfzU67q0EV34+KiuXG6P5BMZInL8
	 tviXWAvnSTlKkX9WGSQkBfyLRVJNRDM32CnRLonp/PZH2JzDWGh3T8Cb83gwCkQPhH
	 aODuX73ze5sqw==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41cb7904d5aso69982661cf.0
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698764199; x=1699368999;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpYMLQZ13miVSKwRHhEO2KWJ/cMhZ5Lcm8HLU14KOBM=;
        b=bY6q54xq4Jjds075jwl0h8ybFDIVGJNwEZHHct6ZTCG9Y8bSJ7+z09fIveFHM2ZMFh
         Q1RxFBk3wAn7bmoLSuVTHSz3ljdoHqF/Hh/PnI3jIig+7YeE0633DuOxBT18QAFL9M2W
         Gdw0wY8ob/o4CoDHCpmbfY53dNg3o4JOVyTa4HJE7esIDyXoZT4bkBDpYhiaH857ZJiq
         PTLAqbU4g3ZbQ6MCBIPQvIXXHYDyeRg2Y+tudDe1NLghIAhmKuily31ymSapbiz9MTtQ
         EbjpfLAbg/X0n+JSLh/dtRzwqF18X+eZUuIaXeeQpLxdjBOUvZUfhx5In4byZpIPETaX
         9e7g==
X-Gm-Message-State: AOJu0Yz3HcGu9VnT7kHsd5aT5o2obu1d/veuHXvjNEUTlnRVawZAA/q/
	L5aoIR7DV+77eP0K8F7JBT/ofPwTLxCl9sDZH970Nef6+9bedVnSSLl5PB3gBJM6nJ+yBt+UKB/
	kQ942DODPPZu1KsV1tDVrENm2FVtLWqbQh3N0PLGE4cGghq6o/Q==
X-Received: by 2002:ac8:7f83:0:b0:41e:204b:f931 with SMTP id z3-20020ac87f83000000b0041e204bf931mr17140701qtj.42.1698764199253;
        Tue, 31 Oct 2023 07:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhxXT6zh5apbHzBARYifBNWbjuGUA0HkX/8LhJMxPXwDzweT07IN3atmh/TMSuRVNN9nyxQvVV4SHG8UkDbZU=
X-Received: by 2002:ac8:7f83:0:b0:41e:204b:f931 with SMTP id
 z3-20020ac87f83000000b0041e204bf931mr17140690qtj.42.1698764198975; Tue, 31
 Oct 2023 07:56:38 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Oct 2023 07:56:38 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <9b8c9846-20be-4cfa-aff5-f9ae8ac2aba4@lunn.ch>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-9-cristian.ciocaltea@collabora.com> <9b8c9846-20be-4cfa-aff5-f9ae8ac2aba4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 31 Oct 2023 07:56:38 -0700
Message-ID: <CAJM55Z_+A1jceB5QWwZ9=roAs7jeAb7E-CEdw3mSOng=jyVDYg@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] riscv: dts: starfive: Add pool for coherent DMA
 memory on JH7100 boards
To: Andrew Lunn <andrew@lunn.ch>, Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Samin Guo <samin.guo@starfivetech.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Andrew Lunn wrote:
> On Sun, Oct 29, 2023 at 06:27:08AM +0200, Cristian Ciocaltea wrote:
> > From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >
> > The StarFive JH7100 SoC has non-coherent device DMAs, but most drivers
> > expect to be able to allocate coherent memory for DMA descriptors and
> > such. However on the JH7100 DDR memory appears twice in the physical
> > memory map, once cached and once uncached:
> >
> >   0x00_8000_0000 - 0x08_7fff_ffff : Off chip DDR memory, cached
> >   0x10_0000_0000 - 0x17_ffff_ffff : Off chip DDR memory, uncached
> >
> > To use this uncached region we create a global DMA memory pool there and
> > reserve the corresponding area in the cached region.
> >
> > However the uncached region is fully above the 32bit address limit, so add
> > a dma-ranges map so the DMA address used for peripherals is still in the
> > regular cached region below the limit.
> >
> > Link: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > ---
> >  .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> > index b93ce351a90f..504c73f01f14 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> > @@ -39,6 +39,30 @@ led-ack {
> >  			label = "ack";
> >  		};
> >  	};
> > +
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		dma-reserved {
> > +			reg = <0x0 0xfa000000 0x0 0x1000000>;
>
> If i'm reading this correctly, this is at the top of the first 4G of
> RAM. But this is jh7100-common.dtsi. Is it guaranteed that all boards
> derived from this have at least 4G? What happens is a board only has
> 2G?

Yes, both the BeagleV Starlight and StarFive VisionFive V1 boards have at least
4G of ram and there won't be any more boards with this SoC. It was a test chip
for the JH7110 after all.

There aren't really any limitations on where this pool could be placed, so I
just chose to wedge it between ranges reserved for graphics by the bootloader.
If anyone has a better idea please go ahead and change it.

>
> It might also be worth putting a comment here about the memory being
> mapped twice. In the ARM world that would be illegal, so its maybe not
> seen that often. Yes, the commit message explains that, but when i
> look at the code on its own, it is less obvious.
>
> > +			no-map;
> > +		};
> > +
> > +		linux,dma {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x10 0x7a000000 0x0 0x1000000>;
> > +			no-map;
> > +			linux,dma-default;
> > +		};
> > +	};

