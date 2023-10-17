Return-Path: <netdev+bounces-41678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CEC7CBA1F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AB41C20B03
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 05:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4FC133;
	Tue, 17 Oct 2023 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3nhQe1M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F14BE58
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 05:28:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B753F1
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 22:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697520487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hB1Ys3pyVtLC66WyqHQkYZDV0fWNI3xEcGaEBbTojWA=;
	b=K3nhQe1MAdWTH4QNgaWSMQ2dEfwG4V21aZJz2IkIX8H7vaQm7FIwiZkO9E7nKfAB6CjvIw
	ILzRDR8x/hLh0uWUR/N+HXkS476Yw2zfOuDUxzMvGTIcemfu0p/xCiKHKmjPl40NUxce3j
	UJ6pYGK5V6KiIO+n+ayljMLLOAjN8cs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-OypeCaVYPdufBA934XEfZQ-1; Tue, 17 Oct 2023 01:28:00 -0400
X-MC-Unique: OypeCaVYPdufBA934XEfZQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c506abc320so23539531fa.2
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 22:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697520479; x=1698125279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hB1Ys3pyVtLC66WyqHQkYZDV0fWNI3xEcGaEBbTojWA=;
        b=RwWD6/IjSvCXqlkXS4XbA4jhBZtXWtez5NbNyIYSmLuXgJtKxS0hmra8Da2mcJTPyH
         uZgFBQ8dVl8tBDA3GNmDE/SAEObWHiCla5AGwkTbaPfwP+RZN4NG0duIIppyxFHqUN5b
         KHmZbDCO1BeFx0a7i0ECc2mw0elMW2W9aQqKOv6P4/oa7RXA/vE7DyXVSDZeBtBRjLWM
         I6sKfP/QzZCiM2CY4didaYOHsj6LrSrgN7F+2j2I/Hh86fQBJXmasPj3CGloJZMGgFf5
         EpcUcE9cM7tRUQkjmGP9/loYKp18G2bbnV/ejgFTlksolmZob9iKU7QnvQ7wPt5dwwTa
         e1Qg==
X-Gm-Message-State: AOJu0YzaakxXKCzJuPUC34GEZE7p5RrB6X+g+D1rgDxSv26nVtX61Mte
	ndUTFxuDgox7mqhbJfOqAZZSlfncz82Bjd25kQdQAivQgy0BcuoXHTRqDUFuKzPO/Ue+WMEkIEd
	x2S2kANLraBODI5js7D7HUZLS/Ihgxqnn
X-Received: by 2002:a05:6512:3ba9:b0:507:9701:2700 with SMTP id g41-20020a0565123ba900b0050797012700mr1114150lfv.20.1697520478985;
        Mon, 16 Oct 2023 22:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvAfxdQ+kiLfQtT6f7u3IqD6TS5IKXJFBeQ799Eef64sPKZxV6ivtMPGYp4y2Xt9AEpnuEQAc3PEglkp45by8=
X-Received: by 2002:a05:6512:3ba9:b0:507:9701:2700 with SMTP id
 g41-20020a0565123ba900b0050797012700mr1114144lfv.20.1697520478648; Mon, 16
 Oct 2023 22:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
 <1697511725.2037013-1-xuanzhuo@linux.alibaba.com> <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
 <1697512950.0813534-1-xuanzhuo@linux.alibaba.com> <CACGkMEtppjoX_WAM+vjzkMKaMQQ0iZL=C_xS4RObuoLbm0udUw@mail.gmail.com>
In-Reply-To: <CACGkMEtppjoX_WAM+vjzkMKaMQQ0iZL=C_xS4RObuoLbm0udUw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 13:27:47 +0800
Message-ID: <CACGkMEvWAhH3uj2DEo=m7qWg3-pQjE-EtEBvTT8JXzqZ+RYEXQ@mail.gmail.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 11:28=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Oct 17, 2023 at 11:26=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Tue, 17 Oct 2023 11:20:41 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Oct 17, 2023 at 11:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > On Tue, 17 Oct 2023 10:53:44 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > ## AF_XDP
> > > > > >
> > > > > > XDP socket(AF_XDP) is an excellent bypass kernel network framew=
ork. The zero
> > > > > > copy feature of xsk (XDP socket) needs to be supported by the d=
river. The
> > > > > > performance of zero copy is very good. mlx5 and intel ixgbe alr=
eady support
> > > > > > this feature, This patch set allows virtio-net to support xsk's=
 zerocopy xmit
