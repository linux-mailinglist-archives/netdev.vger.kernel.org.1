Return-Path: <netdev+bounces-227140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89307BA8F96
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 13:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A127B0B26
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7D12FF661;
	Mon, 29 Sep 2025 11:10:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF552FF17F
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144203; cv=none; b=WYbKlHyvdYIlKYTpDvb+tG77zf2WtKu1XCBbNRnipmjOFAh9jLkCUxPH+qhPbRCJUi1ISGEC99Nlc64yea33lYes0/OqbG6AZ+RlyQUWcgJK6x4BWnO2dp9XWABlfTNyjzcivodSi7gnPwQH/eE+JXya37fvnLqJgOzSngsLoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144203; c=relaxed/simple;
	bh=yoWI9tBuG8dJAoBjwJL5rPMBZrjRYUFiuP7mwPKh9bA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tZdqsVmgh/Ma/+20R7LBXivFOHjI5M9AKxmbYuHd5HN3+s9RU9IcfkppR1HlJnULIZv5w/5pIsh9AdhdZOh89lrK/yzrtcXlPNZH0JaNtflXuLAc6OzM4CmJdqa8yp3Sc9V1xMYrIceDzMBwODyjEcg+oFZkk9SVYbmOc/YAZ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso3600402f8f.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 04:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759144200; x=1759749000;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJXIca+EvRQ89L7bk2b0DhD+hfD5mOr9d3XCmkqng78=;
        b=ZvrS4ufpwUbttoc4G8oY0OP+CwVDwcVEeeaQjGEQ/eb+HdbAj+HJbj5vgmFUIFjciq
         4r92XURBDISIqmcl19WqYG68QWJYw27RoUZbUBiCu5Rw46+AKCdD+yn7CZgNY4Fq7h6J
         kljSFPIs+dzx+8fxW9RMHEG2Xx/fgK8oKAhZTIgEWjFI9xJdVNC04eUcmz/idKlZv3UR
         cjgqGSs9N5UvKAlQZH/41WXF7gBTWXvQu/sIP0QtkgirtgxnswjDmcwCcJT1F733f5jA
         6zc7M74AiKhCdVCc4FscBupBD4RxfHZYI+TfuP1+AGXy+yO7s1eVlm2339DHYlyDRLq/
         47Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWEWuu0scmk0sV9bkrVfEgt+CWOYF5gFxf/Qc/6Nwumyr2kYdbEmIGMgvnjZ4AAQDJrjd9JEPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjmSe3e3Z6J7ySi4OTWp2K7maZ2W+ue1mFm7O7r3/HWFv6BbfA
	DutNKQjMJ+oETIcZ6wkKZ2BI3f5wwA7fMoHXXHJKE/slMIZRD6e7cBbX
X-Gm-Gg: ASbGncuRSrApHnsqc+T1AoD3T2E/bpqv3CwkzdnB8BtgPcVvXyoyWgv5ztDoi7mTeTR
	cW0uyipESNZUhESBQpZra2FxeWHBOZ1X6XcNmm+hw8YCwQ4oo6qHTqQyLB9sn9UjuALgmQ98RxF
	ycsTsexPgxPpiC3vzgZ538Pf5EbgHsytrCj2HL1HOJsl57bja/UxXrI88w0H4/YyBeGEiG2r9dP
	V7f7xl66pZ7RiusG5bpYBVDXi8FZFhU+pqxSTus+gl+iet/X24YZjSfyg7VpHiPhslEZRXdL95g
	OrN3OyIHp3TOirchiMdJQCGFQNfSj3jWkre/Nlq5dY/8W0rF2XbNyJSwqXeY3AnoeU3DThDpdE6
	PqUmrh1O16xHIuHp+Ee3HhrkhMF1KYBSsWSwR4xaARf8sGk8DTiSAV/J228J3
X-Google-Smtp-Source: AGHT+IH9aUETEOagpmS60xJQuZx9vaucTw+4Nh3QdG4b+6hl0xij063Qzl7J09P/zMRvHTa1TDj1pg==
X-Received: by 2002:a05:6000:2306:b0:3ec:dd19:5ab with SMTP id ffacd0b85a97d-40e4dabf4bcmr12480013f8f.61.1759144199739;
        Mon, 29 Sep 2025 04:09:59 -0700 (PDT)
