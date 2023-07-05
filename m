Return-Path: <netdev+bounces-15618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09816748BD1
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263BB1C20BCE
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726214A97;
	Wed,  5 Jul 2023 18:28:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4831134A7
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 18:28:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3AFE1
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688581678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMZds0wi1UTsS0FUwNFQbHz46c8LCZrpEle71cju5wE=;
	b=QNMu+lGQ7a9DgunzcF0lYJhYElnb0DZKe1xHXKELX1XQUB6ZIi2yDiFDvZZ7w+NZcZnAI9
	BQNMDDGoQzso8VSCyUBcKIXcp5soUxprFstffnG0938iNldM1uHow226usFapmQzdw9/8X
	mrVuK2QfC1xdvD2UqoSib27ECpROiKQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-oUqjNGXwOjSbVAhIu5eyFg-1; Wed, 05 Jul 2023 14:27:57 -0400
X-MC-Unique: oUqjNGXwOjSbVAhIu5eyFg-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-bfae0f532e4so7141594276.2
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 11:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688581676; x=1691173676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMZds0wi1UTsS0FUwNFQbHz46c8LCZrpEle71cju5wE=;
        b=b0WAUL+moI0chlajF38kFiyhyPMNQdy5kk1vktzX67zh+h02Y5JxF4NYNbIA7BGWCh
         tpMj3bV/5whiHxqVdVZtmNbU4y8fo/px2kgXmLSHrA3eibTlPaIlloTUsVMQyY6etR8T
         mwOh5EGUIpKa9d2/+s6xb9Rg0KUk+QutZo40SJxNEHjaub3oclwu6nbpp3x6qzuAV3+6
         lboKD7pChhNeSmj0ULwW0sktCRPesJQPuDk1NKeyDIhtEP3zqIJMSUea+8m4TOqzd/Rg
         hQx3ktLjo5iLyWjq/NLY0eOFssOjNbzH9BSaamv1XI6mUFH2YRx5tC56nbuaweUwip8u
         FUHQ==
X-Gm-Message-State: ABy/qLbb3+qZzN3r7t2RNwZ6ZHsoG/IuSVLMsp7IFNNcS8MpSZGt4hEM
	jbMo4stEnbDvpAHouCA/oO3QWhbqWt6uC8o9+662m0tS5cy5mzLE47PivawanmQN4xFTZc/Z3tE
	qCgj8rSkCJesuVrjqchLR+ggJKIRimeRE
X-Received: by 2002:a25:f309:0:b0:c4c:af97:d649 with SMTP id c9-20020a25f309000000b00c4caf97d649mr10261780ybs.38.1688581676300;
        Wed, 05 Jul 2023 11:27:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVD0/f72lvQQ/uCerfOmsg61RewbBZB6TMSt3T6GjJFk/CPDsxV8+Lpqdj2HFwruFhkb4i+8Y9uJXcQSftE0E=
X-Received: by 2002:a25:f309:0:b0:c4c:af97:d649 with SMTP id
 c9-20020a25f309000000b00c4caf97d649mr10261773ybs.38.1688581676010; Wed, 05
 Jul 2023 11:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com> <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org> <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org> <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
In-Reply-To: <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 5 Jul 2023 20:27:19 +0200
Message-ID: <CAJaqyWd0QC6x9WHBT0x9beZyC8ZrF2y=d9HvmT0+05RtGc8_og@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shannon Nelson <shannon.nelson@amd.com>, virtualization@lists.linux-foundation.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 9:50=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Jul 4, 2023 at 11:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Tue, Jul 04, 2023 at 01:36:11PM +0200, Eugenio Perez Martin wrote:
> > > On Tue, Jul 4, 2023 at 12:38=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Martin wrot=
e:
> > > > > On Mon, Jul 3, 2023 at 4:52=E2=80=AFPM Michael S. Tsirkin <mst@re=
dhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio P=C3=A9rez wr=
ote:
> > > > > > > With the current code it is accepted as long as userland send=
 it.
