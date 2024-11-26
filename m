Return-Path: <netdev+bounces-147499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048199D9E0B
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D61928405B
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EA41D7E35;
	Tue, 26 Nov 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Dr+MAdxj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C9F1AAD7
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649438; cv=none; b=MGru31J9lHEJaKw20SWzM2WouXejfhLS1nuHbQ9qWFuaqvQvletvGxaCR1nAKHa3AWcnYAm+2CRCSyGFa8Q1CZesTYDd1mXA5ZrdBC9exMzGKgMgP82wE7j6SMXRD/zTsv7iXsEZ8Rd2CB1GUEWo/Fll38zBu90IA/5vjItTHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649438; c=relaxed/simple;
	bh=JxEi1NzfjLMLWVcyld2ufbmMA0wr6PtI07pJBc7cpLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EklC/goYYu8+dKUTEZj9xZD0S9Gi6Zzfm9mdb7QPiIMLIP62KD2VlPB1+tlHAU4KtE/VPQhjRGT93niwN0Dh6enodSSKo8nbLADL4ZdAM/uZaTc3txFIxRkoZk4CObfk5cOjaTRw8FItlqLujm2UJU8QsDKB/wxlvwm+D4ZCM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=Dr+MAdxj; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4XyXjL3lfsz9wnw;
	Tue, 26 Nov 2024 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1732649430; bh=JxEi1NzfjLMLWVcyld2ufbmMA0wr6PtI07pJBc7cpLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dr+MAdxj6BugDN65hlxBhP/Q7No+l+g223cS3NXWSKikYNgQO4qLYnNuYPzQQQRCS
	 n2OqqNOUldJjoNKBJwtzAbhOIIY5Ingfa96eR1aBCgA1d1sl1+/rQtrEAseT8yw9Xj
	 5NNMW5Ieq+HvFA+YZAn9YCmTGy0ymORZON1aG6C0=
X-Riseup-User-ID: 9289D9DC948FAB085E2DCFBA9194C4F85110AEA0518B8F026BE77FC0B2D0AD56
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4XyXjK2sp0zFtBV;
	Tue, 26 Nov 2024 19:30:29 +0000 (UTC)
Message-ID: <8506e3ba-c2fc-4981-9a51-041565a9337b@riseup.net>
Date: Tue, 26 Nov 2024 20:30:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] udp: call sock_def_readable() if socket is not
 SOCK_FASYNC
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, willemb@google.com
References: <20241126175402.1506-1-ffmancera@riseup.net>
 <CANn89iJ7NLR4vSqjSb9gpKxfZ2jPJS+jv_H1Qqs1Qz0DZZC=ug@mail.gmail.com>
 <CANn89i+651SOZDegASE2XQ7BViBdS=gdGPuNs=69SBS7SuKitg@mail.gmail.com>
 <85bce8fc-6034-43fb-9f4e-45d955568aaa@riseup.net>
 <CANn89iLF_0__Ewy9TXpCs7NP4FB-18iGfnn=cXgXu4qMbxyhwQ@mail.gmail.com>
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <CANn89iLF_0__Ewy9TXpCs7NP4FB-18iGfnn=cXgXu4qMbxyhwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/11/2024 20:26, Eric Dumazet wrote:
> On Tue, Nov 26, 2024 at 8:18 PM Fernando F. Mancera
> <ffmancera@riseup.net> wrote:
>>
>> Hi,
>>
>> On 26/11/2024 19:41, Eric Dumazet wrote:
>>> On Tue, Nov 26, 2024 at 7:32 PM Eric Dumazet <edumazet@google.com> wrote:
>>>>
>>>> On Tue, Nov 26, 2024 at 6:56 PM Fernando Fernandez Mancera
>>>> <ffmancera@riseup.net> wrote:
>>>>>
>>>>> If a socket is not SOCK_FASYNC, sock_def_readable() needs to be called
>>>>> even if receive queue was not empty. Otherwise, if several threads are
>>>>> listening on the same socket with blocking recvfrom() calls they might
>>>>> hang waiting for data to be received.
>>>>>
>>>>
>>>> SOCK_FASYNC seems completely orthogonal to the issue.
>>>>
>>>> First sock_def_readable() should wakeup all threads, I wonder what is happening.
>>>
>>
>> Well, it might be. But I noticed that if SOCK_FASYNC is set then
>> sk_wake_async_rcu() do its work and everything is fine. This is why I
>> thought checking on the flag was a good idea.
>>
> 
> How have you tested SOCK_FASYNC ?
> 
> SOCK_FASYNC is sending signals. If SIGIO is blocked, I am pretty sure
> the bug is back.
> 

Ah, I didn't know SIGIO was going to be blocked.

> 
>>> Oh well, __skb_wait_for_more_packets() is using
>>> prepare_to_wait_exclusive(), so in this case sock_def_readable() is
>>> waking only one thread.
>>>
>>
>> Yes, this is what I was expecting. What would be the solution? Should I
>> change it to "prepare_to_wait()" instead? Although, I don't know the
>> implication that change might have.
> 
> Sadly, we will have to revert, this exclusive wake is subtle.

If that is the case, let me send a revert patch. Thanks for the fast 
replies :)

