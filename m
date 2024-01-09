Return-Path: <netdev+bounces-62748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1BD828EAB
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 21:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A06B24557
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E353D993;
	Tue,  9 Jan 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSUiKXCF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2283D990
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33687627ad0so3049375f8f.2
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 12:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704833824; x=1705438624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iM/YIk0RbVKurT2dGF7o0kOGykVlyKUzNhFaAXhhfXY=;
        b=cSUiKXCFp/RQ4YCtag5zfRMeSScm17JpzR0oMG293T6Mutm4UzBczTKz7wvXcDC4MI
         sbGAE4pm0k3E8DLo8LQfD58OmuMj4OnTpKzxgC6MSES4pf6MUgpAu/vTdR0ZP44QNt1E
         TOty/ZO06x0hhbdR3PEeerbd7ooWGSQ/yiPIOswwzK/JzsbdA1/0PI1jGRyZzVRUJyxP
         afn6u2vIvw3gOa3cZ5DeWlvgvRr85UJ7B/kgsLlFMnVHgqzH0rTtgYOKsKDWA+P0e4qG
         plyvDtbhEbLSTnXpvGnMXGZBxb7XskDEksSBL+OgJToVE0lTelDyKWbzYit0tItsnZ+M
         TdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704833824; x=1705438624;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iM/YIk0RbVKurT2dGF7o0kOGykVlyKUzNhFaAXhhfXY=;
        b=PLIaKRoBvLPfRiTZk/cuo3OzL5a7jDWO4o7lYXi3lnWnRRc7ZRo1QkDFGxxnc54hxk
         KAj96Edhfyywe/SOetnKIvpXB877mqJ6ZkaToFpHljTMcWiOl/L+Yu69VudsqnKhdth9
         oWktJCrVJsovtvDnejgqE6wBfz0gev9vLcTojTdSr49nryEtCKm9sjyS9jO8C7hX32fF
         r9nI47da9nB0qLHwV3AfKeDi2+tM8pw54HSrBNU5uXj7iZUdMsfs52silBppURtQw5lF
         9iNOdMQds8udGPbJQijRBqSaUdASMMT5XXCTiU4NGc0BaEs66M93XGCe058zH6louuu3
         xY8A==
X-Gm-Message-State: AOJu0YzulCqdNDH+78rOMNym82FHbhwk55U8u1LXfvhDBF9gfif5OrR4
	bN52da7N5paRyfsNniKh1Jx4ehLDBjVGtQ==
X-Google-Smtp-Source: AGHT+IGKEXpnp3u+rB7pNeJDK22LqPUSSSzGqp6qRZYTJESJW/vMb3bcGbHx8YY2gZjOSHgNaG6OlA==
X-Received: by 2002:adf:ee4a:0:b0:336:7bb4:bab2 with SMTP id w10-20020adfee4a000000b003367bb4bab2mr785709wro.15.1704833824183;
        Tue, 09 Jan 2024 12:57:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id g4-20020adfa484000000b00336344c3c3fsm3269743wrb.90.2024.01.09.12.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 12:57:03 -0800 (PST)
Message-ID: <6376f623-abc4-4d39-9312-ada29fa481ce@linaro.org>
Date: Tue, 9 Jan 2024 21:57:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethernet binding: broken validation parsing of #nvmem-cell-cells
 ?
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <bdf7751b-0421-485d-8382-26c084f09d7d@gmail.com>
 <a2be5d2d-869b-4fa3-951c-5a7b8efed0cc@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a2be5d2d-869b-4fa3-951c-5a7b8efed0cc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/01/2024 21:32, Krzysztof Kozlowski wrote:
> On 09/01/2024 11:03, Rafał Miłecki wrote:
>> Hi,
>>
>> I'm playing with "dtbs_check" and I stuck on following errors:
>>
>> arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dtb: ethernet@24000: nvmem-cells: [[9], [0]] is too long
>>          from schema $id: http://devicetree.org/schemas/net/ethernet-controller.yaml#
>> arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dtb: ethernet-switch@18007000: ports:port@4:nvmem-cells: [[9], [5]] is too long
>>          from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
>>
> 
> Thanks for the report. It looks like a bug in the dtschema. We should
> drop nvmem-cells from phandle_args. I'll send a fix.

BTW, you already worked on this:
https://github.com/devicetree-org/dt-schema/pull/89/
:)

Best regards,
Krzysztof