> > > > > > >
> > > > > > > Although userland should not set a feature flag that has not =
been
> > > > > > > offered to it with VHOST_GET_BACKEND_FEATURES, the current co=
de will not
> > > > > > > complain for it.
> > > > > > >
> > > > > > > Since there is no specific reason for any parent to reject th=
at backend
> > > > > > > feature bit when it has been proposed, let's control it at vd=
pa frontend
> > > > > > > level. Future patches may move this control to the parent dri=
ver.
> > > > > > >
> > > > > > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFT=
ER_DRIVER_OK backend feature")
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > >
> > > > > > Please do send v3. And again, I don't want to send "after drive=
r ok" hack
> > > > > > upstream at all, I merged it in next just to give it some testi=
ng.
> > > > > > We want RING_ACCESS_AFTER_KICK or some such.
> > > > > >
> > > > >
> > > > > Current devices do not support that semantic.
> > > >
> > > > Which devices specifically access the ring after DRIVER_OK but befo=
re
> > > > a kick?
> > > >
> > >
> > > Previous versions of the QEMU LM series did a spurious kick to start
> > > traffic at the LM destination [1]. When it was proposed, that spuriou=
s
> > > kick was removed from the series because to check for descriptors
> > > after driver_ok, even without a kick, was considered work of the
> > > parent driver.
> > >
> > > I'm ok to go back to this spurious kick, but I'm not sure if the hw
> > > will read the ring before the kick actually. I can ask.
> > >
> > > Thanks!
> > >
> > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-01/msg02775=
.html
> >
> > Let's find out. We need to check for ENABLE_AFTER_DRIVER_OK too, no?
>
> My understanding is [1] assuming ACCESS_AFTER_KICK. This seems
> sub-optimal than assuming ENABLE_AFTER_DRIVER_OK.
>
> But this reminds me one thing, as the thread is going too long, I
> wonder if we simply assume ENABLE_AFTER_DRIVER_OK if RING_RESET is
> supported?
>

The problem with that is that the device needs to support all
RING_RESET, like to be able to change vq address etc after DRIVER_OK.
Not all HW support it.

We just need the subset of having the dataplane freezed until all CVQ
commands have been consumed. I'm sure current vDPA code already
supports it in some devices, like MLX and PSD.

Thanks!

> Thanks
>
> >
> >
> >
> > > > > My plan was to convert
> > > > > it in vp_vdpa if needed, and reuse the current vdpa ops. Sorry if=
 I
> > > > > was not explicit enough.
> > > > >
> > > > > The only solution I can see to that is to trap & emulate in the v=
dpa
> > > > > (parent?) driver, as talked in virtio-comment. But that complicat=
es
> > > > > the architecture:
> > > > > * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> > > > > * Store vq enable state separately, at
> > > > > vdpa->config->set_vq_ready(true), but not transmit that enable to=
 hw
> > > > > * Store the doorbell state separately, but do not configure it to=
 the
> > > > > device directly.
> > > > >
> > > > > But how to recover if the device cannot configure them at kick ti=
me,
> > > > > for example?
> > > > >
> > > > > Maybe we can just fail if the parent driver does not support enab=
ling
> > > > > the vq after DRIVER_OK? That way no new feature flag is needed.
> > > > >
> > > > > Thanks!
> > > > >
> > > > > >
> > > > > > > ---
> > > > > > > Sent with Fixes: tag pointing to git.kernel.org/pub/scm/linux=
/kernel/git/mst
> > > > > > > commit. Please let me know if I should send a v3 of [1] inste=
ad.
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-ema=
il-mst@kernel.org/T/
> > > > > > > ---
> > > > > > >  drivers/vhost/vdpa.c | 7 +++++--
> > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > > index e1abf29fed5b..a7e554352351 100644
> > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl(s=
truct file *filep,
> > > > > > >  {
> > > > > > >       struct vhost_vdpa *v =3D filep->private_data;
> > > > > > >       struct vhost_dev *d =3D &v->vdev;
> > > > > > > +     const struct vdpa_config_ops *ops =3D v->vdpa->config;
> > > > > > >       void __user *argp =3D (void __user *)arg;
> > > > > > >       u64 __user *featurep =3D argp;
> > > > > > > -     u64 features;
> > > > > > > +     u64 features, parent_features =3D 0;
> > > > > > >       long r =3D 0;
> > > > > > >
> > > > > > >       if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
> > > > > > >               if (copy_from_user(&features, featurep, sizeof(=
features)))
> > > > > > >                       return -EFAULT;
> > > > > > > +             if (ops->get_backend_features)
> > > > > > > +                     parent_features =3D ops->get_backend_fe=
atures(v->vdpa);
> > > > > > >               if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > > > > > >                                BIT_ULL(VHOST_BACKEND_F_SUSPEN=
D) |
> > > > > > >                                BIT_ULL(VHOST_BACKEND_F_RESUME=
) |
> > > > > > > -                              BIT_ULL(VHOST_BACKEND_F_ENABLE=
_AFTER_DRIVER_OK)))
> > > > > > > +                              parent_features))
> > > > > > >                       return -EOPNOTSUPP;
> > > > > > >               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND=
)) &&
> > > > > > >                    !vhost_vdpa_can_suspend(v))
> > > > > > > --
> > > > > > > 2.39.3
> > > > > >
> > > >
> >
>


