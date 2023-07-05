Return-Path: <netdev+bounces-15482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB743747EB2
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 09:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08513280FC9
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AE91C30;
	Wed,  5 Jul 2023 07:57:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145B186D
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 07:57:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7990A133
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 00:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688543820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JchDhPT3KR3iSA029I0+obQ1cLL2Ob33e0q6YR+m51M=;
	b=GDxMvrWsztBDydRtJPUZGJVBMPZ9cmGwXrJJrIdtyLwZPKHoDpDmvajxsofwxUimhAhHAW
	hQvvSoLkIWDIRPlFuniSBg0OLj9rGc5PefjGB7gZ0Qr9xg60vJEAVY1vlOYJvVMPRC0g9M
	ELs7gJ+5SeVPKvei+Kz4eHacDGtdvGs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-BbAztlfBMOyUjURSx4O5bg-1; Wed, 05 Jul 2023 03:55:36 -0400
X-MC-Unique: BbAztlfBMOyUjURSx4O5bg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635d9e482f1so64800346d6.1
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 00:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688543736; x=1691135736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JchDhPT3KR3iSA029I0+obQ1cLL2Ob33e0q6YR+m51M=;
        b=ZSRdBzu1efkLL7eiIN5m3r/16Q3fknMWaw6UXNRHAVKEHoaQGRnQ1yavztYMLvUPSv
         uk830/VnFFZzEXGXVMcjUR+8t7CuT+QMCD0RrfZxIwnlF2RGbjnS3IN2jyfXUPa1Y00S
         8F/eryHqMhLdA+Dqns//W26pOKOjalwbbBHYz66tQZtaZSwqyhFm7irFP/X1wFCvXfU/
         vap4bcW9slqzTp0AsG9jbEP5BV2nsR1e8CQ5V8HqiIqsyfrKUqNllFfZNt1vB1HKXJ0o
         St98M80lzBHNMiSafr5HsQA/CjgSezhxkbARJipaNb4y7fuj/4ar3gZHRmKxpwUUniBm
         IJow==
X-Gm-Message-State: ABy/qLZh6i72ca3gXIFdwaWuc4h0l3vCflq29Qp/u7iHLZxSIKWFNL23
	bDsOCXN4lQjTJIp38UULpLdMpE8vEO6FATwBfbYkeavS4k/qu2JpEyDPe64zGELwhNbkJ8gTuSx
	HWmSkoTFg6FxwjYiA2I7nYMN1xesftSq+
X-Received: by 2002:a0c:e9c7:0:b0:632:301e:62fc with SMTP id q7-20020a0ce9c7000000b00632301e62fcmr14553359qvo.35.1688543736083;
        Wed, 05 Jul 2023 00:55:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqduiWcmunoNBMAdWzr6PpWjNwv7fXWO8C6/ME3RHNm2xO9+3sdoOnnjp1VMMQRCem4bpXAtZUe/vemaJ32+g=
X-Received: by 2002:a0c:e9c7:0:b0:632:301e:62fc with SMTP id
 q7-20020a0ce9c7000000b00632301e62fcmr14553352qvo.35.1688543735859; Wed, 05
 Jul 2023 00:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com> <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com> <20230704063646-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704063646-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jul 2023 15:55:23 +0800
Message-ID: <CACGkMEvT4Y+-wfhyi324Y5hhAtn+ZF7cP9d=omdH-ZgdJ-4SOQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shannon Nelson <shannon.nelson@amd.com>, 
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 6:38=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Martin wrote:
> > On Mon, Jul 3, 2023 at 4:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio P=C3=A9rez wrote:
> > > > With the current code it is accepted as long as userland send it.
> > > >
> > > > Although userland should not set a feature flag that has not been
> > > > offered to it with VHOST_GET_BACKEND_FEATURES, the current code wil=
l not
> > > > complain for it.
> > > >
> > > > Since there is no specific reason for any parent to reject that bac=
kend
> > > > feature bit when it has been proposed, let's control it at vdpa fro=
ntend
> > > > level. Future patches may move this control to the parent driver.
> > > >
> > > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK backend feature")
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >
> > > Please do send v3. And again, I don't want to send "after driver ok" =
hack
> > > upstream at all, I merged it in next just to give it some testing.
> > > We want RING_ACCESS_AFTER_KICK or some such.
> > >
> >
> > Current devices do not support that semantic.
>
> Which devices specifically access the ring after DRIVER_OK but before
> a kick?

Vhost-net is one example at last. It polls a socket as well, so it
starts to access the ring immediately after DRIVER_OK.

Thanks

>
> > My plan was to convert
> > it in vp_vdpa if needed, and reuse the current vdpa ops. Sorry if I
> > was not explicit enough.
> >
> > The only solution I can see to that is to trap & emulate in the vdpa
> > (parent?) driver, as talked in virtio-comment. But that complicates
> > the architecture:
> > * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> > * Store vq enable state separately, at
> > vdpa->config->set_vq_ready(true), but not transmit that enable to hw
> > * Store the doorbell state separately, but do not configure it to the
> > device directly.
> >
> > But how to recover if the device cannot configure them at kick time,
> > for example?
> >
> > Maybe we can just fail if the parent driver does not support enabling
> > the vq after DRIVER_OK? That way no new feature flag is needed.
> >
> > Thanks!
> >
> > >
> > > > ---
> > > > Sent with Fixes: tag pointing to git.kernel.org/pub/scm/linux/kerne=
l/git/mst
> > > > commit. Please let me know if I should send a v3 of [1] instead.
> > > >
> > > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-email-mst=
@kernel.org/T/
> > > > ---
> > > >  drivers/vhost/vdpa.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > index e1abf29fed5b..a7e554352351 100644
> > > > --- a/drivers/vhost/vdpa.c
> > > > +++ b/drivers/vhost/vdpa.c
> > > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl(struct =
file *filep,
> > > >  {
> > > >       struct vhost_vdpa *v =3D filep->private_data;
> > > >       struct vhost_dev *d =3D &v->vdev;
> > > > +     const struct vdpa_config_ops *ops =3D v->vdpa->config;
> > > >       void __user *argp =3D (void __user *)arg;
> > > >       u64 __user *featurep =3D argp;
> > > > -     u64 features;
> > > > +     u64 features, parent_features =3D 0;
> > > >       long r =3D 0;
> > > >
> > > >       if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
> > > >               if (copy_from_user(&features, featurep, sizeof(featur=
es)))
> > > >                       return -EFAULT;
> > > > +             if (ops->get_backend_features)
> > > > +                     parent_features =3D ops->get_backend_features=
(v->vdpa);
> > > >               if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > > >                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > > >                                BIT_ULL(VHOST_BACKEND_F_RESUME) |
> > > > -                              BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER=
_DRIVER_OK)))
> > > > +                              parent_features))
> > > >                       return -EOPNOTSUPP;
> > > >               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > >                    !vhost_vdpa_can_suspend(v))
> > > > --
> > > > 2.39.3
> > >
>


