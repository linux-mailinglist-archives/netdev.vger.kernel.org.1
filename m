Return-Path: <netdev+bounces-35361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6CA7A9056
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 03:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E31281A09
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 01:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA97D623;
	Thu, 21 Sep 2023 01:06:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A3622
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 01:06:30 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0891ED3
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 18:06:29 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79545e141c7so10875539f.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 18:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695258388; x=1695863188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2lS6d/rVtirfRBfQnTOsxCSsuFzDb1dL3dqNuIJXCg=;
        b=afAqJhXvj86yWM1+aj/VrfKSle1mvWIDrWqYKMK72+qZdli9KIMBPcbChOs/jJRswT
         g4ZqnFDzOh3+1fKsHHDbwXu0S6wq4X+lYy4laB+5fgJMCvRZulU5RXZP9rCWr11JdRD2
         jrr6jEHL1EBYS8WcWC67H7ttIHGBOKlPJG7EvlX6lmk3jLOxzmhIBt3HGpiUIlkXZ4Dz
         c6DGi94ayAkYy4cg8O1KYO6dggLCTlMPi5FwOP+5MQJtj+/Jt/szSxDaKBS6IaGHCtdI
         iLVmiUSgGEC0SJ/EnAWTHltK8zgA/3PrfHc8wEOCe0wMq3CPO5vG0g/SJUMwT7Rr4ras
         wDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695258388; x=1695863188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2lS6d/rVtirfRBfQnTOsxCSsuFzDb1dL3dqNuIJXCg=;
        b=OggfqI3nX0B6SnxdcDaB5dhJlhPZD2N0e2EAnerjoIJBidYOCPBt5dz00+cZKjVN8D
         9mHxkyxjg67LQI+hQxSMrSRynvGN9oJOnW+RMaeAIZljJ5Cdb0Z6bd8Vckgrg6h1LFdh
         Rrd8KihEQLzJ3XeIBI//CUQrQIZNFLe7j5kkKzGCdZJq3YkREiwHS0LzN4JckkPTjABK
         l9vuHwRCajglawby3+Ji93MGDoWG4+OXB97OiIowz7RoZMPJ20APgJ50g71cWk/Dnc64
         TkmM+GoOmE1PXonTKw2efs8B68S4DK6opSQbUv3m3tpYXIauXRxoyABBl4D58EkFZ8SV
         AFeQ==
X-Gm-Message-State: AOJu0YxDp+eushy39OjYI5ZpJ+fV1Xe51u9ORpFfI/dm9gvsbzgyxUJ4
	i0uWZgZ8Cmz8Q8Tco1FgJgfvCcFUb4A=
X-Google-Smtp-Source: AGHT+IHpDDc3gD5DM/S1ANulyubcpgLfIhEk60Rq4S0kDqLwIIfg58EqNmseK6/GCE3W/jhWNaQ2Ig==
X-Received: by 2002:a05:6602:1228:b0:79f:8434:a0e0 with SMTP id z8-20020a056602122800b0079f8434a0e0mr382369iot.7.1695258388289;
        Wed, 20 Sep 2023 18:06:28 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:a8ed:9f3d:7434:4c90? ([2601:282:1e82:2350:a8ed:9f3d:7434:4c90])
        by smtp.googlemail.com with ESMTPSA id q19-20020a5d87d3000000b0079216d6f219sm113949ios.14.2023.09.20.18.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 18:06:27 -0700 (PDT)
Message-ID: <0f990b11-7fd9-4a56-2710-5ba8b62fd5f9@gmail.com>
Date: Wed, 20 Sep 2023 19:06:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH iproute2-next v3] allow overriding color option in
 environment
Content-Language: en-US
To: Andrea Claudi <aclaudi@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20230918152910.5325-1-stephen@networkplumber.org>
 <ZQixJquSFzcYrWKh@renaissance-vector>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZQixJquSFzcYrWKh@renaissance-vector>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/23 2:20 PM, Andrea Claudi wrote:
> On Mon, Sep 18, 2023 at 08:29:10AM -0700, Stephen Hemminger wrote:
>> For ip, tc, and bridge command introduce IPROUTE_COLORS to enable
>> automatic colorization via environment variable.
>> Similar to how grep handles color flag.
>>
>> Example:
>>   $ IPROUTE_COLORS=auto ip -br addr
>>
>> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>> ---
>> v3 - drop unneccessary check for NULL in match_colors
>>      all three callers pass valid pointer.
>>      drop unnecessary check for NULL in default_color
> 
> The NULL check in default_color is necessary, because getenv may return
> NULL if there is no env variable with the desired name. Indeed it seems
> to me this check is maintained in this patch.
> 
> However the null string check in default_color is also necessary
> because, as I pointed out in the review of the RFC version of this
> patch:
> 
> IPROUTE_COLORS= ip address
> 
> results in colorized output, while I would expect it to produce
> colorless output.
> 
> This happens because we are effectively passing a null string to
> default_color using the above syntax, and match_color_value() treat the
> null string as 'always'.
> 
> Please note that this is indeed correct when calling match_color_value
> when the '-c / --color' option is provided, but not when the env
> variable is used to determine the color.
> 

FYI: I did not get this patch, and it is not showing in patchworks either.

