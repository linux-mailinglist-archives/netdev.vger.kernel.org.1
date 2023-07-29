Return-Path: <netdev+bounces-22553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DF767FBD
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC6E1C20AEA
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B9168B6;
	Sat, 29 Jul 2023 13:52:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5D716435
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 13:52:53 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADD51A2
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 06:52:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bcfe28909so418187566b.3
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690638769; x=1691243569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3e9h1mjHXNaFhhktneoIjNiwNY2p47H6uRSWITeacf8=;
        b=D1w8WthUtE8ehHd3nb4SEpll+SUUhvdWnPQixiZ/dY274mYBgVyWIBGKVAB5ftEM//
         /I8T0jfj+I53Rt7kKUp2TlKdBTfYFm2XudyMCKistf4oGYikg8Otv8TdCf+h8954HQeF
         FZxrTL0gQvx6j45TX3rJ672DDdxGVbtWfCssm6epJNLOTUp5OVl51SZJzXaT47dDdQm9
         4jF/2bdKh8xK1c+nY+sRnZ2BX78F6BAuAyhTxLJl2TnjeIsBq/2fC2fkGHL6dH2G7za/
         Pd8sbareGKAlpqbl5pqMcuoidNqZNk22zH26AlI8QIaj8vqGU88LLS6kGodV3F5xgRKc
         Q6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638769; x=1691243569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3e9h1mjHXNaFhhktneoIjNiwNY2p47H6uRSWITeacf8=;
        b=Nl8r2ppWVvYoPJfC2+7FTW0X8G5kQDyH6l7poKIXprWYLtNUU2ASmpfcfRLz+LC8/h
         geKfx6XWtRCzynf28yicKaGv1Oo86jQuRgAmAzvm7w0GGaWE3FNbU7l6y+dPjSF5d+4R
         Mcdey0IZDMO1lxKMO/NxCJaObQaWpDF+r9/PhUZmoo3qPB5puvteoE7wZ8I1ghS7nQr7
         Pxku0W58ipmPuc3GPPK+gAn5Fnw32/Y7/4dXHGhk6A1W7pYO+hXZxKaz8BsWypmoFTwf
         Elnzv56NAGbrD/cYZsvQxyaxLfxKXOJOgcvN1m8hfUb8AKoh0RUTqFUIWOTtR0sltj/9
         pnBg==
X-Gm-Message-State: ABy/qLYj0BU1bOSuufdAMvGj6EV9FrOcLOrjH5xMc9dIvmJOskfz/Ch/
	eR62Hn4iXd6K2N5W1vaBX9BOlQ==
X-Google-Smtp-Source: APBJJlEsGSrFZkZih0nqPZ7KkzS2vK2oTs+DEAnJxAjBCNeO/gQ2G4zspKF6FrGJ5Xmt0TLCuFYHtA==
X-Received: by 2002:a17:907:7638:b0:997:deb1:ff6a with SMTP id jy24-20020a170907763800b00997deb1ff6amr1870674ejc.22.1690638768934;
        Sat, 29 Jul 2023 06:52:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170906abc600b009828e26e519sm3282832ejb.122.2023.07.29.06.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 06:52:48 -0700 (PDT)
Message-ID: <9cd12d89-b0c1-484f-231e-7b6915f4572b@linaro.org>
Date: Sat, 29 Jul 2023 15:52:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: net: mediatek,net: fixup MAC binding
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230729111045.1779-1-zajec5@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230729111045.1779-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 29/07/2023 13:10, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Use unevaluatedProperties
> It's needed to allow ethernet-controller.yaml properties work correctly.
> 
> 2. Drop unneeded phy-handle/phy-mode
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


