Return-Path: <netdev+bounces-38849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE07BCC43
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 07:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC0E1C208D6
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 05:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0108217F9;
	Sun,  8 Oct 2023 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKV/atcb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6B9CA6F
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 05:21:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F596C5
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 22:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696742479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2Nj6xnsvoA9iFi7VyFH8pnKjaWY3HVRvayfbB8hPWM=;
	b=NKV/atcbXZ2MgRma8x+tP/UD0A2SNExRc/rgw4OSEf3K0j5/o8IBzNC1Mu2fnR0KXhC8sg
	NQ5YriwzaEPDbqRkkP97D7Tn9h7A4paU1xVpfn5AaAe5RhEbZ6z+GoOMo/lVvcnZ9vXtcJ
	6fQ6nuyhFfHMkqYpBL5OcR3uWusztMM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-G76V5NdpOhmdxUvr9Tpf6A-1; Sun, 08 Oct 2023 01:21:18 -0400
X-MC-Unique: G76V5NdpOhmdxUvr9Tpf6A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c030cea151so28520241fa.0
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 22:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742476; x=1697347276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2Nj6xnsvoA9iFi7VyFH8pnKjaWY3HVRvayfbB8hPWM=;
        b=H2W0sCO6aTDl7nN4dQIaMX7uQBL+Fl9Wl+A1ZJkv/r2NloEpU0gf1t/fowTIShxFhS
         8nM55yn2xCERxAb4jX6pfF8oKJojVPZefpDtnIQq0y46i37QvNgXdnnH30KuHmIPsw76
         0V0BOQD2aHcm1C1iSfRphoNS/VWKdxmK6YVyYsa1BS5IrlXON3h6qv3LQZbg6THBKspU
         RW7vOrqxERHWhkCB+bcHarTZdI9vg+he3HW/q9Zy3rswAhBtYChM3uGnByJHEPvT4vRO
         mgO7+/nQr5vBQC5N+da8MpYbxovfuKsu/flgzJYteS9lKRbcuwzslzFjS0JtRDkqQ0Do
         UZhQ==
X-Gm-Message-State: AOJu0YweTW89KSpXaBQvA/kMG7xU1e04L2P8C0oQrRvkdgNkhgu/TrMI
	KUcx9FjFV8cSP202OT2GfOZzI2k37HiK4vx1+xipSxoZotTNU+//EdWjjMnZXLAmbRQhRrXdQg2
	CVdAe5yejWI4HqVoBrGgQaPebjJKWVfO2
X-Received: by 2002:ac2:4e88:0:b0:4fe:1681:9377 with SMTP id o8-20020ac24e88000000b004fe16819377mr9630091lfr.44.1696742476712;
        Sat, 07 Oct 2023 22:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER/zYhzn0jvBIgdcTSYmEApRW78P2jQxly3Zzo2RzLXIJm4ROhWtDKebeluGAnDJIQdL0Wbu7Ug4s1typvJJM=
X-Received: by 2002:ac2:4e88:0:b0:4fe:1681:9377 with SMTP id
 o8-20020ac24e88000000b004fe16819377mr9630073lfr.44.1696742476393; Sat, 07 Oct
 2023 22:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1695627660.git.hengqi@linux.alibaba.com>
 <1b4f480bed95951b6f4805d6c4e72dd1a315acab.1695627660.git.hengqi@linux.alibaba.com>
 <960e16021a529bc9df217b3c2546e0dc7532ce7b.camel@redhat.com> <21d1ab6c-b94c-44c5-b8c3-2d7e7aa32dd9@linux.alibaba.com>
In-Reply-To: <21d1ab6c-b94c-44c5-b8c3-2d7e7aa32dd9@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 13:21:05 +0800
Message-ID: <CACGkMEsqV6KQNJnb9-4+Nt-0bEQ6n7kiZwuvLnBcTXRA+Gofyw@mail.gmail.com>
Subject: Re: [PATCH net v2 5/6] virtio-net: fix the vq coalescing setting for
 vq resize
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Gavin Li <gavinl@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 2:12=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
>
>
> =E5=9C=A8 2023/10/3 =E4=B8=8B=E5=8D=886:41, Paolo Abeni =E5=86=99=E9=81=
=93:
> > On Mon, 2023-09-25 at 15:53 +0800, Heng Qi wrote:
> >> According to the definition of virtqueue coalescing spec[1]:
> >>
> >>    Upon disabling and re-enabling a transmit virtqueue, the device MUS=
T set
> >>    the coalescing parameters of the virtqueue to those configured thro=
ugh the
> >>    VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not=
 set
> >>    any TX coalescing parameters, to 0.
> >>
> >>    Upon disabling and re-enabling a receive virtqueue, the device MUST=
 set
> >>    the coalescing parameters of the virtqueue to those configured thro=
ugh the
> >>    VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not=
 set
> >>    any RX coalescing parameters, to 0.
> >>
> >> We need to add this setting for vq resize (ethtool -G) where vq_reset =
happens.
> >>
> >> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.h=
tml
> >>
> >> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce=
 command")
> >> Cc: Gavin Li <gavinl@nvidia.com>
> >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > @Jason, since you commented on v1, waiting for your ack.
> >
> >> ---
> >>   drivers/net/virtio_net.c | 27 +++++++++++++++++++++++++++
> >>   1 file changed, 27 insertions(+)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 12ec3ae19b60..cb19b224419b 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -2855,6 +2855,9 @@ static void virtnet_get_ringparam(struct net_dev=
ice *dev,
> >>      ring->tx_pending =3D virtqueue_get_vring_size(vi->sq[0].vq);
> >>   }
> >>
> >> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> >> +                                     u16 vqn, u32 max_usecs, u32 max_=
packets);
> >> +
> >>   static int virtnet_set_ringparam(struct net_device *dev,
> >>                               struct ethtool_ringparam *ring,
> >>                               struct kernel_ethtool_ringparam *kernel_=
ring,
> >> @@ -2890,12 +2893,36 @@ static int virtnet_set_ringparam(struct net_de=
vice *dev,
> >>                      err =3D virtnet_tx_resize(vi, sq, ring->tx_pendin=
g);
> >>                      if (err)
> >>                              return err;
> >> +
> >> +                    /* Upon disabling and re-enabling a transmit virt=
queue, the device must
> >> +                     * set the coalescing parameters of the virtqueue=
 to those configured
> >> +                     * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET c=
ommand, or, if the driver
> >> +                     * did not set any TX coalescing parameters, to 0=
.
> >> +                     */
> >> +                    err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(=
i),
> >> +                                                        vi->intr_coal=
_tx.max_usecs,
> >> +                                                        vi->intr_coal=
_tx.max_packets);
> >> +                    if (err)
> >> +                            return err;
> >> +                    /* Save parameters */
> > As a very minor nit, I guess the comment could be dropped here (similar
> > to patch 4/6). @Heng Qi: please don't repost just for this, let's wait
> > for Jason' comments.
>
> Ok. We are currently on the National Day holiday, Jason may reply in a
> few days, thanks!

With the comments removed.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> > Cheers,
> >
> > Paolo
>


