Return-Path: <netdev+bounces-18881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A26758F29
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6229B28105C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A3C8D0;
	Wed, 19 Jul 2023 07:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307DA3D8C
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:36:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19851736
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689752193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/l/BFx3Ouxomc0W5crH0QEL+N5uRN2SeYoUdCWhVZBA=;
	b=X5HS4QAmje4SpahwTW5wG/vym2nUcsDkyr7FlgXBPl7g+2xoQY1ra99ZpvCmnH8hYDtsbj
	PdP+oylMcRQhXOhGrYi+cQtid8BidRkQlQmzwavFcS7q3IofX9sY0m65fRV7Cgn6DblpU2
	ngNOPsiiPCSuMWh6Psc3sEsNIcOcYhY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-2sAPymF3PpG7RyXwoDN6zA-1; Wed, 19 Jul 2023 03:36:32 -0400
X-MC-Unique: 2sAPymF3PpG7RyXwoDN6zA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb76659d54so5425144e87.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689752191; x=1690356991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l/BFx3Ouxomc0W5crH0QEL+N5uRN2SeYoUdCWhVZBA=;
        b=dR+PUKzuSXs901fcppt3alYuQGpfmzP57Ms7tGbbAdP/j6J/G+QpLvVG16JHA+DUtc
         z66l1bbGyyFYsiKMsDGm9ZQpnZ6PlSoyHMsSXPIL+plgYp4OA5zvPU6Sy7P7XXySzmiK
         TrzMhHPV5JNB5o1eaDTmoeE4RUlL3oXIj9KATiANGNubqjnBpz2E0gZV2W/e4GUvKBTC
         uiCsbxf3pMR882z822YAaQEyphooritDVA9v0TFJEbe2aKADnHftE9NGrOCf87puW2sF
         DsCqJz46aCIOrNGupcALU/rGcHi+2G0cTqvp7OpLNFWbhOqlpwcOaiyOw57LYh+T9v4c
         3f2Q==
X-Gm-Message-State: ABy/qLY7GtgcxBRRuzlI/tWHG0lZqj6XDlznIMZfiuhgjgL0nU/vMJJP
	bY9dVnp8Fzw56ZmsBj/72b2nfjrNykLdu55Qm+JC3y40Vi6pZOPlOW//zOGwVGrQqc4wtnid2ov
	8ZxL71KIfdWVhDXwqB7UrUCyV
X-Received: by 2002:a05:6512:15a6:b0:4fd:d3aa:e425 with SMTP id bp38-20020a05651215a600b004fdd3aae425mr1581924lfb.27.1689752190997;
        Wed, 19 Jul 2023 00:36:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1vDeqm1BTcVm9t1Zzvu6JlLhYTYor1hjJsu8aGBt07Q6f2nfDA4itiCmBAX5Xer/YiP+tpg==
X-Received: by 2002:a05:6512:15a6:b0:4fd:d3aa:e425 with SMTP id bp38-20020a05651215a600b004fdd3aae425mr1581912lfb.27.1689752190665;
        Wed, 19 Jul 2023 00:36:30 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-29.business.telecomitalia.it. [87.12.25.29])
        by smtp.gmail.com with ESMTPSA id by27-20020a0564021b1b00b0051d87e72159sm2315237edb.13.2023.07.19.00.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:36:29 -0700 (PDT)
Date: Wed, 19 Jul 2023 09:36:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v2 2/4] vsock/virtio: support to send non-linear
 skb
Message-ID: <4batgyn7pmxn2rysqpztuaim4dxtpfjbrjyyuodsct3qun7w5e@ebd45ngrsfut>
References: <20230718180237.3248179-1-AVKrasnov@sberdevices.ru>
 <20230718180237.3248179-3-AVKrasnov@sberdevices.ru>
 <20230718162202-mutt-send-email-mst@kernel.org>
 <1ac4be11-0814-05af-6c2e-8563ac15e206@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1ac4be11-0814-05af-6c2e-8563ac15e206@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 07:46:05AM +0300, Arseniy Krasnov wrote:
