Return-Path: <netdev+bounces-42899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771BC7D08D7
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A700E1C20F70
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 06:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9646CA67;
	Fri, 20 Oct 2023 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpjcNzcq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31928CA5F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:52:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD02B8
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697784753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EIj3bf1mGidhArRikuspkUzwv3+tYWXHezkRsnPZu4=;
	b=NpjcNzcqdtOvnHbH472fLKxTXZt8lxAz2sm6vFPyy3HT3iWEOpk2f7GJQtJXD0W9F70Q/1
	NtqBlSksosTzYUV7LrRvVJ2BCvcUcTDDUyhL9ouiDImxczQZrdloGhFLiCjJDifbPfnNzb
	R+Mdh7i1iH86MOQNwr3qIPCJ45xgcHY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-T2V6vtb5PMmkB-Uz2M4LDw-1; Fri, 20 Oct 2023 02:52:31 -0400
X-MC-Unique: T2V6vtb5PMmkB-Uz2M4LDw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507a3426041so485169e87.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784750; x=1698389550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EIj3bf1mGidhArRikuspkUzwv3+tYWXHezkRsnPZu4=;
        b=wgeXPtxWQCu60jMniDuDGdJXG1PBdlhZSxjeNIZP2dV7uh/dQO6qq7ve6030zOYedt
         XQF1+qC9UlTzrGWP/Yehf2QYn0C94KosTIm6IygSwYhXGRESUJ1CtJfilV9hifGTITbj
         m0WZN/MBc7ggyv8gyV8ybqutWFgo8vsjOhxcD4ot20IzPz4bNV5dqs05oME/kPG+WWLT
         A5DqyjuH3c6RNa+G2/L6fQCdVBvV6kNICeLTOZJZgGDGo3Xndl/iSBlfPX62s61yXI/q
         +aIJfYGbroPP2M7Tvf2OMbabXl3exKmvTxzl5Q3BEEyukicrXn437Z394fxSnndGGs0W
         Vp9Q==
X-Gm-Message-State: AOJu0YwYL0BLlGnxYgOMSBemUDyBO513iREEUzdMh9wlk+mI1zaJ+8v7
	w4LwXk/2pGNESTp835F8HAVIRnmTXQbrKzo+0be3p3Q0KxgTQMcWtSTOMiaNUhb6H+N8BA+Whsh
	gyC99875mVoPW5bOARKtxWDsgFKBMvrSK
X-Received: by 2002:ac2:5ec3:0:b0:507:9625:5fd3 with SMTP id d3-20020ac25ec3000000b0050796255fd3mr582996lfq.32.1697784750325;
        Thu, 19 Oct 2023 23:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnRuo5sqDr6/4TZIIbTk2wPU8ZXdj12hqoUmgYAL5U7xWnIZLrHn0v6rW79DCzNMacRgQXtQXbupSnIn3yQJ8=
X-Received: by 2002:ac2:5ec3:0:b0:507:9625:5fd3 with SMTP id
 d3-20020ac25ec3000000b0050796255fd3mr582985lfq.32.1697784749976; Thu, 19 Oct
 2023 23:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-13-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-13-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:52:18 +0800
