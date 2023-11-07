Return-Path: <netdev+bounces-46350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4F7E3514
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 07:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD971C20A72
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 06:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7D56AA0;
	Tue,  7 Nov 2023 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCL0BBPV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69457B66B
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 06:10:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205D135
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 22:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699337452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jy3AoTaEFtBC3Hdf9DK2P1sqM0oihORJcg/Y85jsjiM=;
	b=ZCL0BBPVCjBx5kRQ/v13uPAH0IBAj3NooUqYEfFuhtj3Bw7kKpD3UeBsU0xZIfWzNwVmdH
	QjW8FjjKAHPmSQH3Ls4eNDeEeOGAgll04CE35/SrWSXG0HKrx50wpejld0E8SwbCAVNPOl
	O/U56whWBcXZ4jvjt0xJ+NzxXmgD3AM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-heGb091WOUmOLolVsPSbqw-1; Tue, 07 Nov 2023 01:10:51 -0500
X-MC-Unique: heGb091WOUmOLolVsPSbqw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c7f0a33afbso380590666b.3
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 22:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699337450; x=1699942250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy3AoTaEFtBC3Hdf9DK2P1sqM0oihORJcg/Y85jsjiM=;
        b=f3FHOvz2wOAvL0lbkRtMDBTSrcdnsFzHHRae9mouccEPLgscBWf9dOHy1XBmz3WCa9
         A5TkleDWyrIn7fVe1BZm38h+zG6t18XjXK1Zd2xx8IgigBstMFoXS+yzj+e59vjZ4jdK
         rmU7S1iVnML76Nfx0wKqYhzF8gLpQtpDYUUuNy+MuXAGGc5rE4H1HXB6k+EfwzoLXC+w
         m980Q1Bs3WTEf1z33d5SJvNDCJWXDl5rf+EdELoY2utwMev8e0cg0C/tO6bb8kZkx9H6
         sqnUy2m38vwz4E7nVVAJS9bg3i0haHhrLwLIi48Onsf5okGyQLllBlg3XL661GHErFtq
         ToEw==
X-Gm-Message-State: AOJu0YwtmJY3+PoLOwYwV/fpgBMdrpMUz5qeK8JimOtLzfnpOaQ/3CYt
	UrDPwChMCGQgU66/WurSS57Z8+mV/318QMjd9EoMhUo0hPMe00B5i1xqlBnnlrg6KJ3zVz1MLu3
	xuew5/LvyKwmxfSpsBBxuzwbLrFkw8qMp
X-Received: by 2002:a17:906:c114:b0:9dd:6d39:42b9 with SMTP id do20-20020a170906c11400b009dd6d3942b9mr9767019ejc.55.1699337450453;
        Mon, 06 Nov 2023 22:10:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ146Ql2Vvi0xcjK7Z9omMZRxdZMLHLDq1ESNq6PfFahRy+ug99qPlbg3aZ0HTfKjKT8OIC8DWy3+ihFO68A8=
X-Received: by 2002:a17:906:c114:b0:9dd:6d39:42b9 with SMTP id
 do20-20020a170906c11400b009dd6d3942b9mr9767002ejc.55.1699337450164; Mon, 06
 Nov 2023 22:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-9-lulu@redhat.com>
 <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com>
In-Reply-To: <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 7 Nov 2023 14:10:11 +0800
Message-ID: <CACLfguUPZVY2HDBoir67u0CeR3A9wHjCGvuc3cGLe0L43f8jkg@mail.gmail.com>
Subject: Re: [RFC v1 8/8] iommu: expose the function iommu_device_use_default_domain
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 3:26=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Sat, Nov 4, 2023 at 1:18=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Expose the function iommu_device_use_default_domain() and
> > iommu_device_unuse_default_domain()=EF=BC=8C
> > While vdpa bind the iommufd device and detach the iommu device,
> > vdpa need to call the function
> > iommu_device_unuse_default_domain() to release the owner
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> This is the end of the series, who is the user then?
>
> Thanks
>
hi Jason
These 2 functions was called in vhost_vdpa_iommufd_set_device(), Vdpa need =
to
release the dma owner, otherwise, the function will fail when
iommufd called iommu_device_claim_dma_owner() in iommufd_device_bind()
I will change this sequence, Or maybe will find some other way to fix
this problem
thanks
cindy


> > ---
> >  drivers/iommu/iommu.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 3bfc56df4f78..987cbf8c9a87 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -3164,6 +3164,7 @@ int iommu_device_use_default_domain(struct device=
 *dev)
> >
> >         return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(iommu_device_use_default_domain);
> >
> >  /**
> >   * iommu_device_unuse_default_domain() - Device driver stops handling =
device
> > @@ -3187,6 +3188,7 @@ void iommu_device_unuse_default_domain(struct dev=
ice *dev)
> >         mutex_unlock(&group->mutex);
> >         iommu_group_put(group);
> >  }
> > +EXPORT_SYMBOL_GPL(iommu_device_unuse_default_domain);
> >
> >  static int __iommu_group_alloc_blocking_domain(struct iommu_group *gro=
up)
> >  {
> > --
> > 2.34.3
> >
>


