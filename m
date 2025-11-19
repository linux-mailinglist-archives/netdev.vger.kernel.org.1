Return-Path: <netdev+bounces-240012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F051C6F26F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DA20229511
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9295421B195;
	Wed, 19 Nov 2025 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="oYA2RMry"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47B31ED96;
	Wed, 19 Nov 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561390; cv=none; b=CyU/qfbv2hMl6dTsrI+JvlEXY3G+WefpkOTNmfmE7F0E2XaTorNJsdAkD27ID5Qum6ZZaEFPssKRjMJSWvvSMhP+rLsE9IM4u24B0rqvifqU2AntWSPSDX5Pqr5XB0BNR6GkY+DynZu+Sc7FMzUtv3nfqvJNm73teHAbVXqNSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561390; c=relaxed/simple;
	bh=JRZOtH3n73C7KjpFe3uoi9EJEfKK69QvStpnFTVU+Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NptXefg10cTHJ8R0GUUqujtKMShQQz3RqqL30Cwm981sflZuPqYaOLtbxTQsZ97Ta5tBE8FklxZuisgcOOVqBfKHpn0wTXbO6JNW0qrrLFDsZM5gkTcPuFE+s66EQqYoh23B8Xkiaprg5wJgw5o86kW5YLtK9di37qi8KQ35WPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=oYA2RMry; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vLisR-005nht-Ia; Wed, 19 Nov 2025 15:09:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=53wAJwNOjqb4ntnBnczBa2f4AuXPtxn18LUg6Hu+6g4=; b=oYA2RMryWQgAB6DV8HS49llBEx
	4x+Wo1M5zM1u2NNfb14q3uQuTd6//4JzY2aSRyhdvztY16DzzfyUts8RDhrnx+6xahdBHXBo9nJv1
	KVmFmY82T0RA0VfsB4D0o3R/5S8O3E1ptAsUs8e12FPLQrMltyJXI4vzZPVc6Zpsq6uGRUaUEJiqK
	28AoY7VVxNIeuhkMx2Cfc4WuaoplQylM/zgXqVTuQu2A7zaKJl5RL8cB5TPFSk1oQik3rWazhqF56
	WBc2c+p6jZ85KKeBR6BqMr2eeqHbY5AfhXYHD30qV7xNHTUu/4VbJvJmgkMh7sYazSkS+zzpe0Oam
	2QuI97VA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vLisQ-00017s-HP; Wed, 19 Nov 2025 15:09:42 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLisA-00Epah-Fr; Wed, 19 Nov 2025 15:09:26 +0100
Message-ID: <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
Date: Wed, 19 Nov 2025 15:09:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
 <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 11:36, Stefano Garzarella wrote:
> On Tue, Nov 18, 2025 at 11:02:17PM +0100, Michal Luczaj wrote:
>> On 11/18/25 10:51, Stefano Garzarella wrote:
>>> On Mon, Nov 17, 2025 at 09:57:25PM +0100, Michal Luczaj wrote:
>>>> ...
>>>> +static void vsock_reset_interrupted(struct sock *sk)
>>>> +{
>>>> +	struct vsock_sock *vsk = vsock_sk(sk);
>>>> +
>>>> +	/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>>>> +	 * transport->connect().
>>>> +	 */
>>>> +	vsock_transport_cancel_pkt(vsk);
>>>> +
>>>> +	/* Listener might have already responded with VIRTIO_VSOCK_OP_RESPONSE.
>>>> +	 * Its handling expects our sk_state == TCP_SYN_SENT, which hereby we
>>>> +	 * break. In such case VIRTIO_VSOCK_OP_RST will follow.
>>>> +	 */
>>>> +	sk->sk_state = TCP_CLOSE;
>>>> +	sk->sk_socket->state = SS_UNCONNECTED;
>>>> +}
>>>> +
>>>> static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>>> 			 int addr_len, int flags)
>>>> {
>>>> @@ -1661,18 +1678,33 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>>> 		timeout = schedule_timeout(timeout);
>>>> 		lock_sock(sk);
>>>>
>>>> +		/* Connection established. Whatever happens to socket once we
>>>> +		 * release it, that's not connect()'s concern. No need to go
>>>> +		 * into signal and timeout handling. Call it a day.
>>>> +		 *
>>>> +		 * Note that allowing to "reset" an already established socket
>>>> +		 * here is racy and insecure.
>>>> +		 */
>>>> +		if (sk->sk_state == TCP_ESTABLISHED)
>>>> +			break;
>>>> +
>>>> +		/* If connection was _not_ established and a signal/timeout came
>>>> +		 * to be, we want the socket's state reset. User space may want
>>>> +		 * to retry.
>>>> +		 *
>>>> +		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>>>> +		 * vsock_connected_table. We keep the binding and the transport
>>>> +		 * assigned.
>>>> +		 */
>>>> 		if (signal_pending(current)) {
>>>> 			err = sock_intr_errno(timeout);
>>>> -			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>>>> -			sock->state = SS_UNCONNECTED;
>>>> -			vsock_transport_cancel_pkt(vsk);
>>>> -			vsock_remove_connected(vsk);
>>>> +			vsock_reset_interrupted(sk);
>>>> 			goto out_wait;
>>>> -		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>>>> +		}
>>>> +
>>>> +		if (timeout == 0) {
>>>> 			err = -ETIMEDOUT;
>>>> -			sk->sk_state = TCP_CLOSE;
>>>> -			sock->state = SS_UNCONNECTED;
>>>> -			vsock_transport_cancel_pkt(vsk);
>>>> +			vsock_reset_interrupted(sk);
>>>> 			goto out_wait;
>>>
>>> I'm fine with the change, but now both code blocks are the same, so
>>> can we unify them?
>>> I mean something like this:
>>> 		if (signal_pending(current) || timeout == 0 {
>>> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>>> 			...
>>> 		}
>>>
>>> Maybe at that point we can also remove the vsock_reset_interrupted()
>>> function and put the code right there.
>>>
>>> BTW I don't have a strong opinion, what do you prefer?
>>
>> Sure, no problem.
>>
>> But I've realized invoking `sock_intr_errno(timeout)` is unnecessary.
>> `timeout` can't be MAX_SCHEDULE_TIMEOUT, so the call always evaluates to
>> -EINTR, right?
> 
> IIUC currently schedule_timeout() can return MAX_SCHEDULE_TIMEOUT only 
> if it was called with that parameter, and I think we never call it in 
> that way, so I'd agree with you.
> 
> My only concern is if it's true for all the stable branches we will 
> backport this patch.
> 
> I would probably touch it as little as possible and continue using 
> sock_intr_errno() for now, but if you verify that it has always been 
> that way, then it's fine to change it.

All right then, here's a v2 with minimum changes:
https://lore.kernel.org/netdev/20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co/

Note a detail though: should signal and timeout happen at the same time,
now it's the timeout errno returned.