>
>
>On 18.07.2023 23:27, Michael S. Tsirkin wrote:
>> On Tue, Jul 18, 2023 at 09:02:35PM +0300, Arseniy Krasnov wrote:
>>> For non-linear skb use its pages from fragment array as buffers in
>>> virtio tx queue. These pages are already pinned by 'get_user_pages()'
>>> during such skb creation.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>>  net/vmw_vsock/virtio_transport.c | 40 +++++++++++++++++++++++++++-----
>>>  1 file changed, 34 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>>> index e95df847176b..6cbb45bb12d2 100644
>>> --- a/net/vmw_vsock/virtio_transport.c
>>> +++ b/net/vmw_vsock/virtio_transport.c
>>> @@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>>  	vq = vsock->vqs[VSOCK_VQ_TX];
>>>
>>>  	for (;;) {
>>> -		struct scatterlist hdr, buf, *sgs[2];
>>> +		/* +1 is for packet header. */
>>> +		struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
>>> +		struct scatterlist bufs[MAX_SKB_FRAGS + 1];
>>>  		int ret, in_sg = 0, out_sg = 0;
>>>  		struct sk_buff *skb;
>>>  		bool reply;
>>> @@ -111,12 +113,38 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>>
>>>  		virtio_transport_deliver_tap_pkt(skb);
>>>  		reply = virtio_vsock_skb_reply(skb);
>>> +		sg_init_one(&bufs[out_sg], virtio_vsock_hdr(skb),
>>> +			    sizeof(*virtio_vsock_hdr(skb)));
>>> +		sgs[out_sg] = &bufs[out_sg];
>>> +		out_sg++;
>>> +
>>> +		if (!skb_is_nonlinear(skb)) {
>>> +			if (skb->len > 0) {
>>> +				sg_init_one(&bufs[out_sg], skb->data, skb->len);
>>> +				sgs[out_sg] = &bufs[out_sg];
>>> +				out_sg++;
>>> +			}
>>> +		} else {
>>> +			struct skb_shared_info *si;
>>> +			int i;
>>> +
>>> +			si = skb_shinfo(skb);
>>> +
>>> +			for (i = 0; i < si->nr_frags; i++) {
>>> +				skb_frag_t *skb_frag = &si->frags[i];
>>> +				void *va = page_to_virt(skb_frag->bv_page);
>>>
>>> -		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>>> -		sgs[out_sg++] = &hdr;
>>> -		if (skb->len > 0) {
>>> -			sg_init_one(&buf, skb->data, skb->len);
>>> -			sgs[out_sg++] = &buf;
>>> +				/* We will use 'page_to_virt()' for userspace page here,
>>
>> don't put comments after code they refer to, please?
>>
>>> +				 * because virtio layer will call 'virt_to_phys()' later
>>
>> it will but not always. sometimes it's the dma mapping layer.
>>
>>
>>> +				 * to fill buffer descriptor. We don't touch memory at
>>> +				 * "virtual" address of this page.
>>
>>
>> you need to stick "the" in a bunch of places above.
>
>Ok, I'll fix this comment!
>
>>
>>> +				 */
>>> +				sg_init_one(&bufs[out_sg],
>>> +					    va + skb_frag->bv_offset,
>>> +					    skb_frag->bv_len);
>>> +				sgs[out_sg] = &bufs[out_sg];
>>> +				out_sg++;
>>> +			}
>>>  		}
>>>
>>>  		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>>
>>
>> There's a problem here: if there vq is small this will fail.
>> So you really should check free vq s/gs and switch to non-zcopy
>> if too small.
>
>Ok, so idea is that:
>
>if (out_sg > vq->num_free)
>    reorganise current skb for copy mode (e.g. 2 out_sg - header and data)
>    and try to add it to vq again.
>
>?
>
>@Stefano, I'll remove net-next tag (guess RFC is not required again, but not net-next
>anyway) as this change will require review. R-b I think should be also removed. All
>other patches in this set still unchanged.

It's still a new feature so we have net-next tree as the target, right?

I think we should keep net-next. Even if patches require to be
re-reviewed, net-next indicates the tree where we want these to be merge
and for new features is the right one.

Ack for not putting RFC again and for R-b removal for this patch.

Thanks,
Stefano


