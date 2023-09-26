Return-Path: <netdev+bounces-36198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833557AE3C1
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 04:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 22AE21C209B7
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 02:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBDC1100;
	Tue, 26 Sep 2023 02:47:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF37F
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 02:47:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5EB10C
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 19:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695696459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3cx0kxtLpPGv+5EBA2RQ4RZiZDVBT8lLjm6nn2c/2U=;
	b=eWFKEzOXQ7A+uVMTTl20FaYo27NuY0gwHE2H3TCmXUCtmEExGUJQ2dusDVqBEU3/085gcd
	godoSu5gMPTc9S+N8k/Uf6Y1dXrqm/bINWtrJThtxM38UNIpyU1OhJuZpeSPNLYo2lWyrX
	kYUhq2R4VkCvqsYdyBFkFO0S87kgpnI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-jUB9P927OuSrZ73JMnq5AQ-1; Mon, 25 Sep 2023 22:47:38 -0400
X-MC-Unique: jUB9P927OuSrZ73JMnq5AQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5043307ec0bso10078406e87.2
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 19:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695696456; x=1696301256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3cx0kxtLpPGv+5EBA2RQ4RZiZDVBT8lLjm6nn2c/2U=;
        b=G2S5pjsyO2x6ylG2EmxkibwyW4Fm+MZQisCEJygiGTgfy+Y3cR0bLfO+PBkcLQOC+v
         N0RikK2iGIhrH9u2SQxD6jaL52lQqjKt7SUnXQsqFKIdYmmS6p7xO1WkJQUKvJy1BJCz
         UhowCA+I7ydhCRfZrGJ0QaAyXoTv62XRovknpLKJYBQxYAlc7LfB+EKRyuGeY0wcJZlR
         v0RdBWJB06O8hUbLVSHuQGheTKJR/z47F/rJeGZGz0uwLfou6STuDknsit5p807Ofzcm
         NZLhx4S7ShcjIsubMMAYJZkMtFK3fBF8xdJhwfcJ4D7WRBUkhX0ndqwYIOQWm+JeNb0s
         Y6Tw==
X-Gm-Message-State: AOJu0Ywv4gjfz53t6nb/K86PlLcPPjBwOU79jLFvm39AsiKHY0Gl1x64
	G3jORVGAgcfiw9zld2y72nYq6rQPH0IhGPl14oK7lvkcIDBz1329HBqU7JF7V2e7dUh8Q096aFz
	slMsvaQ1/Nw5Frb/n3xgHslY7OTpfHU8H
X-Received: by 2002:ac2:484a:0:b0:504:3807:22a4 with SMTP id 10-20020ac2484a000000b00504380722a4mr6579870lfy.23.1695696456742;
        Mon, 25 Sep 2023 19:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFkOWZjTRPau3mG9Pjn/pYVEjqanRn4CgrReXQdv2VpQOTnisrlxsRXRGDqSTR77juC7tMdGrvAHT7rO57F9E=
X-Received: by 2002:ac2:484a:0:b0:504:3807:22a4 with SMTP id
 10-20020ac2484a000000b00504380722a4mr6579862lfy.23.1695696456554; Mon, 25 Sep
 2023 19:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20230923170540.1447301-2-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 10:47:25 +0800
