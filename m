Return-Path: <netdev+bounces-147572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF3A9DA476
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2268FB22735
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03149190499;
	Wed, 27 Nov 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="DhAf2XHc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF814AD02
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698350; cv=none; b=LAd55LQhCijNgMN4cTVLp1u48iOmKVq5TGw/TdAPbFGp1IRhfvaPq7xWwIWPJ2pqTGxnKDtFhS6ljZIMsiqOYtHQfRW9ZaqeBsIXKvaGfnei9gJfOCLOwzdkaMGKdbcMuLsyGCaoSBzMRMLw8qfFyxdFyk8W4e7A9Dgz6wRU2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698350; c=relaxed/simple;
	bh=RMMkJOlevZ7C/+qPBAbcyED4+var5GKQWU4UF9w4NmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkDEliFUG2Vi1L0Yto/W1E1CZCzRhi6xdHZIsM22jXskt+fqNCAeswoDUY0yDdBUgFMBsMd77FHIhKefijc89Ao+HiQxX+KiC6LRxKK81luD2wfKI3D8ajzMhhcm8DvSRbx6e4ufV6HnOCfogNrZ42Yf2/UG48aHPZ0cuFq0dFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=DhAf2XHc; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Xytp40tT9z9v2b;
	Wed, 27 Nov 2024 09:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1732698348; bh=RMMkJOlevZ7C/+qPBAbcyED4+var5GKQWU4UF9w4NmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DhAf2XHcwNQjdHXEfYuV2zEzk3Q4hBo8KK76jfKOh6OrQSvRX6O/jE8/9hHauwR/n
	 9bxRbMYe4O6me6+QdU3CgH7qda5TBiYRoxduwPW3ok0c9GyDRVOnToJYx4ZTey0Tya
	 5MjXuOg2DlztLSWkSThpZG9WuTqElTexIVuSEg4w=
X-Riseup-User-ID: AA2BAFC7783FC909B6B407F4C10E761B7F2970CDF5AEB82831D4B49F4E409FE3
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Xytnq52tFzJntS;
	Wed, 27 Nov 2024 09:05:35 +0000 (UTC)
Message-ID: <6a4bb567-8970-476d-a800-6f24ccbc397f@riseup.net>
Date: Wed, 27 Nov 2024 10:05:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] udp: call sock_def_readable() if socket is not
 SOCK_FASYNC
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, willemb@google.com
References: <20241126175402.1506-1-ffmancera@riseup.net>
 <CANn89iJ7NLR4vSqjSb9gpKxfZ2jPJS+jv_H1Qqs1Qz0DZZC=ug@mail.gmail.com>
 <CANn89i+651SOZDegASE2XQ7BViBdS=gdGPuNs=69SBS7SuKitg@mail.gmail.com>
 <411eb4ba-3226-44f2-aabe-5d68df01f867@redhat.com>
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <411eb4ba-3226-44f2-aabe-5d68df01f867@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 27/11/2024 08:46, Paolo Abeni wrote:
> Hi,
> 
> I'm sorry for the latency here.
> 
> On 11/26/24 19:41, Eric Dumazet wrote:
>> On Tue, Nov 26, 2024 at 7:32 PM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> On Tue, Nov 26, 2024 at 6:56 PM Fernando Fernandez Mancera
>>> <ffmancera@riseup.net> wrote:
>>>>
>>>> If a socket is not SOCK_FASYNC, sock_def_readable() needs to be called
>>>> even if receive queue was not empty. Otherwise, if several threads are
>>>> listening on the same socket with blocking recvfrom() calls they might
>>>> hang waiting for data to be received.
>>>>
>>>
>>> SOCK_FASYNC seems completely orthogonal to the issue.
>>>
>>> First sock_def_readable() should wakeup all threads, I wonder what is happening.
>>
>> Oh well, __skb_wait_for_more_packets() is using
>> prepare_to_wait_exclusive(), so in this case sock_def_readable() is
>> waking only one thread.
> 
> Very likely whatever I'll add here will be of little use, still...
> 
> AFAICS prepare_to_wait_exclusive() is there since pre git times, so its
> usage not be the cause of behaviors changes.
> 

I don't think the problem is on the usage of prepare_to_wait_exclusive() 
but on the fact that after 612b1c0dec5bc7367f90fc508448b8d0d7c05414 
sock_def_readable() is not being called everytime 
__udp_enqueue_schedule_skb() is called, instead it is called when the 
socket was empty before. On a single thread scenario this is completely 
fine but some issues were reported on scenarios involving multiple 
threads. Please see: https://bugzilla.redhat.com/2308477

>>> UDP can store incoming packets into sk->sk_receive_queue and
>>> udp_sk(sk)->reader_queue
>>>
>>> Paolo, should __skb_wait_for_more_packets() for UDP socket look at both queues ?
> 
> That in case multiple threads are woken-up and thread-1 splices
> sk_receive_queue into reader_queue before thread-2 has any chance of
> checking the first, I guess?
> 
> With prepare_to_wait_exclusive, checking a single queue should be ok.
> 

The scenario I have to reproduce this easily is the following:
1. Create 1 UDP socket
2. Create 5 threads and let them run into a blocking recvfrom()
3. Send 5 small UDP datagrams from main thread to the UDP socket
4. The 5 threads independently terminate after receiving 1 datagram.

This, doesn't work after 612b1c0dec5bc7367f90fc508448b8d0d7c05414 as the 
first time we call __udp_enqueue_schedule_skb() we call 
sock_def_readable() and it wakes up a single thread which receives the 
packet and terminates. The following times we call 
__udp_enqueue_schedule_skb() we are avoiding the sock_def_readable() 
call. This causes the other threads are not being woke up and they are 
blocked waiting on the recvfrom() forever.

Thank you, Fernando.

> /P
> 


