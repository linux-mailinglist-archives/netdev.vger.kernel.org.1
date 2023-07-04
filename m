Return-Path: <netdev+bounces-15342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 229F6746E90
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 12:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CEF1C20446
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479BA5667;
	Tue,  4 Jul 2023 10:26:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDDA5664
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 10:26:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5308D171C
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688466370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NACau5wNdfF9cBpcRDB4PdaraQX5g3P3BOInJlILPJs=;
	b=LyoIi8T4rldQbisX2sVXN5hJv33RfctidYIxsP8HzraZjcJmBeGeEJMu/f7cvB8RDrm2vC
	vaWP7tBX6i0Q5a8ReNPPj1fkxYDc7yE/ailRqWCa89l51bG0Zc5Bhwbem2x0s/t1sYo17c
	4ccVugiARVUbjIP4UFb/2/Bn2tUuUGA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-eRYjKrGiMNqmJ6-RyRKW6Q-1; Tue, 04 Jul 2023 06:26:09 -0400
X-MC-Unique: eRYjKrGiMNqmJ6-RyRKW6Q-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-c38a4d22b39so5962751276.0
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 03:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688466369; x=1691058369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NACau5wNdfF9cBpcRDB4PdaraQX5g3P3BOInJlILPJs=;
        b=FfbPICIcUrY5txxqC/35Hb0iMJcKmPYexThK0pvlLExhSNagY4zWTaSGi1YTu1y9Zd
         0+8W+rd4SMSWNjh/065I3mdmnj2vXormWA7fQkY8mlI/IUDtK2JCU4iPRNMdn1GCBdnB
         +jw3uZJhmZpNxKfSwxuqjmw5z4tk33Cq6iKCpbkeuBRKR4Dyfoa1sGJZba+ic2aYtjZo
         sFWDZg6+EZHcLqjck8W33MCyfgYMgUznPxdht2NypastSlJdr5opN01WpA31X2QAHnnu
         OdOdHZIUnt9xkG6tC4sU2E84pMwsJ7590GWKW2ZM7ewmHdPSKF9vs3VHbc5q1I+xBeNj
         WZfg==
X-Gm-Message-State: ABy/qLbeXJfA89+R+fUWgHXOvbPqGkm/l9PSyyVB/FdK4Bc2mBzKzaTf
	9lufrZou0tZRYwLOt8xO/y8FI7b/e2TR/g1LpFJ/nCLKtH2dIGLnXvS0quHxqnO6Wu2bR7sf3zi
	ZEPtz3dWu8AheKc/RpDe9wH0Z9iAc67Az
X-Received: by 2002:a25:6814:0:b0:bfe:bf77:64fd with SMTP id d20-20020a256814000000b00bfebf7764fdmr12220359ybc.12.1688466368791;
        Tue, 04 Jul 2023 03:26:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF+L7YZgpPC1a/i4PKGYiZXN4PzCqEmdcCDCKNBfLZMyqBzpFv+JZ1Og8EWyPBXcp3Fpvqatc6r0dRqi4N1fAA=
X-Received: by 2002:a25:6814:0:b0:bfe:bf77:64fd with SMTP id
 d20-20020a256814000000b00bfebf7764fdmr12220350ybc.12.1688466368546; Tue, 04
 Jul 2023 03:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com> <20230703105022-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230703105022-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 4 Jul 2023 12:25:32 +0200
Message-ID: <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shannon Nelson <shannon.nelson@amd.com>, 
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 3, 2023 at 4:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio P=C3=A9rez wrote:
> > With the current code it is accepted as long as userland send it.
> >
> > Although userland should not set a feature flag that has not been
> > offered to it with VHOST_GET_BACKEND_FEATURES, the current code will no=
t
> > complain for it.
> >
> > Since there is no specific reason for any parent to reject that backend
> > feature bit when it has been proposed, let's control it at vdpa fronten=
d
> > level. Future patches may move this control to the parent driver.
> >
> > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_=
OK backend feature")
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Please do send v3. And again, I don't want to send "after driver ok" hack
> upstream at all, I merged it in next just to give it some testing.
> We want RING_ACCESS_AFTER_KICK or some such.
>

Current devices do not support that semantic. My plan was to convert
it in vp_vdpa if needed, and reuse the current vdpa ops. Sorry if I
was not explicit enough.

The only solution I can see to that is to trap & emulate in the vdpa
(parent?) driver, as talked in virtio-comment. But that complicates
the architecture:
* Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
* Store vq enable state separately, at
vdpa->config->set_vq_ready(true), but not transmit that enable to hw
* Store the doorbell state separately, but do not configure it to the
device directly.

But how to recover if the device cannot configure them at kick time,
for example?

Maybe we can just fail if the parent driver does not support enabling
the vq after DRIVER_OK? That way no new feature flag is needed.

Thanks!

>
> > ---
> > Sent with Fixes: tag pointing to git.kernel.org/pub/scm/linux/kernel/gi=
t/mst
> > commit. Please let me know if I should send a v3 of [1] instead.
> >
> > [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-email-mst@ker=
nel.org/T/
> > ---
> >  drivers/vhost/vdpa.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index e1abf29fed5b..a7e554352351 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl(struct file=
 *filep,
> >  {
> >       struct vhost_vdpa *v =3D filep->private_data;
> >       struct vhost_dev *d =3D &v->vdev;
> > +     const struct vdpa_config_ops *ops =3D v->vdpa->config;
> >       void __user *argp =3D (void __user *)arg;
> >       u64 __user *featurep =3D argp;
> > -     u64 features;
> > +     u64 features, parent_features =3D 0;
> >       long r =3D 0;
> >
> >       if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
> >               if (copy_from_user(&features, featurep, sizeof(features))=
)
> >                       return -EFAULT;
> > +             if (ops->get_backend_features)
> > +                     parent_features =3D ops->get_backend_features(v->=
vdpa);
> >               if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> >                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> >                                BIT_ULL(VHOST_BACKEND_F_RESUME) |
> > -                              BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK)))
> > +                              parent_features))
> >                       return -EOPNOTSUPP;
> >               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> >                    !vhost_vdpa_can_suspend(v))
> > --
> > 2.39.3
>


