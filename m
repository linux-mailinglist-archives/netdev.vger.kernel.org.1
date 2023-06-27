Return-Path: <netdev+bounces-14183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202F873F65A
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 10:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3F51C2039E
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD6D51B;
	Tue, 27 Jun 2023 08:03:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A5846A
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 08:03:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFAA1A4
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687853015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQ1KiUIpCNyDhBtgM+t3Kj4l2XehoEKxQO7OYIILltw=;
	b=JkVFsOfXuTC9pXi0z1s8A29v7MyKW9tzLjzKh4x7g6snrvCfTvgL2hZA1xdIG//bjpt2QG
	6xFY1fYh8/yZ1x0uwIfNxOEQREGaUFIeMbAcNRUuj6sVtB511ECqiq8pFXvTA2Ni62ZBc6
	T1AD27gYTGO8Tm83z7DRsQiLf5jbqBs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-3KBY06liNjyLufXNofwMeA-1; Tue, 27 Jun 2023 04:03:33 -0400
X-MC-Unique: 3KBY06liNjyLufXNofwMeA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f76712f950so3564513e87.0
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 01:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853011; x=1690445011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQ1KiUIpCNyDhBtgM+t3Kj4l2XehoEKxQO7OYIILltw=;
        b=hLrGyEzVCikfXrYNrQmhVeZIPf0N3eyki4NTdEaa9fJQK+WmPeumSG6klLwibnfN4+
         uBoJPT0qCM1Qiri9H2wYf0+q9S0yM7P19N3gs/VJvIekkr0sOJg4xov5+YqoB9pOBX1S
         1hQhlOq2Gb8mmr8MgwIkZCnajQojsY99cVRhzEVBPuPCIi0wFOlCEFBjamfoDZr7SFTh
         AGBx0/eFtz8lQgvXek2sD3xeGF6QJ56JQapyqpZWKzJibgO3GEv9ZlZEKZ5W64StCXik
         yMREQF+bhpikUlWR9NJ4C1HsB80IvpPAG4VOrcjxjDICjrcFj8k3JeKX8N2KiGuUvI2e
         atoA==
X-Gm-Message-State: AC+VfDwufSI3nsAtqqQd3mwUpSpBSUwl4LT1Zo7DB3feW0Yu3jFhJzP+
	vSuDg4/8NU0QGkuThNaMoUXZO0S7tFUtm1dZ05r+910J0g4QqSRhuipkrLGE72IsAXGQ5pzOqA6
	By475cpRS6FD3jr0uQaQ17jI3BG8y/Sst
X-Received: by 2002:a19:7111:0:b0:4f3:9136:9cd0 with SMTP id m17-20020a197111000000b004f391369cd0mr17569907lfc.44.1687853011632;
        Tue, 27 Jun 2023 01:03:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/gIIK3zpzyK5hdGmnBvsXW1vftwaoK5OxHi4uoENLn5lDqWlNIYsZvweYSeoKVGgDi8bQXCRsOIUaUEHvEiw=
X-Received: by 2002:a19:7111:0:b0:4f3:9136:9cd0 with SMTP id
 m17-20020a197111000000b004f391369cd0mr17569879lfc.44.1687853011290; Tue, 27
 Jun 2023 01:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com> <20230602092206.50108-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230602092206.50108-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:03:19 +0800
Message-ID: <CACGkMEuS3DsjgP0RB2C-DbsACq4FU6RKD4C+p3dOGQHWdZJJhg@mail.gmail.com>
Subject: Re: [PATCH vhost v10 01/10] virtio_ring: put mapping error check in vring_map_one_sg
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This patch put the dma addr error check in vring_map_one_sg().
>
> The benefits of doing this:
>
> 1. reduce one judgment of vq->use_dma_api.
> 2. make vring_map_one_sg more simple, without calling
>    vring_mapping_error to check the return value. simplifies subsequent
>    code
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/virtio/virtio_ring.c | 37 +++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c5310eaf8b46..72ed07a604d4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -355,9 +355,8 @@ static struct device *vring_dma_dev(const struct vrin=
g_virtqueue *vq)
>  }
>
>  /* Map one sg entry. */
> -static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
> -                                  struct scatterlist *sg,
> -                                  enum dma_data_direction direction)
> +static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
> +                           enum dma_data_direction direction, dma_addr_t=
 *addr)
>  {
>         if (!vq->use_dma_api) {
>                 /*
> @@ -366,7 +365,8 @@ static dma_addr_t vring_map_one_sg(const struct vring=
_virtqueue *vq,
>                  * depending on the direction.
>                  */
>                 kmsan_handle_dma(sg_page(sg), sg->offset, sg->length, dir=
ection);
> -               return (dma_addr_t)sg_phys(sg);
> +               *addr =3D (dma_addr_t)sg_phys(sg);
> +               return 0;
>         }
>
>         /*
> @@ -374,9 +374,14 @@ static dma_addr_t vring_map_one_sg(const struct vrin=
g_virtqueue *vq,
>          * the way it expects (we don't guarantee that the scatterlist
>          * will exist for the lifetime of the mapping).
>          */
> -       return dma_map_page(vring_dma_dev(vq),
> +       *addr =3D dma_map_page(vring_dma_dev(vq),
>                             sg_page(sg), sg->offset, sg->length,
>                             direction);
> +
> +       if (dma_mapping_error(vring_dma_dev(vq), *addr))
> +               return -ENOMEM;
> +
> +       return 0;
>  }
>
>  static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
> @@ -588,8 +593,9 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>
>         for (n =3D 0; n < out_sgs; n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> -                       dma_addr_t addr =3D vring_map_one_sg(vq, sg, DMA_=
TO_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> +                       dma_addr_t addr;
> +
> +                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
))
>                                 goto unmap_release;
>
>                         prev =3D i;
> @@ -603,8 +609,9 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         }
>         for (; n < (out_sgs + in_sgs); n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> -                       dma_addr_t addr =3D vring_map_one_sg(vq, sg, DMA_=
FROM_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> +                       dma_addr_t addr;
> +
> +                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &ad=
dr))
>                                 goto unmap_release;
>
>                         prev =3D i;
> @@ -1279,9 +1286,8 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>
>         for (n =3D 0; n < out_sgs + in_sgs; n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> -                       addr =3D vring_map_one_sg(vq, sg, n < out_sgs ?
> -                                       DMA_TO_DEVICE : DMA_FROM_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> +                       if (vring_map_one_sg(vq, sg, n < out_sgs ?
> +                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE, &addr))
>                                 goto unmap_release;
>
>                         desc[i].flags =3D cpu_to_le16(n < out_sgs ?
> @@ -1426,9 +1432,10 @@ static inline int virtqueue_add_packed(struct virt=
queue *_vq,
>         c =3D 0;
>         for (n =3D 0; n < out_sgs + in_sgs; n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> -                       dma_addr_t addr =3D vring_map_one_sg(vq, sg, n < =
out_sgs ?
> -                                       DMA_TO_DEVICE : DMA_FROM_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> +                       dma_addr_t addr;
> +
> +                       if (vring_map_one_sg(vq, sg, n < out_sgs ?
> +                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE, &addr))
>                                 goto unmap_release;
>
>                         flags =3D cpu_to_le16(vq->packed.avail_used_flags=
 |
> --
> 2.32.0.3.g01195cf9f
>


