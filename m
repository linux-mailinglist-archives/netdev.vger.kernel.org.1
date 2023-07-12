Return-Path: <netdev+bounces-17070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7427501A1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 10:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA14228197E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8B100AA;
	Wed, 12 Jul 2023 08:33:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A52100A1
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:33:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740435A2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 01:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689150812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fvdacFEp0fHJZBwcSBoPdNOwi8cM02LSwjABkIHIvP4=;
	b=I2azKyayccD/v5U3vKNBPKrg2Z9H1/kFiATuWDObTEBnF9CMxCZlDVTkau6gwPpvDHfPig
	2skc8e3KjislrDbHehcz0L1af2pSYMMCtQ6jcRr/lTyrNLZqdD9tVb1uffCkfPByLboTlI
	nFmiLIOsS2NvBaOgVI7rXcx4tSMt960=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-hr6eTmQeOM-0XSHtJWxyhg-1; Wed, 12 Jul 2023 04:33:30 -0400
X-MC-Unique: hr6eTmQeOM-0XSHtJWxyhg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b701c82e83so62779461fa.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 01:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689150809; x=1691742809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvdacFEp0fHJZBwcSBoPdNOwi8cM02LSwjABkIHIvP4=;
        b=MJDGLocr4tkcHGo6XnG3LhJt+U3m6AeU0WA3OFqaWqIdeEUJgzaftWF4WA0ire0wNa
         5OWbJtoBxEDgNqPd4fCVdt1/hInzEgnOzzYvKHbkan3b31gNVqgSoDx5lkdKMuF91lOC
         IlEapahmiq3tzaBiVC2aF2TH9nXrgFHRmzl1RMN42K+dA3zBAHvAeJNVg8P15Wi9Q4Fm
         z7/3ntaUeHbJodAKfUWWUS/yxiA7Vhu9HHQapHplu6MbtqkTEdkrYBqJwVLEBHHCX+C7
         Gbiou5cfUY42aK9Gh0/vnQDHM80WQ3nPiN5Q4ZISdTmKlxZUZq7oO4T+osLk7hhLIHw7
         vwtw==
X-Gm-Message-State: ABy/qLbB0vqtdgp74DW+79Y9YbXfmknIPsaZBY+IOnrDf513Xa73oDuV
	QoHHLMQ6+AxWdE3AERkX+GpKO+9XXHqqyH+PlE+TxTVKQ7mUJCOZL3YuUXArkEY9UUozzoDe1SD
	EgPkv4RcXdyRzxdiilA20jJrcZUJ4O0lg
X-Received: by 2002:a2e:b603:0:b0:2b4:737c:e316 with SMTP id r3-20020a2eb603000000b002b4737ce316mr16712861ljn.14.1689150809142;
        Wed, 12 Jul 2023 01:33:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEmgozVOI0gKaZQ3hOgaTYXTianq80QHVDrFU4Y4jEsQxG9CbS08CkZMlDFE28l0iJfKv8GKqIhGpj8BU76nDU=
X-Received: by 2002:a2e:b603:0:b0:2b4:737c:e316 with SMTP id
 r3-20020a2eb603000000b002b4737ce316mr16712841ljn.14.1689150808782; Wed, 12
 Jul 2023 01:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com> <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jul 2023 16:33:17 +0800
Message-ID: <CACGkMEseicSpsCZEunV_GoPR2qYfnB-kp_DvJQUg1pyED9XBkA@mail.gmail.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 11:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> caller can do dma operation in advance. The purpose is to keep memory
> mapped across multiple add/get buf operations.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 17 +++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d471dee3f4f7..1fb2c6dca9ea 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2265,6 +2265,23 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
>
> +/**
> + * virtqueue_dma_dev - get the dma dev
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Returns the dma dev. That can been used for dma api.
> + */
> +struct device *virtqueue_dma_dev(struct virtqueue *_vq)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +
> +       if (vq->use_dma_api)
> +               return vring_dma_dev(vq);
> +       else
> +               return NULL;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_dev);
> +
>  /**
>   * virtqueue_kick_prepare - first half of split virtqueue_kick call.
>   * @_vq: the struct virtqueue
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 2efd07b79ecf..35d175121cc6 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -61,6 +61,8 @@ int virtqueue_add_sgs(struct virtqueue *vq,
>                       void *data,
>                       gfp_t gfp);
>
> +struct device *virtqueue_dma_dev(struct virtqueue *vq);
> +
>  bool virtqueue_kick(struct virtqueue *vq);
>
>  bool virtqueue_kick_prepare(struct virtqueue *vq);
> --
> 2.32.0.3.g01195cf9f
>


