Return-Path: <netdev+bounces-37635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F211B7B668F
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8C048281651
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD488D314;
	Tue,  3 Oct 2023 10:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6FA7ED
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:41:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA07B8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696329668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRRAGV+UU6/gJ85E/oblYOeeKk1zoIISwkILmJK6qUg=;
	b=a0zbZTnHdttZ8EZx57yFUKbn0BENdEDTOAQph6fqifo+8RtR6S33vr9JY+Latle89CaL5J
	4Ej1Rt/QWtv4IL125pf8AlRjwE9ZKMmBMKWLhsnJOdBBTkQZKt5f6JOjXvqU3FWqENAi/h
	g+9SA2ZvLVpK4/gv4DelCx8ORC6/O10=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-bpbByNTGMWawN6-nnCQMTA-1; Tue, 03 Oct 2023 06:41:07 -0400
X-MC-Unique: bpbByNTGMWawN6-nnCQMTA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae5101b152so13883566b.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 03:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696329666; x=1696934466;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRRAGV+UU6/gJ85E/oblYOeeKk1zoIISwkILmJK6qUg=;
        b=b6WV+1tdwTeQQiJW0/hK36ZLoievZE2NAAJvEPrdqUcn5Y1NdpqhwqAX9HcBVwLc8V
         NaUykGK0nKHYH4kuEZxnAZui2YvSRPJCrlO2fCSH69K9KRfJVkyNoJm3Y51XWto9FtVc
         xshQqUdHM0qlrKfLpv/YqYOH7fN/wSr6gWOrPWM30cBpjZeDHjjeyNYmUk8Nc3wHG8ti
         swhWfVJ0QzxjKj8n89s96s+HJVRncJoziH5tLdJmFNIgWLGyiUCSDIB9j5a96Dc2lX4w
         HwrN3Qm/0xPlkUgtFwsgBMB8k5vbve8pXO/4s8eH3OlMKNNYPCYzqwkF4L+lg0VqggXb
         SX6w==
X-Gm-Message-State: AOJu0YwmkAdIZryCiyXsrzsJSN6M24rCfGagT23l/29Oqq/ssU0uwqmq
	8v/ICyiIeG6OsELkKaL0VlFxFWBASvW71885L2FPYzPmVf2Z7ejdHr5JqsqvVugDhOrHuTio4uL
	/La8DFT7jogQ1Ccvx
X-Received: by 2002:a17:906:101a:b0:9b2:93f0:70b9 with SMTP id 26-20020a170906101a00b009b293f070b9mr10916200ejm.3.1696329665904;
        Tue, 03 Oct 2023 03:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0l8fLdJoHjuboygQtpHYXVPvRXsg/ustHtzTXzFiIkT9xq4pzDhV2oPN1PGx5cfXslOhQmg==
X-Received: by 2002:a17:906:101a:b0:9b2:93f0:70b9 with SMTP id 26-20020a170906101a00b009b293f070b9mr10916180ejm.3.1696329665504;
        Tue, 03 Oct 2023 03:41:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id o13-20020a170906358d00b0099bc8db97bcsm839267ejb.131.2023.10.03.03.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:41:05 -0700 (PDT)
Message-ID: <960e16021a529bc9df217b3c2546e0dc7532ce7b.camel@redhat.com>
Subject: Re: [PATCH net v2 5/6] virtio-net: fix the vq coalescing setting
 for vq resize
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>,  "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Gavin Li <gavinl@nvidia.com>
Date: Tue, 03 Oct 2023 12:41:03 +0200
In-Reply-To: <1b4f480bed95951b6f4805d6c4e72dd1a315acab.1695627660.git.hengqi@linux.alibaba.com>
References: <cover.1695627660.git.hengqi@linux.alibaba.com>
	 <1b4f480bed95951b6f4805d6c4e72dd1a315acab.1695627660.git.hengqi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-25 at 15:53 +0800, Heng Qi wrote:
> According to the definition of virtqueue coalescing spec[1]:
>=20
>   Upon disabling and re-enabling a transmit virtqueue, the device MUST se=
t
>   the coalescing parameters of the virtqueue to those configured through =
the
>   VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set
>   any TX coalescing parameters, to 0.
>=20
>   Upon disabling and re-enabling a receive virtqueue, the device MUST set
>   the coalescing parameters of the virtqueue to those configured through =
the
>   VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not set
>   any RX coalescing parameters, to 0.
>=20
> We need to add this setting for vq resize (ethtool -G) where vq_reset hap=
pens.
>=20
> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.html
>=20
> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce co=
mmand")
> Cc: Gavin Li <gavinl@nvidia.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

@Jason, since you commented on v1, waiting for your ack.

> ---
>  drivers/net/virtio_net.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 12ec3ae19b60..cb19b224419b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2855,6 +2855,9 @@ static void virtnet_get_ringparam(struct net_device=
 *dev,
>  	ring->tx_pending =3D virtqueue_get_vring_size(vi->sq[0].vq);
>  }
> =20
> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> +					 u16 vqn, u32 max_usecs, u32 max_packets);
> +
>  static int virtnet_set_ringparam(struct net_device *dev,
>  				 struct ethtool_ringparam *ring,
>  				 struct kernel_ethtool_ringparam *kernel_ring,
> @@ -2890,12 +2893,36 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
>  			err =3D virtnet_tx_resize(vi, sq, ring->tx_pending);
>  			if (err)
>  				return err;
> +
> +			/* Upon disabling and re-enabling a transmit virtqueue, the device mu=
st
> +			 * set the coalescing parameters of the virtqueue to those configured
> +			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the d=
river
> +			 * did not set any TX coalescing parameters, to 0.
> +			 */
> +			err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(i),
> +							    vi->intr_coal_tx.max_usecs,
> +							    vi->intr_coal_tx.max_packets);
> +			if (err)
> +				return err;
> +			/* Save parameters */

As a very minor nit, I guess the comment could be dropped here (similar
to patch 4/6). @Heng Qi: please don't repost just for this, let's wait
for Jason' comments.

Cheers,

Paolo


