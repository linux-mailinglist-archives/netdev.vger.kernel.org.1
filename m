Return-Path: <netdev+bounces-46356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF5F7E3566
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 07:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C25B20B13
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 06:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B3BA3B;
	Tue,  7 Nov 2023 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+q7cvvn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C28F49
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 06:57:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CA1FC
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 22:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699340264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UKkJWw0ipJp0+eK2cyF9Tytq76jRoBcGjC8u2Fp/zg=;
	b=i+q7cvvngAmqLB8vOLnkavCrJXKpZZ6PGAsXKmBgxYqXOXlTP3eXf543YTZyyoehXlK4W0
	C/UG6eXybzMoTS+/iKQFT6tXjGLAuYrSXYpI9LYRKXaST4DglG3U9b8y8m0KA5ao/dVwv+
	M74shnb/24BDno/2k8jeregsbC0flvA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-RMh0r3FQMo2JlXC1z9Wu4g-1; Tue, 07 Nov 2023 01:57:43 -0500
X-MC-Unique: RMh0r3FQMo2JlXC1z9Wu4g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9e293cd8269so11128266b.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 22:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699340262; x=1699945062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UKkJWw0ipJp0+eK2cyF9Tytq76jRoBcGjC8u2Fp/zg=;
        b=Kbju/jftMAaIO/Q3u2pkJw42VNECvP1IMhhfFpFNoVZYTcZxA2jXxb/2bghrGMmtd5
         OMCuv03a1J8jBtRBriIIAJDSlC9t+T6Xjg4rzC26i3PHgyER1TlLZX77rR/NQe3bIi1T
         nv8e+kpUiBplKX/2FByTM8scf9Aukemve+uI7jYsAta2w4hkpq0lJy5IE+zK68AHKQZP
         RWjc0HFd2v4azLfnAlHdYBKA6L4Ws15x0RpTfrCgJbo7NsM9oMVfzvNv46amRvqAQXXD
         fKUUlgDEJ4BHktYgousKe3ic9iy+O/w6puF/cY9qSHEd3s3vstn9IVydhyQahDMbvFyG
         kE3g==
X-Gm-Message-State: AOJu0Ywna002XtIfNLLlEKN9bEWzA5ufWnV/rzSyEV/c0VM2mdoQvn2c
	MiMsXqNr78B1QsKKfLMOPXJ1hVbbp4N+atoOeVNYbt55L8wicq+8tTNdtQbTt4DqWSuaRrPnsUQ
	qsmaJLW45IO21kt3fQEmcfetTJi3jOwZ+
X-Received: by 2002:a17:907:2da7:b0:9dd:f00d:c4e5 with SMTP id gt39-20020a1709072da700b009ddf00dc4e5mr7921445ejc.53.1699340262195;
        Mon, 06 Nov 2023 22:57:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpoDaO1jLLW4JPf6quOD7RvrGAVMZGCINfmMiWH9FieITjURg9fW1hcoakgE4F7vstqKhiYiv0ExnE/IcXagg=
X-Received: by 2002:a17:907:2da7:b0:9dd:f00d:c4e5 with SMTP id
 gt39-20020a1709072da700b009ddf00dc4e5mr7921431ejc.53.1699340261949; Mon, 06
 Nov 2023 22:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
 <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
In-Reply-To: <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 7 Nov 2023 14:57:04 +0800
Message-ID: <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 3:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
> >
> > VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> > address space specified by IOAS id.
> >
> > VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> > from the iommufd address space
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
>
> [...]
>
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index f5c48b61ab62..07e1b2c443ca 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -219,4 +219,70 @@
> >   */
> >  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
> >
> > +/* vhost_vdpa_set_iommufd
> > + * Input parameters:
> > + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> > + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_IOAS_ALL=
OC)
> > + * Output parameters:
> > + * @out_dev_id: device identifier
> > + */
> > +struct vhost_vdpa_set_iommufd {
> > +       __s32 iommufd;
> > +       __u32 iommufd_ioasid;
> > +       __u32 out_dev_id;
> > +};
> > +
> > +#define VHOST_VDPA_SET_IOMMU_FD \
> > +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> > +
> > +/*
> > + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> > + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> > + *
> > + * Attach a vdpa device to an iommufd address space specified by IOAS
> > + * id.
> > + *
> > + * Available only after a device has been bound to iommufd via
> > + * VHOST_VDPA_SET_IOMMU_FD
> > + *
> > + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> > + *
> > + * @argsz:     user filled size of this data.
> > + * @flags:     must be 0.
> > + * @ioas_id:   Input the target id which can represent an ioas
> > + *             allocated via iommufd subsystem.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +struct vdpa_device_attach_iommufd_as {
> > +       __u32 argsz;
> > +       __u32 flags;
> > +       __u32 ioas_id;
> > +};
>
> I think we need to map ioas to vDPA AS, so there should be an ASID
> from the view of vDPA?
>
> Thanks
>
The qemu will have a structure save and  maintain this information,So
I didn't add this
 in kernel=EF=BC=8Cwe can add this but maybe only for check?
this in
Thanks
Cindy
> > +
> > +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> > +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iommufd_as)
> > +
> > +/*
> > + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> > + *
> > + * Detach a vdpa device from the iommufd address space it has been
> > + * attached to. After it, device should be in a blocking DMA state.
> > + *
> > + * Available only after a device has been bound to iommufd via
> > + * VHOST_VDPA_SET_IOMMU_FD
> > + *
> > + * @argsz:     user filled size of this data.
> > + * @flags:     must be 0.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +struct vdpa_device_detach_iommufd_as {
> > +       __u32 argsz;
> > +       __u32 flags;
> > +};
> > +
> > +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> > +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommufd_as)
> > +
> >  #endif
> > --
> > 2.34.3
> >
>


