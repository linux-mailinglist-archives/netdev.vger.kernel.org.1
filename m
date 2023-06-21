Return-Path: <netdev+bounces-12482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E43B737B00
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 08:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF0E28150E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 06:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C703379E0;
	Wed, 21 Jun 2023 06:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A02593
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:05:58 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B91737
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 23:05:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5189f49c315so5880423a12.2
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 23:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687327553; x=1689919553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rl1Qby0u21Iv2rmR9JLr9d/ig7PQZex8yz2AvojYw5k=;
        b=f6cTeKkXAVR90n3ajc6KdT0AvLuCf7rE8O5SWg5HYFe4r6daBoExzrCHY4k9VjtLne
         35eHIix5pq4cczk28QvhmMRZJFIdJjVFFA+fbTmqniBmYr/JJkSTMDFiIiIvjgImKzjw
         ipRLeCzskx28qwtDx+IYK8qMVOm55oORpv9rjj5k5RMH15WVHkOPbpCWXX2sOFcskKLH
         AJ+IKcPSB1ft1XunPFSYCwEo15fDILZw0mmOOEP9V3o+vh/Op91jtrB/s0I5TKgOUbwu
         TUBxhNZIvJbFnJF1WwjWwXb7PGxhaxpvQFmv4JkQfF15/GnSDkg+0bJXgnZaDhlsKPjf
         grXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687327553; x=1689919553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rl1Qby0u21Iv2rmR9JLr9d/ig7PQZex8yz2AvojYw5k=;
        b=DwiyAT16/2Fifq9PzNlTM2bkPTj4QvKsoN9woKrWt4EOJuaF3qdSFLBFYC2rl6hxtH
         Usnm1wGlExA4hnVRMQ6Uh/RTqGLzwG9Auv+Ukxl+7K56sMnpq5DXycQV520VcX0q0DwF
         POcSP9UuQrHey8rEdenqYhXBD74BLdiyrFiT5MuBQv9S8WT9ZV2bmRslE9hl2ciFp4Bk
         iXfevcmc+hAM26DOwbY0AdBl75z0BfEHfBbzeD/R1BikDmh/MY4MHbpg3hbnQ5vOvhsq
         cAGZTnfKJAK6PU/MeGx9WxwH5wH7M93dOWDvbDtGlsLlVjoWsxzwrTWRNAwomer7h+6U
         sbJw==
X-Gm-Message-State: AC+VfDxZdeXJNCL+asxIF6TV7QLoOquLjuoobIc5cV5pGp5g4Y/aKro0
	TxU3L+E9IyE+8voI2vvLD4LJbA==
X-Google-Smtp-Source: ACHHUZ5LvRIbZZcBlOt6s5zzU9Jeyo74a4+RXayHEeu5KUpcAefp32b6yjQerwjo87A40cQ8FOnSwA==
X-Received: by 2002:aa7:db89:0:b0:51a:265a:8fca with SMTP id u9-20020aa7db89000000b0051a265a8fcamr8538702edt.27.1687327553420;
        Tue, 20 Jun 2023 23:05:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g25-20020a056402181900b00515c8024cb9sm2074751edy.55.2023.06.20.23.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 23:05:52 -0700 (PDT)
Message-ID: <74788626-231c-ccfb-ecc8-87dbc6a4ecea@linaro.org>
Date: Wed, 21 Jun 2023 08:05:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] dt-bindings: net: bluetooth: qualcomm: document
 VDD_CH1
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <bgodavar@codeaurora.org>,
 Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
 <20230620111456.48aae53c@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620111456.48aae53c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/06/2023 20:14, Jakub Kicinski wrote:
> On Sat, 17 Jun 2023 18:57:16 +0200 Krzysztof Kozlowski wrote:
>> WCN3990 comes with two chains - CH0 and CH1 - where each takes VDD
>> regulator.  It seems VDD_CH1 is optional (Linux driver does not care
>> about it), so document it to fix dtbs_check warnings like:
>>
>>   sdm850-lenovo-yoga-c630.dtb: bluetooth: 'vddch1-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi Luiz, I don't see you CCed here, should we take it directly 
> to net-next?

Bluetooth bindings are not part of BLUETOOTH entry, so obviously no Cc
for bluetooth maintainers. I'll send a patch to update maintainers.

Best regards,
Krzysztof


