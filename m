Return-Path: <netdev+bounces-29938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0045785482
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B97D2812C0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4128A954;
	Wed, 23 Aug 2023 09:47:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745DA946
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 09:47:24 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0514210CE
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:47:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50091b91a83so1739543e87.3
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692784041; x=1693388841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJYxY9EKyE3nWLrlKwhz/hBGJk5NPLW4fkCZ4lrsGEw=;
        b=bw5w4gl/4vvhu25m5/SOpPCnGec9H3hlKTxmBMwAlXDijKxzcKALGzp/upD4QCDV2E
         YcgEph4FhLWEOwsgMOtu1c0+NuwvyLsPlz5FhF2i63t7TYZYDKVt4PhSxrci4zeN0jKL
         gVuIKzEWDBqOkZa6pw0jwXd5x6CnAqGrIS3IQhxS7UmTlg+qECFn8+gXt1CzixRyrbI/
         Wj7RnpKNXU9tPd2wI+HeqamGI/5+pBAhkLmzfGMOZWisH97vY50a65l7i8D9JMdsltZf
         Hlihoe4ka/yTWi+diQbqKGJ65AU06iFHtSIXYUVQipIvK/9bJ1789qiiIUXiRmZwaGef
         mjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692784041; x=1693388841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJYxY9EKyE3nWLrlKwhz/hBGJk5NPLW4fkCZ4lrsGEw=;
        b=CIYSwEGv4Nai/XqxCmMG7v45Ej6/kGlr9wn3DttRO0/W2nvN1NSCAY6BHO71MaQi2s
         qAkfIc7kCWk3CyYaA0wbiu7cXJUl9gQ6ztKL3X/gK9FUqGXaOAeWSz81sequ+lLWWwdC
         QtYZ+4dwOEzPNNb//DYCbDt8I0agMXZs7d1Dy1nmxVO1gTQV1ZnWyPJT0D1p5AFeuOEU
         eEA5KerDzTrZS6jZoewEecuHqHqzlccESBeO6ecocpVEDYW3C0uIxHDU/y6iZpdd9yst
         Qh/dhrS7whnqRVk98mE9dJiXb1FoB9L/YdQDNJPVWhyzQPllLHXfE2/Wky3AYYDztnak
         x0Ww==
X-Gm-Message-State: AOJu0Yzcz5C4BHqTjj+WgtHGaxS2+aOBQ//1Wwv59p9ERlepfXwQji2I
	KvHwWDUBxgT9wu1kboG2N/2umg==
X-Google-Smtp-Source: AGHT+IE7cysoJxUCYOrYxdZSwvOf4+Tr5mGAWORNPlXqqK8SIWiZ5/c3SimYFa8oVbbcvbfQe/rYeA==
X-Received: by 2002:a05:6512:3b9e:b0:500:9a67:d40e with SMTP id g30-20020a0565123b9e00b005009a67d40emr192736lfv.60.1692784041188;
        Wed, 23 Aug 2023 02:47:21 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c4-20020aa7df04000000b00523b1335618sm9078804edy.97.2023.08.23.02.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 02:47:20 -0700 (PDT)
Message-ID: <601f8735-39ea-7579-0047-3d3358851339@linaro.org>
Date: Wed, 23 Aug 2023 11:47:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] net: dsa: use capital "OR" for multiple licenses
 in SPDX
Content-Language: en-US
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
References: <20230823085632.116725-1-krzysztof.kozlowski@linaro.org>
 <87h6oq9k9d.fsf@kurt>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87h6oq9k9d.fsf@kurt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/08/2023 11:32, Kurt Kanzenbach wrote:
> On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
>> Documentation/process/license-rules.rst and checkpatch expect the SPDX
>> identifier syntax for multiple licenses to use capital "OR".  Correct it
>> to keep consistent format and avoid copy-paste issues.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Side note: The SPDX spec in section D.2 says: "License expression
> operators (AND, OR and WITH) should be matched in a case-sensitive
> manner.". Should is not must. So I assume checkpatch and spdxcheck
> should handle both cases. Especially because:
> 
> |linux (git)-[master] % git grep 'SPDX' | grep ' or ' | wc -l
> |370
> 

But "should" denotes preferred rule:

git grep "SPDX-Li" | grep " OR " | wc -l	
7661

Best regards,
Krzysztof


