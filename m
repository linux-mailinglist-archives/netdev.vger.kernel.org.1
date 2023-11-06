Return-Path: <netdev+bounces-46153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE55E7E1B3B
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 08:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3208A280EC7
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA48FCA74;
	Mon,  6 Nov 2023 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fW02jtHL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20504D26D
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 07:30:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B14B6
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 23:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699255828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F51eSuY4Oi2D0gkQWdIKjqvRwfkp9jTrFlX6owadixE=;
	b=fW02jtHLC8uecPeNmrOqg0LiOkKvhVFS5YDll2wq/H8YtoMZDhjPiMkiDfdPOwpT5Xz0cG
	jz+Pc5xdN5Ct/IKsqNrhwTBXw2BwkgAunZqxUwRsZ0LcceHcWrCuCI8HSXNUwZ1VzMhaGE
	8l5/AUsKf0NlgRYR+i7zZTqQJTE1Fxs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-JUHSkjORPRqzivP4Axr7BQ-1; Mon, 06 Nov 2023 02:30:26 -0500
X-MC-Unique: JUHSkjORPRqzivP4Axr7BQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507ce973a03so3788342e87.3
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 23:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699255825; x=1699860625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F51eSuY4Oi2D0gkQWdIKjqvRwfkp9jTrFlX6owadixE=;
        b=ecxhXzHk8DBpcelWB/hZMarTNCgMHaZNGD6f3HpWEv523WLWxUFv2MqC0BrlQmICcD
         6g8pHsUrDIIsoQ8Dc2qc1DIhlxpZ8Ixhw3/cPcE7wdGclmRg4PXTJeIQZlA2IzT99yH4
         Fnkxivi/vgFmi5sFtr5XH61Ap1hEwnnPH78n7PFmI9inVHzMYqHvIn6vshRk5B8J/Fho
         bdFG5QrpIBk64t5XHfKckKrw3sMyhlUroGq7XhAQkt8RHob01TEzCHGERdCdQYkgEtDm
         cYuJEW+Nifo/fWTHJocHkZc/XL6Yqmafz+RbWA2DC/zAYEaewxYUH3T7ghMNdavKVGeE
         SNvQ==
X-Gm-Message-State: AOJu0YxM3laqaEZ9/reVPq8F0XcxXY2iARkgUpplz+0kV/yi4VuP/WhJ
	X6Pxess1r5wwfij3uZUsvf6R6uX/pc7TUE+tPx2EG0b7LkhQkiCaA7gfdA8EPARidhcwD6KJO8L
	o5znbBids3ID3Lg5EHeDAZvHs1nhm5VPZ
X-Received: by 2002:a05:6512:3e08:b0:503:99d:5a97 with SMTP id i8-20020a0565123e0800b00503099d5a97mr28482717lfv.20.1699255825098;
        Sun, 05 Nov 2023 23:30:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHur0uXYPVe6IlJPXMRunyH5xL4ebGdX/vCL/0AKGxbasEI2KxpGo3WC3Ky/u+84NkABZC4UMdi2leH4CxHzsw=
X-Received: by 2002:a05:6512:3e08:b0:503:99d:5a97 with SMTP id
 i8-20020a0565123e0800b00503099d5a97mr28482691lfv.20.1699255824752; Sun, 05
 Nov 2023 23:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 15:30:13 +0800
Message-ID: <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
>
> VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> address space specified by IOAS id.
>
> VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> from the iommufd address space
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

[...]

> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index f5c48b61ab62..07e1b2c443ca 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -219,4 +219,70 @@
>   */
>  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
>
> +/* vhost_vdpa_set_iommufd
> + * Input parameters:
> + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_IOAS_ALLOC=
)
> + * Output parameters:
> + * @out_dev_id: device identifier
> + */
> +struct vhost_vdpa_set_iommufd {
> +       __s32 iommufd;
> +       __u32 iommufd_ioasid;
> +       __u32 out_dev_id;
> +};
> +
> +#define VHOST_VDPA_SET_IOMMU_FD \
> +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> +
> +/*
> + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> + *
> + * Attach a vdpa device to an iommufd address space specified by IOAS
> + * id.
> + *
> + * Available only after a device has been bound to iommufd via
> + * VHOST_VDPA_SET_IOMMU_FD
> + *
> + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> + *
> + * @argsz:     user filled size of this data.
> + * @flags:     must be 0.
> + * @ioas_id:   Input the target id which can represent an ioas
> + *             allocated via iommufd subsystem.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vdpa_device_attach_iommufd_as {
> +       __u32 argsz;
> +       __u32 flags;
> +       __u32 ioas_id;
> +};

I think we need to map ioas to vDPA AS, so there should be an ASID
from the view of vDPA?

Thanks

> +
> +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iommufd_as)
> +
> +/*
> + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> + *
> + * Detach a vdpa device from the iommufd address space it has been
> + * attached to. After it, device should be in a blocking DMA state.
> + *
> + * Available only after a device has been bound to iommufd via
> + * VHOST_VDPA_SET_IOMMU_FD
> + *
> + * @argsz:     user filled size of this data.
> + * @flags:     must be 0.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vdpa_device_detach_iommufd_as {
> +       __u32 argsz;
> +       __u32 flags;
> +};
> +
> +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommufd_as)
> +
>  #endif
> --
> 2.34.3
>


