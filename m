Return-Path: <netdev+bounces-263053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKfTIUB/pmnhQQAAu9opvQ
	(envelope-from <netdev+bounces-263053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 07:27:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C071E99AF
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 07:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F24AE302A1A8
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 06:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12A383C90;
	Tue,  3 Mar 2026 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mlObZq1N"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5592E8DEB;
	Tue,  3 Mar 2026 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772519230; cv=none; b=VzoWSNMskuYqEAqpQ130VUtv2nrqNKGrBxJ/9llW+pN/NouPmPAc5np2Uf5vC9BDRH5P/7NhdP9MfteTKwsTjtWs++YmyZxRLi4QiDif/Z/93l/yiW7IHOPVYCJD5zFZ1VwOI61JRD5omszehEFQnZW6VrJFd9p7gDoqFX+rBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772519230; c=relaxed/simple;
	bh=fxKizMzMIayJYvrsnvg5v7c9n+Cb/G9sDjZiXulqffo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjjrPWTTbzidlZNKtCN8vCWsROK+r3uejHiMnOor/yZohQcGh0lT2ZCwjgqYkqf/jO7aN9TOP0XED9gGaR0IPB0enCFnRbfdrE0ckl5fOrB+tgoycFDCopXYc9iHa06mHRzRmdDZLXXhRPpFsP5jfEEEXBfgzZ0/GpBqtQ7iFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mlObZq1N; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7f3dabd-e6da-496d-927e-590a41dee009@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772519226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwL4R6Tjrx15lo/+8rlSFcr3K3tEG+s7YuJdiIPQfcQ=;
	b=mlObZq1NJMCT2YKc+UgG3MhwDSoJWI5YGFMX8WYVq9r9rX14M+5v3onDsRjK3DVNSOHLbh
	aKAWgG+6xv7vvh5YkdO02SzyfhVQo2qx2MMYbM5sUrcDPHprQpYhGrhWVpOY4e/1WGa92u
	fI8POhPiuEVxN4ygfBAegFI70AyW5LU=
Date: Tue, 3 Mar 2026 14:26:51 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CANn89iJ0=Tx0i+1UXEdcoFuk1F_MfP41-L-kgGDTN+RcLTRcFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 04C071E99AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263053-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action



On 3/3/26 11:55, Eric Dumazet wrote:
> On Tue, Mar 3, 2026 at 3:12 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 3/3/26 08:22, Jakub Kicinski wrote:
>>> On Mon, 2 Mar 2026 17:55:59 +0800 Leon Hwang wrote:
>>>> On 26/2/26 09:43, Jakub Kicinski wrote:
>>>>> On Wed, 25 Feb 2026 15:46:33 +0800 Leon Hwang wrote:
>>>>>> Issue:
>>>>>> When a TCP socket in the CLOSE_WAIT state receives a RST packet, the
>>>>>> current implementation does not clear the socket's receive queue. This
>>>>>> causes SKBs in the queue to remain allocated until the socket is
>>>>>> explicitly closed by the application. As a consequence:
>>>>>>
>>>>>> 1. The page pool pages held by these SKBs are not released.
>>>>>
>>>>> On what kernel version and driver are you observing this?
>>>>
>>>> # uname -r
>>>> 6.19.0-061900-generic
>>>>
>>>> # ethtool -i eth0
>>>> driver: mlx5_core
>>>> version: 6.19.0-061900-generic
>>>> firmware-version: 26.43.2566 (MT_0000000531)
>>>
>>> Okay... this kernel + driver should just patiently wait for the page
>>> pool to go away.
>>>
>>> What is the actual, end user problem that you're trying to solve?
>>> A few kB of data waiting to be freed is not a huge problem..
>>
>> Yes, it is not a huge problem.
>>
>> The actual end-user issue was discussed in
>> "page_pool: Add page_pool_release_stalled tracepoint" [1].
>>
>> I think it would be useful to provide a way for SREs to purge the
>> receive queue when CLOSE_WAIT TCP sockets receive RST packets. If the
>> NIC, e.g., Mellanox, flaps, the underlying page pool and pages can be
>> released at the same time.
>>
>> Links:
>> [1]
>> https://lore.kernel.org/netdev/b676baa0-2044-4a74-900d-f471620f2896@linux.dev/
> 
> Perhaps SRE could use this in an emergency?
> 
> ss -t -a state close-wait -K

This ss command is acceptable in an emergency.

A sysctl option would be better for persistent SRE operations.

Thanks,
Leon


