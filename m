Return-Path: <netdev+bounces-44078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4167D6038
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EF51C20CBB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E801E2D60F;
	Wed, 25 Oct 2023 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE1EkOKY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6E1360
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 03:03:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFDE12A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698203027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKKjhvsSWhMqpvpb+aiRAAUVchPoyxR+kwr6ifqqgSk=;
	b=XE1EkOKYOtAXYGFLIp3r/dRtP6eOEn8GvKpshQNGyRmYQEuY/nOg3va/ONl166Cz/HFvST
	DUkriGHO/py6YeIkI4rKE3wPxCT8+ESJ/NScEWxv+DxaZs/GB+POZVOEesSyUSaRVyJxgi
	cZmI1WNuSo/5jyVdXMsNL7ZLjApG4h0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-jqjTlMViPt-vf9_oCB5uiw-1; Tue, 24 Oct 2023 23:03:45 -0400
X-MC-Unique: jqjTlMViPt-vf9_oCB5uiw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507d4583c4cso5114045e87.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698203024; x=1698807824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKKjhvsSWhMqpvpb+aiRAAUVchPoyxR+kwr6ifqqgSk=;
        b=Axm8RtPWz0HblzXryZzxKJaB0n0AX0oXi7TqjurspRdB5hoyHySgm6wpkYTJuhjncg
         fFYJc+0XqFZHtwV3/ppPgh8LLXuoBAINkPwZauwiKLph4SG09I2TxAyHG6xFX5YXbG+F
         CzTnTGhTLAWb+RmmpEiyIcbkboUJw8KkkSbzqTnFqS1duZnD9KtcoZD2LaqJ20Drh86F
         hJ5btPTnfP9tPYNZOL37+Zigllg8Lu/Je+OE5wlDSnTJ4JnVVC3y4e5HMJGP2gnnhUYm
         9k44Jvg7rautafM+eCYcNMqrY7eSmObxMH0CgNio3KKwUzZncEQgoK0q+IO92xK7zwT7
         WgPw==
X-Gm-Message-State: AOJu0YwTePYUyUHl30QTowEeoyImfLVLJI8p3KyJJU1fx45gyipgExUI
	Ss26QOCK7xLEZyvwi+aBkQCu/wKldsLTZrwkYPtu26S+8r58Tika07IqrOj+t6zCr2/qAwRwRJu
	OOCN+eSJhxm73n6pv473smYHLe/rb6u3k
X-Received: by 2002:ac2:5988:0:b0:507:9fc1:ca80 with SMTP id w8-20020ac25988000000b005079fc1ca80mr9512258lfn.54.1698203023926;
        Tue, 24 Oct 2023 20:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKDE0Oi+/yy+zs/e0Kltunvo1KOtGO2A6lFPtqtGjPmnZINAAFVwHMaR0smQAMJPXTo11rbwMtOnD9hX+5p4o=
X-Received: by 2002:ac2:5988:0:b0:507:9fc1:ca80 with SMTP id
 w8-20020ac25988000000b005079fc1ca80mr9512246lfn.54.1698203023561; Tue, 24 Oct
 2023 20:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com> <5b99db97dd4b26636f306f70c8158d9d3297b4a0.1697093455.git.hengqi@linux.alibaba.com>
