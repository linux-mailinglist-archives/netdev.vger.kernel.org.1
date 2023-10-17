Return-Path: <netdev+bounces-41656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC98D7CB88E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 04:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A10B20EE2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 02:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEF6187F;
	Tue, 17 Oct 2023 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/gQkhjW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3915C3
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:54:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5993
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697511238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOax/otkLw7+K/DCtgB4LfXc4jtPZ2fMPJUVzKsF40o=;
	b=H/gQkhjWC5Y+Ll0AA/qIa8vPLTtOMND3HO+tRBG6S/1Tb3saLVgSy5PE7ZseQyEa39SEIZ
	zDN0lMXBG/8svCQR16kTifUI8LdLRhyOk8otJnRgjWqjAKWgZxVXItfZs/3ylQojl6vKMF
	l1g4P+y42NxZQi4xbwTxfDRlBvsjw9g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-7ZQxpixxOUye_vISA3sceA-1; Mon, 16 Oct 2023 22:53:57 -0400
X-MC-Unique: 7ZQxpixxOUye_vISA3sceA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079630993dso4050513e87.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697511235; x=1698116035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOax/otkLw7+K/DCtgB4LfXc4jtPZ2fMPJUVzKsF40o=;
        b=c8yyhU0Me9624MHSlbMpnVZ67ztyTZpUD1cCP1cFL9c/1YMU+Zkw9u3kNYJfIwfKQu
         VgwXrD6kzY0RXzBm6vF4FzOu0wwKNehk6v2cMkwSySeDii8y3nkOkNc/3mGIQFSu4Ms5
         NRylO+xt5C5yJhK9D+vpKp2HCSzECnD9zvCHik4KqeAxPhWVXCksE1WI6WIt8GhS4pi5
         PvsLVf0CMmqTGAMOMTbA05XpOxVCst1wWi0psmSOAKXBI/9eVA2Nb4ddkXpFDN2VuAO7
         Et+eprU1C+4IMwr6S92sGwYTEZwDVgY5W/FAZoEthw5MEJqC/QXSVikkhQjzMiPvxlsg
         ARJA==
X-Gm-Message-State: AOJu0YxGIr7/kDVQoTT567EXF2ttNawTUK5DlDKSyrtva9hmubVDzur9
	WZrRtjbCo6NHjwHx0z5lW3uCXld44ReVJxGiS94Yd2qN0lkOCAVlvdIq8okUMbiR+jg+BKOFSCp
	KpLdzqZMJbsO/TnpHNCX6RHArfyiW+SW4
X-Received: by 2002:ac2:4104:0:b0:500:9d4a:8a02 with SMTP id b4-20020ac24104000000b005009d4a8a02mr869653lfi.62.1697511235627;
        Mon, 16 Oct 2023 19:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENwP83c5/JcMZ7anND6C6rpUXSsEAVfp2/WZRv8Bb2onTgn7vos7vIzvI659kgMrPrdVub0RiWlVaNJ2FtRZ8=
X-Received: by 2002:ac2:4104:0:b0:500:9d4a:8a02 with SMTP id
 b4-20020ac24104000000b005009d4a8a02mr869637lfi.62.1697511235236; Mon, 16 Oct
 2023 19:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 10:53:44 +0800
Message-ID: <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> ## AF_XDP
>
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The z=
ero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already suppo=
rt
> this feature, This patch set allows virtio-net to support xsk's zerocopy =
xmit
> feature.
>
> At present, we have completed some preparation:
>
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
>
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
>
> Virtio-net can not increase the queue num at will, so xsk shares the queu=
e with
> kernel.
>
> On the other hand, Virtio-Net does not support generate interrupt from dr=
iver
> manually, so when we wakeup tx xmit, we used some tips. If the CPU run by=
 TX
> NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. =
If it
> is also the local CPU, then we wake up napi directly.
>
> This patch set includes some refactor to the virtio-net to let that to su=
pport
> AF_XDP.
>
> ## performance
>
> ENV: Qemu with vhost-user(polling mode).
>
> Sockperf: https://github.com/Mellanox/sockperf
> I use this tool to send udp packet by kernel syscall.
>
> xmit command: sockperf tp -i 10.0.3.1 -t 1000
>
> I write a tool that sends udp packets or recvs udp packets by AF_XDP.
>
>                   | Guest APP CPU |Guest Softirq CPU | UDP PPS
> ------------------|---------------|------------------|------------
> xmit by syscall   |   100%        |                  |   676,915
> xmit by xsk       |   59.1%       |   100%           | 5,447,168
> recv by syscall   |   60%         |   100%           |   932,288
> recv by xsk       |   35.7%       |   100%           | 3,343,168

Any chance we can get a testpmd result (which I guess should be better
than PPS above)?

Thanks

>
> ## maintain
>
> I am currently a reviewer for virtio-net. I commit to maintain AF_XDP sup=
port in
> virtio-net.
>
> Please review.
>
> Thanks.
>
> v1:
>     1. remove two virtio commits. Push this patchset to net-next
>     2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: s=
upport tx
>     3. fix some warnings
>
> Xuan Zhuo (19):
>   virtio_net: rename free_old_xmit_skbs to free_old_xmit
>   virtio_net: unify the code for recycling the xmit ptr
>   virtio_net: independent directory
>   virtio_net: move to virtio_net.h
>   virtio_net: add prefix virtnet to all struct/api inside virtio_net.h
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: sq support premapped mode
>   virtio_net: xsk: bind/unbind xsk
>   virtio_net: xsk: prevent disable tx napi
>   virtio_net: xsk: tx: support tx
>   virtio_net: xsk: tx: support wakeup
>   virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xsk buffer
>   virtio_net: xsk: tx: virtnet_sq_free_unused_buf() check xsk buffer
>   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
>   virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
>   virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check xsk buffer
>   virtio_net: update tx timeout record
>   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
>
>  MAINTAINERS                                 |   2 +-
>  drivers/net/Kconfig                         |   8 +-
>  drivers/net/Makefile                        |   2 +-
>  drivers/net/virtio/Kconfig                  |  13 +
>  drivers/net/virtio/Makefile                 |   8 +
>  drivers/net/{virtio_net.c =3D> virtio/main.c} | 652 +++++++++-----------
>  drivers/net/virtio/virtio_net.h             | 359 +++++++++++
>  drivers/net/virtio/xsk.c                    | 545 ++++++++++++++++
>  drivers/net/virtio/xsk.h                    |  32 +
>  9 files changed, 1247 insertions(+), 374 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  rename drivers/net/{virtio_net.c =3D> virtio/main.c} (91%)
>  create mode 100644 drivers/net/virtio/virtio_net.h
>  create mode 100644 drivers/net/virtio/xsk.c
>  create mode 100644 drivers/net/virtio/xsk.h
>
> --
> 2.32.0.3.g01195cf9f
>


