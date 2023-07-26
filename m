Return-Path: <netdev+bounces-21123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB8776285D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA942281A76
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14BC1118;
	Wed, 26 Jul 2023 01:55:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0F7C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:55:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C1526A6
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690336551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0em5XVVIcyM6KNou+P9LCvLXygArrZQmd/s3crvVHcs=;
	b=LxGa2QllSc70DxKRNgjXuwQPkVNaeG8gbuc2SWkEeM8P8x9uCfMcbLs5HIqc0K7iztcfDu
	bFQnstvmijOQF/1gSrSknZXxN6cAqZC44jqTYEDMt2UfL0tyMTH+zdKNQCEe4jUZEYxQs1
	ljueNjDC+bEfIRi00DAxLjPDJPo2Ehw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-5e9SHElkOIydKZi1YcOUhg-1; Tue, 25 Jul 2023 21:55:50 -0400
X-MC-Unique: 5e9SHElkOIydKZi1YcOUhg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6f51e170fso54371891fa.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690336548; x=1690941348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0em5XVVIcyM6KNou+P9LCvLXygArrZQmd/s3crvVHcs=;
        b=FEtVeLMZmhcr1XeajMMA82OBKpF3F1+UTadXHG95gfjRdu3I9Y0EG9KpBrecvdr0jO
         LIcyBDx/qs0qlg9zOwj6U59paBfmVACJiwAbrjZA7952qiidVqATpDhbQkeSKvkAhdGJ
         zwp+sTFax3fBbbWMeakykrcH4S9nP+cjpWEAcpxPzD8kRTH54miQSDufJXdq2BtJ6Xw3
         frSk4JNPAFhVFSkxn8kGlW8mlrGKYVUhL+yygDGIXdtWGucJ2diWdMZcLWHdODpz9y1Z
         igAEUKwDXmJcvyeC3I9w1yaP8HbYgE3hzKizd9ZJWDAFW1bpWQ9zos/wmaGVVShANKkC
         PxcQ==
X-Gm-Message-State: ABy/qLbXAS20E6J39nEprQ45/8aH/+OIolyL3f8vyCNnrbJqKo9XEW5q
	mPdyTjzGt8KBuZlXxwNkqHb0lSAe4OGqFTZHgHSBUhxA9xRA1Oj30mit/h1uT+jNs5vN1vzoJ7B
	HgUo/XQ2PTUQbOVOpVS9QKRSSTWs9CWAt
X-Received: by 2002:a2e:9d0f:0:b0:2b6:daed:494f with SMTP id t15-20020a2e9d0f000000b002b6daed494fmr314029lji.35.1690336548788;
        Tue, 25 Jul 2023 18:55:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEb2P+4ABxLYFi0inilvrG1ps7zBAn/FmeDid5GoMQIwuWmQTbpZUHaUvKZywmBDEIsiywhW6IQznr6szo/kqs=
X-Received: by 2002:a2e:9d0f:0:b0:2b6:daed:494f with SMTP id
 t15-20020a2e9d0f000000b002b6daed494fmr314017lji.35.1690336548465; Tue, 25 Jul
 2023 18:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com> <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com> <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com> <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com> <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org> <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230725033506-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jul 2023 09:55:37 +0800
Message-ID: <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Shannon Nelson <shannon.nelson@amd.com>, 
	xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 3:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jul 25, 2023 at 11:07:40AM +0800, Jason Wang wrote:
