Return-Path: <netdev+bounces-46750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415107E62E4
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 05:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7812B20EAD
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 04:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC02A4D;
	Thu,  9 Nov 2023 04:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pn4zc1Ta"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBD568C
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 04:43:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8C26A9
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 20:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699505024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6GvB1IXAeogEqCiOtGvxdZOgEMsucwKwoO81VpCiTk=;
	b=Pn4zc1TakPoAFG15To6jYyiCAIV2sfmXCif0pz4qmmwi1GJYAv74bV77yG9J3ZxR8AKN6V
	l8a9aQiYYtPXn206rj0JUqJQXlzDoRty3PDSM7KxWTefyoSOdc0DSoBQC8xVh5iZkvTTRO
	RrmJlEL4OAoRLqmnJSSBQ1LoMalOlLI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-h_9zhG1QPUygfaYYNq_3bQ-1; Wed, 08 Nov 2023 23:43:42 -0500
X-MC-Unique: h_9zhG1QPUygfaYYNq_3bQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507bd5f4b2dso369705e87.2
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 20:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699505021; x=1700109821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6GvB1IXAeogEqCiOtGvxdZOgEMsucwKwoO81VpCiTk=;
        b=B/aunKR6aIe/dsnDIEeyLf6O2z/uq3tXAFUZvlFo8ElOb18bQIHq2KmWVUz9ZzxOCq
         13UWXpPnCjOc9kgqbFnI1s3UBvjBv732c9rUPLbm/9LuxyTFAi6Iqa56/FJtX0enh799
         11+9weIY8xXhuLt4tlAZypA5D/yQ6iPRgUFetUvLUtRSZHrP0zPRMZp9ylDmsjuaH9/m
         4w6A4zuB7UMrd23t48xL66XWQBML2dis3B4Wy2XIrwnECDmChHtez5fz2U5Ks9DaNuE6
         wUdc6/WyJFHPCH0EwT6Xb6iuQVTSgCqVKqYx7wywsmMJjYIgCUDIUIbXc3Q3sFUr+JuV
         JZsg==
X-Gm-Message-State: AOJu0YyL/KEoXPMmAj5oOA7fm9aNFwtJBseQ5svnTsQvq7xF66qoigY2
	2o7/JudRAsC9ROk0G0iwLryU0oorR7gIZVi4haCXRQB8EmRKVbOFZvGyxbzkMoSoeFoinvWYIOH
	9t2s5LeTVbG30BVn1Q+7sNZVIqUnoKpsE
X-Received: by 2002:ac2:494f:0:b0:509:48ad:27fe with SMTP id o15-20020ac2494f000000b0050948ad27femr366186lfi.16.1699505021231;
        Wed, 08 Nov 2023 20:43:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmrXgRrLh0LZUouoymKDIY+OrZMZh5nWG8w8P0DH+DnREZ+4yso6rCHWZ2X6ImfbGxnyxzD8AEwhHLH0g0UEU=
X-Received: by 2002:ac2:494f:0:b0:509:48ad:27fe with SMTP id
 o15-20020ac2494f000000b0050948ad27femr366173lfi.16.1699505020834; Wed, 08 Nov
 2023 20:43:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698929590.git.hengqi@linux.alibaba.com> <12c77098b73313eea8fdc88a3d1d20611444827d.1698929590.git.hengqi@linux.alibaba.com>
In-Reply-To: <12c77098b73313eea8fdc88a3d1d20611444827d.1698929590.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 12:43:29 +0800
Message-ID: <CACGkMEunoNEA1KFKmH+RhHkFreMgAEa-NgL+XVNROi8qvL42=A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] virtio-net: support rx netdim
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 9:10=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> By comparing the traffic information in the complete napi processes,
> let the virtio-net driver automatically adjust the coalescing
> moderation parameters of each receive queue.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
> v1->v2:
> - Improved the judgment of dim switch conditions.
> - Fix the safe problem of work thread.

Nit: it's better to be more concrete here, e.g what kind of "safe
problem" it is.


