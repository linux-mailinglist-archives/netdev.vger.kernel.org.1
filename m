Return-Path: <netdev+bounces-34045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA9D7A1CC3
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B5B1C2119B
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 10:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B5E101C0;
	Fri, 15 Sep 2023 10:50:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E89DF5E
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:50:09 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E16195
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 03:49:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso2360634a12.2
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694774991; x=1695379791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6A7AJrKsm3kj4VKQZj/CxbnuNiC61KN1keejYnfTK6I=;
        b=NIUA9Er7wq83NeastDeLmwWiChHbJnuYQpRsKuEWTF7PPteT8tiG24vHhpGu9KUnw7
         SZ3/oYitqZE/FhGnmX0iaEHeD4A54TFY48Ebs3pVHFlQiewkpD4gwksuupoQghm4nO+l
         ptF0mYpTBn8FbOxJ+91yKH1k4YGMmW3cFO1e9HiwNs8TEa6J4O/Wgst73gZQEz/2ryam
         znwEHROZcctx8Gx2R+TL1+kYDTo9UoSWiluDbrZyvTGRKORYZHUNJGxo65AuSrMsdF0A
         qqcnPYgdV6dqS/TLESanDAkyQnCR1fprVrpZyzyhy1WrukyqbbIIXSG7huKOy4qixv1C
         Jqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774991; x=1695379791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A7AJrKsm3kj4VKQZj/CxbnuNiC61KN1keejYnfTK6I=;
        b=woWXWxrV0ZY7TWwO+zpx+HiZm/ZkgMiegH6XAqGKk3F6z4CNNk8cxajgTCEHOL9Av4
         MqPsWQqhB0lkf7eNTZGz7bEoFQf5EpuWBpKr7htV5y79HHJyHKHvMH8RBFqlw1Y9N/fs
         vV1+gluH+F+RmZsL7wz8kBjGdkJY52Oclon/BliLw61miAwybhBg3EN4zYmRdDOCiRv/
         14Z2fI4Bc52mONEKAa0Op8vKIAQO9RHXtXNyUibFytidUTdASuGuPo/SuZQ8vgddvwhB
         +aydF3ZotAH2wJKkzxYRAZyB+a2c0BEJH2z7KBBUu61QEpNNT0NG4H4wugYF8NOh/O92
         XE+Q==
X-Gm-Message-State: AOJu0YxM5OHlKYJG5hzs91SJlCyi3AAaLvneMbfLhDyZzwfKo0m25GUA
	6RTxvRIvZRwmGTBTy17QEaJZPw==
X-Google-Smtp-Source: AGHT+IHhSMQp1tp0GYzPk0wOrNW4u1uBvsA1qi4P5f35BkrGd6Ib7iszOkHLTk/A2gdvG/WGwnxlcA==
X-Received: by 2002:aa7:d4c5:0:b0:523:363e:f6e3 with SMTP id t5-20020aa7d4c5000000b00523363ef6e3mr1069556edr.15.1694774991395;
        Fri, 15 Sep 2023 03:49:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v15-20020a056402348f00b005308a170845sm639680edc.29.2023.09.15.03.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:49:50 -0700 (PDT)
Message-ID: <09783255-332f-5ea8-9b5f-a37facb04fa3@linaro.org>
Date: Fri, 15 Sep 2023 12:49:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 21/42] dt-bindings: net: Add Cirrus EP93xx
Content-Language: en-US
To: nikita.shubin@maquefel.me, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-21-a1d779dcec10@maquefel.me>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-21-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/09/2023 10:11, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 



> +  mdio:
> +    $ref: mdio.yaml#
> +    unevaluatedProperties: false
> +    description: optional node for embedded MDIO controller
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - phy-handle
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ethernet@80010000 {
> +        compatible = "cirrus,ep9301-eth";
> +        reg = <0x80010000 0x10000>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <7>;
> +        phy-handle = <&phy0>;

Would be nice to extend the example with mdio, to be complete as much as
possible. Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


