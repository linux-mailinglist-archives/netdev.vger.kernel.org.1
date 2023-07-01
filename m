Return-Path: <netdev+bounces-14946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95F074482D
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 11:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04988281225
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70496525C;
	Sat,  1 Jul 2023 09:17:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF125666
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 09:17:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D5BB
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688203018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5P8+oZe2nmTOWnWCkmaHcGjW4ddEKWX+zP9ge5Dhnp4=;
	b=ac7Bx+mAnxV4MxS3pYRSslFzYojC6+dpjCw0ic2osbmn2wj9NYwjs4wfnMyYY5P1Ta8bDg
	nYud8/+SjT7kidkK9xeIAt3bDH3/+ix7TZUWxYTr9grvmgeX2sX9NEWEsHcEG69AuIpCv8
	g4YO3ohjlXLU6QqSktMtah5We3sOW/s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-hJLW1pN4N1y3P8fWJ3KZKQ-1; Sat, 01 Jul 2023 05:16:56 -0400
X-MC-Unique: hJLW1pN4N1y3P8fWJ3KZKQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e6153f0eeso1408176f8f.0
        for <netdev@vger.kernel.org>; Sat, 01 Jul 2023 02:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688203015; x=1690795015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P8+oZe2nmTOWnWCkmaHcGjW4ddEKWX+zP9ge5Dhnp4=;
        b=XaR8cijTkvbOO7jLI+Y3shxNffFp0u/ODcoI3sEn1GDMez72LkJw4walfB3s8tq5fW
         P+oOaKZXgQWPu3wOaRq3MOv2y70x5zXgXx88IfSn77Beu0I5rDA0sa0M50jkrCviZemZ
         ufX7DFjPcV7vMg6LsaPXvS3LoSJSl10pJRiW201u/xxw/IdGR5YCgfZ9eqQr3VeM7Riz
         TyrQ/NRQ3jirm9bOcOhGIXBZewUi3M44rUT/AClLCl+wGbxwlBOtSnX1sB7j66GUtIpj
         AMCPqBaKGvzJL3Sf0Uht3pRrGFJBk9x0kANY8aplW3aLSraPp6C9VG9kSG7GTZK41UY5
         jC4w==
X-Gm-Message-State: ABy/qLZB1iO1Cn2OKXTHen1h6rZNhX2BOR/scZB2oZkOPrNGWRNnu5xx
	KwtQ05rhWhDxeYVXKlk3J3ZMGV05ftKVSkk7vNe7DChE86YKUYKL3pdv6rL/vvNtPRyEXDZZ7j4
	a2oMUajR8/oYKRuY9wDbuLmnrk2aH/L96vFVHu+q/Vfc=
X-Received: by 2002:a5d:6852:0:b0:314:415:cbf5 with SMTP id o18-20020a5d6852000000b003140415cbf5mr3287991wrw.51.1688203015241;
        Sat, 01 Jul 2023 02:16:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFP3EMRENIi4DQ20/IEBTU2KVd2ubnsbHO86eBAPDozHrZF1MK7rYVDNEdoWWEJqptXlwjlPPkCIWy6yF4bzDg=
X-Received: by 2002:a5d:6852:0:b0:314:415:cbf5 with SMTP id
 o18-20020a5d6852000000b003140415cbf5mr3287980wrw.51.1688203014977; Sat, 01
 Jul 2023 02:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com> <20230628065919.54042-4-lulu@redhat.com>
 <CACGkMEs2V2gqGOv1jd-ZrT-9HHnSU6dhC=1zUojHRDGCeG2E7w@mail.gmail.com>
In-Reply-To: <CACGkMEs2V2gqGOv1jd-ZrT-9HHnSU6dhC=1zUojHRDGCeG2E7w@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sat, 1 Jul 2023 17:16:14 +0800
Message-ID: <CACLfguXFWEs6QLf5Ba65Y_a-i9bQTc-SLvdGfYMAJ+u6BYaLPg@mail.gmail.com>
Subject: Re: [RFC 3/4] vduse: Add the function for get/free the mapp pages
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 4:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jun 28, 2023 at 2:59=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > From: Your Name <you@example.com>
> >
> > Add the function for get/free pages, ad this info
> > will saved in dev->reconnect_info
>
> I think this should be squashed to patch 2 otherwise it fixes a bug
> that is introduced in patch 2?
>
sure will do
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 35 ++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 1b833bf0ae37..3df1256eccb4 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1313,6 +1313,35 @@ static struct vduse_dev *vduse_dev_get_from_mino=
r(int minor)
> >         return dev;
> >  }
> >
> > +int vduse_get_vq_reconnnect(struct vduse_dev *dev, u16 idx)
> > +{
> > +       struct vdpa_reconnect_info *area;
> > +       void *addr =3D (void *)get_zeroed_page(GFP_KERNEL);
> > +
> > +       area =3D &dev->reconnect_info[idx];
> > +
> > +       area->addr =3D virt_to_phys(addr);
> > +       area->vaddr =3D (unsigned long)addr;
> > +       area->size =3D PAGE_SIZE;
> > +       area->index =3D idx;
> > +
> > +       return 0;
> > +}
> > +
> > +int vduse_free_vq_reconnnect(struct vduse_dev *dev, u16 idx)
> > +{
> > +       struct vdpa_reconnect_info *area;
> > +
> > +       area =3D &dev->reconnect_info[idx];
> > +       if ((area->size =3D=3D PAGE_SIZE) && (area->addr !=3D NULL)) {
> > +               free_page(area->vaddr);
> > +               area->size =3D 0;
> > +               area->addr =3D 0;
> > +               area->vaddr =3D 0;
> > +       }
> > +
> > +       return 0;
> > +}
> >
> >  static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
> >  {
> > @@ -1446,6 +1475,10 @@ static int vduse_destroy_dev(char *name)
> >                 mutex_unlock(&dev->lock);
> >                 return -EBUSY;
> >         }
> > +       for (int i =3D 0; i < dev->vq_num; i++) {
> > +
> > +               vduse_free_vq_reconnnect(dev, i);
> > +       }
> >         dev->connected =3D true;
> >         mutex_unlock(&dev->lock);
> >
> > @@ -1583,6 +1616,8 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >                 INIT_WORK(&dev->vqs[i].kick, vduse_vq_kick_work);
> >                 spin_lock_init(&dev->vqs[i].kick_lock);
> >                 spin_lock_init(&dev->vqs[i].irq_lock);
> > +
> > +               vduse_get_vq_reconnnect(dev, i);
>
> Can we delay the allocated until fault?
>
sure will do
> Thanks
>
> >         }
> >
> >         ret =3D idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL=
);
> > --
> > 2.34.3
> >
>


