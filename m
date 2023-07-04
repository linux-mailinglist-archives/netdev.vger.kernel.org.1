Return-Path: <netdev+bounces-15400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A47747589
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A1A280ED9
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA586AAC;
	Tue,  4 Jul 2023 15:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48663C2
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:45:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8121FE76
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688485518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PUI+CtLNs4l2I0+iAQpXHNnM5sim5Or6js9Z3l/FyQ=;
	b=BwlKMqEujySN5qmw+K5Ji2A/Mzspe0yZk0QIdbBhKkUYclIY449s27xavVxf/f22rOYcs2
	Aj8GJ/vr5+Oy8b4+tT70dnirtcdptqtsAS9iZI9o4xCQVEDDFjmA7neUMmIZ5HY4VJ1Nkb
	YwLyJczOgVm4IRoFmJOGvhnVIF6zUMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-HEx3O3STO5uruQYqbxW25Q-1; Tue, 04 Jul 2023 11:45:17 -0400
X-MC-Unique: HEx3O3STO5uruQYqbxW25Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3143c941d0bso716912f8f.1
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 08:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485516; x=1691077516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PUI+CtLNs4l2I0+iAQpXHNnM5sim5Or6js9Z3l/FyQ=;
        b=ITyfI3TdGx/Vo79TWBoRosgN0cvIz3lHQVzXz9jl7pIRieuPQW62i+VAR+9i/t96m+
         621IjWd4HpW19BYKyHFD0umF59tlGwm+EOcSwav8CJH6TKuVX7OU4zSChyS3LM5r3VjL
         QFMFP+EuMj93DiOpBYhe2Q77nb3r00q8BUkTfCr2Mb07ZYqijt8Q1yTlmM3jQBYyGknz
         RPnlaWeyT6d4NVC4y1zt2uXWYtEGHXXgF0Ve9D/Ry8RVyciHxjIFnwH/hrPMETJQqcE2
         iDq2AVogjDr0WlfTdQamI8vHFF/ZIUHqLtqYbikCdffugeNTHGdtHVaozEaiR5hxIqbd
         Jv8w==
X-Gm-Message-State: ABy/qLbJ03HDz1JIxWqF6P+aebEAUDY4CZD+nJiZY8KFaQVIGv+bqKdX
	hX38ZrcvRtkpRpABwII4iEZP3FMsqvaN7Fp2XahglGiFNuprG6nfuYtVznfFW9eGTISDc+5g3oC
	glhffn2m95KZ6RkpUGofjtPrG
X-Received: by 2002:a5d:674d:0:b0:314:13d8:8ae7 with SMTP id l13-20020a5d674d000000b0031413d88ae7mr11780930wrw.26.1688485516324;
        Tue, 04 Jul 2023 08:45:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGHQsomKCUqerVJHD/653LO914nQ9p0VRaFIwyfELGloTwcXrjzg/w2GewNcsvZX5Lc+3kg9A==
X-Received: by 2002:a5d:674d:0:b0:314:13d8:8ae7 with SMTP id l13-20020a5d674d000000b0031413d88ae7mr11780912wrw.26.1688485515962;
        Tue, 04 Jul 2023 08:45:15 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003fbe43238c6sm914770wmi.9.2023.07.04.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:45:15 -0700 (PDT)
Date: Tue, 4 Jul 2023 11:45:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230704114159-mutt-send-email-mst@kernel.org>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 01:36:11PM +0200, Eugenio Perez Martin wrote:
> On Tue, Jul 4, 2023 at 12:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Martin wrote:
> > > On Mon, Jul 3, 2023 at 4:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio Pérez wrote:
> > > > > With the current code it is accepted as long as userland send it.
> > > > >
> > > > > Although userland should not set a feature flag that has not been
> > > > > offered to it with VHOST_GET_BACKEND_FEATURES, the current code will not
> > > > > complain for it.
> > > > >
> > > > > Since there is no specific reason for any parent to reject that backend
> > > > > feature bit when it has been proposed, let's control it at vdpa frontend
> > > > > level. Future patches may move this control to the parent driver.
> > > > >
> > > > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature")
> > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > >
> > > > Please do send v3. And again, I don't want to send "after driver ok" hack
> > > > upstream at all, I merged it in next just to give it some testing.
> > > > We want RING_ACCESS_AFTER_KICK or some such.
> > > >
> > >
> > > Current devices do not support that semantic.
> >
> > Which devices specifically access the ring after DRIVER_OK but before
> > a kick?
> >
> 
> Previous versions of the QEMU LM series did a spurious kick to start
> traffic at the LM destination [1]. When it was proposed, that spurious
> kick was removed from the series because to check for descriptors
> after driver_ok, even without a kick, was considered work of the
> parent driver.
> 
> I'm ok to go back to this spurious kick, but I'm not sure if the hw
> will read the ring before the kick actually. I can ask.
> 
> Thanks!
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-01/msg02775.html

Let's find out. We need to check for ENABLE_AFTER_DRIVER_OK too, no?



> > > My plan was to convert
> > > it in vp_vdpa if needed, and reuse the current vdpa ops. Sorry if I
> > > was not explicit enough.
> > >
> > > The only solution I can see to that is to trap & emulate in the vdpa
> > > (parent?) driver, as talked in virtio-comment. But that complicates
> > > the architecture:
> > > * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> > > * Store vq enable state separately, at
> > > vdpa->config->set_vq_ready(true), but not transmit that enable to hw
> > > * Store the doorbell state separately, but do not configure it to the
> > > device directly.
> > >
> > > But how to recover if the device cannot configure them at kick time,
> > > for example?
> > >
> > > Maybe we can just fail if the parent driver does not support enabling
> > > the vq after DRIVER_OK? That way no new feature flag is needed.
> > >
> > > Thanks!
> > >
> > > >
> > > > > ---
> > > > > Sent with Fixes: tag pointing to git.kernel.org/pub/scm/linux/kernel/git/mst
> > > > > commit. Please let me know if I should send a v3 of [1] instead.
> > > > >
> > > > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-email-mst@kernel.org/T/
> > > > > ---
> > > > >  drivers/vhost/vdpa.c | 7 +++++--
> > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > index e1abf29fed5b..a7e554352351 100644
> > > > > --- a/drivers/vhost/vdpa.c
> > > > > +++ b/drivers/vhost/vdpa.c
> > > > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > >  {
> > > > >       struct vhost_vdpa *v = filep->private_data;
> > > > >       struct vhost_dev *d = &v->vdev;
> > > > > +     const struct vdpa_config_ops *ops = v->vdpa->config;
> > > > >       void __user *argp = (void __user *)arg;
> > > > >       u64 __user *featurep = argp;
> > > > > -     u64 features;
> > > > > +     u64 features, parent_features = 0;
> > > > >       long r = 0;
> > > > >
> > > > >       if (cmd == VHOST_SET_BACKEND_FEATURES) {
> > > > >               if (copy_from_user(&features, featurep, sizeof(features)))
> > > > >                       return -EFAULT;
> > > > > +             if (ops->get_backend_features)
> > > > > +                     parent_features = ops->get_backend_features(v->vdpa);
> > > > >               if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > > > >                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > > > >                                BIT_ULL(VHOST_BACKEND_F_RESUME) |
> > > > > -                              BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
> > > > > +                              parent_features))
> > > > >                       return -EOPNOTSUPP;
> > > > >               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > > >                    !vhost_vdpa_can_suspend(v))
> > > > > --
> > > > > 2.39.3
> > > >
> >


