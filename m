Return-Path: <netdev+bounces-46151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD447E1B26
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 08:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E55280DA1
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 07:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB999C8CB;
	Mon,  6 Nov 2023 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa4PPyLH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F094DDAA
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 07:26:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D4D6F
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 23:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699255586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evSFj1U1p+Ny9gPIF1c5/6yqRIJ9hrTGuB8/aTR/hqw=;
	b=aa4PPyLHSLeWmM3nWbyRMwqqX04W9a+KcbN3yokCllH2rOACVLy4hj6JukpPbmd7iYQi5E
	wIJA7ACHuuOkN2Wd4AWgKg8LvLFHDGjbCEPtQ0U5asvxNQSLTVos4P5TLDdruadqfiNxia
	pN0pdELxKvH9HfEB6xamor/BFLdjc3Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-o3pRSFMeO0qEY9FCoN8DZg-1; Mon, 06 Nov 2023 02:26:25 -0500
X-MC-Unique: o3pRSFMeO0qEY9FCoN8DZg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079fd9754cso3806433e87.0
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 23:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699255583; x=1699860383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evSFj1U1p+Ny9gPIF1c5/6yqRIJ9hrTGuB8/aTR/hqw=;
        b=qCUhgOuOas/bvQXsFsYsoQejSxohXxF0NREzTmaGE5lrJQiH1kNCbtilAgfYxOyrn9
         eHgN/GV3HMAUXbSVrKJgcczKXbskAqpUagZ+X0Qm1v5/zsQCa40WOwop38vfoJyN9xof
         sGkmckKgPnw7fpiRML3j/Inbc46psIC4BkioV/ZxlKgdOIAfLB0Qu2mqbaXF1JcZcSj5
         rUI5EfMHTEl4eJKC6/rG2MIqSVWApXMY7GLxL+PLDVgo7suEA/l7mT4PfcOB024wwyIu
         phUlnzjdRincrTTBpiAD79AQUR5SHzc4iGR71GkWAgXo3ooHYWo5/Ng4X1bjm8HEB2kl
         eWYw==
X-Gm-Message-State: AOJu0YwVlR4IJoiyEGp0MCdjhX1PgtyznbWhyOqMuyKkJs8eElC+bmmP
	SZucIkTC7xDHqWQhUIpV6zMk5TFyrHZ7Ylhq/v2Hkn5CLvPweZljw3vdmkexp940cY5X+deYMK1
	RvL1OtDo4Yf1rkQgKDEcBzqNDegsNxwn0
X-Received: by 2002:ac2:4903:0:b0:507:9628:afb with SMTP id n3-20020ac24903000000b0050796280afbmr22045592lfi.68.1699255583638;
        Sun, 05 Nov 2023 23:26:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcZHQqKWdEULM3eBwn+4d0ZXxU5lMFxm0yiPC67W449u3K16MJzdZf96kxwAhxM88I6SzimJ/v/7HYurwI7AQ=
X-Received: by 2002:ac2:4903:0:b0:507:9628:afb with SMTP id
 n3-20020ac24903000000b0050796280afbmr22045574lfi.68.1699255583367; Sun, 05
 Nov 2023 23:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-9-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-9-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 15:26:12 +0800
Message-ID: <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com>
Subject: Re: [RFC v1 8/8] iommu: expose the function iommu_device_use_default_domain
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 1:18=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Expose the function iommu_device_use_default_domain() and
> iommu_device_unuse_default_domain()=EF=BC=8C
> While vdpa bind the iommufd device and detach the iommu device,
> vdpa need to call the function
> iommu_device_unuse_default_domain() to release the owner
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

This is the end of the series, who is the user then?

Thanks

> ---
>  drivers/iommu/iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3bfc56df4f78..987cbf8c9a87 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3164,6 +3164,7 @@ int iommu_device_use_default_domain(struct device *=
dev)
>
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(iommu_device_use_default_domain);
>
>  /**
>   * iommu_device_unuse_default_domain() - Device driver stops handling de=
vice
> @@ -3187,6 +3188,7 @@ void iommu_device_unuse_default_domain(struct devic=
e *dev)
>         mutex_unlock(&group->mutex);
>         iommu_group_put(group);
>  }
> +EXPORT_SYMBOL_GPL(iommu_device_unuse_default_domain);
>
>  static int __iommu_group_alloc_blocking_domain(struct iommu_group *group=
)
>  {
> --
> 2.34.3
>


