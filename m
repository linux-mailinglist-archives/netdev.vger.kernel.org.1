Return-Path: <netdev+bounces-31889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6F979133A
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268EE1C204F7
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 08:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE55310F5;
	Mon,  4 Sep 2023 08:22:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07751371
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 08:22:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD2D8
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693815720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58CDt7MpBY+8uswKMe/+/g7ssjQGWAe8uPZZeAFNnOg=;
	b=SsfIrUOnlrLnRFjr8ajIJWc2EBBIl8yKu6pA1Qaxbt8V6MSiMbqZkKxOk7QZr9ygNm0DEP
	437yitdRjI6N+n4+OFJR9FwHZLZrHkjlZv3OTO9MfJhi5VtjrGShYNAp2VGb03eBcRV9PD
	n+XHItEd7sftkiiTtMsFc5YBDaA2IWw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-5qPJFJhjOlGYYo1lGv4zgQ-1; Mon, 04 Sep 2023 04:21:59 -0400
X-MC-Unique: 5qPJFJhjOlGYYo1lGv4zgQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31aecb86dacso587854f8f.1
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 01:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693815718; x=1694420518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58CDt7MpBY+8uswKMe/+/g7ssjQGWAe8uPZZeAFNnOg=;
        b=SE0vePST+1cBq4sldzksKxwiRk4STFwuJWYxbfeV+JMKArL26D2d053f2wj1OObybi
         SoSEsUF+gnKvzb035NawqLaxiuF0H+osXCXfz7n+YKSQU6UfEZDcRAx0LNBRqkFfbznP
         PfEvnBQL1oE/Y/g3aTQdisOYZT5hL0gbMGR8gBPUlvKFDmyDrHq++uOIdmm8CF4Qy31Y
         kJhhQ8MPcGcLMvnYX/5cWBDonLtoE+scvOIyn6dV7pVmSXBhiev8wyDVyc8sbQ5tF1Ph
         kS3UZnFqWa1TdMAf7h0GVrGBMuUHnHz7281z4nynoJlFnZ/N+m0H2WhGvPiSTMOI6NBS
         0LiQ==
X-Gm-Message-State: AOJu0Yw4zsvXUqua8XbvNctsn2AVZ2ub+WYdTdkqO54ujFwhjUQ6Rhyc
	5sUfIR2ISKeRUJk+lkUPN6zAmwTF1F5U1362DqdlvbOkagh37Dz09IkTGhK0UzHdPNGMNoVFwAj
	YBhP/FaeFTwHvtE10
X-Received: by 2002:adf:f0ca:0:b0:31c:804b:5ec3 with SMTP id x10-20020adff0ca000000b0031c804b5ec3mr6824549wro.67.1693815717775;
        Mon, 04 Sep 2023 01:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtvlQmvpxtAtQ0RXZWHxi9cuCDi1ONniVj1m3Lt/gu3c78Hd/LstB4eBmnfMtLXc/X7qNKFg==
X-Received: by 2002:adf:f0ca:0:b0:31c:804b:5ec3 with SMTP id x10-20020adff0ca000000b0031c804b5ec3mr6824530wro.67.1693815717437;
        Mon, 04 Sep 2023 01:21:57 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.123.165])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0031ad5a54bedsm13851459wrp.9.2023.09.04.01.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 01:21:56 -0700 (PDT)
Date: Mon, 4 Sep 2023 10:21:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v7 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <h63t6heovmyafu2lo6x6rzsbdbrhqhlbuol774ngbgshbycgdu@fgynzbmj5zn7>
References: <20230827085436.941183-1-avkrasnov@salutedevices.com>
 <20230827085436.941183-5-avkrasnov@salutedevices.com>
 <p2u2irlju6yuy54w4tqstaijhpnbmqxwavsdumsmyskrjguwux@kmd7cbavhjbh>
 <0ab443b5-73a5-f092-44a3-52e26244c9a8@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ab443b5-73a5-f092-44a3-52e26244c9a8@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 03, 2023 at 11:13:23AM +0300, Arseniy Krasnov wrote:
