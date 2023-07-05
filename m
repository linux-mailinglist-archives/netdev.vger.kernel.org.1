Return-Path: <netdev+bounces-15481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1D747E8D
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 09:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D1C281001
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 07:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B31875;
	Wed,  5 Jul 2023 07:50:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1749137F
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 07:50:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF31705
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688543413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y48ulS/+kKO7p+XK2cdnd8+mcOJFtW4xSVJ9cfRLRCc=;
	b=Dk1UZScpk7GtS8sD/qYXhdbRtqkYU700Sfo24LQxvNHFgKAbJH8JlgwhxpgXC5z9PrdO4D
	yjRwOzx6BimeXp3KP4t3APfAf7I0Wl3y8P7JsZDshRH0hKiPaKUqBXspPkhJOMcI6hwNIk
	seLwmfhGxg9UUa8lUbYfdQP85UHYlE8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-YR3jp4mMOd2iQ3Plu8jolA-1; Wed, 05 Jul 2023 03:50:12 -0400
X-MC-Unique: YR3jp4mMOd2iQ3Plu8jolA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-766fd51ee68so24415885a.0
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 00:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688543412; x=1691135412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y48ulS/+kKO7p+XK2cdnd8+mcOJFtW4xSVJ9cfRLRCc=;
        b=YUiUJb9fzYST659FGUo1o+Euas8FDc+SEGczJQcDKeO5t/Htty5+0E+E8/P3eKJw0b
         O+/2o/mPvcFSmoBdL01gMgst4qInWDArsOuCRLgFsZzoUEMkpNoNWYdmPOPHUcafR4o+
         1hprvZWzGhfQZG/04YVp2jci+jasX/qfM6vBI3TmDj/UNMBOK1a57QVfqfF4b8nQbA7M
         HtMU0m+4K04b5baNl1rvZKhC48wPqBoW6pBAbXG21jQ7T6MU80tfnKj193l+CBaxVvZb
         cQQpeO+9od9HKUVYD7POk6hhMkNlccMTOaah6XVTCuHsHmq/Yy7C4IxLR4zWtEOg+Rdq
         6jMw==
X-Gm-Message-State: ABy/qLbTfAjtYuqhQIasTr86b0kZZZvn9wi7t3ksHe5VaE83XKEvMk5O
	JliJLeqnnG5SQ47dmDbHPqZnuQqYbnpq3MLSnlfZEiNXcpQ35Uu8tPjIFqcwR8j7OKMeOfMJH4R
	ZxKL4OKRwBIFxALJhHx9pI2e+78nAArx2
X-Received: by 2002:a0c:f1ca:0:b0:630:14e0:982e with SMTP id u10-20020a0cf1ca000000b0063014e0982emr1588306qvl.22.1688543412147;
        Wed, 05 Jul 2023 00:50:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECWIUnOY9XKAF+JGyO1WxxEdgi7O/d6naJ/xGAnoeQMVdDnnQISxcvMK2kW8kDBCOg+K1qYyW7lCoiy4kASbU=
X-Received: by 2002:a0c:f1ca:0:b0:630:14e0:982e with SMTP id
 u10-20020a0cf1ca000000b0063014e0982emr1588302qvl.22.1688543411888; Wed, 05
 Jul 2023 00:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com> <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org> <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704114159-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jul 2023 15:49:58 +0800
Message-ID: <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 11:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jul 04, 2023 at 01:36:11PM +0200, Eugenio Perez Martin wrote:
> > On Tue, Jul 4, 2023 at 12:38=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Martin wrote:
> > > > On Mon, Jul 3, 2023 at 4:52=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio P=C3=A9rez wrot=
e:
> > > > > > With the current code it is accepted as long as userland send i=
t.
> > > > > >
> > > > > > Although userland should not set a feature flag that has not be=
en
> > > > > > offered to it with VHOST_GET_BACKEND_FEATURES, the current code=
 will not
> > > > > > complain for it.
> > > > > >
> > > > > > Since there is no specific reason for any parent to reject that=
 backend
> > > > > > feature bit when it has been proposed, let's control it at vdpa=
 frontend
