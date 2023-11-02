Return-Path: <netdev+bounces-45631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6927DEBD9
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454B1B20FE8
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 04:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F50510EF;
	Thu,  2 Nov 2023 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqM8gf85"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6F637
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:32:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B4812C
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 21:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698899525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nB/wHAK3uV7p8ELkBB2CJe0YD4hzDwf9L5yW8novGQ=;
	b=XqM8gf85IC6DfZpqtjUaXTptClf2276wXq/ZIvwg2CbT52MXs7LjAIeKQmRhrziTZRv4wY
	IT6z3rcciFaCxRhjd4Uqu7WAz/NWQqySLBrXmWVRA6y69+JtPnBGwSoVtG9OJqU/b5yM2C
	gBPJMyoy012rP0FMQn9j9jzULcU3m5g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-_yVq3a_pPIiFM8wuLbJDAw-1; Thu, 02 Nov 2023 00:32:03 -0400
X-MC-Unique: _yVq3a_pPIiFM8wuLbJDAw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-670991f8b5cso25755316d6.1
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 21:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698899523; x=1699504323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nB/wHAK3uV7p8ELkBB2CJe0YD4hzDwf9L5yW8novGQ=;
        b=UrY6yYr9bQOdYDWbKYBIAqGqC6LEVUUWJc1/A0rlVtAOriyq5BAdeeTXhUJ2yTtmLb
         b7MD2+gUd6pCFuE17PRim64NK5dffKQ2HGc/9XYyXCsrXPFe5Zo8TvXZRBEn23X1rLZ+
         hIONA1al/v/ozZJ6sz22RPCX3eeFBy4o1RaO3VbLqM8jCYvSImlqC3seaCuTlKg7XrK1
         OEnIlPk7Yc4GbfUB3h8Pq9HZo/8YoyOeMZDxG6cPe9vOeRnStt97rq7tFZfdUE8IuKdG
         twUsDJZ598+dnPIz+sdPglI+cq9fy2p2BXrwcfhIjjftwpTYKO9frLTvYVR7tAUCBm5I
         Hn9A==
X-Gm-Message-State: AOJu0Yx/eHoc91D8kzTcfrn+OYWE3oJZ3jNUXTSHP0MNqugYC4KwNynj
	l1he8RqEYSc7WXrUuoU5TYgIE1okwzWCLQJ0WC4B8FDjZ2h++OhSVPg2PgQ2VIqHrCXW+T/e77m
	JHaRjRwZAxfLIox3JO0ZAcwkFvkRDSfuc
X-Received: by 2002:a05:6214:1025:b0:66d:593f:9a4c with SMTP id k5-20020a056214102500b0066d593f9a4cmr10070431qvr.2.1698899523214;
        Wed, 01 Nov 2023 21:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9fEkVdifFYblVSFcFLGnD0KS4cGMxJf7rXRNphZKWo9W9+vy2djLOtEAWOhsttggQH4VVxfdDKoXD/cf7vBA=
X-Received: by 2002:a05:6214:1025:b0:66d:593f:9a4c with SMTP id
 k5-20020a056214102500b0066d593f9a4cmr10070408qvr.2.1698899522822; Wed, 01 Nov
 2023 21:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <b4656b1a14fea432bf8493a7e2f1976c08f2e63c.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEuwDxzw-tk0Lyj2yu57ivQwcuH1FqL8+q0Pk0r_ZdnUJg@mail.gmail.com> <3bc31a3b-a022-4816-a854-7f6b41d2e351@linux.alibaba.com>
