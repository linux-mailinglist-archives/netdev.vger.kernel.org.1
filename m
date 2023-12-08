Return-Path: <netdev+bounces-55457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCEC80AEED
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604F0B20ADA
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 21:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF25C58118;
	Fri,  8 Dec 2023 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bKVi8Gfb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984889F
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 13:45:05 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce6b62746dso1953847b3a.2
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 13:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702071905; x=1702676705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmMyRjA9C9ut996RJfC4MCasWD+B/6bdQ/5Nxu9vz3E=;
        b=bKVi8GfbrD/fos02KZ1AkroaWEY4NNL+MjmtN2lnM1CuPa7ZQBvKlKDvtIG9NpTfdM
         XcKLeZ16ZkZxYRuiXStkreGb8eGpIwZAwqvYP3Wu9Rvo8V2ZHdD2HHDag9i1X9bRGyZZ
         xJzZ44q1BGWszuYzvMGf1jiEERcwoFHnb4zTIbGPjwwa42GSMqbwWJOUH2XWfvpmUJ5V
         dHdLZOBcNzDb/qxVKxQ5859lRSzFxX9IOZmBP7tknCuEIJFwd/VuqZJI073CYHq/R25y
         s0mjyfJ67I85+uJn0i/8BT0ZNAxijvV4nHD6O9a5YqV23QZhmp2ixLUi9uea4j0xANuj
         LS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702071905; x=1702676705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmMyRjA9C9ut996RJfC4MCasWD+B/6bdQ/5Nxu9vz3E=;
        b=XAjKc4I0rJqUWFe+BFZrPo2a5xfEGfI7aUYDdHYMZnD9ux6hUmPkHM3lrfGPRUy6G8
         V8+2QkeyUbBuoj0311yAUlkcbfT9JBaEXsuBe6dOKys+ioj+JFLLNI3Y4qFPwSh2jmZU
         qM30KbsUoDYzO1W0g4QnjCU/VtZKPGCKe6/Z8SUO4+VKvC3rL+aGfvvzDaZKkYSjhoYi
         zCQqDKVede4AXcABfV5+hD2EZjB8DT1HRx4TpNJjBCSLv13FaWIpyIphkgCSui+yEnWa
         5ioseLCFnIRsSOgjEbP7OQ6Lu8kLdd3xsoI7ZWYUw0vXw5HR0LRA8QSda+wAit+rj244
         vLRg==
X-Gm-Message-State: AOJu0YyVQ5Rf/fIw2LS0kH4NWbeHdFPiAgiu6mFwIjA+qqH/Bhg0OKcz
	pDgP01PilMKTL6A2+fCklg6n6qCq6PPFKF1nH2njNw==
X-Google-Smtp-Source: AGHT+IEPFP193ixasd3AGYA9Lam+81h0nZlFpgrxtySqx8iiU1fXmbjJLGBSLAC4J4+/tFAw2Ps0Ow==
X-Received: by 2002:a05:6a00:9398:b0:6cd:dece:b73d with SMTP id ka24-20020a056a00939800b006cddeceb73dmr729777pfb.18.1702071904938;
        Fri, 08 Dec 2023 13:45:04 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:34a6])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a00188300b0068fe5a5a566sm2120212pfh.142.2023.12.08.13.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 13:45:04 -0800 (PST)
Message-ID: <43239302-8882-4eb3-ad5f-7843c82d6f3f@davidwei.uk>
Date: Fri, 8 Dec 2023 13:45:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] netdevsim: link and forward skbs between
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20231207172117.3671183-1-dw@davidwei.uk>
 <ZXLsX0/n2r6sUorb@nanopsycho>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZXLsX0/n2r6sUorb@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-08 02:13, Jiri Pirko wrote:
> "netdevsim: link and forward skbs between"
> I think it there something wrong with your email client, cutting
> subjects like this (all of them).

Apologies, I autoformatted my patch files before git send-email which
wrapped all lines including the subject.

> 
> Thu, Dec 07, 2023 at 06:21:14PM CET, dw@davidwei.uk wrote:
>> This patchset adds the ability to link two netdevsim ports together and
>> forward skbs between them, similar to veth. The goal is to use netdevsim
>> for testing features e.g. zero copy Rx using io_uring.
>>
>> This feature was tested locally on QEMU, and a selftest is included.
>>
>> David Wei (3):
>>  netdevsim: allow two netdevsim ports to be connected
>>  netdevsim: forward skbs from one connected port to another
>>  netdevsim: add selftest for forwarding skb between connected ports
>>
>> drivers/net/netdevsim/bus.c                   |  10 ++
>> drivers/net/netdevsim/dev.c                   |  97 +++++++++++++++
>> drivers/net/netdevsim/netdev.c                |  25 +++-
>> drivers/net/netdevsim/netdevsim.h             |   3 +
>> .../drivers/net/netdevsim/forward.sh          | 111 ++++++++++++++++++
>> 5 files changed, 241 insertions(+), 5 deletions(-)
>> create mode 100755 tools/testing/selftests/drivers/net/netdevsim/forward.sh
>>
>> -- 
>> 2.39.3
>>
>>

