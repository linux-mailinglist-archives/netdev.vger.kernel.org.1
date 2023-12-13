Return-Path: <netdev+bounces-57052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B5811C53
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1991F21907
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4959B4B;
	Wed, 13 Dec 2023 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wfEtH8UD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C0B9
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:25:38 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce76f0748fso4678112b3a.2
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702491938; x=1703096738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOoF6N0/J3cFOv1TqXe0raZIiJevk9NS0CUjnxdJEgE=;
        b=wfEtH8UDqJfYDye8XR7zZgZ7pAN0ylQhK+fe+VcNPRzNhZ7BkGtZ6FrXl7DHNDVld6
         vyNnfs3BxOzFRqcgAqqvVple3siApQcjrwCJsetY6rOmAcNn4MQYAt6+tI3G+VqOPfFE
         EA/FyE0M7dVb01XsIhOVrBW/C8cnUIiWjQXNb5QSVJGNg5tTmoU7fUrXgw8SQB5oV9Y9
         oAep/Z45L18tjCFWWJ2PfCe0D3X1yliwwxHQeS0c8fmc/fQeSa6SASkTK+zxKGgvfxwH
         awUTS1p+zda4okB2MkiqarUiO5OmX+ZlrBxwhnEBJIYTNe4V2/NGPhGD2HUX2WQWGdyH
         ASEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491938; x=1703096738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOoF6N0/J3cFOv1TqXe0raZIiJevk9NS0CUjnxdJEgE=;
        b=mZtCpOEeMHCLjohiN19czONkFQey7lSinZ3B6SPdlt1ceZbG9hPWRKTuKkRzKWNZyj
         MWWlGm1hKMn5imcZR6E4OFFkCF8ZakPuQNdheH4gOK/YrVWJSACjDhDU9d2qyWPSK7Zt
         UIKtY3U1/xnVv1y2DXQs6zO2mr8yrZ7GvbWWV8EZzO1mqK3gd6GGA0hcmK+aqSkM1/2g
         mku0NR+HvAzm1KuFIZUHv04xzdoKcnMeoXqW4JdJTDocucCxkGIhOslqBhAGHgNF4RMn
         t7Vroa56Q0jsLY/PtV80JHi6/y3/hUSr/Pt1mHsRQn3eN/sy1hYOY6bZib0Zkzyv/PBe
         v6fg==
X-Gm-Message-State: AOJu0YzCxoN1xuxUmTzr2u4JFLOgKOBwELJHL21mIjjarX6YtC+y76aA
	VRSbR+8X4+/luAWBiH/zROtjmmaa9CJ8vdi23aU=
X-Google-Smtp-Source: AGHT+IFgi3n4NY1XjA5TZZv9pE8wjrTbzaFyiefxia6QC5TntAwQo5mDkITwMNa0DaEr3/QxjMFDPA==
X-Received: by 2002:a05:6a00:2d13:b0:6ce:5360:31ea with SMTP id fa19-20020a056a002d1300b006ce536031eamr5106447pfb.55.1702491937731;
        Wed, 13 Dec 2023 10:25:37 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:311b:8407:1d2d:c5bb:cc49? ([2804:7f1:e2c0:311b:8407:1d2d:c5bb:cc49])
        by smtp.gmail.com with ESMTPSA id ei43-20020a056a0080eb00b006ce6e431292sm10213490pfb.38.2023.12.13.10.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:25:37 -0800 (PST)
Message-ID: <56865ef2-2219-41e1-8ef4-116c56180786@mojatatu.com>
Date: Wed, 13 Dec 2023 15:25:33 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: sched: Add initial TC error skb drop
 reasons
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 daniel@iogearbox.net, dcaratti@redhat.com, netdev@vger.kernel.org,
 kernel@mojatatu.com
References: <20231205205030.3119672-1-victor@mojatatu.com>
 <20231205205030.3119672-4-victor@mojatatu.com>
 <20231211183031.78f6ffa6@kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20231211183031.78f6ffa6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/2023 23:30, Jakub Kicinski wrote:
> On Tue,  5 Dec 2023 17:50:30 -0300 Victor Nogueira wrote:
>> +	/**
>> +	 * @SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND: tc cookie was looked up
>> +	 * using ext, but was not found.
>> +	 */
>> +	SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND,
>> +	/**
>> +	 * @SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH: tc ext was lookup using
>> +	 * cookie and either was not found or different from expected.
>> +	 */
>> +	SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH,
>> +	/**
>> +	 * @SKB_DROP_REASON_TC_COOKIE_MISMATCH: tc cookie available but was
>> +	 * unable to match to filter.
>> +	 */
>> +	SKB_DROP_REASON_TC_COOKIE_MISMATCH,
> 
> Do we really need 3 reasons for COOKIE?
> 
> Also cookie here is offload state thing right? I wonder how many admins
> / SREs would be able to figure out what's going on based on this kdoc :S
> Let alone if it's a configuration problem or a race condition...

Yeah, probably overkill. Will merge into one.

cheers,
Victor