In-Reply-To: <3bc31a3b-a022-4816-a854-7f6b41d2e351@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Nov 2023 12:31:48 +0800
Message-ID: <CACGkMEuL+ocjBasSAOvKZA7pzLganK9cwvtr-ErquMZBC0aNDw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] virtio-net: support rx netdim
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Liu, Yujie" <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 6:55=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
>
>
> =E5=9C=A8 2023/10/25 =E4=B8=8A=E5=8D=8811:34, Jason Wang =E5=86=99=E9=81=
=93:
> > On Thu, Oct 12, 2023 at 3:44=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >> By comparing the traffic information in the complete napi processes,
> >> let the virtio-net driver automatically adjust the coalescing
> >> moderation parameters of each receive queue.
> >>
> >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >> ---
> >>   drivers/net/virtio_net.c | 147 +++++++++++++++++++++++++++++++++----=
--
> >>   1 file changed, 126 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index caef78bb3963..6ad2890a7909 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -19,6 +19,7 @@
> >>   #include <linux/average.h>
> >>   #include <linux/filter.h>
> >>   #include <linux/kernel.h>
> >> +#include <linux/dim.h>
> >>   #include <net/route.h>
> >>   #include <net/xdp.h>
> >>   #include <net/net_failover.h>
> >> @@ -172,6 +173,17 @@ struct receive_queue {
> >>
> >>          struct virtnet_rq_stats stats;
> >>
> >> +       /* The number of rx notifications */
> >> +       u16 calls;
> >> +
> >> +       /* Is dynamic interrupt moderation enabled? */
> >> +       bool dim_enabled;
> >> +
> >> +       /* Dynamic Interrupt Moderation */
> >> +       struct dim dim;
> >> +
> >> +       u32 packets_in_napi;
> >> +
> >>          struct virtnet_interrupt_coalesce intr_coal;
> >>
> >>          /* Chain pages by the private ptr. */
> >> @@ -305,6 +317,9 @@ struct virtnet_info {
> >>          u8 duplex;
> >>          u32 speed;
> >>
> >> +       /* Is rx dynamic interrupt moderation enabled? */
> >> +       bool rx_dim_enabled;
> >> +
> >>          /* Interrupt coalescing settings */
> >>          struct virtnet_interrupt_coalesce intr_coal_tx;
> >>          struct virtnet_interrupt_coalesce intr_coal_rx;
> >> @@ -2001,6 +2016,7 @@ static void skb_recv_done(struct virtqueue *rvq)
> >>          struct virtnet_info *vi =3D rvq->vdev->priv;
> >>          struct receive_queue *rq =3D &vi->rq[vq2rxq(rvq)];
> >>
> >> +       rq->calls++;
> >>          virtqueue_napi_schedule(&rq->napi, rvq);
> >>   }
> >>
> >> @@ -2138,6 +2154,25 @@ static void virtnet_poll_cleantx(struct receive=
_queue *rq)
> >>          }
> >>   }
> >>
> >> +static void virtnet_rx_dim_work(struct work_struct *work);
> >> +
> >> +static void virtnet_rx_dim_update(struct virtnet_info *vi, struct rec=
eive_queue *rq)
> >> +{
> >> +       struct virtnet_rq_stats *stats =3D &rq->stats;
> >> +       struct dim_sample cur_sample =3D {};
> >> +
> >> +       if (!rq->packets_in_napi)
> >> +               return;
> >> +
> >> +       u64_stats_update_begin(&rq->stats.syncp);
> >> +       dim_update_sample(rq->calls, stats->packets,
> >> +                         stats->bytes, &cur_sample);
> >> +       u64_stats_update_end(&rq->stats.syncp);
> >> +
> >> +       net_dim(&rq->dim, cur_sample);
> >> +       rq->packets_in_napi =3D 0;
> >> +}
> >> +
> >>   static int virtnet_poll(struct napi_struct *napi, int budget)
> >>   {
> >>          struct receive_queue *rq =3D
> >> @@ -2146,17 +2181,22 @@ static int virtnet_poll(struct napi_struct *na=
pi, int budget)
> >>          struct send_queue *sq;
> >>          unsigned int received;
> >>          unsigned int xdp_xmit =3D 0;
> >> +       bool napi_complete;
> >>
> >>          virtnet_poll_cleantx(rq);
> >>
> >>          received =3D virtnet_receive(rq, budget, &xdp_xmit);
> >> +       rq->packets_in_napi +=3D received;
> >>
> >>          if (xdp_xmit & VIRTIO_XDP_REDIR)
> >>                  xdp_do_flush();
> >>
> >>          /* Out of packets? */
> >> -       if (received < budget)
> >> -               virtqueue_napi_complete(napi, rq->vq, received);
> >> +       if (received < budget) {
> >> +               napi_complete =3D virtqueue_napi_complete(napi, rq->vq=
, received);
> >> +               if (napi_complete && rq->dim_enabled)
> >> +                       virtnet_rx_dim_update(vi, rq);
> >> +       }
> >>
> >>          if (xdp_xmit & VIRTIO_XDP_TX) {
> >>                  sq =3D virtnet_xdp_get_sq(vi);
> >> @@ -2176,6 +2216,7 @@ static void virtnet_disable_queue_pair(struct vi=
rtnet_info *vi, int qp_index)
> >>          virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> >>          napi_disable(&vi->rq[qp_index].napi);
> >>          xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> >> +       cancel_work_sync(&vi->rq[qp_index].dim.work);
> >>   }
> >>
> >>   static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp=
_index)
> >> @@ -2193,6 +2234,9 @@ static int virtnet_enable_queue_pair(struct virt=
net_info *vi, int qp_index)
> >>          if (err < 0)
> >>                  goto err_xdp_reg_mem_model;
> >>
> >> +       INIT_WORK(&vi->rq[qp_index].dim.work, virtnet_rx_dim_work);
> >> +       vi->rq[qp_index].dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQ=
E;
> >> +
> >>          virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].na=
pi);
> >>          virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_in=
dex].napi);
> >>
> >> @@ -3335,23 +3379,42 @@ static int virtnet_send_tx_notf_coal_cmds(stru=
ct virtnet_info *vi,
> >>   static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> >>                                            struct ethtool_coalesce *ec=
)
> >>   {
> >> +       bool rx_ctrl_dim_on =3D !!ec->use_adaptive_rx_coalesce;
> >>          struct scatterlist sgs_rx;
> >> +       int i;
> >>
> >> -       vi->ctrl->coal_rx.rx_usecs =3D cpu_to_le32(ec->rx_coalesce_use=
cs);
> >> -       vi->ctrl->coal_rx.rx_max_packets =3D cpu_to_le32(ec->rx_max_co=
alesced_frames);
> >> -       sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal=
_rx));
> >> -
> >> -       if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> >> -                                 VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> >> -                                 &sgs_rx))
> >> +       if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs !=3D vi->intr_coa=
l_rx.max_usecs ||
> >> +                              ec->rx_max_coalesced_frames !=3D vi->in=
tr_coal_rx.max_packets))
> > Any reason we need to stick a check for usecs/packets? I think it
> > might confuse the user since the value could be modified by netdim
> > actually.
>
> Yes, that's exactly what's done here.
>
> When dim is enabled, the user is prohibited from manually configuring
> parameters because dim may modify the parameters.

