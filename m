Return-Path: <netdev+bounces-22661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E076898D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 03:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEA22815A4
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 01:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74062C;
	Mon, 31 Jul 2023 01:23:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40936626
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 01:23:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1366CE7F
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690766626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUdX1IUA/AAHMSIEitCsUCTcaVwwQpXUAsFez0cmz4o=;
	b=O2aocktS9kVp912/9QnPcO/Ud+XgVfJQ7zrERPlGE9PNXsBFQG6PkcDeTBLQVHDJQwGAWb
	RJ0/y2VbOVTlPFCPJXS66vsbUQoTTeG7FsB4TnSuDYtKVxK5z+rvTOgXo2RcIEov3RhL95
	k132a1rpfzvgsSBibchFe0lOsyBLObU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-63EJZDYUMdWswjGJ1QRo6w-1; Sun, 30 Jul 2023 21:23:43 -0400
X-MC-Unique: 63EJZDYUMdWswjGJ1QRo6w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b83988c45bso37901641fa.3
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 18:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690766621; x=1691371421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUdX1IUA/AAHMSIEitCsUCTcaVwwQpXUAsFez0cmz4o=;
        b=Oa62OTXuAXp5hpidBmYBPpldQRdFB75yO5sMBJsRk+ETxeS6xxbrSsJAhrwDHB3CPZ
         mzenqhz/fpd9p8BDl4Tt9Qm/Mb4ZfVDEOsNedrLYnd9oYv5LpKP0s4ZY5gIi6UYf+KWt
         c9SJyPT+bBvQWY+pAa9R5EQkkW8es5fR21GlL9AAqFrKFCV2k6GtrPfvxLBrOAQX18ph
         j+wLzgN7dzIxgxPcEPg252Bb4g6Pi+IH9pgnuQjFPjupLZyw5OMrMLvp80qUC8Sw5tDD
         2xlgZmrkQuzMQlQjxC4TH69CgHhs7D0TyVzVUW+RDtVG/xaP2domWzCunvSPlhmZ3+xY
         PCDQ==
X-Gm-Message-State: ABy/qLbFHGpFkhvWx/puASKhnPGvY8hK3yQhwkVX85YGslDu/txsAnBp
	z4GqL2OfPkSeDkj27wXE8vgsXHKtyLteCQ0u2SwYmeg9WCFMB3MsjLVR6d8Gou93aaXV1dcfLCB
	q6ghrdxir37UszdA+PUvWG2981sunxrb9
X-Received: by 2002:a2e:7a03:0:b0:2b6:e96c:5414 with SMTP id v3-20020a2e7a03000000b002b6e96c5414mr4997713ljc.52.1690766621648;
        Sun, 30 Jul 2023 18:23:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3mYNG7gP+Xjt7/gXlwoQNDUicpGKnwfgw/1ZkukAGM6542lgUEVkWhMu8+/b3ZIbUEcpDG5CjB8A8VE6rDOM=
X-Received: by 2002:a2e:7a03:0:b0:2b6:e96c:5414 with SMTP id
 v3-20020a2e7a03000000b002b6e96c5414mr4997702ljc.52.1690766621373; Sun, 30 Jul
 2023 18:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com> <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org> <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org> <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com> <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com> <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230728080305.5fe3737c@kernel.org>
In-Reply-To: <20230728080305.5fe3737c@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 31 Jul 2023 09:23:29 +0800
Message-ID: <CACGkMEs5uc=ct8BsJzV2SEJzAGXqCP__yxo-MBa6d6JzDG4YOg@mail.gmail.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Christoph Hellwig <hch@infradead.org>, 
	virtualization@lists.linux-foundation.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 11:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 28 Jul 2023 14:02:33 +0800 Xuan Zhuo wrote:
> > Hi guys, this topic is stuck again. How should I proceed with this work=
?
> >
> > Let me briefly summarize:
> > 1. The problem with adding virtio_dma_{map, sync} api is that, for AF_X=
DP and
> > the driver layer, we need to support these APIs. The current conclusion=
 of
> > AF_XDP is no.
> >
> > 2. Set dma_set_mask_and_coherent, then we can use DMA API uniformly ins=
ide
> > driver. This idea seems to be inconsistent with the framework design of=
 DMA. The
> > conclusion is no.
> >
> > 3. We noticed that if the virtio device supports VIRTIO_F_ACCESS_PLATFO=
RM, it
> > uses DMA API. And this type of device is the future direction, so we on=
ly
> > support DMA premapped for this type of virtio device. The problem with =
this
> > solution is that virtqueue_dma_dev() only returns dev in some cases, be=
cause
> > VIRTIO_F_ACCESS_PLATFORM is supported in such cases. Otherwise NULL is =
returned.
> > This option is currently NO.
> >
> > So I'm wondering what should I do, from a DMA point of view, is there a=
ny
> > solution in case of using DMA API?
>
> I'd step back and ask you why do you want to use AF_XDP with virtio.
> Instead of bifurcating one virtio instance into different queues why
> not create a separate virtio instance?
>

I'm not sure I get this, but do you mean a separate virtio device that
owns AF_XDP queues only? If I understand it correctly, bifurcating is
one of the key advantages of AF_XDP. What's more, current virtio
doesn't support being split at queue (pair) level. And it may still
suffer from the yes/no DMA API issue.

Thanks