> > > > > > level. Future patches may move this control to the parent drive=
r.
> > > > > >
> > > > > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER=
_DRIVER_OK backend feature")
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > >
> > > > > Please do send v3. And again, I don't want to send "after driver =
ok" hack
> > > > > upstream at all, I merged it in next just to give it some testing=
.
> > > > > We want RING_ACCESS_AFTER_KICK or some such.
> > > > >
> > > >
> > > > Current devices do not support that semantic.
> > >
> > > Which devices specifically access the ring after DRIVER_OK but before
> > > a kick?
> > >
> >
> > Previous versions of the QEMU LM series did a spurious kick to start
> > traffic at the LM destination [1]. When it was proposed, that spurious
> > kick was removed from the series because to check for descriptors
> > after driver_ok, even without a kick, was considered work of the
> > parent driver.
> >
> > I'm ok to go back to this spurious kick, but I'm not sure if the hw
> > will read the ring before the kick actually. I can ask.
> >
> > Thanks!
> >
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-01/msg02775.h=
tml
>
> Let's find out. We need to check for ENABLE_AFTER_DRIVER_OK too, no?

My understanding is [1] assuming ACCESS_AFTER_KICK. This seems
sub-optimal than assuming ENABLE_AFTER_DRIVER_OK.

But this reminds me one thing, as the thread is going too long, I
wonder if we simply assume ENABLE_AFTER_DRIVER_OK if RING_RESET is
supported?

Thanks

>
>
>
> > > > My plan was to convert
> > > > it in vp_vdpa if needed, and reuse the current vdpa ops. Sorry if I
> > > > was not explicit enough.
> > > >
> > > > The only solution I can see to that is to trap & emulate in the vdp=
a
> > > > (parent?) driver, as talked in virtio-comment. But that complicates
> > > > the architecture:
> > > > * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> > > > * Store vq enable state separately, at
> > > > vdpa->config->set_vq_ready(true), but not transmit that enable to h=
w
> > > > * Store the doorbell state separately, but do not configure it to t=
he
> > > > device directly.
> > > >
> > > > But how to recover if the device cannot configure them at kick time=
,
> > > > for example?
> > > >
> > > > Maybe we can just fail if the parent driver does not support enabli=
ng
> > > > the vq after DRIVER_OK? That way no new feature flag is needed.
> > > >
> > > > Thanks!
> > > >
> > > > >
> > > > > > ---
> > > > > > Sent with Fixes: tag pointing to git.kernel.org/pub/scm/linux/k=
ernel/git/mst
> > > > > > commit. Please let me know if I should send a v3 of [1] instead=
.
> > > > > >
> > > > > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-email=
-mst@kernel.org/T/
> > > > > > ---
> > > > > >  drivers/vhost/vdpa.c | 7 +++++--
> > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > index e1abf29fed5b..a7e554352351 100644
> > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl(str=
uct file *filep,
> > > > > >  {
> > > > > >       struct vhost_vdpa *v =3D filep->private_data;
> > > > > >       struct vhost_dev *d =3D &v->vdev;
> > > > > > +     const struct vdpa_config_ops *ops =3D v->vdpa->config;
> > > > > >       void __user *argp =3D (void __user *)arg;
> > > > > >       u64 __user *featurep =3D argp;
> > > > > > -     u64 features;
> > > > > > +     u64 features, parent_features =3D 0;
> > > > > >       long r =3D 0;
> > > > > >
> > > > > >       if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
> > > > > >               if (copy_from_user(&features, featurep, sizeof(fe=
atures)))
> > > > > >                       return -EFAULT;
> > > > > > +             if (ops->get_backend_features)
> > > > > > +                     parent_features =3D ops->get_backend_feat=
ures(v->vdpa);
> > > > > >               if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > > > > >                                BIT_ULL(VHOST_BACKEND_F_SUSPEND)=
 |
> > > > > >                                BIT_ULL(VHOST_BACKEND_F_RESUME) =
|
> > > > > > -                              BIT_ULL(VHOST_BACKEND_F_ENABLE_A=
FTER_DRIVER_OK)))
> > > > > > +                              parent_features))
> > > > > >                       return -EOPNOTSUPP;
> > > > > >               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND))=
 &&
> > > > > >                    !vhost_vdpa_can_suspend(v))
> > > > > > --
> > > > > > 2.39.3
> > > > >
> > >
>


