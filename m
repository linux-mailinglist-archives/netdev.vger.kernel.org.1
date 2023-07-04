Return-Path: <netdev+bounces-15344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2598C746EDA
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 12:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA088280F18
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7A4431;
	Tue,  4 Jul 2023 10:38:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE692EBC
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 10:38:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60538187
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688467124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRorza6OJCiLsVesM2IH/LA8g4F1XVqMOWMx+3P1rz4=;
	b=WK6+siXTpMKYmAWxQnR86ytA49jxDOu82BBjafOwSP9jIlBDgFrpKEVv7FKPqiak5p9Fak
	fqDrmJPyBk3lm0WEf4frmkab6e6x8+UKDHtu4El8yM9f+vKku2f7eXqOmIPppSrZ15FuQu
	lG3xdFWvZvNkhPLOKaGazIarsmNA9l0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-MxGdSwd1OvKcwQPw-JdN6A-1; Tue, 04 Jul 2023 06:38:41 -0400
X-MC-Unique: MxGdSwd1OvKcwQPw-JdN6A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb1a5788f0so4800937e87.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 03:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688467119; x=1691059119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRorza6OJCiLsVesM2IH/LA8g4F1XVqMOWMx+3P1rz4=;
        b=N0aciil45whOIJtyUzjzCD1y9yC3kKgA5EjDGQckQSpxo9X7qh/7qEQKQV8SPvkEJp
         +PQqlARa8Fbt0tRcQGTsCjm1dZN4O125lmE3lYEMmzxYeKs/nRHiSRSw4+YR6VETA8Qv
         PDpfjMzkBezKHSbGxIht8DoNz+pGpBi9paIRvJCVi1bFC27Rv0zvd4rthUozO1iIUBBj
         9JHeWsTbT3ePRd55GP+jd748HZVPsv4iyq8S3b7YuHbWbvyU7Iy/CpaBpN7V4iADUQV4
         7b6Aoz592iaN2C/kmK2dhQt1PkhR0PaUEe0V0fZtQcF8BNgqLlc8OoNG7tOTW/H/QVJP
         w4mg==
X-Gm-Message-State: ABy/qLZlWSLS+0hMSX1PNl9BMBZxY+HPopU7xSu3uHdhCNYIoWCU1W56
	2k2xE7Lr8/q1SzbNfEiwqaIja9zouOz8dDwgiL2cfY7esbFPQHuRRGdBlbQOx9ERfPF6TyK13As
	YROXHdDN0KUfgIuqZr4FMdf+z
X-Received: by 2002:a05:6512:39d3:b0:4f7:405f:72e7 with SMTP id k19-20020a05651239d300b004f7405f72e7mr10638813lfu.50.1688467119712;
        Tue, 04 Jul 2023 03:38:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGDGMjGihqxX02HuxnbdBtGBjZZQqY3m1CG+EemG0uaYcjxxZV8C9XGiMcmo2QCieoBmTukg==
X-Received: by 2002:a05:6512:39d3:b0:4f7:405f:72e7 with SMTP id k19-20020a05651239d300b004f7405f72e7mr10638796lfu.50.1688467119354;
        Tue, 04 Jul 2023 03:38:39 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b003fa999cefc0sm23940722wml.36.2023.07.04.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 03:38:38 -0700 (PDT)
Date: Tue, 4 Jul 2023 06:38:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230704063646-mutt-send-email-mst@kernel.org>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Martin wrote:
> On Mon, Jul 3, 2023 at 4:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio Pérez wrote:
> > > With the current code it is accepted as long as userland send it.
> > >
> > > Although userland should not set a feature flag that has not been
> > > offered to it with VHOST_GET_BACKEND_FEATURES, the current code will not
> > > complain for it.
> > >
> > > Since there is no specific reason for any parent to reject that backend
> > > feature bit when it has been proposed, let's control it at vdpa frontend
> > > level. Future patches may move this control to the parent driver.
> > >
> > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature")
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> >
> > Please do send v3. And again, I don't want to send "after driver ok" hack
> > upstream at all, I merged it in next just to give it some testing.
> > We want RING_ACCESS_AFTER_KICK or some such.
> >
> 
> Current devices do not support that semantic.

Which devices specifically access the ring after DRIVER_OK but before
a kick?

> My plan was to convert
> it in vp_vdpa if needed, and reuse the current vdpa ops. Sorry if I
> was not explicit enough.
> 
> The only solution I can see to that is to trap & emulate in the vdpa
> (parent?) driver, as talked in virtio-comment. But that complicates
> the architecture:
> * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> * Store vq enable state separately, at
> vdpa->config->set_vq_ready(true), but not transmit that enable to hw
> * Store the doorbell state separately, but do not configure it to the
> device directly.
> 
> But how to recover if the device cannot configure them at kick time,
> for example?
> 
> Maybe we can just fail if the parent driver does not support enabling
> the vq after DRIVER_OK? That way no new feature flag is needed.
> 
> Thanks!
> 
> >
> > > ---
> > > Sent with Fixes: tag pointing to git.kernel.org/pub/scm/linux/kernel/git/mst
> > > commit. Please let me know if I should send a v3 of [1] instead.
> > >
> > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-email-mst@kernel.org/T/
> > > ---
> > >  drivers/vhost/vdpa.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index e1abf29fed5b..a7e554352351 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > >  {
> > >       struct vhost_vdpa *v = filep->private_data;
> > >       struct vhost_dev *d = &v->vdev;
> > > +     const struct vdpa_config_ops *ops = v->vdpa->config;
> > >       void __user *argp = (void __user *)arg;
> > >       u64 __user *featurep = argp;
> > > -     u64 features;
> > > +     u64 features, parent_features = 0;
> > >       long r = 0;
> > >
> > >       if (cmd == VHOST_SET_BACKEND_FEATURES) {
> > >               if (copy_from_user(&features, featurep, sizeof(features)))
> > >                       return -EFAULT;
> > > +             if (ops->get_backend_features)
> > > +                     parent_features = ops->get_backend_features(v->vdpa);
> > >               if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > >                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > >                                BIT_ULL(VHOST_BACKEND_F_RESUME) |
> > > -                              BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
> > > +                              parent_features))
> > >                       return -EOPNOTSUPP;
> > >               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > >                    !vhost_vdpa_can_suspend(v))
> > > --
> > > 2.39.3
> >


