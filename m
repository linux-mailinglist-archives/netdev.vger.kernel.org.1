Return-Path: <netdev+bounces-27616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA377C8F9
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723022813A0
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3CFAD5F;
	Tue, 15 Aug 2023 07:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CE53AC
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:57:50 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBA1110
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 00:57:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso46578615e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692086268; x=1692691068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+MGNeICc/iNj8c7cmcVTYWkovPAjmKjFK52lISRrAY=;
        b=dR14f2VlRh1UMvzvpx38Z7aTixxMvaQiTWiRifQMAwrQgljfw6Y3bF7XyIiLytGWIL
         aUeozA979mk6MX4TLYde6SbkxHJsuuDJ4YQS/8qBKvTdAHCtlnar95uZ4aXm8CwP3YN6
         JvIpn/RfCg9loke8wal8TTeWgXtKiEBMzc0mxzSsa0urCURx3JpgHh3Am+bf2Kq8KGen
         660xnLY8dIbLaMFdBRc+iKrgUIzBokY1lAEuBvZGK6Sdx0ABUbr2Wkoqf+Qmr3xhdew8
         vddgOK0pO09Upxar+1XVP28c0mFkq3IpTDNt/mhut84bgp+VOthchMa6v64nNzy4GF8p
         oFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692086268; x=1692691068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+MGNeICc/iNj8c7cmcVTYWkovPAjmKjFK52lISRrAY=;
        b=Xt9QF3TzM9Cz395L9YiqNLgCqQsVvr2IaalmhPTZczUlvkoMd2AGPAeY+Vb4Kw0e8V
         IaGlYqrAvCpF2rSsww/sL36aw7NdlWDkdBG38IPjppQQCmQHJEdfRP1x6Qm+NucnSkRO
         ep8OsPQSxe0xkA7dBQd1x9nFbXrrN4MeHfQ8gWcl5Nr107GL6VX8pMtHX2tZ3X5LcExa
         8Cb2zPoZ7ORapaczx/+Nvs+dr3I/qpJeUogLlnyj4AM/RK3h72CzBb1I00mq3SRjPU+e
         a6wDInZVmN92oJ9WAYiH92IZozuCrgFtV8qlYflXs1+2uWe5jCgQVFIcZdFo4THHvhCX
         Ip/Q==
X-Gm-Message-State: AOJu0Yx/tcD/5vJOLyWZq6yGhQ6AAi2jZgESjLxVfx4sIy4jZCe1KUEW
	32JgVK/rs4klARUf7h9hKN0WUA==
X-Google-Smtp-Source: AGHT+IFlhQWjto8DwXBrHS84HZUcBWG5Sj4ndPEAjSpSJ30c1oKXXssZLxgZ4tQd8RbAokMv9OHfrg==
X-Received: by 2002:a05:600c:acd:b0:3fa:9823:407 with SMTP id c13-20020a05600c0acd00b003fa98230407mr8706123wmr.18.1692086267744;
        Tue, 15 Aug 2023 00:57:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003fe2120ad0bsm19732991wmc.41.2023.08.15.00.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 00:57:47 -0700 (PDT)
Message-ID: <0df70dbe-88aa-c2c2-2fe9-b916b32e9da9@linaro.org>
Date: Tue, 15 Aug 2023 09:57:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH -next] nfc: virtual_ncidev: Use module_misc_device macro
 to simplify the code
Content-Language: en-US
To: Li Zetao <lizetao1@huawei.com>, bongsu.jeon@samsung.com
Cc: netdev@vger.kernel.org
References: <20230815074927.1016787-1-lizetao1@huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230815074927.1016787-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/08/2023 09:49, Li Zetao wrote:
> Use the module_misc_device macro to simplify the code, which is the
> same as declaring with module_init() and module_exit().
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/nfc/virtual_ncidev.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


