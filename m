Return-Path: <netdev+bounces-14287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CF273FF17
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8887A1C2040F
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF2419515;
	Tue, 27 Jun 2023 14:57:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56518000
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 14:57:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BB83AA4
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687877827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjhqKJ6qHLUSB8vtY/otx3G8KHzKt0XENzTe4gO6p4g=;
	b=FdaQkJaEhfgz/koij3W/KKb3bQPGirP+StutMHTrnHstkhEGcHeKDXdd0LrfJyt+AuSict
	OiTnIUBMVZoTWVf170iPqfN+DOz0zMSM8GHP836EjtCY2B+Y2DHWDRxcQQ40vOAaDZTBM7
	tyERC1OsYuONIyVMzNnV1Iu8PyKm1MI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-6PfRRowrPZeV3qT-cxAavA-1; Tue, 27 Jun 2023 10:57:04 -0400
X-MC-Unique: 6PfRRowrPZeV3qT-cxAavA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635325b87c9so37635046d6.1
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687877822; x=1690469822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjhqKJ6qHLUSB8vtY/otx3G8KHzKt0XENzTe4gO6p4g=;
        b=CLnS0OgC1SpzsOTuQInACeiPQWcN2uxKYozKehRFrLcLOAE0wktETK7tpYs306ynd7
         Q1uMdr9MsNkBH8J3zlr2lpqgsinLOLkkk764suy5/aGD862Pv+aJn9fAO90YP7iZe6/t
         wOG9RjxzCN6i+HBYxy1x2iokMjJ2c+tLE47KEh662mGgiHRwokp2NuCVFajQpkz8I0av
         P6HrqcGQ7fuG+L1rrwiqzm/2OU2c52jqfFfS0L8vFlvi9xHYkpppyNWJwynhUrPb/i3/
         ER0qzOA16uDGK/L2QdfsMJHVbEfqaYMsHcLYLVyZ6IgdfzbNrSXVWr0xz7f2ejj9SSfB
         JhZQ==
X-Gm-Message-State: AC+VfDy6y9M9UMV4W4in1KeOmA5bF5QuEIbFMYmBdiIlatI4tTogVBlj
	Ia6ErXUizsIiHpL8c8qNDj3/B6ABS+KZ5nUEn7LmRgDErVcFvNxXoOQO1gEguIN8BW4Nfon9zzP
	KPrHHRqJmAMjYTXZ1
X-Received: by 2002:a05:6214:2aae:b0:632:32ce:7947 with SMTP id js14-20020a0562142aae00b0063232ce7947mr14376524qvb.28.1687877822155;
        Tue, 27 Jun 2023 07:57:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FD4BbrfWJUBHlxMixbL2nRBP622c0YmQmLo/tSNy5xIH+gMS3yY4rfgKonMVPNm3KAa5EFw==
X-Received: by 2002:a05:6214:2aae:b0:632:32ce:7947 with SMTP id js14-20020a0562142aae00b0063232ce7947mr14376506qvb.28.1687877821863;
        Tue, 27 Jun 2023 07:57:01 -0700 (PDT)
Received: from redhat.com ([45.144.113.5])
        by smtp.gmail.com with ESMTPSA id fc4-20020ad44f24000000b00635ef0579c2sm1022904qvb.39.2023.06.27.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:57:01 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:56:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost v10 02/10] virtio_ring: introduce
 virtqueue_set_premapped()
Message-ID: <20230627105503-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEt3xRvn5na+f4vHjFQoJJcPTvvE3Yd_bGxrDFo9owkqCA@mail.gmail.com>
 <1687855801.1280077-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1687855801.1280077-4-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 04:50:01PM +0800, Xuan Zhuo wrote:
