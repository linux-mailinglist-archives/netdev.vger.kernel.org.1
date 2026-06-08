Return-Path: <netdev+bounces-296408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tccbGbd7JmrRXAIAu9opvQ
	(envelope-from <netdev+bounces-296408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:22:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1AE653F7A
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:22:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rulkc.org header.s=dkim header.b=LWLdzALM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296408-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296408-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rulkc.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 056AF300CF2C
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B439BFE5;
	Mon,  8 Jun 2026 08:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C6399890;
	Mon,  8 Jun 2026 08:10:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906258; cv=none; b=pFLIdGC3/V7PGpfC4dl9Y3bDrjY84ulV6dxOVSO1rX+pI2DcwYFc16cuy0XkhzVH2wJgNOvQOeLZFguQjA6hOUEI8gKRzKGyZKzUVyUDbJVdpcHXAVZ3HQmsJn+Sv+ZErEUGHMm3yqdf53ohVputBGuQGBEk/on6lufzK+GG2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906258; c=relaxed/simple;
	bh=T+UXdam+yWyd/W4SdmgQkDS3bLFNYSV1t2bMdvafd+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqCZb7qmaZpUvZ5bFC4YkD8+7Wzq2PYPL4x03y0+loV9WmoY4ozDB8TLmFg5j4gNCJkTBPYNMJhn1x4b9VpnJFYhIsc/PTT5IMsMv7IN0zhkF3Cp1uWU9F0VgplULgTI1a1b+WZEBdnum3UePdHMGSqHE3CIgnqLUHmaIAv5KF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=LWLdzALM; arc=none smtp.client-ip=155.212.184.193
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B4CC1003A7;
	Mon,  8 Jun 2026 11:10:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1780906247; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rCERzOtepy/cS8kAXVGlEZomKIm0tyZTnmeEluP22/M=;
	b=LWLdzALM0luSB6Rlg2IHsrv9r/lvkL67IbQPvLIEZ/1ylcsqUVjbNLa+DBqXxrEvRWHPIn
	xERoPJixjF8VUqvsAUG2spwLVOKgRoWwnqCiKf7qUFTZiZc4K9XmYTol6z5Xukq27/lcni
	RkqPlbip2WSgPV2eT6NJtOeDnW1T2Kyzyq5RNeg6/DP2uOWoy+qvEDoYg90KtRxG79g0oF
	DuIAqXjMbDRnSpOHtH8eb/BrumcRok/3dOOs8CmKLfbakjMXAZmHkr9MCLIhLAj1IxdKyc
	vvtwFOALI4hIb9BF17zPKY00pFWH1aeMVF9jzatRd9wVCLXslGnMc/95QN4gFg==
Message-ID: <e5200406-d336-4ddf-9abd-78fccda24546@rulkc.org>
Date: Mon, 8 Jun 2026 11:10:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
To: David Laight <david.laight.linux@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
 <20260605160851.3ddbd2ed@pumpkin>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@rulkc.org>
In-Reply-To: <20260605160851.3ddbd2ed@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296408-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:bobby.eshleman@bytedance.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rulkc.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,bytedance.com,linux.alibaba.com,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A1AE653F7A


On 05/06/2026 18:08, David Laight wrote:
> On Fri,  5 Jun 2026 14:53:14 +0300
> Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
>
>> Logically it was based on TCP implementation, so to make further
>> support easier, rewrite it in the TCP way.
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 64 ++++++++++++-------------
>>  1 file changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 2fd9eaaf5ca6..00caeeaa5590 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -73,10 +73,13 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>>  				     struct virtio_vsock_pkt_info *info,
>>  				     size_t len,
>> -				     bool zcopy)
>> +				     bool zcopy, struct ubuf_info *uarg)
>>  {
>>  	struct msghdr *msg = info->msg;
>>  
>> +	/* We have completion - attach it to 'skb'. */
>> +	skb_zcopy_set(skb, uarg, NULL);
>> +
>>  	if (zcopy)
>>  		return __zerocopy_sg_from_iter(msg, NULL, skb,
>>  					       &msg->msg_iter, len, NULL);
>> @@ -208,7 +211,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>>  						  u32 src_cid,
>>  						  u32 src_port,
>>  						  u32 dst_cid,
>> -						  u32 dst_port)
>> +						  u32 dst_port,
>> +						  struct ubuf_info *uarg)
>>  {
>>  	struct vsock_sock *vsk;
>>  	struct sk_buff *skb;
>> @@ -245,7 +249,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>>  	if (info->msg && payload_len > 0) {
>>  		int err;
>>  
>> -		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
>> +		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy, uarg);
>>  		if (err)
>>  			goto out;
>>  
>> @@ -321,38 +325,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
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
>> +		if (info->msg->msg_ubuf) {
>> +			uarg = info->msg->msg_ubuf;
>> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
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
>>  
>> +			if (!can_zcopy)
>> +				uarg_to_msgzc(uarg)->zerocopy = 0;
>> +
>> +			have_uref = true;
>> +		}
>> +
>> +		/* 'can_zcopy' means that this transmission will be
>> +		 * in zerocopy way (e.g. using 'frags' array).
>> +		 */
> I've not looked at the tcp code, but the above doesn't look right.
> I don't see why msg->msg_ubuf might be non-NULL without SOCK_ZEROCOPY set.
> That would give the outer code a callback when the last skb is freed but
> still copy the data.

Hi, 

I guess case when 'msg->msg_ubuf' is non-NULL is special case today for io_uring MSG_ZEROCOPY implementation.
It was added here https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eb315a7d1396b1139fc7daea55f2d3191e8e7092
As I see implementation of its tests in tools/testing/selftests/net/io_uring_zerocopy_tx.c , it doesn't require setting SOCK_ZEROCOPY option for
socket, so for virtio vsock case I just copied same logic to maintain compatibility, because there is MSG_ZEROCOPY io_uring test for virtio/vsock.


>
> I also don't see the point of calling msg_zerocopy_realloc() to get a
> callback when the last skb is freed and then setting
> 	uarg_to_msgzc(uarg)->zerocopy = 0;
> so that the callback doesn't actually do anything.
> It isn't as though you 'find out' later on that you can't actually do
> zerocopy.


Sorry, what do You mean "last skb" ? In this code we first allocate uarg (allocate, because third arg is always NULL). Then in
loop we allocate sk_buffs, fill it with data and send. I mean first/last skb will be freed after uarg is already allocated and we
don't touch it. I think i didn't understand Your question here.


>
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
>> @@ -365,14 +367,12 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  
>>  		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
>>  						 src_cid, src_port,
>> -						 dst_cid, dst_port);
>> +						 dst_cid, dst_port, uarg);
>>  		if (!skb) {
>>  			ret = -ENOMEM;
>>  			break;
>>  		}
>>  
>> -		skb_zcopy_set(skb, uarg, NULL);
> Aren't you passing uarg through two function calls instead of doing it here.
> Doesn't even make it clearer what is going on.


Agree, to simplify patch, uarg could be set earlier (without passing it to functions) I guess.

Thanks


>
> -- David
>
>> -
>>  		virtio_transport_inc_tx_pkt(vvs, skb);
>>  
>>  		ret = t_ops->send_pkt(skb, info->net);
>> @@ -1178,7 +1178,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>>  					   le64_to_cpu(hdr->dst_cid),
>>  					   le32_to_cpu(hdr->dst_port),
>>  					   le64_to_cpu(hdr->src_cid),
>> -					   le32_to_cpu(hdr->src_port));
>> +					   le32_to_cpu(hdr->src_port), NULL);
>>  	if (!reply)
>>  		return -ENOMEM;
>>  