Message-ID: <CACGkMEsL-jWiNeWG5pEA2jp50=BqYmGWM1HsMiCigxic+S0_5A@mail.gmail.com>
Subject: Re: [RFC 1/7] vhost/iommufd: Add the functions support iommufd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 1:05=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new file vhost/iommufd.c to support the function of
> iommufd, This file contains iommufd function of emulated device and
> the physical device.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/iommufd.c | 151 ++++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.h   |  21 ++++++
>  2 files changed, 172 insertions(+)
>  create mode 100644 drivers/vhost/iommufd.c
>
> diff --git a/drivers/vhost/iommufd.c b/drivers/vhost/iommufd.c
> new file mode 100644
> index 000000000000..080858f76fd5
> --- /dev/null
> +++ b/drivers/vhost/iommufd.c
> @@ -0,0 +1,151 @@
> +#include <linux/vdpa.h>
> +#include <linux/iommufd.h>
> +
> +#include "vhost.h"
> +
> +MODULE_IMPORT_NS(IOMMUFD);
> +
> +int vdpa_iommufd_bind(struct vdpa_device *vdpa, struct iommufd_ctx *ictx=
,
> +                     u32 *ioas_id, u32 *device_id)
> +{
> +       int ret;
> +
> +       vhost_vdpa_lockdep_assert_held(vdpa);
> +
> +       /*
> +        * If the driver doesn't provide this op then it means the device=
 does
> +        * not do DMA at all. So nothing to do.
> +        */
> +       if (!vdpa->config->bind_iommufd)
> +               return 0;
> +
> +       ret =3D vdpa->config->bind_iommufd(vdpa, ictx, device_id);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D vdpa->config->attach_ioas(vdpa, ioas_id);
> +       if (ret)
> +               goto err_unbind;
> +       vdpa->iommufd_attached =3D true;
> +
> +       return 0;
> +
> +err_unbind:
> +       if (vdpa->config->unbind_iommufd)
> +               vdpa->config->unbind_iommufd(vdpa);
> +       return ret;
> +}
> +
> +void vdpa_iommufd_unbind(struct vdpa_device *vdpa)
> +{
> +       vhost_vdpa_lockdep_assert_held(vdpa);
> +
> +       if (vdpa->config->unbind_iommufd)
> +               vdpa->config->unbind_iommufd(vdpa);
> +}
> +
> +int vdpa_iommufd_physical_bind(struct vdpa_device *vdpa,
> +                              struct iommufd_ctx *ictx, u32 *out_device_=
id)
> +{
> +       struct device *dma_dev =3D vdpa_get_dma_dev(vdpa);
> +       struct iommufd_device *idev;
> +
> +       idev =3D iommufd_device_bind(ictx, dma_dev, out_device_id);
> +       if (IS_ERR(idev))
> +               return PTR_ERR(idev);
> +       vdpa->iommufd_device =3D idev;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(vdpa_iommufd_physical_bind);
> +
> +void vdpa_iommufd_physical_unbind(struct vdpa_device *vdpa)
> +{
> +       vhost_vdpa_lockdep_assert_held(vdpa);
> +
> +       if (vdpa->iommufd_attached) {
> +               iommufd_device_detach(vdpa->iommufd_device);
> +               vdpa->iommufd_attached =3D false;
> +       }
> +       iommufd_device_unbind(vdpa->iommufd_device);
> +       vdpa->iommufd_device =3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(vdpa_iommufd_physical_unbind);
> +
> +int vdpa_iommufd_physical_attach_ioas(struct vdpa_device *vdpa, u32 *pt_=
id)
> +{
> +       unsigned int flags =3D 0;
> +
> +       return iommufd_device_attach(vdpa->iommufd_device, pt_id);
> +}
> +EXPORT_SYMBOL_GPL(vdpa_iommufd_physical_attach_ioas);
> +
> +static void vdpa_emulated_unmap(void *data, unsigned long iova,
> +                               unsigned long length)
> +{
> +       struct vdpa_device *vdpa =3D data;
> +
> +       vdpa->config->dma_unmap(vdpa, 0, iova, length);
> +}
> +
> +static const struct iommufd_access_ops vdpa_user_ops =3D {
> +       .needs_pin_pages =3D 1,

Note that simulators support VA, so no page pinning in that case while reba=
sing.

static bool use_va =3D true;
module_param(use_va, bool, 0444);
MODULE_PARM_DESC(use_va, "Enable/disable the device's ability to use VA");

So we need to handle that case as well.

(Note that it looks like VA mode is broken, I may need some time to fix tha=
t).

> +       .unmap =3D vdpa_emulated_unmap,
> +};
> +
> +int vdpa_iommufd_emulated_bind(struct vdpa_device *vdpa,
> +                              struct iommufd_ctx *ictx, u32 *out_device_=
id)
> +{
> +       vhost_vdpa_lockdep_assert_held(vdpa);
> +
> +       vdpa->iommufd_ictx =3D ictx;
> +       iommufd_ctx_get(ictx);
> +       struct iommufd_device *idev;
> +
> +       idev =3D iommufd_device_bind(ictx, vdpa->dma_dev, out_device_id);

This seems not appropriate for emulated devices as it deals with the
concepts that only exist in physical devices like the IOMMU domain
etc.

If possible, please refer how VFIO handles this (I guess it should
have something)

Thanks


