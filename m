Return-Path: <netdev+bounces-46571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8E57E5064
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 07:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D480B20D50
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 06:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33847FD;
	Wed,  8 Nov 2023 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWk6yjbO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F085A4C
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 06:39:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BF610C0
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 22:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699425561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2BiMbY1gQc7nI1jkxql4bnHmw6v5I6CxsOnPkltxnE=;
	b=jWk6yjbOWhiRZwjoYTRvTmimiKHhuNmYQIB0ISlJ0kQ88vW6nwMRN2pSaF1PH0XGobtdKC
	iAVb9lt5cWoBJBwmP0MeKFIFURaHMUbtnXMIQDeiULaplWgik0xvbQgGDfrgtFgJYuJOcY
	zUNFV/yvBBupniSB4HEbkyU7wgO8uY8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-YwO-5di7NcyjOSzEs3Hnfg-1; Wed, 08 Nov 2023 01:39:20 -0500
X-MC-Unique: YwO-5di7NcyjOSzEs3Hnfg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9d28dd67464so479981266b.0
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 22:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699425559; x=1700030359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2BiMbY1gQc7nI1jkxql4bnHmw6v5I6CxsOnPkltxnE=;
        b=YuasCaZY2u4FZ+7jDrLDLV3o+mN1niViejVPqyT2L/MAPNu0xu5skpbP5Ko/XyHEu0
         lMfdAHXlAVulOAon1gSz43gFSh0QGl26OzX2EJPsq6YzM/TB9cGl9YiTMYzkOR65KAOJ
         yQ5Xu+ySgu770nNzOA4gtdnYUzSZhpVivzJ4NsTfBJ34hlBGJfS6X/Cm1afAWv2hexg0
         4dkiZWZdpF/ACqBGwL9bZO6d70hrgIe9cSzAvkpQ1+d0ljcxpeyuUoQaMaMDaifmADZP
         bOxIFHe5Q3bTSaBC9FyTNu6Z2Yh9iNi/BenvRksTg2Yq32ttlHmiOUKYH1MYojyVoXSv
         8uoA==
X-Gm-Message-State: AOJu0YwX/mZ0zo/l7FoIAPgtQTLBZ1ukO3KtPGhAl+9/2IjsKodPRdtJ
	Ol/Uz4qIABXv0xMF1Bnz2IubYbpqtGnPj0+pSTln9NoKwd4qaHu+lkCsMIYJvzcmASIOrz+CVfq
	fiGXw8kApH/d18yqA7KP13H0i02tH4/Zb
X-Received: by 2002:a17:907:1c0a:b0:9bf:b5bc:6c4b with SMTP id nc10-20020a1709071c0a00b009bfb5bc6c4bmr655945ejc.62.1699425558975;
        Tue, 07 Nov 2023 22:39:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5epofarFvRVM8cfq6bWdS/ETWfx+tpEnjAOoX/h4uMoyQAvRTok8J+YOehY2gIUyCmGh47tZqftyW2YYoQUI=
X-Received: by 2002:a17:907:1c0a:b0:9bf:b5bc:6c4b with SMTP id
 nc10-20020a1709071c0a00b009bfb5bc6c4bmr655930ejc.62.1699425558569; Tue, 07
 Nov 2023 22:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
 <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
 <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com> <CACGkMEsp_rg+_01hwxCtZNOk2itB1L89mdOc1W1DG3umfEt5bw@mail.gmail.com>
