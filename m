Return-Path: <netdev+bounces-27889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2725E77D85A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FDD2816C1
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD217E8;
	Wed, 16 Aug 2023 02:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65C20E7
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:19:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F0410C3
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692152388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YzYelNfjBE8YH9cr/VxGSoSgFNzkLgVjgq/U7+7Otg=;
	b=DiACvxh9iajslc+2Dbo5bPAzsx8mgKSQGvkPfNLIf9wzSwn9eeu6HqJwUFpeS/dX/5nByT
	sZRVGRklUhwCzYtQ0yaCbyN1CXGYbednnHvKvlloTJYJZk5fDznWEO6wRqM8hiWwmk2UF5
	WYIv7lOShcleD2YBw90xi05kE3BpdSI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-Z1bq1yYtPQKY7PduoBgSpA-1; Tue, 15 Aug 2023 22:19:47 -0400
X-MC-Unique: Z1bq1yYtPQKY7PduoBgSpA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bb93f9a54fso8104581fa.3
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692152386; x=1692757186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YzYelNfjBE8YH9cr/VxGSoSgFNzkLgVjgq/U7+7Otg=;
        b=T42zb8tHP78sPL+H01smMKMP/26qq+xQPJ/rjsAJ8CsDvdzti9l+HeuQCK9NxUVzCO
         tDyQgwulqBP/bepiKiUN9E6lqLFl8CZfEYTs7qqFcuFKJZbQMoG9Io3Mj17tWRts6zCj
         bQQxpH9A6Txqq+vAgznVwceTYQiTP4CQzsMhOuIReVOnJXakJsVs/s/jM24AXWQmlnrj
         eoIR/p9J+JQHPPPsqyjuq0cGzrIBWX58jBPM16R7xhbbJbCMmzHDem1peebogvt3HvYY
         NHTIZyDHEJ7irzFbte/UEwIvBdngXCMNyMbJAOtxeqCP/FvRGXFIK+TDtLzqrX/CrOri
         885Q==
X-Gm-Message-State: AOJu0YxMbQ6cQyfk14BA9/nETP1EmaoJAG3fwxuBvW9qlnRPbiBVCmwV
	CnP3bdIBuJg7/BCpbmh+Z4nAEQD+Par9aL6KVhrNEK8Qm5i61vTfyv+i3onZEC1PshhfGHApCv2
	ekVKKklVKg3MFHwkKAeJ3i2RaHfVoZITH
X-Received: by 2002:a2e:86c2:0:b0:2b6:c528:4940 with SMTP id n2-20020a2e86c2000000b002b6c5284940mr379252ljj.3.1692152386084;
        Tue, 15 Aug 2023 19:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUFlswGIG0rXG62guJXpW6W6jM74cCQMGY5o4vJww/gMKRd4ahB13DeTfzWaJPrkXmvtZiMlxOBn44VTS8tII=
X-Received: by 2002:a2e:86c2:0:b0:2b6:c528:4940 with SMTP id
 n2-20020a2e86c2000000b002b6c5284940mr379239ljj.3.1692152385803; Tue, 15 Aug
 2023 19:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com> <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com> <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
 <1692091669.428807-1-xuanzhuo@linux.alibaba.com> <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
 <1692151724.9150448-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692151724.9150448-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 10:19:34 +0800
Message-ID: <CACGkMEt7LSTY-TRcSD75vYcv0AkH2a5otVXga7VGRLu7JQT_dA@mail.gmail.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 10:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Wed, 16 Aug 2023 09:13:48 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Aug 15, 2023 at 5:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Tue, 15 Aug 2023 15:50:23 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Aug 15, 2023 at 2:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > >
> > > > > Hi, Jason
> > > > >
> > > > > Could you skip this patch?
> > > >
> > > > I'm fine with either merging or dropping this.
> > > >
> > > > >
> > > > > Let we review other patches firstly?
> > > >
> > > > I will be on vacation soon, and won't have time to do this until ne=
xt week.
> > >
> > > Have a happly vacation.
> > >
> > > >
> > > > But I spot two possible "issues":
> > > >
> > > > 1) the DMA metadata were stored in the headroom of the page, this
> > > > breaks frags coalescing, we need to benchmark it's impact
> > >
> > > Not every page, just the first page of the COMP pages.
> > >
> > > So I think there is no impact.
> >
> > Nope, see this:
> >
> >         if (SKB_FRAG_PAGE_ORDER &&
> >             !static_branch_unlikely(&net_high_order_alloc_disable_key))=
 {
> >                 /* Avoid direct reclaim but allow kswapd to wake */
> >                 pfrag->page =3D alloc_pages((gfp & ~__GFP_DIRECT_RECLAI=
M) |
> >                                           __GFP_COMP | __GFP_NOWARN |
> >                                           __GFP_NORETRY,
> >                                           SKB_FRAG_PAGE_ORDER);
> >                 if (likely(pfrag->page)) {
> >                         pfrag->size =3D PAGE_SIZE << SKB_FRAG_PAGE_ORDE=
R;
> >                         return true;
> >                 }
> >         }
> >
> > The comp page might be disabled due to the SKB_FRAG_PAGE_ORDER and
> > net_high_order_alloc_disable_key.
>
>
> YES.
>
> But if comp page is disabled. Then we only get one page each time. The pa=
ges are
> not contiguous, so we don't have frags coalescing.
>
> If you mean the two pages got from alloc_page may be contiguous. The coal=
escing
> may then be broken. It's a possibility, but I think the impact will be sm=
all.

Let's have a simple benchmark and see?

Thanks

>
> Thanks.
>
>
> >
> > >
> > >
> > > > 2) pre mapped DMA addresses were not reused in the case of XDP_TX/X=
DP_REDIRECT
> > >
> > > Because that the tx is not the premapped mode.
> >
> > Yes, we can optimize this on top.
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > I see Michael has merge this series so I'm fine to let it go first.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > >
> > >
> >
>


