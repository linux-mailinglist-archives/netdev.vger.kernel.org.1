Return-Path: <netdev+bounces-46749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E677B7E62C7
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 05:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD5D1C20846
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 04:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523D45C89;
	Thu,  9 Nov 2023 04:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpCB7I33"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4C611F
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 04:19:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E412580
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 20:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699503549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvFRg1ozX36hxCbAKKGm/5hTz3pL2jXDwI2xdrZTOrY=;
	b=bpCB7I335J1JUnUEobSWcpvtzO5P76rRwV500RU/96WGOUkuDR7Pv6L12A+tyWhNm0kLYm
	/R+Bwt6JcORzw/UdZz+JgxK6J1SRuzsx1FiXmOaLgkW85blZaa1Tl6qvNmDMRiYb78nf37
	mXwIPE2Vk0ChR0UM3cFW51URe6lSfpY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-9GiF1jpAMRaCb-rjQJnlCg-1; Wed, 08 Nov 2023 23:19:06 -0500
X-MC-Unique: 9GiF1jpAMRaCb-rjQJnlCg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507c4c57567so396656e87.0
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 20:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699503545; x=1700108345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvFRg1ozX36hxCbAKKGm/5hTz3pL2jXDwI2xdrZTOrY=;
        b=BYuHyCaQ57SSoX8RnvD3tI2jPnYxqDdptZn2vzIezPed+cDiFFIOqi9DLP7jkE3QOE
         eoUlbieDcO+JbJCPvaNNF67bfZuprX6SGtaOD5yyB7+Ot+hhvV5Y4jAWtDsSHIJJZCbn
         07o/bwTeKCL1L8ks3VNQzEAXYJUSSaFF81f82QORUOYZZW8RjTi4RttjWUPL43RBRsF0
         Yk+CZ+2rmA5m1RIuC9WgNcdYzmW1kDqfgDg8v7K+kJeIKYrdbhwJYUmVvfebwuSW6YLo
         GGN1MxbS52QRrEif9/umcBweF1yCQPjxieK+MBOs1ROBpqu5L1MbDBcSdLFqmICjisHc
         6X4A==
X-Gm-Message-State: AOJu0Yz9SvnxTSjO0Z4mYsS+LJB+To22RjoDVjoPlP9SEseNjW3Rdeas
	psQLuafnG9xdnLaWQ3M1ag5MIOw6jzjJmFucbybMjfAoeN5xUTOZTcXAEAr5MFtUPydBM9K/XJC
	Sp78lM+MEW5ljkIr1QyF31WlAzS7QdHlY
X-Received: by 2002:a19:f81a:0:b0:500:9f7b:e6a4 with SMTP id a26-20020a19f81a000000b005009f7be6a4mr406457lff.32.1699503545316;
        Wed, 08 Nov 2023 20:19:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEna4e4m+nuJ6m9UCRfwD82ztP57+PYWew/vMSloocMkgV1HqDEFZ2nPbc+nONZVgQ8+jfAMBYtWw38iK4mxn8=
X-Received: by 2002:a19:f81a:0:b0:500:9f7b:e6a4 with SMTP id
 a26-20020a19f81a000000b005009f7be6a4mr406443lff.32.1699503544910; Wed, 08 Nov
 2023 20:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698929590.git.hengqi@linux.alibaba.com> <a8dd10692a8291029afe283808a5b9051e1400b5.1698929590.git.hengqi@linux.alibaba.com>
In-Reply-To: <a8dd10692a8291029afe283808a5b9051e1400b5.1698929590.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 12:18:53 +0800
Message-ID: <CACGkMEsgJ_MO2cQh18sJjTRUWrWzsX7DgOSHs8GsdeiZY+OjWw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] virtio-net: separate rx/tx coalescing
 moderation cmds
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
> This patch separates the rx and tx global coalescing moderation
> commands to support netdim switches in subsequent patches.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v1->v2:
> - Add 'i' definition.
>
>  drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0ad2894e6a5e..0285301caf78 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3266,10 +3266,10 @@ static int virtnet_get_link_ksettings(struct net_=
device *dev,
>         return 0;
>  }
>
> -static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
> -                                      struct ethtool_coalesce *ec)
> +static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
> +                                         struct ethtool_coalesce *ec)
>  {
> -       struct scatterlist sgs_tx, sgs_rx;
> +       struct scatterlist sgs_tx;
>         int i;
>
>         vi->ctrl->coal_tx.tx_usecs =3D cpu_to_le32(ec->tx_coalesce_usecs)=
;
> @@ -3289,6 +3289,15 @@ static int virtnet_send_notf_coal_cmds(struct virt=
net_info *vi,
>                 vi->sq[i].intr_coal.max_packets =3D ec->tx_max_coalesced_=
frames;
>         }
>
> +       return 0;
> +}
> +
> +static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> +                                         struct ethtool_coalesce *ec)
> +{
> +       struct scatterlist sgs_rx;
> +       int i;
> +
>         vi->ctrl->coal_rx.rx_usecs =3D cpu_to_le32(ec->rx_coalesce_usecs)=
;
>         vi->ctrl->coal_rx.rx_max_packets =3D cpu_to_le32(ec->rx_max_coale=
sced_frames);
>         sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx=
));
> @@ -3309,6 +3318,22 @@ static int virtnet_send_notf_coal_cmds(struct virt=
net_info *vi,
>         return 0;
>  }
>
> +static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
> +                                      struct ethtool_coalesce *ec)
> +{
> +       int err;
> +
> +       err =3D virtnet_send_tx_notf_coal_cmds(vi, ec);
> +       if (err)
> +               return err;
> +
> +       err =3D virtnet_send_rx_notf_coal_cmds(vi, ec);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
>  static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>                                          u16 vqn, u32 max_usecs, u32 max_=
packets)
>  {
> --
> 2.19.1.6.gb485710b
>
>


