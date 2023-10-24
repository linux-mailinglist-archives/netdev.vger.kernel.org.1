Return-Path: <netdev+bounces-44031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140A27D5E52
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFCE1C20CE9
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5231BDD9;
	Tue, 24 Oct 2023 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGsFe9Vw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489502D613;
	Tue, 24 Oct 2023 22:39:39 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B5110C3;
	Tue, 24 Oct 2023 15:39:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso7602615a12.1;
        Tue, 24 Oct 2023 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698187175; x=1698791975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQJA8yhXEYX//p2JnmhaB96Qpjh7PK88vyD48W3Ouu4=;
        b=BGsFe9VwPMm877fvtAUWdqlaOevhH64o7l0035RAlj+Uo1qE5gQlk7dRcnAIhFoqCh
         vLUD4Gi+1ja8GCCX6PVuTSwhYSynPU+2gRndZki7saNeLsLApoVHbpab4zLabW1lznhx
         hjv7ZhfYwp+KGh17HdvYODaL8Bvpb7QDsrXoNeI+UJDB9KndJkPav8TfR5FxMhzg3w9N
         cXgBgRPUTxaw53ldxT947EYz3be1+gn/5dZ84KHeULeiGc1sxpNTs1IRkIB50HJ3achu
         Yvbzmeukuavqs0icJGbLu5piOJ102xFdyXRzQY4TjReFC25YOgqXlWZpXsbWfhlaLkOR
         g2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698187175; x=1698791975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQJA8yhXEYX//p2JnmhaB96Qpjh7PK88vyD48W3Ouu4=;
        b=l1/0iSvbzTl0s8KAWedvr0BGhrkjB+l+ZRN0Qju50UXK1eWOdBBpI+MkVd6GxDFv3e
         b4vuaHBamZg/2IYt8+TTaor9EAn5O+uGYbTsPDIJiFkgAeau2hTWLRxVpLIiqjj+eIY1
         hjqrU47cl3kExrrTQ1mQUi1VeBUrqcvJ/aWluE294LcSfJIb7lB/zlV+09sO7QHmNX9C
         XUJ1W28/+kHYLdvsGc0LXbI+HwDK5VEg/rd7Hi/wgSU5MTGSscef+5wMsAIqivKGBrUt
         p24UsCyr45T9bSLc3OaTiHqPgcWiMyRXi1So3PRBF9mWPsHP7kQQ4Ae3Ab3IcfrHi0Up
         3U5g==
X-Gm-Message-State: AOJu0YwAkhrGXgMGDS5v47sh92If+xIeCIoyh4K0AuTeiIW0yvW0WI8m
	MuMpm0vRPqThIqEZg/KjY7M=
X-Google-Smtp-Source: AGHT+IH8zPhn0PW9jEQ6IfULh/pXtXdH+KK/E1d0UkOCrA7KYP7TJ3MYiiO3t3fPi2vZWI+lqvh/cw==
X-Received: by 2002:a50:9fcc:0:b0:53e:1f06:9676 with SMTP id c70-20020a509fcc000000b0053e1f069676mr10073903edf.37.1698187174774;
        Tue, 24 Oct 2023 15:39:34 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7c68f000000b0053eb9af1e15sm8481053edq.77.2023.10.24.15.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 15:39:34 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:39:32 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzk+dt@kernel.org, arinc.unal@arinc9.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: dsa: realtek: add reset
 controller
Message-ID: <20231024223932.noxpjht2wui7jba2@skbuf>
References: <20231024205805.19314-1-luizluca@gmail.com>
 <20231024205805.19314-3-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024205805.19314-3-luizluca@gmail.com>

On Tue, Oct 24, 2023 at 05:58:06PM -0300, Luiz Angelo Daros de Luca wrote:
> Realtek switches can now be reset using a reset controller.
> 
> The 'reset-gpios' were never mandatory for the driver, although they
> are required for some devices if the switch reset was left asserted by
> a previous driver, such as the bootloader.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---

I believe there was a rule that device tree binding patches should come
before the user of those bindings.

>  Documentation/devicetree/bindings/net/dsa/realtek.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> index cce692f57b08..070821eae2a7 100644
> --- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> @@ -59,6 +59,12 @@ properties:
>      description: GPIO to be used to reset the whole device
>      maxItems: 1
>  
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: switch
> +
>    realtek,disable-leds:
>      type: boolean
>      description: |
> @@ -127,7 +133,6 @@ else:
>      - mdc-gpios
>      - mdio-gpios
>      - mdio
> -    - reset-gpios

Ideally, the change that makes the reset-gpios optional should not be
named "add reset controller", unless it is actually the addition of the
reset controller which makes it optional. Which you say is not the case.
So, I think it should be a separate change.

>  
>  required:
>    - compatible
> -- 
> 2.42.0
> 

I also commented this on the other change: please move the example here.

