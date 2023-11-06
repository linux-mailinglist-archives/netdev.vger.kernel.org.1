Return-Path: <netdev+bounces-46139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA3B7E1955
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 05:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1C7281218
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 04:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9F01C29;
	Mon,  6 Nov 2023 04:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMtkO0YU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3C566D
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 04:11:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FF2B3
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 20:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699243910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHrLb4zEBqMuGuzN6XAqFfCIg5Eok44Njld/JJN4sJk=;
	b=SMtkO0YURk7J7s+Z0AtondWtRVTosyWmns7DbnAMRSXfpJV1U+yE8D7Ww/HgefzsMGT2QM
	vPxCwGYJJ0yaxjYG9aQln3+DExq8M5dGM4dk8WDFJcfJI96kWpo5uRn/3GgIadhoOpHUB+
	0qYOEUGleVlQwgyba2j3X35LQoOZC70=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-QZmvYdObMuubLKEClNe5QA-1; Sun, 05 Nov 2023 23:11:48 -0500
X-MC-Unique: QZmvYdObMuubLKEClNe5QA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507cee14477so4447258e87.3
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 20:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699243907; x=1699848707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHrLb4zEBqMuGuzN6XAqFfCIg5Eok44Njld/JJN4sJk=;
        b=exlgr/jhxqmtUmoSQtvduoE0DubKGU9BUboBDtN0MlVbEDgavkdUE4NE4w8Mu8OnTe
         ikBhUKIs+BbJ4XgTjUDZT9WFlvbel8lJRQusZBTRc8iQTG4H8IQA9NwSMAkWeNzHUpW/
         Xg+uFJK5bILSvJsMiECAZa/monKt3gVEytUvcotAa6qi9vLiRAdosuweTYO5NhJNVyzH
         NNfKjEUPQCXvJSh5RIdAH6i4szhXU/YCuGIwTH/OV5yqDp0fricLSrB+0VSjqRrUkCtV
         fns3+RVgBkZ6t/aW1KNgaOxp/TsbSKb3bUBK/oM+klh6W6smdv+H1yHR9U3FLE81aoYO
         Lq0A==
X-Gm-Message-State: AOJu0Ywd7Ofewzc3xcN9iKuFiTtxnglGYxcBTgIK+yAzB6scjEB5TArx
	WU+WfDvGCdXAN3y4QkogDIygaC2jxQq0kmO0CyyDIwuA0yfCdkFuU2yLt3HvnKIK9yfZIGqo9AP
	kK4kalr4Co35d6nyIoEwapLJAh7ft8JErCQcYQFCx7Bo=
X-Received: by 2002:a19:914a:0:b0:507:9701:2700 with SMTP id y10-20020a19914a000000b0050797012700mr21479170lfj.20.1699243907017;
        Sun, 05 Nov 2023 20:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUWUi5tZ6aymenvsU8IcDkUX50MvzvLjsi++9vXhsqQouRpjAkVN6Zt+HPX/ts88NcBPPpX+/TSiAt8ldNrfw=
X-Received: by 2002:a19:914a:0:b0:507:9701:2700 with SMTP id
 y10-20020a19914a000000b0050797012700mr21479160lfj.20.1699243906677; Sun, 05
 Nov 2023 20:11:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 12:11:35 +0800
Message-ID: <CACGkMEvaKw9g0EmNdFh3=iZm3rD-mo_BtaBA3F5bwqNq4NV3Dw@mail.gmail.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 1:16=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
>
> Hi All
> This code provides the iommufd support for vdpa device
> This code fixes the bugs from the last version and also add the asid supp=
ort. rebase on kernel
> v6,6-rc3
> Test passed in the physical device (vp_vdpa), but  there are still some p=
roblems in the emulated device (vdpa_sim_net),
> I will continue working on it
>
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

It would be better to have a change summary here.

Thanks

>
>
> Cindy Lu (8):
>   vhost/iommufd: Add the functions support iommufd
>   Kconfig: Add the new file vhost/iommufd
>   vhost: Add 3 new uapi to support iommufd
>   vdpa: Add new vdpa_config_ops to support iommufd
>   vdpa_sim :Add support for iommufd
>   vdpa: change the map/unmap process to support iommufd
>   vp_vdpa::Add support for iommufd
>   iommu: expose the function iommu_device_use_default_domain
>
>  drivers/iommu/iommu.c             |   2 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   8 ++
>  drivers/vdpa/virtio_pci/vp_vdpa.c |   4 +
>  drivers/vhost/Kconfig             |   1 +
>  drivers/vhost/Makefile            |   1 +
>  drivers/vhost/iommufd.c           | 178 +++++++++++++++++++++++++
>  drivers/vhost/vdpa.c              | 210 +++++++++++++++++++++++++++++-
>  drivers/vhost/vhost.h             |  21 +++
>  include/linux/vdpa.h              |  38 +++++-
>  include/uapi/linux/vhost.h        |  66 ++++++++++
>  10 files changed, 525 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/vhost/iommufd.c
>
> --
> 2.34.3
>