>
>  drivers/net/virtio_net.c | 187 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 165 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 69fe09e99b3c..5473aa1ee5cd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -19,6 +19,7 @@
>  #include <linux/average.h>
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
> +#include <linux/dim.h>
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> @@ -172,6 +173,17 @@ struct receive_queue {
>
>         struct virtnet_rq_stats stats;
>
> +       /* The number of rx notifications */
> +       u16 calls;
> +
> +       /* Is dynamic interrupt moderation enabled? */
> +       bool dim_enabled;
> +
> +       /* Dynamic Interrupt Moderation */
> +       struct dim dim;
> +
> +       u32 packets_in_napi;
> +
>         struct virtnet_interrupt_coalesce intr_coal;
>
>         /* Chain pages by the private ptr. */
> @@ -305,6 +317,9 @@ struct virtnet_info {
>         u8 duplex;
>         u32 speed;
>
> +       /* Is rx dynamic interrupt moderation enabled? */
> +       bool rx_dim_enabled;
> +
>         /* Interrupt coalescing settings */
>         struct virtnet_interrupt_coalesce intr_coal_tx;
>         struct virtnet_interrupt_coalesce intr_coal_rx;
> @@ -2001,6 +2016,7 @@ static void skb_recv_done(struct virtqueue *rvq)
>         struct virtnet_info *vi =3D rvq->vdev->priv;
>         struct receive_queue *rq =3D &vi->rq[vq2rxq(rvq)];
>
> +       rq->calls++;
>         virtqueue_napi_schedule(&rq->napi, rvq);
>  }
>
> @@ -2141,6 +2157,26 @@ static void virtnet_poll_cleantx(struct receive_qu=
eue *rq)
>         }
>  }
>
> +static void virtnet_rx_dim_work(struct work_struct *work);
> +
> +static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receiv=
e_queue *rq)
> +{
> +       struct dim_sample cur_sample =3D {};
> +
> +       if (!rq->packets_in_napi)
> +               return;
> +
> +       u64_stats_update_begin(&rq->stats.syncp);
> +       dim_update_sample(rq->calls,
> +                         u64_stats_read(&rq->stats.packets),
> +                         u64_stats_read(&rq->stats.bytes),
> +                         &cur_sample);
> +       u64_stats_update_end(&rq->stats.syncp);
> +
> +       net_dim(&rq->dim, cur_sample);
> +       rq->packets_in_napi =3D 0;
> +}
> +
>  static int virtnet_poll(struct napi_struct *napi, int budget)
>  {
>         struct receive_queue *rq =3D
> @@ -2149,17 +2185,22 @@ static int virtnet_poll(struct napi_struct *napi,=
 int budget)
>         struct send_queue *sq;
>         unsigned int received;
>         unsigned int xdp_xmit =3D 0;
> +       bool napi_complete;
>
>         virtnet_poll_cleantx(rq);
>
>         received =3D virtnet_receive(rq, budget, &xdp_xmit);
> +       rq->packets_in_napi +=3D received;
>
>         if (xdp_xmit & VIRTIO_XDP_REDIR)
>                 xdp_do_flush();
>
>         /* Out of packets? */
> -       if (received < budget)
> -               virtqueue_napi_complete(napi, rq->vq, received);
> +       if (received < budget) {
> +               napi_complete =3D virtqueue_napi_complete(napi, rq->vq, r=
eceived);
> +               if (napi_complete && rq->dim_enabled)
> +                       virtnet_rx_dim_update(vi, rq);
> +       }
>
>         if (xdp_xmit & VIRTIO_XDP_TX) {
>                 sq =3D virtnet_xdp_get_sq(vi);
> @@ -2179,6 +2220,7 @@ static void virtnet_disable_queue_pair(struct virtn=
et_info *vi, int qp_index)
>         virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
>         napi_disable(&vi->rq[qp_index].napi);
>         xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> +       cancel_work_sync(&vi->rq[qp_index].dim.work);
>  }
>
>  static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_ind=
ex)
> @@ -2196,6 +2238,9 @@ static int virtnet_enable_queue_pair(struct virtnet=
_info *vi, int qp_index)
>         if (err < 0)
>                 goto err_xdp_reg_mem_model;
>
> +       INIT_WORK(&vi->rq[qp_index].dim.work, virtnet_rx_dim_work);

Any reason we need to do the INIT_WORK here but not probe?

