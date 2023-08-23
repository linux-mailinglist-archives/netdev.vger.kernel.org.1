Return-Path: <netdev+bounces-29970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F2A785670
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583B71C20C43
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0380BA33;
	Wed, 23 Aug 2023 11:08:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3371A956
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:08:44 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD28E63
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:08:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99cdb0fd093so748090266b.1
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692788901; x=1693393701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13ZiGAbaPI1bJ6e405gOO4diSQC4pPB1YKTk8I5pazg=;
        b=pEUttLFM9xcLVYRmZhUVb3fwHeOXyoJkqOjYQz6TgHgU8kswvgpe2wRvcocnFbFaiw
         dajllE/4xQ/3UaYoW3jL5H/zrzwXu6KSBNbct5VIsAPRQBz8MDzUHrCQfhP697BKuz8o
         pXUC7keQGXUiZffjVrBt691gOZrtHimGVcq8YaTpNUgIYnYj28VtX7bRxAC9wgZychg6
         /rjopibEDPkuFaW9iTqvQutl7pB5rEAeL+Etsp1XitUC+w66Hd5GbGNp80tlu/WyH8NG
         0qXWOCRu8xeHRpBiC2BwleSxLioxge/v1E8hkGCgzXPTMalyJaM9XJe8kwmWhat5UB8y
         Otaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692788901; x=1693393701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13ZiGAbaPI1bJ6e405gOO4diSQC4pPB1YKTk8I5pazg=;
        b=haOCSqeE27X/7lKVZ7IAoQamFL4kwVIvASTe23ZgRUMcuJkBbVrh+oJqggIgktB4rO
         60nylnwYR2JRDE5PeXRyjRRPJWJI8DaFGwfBgagYytGdzEmQsob3v9SuDvkO3ikBjhp7
         kj/6hgYeIAaF1idNTyNQqO4PcvJE8h58feqDk4+1ocsiF4ZFOFSPA9dYyrYRjfi0w8o4
         HJLdyNCnnUrAIQhv0/pBIGcvSnE5YNowbb0SZ7Vda9Le1YUSRPgb8DvVR+IHPDl3UlhC
         IDjbt4oBpkj5IjGFOcHs3op9d2BaZa0+4MGeIvNeWsopkuLQQYK8tt4mbGZ+cwkGGXkz
         9nqw==
X-Gm-Message-State: AOJu0YwLNQedvlaeMVJARO4OUt6Oj/Rt/uobmTlR6WbHoY+2QUuDXs1r
	S7SGT5HzzoiVnKqACLvFQeOLLw==
X-Google-Smtp-Source: AGHT+IFPpc/M9qEHjj5tV+w9O5JQwtSamWghJvL0uJZa7j3GJ3omdOLx5vjTovj6fvUU6krRyeBONg==
X-Received: by 2002:a17:906:24e:b0:99c:c8ec:bd4a with SMTP id 14-20020a170906024e00b0099cc8ecbd4amr10548084ejl.60.1692788900696;
        Wed, 23 Aug 2023 04:08:20 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b0099de082442esm9656576ejb.70.2023.08.23.04.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 04:08:20 -0700 (PDT)
Message-ID: <3506906f-7a89-c90c-c753-c330fd33d68c@linaro.org>
Date: Wed, 23 Aug 2023 13:08:19 +0200
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
 <87h6oq9k9d.fsf@kurt> <601f8735-39ea-7579-0047-3d3358851339@linaro.org>
 <87edju9ggi.fsf@kurt>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87edju9ggi.fsf@kurt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/08/2023 12:54, Kurt Kanzenbach wrote:
> On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
>> On 23/08/2023 11:32, Kurt Kanzenbach wrote:
>>> On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
>>>> Documentation/process/license-rules.rst and checkpatch expect the SPDX
>>>> identifier syntax for multiple licenses to use capital "OR".  Correct it
>>>> to keep consistent format and avoid copy-paste issues.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>>>
>>> Side note: The SPDX spec in section D.2 says: "License expression
>>> operators (AND, OR and WITH) should be matched in a case-sensitive
>>> manner.". Should is not must. So I assume checkpatch and spdxcheck
>>> should handle both cases. Especially because:
>>>
>>> |linux (git)-[master] % git grep 'SPDX' | grep ' or ' | wc -l
>>> |370
>>>
>>
>> But "should" denotes preferred rule:
> 
> Yes, of course :).
> 
> You mentioned checkpatch. But checkpatch doesn't warn about it. Or does
> it? 
> 
> |linux (git)-[master] % ./scripts/checkpatch.pl -- drivers/net/dsa/hirschmann/hellcreek.h
> |total: 0 errors, 0 warnings, 0 checks, 321 lines checked
> |
> |drivers/net/dsa/hirschmann/hellcreek.h has no obvious style problems and
> |is ready for submission.

Checkpatch checks licenses of only some files, so maybe I should change
description here (it's you know, copy-paste...).

Best regards,
Krzysztof


