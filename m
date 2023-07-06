Return-Path: <netdev+bounces-15734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB774970A
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 10:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F5A1C20CE1
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9413A184F;
	Thu,  6 Jul 2023 08:03:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056915BA
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 08:03:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48641121
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688630632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uR4y3omuMdeq94aQV10LDw49xhVeOOuaecbCLxNYkRA=;
	b=US4pwvKy6x9Q8zLbDRv1Op2x1P7ADI4jNJXRPu5pvDHoYFUdyMji6tfzw1GsH32byPSCIy
	3Qe1H8u43Na3yLhZLPedzi6RNsqzX/vWdRTCq/LyqxOIeVouokyhcNdjW93FevTfEQsV0/
	IQPk2LBf34o8qTilMJWvLTP/ksNFafw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-2IX4UbnkNt2vS5oVu6MLZw-1; Thu, 06 Jul 2023 04:03:51 -0400
X-MC-Unique: 2IX4UbnkNt2vS5oVu6MLZw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b701e0bb10so3802091fa.3
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 01:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688630630; x=1691222630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uR4y3omuMdeq94aQV10LDw49xhVeOOuaecbCLxNYkRA=;
        b=el0WPcs7G15T4irZXYwxphxWDGemXAN67+ScLgiN0NvDHjo5GrmJlzlnVizH0rcVKQ
         ZrZRD7EAOrFasIDWWBveKW3RexRaEoyNW2MQO1K+fKDXi+j2sAd99ZGJ32XJzEFJ7x7I
         AOKeeKUnQic/G4lHondhssq2UM3nc6FlO40zZAYapwOySWCOO0aPf7YwxDsBhg2sposa
         Ed12ePu3XczraNNAVYiiSZIZShhNNtfkBm1gR/h4lHofKT0j19lJeIATgQbjjFvfjd4d
         CmIC/kQ4xDy7MpFu1QBLEbMoAaIVl/dS2+nhbAmJ9W1e2T2M3W/CBhrSR0aKQHU39ouu
         I2eg==
X-Gm-Message-State: ABy/qLYwbXCoCcigoQX1J/Nff4/Un9uBfRoB32w9bVx01a9n70BpwxZV
	Nd6SdCwPnWccZu3w8Q3hs9OsrU93bwhFkPIANH9URdOhni+g6MdA2vNvzqlwtT2QIRxW50wL9u/
	UrR/Xd6gEojJupxrDg8Bea8bws7XQ1XSW
X-Received: by 2002:a2e:9591:0:b0:2b4:7380:230 with SMTP id w17-20020a2e9591000000b002b473800230mr759829ljh.13.1688630629803;
        Thu, 06 Jul 2023 01:03:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEs2XjxNnDYt9bsvlBMjZE3fW9f7FULLsL3dT+t9oA/+1JgOYl/i6fgqjaisfA5D3k6EKTaqLBpqg1n2mFUQ/k=
X-Received: by 2002:a2e:9591:0:b0:2b4:7380:230 with SMTP id
 w17-20020a2e9591000000b002b473800230mr759810ljh.13.1688630629454; Thu, 06 Jul
 2023 01:03:49 -0700 (PDT)
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
 <20230705043940-mutt-send-email-mst@kernel.org> <CACGkMEufNZGvWMN9Shh6NPOZOe-vf0RomfS1DX6DtxJjvO7fNA@mail.gmail.com>
 <CAJaqyWcqNkzJXxsoz_Lk_X0CvNW24Ay2Ki6q02EB8iR=qpwsfg@mail.gmail.com> <CACGkMEvDsZcyTDBhS8ekXHyv-kiipyHizewpM2+=0XgSYMsmbw@mail.gmail.com>