In-Reply-To: <CACGkMEsp_rg+_01hwxCtZNOk2itB1L89mdOc1W1DG3umfEt5bw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 8 Nov 2023 14:38:37 +0800
Message-ID: <CACLfguW3NZawOL0ET2K7bmtGZuzQwUfJ2HSgnirswzZK1ayPnA@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 11:03=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Nov 7, 2023 at 2:57=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Mon, Nov 6, 2023 at 3:30=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wro=
te:
> > > >
> > > > VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
> > > >
> > > > VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> > > > address space specified by IOAS id.
> > > >
> > > > VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> > > > from the iommufd address space
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > >
> > > [...]
> > >
> > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.=
h
> > > > index f5c48b61ab62..07e1b2c443ca 100644
> > > > --- a/include/uapi/linux/vhost.h
> > > > +++ b/include/uapi/linux/vhost.h
> > > > @@ -219,4 +219,70 @@
> > > >   */
> > > >  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
> > > >
> > > > +/* vhost_vdpa_set_iommufd
> > > > + * Input parameters:
> > > > + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> > > > + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_IOAS=
_ALLOC)
> > > > + * Output parameters:
> > > > + * @out_dev_id: device identifier
> > > > + */
> > > > +struct vhost_vdpa_set_iommufd {
> > > > +       __s32 iommufd;
> > > > +       __u32 iommufd_ioasid;
> > > > +       __u32 out_dev_id;
> > > > +};
> > > > +
> > > > +#define VHOST_VDPA_SET_IOMMU_FD \
> > > > +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> > > > +
> > > > +/*
> > > > + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> > > > + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> > > > + *
> > > > + * Attach a vdpa device to an iommufd address space specified by I=
OAS
> > > > + * id.
> > > > + *
> > > > + * Available only after a device has been bound to iommufd via
> > > > + * VHOST_VDPA_SET_IOMMU_FD
> > > > + *
> > > > + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> > > > + *
> > > > + * @argsz:     user filled size of this data.
> > > > + * @flags:     must be 0.
> > > > + * @ioas_id:   Input the target id which can represent an ioas
> > > > + *             allocated via iommufd subsystem.
> > > > + *
> > > > + * Return: 0 on success, -errno on failure.
> > > > + */
> > > > +struct vdpa_device_attach_iommufd_as {
> > > > +       __u32 argsz;
> > > > +       __u32 flags;
> > > > +       __u32 ioas_id;
> > > > +};
> > >
> > > I think we need to map ioas to vDPA AS, so there should be an ASID
> > > from the view of vDPA?
> > >
> > > Thanks
> > >
> > The qemu will have a structure save and  maintain this information,So
> > I didn't add this
> >  in kernel=EF=BC=8Cwe can add this but maybe only for check?
>
> I meant for example, a simulator has two AS. How can we attach an ioas
> to a specific AS with the above uAPI?
>
> Thank>
this   __u32 ioas_id here is alloc from the iommufd system. maybe I
need to change to new name iommuds_asid to
make this more clear
the process in qemu is

1) qemu want to use AS 0 (for example)
2) checking the existing asid. the asid 0 not used before
3 )alloc new asid from iommufd system, get new ioas_id (maybe 3 for example=
)
qemu will save this relation 3<-->0 in the driver.
4) setting the ioctl VDPA_DEVICE_ATTACH_IOMMUFD_AS to attach new ASID
to the kernel
5=EF=BC=89 while map the memory=EF=BC=8C qemu will use ASID 3 to map /umap
and use ASID 0 for legacy mode map/umap

So kernel here will not maintain the ioas_id from iommufd=EF=BC=8C
and this also make the code strange since there will 2 different asid
for the same AS, maybe we can save these information in the kernel
Thanks
cindy
> > Thanks
> > Cindy
> > > > +
> > > > +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> > > > +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iommufd_=
as)
> > > > +
> > > > +/*
> > > > + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> > > > + *
> > > > + * Detach a vdpa device from the iommufd address space it has been
> > > > + * attached to. After it, device should be in a blocking DMA state=
.
> > > > + *
> > > > + * Available only after a device has been bound to iommufd via
> > > > + * VHOST_VDPA_SET_IOMMU_FD
> > > > + *
> > > > + * @argsz:     user filled size of this data.
> > > > + * @flags:     must be 0.
> > > > + *
> > > > + * Return: 0 on success, -errno on failure.
> > > > + */
> > > > +struct vdpa_device_detach_iommufd_as {
> > > > +       __u32 argsz;
> > > > +       __u32 flags;
> > > > +};
> > > > +
> > > > +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> > > > +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommufd_=
as)
> > > > +
> > > >  #endif
> > > > --
> > > > 2.34.3
> > > >
> > >
> >
>


