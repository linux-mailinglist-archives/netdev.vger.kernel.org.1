Return-Path: <netdev+bounces-41668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D83D7CB91E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 05:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01834B20C4E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912158829;
	Tue, 17 Oct 2023 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pxb6ohay"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94D8801
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:21:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24933AB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697512866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQBANuGLA2Qaczjxyv0Yf+lURIM7hVcQNEeOyQdlaF0=;
	b=Pxb6ohayZ6CdxIxv/QonW7zFymMBiZ76EVeV3SFRWqxRebJs93IoTswn+KEZI49cyv0MwJ
	Ev+cTt4TxtHRvHSYyeDrKItGtiESvLxf8oG936fb2L4F6ot0ODDohzFFI6kHBKPvHft53S
	j7e7aQvXWQk5r9DBPPAx7w2I75UU0N8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-t7Lxiz7gMcKpouOiJH2r5w-1; Mon, 16 Oct 2023 23:20:54 -0400
X-MC-Unique: t7Lxiz7gMcKpouOiJH2r5w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50798a25ebaso3217237e87.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697512853; x=1698117653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQBANuGLA2Qaczjxyv0Yf+lURIM7hVcQNEeOyQdlaF0=;
        b=OzsXSQLBshLxugb1Y6Ft33z96IZNPYASksPsg2cH43qczLya232cFKH7GjTVuz6cE3
         til6kFbhwDnkNQZC7szqWpbgDlZc2yR2dMz0XNsSgcmzRU+LRImOgya7Z17NZKO+rRlI
         thCeL5WthsGXFLBWEAvZlPSlrXZIp1tr2GwywVWNIpNgEZTrOqpEGIPvTpJosOz9ZuqI
         WL9izjevZUfBlUx8XOK+BsGdRmJ0Ov/xl0PN6YYwW9OVIwwQoDEWz72sC1QzCY50McoX
         mbprQErrfs5iWmi4W8QuZ6olfPWfSGoWotTs+pLYZES/tdcZBX9HEktrMUz75vis44zt
         aTVw==
X-Gm-Message-State: AOJu0Yys+57jh4/qPArX3Ez6hN4nGBEP35HOc1txJsibQ09AK7UwDdRl
	Q+XRwDn0ftx1ew35mi2096tvxkQIE8zBNqPFZZ1nlQ1UgS7U/RFyyjIvPoAFJ1xdO37vVap9oMr
	yrlORMWmSzONDsuvk9NtTC7AUDlWOiSsk
X-Received: by 2002:a19:2d1b:0:b0:4f8:6d9d:abe0 with SMTP id k27-20020a192d1b000000b004f86d9dabe0mr307422lfj.33.1697512853459;
        Mon, 16 Oct 2023 20:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEriSO1NnxU3cWGUDSHPSou5pJhfNNgUsEOrGIO0a9jE2MpZhdAKIqP4yHxef6EH0GJZb2STXQJZXTCtFqBkAI=
X-Received: by 2002:a19:2d1b:0:b0:4f8:6d9d:abe0 with SMTP id
 k27-20020a192d1b000000b004f86d9dabe0mr307414lfj.33.1697512853053; Mon, 16 Oct
 2023 20:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com> <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 11:20:41 +0800
Message-ID: <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 11:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Tue, 17 Oct 2023 10:53:44 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > ## AF_XDP
> > >
> > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. T=
he zero
> > > copy feature of xsk (XDP socket) needs to be supported by the driver.=
 The
