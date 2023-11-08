Return-Path: <netdev+bounces-46576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41AF7E50CC
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 08:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078A6B20D5D
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 07:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25A4C8C4;
	Wed,  8 Nov 2023 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvbOGM/8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20119CA6C
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 07:09:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D54710F9
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 23:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699427363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FG5MOGLDTAMR4tm1WZM1MYzGY/BA/UTHJJrzFko+l1M=;
	b=TvbOGM/8BypqutJiHVJF57joz2aKnEY2od8MAJgfvrAuHFd9bak6x+kWbTMOFywvitWstB
	uk/88pTzcghZqW5rweZ/wixyJoXeoz3HQshvx6d799YNp/BaHndc/utdL5II6ffz9cELS5
	XVZWpXmBK9nZFv1pt2qPZX/Q8nwlf8s=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-6KFugozZMTKasM5bVjPh-w-1; Wed, 08 Nov 2023 02:09:22 -0500
X-MC-Unique: 6KFugozZMTKasM5bVjPh-w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50798a259c7so6291806e87.1
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 23:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699427361; x=1700032161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG5MOGLDTAMR4tm1WZM1MYzGY/BA/UTHJJrzFko+l1M=;
        b=seSGnCKKBdbXzpSOYZUZ/mRJbKipP0kVnZdaiObDt2WO/4+/DPHI5tS7PDMYqsg8U3
         hvAIe1qLOWo9AeXMJZB4BkB27loRLdtX04mkrGBZzOdb49/AjqqK6Fj+4KBjFJ/N1JY5
         //COTTJRDtMQod0JCrZ3rig5lDBO8pekSefKE+x8GLKTJyaqqHCDcM4rMubbOcTVUxzD
         AbihHwkwitKIyC26wKU9Y4V+fQ5Gjorj6z+e/5z3FwviEPisP++z+btq36wcH7JbcFI5
         QgDJv53U4Fl7vpO4SIbBa7x1bbcvvlRknq8QmxvW8PTcYAb5SQtYLFf1rnm2qNJwcxC3
         SEkg==
X-Gm-Message-State: AOJu0YxiBQUnl9OqwrnEGZUhlLzaXQ16Z1bFtESG5YPdE++tnZSdbI1R
	4zxEB8sDWE/YmtG5qKSkdthgHsCkNXMnKQmTN3ZxOJAlB5/skz0Stv3o7m8p16+my6eO+P+Zy9z
	//quD/RwOWudJ3pB6PndKAtk9F853Lnnz
X-Received: by 2002:ac2:5104:0:b0:507:a58f:79ad with SMTP id q4-20020ac25104000000b00507a58f79admr525478lfb.61.1699427360915;
        Tue, 07 Nov 2023 23:09:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQlJqwh5A5QLG0zNOIdXOFw8oqq1dAcThcH8anfd70ScbRYfFhNkorJyUFptDNZWspLJ+aEXO/44/4ki8IWxk=
X-Received: by 2002:ac2:5104:0:b0:507:a58f:79ad with SMTP id
 q4-20020ac25104000000b00507a58f79admr525465lfb.61.1699427360483; Tue, 07 Nov
 2023 23:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
 <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
 <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
 <CACGkMEsp_rg+_01hwxCtZNOk2itB1L89mdOc1W1DG3umfEt5bw@mail.gmail.com> <CACLfguW3NZawOL0ET2K7bmtGZuzQwUfJ2HSgnirswzZK1ayPnA@mail.gmail.com>
