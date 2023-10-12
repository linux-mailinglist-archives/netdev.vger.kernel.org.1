Return-Path: <netdev+bounces-40388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B1E7C7197
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B171C20FC2
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12C27ECA;
	Thu, 12 Oct 2023 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLW1QH4G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759B27EC1
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:34:59 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E59DA
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 08:34:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405524e6768so11827345e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124894; x=1697729694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlYbARuGOvayK2I8gPmBtlTVphiwdBhXgzXNKnIpdgQ=;
        b=dLW1QH4GEbS/jBNDsbmYOlK/rKTpAsNIBuwxsxTRwtfus1bRVn42gzcGT/NXKTRcr7
         his/elYT+j9sk4RTtLsIxv76EOrp6T+wJnsPVnCmhsCznjOnP+CQLCOPKBwClGvSSi7d
         rLmUILReAbJ8dPushIZIb26vpaqX8StdpCOxquQ0r4qxim8ij5qu5sgBZ4iCYJPSbJud
         BrBcRa5DHU575qBGqPqlooRYEa3i8BNfwaYboe71JNMGyIDmdIEt6ntF+mjJW45uupYB
         XsKWGwWb1PAt0mSvz/STYgV7e7wj78zNMyCjUy9BSf/L1cx8v97RaKpwvWn4vmNWEYAO
         J2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124894; x=1697729694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlYbARuGOvayK2I8gPmBtlTVphiwdBhXgzXNKnIpdgQ=;
        b=icJk50ARlQwvgnzPK6fFZqm00DYxGhJPJ2eGGXi0BodLtOg/uoEErKRX5NSGCObbpv
         UXOAEe8buODCz4qV8F5Nq0llmjThGQS6ZlfXeGJggNtcNseXzRptFzRwpKEJ5jArZwLM
         kvv/dgZFe4wnTE5608fzI71eOkIBSdpN3L14iermYCXrDUexhqo6dz39EbSCn4nO/961
         olky8RuFsTBkznu7w7qYQHbFzsxLd5FbujIWXB3sPuayE8x5nZy/kxmuPe9ElFthxbhd
         y6LMIulzOHtp2i8YKxlkezGWP+2T0wbCYXOWmDchcHS1trbVGPa9WBFshD+cA9pswmPy
         Ppww==
X-Gm-Message-State: AOJu0YwCie+vKaNJImbJfHKOsoBvuLxF/JPRf5iUbNMrfwicycoY6m/X
	fYKrs7Or5xSw0ppN1MOsFSt5+g==
X-Google-Smtp-Source: AGHT+IGg2dDbelEwQ6AKXVaNt6xSv454CPd0Ugdfj//8oRMrxMj2ciXjjzeqOjOTyIL2fKUpCJJCrg==
X-Received: by 2002:a1c:7917:0:b0:405:3d27:70e8 with SMTP id l23-20020a1c7917000000b004053d2770e8mr20865780wme.36.1697124894284;
        Thu, 12 Oct 2023 08:34:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id x3-20020a05600c21c300b004053a6b8c41sm135419wmj.12.2023.10.12.08.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:34:53 -0700 (PDT)
Message-ID: <c8cf0994-be7f-4ed0-9e9e-a2f81fd9709a@linaro.org>
Date: Thu, 12 Oct 2023 17:34:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] imx6q related DT binding fixes
Content-Language: en-US
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20231012080033.2715241-1-alexander.stein@ew.tq-group.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231012080033.2715241-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/10/2023 10:00, Alexander Stein wrote:
> Hi everyone,
> 
> while working on i.MX6Q based board (arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts)
> I noticed several warnings on dtbs_check.
> I'm also not sure whether thse patches warrent a Fixes tag, so I only added that
> for patch 3. All of these patches are independent and can be picked up
> individually.
> 
> Patches already merged:
> * 0268e1ae25949 ("dt-bindings: trivial-devices: Remove national,lm75")
> * 57db57ae15a97 ("dt-bindings: display: fsl,imx6-hdmi: Change to 'unevaluatedProperties: false'")
>    which deprecates v1 patch 3

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


