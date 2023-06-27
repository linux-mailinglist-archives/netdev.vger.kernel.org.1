Return-Path: <netdev+bounces-14273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D173FDB8
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC584281083
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A881B18B12;
	Tue, 27 Jun 2023 14:23:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991D18B0C
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 14:23:06 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9055D2726
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:23:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991e69499d1so200890366b.2
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687875782; x=1690467782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukf8kcwkmzk9LYwqXTolLjKgBXXfv/auIr6rnxGGo+0=;
        b=lDipDssM6fhnzbxP/+otLf3ADAtXGyAWRBBj5ozeFqK8p3nHDp9UbZapzYCqpThk7A
         V1J32lVWt4v2aH4iJoJdRTJogfKlEk4UUtAz2pYJ9gkn/KsL1MlfUCOlVjqi+Gmc43CR
         XFwHayAXhaF4YsUIm3g1AHDKCYA8Q0kmdoUy1pRvvObgIV565hclnHeyYr9feSaFlnSd
         Wnzx5fFl/9mbdLvb6v/D4KxnfDiGfYQZUbadrZfvgtpKfVY+0LhOTGuxZSUWxzZM433i
         HRx164LS4cDISfoD7dPe6Fc2UfktqMo01/1RtNb/AMUx28tqCsWrljq5OKogYlTi9/SZ
         qzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875782; x=1690467782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukf8kcwkmzk9LYwqXTolLjKgBXXfv/auIr6rnxGGo+0=;
        b=Qhd9DG8BpcQQoRSVl47P1xkM3gqpH4ZOq458+xuAOTvWv1k2iIEz5TVL1Zb+GJeEdZ
         0H8Siez+SYnLZcK0CKQiOWAexmuuFLKJnR4zCDoZaCziCveXuPVKLwTaWBBjUfss59go
         MUJSKenrzRWNj+8xdRh8kvHnpmMgTziHfOl3yy9C47fnPf+ddVUy0rJGdpbCQGw+69zW
         5KUi+Iv1Yrxm9/sgJkfkuZ6TRdfOcU7PISNwUoNE0aAHEGZOFdpfN19lS5mrrsgydt/x
         TDt9gnHInW2igaB5luFqueuS6gmP1843oYNvYLIVtAdm8qusUh+uzcGkKWh2UQXnWth4
         gUrQ==
X-Gm-Message-State: AC+VfDziZI+0ekKsbF/8opBsUvXrfa2HXeykEBWqPFNp0Dyyls7+hBdi
	yq36ZOHljUAvC9dPGd+ln+siGXZbFefTAJ8rBhKIFA==
X-Google-Smtp-Source: ACHHUZ6OV19c18Cv0nNU8zXxPholYkVouLpnSEi8QQ79pSZZvEUYZC9ugwMwAT4QmdwLm8ARWM1TxA==
X-Received: by 2002:a17:907:d1a:b0:988:e223:9566 with SMTP id gn26-20020a1709070d1a00b00988e2239566mr23513151ejc.62.1687875782075;
        Tue, 27 Jun 2023 07:23:02 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id qh15-20020a170906ecaf00b009885462a644sm4575596ejb.215.2023.06.27.07.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:23:01 -0700 (PDT)
Date: Tue, 27 Jun 2023 16:23:00 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vivek Yadav <vivek.2311@samsung.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Message-ID: <20230627142300.heju4qccian5hsjk@blmsp>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
 <20230621123158.fd3pd6i7aefawobf@blmsp>
 <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
 <20230622122339.6tkajdcenj5r3vdm@blmsp>
 <e2cc150b-49e3-7f2f-ce7f-a5982d129346@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2cc150b-49e3-7f2f-ce7f-a5982d129346@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Krzysztof,

On Thu, Jun 22, 2023 at 02:52:48PM +0200, Krzysztof Kozlowski wrote:
> On 22/06/2023 14:23, Markus Schneider-Pargmann wrote:
> >>
> >> Yeah, but your code is different, although maybe we just misunderstood
> >> each other. You wrote that you cannot use the GPIOs, so I assumed you
> >> need to know the variant before using the GPIOs. Then you need
> >> compatibles. It's not the case here. You can read the variant and based
> >> on this skip entirely GPIOs as they are entirely missing.
> > 
> > The version information is always readable for that chip, regardless of
> > state and wake GPIOs as far as I know. So yes it is possible to setup
> > the GPIOs based on the content of the ID register.
> > 
> > I personally would prefer separate compatibles. The binding
> > documentation needs to address that wake and state GPIOs are not
> > available for tcan4552/4553. I think having compatibles that are for
> > these chips would make sense then. However this is my opinion, you are
> > the maintainer.
> 
> We do not talk about compatibles in the bindings here. This is
> discussion about your driver. The entire logic of validating DTB is
> flawed and not needed. Detect the variant and act based on this.

I thought it was about the bindings, sorry.

So to summarize the compatibles ti,tcan4552 and ti,tcan4553 are fine.
But the driver should use the ID register for detection and not compare
the detected variant with the given compatible?

In my opinion it is useful to have an error messages that says there is
something wrong with the devicetree as this can be very helpful for the
developers who bringup new devices. This helps to quickly find issues
with the devicetree.

@Marc: What do you think? Maybe I misinterpreted your mail from last
version?

Best,
Markus

