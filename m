Return-Path: <netdev+bounces-46575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC0F7E50C7
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 08:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E240281412
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 07:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B51440C;
	Wed,  8 Nov 2023 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTDQeeto"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA921D267
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 07:06:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E058710DA
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 23:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699427165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DUoSm2Iv7a2UwdhQ6s1wKH58JFgFQEsPFOv1WpRND8=;
	b=dTDQeetoi/ggUfDJTKRydosCP726A1B1Eh4BLqnRtwR5lAjYHIyWFuxi5rSDuirdhO15Rp
	73lZYg+KZsqw3NmXtK1HBR4SCZ1K7iRgVJDfbbcITGPYXSLyG4nHHP9gpxX5DbqBXoiHis
	bnKR64Axh2a7XrwdCCIdfiTZOAP2d0g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-XLb_J68EPaKVuzl3MVZNig-1; Wed, 08 Nov 2023 02:06:04 -0500
X-MC-Unique: XLb_J68EPaKVuzl3MVZNig-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-542d5dd0c8eso574025a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 23:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699427163; x=1700031963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DUoSm2Iv7a2UwdhQ6s1wKH58JFgFQEsPFOv1WpRND8=;
        b=FvnAv33lbNe8oqtMwe6DeCAWParUtgmuIZAYkVnrhWgQe+hxG/MZ/DgZs8E5NpLcyd
         Rd/8ylLoX6BWlpSKpkpFRMM2+o7sXtuKKfy1dEW/r5gAfj9d1Vw6evf0b+2cSgQNJYa1
         +wGLS44BjrIC6ReVDjFQi7WWxKk7M73Bkzor3FNuTxMhh6vIWq0KFlahlGmPn+VlmLyO
         VL3pPuqM0zKO6PpucO/+o13q1J+hNSpRAPqdra2wawtxoZCWgrhxaHw46z3PNrDwcp7X
         6m0KxfanhjSpH7KZI7LQXRo01I2GiquVkS2W6vjYrKczKP80zahwbhO6JVnXshZXf3z/
         rkZw==
X-Gm-Message-State: AOJu0YzsdLhelxHqjA72k1qU4B67ekSD0jeLlIQ8CaX67g0m964CljCE
	p2F8hkqVwhRhmTPepQMiAWE8S2bwG6WNBTT2UuEm7lU+HXhd4oi6G31atIbGIjzK4vdojl2m7cq
	rKhWzXQpAMTudHYRnMqKdNjIftEK5qzHe
X-Received: by 2002:a17:906:51d1:b0:9dd:be2b:34ea with SMTP id v17-20020a17090651d100b009ddbe2b34eamr4377398ejk.31.1699427163095;
        Tue, 07 Nov 2023 23:06:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDM7EhI+swyyvkDM3u6Pfk6QmXHKd/4wym/b/QMJOFFCkjCTPCMaznbGWByhlORtrmXpffeg/s+KQz4nYEGw8=
X-Received: by 2002:a17:906:51d1:b0:9dd:be2b:34ea with SMTP id
 v17-20020a17090651d100b009ddbe2b34eamr4377383ejk.31.1699427162806; Tue, 07
 Nov 2023 23:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-9-lulu@redhat.com>
 <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com>
 <CACLfguUPZVY2HDBoir67u0CeR3A9wHjCGvuc3cGLe0L43f8jkg@mail.gmail.com> <CACGkMEuA3jg06s9wuxTL60geFm6+nnbEnYXvv8HhTgXoFHyJgQ@mail.gmail.com>
In-Reply-To: <CACGkMEuA3jg06s9wuxTL60geFm6+nnbEnYXvv8HhTgXoFHyJgQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 8 Nov 2023 15:05:24 +0800
Message-ID: <CACLfguVny1MEOddJiQG4x5RWhxwF2OdzVtKcN3kVGtMP-2XXDQ@mail.gmail.com>
Subject: Re: [RFC v1 8/8] iommu: expose the function iommu_device_use_default_domain
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 11:04=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Nov 7, 2023 at 2:10=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Mon, Nov 6, 2023 at 3:26=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Sat, Nov 4, 2023 at 1:18=E2=80=AFAM Cindy Lu <lulu@redhat.com> wro=
te:
> > > >
> > > > Expose the function iommu_device_use_default_domain() and
> > > > iommu_device_unuse_default_domain()=EF=BC=8C
> > > > While vdpa bind the iommufd device and detach the iommu device,
> > > > vdpa need to call the function
> > > > iommu_device_unuse_default_domain() to release the owner
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >
> > > This is the end of the series, who is the user then?
> > >
> > > Thanks
> > >
> > hi Jason
> > These 2 functions was called in vhost_vdpa_iommufd_set_device(), Vdpa n=
eed to
> > release the dma owner, otherwise, the function will fail when
> > iommufd called iommu_device_claim_dma_owner() in iommufd_device_bind()
> > I will change this sequence, Or maybe will find some other way to fix
> > this problem
> > thanks
>
> I meant exporting helpers needs to be done before the real users.
>
> Thanks
>
sure will fix
Thanks
Cindy
> > cindy
> >
> >
> > > > ---
> > > >  drivers/iommu/iommu.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index 3bfc56df4f78..987cbf8c9a87 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -3164,6 +3164,7 @@ int iommu_device_use_default_domain(struct de=
vice *dev)
> > > >
> > > >         return ret;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(iommu_device_use_default_domain);
> > > >
> > > >  /**
> > > >   * iommu_device_unuse_default_domain() - Device driver stops handl=
ing device
> > > > @@ -3187,6 +3188,7 @@ void iommu_device_unuse_default_domain(struct=
 device *dev)
> > > >         mutex_unlock(&group->mutex);
> > > >         iommu_group_put(group);
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(iommu_device_unuse_default_domain);
> > > >
> > > >  static int __iommu_group_alloc_blocking_domain(struct iommu_group =
*group)
> > > >  {
> > > > --
> > > > 2.34.3
> > > >
> > >
> >
>