In-Reply-To: <CACGkMEvDsZcyTDBhS8ekXHyv-kiipyHizewpM2+=0XgSYMsmbw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jul 2023 16:03:37 +0800
Message-ID: <CACGkMEuKNXCSWWqDTZQpogHqT1K=rsQMFAYxL6OC8OL=XeU3-g@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shannon Nelson <shannon.nelson@amd.com>, virtualization@lists.linux-foundation.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 3:55=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Jul 6, 2023 at 3:06=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Thu, Jul 6, 2023 at 3:55=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Wed, Jul 5, 2023 at 4:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > > >
> > > > On Wed, Jul 05, 2023 at 03:49:58PM +0800, Jason Wang wrote:
> > > > > On Tue, Jul 4, 2023 at 11:45=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 04, 2023 at 01:36:11PM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > On Tue, Jul 4, 2023 at 12:38=E2=80=AFPM Michael S. Tsirkin <m=
st@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Mar=
tin wrote:
> > > > > > > > > On Mon, Jul 3, 2023 at 4:52=E2=80=AFPM Michael S. Tsirkin=
 <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio P=C3=
=A9rez wrote:
> > > > > > > > > > > With the current code it is accepted as long as userl=
and send it.
> > > > > > > > > > >
> > > > > > > > > > > Although userland should not set a feature flag that =
has not been
> > > > > > > > > > > offered to it with VHOST_GET_BACKEND_FEATURES, the cu=
rrent code will not
> > > > > > > > > > > complain for it.
> > > > > > > > > > >
> > > > > > > > > > > Since there is no specific reason for any parent to r=
eject that backend
> > > > > > > > > > > feature bit when it has been proposed, let's control =
it at vdpa frontend
> > > > > > > > > > > level. Future patches may move this control to the pa=
rent driver.
> > > > > > > > > > >
> > > > > > > > > > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_EN=
ABLE_AFTER_DRIVER_OK backend feature")
> > > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.co=
m>
> > > > > > > > > >
> > > > > > > > > > Please do send v3. And again, I don't want to send "aft=
er driver ok" hack
> > > > > > > > > > upstream at all, I merged it in next just to give it so=
me testing.
> > > > > > > > > > We want RING_ACCESS_AFTER_KICK or some such.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Current devices do not support that semantic.
> > > > > > > >
> > > > > > > > Which devices specifically access the ring after DRIVER_OK =
but before
> > > > > > > > a kick?
> > > > > > > >
> > > > > > >
> > > > > > > Previous versions of the QEMU LM series did a spurious kick t=
o start
> > > > > > > traffic at the LM destination [1]. When it was proposed, that=
 spurious
> > > > > > > kick was removed from the series because to check for descrip=
tors
> > > > > > > after driver_ok, even without a kick, was considered work of =
the
> > > > > > > parent driver.
> > > > > > >
> > > > > > > I'm ok to go back to this spurious kick, but I'm not sure if =
the hw
> > > > > > > will read the ring before the kick actually. I can ask.
> > > > > > >
> > > > > > > Thanks!
> > > > > > >
> > > > > > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-01/=
msg02775.html
> > > > > >
> > > > > > Let's find out. We need to check for ENABLE_AFTER_DRIVER_OK too=
, no?
> > > > >
> > > > > My understanding is [1] assuming ACCESS_AFTER_KICK. This seems
> > > > > sub-optimal than assuming ENABLE_AFTER_DRIVER_OK.
> > > > >
> > > > > But this reminds me one thing, as the thread is going too long, I
> > > > > wonder if we simply assume ENABLE_AFTER_DRIVER_OK if RING_RESET i=
s
> > > > > supported?
> > > > >
> > > > > Thanks
> > > >
> > > > I don't see what does one have to do with another ...
> > > >
> > > > I think with RING_RESET we had another solution, enable rings
> > > > mapping them to a zero page, then reset and re-enable later.
> > >
> > > As discussed before, this seems to have some problems:
> > >
> > > 1) The behaviour is not clarified in the document
> > > 2) zero is a valid IOVA
> > >
> >
> > I think we're not on the same page here.
> >
> > As I understood, rings mapped to a zero page means essentially an
> > avail ring whose avail_idx is always 0, offered to the device instead
> > of the guest's ring. Once all CVQ commands are processed, we use
> > RING_RESET to switch to the right ring, being guest's or SVQ vring.
>
> I get this. This seems more complicated in the destination: shadow vq + A=
SID?

So it's something like:

