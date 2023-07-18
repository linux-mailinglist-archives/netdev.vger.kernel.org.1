Return-Path: <netdev+bounces-18501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF808757621
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C47C1C20915
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6798DC8D8;
	Tue, 18 Jul 2023 08:01:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF45C8C4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:01:33 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F2B1715
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 01:01:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fdbfda94c4so2966255e87.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 01:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689667216; x=1692259216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0TMF8KkLHgIjjvuu9yRbShpISudcqJyFHmRqyTxc6O4=;
        b=jWuqqDtk3x6ktCQ+Glsyd2kL95uhDESKBMrQtRQ58ong17rYZworF6J3gSwDGvrOaQ
         09qHQCiL3V2B2BS/Oz8xm35SNQ8TMdBUSlk87J8GduCn9Wfu02wJGuKxFO+9plxPhHXu
         3TgtvZFt0v/WvpIURdO8NY3dgcerNOX1LIG6KSM0SkW4PRs/aSEswYlWBOn/OrKzTUhU
         Q/HFw+2oRp3N6TcWPL07pBqki4dfTuKCjbKXFdTMfc969Sviha2bpkEEhw/7p5GqTNEP
         CryarmLHTFBJSpXFfvz2q7455VMybZIJl9joGPMX1JBSj2xq1x/fEHXKicz3z7rO4+uH
         HRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667216; x=1692259216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TMF8KkLHgIjjvuu9yRbShpISudcqJyFHmRqyTxc6O4=;
        b=SttU4LjWtgNCKPgXbjrK6khz+IXqCtLhOsTfCOK+v1GHS8VWq9MN/7zWPWYufHlipz
         ufEK4qK29MJZec3Aslbk7kK0lNNQmPtvoGOWozFY94usZMe5NfxaGlHbFyS6Wr2VJIWE
         flwhvWsNv2F/2DZiAouC9WS8BoC7u2jA46wy8h0jmqeWDIj+G6WXAhwoQPj+Hqra8C8V
         KEBgE/9/4f8mj5BMzh4ZDQUKJ0RrhW076NPQpwF7jL6fzpFoGuwFKEkaU5X6VJ0+ZJxc
         NF1aYTsx4E7L0rpTG6nvplkft4tDLW7zO7RS9er65LYbacna0zgfdUtPCB6FnA6Pwzdb
         WgDg==
X-Gm-Message-State: ABy/qLbIU2TZLE+EYTMiltkYKprR2jVT02zOR6I6Vt5u6oCarqqBWGQR
	4jbH7Mxo2F9Kixctr+lJ7P6QQlvdMFgskc4/jV++iQ==
X-Google-Smtp-Source: APBJJlHk3u4MdO8axVsUFrnEBFxv5a8PaAepGuSbyIx6Wu0c1NWLR2Yv9yDhcPOpldRKz2pvU9g3mA==
X-Received: by 2002:a05:6512:3d03:b0:4fb:8f79:631 with SMTP id d3-20020a0565123d0300b004fb8f790631mr18681248lfv.46.1689667216606;
        Tue, 18 Jul 2023 01:00:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k23-20020aa7c397000000b0051d9dbf5edfsm825879edq.55.2023.07.18.01.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:00:16 -0700 (PDT)
Message-ID: <9ac33c64-337d-d9b6-275c-94942797e5a4@linaro.org>
Date: Tue, 18 Jul 2023 10:00:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: add phy-supply
 support
Content-Language: en-US
To: Marco Felsch <m.felsch@pengutronix.de>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717164307.2868264-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/07/2023 18:43, Marco Felsch wrote:
> Document the common phy-supply property to be able to specify a phy
> regulator.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


