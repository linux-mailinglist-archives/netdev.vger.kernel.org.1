Return-Path: <netdev+bounces-46751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814047E62EB
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 05:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E162BB20EC5
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 04:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CCCA57;
	Thu,  9 Nov 2023 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMEk1Saw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E65685
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 04:45:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4D626A0
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 20:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699505149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nh+OheXPRInxC2fw6E13xlQ+H/XwSKIUTWgl8w4QNlA=;
	b=PMEk1SawXxsEIyajHdcGKeqiL8cPhL1KTcLOlv2cn3+qfS3RG9cRY0B8Tzy5XNB97UYGE9
	yz0Ga8+wBD8FlHXgqS2s/4xNNKlkkNcffQ6ZbwBaOzbiVJ058tznrKJuzx12Y8nRFjDckC
	oHn4l8Xhi+VSAMyiS2KTq7OIqNATshI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-jIZB3OlvNey2BWOek99xOA-1; Wed, 08 Nov 2023 23:45:48 -0500
X-MC-Unique: jIZB3OlvNey2BWOek99xOA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5098fc17ac5so84375e87.1
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 20:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699505147; x=1700109947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nh+OheXPRInxC2fw6E13xlQ+H/XwSKIUTWgl8w4QNlA=;
        b=A749UNQ0kFRyWZLiEc49PJRUNBfpvwVqmUNUgLnNejTGFyNtZaJFIB7zk3Ag9zYdue
         /PL+swwCUKIf+hEa+buckl2qs1LTl5y3glkgxo8p2XtgdTxcGFrflIEYHZtzzZJ/c5aX
         oU3BjQIP85jXUYWMAlf27rIygmbEMArAI6fvwhj5bWPiGS+Z10yRYXhFt7S36HuSUszl
         3t1C58FokYwzSktsLNeM1NWS/6Phy6foApsVs+puKBno45vonZjrat5VEmrETEtUYjj1
         BfjfMePRoQZjUjICO6sKr6oC45NEVfiA41wIN/8sWWIWkrEr4yeuUeY1ebRY6hKVDUBb
         bMsw==
X-Gm-Message-State: AOJu0YwhpO73bomHBzuBcADU6Mw781+87uf0lAsmFPy1BwEeINxDf1TN
	TiIJtpbsyCJbJ9fwJHjHr6mdJEci+iCQ4DbpJf7rAkV/5kXmuDl/YpdAUJUz7DQqzmnQcDHv0eb
	2D4T+tZOR5ZVhOduNt+tKnxVESKrpv79C
X-Received: by 2002:a05:6512:24a:b0:507:9a05:1aed with SMTP id b10-20020a056512024a00b005079a051aedmr422522lfo.4.1699505146975;
        Wed, 08 Nov 2023 20:45:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGQMnknnnttfvBSMewmasPT2BjoSrq4FLu8yWvCTCIlglMuIJ7gAhwUlxK5SUgFrDof+u7pQyWySSesmhudN8=
X-Received: by 2002:a05:6512:24a:b0:507:9a05:1aed with SMTP id
 b10-20020a056512024a00b005079a051aedmr422508lfo.4.1699505146669; Wed, 08 Nov
 2023 20:45:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698929590.git.hengqi@linux.alibaba.com> <4d57c072ca7d12034a1be4d9284e2be5988e1330.1698929590.git.hengqi@linux.alibaba.com>
In-Reply-To: <4d57c072ca7d12034a1be4d9284e2be5988e1330.1698929590.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 12:45:35 +0800
Message-ID: <CACGkMEt23Xm=dpwJMwX9dnwVjmQZqBp0SBxnpY19fgc=xMpcjA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/5] virtio-net: return -EOPNOTSUPP for adaptive-tx
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
> We do not currently support tx dim, so respond to -EOPNOTSUPP.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
> v1->v2:
> - Use -EOPNOTSUPP instead of specific implementation.
>
>  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5473aa1ee5cd..03edeadd0725 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3364,9 +3364,15 @@ static int virtnet_get_link_ksettings(struct net_d=
evice *dev,
>  static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
>                                           struct ethtool_coalesce *ec)
>  {
> +       bool tx_ctrl_dim_on =3D !!ec->use_adaptive_tx_coalesce;
>         struct scatterlist sgs_tx;
>         int i;
>
> +       if (tx_ctrl_dim_on) {
> +               pr_debug("Failed to enable adaptive-tx, which is not supp=
orted\n");
> +               return -EOPNOTSUPP;
> +       }

When can we hit this?

Thanks

> +
>         vi->ctrl->coal_tx.tx_usecs =3D cpu_to_le32(ec->tx_coalesce_usecs)=
;
>         vi->ctrl->coal_tx.tx_max_packets =3D cpu_to_le32(ec->tx_max_coale=
sced_frames);
>         sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx=
));
> @@ -3497,6 +3503,25 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struc=
t virtnet_info *vi,
>         return 0;
>  }
>
> +static int virtnet_send_tx_notf_coal_vq_cmds(struct virtnet_info *vi,
> +                                            struct ethtool_coalesce *ec,
> +                                            u16 queue)
> +{
> +       bool tx_ctrl_dim_on =3D !!ec->use_adaptive_tx_coalesce;
> +       int err;
> +
> +       if (tx_ctrl_dim_on) {
> +               pr_debug("Enabling adaptive-tx for txq%d is not supported=
\n", queue);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
> +                                              ec->tx_coalesce_usecs,
> +                                              ec->tx_max_coalesced_frame=
s);
> +
> +       return err;
> +}
> +
>  static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>                                           struct ethtool_coalesce *ec,
>                                           u16 queue)
> @@ -3507,9 +3532,7 @@ static int virtnet_send_notf_coal_vq_cmds(struct vi=
rtnet_info *vi,
>         if (err)
>                 return err;
>
> -       err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
> -                                              ec->tx_coalesce_usecs,
> -                                              ec->tx_max_coalesced_frame=
s);
> +       err =3D virtnet_send_tx_notf_coal_vq_cmds(vi, ec, queue);
>         if (err)
>                 return err;
>
> --
> 2.19.1.6.gb485710b
>


