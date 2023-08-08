Return-Path: <netdev+bounces-25235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9BD77368F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 04:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A074F281102
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83779A38;
	Tue,  8 Aug 2023 02:26:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D8659
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 02:26:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D845C1711
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691461579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3bPtKkgi1i397NDq9plny0QBkcNq3/yfnepW49dbsU=;
	b=DAWrkLw/OfWnLYJmhHuELtqTbaOEbGbqgdvQ/22hj7Fopw55EjKQKZxJtvliCll7QFMRV2
	It2GUi09GNeP5lTNdHVioxZGQod/e2Mj/AxTyQcZWrt634qNgVFp9wmQj/O/Lv/R8cTnJA
	A5yYsKJzH1ORd9rn9PmhyMgPJA2KnAQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-hTDaKkIINmqfMJr6CNbLOw-1; Mon, 07 Aug 2023 22:26:18 -0400
X-MC-Unique: hTDaKkIINmqfMJr6CNbLOw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9cd6a555aso49365971fa.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 19:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691461576; x=1692066376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3bPtKkgi1i397NDq9plny0QBkcNq3/yfnepW49dbsU=;
        b=Z5A4OZjHUSaU4q+AUoP/KweDJlJwxg8w2gVR+TmkbHfoBCZgfKkotkFLnVXze01OLc
         4CbhU2ZcNa695LPY9LulbFC4y3HQBo5srwAhzIR9zFXcxWoz2EyzCJ8RteMfkJL+/R1r
         FDcHq5WYp1XA6hwux+onAoJGWMLEP4qBnclhuZS9dgycvjohALNqi6D/EFSNLlsYaR+6
         NzyfysRN5PIsGBvRReDZ7I/xmNSRr7CRu2jwmnOyhJWydDEkPTgv6XMpOJP8JEa8ObGV
         TX5et9mKioxSOvLh4zY7wvdmLopL/dhwXBQ/31gxUBN44q8Sfc60PjdKziVLEgFwYRXa
         KTKw==
X-Gm-Message-State: AOJu0Yw4z7abBR9AU22smSZ6RkgEZlWvIRM6aw4IB8PuDb6fRRrmTiR9
	ZrJ6PVFlJ/AHkWGUCG4E6/PB5rButVWqs0N0icBlC4ErmoVZSDB1yO8zmzmQq5WRWEtvwUssqPN
	SMugyzNU4d5enD14a1/Xjj2wj+xE//vL/
X-Received: by 2002:a2e:9dd2:0:b0:2b9:e24d:21f6 with SMTP id x18-20020a2e9dd2000000b002b9e24d21f6mr8537846ljj.20.1691461576628;
        Mon, 07 Aug 2023 19:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNEm+Y6WWl+v6SW3V5FlF+qxZoMtf5PiRX9TeSa9v9sMGFuEkcW6A6jSYVhkrmtuO0whT+JZmflWz4uo7ct/I=
X-Received: by 2002:a2e:9dd2:0:b0:2b9:e24d:21f6 with SMTP id
 x18-20020a2e9dd2000000b002b9e24d21f6mr8537832ljj.20.1691461576310; Mon, 07
 Aug 2023 19:26:16 -0700 (PDT)
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
 <20230801121543-mutt-send-email-mst@kernel.org> <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 10:26:04 +0800
Message-ID: <CACGkMEsoivXfBV75whjyB0yreUNh7HeucGLw3Bq9Zvu1NGnj_g@mail.gmail.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
	virtualization@lists.linux-foundation.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 2:15=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Wed, 2 Aug 2023 09:49:31 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com>=
 wrote:
> > On Tue, 1 Aug 2023 12:17:47 -0400, "Michael S. Tsirkin" <mst@redhat.com=
> wrote:
> > > On Fri, Jul 28, 2023 at 02:02:33PM +0800, Xuan Zhuo wrote:
> > > > On Tue, 25 Jul 2023 19:07:23 +0800, Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > > > > On Tue, 25 Jul 2023 03:34:34 -0400, "Michael S. Tsirkin" <mst@red=
hat.com> wrote:
> > > > > > On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> > > > > > > On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@in=
fradead.org> wrote:
> > > > > > > > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirki=
n wrote:
> > > > > > > > > Well I think we can add wrappers like virtio_dma_sync and=
 so on.
> > > > > > > > > There are NOP for non-dma so passing the dma device is ha=
rmless.
> > > > > > > >
> > > > > > > > Yes, please.
> > > > > > >
> > > > > > >
> > > > > > > I am not sure I got this fully.
> > > > > > >
> > > > > > > Are you mean this:
> > > > > > > https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@=
linux.alibaba.com/
> > > > > > > https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@=
linux.alibaba.com/
> > > > > > >
> > > > > > > Then the driver must do dma operation(map and sync) by these =
virtio_dma_* APIs.
> > > > > > > No care the device is non-dma device or dma device.
> > > > > >
> > > > > > yes
> > > > > >
> > > > > > > Then the AF_XDP must use these virtio_dma_* APIs for virtio d=
evice.
> > > > > >
> > > > > > We'll worry about AF_XDP when the patch is posted.
> > > > >
> > > > > YES.
> > > > >
> > > > > We discussed it. They voted 'no'.
> > > > >
> > > > > http://lore.kernel.org/all/20230424082856.15c1e593@kernel.org
> > > >
> > > >
> > > > Hi guys, this topic is stuck again. How should I proceed with this =
work?
> > > >
> > > > Let me briefly summarize:
> > > > 1. The problem with adding virtio_dma_{map, sync} api is that, for =
AF_XDP and
> > > > the driver layer, we need to support these APIs. The current conclu=
sion of
> > > > AF_XDP is no.
> > > >
> > > > 2. Set dma_set_mask_and_coherent, then we can use DMA API uniformly=
 inside
> > > > driver. This idea seems to be inconsistent with the framework desig=
n of DMA. The
> > > > conclusion is no.
> > > >
> > > > 3. We noticed that if the virtio device supports VIRTIO_F_ACCESS_PL=
ATFORM, it
> > > > uses DMA API. And this type of device is the future direction, so w=
e only
> > > > support DMA premapped for this type of virtio device. The problem w=
ith this
> > > > solution is that virtqueue_dma_dev() only returns dev in some cases=
, because
> > > > VIRTIO_F_ACCESS_PLATFORM is supported in such cases.

Could you explain the issue a little bit more?

E.g if we limit AF_XDP to ACESS_PLATFROM only, why does
virtqueue_dma_dev() only return dev in some cases?

Thanks

>Otherwise NULL is returned.
> > > > This option is currently NO.
> > > >
> > > > So I'm wondering what should I do, from a DMA point of view, is the=
re any
> > > > solution in case of using DMA API?
> > > >
> > > > Thank you
> > >
> > >
> > > I think it's ok at this point, Christoph just asked you
> > > to add wrappers for map/unmap for use in virtio code.
> > > Seems like a cosmetic change, shouldn't be hard.
> >
> > Yes, that is not hard, I has this code.
> >
> > But, you mean that the wrappers is just used for the virtio driver code=
?
> > And we also offer the  API virtqueue_dma_dev() at the same time?
> > Then the driver will has two chooses to do DMA.
> >
> > Is that so?
>
> Ping.
>
> Thanks
>
> >
> >
> > > Otherwise I haven't seen significant comments.
> > >
> > >
> > > Christoph do I summarize what you are saying correctly?
> > > --
> > > MST
> > >
> >
>