1) set all vq ASID to shadow virtqueue
2) do not add any bufs to data qp (stick 0 as avail index)
3) start to restore states via cvq
4) ring_rest for dataqp
5) set_vq_state for dataqp
6) re-initialize dataqp address etc
7) set data QP ASID to guest
8) set queue_enable

?

Thanks

>
> Thanks
>
> >
> >
> >
> > > Thanks
> > >
> > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > > > My plan was to convert
> > > > > > > > > it in vp_vdpa if needed, and reuse the current vdpa ops. =
Sorry if I
> > > > > > > > > was not explicit enough.
> > > > > > > > >
> > > > > > > > > The only solution I can see to that is to trap & emulate =
in the vdpa
> > > > > > > > > (parent?) driver, as talked in virtio-comment. But that c=
omplicates
> > > > > > > > > the architecture:
> > > > > > > > > * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> > > > > > > > > * Store vq enable state separately, at
> > > > > > > > > vdpa->config->set_vq_ready(true), but not transmit that e=
nable to hw
> > > > > > > > > * Store the doorbell state separately, but do not configu=
re it to the
> > > > > > > > > device directly.
> > > > > > > > >
> > > > > > > > > But how to recover if the device cannot configure them at=
 kick time,
> > > > > > > > > for example?
> > > > > > > > >
> > > > > > > > > Maybe we can just fail if the parent driver does not supp=
ort enabling
> > > > > > > > > the vq after DRIVER_OK? That way no new feature flag is n=
eeded.
> > > > > > > > >
> > > > > > > > > Thanks!
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > > Sent with Fixes: tag pointing to git.kernel.org/pub/s=
cm/linux/kernel/git/mst
> > > > > > > > > > > commit. Please let me know if I should send a v3 of [=
1] instead.
> > > > > > > > > > >
> > > > > > > > > > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-=
send-email-mst@kernel.org/T/
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/vhost/vdpa.c | 7 +++++--
> > > > > > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdp=
a.c
> > > > > > > > > > > index e1abf29fed5b..a7e554352351 100644
> > > > > > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > > > > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked=
_ioctl(struct file *filep,
> > > > > > > > > > >  {
> > > > > > > > > > >       struct vhost_vdpa *v =3D filep->private_data;
> > > > > > > > > > >       struct vhost_dev *d =3D &v->vdev;
> > > > > > > > > > > +     const struct vdpa_config_ops *ops =3D v->vdpa->=
config;
> > > > > > > > > > >       void __user *argp =3D (void __user *)arg;
> > > > > > > > > > >       u64 __user *featurep =3D argp;
> > > > > > > > > > > -     u64 features;
> > > > > > > > > > > +     u64 features, parent_features =3D 0;
> > > > > > > > > > >       long r =3D 0;
> > > > > > > > > > >
> > > > > > > > > > >       if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
> > > > > > > > > > >               if (copy_from_user(&features, featurep,=
 sizeof(features)))
> > > > > > > > > > >                       return -EFAULT;
> > > > > > > > > > > +             if (ops->get_backend_features)
> > > > > > > > > > > +                     parent_features =3D ops->get_ba=
ckend_features(v->vdpa);
> > > > > > > > > > >               if (features & ~(VHOST_VDPA_BACKEND_FEA=
TURES |
> > > > > > > > > > >                                BIT_ULL(VHOST_BACKEND_=
F_SUSPEND) |
> > > > > > > > > > >                                BIT_ULL(VHOST_BACKEND_=
F_RESUME) |
> > > > > > > > > > > -                              BIT_ULL(VHOST_BACKEND_=
F_ENABLE_AFTER_DRIVER_OK)))
> > > > > > > > > > > +                              parent_features))
> > > > > > > > > > >                       return -EOPNOTSUPP;
> > > > > > > > > > >               if ((features & BIT_ULL(VHOST_BACKEND_F=
_SUSPEND)) &&
> > > > > > > > > > >                    !vhost_vdpa_can_suspend(v))
> > > > > > > > > > > --
> > > > > > > > > > > 2.39.3
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> > >
> >


