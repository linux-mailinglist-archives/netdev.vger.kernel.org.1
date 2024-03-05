Return-Path: <netdev+bounces-77316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629788713E9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 03:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F25C2882BE
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 02:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BD227441;
	Tue,  5 Mar 2024 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B58nCN+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2828E02
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606975; cv=none; b=OvZRjYraXatOIr5yWJYAP0nwAH4CIkELnO8CLMiTPfMYVkIUZ3ScCljJPEyee5yi21Kzt0VaGu9T7lCpV851qG2HZ2KAAq1CChNORUKR5OtwV5QvdNKohGRXEibMScIuuB3C7aN49r3JWJ4ZcsvzlPkYafMD7bVQ2NEKw2TiJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606975; c=relaxed/simple;
	bh=KGedOZEoj221qbWB1vGk81BPOCBgdNnT7jLv+Ym8ves=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KHKAQnCX0rw6xrZKubBr2NtxdDSwv61jDrjeMFfdNNzKNgQOiagmBAvsl6ronehHwn0iTL5vsTm+L9fIqN49hb258vZ9hvR+xIHryBHQLfZU5R5y35p9eTjIgR5EzCTezRzFeOBhM+b9x3GBuo7F7Gq0GuBNxA9C4Wnxnn0p5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B58nCN+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA66DC433F1;
	Tue,  5 Mar 2024 02:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709606975;
	bh=KGedOZEoj221qbWB1vGk81BPOCBgdNnT7jLv+Ym8ves=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=B58nCN+5WZJ3516pHeQl/YfNj2YMkO415k5heBxWKQURcphbQOSK4E3XdyOCxwfGa
	 OZge5S1h3BYNk+aeyRAU6KzYQEVdU7N1X7G2KlCGXdQZ7RWGkSfH1Gc2NaOw+YO5OD
	 gznUEVVKoOhgq32GYKoyFey+po6ajKyXY2YM5JEu6ZmkgEM3nzkdU1w+T0nO7WfKSs
	 lTGWSDBeWnwOEA4N+NF9dvJk8lOwa9DpVxgXDmMS3yhnlMLAI+gH5AHvucIH3UOl32
	 xmvKXFVh83mJLdZIh8KuXzSRhz4EI8wYUh6ZRQD1Ujm63X/0OQ9bu6Ey9jilQSrwcS
	 8mD58jWarAD6g==
Message-ID: <ad0de3e3-e988-4975-b8b7-5ae7574087f6@kernel.org>
Date: Mon, 4 Mar 2024 19:49:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a test.
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, netdev@vger.kernel.org,
 ast@kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuifeng@meta.com
References: <20240223081346.2052267-1-thinker.li@gmail.com>
 <20240223182109.3cb573a2@kernel.org>
 <b1386790-905f-4bc4-8e60-c0c86030b60c@kernel.org>
 <6b73aa09-b842-4bd0-abab-7011495e7176@gmail.com>
 <d2a4bcab-4fab-4750-b856-a8a9b674a31a@gmail.com>
 <20240304074421.41726c4d@kernel.org>
 <d0719417-e67f-48a9-ac1a-970d0c405270@kernel.org>
In-Reply-To: <d0719417-e67f-48a9-ac1a-970d0c405270@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 7:41 PM, David Ahern wrote:
> On 3/4/24 8:44 AM, Jakub Kicinski wrote:
>> On Fri, 1 Mar 2024 16:45:58 -0800 Kui-Feng Lee wrote:
>>> However, some extra waiting may be added to it.
>>> There are two possible extra waiting. The first one is calling
>>> round_jiffies() in fib6_run_gc(), that may add 750ms at most. The second
>>> one is the granularity of waiting for 5 seconds (in our case) is 512ms
>>> for HZ 1000 according to the comment at the very begin of timer.c.
>>> In fact, it can add 392ms for 5750ms (5000ms + 750ms). Overall, they may
>>> contribute up to 1144ms.
>>>
>>> Does that make sense?
>>>
>>> Debug build is slower. So, the test scripts will be slower than normal
>>> build. That means the script is actually waiting longer with a debug build.
>>
>> Meaning bumping the wait to $((($EXPIRE + 1) * 2))
>> should be enough for the non-debug runner?
> 
> I have not had time to do a deep a dive on the timing, but it seems odd
> to me that a 1 second timer can turn into 11 sec. That means for 10
> seconds (10x the time the user requested) the route survived.

Also, you added a direct call to ipv6_sysctl_rtcache_flush to force a
flush which is going to try to kick off gc at that moment. Is the delay
kicking in?

delay = net->ipv6.sysctl.flush_delay;



