Return-Path: <netdev+bounces-48787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADF47EF8DC
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 21:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8100280D6E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30645038;
	Fri, 17 Nov 2023 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="RdVJkpp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C4D72
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 12:51:00 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a68b87b265so83452239f.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 12:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1700254260; x=1700859060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+LcdbJ40kwiz4H5n6a5Ekh3a4ElzIpNj2R6AuVc6sU=;
        b=RdVJkpp8XbMBBxDJUQ8aWejgQyrSXEQ75R3eH7dzP8Bpd1TIIyh8B+8sRosq8TpWmk
         WDgjgIhdoP4Q24zxu+SdYZ8ZzfWlTettE+rBWYc9RFLGZcB3XWX0/HBBOyjPBmP7h/m+
         AKQvan0TnCXWESqF6+VEH7yvbCP9/4vyFFeno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700254260; x=1700859060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+LcdbJ40kwiz4H5n6a5Ekh3a4ElzIpNj2R6AuVc6sU=;
        b=OzavWVmnWtScq5F1kFoEnXxVgdhX19Bo0tmk5TUKPkHahTncCLbbqO8vGTNwG7P6qW
         PfDbvJIbQ6v0m/cXUeIB96BVwGjjZphZmce/kjHJ9nYdbVWNgIihPSqa3QidF5gr8qq2
         7cbUTjb5/GB4unyuWHoNioBO4lt2HwqWidXdrDuFizHiNli1XFbIfqqDiXRKD13ExXtA
         HaTQyvBC0hinRQSgPHnG+hDFWtN4vOGYipnZ6DsPdQARrxBMkn9rzGXcrBQLkZqa3QFB
         ss0yLfLY0kHkltJLII0R9+HrXfZq56X52jHZaj5iF6fh+HnTwqDV5POa3P4WvVNLGudn
         rYiA==
X-Gm-Message-State: AOJu0YzUwLPotW429QgYDHZ2JfA2NQurIHY50fgkf5yBYHlJhtR8iOEF
	AIuuUDHXvVUQiJ5gyudU19XsKg==
X-Google-Smtp-Source: AGHT+IHycE50SYVPmlqZloaghPwrzD3Yj5yV/Gkna4hMFDFdxWEHcOBMqi/7KvPcZoNbozt/LHNIYw==
X-Received: by 2002:a6b:5009:0:b0:786:fff8:13c2 with SMTP id e9-20020a6b5009000000b00786fff813c2mr682277iob.11.1700254260005;
        Fri, 17 Nov 2023 12:51:00 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id s18-20020a5e9812000000b007a951cf9bf4sm631505ioj.26.2023.11.17.12.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 12:50:59 -0800 (PST)
Message-ID: <9a0c97e7-a790-4440-9f92-0dfb077e18c5@ieee.org>
Date: Fri, 17 Nov 2023 14:50:58 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] net: ipa: Don't error out in .remove()
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Alex Elder <elder@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de
References: <20231117095922.876489-1-u.kleine-koenig@pengutronix.de>
 <20231117095922.876489-2-u.kleine-koenig@pengutronix.de>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20231117095922.876489-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/17/23 3:59 AM, Uwe Kleine-König wrote:
> Returning early from .remove() with an error code still results in the
> driver unbinding the device. So the driver core ignores the returned error
> code and the resources that were not freed are never catched up. In
> combination with devm this also often results in use-after-free bugs.
> 
> Here even if the modem cannot be stopped, resources must be freed. So
> replace the early error return by an error message an continue to clean up.
> 
> This prepares changing ipa_remove() to return void.
> 
> Fixes: cdf2e9419dd9 ("soc: qcom: ipa: main code")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/net/ipa/ipa_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index da853353a5c7..60e4f590f5de 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -960,7 +960,8 @@ static int ipa_remove(struct platform_device *pdev)
>   			ret = ipa_modem_stop(ipa);

This ipa_modem_stop() call is the second one in this function,
which is called if the first attempt returned an error.  The
only error that's returned is -EBUSY, which occurs if a request
to stop the modem arrives at a time when we're in transition.
That is, either we are in the process of starting it up, or
we are in the process of stopping it.  In either case, this
transitional state should come to an end quickly.  This second
call happens after a short delay, giving a chance for the start
or stop that's underway to complete.

If the *second* call returns an error, it's assumed we're stuck
in one of the two transitional states, in which case something is
wrong with the hardware (we've issued a request that did not
complete, for example).  And in that case, we have no way of
knowing whether the hardware will come alive and do something
with a resource that's been allocated for it.

I think I'd rather live with whatever resource leaks occur in
such an unlikely case, rather than free them without knowing
what the (broken) hardware is going to do.

>   		}
>   		if (ret)
> -			return ret;
> +			dev_err(dev, "Failed to stop modem (%pe)\n",
> +				ERR_PTR(ret));

By the above reasoning, I'd rather your patch result in the code
looking like this:

	if (ret) {
		dev_err(dev, "remove: error %d stopping modem\n", ret);
		return ret;		/* XXX Later: just return; */
	}

The message is more consistent with the way other messages in the
driver are written.  If %pe is preferred I'd rather make that change
comprehensively throughout the driver rather than bit-by-bit.

Thanks.

					-Alex

>   		ipa_teardown(ipa);
>   	}


