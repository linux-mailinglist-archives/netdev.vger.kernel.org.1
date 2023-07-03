Return-Path: <netdev+bounces-15140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D6745E50
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F2D280D90
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59BDF9F7;
	Mon,  3 Jul 2023 14:16:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E15F9EE
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 14:16:17 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7DCE52
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 07:16:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9891c73e0fbso813048266b.1
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688393774; x=1690985774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZZJzbwFN4n03zshXK/J7TJjDtnSZkH39pK/RDg/Cu8=;
        b=NDAvG1Uq9mqFT4vdanvxRFxPwqRPt1DYfERUMqUxx1QMnZlj9AwlXAVeC+kMmYFfK1
         kcta0tNxQRlDOAyrM6V5RoCakvaO5Myehpsd6W1ps4oxm3n5IXLhZeZqjANJ9aUAVSjt
         iTKUjtaMOYsIKA+x959dguBWKV9iUOW3+Web6fUfRQoZP/3gmsowr5mWCpOVz8sxddWf
         5oSrxONL99T7s+WgUEo/Nw0aZJ/Ma/iV6NEFFqNPZF8zT8dOwcMDQX8NHlu0m5fmCPPr
         uxEdpSwinLaRn01b7LGOFHvnYgSgVZayJZDQtQKEfJPCsK5To0OknozzxbGje1svGbQY
         yoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688393774; x=1690985774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZZJzbwFN4n03zshXK/J7TJjDtnSZkH39pK/RDg/Cu8=;
        b=cTWQijEQRZK7kf47vUIvvhNaH1OSZ7PpUiPvmDn7O2VpmuZQxr53VZk2qN8JIi1zia
         tooJFr6s9aUISpakq3dpAH6j5rT/0U8ULbvZOJLeIEu1k1SrAwPDaySgJEX1LzDc2mQr
         BcOy3yH3Bry3gpybqe7jsHHv7WXDyr+3YDH+fnbUf6qP+K4Buqvm+zHXPJ1KYjl/I83p
         uxpmS/QlcJHNdPMlGCnDBrpbIbns3ihcZJg7a+KU6C26qSfWVyloTonOCrdFzJmaevT/
         3zZBRK9O45hGKd4y6lDt2Me8fNYIjGY/fl+OGVMHd9h4yri7t7RUARqJZJIA3WKGU6St
         3vSw==
X-Gm-Message-State: AC+VfDxy2pNaMOSkmr4nBMmprkm2AkvPxt7d7NzvfGgF75YrKhkf5cyo
	RpJBPUYRKjO/2QgY4pTYvTUuxw==
X-Google-Smtp-Source: ACHHUZ749XOz+TzH+Pgvlma0DNoLLiZLUWSy8ZcmVUnssJhoqQyIBCOCh6Ux9aU6w2XG4KQmsC7txQ==
X-Received: by 2002:a17:907:60d5:b0:98d:f2c9:a1eb with SMTP id hv21-20020a17090760d500b0098df2c9a1ebmr14827554ejc.24.1688393774502;
        Mon, 03 Jul 2023 07:16:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id la25-20020a170906ad9900b00992e14af9c3sm4821934ejb.143.2023.07.03.07.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:16:14 -0700 (PDT)
Message-ID: <7b8e0f70-a6d2-16e4-5615-004b930298c5@linaro.org>
Date: Mon, 3 Jul 2023 16:16:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: i3c: Add mctp-controller property
Content-Language: en-US
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20230703053048.275709-1-matt@codeconstruct.com.au>
 <20230703053048.275709-2-matt@codeconstruct.com.au>
 <CAGE=qrrqE3Vj1Bs+cC51gKPDmsqMTyHEAJhsrGCyS_jYKf42Gw@mail.gmail.com>
 <d29fc42c04f2e1142b0a196ef7df2d74335cec2e.camel@codeconstruct.com.au>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d29fc42c04f2e1142b0a196ef7df2d74335cec2e.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/07/2023 10:14, Matt Johnston wrote:
> On Mon, 2023-07-03 at 09:15 +0200, Krzysztof Kozlowski wrote:
>> On Mon, 3 Jul 2023 at 07:31, Matt Johnston <matt@codeconstruct.com.au> wrote:
>>>
>>> This property is used to describe a I3C bus with attached MCTP I3C
>>> target devices.
>>>
>>> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
>>> ---
>>>  Documentation/devicetree/bindings/i3c/i3c.yaml | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
>>> index fdb4212149e7..08731e2484f2 100644
>>> --- a/Documentation/devicetree/bindings/i3c/i3c.yaml
>>> +++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
>>> @@ -55,6 +55,10 @@ properties:
>>>
>>>        May not be supported by all controllers.
>>>
>>> +  mctp-controller:
>>> +    description: |
>>> +      Indicates that this bus hosts MCTP-over-I3C target devices.
>>
>> I have doubts you actually tested it - there is no type/ref. Also,
>> your description is a bit different than existing from dtschema. Why?
>> Aren't these the same things?
> 
> (sorry my reply minutes ago was somehow an old draft, please ignore)
> 
> Ah, I'll add 
> $ref: /schemas/types.yaml#/definitions/flag

Although does not matter, but use the same as in dtschema.
type: boolean

> 
> Testing with 
>   make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
> I don't see any warnings, and neither after adding mctp-controller to a .dts
> (out of tree) and testing with
>   make CHECK_DTBS=y DT_SCHEMA_FILES=i3c.yaml aspeed-test.dtb
> 
> Should that pick it up?
> 
> For the description, do you mean it differs to the other properties in
> i3c.yaml, or something else?

It differs than existing mctp-controller property. If this was on
purpose, please share a bit more why. If not, maybe use the same
description?

Best regards,
Krzysztof


