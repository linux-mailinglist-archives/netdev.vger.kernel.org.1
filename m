Return-Path: <netdev+bounces-147492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8909D9DEE
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF4BB21DB9
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3188C1DD9AD;
	Tue, 26 Nov 2024 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="O+YO0ron"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60D18858E
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648689; cv=none; b=olWdjs7Y0DdnC5xDFDuLH4zKXZVbguycZ232u+wJ36IMk8gbFE+iDNDAj9AU8gP6rE4SbhDQF2qaSM2FhqJ11yQSPcJRZN/OZh9mXQJ19gdNJ+NfFr++FK62UMfQRvk+kNglfrASLuNSNjyCnq2TmGQulnLnAiiZVsENLItQcZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648689; c=relaxed/simple;
	bh=WFoLq4dOdTq9BLMfwmAxU+Drm0aYVT7O3PvyFSVqfA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxvKBAy1vmC42GVc255zlAa+F1gk7+FmX/Gknaz1mUeAg9r571kMmnKsf2E9mpiltyjzGfrd9JVUaBvKdVmetv1maZvZ6CVMzfQJ77GFDsSfSXcPII2Dm8ybzOtZX0KGHpYO4zLAwREwOt7nT5nS47ugpYXYQak8BjA5SrnPS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=O+YO0ron; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XyXQx0YvJzDqXL;
	Tue, 26 Nov 2024 19:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1732648681; bh=WFoLq4dOdTq9BLMfwmAxU+Drm0aYVT7O3PvyFSVqfA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O+YO0ronYPRVJyKE1K6NEbknLOrnFb69T36yVJ/CdLUKn+ZIXkRnwe+PqQiUh28qg
	 rSzBL1rRkntydP8E1sT7Hc7NhpaXm/7RuXdTYeI4S2kb37w0C8nR/ho8N5AA3f33Mh
	 zSxFlF/GswaW4tKkpiDdOOId2n0kelGpsu8wVVQI=
X-Riseup-User-ID: 1745837A2BE95B5CEEC469201207054E8F0DB9F1AD8D494BA31067AD83E1F8DC
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XyXQw0Sp1zJrqq;
	Tue, 26 Nov 2024 19:17:59 +0000 (UTC)
Message-ID: <85bce8fc-6034-43fb-9f4e-45d955568aaa@riseup.net>
Date: Tue, 26 Nov 2024 20:17:48 +0100
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
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <CANn89i+651SOZDegASE2XQ7BViBdS=gdGPuNs=69SBS7SuKitg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 26/11/2024 19:41, Eric Dumazet wrote:
> On Tue, Nov 26, 2024 at 7:32 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Tue, Nov 26, 2024 at 6:56 PM Fernando Fernandez Mancera
>> <ffmancera@riseup.net> wrote:
>>>
>>> If a socket is not SOCK_FASYNC, sock_def_readable() needs to be called
>>> even if receive queue was not empty. Otherwise, if several threads are
>>> listening on the same socket with blocking recvfrom() calls they might
>>> hang waiting for data to be received.
>>>
>>
>> SOCK_FASYNC seems completely orthogonal to the issue.
>>
>> First sock_def_readable() should wakeup all threads, I wonder what is happening.
> 

Well, it might be. But I noticed that if SOCK_FASYNC is set then 
sk_wake_async_rcu() do its work and everything is fine. This is why I 
thought checking on the flag was a good idea.

> Oh well, __skb_wait_for_more_packets() is using
> prepare_to_wait_exclusive(), so in this case sock_def_readable() is
> waking only one thread.
> 

Yes, this is what I was expecting. What would be the solution? Should I 
change it to "prepare_to_wait()" instead? Although, I don't know the 
implication that change might have.

Thank you for the comments, first time working on UDP socket 
implementation so they are very helpful :)

>>
>> UDP can store incoming packets into sk->sk_receive_queue and
>> udp_sk(sk)->reader_queue
>>
>> Paolo, should __skb_wait_for_more_packets() for UDP socket look at both queues ?