> +       vi->rq[qp_index].dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQE;
> +
>         virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>         virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index]=
.napi);
>
> @@ -2393,8 +2438,10 @@ static int virtnet_rx_resize(struct virtnet_info *=
vi,
>
>         qindex =3D rq - vi->rq;
>
> -       if (running)
> +       if (running) {
>                 napi_disable(&rq->napi);
> +               cancel_work_sync(&rq->dim.work);
> +       }
>
>         err =3D virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused=
_buf);
>         if (err)
> @@ -2403,8 +2450,10 @@ static int virtnet_rx_resize(struct virtnet_info *=
vi,
>         if (!try_fill_recv(vi, rq, GFP_KERNEL))
>                 schedule_delayed_work(&vi->refill, 0);
>
> -       if (running)
> +       if (running) {
> +               INIT_WORK(&rq->dim.work, virtnet_rx_dim_work);
>                 virtnet_napi_enable(rq->vq, &rq->napi);
> +       }
>         return err;
>  }
>
> @@ -3341,24 +3390,51 @@ static int virtnet_send_tx_notf_coal_cmds(struct =
virtnet_info *vi,
>  static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>                                           struct ethtool_coalesce *ec)
>  {
> +       bool rx_ctrl_dim_on =3D !!ec->use_adaptive_rx_coalesce;
>         struct scatterlist sgs_rx;
> +       bool switch_dim, update;
>         int i;
>
> -       vi->ctrl->coal_rx.rx_usecs =3D cpu_to_le32(ec->rx_coalesce_usecs)=
;
> -       vi->ctrl->coal_rx.rx_max_packets =3D cpu_to_le32(ec->rx_max_coale=
sced_frames);
> -       sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx=
));
> -
> -       if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> -                                 VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> -                                 &sgs_rx))
> -               return -EINVAL;
> +       switch_dim =3D rx_ctrl_dim_on !=3D vi->rx_dim_enabled;
> +       if (switch_dim) {
> +               if (rx_ctrl_dim_on) {
> +                       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_=
NOTF_COAL)) {
> +                               vi->rx_dim_enabled =3D true;
> +                               for (i =3D 0; i < vi->max_queue_pairs; i+=
+)
> +                                       vi->rq[i].dim_enabled =3D true;
> +                       } else {
> +                               return -EOPNOTSUPP;
> +                       }
> +               } else {
> +                       vi->rx_dim_enabled =3D false;
> +                       for (i =3D 0; i < vi->max_queue_pairs; i++)
> +                               vi->rq[i].dim_enabled =3D false;
> +               }
> +       } else {
> +               if (ec->rx_coalesce_usecs !=3D vi->intr_coal_rx.max_usecs=
 ||
> +                   ec->rx_max_coalesced_frames !=3D vi->intr_coal_rx.max=
_packets)
> +                       update =3D true;
>
> -       /* Save parameters */
> -       vi->intr_coal_rx.max_usecs =3D ec->rx_coalesce_usecs;
> -       vi->intr_coal_rx.max_packets =3D ec->rx_max_coalesced_frames;
> -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               vi->rq[i].intr_coal.max_usecs =3D ec->rx_coalesce_usecs;
> -               vi->rq[i].intr_coal.max_packets =3D ec->rx_max_coalesced_=
frames;
> +               if (vi->rx_dim_enabled) {
> +                       if (update)
> +                               return -EINVAL;

update could be used without initialization?

Btw under what condition could we reach here?

Thanks

> +               } else {
> +                       vi->ctrl->coal_rx.rx_usecs =3D cpu_to_le32(ec->rx=
_coalesce_usecs);
> +                       vi->ctrl->coal_rx.rx_max_packets =3D cpu_to_le32(=
ec->rx_max_coalesced_frames);
> +                       sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(v=
i->ctrl->coal_rx));
> +
> +                       if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOT=
F_COAL,
> +                                                 VIRTIO_NET_CTRL_NOTF_CO=
AL_RX_SET,
> +                                                 &sgs_rx))
> +                               return -EINVAL;
> +
> +                       vi->intr_coal_rx.max_usecs =3D ec->rx_coalesce_us=
ecs;
> +                       vi->intr_coal_rx.max_packets =3D ec->rx_max_coale=
sced_frames;
> +                       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                               vi->rq[i].intr_coal.max_usecs =3D ec->rx_=
coalesce_usecs;
> +                               vi->rq[i].intr_coal.max_packets =3D ec->r=
x_max_coalesced_frames;
> +                       }
> +               }
>         }
>
>         return 0;
> @@ -3380,15 +3456,54 @@ static int virtnet_send_notf_coal_cmds(struct vir=
tnet_info *vi,
>         return 0;
>  }
>
> +static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
> +                                            struct ethtool_coalesce *ec,
> +                                            u16 queue)
> +{
> +       bool rx_ctrl_dim_on =3D !!ec->use_adaptive_rx_coalesce;
> +       bool cur_rx_dim =3D vi->rq[queue].dim_enabled;
> +       u32 max_usecs, max_packets;
> +       bool switch_dim, update;
> +       int err;
> +
> +       switch_dim =3D rx_ctrl_dim_on !=3D cur_rx_dim;
> +       if (switch_dim) {
> +               if (rx_ctrl_dim_on)
> +                       vi->rq[queue].dim_enabled =3D true;
> +               else
> +                       vi->rq[queue].dim_enabled =3D false;
> +       } else {
> +               max_usecs =3D vi->rq[queue].intr_coal.max_usecs;
> +               max_packets =3D vi->rq[queue].intr_coal.max_packets;
> +               if (ec->rx_coalesce_usecs !=3D max_usecs ||
> +                   ec->rx_max_coalesced_frames !=3D max_packets)
> +                       update =3D true;
> +
> +               if (cur_rx_dim) {
> +                       if (update)
> +                               return -EINVAL;
> +               } else {
> +                       if (!update)
> +                               return 0;
> +
> +                       err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, queu=
e,
> +                                                              ec->rx_coa=
lesce_usecs,
> +                                                              ec->rx_max=
_coalesced_frames);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>                                           struct ethtool_coalesce *ec,
>                                           u16 queue)
>  {
>         int err;
>
> -       err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
> -                                              ec->rx_coalesce_usecs,
> -                                              ec->rx_max_coalesced_frame=
s);
> +       err =3D virtnet_send_rx_notf_coal_vq_cmds(vi, ec, queue);
>         if (err)
>                 return err;
>
> @@ -3401,6 +3516,32 @@ static int virtnet_send_notf_coal_vq_cmds(struct v=
irtnet_info *vi,
>         return 0;
>  }
>
> +static void virtnet_rx_dim_work(struct work_struct *work)
> +{
> +       struct dim *dim =3D container_of(work, struct dim, work);
> +       struct receive_queue *rq =3D container_of(dim,
> +                       struct receive_queue, dim);
> +       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> +       struct net_device *dev =3D vi->dev;
> +       struct dim_cq_moder update_moder;
> +       int qnum =3D rq - vi->rq, err;
> +
> +       update_moder =3D net_dim_get_rx_moderation(dim->mode, dim->profil=
e_ix);
> +       if (update_moder.usec !=3D vi->rq[qnum].intr_coal.max_usecs ||
> +           update_moder.pkts !=3D vi->rq[qnum].intr_coal.max_packets) {
> +               rtnl_lock();
> +               err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> +                                                      update_moder.usec,
> +                                                      update_moder.pkts)=
;
> +               if (err)
> +                       pr_debug("%s: Failed to send dim parameters on rx=
q%d\n",
> +                                dev->name, (int)(rq - vi->rq));
> +               rtnl_unlock();
> +       }
> +
> +       dim->state =3D DIM_START_MEASURE;
> +}
> +
>  static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>  {
>         /* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
> @@ -3482,6 +3623,7 @@ static int virtnet_get_coalesce(struct net_device *=
dev,
>                 ec->tx_coalesce_usecs =3D vi->intr_coal_tx.max_usecs;
>                 ec->tx_max_coalesced_frames =3D vi->intr_coal_tx.max_pack=
ets;
>                 ec->rx_max_coalesced_frames =3D vi->intr_coal_rx.max_pack=
ets;
> +               ec->use_adaptive_rx_coalesce =3D vi->rx_dim_enabled;
>         } else {
>                 ec->rx_max_coalesced_frames =3D 1;
>
> @@ -3539,6 +3681,7 @@ static int virtnet_get_per_queue_coalesce(struct ne=
t_device *dev,
>                 ec->tx_coalesce_usecs =3D vi->sq[queue].intr_coal.max_use=
cs;
>                 ec->tx_max_coalesced_frames =3D vi->sq[queue].intr_coal.m=
ax_packets;
>                 ec->rx_max_coalesced_frames =3D vi->rq[queue].intr_coal.m=
ax_packets;
> +               ec->use_adaptive_rx_coalesce =3D vi->rq[queue].dim_enable=
d;
>         } else {
>                 ec->rx_max_coalesced_frames =3D 1;
>
> @@ -3664,7 +3807,7 @@ static int virtnet_set_rxnfc(struct net_device *dev=
, struct ethtool_rxnfc *info)
>
>  static const struct ethtool_ops virtnet_ethtool_ops =3D {
>         .supported_coalesce_params =3D ETHTOOL_COALESCE_MAX_FRAMES |
> -               ETHTOOL_COALESCE_USECS,
> +               ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX=
,
>         .get_drvinfo =3D virtnet_get_drvinfo,
>         .get_link =3D ethtool_op_get_link,
>         .get_ringparam =3D virtnet_get_ringparam,
> --
> 2.19.1.6.gb485710b
>