> On Tue, 27 Jun 2023 16:03:23 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Fri, Jun 2, 2023 at 5:22 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > This helper allows the driver change the dma mode to premapped mode.
> > > Under the premapped mode, the virtio core do not do dma mapping
> > > internally.
> > >
> > > This just work when the use_dma_api is true. If the use_dma_api is false,
> > > the dma options is not through the DMA APIs, that is not the standard
> > > way of the linux kernel.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 40 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/virtio.h       |  2 ++
> > >  2 files changed, 42 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 72ed07a604d4..2afdfb9e3e30 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -172,6 +172,9 @@ struct vring_virtqueue {
> > >         /* Host publishes avail event idx */
> > >         bool event;
> > >
> > > +       /* Do DMA mapping by driver */
> > > +       bool premapped;
> > > +
> > >         /* Head of free buffer list. */
> > >         unsigned int free_head;
> > >         /* Number we've added since last sync. */
> > > @@ -2059,6 +2062,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > >         vq->packed_ring = true;
> > >         vq->dma_dev = dma_dev;
> > >         vq->use_dma_api = vring_use_dma_api(vdev);
> > > +       vq->premapped = false;
> > >
> > >         vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> > >                 !context;
> > > @@ -2548,6 +2552,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > >  #endif
> > >         vq->dma_dev = dma_dev;
> > >         vq->use_dma_api = vring_use_dma_api(vdev);
> > > +       vq->premapped = false;
> > >
> > >         vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> > >                 !context;
> > > @@ -2691,6 +2696,41 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> > >
> > > +/**
> > > + * virtqueue_set_premapped - set the vring premapped mode
> > > + * @_vq: the struct virtqueue we're talking about.
> > > + *
> > > + * Enable the premapped mode of the vq.
> > > + *
> > > + * The vring in premapped mode does not do dma internally, so the driver must
> > > + * do dma mapping in advance. The driver must pass the dma_address through
> > > + * dma_address of scatterlist. When the driver got a used buffer from
> > > + * the vring, it has to unmap the dma address. So the driver must call
> > > + * virtqueue_get_buf_premapped()/virtqueue_detach_unused_buf_premapped().
> > > + *
> > > + * This must be called before adding any buf to vring.
> >
> > And any old buffer should be detached?
> 
> I mean that before adding any buf, So there are not old buffer.
> 

Oh. So put this in the same sentence:

	This function must be called immediately after creating the vq,
	or after vq reset, and before adding any buffers to it.


> >
> > > + * So this should be called immediately after init vq or vq reset.

Do you really need to call this again after each reset?


> > Any way to detect and warn in this case? (not a must if it's too
> > expensive to do the check)
> 
> 
> I can try to check whether the qeueu is empty.
> 
> 
> >
> > > + *
> > > + * Caller must ensure we don't call this with other virtqueue operations
> > > + * at the same time (except where noted).
> > > + *
> > > + * Returns zero or a negative error.
> > > + * 0: success.
> > > + * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
> > > + */
> > > +int virtqueue_set_premapped(struct virtqueue *_vq)
> > > +{
> > > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > > +
> > > +       if (!vq->use_dma_api)
> > > +               return -EINVAL;
> > > +
> > > +       vq->premapped = true;
> >
> > I guess there should be a way to disable it. Would it be useful for
> > the case when AF_XDP sockets were destroyed?
> 
> Yes.
> 
> When we reset the queue, the vq->premapped will be set to 0.
> 
> The is called after find_vqs or reset vq.
> 
> Thanks.
> 
> 
> 
> >
> > Thanks
> >
> >
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_set_premapped);
> > > +
> > >  /* Only available for split ring */
> > >  struct virtqueue *vring_new_virtqueue(unsigned int index,
> > >                                       unsigned int num,
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index b93238db94e3..1fc0e1023bd4 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -78,6 +78,8 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
> > >
> > >  unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
> > >
> > > +int virtqueue_set_premapped(struct virtqueue *_vq);
> > > +
> > >  bool virtqueue_poll(struct virtqueue *vq, unsigned);
> > >
> > >  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >


