Return-Path: <netdev+bounces-48692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 958BE7EF441
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162A9B20B37
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B7D31A60;
	Fri, 17 Nov 2023 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="OSHULDO+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC539D4B
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:16:04 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-359c1f42680so6654295ab.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1700230564; x=1700835364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0zkkaGQQfuew0hR3yiZNKRsG691DBdOcjFfvtSIFng=;
        b=OSHULDO+hPUMmriSxtAD13eY1r4DFSjN97ynlcCmgN0MpLscxyRlvB9//FU0ZymZ/8
         +b/bQ5TOR8EJFpaNmDY8sd+zbojVsQ4D9iWqepqoHsZ2Ah2eoEc+XHaGzG9Kv3QPK0o2
         rdgkRTJmNZsGFBIifDxD20HUwy5p010bOylgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230564; x=1700835364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0zkkaGQQfuew0hR3yiZNKRsG691DBdOcjFfvtSIFng=;
        b=gXcdgxiR8Na1kgf9EqOpqc802+I3GTqZRwCXkqgRoAjDiW2n6v95RlAyIQxfew5b+Y
         buQAR45eemjyQJz+6ikSn7AiGMsTDo+ns9KkmlTyYeVrjOe7rMGaeBmA0eiITEDyku5t
         6xsRioD5bkpn/y/niTDkR4Iwdom8necoEYxyFWKV3xA3IG5DzPLVOl3K/tEmQpyPIvGx
         +SDJtqP2rEDlCQfRsSCLssJmkCkHXTGgbFBHq6alaDYKTQuDDYaN0P4iyuP1RViCPgmX
         Dp6c6GMISKMMilnhSM0HBWt1Vi4NgnR9bH6lQQBEhk/40n5viiU8YDQqV/1E+Zoqk+P3
         fgLA==
X-Gm-Message-State: AOJu0YyYBnA5b5blxN69gcArINVsk0oENMenqsbjYsE+yJVzEvd5PlS2
	62vEIyiDeH99EwSd2JXnWUBNcQ==
X-Google-Smtp-Source: AGHT+IHrslgqUbhSMSKPfCItRaJiFm+81phLKiF4fYW7uc8VLB3ATt3nV390Bao0abd+AcVqYEmQEw==
X-Received: by 2002:a05:6e02:1a09:b0:359:c239:3f57 with SMTP id s9-20020a056e021a0900b00359c2393f57mr24128553ild.16.1700230564196;
        Fri, 17 Nov 2023 06:16:04 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id h7-20020a056e021d8700b00359c1e6cf78sm504795ila.38.2023.11.17.06.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 06:16:03 -0800 (PST)
Message-ID: <79f4a1ff-c4af-45be-b15c-fa07bc67f449@ieee.org>
Date: Fri, 17 Nov 2023 08:16:02 -0600
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

Is this really a bug fix?  This code was doing the right
thing even if the caller was not.

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
>   		}
>   		if (ret)
> -			return ret;
> +			dev_err(dev, "Failed to stop modem (%pe)\n",
> +				ERR_PTR(ret));

I think this is not correct, or rather, I think it is less
correct than returning early.

What's happening here is we're trying to stop the modem.
It is an external entity that might have some in-flight
activity that could include "owning" some buffers provided
by Linux, to be filled with received data.  There's a
chance that cleaning up (with the call to ipa_teardown())
can do the right thing, but I'm not going to sign off on
this until I've looked at that in closer detail.

This is something that *could* happen but is not *expected*
to happen.  We expect stopping the modem to succeed so if
it doesn't, something's wrong and it's not 100% clear how
to properly handle it.

For now...  you know a little more about my hesitation, but
please wait to commit this change until I've had a chance
to spend more time reviewing.

					-Alex

>   
>   		ipa_teardown(ipa);
>   	}