>
>
>On 01.09.2023 15:30, Stefano Garzarella wrote:
>> On Sun, Aug 27, 2023 at 11:54:36AM +0300, Arseniy Krasnov wrote:
>>> This adds handling of MSG_ZEROCOPY flag on transmission path: if this
>>> flag is set and zerocopy transmission is possible (enabled in socket
>>> options and transport allows zerocopy), then non-linear skb will be
>>> created and filled with the pages of user's buffer. Pages of user's
>>> buffer are locked in memory by 'get_user_pages()'. Second thing that
>>> this patch does is replace type of skb owning: instead of calling
>>> 'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason of this
>>> change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc'
>>> of socket, so to decrease this field correctly proper skb destructor is
>>> needed: 'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

[...]

>>>
>>> -/* Returns a new packet on success, otherwise returns NULL.
>>> - *
>>> - * If NULL is returned, errp is set to a negative errno.
>>> - */
>>> -static struct sk_buff *
>>> -virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
>>> -               size_t len,
>>> -               u32 src_cid,
>>> -               u32 src_port,
>>> -               u32 dst_cid,
>>> -               u32 dst_port)
>>> -{
>>> -    const size_t skb_len = VIRTIO_VSOCK_SKB_HEADROOM + len;
>>> -    struct virtio_vsock_hdr *hdr;
>>> -    struct sk_buff *skb;
>>> +static bool virtio_transport_can_zcopy(struct virtio_vsock_pkt_info *info,
>>> +                       size_t max_to_send)
>>                                               ^
>> I'd call it `pkt_len`, `max_to_send` is confusing IMHO. I didn't
>> initially if it was the number of buffers or bytes.
>>
>>> +{
>>> +    const struct virtio_transport *t_ops;
>>> +    struct iov_iter *iov_iter;
>>> +
>>> +    if (!info->msg)
>>> +        return false;
>>> +
>>> +    iov_iter = &info->msg->msg_iter;
>>> +
>>> +    if (iov_iter->iov_offset)
>>> +        return false;
>>> +
>>> +    /* We can't send whole iov. */
>>> +    if (iov_iter->count > max_to_send)
>>> +        return false;
>>> +
>>> +    /* Check that transport can send data in zerocopy mode. */
>>> +    t_ops = virtio_transport_get_ops(info->vsk);
>>> +
>>> +    if (t_ops->can_msgzerocopy) {
>>
>> So if `can_msgzerocopy` is not implemented, we always return true after
>> this point. Should we mention it in the .can_msgzerocopy documentation?
>
>Ops, this is my mistake, I must return 'false' in this case. Seems I didn't
>catch this problem with my tests, because there was no test case where
>zerocopy will fallback to copy!
>
>I'll fix it and add new test!

yep, I agree!

>
>>
>> Can we also mention in the commit description why this is need only for
>> virtio_tranport and not for vhost and loopback?
>>
>>> +        int pages_in_iov = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>>> +        int pages_to_send = min(pages_in_iov, MAX_SKB_FRAGS);
>>> +
>>> +        return t_ops->can_msgzerocopy(pages_to_send);
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +

[...]

>>> @@ -270,6 +395,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>>             break;
>>>         }
>>>
>>> +        /* This is last skb to send this portion of data. */
>>
>> Sorry I didn't get it :-(
>>
>> Can you elaborate this a bit more?
>
>I mean that we iterate over user's buffer here, allocating skb on each
>iteration. And for last skb for this buffer we initialize completion
>for user (we need to allocate one completion for one syscall).

Okay, so maybe we should explain better also in the code comment.
>
>Thanks for review, I'll fix all other comments and resend patchset when
>'net-next' will be opened again.

Cool, thanks!
Stefano


