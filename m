Return-Path: <netdev+bounces-44084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28AC7D608D
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FF72817B2
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9F5252;
	Wed, 25 Oct 2023 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWlT/3RU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67D1FD9
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 03:34:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E429AF
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698204894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jV9Cbwzs0UchjggOv0LO2UVRRsI350HRhA3zKeoJhbQ=;
	b=hWlT/3RUiavAnkJtP41kB8rpWWrZRzgyK+Y/ddQVmd0mVwZWijRbd/PavNZDmDcI82GtZO
	DJgcbXdrlu2d4xg37gyLnFnq20xcZR1e72W5MISokPdKKBHnV9ybi4KKxcl2PJ6yaQ6THb
	5uJbibGIInD4XARxcn+eUj42xZv+B/8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-P0-CTgg2N5qoW4zhV9ZDRg-1; Tue, 24 Oct 2023 23:34:51 -0400
X-MC-Unique: P0-CTgg2N5qoW4zhV9ZDRg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507ee71fc4eso3673558e87.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698204890; x=1698809690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV9Cbwzs0UchjggOv0LO2UVRRsI350HRhA3zKeoJhbQ=;
        b=Z24aCz5F8znB4tw3siRh1jpEryta2Vz0ktbOea5JS97RMruSSUBJxAV1tPwpOLAyHh
         FvBVXgPprOZu+jVQgoS6v17cXC1p9sT2O+7F/lUVEI3vD+MdZ3DPV3c3tardGBcRBllb
         qgg2ZQcNBt34MJwQohLv8ZNSP9OyGbKel+qv5nzZNH2fYEu0GqxK1J+vpq9KZn4GFLLB
         wOa5LsBC+KLPr9Z+g1Mfi9Ea8zGGkyGdKFH8mZC+GE40cmNcfZW6NEr1nqTuc9kHzht/
         qBQa4o8sx5MSvXOMLe61RNNdvDmHPWBKJ/Se/bpZGuwOQ7eP2JGxE9h5yCva4gTq4bhr
         EthQ==
X-Gm-Message-State: AOJu0YwAzPLDOPfmvlTRKE31u6Ci/G6iGBOq5gIkw/6U1QTmMJFLVoyQ
	fAWRZv92VjBs1CKA63h1KP2NwtpTxS1wiYFwADZ6tLsM++Gm9M1Ft2P71PdaNWCelspK0tb2W50
	W7Y6isqZd5SAyosBB3Fxa6hRqfXDrSzBE
X-Received: by 2002:a05:6512:3b87:b0:507:974d:80f9 with SMTP id g7-20020a0565123b8700b00507974d80f9mr12301895lfv.34.1698204890426;
        Tue, 24 Oct 2023 20:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmnUXIIHZmI+cO5PGXG/fuC4Fj8OGtPYechDqUrYX9b3v5tayc0GsGSGuqULZyrersc9s6/VXaHQpUFDn0/lU=
X-Received: by 2002:a05:6512:3b87:b0:507:974d:80f9 with SMTP id
 g7-20020a0565123b8700b00507974d80f9mr12301880lfv.34.1698204890041; Tue, 24
 Oct 2023 20:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com> <b4656b1a14fea432bf8493a7e2f1976c08f2e63c.1697093455.git.hengqi@linux.alibaba.com>
In-Reply-To: <b4656b1a14fea432bf8493a7e2f1976c08f2e63c.1697093455.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Oct 2023 11:34:38 +0800
Message-ID: <CACGkMEuwDxzw-tk0Lyj2yu57ivQwcuH1FqL8+q0Pk0r_ZdnUJg@mail.gmail.com>
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

On Thu, Oct 12, 2023 at 3:44=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> By comparing the traffic information in the complete napi processes,
> let the virtio-net driver automatically adjust the coalescing
> moderation parameters of each receive queue.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 147 +++++++++++++++++++++++++++++++++------
>  1 file changed, 126 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index caef78bb3963..6ad2890a7909 100644
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
> @@ -2138,6 +2154,25 @@ static void virtnet_poll_cleantx(struct receive_qu=
eue *rq)
>         }
>  }
>
> +static void virtnet_rx_dim_work(struct work_struct *work);
> +
> +static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receiv=
e_queue *rq)
> +{
> +       struct virtnet_rq_stats *stats =3D &rq->stats;
> +       struct dim_sample cur_sample =3D {};
> +
> +       if (!rq->packets_in_napi)
> +               return;
> +
> +       u64_stats_update_begin(&rq->stats.syncp);
> +       dim_update_sample(rq->calls, stats->packets,
> +                         stats->bytes, &cur_sample);
> +       u64_stats_update_end(&rq->stats.syncp);
> +
> +       net_dim(&rq->dim, cur_sample);
> +       rq->packets_in_napi =3D 0;
> +}
> +
>  static int virtnet_poll(struct napi_struct *napi, int budget)
>  {
>         struct receive_queue *rq =3D
> @@ -2146,17 +2181,22 @@ static int virtnet_poll(struct napi_struct *napi,=
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
> @@ -2176,6 +2216,7 @@ static void virtnet_disable_queue_pair(struct virtn=
et_info *vi, int qp_index)
>         virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
>         napi_disable(&vi->rq[qp_index].napi);
>         xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> +       cancel_work_sync(&vi->rq[qp_index].dim.work);
>  }
>
>  static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_ind=
ex)
> @@ -2193,6 +2234,9 @@ static int virtnet_enable_queue_pair(struct virtnet=
_info *vi, int qp_index)
>         if (err < 0)
>                 goto err_xdp_reg_mem_model;
>
> +       INIT_WORK(&vi->rq[qp_index].dim.work, virtnet_rx_dim_work);
> +       vi->rq[qp_index].dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQE;
> +
>         virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>         virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index]=
.napi);
>
> @@ -3335,23 +3379,42 @@ static int virtnet_send_tx_notf_coal_cmds(struct =
virtnet_info *vi,
>  static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>                                           struct ethtool_coalesce *ec)
>  {
> +       bool rx_ctrl_dim_on =3D !!ec->use_adaptive_rx_coalesce;
>         struct scatterlist sgs_rx;
> +       int i;
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
> +       if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs !=3D vi->intr_coal_r=
x.max_usecs ||
> +                              ec->rx_max_coalesced_frames !=3D vi->intr_=
coal_rx.max_packets))

