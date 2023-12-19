Return-Path: <netdev+bounces-58754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2FA817FEE
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 03:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE44C1F23347
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 02:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A687D15AB;
	Tue, 19 Dec 2023 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1Q3iC4V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BC79C2
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 02:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e7415df4d6so7906747b3.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 18:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702953905; x=1703558705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=An9zJwJNmznbaeONtJS2lyTdh1jPvxfKVpSvMYzXtu0=;
        b=N1Q3iC4Vv1llsfYQWTtrYsYsDQSJv20BnXoy8P4KELr6ajx5StKUbSGtl7rHpXRXOV
         k7TKd6wBo6L5r5a80Bxa/cz/OfKcB1t4+uTtYrJkJMRpvpd2sl1UdUANFH9r0Ro/aFvo
         yCWyuB9/W8Crxwe0kEAYpXIG9r5bgfkAwICT6JLq5L6aa+R5aQaWFpn2049BoMPAHDWt
         0uIYhHzyXr1W+QwWbGVpSh+xla36af6vFs/c7ZrEzFVA2mpi3B66DMl7QxC00tE1op8m
         92mgMsT/wKOsxLLuqTlRZwpXQdmg19UPqR2VkkZHGFQp+Vnzz3GRQagPb/4fj9ccQFHG
         0p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702953905; x=1703558705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=An9zJwJNmznbaeONtJS2lyTdh1jPvxfKVpSvMYzXtu0=;
        b=hG9yrKkoi4DxJLQAAVUmf/7wopoOSBprc0z5DPd9H+M1xk6suZkvxB5+00z0W/6MYT
         rafXlz+BIrulwQ9n5onTAbFUIyUl2d0rvXrxosC83yzPMRTcXlpb3O1SWfZtK1wf0lk1
         IpwctOoeGroEih2n82/j3L0o9BLy31x0WZ8lA1uNM8lmqrRU4qiyLoOahl4cDUHbkw+Z
         EpdGyb9ZIbG7cKBuqxfowzDTaLjZnOIJ7n4vViz8AsTnn2NnpMTOuwldVm+ldCJRCYml
         xO1xDvyhFK+Hkk01Tv6tGiahP7Osmk6gXAX48qyYwd67oMKTwIbwg+xUEX17pjBx9jiD
         AVvA==
X-Gm-Message-State: AOJu0Yxb8NNGE0zsjYQAIsTEA+nYSdXL0Hm4AJpzJ3p8OlK8kP3tMUtO
	6O8FK8zIbdC9St0e+WvAK8I=
X-Google-Smtp-Source: AGHT+IE9dpt1Y3YR0So4iR0pkWFKEzbZJGzOgxkWME3o90uSIocpx4pVShrrMWjiIwVs/n1pWXZ8XA==
X-Received: by 2002:a81:5b57:0:b0:5d7:1a33:5ad7 with SMTP id p84-20020a815b57000000b005d71a335ad7mr215146ywb.36.1702953905205;
        Mon, 18 Dec 2023 18:45:05 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:e84:899c:4b9b:a70e? ([2600:1700:6cf8:1240:e84:899c:4b9b:a70e])
        by smtp.gmail.com with ESMTPSA id gw6-20020a05690c460600b005e492ea4709sm3311880ywb.46.2023.12.18.18.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 18:45:04 -0800 (PST)
Message-ID: <9e8f86e1-8663-4bbb-baa9-fe0030dbbabd@gmail.com>
Date: Mon, 18 Dec 2023 18:45:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/ipv6: Revert remove expired routes with a
 separated list of routes
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: edumazet@google.com, Kui-Feng Lee <thinker.li@gmail.com>
References: <20231217185505.22867-1-dsahern@kernel.org>
 <a289e845-f244-48a4-ba75-34ce027c0de4@gmail.com>
 <c3ae9c3a-9ecd-4b22-a908-9da587c1c88b@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c3ae9c3a-9ecd-4b22-a908-9da587c1c88b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/18/23 18:38, David Ahern wrote:
> On 12/18/23 6:14 PM, Kui-Feng Lee wrote:
>>
>>
>> On 12/17/23 10:55, David Ahern wrote:
>>> Revert the remainder of 5a08d0065a915 which added a warn on if a fib
>>> entry is still on the gc_link list, and then revert  all of the commit
>>> in the Fixes tag. The commit has some race conditions given how expires
>>> is managed on a fib6_info in relation to timer start, adding the entry
>>> to the gc list and setting the timer value leading to UAF. Revert
>>> the commit and try again in a later release.
>>
>> May I know what your concerns are about the patch I provided?
>> Even I try it again later, I still need to know what I miss and should
>> address.
> 
> This is a judgement call based on 6.7-rc number and upcoming holidays
> with people offline. A bug fix is needed for a performance optimization;
> the smart response here is to revert the patch and try again after the
> holidays.
Got it! Thanks!

