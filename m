Return-Path: <netdev+bounces-46354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FB57E3526
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 07:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A537EB20B6F
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154FB65D;
	Tue,  7 Nov 2023 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDB+GMEk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D476AA0
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 06:16:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE04119
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 22:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699337787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2UQHWSjqglckUccpioOkcOlhzli4Nj6mkNpXIHnwec=;
	b=EDB+GMEkEXFf7euskDWz/PPiI8t387a94YDLTrOtOx40EYPxW8N7uPbMvPKiWjzEDf/Egs
	c6sEuFq0JWI1Z8xoAvn092XPb1bznJgfShEm7BEU1JxsWK16j9yr6R/HBjHrk9WzEfp5eU
	vmA6DRQr8HzL5aYhnM4fvn00xhGUq5M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-vIbcSbUJNdaIg7EKNw7wmg-1; Tue, 07 Nov 2023 01:16:24 -0500
X-MC-Unique: vIbcSbUJNdaIg7EKNw7wmg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9e2a8417a3cso5350066b.3
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 22:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699337783; x=1699942583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2UQHWSjqglckUccpioOkcOlhzli4Nj6mkNpXIHnwec=;
        b=lmaLS6py/x0bnIbbxLDxY0TRYWJ09A8Gl2YrIq9P3a0Tu3OlapXk0PLgYuHeMMeGiC
         46CxIN4VDOC5DdJLxj7ZRt5j/J/IbeuVLy6wPayPWvEwAnPhnbY7J6+y7cq/wcUAnA34
         8MfEidJLqMkE4ERz0fzNEOkdC5GMtPGNZw7Qt5ZOhbq90KRRcZYYjHBhGqhthP1kbcAY
         S7Q59QRUy16X1LU/Qu/1tdiQmwD5w4DTPzjlA9MP+lUDWB1jGkUy3MJOae2P0GD0DewS
         zo13z7h0bthk4sPkoF+i5VrpYaA1RRr4tmOf9BzhubXU3l9oco+RFtm5NwTyibVr45Nl
         sQ3Q==
X-Gm-Message-State: AOJu0Yy2EpFth13lQJyFsGq0/mYylrQZwOfVECHYWgHu5LG9CRb7j/gs
	pQghVapxko5Y25TxVmoKVh7qsGVi44M4Lq1bX+EpNrEXJou1E4i0ZsvGX/gpoprjf5IfgwPBcq9
	0GD5hazrdcYEgmwk3D09lo99QAhHMq0GE
X-Received: by 2002:a17:907:97d5:b0:9cb:5a8a:b19d with SMTP id js21-20020a17090797d500b009cb5a8ab19dmr16071459ejc.5.1699337783726;
        Mon, 06 Nov 2023 22:16:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOmPUPuEOev3jI2GvZyE5M89BnJ4HD6j8Fr8R4rZmZ/Ig293uvxxyBNotmr8M7CvYlxy8nZngUJvGsS5szS6o=
X-Received: by 2002:a17:907:97d5:b0:9cb:5a8a:b19d with SMTP id
 js21-20020a17090797d500b009cb5a8ab19dmr16071441ejc.5.1699337783395; Mon, 06
 Nov 2023 22:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-3-lulu@redhat.com>
 <0c710537-254f-48a7-b11d-3ee27c1f10f7@intel.com>
In-Reply-To: <0c710537-254f-48a7-b11d-3ee27c1f10f7@intel.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 7 Nov 2023 14:15:46 +0800
Message-ID: <CACLfguXZjpGE1XyBC+MuMdtuy8mEPnZND8zrxD17foXFcQxTrA@mail.gmail.com>
Subject: Re: [RFC v1 2/8] Kconfig: Add the new file vhost/iommufd
To: Yi Liu <yi.l.liu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 4:50=E2=80=AFPM Yi Liu <yi.l.liu@intel.com> wrote:
>
> On 2023/11/4 01:16, Cindy Lu wrote:
> > Change the makefile and Kconfig, to add the
> > new file vhost/iommufd.c
>
> why not merge it with patch 1?
>
sure will change this

thanks
cindy
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   drivers/vhost/Kconfig  | 1 +
> >   drivers/vhost/Makefile | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index b455d9ab6f3d..a4becfb36d77 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -72,6 +72,7 @@ config VHOST_VDPA
> >       select VHOST
> >       select IRQ_BYPASS_MANAGER
> >       depends on VDPA
> > +     depends on IOMMUFD || !IOMMUFD
> >       help
> >         This kernel module can be loaded in host kernel to accelerate
> >         guest virtio devices with the vDPA-based backends.
> > diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
> > index f3e1897cce85..cda7f6b7f8da 100644
> > --- a/drivers/vhost/Makefile
> > +++ b/drivers/vhost/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_VHOST_RING) +=3D vringh.o
> >
> >   obj-$(CONFIG_VHOST_VDPA) +=3D vhost_vdpa.o
> >   vhost_vdpa-y :=3D vdpa.o
> > +vhost_vdpa-$(CONFIG_IOMMUFD) +=3D iommufd.o
> >
> >   obj-$(CONFIG_VHOST) +=3D vhost.o
> >
>
> --
> Regards,
> Yi Liu
>