In-Reply-To: <CACLfguW3NZawOL0ET2K7bmtGZuzQwUfJ2HSgnirswzZK1ayPnA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Nov 2023 15:09:09 +0800
Message-ID: <CACGkMEvnNXC8PhBNQn_F0ROGRX3CvwmXM6wP2A69aydSuzThYw@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 2:39=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Nov 8, 2023 at 11:03=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Nov 7, 2023 at 2:57=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > On Mon, Nov 6, 2023 at 3:30=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> w=
rote:
> > > > >
> > > > > VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
> > > > >
> > > > > VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> > > > > address space specified by IOAS id.
> > > > >
> > > > > VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> > > > > from the iommufd address space
> > > > >
> > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > ---
> > > >
> > > > [...]
> > > >
> > > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhos=
t.h
> > > > > index f5c48b61ab62..07e1b2c443ca 100644
> > > > > --- a/include/uapi/linux/vhost.h
> > > > > +++ b/include/uapi/linux/vhost.h
> > > > > @@ -219,4 +219,70 @@
> > > > >   */
> > > > >  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
> > > > >
> > > > > +/* vhost_vdpa_set_iommufd
> > > > > + * Input parameters:
> > > > > + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> > > > > + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_IO=
AS_ALLOC)
> > > > > + * Output parameters:
> > > > > + * @out_dev_id: device identifier
> > > > > + */
> > > > > +struct vhost_vdpa_set_iommufd {
> > > > > +       __s32 iommufd;
> > > > > +       __u32 iommufd_ioasid;
> > > > > +       __u32 out_dev_id;
> > > > > +};
> > > > > +
> > > > > +#define VHOST_VDPA_SET_IOMMU_FD \
> > > > > +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> > > > > +
> > > > > +/*
> > > > > + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> > > > > + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as=
)
> > > > > + *
> > > > > + * Attach a vdpa device to an iommufd address space specified by=
 IOAS
> > > > > + * id.
> > > > > + *
> > > > > + * Available only after a device has been bound to iommufd via
> > > > > + * VHOST_VDPA_SET_IOMMU_FD
> > > > > + *
> > > > > + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> > > > > + *
> > > > > + * @argsz:     user filled size of this data.
> > > > > + * @flags:     must be 0.
> > > > > + * @ioas_id:   Input the target id which can represent an ioas
> > > > > + *             allocated via iommufd subsystem.
> > > > > + *
> > > > > + * Return: 0 on success, -errno on failure.
> > > > > + */
> > > > > +struct vdpa_device_attach_iommufd_as {
> > > > > +       __u32 argsz;
> > > > > +       __u32 flags;
> > > > > +       __u32 ioas_id;
> > > > > +};
> > > >
> > > > I think we need to map ioas to vDPA AS, so there should be an ASID
> > > > from the view of vDPA?
> > > >
> > > > Thanks
> > > >
> > > The qemu will have a structure save and  maintain this information,So
> > > I didn't add this
> > >  in kernel=EF=BC=8Cwe can add this but maybe only for check?
> >
> > I meant for example, a simulator has two AS. How can we attach an ioas
> > to a specific AS with the above uAPI?
> >
> > Thank>
> this   __u32 ioas_id here is alloc from the iommufd system. maybe I
> need to change to new name iommuds_asid to
> make this more clear
> the process in qemu is
>
> 1) qemu want to use AS 0 (for example)
> 2) checking the existing asid. the asid 0 not used before
> 3 )alloc new asid from iommufd system, get new ioas_id (maybe 3 for examp=
le)
> qemu will save this relation 3<-->0 in the driver.
> 4) setting the ioctl VDPA_DEVICE_ATTACH_IOMMUFD_AS to attach new ASID
> to the kernel

So if we want to map IOMMUFD AS 3 to VDPA AS 0, how can it be done?

For example I didn't see a vDPA AS parameter in the above uAPI.

vhost_vdpa_set_iommufd has iommufd_ioasid which is obviously not the vDPA A=
S.

And ioas_id of vdpa_device_attach_iommufd_as (as you explained above)
is not vDPA AS.

Thanks


> 5=EF=BC=89 while map the memory=EF=BC=8C qemu will use ASID 3 to map /uma=
p
> and use ASID 0 for legacy mode map/umap
>
> So kernel here will not maintain the ioas_id from iommufd=EF=BC=8C
> and this also make the code strange since there will 2 different asid
> for the same AS, maybe we can save these information in the kernel
> Thanks
> cindy
> > > Thanks
> > > Cindy
> > > > > +
> > > > > +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> > > > > +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iommuf=
d_as)
> > > > > +
> > > > > +/*
> > > > > + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> > > > > + *
> > > > > + * Detach a vdpa device from the iommufd address space it has be=
en
> > > > > + * attached to. After it, device should be in a blocking DMA sta=
te.
> > > > > + *
> > > > > + * Available only after a device has been bound to iommufd via
> > > > > + * VHOST_VDPA_SET_IOMMU_FD
> > > > > + *
> > > > > + * @argsz:     user filled size of this data.
> > > > > + * @flags:     must be 0.
> > > > > + *
> > > > > + * Return: 0 on success, -errno on failure.
> > > > > + */
> > > > > +struct vdpa_device_detach_iommufd_as {
> > > > > +       __u32 argsz;
> > > > > +       __u32 flags;
> > > > > +};
> > > > > +
> > > > > +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> > > > > +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommuf=
d_as)
> > > > > +
> > > > >  #endif
> > > > > --
> > > > > 2.34.3
> > > > >
> > > >
> > >
> >
>


