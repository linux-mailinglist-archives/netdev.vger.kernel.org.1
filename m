Return-Path: <netdev+bounces-246284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54861CE814B
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A294300E160
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF44136672;
	Mon, 29 Dec 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="JtJcSr7w"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018262AD03
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767037527; cv=none; b=pwKGsWknad8ADBLJkeLIwJjq+LKUs3m3xuYvdqV5xGfaP1Jfnw1xvOe1vBqtqPniDJA6kKBnzIEj2zHdGFvFrx3gseQLm+bpg86QaBX+0cUwmdheroMet4eGT9MKAKPtKy6Drxj/YjSpiqT4icijv9tvCS21hgwZ0rsrRMTcaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767037527; c=relaxed/simple;
	bh=ezNcr8pVPE1PaShtXb2giCvbL3shhTUeyQQS1kS2RMg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V1bfphE9cLhuYAbvKJ2p9g9odYHk7b872x5GRtxtyD8GXVjoDsR8rYYbZoJezQAWx7ZFuBfwBxPaie4p3W6x8IbvvLT3MbA9lyH49ZgTtQGWi9f//G0GQDpUAIxg43oTVp+EiCQ+vQ92jaxibeqnaM0p9TfogbdyC9pIbYk3/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=JtJcSr7w; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vaJBA-00DZ89-3b; Mon, 29 Dec 2025 20:45:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=/xZxzdkHzTL1qxsYkwcAznlT6NJL1YIIbVKy6ysI3HM=; b=JtJcSr7wgprzYiBsojYQb6/PZ/
	w4wpT8u+P4wDKXyvHeSMfLdlmCm68ETMcMAcUULXdLjVIPLZdJWZL2z+/ygxqolpndFLCLgypWtVV
	QjQmPTNiELJEUvasqaJ7HfMGTTM394pM1kDSGYsd4KsYqNajuGVX9RMbdLjyuONWg5lRq4Heu8G7W
	AV10Ls4OmCbTnLV42KsUjo9mOzWJVFY7hDg3jO10DU5FOXW8f/4GZOTRapg9CwnkZFL+cJtQZP9Wd
	/4svTk1zTslv8+N/PnDMSPIg/sjJ29ij2DJKE9rVDixJVIm4rNolMGDfmntTuxq40qG3pbuZnsYGD
	NkNf1f7g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vaJB9-0000Vy-Pb; Mon, 29 Dec 2025 20:45:19 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vaJB0-006B0A-1e; Mon, 29 Dec 2025 20:45:10 +0100
Message-ID: <1dad1adc-f287-4871-a86d-e77fe7f84b89@rbox.co>
Date: Mon, 29 Dec 2025 20:45:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net 1/2] vsock: Make accept()ed sockets use custom
 setsockopt()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-1-4654a75d0f58@rbox.co>
 <aUptJ2ECAPbLEZNp@sgarzare-redhat>
 <ff469a0f-091b-4260-8a54-e620024e0ec9@rbox.co>
 <aUqI_qW3SZ-WBXk3@sgarzare-redhat>
Content-Language: pl-PL, en-GB
In-Reply-To: <aUqI_qW3SZ-WBXk3@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 14:15, Stefano Garzarella wrote:
> On Tue, Dec 23, 2025 at 12:09:51PM +0100, Michal Luczaj wrote:
>> On 12/23/25 11:26, Stefano Garzarella wrote:
>>> On Tue, Dec 23, 2025 at 10:15:28AM +0100, Michal Luczaj wrote:
>> ...
>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>> index adcba1b7bf74..c093db8fec2d 100644
>>>> --- a/net/vmw_vsock/af_vsock.c
>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>> @@ -1787,6 +1787,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>>>> 		} else {
>>>> 			newsock->state = SS_CONNECTED;
>>>> 			sock_graft(connected, newsock);
>>>> +			set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
>>>
>>> I was a bit confused about next lines calling set_bit on
>>> `connected->sk_socket->flags`, but after `sock_graft(connected,
>>> newsock)` they are equivalent.
>>>
>>> So, maybe I would move the new line before the sock_graft() call or use
>>> `connected->sk_socket->flags` if you want to keep it after it.
>> ...
>>>> 			if (vsock_msgzerocopy_allow(vconnected->transport))
>>>> 				set_bit(SOCK_SUPPORT_ZC,
>>>> 					&connected->sk_socket->flags);
>>
>> Hmm, isn't using both `connected->sk_socket->flags` and `newsock->flags` a
>> bit confusing?
> 
> Yep, for that reason I suggested to use `connected->sk_socket->flags`.
> 
>> `connected->sk_socket->flags` feels unnecessary long to me.
>> So how about a not-so-minimal-patch to have
>>
>> 	newsock->state = SS_CONNECTED;
>> 	set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
>> 	if (vsock_msgzerocopy_allow(vconnected->transport))
>> 		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
>> 	sock_graft(connected, newsock);
> 
> No, please, this is a fix, so let's touch less as possible.
> 
> As I mentioned before, we have 2 options IMO:
> 1. use `set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);` but move it
>     before `sock_graft()`
> 2. use `connected->sk_socket->flags` and set it after `sock_graft()` if
>     we want to be a bit more consistent
> 
> I'd go with option 2, because I like to be consistent and it's less
> confusing IMHO, but I'm fine also with option 1.

Yeah, all right, here it is:
https://lore.kernel.org/netdev/20251229-vsock-child-sock-custom-sockopt-v2-0-64778d6c4f88@rbox.co/

Thanks,
Michal

