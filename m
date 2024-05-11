Return-Path: <netdev+bounces-95687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9B8C3067
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3D21F2146C
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73622D600;
	Sat, 11 May 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novek.ru header.i=@novek.ru header.b="FM0KsUVC"
X-Original-To: netdev@vger.kernel.org
Received: from novek.ru (unknown [213.148.174.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7AC14F
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.148.174.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715421050; cv=none; b=Go02XMzWnYe6niU/ZhEeqqfB889hx1No0t5c5O5dntDkFPpa2zQQy9E2PV/yYSJ6nWx722ENycfI3/UVLSrf08j5CCBVRQ2z1YY3JIQP03fI/hPeql+NbKFM/kmWBErLMi5UclxpXfMY6D2jR8NULvrNvrNy6RXEn+Jof3eul7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715421050; c=relaxed/simple;
	bh=m5lTYJyAbkXz4nQ7pNY3YCO4M3SGO5MQzzObDvvBo04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeIFrbbSNNknNQUZOGZGj9sIN/ZK0YdXwfDj9ULOQG12tVRWlys7nBEBIWm4OO3m6RrvUdUDspwF0cllPi3zsZ7tVnl7xQOrC48FgXcXO5TWwzOlIgCL7GATkA94gZOaRuhm1Np0yY7C4PnHU9qTUvP3v1A9nx2Pw9mdoAvnPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=novek.ru; spf=pass smtp.mailfrom=novek.ru; dkim=pass (1024-bit key) header.d=novek.ru header.i=@novek.ru header.b=FM0KsUVC; arc=none smtp.client-ip=213.148.174.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=novek.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novek.ru
Received: from [10.223.134.160] (unknown [82.141.252.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by novek.ru (Postfix) with ESMTPSA id 7853B5027B5;
	Sat, 11 May 2024 12:42:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 novek.ru 7853B5027B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novek.ru; s=mail;
	t=1715420558; bh=m5lTYJyAbkXz4nQ7pNY3YCO4M3SGO5MQzzObDvvBo04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FM0KsUVC2D3YxMHf05by4hCeyES8V8Uudcr5Y7TQ/5lgdgO90eYizECD2ubZDjhpH
	 8YcWO6UREoAXWmfW+ZNDMe7hV4fFP1wCEWQXk0++b4rRVVqkY7lz9H0nunNxOAW0RO
	 yGfoPIXq8sVTsOhkaiPV6neafoiiaZ1Kh91iP9Lg=
Message-ID: <225228d7-5c4c-4e8c-99d3-77aed6432887@novek.ru>
Date: Sat, 11 May 2024 10:41:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 01/15] psp: add documentation
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, borisp@nvidia.com, gal@nvidia.com,
 cratiu@nvidia.com, rrameshbabu@nvidia.com, steffen.klassert@secunet.com,
 tariqt@nvidia.com, mingtao@meta.com, knekritz@meta.com
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-2-kuba@kernel.org> <Zj6da1nANulG5cb5@x130.lan>
 <20240510171132.557ba47e@kernel.org>
From: Vadim Fedorenko <vfedorenko@novek.ru>
In-Reply-To: <20240510171132.557ba47e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: **

On 11.05.2024 01:11, Jakub Kicinski wrote:
> On Fri, 10 May 2024 15:19:23 -0700 Saeed Mahameed wrote:
>>> +PSP is designed primarily for hardware offloads. There is currently
>>> +no software fallback for systems which do not have PSP capable NICs.
>>> +There is also no standard (or otherwise defined) way of establishing
>>> +a PSP-secured connection or exchanging the symmetric keys.
>>> +
>>> +The expectation is that higher layer protocols will take care of
>>> +protocol and key negotiation. For example one may use TLS key exchange,
>>> +announce the PSP capability, and switch to PSP if both endpoints
>>> +are PSP-capable.
>>
>> The documentation doesn't include anything about userspace, other than
>> highlevel remarks on how this is expected to work.
> 
> The cover letter does.
> 
>> What are we planning for userspace? I know we have kperf basic support and
>> some experimental python library, but nothing official or psp centric.
> 
> Remind me, how long did it take for kernel TLS support to be merged
> into OpenSSL? ;)

I believe it was bad timing for OpenSSL. The patches with kTLS support were
sitting in the main branch for long time, the problem was postponed release with
with jump to new versioning schema.

But I agree, there is no easy way to start coding user-space lib without initial
support from kernel.

>> I propose to start community driven project with a well established
>> library, with some concrete sample implementation for key negotiation,
>> as a plugin maybe, so anyone can implement their own key-exchange
>> mechanisms on top of the official psp library.
> 
> Yes, I should have CCed Meta's folks who work on TLS [1]. Adding them
> now. More than happy to facilitate the discussion, maybe Willem can
> CC the right Google folks, IDK who else...
> 
> We should start moving with the kernel support, IMO, until we do
> the user space implementation is stalled. I don't expect that the
> way we install keys in the kernel would be impacted by the handshake.
> 
> [1] https://github.com/facebookincubator/fizz