Any reason we need to stick a check for usecs/packets? I think it
might confuse the user since the value could be modified by netdim
actually.

>                 return -EINVAL;
>
> -       /* Save parameters */
> -       vi->intr_coal_rx.max_usecs =3D ec->rx_coalesce_usecs;
> -       vi->intr_coal_rx.max_packets =3D ec->rx_max_coalesced_frames;
> -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               vi->rq[i].intr_coal.max_usecs =3D ec->rx_coalesce_usecs;
> -               vi->rq[i].intr_coal.max_packets =3D ec->rx_max_coalesced_=
frames;
> +       if (rx_ctrl_dim_on) {
> +               if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COA=
L)) {
> +                       vi->rx_dim_enabled =3D true;
> +                       for (i =3D 0; i < vi->max_queue_pairs; i++)
> +                               vi->rq[i].dim_enabled =3D true;
> +               } else {
> +                       return -EOPNOTSUPP;
> +               }
> +       } else {
> +               vi->rx_dim_enabled =3D false;
> +               for (i =3D 0; i < vi->max_queue_pairs; i++)
> +                       vi->rq[i].dim_enabled =3D false;
> +
> +               vi->ctrl->coal_rx.rx_usecs =3D cpu_to_le32(ec->rx_coalesc=
e_usecs);
> +               vi->ctrl->coal_rx.rx_max_packets =3D cpu_to_le32(ec->rx_m=
ax_coalesced_frames);
> +               sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl-=
>coal_rx));
> +
> +               if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +                                         VIRTIO_NET_CTRL_NOTF_COAL_RX_SE=
T,
> +                                         &sgs_rx))
> +                       return -EINVAL;
> +
> +               vi->intr_coal_rx.max_usecs =3D ec->rx_coalesce_usecs;
> +               vi->intr_coal_rx.max_packets =3D ec->rx_max_coalesced_fra=
mes;
> +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       vi->rq[i].intr_coal.max_usecs =3D ec->rx_coalesce=
_usecs;
> +                       vi->rq[i].intr_coal.max_packets =3D ec->rx_max_co=
alesced_frames;
> +               }
>         }
>
>         return 0;
> @@ -3377,13 +3440,27 @@ static int virtnet_send_notf_coal_vq_cmds(struct =
virtnet_info *vi,
>                                           struct ethtool_coalesce *ec,
>                                           u16 queue)
>  {
> +       bool rx_ctrl_dim_on;
> +       u32 max_usecs, max_packets;
>         int err;
>
> -       err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
> -                                              ec->rx_coalesce_usecs,
> -                                              ec->rx_max_coalesced_frame=
s);
> -       if (err)
> -               return err;
> +       rx_ctrl_dim_on =3D !!ec->use_adaptive_rx_coalesce;
> +       max_usecs =3D vi->rq[queue].intr_coal.max_usecs;
> +       max_packets =3D vi->rq[queue].intr_coal.max_packets;
> +       if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs !=3D max_usecs ||
> +                              ec->rx_max_coalesced_frames !=3D max_packe=
ts))
> +               return -EINVAL;
> +
> +       if (rx_ctrl_dim_on) {
> +               vi->rq[queue].dim_enabled =3D true;
> +       } else {
> +               vi->rq[queue].dim_enabled =3D false;
> +               err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
> +                                                      ec->rx_coalesce_us=
ecs,
> +                                                      ec->rx_max_coalesc=
ed_frames);
> +               if (err)
> +                       return err;
> +       }
>
>         err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
>                                                ec->tx_coalesce_usecs,
> @@ -3394,6 +3471,32 @@ static int virtnet_send_notf_coal_vq_cmds(struct v=
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

Is this safe across the e.g vq reset?

Thanks

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
> @@ -3475,6 +3578,7 @@ static int virtnet_get_coalesce(struct net_device *=
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
> @@ -3532,6 +3636,7 @@ static int virtnet_get_per_queue_coalesce(struct ne=
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
> @@ -3657,7 +3762,7 @@ static int virtnet_set_rxnfc(struct net_device *dev=
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