> > > performance of zero copy is very good. mlx5 and intel ixgbe already s=
upport
> > > this feature, This patch set allows virtio-net to support xsk's zeroc=
opy xmit
> > > feature.
> > >
> > > At present, we have completed some preparation:
> > >
> > > 1. vq-reset (virtio spec and kernel code)
> > > 2. virtio-core premapped dma
> > > 3. virtio-net xdp refactor
> > >
> > > So it is time for Virtio-Net to complete the support for the XDP Sock=
et
> > > Zerocopy.
> > >
> > > Virtio-net can not increase the queue num at will, so xsk shares the =
queue with
> > > kernel.
> > >
> > > On the other hand, Virtio-Net does not support generate interrupt fro=
m driver
> > > manually, so when we wakeup tx xmit, we used some tips. If the CPU ru=
n by TX
> > > NAPI last time is other CPUs, use IPI to wake up NAPI on the remote C=
PU. If it
> > > is also the local CPU, then we wake up napi directly.
> > >
> > > This patch set includes some refactor to the virtio-net to let that t=
o support
> > > AF_XDP.
> > >
> > > ## performance
> > >
> > > ENV: Qemu with vhost-user(polling mode).
> > >
> > > Sockperf: https://github.com/Mellanox/sockperf
> > > I use this tool to send udp packet by kernel syscall.
> > >
> > > xmit command: sockperf tp -i 10.0.3.1 -t 1000
> > >
> > > I write a tool that sends udp packets or recvs udp packets by AF_XDP.
> > >
> > >                   | Guest APP CPU |Guest Softirq CPU | UDP PPS
> > > ------------------|---------------|------------------|------------
> > > xmit by syscall   |   100%        |                  |   676,915
> > > xmit by xsk       |   59.1%       |   100%           | 5,447,168
> > > recv by syscall   |   60%         |   100%           |   932,288
> > > recv by xsk       |   35.7%       |   100%           | 3,343,168
> >
> > Any chance we can get a testpmd result (which I guess should be better
> > than PPS above)?
>
> Do you mean testpmd + DPDK + AF_XDP?

Yes.

>
> Yes. This is probably better because my tool does more work. That is not =
a
> complete testing tool used by our business.

Probably, but it would be appealing for others. Especially considering
DPDK supports AF_XDP PMD now.

>
> What I noticed is that the hotspot is the driver writing virtio desc. Bec=
ause
> the device is in busy mode. So there is race between driver and device.
> So I modified the virtio core and lazily updated avail idx. Then pps can =
reach
> 10,000,000.

Care to post a draft for this?

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > > ## maintain
> > >
> > > I am currently a reviewer for virtio-net. I commit to maintain AF_XDP=
 support in
> > > virtio-net.
> > >
> > > Please review.
> > >
> > > Thanks.
> > >
> > > v1:
> > >     1. remove two virtio commits. Push this patchset to net-next
> > >     2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xs=
k: support tx
> > >     3. fix some warnings
> > >
> > > Xuan Zhuo (19):
> > >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> > >   virtio_net: unify the code for recycling the xmit ptr
> > >   virtio_net: independent directory
> > >   virtio_net: move to virtio_net.h
> > >   virtio_net: add prefix virtnet to all struct/api inside virtio_net.=
h
> > >   virtio_net: separate virtnet_rx_resize()
> > >   virtio_net: separate virtnet_tx_resize()
> > >   virtio_net: sq support premapped mode
> > >   virtio_net: xsk: bind/unbind xsk
> > >   virtio_net: xsk: prevent disable tx napi
> > >   virtio_net: xsk: tx: support tx
> > >   virtio_net: xsk: tx: support wakeup
> > >   virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xsk buff=
er
> > >   virtio_net: xsk: tx: virtnet_sq_free_unused_buf() check xsk buffer
> > >   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
> > >   virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
> > >   virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check xsk buffer
> > >   virtio_net: update tx timeout record
> > >   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
> > >
> > >  MAINTAINERS                                 |   2 +-
> > >  drivers/net/Kconfig                         |   8 +-
> > >  drivers/net/Makefile                        |   2 +-
> > >  drivers/net/virtio/Kconfig                  |  13 +
> > >  drivers/net/virtio/Makefile                 |   8 +
> > >  drivers/net/{virtio_net.c =3D> virtio/main.c} | 652 +++++++++-------=
----
> > >  drivers/net/virtio/virtio_net.h             | 359 +++++++++++
> > >  drivers/net/virtio/xsk.c                    | 545 ++++++++++++++++
> > >  drivers/net/virtio/xsk.h                    |  32 +
> > >  9 files changed, 1247 insertions(+), 374 deletions(-)
> > >  create mode 100644 drivers/net/virtio/Kconfig
> > >  create mode 100644 drivers/net/virtio/Makefile
> > >  rename drivers/net/{virtio_net.c =3D> virtio/main.c} (91%)
> > >  create mode 100644 drivers/net/virtio/virtio_net.h
> > >  create mode 100644 drivers/net/virtio/xsk.c
> > >  create mode 100644 drivers/net/virtio/xsk.h
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>


