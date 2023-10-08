Return-Path: <netdev+bounces-38858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA27BCC57
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 07:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0171281BE8
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 05:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB94405;
	Sun,  8 Oct 2023 05:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnX+nb+E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A61FC8
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 05:27:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE43B6
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 22:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696742841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3DuPJ39xeiBlF91sjgXQDqI4pW2tcIwSz1HEGAz2Ig=;
	b=QnX+nb+E5G6xGnsp3qHXQC76MW9n1Q67LmqtGlzZNXFk6y71GEGn+RJdgHa8mYatPAAj6V
	B6LBZUQCOehLVEzd32jCD4THZj5c0kjZsX3HDmUxPmB0dIiSSLX0cfQVsJtq0gXvmRZZaY
	jTLxq3qFrMSZay7sgudBbQMmIQJ/jzQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Pot6HcC0OLm6AVMcPnBNQQ-1; Sun, 08 Oct 2023 01:27:19 -0400
X-MC-Unique: Pot6HcC0OLm6AVMcPnBNQQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5039413f4f9so286172e87.1
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 22:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742838; x=1697347638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3DuPJ39xeiBlF91sjgXQDqI4pW2tcIwSz1HEGAz2Ig=;
        b=YCXvVx9XtR710+tsSxIbTVq3h0gZSG/jYvhA9ja2aW8Cx/mvfzvNIw5CRpToh/E7Tg
         K4SF771QdC471rrVSzzkkoNJkTJxLOw5Mm6tDhZtXxecNh/4sE7SOjsyZ3JUNKTiJH9d
         FSt+6LhohqE+/IsYBJo4lQTH6r+AruifP9dSrnOTHZOp+0a7xXUcxzvTiLXOxtm3lllb
         KkX8ABdpI/JhIk99hrkMKxrB2Yg/cSgxPyxgOVeYvoQajnxQg4/WqArxPYKrfUs86yju
         sp73oxfFNYballbnkZsxOt8NyLkx52mNKryffi8B99nTpuCaddSpYKVhHNFojq6RbMJw
         fyjg==
X-Gm-Message-State: AOJu0YxIELy+k68izegU7LpYpeJ7LXf2QrdZ24kFlXPUzkQ3QVRKTa48
	Q/7I0r9rq9jIylidHZQIoD7MORJPB+oP43iVut1xOyKkc1gpsvFs3Ydk/AVvgPQEdh6BSL2/FIL
	6XpX5cDQ0by1nZI8aX6jdqKTDQ8uyBw8WxNqwbV0cvVI=
X-Received: by 2002:a05:6512:368f:b0:503:985:92c4 with SMTP id d15-20020a056512368f00b00503098592c4mr7934097lfs.52.1696742837926;
        Sat, 07 Oct 2023 22:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMa2p6V6+riZ57fai8dszQFUDJBLDu4ck4IBBLRSz2HlKqrTV0/fRhma2yZ51X8S2Jkm2PqX8hsV3uxBIUl64=
X-Received: by 2002:a05:6512:368f:b0:503:985:92c4 with SMTP id
 d15-20020a056512368f00b00503098592c4mr7934089lfs.52.1696742837587; Sat, 07
 Oct 2023 22:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720083839.481487-1-jasowang@redhat.com> <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com> <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com> <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com> <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com> <20230723053441-mutt-send-email-mst@kernel.org>
 <4d025b89-fa7a-df4b-37d0-96814a2d2bcb@nvidia.com>
In-Reply-To: <4d025b89-fa7a-df4b-37d0-96814a2d2bcb@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 13:27:06 +0800
Message-ID: <CACGkMEvu3hi_D6Y0uqc5GVvdi6TNe-Q1WFie9f=7mVabqO6YvA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: Feng Liu <feliu@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, kuba@kernel.org, 
	Bodong Wang <bodong@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 3:35=E2=80=AFAM Feng Liu <feliu@nvidia.com> wrote:
