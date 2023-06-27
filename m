Return-Path: <netdev+bounces-14177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030BE73F5FE
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 09:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B3D280FD0
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 07:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4743BA23;
	Tue, 27 Jun 2023 07:48:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4172846A
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:48:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C9310FB
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687852094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whaOhWVIaKHzUbZWclTPzFtnTVD/3jITld51dEdWQ0A=;
	b=BAQLESFKI/ZF+hLWY+XZnNuSmJUDb94G/tNxeErXp/i/BfKCVKpPA2rHkqmTPsy+2ZNWBh
	D2FsGzSHofTqRKrzehVlbOGAE+llpFfS1eS+2Buegiix1DRASdcoCn+ci6r7DXrWpmNcCN
	+KpNOyxMiJ9N1GvMXLP0Sd5/bS2UmG4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-TqocsM8gMO6_64a-G6_Qeg-1; Tue, 27 Jun 2023 03:48:11 -0400
X-MC-Unique: TqocsM8gMO6_64a-G6_Qeg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-988e344bed9so380281066b.0
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 00:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852090; x=1690444090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whaOhWVIaKHzUbZWclTPzFtnTVD/3jITld51dEdWQ0A=;
        b=cQ0J7RV/cJM5W+d4ksvdy1ZJtoGnw2StPJZHHfALfr9T0FBJM3O0WEUlB2uiEpv67S
         3BsbcXXiruPirEJb4mY0BfsHi8+7UOZ5/Sns7v4PTwRRpIfoCRWdqYb2x+xddnMP3J5B
         KQKdOf/QVJsZdDI37Yyh6tRDY4LxHPv+yx8YGiue+yvl8dnxZYirl52y2rN1T6vXhOlR
         bpDwERlKMrghEhRTN4NyIo5359GtvWDNGm0QuCxUr21N5PxWNjsv2W7DSammDgWrvmu+
         vL/IG47ekm8tfr+bQ9hOt66+iWI6hnu6kJV4qySSMeVUaxtJHxaJgyvazbqjLaggTrSi
         cSHg==
X-Gm-Message-State: AC+VfDyD1ngf1Qqm9d9AAoNpI716dORBN0lPNpnU6ZfCAcR+GPKjx1ow
	/c4/xMw/BjPFSoLy727vlXTXjDs5UKwQgfNKmblZhAl1ULAcptdaYKKfB6Ar9Kxyj2ordJkxvuz
	BmIR6ih9oQZIT+TYc
X-Received: by 2002:a17:906:da84:b0:988:f307:aea7 with SMTP id xh4-20020a170906da8400b00988f307aea7mr21595739ejb.7.1687852090428;
        Tue, 27 Jun 2023 00:48:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ob/ReyhK7BIZNcKDNmnYWuzv3zeM/wIdMcpgjlvuvypLCy8x/HUywv68r17c73ooOglaGQw==
X-Received: by 2002:a17:906:da84:b0:988:f307:aea7 with SMTP id xh4-20020a170906da8400b00988f307aea7mr21595713ejb.7.1687852090093;
        Tue, 27 Jun 2023 00:48:10 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906355000b00991ba677d92sm2190941eja.84.2023.06.27.00.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:48:09 -0700 (PDT)
Date: Tue, 27 Jun 2023 09:48:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 2/4] virtio/vsock: support MSG_PEEK for
 SOCK_SEQPACKET
Message-ID: <4pcexfrdtuisz53c4sb4pse4cyjw7zsuwtqsnnul23njo4ab5l@4jvdk6buxmj3>
References: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
 <20230618062451.79980-3-AVKrasnov@sberdevices.ru>
 <yiy3kssoiyzs6ehnlo7g2xsb26zee5vih3jpgyc7i3dvfcyfpv@xvokxez3lzpo>
 <9553a82f-ce31-e2e0-ff62-8abd2a6b639b@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9553a82f-ce31-e2e0-ff62-8abd2a6b639b@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 07:34:29AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:28, Stefano Garzarella wrote:
>> On Sun, Jun 18, 2023 at 09:24:49AM +0300, Arseniy Krasnov wrote:
>>> This adds support of MSG_PEEK flag for SOCK_SEQPACKET type of socket.
>>> Difference with SOCK_STREAM is that this callback returns either length
>>> of the message or error.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/virtio_transport_common.c | 63 +++++++++++++++++++++++--
>>> 1 file changed, 60 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>> index 2ee40574c339..352d042b130b 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -460,6 +460,63 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>     return err;
>>> }
>>>
>>> +static ssize_t
>>> +virtio_transport_seqpacket_do_peek(struct vsock_sock *vsk,
>>> +                   struct msghdr *msg)
>>> +{
>>> +    struct virtio_vsock_sock *vvs = vsk->trans;
>>> +    struct sk_buff *skb;
>>> +    size_t total, len;
>>> +
>>> +    spin_lock_bh(&vvs->rx_lock);
>>> +
>>> +    if (!vvs->msg_count) {
>>> +        spin_unlock_bh(&vvs->rx_lock);
>>> +        return 0;
>>> +    }
>>> +
>>> +    total = 0;
>>> +    len = msg_data_left(msg);
>>> +
>>> +    skb_queue_walk(&vvs->rx_queue, skb) {
>>> +        struct virtio_vsock_hdr *hdr;
>>> +
>>> +        if (total < len) {
>>> +            size_t bytes;
>>> +            int err;
>>> +
>>> +            bytes = len - total;
>>> +            if (bytes > skb->len)
>>> +                bytes = skb->len;
>>> +
>>> +            spin_unlock_bh(&vvs->rx_lock);
>>> +
>>> +            /* sk_lock is held by caller so no one else can dequeue.
>>> +             * Unlock rx_lock since memcpy_to_msg() may sleep.
>>> +             */
>>> +            err = memcpy_to_msg(msg, skb->data, bytes);
>>> +            if (err)
>>> +                return err;
>>> +
>>> +            spin_lock_bh(&vvs->rx_lock);
>>> +        }
>>> +
>>> +        total += skb->len;
>>> +        hdr = virtio_vsock_hdr(skb);
>>> +
>>> +        if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
>>> +            if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR)
>>> +                msg->msg_flags |= MSG_EOR;
>>> +
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    spin_unlock_bh(&vvs->rx_lock);
>>> +
>>> +    return total;
>>
>> Should we return the minimum between total and len?
>
>I guess no, because seqpacket dequeue callback always returns length of message,
>then, in af_vsock.c we return either number of bytes read or length of message
>depending on MSG_TRUNC flags.

Right! We should always return the total lenght of the packet.

Thanks,
Stefano

>
>Thanks, Arseniy
>
>>
>> Thanks,
>> Stefano
>>
>>> +}
>>> +
>>> static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>>>                          struct msghdr *msg,
>>>                          int flags)
>>> @@ -554,9 +611,9 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>>>                    int flags)
>>> {
>>>     if (flags & MSG_PEEK)
>>> -        return -EOPNOTSUPP;
>>> -
>>> -    return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags);
>>> +        return virtio_transport_seqpacket_do_peek(vsk, msg);
>>> +    else
>>> +        return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags);
>>> }
>>> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>>>
>>> -- 
>>> 2.25.1
>>>
>>
>


