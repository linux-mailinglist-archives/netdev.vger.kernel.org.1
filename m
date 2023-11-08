Return-Path: <netdev+bounces-46558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A87E4F47
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 04:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21DDB20DCC
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 03:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B5563D;
	Wed,  8 Nov 2023 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqFoHOPv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08103ECF
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 03:03:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9BF10EC
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 19:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699412607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdkmOE2i/X8mF+g84XXuwPONDq0bjsNF8/LqNbQhs1I=;
	b=eqFoHOPvQKYnNNXrkTzQWnwzRqN2KGSdfuAQgiz6bvtoU3yWvkYw9tHhzrBmg77c1OjcRw
	/qh32ZUfyDZslw/JdEdBUQIIULnQcHw4rIZ8h+0U9awe5jtvugd0jbDdxdN9jhsy02+nh2
	yCsaWd4C+wNYLqPZ2zkQRsGUxfV9C0I=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-mTkkY9gDPx24PYjul_R-0Q-1; Tue, 07 Nov 2023 22:03:25 -0500
X-MC-Unique: mTkkY9gDPx24PYjul_R-0Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50948f24d14so6623308e87.1
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 19:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412604; x=1700017404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdkmOE2i/X8mF+g84XXuwPONDq0bjsNF8/LqNbQhs1I=;
        b=CxdgRpRJwx7f48eIHxMtPHSPImVEmiDZHXpZ1vh+oAB9ngl5hSYjv1SerGfdQM4utb
         tc8zKvklRJnlutMOWqCwT6NgVELwdJEEUA2hARKd7ZStbrbmRg0j6ssW3if7buCauCL2
         xyFSmsItjbYQrhxP93zmnVXSEE+c3oAj/vokdJ93wR57TgTD0FuQac97w1VBgKpZOwd1
         i3p0GjVOqIxdK1KNwyuks7CbUj6Yok0uXcGGmWj51oHRTANgfQul6LPd8U4HDQwfmKey
         /iR2bGhuW6JJ+CsDspwsU9prhqz3D4143uESrD+T0g4Yf0X7CnpiMxAek1NyugRPRM65
         2uxg==
X-Gm-Message-State: AOJu0Yzzyg6E2/JG4JmhrPa5buClCvvM/wfRuBppy9EbGfubMVvkxyTG
	09Q8kHjBRxbCXyKsIDE4MXKMIAB4f368QxrLh3jV9kV/78ir8ze+r1SoOqo7U/6+De/sajxLOV1
	67415iMnyKb9fZnKQvxG+k51NIsrOrQIE
X-Received: by 2002:ac2:593b:0:b0:507:9a33:f105 with SMTP id v27-20020ac2593b000000b005079a33f105mr225711lfi.69.1699412603996;
        Tue, 07 Nov 2023 19:03:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfDeEEm3NoVSDw//ZEF2zrrCfMM8SZhj75WuhxEmVScFVNfxLlrPPD9qUMwz+h8100tBYfGU3SiaSXtv2KmjY=
X-Received: by 2002:ac2:593b:0:b0:507:9a33:f105 with SMTP id
 v27-20020ac2593b000000b005079a33f105mr225701lfi.69.1699412603658; Tue, 07 Nov
 2023 19:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
 <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com> <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
In-Reply-To: <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Nov 2023 11:03:12 +0800
Message-ID: <CACGkMEsp_rg+_01hwxCtZNOk2itB1L89mdOc1W1DG3umfEt5bw@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 2:57=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, Nov 6, 2023 at 3:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
> > >
> > > VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> > > address space specified by IOAS id.
> > >
> > > VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> > > from the iommufd address space
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> >
> > [...]
> >
> > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > index f5c48b61ab62..07e1b2c443ca 100644
> > > --- a/include/uapi/linux/vhost.h
> > > +++ b/include/uapi/linux/vhost.h
> > > @@ -219,4 +219,70 @@
> > >   */
> > >  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
> > >
> > > +/* vhost_vdpa_set_iommufd
> > > + * Input parameters:
> > > + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> > > + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_IOAS_A=
LLOC)
> > > + * Output parameters:
> > > + * @out_dev_id: device identifier
> > > + */
> > > +struct vhost_vdpa_set_iommufd {
> > > +       __s32 iommufd;
> > > +       __u32 iommufd_ioasid;
> > > +       __u32 out_dev_id;
> > > +};
> > > +
> > > +#define VHOST_VDPA_SET_IOMMU_FD \
> > > +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> > > +
> > > +/*
> > > + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> > > + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> > > + *
> > > + * Attach a vdpa device to an iommufd address space specified by IOA=
S
> > > + * id.
> > > + *
> > > + * Available only after a device has been bound to iommufd via
> > > + * VHOST_VDPA_SET_IOMMU_FD
> > > + *
> > > + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> > > + *
> > > + * @argsz:     user filled size of this data.
> > > + * @flags:     must be 0.
> > > + * @ioas_id:   Input the target id which can represent an ioas
> > > + *             allocated via iommufd subsystem.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +struct vdpa_device_attach_iommufd_as {
> > > +       __u32 argsz;
> > > +       __u32 flags;
> > > +       __u32 ioas_id;
> > > +};
> >
> > I think we need to map ioas to vDPA AS, so there should be an ASID
> > from the view of vDPA?
> >
> > Thanks
> >
> The qemu will have a structure save and  maintain this information,So
> I didn't add this
>  in kernel=EF=BC=8Cwe can add this but maybe only for check?

I meant for example, a simulator has two AS. How can we attach an ioas
to a specific AS with the above uAPI?

Thanks

> this in
> Thanks
> Cindy
> > > +
> > > +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> > > +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iommufd_as=
)
> > > +
> > > +/*
> > > + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> > > + *
> > > + * Detach a vdpa device from the iommufd address space it has been
> > > + * attached to. After it, device should be in a blocking DMA state.
> > > + *
> > > + * Available only after a device has been bound to iommufd via
> > > + * VHOST_VDPA_SET_IOMMU_FD
> > > + *
> > > + * @argsz:     user filled size of this data.
> > > + * @flags:     must be 0.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +struct vdpa_device_detach_iommufd_as {
> > > +       __u32 argsz;
> > > +       __u32 flags;
> > > +};
> > > +
> > > +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> > > +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommufd_as=
)
> > > +
> > >  #endif
> > > --
> > > 2.34.3
> > >
> >
>


