Return-Path: <netdev+bounces-43892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F9A7D538B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662B51C20BEA
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C202B765;
	Tue, 24 Oct 2023 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11806125DE;
	Tue, 24 Oct 2023 14:00:38 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B6710D4;
	Tue, 24 Oct 2023 07:00:37 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-584042e7f73so2635324eaf.2;
        Tue, 24 Oct 2023 07:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698156037; x=1698760837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4H3TWjIQjf85zyBxIKv34+QRRIwX3a8rnrmF0O3dKsg=;
        b=s/EV7EcOt5icWCFfLL3dpeLoFzNdHnSJC/smlmqm+yWNYlrikJ/9yU9dnlbzWXsmMp
         wF6hiqUxxfH8wshEgsl/YpynM9CMhTcC0lPwetdhE1AFz1sOn0TMIG6U+OkWHU2mNjCS
         hwNkEkF9jTNyhv6YRij8i9EJUjhFu1qLf96gnwE2ANETiznKnNnoTWkoPyJp7qVW2xjL
         8S6hyHfxYoOAcdZiMSHGSP69BlLnXXJ9pfMF3x2LzFmj4YxjKNpfu/y49zgfxActq6YH
         TZ8jvfGDz3XjKMM+dVY7lD0rYjg4LtrHleR5vg1CJjvlnmOymIQarKEF9OJcVP2Ife14
         9Blw==
X-Gm-Message-State: AOJu0YwOGZisC+2dUWFtfZr4/n1zXvn21ZaJ0yiZrC0GNzYQQsscX1XC
	Mw+EzCdJ3gIp7IitlLGh0w==
X-Google-Smtp-Source: AGHT+IH90mhjSMFC6luigjMC7lPfefuM1k+Kx6QDH0HCVGUzuacnelhYBUjr/MSrx7O9d++RvMeWuw==
X-Received: by 2002:a4a:d6c5:0:b0:57b:8ff1:f482 with SMTP id j5-20020a4ad6c5000000b0057b8ff1f482mr12021472oot.0.1698156035973;
        Tue, 24 Oct 2023 07:00:35 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w6-20020a9d6746000000b006ce33ba6474sm1865133otm.4.2023.10.24.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:00:34 -0700 (PDT)
Received: (nullmailer pid 3550335 invoked by uid 1000);
	Tue, 24 Oct 2023 14:00:33 -0000
Date: Tue, 24 Oct 2023 09:00:33 -0500
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] imx6q related DT binding fixes
Message-ID: <20231024140033.GA3544257-robh@kernel.org>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>

On Thu, Aug 10, 2023 at 04:44:45PM +0200, Alexander Stein wrote:
> Hi everyone,
> 
> while working on i.MX6Q based board (arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts)
> I noticed several warnings on dtbs_check. The first 5 patches should be pretty
> much straight forward.
> I'm not 100% sure on the sixth patch, as it might be affected by incorrect
> compatible lists. Please refer to the note in that patch.
> I'm also no sure whether thse patches warrent a Fixes tag, so I only added that
> for patch 3. All of these patches are independent and can be picked up
> individually.
> 
> Best regards,
> Alexander
> 
> Alexander Stein (6):
>   dt-bindings: trivial-devices: Remove national,lm75
>   dt-bindings: imx-thermal: Add #thermal-sensor-cells property
>   dt-bindings: display: imx: hdmi: Allow 'reg' and 'interrupts'
>   dt-bindings: net: microchip: Allow nvmem-cell usage
>   dt-bindings: timer: add imx7d compatible
>   dt-bindings: timer: fsl,imxgpt: Add optional osc_per clock

I noticed this is the top warning for 32-bit i.MX[1] and found this. 
Looks like 5 and 6 never got applied, so I've applied them.

Rob

[1] https://gitlab.com/robherring/linux-dt/-/jobs/5361483372/artifacts/external_file/platform-warnings.log

