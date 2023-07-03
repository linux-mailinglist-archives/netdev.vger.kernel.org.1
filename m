Return-Path: <netdev+bounces-15035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E850745646
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 09:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5944B280C6F
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AEFA34;
	Mon,  3 Jul 2023 07:45:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C710E8
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 07:45:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FB8E43
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688370307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55bNqB8+Yuqx/ySjnDbigrCQp0fQIOTPHTvF9O0igIQ=;
	b=QlzfrPMc47euHX5/Q6Qe81M/GCy53Aiw45cnzRSEocwbRbYL7xMR3fJ3IglKGFZMHXafxZ
	BYdxlWQccrAnUuGlCIy+QHQgEEt2spwNcO48J+OkdKN7cXwj6fWTg32PIGkTSosIIVESdd
	ZViYfYmSCwxq/5QnqhfhXghObeYWD/k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-4SSPlxrOOdiLHJq-CbqcFw-1; Mon, 03 Jul 2023 03:45:05 -0400
X-MC-Unique: 4SSPlxrOOdiLHJq-CbqcFw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b69e64ddabso39698811fa.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 00:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688370304; x=1690962304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55bNqB8+Yuqx/ySjnDbigrCQp0fQIOTPHTvF9O0igIQ=;
        b=EHuOp7h2BqQAgxC+MCVGbrE4NW7spSPYrGRMUQeD+0jOcxzBAgYv41CSjhLLlpVnlu
         8ZN2DOMQa/WhTkcqou8HxhFWT68G5x0Zvizj2oWxqVzndUtgzwrLByLQL4eouSNlP/jo
         tjNydE3gfUTIFqg2NlI3wcv1sAB0eKo8EUOOM0TDBSI0dhoHSZqakhxwLlKrBL5W4qo+
         L5mKaZHvOQfyYHSiSBsekltBIlRzfZYI8bHECGvKqS2DCq9RmKWZlPPjIYthjkEXwZlk
         RRhDO8dz9QaGUecHPhGzxJYKFH7hlWhj2c72j+JS/ytdkqipZDbknTMSp4q/2GDgmFeZ
         WADg==
X-Gm-Message-State: ABy/qLbw9yhHkSfLwTGnK3zw20pcGsfiBntpZxUL24hd0hK6uIkux3rH
	MimS8XaQTlDJmlyn5lHDrNwBhitHLO+C9mRnyDe1HbYh8io/N4rxhqa/0ElYQkHzoFT/mU3St5u
	PATlClI+cmG88QrhxFVMdNgNjnJh4NTyt
X-Received: by 2002:a2e:9059:0:b0:2b6:9909:79cb with SMTP id n25-20020a2e9059000000b002b6990979cbmr6941105ljg.42.1688370304438;
        Mon, 03 Jul 2023 00:45:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEIF9G1Mas3bWI9l/SxIhrXke3ejPrphx9HBEOMX/W+63WdpsfNStOiAI6vn69dm4MUmGuyOhoxIof/LMmBT6M=
X-Received: by 2002:a2e:9059:0:b0:2b6:9909:79cb with SMTP id
 n25-20020a2e9059000000b002b6990979cbmr6941093ljg.42.1688370304167; Mon, 03
 Jul 2023 00:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org> <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
In-Reply-To: <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Jul 2023 15:44:53 +0800
Message-ID: <CACGkMEt-Ao-0FmrG9y8+t31N9mJNyybY5SS+me_7pGyC_xJTsw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xieyongji@bytedance.com, david.marchand@redhat.com, 
	lulu@redhat.com, linux-kernel@vger.kernel.org, 
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

On Mon, Jul 3, 2023 at 3:43=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
> On 7/3/23 08:44, Jason Wang wrote:
> > On Sun, Jul 2, 2023 at 9:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >>
> >> On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> >>> This small series enables virtio-net device type in VDUSE.
> >>> With it, basic operation have been tested, both with
> >>> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> >>> adding VDUSE support using split rings layout (merged in
> >>> DPDK v23.07-rc1).
> >>>
> >>> Control queue support (and so multiqueue) has also been
> >>> tested, but requires a Kernel series from Jason Wang
> >>> relaxing control queue polling [1] to function reliably.
> >>>
> >>> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0=
WvjGRr3whU+QasUg@mail.gmail.com/T/
> >>
> >> Jason promised to post a new version of that patch.
> >> Right Jason?
> >
> > Yes.
> >
> >> For now let's make sure CVQ feature flag is off?
> >
> > We can do that and relax on top of my patch.
>
> I agree? Do you prefer a features negotiation, or failing init (like
> done for VERSION_1) if the VDUSE application advertises CVQ?

Assuming we will relax it soon, I think we can choose the easier way.
I guess it's just failing.

Thanks

>
> Thanks,
> Maxime
>
> > Thanks
> >
> >>
> >>> RFC -> v1 changes:
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> - Fail device init if it does not support VERSION_1 (Jason)
> >>>
> >>> Maxime Coquelin (2):
> >>>    vduse: validate block features only with block devices
> >>>    vduse: enable Virtio-net device type
> >>>
> >>>   drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
> >>>   1 file changed, 11 insertions(+), 4 deletions(-)
> >>>
> >>> --
> >>> 2.41.0
> >>
> >
>


