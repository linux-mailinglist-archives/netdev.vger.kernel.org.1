Return-Path: <netdev+bounces-15031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C5745591
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9911C20510
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A536E;
	Mon,  3 Jul 2023 06:45:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26747803
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 06:45:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224AFCD
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688366699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovluAHTmtFvydqG5OYZ6GVGeRDsdOvDwQZe/fLVcLSo=;
	b=PiKIt3UUtdh9SKfsUFd3OdUxoUgcBdbJXWDUac3NH1zd2eYkmx+0xPnoPzPgXRIfEEEOW0
	+jZxhEUvEfGSPnYiOYWY6VRPs1dX9LEuDjL6wnTm0g3ES3Cd2hab4j5f4b9ySx9On8oAAA
	jzs7DbF7ijtwAysEK+CTBh4zMfJ720E=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-rUSzkYxQNPCl6c4dyFY7TQ-1; Mon, 03 Jul 2023 02:44:58 -0400
X-MC-Unique: rUSzkYxQNPCl6c4dyFY7TQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b69e0a9cc9so33100231fa.0
        for <netdev@vger.kernel.org>; Sun, 02 Jul 2023 23:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688366696; x=1690958696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovluAHTmtFvydqG5OYZ6GVGeRDsdOvDwQZe/fLVcLSo=;
        b=AY8/10HGiqLRTIdR0tShJvw3R/03XvYwQs7VdDdsXDpk6+uCmNNWwMm6VjOTCd6Ab7
         0eLzvP22qFZthmRwER2g1pSYWZsDCAaN/SEFp39pgeROYG0sJjEUMUD2yViFfgQCJ12F
         oEvZrVoIVPNFKqKhHtAXk7r7FECagQkQ65OqF1MuBilLNMAFvNoE6zn8ackMZ+ct4DwH
         hjrRtLPLKqB9V/3Pq5E0TcXkGm+Ty9aEk/R7JisT28WyCo13cI+wU9h/xG56KSuGtP88
         WMZB8I7pDJn70kWpldZgwR6vnGG5kWjipbupAYsmKCp3aNEogKAHtKAjREtElahqixF5
         c1dQ==
X-Gm-Message-State: ABy/qLaky8e5D8xocXyxcjo5XkYFuq9c0Gr8migqAyB2l+5UskEuDl57
	F+WdFRfuFpbswQUssz1/YcwOiJk2M817X5Ka26b6Kk/quNZntg5PAHh6BuI+d7rJ0mgOPJXSUqW
	a1F2/hza+qMvO4hCEdEkgd9A4ALMWu0Nd
X-Received: by 2002:a2e:910c:0:b0:2b6:a22f:9fb9 with SMTP id m12-20020a2e910c000000b002b6a22f9fb9mr6009893ljg.27.1688366696673;
        Sun, 02 Jul 2023 23:44:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlynqGGlx9Jhthcs4p2/VB3UnNVeBKpKxmHTXOyGfI54rO4NRmFnzaCGXKfgksJmq0cNXrTsUIyES6jnl+V9A=
X-Received: by 2002:a2e:910c:0:b0:2b6:a22f:9fb9 with SMTP id
 m12-20020a2e910c000000b002b6a22f9fb9mr6009887ljg.27.1688366696399; Sun, 02
 Jul 2023 23:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com> <20230702093530-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230702093530-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Jul 2023 14:44:45 +0800
Message-ID: <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, xieyongji@bytedance.com, 
	david.marchand@redhat.com, lulu@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 2, 2023 at 9:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> > This small series enables virtio-net device type in VDUSE.
> > With it, basic operation have been tested, both with
> > virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> > adding VDUSE support using split rings layout (merged in
> > DPDK v23.07-rc1).
> >
> > Control queue support (and so multiqueue) has also been
> > tested, but requires a Kernel series from Jason Wang
> > relaxing control queue polling [1] to function reliably.
> >
> > [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0Wv=
jGRr3whU+QasUg@mail.gmail.com/T/
>
> Jason promised to post a new version of that patch.
> Right Jason?

Yes.

> For now let's make sure CVQ feature flag is off?

We can do that and relax on top of my patch.

Thanks

>
> > RFC -> v1 changes:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - Fail device init if it does not support VERSION_1 (Jason)
> >
> > Maxime Coquelin (2):
> >   vduse: validate block features only with block devices
> >   vduse: enable Virtio-net device type
> >
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > --
> > 2.41.0
>


