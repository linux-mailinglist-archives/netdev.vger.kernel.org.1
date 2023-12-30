Return-Path: <netdev+bounces-60609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDF282032E
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 01:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3539CB221E9
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 00:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28F519D;
	Sat, 30 Dec 2023 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC2CT2Xw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E8EDC
	for <netdev@vger.kernel.org>; Sat, 30 Dec 2023 00:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07FBC433C7;
	Sat, 30 Dec 2023 00:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703896938;
	bh=/kpXGSdgmN2VOfvdgzcQ0ElyR1i0ThVCvkTj2kxNB+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nC2CT2XwuDxTqw8c3tdY/AEjuflc/IeZKKh0Slk67p2Yom6K1bka2R9grcvK8+LX+
	 E8gebGp2dYSlk/FZZlCEfVS8vQU19mM5LNg8vbLP1k7wXS2702nGffBltlNzSb8Oq0
	 BWDl9OoqE32msbroQLeFe8SiddUr9ujdS6qpD89Kg0lM/g2d3JMORFAq2FBZlz9D7b
	 I+e+PWOfAELEuCSh9nbx0T9Zn4kyvCBbumcs5xvKMD4KUt+cmG3MosrpV1uwrGzyIV
	 iNEfol3CefC8jNd5vQEbxcTrVWlYBPxyC1j6wlbSXE4gdmTwYMlN1Y5xKXQvvKk8Nu
	 teDYbUs0jxI5g==
Message-ID: <49de9bba-d232-45a6-aa49-d1b502b378f7@kernel.org>
Date: Fri, 29 Dec 2023 17:42:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 1/2] configure: avoid un-recommended command
 substitution form
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Eli Schwartz <eschwartz93@gmail.com>, David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org
References: <20231218033056.629260-1-eschwartz93@gmail.com>
 <20231227164610.7cbc38fe@hermes.local>
 <ac91d9f3-0651-4c66-9d38-c40281150ac5@gmail.com>
 <20231229113632.45c70893@hermes.local>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231229113632.45c70893@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/23 2:36 PM, Stephen Hemminger wrote:
> On Wed, 27 Dec 2023 22:57:10 -0500
> Eli Schwartz <eschwartz93@gmail.com> wrote:
> 
>> On 12/27/23 7:46 PM, Stephen Hemminger wrote:
>>> On Sun, 17 Dec 2023 22:30:52 -0500
>>> Eli Schwartz <eschwartz93@gmail.com> wrote:
>>>   
>>>> The use of backticks to surround commands instead of "$(cmd)" is a
>>>> legacy of the oldest pre-POSIX shells. It is confusing, unreliable, and
>>>> hard to read. Its use is not recommended in new programs.
>>>>
>>>> See: http://mywiki.wooledge.org/BashFAQ/082
>>>> ---  
>>>
>>> This is needless churn, it works now, and bash is never going
>>> to drop the syntax.  
>>
>>
>> Per the patch message, the reason to avoid the syntax is because it is
>> confusing, unreliable, and hard to read.
>>
>> It was deprecated for good reason, and those reasons are relevant to
>> people writing shell scripts! Regardless of whether it is removed, it
>> has several very sharp edges and the modern alternative was designed
>> specifically because the legacy syntax is bad to use *even in bash*.
>>
>> (bash has nothing to do with it. But also, again, this is not about bash
>> because the configure script shebang is *not* /bin/bash.)
> 
> The existing configuration was built incrementally over time.
> Mostly as a reaction to the issues with autoconf.
> 
> Perhaps it is time to consider updating iproute2 to a modern build
> environment like meson that has better config support.
> 


I do find $(...) much more readable than `...`; those little tick marks
can get lost on a screen with any dust for example.

