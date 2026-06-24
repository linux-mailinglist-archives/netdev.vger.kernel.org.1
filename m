Return-Path: <netdev+bounces-301563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id beddHNSJO2q+ZQgAu9opvQ
	(envelope-from <netdev+bounces-301563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:40:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3716BC3FD
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:40:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rulkc.org header.s=dkim header.b=Jgf9Y5iH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301563-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301563-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rulkc.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87784306175C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F73A2EEE9E;
	Wed, 24 Jun 2026 07:39:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD67242D6C;
	Wed, 24 Jun 2026 07:39:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286780; cv=none; b=qO+Vry5GmPGcWlA5Tbl/tpRQ7gq2W5TwGNHfe81LnpqFjhDprBDhfachJnMOend2vbeE9qd1llMHmQwQwCBw7j+q8vZN6Md0ZDIyUIL0WrDyQ5TSfODTlVYG1Ov0fMTwv8VIMQQ4ZQoID5+NCwgKKi9zZ7n5Sh3SwTO3/x/0OJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286780; c=relaxed/simple;
	bh=vnscFOV6WuRvFeIi3LRKjrBNK2qubRJ1xPKRYO5I5Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccb1zKkaSdlolSD3usze82NaNIBA/v6ZJ5NWM5ydawvzQ/I4LrWNDuraZI+chHRFuReuE/IXN8/FOOhNpyJPxFlUo0ZRYPREVGhckR8YJaXvgI33eDAIvOqxQ0vDEx+DT0VHJ5ZrZl8WNiSbFP/YwhRy5pVtV0DdKGSkzz2zyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=Jgf9Y5iH; arc=none smtp.client-ip=155.212.184.193
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B951E1006E6;
	Wed, 24 Jun 2026 10:39:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1782286773; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=u9d9ugozWzOhiPaIzDooLKLSYvxhBtS1e6crWQlC2t0=;
	b=Jgf9Y5iHKWrYx21aCp0Kimhb2Uomi1xS4rC4Xq3LcOoc0OLdsnCkiTM83AGI7IFT0SqdPv
	+teQBCjYWruehFEeciKnkPKEfydO3qB1B0ppeR3HGFEfifvGdq18W4SQSSzuJco8thoOut
	D6MY2D/IPHPd4itZhEDuwEmqzrpe/5/dpKS2tbVhTwnnKHk44gGQbO4aenlnaToNIeXXTM
	+pxW5+R5tQzyA5OFrWMS+dHQiYtVF8FXrkU6gdEgEkyMTcynx1xW2D9Twlgf6U737GiAyJ
	yRaqYMnss1iqjBzYw3HsNgyO0nnpR62z6HJWvmYeq/JyIq5p5D5y6H6/eWNUFg==
Message-ID: <d2bf1f1f-600d-48f6-8824-b08b4e10cc2a@rulkc.org>
Date: Wed, 24 Jun 2026 10:39:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org
References: <20260623153819.697635-1-avkrasnov@rulkc.org>
 <20260623132014-mutt-send-email-mst@kernel.org>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@rulkc.org>
In-Reply-To: <20260623132014-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jasowang@redhat.com,m:bobbyeshleman@meta.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301563-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,meta.com,linux.alibaba.com,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rulkc.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,rulkc.org:dkim,rulkc.org:email,rulkc.org:mid,rulkc.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC3716BC3FD


6/23/26 20:26, Michael S. Tsirkin wrote:
> On Tue, Jun 23, 2026 at 06:38:19PM +0300, Arseniy Krasnov wrote:
>> Logically it was based on TCP implementation, so to make further support
>> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). This
>> patch only rewrites flag handling (e.g. it doesn't change logic).
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>
> It seems to change logic though:
>
>> ---
>>  Changelog v1->v2:
>>  * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>>    already added.
>>  Changelog v2->v3:
>>  * Update commit message.
>>  * Remove one empty line.
>>
>>  net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
>>  1 file changed, 22 insertions(+), 25 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 09475007165b..41c2a0b82a8e 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>>  		return pkt_len;
>>  
>> -	if (info->msg) {
>> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
>> -		 * there is no MSG_ZEROCOPY flag set.
>> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
>> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
>> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
>> +		 * handling from 'tcp_sendmsg_locked()'.
>>  		 */
>> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>> -			info->msg->msg_flags &= ~MSG_ZEROCOPY;
> So previously without SOCK_ZEROCOPY, MSG_ZEROCOPY was always ignored...
>
>
>> +		if (info->msg->msg_ubuf) {
>> +			uarg = info->msg->msg_ubuf;
>> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> now it's not in this case?

Yes, this case is currently for io_uring only, because io_uring doesn't set SOCK_ZEROCOPY to perform zerocopy transmission.

>
>
> Maybe the right call, but saying "does not change logic" seems wrong.

Agree, I need to update commit message again :)

Thanks

>
>
>> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
>> +			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
>> +						    NULL, false);
>> +			if (!uarg) {
>> +				virtio_transport_put_credit(vvs, pkt_len);
>> +				return -ENOMEM;
>> +			}
>>  
>> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
>>  			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>> +			if (!can_zcopy)
>> +				uarg_to_msgzc(uarg)->zerocopy = 0;
>>  
>> +			have_uref = true;
>> +		}
>> +
>> +		/* 'can_zcopy' means that this transmission will be
>> +		 * in zerocopy way (e.g. using 'frags' array).
>> +		 */
>>  		if (can_zcopy)
>>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
>> -
>> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>> -		    info->op == VIRTIO_VSOCK_OP_RW) {
>> -			uarg = info->msg->msg_ubuf;
>> -
>> -			if (!uarg) {
>> -				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> -							    pkt_len, NULL, false);
>> -				if (!uarg) {
>> -					virtio_transport_put_credit(vvs, pkt_len);
>> -					return -ENOMEM;
>> -				}
>> -
>> -				if (!can_zcopy)
>> -					uarg_to_msgzc(uarg)->zerocopy = 0;
>> -
>> -				have_uref = true;
>> -			}
>> -		}
>>  	}
>>  
>>  	rest_len = pkt_len;
>> -- 
>> 2.25.1