>
>
>
> On 2023-07-24 a.m.2:46, Michael S. Tsirkin wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Fri, Jul 21, 2023 at 10:18:03PM +0200, Maxime Coquelin wrote:
> >>
> >>
> >> On 7/21/23 17:10, Michael S. Tsirkin wrote:
> >>> On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> >>>>
> >>>>
> >>>> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> >>>>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> >>>>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> >>>>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
> >>>>>>>>>
> >>>>>>>>> Adding cond_resched() to the command waiting loop for a better
> >>>>>>>>> co-operation with the scheduler. This allows to give CPU a brea=
th to
> >>>>>>>>> run other task(workqueue) instead of busy looping when preempti=
on is
> >>>>>>>>> not allowed on a device whose CVQ might be slow.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>>>>>>
> >>>>>>>> This still leaves hung processes, but at least it doesn't pin th=
e CPU any
> >>>>>>>> more.  Thanks.
> >>>>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> >>>>>>>>
> >>>>>>>
> >>>>>>> I'd like to see a full solution
> >>>>>>> 1- block until interrupt
> >>>>>>
> >>>>>> Would it make sense to also have a timeout?
> >>>>>> And when timeout expires, set FAILED bit in device status?
> >>>>>
> >>>>> virtio spec does not set any limits on the timing of vq
> >>>>> processing.
> >>>>
> >>>> Indeed, but I thought the driver could decide it is too long for it.
> >>>>
> >>>> The issue is we keep waiting with rtnl locked, it can quickly make t=
he
> >>>> system unusable.
> >>>
> >>> if this is a problem we should find a way not to keep rtnl
> >>> locked indefinitely.
> >>
> >>  From the tests I have done, I think it is. With OVS, a reconfiguratio=
n is
> >> performed when the VDUSE device is added, and when a MLX5 device is
> >> in the same bridge, it ends up doing an ioctl() that tries to take the
> >> rtnl lock. In this configuration, it is not possible to kill OVS becau=
se
> >> it is stuck trying to acquire rtnl lock for mlx5 that is held by virti=
o-
> >> net.
> >
> > So for sure, we can queue up the work and process it later.
> > The somewhat tricky part is limiting the memory consumption.
> >
> >
>
>
> Hi Jason
>
> Excuse me, is there any plan for when will v5 patch series be sent out?
> Will the v5 patches solve the problem of ctrlvq's infinite poll for
> buggy devices?

We agree to harden VDUSE and,

It would be hard if we try to solve it at the virtio-net level, see
the discussions before. It might require support from various layers
(e.g networking core etc).

We can use workqueue etc as a mitigation. If Michael is fine with
this, I can post v5.

Thanks

>
> Thanks
> Feng
>
> >>>
> >>>>>>> 2- still handle surprise removal correctly by waking in that case
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>>> ---
> >>>>>>>>>       drivers/net/virtio_net.c | 4 +++-
> >>>>>>>>>       1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.=
c
> >>>>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
> >>>>>>>>> --- a/drivers/net/virtio_net.c
> >>>>>>>>> +++ b/drivers/net/virtio_net.c
> >>>>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct =
virtnet_info *vi, u8 class, u8 cmd,
> >>>>>>>>>               * into the hypervisor, so the request should be h=
andled immediately.
> >>>>>>>>>               */
> >>>>>>>>>              while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> >>>>>>>>> -              !virtqueue_is_broken(vi->cvq))
> >>>>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
> >>>>>>>>> +               cond_resched();
> >>>>>>>>>                      cpu_relax();
> >>>>>>>>> +       }
> >>>>>>>>>
> >>>>>>>>>              return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> >>>>>>>>>       }
> >>>>>>>>> --
> >>>>>>>>> 2.39.3
> >>>>>>>>>
> >>>>>>>>> _______________________________________________
> >>>>>>>>> Virtualization mailing list
> >>>>>>>>> Virtualization@lists.linux-foundation.org
> >>>>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualizati=
on
> >>>>>>>
> >>>>>
> >>>
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>


