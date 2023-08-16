Return-Path: <netdev+bounces-27861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A477D782
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 03:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1D4281663
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2A57EA;
	Wed, 16 Aug 2023 01:14:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D5392
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:14:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23142127
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692148443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+pHbckL50YFELz4jhUnoR5ZB+UHNI6fuSKER4VhZC0=;
	b=ATGxW/sON+L7DrwNLx7dBZ5RTbtMbv920ECI+/7hnIwSr5n7Q1+Vqa0knu40tWVD9thYMO
	Q1DZS0yqU5Ms60UhZYr2Lq7tjT0A5zDx4AXEDDnCNy3Gey4y//Re9XLC5HEYOsdcosW1YS
	loKO+U80tf9nB6bOmjJYOWdPkecCa6o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-GThS5DDoNwiJFJojqdTxVQ-1; Tue, 15 Aug 2023 21:14:01 -0400
X-MC-Unique: GThS5DDoNwiJFJojqdTxVQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ba7156eadfso43628271fa.0
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692148440; x=1692753240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+pHbckL50YFELz4jhUnoR5ZB+UHNI6fuSKER4VhZC0=;
        b=F16UJjERrCO4/0ONivPVQuYb6TBGC52Gjopk9D8JEF2Z+hySC4K0NFyzGCarEzaipU
         CeHXH/OqVj2a9KEm5Piw//yQGPxoZo0h5TBtyGo4MFTFv+sYLRz6eOs4AoWnW6HQ0pjp
         ye4IF20+SOU6UlHyxjTto/0a6ngvKkjvsau5AkIk/EBQJX7fhEE64ce4H1nJunZCoVMu
         YACgPpl1r9FqsqDb/eIWW9oo7BUW8uRnJ94sIoakzryTrNQlFsKZxWjsPl1miaXyG42F
         tQ2kTrmprJyv6ez8bvpi9KRhUK7YAe+Gtgc1s3Wr4SDAXRebwelQjH1ltX+0ly2B0byt
         niBQ==
X-Gm-Message-State: AOJu0Yw8g3r9LGKgwtVbalA3pOjzydwun7Cdn3xFaFj6e/WfKvcLKNsS
	sGRQep8o6jjXaWY4UI3vNRh4/Ntft7bXbCRXDizzluKgHuw66KVnKoOa+dKTu3RD91hOW0nRCXt
	a8jl/3yuzoZU1NwGQ03dltlOhbhKMu0Hj
X-Received: by 2002:a2e:8788:0:b0:2b9:c864:9e3f with SMTP id n8-20020a2e8788000000b002b9c8649e3fmr287462lji.39.1692148440469;
        Tue, 15 Aug 2023 18:14:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8LwPFW2G1dTIhy1em/nftkzDGRx99RiUxeBvkJMjQqcgWmMl74ojJLdmCbQo2Vibix0tfmCqogWSZmq0o5rY=
X-Received: by 2002:a2e:8788:0:b0:2b9:c864:9e3f with SMTP id
 n8-20020a2e8788000000b002b9c8649e3fmr287450lji.39.1692148440172; Tue, 15 Aug
 2023 18:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com> <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com> <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
 <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 09:13:48 +0800
Message-ID: <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 5:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 15 Aug 2023 15:50:23 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Aug 15, 2023 at 2:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > >
> > > Hi, Jason
> > >
> > > Could you skip this patch?
> >
> > I'm fine with either merging or dropping this.
> >
> > >
> > > Let we review other patches firstly?
> >
> > I will be on vacation soon, and won't have time to do this until next w=
eek.
>
> Have a happly vacation.
>
> >
> > But I spot two possible "issues":
> >
> > 1) the DMA metadata were stored in the headroom of the page, this
> > breaks frags coalescing, we need to benchmark it's impact
>
> Not every page, just the first page of the COMP pages.
>
> So I think there is no impact.

Nope, see this:

        if (SKB_FRAG_PAGE_ORDER &&
            !static_branch_unlikely(&net_high_order_alloc_disable_key)) {
                /* Avoid direct reclaim but allow kswapd to wake */
                pfrag->page =3D alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
                                          __GFP_COMP | __GFP_NOWARN |
                                          __GFP_NORETRY,
                                          SKB_FRAG_PAGE_ORDER);
                if (likely(pfrag->page)) {
                        pfrag->size =3D PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
                        return true;
                }
        }

The comp page might be disabled due to the SKB_FRAG_PAGE_ORDER and
net_high_order_alloc_disable_key.

>
>
> > 2) pre mapped DMA addresses were not reused in the case of XDP_TX/XDP_R=
EDIRECT
>
> Because that the tx is not the premapped mode.

Yes, we can optimize this on top.

Thanks

>
> Thanks.
>
> >
> > I see Michael has merge this series so I'm fine to let it go first.
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> >
>