Received: from [192.168.88.248] (78-80-122-106.customers.tmcz.cz. [78.80.122.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2965sm17803036f8f.55.2025.09.29.04.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:09:59 -0700 (PDT)
Message-ID: <2da082ad-c30e-4f91-8055-43cf63a5abe4@ovn.org>
Date: Mon, 29 Sep 2025 13:09:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, ecree.xilinx@gmail.com,
 Richard Gobert <richardbgobert@gmail.com>, kuniyu@google.com,
 shuah@kernel.org, sdf@fomichev.me, aleksander.lobakin@intel.com,
 florian.fainelli@broadcom.com, alexander.duyck@gmail.com,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com,
 netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
To: Paolo Abeni <pabeni@redhat.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-5-richardbgobert@gmail.com>
 <c557acda-ad4e-4f07-a210-99c3de5960e2@redhat.com>
 <84aea541-7472-4b38-b58d-2e958bde4f98@gmail.com>
 <d88f374a-07ff-46ff-aa04-a205c2d85a4c@gmail.com>
 <dd89dc81-6c1b-4753-9682-9876c18acffc@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <dd89dc81-6c1b-4753-9682-9876c18acffc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 12:15 PM, Paolo Abeni wrote:
> Adding the OVS maintainers for awareness..
> 
> On 9/22/25 10:19 AM, Richard Gobert wrote:
>> Richard Gobert wrote:
>>> Paolo Abeni wrote:
>>>> On 9/16/25 4:48 PM, Richard Gobert wrote:
>>>>> Currently, packets with fixed IDs will be merged only if their
>>>>> don't-fragment bit is set. This restriction is unnecessary since
>>>>> packets without the don't-fragment bit will be forwarded as-is even
>>>>> if they were merged together. The merged packets will be segmented
>>>>> into their original forms before being forwarded, either by GSO or
>>>>> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
>>>>> is set, in which case the IDs can become incrementing, which is also fine.
>>>>>
>>>>> Note that IP fragmentation is not an issue here, since packets are
>>>>> segmented before being further fragmented. Fragmentation happens the
>>>>> same way regardless of whether the packets were first merged together.
>>>>
>>>> I agree with Willem, that an explicit assertion somewhere (in
>>>> ip_do_fragmentation?!?) could be useful.
>>>>
>>>
>>> As I replied to Willem, I'll mention ip_finish_output_gso explicitly in the
>>> commit message.
>>>
>>> Or did you mean I should add some type of WARN_ON assertion that ip_do_fragment isn't
>>> called for GSO packets?
>>>
>>>> Also I'm not sure that "packets are segmented before being further
>>>> fragmented" is always true for the OVS forwarding scenario.
>>>>
>>>
>>> If this is really the case, it is a bug in OVS. Segmentation is required before
>>> fragmentation as otherwise GRO isn't transparent and fragments will be forwarded
>>> that contain data from multiple different packets. It's also probably less efficient,
>>> if the segment size is smaller than the MTU. I think this should be addressed in a
>>> separate patch series.
>>>
>>> I'll also mention OVS in the commit message.
>>>
>>
>> I looked into it, and it seems that you are correct. Looks like fragmentation
>> can occur without segmentation in the OVS forwarding case. As I said, this is
>> a bug since generated fragments may contain data from multiple packets. Still,
>> this can already happen for packets with incrementing IDs and nothing special
>> in particular will happen for the packets discussed in this patch. This should
>> be fixed in a separate patch series, as do all other cases where ip_do_fragment
>> is called directly without segmenting the packets first.
> 
> TL;DR: apparently there is a bug in OVS segmentation/fragmentation code:
> OVS can do fragmentation of GSO packets without segmenting them
> beforehands, please see the threads under:
> 
> https://lore.kernel.org/netdev/20250916144841.4884-5-richardbgobert@gmail.com/
> 
> for the whole discussion.

Hmm.  Thanks for pointing that out.  It does seem like OVS will fragment
GSO packets without segmenting them first in case MRU of that packet is
larger than the MTU of the destination port.  In practice though, MRU of
a GSO packet should not exceed path MTU in a general case.  I suppose it
can still happen in some corner cases, e.g. if MTU suddenly changed, in
which case the packet should probably be dropped instead of re-fragmenting.

I also looked through other parts of the kernel and it seems like GSO
packets are not fragmented after being segmented in other places like
the br-netfilter code.  Which suggests that MRU supposed to be smaller
than MTU and so the fragmentation is not necessary, otherwise the packets
will be dropped.

Does that sound correct or am I missing some cases here?

Best regards, Ilya Maximets.

