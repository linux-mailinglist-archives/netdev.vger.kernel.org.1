Return-Path: <netdev+bounces-44528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18717D8718
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 18:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420CFB20FF2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63E37C93;
	Thu, 26 Oct 2023 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYfs1UvB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A01947F
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:56:24 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DD5A4
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:56:23 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a6907e9aa8so29878439f.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698339382; x=1698944182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pb8AVXddAhoBblmZnhjBx3qovIXAv7Urfx982qCtqfw=;
        b=YYfs1UvBohXuXCaqlIcc53vMfuwYBANA08pth+AQlRK7s7UAUCozLnQ8qknCO8pcnZ
         5t/Ny+HEEeZQwge8sTh5KvtXuGhRGUvRmEKPAacfPYteVrBnGaFZQzDaj95iR4gMyTBx
         K9rXtWD4FrEAkv9SRsg6C+7/DRQreW/4Cqr+jtGim9LFWwCnkWkBmgKdkoWredDBuFQq
         UxeXHiS4vwPid4BDkkEiOcpORnAnPCA9zjT+vmP7K4JY2vpT0NRY2elGTT18C5qrB89q
         NzWkYRnMMDOyh3VMJqxkzCkssXRjieeBm5UmRzzxA0FDOvwvuGDOA4q805mKWN8RW25F
         Be4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698339382; x=1698944182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pb8AVXddAhoBblmZnhjBx3qovIXAv7Urfx982qCtqfw=;
        b=a39CDF7lvDpxEXtYkxhrHV0bcLrtpYKEN2oDhCvxMxvTj+6D8wPI+P61SUHnVdtKzE
         441jMNJso7c1YhlvogWN9Ygw+liAXIZxWwH9g/MxK4DsObDdyYdI+XIiiHDxKU1STD5B
         RLH95vbt5IHsft0vWdznLW3RFdiW+ejtN7pzyywr4GOQ1sjB01QNfMSiPilTSnf7unVS
         ty8GnFtMngRqVBsSy0Sv/nTlRGL2CwqEE6Fbe5EUzW6jFYrOryEU+7ZKs99C+azTZLfN
         1x9GAXyBtPgd9Vy6YoEHKMPvTey8H3zWhrqMKEeHuUmNyqAyCXNBYXaQckJQOt4mSwRe
         qlqA==
X-Gm-Message-State: AOJu0Yw/+O7+BCKnphZWwRZcUi6AlNFUVjUEy4YGwa51tItkkQHHqM1C
	bYZHA59cXknTe3QPAMwgEzkbiV1CevM=
X-Google-Smtp-Source: AGHT+IGvy+RGufezjf4G70vd2U0Ox6kD+G79WNWukraEuxjkVWP0awguz08REz45gqmv+e8Wtw1DDg==
X-Received: by 2002:a05:6602:2b86:b0:7a9:96aa:e01e with SMTP id r6-20020a0566022b8600b007a996aae01emr200638iov.17.1698339382520;
        Thu, 26 Oct 2023 09:56:22 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:542:b658:250a:2f23? ([2601:282:1e82:2350:542:b658:250a:2f23])
        by smtp.googlemail.com with ESMTPSA id l22-20020a056602277600b007a29bd0befasm668112ioe.13.2023.10.26.09.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 09:56:21 -0700 (PDT)
Message-ID: <1d25df23-3ef6-40f0-a9f0-844da8e17f57@gmail.com>
Date: Thu, 26 Oct 2023 10:56:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch iproute2-next v3 1/6] ip/ipnetns: move internals of
 get_netnsid_from_name() into namespace.c
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, daniel.machon@microchip.com
References: <20231024100403.762862-1-jiri@resnulli.us>
 <20231024100403.762862-2-jiri@resnulli.us>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231024100403.762862-2-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 4:03 AM, Jiri Pirko wrote:
> diff --git a/include/namespace.h b/include/namespace.h
> index e47f9b5d49d1..e860a4b8ee5b 100644
> --- a/include/namespace.h
> +++ b/include/namespace.h
> @@ -8,6 +8,8 @@
>  #include <sys/syscall.h>
>  #include <errno.h>
>  
> +#include "namespace.h"

??? including this file into itself?

> +
>  #ifndef NETNS_RUN_DIR
>  #define NETNS_RUN_DIR "/var/run/netns"
>  #endif
> @@ -58,4 +60,6 @@ struct netns_func {
>  	void *arg;
>  };
>  
> +int netns_id_from_name(struct rtnl_handle *rtnl, const char *name);
> +
>  #endif /* __NAMESPACE_H__ */


