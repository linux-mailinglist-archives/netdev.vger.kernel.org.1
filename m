Return-Path: <netdev+bounces-51150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125007F956E
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 22:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CD9280CC2
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6968C12E78;
	Sun, 26 Nov 2023 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uxNgOXms"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF657DE
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 13:11:01 -0800 (PST)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C11B741529
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 21:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701033059;
	bh=rvglDuo/fTyCEy2eZikNSrK0RCDTjL208TqZkqJiFe0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=uxNgOXms3kTtZrV9UKovibbt5fnciZ8qdyZ4o64IQpe4AEf3FgVDO6mokn3arw580
	 qFxi1lxD8QcBJ2MKaGszWdV3s7H9T0Pzd2d36/1/bfFobK4wyZ/yBY2IDMdOZz+cBj
	 aN95HuWTNXmyMrq3WMzuqZ71tTp66X8JpJ9e81D1mPm0eR7mLqHOWK+5iCo/jQqJF6
	 Wz2LhlmkxpMopSt/remgbiMLpWJCDzqCosdN1BZGkIFZ4HFzq27Upi3QUUD6Mtr9Xt
	 6962AVK98Dm0xXrBb3CuYGkIiihffdBBZSzlb4FnvAtmFVhPOL6CjTKY3PRO+SYBnp
	 SI0plRoW99sFA==
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67a0f1be799so31961256d6.2
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 13:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701033059; x=1701637859;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvglDuo/fTyCEy2eZikNSrK0RCDTjL208TqZkqJiFe0=;
        b=Nnsl3XPrxQI/Xilrdc2w+IZGK2VR6Xsz1jxMpdfzf/VauED/jATEQsonrVK+fWnEKD
         qdwZI1+6jOzcrGf1BieEKxei1GA1iYseOLb5HPnkgYgcMFpskflg7GYeKJQWli+TWMcq
         7u6+ExN95beTOsXN7YFh3gb2cpLXGpT7nNJdEmTy+kPvF7QfsnAfYfjVjxV3kA2V2QOb
         euSJzcKy1F9tLP9kRI9kp80I9cap5Yumm2LYqcejScJmpJ/NgDVEbvIlLoNdLKJdrdNS
         jJ85BGYFQbRkuFCaknBQOUffDSCV3XIE4Khj6TGaYijTW0EnwVVecAEm2uWD2lhkjcJM
         z3RQ==
X-Gm-Message-State: AOJu0YwL8OO6b23BIE5mKUI2Ujt1wFaOkzQs5CkzamoAZ0ssrahe1Syv
	nGKdXTMjXVm8o3cv+jIysgXkSkc24M0+e6Pw/VNTPuw826ct0+kGjp294EfDrQA25UKW8EXjPX/
	24Om2nhMmJiTFI52JXYg73qrjbg9Nzwaj6LBbpWG2NVtGmM7kSA==
X-Received: by 2002:a0c:e241:0:b0:679:2f94:865c with SMTP id x1-20020a0ce241000000b006792f94865cmr10212328qvl.2.1701033058735;
        Sun, 26 Nov 2023 13:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYWNxo8Vh6oRaTbtMwPUh8NeMnB/m/b1dccmMlQVlfIUn9lkEBCVo+foSjrK/Vattp6N8+q2aLZGzM4wRhZ9g=
X-Received: by 2002:a0c:e241:0:b0:679:2f94:865c with SMTP id
 x1-20020a0ce241000000b006792f94865cmr10212317qvl.2.1701033058505; Sun, 26 Nov
 2023 13:10:58 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 26 Nov 2023 22:10:57 +0100
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com> <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 26 Nov 2023 22:10:57 +0100
Message-ID: <CAJM55Z9e=vjGKNnmURN15mvXo2bVd3igBA-3puF9q7eh5hiP+A@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
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
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

Cristian Ciocaltea wrote:
> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
> RGMII-ID.
>
> TODO: Verify if manual adjustment of the RX internal delay is needed. If
> yes, add the mdio & phy sub-nodes.

Sorry for being late here. I've tested that removing the mdio and phy nodes on
the the Starlight board works fine, but the rx-internal-delay-ps = <900>
property not needed on any of my VisionFive V1 boards either. So I wonder why
you need that on your board

Also in the driver patch you add support for phy-mode = "rgmii-txid", but here
you still set it to "rgmii-id", so which is it?

You've alse removed the phy reset gpio on the Starlight board:

  snps,reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>

Why?

>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> index 7cda3a89020a..d3f4c99d98da 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> @@ -11,3 +11,8 @@ / {
>  	model = "BeagleV Starlight Beta";
>  	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
>  };
> +
> +&gmac {
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};

Lastly the phy-mode and status are the same for the VF1 and Starlight boards,
so why can't these be set in the jh7100-common.dtsi?

/Emil

> --
> 2.42.0
>

