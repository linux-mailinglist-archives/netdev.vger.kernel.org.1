Return-Path: <netdev+bounces-26265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980AB7775D8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516FE282089
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6A76FAA;
	Thu, 10 Aug 2023 10:30:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322C253DC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:30:39 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187D02683
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:30:37 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bcb5df95c5so705903a34.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1691663436; x=1692268236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfX2UO9uPMLGCJf+csL6XyU3QIcd01mEsKwWrpSRNS4=;
        b=SGnJ72WXikaU5xqUInA5M3UvYftl90Px6nU01CEkJphO/WsF5Q2X5gSU4xT6tchamL
         5oH6WUuttHrXL1mWEVgtVnnZcbyWQK/LF7pjeAbo0lqCgKuhyI2LHTGFBGyJVqpZP3jd
         7Ro7a7lBZSw2Q3l6rd0D5Ir21mM9lV0jqpqfROsleVpiV+VBfaaCQvlwJK9l7emWyXps
         8/kD9xmUX1yvQDY9601GcrdcL9zSua5LZ24RsKY6wRIfgaOFtkIWbGDREjHCZnusU9XY
         GCp9qb1WTiBL0TwB8aR0iGDjuhuYll95r5DPSw7mP4UBQ4VqxgXIvmewPTXRP901tW6V
         ezsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663436; x=1692268236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfX2UO9uPMLGCJf+csL6XyU3QIcd01mEsKwWrpSRNS4=;
        b=StX8iXY27gOAO5yIoasgTmith+1H9uqPGzE6K02fYs73S8YmX0FM0DvZToJ/P9Am+O
         E4UHZlLf/0Z7+lhyyt/+y4OmTXT1kLbEwAMZCMpwIcUWowjW/+hzUvtLGDH6OXI991DF
         NknY9X2hB4BTX+ToZtSWhyf0N73OMbA8AQXRS9+XVr+m43IB27uUCOv7AkzUa93OgiMx
         06B6gjl2DovDl8d3D/IcA8oqCcinnLtcdur8Vs7SqsS9BNZmRZMW5K50yJ79Es2ln9QF
         Ld9Xdv9A93lUFNZxzqiHpVGrcOq7gf50jjHpC+FuvVXJgP2NYzYqssiBi2uOXRHbbQJC
         KMkw==
X-Gm-Message-State: AOJu0YwgEANNJZyABJaTQLYkUYTvVJMA/C+RcekaVPWgBqexsGYGVYt2
	7NBcEORtOY9pWEJ4dhrc7G8iuA==
X-Google-Smtp-Source: AGHT+IF0r6GZclcogo6XbgwR5E95APycZzfccRq3VLl0HNlzfmMExbMjn9dfSBYwvsABTggoervb8w==
X-Received: by 2002:a05:6358:7e8f:b0:134:c279:c82a with SMTP id o15-20020a0563587e8f00b00134c279c82amr2360798rwn.29.1691663435963;
        Thu, 10 Aug 2023 03:30:35 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id y11-20020a63ad4b000000b00564250660f3sm1214409pgo.78.2023.08.10.03.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 03:30:35 -0700 (PDT)
Message-ID: <0bdbd852-d21d-3149-a34f-8d25ec3544e8@tuxon.dev>
Date: Thu, 10 Aug 2023 13:30:16 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
To: Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: nicolas.ferre@microchip.com, conor.dooley@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.com, maz@kernel.org, srinivas.kandagatla@linaro.org,
 thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, sre@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
 <ZM0Be8S8zII8wV4l@nanopsycho> <ZNS0708cDAt7H7ul@vergenet.net>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZNS0708cDAt7H7ul@vergenet.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10.08.2023 12:59, Simon Horman wrote:
> On Fri, Aug 04, 2023 at 03:47:39PM +0200, Jiri Pirko wrote:
>> Fri, Aug 04, 2023 at 07:00:07AM CEST, claudiu.beznea@tuxon.dev wrote:
>>> Update MAINTAINERS entries with a valid email address as the Microchip
>>> one is no longer valid.
>>>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>> ---
>>>
>>> Changes in v2:
>>> - collected tags
>>> - extended the recipients list to include individual subsystem
>>>  maintainers and lists instead using only linux-kernel@vger.kernel.org
>>>  as suggested initially by get_maintainers.pl
>>
>> Consider adding entry in .mailmap as well please.
> 
> Hi Claudiu,
> 
> I'd like to echo Jiri's suggestion of adding .mailmap entry
> to reflect this change.

Hi, Simon, Jiri! It's on my list. I'll handled it asap.