So it should be something like

if (rx_ctrl_dim_on)
      return -EINVAL;

without the checking of whether it matches the current parameters?

>
> >
> >>                  return -EINVAL;
> >>
> >> -       /* Save parameters */
> >> -       vi->intr_coal_rx.max_usecs =3D ec->rx_coalesce_usecs;
> >> -       vi->intr_coal_rx.max_packets =3D ec->rx_max_coalesced_frames;
> >> -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >> -               vi->rq[i].intr_coal.max_usecs =3D ec->rx_coalesce_usec=
s;
> >> -               vi->rq[i].intr_coal.max_packets =3D ec->rx_max_coalesc=
ed_frames;
> >> +       if (rx_ctrl_dim_on) {
> >> +               if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_=
COAL)) {
> >> +                       vi->rx_dim_enabled =3D true;
> >> +                       for (i =3D 0; i < vi->max_queue_pairs; i++)
> >> +                               vi->rq[i].dim_enabled =3D true;
> >> +               } else {
> >> +                       return -EOPNOTSUPP;
> >> +               }
> >> +       } else {
> >> +               vi->rx_dim_enabled =3D false;
> >> +               for (i =3D 0; i < vi->max_queue_pairs; i++)
> >> +                       vi->rq[i].dim_enabled =3D false;
> >> +
> >> +               vi->ctrl->coal_rx.rx_usecs =3D cpu_to_le32(ec->rx_coal=
esce_usecs);
> >> +               vi->ctrl->coal_rx.rx_max_packets =3D cpu_to_le32(ec->r=
x_max_coalesced_frames);
> >> +               sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ct=
rl->coal_rx));
> >> +
> >> +               if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COA=
L,
> >> +                                         VIRTIO_NET_CTRL_NOTF_COAL_RX=
_SET,
> >> +                                         &sgs_rx))
> >> +                       return -EINVAL;
> >> +
> >> +               vi->intr_coal_rx.max_usecs =3D ec->rx_coalesce_usecs;
> >> +               vi->intr_coal_rx.max_packets =3D ec->rx_max_coalesced_=
frames;
> >> +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >> +                       vi->rq[i].intr_coal.max_usecs =3D ec->rx_coale=
sce_usecs;
> >> +                       vi->rq[i].intr_coal.max_packets =3D ec->rx_max=
_coalesced_frames;
> >> +               }
> >>          }
> >>
> >>          return 0;
> >> @@ -3377,13 +3440,27 @@ static int virtnet_send_notf_coal_vq_cmds(stru=
ct virtnet_info *vi,
> >>                                            struct ethtool_coalesce *ec=
,
> >>                                            u16 queue)
> >>   {
> >> +       bool rx_ctrl_dim_on;
> >> +       u32 max_usecs, max_packets;
> >>          int err;
> >>
> >> -       err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
> >> -                                              ec->rx_coalesce_usecs,
> >> -                                              ec->rx_max_coalesced_fr=
ames);
> >> -       if (err)
> >> -               return err;
> >> +       rx_ctrl_dim_on =3D !!ec->use_adaptive_rx_coalesce;
> >> +       max_usecs =3D vi->rq[queue].intr_coal.max_usecs;
> >> +       max_packets =3D vi->rq[queue].intr_coal.max_packets;
> >> +       if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs !=3D max_usecs ||
> >> +                              ec->rx_max_coalesced_frames !=3D max_pa=
ckets))
> >> +               return -EINVAL;
> >> +
> >> +       if (rx_ctrl_dim_on) {
> >> +               vi->rq[queue].dim_enabled =3D true;
> >> +       } else {
> >> +               vi->rq[queue].dim_enabled =3D false;
> >> +               err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
> >> +                                                      ec->rx_coalesce=
_usecs,
> >> +                                                      ec->rx_max_coal=
esced_frames);
> >> +               if (err)
> >> +                       return err;
> >> +       }
> >>
> >>          err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
> >>                                                 ec->tx_coalesce_usecs,
> >> @@ -3394,6 +3471,32 @@ static int virtnet_send_notf_coal_vq_cmds(struc=
t virtnet_info *vi,
> >>          return 0;
> >>   }
> >>
> >> +static void virtnet_rx_dim_work(struct work_struct *work)
> >> +{
> >> +       struct dim *dim =3D container_of(work, struct dim, work);
> >> +       struct receive_queue *rq =3D container_of(dim,
> >> +                       struct receive_queue, dim);
> >> +       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> >> +       struct net_device *dev =3D vi->dev;
> >> +       struct dim_cq_moder update_moder;
> >> +       int qnum =3D rq - vi->rq, err;
> >> +
> >> +       update_moder =3D net_dim_get_rx_moderation(dim->mode, dim->pro=
file_ix);
> >> +       if (update_moder.usec !=3D vi->rq[qnum].intr_coal.max_usecs ||
> >> +           update_moder.pkts !=3D vi->rq[qnum].intr_coal.max_packets)=
 {
> > Is this safe across the e.g vq reset?
>
> I think it might. This will be avoided in the next version using:
> 1. cancel virtnet_rx_dim_work before vq reset.
> 2. restore virtnet_rx_dim_work after vq re-enable.

Ok.

Thanks

>
> Thanks a lot!
>
> >
> > Thanks
> >
> >> +               rtnl_lock();
> >> +               err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> >> +                                                      update_moder.us=
ec,
> >> +                                                      update_moder.pk=
ts);
> >> +               if (err)
> >> +                       pr_debug("%s: Failed to send dim parameters on=
 rxq%d\n",
> >> +                                dev->name, (int)(rq - vi->rq));
> >> +               rtnl_unlock();
> >> +       }
> >> +
> >> +       dim->state =3D DIM_START_MEASURE;
> >> +}
> >> +
> >>   static int virtnet_coal_params_supported(struct ethtool_coalesce *ec=
)
> >>   {
> >>          /* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_CO=
AL
> >> @@ -3475,6 +3578,7 @@ static int virtnet_get_coalesce(struct net_devic=
e *dev,
> >>                  ec->tx_coalesce_usecs =3D vi->intr_coal_tx.max_usecs;
> >>                  ec->tx_max_coalesced_frames =3D vi->intr_coal_tx.max_=
packets;
> >>                  ec->rx_max_coalesced_frames =3D vi->intr_coal_rx.max_=
packets;
> >> +               ec->use_adaptive_rx_coalesce =3D vi->rx_dim_enabled;
> >>          } else {
> >>                  ec->rx_max_coalesced_frames =3D 1;
> >>
> >> @@ -3532,6 +3636,7 @@ static int virtnet_get_per_queue_coalesce(struct=
 net_device *dev,
> >>                  ec->tx_coalesce_usecs =3D vi->sq[queue].intr_coal.max=
_usecs;
> >>                  ec->tx_max_coalesced_frames =3D vi->sq[queue].intr_co=
al.max_packets;
> >>                  ec->rx_max_coalesced_frames =3D vi->rq[queue].intr_co=
al.max_packets;
> >> +               ec->use_adaptive_rx_coalesce =3D vi->rq[queue].dim_ena=
bled;
> >>          } else {
> >>                  ec->rx_max_coalesced_frames =3D 1;
> >>
> >> @@ -3657,7 +3762,7 @@ static int virtnet_set_rxnfc(struct net_device *=
dev, struct ethtool_rxnfc *info)
> >>
> >>   static const struct ethtool_ops virtnet_ethtool_ops =3D {
> >>          .supported_coalesce_params =3D ETHTOOL_COALESCE_MAX_FRAMES |
> >> -               ETHTOOL_COALESCE_USECS,
> >> +               ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE=
_RX,
> >>          .get_drvinfo =3D virtnet_get_drvinfo,
> >>          .get_link =3D ethtool_op_get_link,
> >>          .get_ringparam =3D virtnet_get_ringparam,
> >> --
> >> 2.19.1.6.gb485710b
> >>
>


