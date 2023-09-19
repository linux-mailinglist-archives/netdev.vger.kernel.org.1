Return-Path: <netdev+bounces-34992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8437A6619
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B24F282229
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46623374F6;
	Tue, 19 Sep 2023 14:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FBD3C07
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:03:29 +0000 (UTC)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A4A9E
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:03:28 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34fcd361e91so10397915ab.3
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695132208; x=1695737008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yr1EmBU3z8zaF8gW5flexCW4+S+vFcHnORpBf7NfWV0=;
        b=bVlInYs2NVfbSDJq1UEKVxXwaQCmG5G5rnR766p5YlySoDx1zqtZ+VYy2B5SN86vmf
         0amUMkq8xPz2qUMW6xhyZ3FCaH+dz9AwSH7b0u9MZrFbI8fXLcaHrGOeLdt3hzu/bs/c
         /2KsEkp8gqVZeO+tj0CH7vsy2pKvv9aoCRxAgOk5XaIOKvpgAKA/UhIeUD55ju9L9xoW
         D0mJQGBrJ2HXiAZBbIGA8LUUGGQZVSl7M87AVIW29AX7hX4q4w1mcxixjnCHT4vwd/sa
         prrOew1MD+W/keiE1BXj/Rcfimap0onmHYzY6A/qoKTHPQ/PAR5HmYFUoPaH7BSCaVId
         YMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132208; x=1695737008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr1EmBU3z8zaF8gW5flexCW4+S+vFcHnORpBf7NfWV0=;
        b=UVEIs4cEhfMFLEn1oW5T0zHFQxYnHcTTIvrISVJys8BFh8DqkI9ngiOdXFV/j17vnV
         DH6LDDq6g2m4HS+nMgcQ/JWp759PLAiwjoDxHJlpbXtjJET56jvuMJN88oJNURpVydSz
         blkpgwGmXH5gl6XONVIKGPd1VJ1tBU7JtjYCEc4i9XYM33SAYm0faiujvkvN8Hxon+Gn
         2N94wmvhcJWMhBFrTl8OcUQZx31Q3Xt/f9nTJFyekdobVSNRzGvHqxBBmQS08EngE43R
         MhbNFyz6zWuKxNSWamd3Y43okV0xeTT4FI9BH7ZA8K6xBMREN94QENQc4kWSAul6vWR4
         W9zg==
X-Gm-Message-State: AOJu0Yza1w1Qy6SzczQiabDzd/B3fJuEenw+Y8uaDhqX8J6p9iegbTAu
	RbjKGpk/pZOWidPjC96UvmIsXXAQ3UM=
X-Google-Smtp-Source: AGHT+IHc9Bpq/UBx3A4PHUSZZG6Kd4Oa/Isjsvlr/qdIXyGRWVZeEzOsVcB5uGKufzm9aNWKSk2/yQ==
X-Received: by 2002:a05:6e02:1605:b0:34f:7e1b:a7a2 with SMTP id t5-20020a056e02160500b0034f7e1ba7a2mr16223373ilu.13.1695132207739;
        Tue, 19 Sep 2023 07:03:27 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:a8ed:9f3d:7434:4c90? ([2601:282:1e82:2350:a8ed:9f3d:7434:4c90])
        by smtp.googlemail.com with ESMTPSA id q11-20020a056e02106b00b0034a921bc93asm3048237ilj.1.2023.09.19.07.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 07:03:27 -0700 (PDT)
Message-ID: <a4a7f033-e072-15c5-0084-7039456cf4db@gmail.com>
Date: Tue, 19 Sep 2023 08:03:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [patch iproute2-next v2 2/5] ip/ipnetns: move internals of
 get_netnsid_from_name() into namespace.c
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, daniel.machon@microchip.com
References: <20230919115644.1157890-1-jiri@resnulli.us>
 <20230919115644.1157890-3-jiri@resnulli.us>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230919115644.1157890-3-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/19/23 5:56 AM, Jiri Pirko wrote:
> diff --git a/lib/namespace.c b/lib/namespace.c
> index 1202fa85f97d..39981d835aa5 100644
> --- a/lib/namespace.c
> +++ b/lib/namespace.c
> @@ -7,9 +7,11 @@
>  #include <fcntl.h>
>  #include <dirent.h>
>  #include <limits.h>
> +#include <linux/net_namespace.h>
>  
>  #include "utils.h"
>  #include "namespace.h"
> +#include "libnetlink.h"
>  
>  static void bind_etc(const char *name)
>  {
> @@ -139,3 +141,50 @@ int netns_foreach(int (*func)(char *nsname, void *arg), void *arg)
>  	closedir(dir);
>  	return 0;
>  }
> +
> +int netns_netnsid_from_name(struct rtnl_handle *rtnl, const char *name)

just netns_id_from_name or netns_name_to_id. See comment in next patch ....