> > > > > > feature.
> > > > > >
> > > > > > At present, we have completed some preparation:
> > > > > >
> > > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > > 2. virtio-core premapped dma
> > > > > > 3. virtio-net xdp refactor
> > > > > >
> > > > > > So it is time for Virtio-Net to complete the support for the XD=
P Socket
> > > > > > Zerocopy.
> > > > > >
> > > > > > Virtio-net can not increase the queue num at will, so xsk share=
s the queue with
> > > > > > kernel.
> > > > > >
> > > > > > On the other hand, Virtio-Net does not support generate interru=
pt from driver
> > > > > > manually, so when we wakeup tx xmit, we used some tips. If the =
CPU run by TX
> > > > > > NAPI last time is other CPUs, use IPI to wake up NAPI on the re=
mote CPU. If it
> > > > > > is also the local CPU, then we wake up napi directly.
> > > > > >
> > > > > > This patch set includes some refactor to the virtio-net to let =
that to support
> > > > > > AF_XDP.
> > > > > >
> > > > > > ## performance
> > > > > >
> > > > > > ENV: Qemu with vhost-user(polling mode).
> > > > > >
> > > > > > Sockperf: https://github.com/Mellanox/sockperf
> > > > > > I use this tool to send udp packet by kernel syscall.
> > > > > >
> > > > > > xmit command: sockperf tp -i 10.0.3.1 -t 1000
> > > > > >
> > > > > > I write a tool that sends udp packets or recvs udp packets by A=
F_XDP.
> > > > > >
> > > > > >                   | Guest APP CPU |Guest Softirq CPU | UDP PPS
> > > > > > ------------------|---------------|------------------|---------=
---
> > > > > > xmit by syscall   |   100%        |                  |   676,91=
5
> > > > > > xmit by xsk       |   59.1%       |   100%           | 5,447,16=
8
> > > > > > recv by syscall   |   60%         |   100%           |   932,28=
8
> > > > > > recv by xsk       |   35.7%       |   100%           | 3,343,16=
8
> > > > >
> > > > > Any chance we can get a testpmd result (which I guess should be b=
etter
> > > > > than PPS above)?
> > > >
> > > > Do you mean testpmd + DPDK + AF_XDP?
> > >
> > > Yes.
> > >
> > > >
> > > > Yes. This is probably better because my tool does more work. That i=
s not a
> > > > complete testing tool used by our business.
> > >
> > > Probably, but it would be appealing for others. Especially considerin=
g
> > > DPDK supports AF_XDP PMD now.
> >
> > OK.
> >
> > Let me try.
> >
> > But could you start to review firstly?
>
> Yes, it's in my todo list.

Speaking too fast, I think if it doesn't take too long time, I would
wait for the result first as netdim series. One reason is that I
remember claims to be only 10% to 20% loss comparing to wire speed, so
I'd expect it should be much faster. I vaguely remember, even a vhost
can gives us more than 3M PPS if we disable SMAP, so the numbers here
are not as impressive as expected.

Thanks

>
> >
> >
> > >
> > > >
> > > > What I noticed is that the hotspot is the driver writing virtio des=
c. Because
> > > > the device is in busy mode. So there is race between driver and dev=
ice.
> > > > So I modified the virtio core and lazily updated avail idx. Then pp=
s can reach
> > > > 10,000,000.
> > >
> > > Care to post a draft for this?
> >
> > YES, I is thinking for this.
> > But maybe that is just work for split. The packed mode has some trouble=
s.
>
> Ok.
>
> Thanks
>
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > ## maintain
> > > > > >
> > > > > > I am currently a reviewer for virtio-net. I commit to maintain =
AF_XDP support in
> > > > > > virtio-net.
> > > > > >
> > > > > > Please review.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > v1:
> > > > > >     1. remove two virtio commits. Push this patchset to net-nex=
t
> > > > > >     2. squash "virtio_net: virtnet_poll_tx support rescheduled"=
 to xsk: support tx
> > > > > >     3. fix some warnings
> > > > > >
> > > > > > Xuan Zhuo (19):
> > > > > >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> > > > > >   virtio_net: unify the code for recycling the xmit ptr
> > > > > >   virtio_net: independent directory
> > > > > >   virtio_net: move to virtio_net.h
> > > > > >   virtio_net: add prefix virtnet to all struct/api inside virti=
o_net.h
> > > > > >   virtio_net: separate virtnet_rx_resize()
> > > > > >   virtio_net: separate virtnet_tx_resize()
> > > > > >   virtio_net: sq support premapped mode
> > > > > >   virtio_net: xsk: bind/unbind xsk
> > > > > >   virtio_net: xsk: prevent disable tx napi
> > > > > >   virtio_net: xsk: tx: support tx
> > > > > >   virtio_net: xsk: tx: support wakeup
> > > > > >   virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xs=
k buffer
> > > > > >   virtio_net: xsk: tx: virtnet_sq_free_unused_buf() check xsk b=
uffer
> > > > > >   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
> > > > > >   virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buff=
er
> > > > > >   virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check xsk b=
uffer
> > > > > >   virtio_net: update tx timeout record
> > > > > >   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
> > > > > >
> > > > > >  MAINTAINERS                                 |   2 +-
> > > > > >  drivers/net/Kconfig                         |   8 +-
> > > > > >  drivers/net/Makefile                        |   2 +-
> > > > > >  drivers/net/virtio/Kconfig                  |  13 +
> > > > > >  drivers/net/virtio/Makefile                 |   8 +
> > > > > >  drivers/net/{virtio_net.c =3D> virtio/main.c} | 652 +++++++++-=
----------
> > > > > >  drivers/net/virtio/virtio_net.h             | 359 +++++++++++
> > > > > >  drivers/net/virtio/xsk.c                    | 545 ++++++++++++=
++++
> > > > > >  drivers/net/virtio/xsk.h                    |  32 +
> > > > > >  9 files changed, 1247 insertions(+), 374 deletions(-)
> > > > > >  create mode 100644 drivers/net/virtio/Kconfig
> > > > > >  create mode 100644 drivers/net/virtio/Makefile
> > > > > >  rename drivers/net/{virtio_net.c =3D> virtio/main.c} (91%)
> > > > > >  create mode 100644 drivers/net/virtio/virtio_net.h
> > > > > >  create mode 100644 drivers/net/virtio/xsk.c
> > > > > >  create mode 100644 drivers/net/virtio/xsk.h
> > > > > >
> > > > > > --
> > > > > > 2.32.0.3.g01195cf9f
> > > > > >
> > > > >
> > > >
> > >
> >


