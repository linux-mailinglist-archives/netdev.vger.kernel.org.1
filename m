Return-Path: <netdev+bounces-263081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCniJr+ipmmvSAAAu9opvQ
	(envelope-from <netdev+bounces-263081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:58:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8111EB59D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 693A730DDBC3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703C389452;
	Tue,  3 Mar 2026 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rmvmFAsC"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827A388E6D
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528062; cv=none; b=nK96op82o91o3qTHm15DVkdbQpi6VZ1Yv8igDzKBfL3Ova0s65IRMZuxP7AuMoDvBynFlMLWqp8kfzIKaKYMQOoXFRXeBRSyNnbqDuwIJ1V2ZKI8ufj3FeN/HrWJqfHsZ2c22UG/iQsG4LKQsZIqYzHn3xH3MActSxoPlq/gdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528062; c=relaxed/simple;
	bh=2ma5rydRtiGQL0h/YyMYHa43c9soMTtaQHLQFl7LfGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+S4H/+szBE9lvFzDZDBqp6Pnw+w1JA6tCqLozvh1sPFpC4zXHuMO4AzKa8vagcf6zj4UfKNEUaFfkggJN/b7Alz4AAJ6qh8rhu7AyDwkh9NC700IUBHWkNdJXPnx4w00Hr63ntuB2u4lqsBoKLoVCJ61m7ULVauQN7qMgYl43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rmvmFAsC; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03144918-eaa8-461e-915d-232e29a52557@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772528058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HohjobRM5sM+ZHtuHp/cUtj95blgUcqZfqRBXVmSguY=;
	b=rmvmFAsCgdRDnSCqIRoWNa5xzavuxuVHBTICHh3+FuT8ELKXk6D7wp2HUcjFN6H04LJCc5
	MGnnZOhfeAgYteokTTbM4wA0mHVOkaOwJf8fKvlxv7rL5oRDOADYTSXdyAPXf08e4ekCNb
	PgqZEaeqBTPKGJmKfSUPerrrBO7ltmM=
Date: Tue, 3 Mar 2026 16:54:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next] tcp: Add net.ipv4.tcp_purge_receive_queue
 sysctl
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Hwang <leon.huangfu@shopee.com>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ij@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225074633.149590-1-leon.huangfu@shopee.com>
 <20260225174354.5a698ddb@kernel.org>
 <f611be70-8280-44c8-86af-5866c0b302be@linux.dev>
 <20260302162251.733b520e@kernel.org>
 <3a623176-fc5f-4dd4-bbfc-64d211f53645@linux.dev>
 <CANn89iJ0=Tx0i+1UXEdcoFuk1F_MfP41-L-kgGDTN+RcLTRcFA@mail.gmail.com>
 <d7f3dabd-e6da-496d-927e-590a41dee009@linux.dev>
 <c582ab1c-8a2d-4c0f-ad7b-7d44fe4296f6@linux.dev>
 <CANn89i+Bt_AZK=16nekvs846P7fPWxkRrNaNNBOrH0sB7xS1uQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CANn89i+Bt_AZK=16nekvs846P7fPWxkRrNaNNBOrH0sB7xS1uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3E8111EB59D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263081-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,shopee.com,vger.kernel.org,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,google.com,nvidia.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action



On 3/3/26 16:17, Eric Dumazet wrote:
> On Tue, Mar 3, 2026 at 8:55 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 3/3/26 14:26, Leon Hwang wrote:
>>>
>>>
>>> On 3/3/26 11:55, Eric Dumazet wrote:
>>>> On Tue, Mar 3, 2026 at 3:12 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 3/3/26 08:22, Jakub Kicinski wrote:
>>>>>> On Mon, 2 Mar 2026 17:55:59 +0800 Leon Hwang wrote:
>>>>>>> On 26/2/26 09:43, Jakub Kicinski wrote:
>>>>>>>> On Wed, 25 Feb 2026 15:46:33 +0800 Leon Hwang wrote:
>>>>>>>>> Issue:
>>>>>>>>> When a TCP socket in the CLOSE_WAIT state receives a RST packet, the
>>>>>>>>> current implementation does not clear the socket's receive queue. This
>>>>>>>>> causes SKBs in the queue to remain allocated until the socket is
>>>>>>>>> explicitly closed by the application. As a consequence:
>>>>>>>>>
>>>>>>>>> 1. The page pool pages held by these SKBs are not released.
>>>>>>>>
>>>>>>>> On what kernel version and driver are you observing this?
>>>>>>>
>>>>>>> # uname -r
>>>>>>> 6.19.0-061900-generic
>>>>>>>
>>>>>>> # ethtool -i eth0
>>>>>>> driver: mlx5_core
>>>>>>> version: 6.19.0-061900-generic
>>>>>>> firmware-version: 26.43.2566 (MT_0000000531)
>>>>>>
>>>>>> Okay... this kernel + driver should just patiently wait for the page
>>>>>> pool to go away.
>>>>>>
>>>>>> What is the actual, end user problem that you're trying to solve?
>>>>>> A few kB of data waiting to be freed is not a huge problem..
>>>>>
>>>>> Yes, it is not a huge problem.
>>>>>
>>>>> The actual end-user issue was discussed in
>>>>> "page_pool: Add page_pool_release_stalled tracepoint" [1].
>>>>>
>>>>> I think it would be useful to provide a way for SREs to purge the
>>>>> receive queue when CLOSE_WAIT TCP sockets receive RST packets. If the
>>>>> NIC, e.g., Mellanox, flaps, the underlying page pool and pages can be
>>>>> released at the same time.
>>>>>
>>>>> Links:
>>>>> [1]
>>>>> https://lore.kernel.org/netdev/b676baa0-2044-4a74-900d-f471620f2896@linux.dev/
>>>>
>>>> Perhaps SRE could use this in an emergency?
>>>>
>>>> ss -t -a state close-wait -K
>>>
>>> This ss command is acceptable in an emergency.
>>>
>>
>> However, once a CLOSE_WAIT TCP socket receives an RST packet, it
>> transitions to the CLOSE state. A socket in the CLOSE state cannot be
>> killed using the ss approach.
>>
>> The SKBs remain in the receive queue of the CLOSE socket until it is
>> closed by the user-space application.
> 
> Why user-space application does not drain the receive queue ?
> 
> Is there a missing EPOLLIN or something ?

The user-space application uses a TCP connection pool. It establishes
several TCP connections at startup and keeps them in the pool.

However, the application does not always drain their receive queues.
Instead, it selects one connection from the pool using a hash algorithm
for communication with the TCP server. When it attempts to write data
through a socket in the CLOSE state, it receives -EPIPE and then closes
it. As a result, TCP connections whose underlying socket state is CLOSE
may retain an SKB in their receive queues if they are not selected for
communication.

I proposed a solution to address this issue: close the TCP connection if
the underlying sk_err is non-zero.

Thanks,
Leon


