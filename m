Return-Path: <netdev+bounces-49924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A57F3DC3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 06:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33391C20CED
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3C13AD4;
	Wed, 22 Nov 2023 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTCNlcCX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773B98
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 21:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700632363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuZrs5sPpe/6yXla/iuOGbo05Emc2jKyb7+UzJYK5S4=;
	b=YTCNlcCXizjq//3mn3ZEhMEjejl4HhEJ4HkVHwKazUZNg2xSt1r1iS3DzAcbzKFwEZOSYv
	PIrZFNY2Go7eLLnnejgB0zAGYDCmiQDg1rCJiCz+GiXw2TyuMsed5ywr3uqyZPmno3vNjM
	Hx+XscEXkR3a0OznndUqjvSf1PW5ulk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-tEcNDkHGPdKYPbpnnlYDWg-1; Wed, 22 Nov 2023 00:52:42 -0500
X-MC-Unique: tEcNDkHGPdKYPbpnnlYDWg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50aa7e5bd0aso4007117e87.0
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 21:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700632361; x=1701237161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuZrs5sPpe/6yXla/iuOGbo05Emc2jKyb7+UzJYK5S4=;
        b=H2AaqAw/ki7PcmAhxia+3v70AE2umMevaxTwGuHLpcWG6nr7xki6aojIpIaWWYq0sx
         K3bmoLY2p/p6Ly0tLEoIGixlxzLNAdh89Eo4p/K4lHWnzq9xf+Im1CptdleBgfORw11D
         j6kCZwr7zsv3+DH+z7QJsuCCDwZqmBcyvEJ4jExpfErAEcPQvbQqaz66Bg5zQcZUyrf6
         kTGnS1jRZzj+ZmzN1h2G6M7BY6ZVAqRmlq+19hWLKZtdVsY1JIVDHQcSmtrgA2sIizII
         naHvrUOd/kQaRoBGNxBMvVlsnb0zg9VuwabkvBFGQ00M8XOOyKiPlQy/0Q5nOjPfNki7
         aybw==
X-Gm-Message-State: AOJu0YyCCtgzI7B5W+y5vsRDSaCDtwhCsxtILGRw2YRhluwzOFVoMwxx
	PHPBIhJKK0gnbLKfKaaEhXhj9ZePPQdl4gStCIW39H0BeEjWHvTW/WdDOtf7B4YI1w0BZw+nTQW
	d8T/3V4NFZmbdxwvaOivYuO+wWXT+ODeP
X-Received: by 2002:a05:6512:1243:b0:500:d970:6541 with SMTP id fb3-20020a056512124300b00500d9706541mr766726lfb.39.1700632360797;
        Tue, 21 Nov 2023 21:52:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlZIaJItQ/RE9ivbyz4bVkXdmNolp7OHPC7U2Amr3d9s33yvOvMffhqtzGZ4YTDfwQ96dTW8prr2aw8+b2iEY=
X-Received: by 2002:a05:6512:1243:b0:500:d970:6541 with SMTP id
 fb3-20020a056512124300b00500d9706541mr766709lfb.39.1700632360451; Tue, 21 Nov
 2023 21:52:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700478183.git.hengqi@linux.alibaba.com> <c00b526f32d9f9a5cd2e98a212ee5306d6b6d71c.1700478183.git.hengqi@linux.alibaba.com>
In-Reply-To: <c00b526f32d9f9a5cd2e98a212ee5306d6b6d71c.1700478183.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Nov 2023 13:52:29 +0800
Message-ID: <CACGkMEtt-Anog6gS1YvKi2Bt+Q32BnQEtY7E-wLWJwKjRMTUrA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] virtio-net: support rx netdim
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	mst@redhat.com, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com, 
	ast@kernel.org, horms@kernel.org, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 8:38=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> By comparing the traffic information in the complete napi processes,
> let the virtio-net driver automatically adjust the coalescing
> moderation parameters of each receive queue.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
> v2->v3:
> - Some minor modifications.
>
> v1->v2:
> - Improved the judgment of dim switch conditions.
> - Cancel the work when vq reset.
>
>  drivers/net/virtio_net.c | 191 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 169 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 69fe09e99b3c..bc32d5aae005 100644
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
> +       vi->rq[qp_index].dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQE;

So in V2, you explained it can be done here but I want to know why it
must be done here.

For example, the refill_work is initialized in alloc_queues().

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
> @@ -3341,24 +3390,55 @@ static int virtnet_send_tx_notf_coal_cmds(struct =
virtnet_info *vi,
>  static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>                                           struct ethtool_coalesce *ec)
>  {
> +       bool rx_ctrl_dim_on =3D !!ec->use_adaptive_rx_coalesce;
> +       bool update =3D false, switch_dim;
>         struct scatterlist sgs_rx;
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

So basically, I'm asking why we need to duplicate the check here?

E.g caller has done the check for us:

        if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
                ret =3D virtnet_send_notf_coal_cmds(vi, ec);
        else
                ret =3D virtnet_coal_params_supported(ec);

?

Please also check other nested if/else, usually, too many levels of
nesting is a hint that the logic needs to be optimized.

Thanks


