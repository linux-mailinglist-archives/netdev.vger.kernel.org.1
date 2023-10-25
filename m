Return-Path: <netdev+bounces-44089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E107D6151
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945BCB21048
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94942125B3;
	Wed, 25 Oct 2023 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqjJxEOT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403D5397
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:50:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A6F12A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698213048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KN+e0aKFNbM4E73v4YilopHI48/pLEXBGl/D/hXMGQ=;
	b=DqjJxEOTSpuDX6dSiZovjOKXN+2jlZq5Vt6utqIN3nlygSTYrE1JdHIe5YfCSUWB0XcDMN
	cYvV8ZTOt2mUv8qdCBefTU4Sv4HkAs4eXoSSpRA/7r5oT1i9ZzLxYs9Lo18oFMSbxe3jTK
	YDLSfd0npQW8Z2JQniKUIOOGmjXmpzo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-uUqnJDU5NDGjdijWdEA6Ww-1; Wed, 25 Oct 2023 01:50:46 -0400
X-MC-Unique: uUqnJDU5NDGjdijWdEA6Ww-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507b92b4346so5421253e87.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698213045; x=1698817845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KN+e0aKFNbM4E73v4YilopHI48/pLEXBGl/D/hXMGQ=;
        b=TSq5jA7pZuwhVXXMcyimJaE9OqB5WtvKACQh8FyaPWTqfuoGvfDrOy9CkKwws+VoJH
         +w70hcte7Ev0GCsaYWWb+v94cMn0O5p9EnxW4oVjEMdJ0q5Vpo9v5T3ZgTe6jp4AMklg
         b6NZfpLhOxJsqCARQnPFwRTXDRxHJo1u2Dh3wi32CuNG8Z+W9UJmacXwgMhyN+BSCQ0i
         a0QBgrbkFm01zL3qo+RnH3KPPiEmOK1mryK6jaBGpsuhTD2ke04zk6Wz5pwgUP2OWPOI
         NaqWdy0dNsaOvCSBb91CaCzH27lyd02Uh5u6e0acllE1Fq5Mtf+oNx0DglCNTcQPQwYa
         2hBA==
X-Gm-Message-State: AOJu0YwZhlvUxS8GvNmjZMajGCb68x2QTksrgSslw0r7miVjES76/DHk
	VaEL3hlUw7jKu+DpauCOUtS7Z/occeVCqW8FcaVt/rszPMwkl06lsDVfotmr88e8p23oXSPzyTC
	vomF3/et1ufnY+Opy
X-Received: by 2002:a05:6512:3b24:b0:507:aaab:528c with SMTP id f36-20020a0565123b2400b00507aaab528cmr11969644lfv.69.1698213045004;
        Tue, 24 Oct 2023 22:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiaNI7qJmDAB2WipmOi0kcNvRZGBxrxZ2hGGyvWUwDJK/OYH7pxYf0DotRVB2vb5H3kAEqTg==
X-Received: by 2002:a05:6512:3b24:b0:507:aaab:528c with SMTP id f36-20020a0565123b2400b00507aaab528cmr11969627lfv.69.1698213044625;
        Tue, 24 Oct 2023 22:50:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f1:7547:f72e:6bd0:1eb2:d4b5])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040813e14b49sm18483798wmo.30.2023.10.24.22.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:50:43 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:50:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	"Liu, Yujie" <yujie.liu@intel.com>
Subject: Re: [PATCH net-next 5/5] virtio-net: support tx netdim
Message-ID: <20231025015010-mutt-send-email-mst@kernel.org>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <ef5d159875745040e406473bd5c03e9875742ff5.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEuX+kJ8G2CitnACVgx_OSsdbtedD+dvXJ_REFdwzx56Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuX+kJ8G2CitnACVgx_OSsdbtedD+dvXJ_REFdwzx56Vg@mail.gmail.com>

On Wed, Oct 25, 2023 at 11:35:43AM +0800, Jason Wang wrote:
> On Thu, Oct 12, 2023 at 3:44 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> >
> > Similar to rx netdim, this patch supports adaptive tx
> > coalescing moderation for the virtio-net.
> >
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 143 ++++++++++++++++++++++++++++++++-------
> >  1 file changed, 119 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 6ad2890a7909..1c680cb09d48 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -154,6 +154,15 @@ struct send_queue {
> >
> >         struct virtnet_sq_stats stats;
> >
> > +       /* The number of tx notifications */
> > +       u16 calls;
> > +
> > +       /* Is dynamic interrupt moderation enabled? */
> > +       bool dim_enabled;
> > +
> > +       /* Dynamic Interrupt Moderation */
> > +       struct dim dim;
> > +
> >         struct virtnet_interrupt_coalesce intr_coal;
> >
> >         struct napi_struct napi;
> > @@ -317,8 +326,9 @@ struct virtnet_info {
> >         u8 duplex;
> >         u32 speed;
> >
> > -       /* Is rx dynamic interrupt moderation enabled? */
> > +       /* Is dynamic interrupt moderation enabled? */
> >         bool rx_dim_enabled;
> > +       bool tx_dim_enabled;
> >
> >         /* Interrupt coalescing settings */
> >         struct virtnet_interrupt_coalesce intr_coal_tx;
> > @@ -464,19 +474,40 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
> >         return false;
> >  }
> >
> > +static void virtnet_tx_dim_work(struct work_struct *work);
> > +
> > +static void virtnet_tx_dim_update(struct virtnet_info *vi, struct send_queue *sq)
> > +{
> > +       struct virtnet_sq_stats *stats = &sq->stats;
> > +       struct dim_sample cur_sample = {};
> > +
> > +       u64_stats_update_begin(&sq->stats.syncp);
> > +       dim_update_sample(sq->calls, stats->packets,
> > +                         stats->bytes, &cur_sample);
> > +       u64_stats_update_end(&sq->stats.syncp);
> > +
> > +       net_dim(&sq->dim, cur_sample);
> > +}
> > +
> >  static void skb_xmit_done(struct virtqueue *vq)
> >  {
> >         struct virtnet_info *vi = vq->vdev->priv;
> > -       struct napi_struct *napi = &vi->sq[vq2txq(vq)].napi;
> > +       struct send_queue *sq = &vi->sq[vq2txq(vq)];
> > +       struct napi_struct *napi = &sq->napi;
> > +
> > +       sq->calls++;
> 
> I wonder what's the impact of this counters for netdim. As we have a
> mode of orphan skb in xmit.
> 
> We need to test to see.
> 
> Thanks

Agreed, performance patches should come with performance results.

-- 
MST


