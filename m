Return-Path: <netdev+bounces-14178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5690873F608
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 09:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFC61C20A87
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE63BA25;
	Tue, 27 Jun 2023 07:49:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE57A94B
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:49:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A4E10D2
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 00:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687852147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QskuoK2+u8nib14YsmgjwegctAeH9ldt3GHDxrpov3o=;
	b=Jx3OR151EzOaZoVgt8OEEkkmhnPRn+WmieHdGTcD0wLG76yDzWc+dW9C3X0wJf62oVPcOu
	gDlETzgMWEUEgWJe41JE4+IEC9SstjaF3fxUpP74Lgs+7EfZQ8a3vItspuZE8/leNZuNuB
	E/c99rcO4rFN82o6lt7MgS2awiLsuns=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375--UDeGfJYOZ-zzkq-ktU5Yg-1; Tue, 27 Jun 2023 03:49:05 -0400
X-MC-Unique: -UDeGfJYOZ-zzkq-ktU5Yg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355c9028so270813666b.3
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 00:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852144; x=1690444144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QskuoK2+u8nib14YsmgjwegctAeH9ldt3GHDxrpov3o=;
        b=MoIylVgc4VtIavTfvyOy4QsGkQpulPETvapnUJrG2BM5tB2dI+ZtN98fzazjRWL7DX
         W9uzYcGClMTF2wpfOVbZ8xNFMM5KVei6a+s+K1cBMIO6fW5I9s4xvRhpPYaIW7RGErnl
         3HV3d4H6pjarw4JmdzrydaB2T+WEOrgZTi1Z/S5CpQJqGRWUDBm4obsi5Qyvsm7gjm/R
         GCoXM9awg+3TnYDWm0SaSZesx6S8SOK4+DH7J0BHrGcKhwSj1UkjF/tlSOHEEDi3a/ka
         imWp5Nx0OXjswNxeI76T1LjSIamv0D5qH0XprYUBLcU1yv4gt91jfSmmpr3NhrrJnXOs
         ElFg==
X-Gm-Message-State: AC+VfDxd87t4DYMtEiHoPuMG0eAqG3sN4Gy1gEfh8NpzXZVeFf7TPpSa
	LER3xQjBmkQOH7wi9v2rDC5hm16wNF0hJ3gSTGEjosYwdqJiRvv7qZReVRDzudrpqJTc7BARmWP
	2u17gxWwmwPG2nCOf
X-Received: by 2002:a17:907:5c2:b0:974:55a2:cb0b with SMTP id wg2-20020a17090705c200b0097455a2cb0bmr27377792ejb.55.1687852144701;
        Tue, 27 Jun 2023 00:49:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lPeO/qla5LYI8so4+wb692OOE9l0zoDT61iV17QvGS0n+RA4RN7JnC6UwGFHGHsZN1sj4ZQ==
X-Received: by 2002:a17:907:5c2:b0:974:55a2:cb0b with SMTP id wg2-20020a17090705c200b0097455a2cb0bmr27377778ejb.55.1687852144363;
        Tue, 27 Jun 2023 00:49:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id n5-20020a170906088500b0098963eb0c3dsm4208125eje.26.2023.06.27.00.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:49:03 -0700 (PDT)
Date: Tue, 27 Jun 2023 09:49:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 03/17] vsock/virtio: support to send non-linear skb
Message-ID: <6g6rfqbfkmfn5or56v25xny6lyhixj6plmrnyg77hirz7dzzhn@jskeqmnbthhk>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-4-AVKrasnov@sberdevices.ru>
 <3lg4apldxdrpbkgfa2o4wxe4qyayj2h7b2lfcw3q5a7u3hnofi@z2ifmmzt4xpc>
 <0a89e51b-0f7f-b64b-c827-7c943d6f08a6@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a89e51b-0f7f-b64b-c827-7c943d6f08a6@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 07:39:41AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 18:36, Stefano Garzarella wrote:
>> On Sat, Jun 03, 2023 at 11:49:25PM +0300, Arseniy Krasnov wrote:
>>> For non-linear skb use its pages from fragment array as buffers in
>>> virtio tx queue. These pages are already pinned by 'get_user_pages()'
>>> during such skb creation.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/virtio_transport.c | 37 ++++++++++++++++++++++++++------
>>> 1 file changed, 31 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>>> index e95df847176b..6053d8341091 100644
>>> --- a/net/vmw_vsock/virtio_transport.c
>>> +++ b/net/vmw_vsock/virtio_transport.c
>>> @@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>>     vq = vsock->vqs[VSOCK_VQ_TX];
>>>
>>>     for (;;) {
>>> -        struct scatterlist hdr, buf, *sgs[2];
>>> +        /* +1 is for packet header. */
>>> +        struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
>>> +        struct scatterlist bufs[MAX_SKB_FRAGS + 1];
>>>         int ret, in_sg = 0, out_sg = 0;
>>>         struct sk_buff *skb;
>>>         bool reply;
>>> @@ -111,12 +113,35 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>>
>>>         virtio_transport_deliver_tap_pkt(skb);
>>>         reply = virtio_vsock_skb_reply(skb);
>>> +        sg_init_one(&bufs[0], virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>>> +        sgs[out_sg++] = &bufs[0];
>>
>> Can we use out_sg also to index bufs (here and in the rest of the code)?
>>
>> E.g.
>>
>>         sg_init_one(&bufs[out_sg], ...)
>>         sgs[out_sg] = &bufs[out_sg];
>>         ++out_sg;
>>
>>         ...
>>             if (skb->len > 0) {
>>                 sg_init_one(&bufs[out_sg], skb->data, skb->len);
>>                 sgs[out_sg] = &bufs[out_sg];
>>                 ++out_sg;
>>             }
>>
>>         etc...
>>
>>> +
>>
>> For readability, I would move the smaller branch above:
>>
>>         if (!skb_is_nonlinear(skb)) {
>>             // small block
>>             ...
>>         } else {
>>             // big block
>>             ...
>>         }
>>
>>> +        if (skb_is_nonlinear(skb)) {
>>> +            struct skb_shared_info *si;
>>> +            int i;
>>> +
>>> +            si = skb_shinfo(skb);
>>> +
>>> +            for (i = 0; i < si->nr_frags; i++) {
>>> +                skb_frag_t *skb_frag = &si->frags[i];
>>> +                void *va = page_to_virt(skb_frag->bv_page);
>>> +
>>> +                /* We will use 'page_to_virt()' for userspace page here,
>>> +                 * because virtio layer will call 'virt_to_phys()' later
>>> +                 * to fill buffer descriptor. We don't touch memory at
>>> +                 * "virtual" address of this page.
>>> +                 */
>>> +                sg_init_one(&bufs[i + 1],
>>> +                        va + skb_frag->bv_offset,
>>> +                        skb_frag->bv_len);
>>> +                sgs[out_sg++] = &bufs[i + 1];
>>> +            }
>>> +        } else {
>>> +            if (skb->len > 0) {
>>
>> Should we do the same check (skb->len > 0) for nonlinear skb as well?
>> Or do the nonlinear ones necessarily have len > 0?
>
>Yes, non-linear skb always has 'data_len' > 0, e.g. such skbs always have some
>data in it.

Okay, makes sense ;-)

Thanks,
Stefano

>
>Thanks, Arseniy
>
>>
>>> +                sg_init_one(&bufs[1], skb->data, skb->len);
>>> +                sgs[out_sg++] = &bufs[1];
>>> +            }
>>>
>>    ^
>> Blank line that we can remove.
>>
>> Stefano
>>
>>> -        sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>>> -        sgs[out_sg++] = &hdr;
>>> -        if (skb->len > 0) {
>>> -            sg_init_one(&buf, skb->data, skb->len);
>>> -            sgs[out_sg++] = &buf;
>>>         }
>>>
>>>         ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>>> -- 
>>> 2.25.1
>>>
>>
>


