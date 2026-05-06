Return-Path: <netdev+bounces-284768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHJbCeYO+2mbVQMAu9opvQ
	(envelope-from <netdev+bounces-284768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:50:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD94F4D8EE5
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DFBA300E14A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848963E8695;
	Wed,  6 May 2026 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="GlFYOnOg"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [152.89.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD53EC2E0;
	Wed,  6 May 2026 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.89.196.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061025; cv=none; b=ISerWp9M8ukuK/gA11Bc9+WdOBowNP1wp8PuRbfFuVE925pe39ZoSmLH7KUK8VqG8tKfkxHCkWVcqfOyX3mNq6BJVuV2pXv6dNP1RbBf7MTXDH0uLonlmjbx4CkdlZprz595prRYiZN5o9LpDAhq9P4eulfkphrpsILTcphhJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061025; c=relaxed/simple;
	bh=d5gbTt/rFSi+YlAu2A09VdNyvTNIlHL4oX8ZwclG1tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GJQyp33D7BMC4DVzQbZOnFVU1tiklz1S6/n7LreLHNf/iYDAN2pWIZWCfvQJcbHuUUfL21ARDMhXhP/NgGKvMRhS1wVtvE37DbyGvvdcoTEj5GqRqYCW9Uqz7Hrfkg+J+ssQuyq4y4nHEvuHR7QqMQMzKokevmy7kinQ2hIDO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=GlFYOnOg; arc=none smtp.client-ip=152.89.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 505454000B;
	Wed,  6 May 2026 12:50:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 505454000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1778061013;
	bh=4dSd9JK+HYxiH/D05MkH3azRzSX4B6Cu/45ydrD2Lbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=GlFYOnOg3hSa0bYkDNl3hYzOv1wWPAiYT2d5Zc8sj5syDQTlq5XVvsDq6xfto7kcM
	 kzvYC0Ri7jEJgB8EU+Y4vuWrB5uFq6du7OHrgMEDUEtbBIy3hIgSHR3vtJ8TgvLvsj
	 iYVg6UnFrISGQPh/aInN/3qauT6ELqpVC98q8f85YLTf5TY4Rlb8v79Ik4zLliM6Tl
	 rotnYzhzpIdmeKD6LEeOOSc0Hto8OApXn4H8RFl2PkNl6ibw8HjXEtnWBGXYLM/zi4
	 3MtrqKqOfZbbb/2AFwfkPEs9bS8u1CPsk8VxISYOr4HVXJ6NsCu82EmD2KzQZefh6x
	 JamoxI6honxOA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  6 May 2026 12:50:12 +0300 (MSK)
Message-ID: <e1f32df5-b6a1-47a8-a783-fcc8e3c91f25@salutedevices.com>
Date: Wed, 6 May 2026 12:50:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Bobby Eshleman <bobbyeshleman@gmail.com>, Stefano Garzarella
	<sgarzare@redhat.com>
CC: Eric Dumazet <edumazet@google.com>, Bobby Eshleman
	<bobbyeshleman@meta.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux.dev>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <afocwkfBHJ5u10rx@devvm29614.prn0.facebook.com>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <afocwkfBHJ5u10rx@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-exch-cas-s-m1.sberdevices.ru (172.16.210.2) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected, bases: 2026/05/06 09:23:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 104 0.3.104 557b3c2486a74077a103cf2acd83f2ecf4c95118, {Tracking_uf_ne_domains}, {Tracking_arrow_http}, {Tracking_from_domain_doesnt_match_to}, docs.oasis-open.org:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202898 [May 06 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/05/06 07:22:00 #28502761
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/05/06 09:23:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Rspamd-Queue-Id: DD94F4D8EE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,quarantine];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284768-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,meta.com,redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,alibaba.com:email,oasis-open.org:url,salutedevices.com:dkim,salutedevices.com:mid]



05.05.2026 19:37, Bobby Eshleman wrote:
> On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
>> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>>> On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>
>>>> On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>>>>> virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>>>>>
>>>>> virtio_transport_recv_enqueue() skips coalescing for packets
>>>>> with VIRTIO_VSOCK_SEQ_EOM.
>>>>>
>>>>> If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>>>>> a very large number of packets can be queued
>>>>> because vvs->rx_bytes stays at 0.
>>>>>
>>>>> Fix this by estimating the skb metadata size:
>>>>>
>>>>>       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>>>>>
>>>>> Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>>>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>>>> Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>>> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>> Cc: "Eugenio Pérez" <eperezma@redhat.com>
>>>>> Cc: kvm@vger.kernel.org
>>>>> Cc: virtualization@lists.linux.dev
>>>>> ---
>>>>> net/vmw_vsock/virtio_transport_common.c | 4 +++-
>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>> index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>> @@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>>>> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>>>>>                                       u32 len)
>>>>> {
>>>>> -      if (vvs->buf_used + len > vvs->buf_alloc)
>>>>> +      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>>>>> +
>>>>> +      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>>>>>               return false;
>>>>
>>>> I'm not sure about this fix, I mean that maybe this is incomplete.
>>>> In virtio-vsock, there is a credit mechanism between the two peers:
>>>> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>>>>
>>>> This takes only the payload into account, so it’s true that this problem
>>>> exists; however, perhaps we should also inform the other peer of a lower
>>>> credit balance, otherwise the other peer will believe it has much more
>>>> credit than it actually does, send a large payload, and then the packet
>>>> will be discarded and the data lost (there are no retransmissions,
>>>> etc.).
>>>
>>> I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>>> state to account credit")
>>> and find a better fix then?
>>
>> IIRC the same issue was there before the commit fixed by that one (commit
>> 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
>> not sure about reverting it TBH.
>>
>> CCing Arseniy and Bobby.

Thanks!

>>
>>>
>>> There is always a discrepancy between skb->len and skb->truesize.
>>> You will not be able to announce a 1MB window, and accept one milliion
>>> skb of 1-byte each.
>>>
>>> This kind of contract is broken.
>>>
>>
>> Yep, I agree, but before we start discarding data (and losing it), IMHO we
>> should at least inform the other peer that we're out of space.
>>
>> @Stefan, @Michael, do you think we can do something in the spec to avoid
>> this issue and in some way take into account also the metadata in the
>> credit. I mean to avoid the 1-byte packets flooding.
>>
>> Thanks,
>> Stefano
>>
>>
> 
> Indeed the old pre-fix skb code would have the same issue.
> 
> I can't think of any way around this without extending the spec.

Hi, thanks, agree with Bobby, that accounting metadata (e.g. skb size here) was not implemented "by
design" in credit logic - another side of data exchange knows nothing about that. Also the same
situation was before skb implementation was added by Bobby. So looks like need to update spec may be.

Thanks!


> 
> Best,
> Bobby


