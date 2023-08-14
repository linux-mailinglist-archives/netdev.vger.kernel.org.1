Return-Path: <netdev+bounces-27329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C607277B789
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 13:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EE228119B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 11:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3063BA4B;
	Mon, 14 Aug 2023 11:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AABBA47
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 11:25:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340ACE5F
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 04:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692012309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5yFkqGLAbx9780NfgouP2k81nxEAsxnlewTCXDZKT8=;
	b=ilXc7RSx1wEWtNvfkAteeLDzfk9owKLlEWssq/AGmTeKOTx3rxDmuPV4N/+vxBnqdr/Kwq
	HLJqlm4W9xiDq5voZxjK8hsRjHP10P85/BpugEQjgdytlFiBVhw7c6YPioykGrWEJb0I0Z
	jV3lm5/Qw4skACh4Qruej5gvy88XTGk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-afQOpTL1Mb-IqezTWXSMlA-1; Mon, 14 Aug 2023 07:25:07 -0400
X-MC-Unique: afQOpTL1Mb-IqezTWXSMlA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9d0b3a572so43300781fa.1
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 04:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692012306; x=1692617106;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5yFkqGLAbx9780NfgouP2k81nxEAsxnlewTCXDZKT8=;
        b=ls+JGDfsyXghGyPD+wCxzc65g9y/Pwcn5Krwe9k39q0pCII2G5T/QFzklzUGwZ1E5a
         nyuLIcw0XodvKjCDu6UyctUxTeBrR/4wxBsL95Jf6JMTcQbHpyV6vRTzB+0ouJ9i6/Ax
         fPMRKdfJYncwn5PNWAafTS/NCWoAut/jGq7uk0Ley+PsoxwEOE2aLRMocS70wOjpM+Jd
         RdDVTny+el4JFfgf+TGtsppmj1CGBNin7wDdlbN7Co5pTevMM8emSELc5wPUM8j1zkuG
         ADCTrn5Zurm4tkiq21WabH7bpPfrdotMIFdXdS8e+a5+Q0kVATJN5MZ7IWhZzIdFpilt
         t/yQ==
X-Gm-Message-State: AOJu0Yzq3ICfzmF8vZGr5+MeP7o9tZwIR4UfUMTtVm+q3UuWsGniBFCc
	nyfMV8hxp4GuzOrFJHDYeKAs3YI3OmZk3gjFS7CZ7Cusn4Gj2v/rsNZbamEJLAVCIW4FadxAL41
	7yTBK+dHVn17gphyu
X-Received: by 2002:a2e:9e42:0:b0:2b6:de52:357 with SMTP id g2-20020a2e9e42000000b002b6de520357mr5802365ljk.40.1692012306398;
        Mon, 14 Aug 2023 04:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7GN0c3iSPO6lf+9QKRg8LqTQs22sq8qWlpAoK8JTl071RpztkZugmMhPN+lO9ut/U1h2cmQ==
X-Received: by 2002:a2e:9e42:0:b0:2b6:de52:357 with SMTP id g2-20020a2e9e42000000b002b6de520357mr5802347ljk.40.1692012306024;
        Mon, 14 Aug 2023 04:25:06 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906660c00b00992c92af6f4sm5597282ejp.144.2023.08.14.04.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 04:25:05 -0700 (PDT)
Date: Mon, 14 Aug 2023 07:24:59 -0400
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
	bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <20230814072350-mutt-send-email-mst@kernel.org>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692003413.6339955-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1692003413.6339955-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 04:56:53PM +0800, Xuan Zhuo wrote:
> On Mon, 14 Aug 2023 11:05:49 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Thu, Aug 10, 2023 at 8:31 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> > > caller can do dma operation in advance. The purpose is to keep memory
> > > mapped across multiple add/get buf operations.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > So I think we don't have actual users for this in this series? Can we
> > simply have another independent patch for this?
> 
> I am ok. I will remove this from the next version.
> 
> But I also help merge this to 6.6. Then we can let the virtio-net to support
> AF_XDP in 6.7+.

Is there going to be a next version? Because if yes it will be too late for the next release.
if all you want to do is drop this patch then just say so, no need
for another version.

> 
> >
> > > ---
> > >  drivers/virtio/virtio_ring.c | 17 +++++++++++++++++
> > >  include/linux/virtio.h       |  2 ++
> > >  2 files changed, 19 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index f9f772e85a38..bb3d73d221cd 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2265,6 +2265,23 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
> > >
> > > +/**
> > > + * virtqueue_dma_dev - get the dma dev
> > > + * @_vq: the struct virtqueue we're talking about.
> > > + *
> > > + * Returns the dma dev. That can been used for dma api.
> > > + */
> > > +struct device *virtqueue_dma_dev(struct virtqueue *_vq)
> > > +{
> > > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > > +
> > > +       if (vq->use_dma_api)
> > > +               return vring_dma_dev(vq);
> > > +       else
> > > +               return NULL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_dma_dev);
> >
> > One possible concern is that exporting things like NULL may result in
> > the switch in the caller (driver). I wonder if it's better to do
> > BUG_ON() in the path of NULL?
> 
> 
> I agree.
> 
> But we need a new helper to tell the driver(or AF_XDP) that the device support
> ACCESS_PLATFORM or not.
> 
> We need a switch, but we can make the switch is irrelevant to the DMA.
> 
> Thanks.
> 
> 
> 
> >
> > Thanks
> >
> > > +
> > >  /**
> > >   * virtqueue_kick_prepare - first half of split virtqueue_kick call.
> > >   * @_vq: the struct virtqueue
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 8add38038877..bd55a05eec04 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -61,6 +61,8 @@ int virtqueue_add_sgs(struct virtqueue *vq,
> > >                       void *data,
> > >                       gfp_t gfp);
> > >
> > > +struct device *virtqueue_dma_dev(struct virtqueue *vq);
> > > +
> > >  bool virtqueue_kick(struct virtqueue *vq);
> > >
> > >  bool virtqueue_kick_prepare(struct virtqueue *vq);
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >


