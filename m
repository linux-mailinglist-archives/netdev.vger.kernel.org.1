Return-Path: <netdev+bounces-58115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B34BF815178
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 21:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EA11F24AD7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 20:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2BE4777D;
	Fri, 15 Dec 2023 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KU5EIgtC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B646558
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ba4850f65dso80125b6e.2
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702673959; x=1703278759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lV7l2nTXRo6puPksf2Bwbtc+9l9srdKWeAOzTx3pqZU=;
        b=KU5EIgtCK4hVTxEEZxXq7NbhYD5qiIM4WmTT5l+3tSK4lixfIwF2ZDhcGSqTqxYB29
         JxFp3OD3Ee/JMVqO0SPmVVcv2Xdx7oUkqul746gfHgy2s6PdYlNaYOXF9fEMGASjrrwW
         CT4LHPNMPhULbiNgC0+Ql741Fzj0YSqXxaUmSaAdraGzzvmBEQKHQf7x9YiakUMB2IuF
         vXRUldbcwZQ5qmMSk72etRWkYG9SC1NJGqb8EwVai94+r8HdyLhILcg2H13xcFRt1KKp
         a3R78jsr9K/DKgNVTug/BbkgvLtc50WR5jfir69Ce6NP/nbUWFQ1c2xywrKnqV53s0SV
         x8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702673959; x=1703278759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lV7l2nTXRo6puPksf2Bwbtc+9l9srdKWeAOzTx3pqZU=;
        b=Kv1TdcyVIt9MOwPY8bBUfvr4MnsyDzsi3THzeZRzeaC2hZPjd5KwMwwt/MYqyYjO6u
         Q3V4Hhdx+d9w1QiZZ/4zrjqDzu4tPTrn9jQZqrX3fOO8jH977iWwD6LeQQJdWFxQ56B/
         rW7arydhygDabizj9yg66UvgZw5xENJ+iuch6dJsAMzJyKsvD+v1Tf2/9f/VvL+9FeFO
         5CbkqDaHhsXKgz9II0gFtdPmuW3k6zvD1kb/fcegNvm9QuL+rj+Jyi6D7GR2OBpYIxAp
         rGsCWDJ9dOnw5voTM1iYLbpBsspEv2pAqAwIyrGgXkFilFXryeJ1/3xOuLn68JrLYyhx
         CSCA==
X-Gm-Message-State: AOJu0YzOA0KWk2KRutIal+VfPk/Pm+BEBwaN52nkj04Lg0l+AFSPSNGL
	XcWqZjybjHRIfdbasjH2lKrE7A==
X-Google-Smtp-Source: AGHT+IEe4Kr9nZGM8rgYvZk36QtswTXFAg2l00r9jHu+UOaHWgP1pqPIoOBpVHQ2/argXUQTanExYw==
X-Received: by 2002:a05:6808:1a0e:b0:3b9:da30:77fa with SMTP id bk14-20020a0568081a0e00b003b9da3077famr15925945oib.2.1702673959682;
        Fri, 15 Dec 2023 12:59:19 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:18ee:711a:b78b:5489? ([2600:1700:2000:b002:18ee:711a:b78b:5489])
        by smtp.gmail.com with ESMTPSA id v16-20020a0cf910000000b0067a53aa6df2sm7151683qvn.46.2023.12.15.12.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 12:59:19 -0800 (PST)
Message-ID: <65fd52f1-6861-42b0-9148-266766d054b1@sifive.com>
Date: Fri, 15 Dec 2023 14:59:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Content-Language: en-US
To: Jessica Clarke <jrtc27@jrtc27.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>, linux-clk@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
 <20231215204050.2296404-3-cristian.ciocaltea@collabora.com>
 <A7C96942-07CB-40FD-AAAA-4A8947DEE7CA@jrtc27.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <A7C96942-07CB-40FD-AAAA-4A8947DEE7CA@jrtc27.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023-12-15 2:47 PM, Jessica Clarke wrote:
> On 15 Dec 2023, at 20:40, Cristian Ciocaltea <cristian.ciocaltea@collabora.com> wrote:
>>
>> The Synopsys DesignWare MAC found on StarFive JH7100 SoC is mostly
>> similar to the newer JH7110, but it requires only two interrupts and a
>> single reset line, which is 'ahb' instead of the commonly used
>> 'stmmaceth'.
>>
>> Since the common binding 'snps,dwmac' allows selecting 'ahb' only in
>> conjunction with 'stmmaceth', extend the logic to also permit exclusive
>> usage of the 'ahb' reset name.  This ensures the following use cases are
>> supported:
>>
>>  JH7110: reset-names = "stmmaceth", "ahb";
>>  JH7100: reset-names = "ahb";
>>  other:  reset-names = "stmmaceth";
>>
>> Also note the need to use a different dwmac fallback, as v5.20 applies
>> to JH7110 only, while JH7100 relies on v3.7x.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>> .../devicetree/bindings/net/snps,dwmac.yaml   |  3 +-
>> .../bindings/net/starfive,jh7110-dwmac.yaml   | 74 +++++++++++++------
>> 2 files changed, 55 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> index 5c2769dc689a..c1380ff1c054 100644
>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> @@ -95,6 +95,7 @@ properties:
>>         - snps,dwmac-5.20
>>         - snps,dwxgmac
>>         - snps,dwxgmac-2.10
>> +        - starfive,jh7100-dwmac
>>         - starfive,jh7110-dwmac
>>
>>   reg:
>> @@ -146,7 +147,7 @@ properties:
>>   reset-names:
>>     minItems: 1
>>     items:
>> -      - const: stmmaceth
>> +      - enum: [stmmaceth, ahb]
>>       - const: ahb
> 
> I’m not so well-versed in the YAML bindings, but would this not allow
> reset-names = "ahb", "ahb"?

Yes, it would. You need something like:

reset-names:
  oneOf:
    - enum: [stmmaceth, ahb]
    - items:
        - const: stmmaceth
        - const: ahb

Regards,
Samuel