Message-ID: <CACGkMEsoA_y6FV0PzoLfO-UFhJrYRe96cDpX_hHgSo7PAwshrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 12/19] virtio_net: xsk: tx: support wakeup
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> xsk wakeup is used to trigger the logic for xsk xmit by xsk framework or
> user.
>
> Virtio-Net does not support to actively generate an interruption, so it
> tries to trigger tx NAPI on the tx interrupt cpu.
>
> Consider the effect of cache. When interrupt triggers, it is
> generally fixed on a CPU. It is better to start TX Napi on the same
> CPU.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       |  3 ++
>  drivers/net/virtio/virtio_net.h |  8 +++++
>  drivers/net/virtio/xsk.c        | 57 +++++++++++++++++++++++++++++++++
>  drivers/net/virtio/xsk.h        |  1 +
>  4 files changed, 69 insertions(+)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index a08429bef61f..1a222221352e 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -2066,6 +2066,8 @@ static int virtnet_poll_tx(struct napi_struct *napi=
, int budget)
>                 return 0;
>         }
>
> +       sq->xsk.last_cpu =3D smp_processor_id();
> +
>         txq =3D netdev_get_tx_queue(vi->dev, index);
>         __netif_tx_lock(txq, raw_smp_processor_id());
>         virtqueue_disable_cb(sq->vq);
> @@ -3770,6 +3772,7 @@ static const struct net_device_ops virtnet_netdev =
=3D {
>         .ndo_vlan_rx_kill_vid =3D virtnet_vlan_rx_kill_vid,
>         .ndo_bpf                =3D virtnet_xdp,
>         .ndo_xdp_xmit           =3D virtnet_xdp_xmit,
> +       .ndo_xsk_wakeup         =3D virtnet_xsk_wakeup,
>         .ndo_features_check     =3D passthru_features_check,
>         .ndo_get_phys_port_name =3D virtnet_get_phys_port_name,
>         .ndo_set_features       =3D virtnet_set_features,
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index 3bbb1f5baad5..7c72a8bb1813 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -101,6 +101,14 @@ struct virtnet_sq {
>                 struct xsk_buff_pool __rcu *pool;
>
>                 dma_addr_t hdr_dma_address;
> +
> +               u32 last_cpu;
> +               struct __call_single_data csd;
> +
> +               /* The lock to prevent the repeat of calling
> +                * smp_call_function_single_async().
> +                */
> +               spinlock_t ipi_lock;
>         } xsk;
>  };
>
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index 0e775a9d270f..973e783260c3 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -115,6 +115,60 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct =
xsk_buff_pool *pool,
>         return sent =3D=3D budget;
>  }
>
> +static void virtnet_remote_napi_schedule(void *info)
> +{
> +       struct virtnet_sq *sq =3D info;
> +
> +       virtnet_vq_napi_schedule(&sq->napi, sq->vq);
> +}
> +
> +static void virtnet_remote_raise_napi(struct virtnet_sq *sq)
> +{
> +       u32 last_cpu, cur_cpu;
> +
> +       last_cpu =3D sq->xsk.last_cpu;
> +       cur_cpu =3D get_cpu();
> +
> +       /* On remote cpu, softirq will run automatically when ipi irq exi=
t. On
> +        * local cpu, smp_call_xxx will not trigger ipi interrupt, then s=
oftirq
> +        * cannot be triggered automatically. So Call local_bh_enable aft=
er to
> +        * trigger softIRQ processing.
> +        */
> +       if (last_cpu =3D=3D cur_cpu) {
> +               local_bh_disable();
> +               virtnet_vq_napi_schedule(&sq->napi, sq->vq);
> +               local_bh_enable();
> +       } else {
> +               if (spin_trylock(&sq->xsk.ipi_lock)) {
> +                       smp_call_function_single_async(last_cpu, &sq->xsk=
.csd);
> +                       spin_unlock(&sq->xsk.ipi_lock);
> +               }
> +       }

Is there any number to show whether it's worth it for an IPI here? For
example, GVE doesn't do this.

Thanks


> +
> +       put_cpu();
> +}
> +
> +int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
> +{
> +       struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct virtnet_sq *sq;
> +
> +       if (!netif_running(dev))
> +               return -ENETDOWN;
> +
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
> +       sq =3D &vi->sq[qid];
> +
> +       if (napi_if_scheduled_mark_missed(&sq->napi))
> +               return 0;
> +
> +       virtnet_remote_raise_napi(sq);
> +
> +       return 0;
> +}
> +
>  static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virt=
net_rq *rq,
>                                     struct xsk_buff_pool *pool)
>  {
> @@ -240,6 +294,9 @@ static int virtnet_xsk_pool_enable(struct net_device =
*dev,
>
>         sq->xsk.hdr_dma_address =3D hdr_dma;
>
> +       INIT_CSD(&sq->xsk.csd, virtnet_remote_napi_schedule, sq);
> +       spin_lock_init(&sq->xsk.ipi_lock);
> +
>         return 0;
>
>  err_sq:
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> index 73ca8cd5308b..1bd19dcda649 100644
> --- a/drivers/net/virtio/xsk.h
> +++ b/drivers/net/virtio/xsk.h
> @@ -17,4 +17,5 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
>  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xd=
p);
>  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
>                       int budget);
> +int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
>  #endif
> --
> 2.32.0.3.g01195cf9f
>