In-Reply-To: <5b99db97dd4b26636f306f70c8158d9d3297b4a0.1697093455.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Oct 2023 11:03:32 +0800
Message-ID: <CACGkMEvjzGS1fthS93aV0QKX0maVjNtM43-CYJA5GSw30rEwDw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] virtio-net: extract virtqueue coalescig cmd
 for reuse
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
> Extract commands to set virtqueue coalescing parameters for reuse
> by ethtool -Q, vq resize and netdim.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 106 +++++++++++++++++++++++----------------
>  1 file changed, 64 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 54b3fb8d0384..caef78bb3963 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2846,6 +2846,58 @@ static void virtnet_cpu_notif_remove(struct virtne=
t_info *vi)
>                                             &vi->node_dead);
>  }
>
> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> +                                        u16 vqn, u32 max_usecs, u32 max_=
packets)
> +{
> +       struct scatterlist sgs;
> +
> +       vi->ctrl->coal_vq.vqn =3D cpu_to_le16(vqn);
> +       vi->ctrl->coal_vq.coal.max_usecs =3D cpu_to_le32(max_usecs);
> +       vi->ctrl->coal_vq.coal.max_packets =3D cpu_to_le32(max_packets);
> +       sg_init_one(&sgs, &vi->ctrl->coal_vq, sizeof(vi->ctrl->coal_vq));
> +
> +       if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +                                 VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> +                                 &sgs))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> +                                           u16 queue, u32 max_usecs,
> +                                           u32 max_packets)
> +{
> +       int err;
> +
> +       err =3D virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> +                                           max_usecs, max_packets);
> +       if (err)
> +               return err;
> +
> +       vi->rq[queue].intr_coal.max_usecs =3D max_usecs;
> +       vi->rq[queue].intr_coal.max_packets =3D max_packets;
> +
> +       return 0;
> +}
> +
> +static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> +                                           u16 queue, u32 max_usecs,
> +                                           u32 max_packets)
> +{
> +       int err;
> +
> +       err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> +                                           max_usecs, max_packets);
> +       if (err)
> +               return err;
> +
> +       vi->sq[queue].intr_coal.max_usecs =3D max_usecs;
> +       vi->sq[queue].intr_coal.max_packets =3D max_packets;
> +
> +       return 0;
> +}
> +
>  static void virtnet_get_ringparam(struct net_device *dev,
>                                   struct ethtool_ringparam *ring,
>                                   struct kernel_ethtool_ringparam *kernel=
_ring,
> @@ -2903,14 +2955,11 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
>                          * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET c=
ommand, or, if the driver
>                          * did not set any TX coalescing parameters, to 0=
.
>                          */
> -                       err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(=
i),
> -                                                           vi->intr_coal=
_tx.max_usecs,
> -                                                           vi->intr_coal=
_tx.max_packets);
> +                       err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> +                                                              vi->intr_c=
oal_tx.max_usecs,
> +                                                              vi->intr_c=
oal_tx.max_packets);
>                         if (err)
>                                 return err;
> -
> -                       vi->sq[i].intr_coal.max_usecs =3D vi->intr_coal_t=
x.max_usecs;
> -                       vi->sq[i].intr_coal.max_packets =3D vi->intr_coal=
_tx.max_packets;
>                 }
>
>                 if (ring->rx_pending !=3D rx_pending) {
> @@ -2919,14 +2968,11 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
>                                 return err;
>
>                         /* The reason is same as the transmit virtqueue r=
eset */
> -                       err =3D virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(=
i),
> -                                                           vi->intr_coal=
_rx.max_usecs,
> -                                                           vi->intr_coal=
_rx.max_packets);
> +                       err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> +                                                              vi->intr_c=
oal_rx.max_usecs,
> +                                                              vi->intr_c=
oal_rx.max_packets);
>                         if (err)
>                                 return err;
> -
> -                       vi->rq[i].intr_coal.max_usecs =3D vi->intr_coal_r=
x.max_usecs;
> -                       vi->rq[i].intr_coal.max_packets =3D vi->intr_coal=
_rx.max_packets;
>                 }
>         }
>
> @@ -3327,48 +3373,24 @@ static int virtnet_send_notf_coal_cmds(struct vir=
tnet_info *vi,
>         return 0;
>  }
>
> -static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> -                                        u16 vqn, u32 max_usecs, u32 max_=
packets)
> -{
> -       struct scatterlist sgs;
> -
> -       vi->ctrl->coal_vq.vqn =3D cpu_to_le16(vqn);
> -       vi->ctrl->coal_vq.coal.max_usecs =3D cpu_to_le32(max_usecs);
> -       vi->ctrl->coal_vq.coal.max_packets =3D cpu_to_le32(max_packets);
> -       sg_init_one(&sgs, &vi->ctrl->coal_vq, sizeof(vi->ctrl->coal_vq));
> -
> -       if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> -                                 VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> -                                 &sgs))
> -               return -EINVAL;
> -
> -       return 0;
> -}
> -
>  static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>                                           struct ethtool_coalesce *ec,
>                                           u16 queue)
>  {
>         int err;
>
> -       err =3D virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> -                                           ec->rx_coalesce_usecs,
> -                                           ec->rx_max_coalesced_frames);
> +       err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
> +                                              ec->rx_coalesce_usecs,
> +                                              ec->rx_max_coalesced_frame=
s);
>         if (err)
>                 return err;
>
> -       vi->rq[queue].intr_coal.max_usecs =3D ec->rx_coalesce_usecs;
> -       vi->rq[queue].intr_coal.max_packets =3D ec->rx_max_coalesced_fram=
es;
> -
> -       err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> -                                           ec->tx_coalesce_usecs,
> -                                           ec->tx_max_coalesced_frames);
> +       err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
> +                                              ec->tx_coalesce_usecs,
> +                                              ec->tx_max_coalesced_frame=
s);
>         if (err)
>                 return err;
>
> -       vi->sq[queue].intr_coal.max_usecs =3D ec->tx_coalesce_usecs;
> -       vi->sq[queue].intr_coal.max_packets =3D ec->tx_max_coalesced_fram=
es;
> -
>         return 0;
>  }
>
> --
> 2.19.1.6.gb485710b
>


