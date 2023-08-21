Return-Path: <netdev+bounces-29290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47EB78288D
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 14:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C687F1C208CC
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50018538F;
	Mon, 21 Aug 2023 12:06:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF1A538A
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 12:06:46 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D926CD
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 05:06:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so3907871a12.3
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 05:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692619603; x=1693224403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2S+WETvfAyrCVF8DP9tvmJJ5EWf71P/PjeMnXn7n6Lo=;
        b=AKZiy1IcmrTnS8t3Aj69f9szwT2W6buD4JdkJG4PhzNFd6RC8DEOEnJzG38wHiY0Ct
         lmbiwczvEAh2uxmGvZAgXbiZ017Oi4wm9iR7//3Zuuf7YMYcMNn1aUN82CmnWaEzEQIg
         ZhBKp2uSyMsg1I9vn/xFo1RVwdnSQA6OtyXdtESjctJucwdoOQ9sn2Nb/5uw9G7DlkqG
         qloCTWdZbnsV72yu1caka78IiEqhakoJYJKc60vARtuWBqeL7KqzEXi13BSS9L90bhTF
         angIuJ2m55GyWnP4ZlERe4CPo6mqJtDkwRVBdSh7h7nCsvmDBiJsGgxCo54DH/y+MXo6
         ou3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692619603; x=1693224403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2S+WETvfAyrCVF8DP9tvmJJ5EWf71P/PjeMnXn7n6Lo=;
        b=H0lG/T5j3jZSCCcl77Gv5b6pgz6/R4nyZyA+sFrZ966OHCD0+4OYNCNqyRFLaF6U51
         1L2OAaN1eJhXJJp6Xq6VC1/Q3QBYKUQxAoGWmzNgnAXZ48povdWKHGTCtYn5XXBgZOTn
         aN/t+6s6M5Pbx04qu2F7aKoil1vRjJe5GjAodcOxTofPUV9sDhhAEkPXeR0nuSdsANdv
         g1Zl2lCIVqjPpOef/EEASz5CZy1hSEgr32o8kgpk8SFAF1Eu1YJxZKfwI6dp6lw3jcgs
         dLLnOkzeh2L6LtvHzl7lZ0Ct9yLHYcyfTLMEuIs7nyoUi05ps9JlhHCZ9A0Z0i6WdOB9
         liKw==
X-Gm-Message-State: AOJu0YwUqu70PK9VKtqCA99AaOxQy8brwFrLeT83i6WP5xCqT+HWIbfR
	duItBt2muVwjuTkz884cW5OjPg==
X-Google-Smtp-Source: AGHT+IGA3fcwCUwoHfQmYSY/wtDyAlgOxfO0or6c6j0Qcinb4t2/XgeaIcZi4syQvHqfZpMf9jNYmQ==
X-Received: by 2002:a50:fa93:0:b0:525:d95b:cd46 with SMTP id w19-20020a50fa93000000b00525d95bcd46mr4674958edr.2.1692619603593;
        Mon, 21 Aug 2023 05:06:43 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id g4-20020a056402180400b00525727db542sm5974464edy.54.2023.08.21.05.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:06:43 -0700 (PDT)
Message-ID: <ebad4f91-3d4e-c50f-0bde-f11f16061214@linaro.org>
Date: Mon, 21 Aug 2023 14:06:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: syscon: Add compatibles for
 Loongson-1 syscon
Content-Language: en-US
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-2-keguang.zhang@gmail.com>
 <a9a7b65c-ef0b-9f66-b197-548733728d44@linaro.org>
 <CAJhJPsXEf0Yuxasq24X=x_JtUJZrNC1aowfeuu9QM2kz+A=asQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJhJPsXEf0Yuxasq24X=x_JtUJZrNC1aowfeuu9QM2kz+A=asQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/08/2023 13:00, Keguang Zhang wrote:
> On Sat, Aug 19, 2023 at 10:23 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/08/2023 13:13, Keguang Zhang wrote:
>>> Add Loongson LS1B and LS1C compatibles for system controller.
>>
>> I asked not to use the same compatible for different blocks. Compatible
>> is dwmac, but are you still going to use for other blocks? Please write
>> proper description of the hardware.
>>
> Sorry. I didn't make myself clear.
> The SoC only has one syscon with two registers.
> And Each register contains settings for multiple devices.
> Besides DWMAC, this syscon will be used for other devices.
> Should I keep using loongson,ls1b-syscon/loongson,ls1c-syscon?

Ah, ok, then the naming of the compatible should reflect the name of
this syscon block. If it does not have any name and it is the only
syscon, then name like "loongson,ls1b-syscon" is good. If the block has
some name - use it in compatible.

Best regards,
Krzysztof


