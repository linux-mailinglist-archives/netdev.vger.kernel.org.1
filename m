Return-Path: <netdev+bounces-262989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGB8Kf9DpmlyNQAAu9opvQ
	(envelope-from <netdev+bounces-262989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:14:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E51461E7E8D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37B32305D1FC
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 02:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5D34E765;
	Tue,  3 Mar 2026 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u+o66kkY"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8F33D515
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772503944; cv=none; b=qThVFKA3+NOL0u+MbmO/gIfaT+ddQ/De0w+R9/5ZbBUUXXn2u3kICJz2fehrJEiOM+QtUa+fvflzt99ERbjtYM2gMX2PWJho1nKWjb8x+QR99yfwhVb9meLO/YfVG641xox0XNRzlnDbYTWWcVjAz3YEfkeM94aguVBAogakgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772503944; c=relaxed/simple;
	bh=FHUL99jkKiS7cQaGg74n2ztrYjf9Ch0zqo+Qxm0uyNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jabmtj/VWXT/qR/FBU74RKEo6fbs8hj6/ADPuv+O3jE6dbcIn1hAm5isPvC+30cXGYtTYEz7DGRb+/mlJZ82jAUvAOt+6NNAIWj+AVY05WsVasZwi5RutWrB4nV+ZffgE/L/FVn69Z3BTbS8UrzyZKOXFxFtglZv6FKcEfl4ivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u+o66kkY; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a623176-fc5f-4dd4-bbfc-64d211f53645@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772503940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITXnpAu02JzlvG8ACcNMa7Prj6k5bTC+ixlzn4YbRcI=;
	b=u+o66kkYvU/0WatYofey3kIxheT7EhEdcdrwhowxk7SPBm8AEWiQkPGbhM0tHR25/boTw/
	9kptLRzgw+xw3BFcJFoqyGW8vtJfhpDG5gBg+VCSYmnYCQiXAnkboVreb5BYYgQTNRRS/v
	FVTRKtvQouWDk5qN5Kg5tMzYfRbgJAQ=
Date: Tue, 3 Mar 2026 10:12:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next] tcp: Add net.ipv4.tcp_purge_receive_queue
 sysctl
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Hwang <leon.huangfu@shopee.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, kerneljasonxing@gmail.com,
 lance.yang@linux.dev, jiayuan.chen@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225074633.149590-1-leon.huangfu@shopee.com>
 <20260225174354.5a698ddb@kernel.org>
 <f611be70-8280-44c8-86af-5866c0b302be@linux.dev>
 <20260302162251.733b520e@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260302162251.733b520e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E51461E7E8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262989-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[shopee.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action



On 3/3/26 08:22, Jakub Kicinski wrote:
> On Mon, 2 Mar 2026 17:55:59 +0800 Leon Hwang wrote:
>> On 26/2/26 09:43, Jakub Kicinski wrote:
>>> On Wed, 25 Feb 2026 15:46:33 +0800 Leon Hwang wrote:  
>>>> Issue:
>>>> When a TCP socket in the CLOSE_WAIT state receives a RST packet, the
>>>> current implementation does not clear the socket's receive queue. This
>>>> causes SKBs in the queue to remain allocated until the socket is
>>>> explicitly closed by the application. As a consequence:
>>>>
>>>> 1. The page pool pages held by these SKBs are not released.  
>>>
>>> On what kernel version and driver are you observing this?  
>>
>> # uname -r
>> 6.19.0-061900-generic
>>
>> # ethtool -i eth0
>> driver: mlx5_core
>> version: 6.19.0-061900-generic
>> firmware-version: 26.43.2566 (MT_0000000531)
> 
> Okay... this kernel + driver should just patiently wait for the page
> pool to go away. 
> 
> What is the actual, end user problem that you're trying to solve?
> A few kB of data waiting to be freed is not a huge problem..

Yes, it is not a huge problem.

The actual end-user issue was discussed in
"page_pool: Add page_pool_release_stalled tracepoint" [1].

I think it would be useful to provide a way for SREs to purge the
receive queue when CLOSE_WAIT TCP sockets receive RST packets. If the
NIC, e.g., Mellanox, flaps, the underlying page pool and pages can be
released at the same time.

Links:
[1]
https://lore.kernel.org/netdev/b676baa0-2044-4a74-900d-f471620f2896@linux.dev/

Thanks,
Leon


