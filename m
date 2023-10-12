Return-Path: <netdev+bounces-40274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D27C678E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C5D1C20BAC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8066E1CF91;
	Thu, 12 Oct 2023 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUWL5Z5/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C21BDF0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 08:29:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279390
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 01:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697099388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw5dAG2qe9sQwutLGPP6CjbFZLPwvDB+sGyUCh+7Sug=;
	b=UUWL5Z5/an52IQigTshB7M9wasx+xmxUVS1+tgX8uRhMfkY78CQIBcbe4syLFnCCUCf5Fo
	B0Egc4mCix6nF4VmyCs0JOHGYlgqpa019eCaPJqe7WyyS0LOEGmP1N8a1Ashc5UFlg/gzo
	3CnG9VRtu2kZZzjvwyc2xsp7cFSUKVI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-DRRFfKcYMOC9ZHZiso9LLw-1; Thu, 12 Oct 2023 04:29:46 -0400
X-MC-Unique: DRRFfKcYMOC9ZHZiso9LLw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c120e3aa0dso6134001fa.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 01:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697099385; x=1697704185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vw5dAG2qe9sQwutLGPP6CjbFZLPwvDB+sGyUCh+7Sug=;
        b=LdOHKNtUP+ok2FV+zWY/6fwWHBW4qauxtDdBhqGQiVdEUKdQYDifurDSz9MvEi9oIE
         zcTvnFh0PAS4oaBYM3AQOlKehmOp/89EoxgH+vvzibCg0lazYvpTccd8tYsMgdK1LJZY
         EHOH2wShibYc3c1/2FTsq6sRBvF3Lbk2vGJLxY9XC2K8QDG5M6U+rRYM/QfvTGn5H3Ln
         V15coXOpkffUtUPeBsX75cd/vOJ7CERtetB2fwUowzM5ej3YutXnapnr4d+8mbSMDHH8
         Vv8xvN0lOn6dMyuyCF0xKay5kgnRFqUDnvRyigbGrsuzCcXCc0f4FE3orF9qnhNYOKWZ
         R1Cg==
X-Gm-Message-State: AOJu0YxtWoCKw9yHspe1C/KaJU8OwlfxCixqBPQS/G43+bMaqCvIWZxW
	EaNKbks7cSPn0eJB5Dnjis0ly96lD8N9oJdSQ6dmW4GGZOPeGQYImDxwpLSiqcc/H0DGGXtyIoB
	sWzQdcaEsMCIorwKwe5DxzYp/bkNg2qHc
X-Received: by 2002:a19:910d:0:b0:501:ba04:f34b with SMTP id t13-20020a19910d000000b00501ba04f34bmr17462338lfd.44.1697099385366;
        Thu, 12 Oct 2023 01:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6L72gGGcnELBjEfUyBf/q77upOFSG7lJho6VTRgFelGqkudpuilTAwrphbOkgaeFS35fuGuA/oKMzZR8x5I0=
X-Received: by 2002:a19:910d:0:b0:501:ba04:f34b with SMTP id
 t13-20020a19910d000000b00501ba04f34bmr17462324lfd.44.1697099385050; Thu, 12
 Oct 2023 01:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
In-Reply-To: <cover.1697093455.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Oct 2023 16:29:33 +0800
Message-ID: <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing moderation
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 3:44=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Now, virtio-net already supports per-queue moderation parameter
> setting. Based on this, we use the netdim library of linux to support
> dynamic coalescing moderation for virtio-net.
>
> Due to hardware scheduling issues, we only tested rx dim.

Do you have PPS numbers? And TX numbers are also important as the
throughput could be misleading due to various reasons.

Thanks

>
> @Test env
> rxq0 has affinity to cpu0.
>
> @Test cmd
> client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m ${msg_size}
> server: taskset -c 0 sockperf sr --tcp
>
> @Test res
> The second column is the ratio of the result returned by client
> when rx dim is enabled to the result returned by client when
> rx dim is disabled.
>         --------------------------------------
>         | msg_size |  rx_dim=3Don / rx_dim=3Doff |
>         --------------------------------------
>         |   14B    |         + 3%            |
>         --------------------------------------
>         |   100B   |         + 16%           |
>         --------------------------------------
>         |   500B   |         + 25%           |
>         --------------------------------------
>         |   1400B  |         + 28%           |
>         --------------------------------------
>         |   2048B  |         + 22%           |
>         --------------------------------------
>         |   4096B  |         + 5%            |
>         --------------------------------------
>
> ---
> This patch set was part of the previous netdim patch set[1].
> [1] was split into a merged bugfix set[2] and the current set.
> The previous relevant commentators have been Cced.
>
> [1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.aliba=
ba.com/
> [2] https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.alibaba=
.com/
>
> Heng Qi (5):
>   virtio-net: returns whether napi is complete
>   virtio-net: separate rx/tx coalescing moderation cmds
>   virtio-net: extract virtqueue coalescig cmd for reuse
>   virtio-net: support rx netdim
>   virtio-net: support tx netdim
>
>  drivers/net/virtio_net.c | 394 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 322 insertions(+), 72 deletions(-)
>
> --
> 2.19.1.6.gb485710b
>
>


