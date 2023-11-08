Return-Path: <netdev+bounces-46559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B197E4F4A
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 04:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798461C20A23
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 03:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93702ED9;
	Wed,  8 Nov 2023 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAp9XLbR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE78ED2
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 03:04:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C77D10EF
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 19:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699412642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1LQ97ddUdIP3S349Nk8ZXmiilx7zt+gyQAEPt1RKwk=;
	b=BAp9XLbR7HEoy/X9GLv3H42I3WPRhx6+bWdNABCMBszLihXXu6CiW+D0k0mrGg34xLRa6q
	6dW+o9HCOJaDH/4g0VPUFx4U57JkhojBxm+c5i5Y+op5S5cB5cnk43JD7g9SNaPrpyYuVr
	TD2UM2XRVor79ruDut0IZETdr8T6j6A=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-f4tu-JT6OHia7SERvDTPUA-1; Tue, 07 Nov 2023 22:04:00 -0500
X-MC-Unique: f4tu-JT6OHia7SERvDTPUA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50798a25ebaso212998e87.0
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 19:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412639; x=1700017439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1LQ97ddUdIP3S349Nk8ZXmiilx7zt+gyQAEPt1RKwk=;
        b=RognBPTj3g7Vto5lm9iVdhI3Bv37kNP7qfGWM/RdjoLbBnDGICQGjT54xggMk7B1Y6
         FsftsXHL/oL7CYy3ha7b9XHVDyd2ubOzj6tuNbFVAEhWppb4R7LDxWcdjw2SedvSz1zZ
         EFCdzb40mh4YGcE78lGuzwvReJM8L3EYmGQq2P3epub3hMERhVDSXlvyVUti5NfZd/ew
         HF2/Qay2PksDCF8JAcUEMot+eW/KZMqXaX86TGHu1vUBMvvqw0Uf9vh3Io301VUsrjWD
         noHeVZPBj8IkgvHnDbLGZ1Tm8Ar16Ex7Tws1wEbq6taSppJpzoQCqrcNNT5CW9D0/YVv
         Yt1Q==
X-Gm-Message-State: AOJu0YwYx5ldr/cKc3TpNq2t/6YzQt4u0JnA6hS5OgpwELC0XzZt/nwc
	BCCHQIpaqZeJju26yaeTkvGLzN9gyT31dFoHi/nHRgdf+TxOwWJUgaUAQfmBywiL8Vh/BiEng3x
	2d1PMjhSA4RiqrKIBz6OIc1luoFIei4w6
X-Received: by 2002:a05:6512:3910:b0:509:4d3f:a1c4 with SMTP id a16-20020a056512391000b005094d3fa1c4mr185160lfu.12.1699412639367;
        Tue, 07 Nov 2023 19:03:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/WtWEcYVrA6P1JEZ/+s4O/JbYCESejqz6Phd8UEmQIVsvMMk65SthMYJwstqiEzC8DRLJGzSaYpA8nNqIY1Y=
X-Received: by 2002:a05:6512:3910:b0:509:4d3f:a1c4 with SMTP id
 a16-20020a056512391000b005094d3fa1c4mr185156lfu.12.1699412639102; Tue, 07 Nov
 2023 19:03:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-9-lulu@redhat.com>
 <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com> <CACLfguUPZVY2HDBoir67u0CeR3A9wHjCGvuc3cGLe0L43f8jkg@mail.gmail.com>
In-Reply-To: <CACLfguUPZVY2HDBoir67u0CeR3A9wHjCGvuc3cGLe0L43f8jkg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Nov 2023 11:03:48 +0800
Message-ID: <CACGkMEuA3jg06s9wuxTL60geFm6+nnbEnYXvv8HhTgXoFHyJgQ@mail.gmail.com>
Subject: Re: [RFC v1 8/8] iommu: expose the function iommu_device_use_default_domain
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 2:10=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, Nov 6, 2023 at 3:26=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Sat, Nov 4, 2023 at 1:18=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > Expose the function iommu_device_use_default_domain() and
> > > iommu_device_unuse_default_domain()=EF=BC=8C
> > > While vdpa bind the iommufd device and detach the iommu device,
> > > vdpa need to call the function
> > > iommu_device_unuse_default_domain() to release the owner
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> >
> > This is the end of the series, who is the user then?
> >
> > Thanks
> >
> hi Jason
> These 2 functions was called in vhost_vdpa_iommufd_set_device(), Vdpa nee=
d to
> release the dma owner, otherwise, the function will fail when
> iommufd called iommu_device_claim_dma_owner() in iommufd_device_bind()
> I will change this sequence, Or maybe will find some other way to fix
> this problem
> thanks

I meant exporting helpers needs to be done before the real users.

Thanks

> cindy
>
>
> > > ---
> > >  drivers/iommu/iommu.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 3bfc56df4f78..987cbf8c9a87 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -3164,6 +3164,7 @@ int iommu_device_use_default_domain(struct devi=
ce *dev)
> > >
> > >         return ret;
> > >  }
> > > +EXPORT_SYMBOL_GPL(iommu_device_use_default_domain);
> > >
> > >  /**
> > >   * iommu_device_unuse_default_domain() - Device driver stops handlin=
g device
> > > @@ -3187,6 +3188,7 @@ void iommu_device_unuse_default_domain(struct d=
evice *dev)
> > >         mutex_unlock(&group->mutex);
> > >         iommu_group_put(group);
> > >  }
> > > +EXPORT_SYMBOL_GPL(iommu_device_unuse_default_domain);
> > >
> > >  static int __iommu_group_alloc_blocking_domain(struct iommu_group *g=
roup)
> > >  {
> > > --
> > > 2.34.3
> > >
> >
>


