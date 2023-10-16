Return-Path: <netdev+bounces-41330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5F87CA936
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E35B20CC9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0692773B;
	Mon, 16 Oct 2023 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FIDM8/5k"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54527738
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:17:28 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B24100
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:17:26 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57ddba5ba84so352696eaf.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697462246; x=1698067046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bh3+AgzPel++Li3i4cnaSQ7/7AOtdWQs4MXrIboRuuI=;
        b=FIDM8/5kZdjdRNyaOYo7ZqsYXQM9Fb0Iq85/g5ZEU5EeiPOiPFR3JoMQ1x5rIQ+0of
         4r2m7qV+OUjEeiSjv/gtJKuLeyVxu9bU4dFMjguIKRVsednR3BiQh3RuVqSfhcwRARu/
         lGYIJcROM+KTMzRsrDfNA4zFVOXUHG0OTbnmiNCmwf9u/lgC2f/yFUeSk62m3nNNclte
         gIJFOUeszgFhf0KUnT4DJGf6IyZPy5b5MURYg0QMhmJrd+SxXLvk6yfZiT/F3p9zHS/x
         IK19USNGJK5Kt9+nSH0ODthKiK0blcz2oRvFGergFqXxsdCDgCNEUpX/MT9Eg1WYTqJO
         TB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462246; x=1698067046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh3+AgzPel++Li3i4cnaSQ7/7AOtdWQs4MXrIboRuuI=;
        b=kKo7N9ZtB26dsHzf+uQR7609pU9q+vvFk2Pjn0gFIWAo+zkrogo52BEp1Q8P+TkBel
         SAmTbSuwZz0KCoR/tHpUoCvtAZIJ47cuZ+ihmOqsISEcmJamTmWbQsffJttwdCB64nK4
         abUcPMo1dCsfR0eKp4XdNT2LqeGbjKC47+hciIzMul9iEuMkx+gJNKjRdD1v0FW9gwjT
         GU7PrmEMZ59gb41lmt1b1MIp6BeB8RTpkG2jzPy24G4COH3h76ZaWMHnRAc9G062xtPf
         9xNJT/U5Z4Iz08ZT15dzaY2iz6wJyadVs9Z6S9cux8bkFIXwWdvBzf43SGDaRl5k/VbQ
         VxKQ==
X-Gm-Message-State: AOJu0YwocaXSL/jzsavHckzUWN1cVHdxQ+rst1Tyu0DagX+dDAJ1GlrJ
	yPvC5w9WAo4wBrDcsLMe8Vuvn6HBUH7w0NJKRV9NJQ==
X-Google-Smtp-Source: AGHT+IGrbEqS8GB9c2OLyOHVDopIm4PpEGTpzwlL5dIZqSUY0IIG2s6mgrgGOmiIWAxRmhO0G6UG0Q==
X-Received: by 2002:a05:6358:e908:b0:147:47f2:2d54 with SMTP id gk8-20020a056358e90800b0014747f22d54mr28008523rwb.0.1697462245823;
        Mon, 16 Oct 2023 06:17:25 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id x24-20020aa79ad8000000b006b341144ad0sm5760746pfp.102.2023.10.16.06.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 06:17:24 -0700 (PDT)
Message-ID: <50310b5e-7642-4ca1-a9e1-6d817d472131@kernel.dk>
Date: Mon, 16 Oct 2023 07:17:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with io_uring splice and KTLS
Content-Language: en-US
To: Sascha Hauer <sha@pengutronix.de>
Cc: Boris Pismenny <borisp@nvidia.com>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, kernel@pengutronix.de,
 Jakub Kicinski <kuba@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
References: <20231010141932.GD3114228@pengutronix.de>
 <d729781a-3d12-423b-973e-c16fdbcbb60b@kernel.dk>
 <20231012133407.GA3359458@pengutronix.de>
 <f39ef992-4789-4c30-92ef-e3114a31d5c7@kernel.dk>
 <20231013054716.GG3359458@pengutronix.de>
 <a9dd11d9-b5b8-456d-b8b6-12257e2924ab@kernel.dk>
 <20231016072646.GV3359458@pengutronix.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231016072646.GV3359458@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 1:26 AM, Sascha Hauer wrote:
> On Fri, Oct 13, 2023 at 07:45:55AM -0600, Jens Axboe wrote:
>> On 10/12/23 11:47 PM, Sascha Hauer wrote:
>>> On Thu, Oct 12, 2023 at 07:45:07PM -0600, Jens Axboe wrote:
>>>> On 10/12/23 7:34 AM, Sascha Hauer wrote:
>>>>> In case you don't have encryption hardware you can create an
>>>>> asynchronous encryption module using cryptd. Compile a kernel with
>>>>> CONFIG_CRYPTO_USER_API_AEAD and CONFIG_CRYPTO_CRYPTD and start the
>>>>> webserver with the '-c' option. /proc/crypto should then contain an
>>>>> entry with:
>>>>>
>>>>>  name         : gcm(aes)
>>>>>  driver       : cryptd(gcm_base(ctr(aes-generic),ghash-generic))
>>>>>  module       : kernel
>>>>>  priority     : 150
>>>>
>>>> I did a bit of prep work to ensure I had everything working for when
>>>> there's time to dive into it, but starting it with -c doesn't register
>>>> this entry. Turns out the bind() in there returns -1/ENOENT.
>>>
>>> Yes, that happens here as well, that's why I don't check for the error
>>> in the bind call. Nevertheless it has the desired effect that the new
>>> algorithm is registered and used from there on. BTW you only need to
>>> start the webserver once with -c. If you start it repeatedly with -c a
>>> new gcm(aes) instance is registered each time.
>>
>> Gotcha - I wasn't able to trigger the condition, which is why I thought
>> perhaps I was missing something.
>>
>> Can you try the below patch and see if that makes a difference? I'm not
>> quite sure why it would since you said it triggers with DEFER_TASKRUN as
>> well, and for that kind of notification, you should never hit the paths
>> you have detailed in the debug patch.
> 
> I can confirm that this patch makes it work for me. I tested with both
> software cryptd and also with my original CAAM encryption workload.
> IORING_SETUP_SINGLE_ISSUER | IORING_SETUP_DEFER_TASKRUN is not needed.
> Both my simple webserver and the original C++ Webserver from our
> customer are now working without problems.

OK, good to hear. I'm assuming you only change for
sk_stream_wait_memory()? If you can reproduce, would be good to test.
But i general none of them should hurt.

FWIW, the reason why DEFER_TASKRUN wasn't fully solving it is because
we'd also use TIF_NOTIFY_SIGNAL for creating new io-wq workers. So while
task_work would not be the trigger for setting that condition, we'd
still end up doing it via io-wq worker creation.

> Do you think there is a chance getting this change upstream? I'm a bit
> afraid the code originally uses signal_pending() instead of
> task_sigpending() for a good reason.

The distinction between signal_pending() and task_sigpending() was
introduced with TIF_NOTIFY_SIGNAL. This isn't a case of networking
needing to use signal_pending(), just that this is was originally the
only aborting condition and now it's a bit too broad for some cases
(like this one).

-- 
Jens Axboe