> > On Mon, Jul 24, 2023 at 3:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Jul 24, 2023 at 02:52:05PM +0800, Jason Wang wrote:
> > > > On Sat, Jul 22, 2023 at 4:18=E2=80=AFAM Maxime Coquelin
> > > > <maxime.coquelin@redhat.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote=
:
> > > > > >>
> > > > > >>
> > > > > >> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > >>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wro=
te:
> > > > > >>>>
> > > > > >>>>
> > > > > >>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > >>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wr=
ote:
> > > > > >>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > >>>>>>>
> > > > > >>>>>>> Adding cond_resched() to the command waiting loop for a b=
etter
> > > > > >>>>>>> co-operation with the scheduler. This allows to give CPU =
a breath to
> > > > > >>>>>>> run other task(workqueue) instead of busy looping when pr=
eemption is
> > > > > >>>>>>> not allowed on a device whose CVQ might be slow.
> > > > > >>>>>>>
> > > > > >>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > >>>>>>
> > > > > >>>>>> This still leaves hung processes, but at least it doesn't =
pin the CPU any
> > > > > >>>>>> more.  Thanks.
> > > > > >>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > >>>>>>
> > > > > >>>>>
> > > > > >>>>> I'd like to see a full solution
> > > > > >>>>> 1- block until interrupt
> > > >
> > > > I remember in previous versions, you worried about the extra MSI
> > > > vector. (Maybe I was wrong).
> > > >
> > > > > >>>>
> > > > > >>>> Would it make sense to also have a timeout?
> > > > > >>>> And when timeout expires, set FAILED bit in device status?
> > > > > >>>
> > > > > >>> virtio spec does not set any limits on the timing of vq
> > > > > >>> processing.
> > > > > >>
> > > > > >> Indeed, but I thought the driver could decide it is too long f=
or it.
> > > > > >>
> > > > > >> The issue is we keep waiting with rtnl locked, it can quickly =
make the
> > > > > >> system unusable.
> > > > > >
> > > > > > if this is a problem we should find a way not to keep rtnl
> > > > > > locked indefinitely.
> > > >
> > > > Any ideas on this direction? Simply dropping rtnl during the busy l=
oop
> > > > will result in a lot of races. This seems to require non-trivial
> > > > changes in the networking core.
> > > >
> > > > >
> > > > >  From the tests I have done, I think it is. With OVS, a reconfigu=
ration
> > > > > is performed when the VDUSE device is added, and when a MLX5 devi=
ce is
> > > > > in the same bridge, it ends up doing an ioctl() that tries to tak=
e the
> > > > > rtnl lock. In this configuration, it is not possible to kill OVS =
because
> > > > > it is stuck trying to acquire rtnl lock for mlx5 that is held by =
virtio-
> > > > > net.
> > > >
> > > > Yeah, basically, any RTNL users would be blocked forever.
> > > >
> > > > And the infinite loop has other side effects like it blocks the fre=
ezer to work.
> > > >
> > > > To summarize, there are three issues
> > > >
> > > > 1) busy polling
> > > > 2) breaks freezer
> > > > 3) hold RTNL during the loop
> > > >
> > > > Solving 3 may help somehow for 2 e.g some pm routine e.g wireguard =
or
> > > > even virtnet_restore() itself may try to hold the lock.
> > >
> > > Yep. So my feeling currently is, the only real fix is to actually
> > > queue up the work in software.
> >
> > Do you mean something like:
> >
> > rtnl_lock();
> > queue up the work
> > rtnl_unlock();
> > return success;
> >
> > ?
>
> yes

We will lose the error reporting, is it a real problem or not?

>
>
> > > It's mostly trivial to limit
> > > memory consumption, vid's is the
> > > only one where it would make sense to have more than
> > > 1 command of a given type outstanding.
> >
> > And rx mode so this implies we will fail any command if the previous
> > work is not finished.
>
> don't fail it, store it.

Ok.

Thanks

>
> > > have a tree
> > > or a bitmap with vids to add/remove?
> >
> > Probably.
> >
> > Thanks
> >
> > >
> > >
> > >
> > > > >
> > > > > >
> > > > > >>>>> 2- still handle surprise removal correctly by waking in tha=
t case
> > > >
> > > > This is basically what version 1 did?
> > > >
> > > > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@r=
edhat.com/t/
> > > >
> > > > Thanks
> > >
> > > Yes - except the timeout part.
> > >
> > >
> > > > > >>>>>
> > > > > >>>>>
> > > > > >>>>>
> > > > > >>>>>>> ---
> > > > > >>>>>>>      drivers/net/virtio_net.c | 4 +++-
> > > > > >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >>>>>>>
> > > > > >>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virti=
o_net.c
> > > > > >>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > >>>>>>> --- a/drivers/net/virtio_net.c
> > > > > >>>>>>> +++ b/drivers/net/virtio_net.c
> > > > > >>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(s=
truct virtnet_info *vi, u8 class, u8 cmd,
> > > > > >>>>>>>              * into the hypervisor, so the request should=
 be handled immediately.
> > > > > >>>>>>>              */
> > > > > >>>>>>>             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > >>>>>>> -              !virtqueue_is_broken(vi->cvq))
> > > > > >>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
> > > > > >>>>>>> +               cond_resched();
> > > > > >>>>>>>                     cpu_relax();
> > > > > >>>>>>> +       }
> > > > > >>>>>>>
> > > > > >>>>>>>             return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > > > > >>>>>>>      }
> > > > > >>>>>>> --
> > > > > >>>>>>> 2.39.3
> > > > > >>>>>>>
> > > > > >>>>>>> _______________________________________________
> > > > > >>>>>>> Virtualization mailing list
> > > > > >>>>>>> Virtualization@lists.linux-foundation.org
> > > > > >>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtua=
lization
> > > > > >>>>>
> > > > > >>>
> > > > > >
> > > > >
> > >
>


