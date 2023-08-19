Return-Path: <netdev+bounces-29003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42554781605
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF203281E10
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E046362;
	Sat, 19 Aug 2023 00:29:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4763C
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 00:29:16 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9993C3C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:29:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf48546ccfso6909975ad.2
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692404954; x=1693009754;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRsZJj6SSG3fqLpbJ0ituOFAOMGJIferHV4i1E9NQGM=;
        b=YOrsIIhKXpaL0P2/yGoL3I6k88MLxHSQ0Ba/tC6kQTUuHWhIhq2EMfQP5K9iajLZxe
         ePcYVC+46x6UaQLUZqR9PWaIi4d0Hdr89qF3Vu1p6l+Z/mFwEf8YFRCBMogbjMgbYybv
         liQqOeRcKESAZjghYiK2iiXQXmUUnKy7sc8ZKLE0islxgXBj+vkpmPYhEgmaAJlpInaX
         YyqG1pSbbkX1/u6p5bM4W7aPYhy0psBCZfwCK/G9pFA+CgaPmv880/kZlAMQOrjzPOEw
         gbuJv8IZy12f93Ojn+z5grWI4CnWpv2VxSG+uXq97jaK2oPw9jwVR08yQT9KQp8Rdz/j
         Jj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692404954; x=1693009754;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRsZJj6SSG3fqLpbJ0ituOFAOMGJIferHV4i1E9NQGM=;
        b=N+izeEWcJV7jlF5Q5YFFGjXylMjfzl+/dss+O8SjGfQ737yId9V3x+FSDFUpMvm7BJ
         g59DvpEMhzAF2qjXjE02aLOtgKl1FZdKQ6WMkAFB2/9vn+TrBqTh26a6I/A8JWaB9uTq
         /5ZLSv4lDCqgWVdD+Q3z+dTcU38JJuPrJ4647KDES+WGUJCv1LfpVWgOXpAosPpjHhpN
         Vd9YFQGUMWWyZAx+PXR5xyAE4syA5bSeuhaAvg2rjTVYb4aBdoY6eSlSXBQ5QGFz+4i+
         ruVxXCAr6o0MjD9hKU5W8OwxRzds+pGBrPsW6wmCPvF/fnLAoZWkVB3A0bVCPeCTjTKS
         XyrQ==
X-Gm-Message-State: AOJu0YysZSgM8QVzBDl3bnw2SS47VnLHuiHFinzE/a7NB3rIduD8HTfq
	otIA+g8ppTncir7fOCWNCEo=
X-Google-Smtp-Source: AGHT+IEZ9XvO2WDGU61PEBMYat+LJMe+n7c0bsJF0VaGBf7EYcXS3VHun3z/V6VIa3TNT50x5iTg7Q==
X-Received: by 2002:a17:902:c3c5:b0:1b8:72b2:fd3b with SMTP id j5-20020a170902c3c500b001b872b2fd3bmr630917plj.54.1692404954342;
        Fri, 18 Aug 2023 17:29:14 -0700 (PDT)
Received: from [10.69.40.148] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902c1d200b001b9be3b94e5sm2328841plc.303.2023.08.18.17.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 17:29:13 -0700 (PDT)
Message-ID: <4118917e-0ccd-444a-ab24-83dee43af2b4@gmail.com>
Date: Fri, 18 Aug 2023 17:28:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: bcmgenet: Fix return value check for
 fixed_phy_register()
Content-Language: en-US
To: Ruan Jinjie <ruanjinjie@huawei.com>, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 florian.fainelli@broadcom.com, pgynther@google.com, netdev@vger.kernel.org
References: <20230818051221.3634844-1-ruanjinjie@huawei.com>
 <20230818051221.3634844-3-ruanjinjie@huawei.com>
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <20230818051221.3634844-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/2023 10:12 PM, Ruan Jinjie wrote:
> The fixed_phy_register() function returns error pointers and never
> returns NULL. Update the checks accordingly.
> 
> Fixes: b0ba512e25d7 ("net: bcmgenet: enable driver to work without a device tree")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v3:
> - Split the err code update code into another patch set as suggested.
> v2:
> - Remove redundant NULL check and fix the return value.
> - Update the commit title and message.
> - Add the fix tag.
> ---
>   drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Doug Berger <opendmb@gmail.com>

